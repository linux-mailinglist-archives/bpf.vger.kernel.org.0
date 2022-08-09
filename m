Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A1458D6AC
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiHIJnY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 05:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiHIJnR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 05:43:17 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F100B23171;
        Tue,  9 Aug 2022 02:43:10 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id F11A8FF80F;
        Tue,  9 Aug 2022 09:43:06 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-usb@vger.kernel.org, bpf@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 2/2] usb: Implement usb_revoke() BPF function
Date:   Tue,  9 Aug 2022 11:43:00 +0200
Message-Id: <20220809094300.83116-3-hadess@hadess.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809094300.83116-1-hadess@hadess.net>
References: <20220809094300.83116-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This functionality allows a sufficiently privileged user-space process
to upload a BPF programme that will call to usb_revoke_device() as if
it were a kernel API.

This functionality will be used by logind to revoke access to devices on
fast user-switching to start with.

logind, and other session management software, does not have access to
the file descriptor used by the application so other identifiers
are used.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/usb/core/usb.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 2f71636af6e1..ca394848a51e 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -38,6 +38,8 @@
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
 #include <linux/usb/of.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
 
 #include <asm/io.h>
 #include <linux/scatterlist.h>
@@ -438,6 +440,41 @@ static int usb_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+struct usb_revoke_match {
+	int busnum, devnum; /* -1 to match all devices */
+	int euid; /* -1 to match all users */
+};
+
+static int
+__usb_revoke(struct usb_device *udev, void *data)
+{
+	struct usb_revoke_match *match = data;
+
+	if (match->devnum >= 0 && match->busnum >= 0) {
+		if (match->busnum != udev->bus->busnum ||
+		    match->devnum != udev->devnum) {
+			return 0;
+		}
+	}
+
+	usb_revoke_for_euid(udev, match->euid);
+	return 0;
+}
+
+noinline int
+usb_revoke_device(int busnum, int devnum, unsigned int euid)
+{
+	struct usb_revoke_match match;
+
+	match.busnum = busnum;
+	match.devnum = devnum;
+	match.euid = euid;
+
+	usb_for_each_dev(&match, __usb_revoke);
+
+	return 0;
+}
+
 #ifdef	CONFIG_PM
 
 /* USB device Power-Management thunks.
@@ -1004,6 +1041,15 @@ static void usb_debugfs_cleanup(void)
 /*
  * Init
  */
+BTF_SET_START(usbdev_kfunc_ids)
+BTF_ID(func, usb_revoke_device)
+BTF_SET_END(usbdev_kfunc_ids)
+
+static const struct btf_kfunc_id_set usbdev_kfunc_set = {
+	.owner     = THIS_MODULE,
+	.check_set = &usbdev_kfunc_ids,
+};
+
 static int __init usb_init(void)
 {
 	int retval;
@@ -1035,9 +1081,14 @@ static int __init usb_init(void)
 	if (retval)
 		goto hub_init_failed;
 	retval = usb_register_device_driver(&usb_generic_driver, THIS_MODULE);
+	if (retval)
+		goto register_failed;
+	retval = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &usbdev_kfunc_set);
 	if (!retval)
 		goto out;
+	usb_deregister_device_driver(&usb_generic_driver);
 
+register_failed:
 	usb_hub_cleanup();
 hub_init_failed:
 	usb_devio_cleanup();
-- 
2.37.1

