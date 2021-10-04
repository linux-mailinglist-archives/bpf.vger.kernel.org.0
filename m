Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FECD421640
	for <lists+bpf@lfdr.de>; Mon,  4 Oct 2021 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbhJDSVi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Oct 2021 14:21:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237989AbhJDSVi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 4 Oct 2021 14:21:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194IC5Y0018588;
        Mon, 4 Oct 2021 14:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=ekKTIQuKNrnPUnLvNkg5HynRW75Tqau2TGwO+Qzs+4s=;
 b=FWkbo9zLNdRhaiAX/aZFOW+lak+r9lKTD8ziKD0dgo01ukw6QcsYBqAMn+zw3ZiIDndw
 ixNdmTmrCNKzgheQXVUbWeUMQ6m60eLTh76bQXdfy/Kw007KPEkNRhim3IUZIhSRlooC
 kM8Nc0mK6+84wA4XlyOY5EwPcz+5WnHfowgWlyZ/MW7ub9dzblECn3Ff97CwrzBNiQ31
 7jWRoHw0UZ0YCK0byKdU8tw++OylpwOs/65rF//ifjCt8Cn5PKfCC2ciHGTYpreY3z6r
 nwohBjYQ+3bpk9AClWom8bGrZ5DKVqP9DQOUU6opy3dUzWU26oKz9Yj0uEzSi+hlDxT0 sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bg6p2r50e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 14:19:34 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 194IDnSE026145;
        Mon, 4 Oct 2021 14:19:34 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bg6p2r502-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 14:19:34 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 194ICXpd019180;
        Mon, 4 Oct 2021 18:19:32 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3bef29ru4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 18:19:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 194IJTNK35455436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 18:19:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5CE04204B;
        Mon,  4 Oct 2021 18:19:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0611942041;
        Mon,  4 Oct 2021 18:19:29 +0000 (GMT)
Received: from localhost (unknown [9.43.21.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Oct 2021 18:19:28 +0000 (GMT)
Date:   Mon, 04 Oct 2021 23:49:27 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/9] powerpc/bpf: Various fixes
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
        <CAM1=_QSrOZBk+_h224cdxrZw7djqUqO9jytYNV--9V-KTJmt9Q@mail.gmail.com>
In-Reply-To: <CAM1=_QSrOZBk+_h224cdxrZw7djqUqO9jytYNV--9V-KTJmt9Q@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1633371533.g2nx7rum38.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kZhlMTUZAHrrdBPWIBUYWzNcs4Do6cds
X-Proofpoint-GUID: xJBsZPqvGVzL6NLcP9x8V5qyTPSDWVFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=888 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040125
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Johan,

Johan Almbladh wrote:
> On Fri, Oct 1, 2021 at 11:15 PM Naveen N. Rao
> <naveen.n.rao@linux.vnet.ibm.com> wrote:
>>
>> Various fixes to the eBPF JIT for powerpc, thanks to some new tests
>> added by Johan. This series fixes all failures in test_bpf on powerpc64.
>> There are still some failures on powerpc32 to be looked into.
>=20
> Great work! I have tested it on powerpc64 in QEMU, which is the same
> setup that previously triggered an illegal instruction, and all tests
> pass now. On powerpc32 there are still some issues left as you say.

Thanks for the review, and the test!


- Naveen

