Return-Path: <bpf+bounces-43765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657DA9B9844
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C241C21AF3
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05F51CEAA0;
	Fri,  1 Nov 2024 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lvd+EEKa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984F37B
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488618; cv=none; b=C24Nblk32E+wDLMNI6obpy61lgpBDGSzn4z/0yCUrfqgp1n+NRA2XXp8zL5dj9TAMUdhu88kztgnLREj1jiQkBPk96h6OpxdgFpm9AeifhlDRNwJ/IuyPlKcuh4btdPl0VmnWAC2jieAlzejXb9xqr40kWgZiA1EWKz7ul8976A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488618; c=relaxed/simple;
	bh=/ejz6dhntvu5d/LgrI0Y9Bx5HKCJ8QdebT0Mafewd0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLDgdlUFkDHccqcRC/InQF0rKsTfkQ3TwSnOF2w5qlFZBwDL9bFasfOD6vrYx84/Z8GBJFdMwNEhMGDkBpfBSH9zA1pcjwCbQgkKY3xnjdD1IMi5Z947MGMN1zv+e18wngmg8z/DqFiDyTXO9RemGSbBlNrDTuqScmv3lCQutTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lvd+EEKa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21116b187c4so13103105ad.3
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730488616; x=1731093416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrfeQyjGPESQF3M5uHaDCKMJtRpp3W77bgj+7MXQqhc=;
        b=Lvd+EEKaNDDCAFwkfwlHmHdprGFBTTwCgcayK9N3A5dUj+v3oOzS3a9mECpQVfgdhU
         gnKBqmTTKWgGoU23zyhvlcx6w1KBjN5rKIwUZhfelW1rPetF7JZzyA1RBcCdTMLGu3gT
         AaHrHTneG1d/5XpyF5USrLiOKqRGO7VY7Lauj+0VuKodJr7QOH9T1ZJxbZLj8k04TOIC
         J12oN76i004y2C7L16MafiQdLFK8axy2dQDB/zNB9IlknD+F8WfHABu+ThzS8Tm9/u4m
         AaoJtvTpbR68qkW/a0sjmtbBL9BcQd2kUYk9zjLjEapr41wKWEP4rW5gTwlmPCkpUBp4
         +O1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488616; x=1731093416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrfeQyjGPESQF3M5uHaDCKMJtRpp3W77bgj+7MXQqhc=;
        b=n8nrzGnMZ4/Q3cnOyjIUzCadqSww3ofgcIgX+c8xe+TH1ExYEKVqVsb6Fzh5qMu0tN
         gVXcuzREQC1VuARI1UYddFBWxrMaarJYIo6lWuyrWY096HEjqDcUsiUDAi2skOEGpu1P
         YdnxYnYs/rBTfII0FpY5T54FvVjQnS7iX7f5S/IMfHPNXdDUlTTmJw5mZGo0BbSEihfm
         Qvx0BeNcJUJNhRgRrzccd3tkASz412Ok/SFg13xgkJg1t3Da8Jh6H650nLZ1nSoR5t7P
         ptBhCUFpiXfgoz82EjyiEDC7CJInSe/OuieHeuAHk+ihQR2HtftQJl15utC2xLJZm/DY
         j73g==
X-Gm-Message-State: AOJu0YwY33OtuRV8HbkSW6ZFdRbkhL+Pj/+07piJPn0zz+alcwoPhQgt
	jvV29C2zDCLwXX1UjHzAwWyge+n0pGNEADEE9qZCfLBvxSyxfmqC6EQs5HW6h3mGqhZfCJ1v79O
	xeKBpN2bKqxBjkZg92UG7NbR7bYo=
X-Google-Smtp-Source: AGHT+IFXOwcmWdrXpICJC+YfFwR35QyHYsseT91vDTLGi6RmYjqG9yx0HhagE5ksZfGFVPt0qM9xaJHcb2DnKRuslBE=
X-Received: by 2002:a17:902:e84f:b0:20b:6d82:acb with SMTP id
 d9443c01a7336-2111af5afd1mr58435785ad.23.1730488615995; Fri, 01 Nov 2024
 12:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101000017.3424165-1-memxor@gmail.com> <20241101000017.3424165-2-memxor@gmail.com>
