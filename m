Return-Path: <bpf+bounces-46287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D204B9E7591
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30B4167DE5
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7B020E312;
	Fri,  6 Dec 2024 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k35HWzCH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741FC20E012
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501584; cv=none; b=NVQbeEnnTVM+lspKntbJ4umUkaAwNE9KTZ99fHOsRIetqHmLdXHa//r9xGNfVsgpAhGZNbkEhMhZ7sbhkFzB4IIIg0dw46DLIhLaf+C1sG2ZpwoU3vJY68VhLtzTfjjGy+a6JRMOg3axnKxNe2zW21TqTuRYEFDO9Q8uX/LMqY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501584; c=relaxed/simple;
	bh=bNyqIRRJioIl5cCrS19liS/1IEIpJUO+d/r7RsW3U/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uc6K2qCdohyRCKD3yVm1M1dTMswoeM6/kHqtxYNYnLvIdJi9yXJgHi77mn91Dz3VAGSW/FmwvquTn6tlDdKFTEkZwGFzDYqqnfDwFWt73op4gOZM5hczlwiC7pquvZXTHdckdwBuFQnImHl6gvlwPlgN57mkrHUELp/OkF9t870=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k35HWzCH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724f0f6300aso2788560b3a.2
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 08:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733501582; x=1734106382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNyqIRRJioIl5cCrS19liS/1IEIpJUO+d/r7RsW3U/s=;
        b=k35HWzCHwSnKV9gjJLKsOpEroT2ajuUAb1Uyi07MO7nWda+X61e7F0efpKetq3F6oD
         m27r4YuYlFDplc1kwZaqfLWLyuwbkctj4joc8jYk6/zgkGSYTYRXdnPZgGM0HMEwA79E
         jrFUpnzLEzdnCkk6gawPGEZoCZb7CHnGNbfdDIH/1UJR/sD0Q5oekjRPm8bu5MnCTBda
         KWe9Am0FwoWeaMq5CjXvs0xItiTugAIX+6Tj2u/PX44OhnIYFq1zIK2XK4+fv0Lf9SEM
         SmfclhSdE1i/92vrhppYpuxdQqyox8FoCwizTz+nRwOaPx1B2vgl1kFDCuN3aAntfjej
         yo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501582; x=1734106382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNyqIRRJioIl5cCrS19liS/1IEIpJUO+d/r7RsW3U/s=;
        b=lXW1jFO43GvDUr6MBv6C3sCItkUQUbgxxayLtT7pRgUx5G3Aa3UW7z0Asv8Inacdm1
         wcSZrzPwo7UIshqayFfHWOsw8aUQgWurxekNj0NvR3s0uY08AfLzQWvPN859YiewsWtq
         HDIDHQdd3aqzxFPkwZ4AKAYM0oCii+A1FpVGtJ4xiScf1ukOnL0XwackrvubVh9zsgSu
         Swx4jauS3QjZ4+O3YkRhqBW1fiXSIY3+IF0LhZwkqXfMuwlVXa6veAU8rfypmA4f7hdV
         12HGqsKXnM2MjBPliwafGR8KUEzhpEir7n9L/h7Pk8+8DnzYfVmcVTPmB3zpuyhj62DE
         4JaA==
X-Forwarded-Encrypted: i=1; AJvYcCXEH9cuO6yPV3acfgYMIMJxb8eGSdMMEre4bQarbUNIwAbepm3KMbR+SwQZw1p8aLeShL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+2RPrY6T9ihxQhOegov76RS419lOXA78lCqCPmqkPBSGkKtm
	FyIzWauKwN7+Fk3bUssYqnVHE4pXTVhF9grxyO1jCiFC18r10tvD5wkNTu89wAnlU5vHA8+VEqr
	VItzP5oPOPTLT7Xy4Uz5zTry89zPt3Q==
X-Gm-Gg: ASbGncufkRwjJUtQN36Bh9A/KhErfubTcde5niw0TMvKdMGE+NSSKhXSDMkadWJHPoc
	xJSZW4n2yglfEo/pOJq+PUITjMY+ArOx7
