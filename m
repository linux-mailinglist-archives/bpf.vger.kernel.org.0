Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B152560BEC
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiF2Vo4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 17:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiF2Vo4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 17:44:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD073818E;
        Wed, 29 Jun 2022 14:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60987617A3;
        Wed, 29 Jun 2022 21:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADB3C34114;
        Wed, 29 Jun 2022 21:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656539094;
        bh=X7x/N79wD1zUoaZQkdzD8DGsjyqC+AIFRBPcxQZXsRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sN59foP31R2pQrlR1fszVlsARfxfR15zI1g9R0loua+nKESZcJz/9OgPD51B+QecX
         uerZC8KiWw5g9b1rTBFzQlGJJoeTOfybxnrzJbyqp6MN8WQALorUM+O1Z28g5SLPGQ
         QR2mxLCm6JgwH8zqTWNjfymkzAbtAWKHj8tSN0NoubW3C4SZVUr3/osMDVHoNdvfys
         RhN4axzezFfwV5Wkyr6A8t1EGj4SADnligIsjwKnFW8K+sx6t/zNwwJDRlObOBfkDT
         Q5ASjEfKNTU2uP6IxMH/9HugJa8H6YQKNhtZKzB+KEUbObNSr5U/OY0/CYvfwomcqA
         ww/DTwvRLGa6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4EC8E4096F; Wed, 29 Jun 2022 18:44:52 -0300 (-03)
Date:   Wed, 29 Jun 2022 18:44:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 0/2] btf: support BTF_KIND_ENUM64
Message-ID: <YrzH1ABPYmKSEogS@kernel.org>
References: <20220629071213.3178592-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629071213.3178592-1-yhs@fb.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jun 29, 2022 at 12:12:13AM -0700, Yonghong Song escreveu:
> Add support for enum64. For 64-bit enumerator value,
> previously, the value is truncated into 32bit, e.g.,
> for the following enum in linux uapi bpf.h,
>   enum {
>         BPF_F_INDEX_MASK                = 0xffffffffULL,
>         BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
>   /* BPF_FUNC_perf_event_output for sk_buff input context. */
>         BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
>   };    

Applied, added the entry for skip generating enums to the man page,
added support to the pahole BTF loader, used the new pahole to build
bpf-next/master, all seems ok, pushing to next on git.kernel.org so that
the libbpf github CI can give it a go.

To build with torvalds/master one has to add --skip_encoding_btf_enum64,
I think, haven't tested with it, without it isn't working, libbpf
complains at that btfids tool.

Please check/test what is in there now:

  git://git.kernel.org/pub/scm/devel/pahole/pahole.git next
  https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next

Unless someone screams I plan pushing out a new release, update fedora
packages, etc early next week its overdue by now.

- Arnaldo
 
> BPF_F_CTXLEN_MASK will be encoded with 0 with BTF_KIND_ENUM
> after pahole dwarf-to-btf conversion.
> With this patch, the BPF_F_CTXLEN_MASK will be encoded properly
> with BTF_KIND_ENUM64.
> 
> This patch is on top of tmp.master since tmp.master has not
> been sync'ed with master branch yet.
> 
> Changelogs:
>   v2 -> v3:
>     - pass struct type/conf_load pointers to btf_encoder__add_enum[_value]
>       to make code easier to understand.
>   v1 -> v2:
>     - Add flag --skip_encoding_btf_enum64 to disable newly-added functionality.
> 
> Yonghong Song (2):
>   libbpf: Sync with latest libbpf repo
>   btf: Support BTF_KIND_ENUM64
> 
>  btf_encoder.c     | 67 +++++++++++++++++++++++++++++++++++------------
>  btf_encoder.h     |  2 +-
>  dwarf_loader.c    | 12 +++++++++
>  dwarves.h         |  4 ++-
>  dwarves_fprintf.c |  6 ++++-
>  lib/bpf           |  2 +-
>  pahole.c          | 10 ++++++-
>  7 files changed, 81 insertions(+), 22 deletions(-)
> 
> -- 
> 2.30.2

-- 

- Arnaldo
