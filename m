Return-Path: <bpf+bounces-5233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6266B758B27
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 04:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E1D1C20EEE
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC0117F9;
	Wed, 19 Jul 2023 02:10:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BBD17D0
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:10:07 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D385919AF;
	Tue, 18 Jul 2023 19:10:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so10420440e87.3;
        Tue, 18 Jul 2023 19:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689732604; x=1692324604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWXZjAuDZ5feV/10kVxl5QUKhgl3CYoFjxPM3tLNDek=;
        b=YZGj2TqAigLS9gVX3/oQv4ypHCGxUHuSWVyP1A9xC7iDkYJdvi5b/qwqpDMn7LjuDi
         2GshvvD0I89VK3MVl5Vlmt529yNHy+27c6atxbkgO40IMEvMqmTZiqOuDJkczno07L6q
         cMuQq/T9+1Z3mYMH24DKBECjb5BEhAMKDoYI8nTiGacAOpFTCXWj4Jt64s0l2Dkk/T8v
         tZidh8JDHr4pFdJ9FSCmRvE95UUH4IITiq6CGJ0SIkDD4PCNhslXMPgJ/cB1y3Gzcnt7
         jxRw/Rv5Pb4oiq7c2hSCecz/Pt4BZmqiP0eiaNotJYDXfL4Mz1VyKLrxDAoEqhcx2Tiu
         9lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689732604; x=1692324604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWXZjAuDZ5feV/10kVxl5QUKhgl3CYoFjxPM3tLNDek=;
        b=TDF4YSU6X7FiGbx0LTsJnKuLmnfZpWDQ2bKSSBIiWlsivrYjMw7JtwiotavWqhz7Z3
         iMRuETbW6rJFWFqvlj3tp4SMs/oeaO48qXe0DLst7OivnRW8LQqAODDE1cjBW9bcZikr
         sKe9AyY/ksIWsIUNcmV2qK7KSJmmuoSXfdv/aitRUwfX/R+16APLmbEf1NUs5RqwSyvV
         P4vT2nXM8981MN4LrExh0dcSh85gPjzU5vT52ItkbyMQeK9e2ShOR4KyHiDmRtIXg9+/
         DJI47BKNVQP49fVENHQ8+oQ+ROQg8+1CAsOTkr5u8jmbcx05UIMq23ibJhD8JWtr+iMY
         E2Xw==
X-Gm-Message-State: ABy/qLa/45sfMhPNkLmGGeqSiDnswFkz4JrkTrSi4kDs/VOFBPR6MiPH
	M8PDvU9AIUn1C0LvsG0zizKS33iRgbjFvn8SU6fMTBGfK2eYzQ13btY=
X-Google-Smtp-Source: APBJJlEOMCn868MC4GK6BKZADcUyesZCadL6Md/hcHc7RhsHn0zpsG0YaJgVCxPXyBg+p1Q28zkWaYX7eIRhKDZhpBU=
X-Received: by 2002:a05:6512:2038:b0:4f8:67f0:7253 with SMTP id
 s24-20020a056512203800b004f867f07253mr725859lfs.49.1689732603526; Tue, 18 Jul
 2023 19:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
 <168960741686.34107.6330273416064011062.stgit@devnote2> <CAErzpmuvhrj0HhTpH2m-C-=pFV=Q_mxYC59Hw=dm0pqUvtPm0g@mail.gmail.com>
 <20230718194431.5653b1e89841e6abd9742ede@kernel.org> <20230718225606.926222723cdd8c2c37294e41@kernel.org>
 <CAADnVQ+8PuT5tC4q1spefzzCZG9r1UszFv0jenK5+Ed+QNqtsw@mail.gmail.com> <20230719080337.0955a6e77d799daad4c44350@kernel.org>
In-Reply-To: <20230719080337.0955a6e77d799daad4c44350@kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 19 Jul 2023 10:09:48 +0800
Message-ID: <CAErzpmtJF4tjHCyYdHgiX_-vp39tdc=3iNmMhQ6SnFVicqZWrg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API and
 getting func-param API to BTF
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 7:03=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 18 Jul 2023 10:11:01 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Tue, Jul 18, 2023 at 6:56=E2=80=AFAM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > On Tue, 18 Jul 2023 19:44:31 +0900
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > >
> > > > > >  static const struct btf_param *find_btf_func_param(const char =
*funcname, s32 *nr,
> > > > > >                                                    bool tracepo=
int)
> > > > > >  {
> > > > > > +       struct btf *btf =3D traceprobe_get_btf();
> > > > >
> > > > > I found that traceprobe_get_btf() only returns the vmlinux's btf.=
 But
> > > > > if the function is
> > > > > defined in a kernel module, we should get the module's btf.
> > > > >
> > > >
> > > > Good catch! That should be a separated fix (or improvement?)
> > > > I think it's better to use btf_get() and btf_put(), and pass btf vi=
a
> > > > traceprobe_parse_context.
> > >
> > > Hmm, it seems that there is no exposed API to get the module's btf.
> > > Should I use btf_idr and btf_idr_lock directly to find the correspond=
ing
> > > btf? If there isn't yet, I will add it too.
> >
> > There is bpf_find_btf_id.
> > Probably drop 'static' from it and use it.
>
> Thanks! BTW, that API seems to search BTF type info by name. If user want=
 to
> specify a module name, do we need a new API? (Or expand the function to p=
arse
> a module name in given name?)

btf_get_module_btf can be used to get a module's btf, but we have to use
find_module to get the module by its name firstly.

>
> Thank you,
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

