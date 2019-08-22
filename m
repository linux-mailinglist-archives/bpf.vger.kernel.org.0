Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681F89A202
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2019 23:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfHVVQb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Aug 2019 17:16:31 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:48895 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730897AbfHVVQR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 22 Aug 2019 17:16:17 -0400
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Aug 2019 17:16:16 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id CFDEE49A;
        Thu, 22 Aug 2019 17:08:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 22 Aug 2019 17:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:cc
        :subject:from:to:message-id; s=fm1; bh=WZ5Ec3wLQiEm5IlJwCBhY1oTo
        MWeoHMfgT/wZdlQH5Q=; b=Utj4s/Z5saDMZIER6kYduuw5ZYnj1gZuBNQMjAk3I
        GwAsPVKOr+/Azp/IbdYZPN6ePMEBYuIIZy6RNBaN4O63jvgcbJnxnmlGhrboJcmw
        UthSMhr88TD8c0lIGbTubBfN3PlowT5cncIoEVsQh1jEloUj6Ags+rVsQUUoCbZP
        Kksg6YvPmR2BlQIGxKyH28uW/d6KzRDss+bCEPBmhabFR6TPKiLFmssr92qJ8ou5
        YUN4buxkRU/78bPvciLNknmT2SNhaJBzlsbo4Zk48ZBuua3MhxIjKsb6hsZHbpKR
        2qGOCBtyRfjH3p7H/kHRFBcMDCNSXdkT1tB72cR2liWTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WZ5Ec3
        wLQiEm5IlJwCBhY1oToMWeoHMfgT/wZdlQH5Q=; b=eMNX9UaIeB2Sm/5VpMH21P
        YOpr4TD0uVEwVn+0GeuAYiMuDQoSFgPuIdBv0dibbEinqvnDeaFSyGrOVOu3pTM8
        6/wO4nY7vx4eiPN6DoMGMn+u3C1H7qHoFiCqmScXsxktUIAbR6SCQ+IY0QaQw7Ai
        k30z2Rff7dseY0OsOvTujqKVXnTmuo+DXVb0BHr8/QxZDMjEiPARGSfi7gCVqjem
        pPn7az+SLLjYZRqjlhc/jbp3lJpDD8xmNp7PcBkapH3avJQN54HiIQTUjYGmOjZC
        dppndIgwiGYamCRnffNBmRlBJPxkor/4nfZipdRyr3n0ZEYELeWfh5K4txBvwNnA
        ==
X-ME-Sender: <xms:PQRfXQKfIgkFSLdEPMcp9yeLkcwroP3kxcHz1x3emQCrROzvNo8VBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegiedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepgfgtjgffuffhvffksehtqhertddttdej
    necuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqne
    cukfhppeduleelrddvtddurdeigedrgeenucfrrghrrghmpehmrghilhhfrhhomhepugig
    uhesugiguhhuuhdrgiihiienucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:PQRfXYU8ISslaBb0aPcoNOzsZOXje8elv4Qqu48meYoY24cDCfFefA>
    <xmx:PQRfXWkxwm9Ej8uQLPPEfg68dTjcMsgImjZsPelUAk-3lVlZiv5Fyg>
    <xmx:PQRfXWdesUsRaPhOWUSMB6ytOdMczGHdAgcOQQniUZ-wZsRJ5rwU9g>
    <xmx:PgRfXeJcvuWPQjvXGiyQ2-HXUt_fQurItbiQYKI3NPwNce8E4xUFp8--DV0>
Received: from localhost (prnvpn05.thefacebook.com [199.201.64.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD78380062;
        Thu, 22 Aug 2019 17:08:10 -0400 (EDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20190822090555.GJ2349@hirez.programming.kicks-ass.net>
Date:   Thu, 22 Aug 2019 14:08:10 -0700
Cc:     "Yonghong Song" <yhs@fb.com>, "Daniel Xu" <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Andrii Nakryiko" <andriin@fb.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "Alexei Starovoitov" <ast@fb.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kernel Team" <Kernel-team@fb.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Peter Zijlstra" <peterz@infradead.org>,
        "Song Liu" <songliubraving@fb.com>
Message-Id: <BWGGRTQXX7EP.15IPIDK3KLQ6O@dlxu-fedora-R90QNFJV>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu Aug 22, 2019 at 11:05 AM Peter Zijlstra wrote:
> On Thu, Aug 22, 2019 at 07:54:16AM +0000, Song Liu wrote:
> > Hi Peter,=20
> >=20
> > > On Aug 22, 2019, at 12:47 AM, Peter Zijlstra <peterz@infradead.org> w=
rote:
> > >=20
> > > On Wed, Aug 21, 2019 at 06:43:49PM +0000, Yonghong Song wrote:
> > >> On 8/21/19 11:31 AM, Peter Zijlstra wrote:
> > >=20
> > >>> So extending PERF_RECORD_LOST doesn't work. But PERF_FORMAT_LOST mi=
ght
> > >>> still work fine; but you get to implement it for all software event=
s.
> > >>=20
> > >> Could you give more specifics about PERF_FORMAT_LOST? Googling=20
> > >> "PERF_FORMAT_LOST" only yields two emails which we are discussing he=
re :-(
> > >=20
> > > Look at what the other PERF_FORMAT_ flags do? Basically it is adding =
a
> > > field to the read(2) output.
> >=20
> > Do we need to implement PERF_FORMAT_LOST for all software events? If us=
er
> > space asks for PERF_FORMAT_LOST for events that do not support it, can =
we
> > just fail sys_perf_event_open()?
>=20
> It really shouldn't be hard; and I'm failing to see why kprobes are
> special.

Thanks for the feedback, everyone. Really appreciate it.

I will look into extending read_format. I'll submit another patch series
after I get the code to work.

Daniel
