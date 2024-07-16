Return-Path: <bpf+bounces-34877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB98931F3F
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 05:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF28B211C2
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 03:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A4511C92;
	Tue, 16 Jul 2024 03:25:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C711725
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 03:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721100348; cv=none; b=oDGU7RMaf8ZdioqJEul8JrzgyzSoSLij98ZXrlcn1Ghm1BGSx/X6DxfnzUVUj7bvuwmIIdOytwjSIgTAQ35QiwEl9IZZXpIlh+U5yCSez+QY8PMxyMexxspfZSrPMqhIBw2nWv/mWvfBgFGHbx/6yz7X5Sj0BIRYl9GlEsBJWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721100348; c=relaxed/simple;
	bh=qSuZ1FzkBiie2y5fGSUr7XDLjusONXu2VZUjMWcoZ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu1a2nX3+sPaAoDsZ2HxIT8+KHMfr8S4CuNkNeyN0Fl7b7l3DG31DY6TkTXscWQodWviaTy5UAnHCAWii3rYGO1V2VPMuF3X5IEk0hjY/cIxm/8xWXuncXIhJVDe9NliTuMm7n2aG81T/pUCmcm0xV7T/KKtTz+5ZFexGRDHWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b0bc1ef81so3227336b3a.1
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 20:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721100345; x=1721705145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdzUk8/V/ijKZrxLSGp47tUbSyOkIXTiCPrZP5OzCYI=;
        b=ianxN3E7pLTd5we5QuptTkTPBkDuEtOKXdmIY9KTdvD0LDdiUKfGZMEPirt7ZttE1h
         UmQuYhktxXXncdXMXxdK196yYfm0UES2go9uQwl4AOB1xOkMusmXrIELJ1dPFdpUdXiQ
         UvT6510gHAFlZteFE7pPuoA5PqqU1RIf7PMC/j9/6F1/kWsD2m1gFwJjNrcESjEitENi
         4dC8sZcXZrwGMrnjppRxrCaf8AjODtWAWaUwtzRElKBYHPmQ+Pdvq7TWX/ZRM97GZaQL
         Vzvi2wh2uxPtmqw9yFTkEd5MJO/3pkRm3cbCqxM0nZtThzTAkZe7yrdTd6Tyyhp77EFQ
         EHcw==
X-Forwarded-Encrypted: i=1; AJvYcCXuYJ+tbrfOcNjTzpno5PTWA7oMw8uB7d4eJ5wwBqUzMsm+dqldwIyxrsnLEfEsiyQNunCo9Oh6JZ1j0lp/diNbqt07
X-Gm-Message-State: AOJu0Yy6njKjssBwzIBW3JyZRnGW0jVaRoBtp/C83k4+tnzgEWM0ODMs
	wbsNRTyyf14bGaK/zBQe/tW6Nwxgt0GEwch/glAVDeA47T3ChMo=
X-Google-Smtp-Source: AGHT+IEh7Nx76SekK9DHRLhPT5Q9NkUnfK5aCLp7cGreOYLOZjQT7EwzkAG8UD0yK6QaJzztR6v8HA==
X-Received: by 2002:a05:6a21:32aa:b0:1c0:d9c9:64eb with SMTP id adf61e73a8af0-1c3f121087bmr1127194637.17.1721100345308;
        Mon, 15 Jul 2024 20:25:45 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc263c5sm47993465ad.174.2024.07.15.20.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 20:25:44 -0700 (PDT)
Date: Mon, 15 Jul 2024 20:25:44 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, song@kernel.org, kernel-team@meta.com,
	andrii@kernel.org, kuifeng@meta.com
Subject: Re: [PATCH bpf-next 0/4] monitor network traffic for flaky test cases
Message-ID: <ZpXoODGNDyhnyeO8@mini-arch>
References: <20240713055552.2482367-1-thinker.li@gmail.com>
 <ZpWVvo5ypevlt9AB@mini-arch>
 <4c658385-dc3c-46ff-a868-0159edf84dc1@gmail.com>
 <940fff33-ed2b-41e0-bac6-d388deda9446@linux.dev>
 <528a8c8c-159c-4fb2-9c4c-c9c9b2e585df@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <528a8c8c-159c-4fb2-9c4c-c9c9b2e585df@gmail.com>

On 07/15, Kui-Feng Lee wrote:
> 
> 
> On 7/15/24 16:56, Martin KaFai Lau wrote:
> > On 7/15/24 3:07 PM, Kui-Feng Lee wrote:
> > > 
> > > 
> > > On 7/15/24 14:33, Stanislav Fomichev wrote:
> > > > On 07/12, Kui-Feng Lee wrote:
> > > > > Run tcpdump in the background for flaky test cases related to network
> > > > > features.
> > > > 
> > > > Have you considered linking against libpcap instead of shelling out
> > > > to tcpdump? As long as we have this lib installed on the runners
> > > > (likely?) that should be a bit cleaner than doing tcpdump.. WDYT?
> > > 
> > > I just checked the script building the root image for vmtest. [1]
> > > It doesn't install libpcap.
> > > 
> > > If our approach is to capture the packets in a file, and let developers
> > > download the file, it would be a simple and straight forward solution.
> > > If we want a log in text, it would be more complicated to parse
> > > packets.
> > > 
> > > Martin & Stanislay,
> > > 
> > > WDYT about capture packets in a file and using libpcap directly?
> > > Developers can download the file and parse it with tcpdump locally.
> > 
> > thinking out loud...
> > 
> > Re: libpcap (instead of tcpdump) part. I am not very experienced in
> > libpcap. I don't have a strong preference. I do hope patch 1 could be
> > more straight forward that no need to use loops and artificial udp
> > packets to ensure the tcpdump is fully ready to capture. I assume using
> > libpcap can make this sync part easier/cleaner (pthread_cond?) and not
> > too much code is needed to use libpcap?
> 
> Yes, it would be easier and cleaner if we don't parse the payload
> of packets.

Yeah, same, no strong preference; was just wondering whether you've
made a conscious choice of not using it because it definitely makes things
a bit easier wrt to the part where you try to sync with tcpdump..

Also +1 on saving the raw file (via libpcap or tcpdump -w). 

