Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058A4231552
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 00:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgG1WF2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 18:05:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729427AbgG1WF1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Jul 2020 18:05:27 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06SM1q26052276;
        Tue, 28 Jul 2020 18:05:15 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jqs9826s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 18:05:15 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SM1aBB016349;
        Tue, 28 Jul 2020 22:05:13 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 32gcy4m92s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 22:05:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06SM3i1W62128462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 22:03:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF537AE053;
        Tue, 28 Jul 2020 22:05:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 825CFAE059;
        Tue, 28 Jul 2020 22:05:09 +0000 (GMT)
Received: from sig-9-145-173-62.de.ibm.com (unknown [9.145.173.62])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jul 2020 22:05:09 +0000 (GMT)
Message-ID: <f2d9a1c5d8587344d7310746a99ee3a4d3132517.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/3] samples/bpf: Fix test_map_in_map on s390
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Wed, 29 Jul 2020 00:05:09 +0200
In-Reply-To: <CAPhsuW6PaAe4Kb+q7fOnhcm13bh9Mr0i34ar5gAJOm5+BiGkEg@mail.gmail.com>
References: <20200728120059.132256-1-iii@linux.ibm.com>
         <20200728120059.132256-3-iii@linux.ibm.com>
         <CAPhsuW6PaAe4Kb+q7fOnhcm13bh9Mr0i34ar5gAJOm5+BiGkEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_17:2020-07-28,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=3 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280151
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2020-07-28 at 13:59 -0700, Song Liu wrote:
> On Tue, Jul 28, 2020 at 5:14 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > s390 uses socketcall multiplexer instead of individual socket
> > syscalls.
> > Therefore, "kprobe/" SYSCALL(sys_connect) does not trigger and
> > test_map_in_map fails. Fix by using "kprobe/__sys_connect" instead.
> 
> samples/bpf is in semi-deprecated state. I tried for quite some time,
> but still
> cannot build it all successfully. So I apologize for bounding the
> question to you...
> 
> From the code, we do the SYSCALL() trick to change the exact name for
> different architecture. Would this change break the same file for
> x86?

No, it shouldn't - __sys_connect exists on all architectures and gets
control from both regular socket syscalls and socketcall multiplexer.
I tested it on x86 and it worked for me.
It's also already used by
tools/testing/selftests/bpf/progs/test_probe_user.c

Best regards,
Ilya

