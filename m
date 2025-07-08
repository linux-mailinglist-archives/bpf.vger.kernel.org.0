Return-Path: <bpf+bounces-62698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FBFAFD12C
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 18:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D521C22305
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 16:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECD92E54C8;
	Tue,  8 Jul 2025 16:31:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21701CD1E4;
	Tue,  8 Jul 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992296; cv=none; b=dXlhShIv+hiMD0TPA+LiCiSCqxZsVO6jPwnjDLGpOF/BsY5KWRniBOGEMHlEVzcarTnF+wGZTN174uNRIWkEzWSlPk/C5eidOLPpomiXR0ROaeb6Jy/YxTzhQyQFKh7/huClugqi4nOF2ZFx3ivsLkjYjdc8H62yq9CYhDrNHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992296; c=relaxed/simple;
	bh=kKFfVsjjQy3Sye5RAKQyCnZiAtZH86+HYBvB16fyzoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7EV2fRc8eTNdHX7uHJurqFeJ16oRd4nu0DVDhD746bQhz3p/0EyYMUmoT58IYPIUPeEWcnu9M2oi6263KwYpHShOnTNjdyuKVy8U0lri5nnrNOaFy8cT+bi0iHJe/6d4/c1qpbYCJXkIGAciBr4TuSxO5woQ32yBB5Kuv6/MbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A04AB10B198;
	Tue,  8 Jul 2025 16:31:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 04DFD2000E;
	Tue,  8 Jul 2025 16:31:19 +0000 (UTC)
Date: Tue, 8 Jul 2025 12:31:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt
 <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in
 uaccess regions
Message-ID: <20250708123120.7862c458@gandalf.local.home>
In-Reply-To: <CAHk-=wgXcc99EXKfK++FEQzMQc8S16WOwvn=1DcP_ns1jCCYeA@mail.gmail.com>
References: <20250708021115.894007410@kernel.org>
	<20250708021200.058879671@kernel.org>
	<CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
	<20250708092351.4548c613@gandalf.local.home>
	<orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
	<20250708104130.25b76df9@gandalf.local.home>
	<CAHk-=wgXcc99EXKfK++FEQzMQc8S16WOwvn=1DcP_ns1jCCYeA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bb3hnktb3dp9a9m7owwr4xcq4fdujnkx
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 04DFD2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Y0fUepPxaRcfNYrcIABvux8APfNuf2IY=
X-HE-Tag: 1751992279-762972
X-HE-Meta: U2FsdGVkX1+CMuUGypXL1y73IoeNSQJkVrDtzFJSFsYtnPyrjYDQzSR06KYhMnOrpl4Lx/0EQbc7AAqZnPhyKPxXa7LC4/yAbqexMWif3OPVCK16R9a1OF/BJDHp0yNzqkR8J8DPHFolf0Ub7avQHNpfq8NVp/hVZARN9i+lMO5yBn/X9x+BagzI2sp3C87zrNi9XCZJHUnWsWtsDJ6B3QVOWlh37MD62LAKuZsLe+Ck6jECrDxvCgyCblw1LaFpP7K24I8tFo1/AAq6oaPG46VTqMrzxVFQE8FT65YIBX6+eiwFfvI7ATf4iDMYLufw+MzgQMCOmpwB6TXuakm++cl/zFjtNfl5wr1pSUOG3pNkYhO1PYEQ7MeM8lVQfWc8VxLfR/zTkKJarEaTvB9r/YLpcs38622Ue65Z1gzXqcRUBGhJBkPvDqDRO0SV95s21xe+dPHNSs1dQVAwDyuigYcncWln1OuGlkYTjNGR7iaO+8sNYSHqvA==

On Tue, 8 Jul 2025 08:53:56 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 8 Jul 2025 at 07:41, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Would something like this work? If someone enables the config to enable the
> > validation, I don't think we need dynamic printk to do it (as that requires
> > passing in the format directly and not via a pointer).  
> 
> I really think you should just not use 'user_access_begin()" AT ALL if
> you need to play these kinds of games.
> 

Looking at the code a bit deeper, I don't think we need to play these games
and still keep the user_read_access_begin().

The places that are more performance critical (where it reads the sframe
during normal stack walking during profiling) has no debug output, and
there's nothing there that needs to take it out of the user_read_access
area.

