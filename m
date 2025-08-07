Return-Path: <bpf+bounces-65240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430B6B1DD6F
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 21:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601EF5606AC
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 19:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAA021D590;
	Thu,  7 Aug 2025 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkDAZjXO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869E2E36E5;
	Thu,  7 Aug 2025 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754594320; cv=none; b=BB3mrZQwYbPjidOvSIDb6nu6O95Z+dcGKRljyNWf9/E21Y8+F+5KxYNVG/aTH5NAzH2fdjZVIMSKEZKnstfeuV1pykkXqoq43Vc9xmWYNHoOLz/EfKCo6xyzTorBed2YHCOAlR1FdNenluLnuS1h2on+TeRQS+HIzaZ7mJeMWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754594320; c=relaxed/simple;
	bh=451/eb5yzW7FIDbllQFKbUUrmCcNp0soH/LFU1XaOZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aqtS1y5yfFde6UdvYVgEF1lFQFyqsT+pRtqthGGx1t1DSckdC57wRE2Q4MW1b1RYa1kBORMTdzJLoqKoBLuOJGMTCGlGBrl6NEMdSB7QD/qCWZn0Zr3hx1z9P2CN5nlp8t/aJwEFP51V2vhovvY0jLryjAB/hggyppVR83rSLYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkDAZjXO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23fd91f2f8bso10051165ad.3;
        Thu, 07 Aug 2025 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754594317; x=1755199117; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yc6F6giwsTxHvgkCJfnzLOyEE0Zq41KDhRF5H1vRo/M=;
        b=KkDAZjXO7cFYSN+iYb6aVyHDGC1muVD4b8wSY4V69Miy0OQCO9jxo4m0f/uqbBnmPW
         kNS2Ru91Xwwk8e3XgusjkX93o2pS+oNI20rkcUAYWzQC0y1eKbFF8dVlHvdZBKdxliD3
         VSFkkJa7Beej4LbkN3IjSJHl0H4qkXIATjLozripvscMB7LaVVDydOe4fKcuo3LPuMAM
         kTwDNzsvm6vkjzU3HDraI19WmUIh6ZqjM3on4YxJYju7nL8FQBCm6whcLSs2jVWRPROk
         odOjStd4aEMTMmBZVt9oPyt4vJrljEIv7E8C0sB1NqPQkICJAU04ypAcgAKuVvD7N9Ex
         zEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754594317; x=1755199117;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yc6F6giwsTxHvgkCJfnzLOyEE0Zq41KDhRF5H1vRo/M=;
        b=xNB+cNJ01Hizsj2+ZArpNiNjy9WmwPdC/LMX5wRnVWuOKcCsiAOImiXzRkQEEqSYgD
         xnJXYcdNWgSQwIlcQQ2Vts757bu8k9dMES1+gsL4ibWQghvGGjEWaAWEeZWZk7f1A74y
         b4T4SOgI6+0sCeJLuGzoVsjCi9YrDGe88bx0YWNk/8UC2BBLRshtIT7d5rXrDj1YSpDb
         Q0a9yPRmze4G9mp/4jM3kcusHrTKpg7o4g9Td4RNmRFbwQFl824veWgGsF1f+lHOE2I9
         kvvsLOPO70Gi4RL/vzkSDV6upCEf73U3CTK8ywQyesjg0g4H88JBRrzKWRl+JuJyTtxt
         2spg==
X-Forwarded-Encrypted: i=1; AJvYcCWKyDLO6VHkD9ZsabHu5uPrDUPih2Mpp2GZTZjEIDNcCHl4qX5yX7141RAXUuGhOwvkU+Je1tjcCg==@vger.kernel.org, AJvYcCWQtJN+Qm8Zi39+sMUhftxSG5qr+rCCfegdw/TaCZ7XdrjthPR0HSHIl1oBRlwWhGL6mVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mxWDy0WTPzSll615tttYBypznDzrNcpvQx1ZdLL9NFNYSzBJ
	w8V1vgXajnxbq2JhB1skzQk2RSnLNqi7nA4JFRPf0DwPdNrVoWHFHcpT
X-Gm-Gg: ASbGncuswnRuZMZJBWYFPLYMJCxVoVIy5zA06mdhDVfDznc2eydMls8FVGcD+mCknBA
	l2TZ+w+e5I6+bKj5c1UYI0R/s6ZHLL52QUGMzzAxLnDLioCXVrMCDMqYLiricMylfTNr9rxeR+X
	j4EY+kBgpckzOXoeCQmxQ9YepChelcTWVks5iNXfJr4FtE6hy5IvVt5/77fxffotytatLV1m92s
	8RvDYcUSiVOBNo8bGX4NbrnYoJSANxQ/+gy+C0I0gKRJszuqr7XrfY5blENK4xv40o90mjnSNwm
	rJJQi/3biJAEgDXOIj6I2/JlBSZ6viqCH5BQ4nndncBMEBUVsudkQGTDJSIv7QVoLt50AqPpgnO
	TU2xlFyhMvjjyEacwTqEUaUnftTu5Mf+TRY9z
