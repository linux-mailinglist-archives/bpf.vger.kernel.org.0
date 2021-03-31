Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD353501BB
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 15:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhCaNy2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 09:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235777AbhCaNyV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 09:54:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68A8C606A5;
        Wed, 31 Mar 2021 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617198860;
        bh=mlpmYDu/MgPmlL9JJGa4xFueLTSyrRKM59SWYXdWgPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7m2dEc5+l1WmN9RPwRtdmJKTVrjyumk72TWimeufafY0BiPGhih6y1/xagJjhWN+
         hN5N6n9wayJz+j5mrxE9wMsCI7jF6jWv3u2muv+S4Uua38hKAw1AHuggsMBnV3Ke4M
         5GgaMxyegSEMxx6FtV8ocl7eyPVwqqD4XIundCSUa6X923cyUnglBHohheoJTxiBau
         0WjEzs9QNcru9gckaQg0cgJItbZ+QlwPXY9+fn5lfE7bAn4fQ8aFNZT1LAW+ZbB+ge
         9F/xE1BRD8Fkn9eU4b9xcaQCCecf0sO6HlLnnvwaBsSm2Ly1yXdILo6JaUZzPSKUmO
         5h7WpNrptDeIQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9D64440647; Wed, 31 Mar 2021 10:54:17 -0300 (-03)
Date:   Wed, 31 Mar 2021 10:54:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 0/3] permit merging all dwarf cu's for clang
 lto built binary
Message-ID: <YGR/Cc3/39V0kRuj@kernel.org>
References: <20210328201400.1426437-1-yhs@fb.com>
 <YGIQ9c3Qk+DMa+C7@kernel.org>
 <YGM/Uh61RVExWnTU@kernel.org>
 <YGNpBlf7sLalcFWB@kernel.org>
 <YGNs4QxfGvQozqGS@kernel.org>
 <503f852c-a7f4-efb2-5fd3-8431721dd67a@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <503f852c-a7f4-efb2-5fd3-8431721dd67a@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Mar 30, 2021 at 08:20:20PM -0700, Yonghong Song escreveu:
> On 3/30/21 11:24 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Mar 30, 2021 at 03:08:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > [acme@five pahole]$ fullcircle tcp_bbr.o
> > > [acme@five pahole]$

> > > This one is dealt with, doing some more tests and looking at that
> > > array[] versus array[0].

> > I've pushed what I have to the main repos at kernel.org and github,
> > please check, I'll continue from there.

> Looks good. Thanks!

> I will try to experiment with an alternative way ([1]) to check whether
> cross-cu reference happens or not. But at least checking flags
> approach can be adapted to gcc (if we want after comparing the alternative)
> since gcc always has flags in dwarf.
 
> [1] https://lore.kernel.org/bpf/d34a3d62-bae8-3a30-26b6-4e5e8efcd0af@fb.com/T/#m1b0b1206091c19a90b15d054aa26239101289f84

I thought about some other method, like adding a ELF note to vmlinux
stating that this was built with LTO, that would be the fastest way, I
think. If that note wasn't there, then we would fallback to looking at
inter CU references, that way we would have the best of both worlds and
wouldn't incur in per-CU DW_AT_producer overheads with the flags for
each object file.

- Arnaldo
