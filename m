Return-Path: <bpf+bounces-27648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DEA8B0277
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 08:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47D5B21868
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 06:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4DD157499;
	Wed, 24 Apr 2024 06:53:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBBF182AE;
	Wed, 24 Apr 2024 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941581; cv=none; b=k1kKECSxg7jMVUg8dyN2uU/k7EBvEq4w1Ut0wY+gwt/8ivH2RPUJ31YlV7i2sT+45xpE/TgDDmUNqXlw5IOP2FZhFVzGQ4ivYBHhmnI2BTOACLtuQdc9CBnvX1ghZYEJ9iYvbtizI5LkoEVH650zk2yvoYQ0Boo83nfwnwZ6Rvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941581; c=relaxed/simple;
	bh=zs8x+Cx0jIOBkLzuCzbdwjkkfCF5gfQheU48pxRWMQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQKr6crP9xfiH17XlhrJQXw3dgpspVwKlsoGhuz5X7/Y7VOAXkQgBOr2TAQw2bTztY/13npp41kaZpvGYqlzSHvz3CqAI3LBxR4OfHrm4Yl4eyv5/nXd3eVqJe7yFhvNkCej0p6zgwS8OKM2z6bUuSQDVE+6Oair5cHeYrT1hC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VPV3L59ztz1hwMr;
	Wed, 24 Apr 2024 14:49:50 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (unknown [7.185.36.155])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CD5E1A0188;
	Wed, 24 Apr 2024 14:52:54 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Apr
 2024 14:52:53 +0800
From: Xin Liu <liuxin350@huawei.com>
To: <alan.maguire@oracle.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kongweibin2@huawei.com>, <kpsingh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <martin.lau@linux.dev>, <sdf@google.com>,
	<song@kernel.org>, <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
	<yanan@huawei.com>, <yhs@fb.com>, <zhangmingyi5@huawei.com>
Subject: Re: [PATCH] libbpf: extending BTF_KIND_INIT to accommodate some unusual types
Date: Wed, 24 Apr 2024 14:52:00 +0800
Message-ID: <20240424065200.736080-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <a60a0842-cff9-407b-b970-316e615e22e1@oracle.com>
References: <a60a0842-cff9-407b-b970-316e615e22e1@oracle.com>
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

On Tue, 23 Apr 2024 15:30:03 +0100 Alan Maguire <alan.maguire@oracle.com> wrote:
> On 23/04/2024 14:15, Xin Liu wrote:
> > On Mon, 22 Apr 2024 10:43:38 -0700 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > 
> >> On Mon, Apr 22, 2024 at 7:46 AM Xin Liu <liuxin350@huawei.com> wrote:
> >>>
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
> >>>   ...
> >>>    <1><cf>: Abbrev Number: 2 (DW_TAG_base_type)
> >>>     <d0>   DW_AT_byte_size   : 64              // over max size 16
> >>>     <d1>   DW_AT_encoding    : 5        (signed)
> >>>     <d2>   DW_AT_name        : (indirect string, offset: 0x53): __builtin_aarch64_simd_xi
> >>>    <1><d6>: Abbrev Number: 0
> >>>   ...
> >>>
> >>> An easier way to solve this problem is to treat it as a base type
> >>> and set byte_size to 64. This patch is modified along these lines.
> >>>
> >>> Fixes: 4a3b33f8579a ("libbpf: Add BTF writing APIs")
> >>> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> >>> ---
> >>>  tools/lib/bpf/btf.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> >>> index 2d0840ef599a..0af121293b65 100644
> >>> --- a/tools/lib/bpf/btf.c
> >>> +++ b/tools/lib/bpf/btf.c
> >>> @@ -1934,7 +1934,7 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
> >>>         if (!name || !name[0])
> >>>                 return libbpf_err(-EINVAL);
> >>>         /* byte_sz must be power of 2 */
> >>> -       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
> >>> +       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 64)
> >>
> >>
> >> maybe we should just remove byte_sz upper limit? We can probably
> >> imagine 256-byte integers at some point, so why bother artificially
> >> restricting it?
> >>
> >> pw-bot: cr
> > 
> > In the current definition of btf_kind_int, bits has only 8 bits, followed
> > by 8 bits of unused interval. When we expand, we should only use 16 bits
> > at most, so the maximum value should be 8192(1 << 16 / 8), directly removing
> > the limit of byte_sz. It may not fit the current design. For INT type btfs
> > greater than 255, how to dump is still a challenge.
> > 
> > Does the current version support a maximum of 8192 bytes?
> > 
> 
> Presuming we expanded BTF_INT_BITS() as per
> 
> -#define BTF_INT_BITS(VAL)       ((VAL)  & 0x000000ff)
> +#define BTF_INT_BITS(VAL)       ((VAL)  & 0x0000ffff)
> 
> ...as you say we'd be able to represent a 65535-bit value. So if we
> preserve the power-of-two restriction on byte sizes, we'd have to choose
> between either having ints which
> 
> - have a byte_sz maximum of <= 4096 bytes, with all 32768 bits usable; or
> - have a byte_sz maximum of <= 8192 bytes, with 65535 out of 65536 bits
> usable
> 
> The first option seems more intuitive to me.
> 
> In terms of dumping, we could probably just dump a hex representation of
> the relevant bytes.
> 

Currently, there is actually no scenario to use built-in structs in btf. 
As Song and Andrii said, can we remove this restriction first?

> >>
> >>>                 return libbpf_err(-EINVAL);
> >>>         if (encoding & ~(BTF_INT_SIGNED | BTF_INT_CHAR | BTF_INT_BOOL))
> >>>                 return libbpf_err(-EINVAL);
> >>> --
> >>> 2.33.0
> >>>
> >>
> > 

