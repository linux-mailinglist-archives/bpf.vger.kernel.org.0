Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC387333F6D
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 14:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhCJNkp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 08:40:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232821AbhCJNkR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Mar 2021 08:40:17 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12ADcEXL098114;
        Wed, 10 Mar 2021 08:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=O0wcbz3C5TW03jhf92GOdXXPXvVJINLKdZ2YRyrGXi8=;
 b=eYXo7D7QFQHarD9pcJ5Mm+MeB8nZTfo/xbIaNyTlEeOttjBxGBFaTSCg3/8PtCCN44qV
 F9hIKQF9P8+cX1Sr5+uy6TWdOhhqvXPTmMazRmz9TxvYw5YndeoVTud6nuTJHcU3Piff
 a0hsH6BbXkOR8/sa/+gRJr25Vts+1TigzOLr1R9P3PNLlJYmHMGMFuSOL9WfFlhmDkQS
 NUWXN/I3zIf4Y+hVgVjNUtVj+sa5wK9BHbBV5ZQr899fD/SWmbOZQPEAob0SZ2pIMXuZ
 x96BrI9w2B4C2o73GrON727yFakBtvW7hALI/MjSEU+W+w8jalMkd/S8su6niFzxvIcu Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 376jghb9f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 08:40:03 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12ADdab2109800;
        Wed, 10 Mar 2021 08:40:02 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 376jghb9dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 08:40:02 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12ADXEh4011937;
        Wed, 10 Mar 2021 13:40:00 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3768t4h162-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 13:40:00 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12ADdfC934603330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 13:39:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 271B711C050;
        Wed, 10 Mar 2021 13:39:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 917AE11C04C;
        Wed, 10 Mar 2021 13:39:56 +0000 (GMT)
Received: from sig-9-145-31-74.uk.ibm.com (unknown [9.145.31.74])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Mar 2021 13:39:56 +0000 (GMT)
Message-ID: <a8ca404e725891cbd54164ce4b08b884e3eabf1f.camel@linux.ibm.com>
Subject: Re: [PATCH dwarves v2] btf: Add support for the floating-point types
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Wed, 10 Mar 2021 14:39:56 +0100
In-Reply-To: <YEjLfbBQSxiWQMLD@kernel.org>
References: <20210308235913.162038-1-iii@linux.ibm.com>
         <YEdglMDZvplD6ELk@kernel.org>
         <CAEf4BzaN0XwrAaTNe4TojT8UfStvGUfQSJuSQ8CcMtLAgOu9iw@mail.gmail.com>
         <051e4d6b000af07cc65a8dc70f4589fa3bd4be78.camel@linux.ibm.com>
         <CAEf4BzZo4DJJgB57wrkDZCzBGf876ixZBjQrJE4XM_y7OTDKKQ@mail.gmail.com>
         <YEjLfbBQSxiWQMLD@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_08:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100066
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-03-10 at 10:37 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 09, 2021 at 08:14:50PM -0800, Andrii Nakryiko escreveu:
> > On Tue, Mar 9, 2021 at 1:57 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > > On Tue, 2021-03-09 at 13:37 -0800, Andrii Nakryiko wrote:
> > > > On Tue, Mar 9, 2021 at 3:48 AM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > > Em Tue, Mar 09, 2021 at 12:59:13AM +0100, Ilya Leoshkevich
> > > > > escreveu:
> > > > TBH, I think it's not exactly right to call out libbpf version
> > > > here.  It's BTF "version" (if we had such a thing) that
> > > > determines
> > > > the set of supported BTF kinds. There could be other libraries
> > > > that might want to parse BTF. So I don't know what this should
> > > > be
> > > > called, but libbpf_compat is probably a wrong name for it.
> 
> > > BTF version seems to exist: btf_header.version. Should we maybe
> > > bump
> > > this?
>  
> > That seems excessive. If the kernel doesn't use FLOATs, then no one
> > would even notice a difference. While if we bump this version, then
> > everything will automatically become incompatible.
> 
> > > > If we do want to teach pahole to not emit some parts of BTF, it
> > > > should
> > > > probably be a set of BPF features, not some arbitrary library
> > > > versions.
> 
> > > I thought about just adding --btf-allow-floats, but if new
> > > features
> > > will be added in the future, the list of options will become
> > > unwieldy.
> > > So I thought it would be good to settle for something that
> > > increases
> > > monotonically.
>  
> > BTF_KIND_FLOAT is the first extension in a long while. I'd worry
> > about
> > the proliferation of new options when we actually see some proof of
> > that being a problem in practice.
> 
> I tend to agree, Ilya, can you rework the patch in that direction?
> Something like --encode-btf-kind-float that starts disabled or other
> suitable name?
> 
> - Arnaldo

Sure, I'm actually testing v3 that does this right now. So far I went
with simply --btf_float, but I'll change it to the more explicit 
--encode_btf_kind_float.

