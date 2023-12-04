Return-Path: <bpf+bounces-16613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E931803E0F
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DFF1F2127A
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EDC30FBE;
	Mon,  4 Dec 2023 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYQQpN+j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5878CB
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 11:07:00 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a18ebac19efso840277266b.0
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 11:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701716819; x=1702321619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeMSy/82dao1+laQDNIHomsdLfp7nD+ydv7Uu+ny1zA=;
        b=FYQQpN+j0RvPxXfdIl2uCE+zwkHZT8udo9IOU1mzK5/LylESoP5OGaE0X+8ftwX45O
         j6X5BoKVuEM7+jWa8lJ3ThHWAC91zNre+4+GPOUMv88QyNRkem52MdBCxzZj6yuTvZ2w
         sZAGCaJY5z3TEmuu8KO5mdcSCv40xZCLfTqCxpXPnxdkJXiO7UHpeLGFBz9Kr3ZHRmbE
         mmYwDz/7lPGF7a6BCpL0q+sGR5wDF1VfvpDGDH2+mm/BMCRdhibWCmN58N1jCKpDQuRo
         l4i5xNvZcpbXMvL5Tb4Nm1qqNq9AiOWD8+Z/uEGYHHuSrgNUWilQKn6wo7mokE1rWS30
         kOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716819; x=1702321619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeMSy/82dao1+laQDNIHomsdLfp7nD+ydv7Uu+ny1zA=;
        b=kae5xqiEFhiGW9AXsZkcL0J+Qg7YCGi6/zHg0VP9nINtS7H/T1/WVWIB3WbCuzP5m+
         HllQIboq9rXeq5bhdgIr3i6DJMcGxJOatUS1N/l1N9uuZh5cNFRB9uTA/Oq0VebZW5vG
         WZosj32GNHkF4d0Z6msOShYJI4Snfd3O5OuBkh4OMZM5ZII0gYnmU6dE5dpkwCN7nUw2
         HDn5ROVC9/6UxrIi8vZblCl8+AoSmFaN/qyKvrrGipYrRTjdgEndXujlWCB1dJ4LECwi
         6lKuS99rmU/HIFnbesQZ1uqQP3dM6S0866IfuNI7+cs9LELlny71sSH5NgpjnPRt3KxV
         TFzg==
X-Gm-Message-State: AOJu0Ywf180FDg5bKajqUBxI0bo5/OtBikLbM2lEV7jEHEw4clvWog1v
	f7KSqicL2FMBqrb9tlYuYDvtUvvlcnA3mTU2pIPR+5UzaT8=
X-Google-Smtp-Source: AGHT+IEgOq1bL7Ay3DIoVOHLsVr4A5PEy9Mkhr4ajeG8aU6hJBiPvHnAAyMm62/mUajybAIkXOCw+cvPCWMZGDHAOlM=
X-Received: by 2002:a17:906:19ca:b0:9fa:d1df:c2c4 with SMTP id
 h10-20020a17090619ca00b009fad1dfc2c4mr6100017ejd.36.1701716819025; Mon, 04
 Dec 2023 11:06:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202230558.1648708-1-andreimatei1@gmail.com>
 <20231202230558.1648708-4-andreimatei1@gmail.com> <CAEf4BzbT-UBaigkGeimFOTUqadVMbUFJJ7g2gfR-Au3xxHd6Yg@mail.gmail.com>
 <f3475cc9e9ee50a7fdbbfff353f07067537cf1fd.camel@gmail.com>
In-Reply-To: <f3475cc9e9ee50a7fdbbfff353f07067537cf1fd.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 11:06:46 -0800
Message-ID: <CAEf4Bza8e1e8VfXGi9GFg83u-OsE_eOBJhjncUfRmM=VDEAJwg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/3] bpf: minor cleanup around stack bounds
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, sunhao.th@gmail.com, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 10:43=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-12-04 at 10:19 -0800, Andrii Nakryiko wrote:
> [...]
> > > @@ -6828,7 +6831,10 @@ static int check_stack_access_within_bounds(
> > >                 return err;
> > >         }
> > >
> > > -       return grow_stack_state(env, state, round_up(-min_off, BPF_RE=
G_SIZE));
> > > +       /* Note that there is no stack access with offset zero, so th=
e needed stack
> > > +        * size is -min_off, not -min_off+1.
> > > +        */
> > > +       return grow_stack_state(env, state, -min_off /* size */);
> >
> > hmm.. there is still a grow_stack_state() call in
> > check_stack_write_fixed_off(), right? Which is not necessary because
> > we do check_stack_access_within_bounds() before that one. Can you drop
> > it as part of patch #2?
>
> I'm not sure I understand what you mean. Patch #2 (v3) drops
> grow_stack_state() from check_stack_write_fixed_off()
> so all seems good?

I swear I checked for that, both by re-reading the patch and by
searching in the browser. And check_stack_write_fixed_off() was
nowhere to be found. Now triple checking that I see that it's Gmail's
smartness that collapsed that portion of the patch (but not the
others!) into a subtle triple dot region, which made all that
invisible and non-searchable, sigh...

Sorry for the noise, all good then.

