Return-Path: <bpf+bounces-33402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCDB91CA0D
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 03:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB46282164
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 01:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A3E4430;
	Sat, 29 Jun 2024 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU+wXo7y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822B628;
	Sat, 29 Jun 2024 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719624958; cv=none; b=AQPV/x6ft8egrYraL7HCifsS3F2YRH+0A8Ev8N6A05zsPCQgciR/QyC2Jb+Run5YM6M7CFdIpDh9VlXJdBo7czQdvxDkB8YspWOk+81vVWSzxlj7OmB+28bhZV6UjzdUD4HwZNdwRFKlJ4CKbrsNrNjtT+qSxbVA67JwKUEQVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719624958; c=relaxed/simple;
	bh=dYh+evOxwqo8XSXWmP/N8I6tz36TpxDV5ppUhvpbr8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohk2gJR5mllMAzmyW8nTL+PBrbVW/yjeOIrtDd3IB6aAZex8YljN7QVlEdPPS4j07uji4KQjbP/0SSF6CneUpPaklfUUjGbScejBNi36szRnJsBcFc3E3KoJyJBpyBsi4pcsplhY/V+8Tjmi3QuIJ+LHwD4DYDaTJiO4UfLSgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU+wXo7y; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7041053c0fdso723634b3a.3;
        Fri, 28 Jun 2024 18:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719624956; x=1720229756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roaoZW0r/LL4gJxEcTAgb637o+PXIjYa6IKAI4YfzOo=;
        b=IU+wXo7yalVhmC+kDOPlHYAFmzW9c6lTMT94s+WL+VuKbAyAYM0FoC8fCA0qsMK2IE
         z75affHhkF5Qb4uwmVjXrcNmvwnYEvDIw/TTpRoRL1LRlLYYJB9j2daJVCzNd/vq7fUC
         MrTz7YpY0pkkS7YBV2y4lDIa5ebFkr7yDoMbt1YWf0K3K/aNTC5GA4KoySJt/iq1nq3j
         nKUO/7wDoCQMrW2H217nZkzJoAzjP3fSUFyvHjprQnEubvgUKXuMEMDHRptUV5yA8uA5
         uNxCsPh3HgHrkD8iIdCPBJQHeDITJ+8WoD5oL7jdweuPWsuXLMBhP2Rlh0Rr31XvwZ0t
         nnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719624956; x=1720229756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roaoZW0r/LL4gJxEcTAgb637o+PXIjYa6IKAI4YfzOo=;
        b=RO3Rck15VqA9OHyNnI92XbQ6FZsGmCRudVE7FBpFx347Gn79EbnXw/L49vEnrs/fQF
         C/21HKt/Fb9e37QqeuW85X5u2csQbFCHpsLjbZsLzWSDeo0cb/mNmtmD+6lFCV1DtVX/
         6cWruTvr2kf8uDC6/48o59lCOUpmRYO7oO/wCpc+tvZjVNP5p+cveJlJXY3r7cVeL0ur
         HKkHvC4gFKjFtJ0Seka+F40dS8BAuFAJjXQmci/J3pLZuoe6atsbbB2YOyqmjAOPI+18
         hJRIVA6WC1kCXqz/miEGyc5PyoVJLXbfJm7MsOA7CmDJrZXjrofGml0DHi+MUr6P6AZ5
         HlWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDASLCYlEErRx9gRJnkLUUIsNF/Dbp3YFiVe5s2HC1r+KqoSerhAgKnwj66jvJr/6rOZUIQs3PFZCEPtFWXTnyU4eXDg/RhhuPqTfS62EtLsgNJwkC8mOp3TNMf9dPvBgA
X-Gm-Message-State: AOJu0YwjJmKMTrhXv9S/E1wAeKUHEpi6n+ARg5lRt+akwR37xiWMyjsY
	CPamGGLDf98oGBlwWuzoAV0wgpFzEOH0+9gRdunuzIvOcrqhJCgJ
X-Google-Smtp-Source: AGHT+IGnODhe6V9yxiRQpo8rx99CB8ypKUsDIv//HjfMLpiX8E+SUuOGZIWyr1zHTrbli+Y/BHiYwg==
X-Received: by 2002:a05:6a20:131c:b0:1bd:23cc:a3a5 with SMTP id adf61e73a8af0-1bd23cca75bmr11061005637.48.1719624955934;
        Fri, 28 Jun 2024 18:35:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596636sm21771985ad.254.2024.06.28.18.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:35:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 28 Jun 2024 15:35:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH sched_ext/for-6.11 2/2] sched_ext: Implement
 scx_bpf_consume_task()
Message-ID: <Zn9k-j06TM-JiIse@slm.duckdns.org>
References: <Zn4BupVa65CVayqQ@slm.duckdns.org>
 <Zn4Cw4FDTmvXnhaf@slm.duckdns.org>
 <CAADnVQJym9sDF1xo1hw3NCn9XVPJzC1RfqtS4m2yY+YMOZEJYA@mail.gmail.com>
 <Zn8xzgG4f8vByVL3@slm.duckdns.org>
 <CAEf4BzbVorxvJdGA0eLviRhboaisxe4Ng=VErZVh3MG9YrRaKw@mail.gmail.com>
 <Zn9BZB8tE-CySXnn@slm.duckdns.org>
 <Zn9De_70fy-DVA-_@slm.duckdns.org>
 <CAEf4BzY9-CW+SamvwkrHBH1RgB3bxybRmnrK_E0p_Np=V5MsMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY9-CW+SamvwkrHBH1RgB3bxybRmnrK_E0p_Np=V5MsMg@mail.gmail.com>

Hello, Andrii.

On Fri, Jun 28, 2024 at 04:56:55PM -0700, Andrii Nakryiko wrote:
> > Just a bit of addition and a question. scx_bpf_consume_task() is maybe named
> > too generically and I have a hard time imagining it being useful outside
> > iteration loop. So, it does work out kinda neatly if we can tie the whole
> > thing (DSQ lookup, barrier seq) to the iterator.
> >
> > The reason why this becomes nasty is because I can't pass the pointer to the
> > iterator to a kfunc, so maybe allowing that can be a solution here too?
> 
> Sure, if that's the best way to go about this.

If we decide to go this way, how difficult would it be to change the
verifier to allow this?

BTW, as none of the practical schedulers use consume_task() yet, I can skip
this for now. I'll post an updated patches for the iterator itself. We can
decide what to do with consume_task() later.

Thanks.

-- 
tejun

