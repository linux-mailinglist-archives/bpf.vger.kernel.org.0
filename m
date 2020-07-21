Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074DB2289AD
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 22:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGUUQj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 16:16:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbgGUUQi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Jul 2020 16:16:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LK2BLv124635;
        Tue, 21 Jul 2020 16:16:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32cdyb9g10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 16:16:26 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06LK4Ylo134456;
        Tue, 21 Jul 2020 16:16:26 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32cdyb9g00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 16:16:26 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LKFxiw012161;
        Tue, 21 Jul 2020 20:16:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 32dbmn0sur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 20:16:23 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LKGKSP19268086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 20:16:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE189A4054;
        Tue, 21 Jul 2020 20:16:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EAAAA405F;
        Tue, 21 Jul 2020 20:16:20 +0000 (GMT)
Received: from osiris (unknown [9.171.1.44])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Jul 2020 20:16:20 +0000 (GMT)
Date:   Tue, 21 Jul 2020 22:16:19 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 0/4] s390/bpf: implement BPF_PROBE_MEM
Message-ID: <20200721201619.GA4070@osiris>
References: <20200715233301.933201-1-iii@linux.ibm.com>
 <CAADnVQ+fbfAEarcjJCeF=7ssBG2rpxzLZkVT0ZW7k6HWcN1uBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+fbfAEarcjJCeF=7ssBG2rpxzLZkVT0ZW7k6HWcN1uBg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_14:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210128
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

On Tue, Jul 21, 2020 at 11:01:22AM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 15, 2020 at 4:38 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > This patch series implements BPF_PROBE_MEM opcode, which is used in BPF
> > programs that walk chains of kernel pointers. It consists of two parts:
> > patches 1 and 2 enhance s390 exception table infrastructure, patches 3
> > and 4 contains the actual implementation and the test.
> >
> > We would like to take this series via s390 tree, because it contains
> > dependent s390 extable and bpf jit changes. However, it would be great
> > if someone knowledgeable could review patches 3 and 4.

You probably missed this part? It should go upstream via the s390
tree, plus this version is broken since it crashes immediatly if KASLR
is enabled.

> Applied. Thanks

A fixed variant is applied to the s390 tree:
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=05a68e892e89c97df6650cd8cc55058002657cbc
