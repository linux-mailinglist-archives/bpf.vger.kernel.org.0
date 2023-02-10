Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFD2691CF5
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 11:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBJKgx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 05:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjBJKgn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 05:36:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CD970710
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 02:36:34 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AARdw6018289;
        Fri, 10 Feb 2023 10:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=pQstbAouq9GJCTzY/z/pRkpBFCWT5KhnxtDW3/gdxuA=;
 b=EIXpgjPA0lschTnVAr9sy4W5Ctd8ltpBTRPjO4a1605mWQsrJdzymdZgc4zHF7jnhYGe
 dq6JGflADadt/LoLGRSGEkc/hWt7XqyB9jBKAZCXXpzsgnCg4J8yAVHM4rKWCUt9VkWs
 EgdAlryZMgBLP77b7BSyf5RDM8dRi7bp0yz+0C2g//DqaoqE/q3EXDZvD8hl/HNe/DaX
 s0WmlrliznHe6kkz67kKOHs7WaQRjSeHJXR7zKB7yXrhcqbiqu2lrneRhnxMB4Gz/NWQ
 BF8Wi1UOlIP2X8dZLHje2dqzhP6YymZTUfJlgRPtFqT3jQ37s7FKvBNYmzrUbEGY6erH fg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnm6m8gsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 10:36:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31A6deF3023803;
        Fri, 10 Feb 2023 10:36:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06ybcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 10:36:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31AAa6MB46072242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 10:36:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AD362004F;
        Fri, 10 Feb 2023 10:36:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F3C820043;
        Fri, 10 Feb 2023 10:36:06 +0000 (GMT)
Received: from [9.171.85.225] (unknown [9.171.85.225])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 10:36:06 +0000 (GMT)
Message-ID: <e14fa2680a3a37d8ed369ea8014aa70ceaa3bbb8.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 10/16] bpftool: Use
 bpf_{btf,link,map,prog}_get_info_by_fd()
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date:   Fri, 10 Feb 2023 11:36:05 +0100
In-Reply-To: <20230210001210.395194-11-iii@linux.ibm.com>
References: <20230210001210.395194-1-iii@linux.ibm.com>
         <20230210001210.395194-11-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EllxJ5RI75aLBx9eUIuVgM6zwz6870gh
X-Proofpoint-GUID: EllxJ5RI75aLBx9eUIuVgM6zwz6870gh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_05,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302100088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-02-10 at 01:12 +0100, Ilya Leoshkevich wrote:
> Use the new type-safe wrappers around bpf_obj_get_info_by_fd().
> lease enter the commit message for your changes. Lines starting

Not sure what happened here, but this line needs to go.
I'll fix this in v3 if we decide to keep this patch.

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> =C2=A0tools/bpf/bpftool/btf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 13 ++++++++-----
> =C2=A0tools/bpf/bpftool/btf_dumper.c |=C2=A0 4 ++--
> =C2=A0tools/bpf/bpftool/cgroup.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0tools/bpf/bpftool/common.c=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++++++----=
--
> =C2=A0tools/bpf/bpftool/link.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 ++--
> =C2=A0tools/bpf/bpftool/main.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 ++-
> =C2=A0tools/bpf/bpftool/map.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 8 ++++----
> =C2=A0tools/bpf/bpftool/prog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 +=
++++++++++++-----------
> =C2=A0tools/bpf/bpftool/struct_ops.c |=C2=A0 6 +++---
> =C2=A09 files changed, 43 insertions(+), 36 deletions(-)

[...]
