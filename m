Return-Path: <bpf+bounces-36790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 308DE94D6B6
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 20:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92AADB21B20
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 18:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626E415ECEA;
	Fri,  9 Aug 2024 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExrzfYK9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510281474C3
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229614; cv=none; b=GqCbJ+viYgR6N8d+h2Vwg8VHVIiCYYT+DU+hakleDj2Xql5otdQMQ5c6ERKNbdH+V38yr/GvwgDCmCLa6eRAm+g2CgpVgrbx8WsEabkhD7uHZmViVTMl0kkLACyd4aDmcrlk7/v56JaKvqjYmxPeTwmbMV0wia4sf1WzWR7iFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229614; c=relaxed/simple;
	bh=kQRoSA92hYDyVhwG0YjQLYfA8ChI4kIlBvhbXyQNZzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvcWNqAHbYD/X+CriXxk/sxxa+8+vQkXXC1M3wxNhO1eVsvlr/WcQ9KjlMbxG2TA7VfquPkDdcOjjVGQCHTGqKVN+8y1584BczC7k+KB/j161TWyAY76l9Ef4KO7Byi28J3cvollg2Iq7XKD7MRCDFbK0SmzshBd/O3QLf8pe4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExrzfYK9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723229612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Q0TdrPMBWPxQ8cg3/oqyzMEtJu5iYD7aWaTXlS9y5o=;
	b=ExrzfYK9P/U0ljGgHZfG1Z+9g9v9wNSN/I516ZXj5BvafMfq9tHVyvWeClr5oZbljlAZ1h
	K6TNymsMqvyxe/YdCWNL4fep0ZDDGlihe798GR34XnKTNsqXveQWJEU+wQaHQLx1sLDPLV
	gasjRY7M7LgqPOffULdt9O6Q3hoxerM=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-WC78oSKaNXeka1pskqYWig-1; Fri, 09 Aug 2024 14:53:31 -0400
X-MC-Unique: WC78oSKaNXeka1pskqYWig-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-49457fc2a1fso1163319137.2
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 11:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229610; x=1723834410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Q0TdrPMBWPxQ8cg3/oqyzMEtJu5iYD7aWaTXlS9y5o=;
        b=Y4tj6YK1ysVUPe2rWud/LowsxwY3SbYoC5ZRfeQptVdbyUn/9TJ7Bl5ZQ42s/t1OPo
         QRTwOi0bffj1r10GG3JiNv7LIg3gcSbqvJlk2ngi0KMS4JBTORI/eh9LcwUqMG95XNDB
         Y8vq/CV6zlB1q+qonLZy65OKbWw14ReswxEtOzi4UzIqd3l+gcjy70ivb+fAdp5VKo59
         ZEymSckEiicSKdttON1XGmGd6pwkWLstFqrZjDKdt5pteglCUK94uwUiBSPwd+ft/pBM
         yKO2j5rMYwC52uGIQqLXQW9/Lcoxa54+7y6+1Vb3qZGVeWdq6UuO9tzH0On4UaZQeTnq
         7FCw==
X-Forwarded-Encrypted: i=1; AJvYcCVi9227SAdk94jGkRKs+DFhmnBTFMj0bguup+IG7zdPrQIjgWhBOI/REY2swCijK/fBpewiiXPLEz1HvgQJHDl7BYLH
X-Gm-Message-State: AOJu0YxVLepOniPaZmPhh4+fb0jikcSea3AjJvkS1zOZusWRO940pGXK
	MKRphvwEGTc3XFDiJU+eP6lvvKWb4NVjAqlNBH8vtAvkPVL4EPJokByrIwcI+F28pGxtSN5SV1h
	eDo5kBS+T3OXPoCau9wNNhpAI5Ex94v/q7K5SF6epE+RYIEZCF9YDtXxfc31TBbccS/IGxCe2af
	nkQo/DBmrvhbp7w7o3pcuYRejz
