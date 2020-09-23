Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844F12762E8
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 23:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIWVMl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 17:12:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbgIWVMk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Sep 2020 17:12:40 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NL2KtJ016616;
        Wed, 23 Sep 2020 17:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ZdQdC8Nar98jV075v6W2/mXlfvGYHDuO/yvXyC7wQMU=;
 b=LuZYqy0SMcCcjtrVnbKfjGpGIgLWxcpeYk5T0w/xYEUyEOhMElD9369eksUcC9AJKHGM
 85fp9edZsSGAYbMxo9KTS1zpqOpUBOCGlE8HxXTh4F2JbG2k3sCqxKQdOwMeIk7immcC
 1Gv2iiSL+1CPpGmGztzFrgXmRh7jLeolekwps39JnzRpxPdOJ4YFu5tJyag3jYbrgzvR
 ZbMPPv7R+WOkZw5Ewhiwje7p+wtEPfKGURu1n0pfjflO8wzsZtfKGKloCOxfbym7Torw
 ea1ys8lca/KlkP4NOO9Jjw0aWhj8AFgqKCmYvTBdYejNp6ZznW/qN31MxWmhLpu5Rm3H OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33rdfdrw01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 17:12:23 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08NL2Ni4016942;
        Wed, 23 Sep 2020 17:12:23 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33rdfdrvy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 17:12:22 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08NLCJwP008704;
        Wed, 23 Sep 2020 21:12:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33payuba28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 21:12:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08NLCHRx24052018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 21:12:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF4404203F;
        Wed, 23 Sep 2020 21:12:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72B3A42052;
        Wed, 23 Sep 2020 21:12:16 +0000 (GMT)
