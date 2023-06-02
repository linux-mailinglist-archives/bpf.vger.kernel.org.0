Return-Path: <bpf+bounces-1687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0936B72042C
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEC81C20E8C
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE5719BA3;
	Fri,  2 Jun 2023 14:20:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E119527
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 14:20:29 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87F1A6
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 07:20:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30ad752f433so1904141f8f.3
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1685715626; x=1688307626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xHZj17IsBY/kBKUuP07t0/SQ8KbdY0+7aTcU2T6oab4=;
        b=Br5k1qwYE3TTVxMYTxP+plKjdrCF8dYSc5TPHrn2JyJ4KmYa5BQzmE/94VgHXkMRNN
         MJMtnr6dV6pJKU5MnKviq9bfUHD/zir7IG7I55loPMVN7QpabykoNmjgOZUPxDQdNPth
         pQOFESBuzKGODSaarTGpd6PpcRCRUOxwKszPB7kH2oPrg7N/Gkxn45k+vG557HafXo8G
         4FUXmH3ZsZCdu6h4Jrl/S8RzJTNIx4lI7FyzmEVoBoZOS8m545XZ2p0i5xd22qdiQWCa
         xpbhe/DLq5j/C0axIcNaLqtM0NCdpJMmybioxiYRYvO7VtZQJomkUtWjphENFVfm7vux
         2YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685715626; x=1688307626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHZj17IsBY/kBKUuP07t0/SQ8KbdY0+7aTcU2T6oab4=;
        b=AwFRBk2t8IN8KUlRsFh4VNGAWuiGuZ/GdPE+qyQ7acRWVzpNN20ra3NNC/unRZ9I7C
         xMdwAkBwBpdSk5l/GXIOybnHjwfNOmgZV6sbtEn66sDxv8KSqZfvtz/hoqzyW2FusHeq
         qrXcwcP7g+BWNU/swNZCFN7GJVaqpXmciuYVg0CGGpeGDDOwiGlqxs4S2e922cFqiwx5
         1GRHjgdx1w+Ne1B/XSFULgfHpM5xaz4alhJqcnJY6C0E44pz8oe+CbxBq7L6M5oPfmMp
         kMqmK6hAx1KXkNj4kkB+neRSPoVvz/FreRxwNpsXTD1ICuGPAnndpV/FBERlumJLjcUZ
         Oacg==
X-Gm-Message-State: AC+VfDxKMDp7kNNqT6A26fKV0frt8v1Gcm7ygMd0hBsukrwzA+cyt2WQ
	ot2T8Z3No7WqiEGeKkpz1v499A==
X-Google-Smtp-Source: ACHHUZ53U4Oc/1NTtyRyjxspIKa8p8JQKO9ehIgIWCTNrCl+MyZ1InEBxoHm/HrnfH1xGxoh07eBlg==
X-Received: by 2002:adf:e74f:0:b0:30a:e5f1:eedd with SMTP id c15-20020adfe74f000000b0030ae5f1eeddmr62224wrn.67.1685715625841;
        Fri, 02 Jun 2023 07:20:25 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003f42894ebe2sm5649710wmf.23.2023.06.02.07.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:20:25 -0700 (PDT)
Date: Fri, 2 Jun 2023 14:21:21 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
	Joe Stringer <joe@isovalent.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
Message-ID: <ZHn64W6ggfTyzW/U@zh-lab-node-5>
References: <20230531110511.64612-1-aspsk@isovalent.com>
 <20230531110511.64612-2-aspsk@isovalent.com>
 <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local>
 <ZHhJUN7kQuScZW2e@zh-lab-node-5>
 <CAADnVQ+67FF=JsxTDxoo2XL8zSh5Y3xptGee8vBj8OwP3b=aew@mail.gmail.com>
 <ZHjhBFLLnUcSy9Tt@zh-lab-node-5>
 <CAADnVQLXFyhACfZP3bze8PUa43Fnc-Nn_PDGYX2vOq3i8FqKbA@mail.gmail.com>
 <CAADnVQ+FzCiQLbFaJihr8tuJXxjFNZqYs75cyhSDjds8nYBj4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+FzCiQLbFaJihr8tuJXxjFNZqYs75cyhSDjds8nYBj4A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 01, 2023 at 05:40:10PM -0700, Alexei Starovoitov wrote:
> On Thu, Jun 1, 2023 at 11:24 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jun 1, 2023 at 11:17 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > >
> > > > LRU logic doesn't kick in until the map is full.
> > >
> > > In fact, it can: a reproducable example is in the self-test from this patch
> > > series. In the test N threads try to insert random values for keys 1..3000
> > > simultaneously. As the result, the map may contain any number of elements,
> > > typically 100 to 1000 (never full 3000, which is also less than the map size).
> > > So a user can't really even closely estimate the number of elements in the LRU
> > > map based on the number of updates (with unique keys). A per-cpu counter
> > > inc/dec'ed from the kernel side would solve this.
> >
> > That's odd and unexpected.
> > Definitely something to investigate and fix in the LRU map.
> >
> > Pls cc Martin in the future.
> >
> > > > If your LRU map is not full you shouldn't be using LRU in the first place.
> > >
> > > This makes sense, yes, especially that LRU evictions may happen randomly,
> > > without a map being full. I will step back with this patch until we investigate
> > > if we can replace LRUs with hashes.
> > >
> > > Thanks for the comments!
> 
> Thinking about it more...
> since you're proposing to use percpu counter unconditionally for prealloc
> and percpu_counter_add_batch() logic is batched,
> it could actually be acceptable if it's paired with non-api access.
> Like another patch can add generic kfunc to do __percpu_counter_sum()
> and in the 3rd patch kernel/bpf/preload/iterators/iterators.bpf.c
> for maps can be extended to print the element count, so the user can have
> convenient 'cat /sys/fs/bpf/maps.debug' way to debug maps.
> 
> But additional logic of percpu_counter_add_batch() might get in the way
> of debugging eventually.
> If we want to have stats then we can have normal per-cpu u32 in basic
> struct bpf_map that most maps, except array, will inc/dec on update/delete.
> kfunc to iterate over percpu is still necessary.
> This way we will be able to see not only number of elements, but detect
> bad usage when one cpu is only adding and another cpu is deleting elements.
> And other cpu misbalance.

This looks for me like two different things: one is a kfunc to get the current
counter (e.g., bpf_map_elements_count), the other is a kfunc to dump some more
detailed stats (e.g., per-cpu values or more).

My patch, slightly modified, addresses the first goal: most maps of interest
already have a counter in some form (sometimes just atomic_t or u64+lock). If
we add a percpu (non-batch) counter for pre-allocated hashmaps, then it's done:
the new kfunc can get the counter based on the map type.

If/when there's need to provide per-cpu statistics of elements or some more
sophisticated statistics, this can be done without changing the api of the
bpf_map_elements_count() kfunc.

Would this work?

> but debugging and stats is a slippery slope. These simple stats won't be
> enough and people will be tempted to add more and more.
> So I agree that there is a need for bpf map observability,
> but it is not clear whether hard coded stats is the solution.

