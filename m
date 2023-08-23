Return-Path: <bpf+bounces-8349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EA17854AD
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 11:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64962812DF
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A06FAD26;
	Wed, 23 Aug 2023 09:54:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3762A946
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 09:54:58 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 442482130;
	Wed, 23 Aug 2023 02:54:52 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1ACAC2127C62;
	Wed, 23 Aug 2023 02:54:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1ACAC2127C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1692784492;
	bh=HjJsepE5OpDXA/4yFSlmoJDdIBkq291o4bLrlkb/X2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2HEdjShFUhbJ5yW+tQKD58fM3ZGyAPJ8FHAw7hTERIXo60s5dNw384UlgHz/2h/2
	 wzrEH2f4dSNPV6u35TKRSF4QwAWHWy3lBpiMKq9b103tnwiXy6Es/f3UlLQMU/qEx6
	 IdxOLBS2oCBM8tasF9PzKrcdCnmhhW9t72JSlic4=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for 'perf_kprobe' PMU
Date: Wed, 23 Aug 2023 11:54:48 +0200
Message-ID: <5964493.lOV4Wx5bFT@pwmachine>
In-Reply-To: <20230823093614.fd704a98387d0ba1d23a29fb@kernel.org>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com> <2237127.iZASKD2KPV@pwmachine> <20230823093614.fd704a98387d0ba1d23a29fb@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi.

Le mercredi 23 ao=FBt 2023, 02:36:14 CEST Masami Hiramatsu a =E9crit :
> Hi,
>=20
> On Mon, 21 Aug 2023 14:55:14 +0200
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > Could you tell me how do you use this feature, for what perpose?
> >=20
> > Sure (I think I detailed this in the cover letter but I only sent it to
> > the
> > "main" mailing list and not the tracing one, sorry for this
> > inconvenience)!
> >=20
> > Basically, I was adding NTFS tracing to an existing tool which monitors
> > slow I/Os using BPF [1].
> > To test the tool, I compiled a kernel with both NTFS module built-in and
> > figured out the write operations when done on ntfs3 were missing from t=
he
> > output of the tool.
> > The problem comes from the library I use in the tool which does not han=
dle
> > well when it exists different symbols with the same name.
> > Contrary to perf, which only handles kprobes through sysfs, the library
> > handles it in both way (sysfs and PMU) with a preference for PMU when
> > available [2].
> >=20
> > After some discussion, I thought there could be a way to handle this
> > automatically in the kernel when using PMU kprobes, hence this patch.
> > I totally understand the case I described above is really a corner one,
> > but I thought this feature could be useful for other people.
> > In the case of the library itself, we could indeed find the address in
> > /proc/ kallsyms but it would mean having CAP_SYS_ADMIN which is not
> > forcefully something we want to enforce.
> > Also, if we need to read /boot/vmlinuz or /boot/System.map we also need=
 to
> > be root as these files often belong to root and cannot be read by other=
s.
> > So, this patch solves the above problem while not needing specific
> > capabilities as the kernel will solve it for us.
>=20
> Thanks for the explanation. I got the background, and still have some
> questions.
>=20
> - Is the analysis tool really necessary to be used by users other than
>   CAP_SYS_ADMIN? Even if it is useful, I still doubt CAP_PERFMON is safer
>   than CAP_SYS_ADMIN, because BPF program can access any kernel register.

=46or the tool itself, this is indeed not a problem as we rely on CAP_SYS_A=
DMIN.
But this one for the library, as they do not want to enforce CAP_SYS_ADMIN =
to=20
use the library.

> - My concern about this solution (enabling kprobe PMU on all symbols which
>   have the same name) makes it hard to run the same BPF program on it.
>   This is because symbols with the same name do not necessarily have the
>   same arguments (theoretically). Also, the BPF will trace unwanted symbo=
ls
>   at unwanted timing.

Good point for the same name but different arguments!
I was too focused on my case (ntfs_file_write_iter()) and forgot about this.

> - Can you expand that library to handle the same name symbols differently?
>   I think this should be done in the user space, or in the kallsyms like
>   storing symbols with source line information.

I think we can find a way to handle this in user space by potentially=20
abstracting the several PMU probe under one.
Or we can simply explode if a name correspond to several symbols and ask th=
e=20
user to use addr + offset to precise the symbol in this case.

