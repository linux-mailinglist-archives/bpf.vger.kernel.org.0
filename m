Return-Path: <bpf+bounces-27479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A33B8AD62B
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 22:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AD8283593
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB31C6B8;
	Mon, 22 Apr 2024 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYhbbKXu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5D1C68D;
	Mon, 22 Apr 2024 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819318; cv=none; b=Hb1NJdXhkhBDC4UDSbW021PH58WsqllW+QARIVF925QyxrCxJMBim5mU1zMoG4R7I+RQRU48P9tKzDMOQ4BGcdz7mWlLjG1BMCOSq9itwEzi7KuQxtQ+LnNDNeRCZiXByXzM3ilG/PH8PdiZDUoNLuXVyZqNud/+r0M63mZtbIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819318; c=relaxed/simple;
	bh=zOJayybj5bm2pTJSI0p6yN4sVWz2Z2kuEJqDXj404O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1+4PBN3XKuRW6lxCbS8UR3OIhgsHBu/rQaDjwyg+N1VI+kXsZ8D9l+CIb/DnvpOEjaVRbeAImsSYk1yQFdQ/EH+nvlP+qmcSpujfRzC9fypAiH2JDifsljgls1XxhoXoOnJeXCftLWGleKNDGJtNwu5Uk5ZL+0RUHHClbKtOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYhbbKXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC64C113CC;
	Mon, 22 Apr 2024 20:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713819318;
	bh=zOJayybj5bm2pTJSI0p6yN4sVWz2Z2kuEJqDXj404O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYhbbKXu7jdLBINWaEFTHBD/uCrZDgA4cgyaXvHRb+qyaD3gMsMLS2RbyCG1wDMQE
	 t4FooY18pGI0j1YPxkI5mWUSCASCC+B2L2xRAiepYsVBw9sFlsOrBpWnaOJpjeb0GA
	 j8GlenStbonuWp/ducEx6UEa2+4eccGV1VHUG92G3CuGqG/4TQD1Q+ui4Sq0O+NOLj
	 a1BYJMtwa0NidptbKm2L+vSXPUPidni41j0uRAn0J4MCEVeH3PTi5oCcNFlCOuqMqB
	 nyCTKiFvA5t/5kLIXyoGQJLOfPY8dbfFrjG9JYikWmqskBxIS/onQDaXpiliCnoZsR
	 DaL48nfu4sbuA==
Date: Mon, 22 Apr 2024 17:55:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ben Gainey <ben.gainey@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Anne Macedo <retpolanne@posteo.net>,
	Changbin Du <changbin.du@huawei.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Li Dong <lidong@vivo.com>, Paran Lee <p4ranlee@gmail.com>,
	elfring@users.sourceforge.net,
	Markus Elfring <Markus.Elfring@web.de>,
	Yang Jihong <yangjihong1@huawei.com>,
	Chengen Du <chengen.du@canonical.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 00/12] dso/dsos memory savings and clean up
Message-ID: <ZibOs-_ASLcZrnFa@x1>
References: <20240410064214.2755936-1-irogers@google.com>
 <ZhgvE7i9HGGar1eX@x1>
 <CAM9d7chWBv14hD4huuoas4ncZaziuTnHi_JvieKqrLZF9fDpPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chWBv14hD4huuoas4ncZaziuTnHi_JvieKqrLZF9fDpPw@mail.gmail.com>

On Mon, Apr 22, 2024 at 01:06:46PM -0700, Namhyung Kim wrote:
> On Thu, Apr 11, 2024 at 11:42 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Apr 09, 2024 at 11:42:02PM -0700, Ian Rogers wrote:
> > > 12 more patches from:
> > > https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
> > > a near half year old adventure in trying to lower perf's dynamic
> > > memory use. Bits like the memory overhead of opendir are on the
> > > sidelines for now, too much fighting over how
> > > distributions/C-libraries present getdents. These changes are more
> > > good old fashioned replace an rb-tree with a sorted array and add
> > > reference count tracking.
> > >
> > > The changes migrate dsos code, the collection of dso structs, more
> > > into the dsos.c/dsos.h files. As with maps and threads, this is done
> > > so the internals can be changed - replacing a linked list (for fast
> > > iteration) and an rb-tree (for fast finds) with a lazily sorted
> > > array. The complexity of operations remain roughly the same, although
> > > iterating an array is likely faster than iterating a linked list, the
> > > memory usage is at least reduce by half.
> >
> > Got the first 5 patches, would be nice if more people could review it,
> > I'll try and get back to is soon.
> 
> For the series:
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

It is not applying right now, I've just merged with torvalds/master and
I'm running build tests now, will push to tmp.perf-tools-next right now.

- Arnaldo

