Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7EF324766
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 00:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbhBXXMy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 18:12:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234728AbhBXXMv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 18:12:51 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ON4rta173562;
        Wed, 24 Feb 2021 18:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FK/z5lEaYdSvFo5r7CAr13p/aXcsSsLX6k3Gls7p+CA=;
 b=IjIszofKA2sz5QQzxrNZqkbvnJacuoljRxH8u+zwAzSXjHpn2dM2YB6O2YuIB28vqH0M
 gPcwMOSkPMLU6KUN7HsByXLvqeHIH/wpjsx7kwGhrGQZwqhXjst2XmZvlG4G/q5dte3d
 mqelGJ3qZZTsShZqgvqgmHBS1nFKbqPa6q8FfxcOlVGUlBA3Aebgv944/amjpehCRgAo
 aBvJBqDpBtHpFG8W1dvonmYoudOc1VpYyhZLzyJOdjQmdkU6cmzX4SpXcSIvGDbUXG/4
 F3cazirqJ2gIkSeDNtDc+b9isjChZLtSWvz+/XACVBYkhNrDoWZHr9SDW762KH5ETQc6 ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wwr4vhh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:11:59 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11ON6tU3179321;
        Wed, 24 Feb 2021 18:11:58 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wwr4vhfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:11:58 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ON8k5E025813;
        Wed, 24 Feb 2021 23:11:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 36tt28bxnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 23:11:55 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11ONBrRF37486994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 23:11:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 951E84204C;
        Wed, 24 Feb 2021 23:11:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FB0742049;
        Wed, 24 Feb 2021 23:11:53 +0000 (GMT)
Received: from sig-9-145-151-190.de.ibm.com (unknown [9.145.151.190])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 23:11:52 +0000 (GMT)
Message-ID: <912782baa065fb961f61f198cba21bb894d1537a.camel@linux.ibm.com>
Subject: Re: [PATCH v5 bpf-next 2/8] libbpf: Add BTF_KIND_FLOAT support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 25 Feb 2021 00:11:52 +0100
In-Reply-To: <CAEf4BzZdD7gh4ehmH3k-Q_Dt-KtCfX5Xe5PUA93xpo3bS=NTiA@mail.gmail.com>
References: <20210223231459.99664-1-iii@linux.ibm.com>
         <20210223231459.99664-3-iii@linux.ibm.com>
         <CAEf4BzZdD7gh4ehmH3k-Q_Dt-KtCfX5Xe5PUA93xpo3bS=NTiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_13:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240179
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-02-24 at 12:56 -0800, Andrii Nakryiko wrote:
> On Tue, Feb 23, 2021 at 3:15 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > The logic follows that of BTF_KIND_INT most of the time.
> > Sanitization
> > replaces BTF_KIND_FLOATs with equally-sized empty BTF_KIND_STRUCTs
> > on
> > older kernels, for example, the following:
> > 
> >     [4] FLOAT 'float' size=4
> > 
> > becomes the following:
> > 
> >     [4] STRUCT '(anon)' size=4 vlen=0
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> >  tools/lib/bpf/btf.c             | 51
> > ++++++++++++++++++++++++++++++++-
> >  tools/lib/bpf/btf.h             |  6 ++++
> >  tools/lib/bpf/btf_dump.c        |  4 +++
> >  tools/lib/bpf/libbpf.c          | 26 ++++++++++++++++-
> >  tools/lib/bpf/libbpf.map        |  5 ++++
> >  tools/lib/bpf/libbpf_internal.h |  2 ++
> >  6 files changed, 92 insertions(+), 2 deletions(-)
> > 
> 
> [...]
> 
> >  /* it's completely legal to append BTF types with type IDs
> > pointing forward to
> >   * types that haven't been appended yet, so we only make sure that
> > id looks
> >   * sane, we can't guarantee that ID will always be valid
> > @@ -1910,7 +1955,7 @@ static int btf_add_composite(struct btf *btf,
> > int kind, const char *name, __u32
> >   *   - *byte_sz* - size of the struct, in bytes;
> >   *
> >   * Struct initially has no fields in it. Fields can be added by
> > - * btf__add_field() right after btf__add_struct() succeeds.
> > + * btf__add_field() right after btf__add_struct() succeeds.
> 
> Was there some whitespacing problem on this line?

Ouch, yes, I remember dropping this chunk, but my editor appears to
have sneaked it back in. I will split this commit in two (hopefully
it's ok to keep the ack :-)).

