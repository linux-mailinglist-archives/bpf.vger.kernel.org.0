Return-Path: <bpf+bounces-34628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D6F92F6A3
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 10:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA48B20AF6
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8795A3EA71;
	Fri, 12 Jul 2024 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J5UuOGbe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD148801
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771296; cv=none; b=axyc9skzl9zHfi6Q8Xr1RtektL9tAX88KpAa+1YwEigrNSX26OGrp42NxdAKZYOhC1Pgbv98dJXhNK9HLBexdIIzhNn9mgt6JB/UKj/zzKWcUC2ZFhNUaEJ8x+3bjHvvHzN7cAtY+U3ZoToXeA3Jy5qgVRaYfkVA00IXRqTya6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771296; c=relaxed/simple;
	bh=RzVJpMx7YSJL7k9r9a5Y3fiSr3qhdLmZMIAnvudxrh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HeZo1soxXJTCNVVyIZSg2t0zPCI8YwkNvl83Xpy07VRD58NAUW3n+AucUK81DM4h+nTnhr0UECVGVcFSh0O2EynKcd0cG9+1gfLWlxQyd0/Cxk+3CzttJV60ZuhAeVcGL91wvTXjUNq/4BZp6hMkv5a29ylRmMr7C0VhxOwZNOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J5UuOGbe; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so31715481fa.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720771292; x=1721376092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AsGUzoyRhy0GJ9gt6GvhhIfYeQLvKX/mS0Cizw93I4E=;
        b=J5UuOGbeE82fWkhyCY4dFDlzF2OCXdWievkQAzZXFquVcgQiXsJ2cV7I4oymYZ4U/7
         uLgI+gT3rOrcgyeIYqz0wftdDxXtkLR4Y34fhdFbZyOxnSaaf5c76YVdiv37Ipo+Lyic
         QV36d+EhDJgac1poDhIWM7uOO2PZeZUsnE+g5C8Rcy8/vkHW1IRyGMpOfAg8S5ZTgULq
         Em9LyKoj4ghXtDnRgXdskIvPW1fOMIIXB9GgxZ6My8Dp67SKLBRLgCckcsujgFnoJUEY
         zSyoXofFZtODRCQO0d0R7nJwShQeAXYOdU4Mq7yj7cwy+UasxPIaFry2MOXmbHNVyJtH
         EerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720771292; x=1721376092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsGUzoyRhy0GJ9gt6GvhhIfYeQLvKX/mS0Cizw93I4E=;
        b=a0Lv8whcjxC3MyLlY4U0rOrppMuhoAhD5cq4McztXZ1GDH0Y8DMKK3XGGsy93xbx65
         ZTC6b3bt/S6XcoErou3RjfCToQyAyjdviM5eMaHLjQHpRi87GpfJJJolBCyJYLcdnCRa
         pDaMOeltYgeOCm6ASArmAjKTVQc7xNLXEEPBFPrjat0oaDDpxc4nElwmC90h4zrIr6XM
         wO5nVBKNHjijbSgBW91uVZ6y62YR7WiBmUJ3TIsUlWgwFrUKtRYZDDF6BZbS6nnIrqaZ
         wzeH5de9I0ktwxPicOpaNh0kWjZIV/xFDbgytYVCLBVsSIwkhor0Ji6ckZ5j/fp9qqOl
         /PYg==
X-Gm-Message-State: AOJu0YyrJwyktDGWgYj7CSTY/7g13BLMQfsMiRzbKJRVINj4aUgJdjhA
	ZEmhIprKLJDbvN+E1pgh98ehrNDStsVsthW/H1+UdDAAwZ0z1ydbIouY/gCPJG4maM3px/TWYtW
	EhMc=
X-Google-Smtp-Source: AGHT+IGZ0qvtSVhOaxgwaPY0BucmgJu48hBXheVzGIcxv4s+kenMitTlHP0VyQGGVV+/ZJvw2o2l2w==
X-Received: by 2002:a2e:9259:0:b0:2ee:52f4:266 with SMTP id 38308e7fff4ca-2eeb30ba981mr76276811fa.3.1720771291850;
        Fri, 12 Jul 2024 01:01:31 -0700 (PDT)
Received: from localhost ([2401:e180:8873:3610:b5e2:cfc7:c3d8:6a2b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b5689sm6859884b3a.187.2024.07.12.01.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 01:01:31 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 0/3] Use overflow.h helpers to check for overflows
Date: Fri, 12 Jul 2024 16:01:23 +0800
Message-ID: <20240712080127.136608-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set refactors kernel/bpf/verifier.c to use type-agnostic, generic
overflow-check helpers defined in include/linux/overflow.h to check for addition
and subtraction overflow, and drop the signed_*_overflows() helpers we currently
have in kernel/bpf/verifier.c; with a fix for overflow check in adjust_jmp_off()
in patch 1.

There should be no functional change in how the verifier works and  the main
motivation is to make future refactoring[1] easier.

While check_mul_overflow() also exists and could potentially replace what
we have in scalar*_min_max_mul(), it does not help with refactoring and
would either change how the verifier works (e.g. lifting restriction on
umax<=U32_MAX and u32_max<=U16_MAX) or make the code slightly harder to
read, so it is left for future endeavour.

Changes from v2 <https://lore.kernel.org/r/20240701055907.82481-1-shung-hsi.yu@suse.com>
- add fix for 5337ac4c9b80 ("bpf: Fix the corner case with may_goto and jump to
  the 1st insn.") to correct the overflow check for general jump instructions
- adapt to changes in commit 5337ac4c9b80 ("bpf: Fix the corner case with
  may_goto and jump to the 1st insn.")
  - refactor in adjust_jmp_off() as well and remove signed_add16_overflow()

Changes from v1 <https://lore.kernel.org/r/20240623070324.12634-1-shung-hsi.yu@suse.com>:
- use pointers to values in dst_reg directly as the sum/diff pointer and
  remove the else branch (Jiri)
- change local variables to be dst_reg pointers instead of src_reg values
- include comparison of generated assembly before & after the change
  (Alexei)

1: https://github.com/kernel-patches/bpf/pull/7205/commits


Shung-Hsi Yu (3):
  bpf: fix overflow check in adjust_jmp_off()
  bpf: use check_add_overflow() to check for addition overflows
  bpf: use check_sub_overflow() to check for subtraction overflows

 kernel/bpf/verifier.c | 171 ++++++++++++------------------------------
 1 file changed, 48 insertions(+), 123 deletions(-)

-- 
2.45.2