X-Google-Smtp-Source: AGHT+IFpN5g2Q1o9Ory4cz+zhDRs5wQHDm6fwT7LLfbDeaLfxTnQxWl+yco3tOdxAUSO5rOWeNNLc3xNE6tQYjUbViI=
X-Received: by 2002:a17:90b:4c04:b0:2ee:fdf3:390d with SMTP id
 98e67ed59e1d1-2ef6ab06a5amr4957041a91.31.1733501581482; Fri, 06 Dec 2024
 08:13:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com> <CAADnVQJ7WuFge8YZ-g07VK6XhmMCf1RHa0B64O0_S4TLzu0yUg@mail.gmail.com>
In-Reply-To: <CAADnVQJ7WuFge8YZ-g07VK6XhmMCf1RHa0B64O0_S4TLzu0yUg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 08:12:49 -0800
Message-ID: <CAEf4BzZPFy1XXf=2mXVpdVw70rJjgUfPnDOzWb5ZXrJF1=XqUA@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, 
	Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:08=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 5, 2024 at 10:23=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 5, 2024 at 8:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Thu, 2024-12-05 at 17:44 -0800, Alexei Starovoitov wrote:
> > > > On Thu, Dec 5, 2024 at 4:29=E2=80=AFPM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > > >
> > > > > so I went ahead and the fix does look simple:
> > > > > https://github.com/eddyz87/bpf/tree/skb-pull-data-global-func-bug
> > > >
> > > > Looks simple enough to me.
> > > > Ship it for bpf tree.
> > > > If we can come up with something better we can do it later in bpf-n=
ext.
> > > >
> > > > I very much prefer to avoid complexity as much as possible.
> > >
> > > Sent the patch-set for "simple".
> > > It is better then "dumb" by any metric anyways.
> > > Will try what Andrii suggests, as allowing calling global sub-program=
s
> > > from non-sleepable context sounds interesting.
> > >
> >
> > I haven't looked at your patches yet, but keep in mind another gotcha
> > with subprograms: they can be freplace'd by another BPF program
> > (clearly freplace programs were a successful reduction of
> > complexity... ;)
> >
> > What this means in practice is whatever deductions you get out of
> > analyzing any specific original subprogram might be violated by
> > freplace program if we don't enforce them during freplace attachment.
> >
> >
> > Anyways, I came here to say that I think I have a much simpler
> > solution that won't require big changes to the BPF verifier: tags. We
> > can shift the burden to the user having to declare the intent upfront
> > through subprog tags. And then, during verification of that global
> > subprog, the verifier can enforce that only explicitly declared side
> > effects can be enacted by the subprogram's code (taking into account
> > lazy dead code detection logic).
> >
> > We already take advantage of declarative tags for global subprog args
> > (__arg_trusted, etc), we can do the same for the function itself. We
> > can have __subprog_invalidates_all_pkt_pointers tag (and yes, I do
> > insist on this laconic name, of course), and during verification of
> > subprogram we just make sure that subprog was annotated as such, if
> > one of those fancy helpers is called directly in subprog itself or
> > transitively through any of *actually* called subprogs.
>
> tags for args was an aid to the verifier. Nothing is broken without them.
> Here it's about correctness.
> So we cannot use tags to solve this case.

Hm.. Just like without an arg tag, verifier would conservatively
assume that `struct task_struct *task` global subprog argument is just
some opaque memory, not really a task, and would verify that argument
and code working with it as such. If a user did something that
required extra task_struct semantics, then that would be a
verification error. Unless the user added __arg_trusted, of course.

Same thing here. We *assume* that global subprog doesn't have this
packet pointers side effect. If later during verification it turns out
it does have this effect -- this is an error and subprog gets
rejected. Unless the user provided
__subprog_invalidates_all_pkt_pointers, of course. Same thing.

I'm not saying we shouldn't fix the issue, I'm saying we should fix it
in a different place and add a tag to enable this side effect.

