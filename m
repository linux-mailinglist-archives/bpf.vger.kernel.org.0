Return-Path: <bpf+bounces-18916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EDC8236D6
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BB22876B4
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8281D55E;
	Wed,  3 Jan 2024 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5Hh2//e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E31D54E;
	Wed,  3 Jan 2024 20:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4342C433C7;
	Wed,  3 Jan 2024 20:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704315332;
	bh=AeTKh3wRabFnQ1yuK+vyl+Mc6+9kDxEh7vO32+RO5Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5Hh2//e7rRibhQAqELfRdXJ8t5GJI43thG2563X9Z65lUWLC/4445nICOSZmhcsp
	 AjYUL/xmOm1BrAfesT3Q1yKO96Y97obfWM6o72WpyyVAOol0/oKLOPiNY1mxukdB8Y
	 eDiTiJVbhpIuIzQnhj/8ui3yXl/eTDrNOyqI+gM9/i/9YVrQhlfVj3Oq5fy/Ch6UK+
	 w48pUxJXvaFFnB+jfAOxSWQ5m0WFhx5AS0Gx0+8uAsdEr1yChBmcuu1XtSPHTAve7I
	 8KpSMJAGBXhEImItfgF2rDIWlwyBz3csh5TMDAyGrdF6U9zr3B8rnNEVB1h8ifeY25
	 tNK4CS3wVZeZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 49369403EF; Wed,  3 Jan 2024 17:55:30 -0300 (-03)
Date: Wed, 3 Jan 2024 17:55:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ming Wang <wangming01@loongson.cn>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1] perf env: Avoid recursively taking env->bpf_progs.lock
Message-ID: <ZZXJwsYlGxYoQOeP@kernel.org>
References: <20231207014655.1252484-1-irogers@google.com>
 <CAP-5=fWdAouBb7us44HOdd+ZfBj5fLFTuLCokbG8w3jVuQgTxw@mail.gmail.com>
 <ZZWK43OPvGcd-BAR@kernel.org>
 <CAPhsuW6EZ-FoZFbCuxs7gAa0OaQGw0zMLDaeEsNoU31vjXijnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6EZ-FoZFbCuxs7gAa0OaQGw0zMLDaeEsNoU31vjXijnQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Wed, Jan 03, 2024 at 09:40:26AM -0800, Song Liu escreveu:
> On Wed, Jan 3, 2024 at 8:27 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Applied, with that minor patch reduction hunk and this:

> > Fixes: f8dfeae009effc0b ("perf bpf: Show more BPF program info in print_bpf_prog_info()")

> > Song, can I have your Acked-by?

> LGTM. Thanks for the fix!

> Acked-by: Song Liu <song@kernel.org>

Thanks! Added to the cset.

- Arnaldo

