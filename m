Return-Path: <bpf+bounces-4226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967BC749AAE
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5261B281293
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03C68C04;
	Thu,  6 Jul 2023 11:33:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE751848
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 11:33:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30B1FD6
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688643166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+EHgreaHSArQejpZwUzj9BVjiALWLnZxUNJL9dz55r4=;
	b=ipGryLgjXX8/Csq0az9lB8E81zy77GrB9dgGnN8ymKF+nFIpGsZ7FNEpxdhc0nat+UIpMJ
	ldDTNkGgImxth50w3J5m8/ZHBmsVNIM8pCt01HAEa3YE8x5TwluSw/TAg/KoB7Oamj+Qcs
	0vw+kbVdd47z2KP7WFlDyODnwlsPJxg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-Ptt6ivqFPtWU-BG5td62uw-1; Thu, 06 Jul 2023 07:32:45 -0400
X-MC-Unique: Ptt6ivqFPtWU-BG5td62uw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31429e93f26so307822f8f.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 04:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688643164; x=1691235164;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EHgreaHSArQejpZwUzj9BVjiALWLnZxUNJL9dz55r4=;
        b=fkxlP1dKUEFfOTLDVnz76OmPpE0vE5LqoOy8ZNGh3shm14aVzs6SfZlLiFizZNywiL
         U+i0sczS4byKg6RJM+dVKvwX33BqXQMwClTetWIrIceP3p2billOMerkHazeXR21eGaH
         hrr8TOtrxz0ni282wdk7ppkQUnc4QLxX6udnMQxG7j2sUvYExIQvtSHv6DrQTKiZZDlv
         /AHlVUFeCx0vbEGFhhrCA/JLN3/ciNHmSPeotcy1AhAL8TjTpnGsPj9lh+DadL8srhVJ
         repd/ITiP/ctU8blJSSnj0xih67pSM+0XwGS+ExKEQW4wU2or1uIcrakV4nppE0maVA3
         jytQ==
X-Gm-Message-State: ABy/qLbarCTFft5Vl0AZgtAnSQ6N1FRPkkr9t2n4kSTxyMvHXyVz4SYG
	YeqAucHvBblpukflUbzunx9HvxmXxlZAkfZrgniSAh6tozx5jwjnBp5Ed0zNUFEL4Ud/3PSJuJs
	mW9BiEbnNp+v9P54n0ZM0
X-Received: by 2002:a05:6000:1247:b0:313:eb29:4436 with SMTP id j7-20020a056000124700b00313eb294436mr1217120wrx.67.1688643164257;
        Thu, 06 Jul 2023 04:32:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwkRaxQNkD99ye545exOl5xhJyn9xK840Txrw0fb8M++KI1XK3XNcHZmk3ooEOtn36Sg1SYA==
X-Received: by 2002:a05:6000:1247:b0:313:eb29:4436 with SMTP id j7-20020a056000124700b00313eb294436mr1217103wrx.67.1688643163824;
        Thu, 06 Jul 2023 04:32:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d43cd000000b00314427091a2sm1620675wrr.98.2023.07.06.04.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 04:32:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 97148C59677; Thu,  6 Jul 2023 13:32:42 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 keescook@chromium.org, lennart@poettering.net, cyphar@cyphar.com,
 luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
In-Reply-To: <CAEf4Bza5mUou8nw1zjqFaCPPvfUNq-jpNp+y4DhMhhcXc5HwGg@mail.gmail.com>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
 <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
 <20230705-zyklen-exorbitant-4d54d2f220ad@brauner>
 <CAEf4Bza5mUou8nw1zjqFaCPPvfUNq-jpNp+y4DhMhhcXc5HwGg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 06 Jul 2023 13:32:42 +0200
Message-ID: <87a5w9s2at.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> Having it as a separate single-purpose FS seems cleaner, because we
> have use cases where we'd have one BPF FS instance created for a
> container by our container manager, and then exposing a few separate
> tokens with different sets of allowed functionality. E.g., one for
> main intended workload, another for some BPF-based observability
> tools, maybe yet another for more heavy-weight tools like bpftrace for
> extra debugging. In the debugging case our container infrastructure
> will be "evacuating" any other workloads on the same host to avoid
> unnecessary consequences. The point is to not disturb
> workload-under-human-debugging as much as possible, so we'd like to
> keep userns intact, which is why mounting extra (more permissive) BPF
> token inside already running containers is an important consideration.

This example (as well as Yafang's in the sibling subthread) makes it
even more apparent to me that it would be better with a model where the
userspace policy daemon can just make decisions on each call directly,
instead of mucking about with different tokens with different embedded
permissions. Why not go that route (see my other reply for details on
what I mean)?

-Toke


