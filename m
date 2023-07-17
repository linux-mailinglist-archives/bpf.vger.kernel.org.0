Return-Path: <bpf+bounces-5143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E9D756FF1
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 00:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0386B1C20BD0
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78EA1118C;
	Mon, 17 Jul 2023 22:42:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79038C2DB
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 22:42:40 +0000 (UTC)
X-Greylist: delayed 488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 15:42:31 PDT
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ED5170A;
	Mon, 17 Jul 2023 15:42:31 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D40B71A05CE;
	Mon, 17 Jul 2023 22:34:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 68AEC2002D;
	Mon, 17 Jul 2023 22:34:15 +0000 (UTC)
Message-ID: <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
Subject: Re: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of
 RCU Tasks Trace
From: Joe Perches <joe@perches.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
  Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>,  bpf@vger.kernel.org
Date: Mon, 17 Jul 2023 15:34:14 -0700
In-Reply-To: <20230717180454.1097714-5-paulmck@kernel.org>
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
	 <20230717180454.1097714-5-paulmck@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 68AEC2002D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout02
X-Stat-Signature: ydqcdtaadgq3km87eotg8j8pd3mh6b44
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX199v8b1YJAszH97EHPUzWOIn/skmRIxrWs=
X-HE-Tag: 1689633255-124912
X-HE-Meta: U2FsdGVkX18q26xURpW9+7yIL42BuR4Zkw3canI6Q+OaBoEjxOlN4sWO2r2VSPNWSpmqVT2U5xjk7hqFilI04qYOR0SfI2y77lfk9KiC3ksoCTNcalQJLUoOAbm22blsjRiMqKOOFrUtlbPz6p8+1d3RDEZbL/cNxlrRGIfcABTMjv3YW1yQx0HxurQICyXOXY9236m5b8jXkMAeP0DYKYxDMi65GeHRr0wfvh9DCQC0GClucM3KkPEVsRmbrk7JhWDR+6wyGr+fOq244GpBh558PLQ5RW7Lww8erKmNSkQT7MZpMM4KYity//XXO3qESACljOpJ+E3tdzooYjEbv8kH5JOZyxBEuVOEoeG832GISOUxT7dNW0VHoYb0GJ3O0Dfry58QH0V6GhebW2QhLmXhRMKWe3CIv9dyqT1ngG8zSlaC0dQSWlqxxIoWa3U7y2SNQ0Y7BcNEzDK9dcTvxzLAnjtAsIMeLRs+sbYfkB4NOOwrQ9nSYcmJO+ZB5L1M6UpJzh3c0UzxOi/2KW/ZI41TxOlm/8dRVG1Z+KpHLl8U10glR/PgjHnG7cFTil2GKT2UWE5WrRo=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-17 at 11:04 -0700, Paul E. McKenney wrote:
> RCU Tasks Trace is quite specialized, having been created specifically
> for sleepable BPF programs.  Because it allows general blocking within
> readers, any new use of RCU Tasks Trace must take current use cases into
> account.  Therefore, update checkpatch.pl to complain about use of any of
> the RCU Tasks Trace API members outside of BPF and outside of RCU itself.
>=20
> Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
> Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com> (reviewer:CHECKPATCH)
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: <bpf@vger.kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  scripts/checkpatch.pl | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7457,6 +7457,24 @@ sub process {
>  			}
>  		}
> =20
> +# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU=
).
> +		if ($line =3D~ /\brcu_read_lock_trace\s*\(/ ||
> +		    $line =3D~ /\brcu_read_lock_trace_held\s*\(/ ||
> +		    $line =3D~ /\brcu_read_unlock_trace\s*\(/ ||
> +		    $line =3D~ /\bcall_rcu_tasks_trace\s*\(/ ||
> +		    $line =3D~ /\bsynchronize_rcu_tasks_trace\s*\(/ ||
> +		    $line =3D~ /\brcu_barrier_tasks_trace\s*\(/ ||
> +		    $line =3D~ /\brcu_request_urgent_qs_task\s*\(/) {
> +			if ($realfile !~ m@^kernel/bpf@ &&
> +			    $realfile !~ m@^include/linux/bpf@ &&
> +			    $realfile !~ m@^net/bpf@ &&
> +			    $realfile !~ m@^kernel/rcu@ &&
> +			    $realfile !~ m@^include/linux/rcu@) {

Functions and paths like these tend to be accreted.

Please use a variable or 2 like:

our $rcu_trace_funcs =3D qr{(?x:
	rcu_read_lock_trace |
	rcu_read_lock_trace_held |
	rcu_read_unlock_trace |
	call_rcu_tasks_trace |
	synchronize_rcu_tasks_trace |
	rcu_barrier_tasks_trace |
	rcu_request_urgent_qs_task
)};
our $rcu_trace_paths =3D qr{(?x:
	kernel/bfp/ |
	include/linux/bpf |
	net/bpf/ |
	kernel/rcu/ |
	include/linux/rcu
)};

...
=09
		if ($line =3D~ /\b($rcu_trace_funcs)\s*\(/ &&
		    $realfile !~ m{^$rcu_trace_paths}) {
			WARN("RCU_TASKS_TRACE",
			     "use of RCU tasks trace '$1' is incorrect outside BPF or core RCU c=
ode\n" . $herecurr);			}
		}



