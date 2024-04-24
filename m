Return-Path: <bpf+bounces-27649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E49398B02DF
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 09:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB78B22070
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 07:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44868157A48;
	Wed, 24 Apr 2024 07:07:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E563B784;
	Wed, 24 Apr 2024 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713942443; cv=none; b=FfEgCDIiGmtBdUxXyJM4HUJO2YLpQbdebedL5mtXT3BYQJ47FQXZyLnRFwWBZs6zJzBQ3G8RQ8FkPb5G7/cekTOLQEPKRjtnuTjBRBEZq5xptTEV9Q3SKG8Ytvj9BcExirU+pG9s0RuBxVHRsc4i07XOpOCVYVaaGq+HOrq0OKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713942443; c=relaxed/simple;
	bh=Gf+G+MESnnALE0vV/0ONEk5uY23LNiKI9OibIs9tt0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwYXJ2kqrJxEEro9HNfHk5jeMCuveCosDhpsc0JV+aBB+N33wZUUikWu1KmAYlaYyG4LR8yV2QHcgG1kqEKyfT5tjCyKgS0QbSs/NB9u5U0xbxcUNvUFPddog1fUk/JmwKTD18BiKGJUP47XAT5YMP9YA00unoLeq4diJmwucSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VPVQC1knzzcZxw;
	Wed, 24 Apr 2024 15:06:11 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (unknown [7.185.36.155])
	by mail.maildlp.com (Postfix) with ESMTPS id C050A140BA4;
	Wed, 24 Apr 2024 15:07:15 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Apr
 2024 15:07:14 +0800
From: Xin Liu <liuxin350@huawei.com>
To: <yonghong.song@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kongweibin2@huawei.com>, <kpsingh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <martin.lau@linux.dev>, <sdf@google.com>,
	<song@kernel.org>, <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
	<yanan@huawei.com>, <yhs@fb.com>, <zhangmingyi5@huawei.com>
Subject: Re: [PATCH] libbpf: extending BTF_KIND_INIT to accommodate some unusual types
Date: Wed, 24 Apr 2024 15:06:21 +0800
Message-ID: <20240424070621.740898-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <a79006a7-a5af-4e30-8424-d54145bcd538@linux.dev>
References: <a79006a7-a5af-4e30-8424-d54145bcd538@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500010.china.huawei.com (7.185.36.155)

On Tue, 23 Apr 2024 13:12:04 -0700 Yonghong Song <yonghong.song@linux.dev> wrote:
> On 4/23/24 6:15 AM, Xin Liu wrote:
> > On Mon, 22 Apr 2024 10:43:38 -0700 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> >> On Mon, Apr 22, 2024 at 7:46 AM Xin Liu <liuxin350@huawei.com> wrote:
> >>> In btf__add_int, the size of the new btf_kind_int type is limited.
> >>> When the size is greater than 16, btf__add_int fails to be added
> >>> and -EINVAL is returned. This is usually effective.
> >>>
> >>> However, when the built-in type __builtin_aarch64_simd_xi in the
> >>> NEON instruction is used in the code in the arm64 system, the value
> >>> of DW_AT_byte_size is 64. This causes btf__add_int to fail to
> >>> properly add btf information to it.
> >>>
> >>> like this:
> >>>    ...
> >>>     <1><cf>: Abbrev Number: 2 (DW_TAG_base_type)
> >>>      <d0>   DW_AT_byte_size   : 64              // over max size 16
> >>>      <d1>   DW_AT_encoding    : 5        (signed)
> >>>      <d2>   DW_AT_name        : (indirect string, offset: 0x53): __builtin_aarch64_simd_xi
> >>>     <1><d6>: Abbrev Number: 0
> >>>    ...
> >>>
> >>> An easier way to solve this problem is to treat it as a base type
> >>> and set byte_size to 64. This patch is modified along these lines.
> >>>
> >>> Fixes: 4a3b33f8579a ("libbpf: Add BTF writing APIs")
> >>> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> >>> ---
> >>>   tools/lib/bpf/btf.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> >>> index 2d0840ef599a..0af121293b65 100644
> >>> --- a/tools/lib/bpf/btf.c
> >>> +++ b/tools/lib/bpf/btf.c
> >>> @@ -1934,7 +1934,7 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
> >>>          if (!name || !name[0])
> >>>                  return libbpf_err(-EINVAL);
> >>>          /* byte_sz must be power of 2 */
> >>> -       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
> >>> +       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 64)
> >>
> >> maybe we should just remove byte_sz upper limit? We can probably
> >> imagine 256-byte integers at some point, so why bother artificially
> >> restricting it?
> >>
> >> pw-bot: cr
> > In the current definition of btf_kind_int, bits has only 8 bits, followed
> > by 8 bits of unused interval. When we expand, we should only use 16 bits
> > at most, so the maximum value should be 8192(1 << 16 / 8), directly removing
> > the limit of byte_sz. It may not fit the current design. For INT type btfs
> > greater than 255, how to dump is still a challenge.
> 
> Looking at this patch. Now I remember that I have an old pahole patch
> to address similar issues
>    https://lore.kernel.org/bpf/20230426055030.3743074-1-yhs@fb.com/
> which is not merged and I forgot that.
> 
> In that particular case, the int size is 1024 bytes.
> Currently the int type more than 16 bytes cannot be dumped in libbpf.
> Do you have a particular use case to use your__builtin_aarch64_simd_xi() type
> in bpf program? I guess probably not as BPF does not support
> builtin function your__builtin_aarch64_simd_xi().
> 

Currently, there is no use case of byte_sz in btf, so let's remove
__builtin_aarch64_simd_xi first.At least this will support the kernel
compilation phase without causing the kernel to fail directly when
generating btf.

> >
> > Does the current version support a maximum of 8192 bytes?
> >
> >>>                  return libbpf_err(-EINVAL);
> >>>          if (encoding & ~(BTF_INT_SIGNED | BTF_INT_CHAR | BTF_INT_BOOL))
> >>>                  return libbpf_err(-EINVAL);
> >>> --
> >>> 2.33.0
> >>>

