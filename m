Return-Path: <bpf+bounces-70529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BA6BC281A
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 21:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF7B19A2877
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 19:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E322F389;
	Tue,  7 Oct 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpb7RWju"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DDC1C5F23
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865211; cv=none; b=r8I5ptT9Q8v6kUGwp98N8cSdyozYx2DBfxIWULEXiSs0K/IN4dkfqE9jpU5KgtbLiQNfmfPgfqdhFBP6CnzY8HilEHwF3efI1sry4iUm3OdHXIBxRN4khA3GBol2VYM1UhpXWQvJKVnLnLLzI3aPgxZk7Qkc+7zoQKSNUI5+kCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865211; c=relaxed/simple;
	bh=Mi6Vbjm7Iid4NFhZb4q/gBDOU9qvvDxC6+oTtaj6Hoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mm3WQjfsqSpJUYH8MPcfhAutmRAlXtjEbXNNrhD+cV9jiVNrPonQevvXJbeNiM6IeOA7MC/dyRW8bLlpkHzeGNlBjoST3jKaHcrZwprWqJvq1BLFDyQXSupMhapbc8zndUZImUA+JN8J4nHL5juMTkoA5bsppy3f3DrYtbdVOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpb7RWju; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b4f323cf89bso287370166b.2
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759865208; x=1760470008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fDPiTVesHzW0Mznm6dhS+pQ+Go7uie9wNfKlP+bUmUg=;
        b=bpb7RWjuO+8FAIN8BEz0CrEkgFTF22RZ6vVk18kpVoLh82vHrNzF6UD+Fenqr8Cv/d
         fE+KpjoRNuqYXwOq1hSMAPituITa4t+CdKRMhw1V8E07omglAD/ZF6TzY5/K+Z1w0a2j
         uNivqnE8bnFyw75oOQKU2nrpfvm9BYzAlKNruELlkF0/RgI/+eR1eVNY2xeKUUnOTYMs
         ENdt2CevVE5r48O6awd+kZjIpj2UP1VKV2Z5+UR8d8m2DaQ9yItVLEFcQFQl8jn2vV9i
         XAmwHc/7IMFEJ1mzofZDA6G1gLf2jC5DEnqnEJA9Tiifmz6HDAvUTere6Xuoh4UwgOkb
         tVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759865208; x=1760470008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDPiTVesHzW0Mznm6dhS+pQ+Go7uie9wNfKlP+bUmUg=;
        b=XHnZUMRrTZhctjc693B8iM0YXXAbIboXfqw+KOaiowYwBLNNLcFtp3zviZuvietqyc
         4kctLzOI/iyLdjDavcwkXd5TcqmKVYlVkBwP/Vau+lUGZ5ETEHvsQAyBPJtMm8jcCjKv
         MaOqpFxYkSVxJX9tE2fKPX1+4ygJ/nhC5AZlPkQ1ZTFy4l6p/v0mYNgXkExa4o1+XhvR
         8Io9lkRg4aAefPOPzDSu4vC28DUD7lJFnCIgAc9Mk7PmOy13AaMDjsUth12FAll50ahj
         9TKoIxUyrh1AAXS4FAGD7x1xgFnGJ9sbVAzujcFPCrLYzO19gj8OOijGbL8PDaCun0+4
         iR1w==
X-Gm-Message-State: AOJu0Yz+iNcIK44lxm3Y+sSVSDgPCmKE6Vl1fFMT+aqf9Z9ayi2/+WUI
	EKZo4BVIPlj/y+v8aM9u9/4K+sKVAOpgExlm7/l2Qc6Ac0KPQJkcVrJUZpR7ZzDtwQBXmgxzOiZ
	ImIAXNfQMs/6AD1I1cY1ApE+uQ5bdK4g=
X-Gm-Gg: ASbGncsdcy5Wf/4Hrn6hyRE2SkYVzXXuWklm7APxkK2Ivw0JbwPhT5og2qlOesx0+rJ
	ReEDjzYmEgKvX9EBOokV96xTf55wRL4hmI94OGLvebk8Qpp5jZ2KjyivdlB4L7q3IXSPBr527Fk
	agtf66F8KONWbXf1I0uKCkwi2Me2mZMx2CQDCMpujMdZDIccdVJt2sJINWsbtAJNqa8/cvi8xb7
	gURUMNEAvkfTbLUb1lpxszC7gSPAaWj9LjcLaE2sZUlekY/hylpE7yBM1tBMQ+dn81oBebXeJY+
	KtgQjRXVX0AsmMahCJGG2A==
X-Google-Smtp-Source: AGHT+IH0q6th/LwGv6OJtqxDWsDZ87vTjyUgcfS+1t+tsLbyydsZo7yXSBt9R91/MjE9jgUm8SvpSUibzSxUotsJWBY=
X-Received: by 2002:a17:907:9411:b0:b40:6d68:34a4 with SMTP id
 a640c23a62f3a-b50a9d700b5mr91990866b.2.1759865208416; Tue, 07 Oct 2025
 12:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007014310.2889183-1-memxor@gmail.com> <20251007014310.2889183-3-memxor@gmail.com>
 <5ab5aa0dd0a769cfcee7fe9407f95d3956947794.camel@gmail.com>
In-Reply-To: <5ab5aa0dd0a769cfcee7fe9407f95d3956947794.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 7 Oct 2025 21:26:10 +0200
X-Gm-Features: AS18NWBaxywSdyZ58OMsqibVIdhmQtUkQf7YQtCd_BuHL4rDlSgy7RGRO2Qs5ms
Message-ID: <CAP01T77cYTG8v8LrviWFcptdTh5XanqSvUp5Wx9Hvf-LUGQzBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Fix GFP flags for non-sleepable
 async callbacks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 21:14, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Tue, 2025-10-07 at 01:43 +0000, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > @@ -11460,10 +11460,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                       return -EINVAL;
> >               }
> >
> > -             if (in_sleepable(env) && is_storage_get_function(func_id))
> > +             if (is_storage_get_function(func_id))
> >                       env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
> >       }
> >
> > +     /*
> > +      * Non-sleepable contexts in sleepable programs (e.g., timer callbacks)
> > +      * are atomic and must use GFP_ATOMIC for storage_get helpers.
> > +      */
> > +     if (!in_sleepable(env) && is_storage_get_function(func_id))
> > +             env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
> > +
>
> Note this discussion:
> https://lore.kernel.org/bpf/8e1e6e4e3ae2eb9454a37613f30d883d3f4a7270.camel@gmail.com/
>
> It appears there is already a need to have a flag in struct
> subprog_info, indicating whether subprogram might run in a sleepable
> context. Maybe add this flag and remove .storage_get_func_atomic
> altogether? (And check subprog_info in the do_misc_fixups()).

Ok, I can add a subprog field and check it that way.

>
> >       meta.func_id = func_id;
> >       /* check args */
> >       for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
>
> [...]

