Return-Path: <bpf+bounces-52871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE55A4985B
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 12:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2140C3AC218
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199025F79A;
	Fri, 28 Feb 2025 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UoObaZf5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D81C3BE3;
	Fri, 28 Feb 2025 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740742445; cv=none; b=C41TpsTUfaO7hnxeqIHxkTciLUWL6EVBhLVoJjJLdWQlPMoNxbtumMjdaJPcdsMp2xOeQo0bp0VFkXciQdH3t9VeI22PbfqwvZd5m8K73uuoH8uj5rQhHZSvMmhSp2FvHlR8oc2NIqZNR1+ePy+cgW+Mc/FB+bMJA4XTLM6+GQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740742445; c=relaxed/simple;
	bh=+ooH810v2Blnl06gBk8VGSH/EQNPRumC/0B28lSVPfM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p0tTSofeig+wK8Y9pfv6clSn84qHnevnKw1kMx/fStp3n12fwSGtpZXDFNY9Fs5o8dnO7mAuGh+H5j5tQ9zcL8K7dIqupdib8En23j3fKi0SfE/PXaoMWTRt3Icb+uzsFtpxizIhOqpCgGLcruAIJfEZaK7viDPJiCjl17RYr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UoObaZf5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAcxxM012173;
	Fri, 28 Feb 2025 11:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sy22I2
	QlpySMqXVInfw3InidJMO5UXmG9SzBQFajTLo=; b=UoObaZf5nzgXkCaHac1ZFP
	/8DVIpyRY0iYgRVU9mm2qguRSzZw6SZ4Kv9+ba2k8ekuc3l5NCb+txg7M5iEw9Iw
	uXFuubx1WWmTa8x8l7E89bbeuwTiV0kwtdaU4o36ao2emLpKgHrtVLKv/QW0CI8n
	bTdxWVE7D1usTdbhjGxhdt7U9VLFI2KxKceekxyElNevMuWbOHTXpg+jKuV1tSvn
	5jkSP+4GQX/D11/Ll1CK/8YPcnr2ma9eoZnxp4Z3zCypIP931xERcalNrzaSk+Wz
	9L2GkwH3VXMwoUzDYL6hnYzKmqe9htw44osy/LTGTJyi4T9OcX5SQDZ6WtTxX0BQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45337ajnk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 11:33:26 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51SBPi6w010851;
	Fri, 28 Feb 2025 11:33:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45337ajnk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 11:33:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51S9EXWG012522;
	Fri, 28 Feb 2025 11:33:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9yxe0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 11:33:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51SBXM1S47579632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 11:33:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FCCD20040;
	Fri, 28 Feb 2025 11:33:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 644EB2004B;
	Fri, 28 Feb 2025 11:33:17 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.241.152])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Feb 2025 11:33:16 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 1/3] perf ftrace: Fix latency stats with BPF
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20250227191223.1288473-1-namhyung@kernel.org>
Date: Fri, 28 Feb 2025 17:03:03 +0530
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        bpf@vger.kernel.org, Gabriele Monaco <gmonaco@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3946D74A-64EA-4D9E-826F-ECACC6487083@linux.ibm.com>
References: <20250227191223.1288473-1-namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lDI89ePHIRn4bxUzb9PBUpRYBA32iUKP
X-Proofpoint-GUID: tfGqt6fuzijannxJF8MB-E7opk4XnEBD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280083



> On 28 Feb 2025, at 12:42=E2=80=AFAM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>=20
> When BPF collects the stats for the latency in usec, it first divides
> the time by 1000.  But that means it would have 0 if the delta is =
small
> and won't update the total time properly.
>=20
> Let's keep the stats in nsec always and adjust to usec before =
printing.
>=20
> Before:
>=20
>  $ sudo ./perf ftrace latency -ab -T mutex_lock --hide-empty -- sleep =
0.1
>  #   DURATION     |      COUNT | GRAPH                                 =
         |
>       0 -    1 us |        765 | =
#############################################  |
>       1 -    2 us |         10 |                                       =
         |
>       2 -    4 us |          2 |                                       =
         |
>       4 -    8 us |          5 |                                       =
         |
>=20
>  # statistics  (in usec)
>    total time:                    0    <<<--- (here)
>      avg time:                    0
>      max time:                    6
>      min time:                    0
>         count:                  782
>=20
> After:
>=20
>  $ sudo ./perf ftrace latency -ab -T mutex_lock --hide-empty -- sleep =
0.1
>  #   DURATION     |      COUNT | GRAPH                                 =
         |
>       0 -    1 us |        880 | =
############################################   |
>       1 -    2 us |         13 |                                       =
         |
