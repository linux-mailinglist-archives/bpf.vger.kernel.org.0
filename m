Return-Path: <bpf+bounces-3329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C073C4FC
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 02:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85939281E74
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 00:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08435746F;
	Sat, 24 Jun 2023 00:00:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A86FD3
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 00:00:34 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36322736
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:00:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1003100a12.3
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687564832; x=1690156832;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wGiIMzDwzMpqTMWH9aLg5GtEBsj9Z4tW94L6h+MK7I=;
        b=TKJ2LHAIRxI2Y/XRqAKkH9RSXhZ9nL3mhhBU1vJnJCxGiJr5UdcmEU5J1pz0AN7Bmv
         cN3Y1CSZa3a/zaM4VVZCerPrDuG0hsOBUNL4SZ7m+bf2ZqHA+giuE0E3zTQD0VJXFhKe
         1H0aGEVJbBcPu5iBheY1AjyLpabo3/QlE+BCp4wy5oBKUAN2B7pYOBE+55Nuc+BLgLdc
         H77VCoahHJ1Hob+QAWW8QWgLx6QqseQd0F9Syj4TXBfjU1iv75jeQTm9K/OOI6kJ1oFl
         Q+iFUyWgyT6sNsR+jxVeczTPPIrXOhUcoaM4jCwGuMPhCUzm1slWH3I5hvfJDywr5Je6
         cHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687564832; x=1690156832;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1wGiIMzDwzMpqTMWH9aLg5GtEBsj9Z4tW94L6h+MK7I=;
        b=garxgaM5gp96qvMwe7JrXum8qhJNNIzTK0vNMjksTLyLMgS0xKsU6SoGD+rBY5OdF5
         +namC4pQQJFAK8UwDHUtXj3I4vT2nn7DKD84XQl2xBGGg2k3oPet1UDrp4ll7ulwJXnN
         D2KOWqUHvH7gTgEC1sybKMVJv+Ex3w+QIEefDepFCGBI2YC3Tf9p3G3lwjDsBuMzzcfT
         jItprt5Tqe9UUJNgEXNFseLUHT82Ytvrr4XzpUCCOoK4p/5zY3nS3G1jEWu3sGY+kHyE
         2R0w0VEPPNqwEeCiGu/fk2VJjtfCbzfClXRnSIMDo1aDUf2us9whJayTbB5dPrWpm5Xs
         FZcQ==
X-Gm-Message-State: AC+VfDwhbxLqQ71DJp4Pt9a8Sq+Slmg4JQblfMe8yzbVS2hmfuJBoIm7
	OjRO3QxtFjwU2otx53zK70swHRwIduk=
X-Google-Smtp-Source: ACHHUZ615VIWhfZ1zego3TST5pdNhgXYx+eTgAFG2d1/+QtxMlxVw0wNkSpstwe/QYhuUToXcu85Og==
X-Received: by 2002:a05:6a20:3d02:b0:121:c6cf:f96e with SMTP id y2-20020a056a203d0200b00121c6cff96emr20521825pzi.25.1687564832112;
        Fri, 23 Jun 2023 17:00:32 -0700 (PDT)
Received: from localhost ([98.97.117.85])
        by smtp.gmail.com with ESMTPSA id h63-20020a638342000000b0053fc6df5895sm213398pge.39.2023.06.23.17.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 17:00:31 -0700 (PDT)
Date: Fri, 23 Jun 2023 17:00:15 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Anton Protopopov <aspsk@isovalent.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, 
 bpf <bpf@vger.kernel.org>, 
 Joe Stringer <joe@isovalent.com>, 
 John Fastabend <john.fastabend@gmail.com>
Message-ID: <6496320f40706_7b3662086f@john.notmuch>
In-Reply-To: <CAADnVQLn2hxXPXbmPXMn4G6=jCBd6Xmty7RO2bY+S-GiS8NJ6w@mail.gmail.com>
References: <20230531110511.64612-1-aspsk@isovalent.com>
 <20230531110511.64612-2-aspsk@isovalent.com>
 <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local>
 <ZHhJUN7kQuScZW2e@zh-lab-node-5>
 <CAADnVQ+67FF=JsxTDxoo2XL8zSh5Y3xptGee8vBj8OwP3b=aew@mail.gmail.com>
 <ZHjhBFLLnUcSy9Tt@zh-lab-node-5>
 <CAADnVQLXFyhACfZP3bze8PUa43Fnc-Nn_PDGYX2vOq3i8FqKbA@mail.gmail.com>
 <CAADnVQ+FzCiQLbFaJihr8tuJXxjFNZqYs75cyhSDjds8nYBj4A@mail.gmail.com>
 <ZHn64W6ggfTyzW/U@zh-lab-node-5>
 <CAADnVQLn2hxXPXbmPXMn4G6=jCBd6Xmty7RO2bY+S-GiS8NJ6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alexei Starovoitov wrote:
