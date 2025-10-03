Return-Path: <bpf+bounces-70280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4A3BB6277
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 09:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A0B1AE0892
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 07:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026CC238D42;
	Fri,  3 Oct 2025 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkCpC8nX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D732F5B
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475797; cv=none; b=hIzhRK/IJkmQZ+C/n/7BjHfFgreZUU686blvMzID/+J4lLD/spOR64kbbsmk2UptB5au6+87ieFy9ca5gbS7nnihZa546ZAE1RqaETXnCeRn7uF5t0+dGBNv0zNKrStHnPqKDOuM1r2MY0i8XDnIjUxYMRtH+FaTruHD2M3YUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475797; c=relaxed/simple;
	bh=c801An8+Rwn4OwgF9PCcbOkYiAi4Ys+kQW9QCaIAu34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaTZpl/0I7Y4hAA6WxVALyFh+IilyGWNHiKyKQFotEc+uyw/EQBh0Ezsow58iF1y7YJtofWzMZfjN0SpH67D3XWg3BQ2E5kBR0j4SCrcraudMiiDIvyFz+OVJJC8sdBodhOKAzWDWln5WL+0OBUCkb3kgm16gCT0MxrS+HGHczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkCpC8nX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee1381b835so1585408f8f.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759475794; x=1760080594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1i3xulZln/n6sDR7s5KFyTZRx4MkVX3MQWtcLEFO64=;
        b=MkCpC8nXDiRcDJIfgIK3NeEfmQ237RvtI/ndv3uSFTojYy8axlM5z5ik9u/dKz14fH
         1PbYbJt1NuhBxhP8IrRYgcRIfmzFzKUQCQFNypmLNks96hn0bbmIkMYUNM9zDyGvgppz
         MIf+kjTtFep6ohw5J007gESh/SHl0bZPrDK8/+MrugAvCfyMR36a0zzDq0la/Vt8UE5G
         YlBu7KF2WtXxBiMgVmdwVUk5WmNj3wXQhke/h5e2mylY714x8sTO+TA3LGSOmK/NIO8x
         hpCda5GtWHICSGLOv4n25sGZSuy/18vpJNn+U6ejpPBax5reQbpgih4rXMrUsRB4ZVRu
         xnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759475794; x=1760080594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1i3xulZln/n6sDR7s5KFyTZRx4MkVX3MQWtcLEFO64=;
        b=s2DMnjB9X4SEzbtcSF8qMi3uStlSiD2Kht1IoiNXMHik5UwKMXjp2Mop5ifJeNKbr6
         SpL/2J6Y7YevWUaqZ6Vf2Ekyy+vL391N3GKhhdlDaGDDku+3NALq7Nmr8AN5nJRJgSUU
         5leesvgPWO24HVAsQGrVHMR99NtRi0RhYPaN7ODNLQNtNYuNC84utzk1jkyh4k7dUhKh
         pw91Fg7bl2tz2djfg+JW6ZY8oj5lSDTBWbN7pBwN2l3S5qlRPDYy0xfO2ttBSNg0Il83
         n/NJhiby5GI1HqOGpiBz+TyFInR56fcDkNUfOYqLmzwjHaEtDFSyWn9Si5Gc4w0mMEca
         z1Qw==
X-Gm-Message-State: AOJu0YxT9q9fGP2XnYPD7f7Bc6JgceAvsCfi6v5hlE5rIr2C5lvE9FhU
	CLyGjB6ZN0Xh203/hFG2wUTYljChx2AntqRS/12oXxKbUCph1pNMx/1A
X-Gm-Gg: ASbGncvqTYUbALm5tt2UvscTPHweEf6R2ZBI6rp4GGmIvXWGVRnGSbOxP9pUZePeEy7
	vjTDUHBGlb3/EIeP2QO/VPxRebnublLVcp2OshnrtzDbZ6AIi7pwJWne057Yox4/b7hHGVLACy0
	t5CpsTeUZ19PdCgkqbaCbBwEDb5D4j/PQVQwNuZhTvb/363ceEJQhd0MVyJgKrrpDXO2At4/0Xt
	k4gJjNdSJeZ0GSSEPFzNDU7/hXOUFgMvdJN/4+6r1/OXBm1FTAewAN82f77TBPsDqBT540rQJUs
	eokFei1k3os26w9f1tMUoDwvbtV9GK2Sf7/3wOIhICkQciMGkhhxEB6sLQv0xCGapS+0pgZTS48
	aDgkrvTuNKRXaRcxoD8Faz356Y4uBhOpRxx9B4biAW/6m+ThukboBlzKMCH/YFniWCII=
X-Google-Smtp-Source: AGHT+IFxFdocpYKDugodIxYN3iruEGRqLObbGCaRHoYqQnc9085FbWLGvModmSf4HA9MDlr1IPBG+Q==
X-Received: by 2002:a05:6000:43d4:10b0:425:6865:43fe with SMTP id ffacd0b85a97d-42568654da3mr623317f8f.2.1759475794133;
        Fri, 03 Oct 2025 00:16:34 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4abcsm6637482f8f.53.2025.10.03.00.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:16:33 -0700 (PDT)
Date: Fri, 3 Oct 2025 07:22:52 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v5 bpf-next 15/15] selftests/bpf: add selftests for
 indirect jumps
Message-ID: <aN95zMTGafXnLXTc@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-16-a.s.protopopov@gmail.com>
 <193001218286e9b833d44e3ecc2f7e3cee0b4011.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193001218286e9b833d44e3ecc2f7e3cee0b4011.camel@gmail.com>

On 25/10/02 02:07PM, Eduard Zingerman wrote:
> On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> > Add selftests for indirect jumps. All the indirect jumps are
> > generated from C switch statements, so, if compiled by a compiler
> > which doesn't support indirect jumps, then should pass as well.
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> 
> Could you please add proper unit tests in the next revision?
> The way I commented in v3:
> https://lore.kernel.org/bpf/8f529733004eed937b92cc7afab25a6f288b29aa.camel@gmail.com/
> 
> [...]

Yes, I plan to split tests into unit tests and libbpf tests, and aslo
add tests to compute_live_registers. (Just, as I have mentioned in
the cover letter, I wanted to see that kernel part doesn't change too
much before starting to write unit tests.)

