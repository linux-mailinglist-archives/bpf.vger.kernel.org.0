Return-Path: <bpf+bounces-69033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C9DB8BB75
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7E55A5BFE
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0BB1D514B;
	Sat, 20 Sep 2025 00:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngg3OnaW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D5189
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329895; cv=none; b=tPmv98HEx5Wbd0YGmDMyFIgtdxb5IlNJro6QOH8S3hgMZv04vnR0HixbbK8KcfhWDwD6AHOFtAI/1nUGZqohToQWejrZVeYIxOEChg83tntW4eTKUOkTQ8w9XVmfn0951Ghb9+c7mu53djcx5601OMvwgJ4RR8hUYm2BNU4nykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329895; c=relaxed/simple;
	bh=Iai6wRz486L51hwOayj1XiHEmU2t+IFD6qv3XQjOv2Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YCUcA3tsfe6h117UQgdhmVSHrhhBCkEhlFQPPkJqLsVZ8r1uyKqmzEQNrZSKe9rt5A8heVigGC9Tiq9wvy90neY2tiOC41u3xTQvC2MEhcVhv6HASG1WPfTx+KpHZKesQqQV07EeR93KT+C63L8EM5v1zlVuOP4tMDnVIUrcQT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngg3OnaW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-271067d66fbso1890575ad.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 17:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758329893; x=1758934693; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iai6wRz486L51hwOayj1XiHEmU2t+IFD6qv3XQjOv2Q=;
        b=ngg3OnaW53aEz20fuSaraRiXv+ufSOAFjPmQwhU8xcNtW1FkRUiw3pMpHYkRv34ZIt
         gAiTNm0Y1vU+Q6js7xGrJXM/O8KC+WqPtKeR2OFsEmWgZ29f7xPQ03Wc+aQvOqSHFzjo
         7YMuTu2RYtBEG5LqCXVyyu8a04lx4Tz1ZAfLqQoSp9N0QXaWnB+WCiYx08hoIufdpxeD
         fsSe9MGJWKTsMpApE1HJKa0Heo7JL7cpIz/BMwToGOULYuHJQKa74Q+1Rr1I9oBYERU+
         k0J0uZ5JbqqG5TXqvRNH5rpkDh9DzvdZmqONftol4R5ZDZ4SsjOaLhg3qkA2HPdjSbPP
         C/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758329893; x=1758934693;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iai6wRz486L51hwOayj1XiHEmU2t+IFD6qv3XQjOv2Q=;
        b=vl0jMoJVS7etQSW96LHOmhrHlztOZnN0k1f3oUth+7dd9PNysp54QnNXrAeXKN9Nje
         88GgSD86GTI3kHReuCHLXE8+Dt3ACjns7TELNc2thbAO6noEAU1ci3k2kipUxjkreK/P
         dTSOi0iLoe6/g9K4WZUGeGMyygykp8JiDy/MkrlZaGot1dPhaqQZiEn1JjzklF2L/S5i
         c+ylKEWmN3G0RZEwpKmeT1mMl0uiDGQHjCKkMPQUFHsjDh+RNfB1AEmqXpwkubmOaCw7
         kR/NlLNA2cZDZsqoXGQQN4AKK5xWRxngMiMOzeZFWMR4zwu8t+fckKGymq2IDleeHDe6
         JHew==
X-Forwarded-Encrypted: i=1; AJvYcCWm7MRdrBmEP01emsctC85Spxrmu3UgRy3CxLh2huaO0/D65C5ccAdhjG/PywxgSpsYr4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7efy0FUre9Zn+jjR+bWYv8n3ZsjgVkk29xkLGmpJtov8fqZj+
	q6M1QZRA/0tI4tfyurZnvQAoZ0HjHY5nSzQAhNBGudeGdMKn+Dwimnfi
X-Gm-Gg: ASbGnctyDd4nxRdErByos4sBJb/yyTmSjIDy+nHlDRzEYLF74z/PAO+m+xnvZ+dwrNj
	FcEOBFny31HCkER/rx86ABsDFxoXLhzvtpdv7ryPkht1cwPDlkyXBuQqDgE2t3wM7CZvjz8xg3T
	Fx49YypNlI9Sfz3ysSxy2uRXVQuBgf/fhNGuH+qxRJ4kmytxOUZ9T1dvSq3u8EDutkwY7PQUeDK
	Tcmb+dv+0eo+E7SuHlT0CPHF+YyrDJEMLrsuW7th/jhN7f1a6yXkMr+WgN7ooacJfMKIm/UH/Mj
	KMgnMavU6GKo5RoJACL9/YtDDoaKR+LfWGM4ni/s5R4+M7OpxHqeaV9vseirob4iJf7C0fzbtMt
	RruGROA5QVnfHomH00Qo=
X-Google-Smtp-Source: AGHT+IHDFjgTtNgTwqeZrPno98rEZQ48O4ugKQF3iej7HxMt/u4solclxMnjqZctFv3uEL4gJneErQ==
X-Received: by 2002:a17:902:f645:b0:269:91b2:e9d6 with SMTP id d9443c01a7336-269ba52d9c4mr63184445ad.46.1758329893043;
        Fri, 19 Sep 2025 17:58:13 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060619245sm6693637a91.1.2025.09.19.17.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 17:58:12 -0700 (PDT)
Message-ID: <71cc9b1aaae03dc948f2543b44efab2ed6c1b74f.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/13] selftests/bpf: add selftests for
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Fri, 19 Sep 2025 17:58:10 -0700
In-Reply-To: <20250918093850.455051-14-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
	 <20250918093850.455051-14-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> Add selftests for indirect jumps. All the indirect jumps are
> generated from C switch statements, so, if compiled by a compiler
> which doesn't support indirect jumps, then should pass as well.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Patch #8 adds a lot of error conditions that are effectively untested
at the moment. I think we need to figure out a way to express gotox
tests in inline assembly, independent of clang version, and add a
bunch of correctness tests.

[...]

