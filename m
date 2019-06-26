Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F8F56E86
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2019 18:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfFZQQB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 26 Jun 2019 12:16:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbfFZQQB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jun 2019 12:16:01 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QGE7Tc074501
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2019 12:16:00 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcan3c76a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2019 12:16:00 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 26 Jun 2019 17:15:58 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Jun 2019 17:15:56 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5QGFubb42467340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2019 16:15:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D85F0A405C
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2019 16:15:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0B23A4060
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2019 16:15:55 +0000 (GMT)
Received: from dyn-9-152-99-186.boeblingen.de.ibm.com (unknown [9.152.99.186])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2019 16:15:55 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: bpf-next: building samples on s390x
Date:   Wed, 26 Jun 2019 18:15:55 +0200
To:     bpf@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19062616-4275-0000-0000-000003467C69
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062616-4276-0000-0000-000038568234
Message-Id: <8F4FF60D-529B-444C-AB25-F73E95CDDC62@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=52 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=693 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260190
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi all,

I’m trying to build bpf samples on s390x, and I’m getting the following
error:

progs/loop3.c:19:13: error: incomplete definition of type 'struct pt_regs'
                sum += ctx->rax;

I tried to fix that by using `PT_REGS_RC` macro, but:

- `struct pt_regs` is not defined for s390x userspace;
- `PT_REGS_RC` uses `ax` field, which is a part of x86_64 kernel
  version of `struct pt_regs`, whereas `rax` is a part of its userspace
  version.

My question is: which headers should eBPF programs ultimately use:
userspace or kernel? According to my experiments, eBPF samples seem to
use userspace headers and bcc seems to use kernel headers.

Best regards,
Ilya
