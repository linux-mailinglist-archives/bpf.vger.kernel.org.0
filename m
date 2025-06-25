Return-Path: <bpf+bounces-61590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491BEAE90DC
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E378D17983B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5432877DB;
	Wed, 25 Jun 2025 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcZBK9xx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FB264FBB
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889611; cv=none; b=JJ3+33nlTdhyMWKxL37hxxxNIgrKC403sdWm3x9fKAhpVXSHeoO/6b4DwFv3KB5UKNTHGXXThm0sIgYmVkZba882+QJooTqBqn16N6ehPVOTOhNDSDXlNFOdOS5gG9oAL+bzj7scGHbrbw/b1kaAcknBUYchkjnk5im+y9obwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889611; c=relaxed/simple;
	bh=2pNVhWRxozpHEIv4T3Dd8gS4c2eFgEJr4+NfI/+Cg/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R12qbCKM4/XUqL2JNM+1gxS3yVq7qLFlbHm/tFWuKjRaeEnT3Zn0cXjOQNKSQ8uZoGahG9T4OH2gUuoPhcWlyThO8DePqFMl74YPy1pAFFbBzOVhD1RICjRmsYC3B21uR6sk5ptrmPGpCs9XB6e4zLFD+mpKgW0iOuOKTO6VZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcZBK9xx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2360ff7ac1bso3318945ad.3
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 15:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750889609; x=1751494409; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6wnzlOy+M9zfx2HfujBJ8Tbgr+xJaqna202wDayOU9I=;
        b=mcZBK9xxp8OYkTcwllx9qZuVSPADnZgaBMKG4x2hqT7WDJ+0fRZi6WPc8fOSzTmk+T
         o5f9Xx0dDWgKVOJr9zZXPAZKAddkpQBTnxy0BbWFpuWM4fBhURjdqqlFmXP1zMU0Jcla
         LaCFxFYOqG4o/5cwugaEAQBxaghlxVioIvyK/geyojqsa0d54TxttNc/naK/5+JUyPRA
         EK3KAUCg/NMEHxP82fBjmFgchP2sFkP+WScyZbz8JTZLlBdsd6hxlS3XsfoPv/GIljnH
         gC/8BeWJy7gLmYDZ9jYOnpHrEOjSpslaWnVRcEOWZ+b5kOT26MpNGbMEn9D+FmI7OA+W
         TCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750889609; x=1751494409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wnzlOy+M9zfx2HfujBJ8Tbgr+xJaqna202wDayOU9I=;
        b=Gd8TdJPKEIkXIlH2hmWUH55iG3Q7EElrMxiv/cV0CeuyHEymomvW+IyI2balJM3bVU
         5I2fs+vUSHyumY0ayC/JqM9onrKbGjuEqe1UOZDylOfveYqvxKKkXdckWlYUUEUqaTiy
         kQWMJXVHlZYjCgRdlWtnV17jcwHsGljIFCRr++QfgNrKYwJ6ZVyZ4vOqua25nQ4djvVe
         PihlVIUKM7o8AWVLQ5jwgFGlNLZkRbxIraFzR2bLYUBgSAlUNXixixJfSZZube9ESsmn
         1Qre4iI8VsaSsdjv/WA+N69Eh7SFHT25k2g3iSP/+IaxqOzoPL/0CIFt6YrkaTNewihA
         Qe8A==
X-Gm-Message-State: AOJu0YxRH1y9/547OggeZjJPz345QrjCOjDHrYOlaAnvs0cuVwm2JA6n
	YiI7ql4b3PT3v6fVDmv+JexBeHgv6qB3wCPu07+6LGMqAoOU+eWzRb6P
