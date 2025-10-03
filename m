Return-Path: <bpf+bounces-70326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F41BB7DF6
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93D6A4EEA7B
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760792DC774;
	Fri,  3 Oct 2025 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvEL4bxr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB12DA777
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515523; cv=none; b=cQiZU2AKsvWbwhoWu8bbVvZ9MKd/pngd6/AvHzhZGikWdNgzWvkrpHNf+hHvpqyZ7S9YToSkxJLetWIq1rhnTnnv1gT86ugpsbORy7Winj1BQFmrZlbSyu+mNnRvHww9G1BvIMHIyFDMG34GmrdaaiZJwFqsHsLtPPCoWlxWCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515523; c=relaxed/simple;
	bh=XpCWoVaLalwdh4NzzhEJKKvH+JNe5DaZYql7nixRmhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuiiUUYTYq4mLWrSeRxN/YCORCll2nNLz3hM2ASUsrzqr17heBuQr9P9PBOUTicnf9joN0w7dPXvwA0sXaBgy0oQ7/u8DudEoQy86ZQ1ISKRGpc5hrwmgXAgtkmsmN6F28N5bTeQAQlWHgQ2wKpQJB/HCJjNQpVm2ZZdhdS/+co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvEL4bxr; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso1756371a12.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 11:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759515521; x=1760120321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibXxNoWNX3k2PX9k7C9GKNgYUIGTs3LyleFn6WN/vtI=;
        b=mvEL4bxrU1HoC6gDV50e7IMoVrbBULw+R5losnN3yF/FUu3lkU2QgCZhXeOqbpWWLj
         K9PmXynRTXMdBdXnD89VbZlO3oJi34yna6jdrom6No/e7EvnBZPJ5v38c6psPpJVGXSg
         t6iMk+shRar9TBTm2JR1yNX+DBPf2sjzur5Le9IjAoDAv3wU50LURPM+KmcAsM+ucvKN
         rfoKzRdazthEYFA8mxNCBvRQrciEwsumab5siiBHrC3T6FX8eXCQOCKbjNHySPt+zDju
         s9+eRWVHzSVHFB4Lcwj8s6vljltA4rfN0HC0RuUIzqTnVEIl0wI/yj4E/9rAtPTxU/Na
         X6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515521; x=1760120321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibXxNoWNX3k2PX9k7C9GKNgYUIGTs3LyleFn6WN/vtI=;
        b=p5fEaLpr0pmy0O+VRg8njbIN9kL/SgYfzxEHMNQOU+UB6VJlsbh9t3QRDKjbfowoqU
         2YnyRu/pWM37dL7jca/w1EAhIh4clV98bUm6dwwQqO3J7uIeYWyIbxk8d1TiCtUDIxW7
         g2vk/8rhjsyS4xjajniEykC4Imz0U35awT4jAjPqCP9SiyCQr+P3aTloXmIBpl8JdeLR
         5F6huwVN1x2VOqtpVSpoV78+EdiQKLJQDMqgsclsxn+WHtbBwrRDdy5f71HeVwjqUPMr
         EMmPGn6LCHQD/KZQJi7BauoqwD1jDN+fzBuFTGpUuiq5A8/az/bGwRgCdWY2GxqvnwRv
         M1Ow==
X-Gm-Message-State: AOJu0YxIlPHpaDB6GDwgJjvB0fDI7Gsp0yRRh+HkOB5INXXEcRsAuOvb
	3FG28A9fOs2eEgpRo4ZEeXxu27BtmYQkXvD7o/im++XBT0ofLP2irN8kKbZPtAm3Yjk7RGN58rc
	cdyzhR3aThZNB7R8piQrZLg671j+0HhE=
X-Gm-Gg: ASbGnct5+wQOzSifhXL4CgZSbXE6VNZ6vRpHCZahPXbOA6TlsxGF7riRcOz+ogmx3bI
	iR24umT+kmSsUB6L1NTAPfz7uhLTSKPDARhNlQshSBGMMUDXDt+obeWXzDqFGQd+NwUoBQad0mB
	ADxG6k+TBoXgP1CTxmZQnAYXUm2XcKkAPF3p+P6G8bA/ZPkgraEY/+KINk5YFYhhNSze5byudVd
	4VoOPPUxp445akdCAFg7jDAMknCUlc3Y8dwQMjzttG37V0=
X-Google-Smtp-Source: AGHT+IFOpZqnEs2JR7EuefoWKupI6tTBsHbCyWbNfzDvrNysdMG2GZViSlFSGqtEfZUP+3470H6Hp5wbFEQIYj5xbCg=
X-Received: by 2002:a17:90b:1b50:b0:32e:9da9:3e60 with SMTP id
 98e67ed59e1d1-339c28071dcmr4319719a91.36.1759515520844; Fri, 03 Oct 2025
 11:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com> <20251003160416.585080-6-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251003160416.585080-6-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Oct 2025 11:18:26 -0700
X-Gm-Features: AS18NWBEkMyWKhDFI47WGhZd3m_jutW6DVzv8HryH5IGgxy12eGA5qMuvjDgu-c
Message-ID: <CAEf4BzY6RKmsx2qOVkGU2jLNY3iUXhwCwbKF+=BbheSvNGMGrA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 05/10] bpf: verifier: centralize const dynptr check
 in unmark_stack_slots_dynptr()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:04=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Move the const dynptr check into unmark_stack_slots_dynptr() so callers
> don=E2=80=99t have to duplicate it. This puts the validation next to the =
code
> that manipulates dynptr stack slots and allows upcoming changes to reuse
> it directly.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/verifier.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e892df386eed..0b4ea18584bb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -812,6 +812,10 @@ static int unmark_stack_slots_dynptr(struct bpf_veri=
fier_env *env, struct bpf_re
>         struct bpf_func_state *state =3D func(env, reg);
>         int spi, ref_obj_id, i;
>
> +       if (reg->type =3D=3D CONST_PTR_TO_DYNPTR) {
> +               verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released=
");
> +               return -EFAULT;
> +       }

LGTM, but perhaps move that comment that is talking about
CONST_PTR_TO_DYNPTR here (and adjust it)

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>         spi =3D dynptr_get_spi(env, reg);
>         if (spi < 0)
>                 return spi;
> @@ -11487,10 +11491,6 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>                  * is safe to do directly.
>                  */
>                 if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - =
BPF_REG_1])) {
> -                       if (regs[meta.release_regno].type =3D=3D CONST_PT=
R_TO_DYNPTR) {
> -                               verifier_bug(env, "CONST_PTR_TO_DYNPTR ca=
nnot be released");
> -                               return -EFAULT;
> -                       }
>                         err =3D unmark_stack_slots_dynptr(env, &regs[meta=
.release_regno]);
>                 } else if (func_id =3D=3D BPF_FUNC_kptr_xchg && meta.ref_=
obj_id) {
>                         u32 ref_obj_id =3D meta.ref_obj_id;
> --
> 2.51.0
>

