Return-Path: <bpf+bounces-5580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853E775BD73
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 06:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77D71C21603
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 04:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A629656;
	Fri, 21 Jul 2023 04:39:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695B802
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 04:39:27 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4904D273C;
	Thu, 20 Jul 2023 21:39:01 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id BD4D612012D;
	Fri, 21 Jul 2023 04:38:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 5315C2E;
	Fri, 21 Jul 2023 04:38:52 +0000 (UTC)
Message-ID: <be08b429164e18b70f8341eab3deb075fc8b63b4.camel@perches.com>
Subject: Re: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of
 RCU Tasks Trace
From: Joe Perches <joe@perches.com>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
  rostedt@goodmis.org, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Date: Thu, 20 Jul 2023 21:38:51 -0700
In-Reply-To: <c0ca3071-231a-49b1-b153-38ff0328470d@paulmck-laptop>
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
	 <20230717180454.1097714-5-paulmck@kernel.org>
	 <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
	 <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
	 <589412dd594b7efc618728fe68ad6c86f3c60878.camel@perches.com>
	 <798959b0-b107-44c4-8262-075930ebfeaa@paulmck-laptop>
	 <c0ca3071-231a-49b1-b153-38ff0328470d@paulmck-laptop>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5315C2E
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: zq46css7dks6o8yhj8hrd7y6bptxohp5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+5xXj83YKHor2G47+awlxQmgdqpcoeN8k=
X-HE-Tag: 1689914332-372370
X-HE-Meta: U2FsdGVkX19C7F6Fql0Q3oAwHQE+xh5l90Ob83AJnEJ+fJHYNBiwUCzHrswoKK499ZIlqGCSEEvKBYE4ViKQMcG1xbyhSlb1byHn31rXTeijwRcVuEUFvOiT64RaInnk2gNskWCA5fXeI9oHowKIg5ZCniYfk/XqVqJRYAo7RAgLgWB00Ut+UQeQeYNpS/1lDZoOMmNPio+H4rqQTKbopFSEiwROaAn7lZmdnZzBimoYLrCwTVbhhbUOpY5UsaVTANTlChm5VCaDq0ew5/pM8uk6ug7JDpLL3M31zlbthM1xDZAvrj3lp5UDKQejYW4Yp5il5ALXDuH2iPNKd3H/wiMUcVWT3kZSv2UJCIsLroNquFam1sZD1GhRF5XVuXxj
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-07-20 at 20:56 -0700, Paul E. McKenney wrote:

>=20
> > That works much better, thank you!  I will update the patch on my
> > next rebase.
>=20
> As shown below.  Is this what you had in mind?
[]
> commit 496aa3821b40459b107f4bbc14ca867daad21fb6
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Jul 6 11:48:07 2023 -0700
>=20
>     checkpatch: Complain about unexpected uses of RCU Tasks Trace
>    =20
>     RCU Tasks Trace is quite specialized, having been created specificall=
y
>     for sleepable BPF programs.  Because it allows general blocking withi=
n
>     readers, any new use of RCU Tasks Trace must take current use cases i=
nto
>     account.  Therefore, update checkpatch.pl to complain about use of an=
y of
>     the RCU Tasks Trace API members outside of BPF and outside of RCU its=
elf.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7457,6 +7457,30 @@ sub process {
>  			}
>  		}
> =20
> +# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU=
).
> +		our $rcu_trace_funcs =3D qr{(?x:
> +			rcu_read_lock_trace |
> +			rcu_read_lock_trace_held |
> +			rcu_read_unlock_trace |
> +			call_rcu_tasks_trace |
> +			synchronize_rcu_tasks_trace |
> +			rcu_barrier_tasks_trace |
> +			rcu_request_urgent_qs_task
> +		)};
> +		our $rcu_trace_paths =3D qr{(?x:
> +			kernel/bpf/ |
> +			include/linux/bpf |
> +			net/bpf/ |
> +			kernel/rcu/ |
> +			include/linux/rcu
> +		)};
> +		if ($line =3D~ /\b$rcu_trace_funcs\s*\(/) {
> +			if ($realfile !~ m@^$rcu_trace_paths@) {
> +				WARN("RCU_TASKS_TRACE",
> +				     "use of RCU tasks trace is incorrect outside BPF or core RCU co=
de\n" . $herecurr);

Exactly yes.

(though I still suggest a capture group to show the function like below)

		if ($line =3D~ /\b($rcu_trace_funcs)\s*\(/ &&
		    $realfile !~ m{^$rcu_trace_paths}) {
			WARN("RCU_TASKS_TRACE",
			     "use of RCU task trace '$1' is incorrect outside BPF or core RCU co=
de\n" . $herecurr);
		}



