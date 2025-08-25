Return-Path: <bpf+bounces-66405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5063B34809
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 18:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EBC480999
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D029302771;
	Mon, 25 Aug 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boxD0QEZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626C302741
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141026; cv=none; b=WVXwaTybsYbZwxmcJnwFA6WjeS6xAopfTSSbijlqequFurbc7gjFqVk9RtWHtkhPXBvDglqsU7OXWfS9cAYMNK2QHsH72mohEOUQnjKxTMdwnx9Mk8fxIu6DiEJTlC1ylHWxmH1BnSXXQ2F3JyxPlblv9resjTwX49Z2+VvgwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141026; c=relaxed/simple;
	bh=XrVsn9DELz9y/e9xbywSPHczCME3hJmqCLpf0h3A7Nk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FkyRBrhUBM6n6pCh9BVyr7V1Wr0bB1IYmjdYTq+/O7ySmvoozhwLWmgpm1ZCwVFHepbUnyC0COcdekD3bHzz2j4f8CVrKsgOi6g37Ol+Ql4LUCU+Bv/ZuswfO7rOy7sVQZU/MkSBl4Bojwd3UX/9sOtB1pS74r+aIm1iuYG2HVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boxD0QEZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so3547715b3a.3
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756141024; x=1756745824; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kzx6ult7AB9nPxzDnEVuF5a6hHvnRYg2lUWdYF5qbBA=;
        b=boxD0QEZEb0yH3L7xuFpkgx7b7Q2yrTQA2YfVov459OyEU2ANRs3fKHiZARHwiHsFo
         CqUT+YFJgAU7oByagk27tF53WVfvWbO/yvwuCHcs1Ud3u0EFVhlfL35YAqsJu/fqQ+mo
         LAxbOl2N+kJAEM3myUGo5wgUT3Au3xwarHc2Tjh19R4kydKGdmyMuvhAiSbYTLGlUCGI
         TxDv9SjPTs7Bt6UyAXaU9jbO3ItciMqA6JG0dQy9ABWjGAtLBuVzXcJlOnWkWW+sFoaR
         IYx9mzsPu1oQP+opTHmmeSSZSRJwkVE8w8XKfD5yPuXOog2GgqsmkA2CPS592WpkzJDW
         Ovvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756141024; x=1756745824;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kzx6ult7AB9nPxzDnEVuF5a6hHvnRYg2lUWdYF5qbBA=;
        b=sNplIMn0aqkBzwvi0MPwmpQaD/8TkBbSx2bf45ktDv6BTae/he7oF9s4yq+0slMqOq
         p1Ah4W2fOudEcli9QIuKbboyrwlIewiFk4CSEXBQh+kjRLL9bDq0hTHXry3MtdKevQAR
         41TCRr7ZnHcB4HofY5EV9LDQCD9gC/9aG79HNF8w0LnBtAU+s6/T9fqLmW7QKoZwIvt8
         KituD4kc2PXHWf5rx8aiJkVewCj153N9Ujvm99sWHmiKlDbOX5NYINZ1YhQxwinH9Hbj
         mIvfRJgNG14Wmk11l8cymp1TVpu1jnFls0nk+AZRdDQSxrKxfq29878LA/1KesEappYG
         hXHA==
X-Gm-Message-State: AOJu0YxThvMTUyMrE4tFAzwttA6VpWnyTh1j8vhNLKAYBUYjSB20OB1T
	McNxj+jZGYFGBEd/L6tSQ5UH80H5FpwIJh8PtAaGqwzx6OVyjR1F0eZ/
X-Gm-Gg: ASbGnctM91HYfN4P6O2vKrsjssQdtE4YOTn7nfivZgiV3CfqN4C6KLBFWkfgjvU2sa2
	oclAUkYGSUXwoNrlRR6lpTv7Pdx/gu82gST2XTsVhinKx6WXTaAKCHaPJc4iKJY6YUCd5yT0bkU
	HjXgVHuhNRTkvjQtznhd+vJwG72+WcQyircW3obPvieKt3ypnnv1bY21qWMoQJCFfJnkLau3uTP
	qmd7EBcbSyxr5ivZomJlmO+gl4XP0HtgCxiyehH3CstfiKGzx5rByhiIzz2CBE80ElR86ykGoS6
	yGwAgZbVSfHpp4cvImjcjaALZJH9Vbx5Fd9otId5aE7oYuvJFnyXY1zQ6QXqAorxNJTgFSOaykQ
	Tolic1yuaf37+uEtRGiUihCNaYrCU
X-Google-Smtp-Source: AGHT+IFFR5y4JdtzoqwMxsgjkANK77BZHBmK4SjpgTdpWdR3HpCa5wHYqF7+mAfoJNNQWoZJSkODaw==
X-Received: by 2002:a05:6a20:2585:b0:240:ed9:dd0a with SMTP id adf61e73a8af0-24340d11bf2mr18167699637.35.1756141023740;
        Mon, 25 Aug 2025 09:57:03 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::947? ([2620:10d:c090:600::1:48d8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e159b157sm3408790b3a.25.2025.08.25.09.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:57:03 -0700 (PDT)
Message-ID: <af62c4eb4a098ede717767376321520bc8537826.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki	 <jakub@cloudflare.com>, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>
Date: Mon, 25 Aug 2025 09:57:00 -0700
In-Reply-To: <176c9fbe-2d0e-467e-86b2-358ec7a9d7cb@nandakumar.co.in>
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
	 <8834d8df16f050ec9e906a850c894b481dfa022c.camel@gmail.com>
	 <116ef3d2-51a5-444c-ad51-126043649226@nandakumar.co.in>
	 <0ed1ad1d73d2c4468b3a02b3034b7dfd6e693d66.camel@gmail.com>
	 <132d5874-9a1f-496f-a08c-02b99918aa59@nandakumar.co.in>
	 <5d15719140555e1213192aee9078efbd3ee43507.camel@gmail.com>
	 <176c9fbe-2d0e-467e-86b2-358ec7a9d7cb@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-25 at 22:26 +0530, Nandakumar Edamana wrote:
> On 25/08/25 21:54, Eduard Zingerman wrote:
> > On Mon, 2025-08-25 at 09:46 +0530, Nandakumar Edamana wrote:
> > > Status as of now:
> > >=20
> > > DECIDED:
> > >=20
> > > 1. Replace the current outer comment for the new tnum_mul() with a
> > >   =C2=A0 =C2=A0cleaner explanation and the example from the README of=
 the test
> > >   =C2=A0 =C2=A0program.
> > >=20
> > > 2. (Related to PATCH 2/2) Drop the trivial tests.
> > >=20
> > > UNDECIDED:
> > >=20
> > > Instead of just doing tnum_mul(a, b),
> > >=20
> > > a) whether to do best(tnum_mul(a, b), tnum_mul(b, a))
> > > b) whether to do best(best(tnum_mul(a, b), tnum_mul(b, a)),
> > >   =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 best(tnum_mul_old(a, b), tnum_mul_old(b, a)))
> > I'd drop both undecided points.
> Shall I send v5 with the decided changes then?

Yes, please do.

