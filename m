Return-Path: <bpf+bounces-41456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E970E9972F5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 19:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A622B25FE8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA211A2860;
	Wed,  9 Oct 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm955dqR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46E1CACDC;
	Wed,  9 Oct 2024 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494477; cv=none; b=JOQ4Htq0CrhTfMDCCcv3Nuci/q0/h2IdHCT/nBRwlPJI7IyVuVyuv8VRsrBhKINC1jGXJI+GqWwvEzTJIrWZDFHyS6+rAeWCkDLdiJcmj7jI3STUyI6OSoiBfjNpVAq9zE7D8aD5sSx00YM5Cb5WGevrPtbs6EnGz6q6QXVmTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494477; c=relaxed/simple;
	bh=rCf8yMbgXLtkOA9XPz6ccGxNhT7P4jQxTu74RTuyTVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWAhI18px7h8JYXP6JDVQilSkMRmOZxgpZVo9NltQJLjYHr2paRWBLAymB/Q88HwSJHAarnEmLQEd80vJgJ0J46ecvB0FjuMkfCIa5VA0jPCPlUa4hKPlNoaKWqup0dvZPMtINEVfHMI4RDubCuGRTQruWO7G+fJPei12KdNPXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tm955dqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D569C4AF0B;
	Wed,  9 Oct 2024 17:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728494477;
	bh=rCf8yMbgXLtkOA9XPz6ccGxNhT7P4jQxTu74RTuyTVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tm955dqRsIhOjCzwNtV6QO1WdjWvKR4cqoWH2mPJhOI4wz5W6IsbN6WG49c+HL3Rz
	 hni6r16adLJjSfBFIFnbEYPBjJsIKT7XXAJtzJcE3Fr/bRJp3sGVMWhWeJNeUGyv1R
	 XI13JUoeJqxrelrXfNxFUX0e6qLf17dl2x4U8TttjPmXP9hgKWgXszFlZHkcYJNNVt
	 ZsDx3YdBrjDM9niFFUSl+W5Mv6bax2+b+ml+eb/SvvtbfOqp5EeRHkMXn842uc0/5P
	 k3P9tGrDEAbhPcTzwI/ldOpNolmZz1kB1dsES3DaabbfuHF0eZYG8J0Vs2t5bBSeMm
	 cFbWk8PvVkF8Q==
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a344f92143so390035ab.2;
        Wed, 09 Oct 2024 10:21:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUEHJcU74DKuOq8dX9IY6cwzV5vhKJoV7wxXrBeDbLAmudTsX8nVdJv2iY9CFihDn3uTTWD9kHX4YT8lrrLIDrAA==@vger.kernel.org, AJvYcCVgFhVDdZ/pk+afHLM6DXaLtymE/GJxHVOtgqoymsQtJerdobSwtL59K3tGTzwSjN0m9v50qdCv2A1oUYZL@vger.kernel.org, AJvYcCVn5H/k0H/JYzclr2Bhuoo++gtI7gJxp8qW878k0YfxAkrwQbLq7q1g6xTdj0daZDu2qXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBMHSUU6oxItzja8SDML227cwWp4SCC1xrVx2JKuO+3898rNx
	POLzPHYO8qHEhDsY1H1kWqR2YCR5c8TyuUyhFS9l9ZlgpHnymDw6T1RcDP3PSxWeuGJYS/AE6hY
	zyTVt3oeUXNnWNFOmz8Vfg8+soDo=
X-Google-Smtp-Source: AGHT+IFwPtqzDEV5XywrmUHQUyahczwb9o6pAUKRBj80/PfHH5NmR10iqcscZqFtJDfbEjDenSz5mpual8GNQ4AnqXY=
X-Received: by 2002:a05:6e02:18cc:b0:3a2:7651:9846 with SMTP id
 e9e14a558f8ab-3a397cf1543mr29439885ab.13.1728494476517; Wed, 09 Oct 2024
 10:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916014318.267709-1-wutengda@huaweicloud.com>
 <729eef63-6aed-44db-b18a-eb4bf96aeaab@huaweicloud.com> <ZvTYduigMBtlmNbK@google.com>
 <ZwYS4FEP5yMOCXEv@google.com>
In-Reply-To: <ZwYS4FEP5yMOCXEv@google.com>
From: Song Liu <song@kernel.org>
Date: Wed, 9 Oct 2024 10:21:05 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5nDNicW5Pbavt60Q9W0rcgzLPRnfP7794T-SL0PkugAA@mail.gmail.com>
Message-ID: <CAPhsuW5nDNicW5Pbavt60Q9W0rcgzLPRnfP7794T-SL0PkugAA@mail.gmail.com>
Subject: Re: [PATCH -next v3 0/2] perf stat: Support inherit events for bperf
To: Namhyung Kim <namhyung@kernel.org>
Cc: Tengda Wu <wutengda@huaweicloud.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Tue, Oct 8, 2024 at 10:21=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Sep 25, 2024 at 08:43:50PM -0700, Namhyung Kim wrote:
> > Hello,
> >
> > On Wed, Sep 25, 2024 at 10:16:16PM +0800, Tengda Wu wrote:
> > > Hello,
> > >
> > > Sorry for pinging again. Is there any other suggestion with this patc=
h set?
> > > If there is, please let me know.
> >
> > Sorry I was traveling last week.  I think it's good now.
> >
> > Song, can I get your ack?
>
> He seems to be very busy.  I'll pick this up and run some tests.

Sorry for the late reply. I somehow missed the earlier email.

I have a question and a nitpick for 1/2. Otherwise, this looks good
to me.

Thanks,
Song

