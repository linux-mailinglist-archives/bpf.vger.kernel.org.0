Return-Path: <bpf+bounces-1712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A4972077D
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 18:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8688A1C210C5
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121D11D2A1;
	Fri,  2 Jun 2023 16:23:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B231C750
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 16:23:26 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26200B4
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 09:23:25 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af2c35fb85so31143331fa.3
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685723003; x=1688315003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVjukxXXRKShARj0zI7CQA/GP7CSQ+0VqGswmRXM5os=;
        b=gjsRknwyPaV+FS+WRK2i/aWzthHR9a45Zk2PiI8RgPEB+NLrgaHkEb1ck2OC86GmZc
         vQ8eVfcx7VrMC+8+9AGV3PnUZ08ikf7L6rkMAhDEsFh2N7TRTZk2hkdnq6xB0xp9Dpg+
         hw03GHhuHlraClTP/EjBRmjEVP9B3l8lYydm/WkAk1B4igRlRL0Ew1gbnwalsiFcKrHv
         OBaChiEAGH8rWtZXpTQFFhVaQOjrBttGycP/m3XCT9noZcFwThPfBdxyC/ZYQqyjgoPh
         FBSkD1UxqHp4q12lpWsIXiNeTEYM36X2gnzDfYE1on2uAGzNasKNa0LAOSIV30qbSUUK
         LaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723003; x=1688315003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVjukxXXRKShARj0zI7CQA/GP7CSQ+0VqGswmRXM5os=;
        b=XeZZHkkEEOWtzdKDgH19L0u2uC/XihqDo7I8Rv94EkBP5h7IIJ9H5fl5xjQbsPXUpW
         XVQFH89fSBJcvz9GfT3FOjpM4lzNQ1OVtJt8rkYDECHB1bokvYTwlZ/AvS8VuWsCWOuP
         7wSBOtz7+AExSNd0matDsC/8i+bImaYK96BvCuzh848h7eKMN9HYOU8TytNt4E23999/
         SSS3KlJ/yTSQ9Pqo8Aoq6S0Bb0m4x2LUoWmbxK8VIp2buDbu1Agtcs5kNMyNuNoneK3F
         TekaGwzSwHxsvFQHR5DUeTMb/It+d41asGSmGJNC7UChiTaLzKm/avAcjz00n/ZTsdP3
         ifIg==
X-Gm-Message-State: AC+VfDxmWY4G1nvKdlxvfyVPpX7elpudj+edXMBJRiG8fLwxKIJdLR0b
	5yrRGKFIvHm7ZPPUt31n6fmt80yoXa/IyZCzVYsNYp/DmK8=
X-Google-Smtp-Source: ACHHUZ6oxTIeXGUxNisI9NPglMANcttAXhZ2hU4QryTsrhDLrZJNMVzJCXosw2Vl6UiHWsQVpF5+qAZC0v8BqOefpW0=
X-Received: by 2002:a2e:9f12:0:b0:2a7:a5f7:9651 with SMTP id
 u18-20020a2e9f12000000b002a7a5f79651mr318702ljk.23.1685723002763; Fri, 02 Jun
 2023 09:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531110511.64612-1-aspsk@isovalent.com> <20230531110511.64612-2-aspsk@isovalent.com>
 <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local> <ZHhJUN7kQuScZW2e@zh-lab-node-5>
 <CAADnVQ+67FF=JsxTDxoo2XL8zSh5Y3xptGee8vBj8OwP3b=aew@mail.gmail.com>
 <ZHjhBFLLnUcSy9Tt@zh-lab-node-5> <CAADnVQLXFyhACfZP3bze8PUa43Fnc-Nn_PDGYX2vOq3i8FqKbA@mail.gmail.com>
 <CAADnVQ+FzCiQLbFaJihr8tuJXxjFNZqYs75cyhSDjds8nYBj4A@mail.gmail.com> <ZHn64W6ggfTyzW/U@zh-lab-node-5>
In-Reply-To: <ZHn64W6ggfTyzW/U@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 Jun 2023 09:23:11 -0700
Message-ID: <CAADnVQLn2hxXPXbmPXMn4G6=jCBd6Xmty7RO2bY+S-GiS8NJ6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Joe Stringer <joe@isovalent.com>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 7:20=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> On Thu, Jun 01, 2023 at 05:40:10PM -0700, Alexei Starovoitov wrote:
> > On Thu, Jun 1, 2023 at 11:24=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jun 1, 2023 at 11:17=E2=80=AFAM Anton Protopopov <aspsk@isova=
lent.com> wrote:
> > > > >
> > > > > LRU logic doesn't kick in until the map is full.
> > > >
> > > > In fact, it can: a reproducable example is in the self-test from th=
is patch
> > > > series. In the test N threads try to insert random values for keys =
1..3000
> > > > simultaneously. As the result, the map may contain any number of el=
ements,
> > > > typically 100 to 1000 (never full 3000, which is also less than the=
 map size).
> > > > So a user can't really even closely estimate the number of elements=
 in the LRU
> > > > map based on the number of updates (with unique keys). A per-cpu co=
unter
> > > > inc/dec'ed from the kernel side would solve this.
> > >
> > > That's odd and unexpected.
> > > Definitely something to investigate and fix in the LRU map.
> > >
> > > Pls cc Martin in the future.
> > >
> > > > > If your LRU map is not full you shouldn't be using LRU in the fir=
st place.
> > > >
> > > > This makes sense, yes, especially that LRU evictions may happen ran=
domly,
> > > > without a map being full. I will step back with this patch until we=
 investigate
> > > > if we can replace LRUs with hashes.
> > > >
> > > > Thanks for the comments!
> >
> > Thinking about it more...
> > since you're proposing to use percpu counter unconditionally for preall=
oc
> > and percpu_counter_add_batch() logic is batched,
> > it could actually be acceptable if it's paired with non-api access.
> > Like another patch can add generic kfunc to do __percpu_counter_sum()
> > and in the 3rd patch kernel/bpf/preload/iterators/iterators.bpf.c
> > for maps can be extended to print the element count, so the user can ha=
ve
> > convenient 'cat /sys/fs/bpf/maps.debug' way to debug maps.
> >
> > But additional logic of percpu_counter_add_batch() might get in the way
> > of debugging eventually.
> > If we want to have stats then we can have normal per-cpu u32 in basic
> > struct bpf_map that most maps, except array, will inc/dec on update/del=
ete.
> > kfunc to iterate over percpu is still necessary.
> > This way we will be able to see not only number of elements, but detect
> > bad usage when one cpu is only adding and another cpu is deleting eleme=
nts.
> > And other cpu misbalance.
>
> This looks for me like two different things: one is a kfunc to get the cu=
rrent
> counter (e.g., bpf_map_elements_count), the other is a kfunc to dump some=
 more
> detailed stats (e.g., per-cpu values or more).
>
> My patch, slightly modified, addresses the first goal: most maps of inter=
est
> already have a counter in some form (sometimes just atomic_t or u64+lock)=
. If
> we add a percpu (non-batch) counter for pre-allocated hashmaps, then it's=
 done:
> the new kfunc can get the counter based on the map type.
>
> If/when there's need to provide per-cpu statistics of elements or some mo=
re
> sophisticated statistics, this can be done without changing the api of th=
e
> bpf_map_elements_count() kfunc.
>
> Would this work?

No, because bpf_map_elements_count() as a building block is too big
and too specific. Nothing else can be made out of it, but counting
elements.
"for_each_cpu in per-cpu variable" would be generic that is usable beyond
this particular use case of stats collection.

