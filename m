Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230B234D215
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 16:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhC2OEq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 10:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhC2OEd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 10:04:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2C766192F;
        Mon, 29 Mar 2021 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617026673;
        bh=eanCySLvVSOTi/DZKGyfv3h7bKEnmVC891tRVgA+bvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EcUurjivwhPbczQ5dVYSeDPrIh6/QqzF7AvsBzVvVO1CbnFcHH4aVh1JmZ0fIaltd
         ZclSZ7jq6dG/DXmUjqlhMX5guWKEA0Tzw5VydPEAqTRFU7mp6Dg0qWj6h9SP5iFAY1
         lOWxN1WDaIKvDKoQV/hjjEZTGvXlqvEOGci64uBOrNpqHQ+bVzYKXX4ByBBL3KflN4
         KI9WmNjDc5gNKv6UHk/bLpbE4dRQt2VHW0atAN9wCZKff7LqyIcop1EWQTsCad95sB
         pGw25nbXBq/MliaxuP9dai8CuQKdopgXIxAucrqFzcEWKMoRlx/AVv8C/Efk3fcUkU
         Kr/0M4YT+zLCA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E14A240647; Mon, 29 Mar 2021 11:04:30 -0300 (-03)
Date:   Mon, 29 Mar 2021 11:04:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: add option to merge more dwarf
 cu's into one pahole cu
Message-ID: <YGHebuveQ1SJ9BHN@kernel.org>
References: <20210325065316.3121287-1-yhs@fb.com>
 <20210325065332.3122473-1-yhs@fb.com>
 <YF3ynAKXDCE0kDpp@kernel.org>
 <d618edb6-e4c0-a260-905f-e07720746594@fb.com>
 <YF4ltLywXsM3YkSs@kernel.org>
 <74e25d53-1e36-03a0-2de5-bd2d349a4a7f@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74e25d53-1e36-03a0-2de5-bd2d349a4a7f@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 26, 2021 at 04:05:45PM -0700, Yonghong Song escreveu:
> On 3/26/21 11:19 AM, Arnaldo Carvalho de Melo wrote:
> > [acme@five pahole]$ fullcircle ./tcp_ipv4.o
> > /home/acme/bin/fullcircle: line 40: 984531 Segmentation fault      (core dumped) ${codiff_bin} -q -s $file $o_output
> 
> The .o file in lto build is not really an elf .o, it is llvm internal
> ir bitcode.

This one wasn't from a LTO build, I'll revisit this soon. Testing v3
now.

- Arnaldo
 
> > [acme@five pahole]$ pahole --help | grep merge
> >        --merge_cus            Merge all cus (except possible types_cu)
> > [acme@five pahole]$
> > 
> > 
> > - Arnaldo
> > 

-- 

- Arnaldo
