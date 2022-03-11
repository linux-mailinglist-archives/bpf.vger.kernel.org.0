Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5A04D5FE7
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 11:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbiCKKmK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 05:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242183AbiCKKmJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 05:42:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E361C2D96;
        Fri, 11 Mar 2022 02:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AkzjaffqsM7lApV4o+H65jHOpuOe6KV8yXwb2WF6dMU=; b=sVckvczzMIqkK8zNtlAixrVAvU
        XCJLBekqmH2a/SE7X2l1z/z/w2OfOGZsCFggKc6zcGOYvUl694puMBUueA+QLykPu2XhwIqaGq2bf
        dE9pVZvyd3vOTmw7KrDYQvOKYAyFb0d6MEIJztRARnNT6ENLjks4cqKOnLa4RM01FuGJ4DtNbqK7V
        4I+xps9y2vaUDGPqay3CSdmiQM1Mlj/Tom3UJMcfMFa29I568+zZ1eaKFiBNLpRs7724pa1VMSp/I
        s3MWeBi7L1PajYfrkjqV0TqzPAgIXtcrSIV3UkkCFgOusdMdvgxWfsZh8j2fkcgeyZuRVNcFaioPY
        8EfkYSOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSchC-001UGh-DO; Fri, 11 Mar 2022 10:40:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25BD030027B;
        Fri, 11 Mar 2022 11:40:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 041AD201EE482; Fri, 11 Mar 2022 11:40:27 +0100 (CET)
Date:   Fri, 11 Mar 2022 11:40:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
References: <20220308153011.021123062@infradead.org>
 <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
 <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
 <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 10, 2022 at 05:29:11PM +0100, Peter Zijlstra wrote:

> This seems to cure most of the rest. I'm still seeing one failure:
> 
> libbpf: prog 'connect_v4_prog': BPF program load failed: Invalid argument
> libbpf: failed to load program 'connect_v4_prog'
> libbpf: failed to load object './connect4_prog.o'
> test_fexit_bpf2bpf_common:FAIL:tgt_prog_load unexpected error: -22 (errno 22)
> #48/4 fexit_bpf2bpf/func_replace_verify:FAIL


Hmm, with those two patches on I get:

root@tigerlake:/usr/src/linux-2.6/tgl-build# ./test_progs -t fexit
#46 fentry_fexit:OK
#48 fexit_bpf2bpf:OK
#49 fexit_sleep:OK
#50 fexit_stress:OK
#51 fexit_test:OK
Summary: 5/9 PASSED, 0 SKIPPED, 0 FAILED

On the tigerlake, I suppose I'm doing something wrong on the other
machine because there it's even failing on the pre-ibt kernel image.

I'll go write up changelogs and stick these on.
