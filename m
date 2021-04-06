Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29D5355AF9
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 20:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbhDFSEr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 14:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237312AbhDFSEr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 14:04:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B435261154;
        Tue,  6 Apr 2021 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617732278;
        bh=Qw6oVGU/76mVgUbEjpilItCHs1Dj0PAxM5M9pZO1LvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E16Us8E3BJq/6kzWMts91Z14/+27kpa1aW6Da5OvxonQA0t6+DQzFHjoB6ZMGhkUZ
         Vh6vgtWDhmwlfAfJqWQ1IxpyYNhELZIm3Jrdg2f2oPJms2lo+s9P1I4Yp5w+XlM+gR
         apSxhBwZwioxKc/F/8E7OnuiIvs2Eh3+5qYoADfvLJrk5bxDtXeVFg/lVKCRJ74tIm
         9fWYPIVRMyTnCTb9wFE6+wjEuHBpmo35oifJYyrfQckM/+UP6Ty5APulBkLxZJJmR6
         1MZWHd5eNdfJrt7qRQKs4iXmxZIuOp29lN31OrjxvoagWpmCIQg15B06dsT/uAR6D8
         XUT2hqKTOgLgw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CE3A940647; Tue,  6 Apr 2021 15:04:35 -0300 (-03)
Date:   Tue, 6 Apr 2021 15:04:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Bill Wendling <morbo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
Message-ID: <YGyis5/OlebLxYQQ@kernel.org>
References: <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com>
 <CAGG=3QXkvwrm_tnsYtJ-gvHw8Emv5xFWeckoPoD4PhEud7v8EA@mail.gmail.com>
 <YGxgnQyBPf5fxQxM@kernel.org>
 <YGyO9KzDoxu5zk33@kernel.org>
 <YGySmmmn4J43I0EG@kernel.org>
 <YGyTco9NvT8Bin8i@kernel.org>
 <YGyUbX/HRBdGjH3i@kernel.org>
 <3a6aa243-add9-88a5-b405-85fd8bfbe21d@fb.com>
 <4eda63d8-f9df-71ab-d625-dcc4df429a89@fb.com>
 <YGyicDTUkPNhab4K@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGyicDTUkPNhab4K@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Apr 06, 2021 at 03:03:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> /me goes back to building clang/llvm HEAD, reducing the number of linker
> instances to 1 as I have just 32GB of ram in this Ryzen machine... ;-)

And guess what takes a long time?

[ 61%] Linking CXX executable ../../bin/llvm-lto

;-)

- Arnaldo
