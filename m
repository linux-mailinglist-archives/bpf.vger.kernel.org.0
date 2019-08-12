Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D76498A255
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2019 17:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfHLPbA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Aug 2019 11:31:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726818AbfHLPbA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Aug 2019 11:31:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CFROdP110232
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2019 11:30:59 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ub9c9mykd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2019 11:30:58 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 12 Aug 2019 16:30:56 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Aug 2019 16:30:53 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7CFUrtG61210846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 15:30:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEB0011C050;
        Mon, 12 Aug 2019 15:30:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF1AD11C054;
        Mon, 12 Aug 2019 15:30:52 +0000 (GMT)
Received: from dyn-9-152-97-155.boeblingen.de.ibm.com (unknown [9.152.97.155])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Aug 2019 15:30:52 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Sending s390 eBPF JIT patches via bpf@vger.kernel.org
Date:   Mon, 12 Aug 2019 17:30:52 +0200
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19081215-0008-0000-0000-000003083E76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081215-0009-0000-0000-00004A264DF1
Message-Id: <5EC6E1F2-DBE4-42AB-B3F8-C6E78F52A7BF@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=683 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120172
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Daniel and Alexei,

We would like to send s390 eBPF JIT patches through your bpf tree (as
opposed to our s390 tree), since even though they mostly deal with s390
instruction set, we believe you might spot more potential issues than
we do. We also hope that this would allow to identify potential 
conflicts with generic bpf changes earlier. Would that be OK?

Best regards,
Ilya

