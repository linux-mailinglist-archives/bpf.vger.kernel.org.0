Return-Path: <bpf+bounces-40107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5066697CE48
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 21:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7562C1C22A8C
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B87478C7E;
	Thu, 19 Sep 2024 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1BLuA95"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5973440
	for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775706; cv=none; b=tKDAOQRYwgsltex8FCf18Anb9Md+WWjgpVvbnorC7/WZUpM3QIsPbtB9Hf4+Ptq4BnwbJPiNxpRCMQteFsYQ3S6Fr8Cx5Xx8PnmKEMaZcmC35sfY/jmIkINUjnfJEtuVqU7OAo9olhm+VV0lINN+U2tITFwK8rDFCgFd+t5WvPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775706; c=relaxed/simple;
	bh=LDGAZ/eZZb2WJIC/Gv2ov28kOlSEx5kMHGL4tsn4AXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=W7cVNLuXiae01uhRml5OoFWYXxYp7tcXqz8QGSwjr2uAzu0dvVli2I2zsyGx6VkrEJe5tBl3tk1ajDTQolyMvUms9jKHnk4gAWsMq1qausURu6CFAS/U+nx7sxgPB0Yceeq9YLo1JQldRUiIc1czSfwLUVZawFJ9JdPQuGCM9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1BLuA95; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c3d2f9f896so1737457a12.1
        for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 12:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726775704; x=1727380504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vHaVbx2g1p5dSemmS4pBULCnRpFg7rMSXv4J/GrlFwA=;
        b=J1BLuA95vELDA2zMngHCs73wN6qM5KurF7pMXJcq6YAYBR9f8Ecrj7vsw/SrUlHxhU
         P0i27UZMISCc14KR5kmvGGQuSFRcN/XF4m3XIotHlzJtwnGMpd5XCh/6CKePjOufwesf
         76bASnac1nEc01XJipuE/drwTXx9Ixx74i/94kSoQRXcSZevbypqe09EpG/21S9486xX
         pAOWULgreJg8GPRLZ6qA7vTOCUR6HMgYdyYfPbT7zt3pi85D8T/vFjdmdpHlRWpcAjbp
         geYtZ6jmHhxJxakn71rTRNib88o28q0exQXoAEnVaOEqZjrElgqAs/qLRJWV19wuyewc
         QYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726775704; x=1727380504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHaVbx2g1p5dSemmS4pBULCnRpFg7rMSXv4J/GrlFwA=;
        b=YlNiCHPSLqVHIupHxVdtsM+5gD16ZJKZVSThBZKIr4TSoYX+/1H/nFitHtSsrAuXF5
         dTQHn5r1a+/YnfeKJeyHZSp1gciL47GZh+NCVRWNnFwOpVc2fWRVnhM5NHkWzcueEh3w
         VHXHnxxjSH3VV8NtV9rocRwsItKvsSaOxK76v7n+nwX33ZoCvb29cAbuW7T2RByGY6sB
         fWco1Q7mAV+BamWEvgiWGdTp1QEwQKNzB5zQVR3h6rKP6o1oMQZQ7PACgdGoETTk4EVz
         nrJd88EBZp0Ap84uRldPFZpQtMcGlhJelkA7wRnz2ZHy4Ok0EsrabtrzX/PRkGGIn8aw
         TH3A==
X-Gm-Message-State: AOJu0Yz63118dVbqh5ptWyv/z6HJoHP6kQu+Q1njgKUJyoK8FAJe+s4C
	vAKIJf7WgNFCzRZSg3HuSkvA/Hr7arV4OIUaxRMseQpkmn3u2o84
X-Google-Smtp-Source: AGHT+IERQzXnFNhgRgBL95eCbft0i00dLdtsmBbceaikVYRjNK8Emh/o+SqNUGFpgeYQ4USgL5JrDQ==
X-Received: by 2002:a05:6402:34cb:b0:5c2:6ff4:ccd5 with SMTP id 4fb4d7f45d1cf-5c464a443d7mr201160a12.21.1726775703278;
        Thu, 19 Sep 2024 12:55:03 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([62.218.203.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5ed63sm6410827a12.49.2024.09.19.12.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 12:55:02 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf] bpf: syscall_nrs: fix no previous prototype for "syscall_defines"
Date: Thu, 19 Sep 2024 21:54:54 +0200
Message-Id: <20240919195454.73358-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In some environments (gcc treated as error in W=1, which is default), if we
make -C samples/bpf/, it will be stopped because of
"no previous prototype" error like this:

  ../samples/bpf/syscall_nrs.c:7:6:
  error: no previous prototype for ‘syscall_defines’ [-Werror=missing-prototypes]
   void syscall_defines(void)
        ^~~~~~~~~~~~~~~

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
I'm not sure which tree I should target, sorry about that.
---
 samples/bpf/syscall_nrs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/bpf/syscall_nrs.c b/samples/bpf/syscall_nrs.c
index 88f940052450..5f40a29034b6 100644
--- a/samples/bpf/syscall_nrs.c
+++ b/samples/bpf/syscall_nrs.c
@@ -4,6 +4,8 @@
 
 #define SYSNR(_NR) DEFINE(SYS ## _NR, _NR)
 
+void syscall_defines(void);
+
 void syscall_defines(void)
 {
 	COMMENT("Linux system call numbers.");
-- 
2.37.3


