Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9857D6F1610
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 12:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345552AbjD1Kxq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 06:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345595AbjD1Kxo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 06:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C3E2116
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 03:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682679176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+ULg++VU6Z9Sfko72HfIvUtxTw3hDxjpqo3Ne7UJBw=;
        b=JIagRYzTQwdfQu2f+dgXB0jOBTFxevirbb/fVG04b+ScKlG5PtvZzzXFbmz1fcVWYuHPQx
        n9kGOJBiSKjGBWHKX1GCl5QNVUYDDRF7w02n80O+snupEYKE0aRlE6ZztWZXpMUD20h9CV
        XjH57Tp2scXFFLsDO3YDrffxX9nhAg4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-49xe8re1O8-CnJqANRXUSw-1; Fri, 28 Apr 2023 06:52:54 -0400
X-MC-Unique: 49xe8re1O8-CnJqANRXUSw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-95f6f291b9aso374067066b.3
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 03:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682679173; x=1685271173;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+ULg++VU6Z9Sfko72HfIvUtxTw3hDxjpqo3Ne7UJBw=;
        b=hP7LR0X/mFy6+VCNgsVD5pkC96zGJuA3y3cr8lqZiALp6OmDMZvvmtJRntVjTRyQQL
         g4syE+RHT5RIws+XHC6HqAStxXsUp9DMDVEdhYdUHPhruF1B65joEYIeFge+skSkx1nj
         3gUpURYjLBjz/K0/fiE9JWchRLnzYqQ4CAp+YDO3/B7WH5oOoClVS1Nl0kS9CkNGFYGm
         HuzKwO/5JfqlwYrgUXewA3RTtoxuTxh2LlHgk73NSszdBNUg8Q9sM+VWpDu3WSnWVxp6
         uNOyW+5vKcWxXu/h9vX0QdVbHkfKlOM+3Hmp864ftKwfJTmLZiggaoSzgZTDouMTXkBd
         ldiA==
X-Gm-Message-State: AC+VfDwGMbaFMiIKYJWK5emSzKA6UqaelfUgNjAbriGsuOSwOmLV8PiC
        HijlqkRQxrGYrN7MASEWmJ0pGK/JGBzneoiUaoSulnxoUgCX060wiuAbaYjnp4PqSLS8ymT/sqN
        rRFo3XS4uFttl
X-Received: by 2002:a17:907:368d:b0:94e:48ac:9a51 with SMTP id bi13-20020a170907368d00b0094e48ac9a51mr4905333ejc.4.1682679172553;
        Fri, 28 Apr 2023 03:52:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pNYQfKdJa7/R3tHp6KZk6XXZGEyekEMVRJH02AdzCQHAhaOzZ8FY7SeF1FsXK21oUds+pxw==
X-Received: by 2002:a17:907:368d:b0:94e:48ac:9a51 with SMTP id bi13-20020a170907368d00b0094e48ac9a51mr4905282ejc.4.1682679171643;
        Fri, 28 Apr 2023 03:52:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906394b00b0094f4f2db7e0sm11184180eje.143.2023.04.28.03.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 03:52:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7C654ADCA55; Fri, 28 Apr 2023 12:52:50 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>
Cc:     brouer@redhat.com, lorenzo@kernel.org, linyunsheng@huawei.com,
        bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org
Subject: Re: [PATCH RFC net-next/mm V2 1/2] page_pool: Remove workqueue in
 new shutdown scheme
In-Reply-To: <4eab92af-251a-a9aa-e270-179634d0345b@redhat.com>
References: <168262348084.2036355.16294550378793036683.stgit@firesoul>
 <168262351129.2036355.1136491155595493268.stgit@firesoul>
 <871qk582tn.fsf@toke.dk> <4eab92af-251a-a9aa-e270-179634d0345b@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 28 Apr 2023 12:52:50 +0200
Message-ID: <87mt2s6zy5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <jbrouer@redhat.com> writes:

> On 27/04/2023 22.53, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> +noinline
>>>   static void page_pool_empty_ring(struct page_pool *pool)
>>>   {
>>>   	struct page *page;
>>> @@ -796,39 +828,29 @@ static void page_pool_scrub(struct page_pool *poo=
l)
>>>   	page_pool_empty_ring(pool);
>>>   }
>> So this is not in the diff context, but page_pool_empty_ring() does
>> this:
>>=20
>> static void page_pool_empty_ring(struct page_pool *pool)
>> {
>> 	struct page *page;
>>=20
>> 	/* Empty recycle ring */
>> 	while ((page =3D ptr_ring_consume_bh(&pool->ring))) {
>> 		/* Verify the refcnt invariant of cached pages */
>> 		if (!(page_ref_count(page) =3D=3D 1))
>> 			pr_crit("%s() page_pool refcnt %d violation\n",
>> 				__func__, page_ref_count(page));
>>=20
>> 		page_pool_return_page(pool, page);
>> 	}
>> }
>>=20
>> ...and with this patch, that page_pool_return_page() call will now free
>> the pool memory entirely when the last page is returned. When it does
>> this, the condition in the while loop will still execute afterwards; it
>> would return false, but if the pool was freed, it's now referencing
>> freed memory when trying to read from pool->ring.
>
> Yes, that sounds like a problem.
>
>> So I think page_pool_empty_ring needs to either pull out all the pages
>> in the ring to an on-stack buffer before calling page_pool_return_page()
>> on them, or there needs to be some other way to break the loop early.
>
> Let me address this one first, I'll get back to the other in another
> reply.  The usual/idiom way of doing this is to have a next pointer that
> is populated inside the loop before freeing the object.
> It should look like this (only compile tested):
>
>   static void page_pool_empty_ring(struct page_pool *pool)
>   {
> 	struct page *page, *next;
>
> 	next =3D ptr_ring_consume_bh(&pool->ring);
>
> 	/* Empty recycle ring */
> 	while (next) {
> 		page =3D next;
> 		next =3D ptr_ring_consume_bh(&pool->ring);
>
> 		/* Verify the refcnt invariant of cached pages */
> 		if (!(page_ref_count(page) =3D=3D 1))
> 			pr_crit("%s() page_pool refcnt %d violation\n",
> 				__func__, page_ref_count(page));
>
> 		page_pool_return_page(pool, page);
> 	}
>   }

Yup, that works!

>> There are a couple of other places where page_pool_return_page() is
>> called in a loop where the loop variable lives inside struct page_pool,
>> so we need to be absolutely sure they will never be called in the
>> shutdown stage, or they'll have to be fixed as well.
>
> The other loops are okay, but I spotted another problem in=20
> __page_pool_put_page() in "Fallback/non-XDP mode", but that is fixable.

Alright, great!

-Toke

