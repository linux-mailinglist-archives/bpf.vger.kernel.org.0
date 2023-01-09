Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F45662990
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 16:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbjAIPOG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 10:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbjAIPNI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 10:13:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889E114024;
        Mon,  9 Jan 2023 07:12:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 252366117E;
        Mon,  9 Jan 2023 15:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B76C4339E;
        Mon,  9 Jan 2023 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673277138;
        bh=daZxDGs86Bk5MzJICViW/vk55hlhK8dtOjzS01jPUdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeciNFTE67BGP9fkkAqtyDeygJS/MFRECSzsSBN2B93Jv4QgR2sVekPUYyjp6/6ty
         Y32B5J+XlZb1gH7tErm7KYMrq5jZbXodSvGNrN9wGfRMOUKBRQwRbUTKF6kLORTpRR
         Lbse5yYItfyjcYh/kvP4BwzNd+SesrxNdGfnGDTOKm2HFOeLJYhXAX2uY9nc/vQum6
         kwrRJkxY9YfahipQzRaPqCaSoarFt30Q5nQIPwLQexSo5egaMP91iDSs6ZnR6FG1KH
         JBjUeGCrRO2303DBWwJN+1Jj4Xy7hrFDbf5xFqA4EsXpIt1K5goZ3wsgC9bEhzcHeJ
         FW/BPCXK5iKCQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C726C40468; Mon,  9 Jan 2023 12:12:15 -0300 (-03)
Date:   Mon, 9 Jan 2023 12:12:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
Message-ID: <Y7wuz6EOggZ8Wysb@kernel.org>
References: <20230106151320.619514-1-irogers@google.com>
 <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
 <Y7hZccgOiueB31a+@kernel.org>
 <Y7hgKMDGzQlankL1@kernel.org>
 <Y7hgoVKBoulCbA4l@kernel.org>
 <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jan 06, 2023 at 11:06:46AM -0800, Ian Rogers escreveu:
> So trying to get build-test working on my Debian derived distro is a
> PITA with broken feature detection for options I don't normally use.

Its really difficult to have perf building with so many dependent
libraries, mowing out some should be in order.

> I'll try to fix this.

Thanks.
 
> In any case I think I've spotted what is really happening here and it
> isn't a failure but a feature :-D The build is specifying

I get it.

> LIBBPF_DYNAMIC=1 which means you get the libbpf headers from
> /usr/include. I think the build is trying to do this on a system with
> an old libbpf and hence getting the failures above. Previously, even
> though we wanted the dynamic headers we still had a -I, this time for
> the install_headers version. Now you really are using the system
> version and it is broken. This means a few things:
> - the libbpf feature test should fail if code like above is going to fail,

Agreed.

> - we may want to contemplate supporting older libbpfs (I'd rather not),

I'd rather require everybody to be up to the latest trends, but I really
don't think that is a reasonable expectation.

> - does build-test have a way to skip known issues like this?

Unsure, Jiri?

But yeah, previous experiences with Andrii were that we can do not too
costly feature checks, not using .c programs that would fail if some
required feature wasn't present but instead would just do some grep on a
header and if some "smell" wasn't scent, just fail the cap query.

- Arnaldo
