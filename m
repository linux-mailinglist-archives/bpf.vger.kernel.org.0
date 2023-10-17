Return-Path: <bpf+bounces-12389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7C77CBB1E
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 08:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4F0B20F8C
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 06:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5911CB6;
	Tue, 17 Oct 2023 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BCiykHq4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB81172F
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 06:26:39 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543088F
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 23:26:38 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H6HvA0006940;
	Tue, 17 Oct 2023 06:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+73/2wPnPNxmFPUZq/B9BygRXaaF2dst6aEwt+T6i44=;
 b=BCiykHq4y7lasvrvci8A6ORFIbJV0ALEPYnzZlcv+hSb+VwYK9NQk9qE2HXIRXPL9539
 MKW+FViyel8gpDC8Hr4f3PR9GuzIkWB/DrQqm3aQW/j2xHjVMuhGvyuUqMDG7uiOQzcV
 229+1OsXfsylnBENT+Q6ZmqP2+TP6IEA8tkPmOWV11Wg6QbDNJpksVl2yiw6VgOW8i8p
 iFieg7BcKK6T5VD2dGguvuomtBypNRvroOeUqtXIoQC5qijwRHnuNCRA55KH38Yq/Su6
 lqFKVIoQuZDNfcpUqpxsjSxAwzjvKZ1M2neQZ0m80IC0isw/Xwq1FZujcj1A31cOpIep Pg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsmm00xr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Oct 2023 06:26:19 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39H4knC1030723;
	Tue, 17 Oct 2023 06:26:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr7hjduru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Oct 2023 06:26:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39H6QBNe21758552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 06:26:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E164420040;
	Tue, 17 Oct 2023 06:26:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4705920049;
	Tue, 17 Oct 2023 06:26:10 +0000 (GMT)
Received: from [9.203.106.137] (unknown [9.203.106.137])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Oct 2023 06:26:10 +0000 (GMT)
Message-ID: <ebb698eb-5629-afbf-ffa6-9a8f6fdee71c@linux.ibm.com>
Date: Tue, 17 Oct 2023 11:56:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 0/5] powerpc/bpf: use BPF prog pack allocator
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
References: <20231012200310.235137-1-hbathini@linux.ibm.com>
 <140a1e76-dfa4-d20e-fc10-09b4f3a85cb4@iogearbox.net>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <140a1e76-dfa4-d20e-fc10-09b4f3a85cb4@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jSiDE-gPRdjw-W0p4Ur6OBRutXzC_aDm
X-Proofpoint-ORIG-GUID: jSiDE-gPRdjw-W0p4Ur6OBRutXzC_aDm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=525 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170051
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 16/10/23 5:37 pm, Daniel Borkmann wrote:
> On 10/12/23 10:03 PM, Hari Bathini wrote:
>> Most BPF programs are small, but they consume a page each. For systems
>> with busy traffic and many BPF programs, this may also add significant
>> pressure on instruction TLB. High iTLB pressure usually slows down the
>> whole system causing visible performance degradation for production
>> workloads.
>>
>> bpf_prog_pack, a customized allocator that packs multiple bpf programs
>> into preallocated memory chunks, was proposed [1] to address it. This
>> series extends this support on powerpc.
>>
>> Both bpf_arch_text_copy() & bpf_arch_text_invalidate() functions,
>> needed for this support depend on instruction patching in text area.
>> Currently, patch_instruction() supports patching only one instruction
>> at a time. The first patch introduces patch_instructions() function
>> to enable patching more than one instruction at a time. This helps in
>> avoiding performance degradation while JITing bpf programs.
>>
>> Patches 2 & 3 implement the above mentioned arch specific functions
>> using patch_instructions(). Patch 4 fixes a misnomer in bpf JITing
>> code. The last patch enables the use of BPF prog pack allocator on
>> powerpc and also, ensures cleanup is handled gracefully.
>>
>> [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
>>
>> Changes in v6:
>> * No changes in patches 2-5/5 except addition of Acked-by tags from Song.
>> * Skipped merging code path of patch_instruction() & patch_instructions()
>>    to avoid performance overhead observed on ppc32 with that.
> 
> I presume this will be routed via Michael?

Yes, Daniel. This can go via linuxppc tree.

Thanks
Hari

