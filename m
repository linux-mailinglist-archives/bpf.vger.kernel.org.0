Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28700320BCF
	for <lists+bpf@lfdr.de>; Sun, 21 Feb 2021 17:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhBUQkZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Feb 2021 11:40:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230133AbhBUQkY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Feb 2021 11:40:24 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11LGYZEd081965;
        Sun, 21 Feb 2021 11:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MvFOFgdw2dHoguU2CpSRbsMdRwsTkTSibB2eAwCLzag=;
 b=Ui4j1zVYug4kph6R698eLmtWJAjMabuhBnJp6FXBj5NCQzkRQqwD6t0Y7KB7Lq2P2EHm
 8jh0iQ4/mYqqlT6UVTOA37RZk01BrVmXHXRURP2ioToVT8k6m+7EyHa14EarheXWOBe1
 J0j/1tg6m3f7U4b1QgnlI07giNvwetK2d1RjFyU3gCOhiESIr/jslPjoQKA1Ouu6bKMq
 0GJ+brx1iExEVYn6Y0lEPnBK0Aufm8omxqqHflPaQ0sHSxrVZ0tGaD5fFaOGNBiqYmAG
 GsWmb4TqnfuqowoOBBAeLfAn3X5zK8Cmo2dL4xlQQhXkifHHyAsW3+/YA9VOwZ6HMHPh Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36uu4f8amy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Feb 2021 11:39:28 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11LGYqBY082992;
        Sun, 21 Feb 2021 11:38:47 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36uu4f88wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Feb 2021 11:38:47 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11LGc2e6029765;
        Sun, 21 Feb 2021 16:38:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt280y4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Feb 2021 16:38:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11LGc0Ih39780710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Feb 2021 16:38:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CCB8AE04D;
        Sun, 21 Feb 2021 16:38:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85411AE045;
        Sun, 21 Feb 2021 16:37:59 +0000 (GMT)
Received: from [9.145.178.56] (unknown [9.145.178.56])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 21 Feb 2021 16:37:59 +0000 (GMT)
Message-ID: <77c3c64117e266c92fd43860afff858e92d07b6f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 bpf-next 4/6] bpf: Add BTF_KIND_FLOAT support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Sun, 21 Feb 2021 17:37:59 +0100
In-Reply-To: <20210220034959.27006-5-iii@linux.ibm.com>
References: <20210220034959.27006-1-iii@linux.ibm.com>
         <20210220034959.27006-5-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-21_08:2021-02-18,2021-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102210168
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2021-02-20 at 04:49 +0100, Ilya Leoshkevich wrote:
> On the kernel side, introduce a new btf_kind_operations. It is
> similar to that of BTF_KIND_INT, however, it does not need to
> handle encodings and bit offsets. Do not implement printing, since
> the kernel does not know how to format floating-point values.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/bpf/btf.c | 77
> ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 2efeb5f4b343..813c2bfe284f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[...]

> +static int btf_float_check_member(struct btf_verifier_env *env,
> +                                 const struct btf_type *struct_type,
> +                                 const struct btf_member *member,
> +                                 const struct btf_type *member_type)
> +{
> +       u64 start_offset_bytes;
> +       u64 end_offset_bytes;
> +       u64 align_bytes;
> +       u64 align_bits;
> +
> +       align_bytes = min_t(u64, sizeof(void *), member_type->size);
> +       align_bits = align_bytes * BITS_PER_BYTE;
> +       if (member->offset % align_bits) {

The kernel test robot's link error is most likely due to this line.
I should be using do_div here.

[...]