> On Fri, Jun 2, 2023 at 7:20=E2=80=AFAM Anton Protopopov <aspsk@isovalen=
t.com> wrote:
> >
> > On Thu, Jun 01, 2023 at 05:40:10PM -0700, Alexei Starovoitov wrote:
> > > On Thu, Jun 1, 2023 at 11:24=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 1, 2023 at 11:17=E2=80=AFAM Anton Protopopov <aspsk@i=
sovalent.com> wrote:
> > > > > >
> > > > > > LRU logic doesn't kick in until the map is full.
> > > > >
> > > > > In fact, it can: a reproducable example is in the self-test fro=
m this patch
> > > > > series. In the test N threads try to insert random values for k=
eys 1..3000
> > > > > simultaneously. As the result, the map may contain any number o=
f elements,
> > > > > typically 100 to 1000 (never full 3000, which is also less than=
 the map size).
> > > > > So a user can't really even closely estimate the number of elem=
ents in the LRU
> > > > > map based on the number of updates (with unique keys). A per-cp=
u counter
> > > > > inc/dec'ed from the kernel side would solve this.
> > > >
> > > > That's odd and unexpected.
> > > > Definitely something to investigate and fix in the LRU map.
> > > >
> > > > Pls cc Martin in the future.
> > > >
> > > > > > If your LRU map is not full you shouldn't be using LRU in the=
 first place.
> > > > >
> > > > > This makes sense, yes, especially that LRU evictions may happen=
 randomly,
> > > > > without a map being full. I will step back with this patch unti=
l we investigate
> > > > > if we can replace LRUs with hashes.
> > > > >
> > > > > Thanks for the comments!
> > >
> > > Thinking about it more...
> > > since you're proposing to use percpu counter unconditionally for pr=
ealloc
> > > and percpu_counter_add_batch() logic is batched,
> > > it could actually be acceptable if it's paired with non-api access.=

> > > Like another patch can add generic kfunc to do __percpu_counter_sum=
()
> > > and in the 3rd patch kernel/bpf/preload/iterators/iterators.bpf.c
> > > for maps can be extended to print the element count, so the user ca=
n have
> > > convenient 'cat /sys/fs/bpf/maps.debug' way to debug maps.
> > >
> > > But additional logic of percpu_counter_add_batch() might get in the=
 way
> > > of debugging eventually.
> > > If we want to have stats then we can have normal per-cpu u32 in bas=
ic
> > > struct bpf_map that most maps, except array, will inc/dec on update=
/delete.
> > > kfunc to iterate over percpu is still necessary.
> > > This way we will be able to see not only number of elements, but de=
tect
> > > bad usage when one cpu is only adding and another cpu is deleting e=
lements.
> > > And other cpu misbalance.
> >
> > This looks for me like two different things: one is a kfunc to get th=
e current
> > counter (e.g., bpf_map_elements_count), the other is a kfunc to dump =
some more
> > detailed stats (e.g., per-cpu values or more).
> >
> > My patch, slightly modified, addresses the first goal: most maps of i=
nterest
> > already have a counter in some form (sometimes just atomic_t or u64+l=
ock). If
> > we add a percpu (non-batch) counter for pre-allocated hashmaps, then =
it's done:
> > the new kfunc can get the counter based on the map type.
> >
> > If/when there's need to provide per-cpu statistics of elements or som=
e more
> > sophisticated statistics, this can be done without changing the api o=
f the
> > bpf_map_elements_count() kfunc.
> >
> > Would this work?
> =

> No, because bpf_map_elements_count() as a building block is too big
> and too specific. Nothing else can be made out of it, but counting
> elements.
> "for_each_cpu in per-cpu variable" would be generic that is usable beyo=
nd
> this particular use case of stats collection.

Without much thought, could you hook the eviction logic in LRU to know
when the evict happens and even more details about what was evicted so
we could debug the random case where we evict something in a conntrack
table and then later it comes back to life and sends some data like a
long living UDP session.

For example in the cases where you build an LRU map because in 99%
cases no evictions happen and the LRU is just there as a backstop
you might even generate events to userspace to let it know evicts
are in progress and they should do something about it.

Thanks,
John=

