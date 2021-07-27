Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8023D7173
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 10:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhG0IsT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 04:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbhG0IsT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 04:48:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A506EC061757
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+wNngmf69oTRKybdgwHJO1Pd/RjlDc2+aRWE7IELkAQ=; b=EhIQ6WM3ErGVzDOz6wQvPdSQ+v
        tTNPqc6OWWHG6j0JfKDLmHX8Q/RHzybVp1VhtAy5b1IJIGKJQQb+3s20lys+4mFphg6bThKZSA4Ry
        7s6fpqg2ktGtT2QIGsqjhqn2YydkwWyysGBw17WEvaOn6abTsAwd+HbxyNkRl4hFmjs1hA76exuCa
        ii9D151KvBExt8UVr/KZXNCt7ksO/jjIWvBdXW/uyeYFPgDsb4CBSyGYGcsW8GR21dx8GTITKZHAe
        kLwk4/z/Pmy/rolLYJRHu8T7k3q7w/9deY2tNO6tf+zGrjS0CXwyM91ONWl/WQKW35SAYGY+/29fi
        DImPdcsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8Ikz-003OmJ-SU; Tue, 27 Jul 2021 08:48:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 090AA300233;
        Tue, 27 Jul 2021 10:48:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E098B2CB8E20A; Tue, 27 Jul 2021 10:48:07 +0200 (CEST)
Date:   Tue, 27 Jul 2021 10:48:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 03/14] bpf: refactor
 perf_event_set_bpf_prog() to use struct bpf_prog input
Message-ID: <YP/IR3lp9XtHOgYw@hirez.programming.kicks-ass.net>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-4-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726161211.925206-4-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 26, 2021 at 09:12:00AM -0700, Andrii Nakryiko wrote:
> Make internal perf_event_set_bpf_prog() use struct bpf_prog pointer as an
> input argument, which makes it easier to re-use for other internal uses
> (coming up for BPF link in the next patch). BPF program FD is not as
> convenient and in some cases it's not available. So switch to struct bpf_prog,
> move out refcounting outside and let caller do bpf_prog_put() in case of an
> error. This follows the approach of most of the other BPF internal functions.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
