Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E92C62E021
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 16:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiKQPkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 10:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbiKQPkH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 10:40:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5062609;
        Thu, 17 Nov 2022 07:40:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E336F61F86;
        Thu, 17 Nov 2022 15:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C57C433C1;
        Thu, 17 Nov 2022 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668699605;
        bh=Mc4ySWjClUjGsVC0d00yorexigtt/BL4IyUH3iK7Dms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esYymimzQxLQyT1zPNhzzNLMA9P11nnWOpGfhtQLbqqh32cB/bCL8RMeYTXChwavj
         m6D777/MjK1+PH1gMGESslKB28HOG3RkUWpndfXnTwvKVwmorWa85rssjI4He7JrOX
         XC/T0uRDs7yoIYUuvo4QVJR9VRsfmpdAzECzg0pdqGF/bSm0R3/GpnEpeTfVPmmvtK
         lWi6jzj5dCx9iz4/Y1lBHmh1uZbOWC8EdPc3hjE6IvyKHZMZjg1vieesWw+8IrPkmz
         P1wzog4efm6zpl9UzRl4JqsPRZrm6zypANXpCmDa3H4VWWJmMcI6HLwaqmfeyCMWOb
         5LXb2WH+w7xnw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3AF294034E; Thu, 17 Nov 2022 12:40:00 -0300 (-03)
Date:   Thu, 17 Nov 2022 12:40:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/6] Build output clean up
Message-ID: <Y3ZV0FDW70ADoIYE@kernel.org>
References: <20221117004356.279422-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117004356.279422-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Nov 16, 2022 at 04:43:50PM -0800, Ian Rogers escreveu:
> Reduce build spam from commands not prefixed with @. Make
> install_headers targets distinguishable by adding in the library name
> so:
> INSTALL headers
> becomes:
> INSTALL libapi_headers
> 
> Ian Rogers (6):
>   tools lib api: clean up install_headers
>   tools lib bpf: Avoid install_headers make warning
>   tools lib symbol: clean up build output
>   tools lib perf: Make install_headers clearer
>   tools lib subcmd: Make install_headers clearer
>   tools lib traceevent: Make install_headers clearer

Andrii, are you ok with that? Can I carry this on my next (perf/core)
branch?

Testing it now.

- Arnaldo
 
>  tools/lib/api/Makefile        | 4 ++--
>  tools/lib/bpf/Makefile        | 1 +
>  tools/lib/perf/Makefile       | 2 +-
>  tools/lib/subcmd/Makefile     | 2 +-
>  tools/lib/symbol/Makefile     | 4 ++--
>  tools/lib/traceevent/Makefile | 4 ++--
>  6 files changed, 9 insertions(+), 8 deletions(-)
> 
> -- 
> 2.38.1.431.g37b22c650d-goog

-- 

- Arnaldo
