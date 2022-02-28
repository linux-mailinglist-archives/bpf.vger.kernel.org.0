Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270204C6707
	for <lists+bpf@lfdr.de>; Mon, 28 Feb 2022 11:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiB1KUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 05:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiB1KUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 05:20:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780854EF56
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 02:19:37 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SA8bsg013058;
        Mon, 28 Feb 2022 10:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=N9uPvlO1l1d6lm9fmuktgUWp2GnXuunPWzdSg6YFI4o=;
 b=mxZwqYFylrncKqDGB1JgVM5rfXV36SdJ9CWun9yAzeNa8NQln9lihhyZEgNzlfJZ5Qyj
 fwn2wlBrZRiJNIm3VKbEcehlo6HTi3kEov/VDFPpHiVNsfOZGWuxFQDemybDAhGnw/cW
 IndhcBoCdYwyln1Vo81AGPJh1QGkcIXsLQPCRyZWFRj89Zp2rWK0sWqM/cFq1T2+px70
 kK6kexTN16H5DWbCgJapcgXCprjk3lgUGniGLiPE/+5Dy0eyJfs+7pKNXalRolXssRh9
 Qno+pcuDI0zwpfAr8QwNSidE6OF31yDY9MoBrLyqYdSpblIY1jMRwBhfnXRL4ZuQ+66/ lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3egu4mt1k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 10:19:16 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21SA9HhO018730;
        Mon, 28 Feb 2022 10:19:16 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3egu4mt1jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 10:19:15 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21SADPph027186;
        Mon, 28 Feb 2022 10:19:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3egbj12ehq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 10:19:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21SAJAYZ51184084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 10:19:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3E61A4054;
        Mon, 28 Feb 2022 10:19:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DF96A405F;
        Mon, 28 Feb 2022 10:19:10 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Feb 2022 10:19:10 +0000 (GMT)
Message-ID: <87d79308a2ffce76a805cc1e5f60d28bebc74239.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 2/3] bpf: Fix bpf_sk_lookup.remote_port on
 big-endian
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Mon, 28 Feb 2022 11:19:10 +0100
In-Reply-To: <87y21whwwl.fsf@cloudflare.com>
References: <20220222182559.2865596-1-iii@linux.ibm.com>
         <20220222182559.2865596-3-iii@linux.ibm.com>
         <20220227024457.rv5zei6qk4d6wy6d@ast-mbp.dhcp.thefacebook.com>
         <87y21whwwl.fsf@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K4cWcX5UUgg1v7sUCQshdqRVSSIYSJqx
X-Proofpoint-ORIG-GUID: NWf5H4JRDBiMkLGbSKc3yQ8bsg_i361I
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_04,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202280057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2022-02-27 at 21:30 +0100, Jakub Sitnicki wrote:
> 
> On Sat, Feb 26, 2022 at 06:44 PM -08, Alexei Starovoitov wrote:
> > On Tue, Feb 22, 2022 at 07:25:58PM +0100, Ilya Leoshkevich wrote:
> > > On big-endian, the port is available in the second __u16, not the
> > > first
> > > one. Therefore, provide a big-endian-specific definition that
> > > reflects
> > > that. Also, define remote_port_compat in order to have nicer
> > > architecture-agnostic code in the verifier and in tests.
> > > 
> > > Fixes: 9a69e2b385f4 ("bpf: Make remote_port field in struct
> > > bpf_sk_lookup 16-bit wide")
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  include/uapi/linux/bpf.h       | 17 +++++++++++++++--
> > >  net/core/filter.c              |  5 ++---
> > >  tools/include/uapi/linux/bpf.h | 17 +++++++++++++++--
> > >  3 files changed, 32 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index afe3d0d7f5f2..7b0e5efa58e0 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -10,6 +10,7 @@
> > >  
> > >  #include <linux/types.h>
> > >  #include <linux/bpf_common.h>
> > > +#include <asm/byteorder.h>
> > >  
> > >  /* Extended instruction set based on top of classic BPF */
> > >  
> > > @@ -6453,8 +6454,20 @@ struct bpf_sk_lookup {
> > >         __u32 protocol;         /* IP protocol (IPPROTO_TCP,
> > > IPPROTO_UDP) */
> > >         __u32 remote_ip4;       /* Network byte order */
> > >         __u32 remote_ip6[4];    /* Network byte order */
> > > -       __be16 remote_port;     /* Network byte order */
> > > -       __u16 :16;              /* Zero padding */
> > > +       union {
> > > +               struct {
> > > +#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN :
> > > defined(__LITTLE_ENDIAN)
> > > +                       __be16 remote_port;     /* Network byte
> > > order */
> > > +                       __u16 :16;              /* Zero padding
> > > */
> > > +#elif defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN :
> > > defined(__BIG_ENDIAN)
> > > +                       __u16 :16;              /* Zero padding
> > > */
> > > +                       __be16 remote_port;     /* Network byte
> > > order */
> > > +#else
> > > +#error unspecified endianness
> > > +#endif
> > > +               };
> > > +               __u32 remote_port_compat;
> > 
> > Sorry this hack is not an option.
> > Don't have any suggestions at this point. Pls come up with
> > something else.
> 
> I think we can keep the bpf_sk_lookup definition as is, if we leave
> the
> 4-byte load from remote_port offset quirky behavior on little-endian.
> 
> Please take a look at the test fix I've posted for 4-byte load from
> bpf_sock dst_port that works for me on x86_64 and s390. It is exactly
> the same case as we're dealing with here:
> 
> https://lore.kernel.org/bpf/20220227202757.519015-4-jakub@cloudflare.com/T/#u
> 

What about 2-byte loads?

static __noinline bool sk_dst_port__load_half(struct bpf_sock *sk)
{
	__u16 *half = (__u16 *)&sk->dst_port;
	return half[0] == bpf_htons(0xcafe);
}

requires "ca fe ?? ??" in memory on BE, while

static __noinline bool sk_dst_port__load_word(struct bpf_sock *sk)
{
#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
	const __u8 SHIFT = 16;
#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
	const __u8 SHIFT = 0;
#else
#error "Unrecognized __BYTE_ORDER__"
#endif
	__u32 *word = (__u32 *)&sk->dst_port;
	return word[0] == bpf_htonl(0xcafe << SHIFT);
}

requires "00 00 ca fe". This is inconsistent. Furthermore, one
cannot see it with bpf_sock thanks to

	case offsetofend(struct bpf_sock, dst_port) ...
	     offsetof(struct bpf_sock, dst_ip4) - 1:
		return false;

however, with sk_lookup this is the case: loading the most significant
half of the port produces non-zero! So, it's not simply a quirkiness of
the 4-byte load, it's a mutual inconsistency between LSW loads, MSW
loads and 4-byte loads.

One might argue that we can live with that, especially since all the
user-relevant tests pass - here I can only say that an inconsistency on
such a fundamental level makes me nervous.

In order to resolve this inconsistency I've implemented patch 1 of this
series. With that, "sk->dst_port == bpf_htons(0xcafe)" starts to fail,
and that's where one needs something like this patch.

Best regards,
Ilya
