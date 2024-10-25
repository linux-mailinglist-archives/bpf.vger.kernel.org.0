Return-Path: <bpf+bounces-43161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 928929B04C3
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 15:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35C01C2030A
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520BD1FB88D;
	Fri, 25 Oct 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZUSQdJf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938BA1DFF5;
	Fri, 25 Oct 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864585; cv=none; b=raoxfBdbiDeieiNnk9IZ9SuQ626XPaEzex0AlLk5Gn1dCwJCT+gnxPL2zoxt7MK7yCCJoQpnu7bi59vLi3mYBG7xxFDguTIt+ttyViFZySmt2R5KluGiBud0SGtEG9e06zx7rAoX9sz7vb3292rGSWSM5eJ7d1T2bzVrMqRrOPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864585; c=relaxed/simple;
	bh=zKEwOFq+EedN6EAwXtsg7YlRMhj47oRVAezZTHhLCuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoP9Me+kts13pSqz88mEXsvEjd0p3t72RPFE+A1qFnFGsiZASgQFMyHiM3XDA4LoieYGu6Q4ldEukqGziwOTJzpQtGU8fceSUqFBc/xCsQbFeu5DTq3YdVLfpWp4nEQIO9k/eIkxZn+WAs1Th5QE+4MO2guczbadqD49EwQkvgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZUSQdJf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f629a7aaso342476966b.1;
        Fri, 25 Oct 2024 06:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729864582; x=1730469382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld/lzUpMzz/O/gUyxVTjcgsBVURqpGeoKpNyId9bOgY=;
        b=aZUSQdJfvecwlvNnZKn+8d058XGqHjjjr/qtM0umdCo1SXIEnq/fIGmborA5ggjHLa
         5XGUknVP6jCh5AwfsCbo9uuZyRSlD7q9VF2fs+f4S56XqYF1jrxWqSVvCsHnW9usTlD4
         +fFDmeHZQpFy2A2KR7rCw324qywRvThk0Xb4Rsk+j/64PsiRPGr/IKln64OsytfQl1P3
         eP87k7I3MwMT20SPwK24oRlWx8OTygFxioyctc3Kxa6Akc4mmOM7gnVrFqXomoiXunZK
         xETKsfzgOBAgIiP5cWW2wvdCMby+ezwZxWWoAB+a4rdPt/EaPNcy+hpqv9hjrWg0Gplw
         By4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729864582; x=1730469382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld/lzUpMzz/O/gUyxVTjcgsBVURqpGeoKpNyId9bOgY=;
        b=nI2g0k+ddC+qTnxjIu+UBcDETLz+uqIwlIz66CHgDaq4otUmvVr+vUfAC97YscGYDi
         xS8in2WtJnCz87ddAoI7qZ4FR09++oQGENpH/kFoDVVGiaTiag3TNcbP6M8yJBZ5rC/m
         hyt1lm5DXb5Qe+loMzyAszZ0zIntJMe/dD1Xb9KIKNSRviApNKr8fMegujTBd3di/t1v
         Hir0rgScywhvJQVVpeBWTLaYwxJpWeTZ0hZ3cHbjixF2x4FXN9TVDWZpbL+6x8XDSt+Z
         fzYrdL090hCsuyRMKq+lpK8tsP9pvvvMox9RE5Q41q+HltUmko1X8z47xwfKvDGD9hUr
         LCPg==
X-Forwarded-Encrypted: i=1; AJvYcCUvhsiBYA6M2flYtgQtr9sP1cm1ENV0/U58MZYEtQhp8sF61sp1KJPZ7x2fcH679MIQgeoZGCxZpfIKRjaD@vger.kernel.org, AJvYcCXGKysrg1SjJD7y8UULS2ybBU4mfxdnzTcHGuDlCjeeT7LR1WHnzQ7DqcdnenpMOWS9WWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSEvSZ1Xfc+OJ3UtKgZtGTxKBLxUOP9r7rehNWGU97iyOvU75
	0W0ZuN48KbvWjoxTj0w/ARv41eVO17IvpWydDYAClWfssBicoLrfoq7f8KaWzqw=
X-Google-Smtp-Source: AGHT+IHHBPelfDRmV3ElN7dO5ltfgT7F82NL64uGZgXfpVrJ4bY6gR1Y7aYl4TnBcYL8RwxpvjixVA==
X-Received: by 2002:a17:907:7ba8:b0:a99:f5d8:726 with SMTP id a640c23a62f3a-a9ad1a02091mr584361666b.23.1729864581671;
        Fri, 25 Oct 2024 06:56:21 -0700 (PDT)
