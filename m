Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B64400AFE
	for <lists+bpf@lfdr.de>; Sat,  4 Sep 2021 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351106AbhIDK5I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Sep 2021 06:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351100AbhIDK5H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Sep 2021 06:57:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363C5C061575;
        Sat,  4 Sep 2021 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HbnGaf0bnPZtgz30+mN/ev5Nx/MTJPwie3Aor7OwJtk=; b=OfdoP1UUmRFGKnW5MiBcbKdHmh
        1gHGW4nZXLEjKgtCMqYzBfmWTMCPsF2R+08DMPa9pRVj+hyfxfikjx9VxLIRm0ZH0YIEXsyExvAtf
        15R4onfs3kzAWfDtQUgSt2P7sCV+wUKm5Tm9sh5OREsa9fGNsAmXiVu7m4NG7vUwwX0DgdbAs38mD
        hC6Y3rNJGPp5uoHD7rQTi1S60oUdGi9LKq+eka5x5R+M6nkwciSDtVFak3bKvmI4Hb/LfPJYX+KtP
        Ei65lOdmzJilyRor/vqghmiYyt0EgnEG8qTA+/RwAuE8FoxXiKclFwBXNEY7ZBPBm1XbW/CpouHpC
        4VGzqMfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMTKc-005GWI-9s; Sat, 04 Sep 2021 10:55:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D405986283; Sat,  4 Sep 2021 12:55:29 +0200 (CEST)
Date:   Sat, 4 Sep 2021 12:55:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Message-ID: <20210904105529.GA5106@worktop.programming.kicks-ass.net>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-3-songliubraving@fb.com>
 <YTHhOy1gqr44C1bI@hirez.programming.kicks-ass.net>
 <CAEf4BzZ0eq1iFh1oVwTZ7+bQkb=pJShgDWzUSAp41sk30iQunQ@mail.gmail.com>
 <20210904102430.GD4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904102430.GD4323@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 04, 2021 at 12:24:30PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 03, 2021 at 10:10:16AM -0700, Andrii Nakryiko wrote:
> > > I suppose you have to have this helper function because the JIT cannot
> > > emit static_call()... although in this case one could cheat and simply
> > > emit a call to static_call_query() and not bother with dynamic updates
> > > (because there aren't any).
> > 
> > If that's safe, let's do it.
> 
> I'll try and remember to look into static_call_lock(), a means of
> forever denying future static_call_update() calls. That should make this
> more obvious.

A little something like so I suppose.... we don't really have spare
bits in the !INLINE case :/


---
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 3e56a9751c06..b0feccd56d37 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -174,6 +174,10 @@ struct static_call_tramp_key {
 	s32 key;
 };
 
+extern void __static_call_lock(struct static_call_key *key);
+
+#define static_call_lock(name) __static_call_lock(&STATIC_CALL_KEY(name))
+
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
 extern int static_call_mod_init(struct module *mod);
 extern int static_call_text_reserved(void *start, void *end);
@@ -215,6 +219,8 @@ extern long __static_call_return0(void);
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
+#define static_call_lock(name)
+
 static inline int static_call_init(void) { return 0; }
 
 #define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
@@ -268,6 +274,8 @@ static inline long __static_call_return0(void)
 
 #else /* Generic implementation */
 
+#define static_call_lock(name)
+
 static inline int static_call_init(void) { return 0; }
 
 static inline long __static_call_return0(void)
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 5a00b8b2cf9f..e40a3b595c4a 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -62,6 +62,7 @@ struct static_call_key {
 	void *func;
 	union {
 		/* bit 0: 0 = mods, 1 = sites */
+		/* but 1: locked */
 		unsigned long type;
 		struct static_call_mod *mods;
 		struct static_call_site *sites;
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 43ba0b1e0edb..a1ba93fbad29 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -104,6 +104,11 @@ static inline bool static_call_key_has_mods(struct static_call_key *key)
 	return !(key->type & 1);
 }
 
+static inline bool static_call_key_is_locked(struct static_call_key *key)
+{
+	return !!(key->type & 2);
+}
+
 static inline struct static_call_mod *static_call_key_next(struct static_call_key *key)
 {
 	if (!static_call_key_has_mods(key))
@@ -117,7 +122,7 @@ static inline struct static_call_site *static_call_key_sites(struct static_call_
 	if (static_call_key_has_mods(key))
 		return NULL;
 
-	return (struct static_call_site *)(key->type & ~1);
+	return (struct static_call_site *)(key->type & ~3);
 }
 
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
@@ -125,6 +130,9 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 	struct static_call_site *site, *stop;
 	struct static_call_mod *site_mod, first;
 
+	if (WARN_ON_ONCE(static_call_key_is_locked(key)))
+		return;
+
 	cpus_read_lock();
 	static_call_lock();
 
@@ -418,6 +426,18 @@ static void static_call_del_module(struct module *mod)
 	}
 }
 
+void __static_call_lock(struct static_call_key *key)
+{
+	cpus_read_lock();
+	static_call_lock();
+
+	WARN_ON_ONCE(static_call_key_is_locked(key));
+	key->type |= 2;
+
+	static_call_unlock();
+	cpus_read_unlock();
+}
+
 static int static_call_module_notify(struct notifier_block *nb,
 				     unsigned long val, void *data)
 {
