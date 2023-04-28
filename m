Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A0C6F1B5F
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 17:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbjD1PW1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 11:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346355AbjD1PWY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 11:22:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1320435B8;
        Fri, 28 Apr 2023 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ObFqb5BDmMg75VURSfwaRS1WNbglIFkai9QniJhx8m4=; b=ofjldNKGNAboYyyizE5X9fXe5v
        ZECX/MjUW9VZAnH4i5cPG6ZPlfJx697aSrS+hW4+MQWrz2GaGJTNZKGfTGwzeBzQq80A2egcmtHsv
        1mghY2IwxRhk038jLeuk5gwgxYf15Iaw49O745UNZE2t4bGiI825VZGO9S/v5wfHTWUa/9hTuSc5y
        tagA/JI7fEIkjL1A+DqDsFvSCYBt46XQWLecSNBxX4U/NWIVg+4Ar2IlulvFY2/NEF1VbeFgDaYn0
        U8jheldPF/YoLurtIZslA5NOInjPl4yJn3GIDfJRHFh/o0gt2mp+fq7dvbTSmQbBrSkY8w/hebDrp
        ksbCQpJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1psPvD-00DMsj-1Q;
        Fri, 28 Apr 2023 15:22:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC5DD300300;
        Fri, 28 Apr 2023 17:22:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B34A732220BBA; Fri, 28 Apr 2023 17:22:06 +0200 (CEST)
Date:   Fri, 28 Apr 2023 17:22:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH RFC 00/43] x86/pie: Make kernel image's virtual address
 flexible
Message-ID: <20230428152206.GA1464060@hirez.programming.kicks-ass.net>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


For some raison I didn't get 0/n but did get all of the others. Please
keep your Cc list consistent.

On Fri, Apr 28, 2023 at 05:50:40PM +0800, Hou Wenlong wrote:

>   - It is not allowed to reference global variables in an alternative
>     section since RIP-relative addressing is not fixed in
>     apply_alternatives(). Fortunately, all disallowed relocations in the
>     alternative section can be captured by objtool. I believe that this
>     issue can also be fixed by using objtool.

https://lkml.kernel.org/r/Y9py2a5Xw0xbB8ou@hirez.programming.kicks-ass.net
