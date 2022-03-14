Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54C4D8BC5
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 19:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiCNS1S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 14:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiCNS1R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 14:27:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506673B563
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 11:26:03 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EHUDax003415;
        Mon, 14 Mar 2022 18:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Q8h2WMaXtsDZkb5hAKlgwA7eh+W0Wdmjw6u+p9QL6DQ=;
 b=gtBhl5xvSxSDP5v9PzNKn4n390G/BJKU0G/db/Zfe53wwRIRTDQFXOFP6JdpuvsC7Ly6
 OpOReH1ZEge9TVATB12k3y/d5revXJESFHW1LKRPVV0brPQhKoN/xl5ShQQzkB7Q4Buz
 dmkJ55lsw8mwADWy7kjY51D75z6C9h/mmWggBZUcTT0ctVjhZ9WqyOJm6Z9HvX98hMuH
 htarq2VKOjAwYSGiR/wyuPkqIH6XP40BNXuM1A7D5qr0yhtoglCp76DN/0Y4fr/DsAmt
 OIuClAmzt3YQcqFWRGJ4P5RGTSrxbKEnUj3/9yjgDCI8SaX0brK1DydC8OKov5LbonJO Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3et6d7q5ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 18:25:48 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EICh1l026543;
        Mon, 14 Mar 2022 18:25:47 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3et6d7q5ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 18:25:47 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EID9aK017681;
        Mon, 14 Mar 2022 18:25:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3erjshmupm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 18:25:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22EIPgrP45809946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 18:25:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1627D11C4A2;
        Mon, 14 Mar 2022 18:25:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2415111C454;
        Mon, 14 Mar 2022 18:25:27 +0000 (GMT)
Received: from [9.171.29.97] (unknown [9.171.29.97])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Mar 2022 18:25:27 +0000 (GMT)
Message-ID: <f46bff60be49ab2062770d39a20d1874b10c70ae.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: Fix certain narrow loads with
 offsets
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Mon, 14 Mar 2022 19:25:26 +0100
In-Reply-To: <87o828xwf3.fsf@cloudflare.com>
References: <20220222182559.2865596-1-iii@linux.ibm.com>
         <20220222182559.2865596-2-iii@linux.ibm.com>
         <87bkygzbg5.fsf@cloudflare.com>
         <8d8b464f6c2820989d67f00d24b6003b8b758274.camel@linux.ibm.com>
         <871qzbz5sa.fsf@cloudflare.com>
         <a924d763fe50ec80594ca3fac6b311cf9ec20fca.camel@linux.ibm.com>
         <87wnh1xvaj.fsf@cloudflare.com> <87o828xwf3.fsf@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DGzYNjhlHv2XIyTSWK2f8kLXdWMHrGN1
