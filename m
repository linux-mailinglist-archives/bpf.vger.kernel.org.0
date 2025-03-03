Return-Path: <bpf+bounces-53110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811B2A4CBF8
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 20:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F331894F9D
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 19:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC39622DFBE;
	Mon,  3 Mar 2025 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8vt3wom"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14E81EF0B7
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030143; cv=none; b=RdV92MwKZU4j/N2IuDviv1eImkqUEDvlioG+7G403PHIqG3+PEJSykGiSNXd9ePlZGCdhdu9rEQQPecipiSBb09nTDXhppF/f1Og9VYZ951VC3uWjjXFzAE7EQr/TGv/hHhm/IHqecPLAa+O8oGMxW7AR8m4D9iJcEWybqfiKHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030143; c=relaxed/simple;
	bh=GC4NuSGOuwr0S505wOCvRFLfkpMUqgWdbS+RRU5ydJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjN6QsqfViHHe7bJHpqdPuF68ph1AQB+NleqIzNo1za+raBb/Lpo/eGl3FTW60GDmfhiFglUnxF+BVuG5yMPk4QuddDlhlxozyoiuUWmIg8z4PbCd+p5h3FiqQ7q6uGnDI4u9sl2m5V/IwQbcN+bhZZdw6ZEuk05wjEniCuWKoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8vt3wom; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fe821570e4so6955269a91.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 11:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741030141; x=1741634941; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQtQTndLVf+Sbt7KmEALVQJ1UAqOqFRmx2aiXTGp+3o=;
        b=V8vt3womH7PgvyC1WyfVXN6+mmlNQeorPzG3Q/YiZgsiaBl5mq1tp3inXQfO66s1Sg
         7JonFtDOYii6OH99E+7DLJBQNoi8GZaMJzI6Ab27OHIixjnkONR5trs/N1cTltI4/6wj
         idvqnyhWHhipFG6FmvD9jq9Q4k/aPmnLn2BioV7wetfY76guhNDB5VjrLPG7MD7rqg+a
         Ovy50BBqX0jvW7a8n/DtNzfUO2IzvFW1rPznxsOoQuEe6zD4KAzSz6Qg/T1wVeGeNjvW
         7U3kUj0lVe1F+nvh1cDdYlnYVB3munoYSwAZvUeKwYkCDYAm+mvb1LcHDOquNsfAD3Eg
         h4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741030141; x=1741634941;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQtQTndLVf+Sbt7KmEALVQJ1UAqOqFRmx2aiXTGp+3o=;
        b=gqLbOt+jqpxv1iUU6sajTbQMSF17ce8L6NrXXprHPma6WkLeF+V4QXAIHk97EcmNxT
         vYS8Q0JMF6wKMqk8i2mRlxYqxWsHhIUIy1OieUvY9cIXBAnq0ugpvfw6BaaaPTwE4hjr
         khw02BgPLP6o9PWfM5fNv01XRGodKf1kSdNEJOJSh0Nq/3IeaIvw8cV7OXMVmLYKg+Yb
         YLkQQPySaoLUm33nadbCNjkVjXLZRYJvRbzjLeUdxbQFTKVGq3GwuRCW6XRM0H3//Ct+
         WFkMQsIBeDWG+niZSIQoX42AuZ1tLjanJ0mWVrjkfLx6d423u2z6I9riK/Z2xoDwL5xN
         EnDw==
X-Gm-Message-State: AOJu0Yx3Innsuy22E6Ek/oCjdtkm03RyAKIaNb/Ymrbhy2xC+r8ROGC+
	G864xhKveC0nq6l/i6d2iz1ZZpQfOVmyxRR5ZTYKKX3ob5ssTKyS
X-Gm-Gg: ASbGncuLetit4K8Xc35yB4RdbhnaUsuG5sUEq/gcuBHGKIs718HSzDOftchwZcX/++F
	e5tN2E+qo9dV7I+ipGHTeth+b8JuCB8oKsusN/oU3hU6iWmRjjC2kzV8VK8oIj6GHkvPlLf5jUR
	XMwuDNQrD1Ix1Ywi1yz0EEIrysbQCtVN1kE6WztPEwIexDzOepmHx3na0GLc4ae7ko2tImu7Bj8
	30g/BnsDAUCAHH1Yq6DMfS9R6E+3xuPD89Vn99emWMqAuYhVXntrDaB4ZMjdhgmahTrmcfIWWcb
	FwzPAkJONhc0UMdAI8ZtWyBAjFBQznabEAPsdm/biw==
