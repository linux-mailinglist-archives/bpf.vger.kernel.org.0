Return-Path: <bpf+bounces-68666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332F8B7FE55
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20EE542BC8
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360C72C324F;
	Wed, 17 Sep 2025 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCYCm/tv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC129AAF3
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117934; cv=none; b=Gz1BxDyN7OnrLBNVICkcsne0QVhueXxhlHWDUEc0xFnOWobL3x574f6gHKMTAj/sLh0CcVeaOqdgME6HUKi45KTyi/tn1KENTpWN3FyX3HA/VDhpE7fvoNS2+ivKfQb4OXHGWJcCT56AOPCfmGBNPwAQetgCltI+m9BawYRwBLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117934; c=relaxed/simple;
	bh=txdleBHM3a8bC7TTWe8oaYefEX/UfUUpn3n9vG3s8as=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PRHhhmF/5Zuo+fJDHig9dqplOFzmqLk1Iw7w6yEK+Y4yk8fHDlcOvW2Q4LEw3TIfZaCAEABZ6pz87asnq8FH50RbIQyT0dj5GeAAxL96KDWruaIl64WHf4DoaabASclm2wF7FT8iHdeXorf/PqtBlDIldaRfZ0ws7GsX/TqYhCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCYCm/tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6316C4CEE7;
	Wed, 17 Sep 2025 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758117934;
	bh=txdleBHM3a8bC7TTWe8oaYefEX/UfUUpn3n9vG3s8as=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lCYCm/tvHzBvRN7i6k7Qdt+e79T71Jm/m8L3NZ3PJOyKOtE/1AJ/6phFPgmocPrZJ
	 DCsSsA7s2SBUmAqUstvgAA+SuG+DFU2Lc/hMbfTdptHp8uSi4JAstt8BISAm2fgPxv
	 toSGy5fwOYtAlo9G0fFkQDc+6EWnNqB06Q6hjuJPUNVy8HLKCBO92EA2roHWDQdus8
	 L6lxOwoQLe3HxAyQawk86Win1pWVWJo5KfD6QfW+vzQkbSm1ABMdRR0iZBN9xUSp0E
	 7syK+QyHdplSttj7g4w/z3WVtZBgT1WMmTTVMEYlLT1JqUPiIzTw4o7h358098Qkf7
	 PgAPyldCiHooQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Hengqi Chen <hengqi.chen@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 xukuohai@huaweicloud.com
Cc: bpf@vger.kernel.org, Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Call
 bpf_jit_binary_pack_finalize() in bpf_jit_free()
In-Reply-To: <20250916232653.101004-1-hengqi.chen@gmail.com>
References: <20250916232653.101004-1-hengqi.chen@gmail.com>
Date: Wed, 17 Sep 2025 14:05:30 +0000
Message-ID: <mb61p7bxxqimt.fsf@kernel.org>
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
> Acked-by: Puranjay Mohan <puranjay@kernel.org>
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
>  		}
>  		prog->bpf_func -= cfi_get_offset();
> -- 
> 2.27.0

Acked-by: Puranjay Mohan <puranjay@kernel.org>

Thanks,
Puranjay

