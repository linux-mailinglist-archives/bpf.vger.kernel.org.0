Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858F01EA891
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 19:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgFARus (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 13:50:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60668 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgFARur (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 13:50:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051Hm1qP095531;
        Mon, 1 Jun 2020 17:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=wmMb8dfAMWZaQN68Y1JXBMCtXawo2UKsGE+TKeMoP/U=;
 b=l2XwW80w3sTIbc30U3KtwDQQJp5Z+N8RnT2C/i89YWhBWgqMPSPfonsvLPZH0xNDszPJ
 GVLmfmVk7h0P8RgRcIkJZ6pNc6tXOvxUFGoYq92ARDGRfQneq6iSYMRlnZOvjPj5dgqk
 WPnI2G/kuTv4CVRF5NdjNba7PvKJciAikoSEV5FggyX9lHcLbVR/lwPa+VLvuz0SSs8r
 mK0KrZz6ey+D1g3ifnu76zx4yiIBgH/wwCfLtiyS+5w7P13keUbIod0Pv4hDi3kH9+oC
 HcmZQMz+lpxVrh8hLJGucueUbirmjDEdnvxOobCeXE7xCzgGmbgzBK1W53ZB9vBv8xe2 iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31d5qr06sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 01 Jun 2020 17:50:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051HlrJl118068;
        Mon, 1 Jun 2020 17:48:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31c25kb1f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jun 2020 17:48:30 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 051HmSFx003858;
        Mon, 1 Jun 2020 17:48:28 GMT
Received: from dhcp-10-175-199-18.vpn.oracle.com (/10.175.199.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jun 2020 10:48:27 -0700
Date:   Mon, 1 Jun 2020 18:48:20 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Lorenz Bauer <lmb@cloudflare.com>
cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: Checksum behaviour of bpf_redirected packets
In-Reply-To: <CACAyw9_LPEOvHbmP8UrpwVkwYT57rKWRisai=Z7kbKxOPh5XNQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2006011839430.623@localhost>
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com> <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com> <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com> <39d3bee2-dcfc-8240-4c78-2110d639d386@iogearbox.net>
 <CACAyw996Q9SdLz0tAn2jL9wg+m5h1FBsXHmUN0ZtP7D5ohY2pg@mail.gmail.com> <a4830bd4-d998-9e5c-afd5-c5ec5504f1f3@iogearbox.net> <CACAyw99_GkLrxEj13R1ZJpnw_eWxhZas=72rtR8Pgt_Vq3dbeg@mail.gmail.com> <ff8e3902-9385-11ee-3cc5-44dd3355c9fc@iogearbox.net>
 <CACAyw9_LPEOvHbmP8UrpwVkwYT57rKWRisai=Z7kbKxOPh5XNQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=3 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 cotscore=-2147483648
 mlxscore=0 lowpriorityscore=0 suspectscore=3 spamscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006010133
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On Wed, 13 May 2020, Lorenz Bauer wrote:

> > > Option 1: always downgrade UNNECESSARY to NONE
> > > - Easiest to back port
> > > - The helper is safe by default
> > > - Performance impact unclear
> > > - No escape hatch for Cilium
> > >
> > > Option 2: add a flag to force CHECKSUM_NONE
> > > - New UAPI, can this be backported?
> > > - The helper isn't safe by default, needs documentation
> > > - Escape hatch for Cilium
> > >
> > > Option 3: downgrade to CHECKSUM_NONE, add flag to skip this
> > > - New UAPI, can this be backported?
> > > - The helper is safe by default
> > > - Escape hatch for Cilium (though you'd need to detect availability of the
> > >    flag somehow)
> >
> > This seems most reasonable to me; I can try and cook a proposal for tomorrow as
> > potential fix. Even if we add a flag, this is still backportable to stable (as
> > long as the overall patch doesn't get too complex and the backport itself stays
> > compatible uapi-wise to latest kernels. We've done that before.). I happen to
> > have two ixgbe NICs on some of my test machines which seem to be setting the
> > CHECKSUM_UNNECESSARY, so I'll run some experiments from over here as well.
> 
> Great! I'm happy to test, of course.
> 

I had a go at implementing option 3 as a few colleagues ran into this 
problem. They confirmed the fix below resolved the issue.  Daniel is
this  roughly what you had in mind? I can submit a patch for the bpf
tree if that's acceptable with the new flag. Do we need a few
tests though?

From 7e0b0c78530f3800e5c40aa1fe87e5db82c5fb59 Mon Sep 17 00:00:00 2001
From: Alan Maguire <alan.maguire@oracle.com>
Date: Mon, 1 Jun 2020 13:10:37 +0200
Subject: [PATCH bpf-next 1/2] bpf: fix bpf_skb_adjust_room decap for
 CHECKSUM_UNNECESSESARY skbs

When hardware verifies checksums for some of the headers it
will set CHECKSUM_UNNECESSESARY and csum_level indicates the
number of consecutive checksums found.  If we de-encapsulate
data however these values become invalid since we likely
just removed the checksum-validated headers.  The best option
in such cases is to revert to CHECKSUM_NONE as all checksums
will then be checked in software.  Otherwise such checks can
be skipped.

Other checksum states are handled via skb_postpull_rcsum().

Reported-by: Lorenz Bauer <lmb@cloudflare.com>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/uapi/linux/bpf.h |  7 +++++++
 net/core/filter.c        | 15 ++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 974ca6e..03ab70c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1646,6 +1646,12 @@ struct bpf_stack_build_id {
  *		* **BPF_F_ADJ_ROOM_FIXED_GSO**: Do not adjust gso_size.
  *		  Adjusting mss in this way is not allowed for datagrams.
  *
+ *		* **BPF_F_ADJ_ROOM_SKIP_CSUM_RESET**: When shrinking skbs
+ *		  marked CHECKSUM_UNNECESSARY, avoid default behavior which
+ *		  resets to CHECKSUM_NONE.  In most cases, this flag will
+ *		  not be needed as the default behavior ensures checksums
+ *		  will be verified in sofware.
+ *
  *		* **BPF_F_ADJ_ROOM_ENCAP_L3_IPV4**,
  *		  **BPF_F_ADJ_ROOM_ENCAP_L3_IPV6**:
  *		  Any new space is reserved to hold a tunnel header.
@@ -3431,6 +3437,7 @@ enum {
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
 	BPF_F_ADJ_ROOM_ENCAP_L4_GRE	= (1ULL << 3),
 	BPF_F_ADJ_ROOM_ENCAP_L4_UDP	= (1ULL << 4),
+	BPF_F_ADJ_ROOM_SKIP_CSUM_RESET	= (1ULL << 5),
 };
 
 enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index a6fc234..47c8a31 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3113,7 +3113,8 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 {
 	int ret;
 
-	if (flags & ~BPF_F_ADJ_ROOM_FIXED_GSO)
+	if (flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
+		      BPF_F_ADJ_ROOM_SKIP_CSUM_RESET))
 		return -EINVAL;
 
 	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
@@ -3143,6 +3144,18 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 		shinfo->gso_segs = 0;
 	}
 
+	/*
+	 * Decap should invalidate checksum checks done by hardware.
+	 * skb_csum_unnecessary() is not used as the other conditions
+	 * in that predicate do not need to be considered here; we only
+	 * wish to downgrade CHECKSUM_UNNECESSARY to CHECKSUM_NONE.
+	 */
+	if (unlikely(!(flags & BPF_F_ADJ_ROOM_SKIP_CSUM_RESET) &&
+		     skb->ip_summed == CHECKSUM_UNNECESSARY)) {
+		skb->ip_summed = CHECKSUM_NONE;
+		skb->csum_level = 0;
+	}
+
 	return 0;
 }
 
-- 
1.8.3.1

