Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3169319525
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 22:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhBKV1u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 16:27:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhBKV1n (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Feb 2021 16:27:43 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BLD9OW146290;
        Thu, 11 Feb 2021 16:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sFpCA9Ua7GZoOUdH2JtMLxp8//uUC+qHmRlJGJBx0wo=;
 b=j4uGxy33VBu7Fso2R8NGFFsZ1pzxWZvE4CXa9zOAOmFd3lMrOxDzN2drB2DJ9xz8vIgg
 gGfySnyOqG/UF8EXH/DLoYC1LfwSZ/3IGuSBO6O6jqdzWqHEq5V53QW53iElXB84vecu
 zc93b1Pl6MTniVxQeGL1urTt+TI9kzVqjirSFBWjXuPtvcEobvmepI59DJX69nQlMQnv
 6bKImwsl9MbIMvLPRGbUQAOEEWIsxI+/JsLUQkQRs/IVbCOWLZ3Sm0muEMNj81p+75Vt
 iDsLJHiO0M1R1AZ77lfFOjVqT3Isg+c+EfLZ+3MN6Ju3Gx+c5hU9mrU5HsA1IXdbLlx0 og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nca309cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 16:26:43 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BLLh0K031138;
        Thu, 11 Feb 2021 16:26:43 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nca309c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 16:26:42 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BLDILf028010;
        Thu, 11 Feb 2021 21:26:40 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 36hjr8e4av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 21:26:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BLQc8l34603296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 21:26:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 832BD52051;
        Thu, 11 Feb 2021 21:26:38 +0000 (GMT)
Received: from [9.171.67.27] (unknown [9.171.67.27])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 142A65204F;
        Thu, 11 Feb 2021 21:26:38 +0000 (GMT)
Message-ID: <bda4c4eb4e9e01a6ecaf4e0cf14e265997520740.camel@linux.ibm.com>
Subject: Re: [PATCH RFC 1/6] bpf: Add BTF_KIND_FLOAT to uapi
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 11 Feb 2021 22:26:37 +0100
In-Reply-To: <CAEf4BzY-SOyP0g-ZHTK3h1mppwRGJ4YH3vKugeuLGTe8Q3-r7Q@mail.gmail.com>
References: <20210210030317.78820-1-iii@linux.ibm.com>
         <20210210030317.78820-2-iii@linux.ibm.com>
         <CAEf4BzY-SOyP0g-ZHTK3h1mppwRGJ4YH3vKugeuLGTe8Q3-r7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110161
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-02-10 at 16:19 -0800, Andrii Nakryiko wrote:
> On Tue, Feb 9, 2021 at 7:03 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > Add a new kind value, expand the kind bitfield, add a macro for
> > parsing the additional u32.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  include/uapi/linux/btf.h       | 10 ++++++++--
> >  tools/include/uapi/linux/btf.h | 10 ++++++++--
> >  2 files changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> > index 5a667107ad2c..e713430cb033 100644
> > --- a/include/uapi/linux/btf.h
> > +++ b/include/uapi/linux/btf.h
> > @@ -52,7 +52,7 @@ struct btf_type {
> >         };
> >  };
> > 
> > -#define BTF_INFO_KIND(info)    (((info) >> 24) & 0x0f)
> > +#define BTF_INFO_KIND(info)    (((info) >> 24) & 0x1f)
> >  #define BTF_INFO_VLEN(info)    ((info) & 0xffff)
> >  #define BTF_INFO_KFLAG(info)   ((info) >> 31)
> > 
> > @@ -72,7 +72,8 @@ struct btf_type {
> >  #define BTF_KIND_FUNC_PROTO    13      /* Function Proto       */
> >  #define BTF_KIND_VAR           14      /* Variable     */
> >  #define BTF_KIND_DATASEC       15      /* Section      */
> > -#define BTF_KIND_MAX           BTF_KIND_DATASEC
> > +#define BTF_KIND_FLOAT         16      /* Floating point       */
> > +#define BTF_KIND_MAX           BTF_KIND_FLOAT
> >  #define NR_BTF_KINDS           (BTF_KIND_MAX + 1)
> > 
> >  /* For some specific BTF_KIND, "struct btf_type" is immediately
> > @@ -169,4 +170,9 @@ struct btf_var_secinfo {
> >         __u32   size;
> >  };
> > 
> > +/* BTF_KIND_FLOAT is followed by a u32 and the following
> 
> 
> what's the point of that u32, if BTF_FLOAT_BITS() is just t->size *
> 8?
> Why adding this complexity. BTF_KIND_INT has bits because we had an
> inconvenient bitfield encoding as a special BTF_KIND_INT types, which
> we since stopped using in favor of encoding bitfield sizes and
> offsets
> inside struct/union fields. I don't think there is any need for that
> with FLOAT, so why waste space and add complexity and possibility for
> inconsistencies?

You are right, this is not necessary. I don't think something like a
floating-point bitfield exists in the first place.

> Disclaimer: I'm in a "just BTF_KIND_INT encoding bit for
> floating-point numbers" camp.

Despite me being the guy, who sent this series, I like such a simpler
approach as well. In fact, my first attempt at this was even simpler -
just a char[] - but this didn't let us distinguish floats from "real"
byte arrays, which BTF_KIND_INT encoding does. But I think we need to
convince Alexey that this would be OK? :-) If that helps, I can
implement the BTF_KIND_INT encoding variant, so that we could compare
both approaches. What do you think?

> > + * is the 32 bits arrangement:
> > + */
> > +#define BTF_FLOAT_BITS(VAL)    ((VAL)  & 0x000000ff)
> > +
> >  #endif /* _UAPI__LINUX_BTF_H__ */
> > diff --git a/tools/include/uapi/linux/btf.h
> > b/tools/include/uapi/linux/btf.h
> > index 5a667107ad2c..e713430cb033 100644
> > --- a/tools/include/uapi/linux/btf.h
> > +++ b/tools/include/uapi/linux/btf.h
> > @@ -52,7 +52,7 @@ struct btf_type {
> >         };
> >  };
> > 
> > -#define BTF_INFO_KIND(info)    (((info) >> 24) & 0x0f)
> > +#define BTF_INFO_KIND(info)    (((info) >> 24) & 0x1f)
> >  #define BTF_INFO_VLEN(info)    ((info) & 0xffff)
> >  #define BTF_INFO_KFLAG(info)   ((info) >> 31)
> > 
> > @@ -72,7 +72,8 @@ struct btf_type {
> >  #define BTF_KIND_FUNC_PROTO    13      /* Function Proto       */
> >  #define BTF_KIND_VAR           14      /* Variable     */
> >  #define BTF_KIND_DATASEC       15      /* Section      */
> > -#define BTF_KIND_MAX           BTF_KIND_DATASEC
> > +#define BTF_KIND_FLOAT         16      /* Floating point       */
> > +#define BTF_KIND_MAX           BTF_KIND_FLOAT
> >  #define NR_BTF_KINDS           (BTF_KIND_MAX + 1)
> > 
> >  /* For some specific BTF_KIND, "struct btf_type" is immediately
> > @@ -169,4 +170,9 @@ struct btf_var_secinfo {
> >         __u32   size;
> >  };
> > 
> > +/* BTF_KIND_FLOAT is followed by a u32 and the following
> > + * is the 32 bits arrangement:
> > + */
> > +#define BTF_FLOAT_BITS(VAL)    ((VAL)  & 0x000000ff)
> > +
> >  #endif /* _UAPI__LINUX_BTF_H__ */
> > --
> > 2.29.2
> > 


