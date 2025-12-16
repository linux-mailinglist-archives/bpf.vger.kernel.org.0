Return-Path: <bpf+bounces-76780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB6FCC556F
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BA2B300ACEB
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9A33358AE;
	Tue, 16 Dec 2025 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjDnZbTn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB5320A20
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923832; cv=none; b=L4FVDnyehWQO13YmiWsFnecxcrfQDKTb2mh9pGETUlLzcooW3uiFANUKyHHpRgmc5P+rYJTKNQ9xWS8Y5lU+CUZEBfYDsxYCGZ0y+92xbC4deGhJfz2zYraoD26fYs5tWZ3unXqZzABRk9KGMveVOwKTNpXAtjSUWSLqJxqChIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923832; c=relaxed/simple;
	bh=qLIzTUEJs0X/UUSS3qOtV8Aq+BgvPS8xuN/qO8ETJZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJzcKFHgeX8wxNK6gLK8HvHNgIQn3Y2QeOFAFj87dy/gjkegWo81mADZ5NExnIGrdDoGRvvfvuClRRY5L2ga90hwEl4DMGnNFHZfXFlyvCHYkxH+Pq31r1y85FJ2/yX6cRh9z+XH5+NCGnZgJyz7GaPd9kYm18u41k+3+A2bui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjDnZbTn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso3146691a91.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 14:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765923830; x=1766528630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Roi60Efd4Fs1Ld80mlgH1FVNir1s+mxw7oQmakRx4Ek=;
        b=gjDnZbTn4MoYKHOvIxpZ8npkFo6t46hyyRerxmMp94UtEHZ+B/yQKpI0CvuOYezg1u
         AxPdBLwRPLcLdKuRdKqsIN5oG30ek8mwGiPuFvM4Wop5AM45HdS72Dwog8QPJoq/RNq1
         6RlFdrwF+gsiCxHIAcbdMCZhPPSOPa3TnbWF9cojSsn1YGYoCrcEf50QZrIuOMTYQEib
         /xGvc9CeVdjHaliz/S/uc9auXSr67ilHY2Kw++Bvn3VdQri96Hr8Pt2dhBo1BIPjngUb
         xt3BOP7IwyGzI3UQQX1tJvXAmKCCv2S37n3rxCn7rp/UgbL95onw1IFYFwZhNUhzKD7/
         ZVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765923830; x=1766528630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Roi60Efd4Fs1Ld80mlgH1FVNir1s+mxw7oQmakRx4Ek=;
        b=Ibb2/WDNdt/GbUqJJJc1OzoL+wDusCx8SNFszBhc1b151Mp3cWvhQGuBetPNUn0oY4
         nRrhpyOnZ+AG4maha54CnfzdJeCHctqM1Upa3yTeSpWQFO1d4umTUObIUK6EgTpDoCZq
         Ll86Rj+c/Ec77XYZdAiIXJtQp8m57PjK/Te+kQpbHOYjvKqnuzb9QOHO9KiM0Jafs495
         2Qpp/YVCdbTASfY0krIVVNg6vMwFQfkBQ2HcZwou0jxvbqFUpYVj3S23c8TcPDgZWyDa
         MmkXFdgB78fthCxx+w35P55q1kDu07atJq8xfqV36AyPGfx7XueeTvgqDCi4uv1cnDQt
         OaUw==
X-Forwarded-Encrypted: i=1; AJvYcCUqZCHhbAvUbe+U2Pmgi5mJynua2rFhgRrgGZ4cK6iH1/AbDpsfqTqJOZTcgaYrBCG3KI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3XMEm1LFLbylhx5p8DAVzYL44fp1Ryms1TDurEc/iJ5bAV93Z
	enNJ5po0WoIldNu74lGLbjUSTYBUk/l21P3UsoeAdpOfcrUHLp+lGiXl1IMHG4FfnmI8OH/DZoY
	nSm+OyPR6hkc6nIgUcF67m9jYOAmQDqE=
X-Gm-Gg: AY/fxX4S7owzNlpT3Hu9cByw8v8kC5fN8D+O1UA2xtHyXPLv39yIRr8bobyRRJBEAkz
	pyzTY2FAGT4I/HtTaJuLZHmJ0ftLuZE4tdJx7XOVdofcqJ9c0G7XT8a1SfjCZWUBx+afpIkC7Gx
	XeMat2FLGshlI4p4UEiBukRkcfhEuUZ9SMTL/xucyk/0FIOQ9ZwB2d7FlGaLAAtUYFx9vY4WaVS
	iETklcJkoB5VUkp4GhKbZSZTXkfwcnSOudy0ZTyviixtD8+piWhVqKxaLQ1XG6y2SKx4nobMXv3
	I07ccvLlNnK5L1OUE/bokQ==
X-Google-Smtp-Source: AGHT+IEYLTs48vF+CXECG3SI7kHYQlV1l/Uz6RjVpdzPNYDUzh9V5wSDkeeFhTldZE6At/m8qd6tAgFNVBIa3byZg8U=
X-Received: by 2002:a17:90b:35c9:b0:33f:f22c:8602 with SMTP id
 98e67ed59e1d1-34abd858b3cmr13761833a91.26.1765923830393; Tue, 16 Dec 2025
 14:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-4-alan.maguire@oracle.com> <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
 <6f3027ee-576d-45de-9795-9a8e620292e9@oracle.com> <CAEf4BzYQeiECx9UpDqv6zRjd1EPjw8B44YX3KPGR1Z4dFKi1UA@mail.gmail.com>
 <27e4a60100602f769f3c5410a398a75fe0151967.camel@gmail.com>
 <CAEf4BzayA6if0xcTLux=eyASM1kpARmrOdDRmgG9F1SFa-fEcg@mail.gmail.com> <26e95f737d2de5133702c9b641946e70ec2d1dae.camel@gmail.com>
