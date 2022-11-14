Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ECD62832A
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 15:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiKNOsI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 09:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiKNOsH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 09:48:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB9B2F5
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 06:48:06 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEEdoNA015912;
        Mon, 14 Nov 2022 14:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Uk5EXZkBNF0tn4o07/dITg6sAe5THIbl29LANdGKdYE=;
 b=YUVENSN3WIZiTbw6pbWlJ+VcwBOLW1eRQ8HWO6eUXu+zWpeWbVXdxE0vg5X/uw6hzXEk
 3KwiuRe5kcqtN/kcOzFqB/zwO7ajvI+fctvUcLLGs5EYg8nIvv+qRtoNXcZf6zR2BsOS
 pnjVZSEFaH4LojhZFh6Tt9NnRu/trF7TIdwVFCwICEYqWRs/teWwL99bZ0j6WHzDJLhN
 ADl0nTh3SxNrCSnYFCFKMiz4dCI2F57/mKYxf/rmRe9uLDiQkRn/+g2hLX650YjQqFmN
 EW3ddAVcoxwuKVeVKkPJOGJdCtmS02torqExwpOriMDP/8/xbk//5+jxHrMLx3yk1O7x UA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kuqmt06fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:47:44 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEEaE2v012383;
        Mon, 14 Nov 2022 14:47:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3kt349202h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:47:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEEld8F66584858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 14:47:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2E24A4040;
        Mon, 14 Nov 2022 14:47:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBBE7A404D;
        Mon, 14 Nov 2022 14:47:35 +0000 (GMT)
Received: from [9.163.90.158] (unknown [9.163.90.158])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 14:47:35 +0000 (GMT)
Message-ID: <5b59b7df-d2ec-1664-f0fb-764c9b93417c@linux.ibm.com>
Date:   Mon, 14 Nov 2022 20:17:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH 0/3] enable bpf_prog_pack allocator for powerpc
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20221110184303.393179-1-hbathini@linux.ibm.com>
 <00efe9b1-d9fd-441c-9eb4-cbf25d82baf2@csgroup.eu>
From:   Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <00efe9b1-d9fd-441c-9eb4-cbf25d82baf2@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bi3vyvRwPIOVRHzXkZKMZVoheG3BAfsb
X-Proofpoint-GUID: bi3vyvRwPIOVRHzXkZKMZVoheG3BAfsb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Christophe,

On 11/11/22 4:55 pm, Christophe Leroy wrote:
> Le 10/11/2022 à 19:43, Hari Bathini a écrit :
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
>> Patches 1 & 2 add the arch specific functions needed to support this
>> feature. Patch 3 enables the support for powerpc. The last patch
>> ensures cleanup is handled racefully.
>>

>> Tested the changes successfully on a PowerVM. patch_instruction(),
>> needed for bpf_arch_text_copy(), is failing for ppc32. Debugging it.
>> Posting the patches in the meanwhile for feedback on these changes.
> 
> I did a quick test on ppc32, I don't get such a problem, only something
> wrong in the dump print as traps intructions only are dumped, but
> tcpdump works as expected:

Thanks for the quick test. Could you please share the config you used.
I am probably missing a few knobs in my conifg...

Thanks
Hari
