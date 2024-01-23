Return-Path: <bpf+bounces-20141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B37E839D1A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5FD28AE8C
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8825A54279;
	Tue, 23 Jan 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Sgh5QG5C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="kDm5pEPL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RO/B3KIe"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F765465E
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051723; cv=none; b=fak37XorI9P5iwcx+MNJ136S8uSOuy6hCGN6l89Ue+74zlbTZUvsFYQrOi4LA5SDctS+6aE+SHJ4fdtpLMQfrpcJpcAP5Ml4C3DQKZ+og1cdHA09sW+y/n2oWL/qBFUzqEM+Wn5gxaJaqfrSQZDlPiGeJi3s7/Q1rLvSnpT0Wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051723; c=relaxed/simple;
	bh=uBJk0rqIZ+nmf9AbSOah+fJhFYLXD0xM6VMVhtHE50c=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=NdywYgXAijc9zOjuDu8Bw59JPiQOAcoD+rPdeLCBd9XN3w1iVyYCWcrWHQxoowJScwMGss/XEmaG0GdYPfvvzyJtJVg9CP3bP1kxj0w7k5J/CJNHXom8p+yjD/UizKt8V47lOve2K8gEbxACsCTyUWryOv5SoGs+V2c5bNQRGcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Sgh5QG5C; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=kDm5pEPL reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RO/B3KIe reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 775A2C15107E
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 15:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706051719; bh=uBJk0rqIZ+nmf9AbSOah+fJhFYLXD0xM6VMVhtHE50c=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sgh5QG5CTW2ALZdm3VH2BGdCh3EY3bWYGoF+p+z6v+CYcAgJ+8Tvdd7NahNWoqEHD
	 XwSbm7jLi0Q1IZMnTXNa/2SKRPTO+yEjD+loZRoZLKHmBADgHXqxiENOD/xoxcENm+
	 ktElf3lmFez0cgyxC2R3mVTurz1dDBzlNjLvvm3o=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 35C7FC14CF09;
 Tue, 23 Jan 2024 15:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706051719; bh=uBJk0rqIZ+nmf9AbSOah+fJhFYLXD0xM6VMVhtHE50c=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=kDm5pEPLPwnAHSO0nKObfaoolnb5JO35hZihbErnTm3SODei94LN7pQW84QE19yjy
 PuoHbJIlGcar9kjWfEVBCaqPACdormGnS6PuhMF1oQUso6m9H3y24gDQKTapRvvyfK
 BCrh25GJnxbBwi/DjvgcoeEvtAk2ywj6MDOvDYQU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 26107C14CF09
 for <bpf@ietfa.amsl.com>; Tue, 23 Jan 2024 15:15:18 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v5yhJYLbvN_l for <bpf@ietfa.amsl.com>;
 Tue, 23 Jan 2024 15:15:13 -0800 (PST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 906C3C14F749
 for <bpf@ietf.org>; Tue, 23 Jan 2024 15:15:13 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6dbb003be79so4234938b3a.0
 for <bpf@ietf.org>; Tue, 23 Jan 2024 15:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706051712; x=1706656512; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fZsPWFi0DkghszaEQJ3umNHAJEjOSzjsjB52xKFrixo=;
 b=RO/B3KIe70sJ2s989xdb++nYMZx1Zm8N2rGk6qlCakUa0GWt7cFWIRpkWSKEo9R/2Z
 AMH4AdIzX4EnPAF/JbDyGy/HDgcB2Qk9+9q/2NOsSjRy81PIueEbPoNdr+NYvI2WCgDo
 bJ9BD8yjt7bDiZapcU2L+pdhiZS6l/S2QC6ZjycX1dFpilCF0wzLdAevOpW4A61O6Fvu
 DL1v2VJ0LoDTolFbbiGPHM9qovBnxD0F6Antkd6n2I+iWomeKSjsy4sDUXmXVKAkQSso
 jOyLIO0xTybUHb6XlgtqgoYw4WMLmHd/XLGVSXt5wkhvwj4dOsYUVDrXvs08moVbyKeW
 cjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706051712; x=1706656512;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fZsPWFi0DkghszaEQJ3umNHAJEjOSzjsjB52xKFrixo=;
 b=VbGKdUbAg8Wxmpii/9R/f3uGpSO9saNAygyF46e1vSHjmbsY49nPbtI9HqizQEBCZK
 NvragUxk56DEz/PKSdSfPZOKAPaOcwjaDvbl8AwWgXMsCDqoLlSIW9JgFf4ktc+1ekty
 vyT8Cc4Lwd3RvGK7Q07hoywR4VBoU1uDquFmg4fzDrEmZVUSvtQSoB+PaPgs0CQlJaGl
 7fMDCEaz6spSzAHD/d1JEsiExObjlRoH3ynp6ap1edYyHuw+upAURIxmCJwooSAq5/8R
 oZlsSt/fRvDAeUYW62Wx/AHF6GH5b0UUB91lTJAvGl0FjCDDjMvO/rsAkQ0RwDntVwvd
 UIyg==
X-Gm-Message-State: AOJu0YwbyetX+NunRWfbxAf+A8uTGAu+SbLwabPD62wUw+xRlkNM5k4p
 6dsRo5bEldoOytjMaY++VFJcS20vVLL9HcYdcnkxP3OH0XVUsCnz8reAYA+3PA4=
X-Google-Smtp-Source: AGHT+IGzfsXIQbLrPPJkFRU/fb/bmorOZSGrsZfqVMXM/+L3Ts2mtlFXug10aZ0MenlYaPp7Mbw0ng==
X-Received: by 2002:a05:6a00:b95:b0:6db:d315:3781 with SMTP id
 g21-20020a056a000b9500b006dbd3153781mr419483pfj.20.1706051712383; 
 Tue, 23 Jan 2024 15:15:12 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 y137-20020a62ce8f000000b006dd7ae4cd1fsm2031313pfg.49.2024.01.23.15.15.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jan 2024 15:15:12 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
	<dthaler1968@googlemail.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>,
	<jose.marchesi@oracle.com>
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
 <20240123213100.GA221838@maniforge>
 <1e9101da4e44$e24a1720$a6de4560$@gmail.com>
 <20240123215214.GC221862@maniforge>
In-Reply-To: <20240123215214.GC221862@maniforge>
Date: Tue, 23 Jan 2024 15:15:09 -0800
Message-ID: <1f6101da4e52$032b11d0$09813570$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEMYhjceuFr/KIoMYEnffEkkY0NOwHLV0EHAKl61oMBPW6XvrJmTNEA
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/mFj2oV1-Ajt2uSbK-HJIld-wlrU>
Subject: Re: [Bpf] Standardizing BPF assembly language?
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

> -----Original Message-----
> From: David Vernet <void@manifault.com>
> Sent: Tuesday, January 23, 2024 1:52 PM
> To: dthaler1968@googlemail.com
> Cc: bpf@ietf.org; bpf@vger.kernel.org; jose.marchesi@oracle.com
> Subject: Re: [Bpf] Standardizing BPF assembly language?
> 
> On Tue, Jan 23, 2024 at 01:41:10PM -0800, dthaler1968@googlemail.com
> wrote:
> > > -----Original Message-----
> > > From: David Vernet <void@manifault.com>
> > > Sent: Tuesday, January 23, 2024 1:31 PM
> > > To: dthaler1968@googlemail.com
> > > Cc: bpf@ietf.org; bpf@vger.kernel.org; jose.marchesi@oracle.com
> > > Subject: Re: [Bpf] Standardizing BPF assembly language?
> > >
> > > On Tue, Jan 23, 2024 at 08:45:32AM -0800,
> > > dthaler1968=40googlemail.com@dmarc.ietf.org wrote:
> > > > At LSF/MM/BPF 2023, Jose gave a presentation about BPF assembly
> > > > language
(http://vger.kernel.org/bpfconf2023_material/compiled_bpf.txt).
> > > >
> > > > Jose wrote in that link:
> > > > > There are two dialects of BPF assembler in use today:
> > > > >
> > > > > - A "pseudo-c" dialect (originally "BPF verifier format")
> > > > >  : r1 = *(u64 *)(r2 + 0x00f0)
> > > > >  : if r1 > 2 goto label
> > > > >  : lock *(u32 *)(r2 + 10) += r3
> > > > >
> > > > > - An "assembler-like" dialect
> > > > >  : ldxdw %r1, [%r2 + 0x00f0]
> > > > >  : jgt %r1, 2, label
> > > > >  : xaddw [%r2 + 2], r3
> > > >
> > > > During Jose's talk, I discovered that uBPF didn't quote match the
> > > > second dialect and submitted a bug report.  By the time the
> > > > conference was over, uBPF had been updated to match GCC, so that
> > > > discussion worked to reduce the number of variants.
> > > >
> > > > As more instructions get added and supported by more tools and
> > > > compilers there's the risk of even more variants unless it's
> > standardized.
> > > >
> > > > Hence I'd recommend that BPF assembly language get documented in
> > > > some WG draft.  If folks agree with that premise, the first
> > > > question is
> > > > then: which document?
> > >
> > > > One possible answer would be the ISA document that specifies the
> > > > instructions, since that would the IANA registry could list the
> > > > assembly for each instruction, and any future documents that add
> > > > instructions would necessarily need to specify the assembly for
> > > > them, preventing variants from springing up for new instructions.
> > >
> > > I'm not opposed to this, but would strongly prefer that we do it as
> > > an
> > extension
> > > if we go this route to avoid scope creep for the first iteration.
> >
> > If the first iteration does not have it, then presumably the initial
> > IANA registry would not have it either, since this iteration creates
> > the registry and the rules for it.
> >
> > That's doable, but may continue to proliferate more and more variants
> > until it is addressed.
> 
> The same could be said for any new instructions that are added while we
sort
> out standardizing the assembly language as well, no?

Yes, that was my point.  If the initial ISA spec at time of publication
includes the
assembly language then there's no issue.

Not saying we have to wait, just that this which document to put it in is
what the WG should agree on in my view.

> > If it's in another document, do you agree it would still fall under
> > the existing charter bullet about "defining the instructions"
> > > [PS] the BPF instruction set architecture (ISA) that defines the
> > > instructions and low-level virtual machine for BPF programs,
> > ?
> 
> I wouldn't say it's illogical to group assembly language in this bucket,
but I
> would say that defining the assembly language does not need to be tied at
the
> hip with defining instruction encodings and semantics. So my answer is
"yes, I
> think it belongs here", but I also don't think it's necessary or desirable
for the
> first iteration.
> 
> > > > A second question would be, which dialect(s) to standardize.
> > > > Jose's link above argues that the second dialect should be the one
> > > > standardized (tools are free to support multiple dialects for
> > > > backwards compat if they want).  See the link for rationale.
> > >
> > > My recollection was that the outcome of that discussion is that we
> > > were
> > going
> > > to continue to support both. If we wanted to standardize, I have a
> > > hard
> > time
> > > seeing any other way other than to standardize both dialects unless
> > there's
> > > been a significant change in sentiment since LSFMM.
> >
> > If "standardize both", does that mean neither is mandatory and each
> > tool is free to pick one or the other?  And would the IANA registry
> > require a document adding any new instructions to specify the assembly
> > in both dialects?
> 
> Well, if we're standardizing on both, then yes I think it would be
mandatory for
> a tool to support both, and I think instructions would require assembly
for both
> dialects. Practically speaking that's already what's happening, no? Both
dialects
> are already pervasive, so it seems unlikely that a tool would succeed
without
> supporting both regardless.

There's plenty of counter examples of things that exist (whether they
"succeed"
or not depends on the definition of succeed) that support or supported
neither.
E.g., uBPF prior to Jose's talk.

> To Jose's point (pasted below), there are of course drawbacks:
> 
> > - Expensive :: it makes it very difficult to reuse infrastructure.
> > - Problematic :: dis/assemblers, CGEN, LaTeX, editors, IDEs, etc.
> > - Ambiguous :: with both GAS and llvm/MCParser: symbol assignments.
> > - Pervasive :: because of the inline asm.
> 
> I think it would be a lot simpler to standardize on only a single dialect,
but I also
> think the standard should reflect how BPF is being used in practice.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

