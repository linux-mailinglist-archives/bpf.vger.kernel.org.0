Return-Path: <bpf+bounces-11067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA7F7B264B
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 22:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9E5E8282580
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 20:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861C944468;
	Thu, 28 Sep 2023 20:10:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40818626
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 20:10:28 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF9F180
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 13:10:24 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK6Frx009730;
	Thu, 28 Sep 2023 20:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fjJGBX5KsHNa9QSI5QAG+uTe7EQldrAvpqU5Kj6WFGQ=;
 b=Iz6Pydrv91OD1bC3BwyxGxLFbkHBD+8HWyII/vQ2ShcZeAVgmsoWS72SYJD92ur3AaMW
 d+zpgjvy+acTtJukaJfgK/vo8rKJOYN7cx0a6WzvJIglZED65/f+Xd72YdMZZ5nMlFNF
 3OlV5z1oKGNLaVTKPWcwwgDmu/BAjRq3ictk96o/NBD4VcMyN/eX+EkpeW8jb2fa2HVN
 HpJwXL0DomAK/tDlUkaTJvLRV3UU5XrFehKoSfT9Ml/J1gr0jodSfTtdG/Ktp/1dhcw2
 8RgDCXsSORmHduCChNPwSFqFrXySOoxQAV4D5W6gIIDgZKmIBtW1HuhSvUxwe8wvDTNK jg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdf7bhp5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 20:09:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38SIdOp5008386;
	Thu, 28 Sep 2023 20:09:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabt807s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 20:09:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38SK9YqG1245828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Sep 2023 20:09:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33AB120043;
	Thu, 28 Sep 2023 20:09:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88FD320040;
	Thu, 28 Sep 2023 20:09:32 +0000 (GMT)
Received: from [9.43.85.6] (unknown [9.43.85.6])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Sep 2023 20:09:32 +0000 (GMT)
Message-ID: <2fccf899-ca5b-4c77-4357-b6c6e1f72201@linux.ibm.com>
Date: Fri, 29 Sep 2023 01:39:31 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 4/5] powerpc/code-patching: introduce
 patch_instructions()
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Song Liu <song@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20230908132740.718103-1-hbathini@linux.ibm.com>
 <20230908132740.718103-5-hbathini@linux.ibm.com>
 <CAPhsuW6p1+mqG_soSS8q_FFio7iHGtUyyDfH5cyXs_Py8f-Pmg@mail.gmail.com>
 <2dffb52c-39f5-4d27-8a51-e5af643c1be4@csgroup.eu>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <2dffb52c-39f5-4d27-8a51-e5af643c1be4@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IarHbB6hHlcPpz4O4XctV01mjFL8WAc2
X-Proofpoint-GUID: IarHbB6hHlcPpz4O4XctV01mjFL8WAc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_19,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=653 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280171
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 26/09/23 12:21 pm, Christophe Leroy wrote:
> 
> 
> Le 26/09/2023 à 00:50, Song Liu a écrit :
>> On Fri, Sep 8, 2023 at 6:28 AM Hari Bathini <hbathini@linux.ibm.com> wrote:
>>>
>>> patch_instruction() entails setting up pte, patching the instruction,
>>> clearing the pte and flushing the tlb. If multiple instructions need
>>> to be patched, every instruction would have to go through the above
>>> drill unnecessarily. Instead, introduce function patch_instructions()
>>> that sets up the pte, clears the pte and flushes the tlb only once per
>>> page range of instructions to be patched. This adds a slight overhead
>>> to patch_instruction() call while improving the patching time for
>>> scenarios where more than one instruction needs to be patched.
>>>
>>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>>
>> I didn't see this one when I reviewed 1/5. Please ignore that comment.
> 
> If I remember correctry, patch 1 introduces a huge performance
> degradation, which gets then improved with this patch.
> 
> As I said before, I'd expect patch 4 to go first then get
> bpf_arch_text_copy() be implemented with patch_instructions() directly.
> 

Thanks for the reviews, Christophe & Song.
Posted v5 based on your inputs.

- Hari

