Return-Path: <bpf+bounces-66048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DA1B2CF4B
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 00:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315877A2DC6
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 22:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2872C3054C8;
	Tue, 19 Aug 2025 22:21:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A1335336D;
	Tue, 19 Aug 2025 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755642100; cv=none; b=r2Zbjwwy7HITc/dyOosTpX+YqVB0dmF8YGJENe+ADxRFNjXaX+sl1usQmSXAM6BLZtLztFy8eWeiXjY9f54X+wvvNiHf2pgXrWU1ZmJXnhEXN+A3xVgkQ8Jmf22LdZpZ2sjgTrdnxAUYtI1IEDVUfDxuclcsX8abWUtl1j6Gvfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755642100; c=relaxed/simple;
	bh=OaHqnK4SM+62NqJObhRTVXyn+tku4vkJG7T/kN0YkBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4xJM+ucVtdmKXf+In9oC3G8R1lr+3vRFPfLkrZO1L/70Jc9LqP3Wzl/hDnHf/ULuQW7NoYpoZkBqoqFVm0FNmy9HWUyLJT/kzUucgZDrTtWRQ4BULRZE7X4ZX4/JJfUThkzj+KIBO+l12nV42PJHOIDe+aACgdP8DnFb4XvFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 625BB1A028A;
	Tue, 19 Aug 2025 22:21:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 5FDC020027;
	Tue, 19 Aug 2025 22:21:30 +0000 (UTC)
Date: Tue, 19 Aug 2025 18:21:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sven Schnelle
 <svens@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
 <guoren@kernel.org>, Donglin Peng <dolinux.peng@gmail.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <20250819182130.75542133@gandalf.local.home>
In-Reply-To: <aJ4XX4qvHUZRAFxF@lappy>
References: <20250227185804.639525399@goodmis.org>
	<20250227185822.810321199@goodmis.org>
	<aJaxRVKverIjF4a6@lappy>
	<20250813195317.508a29aa@batman.local.home>
	<aJ4XX4qvHUZRAFxF@lappy>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: rm9m5eaexz9psrnybmuf4giddgf68yoh
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 5FDC020027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18UWLhG6lR5gnGcqtpRxu3dqcuTBJ3MHmc=
X-HE-Tag: 1755642090-461516
X-HE-Meta: U2FsdGVkX1+1IQY6vNHRd8PBIspV1OX3DKLcWXU9YRxobNXQZrad95sUTl0f6PhjDzNXpvYPSdLKFnSRi7ore8tp92lDK5ojzcHsXhf21nmO+dIb9tx0bnIdWRmY+z+WSoLKGMgo/4w/eY92LAp+04ftbmVfKGirDVUnEwYou5eiuNFhs5JKmGwuT4rHmefXZVaGMAFqKjgKMiHhorqR0xBihewp4Mhl5nqfr1+1c874VMT7VzXO4AePpjNub8WDRf4uAaso+wvwNrFMhuqmP12eKkD1AnQjNnk9FC1GbbERFfgKR4tr7dRaEsMK952ujY7QI/ew84Q9R174Hcx8Q/s/KAT5tgLA

On Thu, 14 Aug 2025 13:05:35 -0400
Sasha Levin <sashal@kernel.org> wrote:

> On Wed,=20
> Got a small build error:
>=20
> kernel/trace/trace_functions_graph.c: In function =E2=80=98get_return_for=
_leaf=E2=80=99:
> ./include/linux/stddef.h:16:33: error: =E2=80=98struct fgraph_retaddr_ent=
_entry=E2=80=99 has no member named =E2=80=98args=E2=80=99
>     16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>        |                                 ^~~~~~~~~~~~~~~~~~
> kernel/trace/trace_functions_graph.c:640:40: note: in expansion of macro =
=E2=80=98offsetof=E2=80=99
>    640 |                                 size =3D offsetof(struct fgraph_=
retaddr_ent_entry, args);
>        |                                        ^~~~~~~~
>=20
> Does this look right on top of your patch:

Bah, it was on the todo list to add args to retaddr. But it never was done.

>=20
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_fu=
nctions_graph.c
> index 25ea71edb8da..f0f37356ef29 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -637,20 +637,21 @@ get_return_for_leaf(struct trace_iterator *iter,
>                           */
>                          if (unlikely(curr->ent.type =3D=3D TRACE_GRAPH_R=
ETADDR_ENT)) {
>                                  data->ent.rent =3D *(struct fgraph_retad=
dr_ent_entry *)curr;
> -                               size =3D offsetof(struct fgraph_retaddr_e=
nt_entry, args);
> +                               /* fgraph_retaddr_ent_entry doesn't have =
args field */

"doesn't have args field" yet!

> +                               size =3D sizeof(struct fgraph_retaddr_ent=
_entry);
> +                               args_size =3D 0;
>                          } else {
>                                  data->ent.ent =3D *curr;
>                                  size =3D offsetof(struct ftrace_graph_en=
t_entry, args);
> +                               /* If this has args, then append them to =
after the ent. */
> +                               args_size =3D iter->ent_size - size;
> +                               if (args_size > sizeof(long) * FTRACE_REG=
S_MAX_ARGS)
> +                                       args_size =3D sizeof(long) * FTRA=
CE_REGS_MAX_ARGS;
> +
> +                               if (args_size >=3D sizeof(long))
> +                                       memcpy((void *)&data->ent.ent + s=
ize,
> +                                              (void*)curr + size, args_s=
ize);
>                          }

Here's a different update:

-- Steve


diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_func=
tions_graph.c
index 66e1a527cf1a..a7f4b9a47a71 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -27,14 +27,21 @@ struct fgraph_cpu_data {
 	unsigned long	enter_funcs[FTRACE_RETFUNC_DEPTH];
 };
=20
+struct fgraph_ent_args {
+	struct ftrace_graph_ent_entry	ent;
+	/* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS entries */
+	unsigned long			args[FTRACE_REGS_MAX_ARGS];
+};
+
 struct fgraph_data {
 	struct fgraph_cpu_data __percpu *cpu_data;
=20
 	/* Place to preserve last processed entry. */
 	union {
-		struct ftrace_graph_ent_entry	ent;
+		struct fgraph_ent_args		ent;
+		/* TODO allow retaddr to have args */
 		struct fgraph_retaddr_ent_entry	rent;
-	} ent;
+	};
 	struct ftrace_graph_ret_entry	ret;
 	int				failed;
 	int				cpu;
@@ -627,10 +634,13 @@ get_return_for_leaf(struct trace_iterator *iter,
 			 * Save current and next entries for later reference
 			 * if the output fails.
 			 */
-			if (unlikely(curr->ent.type =3D=3D TRACE_GRAPH_RETADDR_ENT))
-				data->ent.rent =3D *(struct fgraph_retaddr_ent_entry *)curr;
-			else
-				data->ent.ent =3D *curr;
+			if (unlikely(curr->ent.type =3D=3D TRACE_GRAPH_RETADDR_ENT)) {
+				data->rent =3D *(struct fgraph_retaddr_ent_entry *)curr;
+			} else {
+				int size =3D min((int)sizeof(data->ent), (int)iter->ent_size);
+
+				memcpy(&data->ent, curr, size);
+			}
 			/*
 			 * If the next event is not a return type, then
 			 * we only care about what type it is. Otherwise we can


