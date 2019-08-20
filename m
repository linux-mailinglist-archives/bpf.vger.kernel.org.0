Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73CDC95476
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 04:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfHTCey (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Aug 2019 22:34:54 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:44033 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728719AbfHTCey (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 19 Aug 2019 22:34:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id AC9BF30E0;
        Mon, 19 Aug 2019 22:34:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 19 Aug 2019 22:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:to:cc
        :subject:from:message-id; s=fm1; bh=UTtjerizdprs5SO9sELd3ccBs2SU
        qyaWLtKiMRtIKCg=; b=er29fuLUdvd1y7Vd5jcXA52UKTe5juq047EmhDXXdQsg
        4i0VKXAdXsh4sIPjz2kFlKA4+h8LuMP6+CzWR/K26hK720DDdpLTroG6g4aPpGFV
        N+/6xBj20VDHHhBh7vb9Go9afTgh2NJvqvinN8sDE6kl4D81xUnTx9jmhza8yRgr
        OW7r6ak2qnvtX0Bhcc1ACfE9JR+CwBONq/+QrtMoIWuW9JKQiNt616kJSF4CejTe
        0iUc9RicFQNleToRpDE+8qrOtHqxbwRv1zj9NSkbhHWu8bwd2XYoAsgA6R7+L8Yy
        hnDXo5i4W7/ilI2zoNSQT3t9bc8REsTPnUO28pd4Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UTtjer
        izdprs5SO9sELd3ccBs2SUqyaWLtKiMRtIKCg=; b=fynTHJt8XyRPpXxlmDWLvm
        O1cqz/sy/p5hsH/qu9jkdrpINAJS7QIO0rdSo1Ce6qNTgTdRtuPVFq0yCaZV+PA6
        UUM04RADWxVzZBf8kmTHtFBGbsX41cgrtf3pQY5dm5qOvFxc59FiXCZfljYPYbmQ
        qIkxDkPnoqb/uLTVAbiYPvmb2hw4pSqCxnFCiV34RuinYdjoAHa+/5Lu5g4Hlu6F
        87K6C57/BfRoC/8bi7RRtOBe2bxE9skGXUuTOxHqoj3Bi3gcPIKUBOoKLEZ39r+0
        Qnt3VuHMtq7PLMzzFvZADt7Kc5EtslLSqJXPNpVJkmj98i27lRV2RErbhzHjJLRA
        ==
X-ME-Sender: <xms:TFxbXfG1MMhPF2Vrz8nA2ZCvAKWEKUQgxwec50curP18IB2Onj7_Nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegtddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpefgtggjfffvuffhkfesthhqredttddtjeen
    ucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighiiiqeenuc
    fkphepudelledrvddtuddrieegrddufeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpegu
    gihusegugihuuhhurdighiiinecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:TFxbXcC_2kE7g-7qPzf5OpP1-YxAvA3w3UlL4T4PEeaAAgPHYNei5w>
    <xmx:TFxbXcyq4jmx0fZHDrLtQtOs0Xn1wqHJX_4P1vpkdWa_-_SaqSshag>
    <xmx:TFxbXY5EVJ7vJnRAsbDeusGg6AaMc6-Xt87qjk8UuhUAnYN14FoGug>
    <xmx:TVxbXQ9FUWi7JBHMkSzeks_Vfj--uDwZlnHLpIF-XptoE4xElD3gsw>
Received: from localhost (unknown [199.201.64.135])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6184B380074;
        Mon, 19 Aug 2019 22:34:51 -0400 (EDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAADnVQ+RKuJB5G+-1fjsE2xLp8CxJMmidd6Qobi_4dXQOWjrow@mail.gmail.com>
Date:   Mon, 19 Aug 2019 19:34:50 -0700
To:     "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc:     "bpf" <bpf@vger.kernel.org>, "Song Liu" <songliubraving@fb.com>,
        "Yonghong Song" <yhs@fb.com>, "Andrii Nakryiko" <andriin@fb.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Alexei Starovoitov" <ast@fb.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Kernel Team" <kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
From:   "Daniel Xu" <dxu@dxuuu.xyz>
Message-Id: <BWE3UBBDYMGD.26324NSRV46UF@dlxu-fedora-R90QNFJV>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon Aug 19, 2019 at 6:26 PM Alexei Starovoitov wrote:
> On Fri, Aug 16, 2019 at 3:33 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > It's useful to know [uk]probe's nmissed and nhit stats. For example wit=
h
> > tracing tools, it's important to know when events may have been lost.
> > debugfs currently exposes a control file to get this information, but
> > it is not compatible with probes registered with the perf API.
> >
> > While bpf programs may be able to manually count nhit, there is no way
> > to gather nmissed. In other words, it is currently not possible to
> > retrieve information about FD-based probes.
> >
> > This patch adds a new ioctl that lets users query nmissed (as well as
> > nhit for completeness). We currently only add support for [uk]probes
> > but leave the possibility open for other probes like tracepoint.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ...
> > +int perf_kprobe_event_query(struct perf_event *event, void __user *inf=
o)
> > +{
> > +       struct perf_event_query_probe __user *uquery =3D info;
> > +       struct perf_event_query_probe query =3D {};
> > +       struct trace_event_call *call =3D event->tp_event;
> > +       struct trace_kprobe *tk =3D (struct trace_kprobe *)call->data;
> > +       u64 ncopy;
> > +
> > +       if (!capable(CAP_SYS_ADMIN))
> > +               return -EPERM;
> > +       if (copy_from_user(&query, uquery,
> > +                          offsetofend(struct perf_event_query_probe, s=
ize)))
> > +               return -EFAULT;
> > +
> > +       ncopy =3D min_t(u64, query.size, sizeof(query));
> > +       query.nhit =3D trace_kprobe_nhit(tk);
> > +       query.nmissed =3D tk->rp.kp.nmissed;
> > +
> > +       if (copy_to_user(uquery, &query, ncopy))
> > +               return -EFAULT;
>=20
> shouldn't kernel update query.size before copying back?
> Otherwise how user space would know which fields
> were populated?

Ah yes, sorry. Will add that.