>       2 -    4 us |          8 |                                       =
         |
>       4 -    8 us |          3 |                                       =
         |
>=20
>  # statistics  (in usec)
>    total time:                  268    <<<--- (here)
>      avg time:                    0
>      max time:                    6
>      min time:                    0
>         count:                  904
>=20

Tested in powerpc for the total time change in usec before and after the =
patch.
After the patch, shows non-zero in total time.

# ./perf ftrace latency -ab -T mutex_lock --hide-empty -- sleep 0.1
#   DURATION     |      COUNT | GRAPH                                    =
      |
     0 -    1 us |         38 | ##############################           =
      |
     1 -    2 us |         19 | ###############                          =
      |
     2 -    4 us |          1 |                                          =
      |

# statistics  (in usec)
  total time:                   53
    avg time:                    1
    max time:                    2
    min time:                    0
       count:                   58

Tested-by: Athira Rajeev <atrajeev@linux.ibm.com>

> Cc: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> tools/perf/util/bpf_ftrace.c                |  8 +++++++-
> tools/perf/util/bpf_skel/func_latency.bpf.c | 20 ++++++++------------
> 2 files changed, 15 insertions(+), 13 deletions(-)
>=20
> diff --git a/tools/perf/util/bpf_ftrace.c =
b/tools/perf/util/bpf_ftrace.c
> index 51f407a782d6c58a..7324668cc83e747e 100644
> --- a/tools/perf/util/bpf_ftrace.c
> +++ b/tools/perf/util/bpf_ftrace.c
> @@ -128,7 +128,7 @@ int perf_ftrace__latency_stop_bpf(struct =
perf_ftrace *ftrace __maybe_unused)
> return 0;
> }
>=20
> -int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace =
__maybe_unused,
> +int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace,
>  int buckets[], struct stats *stats)
> {
> int i, fd, err;
> @@ -158,6 +158,12 @@ int perf_ftrace__latency_read_bpf(struct =
perf_ftrace *ftrace __maybe_unused,
> stats->n =3D skel->bss->count;
> stats->max =3D skel->bss->max;
> stats->min =3D skel->bss->min;
> +
> + if (!ftrace->use_nsec) {
> + stats->mean /=3D 1000;
> + stats->max /=3D 1000;
> + stats->min /=3D 1000;
> + }
> }
>=20
> free(hist);
> diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c =
b/tools/perf/util/bpf_skel/func_latency.bpf.c
> index 09e70d40a0f4d855..3d3d9f427c20876e 100644
> --- a/tools/perf/util/bpf_skel/func_latency.bpf.c
> +++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
> @@ -102,6 +102,7 @@ int BPF_PROG(func_end)
> start =3D bpf_map_lookup_elem(&functime, &tid);
> if (start) {
> __s64 delta =3D bpf_ktime_get_ns() - *start;
> + __u64 val =3D delta;
> __u32 key =3D 0;
> __u64 *hist;
>=20
> @@ -111,26 +112,24 @@ int BPF_PROG(func_end)
> return 0;
>=20
> if (bucket_range !=3D 0) {
> - delta /=3D cmp_base;
> + val =3D delta / cmp_base;
>=20
> if (min_latency > 0) {
> - if (delta > min_latency)
> - delta -=3D min_latency;
> + if (val > min_latency)
> + val -=3D min_latency;
> else
> goto do_lookup;
> }
>=20
> // Less than 1 unit (ms or ns), or, in the future,
> // than the min latency desired.
> - if (delta > 0) { // 1st entry: [ 1 unit .. bucket_range units )
> - // clang 12 doesn't like s64 / u32 division
> - key =3D (__u64)delta / bucket_range + 1;
> + if (val > 0) { // 1st entry: [ 1 unit .. bucket_range units )
> + key =3D val / bucket_range + 1;
> if (key >=3D bucket_num ||
> - delta >=3D max_latency - min_latency)
> + val >=3D max_latency - min_latency)
> key =3D bucket_num - 1;
> }
>=20
> - delta +=3D min_latency;
> goto do_lookup;
> }
> // calculate index using delta
> @@ -146,10 +145,7 @@ int BPF_PROG(func_end)
>=20
> *hist +=3D 1;
>=20
> - if (bucket_range =3D=3D 0)
> - delta /=3D cmp_base;
> -
> - __sync_fetch_and_add(&total, delta);
> + __sync_fetch_and_add(&total, delta); // always in nsec
> __sync_fetch_and_add(&count, 1);
>=20
> if (delta > max)
> --=20
> 2.48.1.711.g2feabab25a-goog
>=20
>=20


