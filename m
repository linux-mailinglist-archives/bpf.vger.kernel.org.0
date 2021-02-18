Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EBB31EC88
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 17:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBRQtU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 11:49:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230443AbhBRNgi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 08:36:38 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11IDVVe4085038;
        Thu, 18 Feb 2021 08:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=QJd4eI4E9FNllLG7VY3vLW9SWusxcLe5G9FlcOS6uPw=;
 b=hYBLdq43UJv5lCugmv0kf9Hw1cqwaL8y50SeEtIUvBJ9JVXNVF/amfyrtWIlyY2bu6l5
 hHMz7/UshlK7UcEAEEoKz4IxmrU2hYuekGOBGw8Dnv72F8eAMnQyJnXolg98/s9vJhV2
 6dchD2u+M7SeciooyrMtjvF8xRu0saQLB0h95aP9dJdjYr+Hh+jRr0NesH6jYosV0bQo
 m0sUyZg63KePL3wwO6DgB84Zn9JcKX9R07gwFIQx2w19pM2yc/nyLUPtvc1hrhO5NsN1
 7ENRrhkie/ebb/9weF9w8vmMaawaVud6he+2QE7tVpNhaUbpkO+4O4XFDbDGZLhgpajA +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36srv80s5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 08:35:19 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11IDVelN085473;
        Thu, 18 Feb 2021 08:35:14 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36srv80rx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 08:35:14 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11IDVfSw028700;
        Thu, 18 Feb 2021 13:35:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 36p6d8je43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 13:35:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11IDYnFG30671224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 13:34:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A6B5A4067;
        Thu, 18 Feb 2021 13:35:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C575A405F;
        Thu, 18 Feb 2021 13:35:00 +0000 (GMT)
Received: from [9.171.64.123] (unknown [9.171.64.123])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Feb 2021 13:35:00 +0000 (GMT)
Message-ID: <4d581ca7743982cb4a1e5baaef2165918f4a2535.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 18 Feb 2021 14:34:59 +0100
In-Reply-To: <a9e9ed02-8791-28b1-60a8-44ea46525d17@fb.com>
References: <20210216011216.3168-1-iii@linux.ibm.com>
         <20210216011216.3168-3-iii@linux.ibm.com>
         <a9e9ed02-8791-28b1-60a8-44ea46525d17@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_05:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180115
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-02-17 at 23:16 -0800, Yonghong Song wrote:
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

> > @@ -2445,6 +2450,9 @@ static void bpf_object__sanitize_btf(struct
> > bpf_object *obj, struct btf *btf)
> >                 } else if (!has_func_global && btf_is_func(t)) {
> >                         /* replace BTF_FUNC_GLOBAL with
> > BTF_FUNC_STATIC */
> >                         t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0,
> > 0);
> > +               } else if (!has_float && btf_is_float(t)) {
> > +                       /* replace FLOAT with INT */
> > +                       t->info = BTF_INFO_ENC(BTF_KIND_FLOAT, 0,
> > 0);
> 
> You can replace float with a "pointer to void" type.

Wouldn't this cause problems with 32-bit floats on 64-bit machines?

[...]

