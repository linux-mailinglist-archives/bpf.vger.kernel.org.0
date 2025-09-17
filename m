Return-Path: <bpf+bounces-68642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69979B7EB39
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71761C04414
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 08:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E492306D58;
	Wed, 17 Sep 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMsJW/KX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245D21CA1F
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096433; cv=none; b=jWN+SIBSP+LwaGAhphvOAJdH9Lr48wMBG+EfLuL5Qhd7QHKqIjb863M84ky28M6Km255Tu/YpZfN3GSDZCbLu8Xvv579NDiA3TlTI/zQGTDoKTQAVGWhhPDYDzfDotiEWTbBFiFeGOm4fpbCUkoFORdL1LLBk2XXTsysxVnp4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096433; c=relaxed/simple;
	bh=d5bMICGZt1/Kv2FE70ThI+bNKN0SeFLnX98pGQ/9krg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RroKGkIEaYZHlJXtCcudf0mr4Ne+NEZfLIn+MRQ8C68fAYkiJ3Lf4MShV8y9EAUcI0CxyZgACFCSMXjsvuEdMF4U8+HpZJraolnp2S3DYG/uB9MkEFA9w3+bOHHYmJpEvhQaozKlAyMHYT8CCDZbOFkhGyC8YInZ5V13WtH55ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMsJW/KX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so448963f8f.0
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758096430; x=1758701230; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uP/fYPFYw8jqJYXcDwGTRw6nICKSA/0keLHin7n4N+I=;
        b=hMsJW/KXsHz5SeUG19bydfMbcM9NfIcqrI7fIAI5Z6pRS+DCD4oFnrWhx0S46OF6s3
         TMAb7lyFAIvbFovkazlds8hQzA31/5tuX/r4TBpzqJljyH2HDiWxvKklJbZB/7dfcakm
         hiRdy36QWfZsLSBm5jnS0U7egXTvpLhYuLq9KXJvEEQOwGEuygKtadvUqUg5orr2gDk7
         +IckYX80lVTTY4/eGzNiaKuGclqYdwo3YQ6p6Dn8WUL6FMyZMESyUSRMaHXnLUmqLuXq
         OmxvaMOPerEmzkhhqsef+SmFyL1LqlrlpjDyWyhc/kC/HzGStNPOXFsV784MfjkPKtZa
         YPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096430; x=1758701230;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uP/fYPFYw8jqJYXcDwGTRw6nICKSA/0keLHin7n4N+I=;
        b=opTmwSJ/v8xjoVWUa3I39KoltsH8QDflweoZ8DyMjvHsUIdQe16XMrlv84iNnfWsvu
         dtFs8M0a80SIQpVgi1sxM40RTWwsD5PgjpY9xiWbXc88WF6WGtKopbFUCHSOumDxwnJk
         30hY6ODpsUbCTJjL3B45CzUO1VLFNMnaN0jWhxtw7NkTQf35L4CzaUZeKZUa42nckZO0
         tQgOCHsBuFy58ojIPhRuudD0tmQKpg7/isHyB/WHmEylVMZGQ1+linDVbo7P362cAj85
         vASXa+1qy8NYSoMKVwPvHkX184EkzvGV+lJ6kyymef4QfRuE5miucqvolY4g19M7yZ+X
         9GsA==
X-Gm-Message-State: AOJu0YzTHkzI+XUXn5BprBTa9dbp1QH0983CLKMJ6JIL5XyRu1iFT4Ig
	cuuCn7WMgIhfuIcSIbgcFzxMIfz/PKBg8JfNb/7SJyRYZCxenuUvlMzc/AUk3vg2
X-Gm-Gg: ASbGnctrQVXgCkFn/45x3YsZnuE0bvrvaAfFy37nb3odfJD6Sxnk+mR0tF4lmXha/XA
	F7wJFa4kf39iYvPJB017aV/YSlxrQIbGnBeEj6CIvvy93R6g81GNei4t10MEMtmtXuoJlk1H8qW
	E5P7Niwi+5CFmKausTN/dnxc4UmyjB7/5gw6pdDOWkvOB1Riyq5rgY9to0voXooggHfTv9tpRl5
	RnWm/kHVEQOuY4VLX0ixpNwjswSRE+3vJBt9/kyKYMp8GwKqa6ho48AEgH+FIKpdaspp4fgieZ0
	K8YblaGrA4/BUCt23dwoL/BHlXVSFPi7AbTEkPsvIXft+pjJNz1XLO+17/m0DSO1GBOvyWxWU+/
	UcJiWDek0bb+Gy7Qv5t9xv/DPKD2DUZsspr1xQjpbAeo96h+6xVcSvUKPx1EcMIbvyKUQwqfYlT
	JxQi1JC3tszkJOFrFYadem
X-Google-Smtp-Source: AGHT+IHk0SfONHJ1G1mcjpK5mO2023lnmNXVdZGtAoeYnMbrO9boM8qbzKyMSlmIMtMChPxHk9emWg==
X-Received: by 2002:a05:6000:22ca:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-3ecdfa65da0mr1053635f8f.12.1758096430081;
        Wed, 17 Sep 2025 01:07:10 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f6fdfecb9884ca93.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f6fd:fecb:9884:ca93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9b1ab74b8sm14118854f8f.5.2025.09.17.01.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:07:09 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:07:08 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/3] Avoid warning on bpf_sock_addr padding access
Message-ID: <cover.1758094761.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset fixes bpf_sock_addr padding access to avoid a kernel
warning and improves our selftests coverage for these ctx padding cases.

Changes in v2:
  - Rebased on top of bpf-next.
  - Added selftests for paddings in bpf_sock and sk_reuseport_md.
  - Simplified sock_addr_is_valid_access's logic, as suggested by Daniel.
  - Removed a tab copied from existing code and spotted by Eduard.

Paul Chaignon (3):
  bpf: Explicitly check accesses to bpf_sock_addr
  selftests/bpf: Move macros to bpf_misc.h
  selftest/bpf: Test accesses to ctx padding

 net/core/filter.c                             | 16 ++++++----
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  4 +++
 .../selftests/bpf/progs/test_cls_redirect.c   |  4 +--
 .../bpf/progs/test_tcp_hdr_options.c          |  5 +--
 .../selftests/bpf/progs/verifier_ctx.c        | 32 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_sock.c       |  4 ---
 6 files changed, 46 insertions(+), 19 deletions(-)

-- 
2.43.0


