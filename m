Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF41602E68
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 16:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiJRO0h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 10:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiJRO0e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 10:26:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A4BC0981
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lRhdHgCWUjXjv0masOFjK8upoM6QJK70D7oNOPh9QAI=; b=TvLOM0OA6hngiwG1n2tO/7kvkS
        9fok2BOQXpzBCgenV5aH6IjXJWQEMV5dCFtqGHrIKve5rjIvDByHH+sKFDpY6K6Eo9UwSxsFyfS1E
        WYgKZrdDVoiZfnQf7OOH4HhW87UiFfjrLBtF/2GbEDjCcusYtBE2vmRlZFNyO9GN4dKUqMNKDTgno
        p3NH/zk2ePy2EG9vLC7IcDQtnU9ge5eK6gcubz/GV+VW5/hWvdIVJQeYzc8zy0z9Nc6HHfaeF3HD0
        Qc+0rl6MT0XCeoedM2GkjIZUmA7OblJ0v/bxkaDARrAUu8XstJAQhhTAqQpH+L+PNi6Xtr4bch1wP
        9k7yYuRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oknXq-004VNx-Cs; Tue, 18 Oct 2022 14:26:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E70D1300202;
        Tue, 18 Oct 2022 16:26:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D051C2129C235; Tue, 18 Oct 2022 16:26:12 +0200 (CEST)
Date:   Tue, 18 Oct 2022 16:26:12 +0200
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
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Fix dispatcher patchable function entry to 5
 bytes nop
Message-ID: <Y063hLFH1JXtdg7Y@hirez.programming.kicks-ass.net>
References: <20221018075934.574415-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018075934.574415-1-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 09:59:34AM +0200, Jiri Olsa wrote:
> The patchable_function_entry(5) might output 5 single nop
> instructions (depends on toolchain), which will clash with
> bpf_arch_text_poke check for 5 bytes nop instruction.
> 
> Adding early init call for dispatcher that checks and change
> the patchable entry into expected 5 nop instruction if needed.
> 
> There's no need to take text_mutex, because we are using it
> in early init call which is called at pre-smp time.
> 
> Fixes: ceea991a019c ("bpf: Move bpf_dispatcher function out of ftrace locations")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
