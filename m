Return-Path: <bpf+bounces-63943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610A3B0CC49
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DD61AA2220
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAE723D2A0;
	Mon, 21 Jul 2025 21:15:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52381F4C92;
	Mon, 21 Jul 2025 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132539; cv=none; b=hvYf+DV+jQ28EEfA62kCCbgZ5O2HwW6xWOCkxTlZjYFWUd8+B5x+dIAd3XBJH0Wix8KaK9xjej3dczHupeeQL+jHgDILLI5ECrLtJOSTEC+mecbEnKXS2uaYmGkdljT1NACkHfCUzLBqyKP3farLKcEQaCFfNzjiptWzTHlWhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132539; c=relaxed/simple;
	bh=UXQqaSrKNl32HMXFzjbrX6dAJBcUn1XXimPqlbYI1Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHQFX2+OZ02AWb4IZZ7k9bj3NVMnvtSEc3RFWX52Uu83QLn199hTwdAFS8SZ41dpDEHMxO6FA1Zkw60O74mrBCYpbR5HKdU+kMZ+h3cagolXKBevNKqMlBE29IUNHiJBZ4jvNcDliZsaL1jqQ/e18MrOYJHOFQzPVE/FxWKE2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 8CC3F1401AF;
	Mon, 21 Jul 2025 21:15:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id BA6B06000F;
	Mon, 21 Jul 2025 21:15:28 +0000 (UTC)
Date: Mon, 21 Jul 2025 17:15:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Brian Robbins
 <brianrob@microsoft.com>, Elena Zannoni <elena.zannoni@oracle.com>
Subject: Re: [RFC] New codectl(2) system call for sframe registration
Message-ID: <20250721171559.53ea892f@gandalf.local.home>
In-Reply-To: <e7926bca-318b-40a0-a586-83516302e8c1@efficios.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
	<20250721145343.5d9b0f80@gandalf.local.home>
	<e7926bca-318b-40a0-a586-83516302e8c1@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ag81zer5egpqh9su1tcpmhb9adkx5adh
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BA6B06000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18IAN69k6jt255S96ZtQ7lzqvvHrMQq1QI=
X-HE-Tag: 1753132528-518571
X-HE-Meta: U2FsdGVkX1/R7XQyqHfn2QUhOnBWDmWkCePphtyYWkDNL+6B52nQVE3yRvQ5HLxL2sUDQ8LKaFrdrJXqHBm6H8P5TwkX4SoubRxIYW5kal1toHP6Ye5YHJRYrcLVHXk1FQe3Upqojj9UoIFx3HMPHWuTfltybq4gGCFwNw6GePA/IxLLWciO8WnyYiG3GzLZS4GitYhyswY+S0QjcmGboxsO7Deb9xQJkgQx1sNv0odWvrXIzwmgFlJ+ZmeB62NNLO4/uAFr5zLUbCBDCGBZk8D8xW17Hs649LEGZpAT/IhUmTxLAb3a1qOGBzgWYGT2bJine59ge8Mu3b0lUthTBEVn23B0OoMFHN/+xxL0xWFcZ3ZpQ+h+RZWDBr1X7MlM

On Mon, 21 Jul 2025 16:58:43 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > Honestly, I'm not sure it needs to be an ELF file. Just a file that has an
> > sframe section in it.  
> 
> Indu told me on IRC that for GNU/Linux, SFrame will be an
> allocated,loaded section in elf files.

Yes it is, but is that a requirement for this interface? I just don't want
to add requirements based on how thing currently work if they are not
needed.

> 
> I'm planning to add optional fields (build id, debug link) that are
> ELF-specific. I therefore think it's best that we keep this specific as
> registration of an elf file.

Here's a hypothetical, what if for some reason (say having the sframe
sections outside of the elf file) that the linker shares that?

For instance, if the sframe sections are downloaded separately as a
separate package for a given executable (to make it not mandatory for an
install), the linker could be smart enough to see that they exist in some
special location and then pass that to the kernel. In other words, this is
option is specific for sframe and not ELF. I rather call it by that.

