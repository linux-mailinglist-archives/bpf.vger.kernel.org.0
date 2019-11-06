Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7923F1B2C
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2019 17:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfKFQ2q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 6 Nov 2019 11:28:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727285AbfKFQ2p (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Nov 2019 11:28:45 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA6GIuSF039726
        for <bpf@vger.kernel.org>; Wed, 6 Nov 2019 11:28:44 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w40qjk1qn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2019 11:28:44 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 6 Nov 2019 16:28:41 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Nov 2019 16:28:38 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA6GSbgi33554552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Nov 2019 16:28:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE59042047;
        Wed,  6 Nov 2019 16:28:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 978A042045;
        Wed,  6 Nov 2019 16:28:37 +0000 (GMT)
Received: from dyn-9-152-99-170.boeblingen.de.ibm.com (unknown [9.152.99.170])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Nov 2019 16:28:37 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [RFC PATCH bpf-next] bpf: allow JIT debugging if
 CONFIG_BPF_JIT_ALWAYS_ON is set
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <CAADnVQ+jOo61VoOp+CDAW7k+GnacgEB8Kge-4JsDBaF25sVhWA@mail.gmail.com>
Date:   Wed, 6 Nov 2019 17:28:37 +0100
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 8BIT
References: <20191106161204.87261-1-iii@linux.ibm.com>
 <CAADnVQ+jOo61VoOp+CDAW7k+GnacgEB8Kge-4JsDBaF25sVhWA@mail.gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
X-TM-AS-GCONF: 00
x-cbid: 19110616-0012-0000-0000-000003614820
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110616-0013-0000-0000-0000219CA5F2
Message-Id: <10A60D54-07EB-4B5D-AD3B-59C6D8D7CF9D@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=976 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911060157
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 06.11.2019 um 17:15 schrieb Alexei Starovoitov <alexei.starovoitov@gmail.com>:
> 
> On Wed, Nov 6, 2019 at 8:12 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>> 
>> Currently it's not possible to set bpf_jit_enable = 2 when
>> CONFIG_BPF_JIT_ALWAYS_ON is set, which makes debugging certain problems
>> harder.
> 
> This is obsolete way of debugging.
> Please use bpftool dump jited instead.

Is there a way to integrate bpftool nicely with e.g. test_verifier?
With bpf_jit_enable = 2, I can see JITed code for each test right away,
without pausing it (via gdb or rebuilding with added sleep()) and
running bpftool.
