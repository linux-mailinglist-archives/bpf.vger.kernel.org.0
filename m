Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF95B747
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfGAIzs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 1 Jul 2019 04:55:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbfGAIzr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Jul 2019 04:55:47 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x618rHuV030797
        for <bpf@vger.kernel.org>; Mon, 1 Jul 2019 04:55:47 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tfe97tt7x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 04:55:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 1 Jul 2019 09:55:44 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 09:55:41 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x618teQS40960020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 08:55:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6E3B4C05A;
        Mon,  1 Jul 2019 08:55:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8BC04C050;
        Mon,  1 Jul 2019 08:55:40 +0000 (GMT)
Received: from dyn-9-152-98-98.boeblingen.de.ibm.com (unknown [9.152.98.98])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 08:55:40 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH bpf-next] selftests/bpf: do not ignore clang failures
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <CAPhsuW5ToikpcEbJjC+JsxWSjgUBHKS97=hiTmt1EHmC9HFb8Q@mail.gmail.com>
Date:   Mon, 1 Jul 2019 10:55:32 +0200
Cc:     bpf <bpf@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
References: <20190627091450.78550-1-iii@linux.ibm.com>
 <CAPhsuW5ToikpcEbJjC+JsxWSjgUBHKS97=hiTmt1EHmC9HFb8Q@mail.gmail.com>
To:     Song Liu <liu.song.a23@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19070108-0028-0000-0000-0000037F414B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070108-0029-0000-0000-0000243F75E5
Message-Id: <2EA9DD60-A922-4056-8775-3F556B9A0087@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010111
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 28.06.2019 um 22:35 schrieb Song Liu <liu.song.a23@gmail.com>:
> 
> On Thu, Jun 27, 2019 at 2:15 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>> 
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index f2dbe2043067..2316fa2d5b3b 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -1,5 +1,6 @@
>> # SPDX-License-Identifier: GPL-2.0
>> 
>> +SHELL := /bin/bash
> 
> I am not sure whether it is ok to require bash. I don't see such requirements in
> other Makefile's under tools/.
> 
> Can we enable some fall back when bash is not present?
> 
> Thanks,
> Song

I think checking for bash presence would unnecessarily complicate
things.  What do you think about having separate targets for
clang-generated bitcode?

Best regards,
Ilya
