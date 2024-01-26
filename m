Return-Path: <bpf+bounces-20400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DBE83DC9F
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 15:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43EC21C21F38
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889E01CD3B;
	Fri, 26 Jan 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="N62qw+Hk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA011D52D
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280171; cv=none; b=kt/sYQ44beB23Aonw1RP31SuMqDQyYt5vM7J/2yMN6x92BSNuXD7cbde1l/rfyf/VTP3tr2McK+5/GTeSFd4bJ3oAUWGWlbKOjXUZ3pUcM556bd8mkvVmXempAMf735e7GPxlLMWuc52mhvSvIF2RM0AxE6hvkq/Yc0xIbCWVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280171; c=relaxed/simple;
	bh=2PTsjLOYiy8Fg2jPcb25iyXKCO+TTKEkQw4KCd2T1eQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=dXJX/rPt4ofUSdsRFGxWhfHE+FW+kCD8+ZOLXqmEFW0tp7670rQ469kSh0a68mKD7KplYo0vYNxgHjWQRiIOJ5DSc8D/LwupVsN5y+ljXa6bNxnhC4itEmM3aW67wuqrKiH/Gtlc+9gsxSJyzxKJr+oyDuhbekb+LYvwEYpFwNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=N62qw+Hk; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf2a381b86so9538771fa.0
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 06:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1706280167; x=1706884967; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=2PTsjLOYiy8Fg2jPcb25iyXKCO+TTKEkQw4KCd2T1eQ=;
        b=N62qw+HkITd5DspMmnTOaWt8qd7SAr+9AUUBbfXc+a2jWSUuvxVYhsZNk7IsuUgOGp
         kTLeCU0ag1c+vtyrJUW/jt29c3HKtu18dOXUbqHY0EnXPR6CpQcJp+GMyKr1YyJ/5vnS
         iHBJjPYJ2Xr4/Wis49Y4e+nM9k4Huu3uCuVTboD7Au/BrjSsJUnabYbPU+NWYSgjznlO
         g3SVM3xU+OOl2AURrK6mlTym8oW/+aFC4f2KnT2oP22t0u4+QZhXVJ12ogGb9UeiKxgi
         yqycUY+dhDd222UX0ArGOTKx0DTfRTIle4OgFhw65vInPaaZglrBeqj85NjplvsAvX+d
         pS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706280167; x=1706884967;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PTsjLOYiy8Fg2jPcb25iyXKCO+TTKEkQw4KCd2T1eQ=;
        b=oZNGKJEkjgIk3t9cOgwbcwKcqkjr7jLfif90eOvLcHrmyWi8oJ/jjrSxBbje7iHFPb
         yr5Nr7hjNfz5DUPyJXv89s5kQ2JJ/9Uwy1oOocVf20NcTxFgjvJPrUvA15uopqV+ER4E
         O31sbFTrtLAa/a52J1qeizFM/XLc9xSLY3weDLBP3oWhF5tYC0kaIJZLmCRLYX4+Y0/f
         jg+h7ObvfvfiTLmBO2lFNk3EHSVp3YtAUvNuwXBTge/hVhO6QzLi0VV2coWRx9C7KwSe
         asRZEorhmpg3Aqs9hPG5EW9to8JaP5ee7eE/0tV1rvJb9nwdfYcsxyjsh2F8MdjMBIbl
         xEiQ==
X-Gm-Message-State: AOJu0YyX9iNbn9uPw1hrI/TeFP9EyzkHy457m5+j/2fspAqv/thpoTK8
	KEwCCQivAFmgy2SlbatV98K2L+oOWhg4vspLHXZZ3JglESwYhdLGwzlVh5/jEZVjpC6k7vlOtkq
	E
X-Google-Smtp-Source: AGHT+IHOKxVaOju8ZRZEkBzJgFfm3NYZdfwUC2N7dpQ93S0k8kNZd8J7mAPW09QIV1xNgVPwWvppfw==
X-Received: by 2002:a2e:a70e:0:b0:2cf:37f1:3b1 with SMTP id s14-20020a2ea70e000000b002cf37f103b1mr753545lje.10.1706280167205;
        Fri, 26 Jan 2024 06:42:47 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a2])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7c1da000000b00554d6b46a3dsm659070edp.46.2024.01.26.06.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 06:42:46 -0800 (PST)
References: <20240124185403.1104141-1-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, andrii@kernel.org
Subject: Re: [PATCH bpf-next v2 0/4] transition sockmap testing to test_progs
Date: Fri, 26 Jan 2024 15:39:52 +0100
In-reply-to: <20240124185403.1104141-1-john.fastabend@gmail.com>
Message-ID: <87jznwdul7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24, 2024 at 10:53 AM -08, John Fastabend wrote:
> Its much easier to write and read tests than it was when sockmap was
> originally created. At that time we created a test_sockmap prog that
> did sockmap tests. But, its showing its age now. For example it reads
> user vars out of maps, is hard to run targetted tests, has a different
> format from the familiar test_progs and so on.
>
> I recently thought there was an issue with pop helpers so I created
> some tests to try and track it down. It turns out it was a bug in the
> BPF program we had not the kernel. But, I think it makes sense to
> start deprecating test_sockmap and converting these to the nicer
> test_progs.
>
> So this is a first round of test_prog tests for sockmap cork and
> pop helpers. I'll add push and pull tests shortly. I think its fine,
> maybe preferred to review smaller patchsets, to send these
> incrementally as I get them created.

Cool to see this transition starting.

