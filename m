Return-Path: <bpf+bounces-28373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296298B8E2D
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 18:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAABD1F2215A
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 16:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C4412FF9B;
	Wed,  1 May 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ+Tj+9e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFFD12F378
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580890; cv=none; b=BnpQysUUyvvNoCyvUgHTPTGekyqX7/epRxZqLq98XZrr2g4V8GgLQAIp9vyrhZIvAhn15TZfIEEKy/iCQH1/MmMlcrxIayiQj/DZFx7oqnF1sdTyq1xGGLgTHTVA2Cp6sS+gTcuNma3YWAT3Ozc88tkDZrQ5NeAZ7hV0pD7HT88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580890; c=relaxed/simple;
	bh=Iv+l90f54I9fdk4Xi4a/kktc6fcFfO1PLlI0GSnpIx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A17xv7+MNybu6AGBFNnxPzF7OKm5WWoNAEkkQ43Ywz3XVLumbg+HSzzGQz+5Dh1B48a/6XG66S4JS9lS9rAmKhWW3ye5ESU2M/Oui2K9wEGn46+Cb1+brcJe7M1fnb04rNcynM+V3G3ykvXbOuCZBpYc3HQRkH/q7nPkgz6ASho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ+Tj+9e; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b2b02d4148so1375616a91.1
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714580888; x=1715185688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJJ/jHeU087S/X1BAT097bglao6JTBJ/hGhps/E7HEE=;
        b=RJ+Tj+9emhJwsPQdBI8pT2DvTSUWITjvDFgYiIp3HEphYNwwOQrFVDEbjxYvOAQAe5
         LV0UPBxz46gm3TZJIhDJj+o441xMviAVP2k+k4N314eS7OW2eKWDXCuWG4XqwMtyNIF/
         g3VeWAqJvaTKhZrxxG+ZnGvkC9B6+oAjnEFaIqGV3vo0st6IVWwH6E9nkLgbB3WrN8tR
         wddrucwaEY4ZQMOdERA3Mrffx5Y2tfawyLL8YFKy6DE6fFr+gba8gTohIvHVHNS9gudb
         L4DSslPOT+D6HMhTXNspUvvdPa+Wz9XwX96/iVtZ96WLZ5X/fwOyLw2gz7WYEhR2ZHv4
         2MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580888; x=1715185688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJJ/jHeU087S/X1BAT097bglao6JTBJ/hGhps/E7HEE=;
        b=HVZU9o0ghALqqmbasY/eUI3ipOLzLiH7COCtvwntDRdKsTa+BRWhlrPdVNRaPIGKsh
         LxwMuzrutZ1bQkTYsDvJkeT8l41gSn2zvjxQqdoeDETvLHjGYjfj0YOd0pwPPPMLPey8
         Ze1XAmV0ojd0x8hPHNMN1mBtStFH3lmorhlnr8e3yvUfA5CHerZPEz65Anono9Pjfjiq
         Efw6QDAGvwKkqLhyQXW480epsek4UErPhxn7CJmwmkr6GXRT2Fle4HAtyiFyKxwd10+S
         rxvRdCdrSsFMN7KeP+wUN32I8QK3lCfwcXIZHyS9lQ/JvWQRaJYL3YHEYtMYAn7KXK1c
         940w==
X-Forwarded-Encrypted: i=1; AJvYcCX4/ufiDAORKYzjRfa5Y5ZOtkOZRNPOACiTrwxu+oBVlzD3cT+cPG860OXO3aQUYwjwnjtXpBDE4lTTstVcODUUV0AI
X-Gm-Message-State: AOJu0Yw4hVCMFsTSThQ1OeLIh6w36K/bJfyS1JZM10OfYScm8V3obNEL
	LW9auL2SxXh/zdoq2Urztb5MQlHM4RMgQ2SobcrOV0Yd8RAFb3rRx8PewyjkcqZf3Ytf/gwOD7N
	0zaf3WYrcZY1NeoaUNVuyONeWVKM=
