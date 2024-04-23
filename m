Return-Path: <bpf+bounces-27496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F388ADB60
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 03:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4039E284485
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 01:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6DEFBF6;
	Tue, 23 Apr 2024 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="KwPvJFm9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="KwPvJFm9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBJ+MCM8"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295BE574
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713834114; cv=none; b=LQNEktRyRbmtXciNtcwFtP2ED44gSW2vkBElZ7/3jI6mZqd6MTZITlk5m/MUTl0IjQcOu5Mamv4KKsn0TnSZ6LLmn046kcMquhiA6nvvaMY6Ofii60SBpPP6DX/NI/cYZwalEL33M3TmTtB0qNwudisGgzmVEtz22lNGf4TmOms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713834114; c=relaxed/simple;
	bh=6cmLz/dPHVSnrwdzERnOvvc8hDrvF85X8i8vtRaWZwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=sWKML2LJCT1r3HAYuld0Viu5nHhB9Ph3nmp13JFWZgyjkaGqsTAUpNJyqePL3AE+diCVoUcSvuxx6bhn690Vw3rVbSLwOeuxMcAJOkHtJ+Di29PNM91gBG/Ch8cP9TB7cTTpa0OD1pGFaZHvKDV/scX13UW3f0QTVNV8+ZvSfTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=KwPvJFm9; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=KwPvJFm9; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBJ+MCM8 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 77964C1C4123
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 18:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713834112; bh=6cmLz/dPHVSnrwdzERnOvvc8hDrvF85X8i8vtRaWZwo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=KwPvJFm9ZJNkfh/LG5nL6Nlprmb2hOCZEzquNdh3cCS1p+gwtfaonkmlAbPKXwMbu
	 dzV77vNtkFLXanRIQBE/9oxlkGsZZla2K02tqCpjq2962vWw+xJT6KrT56Raj5ozDX
	 F2Y44AZRktv1IxHFtSfeJoXMJkfwSoB8sdeLLEto=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Apr 22 18:01:52 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4AA13C18DB82;
	Mon, 22 Apr 2024 18:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713834112; bh=6cmLz/dPHVSnrwdzERnOvvc8hDrvF85X8i8vtRaWZwo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=KwPvJFm9ZJNkfh/LG5nL6Nlprmb2hOCZEzquNdh3cCS1p+gwtfaonkmlAbPKXwMbu
	 dzV77vNtkFLXanRIQBE/9oxlkGsZZla2K02tqCpjq2962vWw+xJT6KrT56Raj5ozDX
	 F2Y44AZRktv1IxHFtSfeJoXMJkfwSoB8sdeLLEto=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 83145C18DB82
 for <bpf@ietfa.amsl.com>; Mon, 22 Apr 2024 18:01:50 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.095
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BjdwGUcuuzh7 for <bpf@ietfa.amsl.com>;
 Mon, 22 Apr 2024 18:01:46 -0700 (PDT)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A1EFDC14F71E
 for <bpf@ietf.org>; Mon, 22 Apr 2024 18:01:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so3534528f8f.0
 for <bpf@ietf.org>; Mon, 22 Apr 2024 18:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713834104; x=1714438904; darn=ietf.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tq+9LLFsQU6mKyzYwHy8w8O3btMoByRIhtZafx67vnw=;
 b=WBJ+MCM8RfCV0RuMqmbGnSWjrsJS+Oc4fqGG3zpWAvW+W69qn7jjcUZv6onXD3CH2r
 IDEOiAtlWdNkA0pFjXiS0+bMzHjHsquV8y+VEYSQ0LB9TVhe+Pj+ix2rZnwBbxbjKmV4
 WAIAwjvd/DUsE0J+MHVqA/GGUdUCJafCFLOiaca89HGcQuqosarUI5xg0SPNYVOqGOdz
 CTR7XQwFubeW9ft0DFbuuRfljrQ/rTzvcWJbW/P0uNEbfQWtEDVOoLe3R3AzoPO/IuE1
 PSM4gOBgLp5+hKLSvCk2DIGF83hDFZexu6VAXShrFVxBREEOFN9c9+W/j+5MjjvXiBad
 lHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713834104; x=1714438904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tq+9LLFsQU6mKyzYwHy8w8O3btMoByRIhtZafx67vnw=;
 b=V2vowKzC1yvDZm4ADNCXCmJpp8erNTXzkE5SXTVIwaDNT20ne5MsFzkRK9lGZqDh1b
 ZGiYj0WyIl8AoQmb6GRbQmlX7oLH8wUt+4KCOiZQFJupXU5gIzw7gaWTMnBLe3kr2Fif
 85Tv90DzNCAUjDYGo+XlXr6Hl2pS2dj1XdDSmjDEUfvGljhES5BNNbinrPuRvNxhv6tG
 FzKKzrChpPCZUnFuhM9HkmMSg/NSBRANuxjdXqoHw5h4q5igrUAarmRrxe3AGb1mceUL
 EY5L12c/p7InoKpff5dfKO5MiYEUQBiINyuOf29SlBaBPGvc37wUsfHTtAr+O0ZH61g8
 tctA==