X-Google-Smtp-Source: AGHT+IGa7s6hEtyafqBRkkUapjh/ygiZ4VUra7nsG+9ZoBlxLCH4aONIpTytpixZLw9BLa+SdAGTwg==
X-Received: by 2002:a17:90b:1645:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2febab300damr21269144a91.4.1741030140929;
        Mon, 03 Mar 2025 11:29:00 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f972esm81938205ad.58.2025.03.03.11.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:29:00 -0800 (PST)
Message-ID: <501a58e7a6377bb69aba70b08e9d72c7bfd6c1cb.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] bpf: simple DFA-based live registers
 analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>
Date: Mon, 03 Mar 2025 11:28:56 -0800
In-Reply-To: <CAADnVQKcOLDqwhhQpy6YU13ZbY3edGgx1XpXF5VsmXt9Byxokg@mail.gmail.com>
References: <20250228060032.1425870-1-eddyz87@gmail.com>
	 <CAADnVQ+BEW_yTsm-pMYcCsHhpZ4=FhAMmGvY7AhwyiUOZ+X1Gg@mail.gmail.com>
	 <cc29975fbaf163d0c2ed904a9a4d6d9452177542.camel@gmail.com>
	 <CAADnVQKcOLDqwhhQpy6YU13ZbY3edGgx1XpXF5VsmXt9Byxokg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-03-01 at 16:09 -0800, Alexei Starovoitov wrote:
> On Fri, Feb 28, 2025 at 8:40=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:

[...]

> > Complete removal of mark_reg_read() means that analysis needs to be
> > done for stack slots as well. The algorithm to handle stack slots is
> > much more complicated:
> > - it needs to track register / stack slot type to handle cases like
> >   "r1 =3D r10" and spills of the stack pointer to stack;
> > - it needs to track register values, at-least crudely, to handle cases
> >   like "r1 =3D r10; r1 +=3D r2;" (array access).
>=20
> Doing this kind of register movement tracking before do_check()
> may be difficult indeed.
> Can we do this use/def tracking inline similar to current liveness,
> but without ->parent logic.
> Using postorder array that this patch adds ?
> verifier states are path sensitive and more accurate
> while this one will be insn based, but maybe good enough ?

You mean act like precision tracking? Whenever instruction is verified
and use is recorded propagate this use upwards in execution path,
updating live-in/live-out sets for instructions?

The problem here is termination (when to consider live-in/live-out
sets final). DFA computation stops as soon as live-in/live-out marks
stop changing. Idk how this condition should look for the scheme
above.

[...]

> > > Also note that mark_reg_read() tracks 32 vs 64 reads separately.
> > > iirc we did it to support fine grain mark_insn_zext
> > > to help architectures where zext has to be inserted by JIT.
> > > I'm not sure whether new liveness has to do it as well.
> >=20
> > As far as I understand, this is important for one check in
> > propagate_liveness(). And that check means something like:
> > "if this register was read as 64-bit value, remember that
> >  it needs zero extension on 32-bit load".
> >=20
> > Meaning that either DFA would need to track this bit of information
> > (should be simple), or more zero extensions would be added.
>=20
> Right. New liveness doesn't break zext, but makes it worse
> for arch that needs it. We would need to quantify the impact.
> iirc it was noticeable enough that we added this support.

I'm surprised that no test_progs or test_verifier tests a broken.
Agree that this needs to be quantified.

[...]

> > Two comparisons are made:
> > - dfa-opts vs dfa-opts-no-rm (small negative impact, except two
> >   sched_ext programs that hit 1M instructions limit; positive impact
> >   would have indicated a bug);
>=20
> Let's figure out what is causing rusty_init[_task]
> to explode.
> And proceed with this set in parallel.

Will do.

> > - dfa-opts vs dfa-opts-no-rm-sl (big negative impact).
>=20
> I don't read it as a big negative.
> cls_redirect and balancer_ingress need to be understood,
> but nothing exploded to hit 1M insns,
> so hopefully bare minimum stack tracking would do the trick.
>=20
> So in terms of priorities, let's land this set, then
> figure out rusty_init,
> figure out read32 vs 64 for zext,
> at that time we may land -no-rm.
> Then stack tracking.

Tbh, I think that landing dfa-opts-no-rm separately from
dfa-opts-no-rm-sl doesn't make things much simpler.
The register chain based liveness computation would still be a thing.
I'd try to figure out how to make the dfa-opts-no-rm-sl variant faster
first.


