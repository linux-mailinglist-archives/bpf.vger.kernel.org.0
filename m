Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A564C64A2C7
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 15:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiLLOD7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 09:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiLLOD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 09:03:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D963210A5;
        Mon, 12 Dec 2022 06:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zo/qFnAsqAdA6EwHKj640zNf/rPC7C+O0LLjxizZbPo=; b=DShHQBeT/EtTb+uCAKmtYRUIZb
        zisvhtLlckkieQb8GDwzzSOEo0a1WLzx32KL7N2wVM/qhdpWOG9BU2Sqlaixg77WO+E9jaDJ9+sbj
        mBFzoxtXlpO2mFyZSDyjzIEjNM3rOfg7rgTP5pmkWa62F6MYlktm96GeKtADv/loadzHsRnjOwNdV
        5uu5nqQxJ52LatHiXUKqIzTTOprO4sx327wlZ+gCzsEtr2K3MVUK4g5rHmglXn0ajdDklUDR5fsTC
        gZgl2VDa0v+pBAvOuxEb5JDt45LwENVOtU7JdGTYtFuQ/cDCv+K3yBdwioDb3yP7G9El7WO/Y0EPB
        7eMifSgw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4jOv-009n2o-7X; Mon, 12 Dec 2022 14:03:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDBAA300299;
        Mon, 12 Dec 2022 15:03:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4C2C2024870B; Mon, 12 Dec 2022 15:03:20 +0100 (CET)
Date:   Mon, 12 Dec 2022 15:03:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 31/31] sched_ext: Add a rust userspace hybrid example
 scheduler
Message-ID: <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-32-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-32-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 10:23:13PM -1000, Tejun Heo wrote:
> From: Dan Schatzberg <dschatzberg@meta.com>
> 
> Atropos is a multi-domain BPF / userspace hybrid scheduler where the BPF
> part does simple round robin in each domain and the userspace part
> calculates the load factor of each domain and tells the BPF part how to load
> balance the domains.
> 
> This scheduler demonstrates dividing scheduling logic between BPF and
> userspace and using rust to build the userspace part.

And here I am, speaking neither Rust nor BPF.

But really, having seen some of this I long for the UMCG patches -- that
at least was somewhat sane and trivially composes, unlike all this
madness.