X-Gm-Message-State: AOJu0YxEnk83TbQg77qLxNNiyfo7S1XhsLls0oezHmzT13Hb4lbpssTr
 FQeaY2Tkv7MyPtKL0Mr6OsFRqTUixtI6HeYinXg7sBTi5H8g3N9sbsgwcRiRenBixUqQ9sfRmAa
 EekuSysMQxF/DbCL3ScL78ST0V/zU/Q==
X-Google-Smtp-Source: AGHT+IGLE/aNnFnW7+NfnJKAdr7sRsUmxFb81rQSHFBzix0+xPMcf2M+ZpALlYWliLyXfZemKbPwoUSCzhva/yvRE38=
X-Received: by 2002:adf:ea07:0:b0:346:409d:51a4 with SMTP id
 q7-20020adfea07000000b00346409d51a4mr712856wrm.24.1713834104116; Mon, 22 Apr
 2024 18:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <093301da933d$0d478510$27d68f30$@gmail.com>
 <CACsn0ckPptm05-G6tXPaJJSvKmP3e-nCKPJJCdkmzZOYkQX-Tw@mail.gmail.com>
 <151e01da94e8$1c391f00$54ab5d00$@gmail.com>
In-Reply-To: <151e01da94e8$1c391f00$54ab5d00$@gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Mon, 22 Apr 2024 18:01:34 -0700
Message-ID: <CACsn0ckq6r-KwNFttPnezjqC6XZYDL0HRHv+bQV_8KR=N55S8A@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/MCsnHLEAZ8TRWLmHMTw9cXpmWII>
Subject: Re: [Bpf] BPF ISA Security Considerations section
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============8211897329336547081=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

--===============8211897329336547081==
Content-Type: multipart/alternative; boundary="000000000000fadd3b0616b9189e"

--000000000000fadd3b0616b9189e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 12:06=E2=80=AFPM <dthaler1968@googlemail.com> wrote=
:
>
> > -----Original Message-----
> > From: Watson Ladd <watsonbladd@gmail.com>
> > Sent: Monday, April 22, 2024 12:02 PM
> > To: dthaler1968=3D40googlemail.com@dmarc.ietf.org
> > Cc: bpf@ietf.org; bpf@vger.kernel.org
> > Subject: Re: [Bpf] BPF ISA Security Considerations section
> >
> > On Sat, Apr 20, 2024 at 9:09=E2=80=AFAM
> > <dthaler1968=3D40googlemail.com@dmarc.ietf.org> wrote:
> > >
> > > Per
> > > https://authors.ietf.org/en/required-content#security-considerations,
> > > the BPF ISA draft is required to have a Security Considerations
> > > section before it can become an RFC.
> > >
> > > Below is strawman text that tries to strike a balance between
> > > discussing security issues and solutions vs keeping details out of
> > > scope that belong in other documents like the "verifier expectations
> > > and building blocks for allowing safe execution of untrusted BPF
> > > programs" document that is a separate item on the IETF WG charter.
> > >
> > > Proposed text:
> > >
> > > > Security Considerations
> > > >
> > > > BPF programs could use BPF instructions to do malicious things with
> > > memory,
> > > > CPU, networking, or other system resources. This is not
> > > > fundamentally
> > > different
> > > > from any other type of software that may run on a device. Execution
> > > environments
> > > > should be carefully designed to only run BPF programs that are
> > > > trusted or
> > > verified,
> > > > and sandboxing and privilege level separation are key strategies fo=
r
> > > limiting
> > > > security and abuse impact. For example, BPF verifiers are well-know=
n
> > > > and
> > > widely
> > > > deployed and are responsible for ensuring that BPF programs will
> > > > terminate within a reasonable time, only interact with memory in
> > > > safe ways, and
> > > adhere to
> > > > platform-specified API contracts. The details are out of scope of
> > > > this
> > > document
> > > > (but see [LINUX] and [PREVAIL]), but this level of verification can
> > > > often
> > > provide a
> > > > stronger level of security assurance than for other software and
> > > > operating
> > > system
> > > > code.
> >
> > I would put a reference to the other deliverable to say more. If we
think that's
> > suboptimal for publication strategy, maybe we can be more generic about
it.
>
> There's nothing that can be referenced yet.  One can only say it's left
for future work,
> would you prefer that?

