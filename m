Return-Path: <bpf+bounces-52589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA646A45059
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 23:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E13424A73
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964042192F3;
	Tue, 25 Feb 2025 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXYsGvwj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57AD218AB7;
	Tue, 25 Feb 2025 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523045; cv=none; b=l4n5d2NBJfdOjZesRltDVlVBsQrk0MjPcuTLimBKdR87XS3sZ/ZVul2hkDleop4VOYePinloMy6ReGEAnwPxJLlgmOC+YUBY8bC4KIcRtlwdGhsk6oeaypeXYCnMQf5+aLOg1ThPUb4saqr3GGkcIKnL313EeFOdmA5FzspXGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523045; c=relaxed/simple;
	bh=aJyw/zDozasxeCGZNcT4xes8tZJoYl8UAvo9PCUbqrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdtKRyBqtkZGjjzdBO4w4c7rQhNbWr2pHHm2F26fcvYV7KgOeGwPEQIdR4giOdfKb3hBKFOC8UBdI0vPmqbe7jhak6+YyXo2zOO/XF9Xs0tLmBRVJXz1Z0PUEvtV0S3ElpraF472kTppTZc5U6mztHzaEtVOmeKm0p8SNA1fAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXYsGvwj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22114b800f7so123766155ad.2;
        Tue, 25 Feb 2025 14:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740523043; x=1741127843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ3kkfSQrGW2tsyUIthqhvss5dDFaiobb45er8//cpI=;
        b=YXYsGvwjMaolAulyqjPnE8swxTHTj14CASPdTFBVo1ND59rSi9Jh6wvUfy6U95jxx8
         m1sfXjZkZ0U1UVrsZK6L/sEgjXf5MF4zDw+DH2DmqhiLg3Kbgo6UrsU2FzHwVWU8RwTl
         z5W3DxZr7S0VsL2M1qv0DQe9NjXW0WKZpdJDihHkrni/pkcqRkZE78qeVS14dc56PkSw
         FhTsOUrxorhLlan9HQATDPa9Ejr8Shg4dM5EMt9N2RIxw3dERZ6eac2cthoT+FlkmDT7
         AWc/TpFnZEFKdb1JurYR6b9RCHWiHfif/AKz0czYbYsHNN1p31/htgqzFKTJ9g98POLj
         TnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523043; x=1741127843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ3kkfSQrGW2tsyUIthqhvss5dDFaiobb45er8//cpI=;
        b=vMkDfJ1ROl/brEW1NnLHhC5N3Bk41IuFBKaL/iwl/kUjr21Nrn0N4To3pNGJ47D21N
         SQ/7sHMRqMs86T0Z9S3UJHh7Ot1AC+SM9tVH2fHGzH1AMsYxpsD6VpKMESN/M4zN1MFt
         PU9Px1HkV80LcGVJMwbY+6Tko1JixBBucE2BFme0qNeAYvR6UTC4OTAtkqq5DdDUGKgs
         lr7J/+F0YmcbWtQX/PehW8txK+VqQom6/pLop9BuorLJK/m9ygsDDs9pgE01Dtxsyyhz
         C+rXVdBY1g+EWKMdraj4J4fomMZSyoibDV5N6gp4qKEinE3wQMMPDoWJYcHtXwrA7fYP
         b+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCX5WJamc5EbVhOJDupo3WIrnEnmoYQi+9X8hYH0k1WVI2iEPHVdex26PGWdIgUpoBNYEgbkpLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPjgeuT/+hTCbMZ7849pO9/5u6sZTEXmCJsQJ+yH9PAYKRhqEL
	lgg1oN+rvCBF/3GZBwjzopRWHn6dFkhIsgoxDNxtTXEs+pofTP0=
