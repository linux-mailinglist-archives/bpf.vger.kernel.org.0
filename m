Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9482C435F0F
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 12:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJUKcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 06:32:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhJUKcH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 06:32:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L8rBfV004120;
        Thu, 21 Oct 2021 06:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ArCn6UNHoGpGtwrwCOk147SdoJ1KXDlManUpuGbMLoA=;
 b=eYfQIB+e7cuDeqIg2jcqzJyTEhsSq19eQZLSgLMOYn+jVD8iDDv1WXeq43pFwe1iMisj
 FiYieK/hp1uTaQyL2fTQXSKRPl7BmGQRTvWSMub8TSSWtC8NUUYmYCjeKeRq7OrjJl8M
 Z9+3J5mus/DrxJowcUmVrNtOxNi9sKvp5PlvZNc8SC395tNPXJJfiwrhcVGXV2pZD1VZ
 MzuYFiNmfUgyMM64Xo7Tz7kQnB0E/98FL8PA9TtXZpfoTLMskNxNfLnkAuKkwOmFbJ2F
 oSVQOckBX1Jm9WiFK1pKHirEuQkUvNSnN5aTNOymjGY8dI8PeXYB1jIsHS1p1D7IiEu2 HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btthkp6j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 06:29:38 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19LAFTZj004673;
        Thu, 21 Oct 2021 06:29:38 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btthkp6ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 06:29:38 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19LAILos027604;
        Thu, 21 Oct 2021 10:29:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3bqpcb5pqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 10:29:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19LATWxQ983688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 10:29:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C9B342042;
        Thu, 21 Oct 2021 10:29:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B177742045;
        Thu, 21 Oct 2021 10:29:31 +0000 (GMT)
Received: from sig-9-145-12-156.uk.ibm.com (unknown [9.145.12.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Oct 2021 10:29:31 +0000 (GMT)
Message-ID: <fdcd0720851bbac1e9e582355c4368fd6eb3ec5f.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 4/4] libbpf: Fix ptr_is_aligned() usages
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 21 Oct 2021 12:29:31 +0200
In-Reply-To: <CAEf4Bza9Vq7P8OL7bwSo9xSjHfqX20XMFRnfT7Kvtji6-YQMug@mail.gmail.com>
References: <20211013160902.428340-1-iii@linux.ibm.com>
         <20211013160902.428340-5-iii@linux.ibm.com>
         <CAEf4BzbQcsz8Y1_MVhnyjCaYx-t-MWBD8xykF3x-UHE9a+X8HQ@mail.gmail.com>
         <9c925536f10105414327ed70e7e50321061c9204.camel@linux.ibm.com>
         <CAEf4Bza9Vq7P8OL7bwSo9xSjHfqX20XMFRnfT7Kvtji6-YQMug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uRWtLBeqxmWLnjWN_Acpn_NISBo24xew
X-Proofpoint-GUID: 8Q_sTLoUjSeFrdCp46ka-cAXUbVcMbcY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_02,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210051
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-10-20 at 16:10 -0700, Andrii Nakryiko wrote:
> On Wed, Oct 20, 2021 at 4:05 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > On Wed, 2021-10-20 at 11:44 -0700, Andrii Nakryiko wrote:
> > > On Wed, Oct 13, 2021 at 9:09 AM Ilya Leoshkevich
> > > <iii@linux.ibm.com>
> > > wrote:
> > > > 
> > > > Currently ptr_is_aligned() takes size, and not alignment, as a
> > > > parameter, which may be overly pessimistic e.g. for __i128 on
> > > > s390,
> > > > which must be only 8-byte aligned. Fix by using btf__align_of()
> > > > where
> > > > possible - one notable exception is ptr_sz, for which there is no
> > > > corresponding type.
> > > > 
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > > >  tools/lib/bpf/btf_dump.c | 12 +++++-------
> > > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > > > index 25ce60828e8d..da345520892f 100644
> > > > --- a/tools/lib/bpf/btf_dump.c
> > > > +++ b/tools/lib/bpf/btf_dump.c
> > > > @@ -1657,9 +1657,9 @@ static int
> > > > btf_dump_base_type_check_zero(struct btf_dump *d,
> > > >         return 0;
> > > >  }
> > > > 
> > > > -static bool ptr_is_aligned(const void *data, int data_sz)
> > > > +static bool ptr_is_aligned(const void *data, int alignment)
> > > >  {
> > > > -       return ((uintptr_t)data) % data_sz == 0;
> > > > +       return ((uintptr_t)data) % alignment == 0;
> > > 
> > > btf__align_of() can return 0 on error and this will be div by 0. I
> > > think the better approach would be for ptr_is_aligned to accept
> > > struct
> > > btf *btf and __u32 type_id, call btf__align_of() based on btf and
> > > type
> > > id, handle 0 case pessimistically (assume not aligned).
> > 
> > I thought about this, but it won't cover the ptr_sz case. Maybe we
> > just need two functions - I'll give it a try tomorrow.
> > 
> 
> Sorry, what's the ptr_sz case? Is this about btf_ptr_sz() helper
> somehow?

Almost, I'm referring to this check:

static int btf_dump_ptr_data(struct btf_dump *d,
			      const struct btf_type *t,
			      __u32 id,
			      const void *data)
{
	if (ptr_is_aligned(data, d->ptr_sz) && d->ptr_sz ==
sizeof(void *)) {
...

