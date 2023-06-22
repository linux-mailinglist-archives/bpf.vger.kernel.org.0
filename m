Return-Path: <bpf+bounces-3137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3685A739F0C
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 12:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17DD1C21023
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCBC566F;
	Thu, 22 Jun 2023 10:57:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EC53AA88
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 10:57:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7195D1BE4
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687431395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mtEvNEEfEgE6y0Va09/K93RbhGC9WjVk1y92ey2SXIQ=;
	b=W5eJyI+mWrXx2msmqElS8j/biYCHvY5XNep6DHuhwuVPzazfpHSryY2/0NKPLKTbp3Xc5Q
	8uQOcQkeCzRDKKQEOcgSRGg2D/Bv7G5zItr1B3gbpqbQFm5tf5DpkNW17YXlEfgCElysPE
	vY2gtqObE5CPqISLpj6gdl1ZdnVJYYE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-TTZhfY3zPQSvSW0i6ki_Kg-1; Thu, 22 Jun 2023 06:56:34 -0400
X-MC-Unique: TTZhfY3zPQSvSW0i6ki_Kg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3112808cd0cso2861965f8f.0
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 03:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687431393; x=1690023393;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtEvNEEfEgE6y0Va09/K93RbhGC9WjVk1y92ey2SXIQ=;
        b=gwW7Q1W7P9cDl+ToYMs8WNGMFxfXmYKfGQQxwRXgdeo45eigpwSEJDZx8r6eCQcrao
         S1K+AOySAWCZXAMXnajXBaPqAB3Ojk9/qRdALC/voZBmVtxkhV856B7duG8UioKjE2j8
         S6i1b2hM4dNDtH4PSOdTuzRF8urjNMVRrIi3iZAqPvJ6enJSyQPY+LSBFeD8p8N88PQ8
         bY/qYPv67UlCgvDNgIoFH3KY5QyEAHXgIuOK2MzA3APu48jHmj2j9BQ0fuwL0I1tRqQ4
         vpl7hyFB3ifsu98zqXbQwykQ40gEw9DLBsYG+U5VDK+IYFOADQJX3pc4NGhcHKsXoQ3V
         4JzA==
X-Gm-Message-State: AC+VfDwgB5XAAe6+B9ZD+sp/7rsyU6g4Xu7XjTpTvpQKw/Adaiy1EVNF
	KNv+vOHiyN4briRRIaAy2zJXUf0hohq48BARGS7dvP5IfBw3Ac30cNM/PkzWfWNkLv5/0g+Td3P
	oqvHSnSCHEk5g
X-Received: by 2002:a5d:480c:0:b0:30a:e5f1:eedd with SMTP id l12-20020a5d480c000000b0030ae5f1eeddmr14834300wrq.67.1687431392885;
        Thu, 22 Jun 2023 03:56:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7WSbvfGBCj5qQ17kuyaXgylgYoEA5grBw2s5jWMUBakMcarcNSS8Brg4cC/lzosHZN0RzjcA==
X-Received: by 2002:a5d:480c:0:b0:30a:e5f1:eedd with SMTP id l12-20020a5d480c000000b0030ae5f1eeddmr14834283wrq.67.1687431392412;
        Thu, 22 Jun 2023 03:56:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p7-20020a056000018700b003095bd71159sm6805634wrx.7.2023.06.22.03.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 03:56:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3DD89BBF45D; Thu, 22 Jun 2023 12:56:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 netdev@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 tirthendu.sarkar@intel.com, simon.horman@corigine.com
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
In-Reply-To: <CAJ8uoz3N1EVZAJZpe_R7rOQGpab4_yoWGPU7PB8PeKP9tvQWHg@mail.gmail.com>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-16-maciej.fijalkowski@intel.com>
 <87zg4uca21.fsf@toke.dk>
 <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
 <87o7l9c58j.fsf@toke.dk>
 <CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
 <20230621133424.0294f2a3@kernel.org>
 <CAJ8uoz3N1EVZAJZpe_R7rOQGpab4_yoWGPU7PB8PeKP9tvQWHg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 22 Jun 2023 12:56:31 +0200
Message-ID: <875y7flq8w.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> On Wed, 21 Jun 2023 at 22:34, Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Wed, 21 Jun 2023 16:15:32 +0200 Magnus Karlsson wrote:
>> > > Hmm, okay, that sounds pretty tedious :P
>> >
>> > Indeed if you had to do it manually ;-). Do not think this max is
>> > important though, see next answer.
>>
>> Can't we add max segs to Lorenzo's XDP info?
>> include/uapi/linux/netdev.h
>
> That should be straight forward. I am just reluctant to add a user
> interface that might not be necessary.

Yeah, that was why I was asking what the expectations were before
suggesting adding this to the feature bits :)

However, given that the answer seems to be "it varies"...

> Maciej, how about changing your patch #13 so that we do not add a flag
> for zc_mb supported or not, but instead we add a flag that gives the
> user the max number of frags supported in zc mode? A 1 returned would
> mean that max 1 frag is supported, i.e. mb is not supported. Any
> number >1 would mean that mb is supported in zc mode for this device
> and the returned number is the max number of frags supported. This way
> we would not have to add one more user interface solely for getting
> the max number of frags supported. What do you think?

...I think it's a good idea to add the field, and this sounds like a
reasonable way of dealing with it (although it may need a bit more
plumbing on the netlink side?)

-Toke


