Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC61F6C4B32
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 13:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCVM5b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 08:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjCVM50 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 08:57:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640F46230E
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 05:57:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eh3so72529991edb.11
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679489834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPyy6q5pueakkvOQE/kRXwscYnpalPkr/fQiX6qnVZc=;
        b=LaKy/2At3Ul0pXWrIEethjLR6La300vtBG7xPcizFjxsM/TxDbe6KjaQGJNB0XperY
         djn/x3ujCiO3dfhAhofSdi4gWevCidXo/jCAz37/3D6wshCLz348DKAjd/EuPqTRb0PX
         gsCeU2U4mdkMy5k0zsNpNfj6FCc01SqN2BaHXEgUxl62/w2xxFAjnlqRvcLl+pS/2FkH
         Bxti8eLzCFTjQOGcUXH5QlrWpPQ9B3bFZSmIkzNYI3urBnqFp0fSlIFkhOoqwUUOIUGp
         l9KZVZcDJM/xbIXto+NiR015jNpBZPQ8NriD2qCoGxfEaNKYQHSvGl0q1T6CSvkvFcld
         nTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPyy6q5pueakkvOQE/kRXwscYnpalPkr/fQiX6qnVZc=;
        b=zfWy/w0r4+cQMqyst9PpvoHI9Ma4Gkija8AVtt20MRmoEsM8d8xtj1yEzbtWMamWMW
         mbxfFK7n8E56xTXzB9I2i8xlG0028OA/p23menjOv/He7Y8JNywreMwhXzxlw8EXCG7O
         4a27sZJvr2fyRb50ItktsiIVnPQzLYrzWLb6vaycv/DuQ9UFyo9TCxOYO2s25m02Kb6Q
         zNyP4SfJ8bM68G6LP1RiSQtaBKPIWGrFLxJibaFdsRrwCxThWwAiNggBlLpLeIVUs7vi
         ay7ejMzzh9DRG0+fQgaDhVKyjRAXtdkm0tmM1wafsolk2tczp+kuGiOrJ3Jm4FtL7bWt
         RWeg==
X-Gm-Message-State: AO0yUKVz9Rp/eJgXayRorUzlxZydj1TXRUHeossWoplQmeFs75sme5j4
        BsyuFUIgxsp6Q0DDeEuh4Hs=
X-Google-Smtp-Source: AK7set+o+j3JyU4eoROOWbuCdRlF6KLx9TeID3POBGhK3UegTRlBlKNW3kADtxPt3ivRLMPw2ly0mA==
X-Received: by 2002:a05:6402:18:b0:502:2b1:c939 with SMTP id d24-20020a056402001800b0050202b1c939mr461952edu.26.1679489833840;
        Wed, 22 Mar 2023 05:57:13 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id v19-20020a1709067d9300b008cff300cf47sm7153528ejo.72.2023.03.22.05.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:57:13 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 22 Mar 2023 13:57:10 +0100
To:     Davide Miola <davide.miola99@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org
Subject: Re: bpf: missed fentry/fexit invocations due to implicit recursion
Message-ID: <ZBr7Jt9+yr0PHk6K@krava>
References: <CAMAi7A7+b6crWHyn9AQ+itsSh8vZ8D5=WEKatAaHj-V_4mjw-g@mail.gmail.com>
 <ZBo164Lc2eL3HUvN@krava>
 <CAMAi7A7Y=m=i-yEOuh-sO-5R5zEGQuo1VwOLKsgvFcv4RRhbhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMAi7A7Y=m=i-yEOuh-sO-5R5zEGQuo1VwOLKsgvFcv4RRhbhQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 22, 2023 at 08:33:18AM +0100, Davide Miola wrote:
> > seems correct to me, can you see see recursion_misses counter in
> > bpftool prog output for the entry tracing program?
> 
> Indeed I can. The problem here is that the recursion is not triggered
> by my programs; from my point of view any miss is basically a random
> event, and the fact that entry and exit progs can miss independently
> means that, at any point, I can count two exits for one entry or
> (worse) just one exit for two entries, making the whole mechanism
> wildly unreliable.
> 
> Would using kprobes/kretprobes instead of fentry/fexit here be my
> best compromise? It is my understanding (please correct me if I'm
> wrong) that kprobes' recursion prevention is per-cpu rather than
> per-program, so in this case there would be no imbalance in the
> number of misses between the entry and exit probes.

kprobes are guarded with perf-cpu bpf_prog_active variable, which will
block nested kprobe calls while kprobe program is running, so you will
get balanced counts but likely miss some executions

there was discussion about this some time ago:
  https://lore.kernel.org/bpf/CAEf4BzZ-xe-zSjbBpKLHfQKPnTRTBMA2Eg382+_4kQoTLnj4eQ@mail.gmail.com/

seems the 'active' problem andrii described fits to your case as well

also retsnoop is probably using some custom per-cpu logic in each program
to prevent this issue, you check it in here:
  git@github.com:anakryiko/retsnoop.git

jirka
