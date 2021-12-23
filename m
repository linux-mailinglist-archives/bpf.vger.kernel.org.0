Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE947DD5D
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 02:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbhLWB02 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 20:26:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbhLWB02 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Dec 2021 20:26:28 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMMceka040069;
        Thu, 23 Dec 2021 01:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1cvTI4hVbqhNIOEUMsUugGgL6OlJP0wHv6tSaJOy+8s=;
 b=UG+kZCIaNt3k+fzrTJQGVggD+mn9NZS2Z0krzn6mpH7/M8E3G8nuVAYOnj0EVHSfTMEs
 ZbcJBEdUPLviDZMWvo/hZkty0FIscakAIAIEnVbY7PVzMvsnRWOB1LKobVEiSA7jC051
 HaTNUhgwaiQwYjIaCZH/Wk3Z8R7GgMCZlGc69O2PvSO2aQoQujl7TNIvEzrKiZdZGLDD
 Gr4wCzsTK3E4flOm64+AsvCMT0zyXCvuJrxaErhcgH8SKRh6TUnpWKr8EhViauZs2dtQ
 ZeduB18GqZukiWU+rwcMyzcsi76lJtflqOprqF36Rlpdn4CQWOW4ZrRoSGxj3TDgMiT2 cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d472s95v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 01:26:10 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BN1Et20019577;
        Thu, 23 Dec 2021 01:26:10 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d472s95uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 01:26:09 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BN1BfqT012456;
        Thu, 23 Dec 2021 01:26:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3d179a2r99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 01:26:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BN1Q5pQ36045252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 01:26:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24D7DAE045;
        Thu, 23 Dec 2021 01:26:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7350AE051;
        Thu, 23 Dec 2021 01:26:04 +0000 (GMT)
Received: from [9.171.84.70] (unknown [9.171.84.70])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Dec 2021 01:26:04 +0000 (GMT)
Message-ID: <72ef381f2aa0b8bf20a07052b71eb7ad1f426c86.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: normalize PT_REGS_xxx() macro
 definitions
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Kenta Tada <Kenta.Tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Date:   Thu, 23 Dec 2021 02:26:04 +0100
In-Reply-To: <20211222213924.1869758-1-andrii@kernel.org>
References: <20211222213924.1869758-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a228mmJRCIMCM7hVGEH2dVTiyhl-K_OT
X-Proofpoint-GUID: If8W5bqUbmq1B2_v2_GZEXU7Pla0FJnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230004
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-12-22 at 13:39 -0800, Andrii Nakryiko wrote:
> Refactor PT_REGS macros definitions in  bpf_tracing.h to avoid
> excessive
> duplication. We currently have classic PT_REGS_xxx() and CO-RE-
> enabled
> PT_REGS_xxx_CORE(). We are about to add also _SYSCALL variants, which
> would require excessive copying of all the per-architecture
> definitions.
> 
> Instead, separate architecture-specific field/register names from the
> final macro that utilize them. That way for upcoming _SYSCALL
> variants
> we'll be able to just define x86_64 exception and otherwise have one
> common set of _SYSCALL macro definitions common for all
> architectures.
> 
> Cc: Kenta Tada <Kenta.Tada@sony.com>
> Cc: Hengqi Chen <hengqi.chen@gmail.com>
> Cc: Björn Töpel <bjorn@kernel.org>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/bpf_tracing.h | 377 +++++++++++++++-------------------
> --
>  1 file changed, 152 insertions(+), 225 deletions(-)

Works fine on s390, and looks good to me.
For both patches:

Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

Best regards,
Ilya
