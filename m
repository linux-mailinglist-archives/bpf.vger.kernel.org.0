Return-Path: <bpf+bounces-3552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8732B73F923
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 11:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB90281031
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 09:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA7E171DF;
	Tue, 27 Jun 2023 09:53:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA076171CF
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 09:53:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EAC2D64
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 02:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687859593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DERs8uzDMpyvp9qgsa7AlFpdBE9PZMETpYtSHAfUjAo=;
	b=EVNd5lkvGS11i2uuTIC9MmOyduPyr+E3UlQWX4Wfyot4fUS1ye44xCf4NSo+HmpYy0Psrl
	rX2n6wQd5AYxEQdgvyorhsB2dMwYGx0B1+OWuGXanm4885SEVTEhaCSbR6sDGazMaTYIOB
	dJF5p09DCx/kbNHN276gh2JPtCbJ/V0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-NLvS9ZOBM-6a7n8-m9Ikvg-1; Tue, 27 Jun 2023 05:53:11 -0400
X-MC-Unique: NLvS9ZOBM-6a7n8-m9Ikvg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-40234d83032so1687061cf.1
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 02:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687859591; x=1690451591;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DERs8uzDMpyvp9qgsa7AlFpdBE9PZMETpYtSHAfUjAo=;
        b=WQd99D55eonqcwj8ov4p5L3Z0GoNrwKBIYYICXClywQFL2nVRiveHAxgvyncP2DPC7
         H9QcReo6yrmJL8hemz1XAzCPimK9CQD5N6FqD/hPe/J4MmR1N+RuOtoFvPqjLwuYWcf2
         i4eckmMi8hqLcQWX4IRgZitzoBYqWp8tAZnhYMKVIthFzdwuJmz/VDTMgZoCOia1mL8w
         s/EIMcgYCmQakLBQqx8ekpiWkAOSrss6uxfxLbVg2eRGBiWW3+U1i96cYJSMtOJCi69o
         llwULPhkR2RJQRrFjkFKQAGkZFBW7geSn+3vVqSIab6+cFpkKDYuXMleFHoZHle0axPc
         M3Rw==
X-Gm-Message-State: AC+VfDzt0nK7Yh4MkOoNT1AhBUOlyCHGiWDE4QbPjlMz4Dot7VAHrUoQ
	wHutDn5uSwxkcTfiN8lY+02UkFPUEzmKjsAg1s1jaupUo6urKD1O3/ZQr0RQihDXSiVPeO1N/UA
	vRthID64L6uIt
X-Received: by 2002:a05:622a:1191:b0:3f6:b493:8ee4 with SMTP id m17-20020a05622a119100b003f6b4938ee4mr39729433qtk.0.1687859591385;
        Tue, 27 Jun 2023 02:53:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5aXj4A9G6QhV47CSXT3MixoO5CAWu5oDZ2HUASdv+XCpyT8RMvKYE/1Knu3xwkhDYnqez+CA==
X-Received: by 2002:a05:622a:1191:b0:3f6:b493:8ee4 with SMTP id m17-20020a05622a119100b003f6b4938ee4mr39729413qtk.0.1687859591104;
        Tue, 27 Jun 2023 02:53:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-6.dyn.eolo.it. [146.241.239.6])
        by smtp.gmail.com with ESMTPSA id cq14-20020a05622a424e00b003f9bccc3182sm208798qtb.32.2023.06.27.02.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 02:53:10 -0700 (PDT)
Message-ID: <35d67fc65d5ff70c102040ce095a7c4a8b5da8bb.camel@redhat.com>
Subject: Re: [PATCH net-next] tools: Fix MSG_SPLICE_PAGES build error in
 trace tools
From: Paolo Abeni <pabeni@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, David Howells
 <dhowells@redhat.com>, netdev@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@redhat.com>, David Miller <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, Matthew Wilcox
 <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2023 11:53:05 +0200
In-Reply-To: <CAM9d7cgaXHU0=K-T80Vv6vh1pFyF=Jo-hgTrHXbOq5gpf5ux8w@mail.gmail.com>
References: <5791ec06-7174-9ae5-4fe4-6969ed110165@tessares.net>
	 <3065880.1687785614@warthog.procyon.org.uk>
	 <3067876.1687787456@warthog.procyon.org.uk>
	 <2cb3b411-9010-a44b-ebee-1914e7fd7b9c@tessares.net>
	 <CAM9d7ch_mWUQGW8G221bZmCPn3wB2mjZm=ZdmhDkczhich9xZA@mail.gmail.com>
	 <20230626145353.468fd133@kernel.org>
	 <CAM9d7cgaXHU0=K-T80Vv6vh1pFyF=Jo-hgTrHXbOq5gpf5ux8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-06-26 at 14:59 -0700, Namhyung Kim wrote:
> On Mon, Jun 26, 2023 at 2:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >=20
> > On Mon, 26 Jun 2023 14:31:39 -0700 Namhyung Kim wrote:
> > > Right, we want to keep the headers files in the tools in sync with
> > > the kernel ones.  And they are used to generate some tables.
> > > Full explanation from Arnaldo below.
> > >=20
> > > So I'm ok for the msg_flags.c changes, but please refrain from
> > > changing the header directly.  We will update it later.
> > >=20
> > > With that,
> > >   Acked-by: Namhyung Kim <namhyung@kernel.org>
> >=20
> > Ah, missed this email, sounds like this is preferred to Matthieu's
> > fix, we'll take this one.
>=20
> Hmm.. I believe they are the same when it comes to the
> changes in the .c file.
>=20
> >=20
> > > Also I wonder if the tool needs to keep the original flag
> > > (SENDPAGE_NOTLAST) for the older kernels.
> >=20
> > That's a bit unclear, because it's just a kernel-internal flag.
> > Future kernels may well use that bit for something else.
>=20
> Ah, ok then.  I thought it's a user-visible flag.
>=20
> >=20
> > Better long term solution would be to use an enum so that the values
> > are included in debuginfo and perf can read them at runtime :(
>=20
> Right, we also consider BTF to read the values and hopefully
> get rid of the business of copying kernel headers.

I read all the above as the preferred solution is the one provided by
Mat's patch (not touching socket.h, same changes as here in
msg_flags.c.

As such, I'll restore Mat's patch in PW and will obsolete this one.
Please raise a flag if I'm wrong ;)

Cheers,

Paolo


