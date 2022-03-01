Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF2E4C7F60
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 01:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiCAAmD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 19:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiCAAmC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 19:42:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE30DE5C
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 16:41:13 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SNgKB5008207;
        Tue, 1 Mar 2022 00:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RUbjcV1bp+2tV8LgeFpwiGpZjFZnSE9yVvA/kmPabq4=;
 b=K1jokwi5Fvq8MOZuGQ43D/MbpnlaAfPaqqgNYbx+/gsihgobuBe1mWTUrEBPV3UYEEGZ
 wrQeEX18jqTKgHsPHeAP+s/qUeZ9rbSUpBDE3Lp7fz0CTpUAPe2805D5NZ3IqitDwe/1
 qLkiRk+1ZxFdUY7BWqMkmHWMbV+7GLLc7rwBzNI4XzIj8OHJQtoIS7XXyb5DSfmtbNY/
 gemWSLNBziQTR5Ft6shnXrzeCvEUeL+u6xJ4CGplemAivrKzE+TivaAEdLaOqeR5Du+U
 YSv+2t4L1a+H5YVNW/cZ20KaXz8U7H/w8ooLLuEajsZO/q3n0nIUIJdOvyIPEioIh+Fe dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eh32c06km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 00:40:57 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2210KXED011911;
        Tue, 1 Mar 2022 00:40:56 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eh32c06k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 00:40:56 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2210biTi031900;
        Tue, 1 Mar 2022 00:40:54 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3efbfjj13f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 00:40:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2210eUSa46793056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 00:40:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCE6D5204F;
        Tue,  1 Mar 2022 00:40:30 +0000 (GMT)
Received: from [9.171.68.145] (unknown [9.171.68.145])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 57EE252052;
        Tue,  1 Mar 2022 00:40:30 +0000 (GMT)
Message-ID: <c2fc061f37d088888133d75c54cb99a104ff75d0.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 2/3] bpf: Fix bpf_sk_lookup.remote_port on
 big-endian
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 01 Mar 2022 01:40:30 +0100
In-Reply-To: <87tucjhzrz.fsf@cloudflare.com>
References: <20220222182559.2865596-1-iii@linux.ibm.com>
         <20220222182559.2865596-3-iii@linux.ibm.com>
         <20220227024457.rv5zei6qk4d6wy6d@ast-mbp.dhcp.thefacebook.com>
         <87y21whwwl.fsf@cloudflare.com>
         <87d79308a2ffce76a805cc1e5f60d28bebc74239.camel@linux.ibm.com>
         <87tucjhzrz.fsf@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zT_ulkY4cHE_sCplRj4JOh5jdSr19sNX
X-Proofpoint-ORIG-GUID: 5s10kWi5MLdDKn01c3DBiIivS4sQdBEg
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_10,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010001
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-02-28 at 14:26 +0100, Jakub Sitnicki wrote:
> On Mon, Feb 28, 2022 at 11:19 AM +01, Ilya Leoshkevich wrote:
> > In order to resolve this inconsistency I've implemented patch 1 of
> > this
> > series. With that, "sk->dst_port == bpf_htons(0xcafe)" starts to
> > fail,
> > and that's where one needs something like this patch.
> 
> Truth be told I can't reproduce the said failure.
> I've extended the test with an additional check:
> 
>    306          bool ok = sk->dst_port == bpf_htons(0xcafe);
>    307          if (!ok)
>    308                  RET_LOG();
>    309          if (!sk_dst_port__load_word(sk))
>    310                  RET_LOG();
> 
> ... but it translates to the same BPF assembly as
> sk_dst_port__load_half. That is:
> 
> ; bool ok = sk->dst_port == bpf_htons(0xcafe);
>    9: (69) r1 = *(u16 *)(r6 +12)
>   10: (bc) w1 = w1
> ; if (!ok)
>   11: (16) if w1 == 0xcafe goto pc+2
>   12: (b4) w1 = 308
>   13: (05) goto pc+14
> 
> During the test I had patch 1 from this series applied on top of [1].
> The latter series should not matter, though, I didn't touch the
> access
> converter.
> 
> Mind sharing what does the `bpftool prog objdump` output look like
> for
> the failing test on your side?
> 
> [1]
> https://lore.kernel.org/bpf/20220227202757.519015-1-jakub@cloudflare.com/
> 