X-Gm-Gg: ASbGncuuzSEoBD19JwopDZMZrgowL5FvWA6mgUyDJsFacRDl5Ci2SITUYCrahybb4Dr
	qreIDj7Z3I1U0/XJwN6OWH/QSDG3XVmBz8Nyc3olpqQZ/1F+1r4lPTwvURftNf5T3+rg478iESr
	/+7AdJfOpCrHdHOue2PRRqWilH2oLi8jSLxLava1XhANvnzB+UBaNxbl76a9I99Zcu8nrF5jIv3
	fxqRkJDE0CGfWE+1lqsvMKAj3MyJ6g2IqUEOCS3Kis79sygmqllSo1LBprPkhJcvnKPEX61oJi3
	ytI42KVBSasxUrhEoS1LaXUGhKseg5vE7PKtO4tqcDWVgMWTqWaYYyW8hPuMUWXRkpR/0lTSOjY
	Anr3fe3xdVpQ=
X-Google-Smtp-Source: AGHT+IEdM0PQrFi/Y13KrbaaJcyL73VV4ae6Z0hUUKynBJcLj4kAZnlgxPh9r4RXjgSY7eHE1Wi0vg==
X-Received: by 2002:a17:902:d492:b0:224:76f:9e4a with SMTP id d9443c01a7336-238c8725bcfmr13119955ad.14.1750889609210;
        Wed, 25 Jun 2025 15:13:29 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2bd4:b3aa:7cc1:1d78? ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8398dcbsm140764325ad.48.2025.06.25.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 15:13:28 -0700 (PDT)
Message-ID: <4266fd5de04092aa4971cbef14f1b4b96961f432.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix unwarranted warning on speculative
 path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Luis
 Gerhorst	 <luis.gerhorst@fau.de>
Date: Wed, 25 Jun 2025 15:13:27 -0700
In-Reply-To: <aFxtazVRQQzhgfmO@mail.gmail.com>
References: <aFw5ha9TAf84MUdR@mail.gmail.com>
	 <402ecbeabdd090b81ae35d2187c344779ff926c7.camel@gmail.com>
	 <aFxtazVRQQzhgfmO@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-25 at 23:43 +0200, Paul Chaignon wrote:

[...]

> > So, suppose there is a program:
> >=20
> >      15: (18) r1 =3D 0x2020200005642020
> >      17: (7b) *(u64 *)(r10 -264) =3D r1
> >=20
> > Insn processing sequence would look like (starting from 15):
> > - prev_insn_idx <- 15
> > - do_check_insn()
> >   - env->insn_idx <- 17
> > - prev_insn_idx <- 17
> > - do_check_insn():
> >   - nospec_result <- true
> >   - env->insn_idx <- 18
> > - state->speculative && cur_aux(env)->nospec_result =3D=3D true:
> >   - WARN_ON_ONCE(18 !=3D 17 + 1) // no warning
> >=20
> > What do I miss?
>=20
> In the if condition, "cur_aux(env)" points to the aux data of the next
> instruction (#17 here) because we incremented "insn_idx" in
> do_check_insn(). In my fix, "insn" points to the previous instruction
> because we retrieved it before calling do_check_insn().
>=20
> Therefore, the processing sequence would look like:
> - prev_insn_idx <- 15
> - do_check_insn()
>   - env->insn_idx <- 17
> - state->speculative && cur_aux(env)->nospec_result =3D=3D true:
>   - WARN_ON_ONCE(17 !=3D 15 + 1) // warning

I'm sorry, I'm a bit slow today (well, maybe not only today).
Isn't it a slightly different bug in the original check?
Suppose current insn is ST/STX that do_check_insn() marked as
nospec_result. I think the intent was to stop branch processing right
at that point, as nospec instruction would be inserted after this
store =3D> no need to speculate further.
In other words, cur_aux(env)->nospec_result pointing to instruction
after ST/STX was not anticipated. (Luis, wdyt?)

> I added a verbose() and recompiled to confirm those numbers.
>=20
> If that makes sense, I'll send a v2 with:
> - A better description, probably with a walkthrough.
> - A test case simplified from the syzkaller repro.
> - insn_sz renamed to prev_insn_sz for clarity.

[...]

