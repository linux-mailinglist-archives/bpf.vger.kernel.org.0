Return-Path: <bpf+bounces-8154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD97828E9
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 14:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1DA280E22
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2D8566E;
	Mon, 21 Aug 2023 12:22:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E15661
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:22:50 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1934C2;
	Mon, 21 Aug 2023 05:22:49 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
	by linux.microsoft.com (Postfix) with ESMTPSA id EA9D2211FA3B;
	Mon, 21 Aug 2023 05:22:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA9D2211FA3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1692620569;
	bh=igE5GuZpKkrEvOFouD2wi4i73MBnSdSlF1cLFSCZDY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ThRpokltgmQVWd8Uv+At2ZgncqSswiPtuSYFG5MjebY4737IL3NpXLe/YZRUVLXfa
	 k+hDSAhoB7D0J45Lkjw9YH98Ze28UwVoJQE2gwk2B3ThhfQ/cy68y6TZLe+PYeOIUe
	 9ExFPIDzWl+vbIlga01HWlNug7c8xcGLYw+M+r6M=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for 'perf_kprobe' PMU
Date: Mon, 21 Aug 2023 14:22:45 +0200
Message-ID: <2695086.mvXUDI8C0e@pwmachine>
In-Reply-To: <ZOJ2W4O75BYP1uML@krava>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com> <20230819101105.b0c104ae4494a7d1f2eea742@kernel.org> <ZOJ2W4O75BYP1uML@krava>
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

Le dimanche 20 ao=FBt 2023, 22:23:55 CEST Jiri Olsa a =E9crit :
> On Sat, Aug 19, 2023 at 10:11:05AM +0900, Masami Hiramatsu wrote:
> > Hi Francis,
> > (Cc: Song Liu and BPF ML)
> >=20
> > On Fri, 18 Aug 2023 20:12:11 +0200
> >=20
> > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > Hi.
> > >=20
> > > Le vendredi 18 ao=FBt 2023, 15:05:37 CEST Masami Hiramatsu a =E9crit :
> > > > On Thu, 17 Aug 2023 13:06:20 +0200
> > > >=20
> > > > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > > > Hi.
> > > > >=20
> > > > > Le jeudi 17 ao=FBt 2023, 09:50:57 CEST Masami Hiramatsu a =E9crit=
 :
> > > > > > Hi,
> > > > > >=20
> > > > > > On Wed, 16 Aug 2023 18:35:17 +0200
> > > > > >=20
> > > > > > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > > > > > When using sysfs, it is possible to create kprobe for several
> > > > > > > kernel
> > > > > > > functions sharing the same name, but of course with different
> > > > > > > addresses,
> > > > > > > by writing their addresses in kprobe_events file.
> > > > > > >=20
> > > > > > > When using PMU, if only the symbol name is given, the event w=
ill
> > > > > > > be
> > > > > > > created for the first address which matches the symbol, as
> > > > > > > returned by
> > > > > > > kallsyms_lookup_name().
> > > > > >=20
> > > > > > Do you mean probing the same name symbols? Yes, it is intended
> > > > > > behavior,
> > > > > > since it is not always true that the same name function has the
> > > > > > same
> > > > > > prototype (it is mostly true but is not ensured), it is better =
to
> > > > > > leave
> > > > > > user to decide which one is what you want to probe.
> > > > >=20
> > > > > This is what I meant.
> > > > > I also share your mind regarding leaving the users deciding which
> > > > > one they
> > > > > want to probe but in my case (which I agree is a bit a corner one)
> > > > > it
> > > > > leaded me to misunderstanding as the PMU kprobe was only added to
> > > > > the
> > > > > first ntfs_file_write_iter() which is not the one for ntfs3.
> > > >=20
> > > > Hmm, OK. I think in that case (multiple same-name symbols exist) the
> > > > default behavior is rejecting with error message. And optionally, it
> > > > will probe all or them like your patch.
> > >=20
> > > I am not sure to understand.
> > > Can you please precise the default behavior of which software compone=
nt?
> >=20
> > I meant that the behavior of the kprobe-events via /sys/kernel/tracing.
> > But your patch is for the other interface for perf as kprobe-event PMU.
> > In that case, I think we should CC to other users like BPF because
> > this may change the expected behavior.
>=20
> it does not break bpf tests, but of course we don't have such use case, b=
ut
> I think should make this optional not to potentionaly break existing user=
s,
> because you get more probes than you currently ask for
>=20
> would be great to have some kind of tests for this as well

If we decide to go further with this contribution, I will add some kind of=
=20
test (even though I do not really see how to test it at the moment).

> SNIP
>=20
> > > > > > > +		/*
> > > > > > > +		 * alloc_trace_kprobe() first considers symbol name,=20
so we
> > > > > > > set
> > > > > > > +		 * this to NULL to allocate this kprobe on the given=20
address.
> > > > > > > +		 */
> > > > > > > +		tk_same_name =3D=20
alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event,
> > > > > > > +						  (void *)address, NULL,=20
offs,
> > > > > > > +						  0 /* maxactive */,
> > > > > > > +						  0 /* nargs */,=20
is_return);
> > > > > > > +
> > > > > > > +		if (IS_ERR(tk_same_name)) {
> > > > > > > +			ret =3D -ENOMEM;
> > > > > > > +			goto error_free;
> > > > > > > +		}
> > > > > > > +
> > > > > > > +		init_trace_event_call(tk_same_name);
> > > > > > > +
> > > > > > > +		if (traceprobe_set_print_fmt(&tk_same_name->tp,=20
ptype) < 0) {
> > > > > > > +			ret =3D -ENOMEM;
> > > > > > > +			goto error_free;
> > > > > > > +		}
> > > > > > > +
> > > > > > > +		ret =3D append_trace_kprobe(tk_same_name, tk);
> > > > > > > +		if (ret)
> > > > > > > +			goto error_free;
>=20
> this seems tricky if offs is specified, because IIUC that will most
> likely fail in the __register_trace_kprobe/register_kprobe call inside
> the append_trace_kprobe ... should we allow this just for offs =3D=3D 0 ?

Excellent catch!
I will correct it for v2 if I send one!

> jirka





