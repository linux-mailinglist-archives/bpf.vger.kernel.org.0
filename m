Return-Path: <bpf+bounces-73751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5621C3863E
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 00:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033EE1A21F40
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 23:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318382F60A2;
	Wed,  5 Nov 2025 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3ixblNQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE352D7DDE
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386210; cv=none; b=lnBknsAOR8fZOySLbborS0OkQXLCrc5kSzxw7+KlsowCU69Ilyl7kA+/Pm+j+23j8ZKfR/eLrQgWX+pBQjopcshv8XzcuhNGZSuF+RTriAVrRXlyypSFUm9Ulh6/Y+Yq8NsootuTMWFl2H1mA7B6wak98MF8NyKDyXdVWjclk4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386210; c=relaxed/simple;
	bh=Ak0a/MofXeKeQ+l3St4/37wwo2EI1oYqy7US8b0zxnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gv/CbudQ5tvxUiq+10moX5MGRHcccaEagrKeV7BKkd608ZpVzDoAe00evT4o+Hr4pVhZpVe2HuWbBWh5oPcNS6pI+z2UqkQbc3TptWRZyUicb4wSW8fxjNJ75DPYdHS0PtqQCXD7xevkchzYbkpJER/F9KJNa2bhRj3c/mWtLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3ixblNQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429cf861327so287770f8f.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 15:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762386207; x=1762991007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqjzYrKsdzYpWMG26lMkMc/ll/hhUuKrKyM2DREXhn8=;
        b=N3ixblNQvBxpfJ6LwigQOd6qlBzlThhsyTAAjhyiAU1g6RZQvrm1pXEtma51wD5dqH
         3VAuloJDwk3o0HuVegYYfokIC2/S+J+lZCvpe+iJ0V1YZ5xsiwN6SZKQDmR7qK6xaxiC
         KkOO2dD+Gg9rJl3872bVYN1dQLgArfal6b1pQQEMfUVuxOej4t6wR808ekACKRwJFwTk
         EJ90KVGfHGTG8YGtAt6yJz7QcplgoHsq4V3wJ1CqvREsJtrd97mTeeMGyKmRNoOQQoQw
         Rj7xa4bB1e7R+rkvd3FfSzAxJbDEVPfDzbsdN4WS/04+jMB/rZJuA0P5j+xJqOsbFu66
         pQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762386207; x=1762991007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqjzYrKsdzYpWMG26lMkMc/ll/hhUuKrKyM2DREXhn8=;
        b=fdXbbsSDSZ8z67vRkp8NfLykvPrcK29kPySPlLB3jM1XTQPw735AkFEVii/Yi0F+Sm
         snxbc2TpJe5eoshIxRNjE9yt1B6/EQwhosqqGXch2TxLdCiazPZmVtrzABbmRa9Los+E
         2QImLRkEI6AzuosCKa0MAagiTh8g9nXbXGYkgreMGrzQN3ykhNR3RNfu7rraeQgXPuXD
         dVjhCZAlB5sQQR2c2qwGdi5hniNMtjD77GlujukIQL4EKgzUobGCz9eFpmNiJF39y/tJ
         5dlpWG33hTa7f8NKuK5CBMJX18ApeKClWTP5WCJuKX6bDgXSf0sYI72qLn0Vhb1ta+jd
         VXjg==
X-Forwarded-Encrypted: i=1; AJvYcCWkVLc0xEkaoE5g995Ju6sQDX/jFG1PazF8fNfjhG/iKY07mEiormpvGlyXBM8x/lCdR+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHzsej1GtSCex7jY/FwMMI38c4hz/HbP0IrI1EVTVKrh7wE4X
	6ifY9UBsTFtC9Qyx7M5P5ELr0mVehcq/pTO1Q21ZPsQJ6+eledbo4Fv+M2SKGKka0mHTc5fesDg
	4HF+uGe7tAhuorXns5qajtTg6upD57kM=
X-Gm-Gg: ASbGncvgKNEUZ5AzQ61nrHxsibVCBldg5017gq4SJ63BVhe1LsOMKfDspYW0tOmrdDG
	PcUER+v+on0GZ9B7xOcob93+6oRBK8O/m+1Ano2+2iL7qXkomd7XhNzfVsPmzCPGJx7w5b5ryBD
	/ivndbrdJ7xNkVDMEEfCnjSD65/APYdeld8hBObAI+bnVSiq52IdxmrxIZotZ5GGEVLJOlLmzJu
	DHZkJP9G10t2Tun3odJV/x7Anz20GKoeTtQqcwXY5Y/K9YQxZjOvfxFZCSryc3DmrLSC8kgnouZ
	tLCruahW/W2NNim7eA==
