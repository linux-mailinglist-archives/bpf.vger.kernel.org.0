Return-Path: <bpf+bounces-20771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF6842D16
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 20:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352D728220B
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3891F7B3F6;
	Tue, 30 Jan 2024 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce8hn3ES"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E97B3C3
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643643; cv=none; b=aZ31xjQZs0YWhuFjEw7+l0nuBwgfpYFf1nLn4K+IYfvVJDvpTV1x8ly+7qnQjGhHfHmsQkOnZTykFhY0KlUMY6mj1eubNl1QFB1bDwV+wANlzofF5q8dlGPdfERcsi3JdIP5V/7LMofCTznWFZ2SIKLUaRKFznCecx0uQ096Fkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643643; c=relaxed/simple;
	bh=Nf8LVXGQUBKcjO/Ha0vlxaiWLMvywwFpoxXwF13qO3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE5i263GwJ0c8DHdo7uG7XeiozrX3gLq20hF/PwuhRPbEC7E/Q0U5O59sWg2plbyDEZlf4byl2/mrw9Rb830TJEfvkOdjF3g9A2twRsAveIehFsbX6ZdiEQDnLQ/n99CPBQpb88nQJBFjaQ63V5FsVr7nQtsF5/PZgpvafYkTsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ce8hn3ES; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5100ed2b33dso7256204e87.0
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 11:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706643640; x=1707248440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzRKimwqPjTIEeKQ1oM17JSZAsqV0NhKJRSyXCx6gfQ=;
        b=ce8hn3EScJH0gyzfXeWnUDPoTFFpHSi+X7mfMeu8IBKqI7yTPR1pL6kC9EFHY6uJ3j
         zhQ/IGAsuPjqz424OOnX8skk1r1EXDwAER39jEmyShwW7x+uSCCZLSfTZiOiHuS7uqgM
         gTZOUX7d2xaqPXYqxjpkYTQX6DEFrCCSMlhYbGUSTEKPXusAAne6MlKjCCC+3izRio3X
         BI5aJXl3cL93m3SUQKozY418x1SQn/iPK8JU/5gdTHua8c3krnwZdrFAlng/ge9gi0O5
         AdLgrq6Ki/hSWsso0FG+Cid8q7AkrgxaTEa+tIMalhQFIYoaNfs9Q893YtyaKHClGs4K
         aHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643640; x=1707248440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzRKimwqPjTIEeKQ1oM17JSZAsqV0NhKJRSyXCx6gfQ=;
        b=gRvVrzv4O0cs+AjvJFc3+uougYj/IC3dcq+gbiFH2D81/jYwom1eVR+8racHsIoohf
         a2CnFZ1QdLF4eZLwVCegHTYl8Z87SKKxTJ6mujMobUxim8AwXUdD2VLRhiQ7awc8bZfb
         B5XhVg5uhHkMkmhHBhZzBO+X3faeNIrAbcv/1M+zHwhEvk07MhhYqGhN3Ilc3P9D2IdB
         ea7gQ9DktA7CfGw5OB8H3zu2fRe1Vo07WD2mypLvx7MiQWWLpLTjNOoCeGuCHc2nGEso
         kNT0ZeuzHMnIwgB/S8SW6RQboDBzDeaOjCC+Ee7xKy11LaAA+bE9Dyjuv7C2Hf5Ty6ah
         J1rg==
X-Gm-Message-State: AOJu0YxlDEFoeDngVP0Wip43lwSHk2B2fqEXSYw5sitFQW+0Di8ffqd1
	IU9ts+Y8X/8WuKv6OYCSfrmAi84w0dsvUWTYNKMMn+U586/6X73x1Ma7bApUOr8XhXEDmFOIt+e
	+nXIDhUaSYcNrj4EAItfCm1eYPI4=
X-Google-Smtp-Source: AGHT+IEneaXalxZjImehz7khNHBL1BB2s5WCMP9vTzJSctoh6f7iYmbxoTEsifBGVdWIsxaYNuej9dROtc7FE8NC6FQ=
X-Received: by 2002:ac2:5ec8:0:b0:510:40a:4cb2 with SMTP id
 d8-20020ac25ec8000000b00510040a4cb2mr5988737lfq.38.1706643639703; Tue, 30 Jan
 2024 11:40:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <006601da5151$a22b2bb0$e6818310$@gmail.com> <877cjutxe9.fsf@oracle.com>
 <8734uitx3m.fsf@oracle.com> <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
 <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
 <071b01da5394$260dba30$72292e90$@gmail.com> <073001da539a$ec1e2b00$c45a8100$@gmail.com>