It's the validator that adds these hacks. I don't think it needs to. It can
just wrap the calls to the code that requires user_read_access and then
check the return value. The validator is just a debugging feature and
performance should not be an issue.

But I do think performance is something to care about during normal
operations where the one big user_read_access_begin() can help.

What about something like this? It adds "safe" versions of the user space
access functions and uses them only in the slow (we don't care about
performance) validator:

-- Steve

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 0060cc576776..79ff3c0fc11f 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -321,7 +321,34 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 
 #ifdef CONFIG_SFRAME_VALIDATION
 
-static __always_inline int __sframe_validate_section(struct sframe_section *sec)
+static int safe_read_fde(struct sframe_section *sec,
+			 unsigned int fde_num, struct sframe_fde *fde)
+{
+	int ret;
+
+	if (!user_read_access_begin((void __user *)sec->sframe_start,
+				    sec->sframe_end - sec->sframe_start))
+		return -EFAULT;
+	ret = __read_fde(sec, fde_num, fde);
+	user_read_access_end();
+	return ret;
+}
+
+static int safe_read_fre(struct sframe_section *sec,
+			 struct sframe_fde *fde, unsigned long fre_addr,
+			 struct sframe_fre *fre)
+{
+	int ret;
+
+	if (!user_read_access_begin((void __user *)sec->sframe_start,
+				    sec->sframe_end - sec->sframe_start))
+		return -EFAULT;
+	ret = __read_fre(sec, fde, fre_addr, fre);
+	user_read_access_end();
+	return ret;
+}
+
+static int sframe_validate_section(struct sframe_section *sec)
 {
 	unsigned long prev_ip = 0;
 	unsigned int i;
@@ -335,13 +362,13 @@ static __always_inline int __sframe_validate_section(struct sframe_section *sec)
 		unsigned int j;
 		int ret;
 
-		ret = __read_fde(sec, i, &fde);
+		ret = safe_read_fde(sec, i, &fde);
 		if (ret)
 			return ret;
 
 		ip = sec->sframe_start + fde.start_addr;
 		if (ip <= prev_ip) {
-			dbg_sec_uaccess("fde %u not sorted\n", i);
+			dbg_sec("fde %u not sorted\n", i);
 			return -EFAULT;
 		}
 		prev_ip = ip;
@@ -353,17 +380,20 @@ static __always_inline int __sframe_validate_section(struct sframe_section *sec)
 			fre = which ? fres : fres + 1;
 			which = !which;
 
-			ret = __read_fre(sec, &fde, fre_addr, fre);
+			ret = safe_read_fre(sec, &fde, fre_addr, fre);
 			if (ret) {
-				dbg_sec_uaccess("fde %u: __read_fre(%u) failed\n", i, j);
-				dbg_print_fde_uaccess(sec, &fde);
+				dbg_sec("fde %u: __read_fre(%u) failed\n", i, j);
+				dbg_sec("FDE: start_addr:0x%x func_size:0x%x fres_off:0x%x fres_num:%d info:%u rep_size:%u\n",
+					fde.start_addr, fde.func_size,
+					fde.fres_off, fde.fres_num,
+					fde.info, fde.rep_size);
 				return ret;
 			}
 
 			fre_addr += fre->size;
 
 			if (prev_fre && fre->ip_off <= prev_fre->ip_off) {
-				dbg_sec_uaccess("fde %u: fre %u not sorted\n", i, j);
+				dbg_sec("fde %u: fre %u not sorted\n", i, j);
 				return -EFAULT;
 			}
 
@@ -374,21 +404,6 @@ static __always_inline int __sframe_validate_section(struct sframe_section *sec)
 	return 0;
 }
 
-static int sframe_validate_section(struct sframe_section *sec)
-{
-	int ret;
-
-	if (!user_read_access_begin((void __user *)sec->sframe_start,
-				    sec->sframe_end - sec->sframe_start)) {
-		dbg_sec("section usercopy failed\n");
-		return -EFAULT;
-	}
-
-	ret = __sframe_validate_section(sec);
-	user_read_access_end();
-	return ret;
-}
-
 #else /*  !CONFIG_SFRAME_VALIDATION */
 
 static int sframe_validate_section(struct sframe_section *sec) { return 0; }

