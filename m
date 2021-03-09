Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FF333261D
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 14:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhCINHW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Mar 2021 08:07:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231335AbhCINHQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Mar 2021 08:07:16 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129D2p11098851;
        Tue, 9 Mar 2021 08:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+D3n7L53Ujb0JDqP/0WZ00OQ8P2nbTQ2ok8mnAojsk0=;
 b=J7t+jyzv8VsvTSg8f2wwD6EooY4qLKpf+O6wYRtmlJJp20CN3j3zSPG/i2E6hzqGLgYG
 1FcuJveNg3GQxKThos/4gsLMwl8Rykml/7Ih+uEHCHJUSNA4Si5q/BRAuz5Y0qgHUA8T
 UKCTbWTAz1xHemuGOKmzba/6SiFydFL5VuEscHBIwijq8enxpBekk3BIsmi8DYBf68Ij
 Jpyxm0AGv/Zd186lpmfc3hkvuUknWKylTy7osI9J8em8HW7nUe3B0BvgkRe8ELJsGEX0
 N04ftJlV/oV+YGOVR1q5Zv4lpeWGhrsP9IKyDboV1p4JmT3x0bQD9iVZqJw2W0pYWM00 QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37640j23ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 08:07:01 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 129D3EsS100712;
        Tue, 9 Mar 2021 08:07:01 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37640j23ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 08:07:01 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 129D2pdu001395;
        Tue, 9 Mar 2021 13:06:58 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3768t4g1es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 13:06:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 129D6era31523168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 13:06:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F80CAE056;
        Tue,  9 Mar 2021 13:06:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2D66AE058;
        Tue,  9 Mar 2021 13:06:54 +0000 (GMT)
Received: from sig-9-145-31-74.uk.ibm.com (unknown [9.145.31.74])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Mar 2021 13:06:54 +0000 (GMT)
Message-ID: <689856c423b1075bdd4b35dce2bb0dd58d92cb1d.camel@linux.ibm.com>
Subject: Re: [PATCH dwarves v2] btf: Add support for the floating-point types
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 09 Mar 2021 14:06:54 +0100
In-Reply-To: <YEdglMDZvplD6ELk@kernel.org>
References: <20210308235913.162038-1-iii@linux.ibm.com>
         <YEdglMDZvplD6ELk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_11:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103090064
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-03-09 at 08:48 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 09, 2021 at 12:59:13AM +0100, Ilya Leoshkevich escreveu:
> > Some BPF programs compiled on s390 fail to load, because s390
> > arch-specific linux headers contain float and double types.
> > 
> > Fix as follows:
> > 
> > - Make the DWARF loader fill base_type.float_type.
> > 
> > - Introduce libbpf compatibility level command-line parameter, so
> > that
> >   pahole could be used to build both the older and the newer
> > kernels.
> > 
> > - libbpf introduced the support for the floating-point types in
> > commit
> >   986962fade5, so update the libbpf submodule to that version and
> > use
> >   the new btf__add_float() function in order to emit the floating-
> > point
> >   types when not in the compatibility mode and base_type.float_type
> > is
> >   set.
> > 
> > - Make the BTF loader recognize the new BTF kind.
> > 
> > Example of the resulting entry in the vmlinux BTF:
> > 
> >     [7164] FLOAT 'double' size=8
> > 
> > when building with:
> > 
> >     LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1} --libbpf_compat=0.4.0
> 
> I'm testing it now, and added as a followup patch the man page entry,
> please check that the wording is appropriate.
> 
> Thanks,
> 
> - Arnaldo
> 
> [acme@five pahole]$ vim man-pages/pahole.1
> [acme@five pahole]$ git diff
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 352bb5e45f319da4..787771753d1933b1 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -199,6 +199,12 @@ Path to the base BTF file, for instance: vmlinux
> when encoding kernel module BTF
>  This may be inferred when asking for a /sys/kernel/btf/MODULE, when
> it will be autoconfigured
>  to "/sys/kernel/btf/vmlinux".
> 
> +.TP
> +.B \-\-libbpf_compat=LIBBPF_VERSION
> +Produce output compatible with this libbpf version. For instance,
> specifying 0.4.0 as
> +the version would encode BTF_KIND_FLOAT entries in systems where the
> vmlinux DWARF
> +information has float types.
> +
>  .TP
>  .B \-l, \-\-show_first_biggest_size_base_type_member
>  Show first biggest size base_type member.
> [acme@five pahole]$

The wording matches what I had in mind for this new flag, thanks!

