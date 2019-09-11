Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9CDAFB31
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2019 13:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfIKLMI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Sep 2019 07:12:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726696AbfIKLMI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Sep 2019 07:12:08 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8BBBeKf040680
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2019 07:12:06 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uxyuar0fm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2019 07:12:06 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 11 Sep 2019 12:12:04 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Sep 2019 12:12:02 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8BBC1SQ43778116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 11:12:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEB724C050;
        Wed, 11 Sep 2019 11:12:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AB7F4C044;
        Wed, 11 Sep 2019 11:12:01 +0000 (GMT)
Received: from [9.145.11.53] (unknown [9.145.11.53])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Sep 2019 11:12:01 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH bpf-next] selftests/bpf: add bpf-gcc support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <8736h3nn6g.fsf@oracle.com>
Date:   Wed, 11 Sep 2019 12:12:00 +0100
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 7bit
References: <20190910234140.53363-1-iii@linux.ibm.com>
 <8736h3nn6g.fsf@oracle.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19091111-4275-0000-0000-000003646C7A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091111-4276-0000-0000-00003876C3B2
Message-Id: <70986114-761C-425A-B04F-B9B402023BDA@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909110102
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 11.09.2019 um 11:30 schrieb Jose E. Marchesi <jose.marchesi@oracle.com>:
> 
> 
> Hi Ilya.
> 
>    Now that binutils and gcc support for BPF is upstream, make use of it in
>    BPF selftests using alu32-like approach. Share as much as possible of
>    CFLAGS calculation with clang.
> 
>    In order to activate the new bpf-gcc support, one needs to configure
>    binutils and gcc with --target=bpf and make them available in $PATH. In
>    particular, gcc must be installed as `bpf-gcc`, which is the default.
> 
>    Right now with binutils 25a2915e8dba and gcc r275589 only a handful of
>    tests work:
> 
>    	# ./test_progs_bpf_gcc
>    	Summary: 5/39 PASSED, 1 SKIPPED, 100 FAILED
> 
>    The reason is that a lot of progs fail to build with the following
>    errors:
> 
>    	error: indirect call in function, which are not supported by eBPF
>    	error: too many function arguments for eBPF
> 
>    The next step is to understand those issues and fix them.
> 
> Will install your patch and take a look.
> 
> Maybe GCC is not inlining something it should be inlining, or clang may
> be silently generating callx %reg instructions, or maybe there are bugs
> in my diagnostics... in any case this is useful feedback :)
> 
> Thanks!

Hi Jose,

I have realised this morning that I must have missed what you said
yesterday about bpf-helpers.h -- using gcc version of this header clears
a lot of errors, but the remaning ones are more curious. I plan to
post a v2 of this patch today or tomorrow with more details on the
remaining failures.

Thanks!
Ilya

