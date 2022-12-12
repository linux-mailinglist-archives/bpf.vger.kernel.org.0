Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19DA64A8BD
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 21:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiLLUct (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 15:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiLLUcr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 15:32:47 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB8730A;
        Mon, 12 Dec 2022 12:32:38 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.187]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5G1V-1oucA71QdJ-01171N; Mon, 12 Dec 2022 21:31:42 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id F41C03C1BA; Mon, 12 Dec 2022 21:31:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1670877095; bh=nxwnxqjAjgVwT5akycdILq2xF3x3T7jbclBRpYvebKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BHwwSClVQEiCMkeGU0a2VtIArgQ0VdHgcme8hBeaPzIH0A38SOUYE4QFSfQlvSu3r
         cH/Qjk5/WDBnq/unjNIzEMLNnJA1szFxe0q+AZe3xUwn2dHwRRq5aieSjfUxin3BA2
         0edYlpDVltvU7VJ43z+1gUDLW3BuHm87PXERBT3Y=
Date:   Mon, 12 Dec 2022 21:31:34 +0100
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
Subject: Re: [PATCH 0/5] Improvements to incremental builds
Message-ID: <Y5ePpm3HKts3b+gJ@fjasle.eu>
References: <20221202045743.2639466-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221202045743.2639466-1-irogers@google.com>
X-Provags-ID: V03:K1:Q5tTJtvP+OI+UVlSCti/RJFZLupxY/4hPPzq2moZ9pa7JrEvtwM
 ft2PS2S2w3HPVHOCQ+BzHC0MOmMI5c8JE7cGMFkb9tBSUCz41D7lKie3SvGmEDlb9G1liv5
 CysdTktoc6kxQSDGJBNQwvp6IpXEy35zKHix5qSDNOa/HGoiQJb6v/8hAVk6uld5Rar8rP/
 EX8yQg6Cxwaq5KGiGWc6A==
UI-OutboundReport: notjunk:1;M01:P0:srtxlQSFqI8=;EFiRNw0p2P7eEd1nkNBqWsU7Hf5
 bQVMEHU3DRCp67FcD3GjOFeLGwaq2hrPNQVFomHSp2/uyqB21NMypyDXUabhQcbmsSKLheAM9
 JfSO7Tw7dSTqL9F8XuE+XT8IdNZJTJcpUsfcqNm6i9MT6iZIIP3N6mow0KYShu81tf/EkK8WY
 ydgsNLijrvE6AcNwbiLrac5HCsl4FeOCNSjRJOlc3HSSC4FgvAQ7Z93QLFMKXzwJwXgRbzzjc
 8KJxBgtbK2zr38QZSQTN4NfM2uBtikl+Un/WmDQYWkXorPjSi7olRZXRCfCVduHg6WPQtwY81
 VkWIAn/h5tAW2K9CW+9IsiG4h35uLxpTG5R0LX+xht32j6+Ym3HO0zI5qGd8gfkpx3WmNaTSR
 X6NWCw0kKovUVmlwrA9uXOqK+pNBjR7GLe9sc7n+gA96cdV9U5S2okmRCYg9Qcoum+kmJcKnm
 m6c5bUcoyDesN2Q0Rjm7elC2tIheSRhObPW3Uy8maZey3a1foxy8t6U7ghwA7BGOaEVv+74F2
 C29GIZjvlHg3P3M1vhxkJzNY6T+HBH25DVkWQGpLqaw4VEetuoSVOQMD/aunBOq2LaDo2JYAA
 2BNkRiK2p8KOVDsgXAA95udGQeoxeE+XIFAEJgaWu6dx7V3tE7NE16eiGDA516c4GXBGk2hDh
 X5Q11ivXw6OXDKAFp1Bhmg4gZhssQXX9ypGVzAKwsw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 01, 2022 at 08:57:38PM -0800 Ian Rogers wrote:
> Switching to using install_headers caused incremental builds to always
> rebuild most targets. This was caused by the headers always being
> reinstalled and then getting new timestamps causing dependencies to be
> rebuilt. Follow the convention in libbpf where the install targets are
> separated and trigger when the target isn't present or is out-of-date.
> 
> Further, fix an issue in the perf build with libpython where
> python/perf.so was also regenerated as the target name was incorrect.
> 
> Ian Rogers (5):
>   tools lib api: Add dependency test to install_headers
>   tools lib perf: Add dependency test to install_headers
>   tools lib subcmd: Add dependency test to install_headers
>   tools lib symbol: Add dependency test to install_headers
>   perf build: Fix python/perf.so library's name
> 
>  tools/lib/api/Makefile     | 38 ++++++++++++++++++++++-----------
>  tools/lib/perf/Makefile    | 43 +++++++++++++++++++-------------------
>  tools/lib/subcmd/Makefile  | 23 +++++++++++---------
>  tools/lib/symbol/Makefile  | 21 ++++++++++++-------
>  tools/perf/Makefile.config |  4 +++-
>  tools/perf/Makefile.perf   |  2 +-
>  6 files changed, 79 insertions(+), 52 deletions(-)
> 
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog

Hi Ian,

which tree is your patch set based on?  At least it doesn't apply on the
current kbuild trees.

Kind regards,
Nicolas

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
