Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C8431E158
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 22:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBQV3b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 16:29:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49766 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232021AbhBQV3M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Feb 2021 16:29:12 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11HL33tT041911;
        Wed, 17 Feb 2021 16:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=RqoBzeBi1v8dd1+zZNLrneVRi1hRB8xpwxGwObv3byU=;
 b=SPbUeziQ8xdH6QVmvam9L4WIXWUhrWJX9h0Q0EDuUgA7xk6IAnfsGj49o5GoreNRIxiJ
 uzsKfdYLblgXE3/yEy+1JVRBy7lIqF8fQbn87TQHx/JJCPQpcTu8sv4Tv4G2i2q5a81y
 H0hoaPG4Xr10gU7Oy/+MQnCwyKdRX4IcfhKCDsM6b9VfmTJAiI8U950lisb4UqiRGw4g
 GGYA8UlBChj+QhoigJm7cQYX2Zn3x0+7kficXbOLRqIsyQIooOeKVWQMTU3SOLQD4uTD
 x10iMMkTCDd/tbx79TK1lmCJIYiwAMf5H/TDD9c0CHJC/J80fLrgC4Wqs6cszQ6Dktsl gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36saqg0nna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 16:28:18 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11HLM93U137686;
        Wed, 17 Feb 2021 16:28:17 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36saqg0nmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 16:28:17 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11HLNX2k006882;
        Wed, 17 Feb 2021 21:28:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 36p6d8a3ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 21:28:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11HLSDSP32506332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Feb 2021 21:28:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E8AC42042;
        Wed, 17 Feb 2021 21:28:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1612C42045;
        Wed, 17 Feb 2021 21:28:13 +0000 (GMT)
Received: from [9.171.64.123] (unknown [9.171.64.123])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Feb 2021 21:28:13 +0000 (GMT)
Message-ID: <fe6133e6e997b9eca7d9b3e0802642498812b3b5.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Wed, 17 Feb 2021 22:28:12 +0100
In-Reply-To: <602d86a63e754_fc54208eb@john-XPS-13-9370.notmuch>
References: <20210216011216.3168-1-iii@linux.ibm.com>
         <20210216011216.3168-3-iii@linux.ibm.com>
         <602d83616c9f1_ddd2208dd@john-XPS-13-9370.notmuch>
         <602d86a63e754_fc54208eb@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_16:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102170153
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-02-17 at 13:12 -0800, John Fastabend wrote:
> John Fastabend wrote:
> > Ilya Leoshkevich wrote:
> > > The logic follows that of BTF_KIND_INT most of the time.
> > > Sanitization
> > > replaces BTF_KIND_FLOATs with equally-sized BTF_KIND_INTs on
> > > older
> >                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Does this match the code though?
> > 
> > > kernels.
> > > 
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > 
> > [...]
> > 
> > 
> > > @@ -2445,6 +2450,9 @@ static void bpf_object__sanitize_btf(struct
> > > bpf_object *obj, struct btf *btf)
> > >                 } else if (!has_func_global && btf_is_func(t)) {
> > >                         /* replace BTF_FUNC_GLOBAL with
> > > BTF_FUNC_STATIC */
> > >                         t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0,
> > > 0);
> > > +               } else if (!has_float && btf_is_float(t)) {
> > > +                       /* replace FLOAT with INT */
> > > +                       t->info = BTF_INFO_ENC(BTF_KIND_FLOAT, 0,
> > > 0);
> > 
> > Do we also need to encode the vlen here?
> 
> Sorry typo on my side, 't->size = ?' is what I was trying to point
> out.
> Looks like its set in the other case where we replace VAR with INT.

The idea is to have the size of the INT equal to the size of the FLOAT
that it replaces. I guess we can't do the same for VARs, because they
don't have the size field, and if we don't have DATASECs, then we can't
find the size of a VAR at all.

