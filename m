Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6975605D8
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 18:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiF2QaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 12:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiF2QaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 12:30:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E3526133;
        Wed, 29 Jun 2022 09:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61357B8259F;
        Wed, 29 Jun 2022 16:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE542C34114;
        Wed, 29 Jun 2022 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656520213;
        bh=AXg0rQTH6cfiLfGA2s439ZXOD7bBos7PTUh5qH7Ael4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agt1AzqIAOQtC80ZRW1qdVfU7gc5aJJ7U5XbzjVT7T9MesuUr4Bz+bEN3brc8MxPR
         veaUzU7j2XJ/mYNrAgRrFeWy5PMrzXFHGYGFYW4qWpe3IK2/uWL0VT7Q3liKAh9u1D
         kzEVHkg9yt/yZRq0U9D0irXzi+/hI2sXNqTv9f5GHswoY31tOlGssMByWILBSL+pD/
         7CM3RQXFkgM0EG8CYOGkWIpRnPi5xjFvIEODESqUFLIjtXS0clnn5KyxxkhLDSnPLC
         wK3NVW8CRWoo1KxeaSmPeyYKDYl/TVyE8TcMVScSaILr+OMq6kTFKwywhBE3WQ2/NH
         tNu3vh1v4u6wg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 377904096F; Wed, 29 Jun 2022 13:30:10 -0300 (-03)
Date:   Wed, 29 Jun 2022 13:30:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH dwarves v2 0/2] btf: support BTF_KIND_ENUM64
Message-ID: <Yrx+Ehpc71/6WHVT@kernel.org>
References: <20220615230306.851750-1-yhs@fb.com>
 <YrrPOFzYAGHm0oht@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrrPOFzYAGHm0oht@krava>
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

Em Tue, Jun 28, 2022 at 11:51:52AM +0200, Jiri Olsa escreveu:
> On Wed, Jun 15, 2022 at 04:03:06PM -0700, Yonghong Song wrote:
> > Add support for enum64. For 64-bit enumerator value,
> > previously, the value is truncated into 32bit, e.g.,
> > for the following enum in linux uapi bpf.h,
> >   enum {
> >         BPF_F_INDEX_MASK                = 0xffffffffULL,
> >         BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
> >   /* BPF_FUNC_perf_event_output for sk_buff input context. */
> >         BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
> >   };
> > 
> > BPF_F_CTXLEN_MASK will be encoded with 0 with BTF_KIND_ENUM
> > after pahole dwarf-to-btf conversion.
> > With this patch, the BPF_F_CTXLEN_MASK will be encoded properly
> > with BTF_KIND_ENUM64.
> 
> yep, tried this on latest vmlinux and got:
> 
> [705813] ENUM64 (anon) size=8
>         BPF_F_INDEX_MASK val=4294967295
>         BPF_F_CURRENT_CPU val=4294967295
>         BPF_F_CTXLEN_MASK val=4503595332403200
> 
> which is correct
> 
> Tested-by: Jiri Olsa <jolsa@kernel.org>

I'm testing with v3:

⬢[acme@toolbox pahole]$ pahole -JV vmlinux-v5.18-rc7+ | grep -B10 -A5 BPF_F_CTXLEN_MASK
	BPF_FUNC_xdp_get_buff_len val=188
	BPF_FUNC_xdp_load_bytes val=189
	BPF_FUNC_xdp_store_bytes val=190
	BPF_FUNC_copy_from_user_task val=191
	BPF_FUNC_skb_set_tstamp val=192
	BPF_FUNC_ima_file_hash val=193
	__BPF_FUNC_MAX_ID val=194
[672880] ENUM64 (anon) size=8
	BPF_F_INDEX_MASK val=4294967295
	BPF_F_CURRENT_CPU val=4294967295
	BPF_F_CTXLEN_MASK val=4503595332403200
[672881] ENUM (anon) size=4
	BPF_F_GET_BRANCH_RECORDS_SIZE val=1
[672882] ARRAY (anon) type_id=672304 index_type_id=18 nr_elems=4
[672883] STRUCT (anon) size=16
	tp_name type_id=672266 bits_offset=0

But:

⬢[acme@toolbox pahole]$ pdwtags -F btf vmlinux-v5.18-rc7+ | grep -B10 -A5 BPF_F_CTXLEN_MASK
BTF: idx: 4173, Unknown kind 19
BTF: idx: 4975, Unknown kind 19
BTF: idx: 6673, Unknown kind 19
BTF: idx: 27413, Unknown kind 19
BTF: idx: 30626, Unknown kind 19
BTF: idx: 30829, Unknown kind 19
BTF: idx: 38040, Unknown kind 19
BTF: idx: 56969, Unknown kind 19
BTF: idx: 83004, Unknown kind 19
⬢[acme@toolbox pahole]$

Ok, I need to update pahole's BTF loader to support:

lib/bpf/src/btf.h:#define BTF_KIND_ENUM64		19	/* Enum for up-to 64bit values */


Working on it now.

Jiri, can I keep your Tested-by for v3?

- Arnaldo

> jirka
> 
> > 
> > This patch is on top of tmp.master since tmp.master has not
> > been sync'ed with master branch yet.
> > 
> > Changelogs:
> >   v1 -> v2:
> >     - Add flag --skip_encoding_btf_enum64 to disable newly-added functionality.
> > 
> > Yonghong Song (2):
> >   libbpf: Sync with latest libbpf repo
> >   btf: Support BTF_KIND_ENUM64
> > 
> >  btf_encoder.c     | 65 +++++++++++++++++++++++++++++++++++------------
> >  btf_encoder.h     |  2 +-
> >  dwarf_loader.c    | 12 +++++++++
> >  dwarves.h         |  4 ++-
> >  dwarves_fprintf.c |  6 ++++-
> >  lib/bpf           |  2 +-
> >  pahole.c          | 10 +++++++-
> >  7 files changed, 80 insertions(+), 21 deletions(-)
> > 
> > -- 
> > 2.30.2
> > 

-- 

- Arnaldo
