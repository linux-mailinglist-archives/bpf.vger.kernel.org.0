Return-Path: <bpf+bounces-58181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92662AB68D6
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 12:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D5777A5085
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606042701B8;
	Wed, 14 May 2025 10:30:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8825DCF9
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747218653; cv=none; b=DtDItZIwRuSUU4qR+vrSrwSSl++muv6WDoaikzpadQ9Dax2qA7ixVJ4VhUZU5AeYrZzHNr5gbAGBEIXZS4nOvHAX4tkEsxf92OLrRWjWzT80s4GBOOwJIBuk54lB3HHgL7PN5vT4xDhWriDG7EwZvzCKc5Ggtt9Yj+QSvkORwz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747218653; c=relaxed/simple;
	bh=chXXFStYvDTEIkJdweQvygxWPaoSL+ly1fIX7LN6hlE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XJyN/YGedsnNExn+x9yz6lWqfhW8PjTn9jjSwtkxt3PiwHdCrozbjnPaq4KqwBiLxRNT5KP+yqT3pBj12c+h0HOQhs+HY+KPx+zVes9nqupcKOd06ACzOiBK56rJpbDqP7Uith5ETpYP6cztrkOp85wIrOKbuDG2WwmQb5sCkIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4Zy8kV4Yllz4x3kG
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 12:30:42 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b73:c707:6969:f5d6])
	by xavier.telenet-ops.be with cmsmtp
	id oyWa2E0030UrTfo01yWarT; Wed, 14 May 2025 12:30:34 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uF9Ni-00000001fhW-1zHh;
	Wed, 14 May 2025 12:30:34 +0200
Date: Wed, 14 May 2025 12:30:34 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
cc: bpf@vger.kernel.org, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
    Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
    Daniel Borkmann <daniel@iogearbox.net>, 
    Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH bpf v2 1/3] bpf: Make CONFIG_DEBUG_INFO_BTF depend upon
 CONFIG_BPF_SYSCALL
In-Reply-To: <20211122144742.477787-2-memxor@gmail.com>
Message-ID: <edac3822-cd29-f7c8-1ff1-182dde7a2c0b@linux-m68k.org>
References: <20211122144742.477787-1-memxor@gmail.com> <20211122144742.477787-2-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

 	Hi Kumar,

On Mon, 22 Nov 2021, Kumar Kartikeya Dwivedi wrote:
> Vinicius Costa Gomes reported [0] that build fails when
> CONFIG_DEBUG_INFO_BTF is enabled and CONFIG_BPF_SYSCALL is disabled.
> This leads to btf.c not being compiled, and then no symbol being present
> in vmlinux for the declarations in btf.h. Since BTF is not useful
> without enabling BPF subsystem, disallow this combination.
>
> However, theoretically disabling both now could still fail, as the
> symbol for kfunc_btf_id_list variables is not available. This isn't a
> problem as the compiler usually optimizes the whole register/unregister
> call, but at lower optimization levels it can fail the build in linking
> stage.
>
> Fix that by adding dummy variables so that modules taking address of
> them still work, but the whole thing is a noop.
>
>  [0]: https://lore.kernel.org/bpf/20211110205418.332403-1-vinicius.gomes@intel.com
>
> Fixes: 14f267d95fe4 ("bpf: btf: Introduce helpers for dynamic BTF set registration")
> Reported-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks for your patch, which is now commit d9847eb8be3d895b ("bpf:
Make CONFIG_DEBUG_INFO_BTF depend upon CONFIG_BPF_SYSCALL") in v5.16.

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -316,6 +316,7 @@ config DEBUG_INFO_BTF
> 	bool "Generate BTF typeinfo"
> 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
> 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
> +	depends on BPF_SYSCALL
> 	help
> 	  Generate deduplicated BTF type information from DWARF debug info.
> 	  Turning this on expects presence of pahole tool, which will convert

I wanted to run pahole on a kernel object file, but was greeted by an
error message:

     libbpf: failed to find '.BTF' ELF section in <foo>.o

Then I discovered I could not enable CONFIG_DEBUG_INFO_BTF without also
enabling BPF_SYSCALL, which looks totally unrelated to me.  So yes,
there seems to be a use case for BTF without enabling the BPF subsystem.

Thanks!

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

