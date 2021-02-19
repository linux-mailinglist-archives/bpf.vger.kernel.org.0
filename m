Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CB431F99C
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 14:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhBSNB5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 08:01:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229681AbhBSNBy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Feb 2021 08:01:54 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JCggPM104538;
        Fri, 19 Feb 2021 08:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=07lxioZ4HoPdBtwmkTrVkTilttT6YNYE5UAP0n+NT/k=;
 b=qP5od98lGBVBYjCoJh+obu1MjHsvNpwC1b8YUt1vGSqx8dhw0kmi22WlHpzEdi8nDItd
 Q9ddM3Cqa3DNd0HKY2HFP5M8ydUk8i00K0ux4HXnbubLXN6Vr69Cw+IJmeZcJbVrtxuT
 ctXiiTZzAG4AtGxDJy4NH+KhCyrP9cnS6U+8vfOLcqulB6TRUmhr/wuiqRjElx+t81kR
 HdgOmehXJZ988tshFAJzHuRousp51hZBlUtpTAC3sWqoN8sZvd0HoIi1h/Zxyf/qhVZf
 SZRTMAagjQMc9BPI+YVDEi0Ig+FxrON0eIKffI97r93myiUSiFCHOJj5rscl7SB5gCLX iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tdju0kcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 08:00:59 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JCgnac104799;
        Fri, 19 Feb 2021 08:00:59 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tdju0kak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 08:00:59 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JCvWTv022862;
        Fri, 19 Feb 2021 13:00:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 36p6d8awr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 13:00:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JD0shL65798616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 13:00:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AF78AE057;
        Fri, 19 Feb 2021 13:00:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B80C6AE045;
        Fri, 19 Feb 2021 13:00:53 +0000 (GMT)
Received: from [9.145.178.56] (unknown [9.145.178.56])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 13:00:53 +0000 (GMT)
Message-ID: <7f133066832e8b925af191d4a5cd8cd8aa782024.camel@linux.ibm.com>
Subject: Re: [PATCH v2 bpf-next 6/6] bpf: Document BTF_KIND_FLOAT in btf.rst
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Fri, 19 Feb 2021 14:00:53 +0100
In-Reply-To: <8e1f764e-856d-4f20-96d5-49c83f692d72@fb.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
         <20210219022543.20893-7-iii@linux.ibm.com>
         <8e1f764e-856d-4f20-96d5-49c83f692d72@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_05:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190099
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2021-02-18 at 21:41 -0800, Yonghong Song wrote:
> 
> 
> On 2/18/21 6:25 PM, Ilya Leoshkevich wrote:
> > Also document the expansion of the kind bitfield.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >   Documentation/bpf/btf.rst | 17 +++++++++++++++--
> >   1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> > index 44dc789de2b4..4f25c992d442 100644
> > --- a/Documentation/bpf/btf.rst
> > +++ b/Documentation/bpf/btf.rst
> > @@ -84,6 +84,7 @@ sequentially and type id is assigned to each
> > recognized type starting from id
> >       #define BTF_KIND_FUNC_PROTO     13      /* Function
> > Proto       */
> >       #define BTF_KIND_VAR            14      /* Variable     */
> >       #define BTF_KIND_DATASEC        15      /* Section      */
> > +    #define BTF_KIND_FLOAT          16      /* Floating
> > point       */
> >   
> >   Note that the type section encodes debug info, not just pure
> > types.
> >   ``BTF_KIND_FUNC`` is not a type, and it represents a defined
> > subprogram.
> > @@ -95,8 +96,8 @@ Each type contains the following common data::
> >           /* "info" bits arrangement
> >            * bits  0-15: vlen (e.g. # of struct's members)
> >            * bits 16-23: unused
> > -         * bits 24-27: kind (e.g. int, ptr, array...etc)
> > -         * bits 28-30: unused
> > +         * bits 24-28: kind (e.g. int, ptr, array...etc)
> > +         * bits 29-30: unused
> >            * bit     31: kind_flag, currently used by
> >            *             struct, union and fwd
> >            */
> > @@ -452,6 +453,18 @@ map definition.
> >     * ``offset``: the in-section offset of the variable
> >     * ``size``: the size of the variable in bytes
> >   
> > +2.2.16 BTF_KIND_FLOAT
> > +~~~~~~~~~~~~~~~~~~~~~
> > +
> > +``struct btf_type`` encoding requirement:
> > + * ``name_off``: any valid offset
> > + * ``info.kind_flag``: 0
> > + * ``info.kind``: BTF_KIND_FLOAT
> > + * ``info.vlen``: 0
> > + * ``size``: the size of the float type in bytes.
> 
> I would be good to specify the allowed size in bytes 2, multiple of
> 4.
> currently we do not have a maximum value, maybe 128. have a float
> type
> something like 2^10 seems strange.

I tried to write this all down and realized it's simpler to enumerate
the allowed values: 2, 4, 8, 12 and 16. I don't think there are 32-byte
floats on any of the architectures supported by the kernel.

