Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886ED4AB83F
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 11:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiBGKAs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 05:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245293AbiBGJqb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 04:46:31 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE79C043181
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 01:46:30 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21787I23031671;
        Mon, 7 Feb 2022 09:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=D1GSY+CdtktwglLxgHLudRXixVrVmahIWv7W8k+9jpU=;
 b=YLGmwyngoI3C28XHdxl7O0nH4y9I/aP9fyxMcmdv2LGOLL8XYX0MSZBTPX6RnTygJHDv
 lPHVyaB9lS3xcLVUt036TJE742798hf+iyRAIu19Yf+oxuSWRPQdRHA4+dRuwLsm6uSk
 v0LT1O8tbrK7l1u9i1MmKIbVBoo0Qo+/XapzTHxg5bM4G5mzzjB0xw471i9avRihKjOY
 HwpBR3w+qgL2Avz0IRq6e07c7fAKdh/8nCXG/PlYFiPKMVuqKN/vlAT8TbyyMsEOclff
 cnIxbIZHDgzEKTh+RCMBo+cQe4/cbT9ZrkicN5lopwDBai/oo4NurrEcREN2mZoHSGMb Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e2318ye0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 09:46:16 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2179Tkgw023674;
        Mon, 7 Feb 2022 09:46:15 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e2318ye0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 09:46:15 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2179cPZD000502;
        Mon, 7 Feb 2022 09:46:13 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3e1gv92mh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 09:46:13 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2179kAVo37683544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Feb 2022 09:46:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 544754C052;
        Mon,  7 Feb 2022 09:46:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3A934C050;
        Mon,  7 Feb 2022 09:46:09 +0000 (GMT)
Received: from osiris (unknown [9.145.87.217])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  7 Feb 2022 09:46:09 +0000 (GMT)
Date:   Mon, 7 Feb 2022 10:46:08 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/2] Fix bpf_perf_event_data ABI breakage
Message-ID: <YgDqYFsLwkWZvX0+@osiris>
References: <20220206145350.2069779-1-iii@linux.ibm.com>
 <CAEf4Bzb1To5+uLdRiJEJUJo4PckVDEBEtENC14Cuf-mkxrnxgA@mail.gmail.com>
 <5e4b012be25cbbb44ecb935de745e17ed5c16f28.camel@linux.ibm.com>
 <CAEf4BzZfn4-dbnRcsStu+EoKD12EoKCShcoAVH9Gj0mqieBAaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZfn4-dbnRcsStu+EoKD12EoKCShcoAVH9Gj0mqieBAaw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LIuFXOi4ZHVHSGIpHYOAJusMXFKS4Y9P
X-Proofpoint-GUID: jiPfSTcBngPYZvz65F96krOPXdAm1M7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 mlxlogscore=963 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202070061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 06, 2022 at 10:23:19PM -0800, Andrii Nakryiko wrote:
> I'm not sure the origins of the need for user_pt_regs (as opposed to
> using pt_regs directly, like x86-64 does), but with CO-RE and
> vmlinux.h it would be more reliable and straightforward to just stick
> to kernel-internal struct pt_regs everywhere. And for non-CO-RE macros
> maybe just using an offset within struct pt_regs (i.e.,
> offsetofend(gprs)) would do it?

user_pt_regs was introduced on s390 because struct pt_regs is _not_
stable. Only the first n entries (aka user_pt_regs) are supposed to be
stable.

We could of course reduce struct pt_regs to the bare minimum, which seems
to be the current user_pt_regs plus orig_gpr2; which semantically would
match more or less what x86 has.

Then move pt_regs to uapi, so it is clear that it cannot be changed
anymore, and have additional data in a separate structure on the stack,
which has pt_regs at the beginning, and access this additional data with
container_of & friends.

I guess that could work, even though this requires to keep user_pt_regs
"for historical reasons".
