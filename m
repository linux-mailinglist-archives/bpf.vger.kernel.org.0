Return-Path: <bpf+bounces-32099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F9F90777C
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 17:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E200E289551
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9383C12EBE6;
	Thu, 13 Jun 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Llmz6kOs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B10F51004;
	Thu, 13 Jun 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293789; cv=none; b=DmV110gj+2FsOJ/XQclabv//xJXplWlYcLAyyhrAQ82YHYE2JtvRWOoUWRaiEafkPbgUO4v+4nf95rZzK4DH4IO6GBtf0StbMQzjvQs6o7zME0Xee1JPdHioLBcLZyt+ejSP16Nq+pIIDXS0aFtUQiZEJi7WeEjj4THCyShbOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293789; c=relaxed/simple;
	bh=r1cTU3P1pKU5lWirze+ykbwtAK94FdUWSosPnjPLE3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjAmfF/vYcA4VnJ7/zLzMg/taX7AlLRdSnDw0rI+DGY7RbI7UP1HldkLbNGYQHJlDaU5aKG6CsC6mImddXiAzBkQvk7CF7CMlA9Mo2iWPUgKam3pK3/g7Pv3gBMABqYMCAgSSVBxbKfmXSVBP6TKkSkuL25J32qeUEHiFqCRqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Llmz6kOs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f27eed98aso1102786f8f.2;
        Thu, 13 Jun 2024 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718293786; x=1718898586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of2uE36aZkPjiXYatlQgio6U7y4rCrakY5ZH1BVVXyE=;
        b=Llmz6kOsnV8I8tjZD+P6ODzhxfKvvQoUN/rR8TUePMiXlkSB5vZvQm/pWvz4iS9eRp
         FtwUDA2EMe84xoxM4E/n4ET3l0oB4bIhUGG1LKJ2vo7ctbIl0+ghnbwjASpPvzwxkQLb
         y9EyG0tO0pU8hOz8UL4Bv9AyoU/b8lUkft4y5u/vBCotjX+cP9X0Kf4qzDMJ7X9drAUc
         ujmv43vH52zZaUiRuZU//Ip0r25t7tTqxk8P5WX5gkyTTvKzquw9rgB1KEMCcoWOJWsi
         7KQjHIjqAt4DWV9bqmEKwJrE8CoYFGQU8vhl48GjnW6WBtenDozoJfXYNSFB5mFJ1M1v
         b7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718293786; x=1718898586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Of2uE36aZkPjiXYatlQgio6U7y4rCrakY5ZH1BVVXyE=;
        b=t3tK25CgNt9S/9KrwwUrsT5aAKGB2sJbs2wo66J/OAVJkd8H2TqtRNIhcPDbK2J0iQ
         Nd2CFdCSVhrv/3u9N/esyIJNxzQ0uLsI+wHZMGnBTQGLczc5xUMFFiIafQvjCSDTxd3z
         51tMADrk1tlNDHU1ykhR1L+0vmgb0LVVSmX1MK1NwXAsBvxEg8J+AEgTMo+ZdWG8GF2t
         BlQuGsMpi/AczdzW1JVJ4GLFD+Ceuu4LJ96aYbZiZuxk3vLOrCWygdNZjIAC9erhn79r
         9SISSz4T0vQt9E979W7ZPKmvwum4Qfn/Qrc2qCfI5A2Hsy9LwyO0p4C50N2afFioBDkv
         Skbg==
X-Forwarded-Encrypted: i=1; AJvYcCVYdjphFeQE7NdVtg+sGACSFtSVD/T6zeK00cVpOX56x1BKSuogj3RceQuH8JHqYHixABCJQvUPjuR54qKRJwldo2daEv0nQkKNbjFqWYI6x8d4WKNdlbqaWOhE3HOkmJTF6e7/vxWzNEd1XdxVGXoE58+oKMTwwJYQ
X-Gm-Message-State: AOJu0Yxr1nGhrLydT+H3jbclT2UvTld6ArWx5Hsz0zYWyueNMnFoFcnA
	kJnD2LE042me58V4IayUQmyzv9JTsvCXNGaElhUsohdwL47r0VkwHXdE4NPbm//D3jksComeJ2K
	mzNYq/9L205WW5lHD36lbrRsu2hA=
X-Google-Smtp-Source: AGHT+IFWxJY1Fft6zcBJgGt05/5oovtE9hfTqkDMxDHAq69Sf+W0hk6DJbT/bMVYXcKWnyzBDFhUIyO/g2x2RwQ8eok=
X-Received: by 2002:adf:e606:0:b0:360:79de:4c32 with SMTP id
 ffacd0b85a97d-3607a72018emr75268f8f.7.1718293785789; Thu, 13 Jun 2024
 08:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613112520.1526350-1-maze@google.com> <bv44ythtmj5sh7uqoo6ydvsdae6r4lamrpkn4gn3n2wx4jebs7@ek3vf4o3m64r>
In-Reply-To: <bv44ythtmj5sh7uqoo6ydvsdae6r4lamrpkn4gn3n2wx4jebs7@ek3vf4o3m64r>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Jun 2024 08:49:34 -0700
Message-ID: <CAADnVQKee8cuxjg2cFGmzRMhpvLOiJnnKAXvJWLRBUYGhH=PPw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix UML x86_64 compile failure
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 8:30=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Thu, Jun 13, 2024 at 04:25:20AM GMT, Maciej =C5=BBenczykowski wrote:
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Fixes: 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper")
> > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > ---
> >  kernel/bpf/verifier.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 36ef8e96787e..7a354b1e6197 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20313,7 +20313,7 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
> >                       goto next_insn;
> >               }
> >
> > -#ifdef CONFIG_X86_64
> > +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> >               /* Implement bpf_get_smp_processor_id() inline. */
> >               if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
> >                   prog->jit_requested && bpf_jit_supports_percpu_insn()=
) {
>
> The patch needs a change description[1].
>
> Maybe something along the line of why pcpu_hot.cpu_number not accessible
> in User-mode Linux? (I don't know bpf_get_smp_processor_id() or UML that
> well, just suggesting possible change description)

+1


pw-bot: cr