X-Proofpoint-ORIG-GUID: zNGtH92ThpgH1s7BHR2OnUPJsxSIxwZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_13,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203140109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-03-14 at 18:35 +0100, Jakub Sitnicki wrote:
> On Thu, Mar 10, 2022 at 11:57 PM +01, Jakub Sitnicki wrote:
> > On Wed, Mar 09, 2022 at 01:34 PM +01, Ilya Leoshkevich wrote:
> > > On Wed, 2022-03-09 at 09:36 +0100, Jakub Sitnicki wrote:
> > 
> > [...]
> > 
> > > > 
> > > > Consider this - today the below is true on both LE and BE,
> > > > right?
> > > > 
> > > >   *(u32 *)&ctx->remote_port == *(u16 *)&ctx->remote_port
> > > > 
> > > > because the loads get converted to:
> > > > 
> > > >   *(u16 *)&ctx_kern->sport == *(u16 *)&ctx_kern->sport
> > > > 
> > > > IOW, today, because of the bug that you are fixing here, the
> > > > data
> > > > layout
> > > > changes from the PoV of the BPF program depending on the load
> > > > size.
> > > > 
> > > > With 2-byte loads, without this patch, the data layout appears
> > > > as:
> > > > 
> > > >   struct bpf_sk_lookup {
> > > >     ...
> > > >     __be16 remote_port;
> > > >     __be16 remote_port;
> > > >     ...
> > > >   }
> > > 
> > > I see, one can indeed argue that this is also a part of the ABI
> > > now.
> > > So we're stuck between a rock and a hard place.
> > > 
> > > > While for 4-byte loads, it appears as in your 2nd patch:
> > > > 
> > > >   struct bpf_sk_lookup {
> > > >     ...
> > > >     #if little-endian
> > > >     __be16 remote_port;
> > > >     __u16  :16; /* zero padding */
> > > >     #elif big-endian
> > > >     __u16  :16; /* zero padding */
> > > >     __be16 remote_port;
> > > >     #endif
> > > >     ...
> > > >   }
> > > > 
> > > > Because of that I don't see how we could keep complete ABI
> > > > compatiblity,
> > > > and have just one definition of struct bpf_sk_lookup that
> > > > reflects
> > > > it. These are conflicting requirements.
> > > > 
> > > > I'd bite the bullet for 4-byte loads, for the sake of having an
> > > > endian-agnostic struct bpf_sk_lookup and struct bpf_sock
> > > > definition
> > > > in
> > > > the uAPI header.
> > > > 
> > > > The sacrifice here is that the access converter will have to
> > > > keep
> > > > rewriting 4-byte access to bpf_sk_lookup.remote_port and
> > > > bpf_sock.dst_port in this unexpected, quirky manner.
> > > > 
> > > > The expectation is that with time users will recompile their
> > > > BPF
> > > > progs
> > > > against the updated bpf.h, and switch to 2-byte loads. That
> > > > will make
> > > > the quirk in the access converter dead code in time.
> > > > 
> > > > I don't have any better ideas. Sorry.
> > > > 
> > > > [...]
> > > 
> > > I agree, let's go ahead with this solution.
> > > 
> > > The only remaining problem that I see is: the bug is in the
> > > common
> > > code, and it will affect the fields that we add in the future.
> > > 
> > > Can we either document this state of things in a comment, or fix
> > > the
> > > bug and emulate the old behavior for certain fields?
> > 
> > I think we can fix the bug in the common code, and compensate for
> > the
> > quirky 4-byte access to bpf_sk_lookup.remote_port and
> > bpf_sock.dst_port
> > in the is_valid_access and convert_ctx_access.
> > 
> > With the patch as below, access to remote_port gets rewritten to:
> > 
> > * size=1, offset=0, r2 = *(u8 *)(r1 +36)
> >    0: (69) r2 = *(u16 *)(r1 +4)
> >    1: (54) w2 &= 255
> >    2: (b7) r0 = 0
> >    3: (95) exit
> > 
> > * size=1, offset=1, r2 = *(u8 *)(r1 +37)
> >    0: (69) r2 = *(u16 *)(r1 +4)
> >    1: (74) w2 >>= 8
> >    2: (54) w2 &= 255
> >    3: (b7) r0 = 0
> >    4: (95) exit
> > 
> > * size=1, offset=2, r2 = *(u8 *)(r1 +38)
> >    0: (b4) w2 = 0
> >    1: (54) w2 &= 255
> >    2: (b7) r0 = 0
> >    3: (95) exit
> > 
> > * size=1, offset=3, r2 = *(u8 *)(r1 +39)
> >    0: (b4) w2 = 0
> >    1: (74) w2 >>= 8
> >    2: (54) w2 &= 255
> >    3: (b7) r0 = 0
> >    4: (95) exit
> > 
> > * size=2, offset=0, r2 = *(u16 *)(r1 +36)
> >    0: (69) r2 = *(u16 *)(r1 +4)
> >    1: (b7) r0 = 0
> >    2: (95) exit
> > 
> > * size=2, offset=2, r2 = *(u16 *)(r1 +38)
> >    0: (b4) w2 = 0
> >    1: (b7) r0 = 0
> >    2: (95) exit
> > 
> > * size=4, offset=0, r2 = *(u32 *)(r1 +36)
> >    0: (69) r2 = *(u16 *)(r1 +4)
> >    1: (b7) r0 = 0
> >    2: (95) exit
> > 
> > How does that look to you?
> > 
> > Still need to give it a test on s390x.
> 
> Context conversion with patch below applied looks correct to me on
> s390x
> as well:
> 
> * size=1, offset=0, r2 = *(u8 *)(r1 +36)
>    0: (69) r2 = *(u16 *)(r1 +4)
>    1: (bc) w2 = w2
>    2: (74) w2 >>= 8
>    3: (bc) w2 = w2
>    4: (54) w2 &= 255
>    5: (bc) w2 = w2
>    6: (b7) r0 = 0
>    7: (95) exit
> 
> * size=1, offset=1, r2 = *(u8 *)(r1 +37)
>    0: (69) r2 = *(u16 *)(r1 +4)
>    1: (bc) w2 = w2
>    2: (54) w2 &= 255
>    3: (bc) w2 = w2
>    4: (b7) r0 = 0
>    5: (95) exit
> 
> * size=1, offset=2, r2 = *(u8 *)(r1 +38)
>    0: (b4) w2 = 0
>    1: (bc) w2 = w2
>    2: (74) w2 >>= 8
>    3: (bc) w2 = w2
>    4: (54) w2 &= 255
>    5: (bc) w2 = w2
>    6: (b7) r0 = 0
>    7: (95) exit
> 
> * size=1, offset=3, r2 = *(u8 *)(r1 +39)
>    0: (b4) w2 = 0
>    1: (bc) w2 = w2
>    2: (54) w2 &= 255
>    3: (bc) w2 = w2
>    4: (b7) r0 = 0
>    5: (95) exit
> 
> * size=2, offset=0, r2 = *(u16 *)(r1 +36)
>    0: (69) r2 = *(u16 *)(r1 +4)
>    1: (bc) w2 = w2
>    2: (b7) r0 = 0
>    3: (95) exit
> 
> * size=2, offset=2, r2 = *(u16 *)(r1 +38)
>    0: (b4) w2 = 0
>    1: (bc) w2 = w2
>    2: (b7) r0 = 0
>    3: (95) exit
> 
> * size=4, offset=0, r2 = *(u32 *)(r1 +36)
>    0: (69) r2 = *(u16 *)(r1 +4)
>    1: (bc) w2 = w2
>    2: (b7) r0 = 0
>    3: (95) exit
> 
> If we go this way, this should unbreak the bpf selftests on BE,
> independently of the patch 1 from this series.
> 
> Will send it as a patch, so that we continue the review discussion.

