Return-Path: <bpf+bounces-36957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 659AD94FA60
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 01:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0673CB21B43
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 23:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA1E19A294;
	Mon, 12 Aug 2024 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrgfUzXR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DC18455E
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506251; cv=none; b=NzXe4Km/A2HiZ23/sswAvr56TbePvuQfZwoouowtAxoS9ycW40IHjI9Ye2PoVEih4D7a1TySee5Yk0z8riuCDo5E9xA/LL9ys5Se4BOjBti/IpGwaAC+aeCTxMZqk4UMwRmJuJto4fmHW9pclJNnmLSbfuIkBy2OLnZjVhzNeog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506251; c=relaxed/simple;
	bh=wIABhbc4fL9P21gp9x2cFaW8B+vQujwxX/4Tn7HYcd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sblyHmOzF2SufxFgKyHoHMdKbA7mtrkjybmSX368xNNjdQ52tNzGE/uAsY9IL9KRNK2gdOJY3sY2xAPY76o4rSaW9KsulsKpDSkPF86cCwHoi2aJxWVhXtlFuWQe6DYxyPjqC3AX+42Sf2j+lv3MkOD31RJUT3S8o3sxLuUPbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrgfUzXR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb64529a36so3274390a91.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 16:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723506249; x=1724111049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8byz90BxzzUl8NLmx+4c7Pbt9WVoYRE6htWyDXf0DsY=;
        b=DrgfUzXRIUKEFyrb3BbF6Fya+s3P9XRRfPE8O8qXlYb/SV+3tlF2lWGm7tXZADiVix
         f7Ailhk7vlyNe8lJNdGHxfvR2ARv0cZmaTEXhFJlltoKCEva8lhzJtrhRW0quZpoAs+s
         CUQSlckk9QyMjkpcZ03+2o7QWsUKvbw2acH3Aa6FpOPrxioDR1LCJY7e0kpNopvN0FZW
         OL2cRKC28vm0sPaphgkfV2auo8Nkh5aAmmus0NCmAe+gYAdGApj35gbwt3hHla6MH1r6
         FtBOkykl5+ezsbN68qtDo2kHrlKYArd70I9e6Sar8shVtZuosOnU1fS3eRp1nhobzB4V
         QFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723506249; x=1724111049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8byz90BxzzUl8NLmx+4c7Pbt9WVoYRE6htWyDXf0DsY=;
        b=oteAMWN2qGkhTddD/tRds99wej1q8M8TzfaXeWg/g4vK+zKPGlTXoN3m6USSs/eFT+
         jDnY6gME8AnjHqvTowuqnDDOuusQnpgW72MSoHsx6jzv1kDn18MxAdrZhfdADOey04eN
         r43B5iYcqzq+ZAOuNBkC/8s/oTdyY+rjhyPQ9/fgKvhIPVuxyiUWX+1diJmbokjKmqlk
         Vrt9ulz7gmbBg+Vd2gJPk9w5tUD01StOK6O43BccIGBRqbfj8FmIrI6O3TKl1uNcAlUq
         Fjvqd11wOBe94L41zJUHtuTB3P8gafhvvRoCbPlL/nYdltctsC3XKMoGkMxyQGGt3zzK
         0Gsg==
X-Gm-Message-State: AOJu0Yyccvxgbob4ULWxCygnCS+I2rxMwK021hhDwucC3rlzwg0mGatC
	ldP1XEOSvQxVDwur2lt1Nt3ZCspI02ke7LnfQy1aYRuMMHIxmdqWvRx18qgbQwg=
X-Google-Smtp-Source: AGHT+IFJxHgsfRaeFviKhDluc9H3IcXmT3ajeNtf/KmOvlSpq/ii5X0Zs4nzlfCnLmqu7Jvta+sIRQ==
X-Received: by 2002:a17:90a:a014:b0:2c9:999d:a22d with SMTP id 98e67ed59e1d1-2d392622f5dmr1990756a91.30.1723506248819;
        Mon, 12 Aug 2024 16:44:08 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fcfe3c1asm5688538a91.39.2024.08.12.16.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 16:44:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/3] support nocsr patterns for calls to kfuncs
Date: Mon, 12 Aug 2024 16:43:53 -0700
Message-ID: <20240812234356.2089263-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As an extension of [1], allow nocsr patterns recognition for kfuncs:
- pattern rules are the same as for helpers;
- spill/fill removal is allowed only for kfuncs marked with KF_NOCSR
  flag;

Mark bpf_cast_to_kern_ctx() and bpf_rdonly_cast() kfuncs as KF_NOCSR
in order to conjure selftests for this feature.

After this patch-set verifier would rewrite the program below:

  r2 = 1
  *(u64 *)(r10 - 32) = r2
  call %[bpf_cast_to_kern_ctx]
  r2 = *(u64 *)(r10 - 32)
  r0 = r2;"

As follows:

  r2 = 1   /* spill/fill at r10[-32] is removed */
  r0 = r1  /* replacement for bpf_cast_to_kern_ctx() */
  r0 = r2
  exit

[1] no_caller_saved_registers attribute for helper calls
    https://lore.kernel.org/bpf/20240722233844.1406874-1-eddyz87@gmail.com/

Eduard Zingerman (3):
  bpf: support nocsr patterns for calls to kfuncs
  bpf: mark bpf_cast_to_kern_ctx and bpf_rdonly_cast as KF_NOCSR
  selftests/bpf: check if nocsr pattern is recognized for kfuncs

 include/linux/btf.h                           |  1 +
 kernel/bpf/helpers.c                          |  4 +-
 kernel/bpf/verifier.c                         | 37 ++++++++++++++
 .../selftests/bpf/progs/verifier_nocsr.c      | 50 +++++++++++++++++++
 4 files changed, 90 insertions(+), 2 deletions(-)

-- 
2.45.2


