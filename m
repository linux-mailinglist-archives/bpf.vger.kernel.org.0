Return-Path: <bpf+bounces-76414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2725CB3462
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 16:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA685300A6E3
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEACE26ED31;
	Wed, 10 Dec 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cvLXkc72"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110822BAF4;
	Wed, 10 Dec 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765379828; cv=none; b=U3+FmnSsbJqz3infXe3mUZjW0cw34Xzv/EOe7y2a6zW5SbKNBZ3vL/Y5+N0nXjVX5Cyr+WEH4vwwtvlzaaHH97lBfQf6tTNu7lRtSARAHh+xmJipFgEFwJyREEEcd5L9Qjc8bOAkXOrdkRkq1TCQ2uQf1WQ4UtTOSW50HkvYw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765379828; c=relaxed/simple;
	bh=StNPX8edmutLaT5NZTi8Panl8ODVbfBBuuPD6j/b/GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSBYtRdFsMDCS4E92uPsXkFmmfEu3eyWkmzKoWEbkeiakJF9e6pdJl8U1e3l7dQ3P1Uq2Bt3hD0DeocVAtU3mToiPfiaRnLuieAlurW2ZsWeBP8qfoyL1fSnQdGiAc3O1l1NHQsQc3yWXuG9NnTTrkfODD39tEwFhneJiwXotqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cvLXkc72; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAE4kR3000613;
	Wed, 10 Dec 2025 15:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nLGqRfkuXy5fTNpu5pbnPbSlDfSmWm
	Ow58TN41H+4k4=; b=cvLXkc72bhbx/BSUOzkVrvtooTbVR3rsEzjF3OR+4vXTQy
	tVv/Vn0K6Q7AeZKaZeVX6aMt9YRL3uT2tSqVmLm5MlF/Hh0o54hculZltdvivzmF
	udAWy82WTdkYwtR0Y5Gqx2UgWTvIrqpWKoyFxM5WlZKGuPceirEud8EIbeXaB7yo
	EpxkCkpwrUvNy1okSmIXRFzZpRbRc2/zce3OAJgOmRG12m6yw20nQ5FW+Bej0k/i
	J6tN3/rC2aSk0qfCv5IYnsEhYeY7UHzQKJZU9NNJE3DAHHgpfS9WrdtipTI8rGFk
	jBQCiy3AlLGF4v7wlB0/MwDnbY8EId3suf0fcc8g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0k32dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 15:16:46 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BAF4VeV009838;
	Wed, 10 Dec 2025 15:16:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0k32da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 15:16:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BADPaU2028123;
	Wed, 10 Dec 2025 15:16:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6y1cdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 15:16:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BAFGdHQ36635026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 15:16:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F6CA20043;
	Wed, 10 Dec 2025 15:16:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE2EF20040;
	Wed, 10 Dec 2025 15:16:37 +0000 (GMT)
Received: from osiris (unknown [9.111.15.174])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Dec 2025 15:16:37 +0000 (GMT)
Date: Wed, 10 Dec 2025 16:16:36 +0100
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
Subject: Re: [RFC PATCH v3 05/17] s390: asm/dwarf.h should only be included
 in assembly files
Message-ID: <20251210151636.40732C96-hca@linux.ibm.com>
References: <20251208171559.2029709-1-jremus@linux.ibm.com>
 <20251208171559.2029709-6-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208171559.2029709-6-jremus@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=69398ede cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=62EC5onNXgn9lpaB:21 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=jgzeNuNnndWrP1aWhNsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: IzMGYfQcab_wGRB3kfvVhm8a1JSw9nq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfXz7a0VpZ+qZ6r
 HGMAJpaZScuifm9deX34oqY/AjankVzvy4F7kLKQV5ivP6gZvMBV96jvBfbqr0a9Ckz+28KSTOF
 n819AOQryx9JM/4lE6AC0txmmSKtHvItP4cbhFwV6w+kiDHoIHvGGE1oTkKEnzp3y/vxcTVw58l
 793v3Fq4DuaopBRkt5KJVEdNgiCjuKYkzJUixfnJHG2zGHxe0uRNxtLb3QooMZ+ePs2psEPjAfZ
 dO8lmjrOK9Pa2xk+RlVQzBa6QHmfk2LYkA2ji9SivTXv7ytq8SpSKDvRivpovh8M8P+jRN7a8bn
 nvK/A9jd08MxRmvc3/MZTEZW3Wyq44rbVwMWpmNMaRTmmRvOcV0tTKdUh6+hLcfxjlkQsxAkZAU
 7WRa9qmsY8n3i9gTPSLrQLM26sMCgA==
X-Proofpoint-GUID: VXt6i1_e8pTA6HDA6kBjlxF1tGWRYeFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016

On Mon, Dec 08, 2025 at 06:15:47PM +0100, Jens Remus wrote:
> Align to x86 and add a compile-time check that asm/dwarf.h is only
> included in pure assembly files.
> 
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
> 
> Notes (jremus):
>     Changes in RFC v2:
>     - Adjust to upstream change of __ASSEMBLY__ to __ASSEMBLER__.
> 
>  arch/s390/include/asm/dwarf.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Is there a reason why this and the next two patches couldn't go upstream
already now? It looks like they improve things in any case.
No dependency to the sframe work.

