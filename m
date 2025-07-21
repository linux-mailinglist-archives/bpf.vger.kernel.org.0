Return-Path: <bpf+bounces-63934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9750CB0CAB4
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 20:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B561AA577B
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EF421FF46;
	Mon, 21 Jul 2025 18:53:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B887DDDC3;
	Mon, 21 Jul 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124003; cv=none; b=b3vV7THlT0MHFaE7T90kyfsb7CecBc0TL+N/s1+sv7hd0D5jc7NeSGoZmoXYMTCjyhLktu4G0XRJ6xDilRDO2d/ObJZu1igXUGDbwli/tgFcUIT2SZTEQogokDejNb/y8S7p/b+eA5V/+Ykg8O87XUmWB+zd/Al6AmmQ1XL5NP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124003; c=relaxed/simple;
	bh=X7ohL0l9JcoXzthoLsppaS0fdOu+yELUNFlMzVZzJZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BESiQb3Tn88JbPRI3qBgW2LzrPqAH1zyh9VbijFqeAnDHge81MgyKZRHbNJXHbmnoAoJrAwvHhfyL2rVp+Kg7e/3JcTrMR31zwQFglVYE/tPb+/x51xvbt3fdDe1NNcp0FJ5kHCO6BzN13mnwcfruGgin7P4tKx62jz+5v8fGRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id AB4F61A0198;
	Mon, 21 Jul 2025 18:53:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id E380A20028;
	Mon, 21 Jul 2025 18:53:12 +0000 (UTC)
Date: Mon, 21 Jul 2025 14:53:43 -0400
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
Message-ID: <20250721145343.5d9b0f80@gandalf.local.home>
In-Reply-To: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 3wfbsfszaepa8icypym6eij1phb5h9hu
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E380A20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/uxOdSyTbUbm9DRBoc2ZPS52vmSLxAVSI=
X-HE-Tag: 1753123992-811885
X-HE-Meta: U2FsdGVkX18hrS6Pkp3rZXlCB33Q6moaQMnuDps3pNGqs/WF0WjwKGQZvXnZUbPTOfG6czkHAzfpZ5tn27Srto+2k4D1Uuda9KXzsf+1Vod7zna3HAFza9rKDX+w9fDOj58cOvMfotfhwhH1zdp+XDgTnfKlcEfk5LTTNyV2S064E2KypM3hQSqyXmGExuWaT/N535Jm2psMjZlez/DOQR9vGActZmte81pOu5/cBw6pHDj2O4A3Lu5WfEo6/JrC0sHF65KOR4wEr9HkJL44LWLUKAzySZSVF83YX9up/F8eYUtv1hMCIjJ1l4YcoyY9e4GvMVSH6F22iGzTejA1sPXCUvmfWfpHegJk72grMNd0YF07Kj8uJCQwH8n5vXMA8CcuiV9N5pxu/tiCHpTvfiwoy94QIes7zeCYcDgNVZLN1P9WVpzmyD91fkLUXs/E

On Mon, 21 Jul 2025 11:20:34 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Hi!
>=20
> I've written up an RFC for a new system call to handle sframe registration
> for shared libraries. There has been interest to cover both sframe in
> the short term, but also JIT use-cases in the long term, so I'm
> covering both here in this RFC to provide the full context. Implementation
> wise we could start by only covering the sframe use-case.
>=20
> I've called it "codectl(2)" for now, but I'm of course open to feedback.

Hmm, I guess I'm OK with that name. I can't really think of anything that
would be better. But kernel developers are notorious for sucking at coming
up with decent names ;-)

>=20
> For ELF, I'm including the optional pathname, build id, and debug link
> information which are really useful to translate from instruction pointers
> to executable/library name, symbol, offset, source file, line number.
> This is what we are using in LTTng-UST and Babeltrace debug-info filter
> plugin [1], and I think this would be relevant for kernel tracers as well
> so they can make the resulting stack traces meaningful to users.

Honestly, I'm not sure it needs to be an ELF file. Just a file that has an
sframe section in it.

