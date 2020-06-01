Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346F21EB0ED
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 23:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgFAVZr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 17:25:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51436 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgFAVZq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 17:25:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051LMQtm062677;
        Mon, 1 Jun 2020 21:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=aW/4iU44t63GXZS7lAjRY3neUhFtpwCFtyEQqF5JqFY=;
 b=xcp3Y73AIZcKVnH5ZpTAe37hYs1WfU2aVwAzexUNndv1stl248RCMqv3EApv0c2RwJRc
 K2HllDbJfyV1dWahnDMi+ziEmo34Zm1/703ZrMr5E176VTP/QZmWMdh2NvFY7mVEY6I3
 4q5vcFMrpegg5VxbwB6+TMFxHUXW59v863Zxv8F3QoQMlRkVa0UlQfWMtUDS12DF0/sK
 fnu2Dtj0iQ1MGE+bicaxjCDTCIe/QXJZTMILGODDRGqPJ+uy7TxJPEnXpmdEjx0v5/Yw
 Ad8cPApXglqx8dZOs8FmIy7UQ98KaKPelT6/RmbFQgBqkxunQFO+mz5gKNA4ILC0G3Ou bA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31bfem0ubt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 01 Jun 2020 21:25:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051LNrrC154553;
        Mon, 1 Jun 2020 21:25:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31c25kt2kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jun 2020 21:25:32 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 051LPUU2011564;
        Mon, 1 Jun 2020 21:25:30 GMT
Received: from dhcp-10-175-199-18.vpn.oracle.com (/10.175.199.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jun 2020 14:25:30 -0700
Date:   Mon, 1 Jun 2020 22:25:23 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Daniel Borkmann <daniel@iogearbox.net>
cc:     Alan Maguire <alan.maguire@oracle.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: Checksum behaviour of bpf_redirected packets
In-Reply-To: <835af597-c346-e178-09c4-9f67c9480020@iogearbox.net>
Message-ID: <alpine.LRH.2.21.2006012217530.15886@localhost>
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com> <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com> <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com> <39d3bee2-dcfc-8240-4c78-2110d639d386@iogearbox.net>
 <CACAyw996Q9SdLz0tAn2jL9wg+m5h1FBsXHmUN0ZtP7D5ohY2pg@mail.gmail.com> <a4830bd4-d998-9e5c-afd5-c5ec5504f1f3@iogearbox.net> <CACAyw99_GkLrxEj13R1ZJpnw_eWxhZas=72rtR8Pgt_Vq3dbeg@mail.gmail.com> <ff8e3902-9385-11ee-3cc5-44dd3355c9fc@iogearbox.net>
 <CACAyw9_LPEOvHbmP8UrpwVkwYT57rKWRisai=Z7kbKxOPh5XNQ@mail.gmail.com> <alpine.LRH.2.21.2006011839430.623@localhost> <835af597-c346-e178-09c4-9f67c9480020@iogearbox.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006010156
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 1 Jun 2020, Daniel Borkmann wrote:

> On 6/1/20 7:48 PM, Alan Maguire wrote:
> > On Wed, 13 May 2020, Lorenz Bauer wrote:
> > 
> >>>> Option 1: always downgrade UNNECESSARY to NONE
> >>>> - Easiest to back port
> >>>> - The helper is safe by default
> >>>> - Performance impact unclear
> >>>> - No escape hatch for Cilium
> >>>>
> >>>> Option 2: add a flag to force CHECKSUM_NONE
> >>>> - New UAPI, can this be backported?
> >>>> - The helper isn't safe by default, needs documentation
> >>>> - Escape hatch for Cilium
> >>>>
> >>>> Option 3: downgrade to CHECKSUM_NONE, add flag to skip this
> >>>> - New UAPI, can this be backported?
> >>>> - The helper is safe by default
> >>>> - Escape hatch for Cilium (though you'd need to detect availability of
> >>>> the
> >>>>     flag somehow)
> >>>
> >>> This seems most reasonable to me; I can try and cook a proposal for
> >>> tomorrow as
> >>> potential fix. Even if we add a flag, this is still backportable to stable
> >>> (as
> >>> long as the overall patch doesn't get too complex and the backport itself
> >>> stays
> >>> compatible uapi-wise to latest kernels. We've done that before.). I happen
> >>> to
> >>> have two ixgbe NICs on some of my test machines which seem to be setting
> >>> the
> >>> CHECKSUM_UNNECESSARY, so I'll run some experiments from over here as well.
> >>
> >> Great! I'm happy to test, of course.
> > 
> > I had a go at implementing option 3 as a few colleagues ran into this
> > problem. They confirmed the fix below resolved the issue.  Daniel is
> > this  roughly what you had in mind? I can submit a patch for the bpf
> > tree if that's acceptable with the new flag. Do we need a few
> > tests though?
> 
> Coded this [0] up last week which Lorenz gave a spin as well. Originally
> wanted to
> get it out Friday night, but due to internal release stuff it got too late Fri
> night
> and didn't want to rush it at 3am anymore, so the series as fixes is going out
> tomorrow
> morning [today was public holiday in CH over here].
>

Looks great! Although I've only seen this issue arise
for cases where csum_level == 0, should we also
add "skb->csum_level = 0;" when we reset the
ip_summed value?

Feel free to add a

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

...for the series if needed. Thanks again!

Alan

> Thanks,
> Daniel
> 
>   [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git/log/?h=pr/adjust-csum
> 
> 
