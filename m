Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77EC8A35D8
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 13:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfH3Lj1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 30 Aug 2019 07:39:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727525AbfH3Lj1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Aug 2019 07:39:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7UBcOeY103989
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 07:39:26 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upyk70kyf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 07:39:26 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Fri, 30 Aug 2019 12:39:23 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Aug 2019 12:39:20 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7UBdJD349414224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 11:39:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 929D711C05B;
        Fri, 30 Aug 2019 11:39:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68D7211C04A;
        Fri, 30 Aug 2019 11:39:19 +0000 (GMT)
Received: from dyn-9-152-96-21.boeblingen.de.ibm.com (unknown [9.152.96.21])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 11:39:19 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] bpf: s390: add JIT support for bpf line info
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20190829200217.16075-1-yauheni.kaliuta@redhat.com>
Date:   Fri, 30 Aug 2019 13:39:19 +0200
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, jolsa@redhat.com
Content-Transfer-Encoding: 8BIT
References: <xunyd0go9cba.fsf@redhat.com>
 <20190829200217.16075-1-yauheni.kaliuta@redhat.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19083011-0008-0000-0000-0000030EFD76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19083011-0009-0000-0000-00004A2D44D7
Message-Id: <879D38E9-3F3D-4C77-A370-8D4998F9FEF9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300127
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 29.08.2019 um 22:02 schrieb Yauheni Kaliuta <yauheni.kaliuta@redhat.com>:
> 
> This adds support for generating bpf line info for JITed programs
> like commit 6f20c71d8505 ("bpf: powerpc64: add JIT support for bpf
> line info") does for powerpc, but it should pass the array starting
> from 1 like x86, see commit 7c2e988f400e ("bpf: fix x64 JIT code
> generation for jmp to 1st insn".
> 
> That fixes test_btf.
> 
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
> 
> The patch is on top of "bpf: s390: add JIT support for multi-function
> programs"
> 
> V1->V1:
> 
> - pass address array starting from element 1.
> 
> ---
> arch/s390/net/bpf_jit_comp.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index b6801d854c77..ce88211b9c6c 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -1420,6 +1420,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> 	fp->jited_len = jit.size;
> 
> 	if (!fp->is_func || extra_pass) {
> +		bpf_prog_fill_jited_linfo(fp, jit.addrs + 1);
> free_addrs:
> 		kfree(jit.addrs);
> 		kfree(jit_data);
> -- 
> 2.22.0
> 

Checkpatch complains about the missing ")" at the end of 7c2e988f400e
commit description. With that fixed:

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thanks!