I think keeping the existing references while saying "Future work will
address this consideration" is best. Let's give the reader something they
can use.

>
> > Often BPF programs are executed on the other side of a reliability
boundary, e.g. if
> > you execute a BPF filter saying drop all on your network card, have
fun. This isn't
> > different from firewalls and the like, but it's a new risk that people
aren't expecting. I
> > think we might also need to call out that BPF security assurance
requires careful
> > design and thought about what is exposed via BPF.
> >
> > Sincerely,
> > Watson
>
> Do you have proposed text?

"Exposing functionality via BPF extends the interface between the component
executing the BPF and the component submitting it. Careful consideration of
what functionality is supposed to be exposed and how that impacts the
security properties desired is required."

Does this work? Not sure if we have a good example of this causing problems=
.
>
> Dave
>


--=20
Astra mortemque praestare gradatim

--000000000000fadd3b0616b9189e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br>
<br>
On Mon, Apr 22, 2024 at 12:06=E2=80=AFPM &lt;<a href=3D"mailto:dthaler1968@=
googlemail.com" target=3D"_blank" rel=3D"noreferrer">dthaler1968@googlemail=
.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Watson Ladd &lt;<a href=3D"mailto:watsonbladd@gmail.com" ta=
rget=3D"_blank" rel=3D"noreferrer">watsonbladd@gmail.com</a>&gt;<br>
&gt; &gt; Sent: Monday, April 22, 2024 12:02 PM<br>
&gt; &gt; To: dthaler1968=3D<a href=3D"mailto:40googlemail.com@dmarc.ietf.o=
rg" target=3D"_blank" rel=3D"noreferrer">40googlemail.com@dmarc.ietf.org</a=
><br>
&gt; &gt; Cc: <a href=3D"mailto:bpf@ietf.org" target=3D"_blank" rel=3D"nore=
ferrer">bpf@ietf.org</a>; <a href=3D"mailto:bpf@vger.kernel.org" target=3D"=
_blank" rel=3D"noreferrer">bpf@vger.kernel.org</a><br>
&gt; &gt; Subject: Re: [Bpf] BPF ISA Security Considerations section<br>
&gt; &gt;<br>
&gt; &gt; On Sat, Apr 20, 2024 at 9:09=E2=80=AFAM<br>
&gt; &gt; &lt;dthaler1968=3D<a href=3D"mailto:40googlemail.com@dmarc.ietf.o=
rg" target=3D"_blank" rel=3D"noreferrer">40googlemail.com@dmarc.ietf.org</a=
>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Per<br>
&gt; &gt; &gt; <a href=3D"https://authors.ietf.org/en/required-content#secu=
rity-considerations" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//authors.ietf.org/en/required-content#security-considerations</a>,<br>
&gt; &gt; &gt; the BPF ISA draft is required to have a Security Considerati=
ons<br>
&gt; &gt; &gt; section before it can become an RFC.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Below is strawman text that tries to strike a balance betwee=
n<br>
&gt; &gt; &gt; discussing security issues and solutions vs keeping details =
out of<br>
&gt; &gt; &gt; scope that belong in other documents like the &quot;verifier=
 expectations<br>
