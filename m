Return-Path: <bpf+bounces-35087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8011B9378C1
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 15:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B891F222B2
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A3C143C45;
	Fri, 19 Jul 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvvuwG/c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CDB83A19;
	Fri, 19 Jul 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721397156; cv=none; b=FdYjXiOsqCzhIbc7v/oj0T3YUIdT1+Jzr0UyppjrUvXsaHehqIRs2+MOtHOyp5IFZNgE2MTEieDu3GQ4ENNnIOlTMHnQiW/CrAd1oPX24Oir4XgNteblcQzBMhrjm+Ory6TMc+ciB8pa9YiKM2NGr5Ti3X7c+2QbpWtZpYR08is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721397156; c=relaxed/simple;
	bh=5m/6tNBOY6VJGkhYsAlnvm2sT/AZ1AzuwTAgZlWDiw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX8c5JAG0vYIc4SVRZveqlK4hcuAxlhaFE50HX6YttyhsTk6+d4x0jipEInfaArw9gmFhHTaZA055u4i6zGMvn9xnoHd4tc58VLJ4VoX98ROm1hMioRqXFLstujVPN3Pal2qypXWXo8UanidG4/hGKavZAID4Tsa9GCnTRg+6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvvuwG/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89239C32782;
	Fri, 19 Jul 2024 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721397156;
	bh=5m/6tNBOY6VJGkhYsAlnvm2sT/AZ1AzuwTAgZlWDiw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvvuwG/cSLij6G6Tyyloq6vZOLDBPwlkLd5DCAmZYxPt88yRChye9N2ar/S/trx2P
	 v9WB4FfSbaOwMl0cMyrzNz2AYL+/8+TN6NbQw3GorJjYew/XCLo1AliytOAt1NgMUo
	 EgCW9QZoJFli5BFNZAxIwkR31ttRkPuXUWBXNI0HvTWKsug9stCwUelRDxItnE5JOz
	 4uBTJfLf6qKM4f487YjTxPLCf9fGSxMZO/0gJlSAY+hFDFhrE+1aablGlr3V2ZhTZJ
	 95PF7OnKTWnDg55ABCqRXvRm/N9f1hTkiN5TMww2wjMj607AqHTjsysxRUCI9prXTq
	 rHIsRUkW2MoYw==
Date: Fri, 19 Jul 2024 15:52:31 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH] hid: bpf: avoid building struct ops without JIT
Message-ID: <gf7t6iyj3ueewvbbmqo2ypzitiy6bvnzj2l6tgccvi22xe5fgm@xvlbq3vkndgr>
References: <20240719095117.3482509-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719095117.3482509-1-arnd@kernel.org>

On Jul 19 2024, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The module does not do anything when the JIT is disabled, but instead
> causes a warning:
> 
> In file included from include/linux/bpf_verifier.h:7,
>                  from drivers/hid/bpf/hid_bpf_struct_ops.c:10:
> drivers/hid/bpf/hid_bpf_struct_ops.c: In function 'hid_bpf_struct_ops_init':
> include/linux/bpf.h:1853:50: error: statement with no effect [-Werror=unused-value]
>  1853 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
>       |                                                  ^~~~~~~~~~~~~~~~
> drivers/hid/bpf/hid_bpf_struct_ops.c:305:16: note: in expansion of macro 'register_bpf_struct_ops'
>   305 |         return register_bpf_struct_ops(&bpf_hid_bpf_ops, hid_bpf_ops);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~
> 
> This could be avoided by making HID-BPF just depend on JIT, but that
> is probably not what we want here. Checking the other users of struct_ops,
> I see that those just leave out the struct_ops usage, so do the same here.

Actually, if we make the struct_ops part only depend on JIT HID-BPF is
kind of moot. All we could do is use HID-BPF to communicate with the
device, without getting any feedback, so nothing much more than what
hidraw provides.

The only "interesting" bit we could do is inject a new event on a device
as if it were originated from the device itself, but I really do not see
the point without the struct_ops hooks.

So I think struct_ops is now the base for HID-BPF, and if it's not
available, we should not have HID-BPF at all.

> 
> Fixes: ebc0d8093e8c ("HID: bpf: implement HID-BPF through bpf_struct_ops")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hid/bpf/Makefile           | 3 ++-
>  drivers/hid/bpf/hid_bpf_dispatch.h | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/bpf/Makefile b/drivers/hid/bpf/Makefile
> index d1f2b81788ca..7566be8eefba 100644
> --- a/drivers/hid/bpf/Makefile
> +++ b/drivers/hid/bpf/Makefile
> @@ -8,4 +8,5 @@ LIBBPF_INCLUDE = $(srctree)/tools/lib
>  obj-$(CONFIG_HID_BPF) += hid_bpf.o
>  CFLAGS_hid_bpf_dispatch.o += -I$(LIBBPF_INCLUDE)
>  CFLAGS_hid_bpf_jmp_table.o += -I$(LIBBPF_INCLUDE)

Unrelated to your patch, but looks like I forgot to remove that entry
from the Makefile now that hid_bpf_jmp_table.c is not available :)

Cheers,
Benjamin

> -hid_bpf-objs += hid_bpf_dispatch.o hid_bpf_struct_ops.o
> +hid_bpf-y += hid_bpf_dispatch.o
> +hid_bpf-$(CONFIG_BPF_JIT) += hid_bpf_struct_ops.o
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.h b/drivers/hid/bpf/hid_bpf_dispatch.h
> index 44c6ea22233f..577572f41454 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.h
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.h
> @@ -14,7 +14,13 @@ struct hid_bpf_ctx_kern {
>  struct hid_device *hid_get_device(unsigned int hid_id);
>  void hid_put_device(struct hid_device *hid);
>  int hid_bpf_allocate_event_data(struct hid_device *hdev);
> +#ifdef CONFIG_BPF_JIT
>  void __hid_bpf_ops_destroy_device(struct hid_device *hdev);
> +#else
> +static inline void __hid_bpf_ops_destroy_device(struct hid_device *hdev)
> +{
> +}
> +#endif
>  int hid_bpf_reconnect(struct hid_device *hdev);
>  
>  struct bpf_prog;
> -- 
> 2.39.2
> 

