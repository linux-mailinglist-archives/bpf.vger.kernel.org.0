Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82863AFA82
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2019 12:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfIKKft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Sep 2019 06:35:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58970 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfIKKft (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Sep 2019 06:35:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BAYdd2165109;
        Wed, 11 Sep 2019 10:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2019-08-05;
 bh=Uqvw86eZACPCWwhEi9VGEZayZR4nrtYb+0ee6A1ZSTw=;
 b=Cmr33c5Ql5q9XdfwxGxPMpSqTpE4QlXWOVSo39rFehktlquZPCGZvpbUDLztXB1Kt7T7
 w6RgPWEnf6n4YA6HqKHG1u+67SZuO2Bz0K1ni/criq4HdYEzOUwJiw4lGUhnpyYx8sUb
 YM1f2Z7b+BgA8EbTk3zGiNzfQ6/snVdQKL6NfF7frKKIT2uZSLHy3aq8pl3FJrJp9IWw
 bTBtPeq/9+EQLaoHsFfMvVozubsqAgTu/7z7jHrglue2OpALA88lBYURtLqFLJw9scA9
 oUnmUPBorBl1R0Plw4admkpG9yFaGkt50gHpdYQj1Hi3fZ3+puO1RAsBcrepNpu5z5nn 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uw1jkh06a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 10:35:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BAY61Q069382;
        Wed, 11 Sep 2019 10:35:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2uxj88n09t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 10:35:22 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8BAZLru009387;
        Wed, 11 Sep 2019 10:35:21 GMT
Received: from termi.oracle.com (/93.108.232.149)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 03:35:20 -0700
From:   jose.marchesi@oracle.com (Jose E. Marchesi)
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add bpf-gcc support
Message-ID: <8736h3nn6g.fsf@oracle.com>
References: <20190910234140.53363-1-iii@linux.ibm.com>
Date:   Wed, 11 Sep 2019 12:30:44 +0200
In-Reply-To: <20190910234140.53363-1-iii@linux.ibm.com> (Ilya Leoshkevich's
        message of "Wed, 11 Sep 2019 00:41:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110096
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi Ilya.

    Now that binutils and gcc support for BPF is upstream, make use of it in
    BPF selftests using alu32-like approach. Share as much as possible of
    CFLAGS calculation with clang.

    In order to activate the new bpf-gcc support, one needs to configure
    binutils and gcc with --target=bpf and make them available in $PATH. In
    particular, gcc must be installed as `bpf-gcc`, which is the default.
    
    Right now with binutils 25a2915e8dba and gcc r275589 only a handful of
    tests work:
    
    	# ./test_progs_bpf_gcc
    	Summary: 5/39 PASSED, 1 SKIPPED, 100 FAILED
    
    The reason is that a lot of progs fail to build with the following
    errors:
    
    	error: indirect call in function, which are not supported by eBPF
    	error: too many function arguments for eBPF
    
    The next step is to understand those issues and fix them.

Will install your patch and take a look.

Maybe GCC is not inlining something it should be inlining, or clang may
be silently generating callx %reg instructions, or maybe there are bugs
in my diagnostics... in any case this is useful feedback :)

Thanks!
