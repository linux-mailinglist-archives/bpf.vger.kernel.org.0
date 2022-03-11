Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1004D6478
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 16:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiCKPYi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 10:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiCKPYh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 10:24:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1AA16FDE2;
        Fri, 11 Mar 2022 07:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NjruXzuQDBa25iXAh8/mEaW7ZKoV0M6wDo7rHCp8Dyo=; b=ijaIGmrQPDAw1W7FSWpwXR8uoF
        YQuBaRffUYgOIIwfwZABBn6MehvhV3D+zCMmuwMxRZhW2VAvxAJmJ0ztzTuwDVSPdjh5EHo1lT8Gg
        V5Y06e8v/EX3P3DEex1jTEl+VsxpVVkU3Z7uJWV8gPAYI+C/ctbP4AeaRMZ6jXU8/zZ0ijEpJhR0T
        Soe4Bmn4+3gdW57lUYF5D7uK6ilaERDC+hb2KySCRISAvnbp6WWJMmJlhFup1fvwoG53DH/OQ15y8
        0Eqiklv7Oe0A9TjgItdGKFkU0H+ik63i192SvxpBlGFEv5iFh6YfRgySI3SdzMrtKHpjE+kZ4YOYk
        Z+3AJHsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSh6d-00HTxp-Tg; Fri, 11 Mar 2022 15:23:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 390093000E6;
        Fri, 11 Mar 2022 16:23:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B8EA2BCABC06; Fri, 11 Mar 2022 16:23:01 +0100 (CET)
Date:   Fri, 11 Mar 2022 16:23:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, mhiramat@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <YitpVCIllFrnakpL@hirez.programming.kicks-ass.net>
References: <20220308153011.021123062@infradead.org>
 <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
 <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
 <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <20220310093731.78a6a8d5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310093731.78a6a8d5@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 10, 2022 at 09:37:31AM -0500, Steven Rostedt wrote:
