Return-Path: <bpf+bounces-43989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8099BC355
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 03:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC7A282D63
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8915542AAF;
	Tue,  5 Nov 2024 02:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPVnwIrR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660284A0A
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730774879; cv=none; b=G9Q00Z/axhlaaT//6Z7jgESBA8wZw6ZXFpggmMjhlumaev3HduYGSy6FcqPmxYbKjbTLXO+7Rnunh2OQr3OXRQ5Le3YSbOamU8bPYKxZ+7LLS49YkuCZCo+exC76fVCdMHdHkiCLMN26QTN5d40GRbcVPldo1CG0kOXz6HcuKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730774879; c=relaxed/simple;
	bh=szHT7iwedjg1MpUpDy4pAPAgz6+XDSwIZaEFYDX+ihE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9PYGsAMYcOwV2augIBphSNCPZBKjAj/CRbxbVUzITs6PYgOVrdEUof2SvWFBTOOrp0cVoAbmSYKkHL/ezRo5ten+8zQOKwIMtpTsg4YY/eRoYh4SMvQvNCqdlbSx++XeHbITQ5yK4lZu/sQNRjBcYq5cO4A2lzwwWrUhKkFASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPVnwIrR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso40585305e9.0
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 18:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730774876; x=1731379676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELfXUT7erbRHfZbq5ySamTTGRJvsa/q1aFZW0UcucIc=;
        b=bPVnwIrR/Fc8xjyySriOL6IFcBcZXCCf8gblh7hvne4SuWYCWcNLYo5KTdi6NQs6y4
         wdfMMep9mZYtLWE3IoJxqtvM5gdw/2hQm99Go7qGdi/nJh0ff6ZmLBFSTv+De48fo88H
         +8LW8rGT0tTdZnrZvaLue2taN9BahNgTlf/6H6RdFE3v0jPUNpoHBZ7pWHOIm7fMtkQS
         9vkLONsU6DsSagcOVsC9SF9XpTxOIMWCYFOX6fLyKKfV34sX/79qIU8LMn20dl4L2IW6
         RKkGMIBIvo2NeSCHpKlkbEf5rlpF9QB0Z4EjNqvFgA5YJg2fyGt72+sjvCzRpXDRyucg
         yKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730774876; x=1731379676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELfXUT7erbRHfZbq5ySamTTGRJvsa/q1aFZW0UcucIc=;
        b=rIWHf704b7VgVfTo/NrR7fWIMsdNZHHIuW6FpPFXS90aMjkFKZzSjAzLoIv6hSpMOW
         bIsoRUBRzLbxPaMO10QfRAKhYrMuDpb/H2Vt9gBS/LevOXT9+RfnoxWTlVM+rU+C/Q3W
         OQz9l2tgnefjMxEOU9lzE5COfZpeYPy9zMGy10KBvXaydsJ34psS+9j+BD2cd8eNcaWo
         YSVUBIdQ9o0wlDHESRXzDeUYwvwF1gGSCWigAOHiaMNzkWZIXm1T39tb+xmvCk9cGdwD
         akGfHGfAhMMArXreYeE6kgWEucrUcjP43zCfvagxAm2WkZoj8m9B0lU9YrXxyhCYT8Xt
         VMLw==
X-Gm-Message-State: AOJu0YyBL1X9w3IDNsd4S9eCUrtchUJIq2KA4E1c5eIkLFvnuHrKqacA
	+vtD66K5sQhQZAtCbaMgXF/dkCfOwgU3RtwRNAolGgiXrNfsMjidGnDiZ+VBDdDvzyS5knwOgco
	aD313Rn3aBg62gwTUbJNkvE4sBQM=
X-Google-Smtp-Source: AGHT+IHwNzSf3d/S/Yqoe7RB127y5huxxqSakD+dmZHe7Jeo04xrR+vImv8Qk7vxD22anwtfRexnSgfmeYOYTo3P2t4=
X-Received: by 2002:a5d:50cf:0:b0:37d:45ab:4241 with SMTP id
 ffacd0b85a97d-380610f2e8emr24814027f8f.12.1730774875453; Mon, 04 Nov 2024
 18:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev> <20241104193510.3243093-1-yonghong.song@linux.dev>
In-Reply-To: <20241104193510.3243093-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Nov 2024 18:47:44 -0800
Message-ID: <CAADnVQK-dCC68pPbrt2DLY5022V64Kget7xyShHqRoK+c5ZTiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 03/10] bpf: Allow private stack to have each
 subprog having stack size of 512 bytes
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 11:35=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
> @@ -6070,11 +6105,23 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>                         depth);
>                 return -EACCES;
>         }
> -       depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
> +       subprog_depth =3D round_up_stack_depth(env, subprog[idx].stack_de=
pth);
> +       depth +=3D subprog_depth;
>         if (depth > MAX_BPF_STACK && !*subtree_depth) {
>                 *subtree_depth =3D depth;
>                 *depth_frame =3D frame + 1;
>         }
> +       if (priv_stack_supported !=3D NO_PRIV_STACK) {
> +               if (!subprog[idx].use_priv_stack) {
> +                       if (subprog_depth > MAX_BPF_STACK) {
> +                               verbose(env, "stack size of subprog %d is=
 %d. Too large\n",
> +                                       idx, subprog_depth);
> +                               return -EACCES;
> +                       }
> +                       if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE)
> +                               subprog[idx].use_priv_stack =3D true;
> +               }
> +       }

Hold on. If I'm reading this correctly this adaptive priv stack
concept will make some subprogs with stack >=3D 64 to use priv_stack
while other subprogs will still use normal stack?
Same for the main prog. It may or may not use priv stack ?

I guess this is ok-ish, but needs to be clearly explained in comments
and commit log.
My first reaction to such adaptive concept was negative, since
such "random" mix of priv stack in some subprogs makes
the whole thing pretty hard to reason about it,
but I guess it's valid to use normal stack when stack usage
is small. No need to penalize every subprog.

I wonder what others think about it.

Also it would be cleaner to rewrite above as:
if (subprog_depth > MAX_BPF_STACK) {
   verbose();
   return -EACCESS;
}
if (priv_stack_supported =3D=3D PRIV_STACK_ADAPTIVE &&
    subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE)
   subprog[idx].use_priv_stack =3D true;

less indent and easier to read.

