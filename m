Return-Path: <bpf+bounces-4295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C5C74A3D8
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C4F281458
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39382AD34;
	Thu,  6 Jul 2023 18:34:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1B946F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 18:34:10 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8721BF6
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 11:34:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso1505947e87.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688668447; x=1691260447;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aF3sv3PUlm8hIrzYKlIDmaUWloA5S+L5sqRJJnUWaKI=;
        b=T6vRItZhB5xM9QCwlEe8ZtJPeeYyVOMsi23t/pwgkAGUt5X2ZYA8rpt0oJxFiXlGun
         VmEC4LRKb8UMq0Ys85ZUuRlgjLt0hrGO/bQaUc7F4tPs7a59VLPzRokHXFtUjzqkvDGe
         T1N/kbKNgMlt3ymobDkKyv6VQyx3eIDxSKPp+dpPDBYGfKiycSPR+TcdXXxA0GTRDu8+
         6DpUl6+GERLiHaQPBuFvUiXH3hzjhwtCZfpMwb0ZTXi3QVhW/jVzdSLXJtngP+LFYxvh
         DHopAp+z4BEHY66gpnFTV7xABfe8uwiz8MkhZSQUPgT0lrgDIXUVI3ia4hhTf/7b3+Yi
         50fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688668447; x=1691260447;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aF3sv3PUlm8hIrzYKlIDmaUWloA5S+L5sqRJJnUWaKI=;
        b=hyxWBqa7iom6r2giMmNfGAvQnjYr/TZQ/nG2PKxXCxa3ovW1MYseGfmEGfAanIx0T2
         jaWrGlZ3nN4hemcKCUl45JsafX2ZlZlpTo/31u2uF8LkqmHgakaymYjao88zcHrGYrnT
         TnGoucbw29AUmhYCsYCHwP7jtZiH98cpg0e2A/ZPlV0+3xVFv209w66RrrqNladuPtn5
         8t4zD+IW0o4RHxz/0mNKQWx4dqsSdcE1/NcKfIfe6zfh5CHbAD6QqRr3IiV9Sa8Z7cGo
         K0bCQTTIITGxS5AFbAwqjYKrYiBatbpZA2mnuo2Z3G616uJhnnj6w09sy1P+aNkkWstd
         8yqw==
X-Gm-Message-State: ABy/qLbTdovxnNq0yXOBJx1idLsbawvPdroyJ0GNUyLy//2VF7sGUMDZ
	q4jGHseMVsrW8Psit6soyTPwHA==
X-Google-Smtp-Source: APBJJlH4qCMfOrZA0jpoV7fExxnRABP14xSigwCyQS/IznXfgj2jWj0EA6nw1rAcnlsAkJM9w1hj4g==
X-Received: by 2002:a05:6512:2384:b0:4fb:78b1:1cd4 with SMTP id c4-20020a056512238400b004fb78b11cd4mr2574957lfv.49.1688668447431;
        Thu, 06 Jul 2023 11:34:07 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id e14-20020a05600c218e00b003fa96fe2bd9sm287254wme.22.2023.07.06.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 11:34:06 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:35:18 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 6/6] selftests/bpf: check that ->elem_count
 is non-zero for the hash map
Message-ID: <ZKcJZt4JEKL1m8BR@zh-lab-node-5>
References: <20230705160139.19967-1-aspsk@isovalent.com>
 <20230705160139.19967-7-aspsk@isovalent.com>
 <CAADnVQLZMb3XqJFp8Oaz-83RzVHTV3EwJymKC817ekC57CNMBg@mail.gmail.com>
 <ZKZUpW5QeOviHCne@zh-lab-node-5>
 <CAADnVQJ4-j6bD9vicVi245cRMWijbW=jQhK5ioczBC-7FCi06A@mail.gmail.com>
 <ZKb9TjHX3GV35Yol@zh-lab-node-5>
 <CAADnVQJd9wb4_DumPdw31k6MCPQUy+T-ae6hFfGBpnX7tVLmKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJd9wb4_DumPdw31k6MCPQUy+T-ae6hFfGBpnX7tVLmKQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 10:48:16AM -0700, Alexei Starovoitov wrote:
> On Thu, Jul 6, 2023 at 10:42 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > >
> > > Don't you want to do:
> > >  val = bpf_map_lookup_elem(map, ...);
> > >  cnt = bpf_map_sum_elem_count(map);
> > >
> > > and that's the main use case ?
> >
> > Not sure I understand what this ^ use case is...
> >
> > Our primary use case is to [periodically] get the number of elements from the
> > user space. We can do this using an iterator as you've suggested and what is
> > tested in the added selftest.
> 
> Hmm. During the last office hours John explained that he needs to raise
> alarm to user space when the map is close to full capacity.
> Currently he's doing it with his own per-map counters implemented
> in a bpf prog.
> I'd expect the alarm to be done inline with updates to the counters.
> If you scan maps from user space every second or so there is a chance
> the spike in usage will be missed.
>
> If we're adding map counters they should be usable not only via iterators.

In some use cases this is ok to miss a spike in favour of not checking counters
too often. But yes, for other use cases this makes sense to add support for
const map ptr, so I will do this.

> 
> John,
> did I describe your use case correctly?

