Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BA826546D
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 23:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725280AbgIJV4I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 17:56:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbgIJVzw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 17:55:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08ALWPtt052985;
        Thu, 10 Sep 2020 17:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0ac3Pa0++7KbmgQl06440c9JvmnKA7DrPkmoT3AgXnY=;
 b=DR1FQXM715nk+2AqqJKVryVOk3DgJPHEcV+iIwDp7CZ+trTx9K57+DFS+PUxuKtK79hr
 puYjnqJWd2/bWZ66VkW72dRbznua0C01FZLZZIzW89zhpUiXyLfhb5hMDh20ObSNNzAU
 +TB8IO0cNWaf5HHzZzu8b+yT8afHBVI/iYvizFy3zJBNyFuzLZIiwFV113RXq80HvkGs
 IVQmc9xvATx5Y3JazE4plbLO0aFirDPnqFp4b6DqlhrJ88a7YFeSrfWfpgijC+dBKcZT
 5PyoDY8Ug11pW2bH5FIshwVj6T+Pd/ora7Jx8fjjnNk5HEsACIb3IDsK88lfSczrKvmN 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ftytte8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 17:55:37 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08ALmpjP134688;
        Thu, 10 Sep 2020 17:55:36 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ftytte7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 17:55:36 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08ALtTd2006540;
        Thu, 10 Sep 2020 21:55:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 33dxdr3p8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 21:55:34 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08ALtVwW34406756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 21:55:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E11DA4051;
        Thu, 10 Sep 2020 21:55:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAF6BA4040;
        Thu, 10 Sep 2020 21:55:30 +0000 (GMT)
Received: from sig-9-145-5-224.uk.ibm.com (unknown [9.145.5.224])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Sep 2020 21:55:30 +0000 (GMT)
Message-ID: <6453ae0b1c3ceebd6aaa6025997691610805a0f1.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 0/3] Fix three endianness issues in test_progs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 10 Sep 2020 23:55:30 +0200
In-Reply-To: <CAEf4BzYQ+81D4VgrOjTuX-1a1HgPBNq+zsX-te44Wa4=97Yqpg@mail.gmail.com>
References: <20200909232443.3099637-1-iii@linux.ibm.com>
         <CAEf4BzYQ+81D4VgrOjTuX-1a1HgPBNq+zsX-te44Wa4=97Yqpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_09:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=3 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100186
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-09-10 at 09:58 -0700, Andrii Nakryiko wrote:
> On Wed, Sep 9, 2020 at 6:59 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > This series fixes three test_progs failures on s390, all of which
> > occur
> > because of endianness issues.
> > 
> > Ilya Leoshkevich (3):
> >   selftests/bpf: Fix endianness issue in test_sockopt_sk
> >   selftests/bpf: Fix endianness issues in
> > sk_lookup/ctx_narrow_access
> >   selftests/bpf: Fix endianness issue in sk_assign
> > 
> >  .../selftests/bpf/prog_tests/sk_assign.c      |   2 +-
> >  .../selftests/bpf/prog_tests/sockopt_sk.c     |   2 +-
> >  .../selftests/bpf/progs/test_sk_lookup.c      | 264 ++++++++++--
> > ------
> >  3 files changed, 151 insertions(+), 117 deletions(-)
> > 
> > --
> > 2.25.4
> > 
> 
> Ilya,
> 
> libbpf Travis CI setup does only a build of libbpf for s390x right
> now. But we additionally have a test that builds the latest kernel
> and
> selftests and runs them in qemu. All this is implemented for x86-64
> right now. But if you'd like to spend some time to set this up for
> s390x as well, please let me know. You'll be able to detect issues
> like this much earlier.

That sounds interesting. I will try to adjust your scripts to create a
s390x rootfs, cross-compile s390x kernel and selftests, and run them
on my laptop; when this works, I will send a PR.

