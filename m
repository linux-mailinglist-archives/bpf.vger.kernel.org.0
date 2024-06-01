Return-Path: <bpf+bounces-31083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0991D8D6D9A
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 05:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C888B2334E
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 03:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4C56FB6;
	Sat,  1 Jun 2024 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUfXUcmj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1836FA8
	for <bpf@vger.kernel.org>; Sat,  1 Jun 2024 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717211328; cv=none; b=sMGhpKQxILUoQwrNaCKgrJwx/hNhtby/I+oGF/1lhxz9Gz5s0ynvJC8L+iAF3TPtKiin4HR3Nosp9+ZN8sGvOp6HxKVOCzk1gQH4ILSMP9qzbXwCWSMNoWBc5eeOkmVzHZOQy7S8SEHSLmYC2hs7BN0sL9jjrauCB9xuOLynNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717211328; c=relaxed/simple;
	bh=KOJ2aLiDGQE4im7BL/2WV0cROJJz5MfmO4q/C8xyqr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bi2f/E8ahE43uZSoou+W0xQPJL2uUkwimk/c5cNJMa0YarvF4FiVyLY4nrj89k2fp/jlNEFNhPnrc9jfKJjmYP6xHoSIvF/HfmXcMgAOa0QsrCLq+NJV0cjLrU3grrOgXHUA22NQYXuDJ+TPtS5Jz0ga5EknHnULbDN98EKOvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUfXUcmj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so25478795e9.1
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 20:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717211325; x=1717816125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OA8XgYzhLls0SQ7qQyEk3bhtyA/uRjiORWzOBU5sis=;
        b=RUfXUcmjlQYzOqmdiJ62PKcbFY75xPF+ua/mNZX674vbhMjxx8vgJfnB8o43MvWZ3P
         DkJKzOggD2qd1GDPucYGlLdPCrunqWQpMZvdunSUo6ADoIZTDGssvAj/pbglh+7RSBpF
         8Hbth6Vio4EqZal00oWQYgbJA9h9wRqa5h069rGlsgYdUYwP5R9A/rCbSBfUIrYBsbOc
         TE/VC1dlCTw8n9Jbye6kzjJXbCNdOVLTvGC9yJgWpCFOZ+wj4E8KvBndJLDXZi9QgdWT
         j6rRCsqhIc803vKy/tFzPu7cmL0m5C24nl1Pg0Zs5ALpnIW19vJFwICrAYBfktxdg7X3
         MIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717211325; x=1717816125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OA8XgYzhLls0SQ7qQyEk3bhtyA/uRjiORWzOBU5sis=;
        b=XMdaxkh1OBsLQscRmaLBbPhscita5mp5/mgOEBfcJL0IalmN0z1lMkNzxlI1zbDLSa
         XqQmNcXIBZxo8gbGlvzh61LRXEHB68ZIluzulz63kcczqc64ylB/go4aZBLhhJOjaZ87
         gGh4yHWzvo3lV/oS/p5+ywyENAy+sJdxpUKnKdRSv4FBOyxW5Ofdi8YY4tyvFgYPAGFu
         N1Py9X/zNeaZGweaumEhTC+/anJ81kBpTMTyn9clBMRb1YG5dVxrmC+f0wMI2rfK6BON
         ofg86gLyW7F/8bRG4fvKVMnZ0/I1rsA4bTsPQz7GNR4DezxKqMwAxsoD2h1v5M3sx856
         Bk7A==
X-Gm-Message-State: AOJu0YyJtzr3XXPSTV5HDv1wB7+zFUQJN4el4ir7+HXwTtPOH8O4nsM0
	1+ZF/Hl07tNmDS7Lh/DTB74UIZUDObGOHeEvKmbzKcr4I3p+FNOnRwUE1molnKJmvVlMuGeoLlJ
	/SDlPJOdgZedqDH1WcFVxSaaXKg4=
X-Google-Smtp-Source: AGHT+IGPqUoJHPn5dGc63gjSRSU/LN0vzW7OmxIv5ca3pX/GzbB7Ub3jG/6K0b1X2oNPJV9ZXB4tR0ImHv9Ts8JX/A8=
X-Received: by 2002:a05:600c:3595:b0:420:1078:a74c with SMTP id
 5b1f17b1804b1-4212e075798mr27943165e9.20.1717211324924; Fri, 31 May 2024
 20:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525031156.13545-1-alexei.starovoitov@gmail.com>
 <90874d4e32e7fe937c6774ad34d1617592b8abc8.camel@gmail.com>
 <CAADnVQJdaQT_KPEjvmniCTeUed3jY0mzDNLUhKbFjpbjApMJrA@mail.gmail.com>
 <ceec0883544b6855b7d1fda2884de775414a56c4.camel@gmail.com>
 <a8612f7bada4cf00d47e74c1507f9ad262e8a08f.camel@gmail.com>
 <CAADnVQKczx0pNt7f8vYmknyg7cBxrr8raOpVKmxfnSjT3UO1OQ@mail.gmail.com> <62cf34743e05aacfc754fbb84a0e1eeba14e76d2.camel@gmail.com>
