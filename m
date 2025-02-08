Return-Path: <bpf+bounces-50839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D820AA2D326
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 03:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ADEE7A4D4E
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 02:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D353214A4F9;
	Sat,  8 Feb 2025 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi41XOjH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764C130A7D;
	Sat,  8 Feb 2025 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738982421; cv=none; b=uC3D/v/hgWpdhAyifVlnnaYFI3V2bgsqwwsQHT4kBvLgzGdogcXdBG9zTTrXvvricDest/LxLvtKAqY7Qw8DF2Hgm3hmkDZUz1DsfG4Ux19ZXyX33XiBggqTYvVUjk5pLMyF4LhmQAeBdJImob0FpgkN5sn639cquU1b/KYiSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738982421; c=relaxed/simple;
	bh=CCE6g8psB7pQeEuzmbEF/71KvxZ14BfzQFajZKgBMGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VedKq6puwScfk5QIEhOPlVKtpF2U98XistaC/+qXyIkAzz9K7sYADrX2i/1ivYCozncCjEAGcjwh0jnY5qaaTBTDwV3G6rjFLGm4WXQFI8lQgtSoYgJuykLsIRq24oAMIlWTuzrqXcyQ+X7UyzevmT5AtG3qbL6RtDfrGBgXATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi41XOjH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38dc627eba6so1318885f8f.2;
        Fri, 07 Feb 2025 18:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738982418; x=1739587218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srkQrrAnpadY8PLhAHZbzX0FKCYiY7EBmJzK416d56s=;
        b=Oi41XOjHdJj7Bqg8mETz/wN831agW//j9DtIRdYjsYfJ72yKTZ2uXAasqvEqOPVVih
         8I64K/Z8geDrVh+YbQJ4XXelLqCTM2NoDP5kxa7USVNFgA3HO4B355Oc6FehH/qFt8NL
         4Fqxx5lc40bP7D3VQgmfLoCuS+mF/3doTeVhIvyvf3yy6X2k+/JxsXHLbsXEjjgCDwrN
         JlvI75Y0aOkHYHgEw60+WPwkY/ahBBrJ9hkpDONGsCCG4yfuGqaKF4Sd2kIAKP7Xeos2
         3tPIU1JodWuJu0CWYqBWKi0ZhKxdSLMzoG2VLl12PWTF80EssWXWLHbhoj7AT7gG73+E
         6jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738982418; x=1739587218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srkQrrAnpadY8PLhAHZbzX0FKCYiY7EBmJzK416d56s=;
        b=a0JWc+IQFBbwcM8oSt6+QkcsBGoK3KDN4BruxaCpXVDgdCvR2XQAqa6KCYqVEDGpSF
         vEM19CL9dBqtbWNgqvzNnrDgcCYeOhQXSDYKamjmpb5v0pwqLxFcb7+0M0migllnAAZc
         0oFKp/gudWrb1G39mMPMgjn7Y8jL9Albi6snIQDofwZZlZhyz215pDpkSO0Ch5+lB+xg
         SDOEOTXjTGfd9adPkZxvZGYNyprCfYjXGti2f26Yv3jSmr5ncmeWSgw3zpqri3LdLK8+
         xX1Fh8rqov+grdSJIQkhiF7XbWUQO6SPa5+jvEZ8cyzM006xY59GbbRKligIojQG/0cN
         825w==
X-Forwarded-Encrypted: i=1; AJvYcCVLUxiDdtcUpsB2v7FTWpO8+WyNGtB6mF88PwqekCBxTfbndGynbxkC2eo8ZiVthUH7f/o=@vger.kernel.org, AJvYcCVWnj1u0nVRs0ijcWtCUFVw7+kw3BHjZml1bRvPr9StiLUGwMMvwGXJ7H0z1/fTg+m78zl5kwjugoLEIuyN@vger.kernel.org
X-Gm-Message-State: AOJu0YxwOHALcrMNY8dm+BU6zzvTZKaKtViVcRS5AOTteGs/xMjFyiWW
	Sd0XH0f/RFppgH5lpcizwZZX2hOm2TIyKr8iEcecorTRVFXsquRPZrYuHOqcpz3wZqcKfc9YGRH
	JEldfTEYrzH2pyBWQlQ87+71cdlY=
X-Gm-Gg: ASbGncvNZkkkBnSu8Bill58r3XtADpAVUDwRE8X8BtMmIvUiNPlJbQUd2do6OTpsm5W
	ALCmMGSoph0B4k9Dg2R8MV0SH0Pj+aJ5kRxn6iRoIc5Y0Qv2YIyOpVbu/B6788VH84jDsaczaTr
	sW7RG0IHdZWEVKIeNVumNALSqeFv8e
X-Google-Smtp-Source: AGHT+IEfhXFVKhUN2y1oi1TXHVdQ8x25Bg0Z/m21MOgikvbJIRkYv4XSKVjjcuzA74IMRgxZ+h4RSWQtz1ci/1yxZcE=
X-Received: by 2002:a05:6000:154f:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-38dc8d98e9amr3557767f8f.2.1738982417610; Fri, 07 Feb 2025
 18:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080392CC36DB66E8EA202DE99F42@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLb--LzFmXZPLPa5V+cD1A9YzTnZSgno9ftcA4-GGTi8w@mail.gmail.com> <AM6PR03MB508011599420DB53480E8BF799F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB508011599420DB53480E8BF799F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Feb 2025 18:40:06 -0800