X-Google-Smtp-Source: AGHT+IEFdE04em5kmZpqozJHFyl43HtOQHY9+WnoYCNyeQTYgfDQb4M2mP493FyurdHm66aSFshL8OyGHxIs5qHUet4=
X-Received: by 2002:a17:90b:618:b0:2b1:502a:7f7 with SMTP id
 gb24-20020a17090b061800b002b1502a07f7mr2934765pjb.6.1714580887956; Wed, 01
 May 2024 09:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430112830.1184228-1-jolsa@kernel.org> <20240430112830.1184228-7-jolsa@kernel.org>
 <CAEf4BzYiBDDEPjAbW+anv8uoAdwjyUrOAeFeEXKXSBj_0wOTqQ@mail.gmail.com> <ZjIFzmmj_e1PzS5x@krava>
In-Reply-To: <ZjIFzmmj_e1PzS5x@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 May 2024 09:27:55 -0700
Message-ID: <CAEf4BzZDg6-GUt2d4Oy2p82EoBxUWrpSAMK4fvWWegFoov09Gw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 6/7] selftests/bpf: Add kprobe session test
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 2:05=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Apr 30, 2024 at 10:29:05AM -0700, Andrii Nakryiko wrote:
> > On Tue, Apr 30, 2024 at 4:29=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding kprobe session test and testing that the entry program
> > > return value controls execution of the return probe program.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/bpf_kfuncs.h      |  2 +
> > >  .../bpf/prog_tests/kprobe_multi_test.c        | 39 ++++++++++
> > >  .../bpf/progs/kprobe_multi_session.c          | 78 +++++++++++++++++=
++
> > >  3 files changed, 119 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_se=
ssion.c
> > >
> >
> > Given the things I mentioned below were the only "problems" I found, I
> > applied the patch and fixed those issues up while applying. Thanks a
> > lot for working on this! Excited about this feature, it's been asked
> > by our internal customers for a while as well. Looking forward to
> > uprobe session program type!
>
> great, I'll send it soon
>
> >
> > > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing=
/selftests/bpf/bpf_kfuncs.h
> > > index 14ebe7d9e1a3..180030b5d828 100644
> > > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > @@ -75,4 +75,6 @@ extern void bpf_key_put(struct bpf_key *key) __ksym=
;
> > >  extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> > >                                       struct bpf_dynptr *sig_ptr,
> > >                                       struct bpf_key *trusted_keyring=
) __ksym;
> > > +
> > > +extern bool bpf_session_is_return(void) __ksym;
> >
> > should be __weak, always make it __weak. vmlinux.h with kfuncs is comin=
g
> >
> > same for another kfunc in next patch
>
> ok
>
> >
> > >  #endif
> >
> > [...]
> >
> > > +static const void *kfuncs[8] =3D {
> > > +       &bpf_fentry_test1,
> > > +       &bpf_fentry_test2,
> > > +       &bpf_fentry_test3,
> > > +       &bpf_fentry_test4,
> > > +       &bpf_fentry_test5,
> > > +       &bpf_fentry_test6,
> > > +       &bpf_fentry_test7,
> > > +       &bpf_fentry_test8,
> > > +};
> > > +
> >
> > this is not supposed to work :) I don't think libbpf support this kind
> > of relocations in data section.
>
> aah, nice ;-) should we make it work (or make sure it works) ? seems usef=
ul
>

let's see if there are any real use cases beyond selftests, first

> >
> > The only reason it works in practice is because compiler completely
> > inlines access to this array and so code just has unrolled loop
> > (thanks to "static const" and -O2).
> >
> > This is a bit fragile, though. It might keep working, of course
> > (though I'm not sure if -O1 would still work), but I'd feel a bit more
> > comfortable if you define and initialize this array inside the
> > function (then it will be guaranteed to work with libbpf logic)
>
> thanks,
> jirka

