Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C5258D6AB
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiHIJnL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 05:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237793AbiHIJnK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 05:43:10 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F279222B29;
        Tue,  9 Aug 2022 02:43:07 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 2DA6DFF805;
        Tue,  9 Aug 2022 09:43:03 +0000 (UTC)
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
Subject: [PATCH 1/2] USB: core: add a way to revoke access to open USB devices
Date:   Tue,  9 Aug 2022 11:42:59 +0200
Message-Id: <20220809094300.83116-2-hadess@hadess.net>
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

There is a need for userspace applications to open USB devices directly,
for all the USB devices without a kernel-level class driver[1], and
implemented in user-space.

As not all devices are built equal, we want to be able to revoke
access to those devices whether it's because the user isn't at the
console anymore, or because the web browser, or sandbox doesn't want
to allow access to that device.

This commit implements the internal API used to revoke access to USB
devices, given either bus and device numbers, or/and a user's
effective UID.

Signed-off-by: Bastien Nocera <hadess@hadess.net>

[1]:
Non exhaustive list of devices and device types that need raw USB access:
- all manners of single-board computers and programmable chips and
devices (avrdude, STLink, sunxi bootloader, flashrom, etc.)
- 3D printers
- scanners
- LCD "displays"
- user-space webcam and still cameras
- game controllers
- video/audio capture devices
- sensors
- software-defined radios
- DJ/music equipment
- protocol analysers
- Rio 500 music player
---
 drivers/usb/core/devio.c | 79 ++++++++++++++++++++++++++++++++++++++--
 drivers/usb/core/usb.h   |  2 +
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index b5b85bf80329..d8d212ef581f 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -78,6 +78,7 @@ struct usb_dev_state {
 	int not_yet_resumed;
 	bool suspend_allowed;
 	bool privileges_dropped;
+	bool revoked;
 };
 
 struct usb_memory {
@@ -183,6 +184,13 @@ static int connected(struct usb_dev_state *ps)
 			ps->dev->state != USB_STATE_NOTATTACHED);
 }
 
+static int disconnected_or_revoked(struct usb_dev_state *ps)
+{
+	return (list_empty(&ps->list) ||
+			ps->dev->state == USB_STATE_NOTATTACHED ||
+			ps->revoked);
+}
+
 static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
 {
 	struct usb_dev_state *ps = usbm->ps;
@@ -237,6 +245,9 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	dma_addr_t dma_handle;
 	int ret;
 
+	if (disconnected_or_revoked(ps))
+		return -ENODEV;
+
 	ret = usbfs_increase_memory_usage(size + sizeof(struct usb_memory));
 	if (ret)
 		goto error;
@@ -310,7 +321,7 @@ static ssize_t usbdev_read(struct file *file, char __user *buf, size_t nbytes,
 
 	pos = *ppos;
 	usb_lock_device(dev);
-	if (!connected(ps)) {
+	if (disconnected_or_revoked(ps)) {
 		ret = -ENODEV;
 		goto err;
 	} else if (pos < 0) {
@@ -2315,7 +2326,7 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
 	if (ps->privileges_dropped)
 		return -EACCES;
 
-	if (!connected(ps))
+	if (disconnected_or_revoked(ps))
 		return -ENODEV;
 
 	/* alloc buffer */
@@ -2555,7 +2566,7 @@ static int proc_forbid_suspend(struct usb_dev_state *ps)
 
 static int proc_allow_suspend(struct usb_dev_state *ps)
 {
-	if (!connected(ps))
+	if (disconnected_or_revoked(ps))
 		return -ENODEV;
 
 	WRITE_ONCE(ps->not_yet_resumed, 1);
@@ -2580,6 +2591,66 @@ static int proc_wait_for_resume(struct usb_dev_state *ps)
 	return proc_forbid_suspend(ps);
 }
 
+static int usbdev_revoke(struct usb_dev_state *ps)
+{
+	struct usb_device *dev = ps->dev;
+	unsigned int ifnum;
+	struct async *as;
+
+	if (ps->revoked) {
+		usb_unlock_device(dev);
+		return -ENODEV;
+	}
+
+	snoop(&dev->dev, "%s: REVOKE by PID %d: %s\n", __func__,
+	      task_pid_nr(current), current->comm);
+
+	ps->revoked = true;
+
+	for (ifnum = 0; ps->ifclaimed && ifnum < 8*sizeof(ps->ifclaimed);
+			ifnum++) {
+		if (test_bit(ifnum, &ps->ifclaimed))
+			releaseintf(ps, ifnum);
+	}
+	destroy_all_async(ps);
+
+	as = async_getcompleted(ps);
+	while (as) {
+		free_async(as);
+		as = async_getcompleted(ps);
+	}
+
+	wake_up(&ps->wait);
+
+	return 0;
+}
+
+int usb_revoke_for_euid(struct usb_device *udev,
+		int euid)
+{
+	struct usb_dev_state *ps;
+
+	usb_lock_device(udev);
+
+	list_for_each_entry(ps, &udev->filelist, list) {
+		if (euid >= 0) {
+			kuid_t kuid;
+
+			if (!ps || !ps->cred)
+				continue;
+			kuid = ps->cred->euid;
+			if (kuid.val != euid)
+				continue;
+		}
+
+		usbdev_revoke(ps);
+	}
+
+out:
+	usb_unlock_device(udev);
+	return 0;
+}
+
 /*
  * NOTE:  All requests here that have interface numbers as parameters
  * are assuming that somehow the configuration has been prevented from
@@ -2623,7 +2694,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 #endif
 	}
 
-	if (!connected(ps)) {
+	if (disconnected_or_revoked(ps)) {
 		usb_unlock_device(dev);
 		return -ENODEV;
 	}
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 82538daac8b8..5b007530a1cf 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -34,6 +34,8 @@ extern int usb_deauthorize_device(struct usb_device *);
 extern int usb_authorize_device(struct usb_device *);
 extern void usb_deauthorize_interface(struct usb_interface *);
 extern void usb_authorize_interface(struct usb_interface *);
+extern int usb_revoke_for_euid(struct usb_device *udev,
+		int euid);
 extern void usb_detect_quirks(struct usb_device *udev);
 extern void usb_detect_interface_quirks(struct usb_device *udev);
 extern void usb_release_quirk_list(void);
-- 
2.37.1

