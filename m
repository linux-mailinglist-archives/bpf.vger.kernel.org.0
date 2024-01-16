Return-Path: <bpf+bounces-19618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B782F36C
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 18:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9E21F244B7
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82711CABE;
	Tue, 16 Jan 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nametag.social header.i=@nametag.social header.b="X0oeK3p8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558DB1CAB8
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nametag.social
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nametag.social
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427125; cv=none; b=K8Y9EPtVPE+daJtoIXDeJEvPIQOlAiAX6rkJDGCIXwanIAgoNy/5V3AEca97wGo+bg47N5J1j5mmUvZtR64XhTJVzPyaus4blHzTPn/QZyYYXbz+1byKuENcS/2c0MJ/JFPyhwYb31F7JLLE4B1KebdSYMGoOw7qpDcEP6PJeZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427125; c=relaxed/simple;
	bh=lkMBIFrXjDCsSmfJXkXpyx9OpzXexiM6toFn83DP/bM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=bkTLTr0HrX/JKIKlMhxvefuYFVoMGZWqacoVl3s8TWu96Fll5Kj5NyMcQwON2sZl2gCukQM1/BLO4NB5T+mubkXHuQUpB2A+030dQ6BuPKBPxZCCrtauSXMJAdkfnqt3+79p0jmA1DL/eF4u/fk+ASky9/z2YOsOIwLMccTnEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=nametag.social header.i=@nametag.social header.b=X0oeK3p8; arc=none smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2dc7827a97so284906866b.2
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 09:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nametag.social; s=google; t=1705427121; x=1706031921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkMBIFrXjDCsSmfJXkXpyx9OpzXexiM6toFn83DP/bM=;
        b=X0oeK3p8vYoFm3QQSZTh9FJjro0shKH8oHCgDC5C3arReeZbPyTQ3fLpwY4vWiyLNg
         oDKc4UYEXv87NYiyB4yJbpMPJ11QzJd3I3+xWTQ1s/u9riY/zEhOrAwpt9V+uVyKGU0y
         ea22z+lstW3CTzfbX77pyXGXn7v76Ft0werMkFZxS350SAMA1tu3vmOD+ogTAy2NR5cS
         90XzmcQ7zRv0zpSuZ1kEOqhv8OpGv1NNDTH9cAoj154qqV1r7v0Jw3NvkeiB0xLORWAK
         1CzhouAvT8kp4fnVkurlTG+9RQmKXRCmBdu6nDFIao38VWmygq/Hy4wLOBwHq9DoE0eZ
         6nOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705427121; x=1706031921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkMBIFrXjDCsSmfJXkXpyx9OpzXexiM6toFn83DP/bM=;
        b=qw212yjn9pukAqC71dclp1LbO/QD0aoaz1o6tMEd5aU5ZAx9phSvtUac83Pnk+VbJS
         ogOj9OL8kCGD4YvNXlurqvwCU5PQyfhkY4lRS7Kw9wyABalAWpaKFYmWxDMJeIV/mq+P
         evRlyWAYlXx5sO4dr3Sz9GzK3oCbFKfnD0LZjl7M9C4tQLQNTA8Uq15kEJw+rYETZ2ZQ
         wxc2bHFD+dtX3LXiVT8Rd5dXVVp0r+7Ls4db6DOMZyIYnUdioGt/OjkEATH6L4KspSoI
         zXR152DJtM2wUyrINL/cP0SKtm8aETjl63CkJiZxHdyxYGSwp/rywHXvaEjWLNpHqOoY
         u+9g==
X-Gm-Message-State: AOJu0Yz99+xDYN0TBc7XU+sulJEPbEk7yeEYunL52ptieslMlEtzBC3J
	N8zipxxCc9E2C6Iu6itq/XLtiSORUCS3EC8qiFSppN7gqC/AQQ==
X-Google-Smtp-Source: AGHT+IHmTCLmiTRZU/LnxeFGY9tn5C8c+4VQL0fcVUuLvXprWz3y/GodTp1CIwtscTEMHP1xwXt0KmRQ/GlzPeEKKJA=
X-Received: by 2002:a17:907:c01c:b0:a2d:e4b9:45b4 with SMTP id
 ss28-20020a170907c01c00b00a2de4b945b4mr2017770ejc.75.1705427121451; Tue, 16
 Jan 2024 09:45:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM1kxwj533vwyxNvCPgXK2p=CxVszOm4T4g0YzaFhWPGATS0RA@mail.gmail.com>
 <CAM1kxwi9FMUr3vOqZeRe3FjuvwQgdW-8g0HGLL5fU2tOOjRfYA@mail.gmail.com> <65a5bde2c4e31_2eaef20845@john.notmuch>
In-Reply-To: <65a5bde2c4e31_2eaef20845@john.notmuch>
From: Victor Stewart <v@nametag.social>
Date: Tue, 16 Jan 2024 12:45:10 -0500
Message-ID: <CAM1kxwgZB8h36SC5YMK0PNg25UvXWVTRmFJsaOOyaczD_+8SVw@mail.gmail.com>
Subject: Re: [RFC bpf-next] crypto for unsleepable progs + new persistent bpf
 map for kernel api structs
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 6:21=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Victor Stewart wrote:
> > On Sat, Jan 13, 2024 at 2:31=E2=80=AFPM Victor Stewart <v@nametag.socia=
l> wrote:
> > >
> > > i was just brainstorming at Vadim off mailing list about my desire to=
 do AES
> > > decryption of QUIC connection IDs in an XDP program, RE his pending
> > > bpf crypto api patch series:
> > >
> > > https://lore.kernel.org/bpf/20231202010604.1877561-1-vadfed@meta.com/
> > >
> > > i'm hoping to gather some thoughts on the below two roadblocks:
> > >
> > >
> > > (1) crypto for preemption disabled bpf programs
> > >
> > > as he mentioned in the comments of 1/3 and to me directly, a non slee=
pable
> > > bpf program is not allowed to allocate a crypto context.
> > >
> > > is it possible for this restriction to be lifted?
> > >
> > > if not what safeguards would be required to lift it?
> > >
> > > worst case maybe an API could be added for userspace to initialize th=
e
> > > context, as userspace must provide the key anyway.
>
> I'm trying to understand why this is "worst case" to setup the context
> from userspace? Perhaps naively I haven't tried to code this up, but
> it seems like a sensible workflow to have userspace generate the key and
> also setup the context. Then have fastpath (XDP) use the context for
> decrypting?

yes i agree 100%. i think adding a new syscall flag + struct is
probably the ideal design?

syscall flag -> BPF_CRYPTO_CTX_CREATE

struct {

__aligned_u64 alg_name; // filter alg by synchronous, else return error
__u8 alg_name_len;
__u32 alg_type;
__u32 alg_mask;

__aligned_u64 cipher_key;
__u8 cipher_key_len;

__u8 array_idx;

// etc...
};

store the created bpf_crypto_ctx objects in an array in
kernel/bpf/crypto.c (the same as bpf_crypto_types) and add accessors

and make it all array/index based for performance reasons. up to the
user to manage the indexes.

>
> Thanks,
> John