X-Google-Smtp-Source: AGHT+IHy2tfHNgJ6cQpCodGNfGYWTZ5F1i/eU0t3ocsIu6em6NiXgoAdtiWwWZT/GQIXmPMwErZiV6BOsWuGXGX8nJc=
X-Received: by 2002:a05:6000:230e:b0:429:d170:b3ac with SMTP id
 ffacd0b85a97d-429e32dd82cmr5292052f8f.13.1762386207144; Wed, 05 Nov 2025
 15:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105201415.227144-1-hoyeon.lee@suse.com> <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
 <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
 <CAADnVQJVYDbOCuJnf9jZWdFya7-PfFfPv2=d2M=75aA+VGGayg@mail.gmail.com> <8541c5bb758bc06e8c865aaa4f95456ac3238321.camel@gmail.com>
In-Reply-To: <8541c5bb758bc06e8c865aaa4f95456ac3238321.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 15:43:15 -0800
X-Gm-Features: AWmQ_bndYwW94kW--NSZQuJg-9ElD91TnXSYs-Z0mmovjayEfLI3uc8pkBOaK5I
Message-ID: <CAADnVQL91xsujXt4GWjgCYC+PdBC-2ZH6GqefXws_YHiL7B7Sg@mail.gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use bpf_strncmp
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hoyeon Lee <hoyeon.lee@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:38=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2025-11-05 at 15:33 -0800, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Wed, 2025-11-05 at 14:45 -0800, Alexei Starovoitov wrote:
> > > > On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse=
.com> wrote:
> > > > >
> > > > > The netif_receive_skb BPF program used in snprintf_btf test still=
 uses
> > > > > a custom __strncmp. This is unnecessary as the bpf_strncmp helper=
 is
> > > > > available and provides the same functionality.
> > > > >
> > > > > This commit refactors the test to use the bpf_strncmp helper, rem=
oving
> > > > > the redundant custom implementation.
> > > > >
> > > > > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > > > > ---
> > > > >  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +--------=
------
> > > > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.=
c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > > index 9e067dcbf607..186b8c82b9e6 100644
> > > > > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > > @@ -31,19 +31,6 @@ struct {
> > > > >         __type(value, char[STRSIZE]);
> > > > >  } strdata SEC(".maps");
> > > > >
> > > > > -static int __strncmp(const void *m1, const void *m2, size_t len)
> > > > > -{
> > > > > -       const unsigned char *s1 =3D m1;
> > > > > -       const unsigned char *s2 =3D m2;
> > > > > -       int i, delta =3D 0;
> > > > > -
> > > > > -       for (i =3D 0; i < len; i++) {
> > > > > -               delta =3D s1[i] - s2[i];
> > > > > -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> > > > > -                       break;
> > > > > -       }
> > > > > -       return delta;
> > > > > -}
> > > > >
> > > > >  #if __has_builtin(__builtin_btf_type_id)
> > > > >  #define        TEST_BTF(_str, _type, _flags, _expected, ...)    =
               \
> > > > > @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void=
 *m2, size_t len)
> > > > >                                        &_ptr, sizeof(_ptr), _hfla=
gs);   \
> > > > >                 if (ret)                                         =
       \
> > > > >                         break;                                   =
       \
> > > > > -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED_S=
TRSIZE); \
> > > > > +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _exp=
ectedval); \
> > > >
> > > > Though it's equivalent, the point of the test is to be heavy
> > > > for the verifier with open coded __strncmp().
> > > >
> > > > pw-bot: cr
> > >
> > > I double checked that before acking, the test was added as a part of =
[1].
> > > So it seems to be focused on bpf_snprintf_btf(), not on scalability.
> > > And it's not that heavy in terms of instructions budget:
> > >
> > > File                     Program                  Verdict  Insns  Sta=
tes
> > > -----------------------  -----------------------  -------  -----  ---=
---
> > > netif_receive_skb.bpf.o  trace_netif_receive_skb  success  18152     =
629
> >
> > Is this before or after?
> > What is the % decrease in insn_processed?
> > I'd like to better understand the impact of the change.
>
> That's before, after the change it is as follows:
>
> File                     Program                  Verdict  Insns  States
> -----------------------  -----------------------  -------  -----  ------
> netif_receive_skb.bpf.o  trace_netif_receive_skb  success   4353     235
> -----------------------  -----------------------  -------  -----  ------
>
> So, the overall impact is 18K -> 4K instructions processed.

It's large enough impact for the verifier.
I agree that the test was mainly focusing on testing
bpf_snprintf_btf(), but it has a nice side effect by testing
bounded loops too.
I prefer to keep it as-is.

