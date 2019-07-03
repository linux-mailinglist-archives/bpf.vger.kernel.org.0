Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB1DF5E0F1
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2019 11:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGCJXL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jul 2019 05:23:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727004AbfGCJXL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Jul 2019 05:23:11 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x639N6Ob106906
        for <bpf@vger.kernel.org>; Wed, 3 Jul 2019 05:23:10 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tgrajued1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2019 05:23:08 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 3 Jul 2019 10:22:17 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Jul 2019 10:22:15 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x639MEBF53608496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jul 2019 09:22:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 857AFAE055;
        Wed,  3 Jul 2019 09:22:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 284AAAE04D;
        Wed,  3 Jul 2019 09:22:14 +0000 (GMT)
Received: from dyn-9-152-98-248.boeblingen.de.ibm.com (unknown [9.152.98.248])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Jul 2019 09:22:14 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: bpf: jit: s390 64/32 bits for index in tail call
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <xuny36jxppso.fsf@redhat.com>
Date:   Wed, 3 Jul 2019 11:22:13 +0200
Cc:     Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
Content-Transfer-Encoding: 7bit
References: <xuny36jxppso.fsf@redhat.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19070309-0028-0000-0000-0000037FEE3C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070309-0029-0000-0000-000024402BAF
Message-Id: <44F2B8D1-6636-4ACE-9C83-98C978FBA104@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=779 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030111
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> ```
>    With this patch a tail call generates the following code on s390x:
> 
>     if (index >= array->map.max_entries)
>             goto out
>     000003ff8001c7e4: e31030100016   llgf    %r1,16(%r3)
>     000003ff8001c7ea: ec41001fa065   clgrj   %r4,%r1,10,3ff8001c828
> ```
> 
> Do I understand corretly, that it uses 64 bit index value?
> 
> "runtime/jit: pass > 32bit index to tail_call"
> test_verifier's test fails for me and I see, for example,
> /* mov edx, edx */  in the x86 implementation

Hi Yauheni,

llgf zero-extends a 32-bit value and puts it into a register, so I would
expect index to be a 32-bit value here. This test passes for me:

#752/u runtime/jit: pass > 32bit index to tail_call OK
#752/p runtime/jit: pass > 32bit index to tail_call OK

Which machine are you using for testing? I tried that on z14 (3906).

Best regards,
Ilya