X-Google-Smtp-Source: AGHT+IFzxNIf1yg4SGfT1z3oNAxNmo/B9SvlYd9tqS/cOfyD+uJlHhkk8uLOQl2/ViWSRam7qJW64w==
X-Received: by 2002:a17:903:fae:b0:240:636c:df91 with SMTP id d9443c01a7336-242c21dd509mr2665895ad.34.1754594317110;
        Thu, 07 Aug 2025 12:18:37 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::6? ([2620:10d:c090:600::1:8527])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89768a7sm191948545ad.83.2025.08.07.12.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:18:36 -0700 (PDT)
Message-ID: <1c78d157e7f174fd3eb154bf0655f0d14650b43e.camel@gmail.com>
Subject: Re: [RFC dwarves 5/6] btf_encoder: Do not error out if BTF is not
 found in some input files
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, "Jose E. Marchesi"
	 <jose.marchesi@oracle.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves
 <dwarves@vger.kernel.org>,  bpf <bpf@vger.kernel.org>
Date: Thu, 07 Aug 2025 12:18:35 -0700
In-Reply-To: <CAADnVQ+x3Jir0s=nsvw7eV54FJjFkfwx=+xWMM4bFHHmwD5ORw@mail.gmail.com>
References: <20250807144209.1845760-1-alan.maguire@oracle.com>
	 <20250807144209.1845760-6-alan.maguire@oracle.com>
	 <CAADnVQK38yk3XO9cebrXhMUSK10bH2LVPvs6W4e168x3mGpTWA@mail.gmail.com>
	 <87cy972imt.fsf@oracle.com>
	 <CAADnVQ+x3Jir0s=nsvw7eV54FJjFkfwx=+xWMM4bFHHmwD5ORw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-07 at 10:12 -0700, Alexei Starovoitov wrote:
> On Thu, Aug 7, 2025 at 9:37=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
> >
> >
> > > On Thu, Aug 7, 2025 at 7:42=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> > > >
> > > > This is no substitute for link-time BTF deduplication of course, bu=
t
> > > > it does provide a simple way to see the BTF that gcc generates for =
vmlinux.
> > > >
> > > > The idea is that we can explore differences in BTF generation acros=
s
> > > > the various combinations
> > > >
> > > > 1. debug info source: DWARF; dedup done via pahole (traditional)
> > > > 2. debug info source: compiler-generated BTF; dedup done via pahole=
 (above)
> > > > 3. debug info source: compiler-generated BTF; dedup done via linker=
 (TBD)
> > > >
> > > > Handling 3 - linker-based dedup - will require BTF archives so that=
 is the
> > > > next step we need to explore.
> > >
> > > Overall, the patch set makes sense and we need to make this step in p=
ahole,
> > > but before we start any discussion about 3 and BTF archives
> > > the 1 and 2 above need to reach parity.
> > > Not just being close enough, but an exact equivalence.
> > >
> > > But, frankly, gcc support for btf_decl_tags is much much higher prior=
ity
> > > than any of this.
> > >
> > > We're tired of adding hacks through the bpf subsystem, because
> > > gcc cannot do decl_tags.
> > > Here are the hacks that will be removed:
> > > 1. BTF_TYPE_SAFE*
> > > 2. raw_tp_null_args[]
> > > 3. KF_ARENA_ARG
> > > and probably other cases.
> >
> > We are getting there.  The C front-end maintainer just looked at the
> > latest version of the series [1] and, other than a small observation
> > concerning wide char strings, he seems to be ok with the attributes.
> >
> > [1] https://gcc.gnu.org/pipermail/gcc-patches/2025-August/692057.html
>
> Good to know.
>
> Yonghong, what does llvm do with wchar?

The literal is copied as-is with a warning.

  $ cat wide-string-test.c
  __attribute__((btf_decl_tag(u8"=C3=BC=C3=BC=C3=BC")))
  int foo(void) { return 42; }

  $ clang --target=3Dbpf -O2 -g wide-string-test.c -c -o wide-string-test.o
  wide-string-test.c:1:29: warning: encoding prefix 'u8' on an unevaluated =
string literal has no effect [-Winvalid-unevaluated-string]
      1 | __attribute__((btf_decl_tag(u8"=C3=BC=C3=BC=C3=BC")))
        |                             ^~
  1 warning generated.

  $ bpftool btf dump file wide-string-test.o
  [1] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D0
  [2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
  [3] FUNC 'foo' type_id=3D1 linkage=3Dglobal
  [4] DECL_TAG '=C3=BC=C3=BC=C3=BC' type_id=3D3 component_idx=3D-1

"As-is" means using compiler internal encoding (UTF8),
e.g. above u8"=C3=BC=C3=BC=C3=BC" is encoded as "c3 bc c3 bc c3 bc" in the =
final .BTF
section, same happens for UTF32 literal U"=C3=BC=C3=BC=C3=BC".

