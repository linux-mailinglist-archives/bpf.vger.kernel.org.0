Return-Path: <bpf+bounces-41085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6459924FA
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 08:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED851C22209
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 06:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2BA1531CC;
	Mon,  7 Oct 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pSWACBqj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA742077;
	Mon,  7 Oct 2024 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283073; cv=none; b=b17XHz4MMeAhdR/YTya06StCxHtw3GNjlpcCrBk78s17tqPuO/QMMli9Lm5su9JvIIiqJK+YW8IAX0Wb5431HKO1w4t3+8fch+28JgISnNMQoEBJKkd7a8OEzFWjZwYbERontJKBhHcsNvPXmaL4lKPDXLLXMcv8C5YRk3C8ENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283073; c=relaxed/simple;
	bh=g3GXP9seX/Xrl0OzEkq2gfliNxDJLE2Ij/C6kPicpNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eF7gbUIYOhK8T63K2DPhhmdPWXjKHuGe/RFFEISU9ZPTpB+O/Z2yhHqATyaWEOGNqdjUTjKqAqh+whkcAIa+UIVkJSglvSGkDHk0FX/8otHowea8HaYwZ0zsvLnhgC9IPH3BL86nxawO8D42sSW9V24+MUS8dNQjfsTRTDbEk2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pSWACBqj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4976Qwur025893;
	Mon, 7 Oct 2024 06:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type; s=pp1; bh=Gxo1OKB3S+0RplzV70T8W45kSo
	KYWYadm5u+4O2vvpY=; b=pSWACBqj91deO3CvxA3v6q7zSoZXnHlSm5kpZdnila
	1rlb9NU76gttKrEUQixXwg5CfOTKBMi5LlAjidaH3ai856CydzlXcd3WMXNBMKqS
	8CadAoV/edcuH8/s+tOZu5LSo85dxzeXdgmTGdsXxqlUgp+zvkJa2iGldkkbVyfb
	zUQi1KPCf0trAGIvsWj2udb7yGQ7iS9OKQOhH+oBy895tIUQsf27yeiWlPHbt9Ta
	7ulgxkJBRESzG0KKhfughjWygJBM1xSC3ywZyaIOJBCkmS+4l0Np40ICx+nMbwVn
	bli+60/7jYWTzhjRcuO8RkpmWZ6cjEv3cv3Io5MpsWUw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424acng1a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 06:37:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49751HGH022867;
	Mon, 7 Oct 2024 06:37:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0mnfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 06:37:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4976baPl51642628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 06:37:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11B4A20043;
	Mon,  7 Oct 2024 06:37:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C91CF20040;
	Mon,  7 Oct 2024 06:37:35 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  7 Oct 2024 06:37:35 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland
 <mark.rutland@arm.com>,
        Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 6/7] tracing: add support for function argument to graph
 tracer
In-Reply-To: <20241004184008.151c64a7@gandalf.local.home> (Steven Rostedt's
	message of "Fri, 4 Oct 2024 18:40:08 -0400")
References: <20240904065908.1009086-1-svens@linux.ibm.com>
	<20240904065908.1009086-7-svens@linux.ibm.com>
	<20241004184008.151c64a7@gandalf.local.home>
Date: Mon, 07 Oct 2024 08:37:35 +0200
Message-ID: <yt9dldz0v2og.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4aHDxItS7uoT3n1D7BVzH9brNcC0nBxM
X-Proofpoint-ORIG-GUID: 4aHDxItS7uoT3n1D7BVzH9brNcC0nBxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-06_21,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 mlxlogscore=650 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070045

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed,  4 Sep 2024 08:59:00 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> Wire up the code to print function arguments in the function graph
>> tracer. This functionality can be enabled/disabled during compile
>> time by setting CONFIG_FUNCTION_TRACE_ARGS and during runtime with
>> options/funcgraph-args.
>
> I finally got around to looking at your patches. Do you plan on still
> working on them? I really like this feature, and I'm willing to do the work
> too if you have other things on your plate.

Yes, working on other things, so feel free to take over.