> On Thu, 10 Mar 2022 14:47:18 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index acb50fb7ed2d..2d86d3c09d64 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -5354,6 +5381,11 @@ int modify_ftrace_direct(unsigned long ip,
> >  	mutex_lock(&direct_mutex);
> >  
> >  	mutex_lock(&ftrace_lock);
> > +
> > +	ip = ftrace_location(ip);
> > +	if (!ip)
> > +		goto out_unlock;
> > +
> 
> Perhaps this should go into find_direct_entry() instead, as I think you are
> adding it before all the find_direct_entry() callers.

Something like so then?

Index: linux-2.6/kernel/trace/ftrace.c
===================================================================
--- linux-2.6.orig/kernel/trace/ftrace.c
+++ linux-2.6/kernel/trace/ftrace.c
@@ -1575,7 +1575,7 @@ unsigned long ftrace_location_range(unsi
  * If @ip matches sym+0, return sym's ftrace location.
  * Otherwise, return 0.
  */
-unsigned long ftrace_location(unsigned long ip)
+unsigned long __ftrace_location(unsigned long ip, struct dyn_ftrace **recp)
 {
 	struct dyn_ftrace *rec;
 	unsigned long offset;
@@ -1591,13 +1591,22 @@ unsigned long ftrace_location(unsigned l
 			rec = lookup_rec(ip, ip + size - 1);
 	}
 
-	if (rec)
+	if (rec) {
+		if (recp)
+			*recp = rec;
+
 		return rec->ip;
+	}
 
 out:
 	return 0;
 }
 
+unsigned long ftrace_location(unsigned long ip)
+{
+	return __ftrace_location(ip, NULL);
+}
+
 /**
  * ftrace_text_reserved - return true if range contains an ftrace location
  * @start: start of range to search
@@ -2392,6 +2401,30 @@ static struct ftrace_hash *direct_functi
 static DEFINE_MUTEX(direct_mutex);
 int ftrace_direct_func_count;
 
+static struct ftrace_func_entry *
+find_direct_entry(unsigned long *ip, struct dyn_ftrace **recp, bool warn)
+{
+	struct ftrace_func_entry *entry;
+	struct dyn_ftrace *rec = NULL;
+
+	*ip = __ftrace_location(*ip, &rec);
+	if (!*ip)
+		return NULL;
+
+	if (recp)
+		*recp = rec;
+
+	entry = __ftrace_lookup_ip(direct_functions, *ip);
+	if (!entry) {
+		WARN_ON(rec->flags & FTRACE_FL_DIRECT);
+		return NULL;
+	}
+
+	WARN_ON(warn && !(rec->flags & FTRACE_FL_DIRECT));
+
+	return entry;
+}
+
 /*
  * Search the direct_functions hash to see if the given instruction pointer
  * has a direct caller attached to it.
@@ -2400,7 +2433,7 @@ unsigned long ftrace_find_rec_direct(uns
 {
 	struct ftrace_func_entry *entry;
 
-	entry = __ftrace_lookup_ip(direct_functions, ip);
+	entry = find_direct_entry(&ip, NULL, false);
 	if (!entry)
 		return 0;
 
@@ -5127,40 +5160,19 @@ int register_ftrace_direct(unsigned long
 	struct ftrace_direct_func *direct;
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *free_hash = NULL;
-	struct dyn_ftrace *rec;
+	struct dyn_ftrace *rec = NULL;
 	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
 
-	ip = ftrace_location(ip);
-	if (!ip)
+	entry = find_direct_entry(&ip, &rec, true);
+	if (!ip || !rec)
 		goto out_unlock;
 
-	/* See if there's a direct function at @ip already */
 	ret = -EBUSY;
-	if (ftrace_find_rec_direct(ip))
-		goto out_unlock;
-
-	ret = -ENODEV;
-	rec = lookup_rec(ip, ip);
-	if (!rec)
+	if (entry && entry->direct)
 		goto out_unlock;
 
-	/*
-	 * Check if the rec says it has a direct call but we didn't
-	 * find one earlier?
-	 */
-	if (WARN_ON(rec->flags & FTRACE_FL_DIRECT))
-		goto out_unlock;
-
-	/* Make sure the ip points to the exact record */
-	if (ip != rec->ip) {
-		ip = rec->ip;
-		/* Need to check this ip for a direct. */
-		if (ftrace_find_rec_direct(ip))
-			goto out_unlock;
-	}
-
 	ret = -ENOMEM;
 	direct = ftrace_find_direct_func(addr);
 	if (!direct) {
@@ -5209,33 +5221,6 @@ int register_ftrace_direct(unsigned long
 }
 EXPORT_SYMBOL_GPL(register_ftrace_direct);
 
-static struct ftrace_func_entry *find_direct_entry(unsigned long *ip,
-						   struct dyn_ftrace **recp)
-{
-	struct ftrace_func_entry *entry;
-	struct dyn_ftrace *rec;
-
-	rec = lookup_rec(*ip, *ip);
-	if (!rec)
-		return NULL;
-
-	entry = __ftrace_lookup_ip(direct_functions, rec->ip);
-	if (!entry) {
-		WARN_ON(rec->flags & FTRACE_FL_DIRECT);
-		return NULL;
-	}
-
-	WARN_ON(!(rec->flags & FTRACE_FL_DIRECT));
-
-	/* Passed in ip just needs to be on the call site */
-	*ip = rec->ip;
-
-	if (recp)
-		*recp = rec;
-
-	return entry;
-}
-
 int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 {
 	struct ftrace_direct_func *direct;
@@ -5245,11 +5230,7 @@ int unregister_ftrace_direct(unsigned lo
 
 	mutex_lock(&direct_mutex);
 
-	ip = ftrace_location(ip);
-	if (!ip)
-		goto out_unlock;
-
-	entry = find_direct_entry(&ip, NULL);
+	entry = find_direct_entry(&ip, NULL, true);
 	if (!entry)
 		goto out_unlock;
 
@@ -5382,11 +5363,7 @@ int modify_ftrace_direct(unsigned long i
 
 	mutex_lock(&ftrace_lock);
 
-	ip = ftrace_location(ip);
-	if (!ip)
-		goto out_unlock;
-
-	entry = find_direct_entry(&ip, &rec);
+	entry = find_direct_entry(&ip, &rec, true);
 	if (!entry)
 		goto out_unlock;
 
