Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49537421622
	for <lists+bpf@lfdr.de>; Mon,  4 Oct 2021 20:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbhJDSNt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Oct 2021 14:13:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57054 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236050AbhJDSNt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 4 Oct 2021 14:13:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194Hh78p007660;
        Mon, 4 Oct 2021 14:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=ljXqVufmHhnRJG7cSl8LWnmy2wSmE4Bj70sdIMXS+8U=;
 b=iT2TNjA7mkTqQGmGI2SuW7hW/Z/TgA+k6sM65U6+chSDL2ka9OB80ZCHICNSPJL9636E
 17kq0ml7ieoCcfuKAOJdJyfc3L+JjQw1bphCjjF2sA9VPhh3B0i5q2j8T/YNx1J6lqON
 IubeuhMxeFWlBYm41cYvHzri2WODRCDB9FsirgrB9l2niFTmEZOjw3icUTRC2dTABp+i
 zmzuwhAujJKthTpZVzEh+v2PBCFvSNcgq05Apg0zZ85bnZ+BbmS1+OuhXsfNEbhEuUT5
 59JAcNtcOgBMVNzKjJoy3yCM6u2SxC/i0KvqZRy2UkIreAV75afjNfwOB2M8u2MNdRd9 mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bg68t0mqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 14:11:40 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 194HkblC018247;
        Mon, 4 Oct 2021 14:11:39 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bg68t0mpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 14:11:39 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 194I2ZZb004096;
        Mon, 4 Oct 2021 18:11:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3bef29rsh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 18:11:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 194IBZgC53215712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 18:11:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D5D54203F;
        Mon,  4 Oct 2021 18:11:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB7F942042;
        Mon,  4 Oct 2021 18:11:34 +0000 (GMT)
Received: from localhost (unknown [9.43.21.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Oct 2021 18:11:34 +0000 (GMT)
Date:   Mon, 04 Oct 2021 23:41:32 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/9] powerpc/bpf: Remove unused SEEN_STACK
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
        <92fcd53a43dede52fbba52dc50c76042a6ce284c.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
        <bdadfd21-7e39-5984-43b9-818f1660ccaf@csgroup.eu>
In-Reply-To: <bdadfd21-7e39-5984-43b9-818f1660ccaf@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1633369544.ekqufta9bg.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U35N95J3kp-oGtzcIphUah55R57BcLsx
X-Proofpoint-ORIG-GUID: IfnMBHQJnIKAYI0zRSnltowmMhsZCNj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040125
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christophe Leroy wrote:
>=20
>=20
> Le 01/10/2021 =C3=A0 23:14, Naveen N. Rao a =C3=A9crit=C2=A0:
>> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>=20
>> SEEN_STACK is unused on PowerPC. Remove it. Also, have
>> SEEN_TAILCALL use 0x40000000.
>=20
> Why change SEEN_TAILCALL ? Would it be a problem to leave it as is ?
>=20
>>=20
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

I prefer the bit usage to be contiguous. Changing SEEN_TAILCALL isn't a=20
problem either.


- Naveen

