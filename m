Return-Path: <bpf+bounces-66823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D4B39C64
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 14:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D11E4683FC
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5CF30FC08;
	Thu, 28 Aug 2025 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmE321J/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E730F554
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383016; cv=none; b=i1NnwZmzEyvAomnsZYoTXwE4Ewf8YultJCdRPzkdfGSxKZkO/82jhbxEkGePwWczgUY00f1BS9ZOgR2db1qYIzaRD/bNKOsWSKjqHOwbOR6BDUxGQDL/aJSX4AuT0xkxC/EDSn+I4KLgKuwx9PyqF5WSwdsxTmllDhC6nZJisr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383016; c=relaxed/simple;
	bh=zKFP7gnLB5E28hm89+phFHoHM6iqCsl0KuLbk4Kmfeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qAXOx07tIkVolnGnkIB2p3bk50JWmli41cn92jwwp+P2bAzLt427hQEoc3b+EfxlhRbLi7vLlG/sBBaGYSdiJrq/IrFFQEmbjp943HtsKgovLwquPpFB6FkXYEEIJlVop+gj8crflNdI85R8H6Bkorzr91P+rcmbuQ88VhN+gXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmE321J/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEB1C4CEF5;
	Thu, 28 Aug 2025 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756383015;
	bh=zKFP7gnLB5E28hm89+phFHoHM6iqCsl0KuLbk4Kmfeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nmE321J/SyL6viFFqnBuolsF9lsXeYrSBg4qkfajYLZhoO3D9TnP38CMSq+1BcNjJ
	 x8pOju3SWDlW6Eh7N3I7YTIWnXBR9kFFIojIWLsWTE+FIPsz9T371OtJhjU+DwZZd7
	 3w/p+40Wl7lyKaE+PPxuVTcHYX5mWI1LnTpQ+5ORKV8guA6Nht9G/+CFOMdXOqpOZa
	 JBg+RcOmHDnDhd/kRQAb2PuHSkVg8wvzO12vIqXxXZygs8XoGQW6Ey9vvi0DGSIQ6w
	 ESoRR69m53ULVTFvuHbnEM1H02Yx78XbWskogy6oL/UR+2KHtiKaWo/rVUec6eLpR9
	 92E9mywwvznjQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Hengqi Chen <hengqi.chen@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 xukuohai@huaweicloud.com, Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Call
 bpf_jit_binary_pack_finalize() in bpf_jit_free()
In-Reply-To: <20250828013415.2298-1-hengqi.chen@gmail.com>
References: <20250828013415.2298-1-hengqi.chen@gmail.com>
Date: Thu, 28 Aug 2025 12:10:11 +0000
Message-ID: <mb61pjz2nmyu4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hengqi Chen <hengqi.chen@gmail.com> writes:

> The current implementation seems incorrect and does NOT match the
> comment above, use bpf_jit_binary_pack_finalize() instead.
>
> Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 52ffe115a8c4..4ef9b7b8fb40 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -3064,8 +3064,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>  		 * before freeing it.
>  		 */
>  		if (jit_data) {
> -			bpf_arch_text_copy(&jit_data->ro_header->size, &jit_data->header->size,
> -					   sizeof(jit_data->header->size));
> +			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
>  			kfree(jit_data);

Thanks for this patch!

So, this is fixing a bug because bpf_jit_binary_pack_finalize() will do
kvfree(rw_header); but without it currently, jit_data->header is never
freed.

But I think we shouldn't use bpf_jit_binary_pack_finalize() here as it
copies the whole rw_header to ro_header using  bpf_arch_text_copy()
which is an expensive operation (patch_map/unmap in loop +
flush_icache_range()) and not needed here because we are going
to free ro_header anyway.

We only need to copy jit_data->header->size to jit_data->ro_header->size
because this size is later used by bpf_jit_binary_pack_free(), see
comment above bpf_jit_binary_pack_free().

How I suggest we should fix the code and the comment:

-- >8 --

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 5083886d6e66b..cb4c50eeada13 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -3093,12 +3093,14 @@ void bpf_jit_free(struct bpf_prog *prog)

                /*
                 * If we fail the final pass of JIT (from jit_subprogs),
-                * the program may not be finalized yet. Call finalize here
-                * before freeing it.
+                * the program may not be finalized yet. Copy the header size
+                * from rw_header to ro_header before freeing the ro_header
+                * with bpf_jit_binary_pack_free().
                 */
                if (jit_data) {
                        bpf_arch_text_copy(&jit_data->ro_header->size, &jit_data->header->size,
                                           sizeof(jit_data->header->size));
+                       kvfree(jit_data->header);
                        kfree(jit_data);
                }
                prog->bpf_func -= cfi_get_offset();

-- 8< --

Song,

Do you think this optimization is worth it or should we just call
bpf_jit_binary_pack_finalize() here like this patch is doing?

Thanks,
Puranjay

