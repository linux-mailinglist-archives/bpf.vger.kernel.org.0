Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109E164A9E0
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 23:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiLLWAY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 17:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLLWAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 17:00:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948701007B;
        Mon, 12 Dec 2022 14:00:22 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so1485100pjm.2;
        Mon, 12 Dec 2022 14:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPROv2++iXsCYjxrqkErN/kEU/7ybcYjBebe0YqyUn0=;
        b=VGeiVpUO66G982s+iqcLVxzYcow6fONQ6sCMHG1mPkB/am1PbtnL87w6vUoLP+urCC
         N8YsE5p9FVFNEWd+vZRjbdd2gDjthj4kUrWouWdGAEnFM0koYRtPF9C0/su90sOOSYyN
         0B/6I/zWHEojMpjoTMBQ7GQLKr1uM4hMjc1NuKlBba/xOexC7TVebHql4vy6wEwqZaAR
         Iut873m+Cva5JjsyYs0nVNWHiJZ/QXAR54q76fh1iyCgMJeZHrSU8SrOPHYyH+94ffAd
         vjuz/C6zLGc/yGqwZdMNy7OZtkBIl1zsxSzZFHb0dp9hfFwJwZSbf+jqSi1f0vrf4vUa
         m0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPROv2++iXsCYjxrqkErN/kEU/7ybcYjBebe0YqyUn0=;
        b=1uQX4aYX3a4bk9Tgzg/nHs3i74J2jfbaD1LCCWWXVZwsAooeBk7Qk/UXaIbsmnZj7J
         yK0y1EwBwYph1jVaReVmXVfucxfCLKcBL6G4SfjGcjC2qcYldkSUgDozaKD8/53dAC0E
         +Bn5XJJZn70ey4GlKsW10SpSrjibRBRZITQBFQrdKBtyMowtVcStJheir2qof/WA9/lW
         9POaqWq3iYczERMSJBLmQ5A0NinuGblOSDGBeD6sDJwJsbclmjqSQ7o7yGj5Ljhm1Weh
         8p3f3hitJ0VjpfEhaZk7qZve7+A+CmOAp+a6dEVhj71TSN0dYR4wcmK4KNxzfsVsfV63
         aUJA==
X-Gm-Message-State: ANoB5pl7+f9JYtl5n63CV9JqcdkdJOslXf0H3hYfc3i7veAR8M4utU1Y
        8pj1dmn+YGuTkNpi5SG2JZc=
X-Google-Smtp-Source: AA0mqf5nvWlMLAJ0H4XXVBwQULotBr9HnfrYpuM9nuujrhpx0BW3VSNB5ryC/uGn69j0vyL2NfTqIw==
X-Received: by 2002:a05:6a20:1010:b0:a2:ed21:d820 with SMTP id a16-20020a056a20101000b000a2ed21d820mr27961408pzd.42.1670882421804;
        Mon, 12 Dec 2022 14:00:21 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b00187197c499asm6876607plb.164.2022.12.12.14.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:00:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 12:00:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 31/31] sched_ext: Add a rust userspace hybrid example
 scheduler
Message-ID: <Y5ekc7v01cXHX8gc@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-32-tj@kernel.org>
 <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Mon, Dec 12, 2022 at 03:03:20PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 29, 2022 at 10:23:13PM -1000, Tejun Heo wrote:
> > From: Dan Schatzberg <dschatzberg@meta.com>
> > 
> > Atropos is a multi-domain BPF / userspace hybrid scheduler where the BPF
> > part does simple round robin in each domain and the userspace part
> > calculates the load factor of each domain and tells the BPF part how to load
> > balance the domains.
> > 
> > This scheduler demonstrates dividing scheduling logic between BPF and
> > userspace and using rust to build the userspace part.
> 
> And here I am, speaking neither Rust nor BPF.

I'm not super fluent in rust but do really enjoy whenever I get to do things
in it. What the language pulls off is actually really neat. It does take
some getting-used-to tho.

> But really, having seen some of this I long for the UMCG patches -- that
> at least was somewhat sane and trivially composes, unlike all this
> madness.

Putting aside lack of familiarity, there are several things which make the
examples including this one not very readable. e.g. how the loops have to be
structured in BPF and the inability to seamlessly access the elements of
certain BPF map types do hamper ergonomics and readability quite a bit. That
said, there are a lot of new developments in BPF which should improve many
of these areas, so hopefully things should keep getting better.

Thanks.

-- 
tejun