X-Gm-Features: AWEUYZlY5Cx47GrscuSXW8CNNyK9yWTnCSrStL43MJmsPS9ntY6SNnwBBCv6kDs
Message-ID: <CAADnVQ+7RvuGsbnpeyMrZPKypKeUSULx42Gvmc9J_gnnkPffdA@mail.gmail.com>
Subject: Re: [RFC] bpf: Rethinking BPF safety, BPF open-coded iterators, and
 possible improvements (runtime protection)
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 4:40=E2=80=AFPM Juntong Deng <juntong.deng@outlook.c=
om> wrote:
>
> On 2025/2/4 23:59, Alexei Starovoitov wrote:
> > On Tue, Feb 4, 2025 at 11:35=E2=80=AFPM Juntong Deng <juntong.deng@outl=
ook.com> wrote:
> >>
> >> This discussion comes from the patch series open-coded BPF file
> >> iterator, which was Nack-ed and thus ended [0].
> >>
> >> Thanks for the feedback from Christian, Linus, and Al, all very helpfu=
l.
> >>
> >> The problems encountered in this patch series may also be encountered =
in
> >> other BPF open-coded iterators to be added in the future, or in other
> >> BPF usage scenarios.
> >>
> >> So maybe this is a good opportunity for us to discuss all of this and
> >> rethink BPF safety, BPF open coded iterators, and possible improvement=
s.
> >>
> >> [0]:
> >> https://lore.kernel.org/bpf/AM6PR03MB50801990BD93BFA2297A123599EC2@AM6=
PR03MB5080.eurprd03.prod.outlook.com/T/#t
> >>
> >> What do we expect from BPF safety?
> >> ----------------------------------
> >>
> >> Christian points out the important fact that BPF programs can hold
> >> references for a long time and cause weird issues.
> >>
> >> This is an inherent flaw in BPF. Since the addition of bpf_loop and
> >> BPF open-code iterators, the myth that BPF is "absolutely" safe has
> >> been broken.
> >>
> >> The BPF verifier is a static verifier and has no way of knowing how
> >> long a BPF program will actually run.
> >>
> >> For example, the following BPF program can freeze your computer, but
> >> can pass the BPF verifier smoothly.
> >>
> >> SEC("raw_tp/sched_switch")
> >> int BPF_PROG(on_switch)
> >> {
> >>          struct bpf_iter_num it;
> >>          int *v;
> >>          bpf_iter_num_new(&it, 0, 100000);
> >>          while ((v =3D bpf_iter_num_next(&it))) {
> >>                  struct bpf_iter_num it2;
> >>                  bpf_iter_num_new(&it2, 0, 100000);
> >>                  while ((v =3D bpf_iter_num_next(&it2))) {
> >>                          bpf_printk("BPF Bomb\n");
> >>                  }
> >>                  bpf_iter_num_destroy(&it2);
> >>          }
> >>          bpf_iter_num_destroy(&it);
> >>          return 0;
> >> }
> >>
> >> This BPF program runs a huge loop at each schedule.
> >>
> >> bpf_iter_num_new is a common iterator that we can use in almost any
> >> context, including LSM, sched-ext, tracing, etc.
> >>
> >> We can run large, long loops on any critical code path and freeze the
> >> system, since the BPF verifier has no way of knowing how long the
> >> iteration will run.
> >
> > This is completely orthogonal to the issue that Christian explained.
>
> Thanks for your reply!
>
> Completely orthogonal? Sorry, I may have some misunderstandings.

...

> program runs a huge loop at each schedule

You've discovered bpf iterators and said, rephrasing,
"loops can take a long time" and concluded with:
"This is an inherent flaw in BPF".

This kind of rhetoric is not helpful.
People that wanted to abuse bpf powers could have done it 10 years
ago without iterators, loops, etc.
One could create a hash map and populate it with collisions
and long per bucket link lists. Though we have random seed with enough
persistence hashtab becomes slow.
Then just do bpf_map_lookup_elem() from the prog.
This was a known issue that is gradually being fixed.

> Could you please share a link to the patch? I am curious how we can
> fix this.

There is no "fix" for the iterator. There is no single patch either.
The issues were discussed over many _years_ in LPC and LSFMM.
Exception logic was a step to fixing it.
Now we will do "exceptions part 2" or will rip out exceptions completely
and go with "fast execute" approach.
When either approach works we can add a watchdog (and other mechanisms)
to cancel program execution.
Unlike user space there is no easy way to sigkill bpf prog.
We have to free up all resources cleanly.

> Yes, I am willing to help, so I included a "Possible improvements"
> section.

With rants like "inherent flaw in BPF" it's hard to take
your offer of help seriously.

> I am also working on another patch about filters that we discussed
> earlier, although it still needs some time.

Pls focus on landing that first.

