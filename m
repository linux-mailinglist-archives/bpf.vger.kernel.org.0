Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E8D324EAE
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 12:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhBYK7Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 05:59:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231845AbhBYK63 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 05:58:29 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PAY310068829;
        Thu, 25 Feb 2021 05:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GWB7IqQUJmiME1BbX7V4b56Sr1CCFaaNyyZPLEVhWZM=;
 b=g1FyUHsPiummaR/uqyw3sqYd33GPtIp1OlslZHoguf4ifqZTkjFvBZdxUn7IaQ8js57w
 SKpQ3wdudDy135nhpKH2mNxKO1HwbeCg/kUlz4SvzDd/PE8GqaWmq93CRQcvPC/rdmqN
 HIS10QHQ4puYp8F/L21CmzFC9lxCekCaP4jKrt6loLO5U8U5HqhxEeEJ+LIqlEz2OvRm
 d7y8z2kr5mtQqIXa2YioQZ5cQKfAsDuJ17ZQxuw1R0kPHSJgKdThNXQZ1kFri3dDOjF5
 sSNE6vv/OGm1YfSvZb27CkEmh08lNsdQjf2r2D0r1ETGBAI1DDbkD4GUJ2bSI+hVBCAx 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36x8dwc4ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 05:57:34 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11PAYHdi070386;
        Thu, 25 Feb 2021 05:57:34 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36x8dwc48d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 05:57:34 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11PAWeoF004146;
        Thu, 25 Feb 2021 10:40:51 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 36tt28cbsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 10:40:51 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11PAenXI42926424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 10:40:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C23E4A4059;
        Thu, 25 Feb 2021 10:40:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 370EAA4051;
        Thu, 25 Feb 2021 10:40:48 +0000 (GMT)
Received: from sig-9-145-151-190.de.ibm.com (unknown [9.145.151.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Feb 2021 10:40:48 +0000 (GMT)
Message-ID: <6962feb05a62d718e5d430f782012d71d6c73eed.camel@linux.ibm.com>
Subject: Re: [PATCH v6 bpf-next 6/9] bpf: Add BTF_KIND_FLOAT support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 25 Feb 2021 11:40:47 +0100
In-Reply-To: <e7957fca-b938-e50d-74f5-ecc40145eb4d@fb.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
         <20210224234535.106970-7-iii@linux.ibm.com>
         <e7957fca-b938-e50d-74f5-ecc40145eb4d@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_06:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250084
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-02-24 at 23:10 -0800, Yonghong Song wrote:
> On 2/24/21 3:45 PM, Ilya Leoshkevich wrote:
> > On the kernel side, introduce a new btf_kind_operations. It is
> > similar to that of BTF_KIND_INT, however, it does not need to
> > handle encodings and bit offsets. Do not implement printing, since
> > the kernel does not know how to format floating-point values.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >   kernel/bpf/btf.c | 79
> > ++++++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 77 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 2efeb5f4b343..c405edc8e615 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c

[...]

> > @@ -1849,7 +1852,7 @@ static int btf_df_check_kflag_member(struct
> > btf_verifier_env *env,
> >         return -EINVAL;
> >   }
> >   
> > -/* Used for ptr, array and struct/union type members.
> > +/* Used for ptr, array struct/union and float type members.
> >    * int, enum and modifier types have their specific callback
> > functions.
> >    */
> >   static int btf_generic_check_kflag_member(struct btf_verifier_env
> > *env,
> > @@ -3675,6 +3678,77 @@ static const struct btf_kind_operations
> > datasec_ops = {
> >         .show                   = btf_datasec_show,
> >   };
> >   
> > +static s32 btf_float_check_meta(struct btf_verifier_env *env,
> > +                               const struct btf_type *t,
> > +                               u32 meta_left)
> > +{
> > +       if (btf_type_vlen(t)) {
> > +               btf_verifier_log_type(env, t, "vlen != 0");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (btf_type_kflag(t)) {
> > +               btf_verifier_log_type(env, t, "Invalid btf_info
> > kind_flag");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (t->size != 2 && t->size != 4 && t->size != 8 && t->size
> > != 12 &&
> > +           t->size != 16) {
> > +               btf_verifier_log_type(env, t, "Invalid type_size");
> > +               return -EINVAL;
> > +       }
> > +
> > +       btf_verifier_log_type(env, t, NULL);
> > +
> > +       return 0;
> > +}
> > +
> > +static int btf_float_check_member(struct btf_verifier_env *env,
> > +                                 const struct btf_type
> > *struct_type,
> > +                                 const struct btf_member *member,
> > +                                 const struct btf_type
> > *member_type)
> > +{
> > +       u64 start_offset_bytes;
> > +       u64 end_offset_bytes;
> > +       u64 misalign_bits;
> > +       u64 align_bytes;
> > +       u64 align_bits;
> > +
> > +       align_bytes = min_t(u64, sizeof(void *), member_type-
> > >size);
> 
> I listed the following possible (size, align) pairs:
>      size     x86_32 align_bytes   x86_64 align bytes
>       2        2                    2
>       4        4                    4
>       8        4                    8
>       12       4                    8
>       16       4                    8
> 
> A few observations.
>    1. I don't know, just want to confirm, for double, the alignment 
> could be 4 (for a member) on 32bit system, is that right?
>    2. for size 12, alignment will be 8 for x86_64 system, this is 
> strange, not sure whether it is true or not. Or size 12 cannot be
> on x86_64 and we should error out if sizeof(void *) is 8.

1 - Yes.

2 - On x86_64 long double is 16 bytes and the required alignment is 16
bytes too. However, on other architectures all this might be different.
For example, for us long double is 16 bytes too, but the alignment can
be 8. So can we be somewhat lax here and just allow smaller alignments,
instead of trying to figure out what exactly each supported
architecture does?

[...]
> 

