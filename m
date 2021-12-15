Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D824B475B63
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243652AbhLOPFv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 10:05:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43397 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230271AbhLOPFv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Dec 2021 10:05:51 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFEFgdo002642
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 15:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=m346anBmWRg6gCXlMJoRkpzygWgXKtqpKZwDuGtDse4=;
 b=iAkGmGcr9UEKDW7ZAfzWDYZgqIfDASUCpMHeyEzBYwH3CNQZJBo3arzaYlgcY+ZF/L6Y
 VcD8SjXvMQkCvsNzzz/JyCZ+46KY6j9yNe72qGldGHxAOwG3a62260OQseEVm5DlQ37u
 IJW5EsPdSC3lRoRa9fc7VHO7SGSkbOtK/v7YWjMkk4pqPBnTqz+7KeyKU/b4huRD4Be6
 svCs0JU9bi0fdcN8L7ODgf8Ph/LtwRK6zbO4zLHBZS616bn+pNx5RyM3MD0kJwWHf22w
 syyoUmT1zYVfDpp6p/SMJS301TndAB3mW6XXmZwTZD1E6qIY6mALcXbkNJq/rJaTyzPq mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cyhyk16hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 15:05:50 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BFEpDQX024601
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 15:05:49 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cyhyk16h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 15:05:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BFF2frq025371;
        Wed, 15 Dec 2021 15:05:48 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3cy7jqx9y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 15:05:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BFF5jCo33161486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 15:05:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AAA2A4E1B;
        Wed, 15 Dec 2021 14:48:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B563BA4DEC;
        Wed, 15 Dec 2021 14:48:14 +0000 (GMT)
Received: from localhost (unknown [9.43.122.198])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Dec 2021 14:48:14 +0000 (GMT)
Date:   Wed, 15 Dec 2021 20:18:13 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: PPC jit and pseudo_btf_id
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
References: <xunylf0o872l.fsf@redhat.com>
        <1639483040.nhfgn2cmvh.naveen@linux.ibm.com>
        <CANoWswkVLUDzwivbkiJ28LKo8F2YZJ4sRR=76NNcYwpdncquwA@mail.gmail.com>
In-Reply-To: <CANoWswkVLUDzwivbkiJ28LKo8F2YZJ4sRR=76NNcYwpdncquwA@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/v0.16-1-g4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1639577374.grloptq1hq.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a_638EOFoYJ5Dw-S4C97WF0c1LmpW6Ys
X-Proofpoint-ORIG-GUID: hqPQEV0yQssfmxClVHJZQXV3QTSlo4HB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_10,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=594 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150086
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yauheni Kaliuta wrote:
>> Can you please check if the below patch fixes the issue for you?
>=20
> It does, thanks!
>=20
> I was actually thinking later about something similar and I wonder
> about naming. Should the function be renamed to more generic, and is
> it really for func_addr only or can be any generic value?

Good point. Looking at jit_subprogs(), it looks like the extra pass=20
fixes up addresses of subprog calls, as well as that of other bpf=20
functions.  So, I agree that it makes sense to change the function name. =20
func_addr looks to still be correct though.

Thanks for testing this. I will update this patch and post it along with=20
a few other fixes.


Regards,
Naveen

