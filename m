Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0C9663F0F
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 12:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbjAJLMI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 06:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbjAJLLl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 06:11:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFA4260E;
        Tue, 10 Jan 2023 03:10:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so6710995wma.1;
        Tue, 10 Jan 2023 03:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwG3x8Jb1ESlAmiC0amTV8bv6zPRzHOfSpbTvokPrgw=;
        b=PuQiiCp+VCjX55Ew0DP8agKIfZsn136JYzQFJsBKyDlMBynv0HYmVp/lJljXRi+F5f
         wddtAWBoSoA+rUhBjrPbmHvmLkXkZ4gdc7Wbw4+sEuXjV4i+Hhf5KBsFGq0e+SBupjdU
         w3kO6+UdXP7sjXHfuIPQEZp0SDvtFL6NAZ2TPAHmrE1rNV4nVzVfVic8a3ux5zti03Ai
         WoN/bm3GsH+oWIcS+I9tdgjW5OudiIHPkywpJyUI0o+88l6nA0k4w+lpKwzEc7HCH4y4
         dOJ33dauVBt2gSRiLC7Y4stizeQ5MMTTSUGeNqmHQPLlB1uqG9Ajm1R5yGOcyd1j5ko9
         N61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwG3x8Jb1ESlAmiC0amTV8bv6zPRzHOfSpbTvokPrgw=;
        b=W+OmgrmBSkSd8H7EF4NJ+ImVWZ8BpqkUIQZxBrnfNvKkhDogOLwhuN1PAgDwlIvCM/
         8df+bNuQwZE9gyC/6FB/n7JelKueYibQWDPtNf3nzFB8AEtGixG4Jn+4u0ln5QbUgnsp
         2nurceHkHLndsnVWbrkaTaNXQTppiI2VfE+VHiCSRnGAZZ/2eBOWbsPk1g/xHXlprbjS
         Nv0CbCjzyom45AjIsrfE+fG3vy6U27KLekvwNF0E28FM6txql9nlDsSQHGG6WRbPwPMg
         EKEXZ45KxLHp+D2R43EVknZBU5629opxxlHONw+f2LxOn/0WghY6FRwvzWfHgOUxL+fg
         6bQQ==
X-Gm-Message-State: AFqh2krI4Wf4OfsQ3h359vaHU5orTNtyUCpDkXmU20fTxZnOu8qIB8tm
        MDAl6F/Nl36iwhS/iwjjjx0=
X-Google-Smtp-Source: AMrXdXvNGL7wXRjBiHe8SoL9AyEnExLLxDgJCHMjbnr4E3W0RuapsYh4AdGONLb6oOaiztnlEDzGsg==
X-Received: by 2002:a05:600c:1c81:b0:3d1:e907:17cb with SMTP id k1-20020a05600c1c8100b003d1e90717cbmr49317896wms.1.1673349054884;
        Tue, 10 Jan 2023 03:10:54 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b003d9b87296a9sm20916439wmo.25.2023.01.10.03.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 03:10:54 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 10 Jan 2023 12:10:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 2/3] perf/core: Set data->sample_flags in
 perf_prepare_sample()
Message-ID: <Y71HvO5NV0OP6YYq@gmail.com>
References: <20221229204101.1099430-1-namhyung@kernel.org>
 <20221229204101.1099430-2-namhyung@kernel.org>
 <Y7wFJ+NF0NwnmzLa@hirez.programming.kicks-ass.net>
 <Y7x3RUd67smv3EFQ@google.com>
 <Y71D1FCzoGihMUv+@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y71D1FCzoGihMUv+@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jan 09, 2023 at 12:21:25PM -0800, Namhyung Kim wrote:
> 
> > Looks good.  But I'm confused by the tip-bot2 messages saying it's
> > merged.  Do you want me to work on it as a follow up?
> 
> Ingo and me talked past one another, I agreed with 1/3 and he applied
> the whole series. Just talked to him again and he's just zapped these
> last two patches.

Yeah - perf/core is now:

   7bdb1767bf01 ("perf/core: Change the layout of perf_sample_data")

which can be used for further work. Sorry about the confusion ...

Thanks,

	Ingo
