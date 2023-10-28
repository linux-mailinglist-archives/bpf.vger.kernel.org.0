Return-Path: <bpf+bounces-13531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB84E7DA487
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 02:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F397B21645
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 00:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFFF639;
	Sat, 28 Oct 2023 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I085t9yn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4B39F
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 00:56:30 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AF8CC
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 17:56:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso2578723b3a.3
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 17:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698454589; x=1699059389; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a76Ao9N7egg58eqjOWJkIzdIV1+T0l/g36r0Idjh7NU=;
        b=I085t9yniihKameymX/JVXaVkMMitibBnFltTgWWaX2Z9dDxSM5BR/ESY/E+JNh4Co
         +uPaSj7cveb1L20tizLokV6u9QJNhAWYuIr/WzDxagfeQikVzFwdPPbduo9RHqIG4orS
         B6nSx7RfCWfvCXWXFEx08y46suEduCXiCbOeN1vYoJlZ59npTE+pCawY+Ts43/gBhbN8
         4ZfW/FuwoehOIhIyurGC8XwwZVShkvgLhLP+rS1ezNNiKonuuu4M+ACRP0mac9tTLOC0
         8HPTE4WaAZE3Rck9sAuhNcuVH85nCOMJcSOxqEDlKHIsH+YTf5gW6v0cQgNlwuO9GssZ
         r0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698454589; x=1699059389;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a76Ao9N7egg58eqjOWJkIzdIV1+T0l/g36r0Idjh7NU=;
        b=RDRzZp5sqDZBmM1SzuR4e8xgKDOUHagWmboKjYuRjQn2WPmZKh29j6QKRjlZYJFdTz
         YMAdCdt2DXf/6inYtUrvX1OfFjXCFxQMdWHqgsxvU6fBn2bIby94ZgPlVh6A5R25fmzd
         lWqOMQw8+EVTMWGoI9VMkEruUCmSgCDpt6vh4drJDz9efeOzJHZs0c+57wGKZyygORRr
         NiZHLYBRni/CDRq/Wv9vWEd6OQdiOF5q0bgqSeTEFqddEJd2Rwq/TreAsIH+Zv8gMEcZ
         CETsPMvFUJISskXfdGiQGhcjdifA5pAHxNNv6pbllr7P4irgNNLxBogVDslJB2zXFceO
         BjEw==
X-Gm-Message-State: AOJu0YzjHyUNYPckQMDKuA5fxM5UGqfJtMYPe6+/7yDPoazdGryphmKs
	/cBLXpW20qEj6oWwLUrcAHk=
X-Google-Smtp-Source: AGHT+IGmJlXG+IgwwitkGT3Ru+NlQnm5e/B0pYqTMFqMzfSnh1hT5lugxfuxsnz9aSDyDd1Yf5Kd1A==
X-Received: by 2002:a05:6a00:1888:b0:690:2ad9:1454 with SMTP id x8-20020a056a00188800b006902ad91454mr4845117pfh.33.1698454588829;
        Fri, 27 Oct 2023 17:56:28 -0700 (PDT)
Received: from surya ([2600:1700:3ec2:2011:3ef3:bbdb:b46b:4676])
        by smtp.gmail.com with ESMTPSA id fj8-20020a056a003a0800b006b90f1706f1sm1937318pfb.134.2023.10.27.17.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 17:56:28 -0700 (PDT)
Date: Fri, 27 Oct 2023 17:56:26 -0700
From: Manu Bretelle <chantr4@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: umount children of TDIR in
 test_bpffs
Message-ID: <ZTxcOjXbeVsxgs0p@surya>
References: <20231024201852.1512720-1-chantr4@gmail.com>
 <041a3ea2-8cc6-4f0f-8ed9-6ca459e5bbb7@gmail.com>
 <ZTiqp7URqNjqrSEk@surya>
 <CAADnVQ++5v46OYD-zR28dM=PaZ1RYLoijLicg+8DgnAZAZ_qtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ++5v46OYD-zR28dM=PaZ1RYLoijLicg+8DgnAZAZ_qtw@mail.gmail.com>

On Thu, Oct 26, 2023 at 02:35:11PM -0700, Alexei Starovoitov wrote:
> On Tue, Oct 24, 2023 at 10:42 PM Manu Bretelle <chantr4@gmail.com> wrote:
> >
> > On Tue, Oct 24, 2023 at 02:29:19PM -0700, Kui-Feng Lee wrote:
> > >
> > >
> > > On 10/24/23 13:18, Manu Bretelle wrote:
> > > > Currently this tests tries to umount /sys/kernel/debug (TDIR) but the
> > > > system it is running on may have mounts below.
> > > >
> > > > For example, danobi/vmtest [0] VMs have
> > > >      mount -t tracefs tracefs /sys/kernel/debug/tracing
> > > > as part of their init.
> > > >
> > > > This change list mounts and will umount any mounts below TDIR before
> > > > umounting TDIR itself.
> > > >
> > > > Note that it is not umounting recursively, so in the case of a sub-mount
> > > > of TDIR  having another sub-mount, this will fail as mtab is ordered.
> > >
> > > Should we move TID to a random path likes "/sys/kernel/debug-<pid>/"?
> > >
> >
> > Fair point, I suppose we would want to keep TDIR a defined string as it does
> > simplify the gymnastic involved through the rest of the script, but yeah
> > looking at the original commit:
> > edb65ee5aa25 (selftests/bpf: Add bpffs preload test)
> >
> > I don't see any reason to use an alternate directory and rather mkdir it vs
> > umounting the original one.
> > so something like
> >
> >     #define TDIR "/sys/kernel/test_bpffs"
> >
> > Would probably do.
> >
> > Alexei could confirm his original intent probably.
> 
> I don't remember why I picked /sys/kernel/debug back then.
> I suspect TDIR /tmp/foo and mkdir would work the same way.

Yeah. I suspect the reason you used an existing directory is that
/sys/kernel is not mutable from userspace.
I ended up picking a random name under /tmp and mkdir.

