Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092B45B00AA
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 11:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiIGJip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 05:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIGJio (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 05:38:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA72AB2D80;
        Wed,  7 Sep 2022 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OsCEoNIrbCyBadFl7iEVm6YU+HPMKAlDJp0KSCt8Apk=; b=BIpFvwTuhKNBri78IDhQcy2xkI
        sKxgRo0M6uvTIDmVoCAHnG26qtdqgDCy10xZ7zNQDMFC7Jfgz32vurDhl56V5roTmVtqo+SA8sHK2
        i5BFlvMZZegrWtBOi2xU3BtHK3Ua72hhjzbA/8aOzS01dWEKE5CdHMmydG9K9W4Fvhp0R+kFN401c
        eQGP0JDCeFmjUbp5JDMEMpSn0O5kQQ9hVjSINKgGECqSbvoqicf4Pz/gA1MCyh/3UspkFbz2X9o62
        3saVOAgzFuobtUGoDUB8yCoWHPSuaEBvq68O5USirsNjXsXf2aue4k4pQWIxiA6tdgsPQv7twgmRT
        7RgXHCmw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVrW0-00APcu-Tj; Wed, 07 Sep 2022 09:38:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7AC20300244;
        Wed,  7 Sep 2022 11:38:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FE82201A4E68; Wed,  7 Sep 2022 11:38:36 +0200 (CEST)
Date:   Wed, 7 Sep 2022 11:38:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/kprobes: Fix kprobes instruction boudary check
 with CONFIG_RETHUNK
Message-ID: <YxhmnDqSkE8CP3UX@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
 <YxhDBAhYrs0Sfqjt@hirez.programming.kicks-ass.net>
 <20220907181218.41facc0902789c77e42170ea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907181218.41facc0902789c77e42170ea@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 06:12:18PM +0900, Masami Hiramatsu wrote:
> OK, it should be updated. Where can I refer the names (especially '.dX' suffixes)?

https://sourceware.org/binutils/docs-2.23.1/as/i386_002dMnemonics.html

  `.d8' or `.d32' suffix prefers 8bit or 32bit displacement in encoding.
