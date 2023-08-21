Return-Path: <bpf+bounces-8155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D437828EE
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 14:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9185E280EBE
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE45673;
	Mon, 21 Aug 2023 12:24:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80C185B
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:24:12 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CFBCE3;
	Mon, 21 Aug 2023 05:24:10 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
	by linux.microsoft.com (Postfix) with ESMTPSA id BE755211FA3B;
	Mon, 21 Aug 2023 05:24:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE755211FA3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1692620650;
	bh=940167KBZ2h5//YOHdwnopMfH82ZakvzI8IA3jyqVXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+uufg3eCajFsqDCTZNFFav6IR5W6fdEO4quWKEQV+iSZYHU8zESbbTAG0D3o7r4s
	 pF/gyN0gmd3ekq1qTtgcfbSL8VxIIL8PLI6uFloNbqvD64DpZmbPHDSgkC/OYBKmMI
	 vKrRxZAty904xFj8Rx8CEhvkLThQFt2KIxfLSY2g=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for 'perf_kprobe' PMU
Date: Mon, 21 Aug 2023 14:24:06 +0200
Message-ID: <5703175.DvuYhMxLoT@pwmachine>
In-Reply-To: <ZOJ44P40bsSpUmYA@krava>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com> <20230819101105.b0c104ae4494a7d1f2eea742@kernel.org> <ZOJ44P40bsSpUmYA@krava>
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

Le dimanche 20 ao=FBt 2023, 22:34:40 CEST Jiri Olsa a =E9crit :
> On Sat, Aug 19, 2023 at 10:11:05AM +0900, Masami Hiramatsu wrote:
>=20
> SNIP
>=20
> > > > > > > +	func_addr =3D kallsyms_lookup_name(func);
> > > > > > > +	for (i =3D 0; i < array.size; i++) {
> > > > > > > +		struct trace_kprobe *tk_same_name;
> > > > > > > +		unsigned long address;
> > > > > > > +
> > > > > > > +		address =3D array.addrs[i];
> > > > > > > +		/* Skip the function address as we already=20
registered it. */
> > > > > > > +		if (address =3D=3D func_addr)
> > > > > > > +			continue;
> > > > > > > +
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
>=20
> also are we leaking tk_same_name in here?
>=20
> > > > > > > +			goto error_free;
> > > > > > > +		}
> > > > > > > +
> > > > > > > +		ret =3D append_trace_kprobe(tk_same_name, tk);
> > > > > > > +		if (ret)
>=20
> and here?

Good catch!
Do you know if the appended probes are automatically freed? If so, can you=
=20
please indicate which function handles this?

> jirka
>=20
> > > > > > > +			goto error_free;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +end:
> > > > > > > +	kfree(array.addrs);
> > > > > > >=20
> > > > > > >  	return trace_probe_event_call(&tk->tp);
> > > > > > >=20
> > > > > > > +error_free:
> > > > > > > +	kfree(array.addrs);
> > > > > > >=20
> > > > > > >  error:
> > > > > > >  	free_trace_kprobe(tk);
> > > > > > >  	return ERR_PTR(ret);
> > > > >=20
> > > > > ---
> > > > > [1]: https://github.com/torvalds/linux/blob/
> > > > > 57012c57536f8814dec92e74197ee96c3498d24e/tools/perf/util/probe-ev=
ent
> > > > > .c#L29
> > > > > 89- L2993

Best regards.



