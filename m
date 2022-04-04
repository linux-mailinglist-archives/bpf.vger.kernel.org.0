Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441B74F1FB5
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 01:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiDDXDT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 19:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349594AbiDDXCg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 19:02:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977296CA6B
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 15:22:33 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234KXd6H017496;
        Mon, 4 Apr 2022 22:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yxHbKO1ARCwhCUqd/qvgruEk+GNIH1u2bgA2HaIJsBc=;
 b=nDtYrPR7tg9BkqHFH4vk4/NbQJE9xpEXKCXJcy0+uyuj1dnhmSvmTmdZMcbqT10KJf3i
 OjwFA+yGJoWBk/ksaFGUvPcsBp78FaJtmOtUWpSR/Vir08mCz4wRAP4IHdoY2Sarf1Kc
 lgkZuuMlc4V8WbVgIvMaLL6sb2y6yBhBoWWAfQR1pLgnvOqwV236ladF0lNRk/ELfm3N
 HehoMRwv49l2QVsuWRzzgCovuBeBfcgJ9sg/4mfDMEYJnb+FBCx26dmA0NcoZD3xyhR8
 Ex5+ALZL+lCPzOc3POt0HIkaRX3a0yto20qghHOeVpe5EgwPbfu4QoVO20IEgHLHwGU0 jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f80ysqng3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 22:22:20 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 234MLkil009465;
        Mon, 4 Apr 2022 22:22:20 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f80ysqnfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 22:22:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 234MH8Kg010696;
        Mon, 4 Apr 2022 22:22:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3f6drhmct2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 22:22:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 234MMEYM49217970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Apr 2022 22:22:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78600AE053;
        Mon,  4 Apr 2022 22:22:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F72BAE04D;
        Mon,  4 Apr 2022 22:22:14 +0000 (GMT)
Received: from [9.171.47.144] (unknown [9.171.47.144])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Apr 2022 22:22:13 +0000 (GMT)
Message-ID: <94ea750cd20efa203a5253b4d6f40a7c7661c87e.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next] libbpf: Support Debian in resolve_full_path()
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>
Date:   Tue, 05 Apr 2022 00:22:13 +0200
In-Reply-To: <CAEf4BzZfSUTNAXQM6BcXF6rQGe6LaSfpgiA9uQXu8Fvb3Kk-KQ@mail.gmail.com>
References: <20220404102908.14688-1-iii@linux.ibm.com>
         <CAEf4BzZfSUTNAXQM6BcXF6rQGe6LaSfpgiA9uQXu8Fvb3Kk-KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: izbJgYVCOtDLJEBoSmPrUBFMZcOUxoaG
X-Proofpoint-GUID: lT54HJBnHP46GJYErtuAYOUNgJV5JgTo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_09,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040123
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-04-04 at 14:58 -0700, Andrii Nakryiko wrote:
> On Mon, Apr 4, 2022 at 3:29 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > attach_probe selftest fails on Debian-based distros with `failed to
> > resolve full path for 'libc.so.6'`. The reason is that these
> > distros
> > embraced multiarch to the point where even for the "main"
> > architecture
> > they store libc in /lib/<triple>.
> > 
> > This is configured in /etc/ld.so.conf and in theory it's possible
> > to
> > replicate the loader's parsing and processing logic in libbpf,
> > however
> > a much simpler solution is to just enumerate the known library
> > paths.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 54 ++++++++++++++++++++++++++++++++++++--
> > ----
> >  1 file changed, 47 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 6d2be53e4ba9..4f616b11564f 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10707,21 +10707,61 @@ static long elf_find_func_offset(const
> > char *binary_path, const char *name)
> >         return ret;
> >  }
> > 
> > +static void add_debian_library_paths(const char **search_paths,
> > int *n)
> > +{
> > +       /*
> > +        * Based on https://packages.debian.org/sid/libc6.
> > +        *
> > +        * Assume that the traced program is built for the same
> > architecture
> > +        * as libbpf, which should cover the vast majority of
> > cases.
> > +        */
> > +#if defined(__x86_64__)
> 
> can you please also drop defined() where possible, it looks cleaner
> to me:
> 
> #if __x86_64__
> 
> vs
> 
> #if defined(__x86_64__)

The consensus in the existing kernel and tools code (including libbpf
itself) seems to be to use #if defined() or #ifdef for such macros:

$ git grep __x86_64__ | wc -l
306

$ git grep __x86_64__ | grep -v \
    -e '#\s*ifdef __x86_64__' \
    -e 'defined\s*(__x86_64__)' \
    -e '#\s*ifndef __x86_64__' \
    -e '#\s*else' \
    -e '#\s*endif'
arch/x86/Makefile:        CHECKFLAGS += -D__x86_64__
arch/x86/Makefile.um:CHECKFLAGS  += -m64 -D__x86_64__
tools/lib/bpf/libbpf.c:#if __x86_64__
tools/testing/selftests/ipc/Makefile:	CFLAGS := -DCONFIG_X86_64 -
D__x86_64__
tools/testing/selftests/rcutorture/bin/mkinitrd.sh:if echo -e "#if
__x86_64__||__i386__||__i486__||__i586__||__i686__" \
tools/testing/selftests/x86/mov_ss_trap.c:#if __x86_64__

I think `#if __x86_64__` should work in most cases, but I'd rather
stick with the existing style if you don't mind.
