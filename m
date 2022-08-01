Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE20587069
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiHAS25 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 14:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiHAS24 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 14:28:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A8EE0CC;
        Mon,  1 Aug 2022 11:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C254FB81629;
        Mon,  1 Aug 2022 18:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4BDC433C1;
        Mon,  1 Aug 2022 18:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659378533;
        bh=eR4O0ECQ4k++WJdThxBZKnP9tRrO4qiEt92KsE4iz0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmiwxqnjU4eAzWua7DHQr3LUgRJHI64h7Ob4mYYI0lyYDfq99xS1oo62Vsqp9K/Gj
         b4soRF7kEGtPp0Ub6yY154MxRF5YLb9kXhDRfmI1Jr9ia2ys21iCLqw6O23+kNAOtc
         14Jlxy44hMQaE0ARbLaBDmP/DJ8P6DJJKeErUxf2t66aaykcGeNn9SXRq/CW3WS5tp
         59mU2WEePl+yO0IgSRRewdWxnYB8p0KQ1qJw6pGJ2ND0h0nHm3JUMj7XSZWthnKkvM
         4p42E3xHBkKYT4skiz75n0kxkGknVw2CigL/OSs1gL4bR4aQfzEKwTkMXKNYfbf6An
         ugSdAVulHyzoA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E507540736; Mon,  1 Aug 2022 15:28:50 -0300 (-03)
Date:   Mon, 1 Aug 2022 15:28:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andres Freund <andres@anarazel.de>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH v3 8/8] tools bpftool: Don't display
 disassembler-four-args feature test
Message-ID: <YugbYqyeLePDiELm@kernel.org>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de>
 <20220801013834.156015-9-andres@anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801013834.156015-9-andres@anarazel.de>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Jul 31, 2022 at 06:38:34PM -0700, Andres Freund escreveu:
> The feature check does not seem important enough to display. Requested by
> Jiri Olsa.

Sorry, I hadn't seen this one, removing my change.

- Arnaldo
 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> Signed-off-by: Andres Freund <andres@anarazel.de>
> ---
>  tools/bpf/bpftool/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 436e671b2657..517df016d54a 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -95,8 +95,7 @@ RM ?= rm -f
>  FEATURE_USER = .bpftool
>  FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled zlib libcap \
>  	clang-bpf-co-re
> -FEATURE_DISPLAY = libbfd disassembler-four-args zlib libcap \
> -	clang-bpf-co-re
> +FEATURE_DISPLAY = libbfd zlib libcap clang-bpf-co-re
>  
>  check_feat := 1
>  NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
> -- 
> 2.37.0.3.g30cc8d0f14

-- 

- Arnaldo
