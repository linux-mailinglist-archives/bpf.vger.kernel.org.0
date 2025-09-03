Return-Path: <bpf+bounces-67255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F94B417FC
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 10:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE771BA3C26
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A216A2E2F0E;
	Wed,  3 Sep 2025 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l+qdVHF0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5A2E62B3;
	Wed,  3 Sep 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886826; cv=none; b=YqnkZvQ4YWJ0wb6IKDLBLSnmu8FAgrH8Lb8nj4Ts2swfqkR//6Eso5qrZuu192s/aWr0edd0pXeZSYvw7+F/WNgJlutn4ZPHVaDrdj7LK+IjVJ/DUSCsVi2NvXywPqMitW/yb+iKRV7Q9tsg8W7ocWHnUAN0YwMXcb44aptZWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886826; c=relaxed/simple;
	bh=CeCM/HmjZliMLnHkBvZkg72p0Kg5C8W0aOUbx0JRgAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WSnj0SvAiePvq7qD2vmXQ2THCW95jH+8SdFfqWMpMFkov+aUQuactAPXvCeboa3Eu/42DL78y966chWBNP4RWqmtM0UiFkhJnYCEYXuiAz3pYkRy6FESFiH4tbVbDf2QzydUhHsumkq2c2E4EGS4gvOZvNuYWXMfQduvuE7f2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l+qdVHF0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Nffc4004032;
	Wed, 3 Sep 2025 08:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mJRYJJ
	iGP3O9OmhSaZUakyOS2WjUvaQxrQqD8pIfL50=; b=l+qdVHF0vDyRMtwaebUoIj
	z2iDp0yC30Zvzlx4E1dtOGBP2UUtPm68/zYHrMxaBDyImWaQC5pOkapvOEWuPkm0
	Wa/maFl4XV8LUqY/kCnJg1kbFU9GCqfPK1Nax6Z/YEGgi6ix2GKhYVH4UGEln+Im
	OuMAxum2fDIBxU8avLT29fWaLxHyqlkF18sK79qNHqZQCpDXhjFXbmk/3euQw1Da
	M/xGDIKt/RMZPcLkd8pR6W6ML8tjCvcyTEDW1ka84745/Qz2JaPuCJk45fVHByiG
	Ar3yGRktQRmUABSVI7XT4gdyKrsP+5Clew6+xJ4gSx63XzTKwamlQ5CVstMUDtUg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvftp2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 08:06:48 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5837pAAa012647;
	Wed, 3 Sep 2025 08:06:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvftp29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 08:06:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5836IqKV019404;
	Wed, 3 Sep 2025 08:06:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4mxcv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 08:06:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58386jfv60752372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Sep 2025 08:06:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CCE92004B;
	Wed,  3 Sep 2025 08:06:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBD7B20040;
	Wed,  3 Sep 2025 08:06:44 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Sep 2025 08:06:44 +0000 (GMT)
Message-ID: <03b13088-8dae-4d68-8594-6523b4aee406@linux.ibm.com>
Date: Wed, 3 Sep 2025 10:06:44 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Legacy hardware/cache events as json
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
        Thomas Falcon <thomas.falcon@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>,
        Leo Yan <leo.yan@arm.com>, Vince Weaver <vincent.weaver@maine.edu>
References: <20250828205930.4007284-1-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=behrUPPB c=1 sm=1 tr=0 ts=68b7f718 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=h0uksLzaAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=KByoUL483hSIROooWq4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=MSi_79tMYmZZG2gvAgS0:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: y5jHuvcz1AvdARQJzfuyJqumQ_eV1ZXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX1kek//mDJGNd
 TmMxhEX7iwrmfwBFMFWnTVNlXuoKChTkUkqA78axxAm43Flnt5eW7uUGaRh0GLgUpBVY+0WaX3J
 5KWn5Jl0UkjswVxxqzL9nZBleXR3cfH7wtclGw6Bk0R5Szk2lY+/MzOf8N+3EfsRemld13Ql9hk
 RVN5qr/hLKlxZKvwMzYXEfik1cd4BiPmJ/L/t8BkyWa+9ZihmqFUPglPO8OJ1maoecGUmt/Z92g
 SgjZ1KHXARlYmYFmnPYn0BopVW9kXg809Lnetz7AEX4wAeS1TKdu0XoOU1kbNzNW5Th9Eh85dOC
 Z6d0EMDCbkCBHLqPrHLK6OfiTYYcrIF/pQow2VoSGrlDAfGouwkLgOiy0EWRdFDL7fmIVf3+9og
 L6Vw68VN
X-Proofpoint-GUID: cjcZczKn9cVb7gI_Smn-YkYgwY_C4PT9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

On 8/28/25 22:59, Ian Rogers wrote:
> Mirroring similar work for software events in commit 6e9fa4131abb
> ("perf parse-events: Remove non-json software events"). These changes
> migrate the legacy hardware and cache events to json.  With no hard
> coded legacy hardware or cache events the wild card, case
> insensitivity, etc. is consistent for events. This does, however, mean
> events like cycles will wild card against all PMUs. A change doing the
> same was originally posted and merged from:
> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> his dislike for the cycles behavior on ARM with perf record. Earlier
> patches in this series make perf record event opening failures
> non-fatal and hide the cycles event's failure to open on ARM in perf
> record, so it is expected the behavior will now be transparent in perf
> record on ARM. perf stat with a cycles event will wildcard open the
> event on all PMUs.
> 
> The change to support legacy events with PMUs was done to clean up
> Intel's hybrid PMU implementation. Having sysfs/json events with
> increased priority to legacy was requested by Mark Rutland
>  <mark.rutland@arm.com> to fix Apple-M PMU issues wrt broken legacy
> events on that PMU. It is believed the PMU driver is now fixed, but
> this has only been confirmed on ARM Juno boards. It was requested that
> RISC-V be able to add events to the perf tool json so the PMU driver
> didn't need to map legacy events to config encodings:
> https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
> This patch series achieves this.
> 
> A previous series of patches decreasing legacy hardware event
> priorities was posted in:
> https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
> Namhyung Kim <namhyung@kernel.org> mentioned that hardware and
> software events can be implemented similarly:
> https://lore.kernel.org/lkml/aIJmJns2lopxf3EK@google.com/
> and this patch series achieves this.
> 
> Note, patch 1 (perf parse-events: Fix legacy cache events if event is
> duplicated in a PMU) fixes a function deleted by patch 15 (perf
> parse-events: Remove hard coded legacy hardware and cache
> parsing). Adding the json exposed an issue when legacy cache (not
> legacy hardware) and sysfs/json events exist. The fix is necessary to
> keep tests passing through the series. It is also posted for backports
> to stable trees.
> 
> The perf list behavior includes a lot more information and events. The
> before behavior on a hybrid alderlake is:


.....

For s390 the whole series:

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

