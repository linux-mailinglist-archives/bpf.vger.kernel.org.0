Return-Path: <bpf+bounces-45377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5C79D4F9E
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 16:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8051F227D0
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9A51DAC97;
	Thu, 21 Nov 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ppfws4NZ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362861D7E5C;
	Thu, 21 Nov 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202607; cv=none; b=tg5FyUaIXH3fKwy/cC7/VO6L29vhnwvYHCOAGeJJSHNzUmHf1YW7JGXMK9OMA8agvW4a+CoExHycDLa/V6FjF7EB9OXl4fSxXEjC8uqCKZWLUk2hvllbQHVzYhIK+4xklzdAuOJUiIHpU229LNv9LnwsoWNFzWhCO7viGeD//bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202607; c=relaxed/simple;
	bh=y5x6xEpM40jtwklXcJiTMsWMil5e1bPUB64pkE2nqDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koQoGimwkt1ZvNWjGQU7SfVzmp7WD82M7D5h/JP2znHhj89tIj/u9TT8yu7j3WbHwtg/5f4fTwkv8jTbfi4/ep6vu1ZGoAG9t0D7UHoTTurNGtsTHhWlVTBDO61EauuIlpruliOXz6wWbEOnXZTtHSTf+ZknnskMBq3i4j8kS0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ppfws4NZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rxevy5h5i8g9QJaX9dDgnxXQcDraOey7eWADfayEl0k=; b=Ppfws4NZ9w0ZwYZapvn7JbPIDU
	Kx1j9blrZQAcRovxmKXJHt0enTDoPvlAS+KHbSPE5wf3jxA24prNJXl4J1Q8/KixFx+qU4a7F4Jw5
	uSxVL7lioES1lirZdA70En42ToKOskNdj4j3sHig07hRdlWIYOa2ci8X+BBGLnewQPM5Ph+mFOiek
	7qzqpOeX8fiwwLudpnJsega7agLjvfb+Mv/9JVEBSs+zZPeRy6qMsSON84zTZqOmEbFvKiUkfN5qv
	AJ37nsW3ZgmrYdWR6QahOhkqj2+K9u70PACJIaVQs4CdCGdZcRM49kSmO3zhRpYg0NqVu9wtYWZ0C
	qL9W7Wkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tE91F-00000006WEF-1bLS;
	Thu, 21 Nov 2024 15:22:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B54E430068B; Thu, 21 Nov 2024 16:22:57 +0100 (CET)
Date: Thu, 21 Nov 2024 16:22:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, mjguzik@gmail.com,
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org,
	vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
	david@redhat.com, arnd@arndb.de, richard.weiyang@gmail.com,
	zhangpeng.00@bytedance.com, linmiaohe@huawei.com,
	viro@zeniv.linux.org.uk, hca@linux.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 tip/perf/core 2/4] mm: Introduce
 mmap_lock_speculation_{begin|end}
Message-ID: <20241121152257.GN38972@noisy.programming.kicks-ass.net>
References: <20241028010818.2487581-1-andrii@kernel.org>
 <20241028010818.2487581-3-andrii@kernel.org>
 <20241121144442.GL24774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121144442.GL24774@noisy.programming.kicks-ass.net>

On Thu, Nov 21, 2024 at 03:44:42PM +0100, Peter Zijlstra wrote:

> But perhaps it makes even more sense to add this functionality to
> seqcount itself. The same argument can be made for seqcount_mutex and
> seqcount_rwlock users.

Something like so I suppose.

---
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5298765d6ca4..102afdf8c7db 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -318,6 +318,28 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 	__seq;								\
 })
 
+/**
+ * raw_seqcount_try_begin() - begin a seqcount_t read critical section
+ *                            w/o lockdep and w/o counter stabilization
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ *
+ * Very like raw_seqcount_begin(), except it enables eliding the critical
+ * section entirely if odd, instead of doing the speculation knowing it will
+ * fail.
+ *
+ * Useful when counter stabilization is more or less equivalent to taking
+ * the lock and there is a slowpath that does that.
+ *
+ * If true, start will be set to the (even) sequence count read.
+ *
+ * Return: true when a read critical section is started.
+ */
+#define raw_seqcount_try_begin(s, start)				\
+({									\
+	start = raw_read_seqcount(s);					\
+	!(start & 1);							\
+})
+
 /**
  * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
  *                        lockdep and w/o counter stabilization

