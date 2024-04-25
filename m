Return-Path: <bpf+bounces-27808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD5A8B230D
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 15:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA811F22CDB
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 13:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DBC149DE0;
	Thu, 25 Apr 2024 13:44:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B2149C70;
	Thu, 25 Apr 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052685; cv=none; b=pQruheIRWPnOVW7nQ17+oHgjM1cFpjok71kLiNQS6mXo7qlkmGM/a+e9tEYAgnQHFBz1jUQUk5WyIEZuGSYyvC3ElMX2konDJiENRcASN2eeSR2l9xjGRGM6B27NxKFjjqsK8gn91i1scMQhNxxFoJMotaozkb+KB+PUVRK7M3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052685; c=relaxed/simple;
	bh=CyrSeJBRTRkJmYgi2pUvZxa1a3HuhHmZ2BltAAz8wfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfzExLJoFt3+190+xnIliNv5N8RZR6KELJuTbHoMqODkTF+Mp8/PEs0HjmvgXbwoyzE0S7Uk66njaxHqb0L6iFPNUerQbluLvkximYoaNKmid8g/AOxVcBsXQY0WeKU/5ovzpdbBBEBIaWcFE1nvEL1ySRe16h0UWdW0xHn67as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VQH8X4NLBzNtVH;
	Thu, 25 Apr 2024 21:42:04 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (unknown [7.185.36.155])
	by mail.maildlp.com (Postfix) with ESMTPS id 412FC180080;
	Thu, 25 Apr 2024 21:44:37 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 21:44:36 +0800
From: Xin Liu <liuxin350@huawei.com>
To: <alan.maguire@oracle.com>
CC: <andrii@kernel.org>, <arnaldo.melo@gmail.com>, <ast@kernel.org>,
	<bpf@vger.kernel.org>, <daniel@iogearbox.net>, <dwarves@vger.kernel.org>,
	<kernel-team@fb.com>, <liuxin350@huawei.com>, <ndesaulniers@google.com>,
	<yonghong.song@linux.dev>, <yanan@huawei.com>, <wuchangye@huawei.com>,
	<xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
	<zhangmingyi5@huawei.com>, <liwei883@huawei.com>
Subject: Re: [PATCH dwarves] btf_encoder: Fix dwarf int type with greater-than-16 byte issue
Date: Thu, 25 Apr 2024 21:43:40 +0800
Message-ID: <20240425134340.750289-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <686d2f65-0d6d-43e6-83fe-a9eb2eb6149e@oracle.com>
References: <686d2f65-0d6d-43e6-83fe-a9eb2eb6149e@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500010.china.huawei.com (7.185.36.155)

On Wed, 24 Apr 2024 15:35:38 -0700 Yonghong Song <yonghong.song@linux.dev> wrote:
> Nick Desaulniers and Xin Liu separately reported that int type might
> have greater-than-16 byte size ([1] and [2]). More specifically, the
> reported int type sizes are 1024 and 64 bytes.
> 
> The libbpf and bpf program does not really support any int type greater
> than 16 bytes. Therefore, with current pahole, btf encoding will fail
> with greater-than-16 byte int types.
> 
> Since for now bpf does not support '> 16' bytes int type, the simplest
> way is to sanitize such types, similar to existing conditions like
> '!byte_sz' and 'byte_sz & (byte_sz - 1)'. This way, pahole won't
> call libbpf with an unsupported int type size. The patch [3] was
> proposed before. Now I resubmitted this patch as there are another
> failure due to the same issue.
> 
>   [1] https://github.com/libbpf/libbpf/pull/680
>   [2] https://lore.kernel.org/bpf/20240422144538.351722-1-liuxin350@huawei.com/
>   [3] https://lore.kernel.org/bpf/20230426055030.3743074-1-yhs@fb.com/
> 
> Cc: Xin Liu <liuxin350@huawei.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Reviewed-by: Xin Liu <liuxin350@huawei.com>

> ---
>  btf_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index e1e3529..19e9d90 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -393,7 +393,7 @@ static int32_t btf_encoder__add_base_type(struct btf_encoder *encoder, const str
>  	 * these non-regular int types to avoid libbpf/kernel complaints.
>  	 */
>  	byte_sz = BITS_ROUNDUP_BYTES(bt->bit_size);
> -	if (!byte_sz || (byte_sz & (byte_sz - 1))) {
> +	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16) {
>  		name = "__SANITIZED_FAKE_INT__";
>  		byte_sz = 4;
>  	}