X-Received: by 2002:a05:6102:38c7:b0:493:effa:f13c with SMTP id ada2fe7eead31-495d85836d7mr3406269137.19.1723229610633;
        Fri, 09 Aug 2024 11:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXMG38O6bXHYSFXkgdhixdY/LL01zjfldoTMjmv76wCz3f6Z9SfwN5XHBpdXER9i7WZ/NwgNIWKqdEzG7NnVE=
X-Received: by 2002:a05:6102:38c7:b0:493:effa:f13c with SMTP id
 ada2fe7eead31-495d85836d7mr3406261137.19.1723229610341; Fri, 09 Aug 2024
 11:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808145639.GA20510@asgard.redhat.com> <83d4e1a3-73fc-4634-b133-82b9e883b98b@linuxfoundation.org>
 <20240809010044.GA28665@asgard.redhat.com> <41cb60af-3175-42ab-896f-b890e51cde0d@linuxfoundation.org>
In-Reply-To: <41cb60af-3175-42ab-896f-b890e51cde0d@linuxfoundation.org>
From: Eugene Syromiatnikov <esyromia@redhat.com>
Date: Fri, 9 Aug 2024 20:53:19 +0200
Message-ID: <CAKiVLCJK+D7nwSm0rVfL5qh6751SdX-DNHw=rD8OKfcSF767cw@mail.gmail.com>
Subject: Re: [PATCH] selftests/alsa/Makefile: fix relative rpath usage
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>, Artem Savkov <asavkov@redhat.com>, linux-sound@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Aug 2024 at 19:01, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 8/8/24 19:00, Eugene Syromiatnikov wrote:
> > On Thu, Aug 08, 2024 at 02:20:21PM -0600, Shuah Khan wrote:
> >> Wouldn't make sense to fix fix this in selftests main Makefile
> >> instead of changing the all the test makefiles
> >
> > As of now, the usage of rpath is localised, so it is relatively easy
> > to evaluate the effect/prudence of such a change;  I am not so confident
> > in imposing rpath on all of the selftests (and, if doing so, I would
> > rather opt for runpath, to leave out an ability to override the search
> > path via LD_LIBRARY_PATH, if such need arises);  in that case it is possibly
> > also worth to add -L$(OUTPUT) to the CFLAGS as well, as the compile-time
> > counterpart.  But, again, I was trying to avoid the task of evaluating
> > the possible side effects of such a change, considering the variability
> > in environments and setups selftests are run.
>
> Okay.
>
> >
> >> Same comment on all other files.
> >
> >> It would be easier to send these as series
> >
> > I hesitated to do so due to the fact that different selftests are seemingly
> > maintained by different people.
>
> You can cc everybody on the cover-letter explaining the change
> and the individual patches can be sent selectively.
>
> This is a kind of change it would be good to go as a series so
> it will be easier for reviewers.

I see, thank you for the explanation.

Right now I am working on the variant of the patch that consolidates
the -L/-rpath flags in lib.mk, do you think it will be of use to have
some opt-in/opt-out mechanism, or just impose them unconditionally,
similarly to -D_GNU_SOURCE? So far I don't see any issues with either
building or running the tests, but I can imagine it might be necessary
to avoid such flags in some cases.

> I had to comment on all 3 patches you sent - instead I could have
> sent one reply to the cover letter. It makes it so much easier for
> people to follow the discussion and add to it.

My apologies.

> >> please mentioned the tests run as well after this change.
> >
> > I have checked the ldd output after the change remained the same (and that ldd
> > is able to find the libraries used when run outside the directory the tests
> > reside in) and did a cursory check of the results of the run of the affected
> > tests
>
> Please mention that then in the change log.
>
> I applied this patch and ran alsa test without any issues. You
> could do the same with:
>
> make kselftest TARGETS=alsa

Thanks, will do.

> (but not so sure about the BPF selftests, as they don't compile as-is
> > due to numerous "incompatible pointer types" warnings that are forced
> > into errors by -Werror and the fact that it hanged the machine I tried
> > to run them on).
> >
>
> I see a bpf patch from you in the inbox - if you mention the issues bpf
> people might be able to help you.

Right, I am in the process of condensing my issues into patches or at
least useful bug reports.

> I am not replying to your other patches. Take these as comments on others
> as well.
>
> thanks,
> -- Shuah


