Return-Path: <bpf+bounces-11555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E51F77BBE7A
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 20:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C479F282163
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 18:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B673536B04;
	Fri,  6 Oct 2023 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BOWZxJeS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D72AB3B
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 18:13:23 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C824BF
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 11:13:22 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396IC3kl027033;
	Fri, 6 Oct 2023 18:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uG89KsPrCmOIbR7tpcHiLM6LXCzlK59QVw5m4kwOAjg=;
 b=BOWZxJeS8DSAkFT9+9xNfEabc6F1FrTZkLs7dctXDho+KFz/y16nwyW5C5n6oYoyks+H
 Um2v4PiTdZcJiLOv+ywZ95bqb6kazDleeqG0HomUDExbDOMw+2GmDnELiMuLg2EvMJLI
 Vaayg9y437+ry3S0H/oRMfnBLKq7YkmiG+02ALur0zEh5UHo4XqfLGYsVkPQ/LGxYMZw
 Tsj+ANnETVeEnrWeNPI9D5T5zqdq9uL2olsATszr0+P8sLfeXEtFv9QbfNxaTo+qEHpE
 Rv5hR5+6qF5eGEpW8CWgVCMy6mupkQHj+4F6nJT4JDeleNe72VQCxT5X6ywEmD/u4pk+ RQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjqa980wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Oct 2023 18:13:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 396HmNMK007428;
	Fri, 6 Oct 2023 18:12:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3teygn3cxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Oct 2023 18:12:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 396IClr724838844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Oct 2023 18:12:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD26020040;
	Fri,  6 Oct 2023 18:12:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 612A42004D;
	Fri,  6 Oct 2023 18:12:46 +0000 (GMT)
Received: from [9.43.70.9] (unknown [9.43.70.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Oct 2023 18:12:46 +0000 (GMT)
Message-ID: <159f0096-5b39-04c4-aaea-64e0742fb192@linux.ibm.com>
Date: Fri, 6 Oct 2023 23:42:45 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/5] powerpc/code-patching: introduce
 patch_instructions()
Content-Language: en-US
To: Song Liu <song@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20230928194818.261163-1-hbathini@linux.ibm.com>
 <20230928194818.261163-2-hbathini@linux.ibm.com>
 <CAPhsuW6o+4STm0AUviP_M8c-xK9Y7Uzke1zouEsEreggVBofkw@mail.gmail.com>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <CAPhsuW6o+4STm0AUviP_M8c-xK9Y7Uzke1zouEsEreggVBofkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SoWxSm9TO-cFq6udCp4aS4lULbVqSwyU
X-Proofpoint-ORIG-GUID: SoWxSm9TO-cFq6udCp4aS4lULbVqSwyU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_15,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=582
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060137
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for the review, Song.

On 29/09/23 2:38 am, Song Liu wrote:
> On Thu, Sep 28, 2023 at 12:48 PM Hari Bathini <hbathini@linux.ibm.com> wrote:
>>
>> patch_instruction() entails setting up pte, patching the instruction,
>> clearing the pte and flushing the tlb. If multiple instructions need
>> to be patched, every instruction would have to go through the above
>> drill unnecessarily. Instead, introduce function patch_instructions()
>> that sets up the pte, clears the pte and flushes the tlb only once per
>> page range of instructions to be patched. This adds a slight overhead
>> to patch_instruction() call while improving the patching time for
>> scenarios where more than one instruction needs to be patched.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> With a nit below.
> 
> [...]
>> +/*
>> + * A page is mapped and instructions that fit the page are patched.
>> + * Assumes 'len' to be (PAGE_SIZE - offset_in_page(addr)) or below.
>> + */
>> +static int __do_patch_instructions_mm(u32 *addr, void *code, size_t len, bool repeat_instr)
>>   {
>>          int err;
>>          u32 *patch_addr;
>> @@ -307,11 +336,15 @@ static int __do_patch_instruction_mm(u32 *addr, ppc_inst_t instr)
>>
>>          orig_mm = start_using_temp_mm(patching_mm);
>>
>> -       err = __patch_instruction(addr, instr, patch_addr);
>> +       /* Single instruction case. */
>> +       if (len == 0) {
>> +               err = __patch_instruction(addr, *(ppc_inst_t *)code, patch_addr);
> 
> len == 0 for single instruction is a little weird to me. How about we just use
> len == 4 or 8 depending on the instruction to patch?

Yeah. Looks a bit weird but it avoids the need to call ppc_inst_read()
& ppc_inst_len(). A comment explaining why this weird check could
have been better though..

Thanks
Hari

