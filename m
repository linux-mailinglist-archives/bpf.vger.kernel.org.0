Return-Path: <bpf+bounces-5176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C0D758289
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 18:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477421C20D6A
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1E1FC16;
	Tue, 18 Jul 2023 16:52:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6CC2C4
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 16:52:39 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC88199;
	Tue, 18 Jul 2023 09:52:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so89948591fa.3;
        Tue, 18 Jul 2023 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689699156; x=1692291156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iemggp/0h14cLCAAyDHhcCwLJhah9OyvESFo1Hs7/uQ=;
        b=qyylx3cIYmzIoE2RyMD9SETNHrJE31G33ejnX8oLxbM2rt3B07VYRuOv9KZqIwDU1z
         5ufm52bqxsWSUYkOJJFcf+njn9TrbFDP/ehFquKoMP3eLdJfd4u8YxMhQup/AsXMz8rA
         3A50PGhJDKIWDWHUA8kwuYlri3feKEgHSgzozIVG+5DtPyHn3+lBTPTfl3GrPhzbpzyd
         a+ftHoP0S0lX/ldtvRuHojqpnJjmpV7UdraTZxPkX3CGY/r44prbquB0+Orp3tR4xnmH
         xlt7x/07FJH5a/GlMVWIy84tt+ZmysSzPfXHvFjH6Vuc2X9wLGMB0NpNlJh1wcGEfnUR
         egGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689699156; x=1692291156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iemggp/0h14cLCAAyDHhcCwLJhah9OyvESFo1Hs7/uQ=;
        b=IuMPoLgcN/ENKZg+r/LgEJ3e7BZK/JdVVgV7qe5qPwY3lbhuipAoIVp6RU3CVwJNfH
         o6XukKr/0T3yr4Y+Hag2cOBz+ARGLiDKWAt6H+hP9dqOxtYvZzbosLA45oj1SjLNHcHg
         P4gqTIPsh/0b01ZCukKNcRixZeY/8RY4uRS7YOa1yD9ddx6cHV/xoDnzXsK1URkIj4FN
         se4cusiUz2xOqSpWvO00rcXP3M51B0+sy8YD5iQ7jOJsi3TNKXftX1U2hc387aujUaZ7
         +0egXSvcYrYSrKlehgFPeHCblsWbru9Zf4ymqVt2wjMaYEkljtguxvGRWHyUGPtp/Csm
         L2/Q==
X-Gm-Message-State: ABy/qLZgCHQskNXIMhJUR9IDCXJrqScmyl+ndk3dtp11pQcAFGot6qxR
	YWWF0wblIDyUcZV9iJXPhqp0YNvMpgJN7dK0hB0=
X-Google-Smtp-Source: APBJJlGtfIRvoWydC+CLLzgbS6S6yDVAym+kj9+77hjHEG4LTDQ34Jx3Fn5D0r59saL3Fo8htdGPQLd+4iTCW/2q8vs=
X-Received: by 2002:a2e:84d7:0:b0:2b6:cca1:975f with SMTP id
 q23-20020a2e84d7000000b002b6cca1975fmr11532284ljh.13.1689699156163; Tue, 18
 Jul 2023 09:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230502005218.3627530-1-drosen@google.com> <20230718082615.08448806@kernel.org>
 <CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com> <20230718090632.4590bae3@kernel.org>
In-Reply-To: <20230718090632.4590bae3@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Jul 2023 09:52:24 -0700
Message-ID: <CAADnVQ+4aehGYPJ2qT_HWWXmOSo4WXf69N=N9-dpzERKfzuSzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 9:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 18 Jul 2023 08:52:55 -0700 Alexei Starovoitov wrote:
> > On Tue, Jul 18, 2023 at 8:26=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Mon,  1 May 2023 17:52:16 -0700 Daniel Rosenberg wrote:
> > > > --- a/include/linux/skbuff.h
> > > > +++ b/include/linux/skbuff.h
> > > > @@ -4033,7 +4033,7 @@ __skb_header_pointer(const struct sk_buff *sk=
b, int offset, int len,
> > > >       if (likely(hlen - offset >=3D len))
> > > >               return (void *)data + offset;
> > > >
> > > > -     if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) =
< 0))
> > > > +     if (!skb || !buffer || unlikely(skb_copy_bits(skb, offset, bu=
ffer, len) < 0))
> > > >               return NULL;
> > >
> > > First off - please make sure you CC netdev on changes to networking!
> > >
> > > Please do not add stupid error checks to core code for BPF safety.
> > > Wrap the call if you can't guarantee that value is sane, this is
> > > a very bad precedent.
> >
> > This is NOT for safety. You misread the code.
>
> Doesn't matter, safety or optionality. skb_header_pointer() is used
> on the fast paths of the networking stack, adding heavy handed input
> validation to it is not okay. No sane code should be passing NULL
> buffer to skb_header_pointer(). Please move the NULL check to the BPF
> code so the rest of the networking stack does not have to pay the cost.
>
> This should be common sense. If one caller is doing something..
> "special" the extra code should live in the caller, not the callee.
> That's basic code hygiene.

you're still missing the point. Pls read the whole patch series.
It is _not_ input validation.
skb_copy_bits is a slow path. One extra check doesn't affect
performance at all. So 'fast paths' isn't a valid argument here.
The code is reusing
        if (likely(hlen - offset >=3D len))
                return (void *)data + offset;
which _is_ the fast path.

What you're requesting is to copy paste
the whole __skb_header_pointer into __skb_header_pointer2.
Makes no sense.

