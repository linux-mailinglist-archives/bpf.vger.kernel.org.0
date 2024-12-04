Return-Path: <bpf+bounces-46044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7B29E3183
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 03:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7569EB2640D
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 02:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F744C94;
	Wed,  4 Dec 2024 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrSEiR30"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7127715
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280119; cv=none; b=Thu3D05Pic2xZeVeV6yozXozA37Fv6gEsY92G1DnsXFXKfxRnxI1DPOkpQSIugHqTjtMmOyDIVyAkMYQOyzJLB4ylYnBWarIBBTCyQlvCix3yZZR+l8OGXT4Z/0kBd8zWVA9a+DyCanphZzQmq4U92IzeU8RFGp1iFTE3WrcFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280119; c=relaxed/simple;
	bh=ULoSHOerlTsGTXmZbN4tEM6h3CTPv6KPWo+ak7IXo8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tq2pdhO8GGq9CqTQYoLI8+ZzRlh+98dkl+b3F9SzhL7rLsgMwK6T6osBEjeqhMkOKkjroRRqN2HsbReDRs0WZ/+iPHrZG3w4H2omXKh3X06pZLedS/q3DXMOJQAaVniwPBW25w+GT2g1c/OpIvmkeeopys1mI06iRM2ALS9bii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrSEiR30; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-385e35912f1so3052212f8f.3
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 18:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733280116; x=1733884916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r34zyuCvbxBXjY42mabehAudome2dXk+3nLxXretxsM=;
        b=PrSEiR307l4D2ETPf3Dl3I3Z/xoqUSH6W2KTs/TAK+lPV2YUgHl2sImw7Bx3Hydt8B
         vWXlQ3k4w6cg7s8ley1nwOYEudRt+MKZ6TBOq8kEiC+BVsSiTo3QFjbvjWXCWWefAIrG
         QhHhB6OEjWTbCvwxy11iC38P4sWw42aW409ptc7uT55ePa0R8gT6XPln728PcfnV+08g
         xv7eIzf+ywHtuWqhSBSOhjwL92JDKqvFmFktXSPc0vhO6SKuL/COdVm2w0xb/rYuifKr
         WAXW2yLyfqo5vO0TEENDcdw4JCt0acS0LUoU+GLaH8zLBMcgZzHSIoL3Q0/5FrKgPYxX
         effw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280116; x=1733884916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r34zyuCvbxBXjY42mabehAudome2dXk+3nLxXretxsM=;
        b=blBTrPMTlM5dUX4BmBYEHSWzl2cldp2ZWQmWB6bezYOpw7GFQrQ2Rn6yjFkO7d1SLO
         C9IXwO/BEVilw7+l4YhVYpu9yyLZyTCEolYZ+smDg4Ktd63bNChAtz/y7HpVBIGHevNA
         7I4EYS+/NRSlLoJ0pUiUy6m5h+5VUruUoxzoUkFTldVWIrZodZMFUWS28iV774ux2qIX
         Cd9NytzgI5iJr/Sp7yZ4HQrFSDDtLY2FMEaU2aM4SfcA31R89kNNyhumEwTa1OYbsTA4
         Zl0TBng0i/ZDWZenMhxBN70zrFCGdCoMg08GS7D1MQRxhOiBLj5g9/+Shub/u/kYsVsP
         RIjA==
X-Gm-Message-State: AOJu0YxvsN8ZvCP6VIR9ckYte+CwxfGtD7IEyUN12pbDy5Oxwc/V7nsk
	iz4Uv0gTDCcDs/RCX2IeAMVmOUBiAAx8NoMMQc/89UBbrp4RfeLcTnziapzbmO8=
X-Gm-Gg: ASbGnctn8/mOg2Vefw7hGP1k8PbpBBv5tKsOfyeadDk+L0EA8PWIEQ3nl4JTJoCf27O
	YwZNGMrfd955duuyKKFSH+9ok33ISfWfPuEQQSZ3zzF7CyfXgoQFE3ecCf0n6QlFxX+y8GdpoVI
	AzocM4FIFd1hbN23a8JP7U6gvmfCPmsINE9z7vv4xJq+BLI+Thf7BIoWLz9B6Wqto+mrsJV+yhS
	UV60vlto4nW4Tius5flM1V/H1aX+8iVqKLjgDD7q3GoQ1bgG7rnCjpGrRiAsdwAFvSCV5vRaTBr
	2Q==
