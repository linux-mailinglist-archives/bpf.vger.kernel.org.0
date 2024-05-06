Return-Path: <bpf+bounces-28653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B798BC78D
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 08:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9060A28177C
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4DF4CB4B;
	Mon,  6 May 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5oTyFMm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143C446CF
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714976816; cv=none; b=QEW5JVcjvpkkOrEVd6QTEcjWiKGNjDXkH//Shv0P5b+5nAAKX1lg03ZmmYRoXa9WS2R0FtbVzLWtoJ3xaXLl53gjFiV/mCDaKNFjOIZNkJyjmF7q8fdaz620u51dO9bZkLwn7wPeC0gIuM7BkY4nfA4LEiPOJoVg3WMr6Nw9wzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714976816; c=relaxed/simple;
	bh=QZxUKkNl+WmjHpkpCnpIFMAY1RhyZG/GYjNRTd87HGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p58sVElBDsN3SAzTr4ViwLY1J7USgfVpNDtxJNi9wgmG5Kzewd/r0mxaCMwiEfYje7QMaVDP57l+9kAStaJFkXy01ath/R5PGzrlQRgW1LTphOoPIoAIvEC+fDtx401BzmKBcJqmjqrRn1OltgxMJ85WKJn6QVCi+8hQ2bQbJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5oTyFMm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ed012c1afbso11536185ad.1
        for <bpf@vger.kernel.org>; Sun, 05 May 2024 23:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714976814; x=1715581614; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P3Aw4LK2JWQVylKCDX6aJbxQrem5exTWVU2bNm6UVOk=;
        b=F5oTyFMmJYgGax1ETw32RaunNm88YsxYtFFULGvHebOfhN+Cug9HuoM+aItuqohNKf
         6gYvwJFQwvN1+9ua2n1Hhpqmj09A/fluvReCGfNfpOg54Ev6A0EiK9h7y2Jm8xCHH04Z
         Yg9WQbxvW21LrXhL1xUf6qcJmAvVgWIrp8e8y08S9aVtdqaobPPH2Ou36T79XrsPXng5
         rUVz1IFl2eQCDAnBoeuDFK1O09jjDaL8DNjhIuCiEyakcllfiqjWr2FLuFTEsRYcXrXJ
         /dV/taqhPi+Z9ezV6L/RUKnQ445Mbk8+j7SZEn0VgppMekNBVIMn35laOdsDpH/TihgN
         ZBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714976814; x=1715581614;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3Aw4LK2JWQVylKCDX6aJbxQrem5exTWVU2bNm6UVOk=;
        b=UQCGdG+QmuzufMcZ/cbaL9i72RnVNcrsIXcZSgTZ+4uGozbNDtdGwvc/+l6r+gY07/
         VlDUtP6OyKro549fSEBULluebD85bVjWGTZQOI/RBhxVEkDFjnddWb+xTO7mzhHjCaf6
         Vnh7Y218swYFiQGI6ZJLswB5Cd56OXa+KGq+7GpV5O080R5DQy3sOiN1P6ZZKcv+IuA/
         Bw6VEHpieaOPMTpFDe+CQT7GqJL3VI+Zrw8ZvIpunZejOJlWx+Lt4G9Wt70WFnrWLRzZ
         bSba6rnD7d1OHVwAFyfvDRKizxNqINRWbgGFjEHiTUnqqaBGZrja+oGa4fxR0GI5HWYL
         64SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSKR43Tf0owA7GaR6jCC5WPXoynGHiCjzS/PdP+3rPHqmk9fh7cMOprg8qjCbRkBdYOIHBMbq2GdYNv1uMhA5JQ3KK
X-Gm-Message-State: AOJu0YwMvNVbx1M4/CPIaFWuE1PqZCoeawczkgmvH2WPRT8sU/mdofrI
	Ln3jDoNLhybfPcT6kpbi+L5ebYlCS7PGVGqHoYmrpJQlf+LtToCn0nU/DA==
X-Google-Smtp-Source: AGHT+IHZ6SUTl/W6w514DtpnzhhAvggxcHaGhbt00AInbHa71GGHuuZNUlQ58RqpTXHfX0n0Owa4xw==
X-Received: by 2002:a17:902:9f96:b0:1e7:b6f4:2d77 with SMTP id g22-20020a1709029f9600b001e7b6f42d77mr9152793plq.22.1714976814187;
        Sun, 05 May 2024 23:26:54 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:c1e5:c8dd:a422:b79d? ([2604:3d08:6979:1160:c1e5:c8dd:a422:b79d])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e5cf00b001e223b9eb25sm7459981plf.153.2024.05.05.23.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 23:26:53 -0700 (PDT)
Message-ID: <0f9e9023387c147e9362a45365d31ba69b0d1fc6.camel@gmail.com>
Subject: Re: [RFC bpf-next] bpf: avoid clang-specific push/pop attribute
 pragmas in bpftool
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, david.faust@oracle.com, 
 cupertino.miranda@oracle.com
Date: Sun, 05 May 2024 23:26:52 -0700
In-Reply-To: <CAEf4Bza5cmJK-+tK1QJ-SVUWmTOTOM_3gZQ=9yhynU5vE_wWyg@mail.gmail.com>
References: <20240503111836.25275-1-jose.marchesi@oracle.com>
	 <6687f49cdd5061202ee112c38614bea091266179.camel@gmail.com>
	 <171a007587c02ff4a8d064c65531fde318c3b4e2.camel@gmail.com>
	 <CAEf4Bza5cmJK-+tK1QJ-SVUWmTOTOM_3gZQ=9yhynU5vE_wWyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-03 at 15:14 -0700, Andrii Nakryiko wrote:
[...]

> With the decomposition into sort + emit string representation, it's
> now trivial to use in this flexible way.
>=20
> Thoughts?

Compared to callbacks for attributes this adds the following:
- ability to filter-out some types;
- ability to add some pre-processor statements between specific types.

Compared to callbacks for attributes this lacks the following:
- ability to specify attributes for nested anonymous types
  (not important for preserve_access_index).

As I ranted in the off-list discussion, full flexibility is achievable
only with some kind of C AST:
- an API to produce such an AST;
- an API to modify AST where necessary;
- an API to serialize the AST as C code.

Adding such AST to libbpf is completely out of scope.

So, what we are left with is a set of half-measures:
1. a fixed attribute string as in Jose's patch;
2. a callback before printing attributes as suggested by me;
3. two API functions to get a sorted list of types and to print a type
   as suggested by Andrii.

And a set of use-cases:
a. capability to add some attribute for all structs;
b. capability to add some attribute for specific types;
c. capability to filter printed types.

(1) covers only (a);
(2) covers (a,b);
(3) covers (a,b,c).

Still, (3) has limited flexibility and I do not exclude the necessity
to add some sort of (2) in the future.

On the other hand, necessity to modify dump output arises not often,
so I think that (3) is preferable at the moment.

