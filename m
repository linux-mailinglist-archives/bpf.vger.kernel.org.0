Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88FC6659DE
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2019 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfGKPBA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 11 Jul 2019 11:01:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728725AbfGKPBA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Jul 2019 11:01:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6BExOvP033996
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2019 11:00:59 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tp6s41jt7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2019 11:00:54 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 11 Jul 2019 16:00:42 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Jul 2019 16:00:38 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6BF0bkp12648538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jul 2019 15:00:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D23A64204C;
        Thu, 11 Jul 2019 15:00:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B08C44203F;
        Thu, 11 Jul 2019 15:00:37 +0000 (GMT)
Received: from dyn-9-152-97-237.boeblingen.de.ibm.com (unknown [9.152.97.237])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Jul 2019 15:00:37 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v3 bpf] selftests/bpf: do not ignore clang failures
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <CAEf4Bzb6mY-F-wUNNimS+hMSRbJetTKXNcGDQbsJXhXDywA+tg@mail.gmail.com>
Date:   Thu, 11 Jul 2019 17:00:37 +0200
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <liu.song.a23@gmail.com>
Content-Transfer-Encoding: 8BIT
References: <20190711091249.59865-1-iii@linux.ibm.com>
 <CAEf4Bzb6mY-F-wUNNimS+hMSRbJetTKXNcGDQbsJXhXDywA+tg@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19071115-0016-0000-0000-00000291CE55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071115-0017-0000-0000-000032EF8E88
Message-Id: <51821F5F-A70F-485B-B6E7-CAE6D49B6D1D@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=889 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907110170
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 11.07.2019 um 16:55 schrieb Andrii Nakryiko <andrii.nakryiko@gmail.com>:
> 
> On Thu, Jul 11, 2019 at 2:14 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>> 
>> 
>> In addition, pull Kbuild.include in order to get .DELETE_ON_ERROR target,
> 
> In your original patch you explicitly declared .DELETE_ON_ERROR, but
> in this one you just include Kbuild.include.
> Is it enough to just include that file to get desired behavior or your
> forgot to add .DELETE_ON_ERROR?

It’s enough to just include Kbuild.include. I grepped the source tree
and found that no one else declares .DELETE_ON_ERROR explicitly, so I've
decided to avoid doing this as well.