In-Reply-To: <62cf34743e05aacfc754fbb84a0e1eeba14e76d2.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 May 2024 20:08:33 -0700
Message-ID: <CAADnVQLh34wMpHMaSA+4mpfGbPWB3U6TgU6ozBzCUbY0pWdM7A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in open
 coded iters and may_goto loop.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 3:14=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-05-28 at 20:22 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> >
>
> > > However, below is an example where if comparison is BPF_X.
> > > Note that I obfuscated constant 5 as a volatile variable.
> > > And here is what happens when verifier rejects the program:
> >
> > Sounds pretty much like: doctor it hurts when I do that.
>
> Well, the point is not in the volatile variable but in the BPF_X
> comparison instruction. The bound might a size of some buffer,
> e.g. encoded like this:
>
> struct foo {
>   int *items;
>   int max_items; // suppose this is 5 for some verification path
> };               // and 7 for another.
>
> And you don't need bpf_for specifically, an outer loop with
> can_loop should also lead to get_loop_entry(...) being non-NULL.

Right. Open coded iters and can_loop have the same convergence
property. They both need loop iterations to look like infinite
loop (same states) while bounded loop logic needs the opposite.
It needs loop states to be different otherwise it's an infinite loop
and prog is rejected.
So it's simply impossible for the verifier to excel in both.
The heuristic I'm adding is trying to make it work well
for open coded iters and focusing on converging when loop count
is high and impractical for a bounded loop.
At the same time the heuristic is trying not to degrade a corner
case where bounded loop logic might help (by recognizing
const_dst ?=3D const_src and not widening equality operation).
But heuristic is not going to be perfect.

As I said it's two steps forward and minimal step back.
I'm adding the following selftests:
       volatile const int limit =3D 100000; /* global */
        while ((v =3D bpf_iter_num_next(&it))) {
                if (i < limit)
                        sum +=3D arr[i++];
        }
influenced by your test and it passes due to widening logic.
Such a test is an impossible task for a bounded loop.
Hence this step forward for open coded iters is much
bigger than corner case loss of bounded loop logic inside
open coded iter.

> > > +      volatile unsigned long five =3D 5;
> > > +      unsigned long sum =3D 0, i =3D 0;
> > > +      struct bpf_iter_num it;
> > > +      int *v;
> > > +
> > > +      bpf_iter_num_new(&it, 0, 10);
> > > +      while ((v =3D bpf_iter_num_next(&it))) {
> > > +              if (i < five)
> > > +                      sum +=3D arr[i++];
> >
> > If you're saying that the verifier should accept that
> > no matter what then I have to disagree.
> > Not interested in avoiding issues in programs that
> > are actively looking to explore a verifier implementation detail.
>
> I don't think that this is a very exotic pattern,
> such code could be written if one has a buffer with a dynamic bound
> and seeks to fill it with items from some collection applying filtering.

After thinking more I had to agree. Hence I added it as a test.
volatile on stack is exotic and impractical, but
volatile const int limit;
as global var is a very real use case.

My widening logic was indeed too broad for BPF_X case.
reg_set_min_max() will see two unknown scalars and there will be
nothing to learn bounds from.
I'm fixing it with a double call to reg_set_min_max().
Once for src and other_src and 2nd time for dst and other_dst.
This way "i < five" is properly widened for both registers.

> I do not insist that varifier should accept such programs,
> but since we are going for heuristics to do the widening,
> I think we should try and figure out a few examples when
> heuristics breaks, just to understand if that is ok.

btw the existing widen_imprecise_scalars() heuristic
for open coded iters is more or less the same thing.
It may hurt bounded loop logic too. A bit of hand waving:
while ((v =3D bpf_iter_num_next(&it))) {
   if (i < 100) {
        j++;
        i++;
        // use 'j' such that it's safe only when 'j' is precise.
  }

Without this patch 'i < 100' will force precision on 'i',
but widen_imprecise_scalars() might widen 'j'.

At the end the users would need to understand how the
verifier widened 'i < 100' to write progs with open coded iters
and normal maps.
Or they will switch to may_goto and arena and things will "just work".

In arena progs we currently do a ton of useless mark_chain_precision
work because of 'i < 100' conditions. When all other pointers are arena
pointers they don't trigger precision marking.
Only 'i < 100' do. So after this patch the verifier is doing a lot
less work for arena programs. That's another reason why I want
to remove precision marking after is_branch_taken.

Anyway, v4 will be soon.

