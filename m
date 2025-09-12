Return-Path: <bpf+bounces-68219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A520AB545F6
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 10:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081B6563DC1
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD8C275AE6;
	Fri, 12 Sep 2025 08:50:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BE919E97A;
	Fri, 12 Sep 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667046; cv=none; b=PGI65DUrd0I47f9QXtoDqAx0NmQCnPzt9DxklHm5YQiZDw/Skc8XFuaUNuJXY/0Ws1OMmUJyWtDsk51/dOTdI/uY+wJg6d+HoD1a+RCP4c25ogGnAK3IWx6eqGubQwcxWKNmOXQprgR7Ag1mYov0wIdrICPF+YACLbPkd1gnpFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667046; c=relaxed/simple;
	bh=kOCT0uKL+2GCzdTJlM237/8qYHdNnAgbYOdpMlv95/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9ql1hq8l/2fg1fjtwdUl/x3nQ+wX2N5nHN38M5N5n9j46AH/4yK3pM2pmhZluxWpAcuisFvOEB7nvN/F7Qs8h0c1jMvM8fiCaAkOMLZU1yWIqUdZeiYHkRephl5+BgXYhNpvKvab7544oodDiLcV7d7qQR+EDWGcGZa+lYI5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cNSNn3h8zz9sjC;
	Fri, 12 Sep 2025 10:32:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qrMr2wDWbrGI; Fri, 12 Sep 2025 10:32:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cNSNn2wqYz9sjB;
	Fri, 12 Sep 2025 10:32:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4DFD58B7A7;
	Fri, 12 Sep 2025 10:32:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id zoIQp3eX62gY; Fri, 12 Sep 2025 10:32:57 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C9D828B764;
	Fri, 12 Sep 2025 10:32:56 +0200 (CEST)
Message-ID: <7ded6ce4-1fcb-4e2d-94ab-5c330de6aea0@csgroup.eu>
Date: Fri, 12 Sep 2025 10:32:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] perf: Completely remove possibility to override
 MAX_NR_CPUS
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <b205802edbb6fcc78822f558dff7104e64b29864.1755510867.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <b205802edbb6fcc78822f558dff7104e64b29864.1755510867.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/08/2025 à 11:57, Christophe Leroy a écrit :
> Commit 21b8732eb447 ("perf tools: Allow overriding MAX_NR_CPUS at
> compile time") added the capability to override MAX_NR_CPUS. At
> that time it was necessary to reduce the huge amount of RAM used
> by static stats variables.
> 
> But this has been unnecessary since commit 6a1e2c5c2673 ("perf stat:
> Remove a set of shadow stats static variables"), and
> commit e8399d34d568 ("libperf cpumap: Hide/reduce scope of
> MAX_NR_CPUS") broke the build in that case because it failed to
> add the guard around the new definition of MAX_NR_CPUS.
> 
> So cleanup things and remove guards completely to officialise it
> is not necessary anymore to override MAX_NR_CPUS.
> 
> Link: https://lore.kernel.org/all/8c8553387ebf904a9e5a93eaf643cb01164d9fb3.1736188471.git.christophe.leroy@csgroup.eu/
> Fixes: e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Gentle ping

Thanks
Christophe

> ---
>   tools/perf/perf.h                        | 2 --
>   tools/perf/util/bpf_skel/kwork_top.bpf.c | 2 --
>   2 files changed, 4 deletions(-)
> 
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 3cb40965549f..e004178472d9 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -2,9 +2,7 @@
>   #ifndef _PERF_PERF_H
>   #define _PERF_PERF_H
>   
> -#ifndef MAX_NR_CPUS
>   #define MAX_NR_CPUS			4096
> -#endif
>   
>   enum perf_affinity {
>   	PERF_AFFINITY_SYS = 0,
> diff --git a/tools/perf/util/bpf_skel/kwork_top.bpf.c b/tools/perf/util/bpf_skel/kwork_top.bpf.c
> index 73e32e063030..6673386302e2 100644
> --- a/tools/perf/util/bpf_skel/kwork_top.bpf.c
> +++ b/tools/perf/util/bpf_skel/kwork_top.bpf.c
> @@ -18,9 +18,7 @@ enum kwork_class_type {
>   };
>   
>   #define MAX_ENTRIES     102400
> -#ifndef MAX_NR_CPUS
>   #define MAX_NR_CPUS     4096
> -#endif
>   #define PF_KTHREAD      0x00200000
>   #define MAX_COMMAND_LEN 16
>   


