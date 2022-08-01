Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E62558703A
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 20:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiHASKz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 14:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiHASKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 14:10:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC315A2B;
        Mon,  1 Aug 2022 11:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB72861168;
        Mon,  1 Aug 2022 18:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3087EC433C1;
        Mon,  1 Aug 2022 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659377446;
        bh=eogaxGAwAkmy4/fpjaPZI6kZCAoWTosZA8Bc+IIaeWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+18rjM7/vpJ901Bmues0JbNcQdsuXedRxVxbTe5Ll3OMbPzPHxprXOpN3Mfg9EU4
         omggqsyKb1H8tsI7DmrFOtDhUQkeToEDB7OI5uOIw/ttj4BVs9biq0asaReiJ5PuOx
         6XhACgirN8hauoIEVSNFq876BiEHIHFUjyVoFqPmx7wg7Qx0iHtIL/siQ+2eLmJKbI
         ZM83W3dkWRzpTq2ezvNNu/ZVjXI3aPuSKOPm++L1kJsW8UnRaKUbwP2/3LTa9/I7Dr
         SJqNJJMSgnZkXEyaNWVBJWS04OH7jj6kABywm7XZ9TIQAZH8ivFn4NPaLZZYfqW/eo
         Y8TwzolmDhN/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A6F9940736; Mon,  1 Aug 2022 15:10:43 -0300 (-03)
Date:   Mon, 1 Aug 2022 15:10:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andres Freund <andres@anarazel.de>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH v3 2/8] tools build: Don't display disassembler-four-args
 feature test
Message-ID: <YugXI9zVJQi6Nxah@kernel.org>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de>
 <20220801013834.156015-3-andres@anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801013834.156015-3-andres@anarazel.de>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Jul 31, 2022 at 06:38:28PM -0700, Andres Freund escreveu:
> The feature check does not seem important enough to display. Suggested by
> Jiri Olsa.

I turned the last paragraph into a:

Suggested-by: Jiri Olsa <jolsa@kernel.org>
 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> Signed-off-by: Andres Freund <andres@anarazel.de>
> ---
>  tools/build/Makefile.feature | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 8f6578e4d324..fc6ce0b2535a 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -135,8 +135,7 @@ FEATURE_DISPLAY ?=              \
>           get_cpuid              \
>           bpf			\
>           libaio			\
> -         libzstd		\
> -         disassembler-four-args
> +         libzstd
>  
>  # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
>  # If in the future we need per-feature checks/flags for features not
> -- 
> 2.37.0.3.g30cc8d0f14

-- 

- Arnaldo
