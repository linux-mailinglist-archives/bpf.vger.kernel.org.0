Return-Path: <bpf+bounces-38041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0847395E6B0
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 04:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9961F2163F
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 02:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69557B664;
	Mon, 26 Aug 2024 02:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D2gno/9X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EC7489
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724639226; cv=none; b=Le96keDp5sd/cBGiJux4XJOZRlrSTK0acnoS0qaHCiaTkRoqmKszoi9z0pZ6Omv0kTx8sgH/sR+mvQ1QBg9w4+VQRZChYicTO1iFvKT46VuZ8jzfHzb6dTlyK4xyUqPuZjHvLjt/l8gD4SODbFHVQL3Fo3MaGZ/giNcGCnIUxVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724639226; c=relaxed/simple;
	bh=h+vf2zDNngCSGhTz8LOVBHiGSxbBMMsAacYzdRHip54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBSLxp1bBK3v27K3gysbDhtzSrcIxxdmLUWN5RlkQc27V5OqeybDNMtCRsdGLNYz3XaQB/TtFGirTvbVFPjczgENOsN9qQk2l1PzTR//LvgDdwXn1raHBYV0NcILmAFuU7KHD5/A3yXBxGBqeWJ7gdESuJ9kRyLwvQ98NxXNEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D2gno/9X; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428101fa30aso33549315e9.3
        for <bpf@vger.kernel.org>; Sun, 25 Aug 2024 19:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724639223; x=1725244023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ph+ZuLbsezZJ1raE1GiR3wAm1GTZNQAYiHPQbzcPMpE=;
        b=D2gno/9Xr321/U82RXC3m4sscbGMFRTudkvtM5mqd8gdN0Vi9Jfhr3yP1DiqxGSgeC
         oiuxURyG7x4KKbKZXiy+XXi1ejLIstFV62xmoJGNOHh/f9zRv1xKvhnHUYVk7UcMSa0x
         PIqA6flthfDYbpeGXHmcKBUtftl8Cbs96wv7lOnfufUumaeaCrqJA28lhh/w4/uUUG3G
         7a4+v4JWvOBJTALRi1Y4PDkzujjGfTsvM5rouDcKl6KoAq2br5nMjtqp2eYzFM2l62zY
         DIPIzKJGbFyiA0Gly1UJXv5zpZWVS8BFFjCMEhjNOKQh7Wxq0xCSNHpwHHgsINwA6Tep
         /NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724639223; x=1725244023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph+ZuLbsezZJ1raE1GiR3wAm1GTZNQAYiHPQbzcPMpE=;
        b=IjMOWqEa6NZFk3LvUUx+RkhuTT7H6xXmWYuoEmcRWD1ZXF1rOUY4V5KaRoHADx5zd0
         Tf0bUiUGwhpv1pM8icuMp4SrT2oO4EGOUM5CV5W+xbGwIQzeDlS3RegvV03+sDLYolir
         6pX2zrgomJM5vOWSgUBQ+IZBtgcggCqwTkuJySm4hPRI2wMmEbonUh6wYModRDZdxbIF
         rATyvuUw/tZdhtFlPzyCKggfCEKbiyZu4SakVY/wNsodhN8Lsh5I/XBgy26u9DyXb40Y
         OeHq9grluQd9YmPpCD0/rqX7yD/llFH1vlCCPk1grNJQHF8ToZPuWJufIs0fECzvUCqj
         bezw==
X-Forwarded-Encrypted: i=1; AJvYcCVoU79oYyiwHrnk0nVRkIiCQRxWeViD4w3Fp27K/X6d29UaugQde2RVJFt3z+E68DESv8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf1JCRGv8/PX87j6VKr3aF9PBAt9we/E383WZr8v1JyJDSs0WW
	o2kGCdB+6k3FJ/IcjSodSiA6Pk/8WOz8lIvovvMom7pTMDGzEih2DiQyFXMBzck=
X-Google-Smtp-Source: AGHT+IHW92GMiMx0CcynBRBCPrgf3JkUi1zJucES3LxkQJGe6B7PONl9QhzLd4yGIlezMwfmr9l1Mw==
X-Received: by 2002:adf:a153:0:b0:371:8bc8:ad5b with SMTP id ffacd0b85a97d-373118eed3dmr5621242f8f.60.1724639222985;
        Sun, 25 Aug 2024 19:27:02 -0700 (PDT)
Received: from u94a (39-14-73-109.adsl.fetnet.net. [39.14.73.109])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8253d5bda0bsm257449239f.16.2024.08.25.19.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 19:27:02 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:26:53 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Daniel Xu <dlxu@meta.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc: kernel-ci <kernel-ci@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Manu Bretelle <chantra@meta.com>
Subject: Re: BPF CI and stable backports (was Re: [PATCH stable 6.6 2/2]
 selftests/bpf: Add a test to verify previous stacksafe() fix)
Message-ID: <kpxnarc6aadnnabt4eq6n2gxoxhhkeowcmzysnuhc52p5egpqi@6mfuil3erxgq>
References: <pybgmvfeil5euvdz7vs7ioacncrgiz4lnvy5sj3o4prypgsdd4@tzc2ecsmyt6g>
 <f4c2306d-6bb9-4a17-ad51-0ffba13a140c@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4c2306d-6bb9-4a17-ad51-0ffba13a140c@meta.com>

Hi Daniel,

On Fri, Aug 23, 2024 at 11:57:06PM GMT, Daniel Xu wrote:
[...]
> > On Fri, Aug 23, 2024 at 01:53:48AM GMT, bot+bpf-ci@kernel.org wrote:
> > [...]
> >> CI has tested the following submission:
> >> Status:     CONFLICT
> >> Name:       [stable,6.6,2/2] selftests/bpf: Add a test to verify previous stacksafe() fix
> >> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=882411&state=*
> >> PR:         https://github.com/kernel-patches/bpf/pull/7584
> >>
> >> Please rebase your submission onto the most recent upstream change and resubmit
> >> the patch to get it tested again.
> > 
> > It seems the BPF CI picks up stable patches and tries to apply it on top
> > of bpf-next, which fails to due conflict. Could a filter be added to CI
> > so these are ignored instead? (Or have BPF CI apply and test against
> > stable/linux-*, but that seems too much to ask)
> > 
> > OTOH if maintainers and reviewers prefers stable backport not to be sent
> > to the BPF mailing list, I will drop the CC to BPF mailing list in the
> > future.
> > 
[...]
> 
> Thanks for reporting.
> 
> The way kernel-patches-daemon (KPD) works is it periodically looks on 
> patchwork for patchsets delegated to BPF tree. If there's a specific tag 
> (bpf, bpf-next, bpf-net, for-next) it'll apply the series to that 
> branch. If not, there's an ordered list of branches to try. bpf-next is 
> first on that list which is why you're seeing the conflicts.
> 
>  From KPD side, the simplest way would be to not have backports show
> up on patchwork. I think it makes sense - it is not really being sent 
> for review.
> 
> We could probably add additional logic to ignore stable backports as 
> well. Up to the maintainers. I don't really have an opinion.

Thanks for the explanations. I didn't realize that patchwork was
involved.

Seems like the best action for now is to drop BPF mailing list when
sending stable backports, this also avoids cluttering Netdev + BPF
patchwork and keep it development focused.

(I think backports still need reviewing, but that's probably a different
discussion)

Shung-Hsi