&gt; &gt; &gt; and building blocks for allowing safe execution of untrusted=
 BPF<br>
&gt; &gt; &gt; programs&quot; document that is a separate item on the IETF =
WG charter.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Proposed text:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Security Considerations<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; BPF programs could use BPF instructions to do malicious=
 things with<br>
&gt; &gt; &gt; memory,<br>
&gt; &gt; &gt; &gt; CPU, networking, or other system resources. This is not=
<br>
&gt; &gt; &gt; &gt; fundamentally<br>
&gt; &gt; &gt; different<br>
&gt; &gt; &gt; &gt; from any other type of software that may run on a devic=
e. Execution<br>
&gt; &gt; &gt; environments<br>
&gt; &gt; &gt; &gt; should be carefully designed to only run BPF programs t=
hat are<br>
&gt; &gt; &gt; &gt; trusted or<br>
&gt; &gt; &gt; verified,<br>
&gt; &gt; &gt; &gt; and sandboxing and privilege level separation are key s=
trategies for<br>
&gt; &gt; &gt; limiting<br>
&gt; &gt; &gt; &gt; security and abuse impact. For example, BPF verifiers a=
re well-known<br>
&gt; &gt; &gt; &gt; and<br>
&gt; &gt; &gt; widely<br>
&gt; &gt; &gt; &gt; deployed and are responsible for ensuring that BPF prog=
rams will<br>
&gt; &gt; &gt; &gt; terminate within a reasonable time, only interact with =
memory in<br>
&gt; &gt; &gt; &gt; safe ways, and<br>
&gt; &gt; &gt; adhere to<br>
&gt; &gt; &gt; &gt; platform-specified API contracts. The details are out o=
f scope of<br>
&gt; &gt; &gt; &gt; this<br>
&gt; &gt; &gt; document<br>
&gt; &gt; &gt; &gt; (but see [LINUX] and [PREVAIL]), but this level of veri=
fication can<br>
&gt; &gt; &gt; &gt; often<br>
&gt; &gt; &gt; provide a<br>
&gt; &gt; &gt; &gt; stronger level of security assurance than for other sof=
tware and<br>
&gt; &gt; &gt; &gt; operating<br>
&gt; &gt; &gt; system<br>
&gt; &gt; &gt; &gt; code.<br>
&gt; &gt;<br>
&gt; &gt; I would put a reference to the other deliverable to say more. If =
we think that&#39;s<br>
&gt; &gt; suboptimal for publication strategy, maybe we can be more generic=
 about it.<br>
&gt;<br>
&gt; There&#39;s nothing that can be referenced yet.=C2=A0 One can only say=
 it&#39;s left for future work,<br>
&gt; would you prefer that?<br>
<br>
I think keeping the existing references while saying &quot;Future work will=
 address this consideration&quot; is best. Let&#39;s give the reader someth=
ing they can use.<br>
<br>
&gt;<br>
&gt; &gt; Often BPF programs are executed on the other side of a reliabilit=
y boundary, e.g. if<br>
&gt; &gt; you execute a BPF filter saying drop all on your network card, ha=
ve fun. This isn&#39;t<br>
&gt; &gt; different from firewalls and the like, but it&#39;s a new risk th=
at people aren&#39;t expecting. I<br>
&gt; &gt; think we might also need to call out that BPF security assurance =
requires careful<br>
&gt; &gt; design and thought about what is exposed via BPF.<br>
&gt; &gt;<br>
&gt; &gt; Sincerely,<br>
&gt; &gt; Watson<br>
&gt;<br>
&gt; Do you have proposed text?<br>
<br>
&quot;Exposing functionality via BPF extends the interface between the comp=
onent executing the BPF and the component submitting it. Careful considerat=
ion of what functionality is supposed to be exposed and how that impacts th=
e security properties desired is required.&quot;<div dir=3D"auto"><br></div=
><div dir=3D"auto">Does this work? Not sure if we have a good example of th=
is causing problems.<br>
&gt;<br>
&gt; Dave<br>
&gt;<br>
<br>
<br>
-- <br>
Astra mortemque praestare gradatim<br></div></div>

--000000000000fadd3b0616b9189e--


--===============8211897329336547081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============8211897329336547081==--