> I understand this demand, but solving that with probing *all* symbols see=
ms
> like a brute force solution and may cause another problem later.
>=20
> But this is a good discussion item. Last month Alessandro sent a script
> which makes such symbols unique. Current problem is that the numbering is
> not enough to identify which one is from which source code.

Definitely, I wrote this specifically to create a discussion and gather som=
e=20
comments, hence the RFC tag.

> https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carminati=
@gm
> ail.com/

I will definitely take a look at this contribution! Thank you for sharing t=
he=20
link!

> > > If you just need to trace/profile a specific function which has the s=
ame
> > > name symbols, you might be better to use `perf probe` +
> > > `/sys/kernel/tracing` or `perf record -e EVENT`.
> > >=20
> > > Or if you need to run it with CAP_PERFMON, without CAP_SYS_ADMIN,
> > > we need to change a userspace tool to find the correct address and
> > > pass it to the perf_event_open().
> > >=20
> > > > > > Added new events:
> > > > > >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> > > > > >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> > > > > >=20
> > > > > > You can now use it in all perf tools, such as:
> > > > > >         perf record -e probe:ntfs_file_write_iter -aR sleep 1
> > > > > >=20
> > > > > > root@vm-amd64:~# cat /sys/kernel/tracing/kprobe_events
> > > > > > p:probe/ntfs_file_write_iter _text+5088544
> > > > > > p:probe/ntfs_file_write_iter _text+5278560
> > > > > >=20
> > > > > > > Thought?
> > > > > >=20
> > > > > > This contribution is basically here to sort of mimic what perf
> > > > > > does
> > > > > > but
> > > > > > with PMU kprobes, as this is not possible to write in a sysfs f=
ile
> > > > > > with
> > > > > > this type of probe.
> > > > >=20
> > > > > OK, I see it is for BPF only. Maybe BPF program can filter correct
> > > > > one
> > > > > to access the argument etc.
> > > >=20
> > > > I am not sure I understand, can you please precise?
> > > > The eBPF program will be run when the kprobe will be triggered, so =
if
> > > > the
> > > > kprobe is armed for the function (e.g. old ntfs_file_write_iter()),
> > > > the
> > > > eBPF program will never be called.
> > >=20
> > > As I said above, it is userspace BPF loader issue, because it has to
> > > specify the correct address via unique symbol + offset, instead of
> > > attaching all of them. I think that will be more side-effects.
> > >=20
> > > But anyway, thanks for pointing this issue. I should fix kprobe event=
 to
> > > reject the symbols which is not unique. That should be pointed by oth=
er
> > > unique symbols.
> >=20
> > You are welcome and I thank you for the discussion.
> > Can you please precise more what you think about "reject the symbols wh=
ich
> > is not unique"?
>=20
> > Basically something like this:
> Yes, that's what I said.

OK, I will write something and send it as an RFC before end of the week the=
n.

> > struct trace_event_call *
> > create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> >=20
> > 			  bool is_return)
> >=20
> > {
> >=20
> > 	...
> > 	if (!addr && func) {
>=20
> if (func) {  /* because anyway if user specify "func" we have to solve
>  the symbol address */
>=20
> > 		array.addrs =3D NULL;
> > 		array.size =3D 0;
> > 		ret =3D kallsyms_on_each_match_symbol(add_addr, func, &array);
> > 		if (ret)
> > 	=09
> > 			goto error_free;
> > 	=09
> > 		if (array.size !=3D 1) {
> > 	=09
> > 			/*
> > 		=09
> > 			 * Function name corresponding to several symbols must
> > 			 * be passed by address only.
> > 			 */
> > 		=09
> > 			return -EINVAL;
>=20
> This case may return a unique error code so that the caller can notice
> the problem.

Is it OK to add a dedicated error code for such a case?

> Thank you,
>=20
> > 		}
> > =09
> > 	}
> > =09
> > =09
> > =09
> > 	...
> >=20
> > }
> > ?
> > If my understanding is correct, I think I can write a patch to achieve
> > this.
> >=20
> >=20
> >=20
> > Best regards.
> > ---
> > [1]: https://github.com/inspektor-gadget/inspektor-gadget/pull/1879
> > [2]: https://github.com/cilium/ebpf/blob/
> > 270c859894bd38cdd0c7783317b16343409e4df8/link/kprobe.go#L165-L191

Best regards.