In-Reply-To: <073001da539a$ec1e2b00$c45a8100$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Jan 2024 11:40:28 -0800
Message-ID: <CAADnVQ+V33Cms=x6HHTCbpKN386NGNa5Z8KeiTujvrefqZod_A@mail.gmail.com>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 8:39=E2=80=AFAM <dthaler1968@googlemail.com> wrote:
>
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > [...]
> > > > Although the Linux verifier doesn't support them, the fact that gcc
> > > > does support them tells me that it's probably safest to list the DW
> > > > and LDX variants as deprecated as well, which is what the draft
> > > > already did in the appendix so that's good (nothing to change there=
,
> > > > I think).
> > >
> > > DW never existed in classic bpf, so abs/ind never had DW flavor.
> > > If some assembler/compiler decided to "support" them it's on them.
> > > The standard must not list such things as deprecated. They never
> > > existed. So nothing is deprecated.
> >
> > Ack, I will remove the ABS/IND + DW lines from the appendix.
> >
> > > Same with MSH. BPF_LDX | BPF_MSH | BPF_B is the only insn ever existe=
d.
> > > It's a legacy insn. Just like abs/ind.
> >
> > Should it be listed in the legacy conformance group then?
> >
> > Currently it's not mentioned in instruction-set.rst at all, so the opco=
de is
> > available to use by any new instruction.  If we do list it in instructi=
on-set.rst
> > then, like abs/ind, it will be avoided by anyone proposing new instruct=
ions.
>
> Here's my understanding of this thread so far:
>
> * (IND/ABS) | (W/H/B) | LD : these are accepted by the Linux verifier and=
 are supported
>    by clang and gcc.  They should be in the legacy conformance group of d=
eprecated
>    instructions.

yes

> * (IND/ABS) | DW | (LD/LDX) : these are not accepted by the Linux verifie=
r and were
>    never used.  Clang doesn't generate them but gcc did which is now remo=
ved
>    based on this discussion.  They should NOT be in the legacy conformanc=
e group of
>    deprecated instructions because they were never defined in the first p=
lace, and
>    instruction-set.rst should be updated to clarify this.

yes

> * (IND/ABS) | (W/H/B) | LDX : these are not accepted by the Linux verifie=
r and were
>    never used.  Clang doesn't generate them but gcc does. They should NOT
>    be in the legacy conformance group of deprecated instructions because =
they were
>    never defined in the first place, and instruction-set.rst should be up=
dated to clarify this.

yes.

> * (IND/ABS) | (W/H/B/DW) | (ST/STX): these are not accepted by the Linux =
verifier and were
>    never used.  I don't know whether clang or gcc generates them.  They s=
hould NOT
>    be in the legacy conformance group of deprecated instructions because =
they were
>    never defined in the first place, and instruction-set.rst should be up=
dated to clarify this.

yes

> * MSH | B | LDX: this existed in classic BPF but does not exist in (e)BPF=
 since it is not accepted
>    by the Linux verifier.  I don't know whether clang ever generated them=
, but gcc never did.
>    The "Legacy BPF Packet access instructions" section of instruction-set=
.rst says
>    > BPF previously introduced special instructions for access to packet =
data that were carried
>    > over from classic BPF. However, these instructions are deprecated an=
d should no longer be used.
>    I read Alexei's comment "It's a legacy insn. Just like abs/ind" as a p=
ossible argument that MSH|B|LDX
>    should be mentioned in instruction-set.rst, pointing to the above sect=
ion, like IND/ABS do.
>    But Yonghong argued that it was never accepted by the verifier, so nee=
d not be mentioned.

Yonghong is actually more correct here.

MSH | B | LDX is only accepted by _classic_ BPF.

It was never accepted by eBPF verifier,
so I have to back track my earlier suggestion.
I think it's undefined opcode from 'eBPF standardization' pov.
The standard doesn't talk about 'classic BPF' at all.
So it's fine to use MSH | B | LDX for something in the future.

> * MSH | (W/H/DW) | (LD/ST/STX): These are not accepted by the Linux verif=
ier and were
>    never used.  They should NOT be in the legacy conformance group of dep=
recated instructions
>    because they were never defined in the first place.

yes.

