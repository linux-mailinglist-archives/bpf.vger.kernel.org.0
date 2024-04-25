Return-Path: <bpf+bounces-27816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61748B23EF
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 16:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B7D28312F
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA7153510;
	Thu, 25 Apr 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4hhdS0/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E8C1534E8;
	Thu, 25 Apr 2024 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054779; cv=none; b=YmTuPFMGyvUjN3OBhUn1edaR3RPCOkOr0msfNF59c6uS5Df0+CrZNdL4gmCw+G1w8+Ntxa6fvS1q2UjKABt4/V5SokZdWI0DbD/3c+v1ju/3LWiM9Z+HLvq9kxtiUZmdjYfsxlh3g83erFsLAxFDSdMVlkOyLN1fHmsTmgJPx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054779; c=relaxed/simple;
	bh=/p9KNiZsQmUy2Vg1gCseczfp5v4YrwJ/YoZmbXRfjlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/op640+jShSC3PNBgUnAH2aoaiGuiGDJSgASJQZp8UVhkIWNjXe85UtLqVLO24HEXvaGt0kDQp3FI8dqeBnk5fNz3cyWbOI3N0nf5a9EncTsZZngJ6BlVfB3GVSvZaPiZoaVtjLqo3gl9VQCdIj1MOdluZw5JHkaArjmzjDvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4hhdS0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABE7C113CC;
	Thu, 25 Apr 2024 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714054778;
	bh=/p9KNiZsQmUy2Vg1gCseczfp5v4YrwJ/YoZmbXRfjlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4hhdS0/b8PEImEW9wO7Wi7f3tlGDUzstMXArg1CBC74HHRft4nYhaBBqyVlHiD3l
	 YPvemyjkH3xUKJ7wipySSG8rCtb1gdTRt3CyCuw8pFLInxcVsTgtnSDZBukJ4Ce5Jx
	 RU3mE7uAu5BlIPhlKIccvwSx1HMdBpxwG8OVsO1uuaYEYNfUJtT1mKwKipGwDXS6wH
	 Q1EIdEDL74SANwrMYjqMavxCzS+oh2lRaQZExt7nPhFUeKxEVSWJaO6vghFX8Kvha9
	 ZSftxvt1ndqXVgMmj5k4FBMozfe2AUfx/3xEsjHuSNxEMewrGidljpi46ny29R+NW4
	 HWXlEeKXjw0Yg==
Date: Thu, 25 Apr 2024 11:19:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Xin Liu <liuxin350@huawei.com>
Cc: alan.maguire@oracle.com, andrii@kernel.org, arnaldo.melo@gmail.com,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	dwarves@vger.kernel.org, kernel-team@fb.com,
	ndesaulniers@google.com, yonghong.song@linux.dev, yanan@huawei.com,
	wuchangye@huawei.com, xiesongyang@huawei.com,
	kongweibin2@huawei.com, zhangmingyi5@huawei.com,
	liwei883@huawei.com
Subject: Re: [PATCH dwarves] btf_encoder: Fix dwarf int type with
 greater-than-16 byte issue
Message-ID: <ZipmdsxjENtoRRkG@x1>
References: <686d2f65-0d6d-43e6-83fe-a9eb2eb6149e@oracle.com>
 <20240425134340.750289-1-liuxin350@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425134340.750289-1-liuxin350@huawei.com>

On Thu, Apr 25, 2024 at 09:43:40PM +0800, Xin Liu wrote:
> On Wed, 24 Apr 2024 15:35:38 -0700 Yonghong Song <yonghong.song@linux.dev> wrote:
> > Nick Desaulniers and Xin Liu separately reported that int type might
> > have greater-than-16 byte size ([1] and [2]). More specifically, the
> > reported int type sizes are 1024 and 64 bytes.
> > 
> > The libbpf and bpf program does not really support any int type greater
> > than 16 bytes. Therefore, with current pahole, btf encoding will fail
> > with greater-than-16 byte int types.
> > 
> > Since for now bpf does not support '> 16' bytes int type, the simplest
> > way is to sanitize such types, similar to existing conditions like
> > '!byte_sz' and 'byte_sz & (byte_sz - 1)'. This way, pahole won't
> > call libbpf with an unsupported int type size. The patch [3] was
> > proposed before. Now I resubmitted this patch as there are another
> > failure due to the same issue.
> > 
> >   [1] https://github.com/libbpf/libbpf/pull/680
> >   [2] https://lore.kernel.org/bpf/20240422144538.351722-1-liuxin350@huawei.com/
> >   [3] https://lore.kernel.org/bpf/20230426055030.3743074-1-yhs@fb.com/
> > 
> > Cc: Xin Liu <liuxin350@huawei.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> 
> Reviewed-by: Xin Liu <liuxin350@huawei.com>

Thanks, applied to next,

- Arnaldo
 
> > ---
> >  btf_encoder.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index e1e3529..19e9d90 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -393,7 +393,7 @@ static int32_t btf_encoder__add_base_type(struct btf_encoder *encoder, const str
> >  	 * these non-regular int types to avoid libbpf/kernel complaints.
> >  	 */
> >  	byte_sz = BITS_ROUNDUP_BYTES(bt->bit_size);
> > -	if (!byte_sz || (byte_sz & (byte_sz - 1))) {
> > +	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16) {
> >  		name = "__SANITIZED_FAKE_INT__";
> >  		byte_sz = 4;
> >  	}