> 
> If there are other file types in the future that happen to contain an
> sframe section (but are not ELF), then we can simply add a new label to
> enum code_opt.
> 
> >   
> >>
> >> sys_codectl(2)
> >> =================
> >>
> >> * arg0: unsigned int @option:
> >>
> >> /* Additional labels can be added to enum code_opt, for extensibility. */
> >>
> >> enum code_opt {
> >>       CODE_REGISTER_ELF,  
> > 
> > Perhaps the above should be: CODE_REGISTER_SFRAME,
> > 
> > as currently SFrame is read only via files.  
> 
> As I pointed out above, on GNU/Linux, sframe is always an allocated,loaded
> ELF section. AFAIU, your comment implies that we'd want to support other scenarios
> where the sframe is in files outside of elf binary sframe sections. Can you
> expand on the use-case you have for this, or is it just for future-proofing ?

Heh, I just did above (before reading this). But yeah, it could be. As I
mentioned above, this is not about ELF files. Sframes just happen to be in
an ELF file. CODE_REGISTER_ELF sounds like this is for doing special
actions to an ELF file, when in reality it is doing special actions to tell
the kernel this is an sframe table. It just happens that sframes are in
ELF. Let's call it for what it is used for.

> 
> >   
> >>       CODE_REGISTER_JIT,  
> > 
> >  From our other conversations, JIT will likely be a completely different
> > format than SFRAME, so calling it just JIT should be fine.  
> 
> OK
> 
> > 
> >   
> >>       CODE_UNREGISTER,  
> > 
> > I wonder if this should be the first enum. That is, "0" is to unregister.
> > 
> > That way, all non-zero options will be for what is being registered, and
> > "0" is for unregistering any of them.  
> 
> Good idea, I'll do that.
> 
> > 
> >   
> >> };
> >>
> >> * arg1: void * @info
> >>
> >> /* if (@option == CODE_REGISTER_ELF) */
> >>
> >> /*
> >>    * text_start, text_end, sframe_start, sframe_end allow unwinding of the
> >>    * call stack.
> >>    *
> >>    * elf_start, elf_end, pathname, and either build_id or debug_link allows
> >>    * mapping instruction pointers to file, symbol, offset, and source file
> >>    * location.
> >>    */
> >> struct code_elf_info {
> >> :   __u64 elf_start;
> >>       __u64 elf_end;  
> > 
> > Perhaps:
> > 
> > 	__u64 file_start;
> > 	__u64 file_end;
> > 
> > ?
> > 
> > And call it "struct code_sframe_info"
> >   
> >>       __u64 text_start;
> >>       __u64 text_end;  
> >   
> >>       __u64 sframe_start;
> >>       __u64 sframe_end;  
> > 
> > What is the above "sframe" for?

Still wondering what the above is for.

> >   
> >>       __u64 pathname;              /* char *, NULL if unavailable. */
> >>
> >>       __u64 build_id;              /* char *, NULL if unavailable. */
> >>       __u64 debug_link_pathname;   /* char *, NULL if unavailable. */  
> > 
> > Maybe just list the above three as "optional" ?  
> 
> This is what I had in mind with "NULL if unavailable", but I can clarify
> them as being "optional" in the comment.
> 
> Do you envision that the sizeof(struct code_elf_info) could be smaller
> and not include the optional fields, or just specifying them as NULL if
> unavailable is enough ?

Hmm, are we going to allow this structure to expand? Should we give it a
size. Or just state that different options could have different sizes (and
make this more of a union than a structure).

> 
> > 
> > It may be available, but the implementer just doesn't want to implement it.
> >   
> >>       __u32 build_id_len;
> >>       __u32 debug_link_crc;
> >> };
> >>
> >>
> >> /* if (@option == CODE_REGISTER_JIT) */
> >>
> >> /*
> >>    * Registration of sorted JIT unwind table: The reserved memory area is
> >>    * of size reserved_len. Userspace increases used_len as new code is
> >>    * populated between text_start and text_end. This area is populated in
> >>    * increasing address order, and its ABI requires to have no overlapping
> >>    * fre. This fits the common use-case where JITs populate code into
> >>    * a given memory area by increasing address order. The sorted unwind
> >>    * tables can be chained with a singly-linked list as they become full.
> >>    * Consecutive chained tables are also in sorted text address order.
> >>    *
> >>    * Note: if there is an eventual use-case for unsorted jit unwind table,
> >>    * this would be introduced as a new "code option".
> >>    */
> >>
> >> struct code_jit_info {
> >>       __u64 text_start;      /* text_start >= addr */
> >>       __u64 text_end;        /* addr < text_end */
> >>       __u64 unwind_head;     /* struct code_jit_unwind_table * */
> >> };
> >>
> >> struct code_jit_unwind_fre {
> >>       /*
> >>        * Contains info similar to sframe, allowing unwind for a given
> >>        * code address range.
> >>        */
> >>       __u32 size;
> >>       __u32 ip_off;  /* offset from text_start */
> >>       __s32 cfa_off;
> >>       __s32 ra_off;
> >>       __s32 fp_off;
> >>       __u8 info;
> >> };
> >>
> >> struct code_jit_unwind_table {
> >>       __u64 reserved_len;
> >>       __u64 used_len; /*
> >>                        * Incremented by userspace (store-release), read by
> >>                        * the kernel (load-acquire).
> >>                        */
> >>       __u64 next;     /* Chain with next struct code_jit_unwind_table. */
> >>       struct code_jit_unwind_fre fre[];
> >> };  
> > 
> > I wonder if we should avoid the "jit" portion completely for now until we
> > know what exactly we need.  
> 
> I don't want to spend too much discussion time on the jit portion at this stage,
> but I think it's good to keep this in mind so we come up with an ABI that will
> naturally extend to cover that use case. I favor keeping the JIT portion in these
> discussions but not implement it initially.

As long as the structure is flexible to handle this. We could even add the
JIT enum, but return -EINVAL (or whatever) if it is used to state that it's
not currently implemented.

-- Steve

