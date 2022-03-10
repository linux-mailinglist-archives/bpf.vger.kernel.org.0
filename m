Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA39E4D485B
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 14:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiCJNtG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 08:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242514AbiCJNtG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 08:49:06 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3991CA6504;
        Thu, 10 Mar 2022 05:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h62QDpiv0sKvaMSzpmkYIhLgXWs1pYU6I0XpXuvuC+g=; b=qWHF2TELafU4ktGyB58Bp5t9ET
        ZCzNQd9HNEVgHDVn0qsfyyOGwILkEXGUyq+Yd2ZDEcbSRKhDnM75gHogn5YBSDjiwyjDb6lcCJ3Tk
        CYVF3eDEwIlPxaBXe8cmzqxGXrRgCNs5gxHH/bxELWn7uZYDprNxXEtJZxojQg0Zbpv5EoZCefUgF
        GiFbwfmmdMRSDvzLvx6aqgoozhS0keNlvyligzRlGNSTjzrkL3tvRN0tfxu2H0BhMiIujagxOBu2o
        oNvr+KGfzfiVKqcNwUTHO2IrN4tliYuyglZqF4u2p84593kP6FY9icvFIF9tX2zLJ3JF/Be0SayjH
        QtJ3kLcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSJ8T-00H7ra-Bi; Thu, 10 Mar 2022 13:47:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A9B93000E6;
        Thu, 10 Mar 2022 14:47:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA87326719DE3; Thu, 10 Mar 2022 14:47:18 +0100 (CET)
Date:   Thu, 10 Mar 2022 14:47:18 +0100
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
Message-ID: <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
References: <20220308153011.021123062@infradead.org>
 <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
 <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
 <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 10, 2022 at 10:35:32AM +0100, Peter Zijlstra wrote:

> > $ test_progs -t fentry
> > test_fentry_fexit:PASS:fentry_skel_load 0 nsec
> > test_fentry_fexit:PASS:fexit_skel_load 0 nsec
> > test_fentry_fexit:PASS:fentry_attach 0 nsec
> > test_fentry_fexit:FAIL:fexit_attach unexpected error: -1 (errno 19)
> > #54 fentry_fexit:FAIL

This seems to cure the above. fexit_bpf2bpf is still failing, I'll dig
into that after lunch.

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index acb50fb7ed2d..2d86d3c09d64 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5354,6 +5381,11 @@ int modify_ftrace_direct(unsigned long ip,
 	mutex_lock(&direct_mutex);
 
 	mutex_lock(&ftrace_lock);
+
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry = find_direct_entry(&ip, &rec);
 	if (!entry)
 		goto out_unlock;