Received: from andrea ([2a01:5a8:300:22d3:a281:3d89:19cb:ed96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f029559sm73501266b.58.2024.10.25.06.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 06:56:21 -0700 (PDT)
Date: Fri, 25 Oct 2024 16:56:17 +0300
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: puranjay@kernel.org, bpf@vger.kernel.org, lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Some observations (results) on BPF acquire and release
Message-ID: <ZxujgUwRWLCp6kxF@andrea>
References: <Zxk2wNs4sxEIg-4d@andrea>
 <13f60db0-b334-4638-a768-d828ecf7c8d0@paulmck-laptop>
 <Zxor8xosL-XSxnwr@andrea>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxor8xosL-XSxnwr@andrea>

> But the subset of the LKMM which deals with "strong fences" and Acq &
> Rel (limited to so called marked accesses) seems relatively contained
> /simple:  its analysis could be useful, if not determining, in trying
> to resolve the above issues.

Elaborating on the previous suggestion/comparison with the LKMM, the
"subset" in question can take the following form (modulo my typos):

"LKMM with acquire/release, strong fences, and marked accesses only"

[...]

let acq-po = [Acq] ; po ; [M]
let po-rel = [M] ; po ; [Rel]
let strong-fence = [M] ; fencerel(Mb) ; [M]
let ppo = acq-po | po-rel | strong-fence

let A-cumul(r) = rfe? ; r
let cumul-fence = A-cumul(strong-fence | po-rel)
let overwrite = co | fr
let prop = (overwrite & ext)? ; cumul-fence* ; rfe?

let hb = ppo | rfe | ((prop \ id) & int)
acyclic hb as Hb

let pb = prop ; strong-fence ; hb*
acyclic pb as Pb


For BPF, we'd want to replace acq-po, po-rel and strong-fence with
load_acquire, store_release and po_amo_fetch respectively:  Unless
I'm missing something, this should restore the intended behaviors
for the R and Z6.3 tests discussed earlier.

A couple of other remarks:

- Notice how the above formalization is completely symmetrical wrt.
  co <-> fr, IOW, co links are considered "on par with" fr links.
  In particular, the following test is satisfiable in the above
  formalization, as is the corresponding C test in the LKMM:

BPF 2+2W+release+fence
{
 0:r2=x; 0:r4=y;
 1:r2=y; 1:r4=x; 1:r6=l;
}
 P0                                 | P1                                         ;
 r1 = 1                             | r1 = 1                                     ;
 *(u32 *)(r2 + 0) = r1              | *(u32 *)(r2 + 0) = r1                      ;
 r3 = 2                             | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) ;
 store_release((u32 *)(r4 + 0), r3) | r3 = 2                                     ;
                                    | store_release((u32 *)(r4 + 0), r3)         ;
exists ([x]=1 /\ [y]=1)

  (On an historical note, this wasn't always the case in the LKMM,
  cf. e.g. [1], but be alerted that the formalization in [1] is
  decisively more involved and less intuitive than today's / what
  the LKMM community has converged to.  ;-) )

- The above formalization merges the so called "Observation" axiom
  in the "Happens-before" axiom.  In the LKMM, this followed the
  removal of B-cumulativity for smp_wmb() and smp_store_release()
  and a consequent "great simplification" of the hb relation: link
  [2] can provide more details and some examples related to those
  changes.  For completeness, here is the BPF analogue of test
  "C-release-acquire-is-B-cumulative.litmus" from that article:

BPF ISA2+release+acquire+acquire
{
 0:r2=x; 0:r4=y;
 1:r2=y; 1:r4=z;
 2:r2=z; 2:r4=x;
}
 P0                                 | P1                                 | P2                                 ;
 r1 = 1                             | r1 = load_acquire((u32 *)(r2 + 0)) | r1 = load_acquire((u32 *)(r2 + 0)) ;
 *(u32 *)(r2 + 0) = r1              | r3 = 1                             | r3 = *(u32 *)(r4 + 0)              ;
 r3 = 1                             | *(u32 *)(r4 + 0) = r3              |                                    ;
 store_release((u32 *)(r4 + 0), r3) |                                    |                                    ;
exists (1:r1=1 /\ 2:r1=1 /\ 2:r3=0)

  The formalization sketched above allows this behavior.  Notice,
  however, that the behavior is forbidden after "completion" of
  the release/acquire chain, i.e. by making the store from P1 a
  store-release (a property also known as A-cumulativy of the
  release operation).


I guess the next question (once clarified the intentions for the R
and Z6.3 tests seen earlier) is "Does BPF really care about 2+2W
and B-cumulativity for store-release?"; I mentioned some tradeoff,
but in the end this is a call for the BPF community.

  Andrea

[1] https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/StrongModel.html
[2] https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/WeakModel.html#Cumulativity

