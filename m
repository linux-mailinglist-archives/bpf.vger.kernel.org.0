Return-Path: <bpf+bounces-8157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D416078299F
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 14:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C05280E87
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12F86ABB;
	Mon, 21 Aug 2023 12:55:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618706ABA
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:55:21 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32777CC;
	Mon, 21 Aug 2023 05:55:19 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F0AA211FA3A;
	Mon, 21 Aug 2023 05:55:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F0AA211FA3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1692622518;
	bh=JyeNce4iuVqX6fxwN+HHZhFX3v9kBJRYNwGEqJm6r1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUpzZAZMlI/qd8VSnIZn76AfbjbDmBcL3sPttR0aA/zngfM/G26Osny2hTVe7RChs
	 V8i5rBoV4qqiGuUjAA4tULu+KVMmXMvaY1Ev5HF0nGoKQ91qOztVuIVDNNNXY4Xkxi
	 WGRGoHCn1nw9uSYlPadTp74uGaMskQRFjhp51Dl4=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for 'perf_kprobe' PMU
Date: Mon, 21 Aug 2023 14:55:14 +0200
Message-ID: <2237127.iZASKD2KPV@pwmachine>
In-Reply-To: <20230819101105.b0c104ae4494a7d1f2eea742@kernel.org>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com> <5702263.DvuYhMxLoT@pwmachine> <20230819101105.b0c104ae4494a7d1f2eea742@kernel.org>
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
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi.

Le samedi 19 ao=FBt 2023, 03:11:05 CEST Masami Hiramatsu a =E9crit :
> Hi Francis,
> (Cc: Song Liu and BPF ML)
>=20
> On Fri, 18 Aug 2023 20:12:11 +0200
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > Hi.
> >=20
> > Le vendredi 18 ao=FBt 2023, 15:05:37 CEST Masami Hiramatsu a =E9crit :
> > > On Thu, 17 Aug 2023 13:06:20 +0200
> > >=20
> > > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > > Hi.
> > > >=20
> > > > Le jeudi 17 ao=FBt 2023, 09:50:57 CEST Masami Hiramatsu a =E9crit :
> > > > > Hi,
> > > > >=20
> > > > > On Wed, 16 Aug 2023 18:35:17 +0200
> > > > >=20
> > > > > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > > > > When using sysfs, it is possible to create kprobe for several
> > > > > > kernel
> > > > > > functions sharing the same name, but of course with different
> > > > > > addresses,
> > > > > > by writing their addresses in kprobe_events file.
> > > > > >=20
> > > > > > When using PMU, if only the symbol name is given, the event will
> > > > > > be
> > > > > > created for the first address which matches the symbol, as
> > > > > > returned by
> > > > > > kallsyms_lookup_name().
> > > > >=20
> > > > > Do you mean probing the same name symbols? Yes, it is intended
> > > > > behavior,
> > > > > since it is not always true that the same name function has the s=
ame
> > > > > prototype (it is mostly true but is not ensured), it is better to
> > > > > leave
> > > > > user to decide which one is what you want to probe.
> > > >=20
> > > > This is what I meant.
> > > > I also share your mind regarding leaving the users deciding which o=
ne
> > > > they
> > > > want to probe but in my case (which I agree is a bit a corner one) =
it
> > > > leaded me to misunderstanding as the PMU kprobe was only added to t=
he
> > > > first ntfs_file_write_iter() which is not the one for ntfs3.
> > >=20
> > > Hmm, OK. I think in that case (multiple same-name symbols exist) the
> > > default behavior is rejecting with error message. And optionally, it
> > > will probe all or them like your patch.
> >=20
> > I am not sure to understand.
> > Can you please precise the default behavior of which software component?
>=20
> I meant that the behavior of the kprobe-events via /sys/kernel/tracing.
> But your patch is for the other interface for perf as kprobe-event PMU.
> In that case, I think we should CC to other users like BPF because
> this may change the expected behavior.
>=20
> > > > > Have you used 'perf probe' tool? It tries to find the appropriate
> > > > > function
> > > > > by line number and creates the probe by 'text+OFFSET' style, not =
by
> > > > > symbol.
> > > > > I think this is the correct way to do that, because user will not
> > > > > know
> > > > > which 'address' of the symbol is what the user want.
> > > >=20
> > > > 'perf probe' perfectly does the trick, as it would find all the ker=
nel
> > > > addresses which correspond to the symbol name and create as many
> > > > probes as
> > > > corresponding symbols [1]:
> > > > root@vm-amd64:~# perf probe --add ntfs_file_write_iter
> > >=20
> > > If you can specify the (last part of) file path as below,
> > >=20
> > > perf probe --add ntfs_file_write_iter@ntfs3/file.c
> > >=20
> > > Then it will choose correct one. :)
> >=20
> > Nice! TIL thank you! perf is really powerful!
>=20
> Yeah, but note that the perf-probe is a tool to setup a 'visible' tracepo=
int
> event. After making a new tracepoint event, the perf tool can use such
> "[Tracepoint event]" instead of PMU.
>=20
> Unfortunately, kprobe-event 'PMU' version doesn't support this
> because it has been introduced for BPF. See the original series;
>=20
> https://lore.kernel.org/lkml/20171206224518.3598254-1-songliubraving@fb.c=
om/
>=20
> So, the "local_kprobe_event" is making a kprobe PMU which is a event for
> local session, that is designed for using such event from BPF (if I
> understand correctly). Of course BPF tool can setup its local
> event with a unique symbol + offset (not just a symbol) in a BPF tool with
> perf-probe but it doesn't.
>=20
> Could you tell me how do you use this feature, for what perpose?

