Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB2327185
	for <lists+bpf@lfdr.de>; Sun, 28 Feb 2021 09:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhB1IHr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Feb 2021 03:07:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230406AbhB1IHp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Feb 2021 03:07:45 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11S84Mrc180272;
        Sun, 28 Feb 2021 03:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=GyrBO1FYFDiX5oS4mzwwKN19FXAb8n6KMyiIirk/kL8=;
 b=CbmzSYCD0SibgEP13yDP6DzLAe3XuFp1EWJIgXY/qs7G3sLthARXSMietVIOAHy5cDNC
 jQQh1o//75SLn3JaM8oZjq+8rbSlCWP+sXPEHA39IcKqIbUnJ2YLI0fZfNRU4YEPMyAk
 rFeoBmcIOXM7HPHp1KVEQwxbtaZIji+qooHREbBZLeVErz7GPkHH/S+uCynJHphrGzcg
 4R3WRkJqBW8PUOFKZXcNm/4PoGSaqnCC+1fSK4kfJcym6rrDu2c6bRp4gUGE3hjkKtOs
 jNwTQfLXtRvk82icfz8q7XEcUWvF356sy19MhMPx71OTlMBzwTlCCUseNs0YpkxYWxiJ Sw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 370410km9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Feb 2021 03:06:36 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11S7xG9w019816;
        Sun, 28 Feb 2021 08:06:34 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 36ydq8gtth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Feb 2021 08:06:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11S86Voa47513880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Feb 2021 08:06:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3B5B52051;
        Sun, 28 Feb 2021 08:06:30 +0000 (GMT)
Received: from osiris (unknown [9.171.48.61])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 97B2F5204E;
        Sun, 28 Feb 2021 08:06:30 +0000 (GMT)
Date:   Sun, 28 Feb 2021 09:06:29 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 bpf-next] selftests/bpf: Use the last page in
 test_snprintf_btf on s390
Message-ID: <YDtPBT3+pGwNSIHs@osiris>
References: <20210227051726.121256-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210227051726.121256-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-28_03:2021-02-26,2021-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=947 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102280066
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 27, 2021 at 06:17:26AM +0100, Ilya Leoshkevich wrote:
> test_snprintf_btf fails on s390, because NULL points to a readable
> struct lowcore there. Fix by using the last page instead.
> 
> Error message example:
> 
>     printing fffffffffffff000 should generate error, got (361)
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> 
> 
> v1: https://lore.kernel.org/bpf/20210226135923.114211-1-iii@linux.ibm.com/
> v1 -> v2: Yonghong suggested to add the pointer value to the error
>           message.
>           I've noticed that I've been passing BADPTR as flags, therefore
>           the fix worked only by accident. Put it into p.ptr where it
>           belongs.
> 
> v2: https://lore.kernel.org/bpf/20210226182014.115347-1-iii@linux.ibm.com/
> v2 -> v3: Heiko mentioned that using _REGION1_SIZE is not future-proof.
>           We had a private discussion and came to the conclusion that
>           the the last page is good enough.
> 
> v3: https://lore.kernel.org/bpf/20210226190908.115706-1-iii@linux.ibm.com/
> v3 -> v4: Yonghong suggested to print the non-hashed pointer value.
> 
>  .../testing/selftests/bpf/progs/netif_receive_skb.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Just in case, also for v4:

Acked-by: Heiko Carstens <hca@linux.ibm.com>