Received: from sig-9-145-183-66.de.ibm.com (unknown [9.145.183.66])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Sep 2020 21:12:16 +0000 (GMT)
Message-ID: <cf1a51289051cbe3d70e9a755c64f4da8ccf15a5.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Fix endianness issues in
 sk_lookup/ctx_narrow_access
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Wed, 23 Sep 2020 23:12:16 +0200
In-Reply-To: <CAEf4BzYGbzwwDLAUdBB+fj1XYRFddOgUUYFAmUmq=jYpPAsaog@mail.gmail.com>
References: <20200909232443.3099637-1-iii@linux.ibm.com>
         <20200909232443.3099637-3-iii@linux.ibm.com>
         <CAEf4BzYGbzwwDLAUdBB+fj1XYRFddOgUUYFAmUmq=jYpPAsaog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_16:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=3 clxscore=1011 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230155
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-09-10 at 09:55 -0700, Andrii Nakryiko wrote:
> On Wed, Sep 9, 2020 at 6:59 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > This test makes a lot of narrow load checks while assuming little
> > endian architecture, and therefore fails on s390.
> > 
> > Fix by introducing LSB and LSW macros and using them to perform
> > narrow
> > loads.
> > 
> > Fixes: 0ab5539f8584 ("selftests/bpf: Tests for BPF_SK_LOOKUP attach
> > point")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> 
> Jakub,
> 
> Can you please help review this to make sure no error accidentally
> slipped in?

Gentle ping.

> 
> >  .../selftests/bpf/progs/test_sk_lookup.c      | 264 ++++++++++--
> > ------
> >  1 file changed, 149 insertions(+), 115 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
> > b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
> > index bbf8296f4d66..94e6d370967b 100644
> > --- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
> > +++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
> > @@ -19,6 +19,17 @@
> >  #define IP6(aaaa, bbbb, cccc, dddd)                    \
> >         { bpf_htonl(aaaa), bpf_htonl(bbbb), bpf_htonl(cccc),
> > bpf_htonl(dddd) }
> > 
> > +/* Macros for least-significant byte and word accesses. */
> > +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> > +#define LSE_INDEX(index, size) (index)
> > +#else
> > +#define LSE_INDEX(index, size) ((size) - (index) - 1)
> > +#endif
> > +#define LSB(value, index)                              \
> > +       (((__u8 *)&(value))[LSE_INDEX((index), sizeof(value))])
> > +#define LSW(value, index)                              \
> > +       (((__u16 *)&(value))[LSE_INDEX((index), sizeof(value) /
> > 2)])
> > +
> >  #define MAX_SOCKS 32
> > 
> >  struct {
> > @@ -369,171 +380,194 @@ int ctx_narrow_access(struct bpf_sk_lookup
> > *ctx)
> >  {
> >         struct bpf_sock *sk;
> >         int err, family;
> > -       __u16 *half;
> > -       __u8 *byte;
> >         bool v4;
> > 
> >         v4 = (ctx->family == AF_INET);
> > 
> >         /* Narrow loads from family field */
> > -       byte = (__u8 *)&ctx->family;
> > -       half = (__u16 *)&ctx->family;
> > -       if (byte[0] != (v4 ? AF_INET : AF_INET6) ||
> > -           byte[1] != 0 || byte[2] != 0 || byte[3] != 0)
> > +       if (LSB(ctx->family, 0) != (v4 ? AF_INET : AF_INET6) ||
> > +           LSB(ctx->family, 1) != 0 || LSB(ctx->family, 2) != 0 ||
> > +           LSB(ctx->family, 3) != 0)
> >                 return SK_DROP;
> > -       if (half[0] != (v4 ? AF_INET : AF_INET6))
> > +       if (LSW(ctx->family, 0) != (v4 ? AF_INET : AF_INET6))
> >                 return SK_DROP;
> > 
> > -       byte = (__u8 *)&ctx->protocol;
> > -       if (byte[0] != IPPROTO_TCP ||
> > -           byte[1] != 0 || byte[2] != 0 || byte[3] != 0)
> > +       /* Narrow loads from protocol field */
> > +       if (LSB(ctx->protocol, 0) != IPPROTO_TCP ||
> > +           LSB(ctx->protocol, 1) != 0 || LSB(ctx->protocol, 2) !=
> > 0 ||
> > +           LSB(ctx->protocol, 3) != 0)
> >                 return SK_DROP;
> > -       half = (__u16 *)&ctx->protocol;
> > -       if (half[0] != IPPROTO_TCP)
> > +       if (LSW(ctx->protocol, 0) != IPPROTO_TCP)
> >                 return SK_DROP;
> > 
> >         /* Narrow loads from remote_port field. Expect non-0 value.
> > */
> > -       byte = (__u8 *)&ctx->remote_port;
> > -       if (byte[0] == 0 && byte[1] == 0 && byte[2] == 0 && byte[3]
> > == 0)
> > +       if (LSB(ctx->remote_port, 0) == 0 && LSB(ctx->remote_port,
> > 1) == 0 &&
> > +           LSB(ctx->remote_port, 2) == 0 && LSB(ctx->remote_port,
> > 3) == 0)
> >                 return SK_DROP;
> > -       half = (__u16 *)&ctx->remote_port;
> > -       if (half[0] == 0)
> > +       if (LSW(ctx->remote_port, 0) == 0)
> >                 return SK_DROP;
> > 
> >         /* Narrow loads from local_port field. Expect DST_PORT. */
> > -       byte = (__u8 *)&ctx->local_port;
> > -       if (byte[0] != ((DST_PORT >> 0) & 0xff) ||
> > -           byte[1] != ((DST_PORT >> 8) & 0xff) ||
> > -           byte[2] != 0 || byte[3] != 0)
> > +       if (LSB(ctx->local_port, 0) != ((DST_PORT >> 0) & 0xff) ||
> > +           LSB(ctx->local_port, 1) != ((DST_PORT >> 8) & 0xff) ||
> > +           LSB(ctx->local_port, 2) != 0 || LSB(ctx->local_port, 3)
> > != 0)
> >                 return SK_DROP;
> > -       half = (__u16 *)&ctx->local_port;
> > -       if (half[0] != DST_PORT)
> > +       if (LSW(ctx->local_port, 0) != DST_PORT)
> >                 return SK_DROP;
> > 
> >         /* Narrow loads from IPv4 fields */
> >         if (v4) {
> >                 /* Expect non-0.0.0.0 in remote_ip4 */
> > -               byte = (__u8 *)&ctx->remote_ip4;
> > -               if (byte[0] == 0 && byte[1] == 0 &&
> > -                   byte[2] == 0 && byte[3] == 0)
> > +               if (LSB(ctx->remote_ip4, 0) == 0 &&
> > +                   LSB(ctx->remote_ip4, 1) == 0 &&
> > +                   LSB(ctx->remote_ip4, 2) == 0 &&
> > +                   LSB(ctx->remote_ip4, 3) == 0)
> >                         return SK_DROP;
> > -               half = (__u16 *)&ctx->remote_ip4;
> > -               if (half[0] == 0 && half[1] == 0)
> > +               if (LSW(ctx->remote_ip4, 0) == 0 &&
> > +                   LSW(ctx->remote_ip4, 1) == 0)
> >                         return SK_DROP;
> > 
> >                 /* Expect DST_IP4 in local_ip4 */
> > -               byte = (__u8 *)&ctx->local_ip4;
> > -               if (byte[0] != ((DST_IP4 >>  0) & 0xff) ||
> > -                   byte[1] != ((DST_IP4 >>  8) & 0xff) ||
> > -                   byte[2] != ((DST_IP4 >> 16) & 0xff) ||
> > -                   byte[3] != ((DST_IP4 >> 24) & 0xff))
> > +               if (LSB(ctx->local_ip4, 0) != ((DST_IP4 >> 0) &
> > 0xff) ||
> > +                   LSB(ctx->local_ip4, 1) != ((DST_IP4 >> 8) &
> > 0xff) ||
> > +                   LSB(ctx->local_ip4, 2) != ((DST_IP4 >> 16) &
> > 0xff) ||
> > +                   LSB(ctx->local_ip4, 3) != ((DST_IP4 >> 24) &
> > 0xff))
> >                         return SK_DROP;
> > -               half = (__u16 *)&ctx->local_ip4;
> > -               if (half[0] != ((DST_IP4 >>  0) & 0xffff) ||
> > -                   half[1] != ((DST_IP4 >> 16) & 0xffff))
> > +               if (LSW(ctx->local_ip4, 0) != ((DST_IP4 >> 0) &
> > 0xffff) ||
> > +                   LSW(ctx->local_ip4, 1) != ((DST_IP4 >> 16) &
> > 0xffff))
> >                         return SK_DROP;
> >         } else {
> >                 /* Expect 0.0.0.0 IPs when family != AF_INET */
> > -               byte = (__u8 *)&ctx->remote_ip4;
> > -               if (byte[0] != 0 || byte[1] != 0 &&
> > -                   byte[2] != 0 || byte[3] != 0)
> > +               if (LSB(ctx->remote_ip4, 0) != 0 ||
> > +                   LSB(ctx->remote_ip4, 1) != 0 ||
> > +                   LSB(ctx->remote_ip4, 2) != 0 ||
> > +                   LSB(ctx->remote_ip4, 3) != 0)
> >                         return SK_DROP;
> > -               half = (__u16 *)&ctx->remote_ip4;
> > -               if (half[0] != 0 || half[1] != 0)
> > +               if (LSW(ctx->remote_ip4, 0) != 0 ||
> > +                   LSW(ctx->remote_ip4, 1) != 0)
> >                         return SK_DROP;
> > 
> > -               byte = (__u8 *)&ctx->local_ip4;
> > -               if (byte[0] != 0 || byte[1] != 0 &&
> > -                   byte[2] != 0 || byte[3] != 0)
> > +               if (LSB(ctx->local_ip4, 0) != 0 ||
> > +                   LSB(ctx->local_ip4, 1) != 0 ||
> > +                   LSB(ctx->local_ip4, 2) != 0 || LSB(ctx-
> > >local_ip4, 3) != 0)
> >                         return SK_DROP;
> > -               half = (__u16 *)&ctx->local_ip4;
> > -               if (half[0] != 0 || half[1] != 0)
> > +               if (LSW(ctx->local_ip4, 0) != 0 || LSW(ctx-
> > >local_ip4, 1) != 0)
> >                         return SK_DROP;
> >         }
> > 
> >         /* Narrow loads from IPv6 fields */
> >         if (!v4) {
> > -               /* Expenct non-:: IP in remote_ip6 */
> > -               byte = (__u8 *)&ctx->remote_ip6;
> > -               if (byte[0] == 0 && byte[1] == 0 &&
> > -                   byte[2] == 0 && byte[3] == 0 &&
> > -                   byte[4] == 0 && byte[5] == 0 &&
> > -                   byte[6] == 0 && byte[7] == 0 &&
> > -                   byte[8] == 0 && byte[9] == 0 &&
> > -                   byte[10] == 0 && byte[11] == 0 &&
> > -                   byte[12] == 0 && byte[13] == 0 &&
> > -                   byte[14] == 0 && byte[15] == 0)
> > +               /* Expect non-:: IP in remote_ip6 */
> > +               if (LSB(ctx->remote_ip6[0], 0) == 0 &&
> > +                   LSB(ctx->remote_ip6[0], 1) == 0 &&
> > +                   LSB(ctx->remote_ip6[0], 2) == 0 &&
> > +                   LSB(ctx->remote_ip6[0], 3) == 0 &&
> > +                   LSB(ctx->remote_ip6[1], 0) == 0 &&
> > +                   LSB(ctx->remote_ip6[1], 1) == 0 &&
> > +                   LSB(ctx->remote_ip6[1], 2) == 0 &&
> > +                   LSB(ctx->remote_ip6[1], 3) == 0 &&
> > +                   LSB(ctx->remote_ip6[2], 0) == 0 &&
> > +                   LSB(ctx->remote_ip6[2], 1) == 0 &&
> > +                   LSB(ctx->remote_ip6[2], 2) == 0 &&
> > +                   LSB(ctx->remote_ip6[2], 3) == 0 &&
> > +                   LSB(ctx->remote_ip6[3], 0) == 0 &&
> > +                   LSB(ctx->remote_ip6[3], 1) == 0 &&
> > +                   LSB(ctx->remote_ip6[3], 2) == 0 &&
> > +                   LSB(ctx->remote_ip6[3], 3) == 0)
> >                         return SK_DROP;
> > -               half = (__u16 *)&ctx->remote_ip6;
> > -               if (half[0] == 0 && half[1] == 0 &&
> > -                   half[2] == 0 && half[3] == 0 &&
> > -                   half[4] == 0 && half[5] == 0 &&
> > -                   half[6] == 0 && half[7] == 0)
> > +               if (LSW(ctx->remote_ip6[0], 0) == 0 &&
> > +                   LSW(ctx->remote_ip6[0], 1) == 0 &&
> > +                   LSW(ctx->remote_ip6[1], 0) == 0 &&
> > +                   LSW(ctx->remote_ip6[1], 1) == 0 &&
> > +                   LSW(ctx->remote_ip6[2], 0) == 0 &&
> > +                   LSW(ctx->remote_ip6[2], 1) == 0 &&
> > +                   LSW(ctx->remote_ip6[3], 0) == 0 &&
> > +                   LSW(ctx->remote_ip6[3], 1) == 0)
> >                         return SK_DROP;
> > -
> >                 /* Expect DST_IP6 in local_ip6 */
> > -               byte = (__u8 *)&ctx->local_ip6;
> > -               if (byte[0] != ((DST_IP6[0] >>  0) & 0xff) ||
> > -                   byte[1] != ((DST_IP6[0] >>  8) & 0xff) ||
> > -                   byte[2] != ((DST_IP6[0] >> 16) & 0xff) ||
> > -                   byte[3] != ((DST_IP6[0] >> 24) & 0xff) ||
> > -                   byte[4] != ((DST_IP6[1] >>  0) & 0xff) ||
> > -                   byte[5] != ((DST_IP6[1] >>  8) & 0xff) ||
> > -                   byte[6] != ((DST_IP6[1] >> 16) & 0xff) ||
> > -                   byte[7] != ((DST_IP6[1] >> 24) & 0xff) ||
> > -                   byte[8] != ((DST_IP6[2] >>  0) & 0xff) ||
> > -                   byte[9] != ((DST_IP6[2] >>  8) & 0xff) ||
> > -                   byte[10] != ((DST_IP6[2] >> 16) & 0xff) ||
> > -                   byte[11] != ((DST_IP6[2] >> 24) & 0xff) ||
> > -                   byte[12] != ((DST_IP6[3] >>  0) & 0xff) ||
> > -                   byte[13] != ((DST_IP6[3] >>  8) & 0xff) ||
> > -                   byte[14] != ((DST_IP6[3] >> 16) & 0xff) ||
> > -                   byte[15] != ((DST_IP6[3] >> 24) & 0xff))
> > +               if (LSB(ctx->local_ip6[0], 0) != ((DST_IP6[0] >> 0)
> > & 0xff) ||
> > +                   LSB(ctx->local_ip6[0], 1) != ((DST_IP6[0] >> 8)
> > & 0xff) ||
> > +                   LSB(ctx->local_ip6[0], 2) != ((DST_IP6[0] >>
> > 16) & 0xff) ||
> > +                   LSB(ctx->local_ip6[0], 3) != ((DST_IP6[0] >>
> > 24) & 0xff) ||
> > +                   LSB(ctx->local_ip6[1], 0) != ((DST_IP6[1] >> 0)
> > & 0xff) ||
> > +                   LSB(ctx->local_ip6[1], 1) != ((DST_IP6[1] >> 8)
> > & 0xff) ||
> > +                   LSB(ctx->local_ip6[1], 2) != ((DST_IP6[1] >>
> > 16) & 0xff) ||
> > +                   LSB(ctx->local_ip6[1], 3) != ((DST_IP6[1] >>
> > 24) & 0xff) ||
> > +                   LSB(ctx->local_ip6[2], 0) != ((DST_IP6[2] >> 0)
> > & 0xff) ||
> > +                   LSB(ctx->local_ip6[2], 1) != ((DST_IP6[2] >> 8)
> > & 0xff) ||
> > +                   LSB(ctx->local_ip6[2], 2) != ((DST_IP6[2] >>
> > 16) & 0xff) ||
> > +                   LSB(ctx->local_ip6[2], 3) != ((DST_IP6[2] >>
> > 24) & 0xff) ||
> > +                   LSB(ctx->local_ip6[3], 0) != ((DST_IP6[3] >> 0)
> > & 0xff) ||
> > +                   LSB(ctx->local_ip6[3], 1) != ((DST_IP6[3] >> 8)
> > & 0xff) ||
> > +                   LSB(ctx->local_ip6[3], 2) != ((DST_IP6[3] >>
> > 16) & 0xff) ||
> > +                   LSB(ctx->local_ip6[3], 3) != ((DST_IP6[3] >>
> > 24) & 0xff))
> >                         return SK_DROP;
> > -               half = (__u16 *)&ctx->local_ip6;
> > -               if (half[0] != ((DST_IP6[0] >>  0) & 0xffff) ||
> > -                   half[1] != ((DST_IP6[0] >> 16) & 0xffff) ||
> > -                   half[2] != ((DST_IP6[1] >>  0) & 0xffff) ||
> > -                   half[3] != ((DST_IP6[1] >> 16) & 0xffff) ||
> > -                   half[4] != ((DST_IP6[2] >>  0) & 0xffff) ||
> > -                   half[5] != ((DST_IP6[2] >> 16) & 0xffff) ||
> > -                   half[6] != ((DST_IP6[3] >>  0) & 0xffff) ||
> > -                   half[7] != ((DST_IP6[3] >> 16) & 0xffff))
> > +               if (LSW(ctx->local_ip6[0], 0) != ((DST_IP6[0] >> 0)
> > & 0xffff) ||
> > +                   LSW(ctx->local_ip6[0], 1) !=
> > +                           ((DST_IP6[0] >> 16) & 0xffff) ||
> > +                   LSW(ctx->local_ip6[1], 0) != ((DST_IP6[1] >> 0)
> > & 0xffff) ||
> > +                   LSW(ctx->local_ip6[1], 1) !=
> > +                           ((DST_IP6[1] >> 16) & 0xffff) ||
> > +                   LSW(ctx->local_ip6[2], 0) != ((DST_IP6[2] >> 0)
> > & 0xffff) ||
> > +                   LSW(ctx->local_ip6[2], 1) !=
> > +                           ((DST_IP6[2] >> 16) & 0xffff) ||
> > +                   LSW(ctx->local_ip6[3], 0) != ((DST_IP6[3] >> 0)
> > & 0xffff) ||
> > +                   LSW(ctx->local_ip6[3], 1) != ((DST_IP6[3] >>
> > 16) & 0xffff))
> >                         return SK_DROP;
> >         } else {
> >                 /* Expect :: IPs when family != AF_INET6 */
> > -               byte = (__u8 *)&ctx->remote_ip6;
> > -               if (byte[0] != 0 || byte[1] != 0 ||
> > -                   byte[2] != 0 || byte[3] != 0 ||
> > -                   byte[4] != 0 || byte[5] != 0 ||
> > -                   byte[6] != 0 || byte[7] != 0 ||
> > -                   byte[8] != 0 || byte[9] != 0 ||
> > -                   byte[10] != 0 || byte[11] != 0 ||
> > -                   byte[12] != 0 || byte[13] != 0 ||
> > -                   byte[14] != 0 || byte[15] != 0)
> > +               if (LSB(ctx->remote_ip6[0], 0) != 0 ||
> > +                   LSB(ctx->remote_ip6[0], 1) != 0 ||
> > +                   LSB(ctx->remote_ip6[0], 2) != 0 ||
> > +                   LSB(ctx->remote_ip6[0], 3) != 0 ||
> > +                   LSB(ctx->remote_ip6[1], 0) != 0 ||
> > +                   LSB(ctx->remote_ip6[1], 1) != 0 ||
> > +                   LSB(ctx->remote_ip6[1], 2) != 0 ||
> > +                   LSB(ctx->remote_ip6[1], 3) != 0 ||
> > +                   LSB(ctx->remote_ip6[2], 0) != 0 ||
> > +                   LSB(ctx->remote_ip6[2], 1) != 0 ||
> > +                   LSB(ctx->remote_ip6[2], 2) != 0 ||
> > +                   LSB(ctx->remote_ip6[2], 3) != 0 ||
> > +                   LSB(ctx->remote_ip6[3], 0) != 0 ||
> > +                   LSB(ctx->remote_ip6[3], 1) != 0 ||
> > +                   LSB(ctx->remote_ip6[3], 2) != 0 ||
> > +                   LSB(ctx->remote_ip6[3], 3) != 0)
> >                         return SK_DROP;
> > -               half = (__u16 *)&ctx->remote_ip6;
> > -               if (half[0] != 0 || half[1] != 0 ||
> > -                   half[2] != 0 || half[3] != 0 ||
> > -                   half[4] != 0 || half[5] != 0 ||
> > -                   half[6] != 0 || half[7] != 0)
> > +               if (LSW(ctx->remote_ip6[0], 0) != 0 ||
> > +                   LSW(ctx->remote_ip6[0], 1) != 0 ||
> > +                   LSW(ctx->remote_ip6[1], 0) != 0 ||
> > +                   LSW(ctx->remote_ip6[1], 1) != 0 ||
> > +                   LSW(ctx->remote_ip6[2], 0) != 0 ||
> > +                   LSW(ctx->remote_ip6[2], 1) != 0 ||
> > +                   LSW(ctx->remote_ip6[3], 0) != 0 ||
> > +                   LSW(ctx->remote_ip6[3], 1) != 0)
> >                         return SK_DROP;
> > 
> > -               byte = (__u8 *)&ctx->local_ip6;
> > -               if (byte[0] != 0 || byte[1] != 0 ||
> > -                   byte[2] != 0 || byte[3] != 0 ||
> > -                   byte[4] != 0 || byte[5] != 0 ||
> > -                   byte[6] != 0 || byte[7] != 0 ||
> > -                   byte[8] != 0 || byte[9] != 0 ||
> > -                   byte[10] != 0 || byte[11] != 0 ||
> > -                   byte[12] != 0 || byte[13] != 0 ||
> > -                   byte[14] != 0 || byte[15] != 0)
> > +               if (LSB(ctx->local_ip6[0], 0) != 0 ||
> > +                   LSB(ctx->local_ip6[0], 1) != 0 ||
> > +                   LSB(ctx->local_ip6[0], 2) != 0 ||
> > +                   LSB(ctx->local_ip6[0], 3) != 0 ||
> > +                   LSB(ctx->local_ip6[1], 0) != 0 ||
> > +                   LSB(ctx->local_ip6[1], 1) != 0 ||
> > +                   LSB(ctx->local_ip6[1], 2) != 0 ||
> > +                   LSB(ctx->local_ip6[1], 3) != 0 ||
> > +                   LSB(ctx->local_ip6[2], 0) != 0 ||
> > +                   LSB(ctx->local_ip6[2], 1) != 0 ||
> > +                   LSB(ctx->local_ip6[2], 2) != 0 ||
> > +                   LSB(ctx->local_ip6[2], 3) != 0 ||
> > +                   LSB(ctx->local_ip6[3], 0) != 0 ||
> > +                   LSB(ctx->local_ip6[3], 1) != 0 ||
> > +                   LSB(ctx->local_ip6[3], 2) != 0 ||
> > +                   LSB(ctx->local_ip6[3], 3) != 0)
> >                         return SK_DROP;
> > -               half = (__u16 *)&ctx->local_ip6;
> > -               if (half[0] != 0 || half[1] != 0 ||
> > -                   half[2] != 0 || half[3] != 0 ||
> > -                   half[4] != 0 || half[5] != 0 ||
> > -                   half[6] != 0 || half[7] != 0)
> > +               if (LSW(ctx->remote_ip6[0], 0) != 0 ||
> > +                   LSW(ctx->remote_ip6[0], 1) != 0 ||
> > +                   LSW(ctx->remote_ip6[1], 0) != 0 ||
> > +                   LSW(ctx->remote_ip6[1], 1) != 0 ||
> > +                   LSW(ctx->remote_ip6[2], 0) != 0 ||
> > +                   LSW(ctx->remote_ip6[2], 1) != 0 ||
> > +                   LSW(ctx->remote_ip6[3], 0) != 0 ||
> > +                   LSW(ctx->remote_ip6[3], 1) != 0)
> >                         return SK_DROP;
> >         }
> > 
> > --
> > 2.25.4
> > 

