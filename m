Return-Path: <bpf+bounces-70028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B50BACCD6
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 14:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B6F480D4E
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4202F362B;
	Tue, 30 Sep 2025 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq72BsBs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D824418F
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234875; cv=none; b=NHvzUXg1j3x+17yDmahTL5H+UyGt4Tj5onUGjHcashFObMXvnd/NVIplAR4kqiP1bjmEIq07j9rTq88qkL/mj5q4MJoTZLrXmCNmBgIYhUekBI4ExuFvyE48Z2NK3DzEJ1TpoVH0+BXGx4lWCKjBe6uSDHqVuih6Ey/+TYh1WSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234875; c=relaxed/simple;
	bh=kS15K6B184AgmkKQfDST1OfX/ya+JbvOLcQnxqe2USI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubi3W/pd6/EWeEq3kYQNdsTR71/GiJ5c+CnrDhZ52Qg51CjcHqOzV+LFOfXEkqI7UdPHKbRoKp46H/bPaZQhJHD5p/ZFo9YHlRve+V2NnCi3ZLyS6rnwxocMj0uShii38IeJCSBv+Sqo8KkwI/sujtSux85gbcNSzxKmKXC/Gbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq72BsBs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso3433503f8f.1
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759234871; x=1759839671; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LJginGWKXBBisWxHvwcq7WubQIl9n2gVJaaCC9jHFFI=;
        b=Aq72BsBsY4ChQvrVGQrnWDTvAFcnOyDJlpppgUABFrmLqhNODc+5ofLECQgyDMxNZQ
         oxw14sRQZGAiFRj1T22oCiDBl4MQ7rRDx+XqcSK6+7JEtiuHhvqUAgVyxIKXTUYFJy20
         JY7Y1xPToMPnX3cKLOu68NtfgceHeAoekszjv1SqRK0XNZD59b//43ra2dgyuu8ou8pd
         ayFMKGd/JdMO9UyoGFRnbWUQgZjg3o+jBT201tff0IK6vg0o9CVlb3p+9Dbjy3urtv1h
         TGr/7oV21IhabJpRknb8aB+nbJWLOQLErnm9FM+GDkJJkltZVYqEbu858gR3Zscbgn/1
         vzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759234871; x=1759839671;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJginGWKXBBisWxHvwcq7WubQIl9n2gVJaaCC9jHFFI=;
        b=om2hHZo5BjtJvCu0kAEfxB4ITLqbzf2oHlrLDBIhaZv5EDqpNZUKQu0pbh3aZFRcZ9
         SHxTywiucJG1oIDEvoR1SXBRl575WCw6eXaZ5E8wahdPs4fwmm5H8KlL9pc3nBK9l/jK
         xegd5ze49ovGcC9rrE6uMVvLfl2DdNRaPhCRVpUBYRFUcXzI50WrVFd3t1ukCHgwlbtO
         xvMAr8UdZlBVtLtft/IfmYfY5p+OLZ+zsIUlIyxXIpSUdpmROKtEUpsPZK3Bd4aCFNfi
         NbqwfLzxO7YjyukLtsFUDVrdVKADW/f5fPYQq20iWitxELO0b5gVwBlSsHMVHKKtH0Eb
         He0w==
X-Gm-Message-State: AOJu0YwTz95nj2M9cWRvTs1RU5V+o0Gk0FNMiPBcsCl3K7tdJASx0P+s
	V+IU+pTZsxyUUYdPT358oUq7I9O+dRARhdPGO9r19j8qaP+WlQ6VJtjn
X-Gm-Gg: ASbGncuEYOARx/lqeKqWKdTZohejJXf++b0VIdIDXJAM69C6Rf8BATs4CdJOxmY9TAT
	pMkXQzB5do5pM2Xj7saOlbvVOzm+FlqlyDvu9hob+B+1s1s7hmrpPbNyatXYX+w7v7dG5uBKuMi
	7LZStTMNLGeS2kKbxEBYEZSWSBUZyLxb15fSCVwkLvm6DV1P27/FeV/MuA7iJlzr4oDWjS6wmYz
	Q5LlSnisVvPLgoP+z5QaGf0Pa8zxKmW1PH+NCetH6Xu0ZR1jFKDLTgPXRJAHraWTJt15SnpOLz5
	VRIuboqSM6Tp7QTzx3eOK20AbCqQKS0gditsdhCApxU+We5GAMZx2BAagDITgdXn7YF8yanHOHX
	RE28BpDuC383n9SlyfeXsH03lWDIpOmaEvAxXHAlts41yVrPrQSK1YgvS
X-Google-Smtp-Source: AGHT+IEtv5cN8nmOWybu9fPmXmMWIPO0hXDjWEVRt5I6wce8R9rw7oTvFToNKzZPm2FyxP/oWt4n4w==
X-Received: by 2002:a5d:5e11:0:b0:401:c55d:2d20 with SMTP id ffacd0b85a97d-42411bbeef2mr2459680f8f.26.1759234870608;
        Tue, 30 Sep 2025 05:21:10 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603365sm23193164f8f.37.2025.09.30.05.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:21:10 -0700 (PDT)
Date: Tue, 30 Sep 2025 12:26:51 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v4 bpf-next 00/15] BPF indirect jumps
Message-ID: <aNvMi8T5YvgTFVCJ@mail.gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
 <CAADnVQLvH8bjVYh4XiAvt=8+QKGY3imEuLjm9+zEe3744HM-Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLvH8bjVYh4XiAvt=8+QKGY3imEuLjm9+zEe3744HM-Fw@mail.gmail.com>

On 25/09/30 01:59PM, Alexei Starovoitov wrote:
> On Tue, Sep 30, 2025 at 12:49 PM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > v3 -> v4 (this series):
> 
> Doesn't apply to bpf-next :(

Oh, sorry, I will resend it now.

> pw-bot: cr

