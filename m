Return-Path: <bpf+bounces-27542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2078AE7BE
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 15:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845C4B22FBB
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 13:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D341353E1;
	Tue, 23 Apr 2024 13:16:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922C9134CC2;
	Tue, 23 Apr 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878166; cv=none; b=rtfIJSeQQTJ9eowfZmPx7BLVU36vJHb3qM/koF+kFN30Y0+sqMIIG6Wj6riGViOc+eSJ4lw1Bc76dA7EQ46+e4mLcq4oRdwx2OxhdmnWIKi6udzlp0pGCdwAZVXoQpsTvStAA8vRrk9U893uC/MilqhGVGQ9EphvbR52GBHKR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878166; c=relaxed/simple;
	bh=R73b195VgYovRIbyK5XIaCgc1Kuz4EKQSwcOa26eGg8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kQA4VbdnSiU6QvqtUk2BJQ3Si92bcyeuZBA660drdVP2Ajf18KI4NNgzASeMqr4BP1JG9Yd15GaVCfD6aLgOH/DMHd34A7BcaOQs1dTdL0xic7cQq+CImZZoloXRqOoUyZG5lH0vl2/8qPRwjtNCmWXEIYMdoI5ArHi6X9hzPOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VP2cS5yfFzNnnh;
	Tue, 23 Apr 2024 21:13:28 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (unknown [7.185.36.155])
	by mail.maildlp.com (Postfix) with ESMTPS id 451301800B8;
	Tue, 23 Apr 2024 21:15:59 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 21:15:58 +0800
From: Xin Liu <liuxin350@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
	<zhangmingyi5@huawei.com>, <liwei883@huawei.com>, <liuxin350@huawei.com>
Subject: Re: [PATCH] libbpf: extending BTF_KIND_INIT to accommodate some unusual types
Date: Tue, 23 Apr 2024 21:15:03 +0800
Message-ID: <20240423131503.361149-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500010.china.huawei.com (7.185.36.155)

On Mon, 22 Apr 2024 10:43:38 -0700 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Mon, Apr 22, 2024 at 7:46 AM Xin Liu <liuxin350@huawei.com> wrote:
> >
> > In btf__add_int, the size of the new btf_kind_int type is limited.
> > When the size is greater than 16, btf__add_int fails to be added
> > and -EINVAL is returned. This is usually effective.
> >
> > However, when the built-in type __builtin_aarch64_simd_xi in the
> > NEON instruction is used in the code in the arm64 system, the value
> > of DW_AT_byte_size is 64. This causes btf__add_int to fail to
> > properly add btf information to it.
> >
> > like this:
> >   ...
> >    <1><cf>: Abbrev Number: 2 (DW_TAG_base_type)
> >     <d0>   DW_AT_byte_size   : 64              // over max size 16
> >     <d1>   DW_AT_encoding    : 5        (signed)
> >     <d2>   DW_AT_name        : (indirect string, offset: 0x53): __builtin_aarch64_simd_xi
> >    <1><d6>: Abbrev Number: 0
> >   ...
> >
> > An easier way to solve this problem is to treat it as a base type
> > and set byte_size to 64. This patch is modified along these lines.
> >
> > Fixes: 4a3b33f8579a ("libbpf: Add BTF writing APIs")
> > Signed-off-by: Xin Liu <liuxin350@huawei.com>
> > ---
> >  tools/lib/bpf/btf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 2d0840ef599a..0af121293b65 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1934,7 +1934,7 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
> >         if (!name || !name[0])
> >                 return libbpf_err(-EINVAL);
> >         /* byte_sz must be power of 2 */
> > -       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
> > +       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 64)
> 
> 
> maybe we should just remove byte_sz upper limit? We can probably
> imagine 256-byte integers at some point, so why bother artificially
> restricting it?
> 
> pw-bot: cr

In the current definition of btf_kind_int, bits has only 8 bits, followed
by 8 bits of unused interval. When we expand, we should only use 16 bits
at most, so the maximum value should be 8192(1 << 16 / 8), directly removing
the limit of byte_sz. It may not fit the current design. For INT type btfs
greater than 255, how to dump is still a challenge.

Does the current version support a maximum of 8192 bytes?

> 
> >                 return libbpf_err(-EINVAL);
> >         if (encoding & ~(BTF_INT_SIGNED | BTF_INT_CHAR | BTF_INT_BOOL))
> >                 return libbpf_err(-EINVAL);
> > --
> > 2.33.0
> >
> 

