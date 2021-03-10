Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9819B334961
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 22:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhCJVDX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 16:03:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230491AbhCJVDK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Mar 2021 16:03:10 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AKZZlo039430;
        Wed, 10 Mar 2021 16:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=48427Q3e9u7jiZIek7Xnn7ihN6QjD11lvW1ADGEo7gc=;
 b=rD+8oJcCR7LvbV8TFrlHamXAYV4bc9q1f3klc0zY8RNi9SYPQc3+AwZB6qbY0nUfO8Hc
 Da5l1Z2lSpJAp+XhZo3h5tsDRApz4lMLtLa3jOD+kf/vHLQQVvYBgZN1CekSE9wPWu2j
 I1CHuj+KkvXsNYb5MJWkSaeGBp2/KOhSMBcSoUXmBQ2IUY4WNGRbsFVaI3hOdE3q0sy8
 Potxh6gAyRsRmpJOucMNcdOjdVYNkgR5QgB0yrmnS+gtUcxK6A5HROc0ruCnkrJ+E8Qc
 1NHEuMTu+FKXuLws2mblCpHXA/P/HVGRZLw8nrh1R+odezysKJ38gWy/BpMntNjkqere nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774kx9ycm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 16:02:56 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12AKdqh9059095;
        Wed, 10 Mar 2021 16:02:56 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774kx9ybt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 16:02:56 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12AKvOwS014515;
        Wed, 10 Mar 2021 21:02:53 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3768t4hap6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 21:02:53 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12AL2Y6c27591084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 21:02:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 548A8AE04D;
        Wed, 10 Mar 2021 21:02:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6160AE05A;
        Wed, 10 Mar 2021 21:02:49 +0000 (GMT)
Received: from sig-9-145-31-74.uk.ibm.com (unknown [9.145.31.74])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Mar 2021 21:02:49 +0000 (GMT)
Message-ID: <ff68a62e776ce9e459bece7ae87cc53573500a50.camel@linux.ibm.com>
Subject: Re: [PATCH v4 dwarves] btf: Add support for the floating-point types
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Wed, 10 Mar 2021 22:02:49 +0100
In-Reply-To: <CAEf4BzY0++YuU7+a3vSfWWZNLoov7mu7Q1ty4FqqH78gkqgqQw@mail.gmail.com>
References: <20210310201550.170599-1-iii@linux.ibm.com>
         <CAEf4BzY0++YuU7+a3vSfWWZNLoov7mu7Q1ty4FqqH78gkqgqQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_12:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103100099
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-03-10 at 12:25 -0800, Andrii Nakryiko wrote:
> On Wed, Mar 10, 2021 at 12:16 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > Some BPF programs compiled on s390 fail to load, because s390
> > arch-specific linux headers contain float and double types.
> > 
> > Fix as follows:
> > 
> > - Make the DWARF loader fill base_type.float_type.
> > 
> > - Introduce the --btf_gen_floats command-line parameter, so that
> >   pahole could be used to build both the older and the newer
> > kernels.
> > 
> > - libbpf introduced the support for the floating-point types in
> > commit
> >   986962fade5, so update the libbpf submodule to that version and
> > use
> >   the new btf__add_float() function in order to emit the floating-
> > point
> >   types when not in the compatibility mode.
> > 
> > - Make the BTF loader recognize the new BTF kind.
> > 
> > Example of the resulting entry in the vmlinux BTF:
> > 
> >     [7164] FLOAT 'double' size=8
> > 
> > when building with:
> > 
> >     LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1} --btf_gen_floats
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> 
> So it looks good to me overall, but here's the question about using
> this --btf-gen-floats flag from link-vmlinux.sh script. If you
> specify
> that flag for an old pahole, it will probably error out, right? So
> that means we'll need to do feature detection for pahole supported
> features, right?..

I was planning to just bump the version in this check:

    if [ "${pahole_ver}" -lt "116" ]; then

But we could also keep allowing 1.16-1.20 and pass the new flag on
1.21+ only.

What do you think?

