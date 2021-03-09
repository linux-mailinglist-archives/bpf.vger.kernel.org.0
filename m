Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28400333150
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 22:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhCIV6i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Mar 2021 16:58:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230320AbhCIV6I (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Mar 2021 16:58:08 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129LXR4q038983;
        Tue, 9 Mar 2021 16:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MBIgUSdvkK7QY/GIlzvq//p0Kddntw4vLogEln8ehrs=;
 b=ln17TwF3XLHAGzPekD+NVGSghMY0+TQpOhG647s+L+LOYnFnYqf5i4XzrzJCc1Uceaf6
 oqN/Ht+dcAAh1bzYVzhFta1PhyxgXl8PrJchuLf5urr1mTa0Y+LUwfPa0MIXp2ZSX64o
 TgNjMA9ZLbsMXGwa7z8ljFQXgP1kQENFSPvBhHZ8cSBUkSLMT3qYV9mf3KrMCCji+hkG
 RY9kZrLgRvAluHNY7gpvVXivLcGxURtwjCJpahxFCysV4OXBBMmYJnvdR+bX66sfkTBP
 +zxaS3be+RRUHNtyeq3CXCm6H0PWQekKn7T4XOT/qoKUN6QlqJ9K0zRvawJIFOz33isD Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 376gwt8tvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 16:57:53 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 129LaNo2056187;
        Tue, 9 Mar 2021 16:57:52 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 376gwt8tum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 16:57:52 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 129LqsPB004802;
        Tue, 9 Mar 2021 21:57:50 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3768t4gdg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 21:57:50 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 129Lvldv40501714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 21:57:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73EEF4C04A;
        Tue,  9 Mar 2021 21:57:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6D364C046;
        Tue,  9 Mar 2021 21:57:46 +0000 (GMT)
Received: from sig-9-145-31-74.uk.ibm.com (unknown [9.145.31.74])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Mar 2021 21:57:46 +0000 (GMT)
Message-ID: <051e4d6b000af07cc65a8dc70f4589fa3bd4be78.camel@linux.ibm.com>
Subject: Re: [PATCH dwarves v2] btf: Add support for the floating-point types
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 09 Mar 2021 22:57:46 +0100
In-Reply-To: <CAEf4BzaN0XwrAaTNe4TojT8UfStvGUfQSJuSQ8CcMtLAgOu9iw@mail.gmail.com>
References: <20210308235913.162038-1-iii@linux.ibm.com>
         <YEdglMDZvplD6ELk@kernel.org>
         <CAEf4BzaN0XwrAaTNe4TojT8UfStvGUfQSJuSQ8CcMtLAgOu9iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_18:2021-03-09,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090105
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-03-09 at 13:37 -0800, Andrii Nakryiko wrote:
> On Tue, Mar 9, 2021 at 3:48 AM Arnaldo Carvalho de Melo <
> acme@kernel.org> wrote:
> > 
> > Em Tue, Mar 09, 2021 at 12:59:13AM +0100, Ilya Leoshkevich
> > escreveu:
> > > Some BPF programs compiled on s390 fail to load, because s390
> > > arch-specific linux headers contain float and double types.
> > > 
> > > Fix as follows:
> > > 
> > > - Make the DWARF loader fill base_type.float_type.
> > > 
> > > - Introduce libbpf compatibility level command-line parameter, so
> > > that
> > >   pahole could be used to build both the older and the newer
> > > kernels.
> > > 
> > > - libbpf introduced the support for the floating-point types in
> > > commit
> > >   986962fade5, so update the libbpf submodule to that version and
> > > use
> > >   the new btf__add_float() function in order to emit the
> > > floating-point
> > >   types when not in the compatibility mode and
> > > base_type.float_type is
> > >   set.
> > > 
> > > - Make the BTF loader recognize the new BTF kind.
> > > 
> > > Example of the resulting entry in the vmlinux BTF:
> > > 
> > >     [7164] FLOAT 'double' size=8
> > > 
> > > when building with:
> > > 
> > >     LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1} --
> > > libbpf_compat=0.4.0
> > 
> > I'm testing it now, and added as a followup patch the man page
> > entry,
> > please check that the wording is appropriate.
> > 
> > Thanks,
> > 
> > - Arnaldo
> > 
> > [acme@five pahole]$ vim man-pages/pahole.1
> > [acme@five pahole]$ git diff
> > diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> > index 352bb5e45f319da4..787771753d1933b1 100644
> > --- a/man-pages/pahole.1
> > +++ b/man-pages/pahole.1
> > @@ -199,6 +199,12 @@ Path to the base BTF file, for instance:
> > vmlinux when encoding kernel module BTF
> >  This may be inferred when asking for a /sys/kernel/btf/MODULE,
> > when it will be autoconfigured
> >  to "/sys/kernel/btf/vmlinux".
> > 
> > +.TP
> > +.B \-\-libbpf_compat=LIBBPF_VERSION
> > +Produce output compatible with this libbpf version. For instance,
> > specifying 0.4.0 as
> > +the version would encode BTF_KIND_FLOAT entries in systems where
> > the vmlinux DWARF
> > +information has float types.
> 
> TBH, I think it's not exactly right to call out libbpf version here.
> It's BTF "version" (if we had such a thing) that determines the set
> of
> supported BTF kinds. There could be other libraries that might want
> to
> parse BTF. So I don't know what this should be called, but
> libbpf_compat is probably a wrong name for it.

BTF version seems to exist: btf_header.version. Should we maybe bump
this?

> 
> If we do want to teach pahole to not emit some parts of BTF, it
> should
> probably be a set of BPF features, not some arbitrary library
> versions.

I thought about just adding --btf-allow-floats, but if new features
will be added in the future, the list of options will become unwieldy.
So I thought it would be good to settle for something that increases
monotonically.

