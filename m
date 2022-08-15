Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA816592CAD
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 12:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242222AbiHOJ56 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 05:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242249AbiHOJ55 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 05:57:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C05D1F637
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 02:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qN7o9Rb8ger9FnVGpNBW9diT3MJc0AyP50U/TpxknqU=; b=SUbiORHjmGtS+h1MISgh9MwgLM
        fTD0wSdu6jZzEWJD1/x6CeBczv1wuD8wlsu2IW5K+mOkiDv0mzQYCKYjKAeHzA+1blNOyT/jgGAcP
        RVX9QTKXS0HI6c8D+BTM78/eKqPHPZ9XZ08SXR+5/rLjMNUljDLeQ2HASr4Cqm72feLiIEnVi9x5q
        eCTVNqZitVQ41cv58SZHm1bCCEfmuliTkG9epbIpGPH+gFpFYixw29oIiFpUBUJv0AoJ+n/LC4zvA
        FKYXORlSD8qrbhg4v7klJrxqrz8h7X090/Fb52Tp1SXWTNeHK9auYxjQ7MSK5pQdrlPOfKBZh1BHP
        gIcfaf7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNWqr-005c7k-Qj; Mon, 15 Aug 2022 09:57:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44CC3980153; Mon, 15 Aug 2022 11:57:40 +0200 (CEST)
Date:   Mon, 15 Aug 2022 11:57:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/6] kprobes: Add new
 KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
Message-ID: <YvoYlCz0Ej7t9yDV@worktop.programming.kicks-ass.net>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811091526.172610-2-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 11, 2022 at 11:15:21AM +0200, Jiri Olsa wrote:
> Adding KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag to indicate that
> attach address is on function entry. This is used in following
> changes in get_func_ip helper to return correct function address.

IIRC (and I've not digested patch) the intent was to have func+0 mean
this. x86-IBT is not the only case where this applies, there are
multiple architectures where function entry is not +0.
