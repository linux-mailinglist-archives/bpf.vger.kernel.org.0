Return-Path: <bpf+bounces-3663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDEF741210
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 15:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2488280DE9
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB9C13D;
	Wed, 28 Jun 2023 13:16:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E8C12E
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 13:16:17 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E11E2134
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 06:16:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so8388700e87.2
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687958174; x=1690550174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WcbbyrufS0nV2DyodnxJiQmthoFbSxlr+ywuJKanMrg=;
        b=A+LC5H0NrTZYKpcRiZtA6UarfSc5RLgQiMRHb2vHPQN7ABNmp9HFbHKZ9J39XJxJH6
         bo2wZAgA1nYWRg/ONp37sVXebWkdRTk9lp+OwInfTes9kIGS+GJpGA2ZGWh4wB5+xCjV
         qTv5uh9O5ah3JUCsA3jLEsdaSemRFow5skX7d+khgV67RK1bMuYxz2XHTP6sWvvMWgXd
         Od0QqfhXPMj64PbNgrsuz0ATCv+LTgJTErhCCOKN4WmLcQbqfC7SHkj0jbfgPy1oIVEe
         DZyUc8VroLcUdr38b5+6fA8FM/dSQmMi0E4n1cjspmM0z07ts4IfxxKl4VwDgEtQ8yQJ
         k7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958174; x=1690550174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WcbbyrufS0nV2DyodnxJiQmthoFbSxlr+ywuJKanMrg=;
        b=UC7DrDcYKLbDehQlOu1yQ4etw4GvmjBJ+jPM8zn19VYXV89TVfpY7IzjW1+RdregDt
         J6+qEgCeCBMHR7iyJXcmueAX8C5WEfGiV1XFgYnG2cqZpiv6vB44vQiumgZy6JuTEdrb
         K/7bVJe+6G8JXg4YHUv0Fb+oK+yLPg/ojBmqu/hfB4AKsvCjkgAFZdL/Lu2abMroWaGa
         0HlCv6Q6UYgRZeNiKXJdCMgNwoT2/wqT6Sxp6mIPNkCc0hoMN/z9knbAlswZwitNnI/j
         pa5GEJT195N2ZExCdva1t1lZNnOO3zDfkc3YmlK6W/QcxUftmjznt7cdpdemgoMUgo0P
         sAMg==
X-Gm-Message-State: AC+VfDzGoATmXnPXmHgX6qQsLeTBzu4zzLWdqv2EmdOPDKv9PX97YQQP
	/EaqQrpRgklcxtxCVkV0Wl5rRA==
X-Google-Smtp-Source: ACHHUZ5BUsLIPvFet+AIMfoLoThbFhEN4UVyP3JeaLVa70JGKknGPSw07xUIB+qMvTNY0YmaYjwk9w==
X-Received: by 2002:a19:381b:0:b0:4f8:5713:4400 with SMTP id f27-20020a19381b000000b004f857134400mr18772279lfa.1.1687958174150;
        Wed, 28 Jun 2023 06:16:14 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id c11-20020aa7c74b000000b0051d96edccc7sm3388056eds.46.2023.06.28.06.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:16:13 -0700 (PDT)
Date: Wed, 28 Jun 2023 13:17:23 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
	Joe Stringer <joe@isovalent.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
Message-ID: <ZJwy478jHkxYNVMc@zh-lab-node-5>
References: <20230531110511.64612-1-aspsk@isovalent.com>
 <20230531110511.64612-2-aspsk@isovalent.com>
 <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local>
 <ZHhJUN7kQuScZW2e@zh-lab-node-5>
 <CAADnVQ+67FF=JsxTDxoo2XL8zSh5Y3xptGee8vBj8OwP3b=aew@mail.gmail.com>
 <ZHjhBFLLnUcSy9Tt@zh-lab-node-5>
 <CAADnVQLXFyhACfZP3bze8PUa43Fnc-Nn_PDGYX2vOq3i8FqKbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLXFyhACfZP3bze8PUa43Fnc-Nn_PDGYX2vOq3i8FqKbA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alexey, hi Martin,

On Thu, Jun 01, 2023 at 11:24:20AM -0700, Alexei Starovoitov wrote:
> On Thu, Jun 1, 2023 at 11:17 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > >
> > > LRU logic doesn't kick in until the map is full.
> >
> > In fact, it can: a reproducable example is in the self-test from this patch
> > series. In the test N threads try to insert random values for keys 1..3000
> > simultaneously. As the result, the map may contain any number of elements,
> > typically 100 to 1000 (never full 3000, which is also less than the map size).
> > So a user can't really even closely estimate the number of elements in the LRU
> > map based on the number of updates (with unique keys). A per-cpu counter
> > inc/dec'ed from the kernel side would solve this.
> 
> That's odd and unexpected.
> Definitely something to investigate and fix in the LRU map.
> 
> Pls cc Martin in the future.

I've looked into this a bit more and the problem is as follows.

LRU maps allocate MAX_ENTRIES elements and put them in the global free list.
Then each CPU will try to get memory in 128 elements chunks into their own
local free lists.

The user expectation is that evictions start when the map is full, however, on
practice we start evicting elements when capacity reaches about (MAX_ENTRIES -
NCPUS*128) elements. This happens because when one CPU have used its local
free-list, it gets to the global lists. While there could be another
(NCPUS-1)*128 free elements in local free lists of other CPUs, our CPU goes to
the global free list, which is empty, and then starts to evict elements from
active/inactive lists (a 128 elements chunk). Then this can happen for another
active CPU, etc.

This looks like not a problem for big maps, where (NCPUS*128) is not a big %%
of the total map capacity. For smaller maps this may be unexpected (I first
noticed this on a 4K map where after updating 4K keys map capacity was about
200-300 elements).

My first attempt to fix this was to just increase nr_entries allocated for the
map by NCPUS*128, which makes evictions to start happening at MAX_ENTRIES.  But
soon I've realized that in such way users can get more than MAX_ENTRIES inside
a map, which is unexpected as well (say, when dumping a map in a location of
MAX_ENTRIES size or syncing entries with another map of MAX_ENTRIES capacity).

I also briefly looked into allowing to call the prealloc_lru_pop() function
under a bucket lock (by passing the currently locked bucket to it so that this
pointer is passed all the way to the htab_lru_map_delete_node() function which
may then bypass locking the bucket if it is the same one). Looks like this
works, but I didn't have time to understand if this breaks the LRU architecture
badly or not.

