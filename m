Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C278646EC75
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 17:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhLIQFl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 11:05:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233176AbhLIQFk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 11:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639065726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HkMwGUSLzSpEkF6yTy3MllG932xksHPg1EKQ//z4ek=;
        b=Lw2Wench/G4m0zbl3NJkKNSWeSrsiZiDlDYKf1/2DhXve5dYuHcbPkiU8YvyVR3i4Qn/NW
        36xh9p+zUyPeV4M0RPfhppzDyAVq4GTm0RkPPfWxw4ufzL/2hteSfOx3gck9J8wf+YvytY
        93NSrmFxQeBTl8S+MoWOlDKKew/UqLk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-CyapcwVUPvCjykn650B0GA-1; Thu, 09 Dec 2021 11:02:02 -0500
X-MC-Unique: CyapcwVUPvCjykn650B0GA-1
Received: by mail-ed1-f71.google.com with SMTP id w18-20020a056402071200b003e61cbafdb4so5679562edx.4
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 08:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1HkMwGUSLzSpEkF6yTy3MllG932xksHPg1EKQ//z4ek=;
        b=VxjOsRNJqcIy3PlZv0n0iDj9XH8I1FsSjF8TMATJQe0copZr7bhGd8Ba7hB6sySwa9
         wghhqYQT064xh/NYQ378cbIvo204H/AKTBT1xP9iGziLzwxIrYxEWBZYbvFrxgHEIOYF
         O7Xkn7a0JAZRf5P3+G4+6NmRYlkq+SHRQ3J7wiSs97Yi4rb3JRSDxHiXcPoY7Tgs5TH8
         kJYmf+SXrfxHXgFDRItebBAauuovmiN7YxlxpuBp9nTqGLkGM4slPz19HkzLx0Li8XMK
         27t0AIYMZuk5dgeZesbnAIx8aZWqtLLcL6VhivbjYqe0Og4suhU0yJ+1BMn71Ww3JFeF
         FrHA==
X-Gm-Message-State: AOAM530FE+pTJHPuzy3yvtsb5rW/BaL8Tj4/7hDuqVTL6CmobF/22eFd
        zrDAakdn1HFxc0ReLAaCQYYOK/ygK4LrTfVBNtBZsdXB3M1dThmPQNb1XVJEI/e9rhRoHjhbTRp
        CL/vnC1LpWnb4
X-Received: by 2002:a05:6402:1292:: with SMTP id w18mr29991086edv.46.1639065720969;
        Thu, 09 Dec 2021 08:02:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwe+6roGeOOO9pQCDglWWGKyk6lJOhnyfnE3Kissr7dFE7pyUHoYF7URLruw9+/XBdDKKT4A==
X-Received: by 2002:a05:6402:1292:: with SMTP id w18mr29991046edv.46.1639065720672;
        Thu, 09 Dec 2021 08:02:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g15sm148774ejt.10.2021.12.09.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:02:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7077F180471; Thu,  9 Dec 2021 17:01:59 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: RE: [PATCH bpf-next 1/8] page_pool: Add callback to init pages when
 they are allocated
In-Reply-To: <61b131f0a4c18_97957208ad@john.notmuch>
References: <20211202000232.380824-1-toke@redhat.com>
 <20211202000232.380824-2-toke@redhat.com>
 <61b131f0a4c18_97957208ad@john.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 09 Dec 2021 17:01:59 +0100
Message-ID: <87zgp9wyvc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Add a new callback function to page_pool that, if set, will be called ev=
ery
>> time a new page is allocated. This will be used from bpf_test_run() to
>> initialise the page data with the data provided by userspace when running
>> XDP programs with redirect turned on.
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> LGTM.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
>
>>  include/net/page_pool.h | 2 ++
>>  net/core/page_pool.c    | 2 ++
>>  2 files changed, 4 insertions(+)
>>=20
>> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
>> index 3855f069627f..a71201854c41 100644
>> --- a/include/net/page_pool.h
>> +++ b/include/net/page_pool.h
>> @@ -80,6 +80,8 @@ struct page_pool_params {
>>  	enum dma_data_direction dma_dir; /* DMA mapping direction */
>>  	unsigned int	max_len; /* max DMA sync memory size */
>>  	unsigned int	offset;  /* DMA addr offset */
>> +	void (*init_callback)(struct page *page, void *arg);
>> +	void *init_arg;
>>  };
>>=20=20
>>  struct page_pool {
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 9b60e4301a44..fb5a90b9d574 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -219,6 +219,8 @@ static void page_pool_set_pp_info(struct page_pool *=
pool,
>>  {
>>  	page->pp =3D pool;
>>  	page->pp_magic |=3D PP_SIGNATURE;
>> +	if (unlikely(pool->p.init_callback))
>> +		pool->p.init_callback(page, pool->p.init_arg);
>
> already in slow path right? So unlikely in a slow path should not
> have any impact on performance is my reading.

Yeah, fair point, may have gone a little overboard on the "minimise
impact to existing code" here - will drop.

-Toke

