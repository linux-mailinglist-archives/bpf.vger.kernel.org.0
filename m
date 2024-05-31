Return-Path: <bpf+bounces-31065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18738D6964
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 21:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F571F26805
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7480045;
	Fri, 31 May 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVR4I1ga"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B04653C
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182380; cv=none; b=cGPZE+x903pqgXjfp7JZOhShyFELsTYaH7Vu2kdDoK/WwI1TD9+bMUNkD2XATi4Sc7akrwpOz80dg9Gwrg4km/ZMuvIJiyeCC5oswEWyrLwnCIlPzTeVrjYRgWOzNraRqPZRlOo8JbFkEi7iDCq9U2LrpxcqJPpckdWK/kaOubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182380; c=relaxed/simple;
	bh=6lnOiZ2ZynCn9jFifIhFEc22dKxCJC7SqVq3y9BLTjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBrFekADoJ9d48j1yU/5qgE5WQalE4zQT+SHFnrEQ2QO9vDRm/sE85nsbLSUuZa/ds671LUChQhbu8KqeR0U1Tx/5W2B6hNjL0/AnpQvVtjkihbRagsqoYauvtLH9XwOlzR9O9nik1Pyn/rP2pLhDdSEfmE9wlj7W8VCPU8yXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVR4I1ga; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c1e6eadb54so705707a91.3
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717182378; x=1717787178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35vjsfkgaBlEO0azGL4Gipxm7cC7eiYiY+kG8/Jg/5s=;
        b=aVR4I1gaQmo1e3Q7C29pPFlLRKHIDvzNM8QRgW88uQo4T4/TmrqSt0XYOfRsZBgEMG
         7FB1i0dZbKN90l8kUQUaZTTY094bjxEIZVjVhTuOMqAzQoG3Tdxa818GvYfCyxsz4jAM
         Lt9U6qM9DbWJc+dqq8IIyYZOybKs8FxI8zX4wqvtrF+mVu6clISd581gzzE0vrByfUBH
         8YjHfCuuYGKJn25Y5lxBRSKjwTwuzOm9So3g8lUPyT/GU+KYVh49s4QY6Cw90wTWWpeG
         8Xui8+8k1fWq4Uin4vIotyhxD4EBibanI0KPyW0HMqcF/LKeMBa+5CpLpbIXxL7hNb5A
         zWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717182378; x=1717787178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35vjsfkgaBlEO0azGL4Gipxm7cC7eiYiY+kG8/Jg/5s=;
        b=U8zbACiHLeFWaaJ4jgMhzBr6wAPUXQyY1t10eny0l9dJAFX3J1AADUx3IpYakK4HgF
         r1jxYyMt/iVWuGarUsGXzKsR6tyq867FPhkOOF3Qyppp+66+CS6UrC8xQuh5nm4X0QrY
         DPHzcGy81yA6w2D3fBrUfrxW8Lq//4mSsREz/0ZBaGCHHcAOtGZhp2IO70eZw2P7S8Qx
         rPMp0stqKL8W1ojHgrtwuIkCMaTsTj7PoK92QuawjJyIJVGoo7X8sUsbx35JsvsVjntU
         m6yvxc2eGlgU/51lpjryygmEdPgUNUruNpZQZBHF1iwgs9FxuAQVeB7tomDtq/WOqyz3
         kn1w==
X-Forwarded-Encrypted: i=1; AJvYcCVHVchVXH8IELL3sHH/1Oj968CkVCEZlvX4kXuW5P8SZohUHHJd+ZPum8veTTZQJ+jCf5fueh0AbvGttctwirvZkhdv
X-Gm-Message-State: AOJu0Yy4NuFdu80a/8QhYM8MLUPZaB2uQMj5YtUKhIDhTfOEOzgtWkZc
	BGUNTz4L0Nzzey+VyDzsWp90oyLKyJN39rkhgVaOCtI6S3RlaJpuJCgr50DoUaeXOoWla0WWZoY
	yXxKLdY3VdcMJYN8KjCZ+XtWg3JM=
X-Google-Smtp-Source: AGHT+IE1nOdnt8XNIRaee1sJThEdS9hw8fejSz1Br0fO6cgY2+wHhaQnxHJs5s1irtzRIfQmf30QEdxm+lfFa1PZoSg=
X-Received: by 2002:a17:90b:352:b0:2ac:9baf:25b5 with SMTP id
 98e67ed59e1d1-2c1dc588848mr2985548a91.25.1717182378184; Fri, 31 May 2024
 12:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122408.3154936-1-alan.maguire@oracle.com> <20240528122408.3154936-10-alan.maguire@oracle.com>
In-Reply-To: <20240528122408.3154936-10-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 May 2024 12:06:05 -0700
Message-ID: <CAEf4Bzbgie89A+j3NeFNDor+_AN84YO=f-f+3ekjauxfL=KZ5g@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 9/9] kbuild,bpf: add module-specific pahole
 flags for distilled base BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 5:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Support creation of module BTF along with distilled base BTF;
> the latter is stored in a .BTF.base ELF section and supplements
> split BTF references to base BTF with information about base types,
> allowing for later relocation of split BTF with a (possibly
> changed) base.  resolve_btfids detects the presence of a .BTF.base
> section and will use it instead of the base BTF it is passed in
> BTF id resolution.
>
> Modules will be built with a distilled .BTF.base section for external
> module build, i.e.
>
> make -C. -M=3Dpath2/module
>
> ...while in-tree module build as part of a normal kernel build will
> not generate distilled base BTF; this is because in-tree modules
> change with the kernel and do not require BTF relocation for the
> running vmlinux.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  scripts/Makefile.btf      | 5 +++++
>  scripts/Makefile.modfinal | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index bca8a8f26ea4..191b4903e864 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -21,8 +21,13 @@ else
>  # Switch to using --btf_features for v1.26 and later.
>  pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j --btf_features=
=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consisten=
t_func
>
> +ifneq ($(KBUILD_EXTMOD),)
> +module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=3D --btf_featu=
res=3Ddistilled_base

Remind me, please. What's the state of pahole patches? Are they
waiting on these libbpf changes to land first, right?

> +endif
> +
>  endif
>
>  pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_exclu=
de=3Drust
>
>  export PAHOLE_FLAGS :=3D $(pahole-flags-y)
> +export MODULE_PAHOLE_FLAGS :=3D $(module-pahole-flags-y)
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 79fcf2731686..6d2b8da98ee5 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -39,7 +39,7 @@ quiet_cmd_btf_ko =3D BTF [M] $@
>         if [ ! -f vmlinux ]; then                                       \
>                 printf "Skipping BTF generation for %s due to unavailabil=
ity of vmlinux\n" $@ 1>&2; \
>         else                                                            \
> -               LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) =
--btf_base vmlinux $@; \
> +               LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) =
$(MODULE_PAHOLE_FLAGS) --btf_base vmlinux $@; \
>                 $(RESOLVE_BTFIDS) -b vmlinux $@;                        \
>         fi;
>
> --
> 2.31.1
>

