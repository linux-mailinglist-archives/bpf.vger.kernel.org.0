Return-Path: <bpf+bounces-76413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9DDCB342E
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 16:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 281D9305F7ED
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CC13112DC;
	Wed, 10 Dec 2025 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BotcddGy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C7273F9;
	Wed, 10 Dec 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765379491; cv=none; b=W/tSa3A9YeqkvuQI/luqzm4Qth/eOuGL84/LVoyh0oE6UbXvwiBMQnd8S1v4naTNOHzAFioWet9qz+RwQhzMgu2boQAdOGJGykz4SKdGuTrCyCSb9VO0nispECGa4gVq7nLouvnFxJyb/yhiolB+vKdNuiODYOtr/NyB6bJIswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765379491; c=relaxed/simple;
	bh=D0iKQhZACwRoqu3xD+l1oKy8JLv/MH/BqgDjLj6XGi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHPjbS8zbf3MkN8fg1xyQfas/2CeYFVntExAMELeIHaCDLgPSUR8iKlV6YvlQc/yovpvP3GBoMV+3OC2Xu0j+lEsWS0M3p3ptAVXJxqwrTUkROCMiD73bEQzB1WI1QuHIqev3T3e7E+FiJYmk/xzzz2Vk27pMQNpGVQWj3fQ2SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BotcddGy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BA41Jg9002482;
	Wed, 10 Dec 2025 15:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=uK2zxZ2q5AmsaLIahS9HgIU8HhP5ET
	F71z6t4/GZg1I=; b=BotcddGywGryZ1+aT0vk/IMpcAx2v2B+HYhHZBXfBYj+J0
	SSO3AwgVdtCs8j5ZuLaz9kSX3NMmUlmEAWHUQ4LxKlgfMMatrrGlYv5sciyU3czP
	aRE6RsiNUtYEqUexwUSyFDaEaqUuOQxrPryDL4n3SnJ5lPpR+1X9zb4I7neVqMji
	I7MwRd5WxMKeVYqArmiOPn4j1pP3gZq7xEeH6YCrf899+3zj9ib93+BuWzDhASky
	UnlvD4i0i+0F2eVkCUKFJJxV3czBGStEUNJu9IKwP/tk6Ijj7lphRG7j2vS61pxN
	Jlk/yT9GnY38GAgRFVezNcMeojaerHZmMpatadrw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7c30e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 15:10:20 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BAEhHAa001036;
	Wed, 10 Dec 2025 15:10:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7c30e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 15:10:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BADSRvp030714;
	Wed, 10 Dec 2025 15:10:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxts9cy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 15:10:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BAFAFxq61800746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 15:10:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54F5F20043;
	Wed, 10 Dec 2025 15:10:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E357C20040;
	Wed, 10 Dec 2025 15:10:13 +0000 (GMT)
Received: from osiris (unknown [9.111.15.174])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Dec 2025 15:10:13 +0000 (GMT)
Date: Wed, 10 Dec 2025 16:10:12 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: Re: [RFC PATCH v3 14/17] s390/unwind_user/sframe: Enable
 HAVE_UNWIND_USER_SFRAME
Message-ID: <20251210151012.40732B79-hca@linux.ibm.com>
References: <20251208171559.2029709-1-jremus@linux.ibm.com>
 <20251208171559.2029709-15-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208171559.2029709-15-jremus@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YBUUIRv3MZQ5Ku7u4sKGBo-lV5mrVIia
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX8LNS9RfAzjUo
 ZMp6a66I3UhyY1eCsG6JpbwVVkY4jMxTS3+VIFVTNMlc7AqYwXTGMQeRQuFLV+9lo7BQv/NyKaN
 gouuFzLkHEeP/XRoEyEzbDPtADE0Dd+YtE1odosL8HslIpReGA7Gtcpz+/x83nk9x8A0VmSJDHa
 0+9P16JLW748bcj6zgnIDVYrJ3t3GiFltY4zSO0iyUrz/y0vOKe1pGXqxR6Ljbz8AL+9zO0MFbG
 TjoEFFMlf9m9bXQ4DIrEt7SPWpoFsLw1+/9/fe6ExB5fgtQvhLcATM47ifX/6cEI/teOX2y0OCf
 UUcvY3l9cDOO47mevpa7mYPpwRUOsVrfU9R+NOBCc62cTt46opsLlzB3Cu3QhAoFSnEj6+d3Mql
 39QAp2HrFZ4rGcZJ092iEWBwhCiO6A==
X-Proofpoint-GUID: 2wxzMWDHXZy-GzasDm6EcMscapuhkCrM
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=69398d5d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=UjrV1-PU3I0w5ibNVf4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

Hi Jens,

On Mon, Dec 08, 2025 at 06:15:56PM +0100, Jens Remus wrote:
> +static inline int __s390_get_dwarf_fpr(unsigned long *val, int regnum)
> +{
> +	switch (regnum) {
> +	case 16:
> +		fpu_std(0, (freg_t *)val);
> +		break;
> +	case 17:
> +		fpu_std(2, (freg_t *)val);
> +		break;
> +	case 18:
> +		fpu_std(4, (freg_t *)val);
> +		break;
> +	case 19:
> +		fpu_std(6, (freg_t *)val);
> +		break;
> +	case 20:
> +		fpu_std(1, (freg_t *)val);
> +		break;

IIRC, I mentioned this already last time. But it is not correct to access user
space floating point register contents like this. Due to in-kernel fpu/vector
register usage the user space register contents may have been saved away to
the per-thread vxrs save area, and registers may have been used for in-kernel
usage instead.
Read: the above code could access lazy register contents of in-kernel usage.

Change the above to something like:

	struct fpu *fpu = &current->thread.ufpu;

	save_user_fpu_regs();
	switch (regnum) {
	case 16: return fpu->vxrs[0].high;
	case 17: return fpu->vxrs[2].high;
	case 18: return fpu->vxrs[4].high;
	case 19: return fpu->vxrs[6].high;
	case 20: return fpu->vxrs[1].high;
	...

save_user_fpu_regs() will write all user space fpu/vector register contents to
the per-thread save area (if not already saved), and then it is possible to
read contents from there.

I'll see if I can provide something better for this use case, since this code
needs to access only the first 16 registers; so no need to write contents of
all registers to the save area.

