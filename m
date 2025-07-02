Return-Path: <bpf+bounces-62111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AA0AF1578
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3C7189E3F3
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 12:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597AC26E173;
	Wed,  2 Jul 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tQAUgaYG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7926A090;
	Wed,  2 Jul 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458853; cv=none; b=bfYGIBcOjBZI+TQi02pByey+kDM3zr2KCnFwiQVtjszYw1zG7FTxopVdkuFj01G2O9dje2iXNDnJYom0H94nHdNM01ala/xEeBff0XnaagyhcZnQ2mI6RF6pQO1Qxn8Gb4kDAOwKfyMUwRKwkOjbnRwsK1OYwMB9kzLd/94jcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458853; c=relaxed/simple;
	bh=r1RRnmHC+fZLpTW3fqjbqGzuJWKTcRrBGANv/Cc9i70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzyV4xp6Tt+Fx7AQE3o+FB5GzyAV2K8V5cTNbFuQ22xpvJhVsKei1gwipVjl1b/6hcEbiFU+X/G1W20SdReQNHcvIEha64G59hSX7Jr7U7pGBBBN45BTMInL5mFPFm6PbySf5tNKVM+TH68WBMj8ctZs3LhZ17BFSmtWU+SIkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tQAUgaYG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562C5jqN015498;
	Wed, 2 Jul 2025 12:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M9zIsC
	qEmF+CdKIAtl8yghoK30TMlyYCs0mt36XHacI=; b=tQAUgaYGKEnIao30/9C4pC
	oGle8rpDgwOqIM6YkSefu0BV3ETUbMAxSabMh1w+LbjQzNBFdSVfouXmPW1iG1Qo
	zkTt44jk2e3I+UMimK0lZQP/cZeG3lsQhsHaoEL3o4uFRTdWGp0GRB3ayBfGzaZJ
	wJCgt5cwv8Go/7X8gc4XhwdE6dkYjMjwoqp9LHwJr+jsEZfIcbYEkE3p+68o96Kg
	7K83cAvkYnwr4xlCNt0g0VebhxOQP6dP4Qw50i3y0ndcJ44Lmj4japf/wI25byXB
	zKiTkETJMBmEYmWJtLteycCQWiaJh3AJiWihvHgomhQpgQskecmH2pTBOC12rHVg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrndxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 12:20:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 562ALCTp011840;
	Wed, 2 Jul 2025 12:20:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7mybsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 12:20:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 562CK8Tl21365086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 12:20:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F2B920040;
	Wed,  2 Jul 2025 12:20:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 337852004E;
	Wed,  2 Jul 2025 12:20:08 +0000 (GMT)
Received: from [9.152.222.224] (unknown [9.152.222.224])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 12:20:08 +0000 (GMT)
Message-ID: <8446a4a9-023f-4f74-a15c-82450f239c13@linux.ibm.com>
Date: Wed, 2 Jul 2025 14:20:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/11] perf: Support deferred user callchains for per
 CPU events
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20250701180410.755491417@goodmis.org>
 <20250701180456.716085204@goodmis.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250701180456.716085204@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=686523fe cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VEqhm_vXFi0XNEmMTr8_J5BmE51JLvYV
X-Proofpoint-ORIG-GUID: VEqhm_vXFi0XNEmMTr8_J5BmE51JLvYV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEwMCBTYWx0ZWRfX8jq7pcZePAxi 6OtP5B0EWMzldnhljWrsUOjNsFHwBYw9PW/4y0FXHE2k22hHBitvxqpsKDBEeEI8XIHxysGPC5n Yenh0LYlt5ZMz8uetyrGaXvqvipQXJeM1Ls6ZFhs5GJHdhVp7JhaPaQrK8U0wmYLeYxtn8+PXtn
 yUU6SfO1rQlvK+1f4s1KriZOwbb3hpwuIMspFy5yDYYz8ZxXe0nZg8ro9DjLp1rq6oP4hyAo3T2 FADS4gtHAVD2yLHzBTDbQvC11c6J0PxZeCr1lmo8Y4F/t2/n0G2sJs6DJ5ZJFF2cmXps4rP4gTo s0SguKd/jURs9SRanwDRedUtJnF4LO7Wl+aUN4YCTGyYZMt01CC5HJKMgnnf1Tl3YW6E4AeMsvs
 iPy2y50nexebu8h022/wqgltzR9DPH29fWrgKm5hgzRSNdClHw8QjkaKgzuLOg8iAxSObjT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020100

Hello Steve!

On 01.07.2025 20:04, Steven Rostedt wrote:

> diff --git a/kernel/events/core.c b/kernel/events/core.c

> @@ -5609,62 +5784,119 @@ static void perf_pending_unwind_sync(struct perf_event *event)
>  
>  struct perf_callchain_deferred_event {
>  	struct perf_event_header	header;
> +	u64				timestamp;
>  	u64				nr;
>  	u64				ips[];
>  };

Nit: Please update the following related comments when making changes to
struct perf_callchain_deferred_event.

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 184740d1e79d..08ce721e79bc 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1248,6 +1248,7 @@ enum perf_event_type {
 	 *
 	 * struct {
 	 *	struct perf_event_header	header;
+	 *	u64				timestamp;
 	 *	u64				nr;
 	 *	u64				ips[nr];
 	 *	struct sample_id		sample_id;
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 184740d1e79d..08ce721e79bc 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1248,6 +1248,7 @@ enum perf_event_type {
 	 *
 	 * struct {
 	 *	struct perf_event_header	header;
+	 *	u64				timestamp;
 	 *	u64				nr;
 	 *	u64				ips[nr];
 	 *	struct sample_id		sample_id;

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


