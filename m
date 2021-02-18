Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D7931EC89
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 17:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhBRQti (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 11:49:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230186AbhBRNmo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 08:42:44 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11IDVfJv010020;
        Thu, 18 Feb 2021 08:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=WauhK6ZqrLlMc/HASY+jV3MG/mJSa69iEWnM2ynlKGc=;
 b=H2PuD8X8w+haaRX+zlk2IgGHTA76ArCqNB0U36eFmotW52Wmv73roOpIXpQ0jerOqj+8
 1V+XUe7JAcpl+1Adi7FpBfbYPtPV65tRO96s/eB3fGlNcAUnt/46rEvc5drNYOENSdP0
 XohZZm43xoz8+nNrFmzTHNrHPcSx3sQQeciBhJN5tU9fvGvEYiH8cdXGEd7CYmqWLwrh
 xLPPRzksww8toIAaY1WFWao3PqrxIq5LTxeDKOBGuQJhmj6Ykl5LwmtvsGr6DvCmHBA4
 kdGXd5Y8sVS5z9GYoUk0spcBfTPn+vM3xG9AMAegbAdAxF7X/t2ed+H1+RioMg7caqm5 Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36srmgsew5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 08:41:35 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11IDWOWC015099;
        Thu, 18 Feb 2021 08:41:35 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36srmgsev3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 08:41:35 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11IDbfln001618;
        Thu, 18 Feb 2021 13:41:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 36p6d8je6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 13:41:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11IDfU2f36634958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 13:41:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA5B6A405C;
        Thu, 18 Feb 2021 13:41:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E362A4064;
        Thu, 18 Feb 2021 13:41:29 +0000 (GMT)
Received: from [9.171.64.123] (unknown [9.171.64.123])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Feb 2021 13:41:29 +0000 (GMT)
Message-ID: <8c88e095fdd48e9d71693021b3048119f45895e6.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 18 Feb 2021 14:41:29 +0100
In-Reply-To: <ace21632-0292-bcde-d87b-fc3b00fc612c@fb.com>
References: <20210216011216.3168-1-iii@linux.ibm.com>
         <20210216011216.3168-3-iii@linux.ibm.com>
         <ace21632-0292-bcde-d87b-fc3b00fc612c@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_05:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102180115
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-02-17 at 22:58 -0800, Yonghong Song wrote:
> On 2/15/21 5:12 PM, Ilya Leoshkevich wrote:
> > The logic follows that of BTF_KIND_INT most of the time.
> > Sanitization
> > replaces BTF_KIND_FLOATs with equally-sized BTF_KIND_INTs on older
> > kernels.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >   tools/lib/bpf/btf.c             | 44
> > +++++++++++++++++++++++++++++++++
> >   tools/lib/bpf/btf.h             |  8 ++++++
> >   tools/lib/bpf/btf_dump.c        |  4 +++
> >   tools/lib/bpf/libbpf.c          | 29 +++++++++++++++++++++-
> >   tools/lib/bpf/libbpf.map        |  5 ++++
> >   tools/lib/bpf/libbpf_internal.h |  2 ++
> >   6 files changed, 91 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index d9c10830d749..07a30e98c3de 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c

[...]

> > @@ -2373,6 +2377,42 @@ int btf__add_datasec(struct btf *btf, const
> > char *name, __u32 byte_sz)
> >         return btf_commit_type(btf, sz);
> >   }
> >   
> > +/*
> > + * Append new BTF_KIND_FLOAT type with:
> > + *   - *name* - non-empty, non-NULL type name;
> > + *   - *sz* - size of the type, in bytes;
> > + * Returns:
> > + *   - >0, type ID of newly added BTF type;
> > + *   - <0, on error.
> > + */
> > +int btf__add_float(struct btf *btf, const char *name, size_t
> > byte_sz)
> > +{
> > +       struct btf_type *t;
> > +       int sz, name_off;
> > +
> > +       /* non-empty name */
> > +       if (!name || !name[0])
> > +               return -EINVAL;
> 
> Do we want to ensure byte_sz to be 2/4/8/16?
> Currently, the int type supports 1/2/4/8/16.
> 
> In LLVM, the following are supported float types:
> 
>    case BuiltinType::Half:
>    case BuiltinType::Float:
>    case BuiltinType::LongDouble:
>    case BuiltinType::Float16:
>    case BuiltinType::BFloat16:
>    case BuiltinType::Float128:
>    case BuiltinType::Double:

There can be 80-bit floats on x86:

#include <stdio.h>
int main() { printf("%zu\n", sizeof(long double)); }

prints 12 when compiled with -m32 (not 10 due to alignment I assume).

I guess this now completely kills the idea with sanitizing FLOATs to
equally-sized INTs...

[...]

