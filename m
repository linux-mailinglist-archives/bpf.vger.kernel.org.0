Return-Path: <bpf+bounces-61756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8705AEBCFD
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 18:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843C61C271F8
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B56E1BD9F0;
	Fri, 27 Jun 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BJFZkKBC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45281A2387;
	Fri, 27 Jun 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041181; cv=none; b=o8F3JZZlflWE3yWil9cSR+8OBtWpSu/IjR/LbL+o27kcymtczX5XOfSdvhxtL0nosCcagytOzZ4h1FOXbgJT6RkwH7DDpxQIB7Ifgra+lLfeG1CKnOyfiMsAqrMBKre7H6Vibpwh1aKoDACbnpvA+qF1bvg/iWJBJV6tQpy0VDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041181; c=relaxed/simple;
	bh=dojDUaknWsQhUppWGBTY+TtDVjglusnc/IomcJ2SaIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQ1iPh4Cd5HGxuY0ypL64b9vXMb3ucjK3sMTY2SfYUE1RnTs+NUggDIUQOm2mWv6gUeWjcONVq1wGDjTZws8K04+Z2RC1zgnEqyQbqV1BKJ3b0hpPUOv6//1pdjuvZCONEn7VK2++WtnXfi27I+nEq1Zqj+H8r8aVPGZIfHFKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BJFZkKBC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R8JAGo015779;
	Fri, 27 Jun 2025 16:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AUUGAs
	jTPjmQje0zk6ojyUek1SCo7u8kOCyALn0F/Qw=; b=BJFZkKBCRZPUNFOUJOnQTk
	NgIXC236oayhZRazl7BsxP6YfeXqMvcMRb825QsVgk6Uekkdy/58yOHB6dtNdcxY
	Jxk3O9qwbYGHhJvwDkC/H0iTUiMQj5HbsH+8KRUVbAx/LZvC0HjfGNaH5LJFyRb5
	jrE7cE3+XrJZ0c0IEvTMG7exDdyt0Gp8qCjh8WtmrAlf6WxoErflk4VSAFMb8/SJ
	xklccYaoBZhSkN8W7EteIPQcomXYVl7uUnmj7F/67iI9LWhv9E9s7k1Lmm/1J9nN
	puS3Fsaa0ViDFZgjLS0PfnEzU7MG5WFQ2hiTxc5Yy1LZjPD+O5TOduQKccoFhquA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jxmyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 16:19:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCb3AG006414;
	Fri, 27 Jun 2025 16:19:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pn06r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 16:19:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55RGJ7E342992004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 16:19:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AA5A20040;
	Fri, 27 Jun 2025 16:19:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FB992004B;
	Fri, 27 Jun 2025 16:19:06 +0000 (GMT)
Received: from [9.111.156.254] (unknown [9.111.156.254])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 16:19:06 +0000 (GMT)
Message-ID: <75c074f7-ed3c-4302-a962-b62b6ff644f5@linux.ibm.com>
Date: Fri, 27 Jun 2025 18:19:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/12] unwind_user/sframe: Wire up unwind_user to
 sframe
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
        Andrew Morton <akpm@linux-foundation.org>
References: <20250617225009.233007152@goodmis.org>
 <20250617225118.194027083@goodmis.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250617225118.194027083@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzMiBTYWx0ZWRfX5EOajJCM7rtq tJX1uS3QJ5qywbpBYkqH7VjetMeliH2CFgCFjf/+QkYQzXnoyw8XxjBnCsxfRI/DApJe8o/SVA9 HDxP+jVWMnsmHicIzJoRmcaBqor8aYFZR34Ke7pDrIt19JyZ3rMH0fG9KbHjiGFp+0Gj9LXwjZn
 9LNeAMqCSZi5SMo9RG75MIEDwNBw3OyFMaAWkpi3N+ZcNTypyPCyVSa3I/QCETXtnobAhU7zIbm Wk63pvU4qUMqzXnl4UikOoGHflSbdiutp1YAyZ7pr/KxQdbaHN91Ro4T1aiaBPija1nXCguXGGc u5yvMhD2ZZRy9oQj9Ww/y+JvfDbfWesNqFu5HV3Azg64BzXphCgJiaU4pBvCozjX7J/ZAFs+k+I
 4W7a2cc5riB9p13Dvl/TMnzGFksjfFdpslZr4c810GYtCTQZOHCW3dy7UDzTrN5gPl/cLv3f
X-Proofpoint-GUID: 5jdiw-_Y8CleflV2OaRKTJR6UdrRSA12
X-Proofpoint-ORIG-GUID: 5jdiw-_Y8CleflV2OaRKTJR6UdrRSA12
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685ec47f cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=mmEVG2U_Ztk9iETfGqQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270132

On 18.06.2025 00:50, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Now that the sframe infrastructure is fully in place, make it work by
> hooking it up to the unwind_user interface.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c

> @@ -41,17 +48,27 @@ static inline bool compat_state(struct unwind_user_state *state)
>  int unwind_user_next(struct unwind_user_state *state)
>  {
>  	struct unwind_user_frame *frame;
> +	struct unwind_user_frame _frame;
>  	unsigned long cfa = 0, fp, ra = 0;
>  
>  	if (state->done)
>  		return -EINVAL;
>  
> -	if (compat_state(state))
> +	if (compat_state(state)) {
>  		frame = &compat_fp_frame;
> -	else if (fp_state(state))
> +	} else if (sframe_state(state)) {
> +		/* sframe expects the frame to be local storage */
> +		frame = &_frame;
> +		if (sframe_find(state->ip, frame)) {
> +			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
> +				goto the_end;

Nit: s/the_end/done/

> +			frame = &fp_frame;
> +		}
> +	} else if (fp_state(state)) {
>  		frame = &fp_frame;
> -	else
> +	} else {
>  		goto the_end;
> +	}
>  
>  	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
>  

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


