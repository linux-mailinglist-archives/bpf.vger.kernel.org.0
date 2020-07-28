Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764612314FC
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 23:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgG1Vhk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 17:37:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729958AbgG1Vhk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Jul 2020 17:37:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06SL1qTr007086;
        Tue, 28 Jul 2020 17:37:27 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32jpw3hj62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 17:37:27 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SLZLW6021816;
        Tue, 28 Jul 2020 21:37:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 32gcy4m89b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 21:37:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06SLbNAo28901656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 21:37:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15AED42045;
        Tue, 28 Jul 2020 21:37:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 990954203F;
        Tue, 28 Jul 2020 21:37:22 +0000 (GMT)
Received: from sig-9-145-173-62.de.ibm.com (unknown [9.145.173.62])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jul 2020 21:37:22 +0000 (GMT)
Message-ID: <6386aaf1ecbab2384bc64e5db5e64b1b4c11190e.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/3] samples/bpf: Fix building out of srctree
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 28 Jul 2020 23:37:22 +0200
In-Reply-To: <561d45c27df34a412aed676293078bcac5c1d91a.camel@linux.ibm.com>
References: <20200728120059.132256-1-iii@linux.ibm.com>
         <20200728120059.132256-2-iii@linux.ibm.com>
         <CAPhsuW4OkZ0CPk0=Foem-BnUP3FGSL-ffuO-+euW1gNWhupghA@mail.gmail.com>
         <561d45c27df34a412aed676293078bcac5c1d91a.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_16:2020-07-28,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=3 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280146
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2020-07-28 at 23:12 +0200, Ilya Leoshkevich wrote:
> On Tue, 2020-07-28 at 13:48 -0700, Song Liu wrote:
> > On Tue, Jul 28, 2020 at 5:15 AM Ilya Leoshkevich <iii@linux.ibm.com
> > >
> > wrote:
> > > Building BPF samples out of srctree fails, because the output
> > > directory
> > > for progs shared with selftests (CGROUP_HELPERS, TRACE_HELPERS)
> > > is
> > > missing and the compiler cannot create output files.
> > > 
> > > Fix by creating the output directory in Makefile.
> > 
> > What is the make command line we use here? I am trying:
> > 
> >    make M=samples/bpf O=./xxx
> > 
> > w/o this patch, make created ./xxx/samples/bpf.
> > 
> > Did I miss something?
> 
> I'm using
> 
> make O=$HOME/linux-build 'CC=ccache gcc' M=samples/bpf -j12
> 
> My make version is GNU Make 4.2.1.

Hmm, I wanted to elaborate a little bit more on why this fix should
work, and realized that it works only by accident: cgroup_helpers
and trace_helpers are userspace code, and my fix modifies the recipe
for building bpf programs.

Please disregard this patch - I will have to come up with a better fix.