In-Reply-To: <20241101000017.3424165-2-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 12:16:44 -0700
Message-ID: <CAEf4BzaS9+Zs7cRKXPxD1zxNu4DLQw1VmPbJ4_cUMrSfc0R7sg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Juri Lelli <juri.lelli@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <olsajiri@gmail.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 5:00=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Arguments to a raw tracepoint are tagged as trusted, which carries the
> semantics that the pointer will be non-NULL.  However, in certain cases,
> a raw tracepoint argument may end up being NULL More context about this
> issue is available in [0].
>
> Thus, there is a discrepancy between the reality, that raw_tp arguments
> can actually be NULL, and the verifier's knowledge, that they are never
> NULL, causing explicit NULL checks to be deleted, and accesses to such
> pointers potentially crashing the kernel.
>
> To fix this, mark raw_tp arguments as PTR_MAYBE_NULL, and then special
> case the dereference and pointer arithmetic to permit it, and allow
> passing them into helpers/kfuncs; these exceptions are made for raw_tp
> programs only. Ensure that we don't do this when ref_obj_id > 0, as in
> that case this is an acquired object and doesn't need such adjustment.
>
> The reason we do mask_raw_tp_trusted_reg logic is because other will
> recheck in places whether the register is a trusted_reg, and then
> consider our register as untrusted when detecting the presence of the
> PTR_MAYBE_NULL flag.
>
> To allow safe dereference, we enable PROBE_MEM marking when we see loads
> into trusted pointers with PTR_MAYBE_NULL.
>
> While trusted raw_tp arguments can also be passed into helpers or kfuncs
> where such broken assumption may cause issues, a future patch set will
> tackle their case separately, as PTR_TO_BTF_ID (without PTR_TRUSTED) can
> already be passed into helpers and causes similar problems. Thus, they
> are left alone for now.
>
> It is possible that these checks also permit passing non-raw_tp args
> that are trusted PTR_TO_BTF_ID with null marking. In such a case,
> allowing dereference when pointer is NULL expands allowed behavior, so
> won't regress existing programs, and the case of passing these into
> helpers is the same as above and will be dealt with later.
>
> Also update the failure case in tp_btf_nullable selftest to capture the
> new behavior, as the verifier will no longer cause an error when
> directly dereference a raw tracepoint argument marked as __nullable.
>
>   [0]: https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt14gen=
4.remote.csb
>
> Reported-by: Juri Lelli <juri.lelli@redhat.com>
> Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TRUS=
TED_ARGS kfuncs")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h                           |  6 ++
>  kernel/bpf/btf.c                              |  5 +-
>  kernel/bpf/verifier.c                         | 75 +++++++++++++++++--
>  .../bpf/progs/test_tp_btf_nullable.c          |  6 +-
>  4 files changed, 83 insertions(+), 9 deletions(-)
>

[...]

> @@ -6693,7 +6709,21 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
>
>         if (ret < 0)
>                 return ret;
> -
> +       /* For raw_tp progs, we allow dereference of PTR_MAYBE_NULL
> +        * trusted PTR_TO_BTF_ID, these are the ones that are possibly
> +        * arguments to the raw_tp. Since internal checks in for trusted
> +        * reg in check_ptr_to_btf_access would consider PTR_MAYBE_NULL
> +        * modifier as problematic, mask it out temporarily for the
> +        * check. Don't apply this to pointers with ref_obj_id > 0, as
> +        * those won't be raw_tp args.
> +        *
> +        * We may end up applying this relaxation to other trusted
> +        * PTR_TO_BTF_ID with maybe null flag, since we cannot
> +        * distinguish PTR_MAYBE_NULL tagged for arguments vs normal
> +        * tagging, but that should expand allowed behavior, and not
> +        * cause regression for existing behavior.
> +        */

Yeah, I'm not sure why this has to be raw tp-specific?.. What's wrong
with the same behavior for BPF iterator programs, for example?

It seems nicer if we can avoid this temporary masking and instead
support this as a generic functionality? Or are there complications?

> +       mask =3D mask_raw_tp_reg(env, reg);
>         if (ret !=3D PTR_TO_BTF_ID) {
>                 /* just mark; */
>
> @@ -6754,8 +6784,13 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
>                 clear_trusted_flags(&flag);
>         }
>
> -       if (atype =3D=3D BPF_READ && value_regno >=3D 0)
> +       if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
>                 mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, bt=
f_id, flag);
> +               /* We've assigned a new type to regno, so don't undo mask=
ing. */
> +               if (regno =3D=3D value_regno)
> +                       mask =3D false;
> +       }
> +       unmask_raw_tp_reg(reg, mask);
>
>         return 0;
>  }

[...]

