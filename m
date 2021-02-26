Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412383266F3
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 19:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhBZSd0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 13:33:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230345AbhBZSdV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 13:33:21 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QI3SZB151198;
        Fri, 26 Feb 2021 13:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fIHusBedclNkUmUDSkXJsYb6diT9a6fFXbf17Oh3bus=;
 b=dAiRd38PooyYJGYHfxMgV60OZoA0jSilV/2ySLYZVhlZf3ymkYxgI6LGXSWFNglflg47
 gVQQyMI2iwwWukcqCgalncYYjpBAWuycJ5D1IT99XKhUykPIfJFhuEXjN/3cFB4nx4Ih
 2c3/YlJjEt3JnlAyZwlYNEQ0WR5hOQncQsZ2NhmCeFgkzEA61OsIi/8HrQ6wFJzWmEPN
 9JPttENH/gd9O+sboNUq3V0WwdaAS3N4MjgVPRP5WJRzpqof6ager02KZG/FNuzuPex0
 jNeNAqkXD+ylKFdxttV/9wojAfHdg5t4lH2w75ASThAYSKxDwy30u2mG+NwFZTWhXhcH ug== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y3x7w2dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 13:32:27 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QISRvL016898;
        Fri, 26 Feb 2021 18:32:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt285jdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 18:32:25 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QIWMlr44958194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 18:32:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A02AAE053;
        Fri, 26 Feb 2021 18:32:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FD05AE051;
        Fri, 26 Feb 2021 18:32:22 +0000 (GMT)
Received: from osiris (unknown [9.171.89.133])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 26 Feb 2021 18:32:22 +0000 (GMT)
Date:   Fri, 26 Feb 2021 19:32:20 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Use _REGION1_SIZE in
 test_snprintf_btf on s390
Message-ID: <YDk+tETRHaqftABG@osiris>
References: <20210226182014.115347-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226182014.115347-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_07:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260134
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 26, 2021 at 07:20:14PM +0100, Ilya Leoshkevich wrote:
> test_snprintf_btf fails on s390, because NULL points to a readable
> struct lowcore there. Fix by using _REGION1_SIZE instead.
> 
> Error message example:
> 
>     printing 0000000000000000 should generate error, got (361)
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> 
> v1: https://lore.kernel.org/bpf/20210226135923.114211-1-iii@linux.ibm.com/
> v1 -> v2: Yonghong suggested to add the pointer value to the error
>           message.
>           I've noticed that I've been passing BADPTR as flags, therefore
>           the fix worked only by accident. Put it into p.ptr where it
>           belongs.
> 
>  .../testing/selftests/bpf/progs/netif_receive_skb.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> index 6b670039ea67..4d158de73c2d 100644
> --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> @@ -16,6 +16,13 @@ bool skip = false;
>  #define STRSIZE			2048
>  #define EXPECTED_STRSIZE	256
> 
> +#if defined(bpf_target_s390)
> +/* NULL points to a readable struct lowcore on s390, so take _REGION1_SIZE */
> +#define BADPTR			((void *)(1ULL << 53))
> +#else
> +#define BADPTR			0
> +#endif
> +
>  #ifndef ARRAY_SIZE
>  #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
>  #endif
> @@ -113,11 +120,11 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
>  	}
> 
>  	/* Check invalid ptr value */
> -	p.ptr = 0;
> +	p.ptr = BADPTR;
>  	__ret = bpf_snprintf_btf(str, STRSIZE, &p, sizeof(p), 0);
>  	if (__ret >= 0) {
> -		bpf_printk("printing NULL should generate error, got (%d)",
> -			   __ret);
> +		bpf_printk("printing %p should generate error, got (%d)",
> +			   BADPTR, __ret);
>  		ret = -ERANGE;

This will work for now on s390, since _right now_ we don't map
anything that high, but there is no guarantee that it will stay
this way.
I'd rather skip this test for s390.
