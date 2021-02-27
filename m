Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC4326B99
	for <lists+bpf@lfdr.de>; Sat, 27 Feb 2021 06:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhB0FOR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Feb 2021 00:14:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28264 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhB0FOQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 27 Feb 2021 00:14:16 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11R54LuZ096415;
        Sat, 27 Feb 2021 00:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=bRtw7DpQs0NwtjAiBX1UphIOJfHzmzPillNmd05vu3I=;
 b=eDDxhxfiIWpgX1juXofIeRkFEfJIeixuBtMDe0UCclIJaXF2wBAPp4EX6LcAw2I7GqGU
 wuBCCWjSv3tRIcbvKCA13weWArhJkxw1+BFQy9zQXqW7dXLKfNX+gablVcZGaP+Vr/GF
 bCqgf7edFDFrHeJndneaM4eJ2d7k2HG8gQH/NKzkL7SFkMbeA7Jp7sAbLc8hizXtY7fc
 hP4mtf46yNVJ1yOptxzpXvLnTKF91ofqfPf61r5wvRMUu6jyzgH7Sji9lSnb2g+pJzNi
 dmYX6zS1vasKMgFkPYJYn6AI4uXE1V1tJrx3lRmvpDV1CJL04D/QY0w2/XOEWs9wiJmh 1Q== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ycenur3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Feb 2021 00:13:23 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11R5Clxa005859;
        Sat, 27 Feb 2021 05:13:21 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 36ydbh818b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Feb 2021 05:13:21 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11R5D50530343560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Feb 2021 05:13:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B79FCA4051;
        Sat, 27 Feb 2021 05:13:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CA77A404D;
        Sat, 27 Feb 2021 05:13:18 +0000 (GMT)
Received: from sig-9-145-151-190.de.ibm.com (unknown [9.145.151.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 27 Feb 2021 05:13:18 +0000 (GMT)
Message-ID: <5493032612904e8aeeb0622146a14f0a4254016a.camel@linux.ibm.com>
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Use the last page in
 test_snprintf_btf on s390
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     bpf@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
Date:   Sat, 27 Feb 2021 06:13:18 +0100
In-Reply-To: <21c13c15-0dbc-8430-9e04-0932f6f913f0@fb.com>
References: <20210226190908.115706-1-iii@linux.ibm.com>
         <21c13c15-0dbc-8430-9e04-0932f6f913f0@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-27_03:2021-02-26,2021-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102270034
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2021-02-26 at 19:47 -0800, Yonghong Song wrote:
> 
> 
> On 2/26/21 11:09 AM, Ilya Leoshkevich wrote:
> > test_snprintf_btf fails on s390, because NULL points to a readable
> > struct lowcore there. Fix by using the last page instead.
> > 
> > Error message example:
> > 
> >      printing 0000000000000000 should generate error, got (361)
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > 
> > v1: 
> > https://lore.kernel.org/bpf/20210226135923.114211-1-iii@linux.ibm.com/
> > v1 -> v2: Yonghong suggested to add the pointer value to the error
> >            message.
> >            I've noticed that I've been passing BADPTR as flags,
> > therefore
> >            the fix worked only by accident. Put it into p.ptr where
> > it
> >            belongs.
> > 
> > v2: 
> > https://lore.kernel.org/bpf/20210226182014.115347-1-iii@linux.ibm.com/
> > v2 -> v3: Heiko mentioned that using _REGION1_SIZE is not future-
> > proof.
> >            We had a private discussion and came to the conclusion
> > that
> >            the the last page is good enough.
> 
> Heiko, could you ack the patch if it is okay? Thanks!
> 
> > 
> >   .../testing/selftests/bpf/progs/netif_receive_skb.c | 13
> > ++++++++++---
> >   1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > index 6b670039ea67..c3669967067e 100644
> > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > @@ -16,6 +16,13 @@ bool skip = false;
> >   #define STRSIZE                       2048
> >   #define EXPECTED_STRSIZE      256
> >   
> > +#if defined(bpf_target_s390)
> > +/* NULL points to a readable struct lowcore on s390, so take the
> > last page */
> > +#define BADPTR                 ((void *)0xFFFFFFFFFFFFF000ULL)
> > +#else
> > +#define BADPTR                 0
> > +#endif
> > +
> >   #ifndef ARRAY_SIZE
> >   #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> >   #endif
> > @@ -113,11 +120,11 @@ int BPF_PROG(trace_netif_receive_skb, struct
> > sk_buff *skb)
> >         }
> >   
> >         /* Check invalid ptr value */
> > -       p.ptr = 0;
> > +       p.ptr = BADPTR;
> >         __ret = bpf_snprintf_btf(str, STRSIZE, &p, sizeof(p), 0);
> >         if (__ret >= 0) {
> > -               bpf_printk("printing NULL should generate error,
> > got (%d)",
> > -                          __ret);
> > +               bpf_printk("printing %p should generate error, got
> > (%d)",
> > +                          BADPTR, __ret);
> 
>  From https://www.kernel.org/doc/Documentation/printk-formats.txt:
> 
> Pointers printed without a specifier extension (i.e unadorned %p) are
> hashed to give a unique identifier without leaking kernel addresses
> to user
> space. On 64 bit machines the first 32 bits are zeroed. If you
> _really_
> want the address see %px below.
> 
> I think it is okay to use %px here.

I don't think bpf_trace_printk supports it, but I'll use %llx instead.

[...]

