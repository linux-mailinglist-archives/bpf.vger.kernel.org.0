Return-Path: <bpf+bounces-62690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E984DAFCE00
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 16:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37351487390
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 14:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8222E06E4;
	Tue,  8 Jul 2025 14:41:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C62DF3DA;
	Tue,  8 Jul 2025 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985700; cv=none; b=EQjq8jJh7jm4TLiurivvT/QdIcVo87I5fZwMgP51UNYgp06YQJgdwLY/P2JZFQ/B5aPke0AGyEogyc9aDMaFvX/nUWrxIOJ0M4/TIqJ/N1XXAXefsmWT7mgVNgPMtsTjHaI5OzwxDcU9CSDBvSyOQMotHFu08FDN/fn7cApQ/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985700; c=relaxed/simple;
	bh=hufHe4IE8eZf/XDENzkZEIR+zscCdMt60qnkA9EsX1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Emr5MJtLVLmWJmKJB14N1+6wuTCtPLukUdmMYroyCAUtiNxFrJ0wS7e2Chye8UIoETL00Usp0sr+l/m0SJM8x2uDvxym9EoEOCysFB0JD0GM7GYNJW6SWSSZRNk7eyNZjopwiSBX/mSMZ//uNuj+NLuWFgypQQuHIyW7ASpZxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id CEE7C5A3E2;
	Tue,  8 Jul 2025 14:41:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 145452002D;
	Tue,  8 Jul 2025 14:41:29 +0000 (UTC)
Date: Tue, 8 Jul 2025 10:41:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt
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
Message-ID: <20250708104130.25b76df9@gandalf.local.home>
In-Reply-To: <orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
References: <20250708021115.894007410@kernel.org>
	<20250708021200.058879671@kernel.org>
	<CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
	<20250708092351.4548c613@gandalf.local.home>
	<orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 145452002D
X-Rspamd-Server: rspamout02
X-Stat-Signature: qpmhrsiy8stxuor77jefwkrzwh6kjp34
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Up2M/qA+CuKfyyqu6ZaHMccmLpLI3lTs=
X-HE-Tag: 1751985689-715856
X-HE-Meta: U2FsdGVkX1+W/NjgdaM3xA6WW1mpG1cw95ojVNGIy/a1YyTiN/lHqC/84cg0ilhSRJ/XcjCXtGVbAovK/Nl7PBxfAfmL6/yVth+cwODZL0AoIuiu6RMpEz6hHQdxPf+1wDoG7GTBzpcL/emRP2Uam06WhqId7C+vFKfzh9A5wXe8UWatqkzXGvmqYtuMRmrxtumxVE994G2T1YhwU0bDqpvFCbmOWnpFOUAXIWeWGNnP7XAh6gkYMY396ONf2EB0lW+mSc1Ifr9CCxM7cEKVIhE/LDBbfR4Qp3dKCLBd4XS5tUUQ4CNvvlRiN2uJ2c4XB9RbUlBlYFjyOltqZCoOQAY9EtY6dst0D5q53b+bt4LL69LvQrM0ZICc5OWSwbE8

On Tue, 8 Jul 2025 07:34:36 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> I had found those debug printks really useful for debugging
> corrupt/missing .sframe data, but yeah, this patch is ridiculously bad.
> Sorry for putting that out into the world ;-)
> 
> And those are all error paths, so it's rather pointless to do that whole
> uaccess disable/enable/disable dance.
> 
> So yeah, drop it for now and I can replace it with something better
> later on.

Would something like this work? If someone enables the config to enable the
validation, I don't think we need dynamic printk to do it (as that requires
passing in the format directly and not via a pointer).

-- Steve

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 0060cc576776..524738e2b823 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -321,11 +321,24 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 
 #ifdef CONFIG_SFRAME_VALIDATION
 
-static __always_inline int __sframe_validate_section(struct sframe_section *sec)
+/* Used to save error messages in uaccess sections */
+struct err_msg {
+	const char		*fmt;
+	int			param1;
+	int			param2;
+	long			param3;
+	long			param4;
+};
+
+static __always_inline
+int __sframe_validate_section(struct sframe_section *sec, struct err_msg *err)
 {
 	unsigned long prev_ip = 0;
 	unsigned int i;
 
+/* current->comm, current->pid, sec->filename */
+#define ERR_HDR KERN_WARNING "%s (%d) %s: "
+
 	for (i = 0; i < sec->num_fdes; i++) {
 		struct sframe_fre *fre, *prev_fre = NULL;
 		unsigned long ip, fre_addr;
@@ -341,7 +354,8 @@ static __always_inline int __sframe_validate_section(struct sframe_section *sec)
 
 		ip = sec->sframe_start + fde.start_addr;
 		if (ip <= prev_ip) {
-			dbg_sec_uaccess("fde %u not sorted\n", i);
+			err->fmt = ERR_HDR "fde %u not sorted\n";
+			err->param1 = i;
 			return -EFAULT;
 		}
 		prev_ip = ip;
@@ -355,15 +369,23 @@ static __always_inline int __sframe_validate_section(struct sframe_section *sec)
 
 			ret = __read_fre(sec, &fde, fre_addr, fre);
 			if (ret) {
-				dbg_sec_uaccess("fde %u: __read_fre(%u) failed\n", i, j);
-				dbg_print_fde_uaccess(sec, &fde);
+				err->fmt = ERR_HDR
+					"fde %u: __read_fre(%u) failed\n"
+					"  frame_start=%lx frame_end=%lx\n";
+				err->param1 = i;
+				err->param2 = j;
+				err->param3 = (long)sec->sframe_start;
+				err->param4 = (long)sec->sframe_end;
 				return ret;
 			}
 
 			fre_addr += fre->size;
 
 			if (prev_fre && fre->ip_off <= prev_fre->ip_off) {
-				dbg_sec_uaccess("fde %u: fre %u not sorted\n", i, j);
+				err->fmt = ERR_HDR
+					"fde %u: fre %u not sorted\n";
+				err->param1 = i;
+				err->param2 = j;
 				return -EFAULT;
 			}
 
@@ -376,16 +398,26 @@ static __always_inline int __sframe_validate_section(struct sframe_section *sec)
 
 static int sframe_validate_section(struct sframe_section *sec)
 {
+	struct err_msg err;
 	int ret;
 
+	memset(&err, 0, sizeof(err));
+
 	if (!user_read_access_begin((void __user *)sec->sframe_start,
 				    sec->sframe_end - sec->sframe_start)) {
-		dbg_sec("section usercopy failed\n");
+		pr_warn("%s (%d): section usercopy failed\n",
+			current->comm, current->pid);
 		return -EFAULT;
 	}
 
-	ret = __sframe_validate_section(sec);
+	ret = __sframe_validate_section(sec, &err);
 	user_read_access_end();
+
+	if (ret) {
+		printk(err.fmt, current->comm, current->pid,
+		       sec->filename, err.param1, err.param2,
+		       err.param3, err.param4);
+	}
 	return ret;
 }
 

