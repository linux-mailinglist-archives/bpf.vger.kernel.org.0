Return-Path: <bpf+bounces-9185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C5C7917D7
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 15:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2139C280F7C
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED04AD5F;
	Mon,  4 Sep 2023 13:11:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE8442D
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 13:11:04 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E52AB6
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 06:11:03 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384D7oWE004620;
	Mon, 4 Sep 2023 13:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oRS0f20t+mi4WPhtxdbJOjDmC/acb6FDsNYbfNgRK2k=;
 b=n130b57callbJjh5vBADeY7LwyLAis6/nuMIR9Af4gad6W6ZRsByUqchz0phfkMfVakJ
 aurOX2atzH5Q3XN4RhhWfKRxn14UsAZSi0EgkVG0J003rOED/+fb/JGOWIZRXpIeJ99u
 oyn/v6in7p2m9o2zg59s0lSHyx6o4QONpQAIsRD15fG49pmNp2wXmtzsICOHi0rcCdsD
 zVibuiOl0wQ0puKS6nr4FxVj0hzQuN6Xa1Ln0XGDRHQpXecU0/GpLKyfVMmoqCM+vkvj
 jHSDpGT7SdxIJx9aM7L/nxPbLUSvAPWNOdpEnh1LDPFX8O2fl2H9NZHdA+SGYAMSz2GB xw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw7s7bnsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Sep 2023 13:10:42 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 384DAfQK014310;
	Mon, 4 Sep 2023 13:10:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw7s7bnrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Sep 2023 13:10:41 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 384CaCjB026770;
	Mon, 4 Sep 2023 13:10:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcn2u93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Sep 2023 13:10:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 384DAcvi49348968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Sep 2023 13:10:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 211A62004E;
	Mon,  4 Sep 2023 13:10:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87BAA20043;
	Mon,  4 Sep 2023 13:10:37 +0000 (GMT)
Received: from [9.171.57.13] (unknown [9.171.57.13])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Sep 2023 13:10:37 +0000 (GMT)
Message-ID: <aa14035136254ce08bd605242173432394103abd.camel@linux.ibm.com>
Subject: Re: [RFC PATCH bpf-next v4 0/4] bpf, x64: Fix tailcall infinite loop
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Leon Hwang <hffilwlqm@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, maciej.fijalkowski@intel.com
Cc: song@kernel.org, jakub@cloudflare.com, bpf@vger.kernel.org
Date: Mon, 04 Sep 2023 15:10:37 +0200
In-Reply-To: <20230903151448.61696-1-hffilwlqm@gmail.com>
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rPCtaJFquoLHtIvS06yrL6Y-BmnQx_9Z
X-Proofpoint-GUID: eYRbgQgOWF-nYRvD1Ot8YezEmSUvcqyY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 mlxlogscore=607 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309040117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 2023-09-03 at 23:14 +0800, Leon Hwang wrote:
> This patch series fixes a tailcall infinite loop on x64.
>=20
> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and
> tailcall
> handling in JIT"), the tailcall on x64 works better than before.
>=20
> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF
> subprograms
> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
>=20
> From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF
> program
> to other BPF programs"), BPF program is able to trace other BPF
> programs.
>=20
> How about combining them all together?
>=20
> 1. FENTRY/FEXIT on a BPF subprogram.
> 2. A tailcall runs in the BPF subprogram.
> 3. The tailcall calls the subprogram's caller.
>=20
> As a result, a tailcall infinite loop comes up. And the loop would
> halt
> the machine.
>=20
> As we know, in tail call context, the tail_call_cnt propagates by
> stack
> and rax register between BPF subprograms. So do in trampolines.
>=20
> How did I discover the bug?
>=20
> From commit 7f6e4312e15a5c37 ("bpf: Limit caller's stack depth 256
> for
> subprogs with tailcalls"), the total stack size limits to around
> 8KiB.
> Then, I write some bpf progs to validate the stack consuming, that
> are
> tailcalls running in bpf2bpf and FENTRY/FEXIT tracing on bpf2bpf[1].
>=20
> At that time, accidently, I made a tailcall loop. And then the loop
> halted
> my VM. Without the loop, the bpf progs would consume over 8KiB stack
> size.
> But the _stack-overflow_ did not halt my VM.
>=20
> With bpf_printk(), I confirmed that the tailcall count limit did not
> work
> expectedly. Next, read the code and fix it.
>=20
> Finally, unfortunately, I only fix it on x64 but other arches. As a
> result, CI tests failed because this bug hasn't been fixed on s390x.
>=20
> Some helps on s390x are requested.

I will take a look, thanks for letting me know.
I noticed there was something peculiar in this area when implementing
the trampoline:

	 * Note 1: The callee can increment the tail call counter, but
	 * we do not load it back, since the x86 JIT does not do this
	 * either.

but I thought that this was intentional.


[...]