Sure.

As I mentioned, it's best demonstrated with sk_lookup, so that's what
I'll be using. Apply this on top of bpf-next:

--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -392,7 +392,7 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
 	int err, family;
-	__u32 val_u32;
+	__u32 *ptr_u32;
 	bool v4;
 
 	v4 = (ctx->family == AF_INET);
@@ -411,17 +411,12 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 	if (LSW(ctx->protocol, 0) != IPPROTO_TCP)
 		return SK_DROP;
 
-	/* Narrow loads from remote_port field. Expect SRC_PORT. */
-	if (LSB(ctx->remote_port, 0) != ((SRC_PORT >> 0) & 0xff) ||
-	    LSB(ctx->remote_port, 1) != ((SRC_PORT >> 8) & 0xff) ||
-	    LSB(ctx->remote_port, 2) != 0 || LSB(ctx->remote_port, 3)
!= 0)
+	ptr_u32 = (__u32 *)&ctx->remote_port;
+	if (LSW(*ptr_u32, 0) != SRC_PORT)
 		return SK_DROP;
-	if (LSW(ctx->remote_port, 0) != SRC_PORT)
+	if (LSW(*ptr_u32, 1) != 0)
 		return SK_DROP;
-
-	/* Load from remote_port field with zero padding (backward
compatibility) */
-	val_u32 = *(__u32 *)&ctx->remote_port;
-	if (val_u32 != bpf_htonl(bpf_ntohs(SRC_PORT) << 16))
+	if (*ptr_u32 != SRC_PORT)
 		return SK_DROP;
 
 	/* Narrow loads from local_port field. Expect DST_PORT. */

The checks look as follows:

$ llvm-objdump -d -l tools/testing/selftests/bpf/test_sk_lookup.o

; if (LSW(*ptr_u32, 0) != SRC_PORT)
     370:	69 26 00 26 00 00 00 00	r2 = *(u16 *)(r6 + 38)
     371:	56 20 01 00 00 00 1f 48	if w2 != 8008 goto
+256 <LBB15_135>

; if (LSW(*ptr_u32, 1) != 0)
     372:	69 26 00 24 00 00 00 00	r2 = *(u16 *)(r6 + 36)
     373:	56 20 00 fe 00 00 00 00	if w2 != 0 goto +254
<LBB15_135>

; if (*ptr_u32 != SRC_PORT)
     374:	61 26 00 24 00 00 00 00	r2 = *(u32 *)(r6 + 36)
     375:	56 20 00 fc 00 00 1f 48	if w2 != 8008 goto
+252 <LBB15_135>

After loading:

# tools/testing/selftests/bpf/tools/sbin/bpftool prog dump xlated id
141

; if (LSW(*ptr_u32, 0) != SRC_PORT)
  49: (69) r2 = *(u16 *)(r6 +4)
  50: (bc) w2 = w2
  51: (56) if w2 != 0x1f48 goto pc+938

; if (LSW(*ptr_u32, 1) != 0)
  52: (69) r2 = *(u16 *)(r6 +4)
  53: (bc) w2 = w2
  54: (56) if w2 != 0x0 goto pc+935

; if (*ptr_u32 != SRC_PORT)
  55: (69) r2 = *(u16 *)(r6 +4)
  56: (bc) w2 = w2
  57: (56) if w2 != 0x1f48 goto pc+932

Note that both LSW(0) and LSW(1) loads result in the same code after
rewriting. This is because the offset is ignored for this particular
combination of sizes.

Best regards,
Ilya
