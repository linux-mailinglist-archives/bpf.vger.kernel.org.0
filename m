Return-Path: <bpf+bounces-20979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD30D846028
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 19:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BAD289897
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808D182C97;
	Thu,  1 Feb 2024 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRhZ9q9n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A55A4E0
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812972; cv=none; b=LZsAEW+ISCTEMSG1JfD3c6rNeaF+AsaEAb3DmOepyQDET1SqKWEnAz0fI9F6v3Unq7HeVO5g+kC0XTaZsPOZKYPcrd8HEMBSUhNEu4oTU14GMvbswhzAVSBro4j7WNZuWMDL48bU77SnB+P8XnI/ofA+FLspmP9XKY7huWHXtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812972; c=relaxed/simple;
	bh=rsxnBiMP12zdsO629IyGH9rTDA66O/m8TLLutUPhwHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdRN1Rq9quORH9HWlFgz+kLSj8IqWqOCZ0pBJKEnq7/93J8HcHdc7copwviNG6jnNPGZ42WHcm0Kf+a+zfcNeYLhdDD8R1iOiwCcAgygtHyrEgSqzp+2wFt8tTMD70XNGuBaPsTNDAyQrYdcFisdp2uDKIheYBLJ1U91YuBpMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRhZ9q9n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d8ef977f1eso9839165ad.0
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 10:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706812970; x=1707417770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3RJI9qQbJZJxoipftQjkFeMrVzDmJ6hd/foHgzOMQo=;
        b=SRhZ9q9noV0M7f0t30VO8PThEM6ONX0CobNft+9z04+lqV2boH5MdBdcDo2QUJGJRn
         /hG6hfYJQ5lkrP4JZSYF0VFmOEPKlRjVD/lZ0F675f4wOpdQT/NVjT841Qk2Ed1oAJ+L
         1LyGAKRAtnbUa6nYx7VaokOFI0cOEp4fwbTiZLmdAsT2vurtEaNQvZhYvWTSBfkL7zba
         NGvY8O8Avujr1cmGu4Wxin/harvvx8hu5JSVOVhVQjI3Hjd0fbJQqaytYjgXypeuEPPk
         ATusf0aBAaJ9g2HG9blEwAbtI5JKj1fl4q1rwvhS0PGbecv0fQTNMbppF2VI4nFxo/yS
         0LtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706812970; x=1707417770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3RJI9qQbJZJxoipftQjkFeMrVzDmJ6hd/foHgzOMQo=;
        b=uruTFqjA8RZj746T007zyZSZoMW+VC0Hrii/L+WaYuGie3UVzr7pi+prM8BDpacKRv
         bXhIPFs954ng3pvNsv6iD+0vyWffk2cwqyIsxSiOFSz4Sx8P9vuXOIRbfN3WGLNbIJGr
         1IhDZw95V7PrBt0eq9bVZGjo8PCMTYsL6qj4iyGfHFqKQuEWxXIIXDPRSb6tb6FBhG3c
         dzm+kSrki910XV+rgn8BinoTO2VDHggi7+VPQlWS+Zywf+7rCFm7pDL6JepSZGbq58s2
         r9UKmFuMmKqHN3r8qbUlICOTFv+Qz17f5w22jHvp1PMAVlqmCQ7khtfxT5LI2tqi+fus
         Pt0w==
X-Gm-Message-State: AOJu0YyQ245gOD8wPTw0xHwPNoHmSQUJyQivZc/PJyy+4iEdJVGXSc5w
	/sgBkW4+fRr0wzUzB4MOD3GHnvBvhpARfpqIEowjfemLNQxey1ng
X-Google-Smtp-Source: AGHT+IEkejMFrL0CwSF+5iVpdLTinNMZFBbsp+fK2YpQfK1inzLHxWVESDOcuYFDkuVnXmKOgJzjug==
X-Received: by 2002:a17:903:234b:b0:1d7:7d1a:7697 with SMTP id c11-20020a170903234b00b001d77d1a7697mr6452195plh.68.1706812969772;
        Thu, 01 Feb 2024 10:42:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVju3oETvFbONPwP4df3KCVc6ko438cnxihiNkP7eiD3J+vhmGr+1Tl/uY5dqYc4m8yNRbZcyl7dBqfoMhCfut9b31yDH/P567VWTj29FT4Wicqbc+Q+C4rMGF8wpbE1VR8x/C11lFh0XG7ywMdxA9VPyxnLrk9+ufklo07wNalkFxQnPay58ABvpoxyS80jTjSr46yS1e9BckGNrtcJm84RB54c4RscR5bpvSHARtoT/CpmV1Ql9vk35XwDx+oPYzZhCgpPJoVugSQE14DPjDhthKPCRpS/b8E2C1AHbHAiJhf9VKp/c1dM62MA2JY+B4LwPeVAuJxUCf3CHfyvRCi92Vcqw==
Received: from surya ([70.134.61.176])
        by smtp.gmail.com with ESMTPSA id lc16-20020a170902fa9000b001d8cbbb1f00sm154619plb.23.2024.02.01.10.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:42:49 -0800 (PST)
Date: Thu, 1 Feb 2024 10:42:47 -0800
From: Manu Bretelle <chantr4@gmail.com>
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
	eddyz87@gmail.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next ] selftests/bpf: disable IPv6 for lwt_redirect
 test
Message-ID: <ZbvmJwy96KPluVqO@surya>
References: <20240131053212.2247527-1-chantr4@gmail.com>
 <CAO3-PboMzPXAey7a1LQ1Gme_pgV4QMyFBx-y=R7PUQBPrGfRvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO3-PboMzPXAey7a1LQ1Gme_pgV4QMyFBx-y=R7PUQBPrGfRvg@mail.gmail.com>

On Wed, Jan 31, 2024 at 10:44:07PM -0600, Yan Zhai wrote:
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> > index beeb3ac1c361..b5b9e74b1044 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> > @@ -203,6 +203,7 @@ static int setup_redirect_target(const char *target_dev, bool need_mac)
> >         if (!ASSERT_GE(target_index, 0, "if_nametoindex"))
> >                 goto fail;
> >
> > +       SYS(fail, "sysctl -w net.ipv6.conf.all.disable_ipv6=1");
> 
> Thanks for digging into this! I was totally unprepared for that many
> router solicitations when I wrote the wait logic. For now disable v6
> is totally good to unblock similar scenarios. But think it twice it is
> probably still worthwhile to incorporate v6 later since lwt hooks mess
> with both v4/v6 routing. So I'll try to fix up the wait logic later
> this week. An exact packet filter is probably best suited to make
> icmpv6/arp/nd happy.
> 

Greatly appreciated Yan. I definitely agree that it is desirable to have V6
support to.

In case that helps... [0] should help you repro locally on your favorite
architecture.


[0] https://chantra.github.io/bpfcitools/bpf-local-development.html

Manu

> best
> Yan
> 
> >         SYS(fail, "ip link add link_err type dummy");
> >         SYS(fail, "ip link set lo up");
> >         SYS(fail, "ip addr add dev lo " LOCAL_SRC "/32");
> > --
> > 2.39.3
> >