X-Gm-Gg: ASbGncu0Fi5JVxto721NEKcBLdob3TpwCjbyTooumHRW7kCTqg/Q9Hqd2xhIPzDkLXK
	nJX6tJdZiJZj2iXZCbnXGq9emG0M4oYEJJFRXK4pH3cOCO3bgU4x6LyMDu+rvxnzUjk7A4HCLph
	bYIE7qc8FAuSfVoEJ6zhQxPE2f+oEcbdaEkU6ZiLSAKjgR+8LKPQ/tGhVtiblwBqCI34MO0+9X4
	46PLBP6mcERLhQQi45duRCOGd7q0F7oORQcd7/EK4xP+18kM/1He8LlUMtgRYTJhG9J59Y5CIrm
	b/46KoP/Sg9li53wUfN9HuRHJffeJS0AbS+k/dxQFe8P
X-Google-Smtp-Source: AGHT+IGmoICSUheSai24ZYLhwLerWiJoqglR9HUuFvPqyi9MvbKgX+RP2oer/JvxDyfKx2Ah1KzUmg==
X-Received: by 2002:a05:6a00:3c8b:b0:72a:bcc2:eefb with SMTP id d2e1a72fcca58-7348bd9221amr1425973b3a.2.1740523042927;
        Tue, 25 Feb 2025 14:37:22 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a6f9ea7sm2145886b3a.65.2025.02.25.14.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:37:22 -0800 (PST)
Date: Tue, 25 Feb 2025 14:37:21 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 2/6] selftests/xsk: Add tail adjustment
 functionality to XDP
Message-ID: <Z75GIb_EtzKEKTaY@mini-arch>
References: <20250220084147.94494-1-tushar.vyavahare@intel.com>
 <20250220084147.94494-3-tushar.vyavahare@intel.com>
 <Z7dqhiWcXDszRSYF@mini-arch>
 <IA1PR11MB651473D6A9F11317CA7A01778FC32@IA1PR11MB6514.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA1PR11MB651473D6A9F11317CA7A01778FC32@IA1PR11MB6514.namprd11.prod.outlook.com>

On 02/25, Vyavahare, Tushar wrote:
> 
> 
> > -----Original Message-----
> > From: Stanislav Fomichev <stfomichev@gmail.com>
> > Sent: Thursday, February 20, 2025 11:17 PM
> > To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org; Karlsson,
> > Magnus <magnus.karlsson@intel.com>; Fijalkowski, Maciej
> > <maciej.fijalkowski@intel.com>; jonathan.lemon@gmail.com;
> > davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com; ast@kernel.org;
> > daniel@iogearbox.net
> > Subject: Re: [PATCH bpf-next 2/6] selftests/xsk: Add tail adjustment functionality
> > to XDP
> > 
> > On 02/20, Tushar Vyavahare wrote:
> > > Introduce a new function, xsk_xdp_adjust_tail, within the XDP program
> > > to adjust the tail of packets. This function utilizes
> > > bpf_xdp_adjust_tail to modify the packet size dynamically based on the 'count'
> > variable.
> > >
> > > If the adjustment fails, the packet is dropped using XDP_DROP to
> > > ensure processing of only correctly modified packets.
> > >
> > > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> > 
> > Any reason not to combine patches 2..5 into a single one? I looked through each
> > one briefly and it's a bit hard to follow when trying to put everything together..
> 
> Maybe that was too many patches. How about this?
>  
> #1: selftests/xsk: Add packet stream replacement function
> #2: selftests/xsk: Add tail adjustment test functionality to AF_XDP.
> #3: selftests/xsk: Add support check for bpf_xdp_adjust_tail() helper in
>     xskxceiver
> #4: selftests/xsk: Implement and test packet resizing with
>     bpf_xdp_adjust_tail
 
Even that might be too much. #1 is clearly refactoring - keep it separate. The
rest seems like it belongs to the same testcase(s)? I'd put patches 2,3,4,5,6
in the same patch.

For example, you add bpf xsk_xdp_adjust_tail function, but there are
not callers in the same patch, so it's not clear what's the context.
Same for testapp_xdp_adjust_tail - there is no caller, so the reader
needs to go to the next patch to put it all together. Same for
testapp_adjust_tail...