>=20
> sys_codectl(2)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * arg0: unsigned int @option:
>=20
> /* Additional labels can be added to enum code_opt, for extensibility. */
>=20
> enum code_opt {
>      CODE_REGISTER_ELF,

Perhaps the above should be: CODE_REGISTER_SFRAME,

as currently SFrame is read only via files.

>      CODE_REGISTER_JIT,

=46rom our other conversations, JIT will likely be a completely different
format than SFRAME, so calling it just JIT should be fine.


>      CODE_UNREGISTER,

I wonder if this should be the first enum. That is, "0" is to unregister.

That way, all non-zero options will be for what is being registered, and
"0" is for unregistering any of them.


> };
>=20
> * arg1: void * @info
>=20
> /* if (@option =3D=3D CODE_REGISTER_ELF) */
>=20
> /*
>   * text_start, text_end, sframe_start, sframe_end allow unwinding of the
>   * call stack.
>   *
>   * elf_start, elf_end, pathname, and either build_id or debug_link allows
>   * mapping instruction pointers to file, symbol, offset, and source file
>   * location.
>   */
> struct code_elf_info {
> :   __u64 elf_start;
>      __u64 elf_end;

Perhaps:

	__u64 file_start;
	__u64 file_end;

?

And call it "struct code_sframe_info"

>      __u64 text_start;
>      __u64 text_end;

>      __u64 sframe_start;
>      __u64 sframe_end;

What is the above "sframe" for?

>      __u64 pathname;              /* char *, NULL if unavailable. */
>=20
>      __u64 build_id;              /* char *, NULL if unavailable. */
>      __u64 debug_link_pathname;   /* char *, NULL if unavailable. */

Maybe just list the above three as "optional" ?

It may be available, but the implementer just doesn't want to implement it.

>      __u32 build_id_len;
>      __u32 debug_link_crc;
> };
>=20
>=20
> /* if (@option =3D=3D CODE_REGISTER_JIT) */
>=20
> /*
>   * Registration of sorted JIT unwind table: The reserved memory area is
>   * of size reserved_len. Userspace increases used_len as new code is
>   * populated between text_start and text_end. This area is populated in
>   * increasing address order, and its ABI requires to have no overlapping
>   * fre. This fits the common use-case where JITs populate code into
>   * a given memory area by increasing address order. The sorted unwind
>   * tables can be chained with a singly-linked list as they become full.
>   * Consecutive chained tables are also in sorted text address order.
>   *
>   * Note: if there is an eventual use-case for unsorted jit unwind table,
>   * this would be introduced as a new "code option".
>   */
>=20
> struct code_jit_info {
>      __u64 text_start;      /* text_start >=3D addr */
>      __u64 text_end;        /* addr < text_end */
>      __u64 unwind_head;     /* struct code_jit_unwind_table * */
> };
>=20
> struct code_jit_unwind_fre {
>      /*
>       * Contains info similar to sframe, allowing unwind for a given
>       * code address range.
>       */
>      __u32 size;
>      __u32 ip_off;  /* offset from text_start */
>      __s32 cfa_off;
>      __s32 ra_off;
>      __s32 fp_off;
>      __u8 info;
> };
>=20
> struct code_jit_unwind_table {
>      __u64 reserved_len;
>      __u64 used_len; /*
>                       * Incremented by userspace (store-release), read by
>                       * the kernel (load-acquire).
>                       */
>      __u64 next;     /* Chain with next struct code_jit_unwind_table. */
>      struct code_jit_unwind_fre fre[];
> };

I wonder if we should avoid the "jit" portion completely for now until we
know what exactly we need.

Thanks,

-- Steve


>=20
> /* if (@option =3D=3D CODE_UNREGISTER) */
>=20
> void *info
>=20
> * arg2: size_t info_size
>=20
> /*
>   * Size of @info structure, allowing extensibility. See
>   * copy_struct_from_user().
>   */
>=20
> * arg3: unsigned int flags (0)
>=20
> /* Flags for extensibility. */
>=20
> Your feedback is welcome,
>=20
> Thanks,
>=20
> Mathieu
>=20
> [1] https://babeltrace.org/docs/v2.0/man7/babeltrace2-filter.lttng-utils.=
debug-info.7/
>=20


