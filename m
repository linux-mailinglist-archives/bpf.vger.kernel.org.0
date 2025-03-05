Return-Path: <bpf+bounces-53389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4875EA50BE8
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 20:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867C53A3CEE
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1413325486F;
	Wed,  5 Mar 2025 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGTocceb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED74225334C
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204194; cv=none; b=swfEQab7ahL8SrtTjK7FQ3aZ05jJZyywaj1x6uO5eNDUKSllVSBZOB2DLj/vE497SmbghRPKWORUkFviGWU/82c5rrRAKjqyEneiHIJSaIiV3mHMyI09DzbrCQnHE9S7mbxl643kuy74oXeLscVvOx0S3Q6+T8XaUabWCBI7x+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204194; c=relaxed/simple;
	bh=5NaKFyoud6P3x1lKhp8zfn95EYy411Wco7kBBCE9/Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1goff8dckcRdY2tSbu75xC6fKXvA/WMOtn0htGHg6KGEsyYBfjEeh3w/1EP0vX864ylIiNpuby2fNxN2IicmHOFN1igohhdKxYvdLRFxGYboyQpgI0GByexEr7fEbcuyojEyz6llyEayaqcH85AH5DxJnxsvTJZ4aGrBUXIQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGTocceb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf42913e95so813316366b.2
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 11:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741204191; x=1741808991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V9ajUvU1Fs5VzsMLO4X1B+Qspg5fSNfwOMZ/1wxAjmM=;
        b=eGToccebEfddry/JbapET8xXfvaI5geNHW7JZwoEeK3nX0z0OJz47VrhFbffbSskAt
         DBPZT3Uc3Mf+/TskSGRFQAdhB7OhoQui0OIPjzPn2G4HNmJ4HSv6nhNOMuw+PUsevi7V
         vpl518/xKVclw14XbZ1hUEnjfP19A5d2PQXleqZV1WO57yKCu/+47IlMrvEs48SAH+Ti
         8I56kqOR1Aw4EsJmE10cMnPTNPGjLhf+OoFRHoX2khKLlIIycpgDShyQ5fsWXsUQOJ6E
         iRJWFVfCOsRuwnQg9seZsHsjqK8WDwVvg+R0gI/IiWyLvlvefwj5v7l9xZP/r6Qobhkt
         y4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204191; x=1741808991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9ajUvU1Fs5VzsMLO4X1B+Qspg5fSNfwOMZ/1wxAjmM=;
        b=aV5rLdzh/uJ5aiqMfuBs+PW+Eq1sgpG8A/csU3qWflgd5+FeZNSKrQKDZokaBu6hD0
         1jL/9nwO1iUEsLRG1+B5eyQwrwAZ0tnrAj0YrooRfckDbHHMeqRlH4lz3G+sLNwFHCcF
         oJTE+cX9ds8NloEEWat/Mc39xiU6BrB3FvDV05yK8y5AAnCFWNijiI0U/wQFblnSGq9H
         ruE8lDXd9DEQBO0A1+iKGuCilPEp6ygWz432C1WdNCOM9lRXlwOuVepcAbr8pPCGVnAp
         RdF70njHirkqZ5sRFufUuqopm9gdBie4Aeo5mtS4XyibCRE6bhf0eRjTCxb1JhnJ9UNo
         Lh2g==
X-Gm-Message-State: AOJu0YxWjrlub61B647Xtgq+BqfOsLjJ0H5GcUZPH5gC6a+V9VGjGydW
	vXhFN5kDR3plb2J1/FDRUmPMfMtBo1+dG9ZFPK9Lsw2KedRqfEQ0WpCtLQ==
X-Gm-Gg: ASbGnctEoI8PFT3oe1g2H22bZ+t4baifIQRlwvbh1vqvEYhds3ozydY2rdRZKXJHR3U
	pgeiSm65JmLVvdVI2rIMZ8K6cYTSe//MH7LTGMFpT+obavSFC5XcEKcqzmubj/bF9IU2glyYqIJ
	uF7tLVOMBftaLTOkvEGcyPQAwKLrXZgYNom6HypNFXSs8L+RmHdAo7s8UzBuaiN82d38um5edvR
	6gFnjd5LyWDxblkfnLxqOU4yxMWzreDWfxPKk+Mu3WsyDFPgyGgHfa7kEsiDoUPkkTVSzy6Qwsz
	TJcCyggKeHcXL8c3YQFs15AQbPhvxe8La2Y8swtGvsw7Kg8eDwO+pyK5NMI=
X-Google-Smtp-Source: AGHT+IGcygIPF9tJDbrPjNH6DM98HX78nQpzJI83Nza4wyZhenSB0QPr2OPMRB9gSHtaHXqCG5WMYw==
X-Received: by 2002:a17:907:7b06:b0:abf:7026:13a2 with SMTP id a640c23a62f3a-ac20d9d94a1mr374697866b.17.1741204190787;
        Wed, 05 Mar 2025 11:49:50 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:4624])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1daea1cd2sm481584066b.181.2025.03.05.11.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:49:50 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 0/4] Support freplace prog from user namespace
Date: Wed,  5 Mar 2025 19:49:38 +0000
Message-ID: <20250305194942.123191-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Freplace programs can't be loaded from user namespace, as
bpf_program__set_attach_target() requires searching for target prog BTF,
which is locked under CAP_SYS_ADMIN.
This patch set enables this use case by:
1. Relaxing capable check in bpf's BPF_BTF_GET_FD_BY_ID, check for CAP_BPF
instead of CAP_SYS_ADMIN, support BPF token in attr argument.
2. Pass BPF token around libbpf from bpf_program__set_attach_target() to
bpf syscall where capable check is.
3. Validate positive/negative scenarios in selftests

This patch set is enabled by the recent libbpf change[1], that
introduced bpf_object__prepare() API. Calling bpf_object__prepare() for
freplace program before bpf_program__set_attach_target() initializes BPF
token, which is then passed to bpf syscall by libbpf.

[1] https://lore.kernel.org/all/20250303135752.158343-1-mykyta.yatsenko5@gmail.com/

Mykyta Yatsenko (4):
  bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
  bpf: return prog btf_id without capable check
  libbpf: pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
  selftests/bpf: test freplace from user namespace

 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/syscall.c                          | 13 ++-
 tools/include/uapi/linux/bpf.h                |  1 +
 tools/lib/bpf/bpf.c                           |  3 +-
 tools/lib/bpf/bpf.h                           |  4 +-
 tools/lib/bpf/btf.c                           | 14 ++-
 tools/lib/bpf/libbpf.c                        | 10 +-
 tools/lib/bpf/libbpf_internal.h               |  1 +
 .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +-
 .../testing/selftests/bpf/prog_tests/token.c  | 94 +++++++++++++++++++
 .../selftests/bpf/progs/priv_freplace_prog.c  | 13 +++
 tools/testing/selftests/bpf/progs/priv_prog.c |  2 +-
 12 files changed, 143 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/priv_freplace_prog.c

-- 
2.48.1


