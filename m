Return-Path: <bpf+bounces-64884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F38B181ED
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 14:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFDE1C82CAE
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496132472BC;
	Fri,  1 Aug 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c+jFatqc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6981123E358;
	Fri,  1 Aug 2025 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051889; cv=none; b=TMBeOgBmgRIrqqqF3jCaXtIdwTRVv2ay6SMSoMOnLt8KHBX9sKz9UWNh6gCCtxxaWoOR48V6aOqZvjmfayBMCimVydWVsg7hZpeH5oZw49rdKI0EqG+PfLTgY0C6FQO1Thm8HaQhZbRgembDUkkPgpzhDYHM5T0vdLr6X2VD8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051889; c=relaxed/simple;
	bh=Ye/8ymgyTNlqL0+zOaZUdjRrgZzlqEJB2KZfvCVzt78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBDzOXqL3WMxXq7wIZRyoPSMmYGy3begpmTNm9Y33bWe4XtbEmJk8y6+XbWWYj6Ul4hwmqGBHZ8sMaKa1o3ulXtUE8vbv7Fd1FNpESbNjQVpRtvw1h36Dl66OSUaadO7UDpe2iKfJPJ9FYAWc2RAm5YjqVwtHFltYV0j0vWBm+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c+jFatqc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5716CRrY022019;
	Fri, 1 Aug 2025 12:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=foCGo2d0YHQot57U02sfDowq93U1Hl
	JgNTX8LWFZ2NY=; b=c+jFatqc+1VFPTlKTyrUOvQIlKNLDdPbmb8a38dX2HTflO
	iy7U9Lt6z4UXgHfCM67wiBqXbYhr1qNXCPWL2aktClS/rJrNt3ox8KpFSBL9xAcK
	XwB5qWYlS0OgfSM/MyFQsSDTpgODwuBnWWKhk33ZiWwHDZbgfm6XkSPDcUXvT9XW
	yWWFtpCoke/T8r9qv9k+okOZYTuJ0qCnn4um7IgRnoKMI+bj0GIwLBcbDzg/owgZ
	NCUHMbMImhmM5vDoCX11vLIITX3xIkGrnlpBT0CM0MnrTkSGY+ZSNz5yILqH65n9
	NxUSm/p98M0ugSMqkJS4ydrqKoa/bVYk8uOw6p5Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qen8q0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 12:36:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5719Kjio016406;
	Fri, 1 Aug 2025 12:36:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485aun18qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 12:36:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 571Can9433685958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 12:36:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9436C20043;
	Fri,  1 Aug 2025 12:36:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DB6D20040;
	Fri,  1 Aug 2025 12:36:48 +0000 (GMT)
Received: from osiris (unknown [9.111.82.186])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  1 Aug 2025 12:36:48 +0000 (GMT)
Date: Fri, 1 Aug 2025 14:36:47 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, Steven Rostedt <rostedt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
        Sam James <sam@gentoo.org>
Subject: Re: [RFC PATCH v1 12/16] unwind_user/backchain: Introduce back chain
 user space unwinding
Message-ID: <20250801123647.9905A43-hca@linux.ibm.com>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-13-jremus@linux.ibm.com>
 <a4dd5okskro2h45zmqgg3etj6uwici2hoop2uaf6iqrlaej7yh@xlduwjqke4ec>
 <63665c54-db44-452f-b321-1162ff6c3fe4@linux.ibm.com>
 <ddwondzj74rr3fgvsdnkch7trrcwltasb236hvvx5tnywf2lhu@vo47rcoyu2nc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddwondzj74rr3fgvsdnkch7trrcwltasb236hvvx5tnywf2lhu@vo47rcoyu2nc>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wmg_jJYi_bAxFEdtwgpPXeefh0YLfbdi
X-Proofpoint-GUID: wmg_jJYi_bAxFEdtwgpPXeefh0YLfbdi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA5MiBTYWx0ZWRfX1Kf3ofBZeGu1
 QofOzzqthUplNvFwtwQYixbImxKlfN1xZT8EfXqd13DTYS1bwEpz1jejGIxtcSTmlMvLsiH8HGm
 B1SKosiCxTz39sR0NomiFtBWyML7ROuf0dzeJWMwefF4q3cHWmacBR/2+HC4bOf76TZx9uKndSY
 0tjnQHBo7JWgpLOCT9F38jAI6VGAeRZ8fhGyZYaS580zJ9Di/ocxBByG2aFM8o7QZ8xO7+kdFpJ
 RA65SxfwkzkA1F4Kmlox97bj5+uboCOGWe80/JbgaCzJZAAD+pvbkNK4XSB3fd72vDuKZAV8sIB
 ypbhdM/g/EUxFjaPY/8sBtt8zkuRq6PUPjwPwA9GfwZ4QU1m6sYQbScEuAfWWHEhvauieThPVMH
 EtjHZdzD3QkdQuTePaYv7iwrINOljCk+lXi3dqAeZ8F7yL7cZwDlsc+4O+D8H2sA3CG3OqwF
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=688cb4e7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=1JbVbOoES49UGEVtLQsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=585 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010092

On Thu, Jul 17, 2025 at 10:19:54PM -0700, Josh Poimboeuf wrote:
> On Thu, Jul 17, 2025 at 02:20:12PM +0200, Jens Remus wrote:
> > > Also, if distros aren't even compiling with -mbackchain, I wonder if we
> > > can just not do this altogether :-)
> > 
> > My original intent was to use unwind user's for_each_user_frame() to
> > replace the exiting stack tracing logic in arch_stack_walk_user_common()
> > in arch/s390/kernel/stacktrace.c, which currently supports backchain.
> > Given that for_each_user_frame() was made private in the latest unwind
> > user series version hinders me.  The use was also low, because the
> > currentl arch_stack_walk_user_common() implementation does not support
> > page faults, so that the attempt to use unwind user sframe would always
> > fail and fallback to unwind user backchain.  My hope was that somebody
> > with more Kernel skills could give me a few hints at how it could be
> > made to support deferred unwind. :-)
> 
> I believe stack_trace_save_user() is only used by ftrace, and that will
> no longer be needed once ftrace starts using unwind_user.
> 
> Maybe Heiko knows if that backchain user stacktrace code has any users?
> 
> If distros aren't building with -mbackchain, maybe backchain support can
> be considered obsoleted by sframe, and we can get away with not
> implementing it.

I guess that's a valid option. I know only of some special cases where
users compile everything on their own with -mbackchain to make this
work on a per-case basis. It shouldn't cause to much pain for them to
switch to sframe, as soon as that is available.

