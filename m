Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75AAC2712E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 22:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfEVUx7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 16:53:59 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:55493 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbfEVUx7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 16:53:59 -0400
Received: by mail-qt1-f201.google.com with SMTP id v16so3253175qtk.22
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 13:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ukNWyZpQEscAlXdUip/QWXhs5cbXEziRRf5YyJhah4M=;
        b=YNNVPbSx7FsOwk16jCPbtBA2G+ZPpu8SLkw0MknnLWZEzpx3k3DQ24qU05oO58WL6/
         Z3l/BWk0m2bqB2K7kjkcu2kFTiiSFUPaofTqH+Ct/OXdNXdY5jrYgET3PSnvoKLV6YsV
         HPayFURnBcfIEAK0D4VLrSsrs+q/kTNes9QTKFDjUVSpa/Yju1xDE7/Xlid8W0NEqX7I
         BRPnjfmY9tImK6Runjp2fQl0RHt53RpT1MPLuqRn333dWhZgbJRDa41ppTyfbyzAZ6fz
         URyIlnrJyVefkwaIo5PNLvNKJ8riAjHPlW1+VpMWGXP9P565Hqa4wpp1GScQEybwh+u2
         hmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ukNWyZpQEscAlXdUip/QWXhs5cbXEziRRf5YyJhah4M=;
        b=DrEz5JlP6PqNDmSy6FfAvA6cLcByJ2LE8EeotMjf/UG5eXXrvb5lNvruba67njAiSI
         ovQRuofXEJY+9gx1B2Pm7r0F+R9+K/C2XxvKfyeRNCuEfKzrQe2FFUY2ADmzSUmzHvt+
         B+QafjWp4k4pVHy2o2P8p+UvSkIPGgsWdGp6fs+krcFFBg7kJsvMi5AnTTzeXS98OIHr
         wmAtI3SGrrzTJB40R8HoTYS5W4s5tn4nYzXciwrqteQZ1d7C/AQdOd3TBTBNJkStEDxo
         wmv2mvdP/L2YKcs4q0XrTqqczA4P4mO99uUV5hwwojbGq2C/F+jp1HlFicjik+TZb+df
         ua5w==
X-Gm-Message-State: APjAAAV/K3U6y5+gLwzydeNhd4oLpVFSQqnIRd4XiYJ8gOwglt0IQuvU
        vpgV+8ansO0B7PJv92UOVvDsIDk=
X-Google-Smtp-Source: APXvYqx9x1/i9RddXIFy8UKRAw7tdSzqIGW+3fgcjqiypNTjBQ0QyE3Nol6HJXkiMDN9Q2UXUhI54Uo=
X-Received: by 2002:ac8:1a04:: with SMTP id v4mr77233094qtj.63.1558558438027;
 Wed, 22 May 2019 13:53:58 -0700 (PDT)
Date:   Wed, 22 May 2019 13:53:51 -0700
In-Reply-To: <20190522205353.140648-1-sdf@google.com>
Message-Id: <20190522205353.140648-2-sdf@google.com>
Mime-Version: 1.0
References: <20190522205353.140648-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH bpf-next v2 2/4] bpf: media: properly use bpf_prog_array api
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sean Young <sean@mess.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we don't have __rcu markers on the bpf_prog_array helpers,
let's use proper rcu_dereference_protected to obtain array pointer
under mutex.

Cc: linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sean Young <sean@mess.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/media/rc/bpf-lirc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index ee657003c1a1..0a0ce620e4a2 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -8,6 +8,9 @@
 #include <linux/bpf_lirc.h>
 #include "rc-core-priv.h"
 
+#define lirc_rcu_dereference(p)						\
+	rcu_dereference_protected(p, lockdep_is_held(&ir_raw_handler_lock))
+
 /*
  * BPF interface for raw IR
  */
@@ -136,7 +139,7 @@ const struct bpf_verifier_ops lirc_mode2_verifier_ops = {
 
 static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
 {
-	struct bpf_prog_array __rcu *old_array;
+	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
 	struct ir_raw_event_ctrl *raw;
 	int ret;
@@ -154,12 +157,12 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
 		goto unlock;
 	}
 
-	if (raw->progs && bpf_prog_array_length(raw->progs) >= BPF_MAX_PROGS) {
+	old_array = lirc_rcu_dereference(raw->progs);
+	if (old_array && bpf_prog_array_length(old_array) >= BPF_MAX_PROGS) {
 		ret = -E2BIG;
 		goto unlock;
 	}
 
-	old_array = raw->progs;
 	ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
 	if (ret < 0)
 		goto unlock;
@@ -174,7 +177,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
 
 static int lirc_bpf_detach(struct rc_dev *rcdev, struct bpf_prog *prog)
 {
-	struct bpf_prog_array __rcu *old_array;
+	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
 	struct ir_raw_event_ctrl *raw;
 	int ret;
@@ -192,7 +195,7 @@ static int lirc_bpf_detach(struct rc_dev *rcdev, struct bpf_prog *prog)
 		goto unlock;
 	}
 
-	old_array = raw->progs;
+	old_array = lirc_rcu_dereference(raw->progs);
 	ret = bpf_prog_array_copy(old_array, prog, NULL, &new_array);
 	/*
 	 * Do not use bpf_prog_array_delete_safe() as we would end up
@@ -223,21 +226,22 @@ void lirc_bpf_run(struct rc_dev *rcdev, u32 sample)
 /*
  * This should be called once the rc thread has been stopped, so there can be
  * no concurrent bpf execution.
+ *
+ * Should be called with the ir_raw_handler_lock held.
  */
 void lirc_bpf_free(struct rc_dev *rcdev)
 {
 	struct bpf_prog_array_item *item;
+	struct bpf_prog_array *array;
 
-	if (!rcdev->raw->progs)
+	array = lirc_rcu_dereference(rcdev->raw->progs);
+	if (!array)
 		return;
 
-	item = rcu_dereference(rcdev->raw->progs)->items;
-	while (item->prog) {
+	for (item = array->items; item->prog; item++)
 		bpf_prog_put(item->prog);
-		item++;
-	}
 
-	bpf_prog_array_free(rcdev->raw->progs);
+	bpf_prog_array_free(array);
 }
 
 int lirc_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
@@ -290,7 +294,7 @@ int lirc_prog_detach(const union bpf_attr *attr)
 int lirc_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
 {
 	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
-	struct bpf_prog_array __rcu *progs;
+	struct bpf_prog_array *progs;
 	struct rc_dev *rcdev;
 	u32 cnt, flags = 0;
 	int ret;
@@ -311,7 +315,7 @@ int lirc_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
 	if (ret)
 		goto put;
 
-	progs = rcdev->raw->progs;
+	progs = lirc_rcu_dereference(rcdev->raw->progs);
 	cnt = progs ? bpf_prog_array_length(progs) : 0;
 
 	if (copy_to_user(&uattr->query.prog_cnt, &cnt, sizeof(cnt))) {
-- 
2.21.0.1020.gf2820cf01a-goog

