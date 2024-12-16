Return-Path: <bpf+bounces-47066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77AA9F3C00
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 22:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AD3188A018
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 21:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7971F8F0A;
	Mon, 16 Dec 2024 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W3tLu/Xi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D851F8ADD
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381911; cv=none; b=FWonAaXPGWexHqjDHeackmlPmx2vbUW8MzWDNx8lCjqeBq2x5/0yXolNqzJsSKyXSK5XKG85fc+QAmODyOFxT8Euj2x3c2GnAWsledgIt2c0s306hIfZghNx0YUwslrDgaKmISBqn43CY8tBRt44e7lR49cnoKfOy+I1QJchHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381911; c=relaxed/simple;
	bh=cEBjiekPgeTfTPs03pJN92/L4CLT6wplCshcx5sP3pQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kdn8tFsrLv3w78m+NT/XzolLOdndVG1qFq8QQVIMa+Sua1tgzM2YVg5Tcx9BgTbK6u2JwvE+taOzTxtMMuzkyxA+i5h/yzQEN2aWMIJYwlKIUFHeqfUzR/zTQvmpJxhuP5cXDThERW4t9NsGcqGXa2i5zznldOt+tIhF6qGFHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W3tLu/Xi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436345cc17bso21282485e9.0
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 12:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734381908; x=1734986708; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYaq4M4YfZK86hssibI7o8W2XWv/I6RdxSVwoDtwAC4=;
        b=W3tLu/XiQk83q8QKkQV4JLh8+1MOxBs8EQe/Bp6BepfqSdjhXOwPgIbnYfLHQY84ew
         VZugNBIfhhDbls1gNF1FpE0u14+VtrbeK4IQpPcB7zeJCK0q9PCV6NW+duTnT2yWAb0x
         aG08PAOO6OEV9mmcytRLAdeCdndkCfU1BzaO9BoC/oTHgVwfO4kJxCEhf8VJak/IaMIW
         L2hUGnXKm0ptKFCmtupVQMTi6fQL26bHbBj5w5TvkwbOM6wxqdgHfxlqBOARXXl/ElNz
         3NpfNTGKCBNIs+RTzjroStu/KGgGDzeHoYkJOQfIc/52Js7WAVBXozXqXGm2Zswy6kcR
         tFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381908; x=1734986708;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYaq4M4YfZK86hssibI7o8W2XWv/I6RdxSVwoDtwAC4=;
        b=nAc6/DtCF5K+ruKeIURr9Vxa1n/KQgCub6F9duYVYhFtKf8qF+Xx2ZHVa8/1yhGcFQ
         9a0SFNILpiJ+q7Z6bpLnSRKf6epTKQXywJXQdgYQunN1s1FoxZX1AdgTwsei5Oy3XkJg
         GktHnMQpDPickprifRb7aFwuGULd3a05ZCBsqWK1xI0Sy6sO3oYgNmEu7NopOEyXwUvt
         ZIRdT2RncXADmiODXGI40Z7TPB+0ILMmcgd5+S2UAHoWVZjDj5UhG1fQPB6T4fR1YVBy
         flORGfMh8oZqBkdnSK5j44gqfinOqSHZah6Flb52HebawH4GRlcPMj/v/W/SoE7b039D
         qkKw==
X-Gm-Message-State: AOJu0YzneeoJYjI3gTj40HVCVgIDNlX2kEweYGN2bOi57AAugwRFI057
	NzVXtwdZtuUGrXFri/k6n3jjeqwcBxNRy/jVAEPNMmkt2PpPm137K6StGG6PPMA=
X-Gm-Gg: ASbGncvH+rBT/Mt7Wh9j+r8pVgiJeLvOK5xiZB88EhnBRKjqRWPtu6CGn8mumeaeZTQ
	fK9tpx4wBm2BInGoyG89zdTDruAQNRFzJj/vh3D1PMU2khOsDYCbbDv62XObkAL7e5Dh9mDuH9g
	RSpa05fd6Gaemuux8v13so07SMv+NFcH6kUmAv3QQKsvte3vl2SVtxpvnl3vvo4gd7MEmLdwm9F
	soYKZSeAhC+57LlBUV4yg/Yx0UFZhsE/OGmIxUOCg==
