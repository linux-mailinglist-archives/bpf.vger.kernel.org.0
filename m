Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE5523B96
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 19:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345601AbiEKRdL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 13:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244493AbiEKRdL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 13:33:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFDB1A8E1C
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 10:33:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so5565946pju.2
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eplKEuyl2XwziYBtPQMXsLaADniHrRGbEFAJfGt2TV0=;
        b=jPa9U9J4NUoPTCCN9EmTAMTMBkmR97wfM92r2qY36KqzHYzXb+fFPkjoMLk8y/3zyu
         aNUq5TpqiB0cW0EhWEb4HKGciRFc3MbkW0RLlvX1iD7bhctV5FaPPPDuglJTVe09k14T
         yb7bRCN1cN2bXyHHkixpgBxD2svUhsB1NKYJzrwO+G0a4wx9oz6R9JtbfXwtRwbpg6M8
         sx5inCjfIaB3fJQP4irvWmlwBVxwqVgdITrByMMlSvq62KlusDHJ9V3tWfyyftvnP3nB
         JQ0nOrOFs6zbcyh+JVUWx4ufZjFD64a7QLY6LFyNCAJzuYds/TZzxp0vlcU+jCSKl7K2
         MJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eplKEuyl2XwziYBtPQMXsLaADniHrRGbEFAJfGt2TV0=;
        b=qXOsuVb3jPO/2Cps9rBTZEAIXRUjnKODSNuaVVi2nZIYjDfq1x+FM3tBzgA6C5tm3w
         Z0O0c/KYkFYOWiIb0JuP7J0/G4SteP2XBWrmmJAlAS6nnGfAV6lX5Z6S86NaIA6rEav8
         uwlNr97oj3wtQJCx4IZJDD4Ps4KcQDfVNR2zUxd5to+UlSbf4cqoOla9qcpCPrBTevvT
         7PcVoUF1Vs6GKVwl3vvlCMediC3sdpjfm9cGCA/OCC1Ew0XtwbZY5rqXbvcoqiVvi6sY
         w9G6+TyZdzs5BzrMGnQg671FfhfQNMzo70QWJ2nGuNxo9h4HmMjhETNFP40IlZM2aB3+
         pn/w==
X-Gm-Message-State: AOAM530bb+EOf/o1up9GNZSyfRINxM/Af4iw/wNdjqWVZTGZMvn9jvJ+
        WXVnLvzuPAjcG2sclury7No=
X-Google-Smtp-Source: ABdhPJzpccqdShWpV9Qm6NVlOFfp+DhCSlLIg9+uAcWaJ5xMtmj2929Q2CySedRSR/+ftWrRa/eW/A==
X-Received: by 2002:a17:902:e74a:b0:15e:9811:11da with SMTP id p10-20020a170902e74a00b0015e981111damr26167816plf.130.1652290388493;
        Wed, 11 May 2022 10:33:08 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:6b86])
        by smtp.gmail.com with ESMTPSA id fv7-20020a17090b0e8700b001cd4989fecfsm202531pjb.27.2022.05.11.10.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 10:33:08 -0700 (PDT)
Date:   Wed, 11 May 2022 10:33:05 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] selftests/bpf: Add benchmark for local_storage
 get
Message-ID: <20220511173305.ftldpn23m4ski3d3@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220508215301.110736-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220508215301.110736-1-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 08, 2022 at 02:53:01PM -0700, Dave Marchevsky wrote:
> Add a benchmarks to demonstrate the performance cliff for local_storage
> get as the number of local_storage maps increases beyond current
> local_storage implementation's cache size.
> 
> "sequential get" and "interleaved get" benchmarks are added, both of
> which do many bpf_task_storage_get calls on a set of {10, 100, 1000}
> task local_storage maps, while considering a single specific map to be
> 'important' and counting task_storage_gets to the important map
> separately in addition to normal 'hits' count of all gets. Goal here is
> to mimic scenario where a particular program using one map - the
> important one - is running on a system where many other local_storage
> maps exist and are accessed often.
> 
> While "sequential get" benchmark does bpf_task_storage_get for map 0, 1,
> ..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
> bpf_task_storage_gets for the important map for every 10 map gets. This
> is meant to highlight performance differences when important map is
> accessed far more frequently than non-important maps.
> 
> Addition of this benchmark is inspired by conversation with Alexei in a
> previous patchset's thread [0], which highlighted the need for such a
> benchmark to motivate and validate improvements to local_storage
> implementation. My approach in that series focused on improving
> performance for explicitly-marked 'important' maps and was rejected
> with feedback to make more generally-applicable improvements while
> avoiding explicitly marking maps as important. Thus the benchmark
> reports both general and important-map-focused metrics, so effect of
> future work on both is clear.
> 
> Regarding the benchmark results. On a powerful system (Skylake, 20
> cores, 256gb ram):
> 
> Local Storage
> =============
>         num_maps: 10
> local_storage cache sequential  get:  hits throughput: 20.013 ± 0.818 M ops/s, hits latency: 49.967 ns/op, important_hits throughput: 2.001 ± 0.082 M ops/s
> local_storage cache interleaved get:  hits throughput: 23.149 ± 0.342 M ops/s, hits latency: 43.198 ns/op, important_hits throughput: 8.268 ± 0.122 M ops/s
> 
>         num_maps: 100
> local_storage cache sequential  get:  hits throughput: 6.149 ± 0.220 M ops/s, hits latency: 162.630 ns/op, important_hits throughput: 0.061 ± 0.002 M ops/s
> local_storage cache interleaved get:  hits throughput: 7.659 ± 0.177 M ops/s, hits latency: 130.565 ns/op, important_hits throughput: 2.243 ± 0.052 M ops/s
> 
>         num_maps: 1000
> local_storage cache sequential  get:  hits throughput: 0.917 ± 0.029 M ops/s, hits latency: 1090.711 ns/op, important_hits throughput: 0.002 ± 0.000 M ops/s
> local_storage cache interleaved get:  hits throughput: 1.121 ± 0.016 M ops/s, hits latency: 892.299 ns/op, important_hits throughput: 0.322 ± 0.005 M ops/s

Thanks for crafting a benchmark. It certainly helps to understand the cliff.
Is there a way to make it more configurable?
10,100,1000 are hard coded and not easy to change.
In particular I'm interested in the numbers:
1, 16, 17, 32, 100.
If my understanding of implementation is correct 1 and 16 should have
pretty much the same performance.
17 should see the cliff which should linearly increase in 32 and in 100.
Between just two points 100 and 1000 there is no easy way
to compute the linear degradation.
Also could you add a hash map with key=tid.
It would be interesting to compare local storage with hash map.
iirc when local storage was introduced it was 2.5 times faster than large hashmap.
Since then both have changed.