X-Google-Smtp-Source: AGHT+IF5V5DFbEDOROnCaKlXJUGaPUKrLPcWxipMIkG6MIQkkb9AHYTA5fG3RMfKxBsRbLVsAyEf8w==
X-Received: by 2002:a05:6000:1882:b0:385:f409:b4c with SMTP id ffacd0b85a97d-385fd42d0d5mr3928393f8f.54.1733280116021;
        Tue, 03 Dec 2024 18:41:56 -0800 (PST)
Received: from localhost (fwdproxy-cln-036.fbsv.net. [2a03:2880:31ff:24::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e13e8eadsm12810252f8f.28.2024.12.03.18.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 18:41:55 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Manu Bretelle <chantra@meta.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v1 0/2] Fix for raw_tp PTR_MAYBE_NULL unmarking
Date: Tue,  3 Dec 2024 18:41:52 -0800
Message-ID: <20241204024154.21386-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; h=from:subject; bh=ULoSHOerlTsGTXmZbN4tEM6h3CTPv6KPWo+ak7IXo8U=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT8CA/AgJuqEGAs0l5BaW+DM/Iej9IbACuhy8CxOs rTgWUiKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/AgAAKCRBM4MiGSL8Rym92D/ 46QgKxreCpvpxfGPYKjoftOZqjvVlX5Y/75OUxff/T3+k02FRq4sebmm7K7yaorx4gwWSFwmzQ/dVu wlnHEHzJUcZeAuqn5csxfVc+IlLgoh4Q0n1WvuqeMmILtB+38IgegrqDffSm7mWY7+y2cgnfuLDo3a 6lCBmUzq/atQMYJ9S7CvVy50Vt7VuVc5q1vtfxPnAXQ5vG1pgZbMXc8KDQthblJblDXpffVrHjgZsl mK4BO+bI29YGkB67jJVfFRoc4BDkxx9tChGt0doAZNMyNdr9OblQwLRWJLKkRESl1gTvXuVCkEOjfp 0NvJ9rCXCkNgHGHGw8S+F16/hczeQqFS3/GUV9b9ICjKB75TZmHHgxI4X+PC9GE2k/rYsoUzEz9Ibi W2+9fLs+oahDxHBDfqNOF4VSR08YUaYDoyqA67oLp/vqyQAvMrg3cEY5KAzZnR1FB9oEoSTuaKkLBs EZMnDg6EuOegEuzTQ/MlS4YluOjHx9gAjOucR/h+O6gv9z8sE/XiQNF3r5v/BENW0/ZbzkumNVrmq1 lGdISxXAeQN+li7GhaI4/aws++rNRQ1VEA+fTYck2prX5QQvjuuO2+VUCPBtsnQNa4mCda7na2Ot2Q nMlTwXBQ4rHZB9mt5GFDQOjnWCOm28zghbjqvnE0hVoip3ay9VZReyVnQpcw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

A production BPF program had the following code produced by LLVM.

r0 = 1024;
r1 = ...; // r1 = trusted_or_null_(id=1)
r3 = r1;  // r3 = trusted_or_null_(id=1) r1 = trusted_or_null_(id=1)
r3 += r0; // r3 = trusted_or_null_(id=1, off=1024)
if r1 == 0 goto pc+X;

After cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL"),
the production BPF program began throwing a warning in the verifier
because for the code above, when unmarking null mark from r1, the
verifier will notice another register r3 with same id but off != 0,
which is unexpected, since offset modification on PTR_MAYBE_NULL is not
permitted, but the aforementioned commit relaxed that restriction to
preserve compatibility with non-NULL raw_tp args.

Provide a fix to suppress the warning for raw_tp args. We will follow up
with a more generic fix to handle such patterns for all pointer types in
the verifier, which currently involves playing whack-a-mole with
suppressing such LLVM optimizations and reworking BPF programs to avoid
verifier errors.

Kumar Kartikeya Dwivedi (2):
  bpf: Suppress warning for non-zero off raw_tp arg NULL check
  selftests/bpf: Add raw_tp tests for PTR_MAYBE_NULL marking

 kernel/bpf/verifier.c                         | 44 ++++++++--
 .../selftests/bpf/prog_tests/raw_tp_null.c    |  6 ++
 .../selftests/bpf/progs/raw_tp_null_fail.c    | 81 +++++++++++++++++++
 3 files changed, 126 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null_fail.c


base-commit: 45e04eb4d9d85603539984bc9ca930c380c93b15
-- 
2.43.5


