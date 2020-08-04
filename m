Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A49B23C042
	for <lists+bpf@lfdr.de>; Tue,  4 Aug 2020 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHDToL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Aug 2020 15:44:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23656 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727014AbgHDToL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Aug 2020 15:44:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074JY0b2138302
        for <bpf@vger.kernel.org>; Tue, 4 Aug 2020 15:44:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qbvqbtkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2020 15:44:10 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 074Jdxej154919
        for <bpf@vger.kernel.org>; Tue, 4 Aug 2020 15:44:10 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qbvqbtkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 15:44:10 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074Jhsdv015875;
        Tue, 4 Aug 2020 19:44:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 32n018a7ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 19:44:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 074Ji5GV17236472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 19:44:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE51AAE045;
        Tue,  4 Aug 2020 19:44:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B2A5AE051;
        Tue,  4 Aug 2020 19:44:05 +0000 (GMT)
Received: from sig-9-145-26-160.uk.ibm.com (unknown [9.145.26.160])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Aug 2020 19:44:05 +0000 (GMT)
Message-ID: <7fb300731582d6c9a61e5de952c94720c5a62c3b.camel@linux.ibm.com>
Subject: Re: s390 test_bpf: #284 BPF_MAXINSNS: Maximum possible literals
 failure
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Yauheni Kaliuta <ykaliuta@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>
Date:   Tue, 04 Aug 2020 21:44:05 +0200
In-Reply-To: <CANoWsw=4H1bHNmDP1GDo+wROCyZiZwFr-LPwoeZcWss2tJ-MNQ@mail.gmail.com>
References: <CANoWsw=4H1bHNmDP1GDo+wROCyZiZwFr-LPwoeZcWss2tJ-MNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_04:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 suspectscore=4 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040137
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2020-08-04 at 20:40 +0300, Yauheni Kaliuta wrote:
> Hi!
> 
> I have a failure (crash) of selftests/bpf/test_kmod.sh on s390.
> 
> The problem comes with loading with
> 
> sysctl -w net.core.bpf_jit_harden=2
> 
> In that case the program (lib/test_bpf.c):
> 
> static int bpf_fill_maxinsns1(struct bpf_test *self)
> {
>     unsigned int len = BPF_MAXINSNS;
>     struct sock_filter *insn;
>     __u32 k = ~0;
>     int i;
> 
>     insn = kmalloc_array(len, sizeof(*insn), GFP_KERNEL);
>     if (!insn)
>         return -ENOMEM;
> 
>     for (i = 0; i < len; i++, k--)
>         insn[i] = __BPF_STMT(BPF_RET | BPF_K, k);
> 
>     self->u.ptr.insns = insn;
>     self->u.ptr.len = len;
> 
>     return 0;
> }
> 
> after blinding and jiting is 98362 bytes for me and it does not fit
> 16bit offset for BRC 15,.. command where BPF_EXIT | BPF_JMP is
> translated.
> 
> What is the easiest way to use BRCL for large offset here?
> 
> Thanks!

Hi Yauheni!

Did you try bpf-next, specifically with commit 5fa6974471c5 ("s390/bpf:
Use brcl for jumping to exit_ip if necessary")? This was supposed to
fix this problem.

Best regards,
Ilya

