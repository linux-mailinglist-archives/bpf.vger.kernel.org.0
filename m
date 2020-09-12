Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFD1267A03
	for <lists+bpf@lfdr.de>; Sat, 12 Sep 2020 13:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgILLih (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Sep 2020 07:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgILLib (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Sep 2020 07:38:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34332C061573;
        Sat, 12 Sep 2020 04:38:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d9so9119839pfd.3;
        Sat, 12 Sep 2020 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JOBiTqpqmewCvoLoEJmbgeJVLNDrAuMdm+eA9exIsxQ=;
        b=PXM+hqaV4/qLZsBYUbMKgA4xEtKzgQxCgtUsR7oVbUCx51xyrVm4Eeo2YVq+Hgg9mU
         szUPM66V3ipOlsDdpuet3JUWXDkesNaXlheJTduIflkb0JzxAvaD0hpPh1KPPCOw1sfY
         8n7ZiruJv8cpVkxjG5Atb1i/lNfXYTOSUgMavIvQ+EAWsV/2oZAQ74EjhcTaZhpgls53
         13MNSIm9JrmLEQEKy9kalklCZZFLXu4e3ybJ2Kg8fX3MzLS4t1I2gvOIeLF4BaNIQvd4
         n9foLuKydi8Zl2vvA9smyhVCR1J1BL3nhpmU0ZKt6c+XfwRafYRt+32261IZ1RuOfDFy
         lsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOBiTqpqmewCvoLoEJmbgeJVLNDrAuMdm+eA9exIsxQ=;
        b=efyF0knTh1XNUY6HfWqWTJHUkPTwv1ne1GNK9Mf0fWhSzkfy1BJ4SEusn8YGMLRAb3
         GMD3QvSVndozPuSBK28Lz2nghdoch9zd1T4ZfIecYUdVc6The5BdpPKX93J7T9RUR4RC
         Bug/wAUtHzHA90lm21OoOW/W2BjooVhI9bX3pI6fVnnl8+8UuitHbWt2mES8l22Adxq2
         dqLCNxYRM0sf7D+8Vdk50HH8XNdzfQHA2rjpm5WWfMSUaCQuP2xYqk2bmTtJEGhxiu3Q
         gWKgGjGtsOxw5E4VDKbAxyC8p5Ou/Fe8mj/2yXx0LJY0eZdZRZFhAmKxcwuCGT44hirF
         cqYg==
X-Gm-Message-State: AOAM532Wgi4NCX4cQEysr03ZzxrdRsvBsXJhaHSISc1theqoMlnsLVBL
        Wdj55pYRYPvJYBn2feuWRTY=
X-Google-Smtp-Source: ABdhPJyjszfHZz7MeXzhIH6SDCPTBeTXXYPKS4P5Xthx5d4CnPQeuv67ewJwYdXw7VWrfBY3dIHZpg==
X-Received: by 2002:a63:4cc:: with SMTP id 195mr4667187pge.376.1599910709509;
        Sat, 12 Sep 2020 04:38:29 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.95])
        by smtp.gmail.com with ESMTPSA id r206sm5156621pfr.91.2020.09.12.04.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 04:38:27 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        anant.thazhemadam@gmail.com
Subject: [PATCH] Using a pointer and kzalloc in place of a struct directly 
Date:   Sat, 12 Sep 2020 17:08:04 +0530
Message-Id: <20200912113804.6465-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000c82fe505aef233c6@google.com>
References: <000000000000c82fe505aef233c6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Updated the usage of a struct variable directly, in bpf_link_get_info_by_fd
to using a pointer of the same type instead, which points to a memory 
location allocated using kzalloc.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
I saw this bug (https://syzkaller.appspot.com/bug?extid=976d5ecfab0c7eb43ac3),
and tried to come up with a patch for it (before I saw that this had already 
been taken care of). 
Although I don't think it fundamentally changes how things work much, it still 
seems to have fixed the error on it's own too.
I'd like to hear anyone's 2c on this, and know  if this method of using info 
(of type bpf_link_info) instead
would be a welcome change in general, even if it was not centered around 
fixing the bug.
If instead, as an unwelcome consequence, this patch might make something go 
wrong somewhere, or passing
the syzbot test was a false positive, I would appreciate it if you could shed 
some light on that for me as well.
If this patch seems acceptable, then I'll send in a cleaner v2 that's a little
more articulate, if required.
Just trying to understand how things work, and sometimes why things work
in and around the kernel.
Thanks,
Anant


 kernel/bpf/syscall.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4108ef3b828b..01b9c203ef65 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3605,30 +3605,31 @@ static int bpf_link_get_info_by_fd(struct file *file,
 				  union bpf_attr __user *uattr)
 {
 	struct bpf_link_info __user *uinfo = u64_to_user_ptr(attr->info.info);
-	struct bpf_link_info info;
+	struct bpf_link_info *info = NULL;
 	u32 info_len = attr->info.info_len;
 	int err;
 
-	err = bpf_check_uarg_tail_zero(uinfo, sizeof(info), info_len);
+	err = bpf_check_uarg_tail_zero(uinfo, sizeof(struct bpf_link_info), info_len);
+
 	if (err)
 		return err;
 	info_len = min_t(u32, sizeof(info), info_len);
 
-	memset(&info, 0, sizeof(info));
-	if (copy_from_user(&info, uinfo, info_len))
+	info = kzalloc(sizeof(struct bpf_link_info), GFP_KERNEL);
+	if (copy_from_user(info, uinfo, info_len))
 		return -EFAULT;
 
-	info.type = link->type;
-	info.id = link->id;
-	info.prog_id = link->prog->aux->id;
+	info->type = link->type;
+	info->id = link->id;
+	info->prog_id = link->prog->aux->id;
 
 	if (link->ops->fill_link_info) {
-		err = link->ops->fill_link_info(link, &info);
+		err = link->ops->fill_link_info(link, info);
 		if (err)
 			return err;
 	}
 
-	if (copy_to_user(uinfo, &info, info_len) ||
+	if (copy_to_user(uinfo, info, info_len) ||
 	    put_user(info_len, &uattr->info.info_len))
 		return -EFAULT;
 
-- 
2.25.1

