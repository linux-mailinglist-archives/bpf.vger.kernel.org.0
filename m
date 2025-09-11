Return-Path: <bpf+bounces-68094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB52B52DF9
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 12:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0330FA06135
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078A030F554;
	Thu, 11 Sep 2025 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3VHdKCK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A8C30E85A
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585362; cv=none; b=ddKghb/Agx28rQyoMsFIAZ5wTNcWBikLKDnKsNwHSFabdNg6/3PCzsjJtdsRhmSrKsXDFm1vc+9IZZJRAsqD4pBOlOq+y0kWK297GOjENUuDkx0dH2gLZY8E3YLXmzOOoLYhBbgIER7gfimlU3isIzQMpOYQ5J92H4NoB8HhgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585362; c=relaxed/simple;
	bh=DXPAmzLRhKCJobsF1zcsCZQP5SrHJ2XhbHdOBYXU4EI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bdPBifCy+b2obZn7VtyrAr66BJRD9z2HZ+1lBdZhwgoo1lFGcMy75y0nUZMTcZYiUJdcqTlHhGyyiFCCC2kp2zBsxwA9MI5oWMKp1rI8QiXilxPEfRJkh8jh9rvXPP+LuRucfRmAj3U32E8hpibCOymVqK2SGATwDZRbKmK3QVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3VHdKCK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f7cd8ec2cso629295e87.2
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 03:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757585359; x=1758190159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ACqPWjv+lFry9n4EefwaOP3r/fkJ99H7i94e0rX8odw=;
        b=i3VHdKCKKZfK/pFRUQUxM7mxtLWq37xu+RisEF9uRfjo9vIpR4eTecV9Y5Ycngwkbi
         FWFhCtt7eewzxzGbKUgc7xVy31TWN3fCoCr2V0blu0JMhcQtOZuD0rQ0nUed0sh15emM
         DOyQlfN4uLMPkYDF12ae4yXULsxRtWCLQBX58VxOR79Pf5F+s7yy+W3IdGX2AYM9i7c2
         iK1NiLBvghqxfm84qPJITI4wL0VNhjD0gtcKnq1dMLB2NW5etZ7PGMsHfHDsKLEeuakS
         +Y0RCVYE2OYbhBmsrWwsb4QX2nObxujuiKKyhZb/qPgkkZFH/tfFd2aQiKDvO4DzDReA
         ZWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757585359; x=1758190159;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACqPWjv+lFry9n4EefwaOP3r/fkJ99H7i94e0rX8odw=;
        b=Uklp9p/IogJ/Z03s7j/smu8R1YUYKhML9QYXDbiMRvwy0G24iq0EW8hxDxFu4TJg5f
         lHPydSh1NHqQ8xQQCm63WUUhFJD7AWVmRC0bNVfEG6emuaUNoNc6jxx91qn+bPiLoeAg
         po1piI56xhgv770eZM3ncyAE9gubdb2INxyl2VR3hKjsaprvAfuTLvhGnOinX26lOHY1
         7PAH/moYnUh2Mz/ddIV2Up36nwixnCP1MtTjBaQAfnts09uwa6tH0en6VTgYQAh0L3pM
         XDt2HxtxOYNOKoUOBG1TTWJ1vUHnkH4hzS6FP2JvM5Sr5OoK6kvF7aKJ/4bX3XQp/dr0
         WsXg==
X-Gm-Message-State: AOJu0YypVNeBh1TLbB1izuV5HqF+k8XRE53zN++eZ2vtK/ahZI2Hlvyt
	tehh1YrZBbtirLx3b0F6WvKILoPYH2J4k3lkDoFqyrOXKvZW9edSNhzcpZOzs7+02FXo5Uc3IRP
	ApEpnHgjdAJ18fFle1NDcSGSRxXHT1pXRm2BL8w4=
X-Gm-Gg: ASbGncvJscvHYn1fFCottJVqE23us2oZht6sKFr3xb7ObRO9evV4TA4HX8kMUTN3T/8
	Csm3YhtHVkkruBVhFh/3P9FlzmaUlD7EGcCn4K0mQ643m+r/YL0Ncb8NurRS35o4xGvglEROzxH
	u9CYb8tgjnjXnXZJBYWtVezqtCyMGPUlsmlTQUngTIJF2G5FDVgeaDW3t53OToUn4jDVZQu2rnk
	VZkOMBCFeUQBDIBEag=
X-Google-Smtp-Source: AGHT+IGzBt1FElOGMuTpwYlplXZ4bVVKpP3VjUm78T1oIOZr5K+AuVDoMZxILU14dmir483PcUUqEsKmGdpkU6YywDw=
X-Received: by 2002:ac2:51ca:0:b0:560:8b86:75ba with SMTP id
 2adb3069b0e04-56261db5e31mr5713328e87.52.1757585358608; Thu, 11 Sep 2025
 03:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ariel Silver <arielsilver77@gmail.com>
Date: Thu, 11 Sep 2025 13:09:06 +0300
X-Gm-Features: Ac12FXziD3obB7804GE7gOADx3-kO3uFBxy7SqXpXYHyv39mEIr_TPATqm5aZHQ
Message-ID: <CACKMdf=P76Bf8-zPVO0shnj87AoFV+NCGhANPyP9gHVpYDk3jA@mail.gmail.com>
Subject: [PATCH] docs/bpf: clarify ret handling in LSM BPF programs
To: bpf@vger.kernel.org
Cc: linux-doc@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"

Docs currently suggest that all attached BPF LSM programs always run
and that ret simply carries the previous return code. In reality,
execution stops as soon as one program returns non-zero. This is
because call_int_hook() breaks out of the loop when RC != 0, so later
programs are not executed.

Signed-off-by: arielsilver77@gmail.com <arielsilver77@gmail.com>
---
 Documentation/bpf/prog_lsm.rst | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/prog_lsm.rst b/Documentation/bpf/prog_lsm.rst
index ad2be02f3..92bfb64c2 100644
--- a/Documentation/bpf/prog_lsm.rst
+++ b/Documentation/bpf/prog_lsm.rst
@@ -66,21 +66,17 @@ example:

    SEC("lsm/file_mprotect")
    int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
-            unsigned long reqprot, unsigned long prot, int ret)
+            unsigned long reqprot, unsigned long prot)
    {
-       /* ret is the return value from the previous BPF program
-        * or 0 if it's the first hook.
-        */
-       if (ret != 0)
-           return ret;
-
        int is_heap;

        is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
               vma->vm_end <= vma->vm_mm->brk);

        /* Return an -EPERM or write information to the perf events buffer
-        * for auditing
+        * for auditing.
+        * Returning a non-zero value will stop the chain of
+        * LSM BPF programs attached to the same hook.
         */
        if (is_heap)
            return -EPERM;
-- 
2.50.1

