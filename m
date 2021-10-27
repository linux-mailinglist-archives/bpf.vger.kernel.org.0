Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77EA43C603
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 11:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhJ0JGP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhJ0JGO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:06:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B751AC061570;
        Wed, 27 Oct 2021 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GJg6eB6n8rP40WF7KLwrQtbmrEa/9yt5sPpTb6bjopM=; b=J2yCCtFPMmo3xtP5ajSZqKRB7D
        nLKe/YCLDCHv29Fo6MvPx3AOPkJv96BTVBfrCTFXqFgeJBcPxXkhtmoQ7JiDc2OCqckAgsd5yDt2y
        6EV4gAZR6XLM5V56xoOE4i2hycDkB3IFMmcI3joAOEkuKxSFN3jgA16PMRfVv3I/l/7vL+79pFVEZ
        t5cnBi28jp7O3d8NvMs15XnAp2ri+Bwmlj2yo1EN+hUelmQ0ggoON4w+NGNM/4cirEc4RWroVqYkQ
        u5mzu+Vr1BiEAa6HmTiEX/iQjI1DGLZwCnKh1F37yXJJ8nYfK4UujEXuWPmAqRC+FfcZxcLbdDZ+Q
        EPmKAJ+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfen3-00HWYd-R3; Wed, 27 Oct 2021 09:00:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73AD730031A;
        Wed, 27 Oct 2021 11:00:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51060236E43D9; Wed, 27 Oct 2021 11:00:09 +0200 (CEST)
Date:   Wed, 27 Oct 2021 11:00:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 00/16] x86: Rewrite the retpoline rewrite logic
Message-ID: <YXkVGSG3BkMUEaKH@hirez.programming.kicks-ass.net>
References: <20211026120132.613201817@infradead.org>
 <CAADnVQJaiHWWnVcaRN43DcNgqktgKs3i1P3uz4Qm8kN7bvPCCg@mail.gmail.com>
 <YXhMv6rENfn/zsaj@hirez.programming.kicks-ass.net>
 <CAADnVQ+w_ww3ZR_bJVEU-PxWusT569y0biLNi=GZJNpKqFzNLA@mail.gmail.com>
 <20211026210509.GH174703@worktop.programming.kicks-ass.net>
 <CAADnVQ+NA2J3Lxvb8Y31yaubM6ntx5LtoSEaLziZ1b8qiY4oYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+NA2J3Lxvb8Y31yaubM6ntx5LtoSEaLziZ1b8qiY4oYQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 02:05:55PM -0700, Alexei Starovoitov wrote:

> Please post it. CI cannot pull it from the repo.

Done:

  https://lore.kernel.org/bpf/20211027085243.008677168@infradead.org/T/#t