I applied this patch to bpf-next, and while it looks reasonable, the
test still fails, e.g. here:

	/* Load from remote_port field with zero padding (backward
compatibility) */
	val_u32 = *(__u32 *)&ctx->remote_port;
	if (val_u32 != bpf_htonl(bpf_ntohs(SRC_PORT) << 16))
		return SK_DROP;

> 
> > 
> > --8<--
> > 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 65869fd510e8..2625a1d2dabc 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -10856,13 +10856,24 @@ static bool sk_lookup_is_valid_access(int
> > off, int size,
> >         case bpf_ctx_range(struct bpf_sk_lookup, local_ip4):
> >         case bpf_ctx_range_till(struct bpf_sk_lookup,
> > remote_ip6[0], remote_ip6[3]):
> >         case bpf_ctx_range_till(struct bpf_sk_lookup, local_ip6[0],
> > local_ip6[3]):
> > -       case offsetof(struct bpf_sk_lookup, remote_port) ...
> > -            offsetof(struct bpf_sk_lookup, local_ip4) - 1:
> >         case bpf_ctx_range(struct bpf_sk_lookup, local_port):
> >         case bpf_ctx_range(struct bpf_sk_lookup, ingress_ifindex):
> >                 bpf_ctx_record_field_size(info, sizeof(__u32));
> >                 return bpf_ctx_narrow_access_ok(off, size,
> > sizeof(__u32));
> >  
> > +       case bpf_ctx_range(struct bpf_sk_lookup, remote_port):
> > +               /* Allow 4-byte access to 2-byte field for backward
> > compatibility */
> > +               if (size == sizeof(__u32))
> > +                       return off == offsetof(struct
> > bpf_sk_lookup, remote_port);
> > +               bpf_ctx_record_field_size(info, sizeof(__be16));
> > +               return bpf_ctx_narrow_access_ok(off, size,
> > sizeof(__be16));
> > +
> > +       case offsetofend(struct bpf_sk_lookup, remote_port) ...
> > +            offsetof(struct bpf_sk_lookup, local_ip4) - 1:
> > +               /* Allow access to zero padding for backward
> > compatiblity */
> > +               bpf_ctx_record_field_size(info, sizeof(__u16));
> > +               return bpf_ctx_narrow_access_ok(off, size,
> > sizeof(__u16));
> > +
> >         default:
> >                 return false;
> >         }
> > @@ -10944,6 +10955,11 @@ static u32
> > sk_lookup_convert_ctx_access(enum bpf_access_type type,
> >                                                      sport, 2,
> > target_size));
> >                 break;
> >  
> > +       case offsetofend(struct bpf_sk_lookup, remote_port):
> > +               *target_size = 2;
> > +               *insn++ = BPF_MOV32_IMM(si->dst_reg, 0);
> > +               break;
> > +
> >         case offsetof(struct bpf_sk_lookup, local_port):
> >                 *insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si-
> > >src_reg,
> >                                       bpf_target_off(struct
> > bpf_sk_lookup_kern,
> 

