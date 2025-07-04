Return-Path: <bpf+bounces-62402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879C6AF939E
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 15:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15797175D19
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD8A2F50B0;
	Fri,  4 Jul 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig7b0SPI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BDB1E4BE
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634400; cv=none; b=XFFYkn0rr6uNhVllJcMFsz05kCMHqZ4osTgKqM++8Jp1hjvvAFAF2pAr14QLP/YeWaOKYpoP2Gq9gbTUsLnio/InfywLzcDBVCBQz/Z+d4RL7OBlJdsXFV26Zh6ziUSWAGLd+2655WVvqchFHt6/hznlONAZcuK2N2C/MQuz70c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634400; c=relaxed/simple;
	bh=EEzAX4lJwRCsvcNkPFqNPPwuxBJmQtJPA6rCzWODgII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqqbYc1/8u3C+fphx9E0xAZcxqt6R3ncLjIEe9VLUZRknD8nhuDVtpUGsCRz5svABGY9NpmkKiyaByksi8vMuCLeSF2VLO/zlILHx6VD2r5YUEPkr6mxfoUlZC55rNkKdG7Xrx0KFBzF9ipLHTJX1U+nlTDemttfEniX96AKnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig7b0SPI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so4850065e9.2
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751634397; x=1752239197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VbDmVoB6QYzHRm1DxDCdoLuUxkx3HxhnJfz6vgwqWHw=;
        b=ig7b0SPISzaH5iWJBpzkDiYRdcVS8/cEiXBwLJlxlsHORZdy4j1U6ECJAITIftFYMV
         wnHI0fEP9S7YI7VJ2Xz0TML8Ihp3Y7TaBIjcfuGvqKRtAL39TSMSNcnH0luoLZUKXpMI
         zONC2ezs4HJuxHVzMe/N2mx2xUkPNWFglh9Iutz6x/FU1iYv1CuyISjgj/TPnahGLe+K
         AAcMwwnJ3qDZT58LBj3zthtLvjaMneg1oNe6WN0sWDI/r672xtUVmDNU61fuh1CSUonF
         YWTHBPgkI9F+e2v13Jaf1165aDKYIol5eDTcyAbenQQDGb6mdGPNJfgMNiUUkkFoDBRK
         xeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751634397; x=1752239197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbDmVoB6QYzHRm1DxDCdoLuUxkx3HxhnJfz6vgwqWHw=;
        b=SyVbdtjSi1tMprQIs8iMiZ0JFbH539bjiemmUqoGdDXSTwewaqHgCa8LmYPVNn/BkV
         lZh62qtnjjz+4YDm4tL0uktE4Zfhttzohg+gRjwtFoqKD3dtPpoapEIIcXBgm1JuEeNr
         uESNhqZFup+Tr2SCyl2y970sBJbLVtC5rxtfRxIn7Jr5p6DRlrzAdEzICXOfm9HVFFQP
         Z6Q+TvDYnXrZmrnLsgBNlLbAaV+LFD1YJ7BHvsyyKgoM4OM8clrRql45n1RVC4l05Rrf
         sXEQqFI7KkeJ34YFct0ufgY/6wMSWS2AQOLWgG+NCgDFu74XwaaW0Z4wWXzS++jPODec
         jBpw==
X-Gm-Message-State: AOJu0YwY2TJ3g6g/gPmhkyE3Go6TuGYgWwH8V4dQwA/HY2ae0a3q79Ii
	HEXrg4EEcYI5kcR6gJx6rBAiLvQgyQrJ2/eWkPWStWpN7O3HwLVXZLa4GWgEXzzw
X-Gm-Gg: ASbGnct5cMn/uZWsX/+zcl3bxXUOFfIrCBIEj9H87dILw29E43HW4hy/wi13VdfqA0B
	2IjfvdPvsPNBzxqItSH7ohVSUr44/SClbDAFAHzbGNMe8J+5EkrRyR/e5q5v51Gwni04YetxuvU
	72Ru+IdQ+sZwY+2dINkXNhTwA/2Tz8eABxkhu9aFrhpd8iMDMWYbldvR3CPSc1ETCQRjg9n+Tb0
	fRR6qzoglI50aE4Ep05vzado1729X4H/YR48EKxQm/pOR/b/LY29yopUpP2Hw6f45BNH/X5rHEr
	qPC14ayHyzHCHbsxHdYlc8pi8o9yjogj0WWn5gan3KYKfDpOwgp2Yd7k4dwwAjZDBvJRbF+EYjV
	/uFyk/J3hq1wFX98DRcrg82t94XuSkdlwUA87/INCF1YLnJZFbg==
X-Google-Smtp-Source: AGHT+IEZqvVwyieHO5BJ7Y2gBdtBG4zAux32SmUHpQaItIY+jWrrYAlguBR59+YH9k5i2rFhwmJV/A==
X-Received: by 2002:a05:6000:240c:b0:3b3:9cc4:6830 with SMTP id ffacd0b85a97d-3b4964f7c5fmr2469846f8f.48.1751634396751;
        Fri, 04 Jul 2025 06:06:36 -0700 (PDT)
Received: from Tunnel (2a01cb09e0612408276c52a81ead4591.ipv6.abo.wanadoo.fr. [2a01:cb09:e061:2408:276c:52a8:1ead:4591])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97708sm2475114f8f.50.2025.07.04.06.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 06:06:36 -0700 (PDT)
Date: Fri, 4 Jul 2025 15:06:32 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Negative test case for tail
 call map
Message-ID: <aGfR2NqZWL1c1-Mc@Tunnel>
References: <1f395b74e73022e47e04a31735f258babf305420.1751578055.git.paul.chaignon@gmail.com>
 <7cec754c8d4cc2d93a50e9091d7ccc7f33d454d4.1751578055.git.paul.chaignon@gmail.com>
 <ad62770379cfcb7426a9a765bb59edb6d5d91fd1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad62770379cfcb7426a9a765bb59edb6d5d91fd1.camel@gmail.com>

On Thu, Jul 03, 2025 at 02:55:01PM -0700, Eduard Zingerman wrote:
> On Thu, 2025-07-03 at 23:36 +0200, Paul Chaignon wrote:
> > This patch adds a negative test case for the following verifier error.
> > 
> >     expected prog array map for tail call
> > 
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> 
> Nit: selftests/bpf/verifier binary is considered obsolete,

I didn't know that. Too bad, those verifier/ tests were easy to extract
and reuse as syzkaller seeds :)

I've sent a v2 with the new test format. Thanks for the review!

>      new tests are mostly added as a part test_progs binary.
>      E.g. you can add a file progs/verifier_tailcalls.c,
>      register it in test_progs/verifier.c and define
>      tests using test_loader framework, e.g. see
>      progs/verifier_and.c.
> 
> [...]

