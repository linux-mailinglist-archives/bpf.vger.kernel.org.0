Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B611B5728A6
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 23:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiGLVav (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 17:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiGLVat (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 17:30:49 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91577CEB9D
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 14:30:47 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f14so7381659qkm.0
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 14:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/ov82X9kW39yvbxY1McMir/k+O2+nYDyG4xPScmDyfc=;
        b=ay3/5lDUwcy1Hcdr2vmHaxiMQwYnvd/iCWseV3Jo2Kp2E/uDYFyEIr76QZQCwA7K+S
         wi1beA0eG1qxbEBdN7ZT4w6+ri8TWB8pNNplK5yvswScENpVx3UZUWOZYg2+DBlj4gEf
         YPcT+/qh0IYxNQoeADazl8GnAJqKoTR8qVEaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/ov82X9kW39yvbxY1McMir/k+O2+nYDyG4xPScmDyfc=;
        b=4pNJJtfXdJ0/FSemNcczr56bBlnDwpr/fUFktR/1T34j4pAA6gW7minotWtQbqFYaU
         9Iy/ZpHpJOWRilZpPLLPkvNnBd4R0QI5+As64SE6DPamk2XOAuE1VlRZZBw6kMPZyT6L
         88TK2lHfRe4lIB/XSPNYPJRT+YA4lGYL7RpCap579KYxa9Ty8lNcsz9vWPcH1TkegeSQ
         E/wVFIvEzgdUucVACGWHEBe7jheuWlsgjoFf1K+OcFqhW3mdtLIdOhOn3cv3Ka5QaAiI
         L32nv4G+REw2jQdk+TA8HKOhx23v9ltfn7Z/3psfhcHSVQdYgoCoZSG4gItOG/eLWY9p
         /c7A==
X-Gm-Message-State: AJIora8smmnHAakrQaGQjrlI4ryg3T8shCTgLBALViVl7tkjPtyaILZ8
        Pf/WRZt5bInEkq2lBwzwnIR8kcnJSimV+CRY
X-Google-Smtp-Source: AGRyM1tPYp1vPM53Xd2cP3aF0HKDN4RijBCYmU7LSYzQBcaeKECQ9LthjfLWLntHfoh9ElULngaJQA==
X-Received: by 2002:a05:620a:132d:b0:6b5:9575:9080 with SMTP id p13-20020a05620a132d00b006b595759080mr222850qkj.153.1657661446728;
        Tue, 12 Jul 2022 14:30:46 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a44cd00b006b5a9e53105sm1931238qkp.91.2022.07.12.14.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:30:46 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 12 Jul 2022 17:30:44 -0400 (EDT)
To:     James Clark <james.clark@arm.com>
cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/8] perf evsel: Do not request ptrauth sample field if
 not supported
In-Reply-To: <8d282e87-c1c8-f7a0-631b-8d569c2154a6@arm.com>
Message-ID: <8b6a583a-4ee0-8097-54e5-7d51a6edaa@maine.edu>
References: <20220704145333.22557-1-andrew.kilroy@arm.com> <20220704145333.22557-3-andrew.kilroy@arm.com> <d67dff7-73c3-e5a-eb7b-f132e8f565cc@maine.edu> <8d282e87-c1c8-f7a0-631b-8d569c2154a6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 11 Jul 2022, James Clark wrote:
> On 06/07/2022 17:01, Vince Weaver wrote:
> > So in this case you are leaking ARM64-specific info into the generic 
> > perf_event_open() call?  Is there any way the kernel could implement this 
> > without userspace having to deal with the issue?
> 
> The alternative to this change is just to call it "PERF_SAMPLE_POINTER_AUTH_MASK"
> and then it's not Arm specific, it's just that only Arm implements it for now.
> This is definitely an option.
> 
> But if no platform ever implements something similar then that bit is wasted.
> The intention of adding "PERF_SAMPLE_ARCH_1" was to prevent wasting that bit.
> But as you say, maybe making it arch specific isn't the right way either.

I don't know what the current kernel policy is on this kind of thing, but 
in the past perf_event_open was meant to be a generic as possible.
Having architecture-specific magic bits is best avoided.
However I'm not the maintainer for this so really my opinion doesn't 
really matter.

I'm just speaking up as a userspace coder who is trying to write 
cross-platform tools, and having to maintain obscure arch-specific code 
paths in every single utility ends up being a huge pain.  And isn't the 
whole point of an operating system to abstract this away?

> > can tell there haven't been any documentation patches included for the 
> > Makefile.
> 
> We plan to update the docs for the syscall, but it's in another repo, and
> we'll wait for this change to be finalised first. I'm not sure what you
> mean about the Makefile?

sorry, that was a mis-type.  I meant "manpage" not Makefile.

Vince Weaver
vincent.weaver@maine.edu