Sure (I think I detailed this in the cover letter but I only sent it to the=
=20
"main" mailing list and not the tracing one, sorry for this inconvenience)!

Basically, I was adding NTFS tracing to an existing tool which monitors slo=
w=20
I/Os using BPF [1].
To test the tool, I compiled a kernel with both NTFS module built-in and=20
figured out the write operations when done on ntfs3 were missing from the=20
output of the tool.
The problem comes from the library I use in the tool which does not handle=
=20
well when it exists different symbols with the same name.
Contrary to perf, which only handles kprobes through sysfs, the library=20
handles it in both way (sysfs and PMU) with a preference for PMU when=20
available [2].

After some discussion, I thought there could be a way to handle this=20
automatically in the kernel when using PMU kprobes, hence this patch.
I totally understand the case I described above is really a corner one, but=
 I=20
thought this feature could be useful for other people.
In the case of the library itself, we could indeed find the address in /pro=
c/
kallsyms but it would mean having CAP_SYS_ADMIN which is not forcefully=20
something we want to enforce.
Also, if we need to read /boot/vmlinuz or /boot/System.map we also need to =
be=20
root as these files often belong to root and cannot be read by others.
So, this patch solves the above problem while not needing specific capabili=
ties=20
as the kernel will solve it for us.

> If you just need to trace/profile a specific function which has the same
> name symbols, you might be better to use `perf probe` +
> `/sys/kernel/tracing` or `perf record -e EVENT`.
>=20
> Or if you need to run it with CAP_PERFMON, without CAP_SYS_ADMIN,
> we need to change a userspace tool to find the correct address and
> pass it to the perf_event_open().
>=20
> > > > Added new events:
> > > >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> > > >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> > > >=20
> > > > You can now use it in all perf tools, such as:
> > > >         perf record -e probe:ntfs_file_write_iter -aR sleep 1
> > > >=20
> > > > root@vm-amd64:~# cat /sys/kernel/tracing/kprobe_events
> > > > p:probe/ntfs_file_write_iter _text+5088544
> > > > p:probe/ntfs_file_write_iter _text+5278560
> > > >=20
> > > > > Thought?
> > > >=20
> > > > This contribution is basically here to sort of mimic what perf does
> > > > but
> > > > with PMU kprobes, as this is not possible to write in a sysfs file
> > > > with
> > > > this type of probe.
> > >=20
> > > OK, I see it is for BPF only. Maybe BPF program can filter correct one
> > > to access the argument etc.
> >=20
> > I am not sure I understand, can you please precise?
> > The eBPF program will be run when the kprobe will be triggered, so if t=
he
> > kprobe is armed for the function (e.g. old ntfs_file_write_iter()), the
> > eBPF program will never be called.
>=20
> As I said above, it is userspace BPF loader issue, because it has to spec=
ify
> the correct address via unique symbol + offset, instead of attaching all =
of
> them. I think that will be more side-effects.
>=20
> But anyway, thanks for pointing this issue. I should fix kprobe event to
> reject the symbols which is not unique. That should be pointed by other
> unique symbols.

