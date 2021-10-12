Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF542A38E
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhJLLpu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 07:45:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232704AbhJLLpu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Oct 2021 07:45:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CB3Mso026714;
        Tue, 12 Oct 2021 07:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jOvfsQNRsaWG6xIqiUwd8J5SFAiJeaVyxUdtYxIhmno=;
 b=Y/JhRqQdKCndCigWg/tch5hYzu63KHM68Jp5NwrPGb2ww2vUeuCIvmFKlaJ0lLvqfVCS
 yCURcAtdirmiGAV32THPF7MdBuldyhYx/Dkc/pbKt/mIcgOGYGbMmCkyqxm8buntmUfi
 ShjG6p2ki3WIKdx9u0h+/IQ2cSQvaF8QnzGOSCsDDgzbWVgncAypY7h7UjJkP1eisHGo
 br2qIM0mFVrt5TPtvi9GHb/Che7Rr+mIDZkGzUAtqGmFMJZnjA82CJIdgGqZ71zPoUg9
 rLi9NeC19dGireAchotG5nw+PZfOuhY6Qa0cCJvnFL8P/GFHiCiEMDu+Iaas3MdacvIc fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn49yqfqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 07:43:37 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19CBN9Vg019406;
        Tue, 12 Oct 2021 07:43:36 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn49yqfps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 07:43:36 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19CBhPcZ031110;
        Tue, 12 Oct 2021 11:43:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3bk2q9pa6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 11:43:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19CBhK7g23069036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 11:43:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E79C75207A;
        Tue, 12 Oct 2021 11:43:20 +0000 (GMT)
Received: from sig-9-145-45-184.uk.ibm.com (unknown [9.145.45.184])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9D0905204F;
        Tue, 12 Oct 2021 11:43:20 +0000 (GMT)
Message-ID: <b4e2bd3d417a808cb747c09bf6cfa6f74404f1c0.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: Fix dumping big-endian bitfields
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 12 Oct 2021 13:43:20 +0200
In-Reply-To: <CAEf4BzZeUQf4DzCNgkpR7yqsb41=Vvu8EPfdTQBwaBk95Dxi-w@mail.gmail.com>
References: <20211012023218.399568-1-iii@linux.ibm.com>
         <20211012023218.399568-3-iii@linux.ibm.com>
         <CAEf4BzZeUQf4DzCNgkpR7yqsb41=Vvu8EPfdTQBwaBk95Dxi-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UaXgtLwku4G3Bj7opmC_tgNnZmfP6sV_
X-Proofpoint-GUID: iTF0q4JhUK-UgrMGss-0DUINa05opmXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_02,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120067
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-10-12 at 06:03 +0200, Andrii Nakryiko wrote:
> On Tue, Oct 12, 2021 at 4:32 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > On big-endian arches not only bytes, but also bits are numbered in
> > reverse order (see e.g. S/390 ELF ABI Supplement, but this is also
> > true
> > for other big-endian arches as well).
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  tools/lib/bpf/btf_dump.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > index ad6df97295ae..ab45771d0cb4 100644
> > --- a/tools/lib/bpf/btf_dump.c
> > +++ b/tools/lib/bpf/btf_dump.c
> > @@ -1577,14 +1577,15 @@ static int
> > btf_dump_get_bitfield_value(struct btf_dump *d,
> >         /* Bitfield value retrieval is done in two steps; first
> > relevant bytes are
> >          * stored in num, then we left/right shift num to eliminate
> > irrelevant bits.
> >          */
> > -       nr_copy_bits = bit_sz + bits_offset;
> >         nr_copy_bytes = t->size;
> >  #if __BYTE_ORDER == __LITTLE_ENDIAN
> >         for (i = nr_copy_bytes - 1; i >= 0; i--)
> >                 num = num * 256 + bytes[i];
> > +       nr_copy_bits = bit_sz + bits_offset;
> >  #elif __BYTE_ORDER == __BIG_ENDIAN
> >         for (i = 0; i < nr_copy_bytes; i++)
> >                 num = num * 256 + bytes[i];
> > +       nr_copy_bits = nr_copy_bytes * 8 - bits_offset;
> 
> oh, I remember dealing with this in the context of pahole. Just one
> nit, please use t->size instead of nr_copy_bytes, I think it will
> make
> it a bit more explicit (nr_copy_bytes is logically mutable, though
> only in little-endian case, but still).

Both sz and num_copy_bytes look redundant to be honest. What do you
think about dropping both completely and just using t->size everywhere
instead?

> 
> >  #else
> >  # error "Unrecognized __BYTE_ORDER__"
> >  #endif
> > --
> > 2.31.1
> > 


