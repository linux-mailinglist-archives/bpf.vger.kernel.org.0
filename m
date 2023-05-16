Return-Path: <bpf+bounces-615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5037048F7
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 11:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3356281000
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 09:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3AC156F7;
	Tue, 16 May 2023 09:19:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9932C726
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 09:19:31 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF9C3588;
	Tue, 16 May 2023 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T4Sl1ooBMpb0KanF1wJIqGZiESG+DyDGWDVl3K8WeZc=; b=thpq6ZmH4G9fdo7dFMIuaCShJn
	vKgsEXcb3N7S96cxM34TNZ0/2ZeXZ+/8JQ+/2rYIVRdvI3/0EAMO3H14GOFLlVQBmFluRR0qCrYtd
	sO9vJz5Ibq0vbeWMngbnNu/YT13I0sIvRpOcrHkDIzsB18UYTCFt7ZC03H2ly1MDx98Y76sbEgkAb
	+badUdO52UmI9I7EB4CdAY3MgGbok5FHWffCtRCGhWICUEeA4njesY3PqrW5UKvhU5b1FQ7Z2MAqK
	a1eW3FfI/q+76vBbtLDD6a8befQtUWBPfkxkUtPTLm9+pTABNLs8p5nxOeE+ruY1IWLV2YKdyrZtC
	vgDNLtaQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pyqp2-0048AC-U4; Tue, 16 May 2023 09:18:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BE8330008D;
	Tue, 16 May 2023 11:18:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60A632011856F; Tue, 16 May 2023 11:18:20 +0200 (CEST)
Date: Tue, 16 May 2023 11:18:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ze Gao <zegao2021@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Conor Dooley <conor@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
	Ze Gao <zegao@tencent.com>
Subject: Re: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion free
Message-ID: <20230516091820.GB2587705@hirez.programming.kicks-ass.net>
References: <20230516071830.8190-1-zegao@tencent.com>
 <20230516071830.8190-3-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516071830.8190-3-zegao@tencent.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 03:18:28PM +0800, Ze Gao wrote:
> Current implementation calls kprobe related functions before doing
> ftrace recursion check in fprobe_kprobe_handler, which opens door
> to kernel crash due to stack recursion if preempt_count_{add, sub}
> is traceable.

Which preempt_count*() are you referring to? The ones you just made
_notrace in the previous patch?

