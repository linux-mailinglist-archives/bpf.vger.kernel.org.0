Return-Path: <bpf+bounces-22243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39D285A0D2
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 11:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026571C213B6
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21282577D;
	Mon, 19 Feb 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZj/Sz/I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7172561A;
	Mon, 19 Feb 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338063; cv=none; b=VjgeIrFk1eckyIZ+CZ4WbFqYLWTnfKQuf7gM/hCR/+IX9vJ0u8n375/6l6zr20t60TyXWEUWkgq7jNeOZb7vyTn5+2nXB0BlDvi3ax462+vrJP29Vp7/4Z+qSb6fqlwo2pn2y+4115GUF0mqwYKGR8OrXDCwKcSHZxP2V1ZNPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338063; c=relaxed/simple;
	bh=h8b5hbcVCLA3zszp+wjNGpgMRChVVKuKioL5cmf5iWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCEqiZ/e2H+SK+iZuDnYDjAGzLuZKu+CMZtQ//SAyHwNL1h9C3Y01TxQ/j9mvvrMI8xZ//VB8AMWWXDwgmKAGgk6MhkDoYXgdC+GrmVltrfcrWKjewkp8Qaxald8r8RuoZp6hpcfeGDPOC0pjBtyaN0FdH6N8ghFW3nIRBY0cOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZj/Sz/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931B7C433C7;
	Mon, 19 Feb 2024 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708338062;
	bh=h8b5hbcVCLA3zszp+wjNGpgMRChVVKuKioL5cmf5iWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZj/Sz/InasetlsIOZ7hkseqSjGZfo0eNokPYcfmTapImrSac7KzyzLqc4Wdw5QdM
	 TmUmvKOtra/aY9QMGHMH/Q2lFGaG72k31w9wwIEBGgPdxaiuhm/SVDR9NGCOVE1Mle
	 d1Tsay61132yt+6zak0tpyeqsbw4fhjHDhOJ+XHAOnHJ60PieASP7OO9anVqPEMldn
	 8OftREMRCtZCzV8BWEqmJYzNHNez1KM/lf3zUEH0btz0GN813kCNk6TWCPat4z/2Hg
	 aTsxqZVDzNOjfRQEaVRl7G4Ga/x4gmHaf2WBxELBUDZou9Wlz8W497P0K2v/mQCv3D
	 GJk5Mtc14aWaw==
Date: Mon, 19 Feb 2024 10:19:25 +0000
From: Simon Horman <horms@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Check return from set_memory_rox() and
 friends
Message-ID: <20240219101925.GW40273@kernel.org>
References: <63322c8e8454de9b240583de58cd730bc97bb789.1708165016.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63322c8e8454de9b240583de58cd730bc97bb789.1708165016.git.christophe.leroy@csgroup.eu>

On Sat, Feb 17, 2024 at 11:24:07AM +0100, Christophe Leroy wrote:
> arch_protect_bpf_trampoline() and alloc_new_pack() call
> set_memory_rox() which can fail, leading to unprotected memory.
> 
> Take into account return from set_memory_XX() functions and add
> __must_check flag to arch_protect_bpf_trampoline().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

...

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ea6843be2616..23ce17da3bf7 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -898,23 +898,30 @@ static LIST_HEAD(pack_list);
>  static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_insns)
>  {
>  	struct bpf_prog_pack *pack;
> +	int err;
>  
>  	pack = kzalloc(struct_size(pack, bitmap, BITS_TO_LONGS(BPF_PROG_CHUNK_COUNT)),
>  		       GFP_KERNEL);
>  	if (!pack)
>  		return NULL;
>  	pack->ptr = bpf_jit_alloc_exec(BPF_PROG_PACK_SIZE);
> -	if (!pack->ptr) {
> -		kfree(pack);
> -		return NULL;
> -	}
> +	if (!pack->ptr)
> +		goto out;
>  	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
>  	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
>  	list_add_tail(&pack->list, &pack_list);

Hi Christophe,

Here pack is added to pack_list.

>  
>  	set_vm_flush_reset_perms(pack->ptr);
> -	set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
> +	err = set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
> +	if (err)
> +		goto out_free;

But this unwind path doesn't appear to remove pack form pack_list.

Flagged by Smatch.

>  	return pack;
> +
> +out_free:
> +	bpf_jit_free_exec(pack->ptr);
> +out:
> +	kfree(pack);
> +	return NULL;
>  }
>  
>  void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)

...

