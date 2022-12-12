Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3364A90C
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 21:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiLLU7c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 15:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLLU7O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 15:59:14 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF8A183B6;
        Mon, 12 Dec 2022 12:59:07 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.187]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mleo0-1odmn242ug-00imxM; Mon, 12 Dec 2022 21:57:47 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 770693C1BA; Mon, 12 Dec 2022 21:57:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1670878658; bh=qnQ4b4OQQYBi41zkGd5uOCUPLtZ3tfRTJtk/z24yVwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=4x5ahCDLnX1Nwswko43mNTdERhxKyMuflqrcHjLjKRvKaeLkFF/p80sxO1Leyq3vE
         SgfxTSm+ivpt3Ilu3P5k+ScZ9gLFNObyr7D/iamJou6F57djITqC4AiietPvAb4Np3
         tSvtnIjNRvuVhDLdwGqgJM1IZrqJwzl6wBgsXZHs=
Date:   Mon, 12 Dec 2022 21:57:38 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/5] tools lib subcmd: Add dependency test to
 install_headers
Message-ID: <Y5eVwlId2A2/pN40@fjasle.eu>
References: <20221202045743.2639466-1-irogers@google.com>
 <20221202045743.2639466-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221202045743.2639466-4-irogers@google.com>
X-Provags-ID: V03:K1:3GmCeNNSVVdhmJX5HMTzbhSdxI6R4yUF6tJQCtwPq/TnqvO5APk
 /+xEZtzMC83be00kVnu0kgC6dao9my0lKfrnr1YkOYOcQvaLg8Xb4nj0q1VtsXhowaQ/C3M
 Lp+WOdtyKO9zX/bGvpytzbjN50dCkbTyUfajmSLE/HnaMQ+J62EhxWaNErXiXf4p0QSZUJd
 LZC/vbAoFLWwVn81ixpTA==
UI-OutboundReport: notjunk:1;M01:P0:n+AMtI/h5nQ=;uzd76xvlXBHZvc/0DeTuUmklTpb
 8FO3mEpw3fol4NJq85+yLNJrcHHP1fKpUs1QXjlcBU6IKe/E12GRsJ5d+HiHz4pjkQbVszauo
 AJji12/4UPffp8K42/ei4zyYLFdHZ7kHOXGLri9P7NsnAu+SkSqvXkDX5c0zMx8hd26vk3UZQ
 yPSLWSyd2GqEVSXagA9LdzMIjUFRmMdvQd5KN+ZvCItUd5B1FDQgT1ZnXUMoJO+yldMJORKxl
 6+LznW8Ix/4zQpxm99RZ2l/+D+DyWDTK2TXUtrheXC5aKMC83h/jzFUiuj67/sWXKiOMa6ih9
 TA5nuTZjGq/J2YH/ztOBhk9XwW0YayQ3INKYlMD67JlY6MYYkym42b9AFUrA2qikNRhdLxGZI
 8G5Wy2yR+OLGhxJzdYwID48Hm1iPWCvAz24qtfrlBIIQRtANxOb5qAbWS/lYk6VeSEamOd4y9
 ImkhLJ75hMsePDFLKx+pCmz1A9Qv5sL/NHtQkfDOqmoubAoLRXD2vlg5vbOARHg5gRzGIFbaQ
 YItcecrqtpPFk0Yuz8wxVV5/VIec8ypTY0tWruX5nsSUKWUZ+V/nLdieu++oT3BShJ05Dr6eY
 ozO0UGFk5161umJ0GpuSidNQ9PlVS8meDmaAUA+gsMT6q9dQu4up3ivjFUicK4D8/7lpZCc7J
 PK0/aRD3OF5Qr6zMczu8CicEUcxrLXexa55HsKAmCw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 01, 2022 at 08:57:41PM -0800 Ian Rogers wrote:
> Compute the headers to be installed from their source headers and make
> each have its own build target to install it. Using dependencies
> avoids headers being reinstalled and getting a new timestamp which
> then causes files that depend on the header to be rebuilt.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/subcmd/Makefile | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> index 9a316d8b89df..b87213263a5e 100644
> --- a/tools/lib/subcmd/Makefile
> +++ b/tools/lib/subcmd/Makefile
> @@ -89,10 +89,10 @@ define do_install_mkdir
>  endef
>  
>  define do_install
> -	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
> -		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
> +	if [ ! -d '$2' ]; then             \
> +		$(INSTALL) -d -m 755 '$2'; \
>  	fi;                                             \
> -	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
> +	$(INSTALL) $1 $(if $3,-m $3,) '$2'

What about using '$(INSTALL) -D ...' instead of the if-mkdir-block above?
(E.g. as in tools/debugging/Makefile.)

Kind regards,
Nicolas

>  endef
>  
>  install_lib: $(LIBFILE)
> @@ -100,13 +100,16 @@ install_lib: $(LIBFILE)
>  		$(call do_install_mkdir,$(libdir_SQ)); \
>  		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
>  
> -install_headers:
> -	$(call QUIET_INSTALL, libsubcmd_headers) \
> -		$(call do_install,exec-cmd.h,$(prefix)/include/subcmd,644); \
> -		$(call do_install,help.h,$(prefix)/include/subcmd,644); \
> -		$(call do_install,pager.h,$(prefix)/include/subcmd,644); \
> -		$(call do_install,parse-options.h,$(prefix)/include/subcmd,644); \
> -		$(call do_install,run-command.h,$(prefix)/include/subcmd,644);
> +HDRS := exec-cmd.h help.h pager.h parse-options.h run-command.h
> +INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/subcmd
> +INSTALL_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
> +
> +$(INSTALL_HDRS): $(INSTALL_HDRS_PFX)/%.h: %.h
> +	$(call QUIET_INSTALL, $@) \
> +		$(call do_install,$<,$(INSTALL_HDRS_PFX)/,644)
> +
> +install_headers: $(INSTALL_HDRS)
> +	$(call QUIET_INSTALL, libsubcmd_headers)
>  
>  install: install_lib install_headers
>  
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