In-Reply-To: <26e95f737d2de5133702c9b641946e70ec2d1dae.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 14:23:35 -0800
X-Gm-Features: AQt7F2rV2p1VSvJoZysD5GfPah1tWy3K7xoX6AWiSx6KM6JRsGtC6hBz42U6n6Q
Message-ID: <CAEf4BzawMy=woHx_yHY0iiD0x12B_+J8mFgV5zT3aCpG2N0s-g@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 1:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-12-16 at 13:11 -0800, Andrii Nakryiko wrote:
> > On Tue, Dec 16, 2025 at 11:58=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Tue, 2025-12-16 at 11:42 -0800, Andrii Nakryiko wrote:
> > > > On Tue, Dec 16, 2025 at 7:00=E2=80=AFAM Alan Maguire <alan.maguire@=
oracle.com> wrote:
> > > > >
> > > > > On 16/12/2025 06:07, Eduard Zingerman wrote:
> > > > > > On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > @@ -395,8 +416,7 @@ static int btf_type_size(const struct btf=
_type *t)
> > > > > > >      case BTF_KIND_DECL_TAG:
> > > > > > >              return base_size + sizeof(struct btf_decl_tag);
> > > > > > >      default:
> > > > > > > -            pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t=
));
> > > > > > > -            return -EINVAL;
> > > > > > > +            return btf_type_size_unknown(btf, t);
> > > > > > >      }
> > > > > > >  }
> > > > > > >
> > > > > >
> > > > > > That's a matter of personal preference, of-course, but it seems=
 to me
> > > > > > that using `kind_layouts` table from your next patch for size
> > > > > > computation for all kinds would be a bit more elegant.
> > > > > >
> > > > > > Also, a question, should BTF validation check sizes for known k=
inds
> > > > > > and reject kind layout sections if those sizes differ from expe=
cted?
> > > > > >
> > > > >
> > > > > yeah, I'd say we'd need your second suggestion for the first to b=
e safe,
> > > > > and it seems worthwhile doing both I think. Thanks!
> > > >
> > > > ... but we will just blindly trust layout for unknown kinds, though=
?
> > > > So it's a bit inconsistent. I'd say let's keep it simple and don't
> > > > overdo the checking? btf_sanity_check() will validate that all know=
n
> > > > kinds are well-formed, isn't that sufficient to ensure that subsequ=
ent
> > > > use of BTF data in libbpf won't crash? If some tool generated a sub=
tly
> > > > invalid layout section which otherwise preserves BTF data
> > > > correctness... I don't know, this seems fine. The goal of sanity
> > > > checking is just to prevent more checks in all different places tha=
t
> > > > will subsequently rely on IDs being valid, and stuff like that. If
> > > > layout info is wrong for known kinds, so be it, we are not using th=
at
> > > > information anyways.
> > >
> > > Ignoring layout information for known kinds can lead to weird
> > > scenarios: e.g. suppose type size is N, but kind layout specifies tha=
t
> > > it is M > N, and the tool generating BTF uses M to actually layout th=
e
> > > binary data. We are being a bit inconsistent with such encoding.
> >
> > Who are "we" here? The tool that emitted incorrect layout information
> > -- yep, for sure. (But that shouldn't happen for correct BTF.)
> >
> > We do btf_sanity_check() upfront to minimize various sanity checks
> > spread out in libbpf code when using BTF data later on. But the goal
> > there is not really to check "100% standards conformance" of whatever
> > BTF we are working with. Kernel is way more concerned about validity
> > and not letting anything unexpected get through, but libbpf is in user
> > space and it's a bit different approach there.
> >
> > As long as BTF looks structurally sound (btf_sanity_check), it should
> > be fine for our needs. If BTF is corrupted or just uses invalid ID, or
> > whatnot, it will eventually fail somewhere, most probably. But the
> > goal is not to have NULL derefs and stuff like that.
>
> Introducing layout info into format provides an alternative definition
> for structural soundness. E.g. some types or vlen elements can have
> padding in the end all of a sudden.
>
> Using this info for some types but not the others is inconsistent.

Ok, so what you are saying is that if there is layout info we should
always use that instead of hard-coded knowledge about kind layout,
right? Ok, I can agree to that, but see note about extensibility
below.

But that's a bit different from validating that the recorded layout
of, say, BTF_KIND_STRUCT is what we expect (sizeof(struct btf_type) +
vlen * sizeof(struct btf_member)). Because if we enforce that, then we
still preclude any extensions to those layouts in the future. And if
we do that, what's the point of looking at layout info for kinds we do
know about?

> Given that BTF rewrites would only be unsound in presence of unknown
> types the whole feature looks questionable to me.

What are those "BTF rewrites" you are referring to? I'm getting a bit
lost in this discussion, tbh.

This feature is designed to allow introducing new (presumably,
optional) kinds and not break older versions of libbpf/bpftool to at
least be able to dump known contents. Does the current implementation
achieve that goal? What other goals do you think this feature should
support?

>
> > Basically what I'm trying to say is that if some tool intentionally or
> > unintentionally generates invalid layout information, but the rest of
> > data is valid, and libbpf doesn't look at layout and otherwise makes
> > fine use of BTF. Then that's fine with me, that BTF fulfills its duty
> > as far as libbpf is concerned. Libbpf here is just a consumer that
> > tries to be as permissive (unlike kernel) as possible, while not
> > leading to a process crash.
> >
> > With double checking that layout info matches our implicit knowledge
> > of type layout we are starting to move into BTF verification a bit,
> > IMO. And I think that's misleading and unnecessary.