X-Google-Smtp-Source: AGHT+IHoy5v51+NNJNbJ8+PmMkv5BtWbb3JzBlBg2GSRmrD/kug/rYCHe9UveH6H63fOXBfPFt2wQQ==
X-Received: by 2002:a05:600c:1d1f:b0:434:f0df:9f6 with SMTP id 5b1f17b1804b1-4364767f087mr11740375e9.3.1734381907882;
        Mon, 16 Dec 2024 12:45:07 -0800 (PST)
Received: from localhost ([2a09:bac1:27c0:58::3b6:40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801acfdsm9026347f8f.57.2024.12.16.12.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 12:45:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Dec 2024 21:45:06 +0100
Message-Id: <D6DF2O8EW4OO.L1VZME1R8LAZ@bobby>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "kernel-team" <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test r0 bounds after BPF to
 BPF call with abnormal return
From: "Arthur Fabre" <afabre@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>
X-Mailer: aerc 0.8.2
References: <20241213212717.1830565-1-afabre@cloudflare.com>
 <20241213212717.1830565-3-afabre@cloudflare.com>
 <76401f4502366c2d9221758f9034aa7bb2d831a3.camel@gmail.com>
 <D6DB4NCLQZC9.I7DUNKR9RORW@bobby>
 <CAADnVQ++HfXeobY2XoJfDWXZGrF4_kR5kOK7asFRpBN=qmXU8Q@mail.gmail.com>
 <ed827bde40ab18be536add38c4237d949a752b2d.camel@gmail.com>
 <CAADnVQJwJVtD6rs0123mEa+Fok34mYL_nAZX09isKQHeLiY1-Q@mail.gmail.com>
In-Reply-To: <CAADnVQJwJVtD6rs0123mEa+Fok34mYL_nAZX09isKQHeLiY1-Q@mail.gmail.com>

On Mon Dec 16, 2024 at 8:47 PM CET, Alexei Starovoitov wrote:
> On Mon, Dec 16, 2024 at 10:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >
> > On Mon, 2024-12-16 at 10:05 -0800, Alexei Starovoitov wrote:
> >
> > [...]
> >
> > > > Thanks for the review! Good point, I'll try to write them in C.
> > > >
> > > > It might not be possible to do them both entirely: clang also doesn=
't
> > > > know that bpf_tail_call() can return, so it assumes the callee() wi=
ll
> > > > return a constant r0. It sometimes optimizes branches / loads out
> > > > because of this.
> > >
> > > I wonder whether we should tell llvm that it's similar to longjmp()
> > > with __attribute__((noreturn)) or some other attribute.
> >
> > GCC documents it as follows [1]:
> >
> >   > The noreturn keyword tells the compiler to assume that fatal
> >   > cannot reaturn. It can then optimize without regard to what would
> >   > happen if fatal ever did return. This makes slightly better code.
> >   > More importantly, it helps avoid spurious warnings of
> >   > uninitialized variables.
> >
> > But the bpf_tail_call could return if MAX_TAIL_CALL_CNT limit is exceed=
ed,
> > or programs map index is out of bounds.
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Common-Function-Attri=
butes.html#index-noreturn-function-attribute
>
> Yeah. noreturn is too heavy.
> attr(returns_twice) is another option, but it will probably
> pessimize the code too much as well.

We could provide a macro like:

#define BPF_TAIL_CALL(ctx, map, index) do { \
    bpf_tail_call(ctx, map, index); \
    int maybe_return; \
    asm volatile("%0 =3D 0" : "=3Dr"(maybe_return)); \
    if (maybe_return) \
        return maybe_return; \
} while(0)

It correctly tricks clang into thinking it can return early, but the
verifier removes the dead branch so there's no runtime cost.

But users would have to switch to it, I don't think we can replace the
definition in bpf_helper_defs.h in a backwards compatible way.

