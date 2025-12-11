Return-Path: <bpf+bounces-76462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9406CB566E
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 10:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13CD330456E1
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049682F7AA3;
	Thu, 11 Dec 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GBFb2+Fk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21BF2D5C83;
	Thu, 11 Dec 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446255; cv=none; b=gqG7rpSwMG5Y77hEIUYgtHBoQeGqiD2Qzv6vSqBBaCmO8/4W5ZjFPWykF+CteEgJrtltnobwl5KIsL0GotE/zsimrIycRf7w8L6cOp7kZJA7iNl/ONUuBfN5OiAiex6CiFFyppnBNYnienqfgPnwq3M/9SIEO9EE/v8YwqaBwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446255; c=relaxed/simple;
	bh=D+cmyrsZQVAh2W/giFHJiiGkqAYiu0cvjDOq7WnpF5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcbVU2+p423p4RKGlQrvj8vhptkVyv3I+DwQJUK8pXK1X3yEXnM7ZCISLAfvXo5dUIxKATE0Yn2BcYW32YJqXi2yfdUUd1Kq4YcKc0Y0V2H1zqzk4R1PxNUvk+nFwKM+fAHZf25JoDvL81OwqI/00iTMicBVRpeeqJWI4prXi38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GBFb2+Fk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BB2NIXF028098;
	Thu, 11 Dec 2025 09:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FD8maE
	HeTgDD71fz+2/5BPQXB7msWRXHabxVFcpu/Po=; b=GBFb2+FkWsOeFj5sfRxm5I
	D5AlOKUnvhfkKHyUuBPwI+4I8oV7k0V4qfF8SYyLBAzBfRZ6G+FQN4dC3RMyva01
	JA2NAjgguR3joGqqjEuvUO0KCcZd9K0CFqMASf4fdsAlFWbq5QYkX6AyvqeCOH6m
	F7xLYrvNkqNWs52ZUXQDgi36GE91F+/FGjyx5eZ2mw8oIR+QcXREiH32M3/DRBjp
	+0V7t2eOip9C1MRn0juawvz+GiVhNpqeLf6eYLQziFcSv6pwD1+T4llte6b1i1eE
	e6zqZrhUPylXCsOrNqMAqMxItLm7rOEKDSgDexjfKP/gQrj1xaxQ6VhSro8AsCtw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53pamc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 09:43:45 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BB9faXG023078;
	Thu, 11 Dec 2025 09:43:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53pama-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 09:43:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BB8XFdO012425;
	Thu, 11 Dec 2025 09:43:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ak5fcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 09:43:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BB9hdJV19333646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 09:43:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A184A20043;
	Thu, 11 Dec 2025 09:43:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C30320040;
	Thu, 11 Dec 2025 09:43:37 +0000 (GMT)
Received: from [9.111.167.168] (unknown [9.111.167.168])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Dec 2025 09:43:37 +0000 (GMT)
Message-ID: <84d843d7-d827-4945-b1f5-78189e63753d@linux.ibm.com>
Date: Thu, 11 Dec 2025 10:43:36 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/17] s390: asm/dwarf.h should only be included in
 assembly files
To: Heiko Carstens <hca@linux.ibm.com>
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
References: <20251208171559.2029709-1-jremus@linux.ibm.com>
 <20251208171559.2029709-6-jremus@linux.ibm.com>
 <20251210151636.40732C96-hca@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20251210151636.40732C96-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX4Xjlv3yyQSZB
 2GOKiYgU9tycGA3ef8DQ9txByK/m4hbZLgHyfZG3YTcxSwWFzfZ6bgkEcz8NyBb/mJy5qlEnUBw
 9t1GTraPwBNpf0NLzZhW4R/47WyF4WH7QJuJ8ib0ae/Shayz4u/ZyPaLsSv8/ZTIWSK3AhsdIBG
 llKdLQ2WNR2/HpUod6PsTtZF1GI0lcSuiMJR/oSoWD/k8q7dbl0a3bY6ve+iy9tuP+TJ6n9+HsN
 UI0Bdr+SCrRf/y3pJFUyjYHFEz8hObL6GhsTZrcwrXP2g2SLhlPFuzT93WSwJ7jlT80QoLH9Nwh
 gIIb7s2eQ3ej3tqDoyuOtgi9JvSv4z8WODE2TGbzr8PmelpUosjlKaI3HGzWhTZOoOw1kTODO8T
 +RTFLHVhWqk6dk2MoeuRscfMRgHaGA==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=693a9251 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=62EC5onNXgn9lpaB:21 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=qXztJ9kz0_brgplrvAIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3gelZydcZdPV3ZIYmrk0w-Gsmm1pMOXj
X-Proofpoint-GUID: KM7DR54WwKW8nE1qjDjXvs63VtVcksTo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

On 12/10/2025 4:16 PM, Heiko Carstens wrote:
> On Mon, Dec 08, 2025 at 06:15:47PM +0100, Jens Remus wrote:
>> Align to x86 and add a compile-time check that asm/dwarf.h is only
>> included in pure assembly files.

> Is there a reason why this and the next two patches couldn't go upstream
> already now? It looks like they improve things in any case.
> No dependency to the sframe work.

They probably could go upstream now.  At least this one.  For the two
other patches the question is whether we want to wait for whether the
respective x86 changes go upstream, as their descriptions claim to align
to x86.

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


