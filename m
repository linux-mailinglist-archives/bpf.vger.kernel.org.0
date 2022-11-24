Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83FF6375FF
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 11:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKXKO1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 05:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKXKO0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 05:14:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBFFC0503;
        Thu, 24 Nov 2022 02:14:25 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AOAAN3s014389;
        Thu, 24 Nov 2022 10:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=/jYKHwVqi5Bb3zOWYzhgtzks4VPghnmXgxJb0Lk/TDg=;
 b=r0Nb51Prs0/h6RY+oQv+0Ue7AEzG4ORNOilG007yr3PZnQtLmLV2amBOlDCyh56hVQwF
 TvZfGdooH2Ro/9V/mEA4hqzSEAr9VWBh9EJ5JvDlCEXpVN6q6+RVAWbhrF5N0Yp1r9/u
 nGV7UTokh3flXlQ2H8gpebqNBY3/CLgErWy9afnCPkfFzLBMNA+boibcaCpiSnxdLYxF
 D7qrF1c9JESy/VdOq+lbT1NIOr821VNrVwBuL/HqVBa9km/Zvqxgcrhh3L8o9hUaPsl5
 KVK1g1QnAbCLXcb8D92AcHPgJ4bkrucCX20in0Sakj+KyqiJRMKJhPuu9LeaV4B6fdtP Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10ph0k8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 10:13:58 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AO9N3YQ031846;
        Thu, 24 Nov 2022 10:13:57 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10ph0k7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 10:13:57 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AOA7e57009899;
        Thu, 24 Nov 2022 10:13:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3kxpdj00b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 10:13:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AOADqgt42139944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Nov 2022 10:13:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F58D42042;
        Thu, 24 Nov 2022 10:13:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 272A74203F;
        Thu, 24 Nov 2022 10:13:52 +0000 (GMT)
Received: from localhost (unknown [9.43.36.53])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Nov 2022 10:13:52 +0000 (GMT)
Date:   Thu, 24 Nov 2022 15:43:50 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH] powerpc/bpf: Only update ldimm64 during extra pass when
 it is an address
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>
References: <3f6d302a2068d9e357efda2d92c8da99a0f2d0b2.1669278892.git.christophe.leroy@csgroup.eu>
In-Reply-To: <3f6d302a2068d9e357efda2d92c8da99a0f2d0b2.1669278892.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1669284441.66eunvaboi.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _MbERAMhLbV9ShnTyyIoUxaOAONes4jL
X-Proofpoint-GUID: RZOUyJmB4of1rqkOBNDGVb-Jn9vO60P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_07,2022-11-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 mlxlogscore=770 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211240079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christophe Leroy wrote:
> ldimm64 is not only used for loading function addresses, and

That's probably true today, but I worry that that can change upstream=20
and we may not notice at all.

> the NOPs added for padding are impacting performance, so avoid
> them when not necessary.
>=20
> On QEMU mac99, with the patch:
>=20
> test_bpf: #829 ALU64_MOV_K: all immediate value magnitudes jited:1 167436=
810 PASS
> test_bpf: #831 ALU64_OR_K: all immediate value magnitudes jited:1 1707029=
40 PASS
>=20
> Without the patch:
>=20
> test_bpf: #829 ALU64_MOV_K: all immediate value magnitudes jited:1 173012=
360 PASS
> test_bpf: #831 ALU64_OR_K: all immediate value magnitudes jited:1 1764240=
90 PASS
>=20
> That's a 3.5% performance improvement.

A better approach would be to do a full JIT during the extra pass.=20
That's what most other architectures do today. And, as long as we can=20
ensure that the JIT'ed program size can never increase during the=20
extra pass, we should be ok to do a single extra pass.


- Naveen
