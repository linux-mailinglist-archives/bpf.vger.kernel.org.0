Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB84873A2
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 08:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiAGHg3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 02:36:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235128AbiAGHg2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 02:36:28 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2076cMtQ017958;
        Fri, 7 Jan 2022 07:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=U36coC2K3bgPp6+lil/Brl/6/u+WSFE+iAHncxbWons=;
 b=tUGpS0kfHYxht0KG7Ak6UAx9gTVn046T2aNhAfdgzxj4x34PNcnY5QzWSr1ZHFmh1QiI
 TE6iowSvlrg2PVzdSVXhgTeEII0Bi58NUnxr6EIDJ072p7E/zPjYsfbvjbeHCBfIVvcJ
 KoCT4L1vS461Fv4iIyCQNUBEsY+58AQiU/Nh/NICtgUsPVlGFXXA8S3Tasu7Qjo78YfU
 l+kEuGawp4rsp2wicX+xT3lQXGHI7g/9Hs1cK1F782FS29iIOr5iWvDrYEnYznFs4zEC
 TOHrEfefBfvu/1nlSskPBcGMkgTYabEShfmbsim6BeluAQDr7mhfwWeoa/xQdygNQx18 Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3de5bqk32k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jan 2022 07:36:08 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2077MNHt004346;
        Fri, 7 Jan 2022 07:36:08 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3de5bqk31n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jan 2022 07:36:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2077YFa4020341;
        Fri, 7 Jan 2022 07:36:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3de5gfuu0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jan 2022 07:36:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2077a3A638535464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jan 2022 07:36:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AC16AE056;
        Fri,  7 Jan 2022 07:36:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CB02AE053;
        Fri,  7 Jan 2022 07:36:02 +0000 (GMT)
Received: from localhost (unknown [9.43.90.227])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jan 2022 07:36:02 +0000 (GMT)
Date:   Fri, 07 Jan 2022 13:06:01 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/13] powerpc/bpf: Some fixes and updates
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     bpf@vger.kernel.org, Hari Bathini <hbathini@linux.ibm.com>,
        johan.almbladh@anyfinetworks.com, Jiri Olsa <jolsa@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, song@kernel.org, ykaliuta@redhat.com
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
        <f4f3437d-084f-0858-8795-76e4a0fa5627@iogearbox.net>
In-Reply-To: <f4f3437d-084f-0858-8795-76e4a0fa5627@iogearbox.net>
MIME-Version: 1.0
User-Agent: astroid/v0.16-1-g4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1641540707.ewk8tpqmvl.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JWN2KhdmtEzlXJvEgi-GbCZczd7eVmr9
X-Proofpoint-ORIG-GUID: _a4BW3tAt9FMOboixZVikopQ3TVDhfvs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_02,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=949 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070053
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

Daniel Borkmann wrote:
> Hi Naveen,
>=20
> On 1/6/22 12:45 PM, Naveen N. Rao wrote:
>> A set of fixes and updates to powerpc BPF JIT:
>> - Patches 1-3 fix issues with the existing powerpc JIT and are tagged
>>    for -stable.
>> - Patch 4 fixes a build issue with bpf selftests on powerpc.
>> - Patches 5-9 handle some corner cases and make some small improvements.
>> - Patches 10-13 optimize how function calls are handled in ppc64.
>>=20
>> Patches 7 and 8 were previously posted, and while patch 7 has no
>> changes, patch 8 has been reworked to handle BPF_EXIT differently.
>=20
> Is the plan to route these via ppc trees? Fwiw, patch 1 and 4 look generi=
c
> and in general good to me, we could also take these two via bpf-next tree
> given outside of arch/powerpc/? Whichever works best.

Yes, I would like to route this through the powerpc tree. Though patches=20
1 and 4 are generic, they primarily affect powerpc and I do not see=20
conflicting changes in bpf-next. Request you to please ack those patches=20
so that Michael can take it through the powerpc tree.


Thanks!
- Naveen