You are welcome and I thank you for the discussion.
Can you please precise more what you think about "reject the symbols which =
is=20
not unique"?
Basically something like this:
struct trace_event_call *
create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
			  bool is_return)
{
	...
	if (!addr && func) {
		array.addrs =3D NULL;
		array.size =3D 0;
		ret =3D kallsyms_on_each_match_symbol(add_addr, func, &array);
		if (ret)
			goto error_free;

		if (array.size !=3D 1) {
			/*=20
			 * Function name corresponding to several symbols must
			 * be passed by address only.
			 */
			return -EINVAL;
		}
	}
	...
}
?
If my understanding is correct, I think I can write a patch to achieve this.

> Thank you,
>=20
> > > Thank you,
> > >=20
> > > > > Thank you,
> > > > >=20
> > > > > > The idea here is to search all kernel functions which match this
> > > > > > symbol
> > > > > > and
> > > > > > create a trace_kprobe for each of them.
> > > > > > All these trace_kprobes are linked together by sharing the same
> > > > > > trace_probe.
> > > > > >=20
> > > > > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > > > > ---
> > > > > >=20
> > > > > >  kernel/trace/trace_kprobe.c | 86
> > > > > >  +++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 86 insertions(+)
> > > > > >=20
> > > > > > diff --git a/kernel/trace/trace_kprobe.c
> > > > > > b/kernel/trace/trace_kprobe.c
> > > > > > index 1b3fa7b854aa..08580f1466c7 100644
> > > > > > --- a/kernel/trace/trace_kprobe.c
> > > > > > +++ b/kernel/trace/trace_kprobe.c
> > > > > > @@ -1682,13 +1682,42 @@ static int unregister_kprobe_event(stru=
ct
> > > > > > trace_kprobe *tk)>
> > > > > >=20
> > > > > >  }
> > > > > > =20
> > > > > >  #ifdef CONFIG_PERF_EVENTS
> > > > > >=20
> > > > > > +
> > > > > > +struct address_array {
> > > > > > +	unsigned long *addrs;
> > > > > > +	size_t size;
> > > > > > +};
> > > > > > +
> > > > > > +static int add_addr(void *data, unsigned long addr)
> > > > > > +{
> > > > > > +	struct address_array *array =3D data;
> > > > > > +	unsigned long *p;
> > > > > > +
> > > > > > +	array->size++;
> > > > > > +	p =3D krealloc(array->addrs,
> > > > > > +				sizeof(*array->addrs) * array->size,
> > > > > > +				GFP_KERNEL);
> > > > > > +	if (!p) {
> > > > > > +		kfree(array->addrs);
> > > > > > +		return -ENOMEM;
> > > > > > +	}
> > > > > > +
> > > > > > +	array->addrs =3D p;
> > > > > > +	array->addrs[array->size - 1] =3D addr;
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > >=20
> > > > > >  /* create a trace_kprobe, but don't add it to global lists */
> > > > > >  struct trace_event_call *
> > > > > >  create_local_trace_kprobe(char *func, void *addr, unsigned long
> > > > > >  offs,
> > > > > > =20
> > > > > >  			  bool is_return)
> > > > > > =20
> > > > > >  {
> > > > > > =20
> > > > > >  	enum probe_print_type ptype;
> > > > > >=20
> > > > > > +	struct address_array array;
> > > > > >=20
> > > > > >  	struct trace_kprobe *tk;
> > > > > >=20
> > > > > > +	unsigned long func_addr;
> > > > > > +	unsigned int i;
> > > > > >=20
> > > > > >  	int ret;
> > > > > >  	char *event;
> > > > > >=20
> > > > > > @@ -1722,7 +1751,64 @@ create_local_trace_kprobe(char *func, vo=
id
> > > > > > *addr,
> > > > > > unsigned long offs,>
> > > > > >=20
> > > > > >  	if (ret < 0)
> > > > > >  =09
> > > > > >  		goto error;
> > > > > >=20
> > > > > > +	array.addrs =3D NULL;
> > > > > > +	array.size =3D 0;
> > > > > > +	ret =3D kallsyms_on_each_match_symbol(add_addr, func, &array);
> > > > > > +	if (ret)
> > > > > > +		goto error_free;
> > > > > > +
> > > > > > +	if (array.size =3D=3D 1)
> > > > > > +		goto end;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Below loop allocates a trace_kprobe for each function=20
with
> > > > > > the
> > > > > > same
> > > > > > +	 * name in kernel source code.
> > > > > > +	 * All this differente trace_kprobes will be linked together
> > > > > > through
> > > > > > +	 * append_trace_kprobe().
> > > > > > +	 * NOTE append_trace_kprobe() is called in
> > > > > > register_trace_kprobe()
> > > >=20
> > > > which
> > > >=20
> > > > > > +	 * is called when a kprobe is added through sysfs.
> > > > > > +	 */
> > > > > > +	func_addr =3D kallsyms_lookup_name(func);
> > > > > > +	for (i =3D 0; i < array.size; i++) {
> > > > > > +		struct trace_kprobe *tk_same_name;
> > > > > > +		unsigned long address;
> > > > > > +
> > > > > > +		address =3D array.addrs[i];
> > > > > > +		/* Skip the function address as we already registered=20
it. */
> > > > > > +		if (address =3D=3D func_addr)
> > > > > > +			continue;
> > > > > > +
> > > > > > +		/*
> > > > > > +		 * alloc_trace_kprobe() first considers symbol name,=20
so we set
> > > > > > +		 * this to NULL to allocate this kprobe on the given=20
address.
> > > > > > +		 */
> > > > > > +		tk_same_name =3D=20
alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event,
> > > > > > +						  (void *)address, NULL,=20
offs,
> > > > > > +						  0 /* maxactive */,
> > > > > > +						  0 /* nargs */,=20
is_return);
> > > > > > +
> > > > > > +		if (IS_ERR(tk_same_name)) {
> > > > > > +			ret =3D -ENOMEM;
> > > > > > +			goto error_free;
> > > > > > +		}
> > > > > > +
> > > > > > +		init_trace_event_call(tk_same_name);
> > > > > > +
> > > > > > +		if (traceprobe_set_print_fmt(&tk_same_name->tp,=20
ptype) < 0) {
> > > > > > +			ret =3D -ENOMEM;
> > > > > > +			goto error_free;
> > > > > > +		}
> > > > > > +
> > > > > > +		ret =3D append_trace_kprobe(tk_same_name, tk);
> > > > > > +		if (ret)
> > > > > > +			goto error_free;
> > > > > > +	}
> > > > > > +
> > > > > > +end:
> > > > > > +	kfree(array.addrs);
> > > > > >=20
> > > > > >  	return trace_probe_event_call(&tk->tp);
> > > > > >=20
> > > > > > +error_free:
> > > > > > +	kfree(array.addrs);
> > > > > >=20
> > > > > >  error:
> > > > > >  	free_trace_kprobe(tk);
> > > > > >  	return ERR_PTR(ret);
> > > >=20
> > > > ---
> > > > [1]: https://github.com/torvalds/linux/blob/
> > > > 57012c57536f8814dec92e74197ee96c3498d24e/tools/perf/util/probe-even=
t.c
> > > > #L29
> > > > 89- L2993

Best regards.
=2D--
[1]: https://github.com/inspektor-gadget/inspektor-gadget/pull/1879
[2]: https://github.com/cilium/ebpf/blob/
270c859894bd38cdd0c7783317b16343409e4df8/link/kprobe.go#L165-L191



