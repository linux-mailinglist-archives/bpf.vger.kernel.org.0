Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD323331A38
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 23:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhCHWcF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 17:32:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41902 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231826AbhCHWbp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Mar 2021 17:31:45 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128M3cOc129873;
        Mon, 8 Mar 2021 17:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Dhc9hjSdn2QHIPO0Yd8tJG4DNUJnc4lXrvycIDM/tOY=;
 b=Q8nnhPRkjlSVdGbMDsgWk9e2lNTSgr8RiA6YvjLqw71mNU8a3YKnPVe7rPeQndjhWFXH
 Im6XMKscixPmdTOah1NzRp/9QJstKWIQePn0kmInjtKpECuni/200BEi1gUghc9dqTCc
 kALYbhAjaRcrHPa8Cl4xJxGXjWqjbT1ddbzV0kcWVbjfwg3GFW8O3so5krClDYAkb2j5
 +JTYDIlba7G8pXg2Wf6faxSJuQ0Bc9dxHTjra9+0nuN3tp7X3OU4Eu+xMD7zDc5InemS
 yiM+E6/1QlPe1KqfgRhAEr/i3fVm9Kr6MaaI0nnVAWe167N1dPcO8Sovust/1yw927Sx 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375udpt2a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 17:31:32 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 128M3Wp1129664;
        Mon, 8 Mar 2021 17:31:31 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375udpt28w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 17:31:31 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 128MS2Ia002972;
        Mon, 8 Mar 2021 22:31:28 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3741c8j6rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 22:31:28 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 128MVPlC55706012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Mar 2021 22:31:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 556E0A40AB;
        Mon,  8 Mar 2021 22:31:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B70E5A40AD;
        Mon,  8 Mar 2021 22:31:24 +0000 (GMT)
Received: from sig-9-145-31-74.uk.ibm.com (unknown [9.145.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Mar 2021 22:31:24 +0000 (GMT)
Message-ID: <ed1ac857a282f9606b22ca907b7cf93f6e29e483.camel@linux.ibm.com>
Subject: Re: [PATCH] btf: Add support for the floating-point types
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Mon, 08 Mar 2021 23:31:24 +0100
In-Reply-To: <CAEf4BzbHyg6xndiw=gNhW79ofWACzb1mtDt0ghEhkRMpOd70GQ@mail.gmail.com>
References: <20210306022203.152930-1-iii@linux.ibm.com>
         <CAEf4BzYvawU4jTKwoUagY0Bn0SYNwcSohb-ZAPq_rLvF5qLamg@mail.gmail.com>
         <YETSLwfibXxelBIN@kernel.org> <YETYtWwSFVMDAnCA@kernel.org>
         <YETaG9CZbrzMNmbh@kernel.org> <YETejOpEPkaP3UU1@kernel.org>
         <5042b6b4d47ac2a8bb919909d43b1fe826fd9441.camel@linux.ibm.com>
         <YEYgVmo0ryuM3SUY@kernel.org>
         <CAEf4BzbHyg6xndiw=gNhW79ofWACzb1mtDt0ghEhkRMpOd70GQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_20:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080115
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2021-03-08 at 14:16 -0800, Andrii Nakryiko wrote:
> On Mon, Mar 8, 2021 at 5:02 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> > 
> > Em Mon, Mar 08, 2021 at 04:02:58AM +0100, Ilya Leoshkevich
> > escreveu:
> > > On Sun, 2021-03-07 at 11:09 -0300, Arnaldo Carvalho de Melo
> > > wrote:
> > > > Adding Jiri to the CC list.
> > > > Em Sun, Mar 07, 2021 at 10:50:19AM -0300, Arnaldo Carvalho de
> > > > Melo escreveu:
> > > > > Em Sun, Mar 07, 2021 at 10:44:21AM -0300, Arnaldo Carvalho de
> > > > > Melo escreveu:
> > > > > Now will build a kernel with this new version, reboot, then
> > > > > push
> > > > > publicly.
> > 
> > > > So now trying to build v5.12-rc2 with pahole supporting
> > > > BTF_KIND_FLOAT:
> > 
> > > >   AS      .tmp_vmlinux.kallsyms2.S
> > > >   LD      vmlinux
> > > >   BTFIDS  vmlinux
> > > > FAILED: load BTF from vmlinux: Invalid argument
> > > > make[1]: *** [/home/acme/git/linux/Makefile:1197: vmlinux]
> > > > Error 255
> > > > make[1]: Leaving directory '/home/acme/git/build/v5.12.0-rc2'
> > > > make: *** [Makefile:215: __sub-make] Error 2
> > > > [acme@five linux]$
> > 
> > > > [acme@five linux]$ egrep BTF\|DWARF  ../build/v5.12.0-
> > > > rc2/.config
> > > > CONFIG_VIDEO_SONY_BTF_MPX=m
> > > > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> > > > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > > > CONFIG_DEBUG_INFO_BTF=y
> > > > CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> > > > CONFIG_DEBUG_INFO_BTF_MODULES=y
> > 
> > > > Ideas?
> > 
> > > So v5.12-rc2 does not have this series yet:
> > 
> > > https://lore.kernel.org/bpf/20210226202256.116518-1-iii@linux.ibm.com/
> > 
> > > pahole generates a BTF_KIND_FLOAT, but libbpf from v5.12-rc2
> > > doesn't
> > > know how to handle it and resolve_btfids fails.
> > 
> > > I guess this is the first time a new BTF kind is added? I checked
> > > the
> > > history, and kernel v5.2, which introduced DEBUG_INFO_BTF,
> > > already had
> > > BTF_KIND_DATASEC.
> > 
> > > So should I add a command-line option to pahole, which would tell
> > > it
> > > the desired libbpf compatibility level?
> > 
> > Yes, that would be best, some sort of capability querying and then
> > a
> > decision about using the new feature.
> 
> pahole could be used to add .BTF post-factum to vmlinux image of a
> very old kernel, even the one that doesn't support BTF at all. So
> whatever detection system is going to be added, we should make it
> easy
> to turn it off.

I'd rather not have detection at all. Instead, pahole should encode
floats as ints by default (that's not fully correct, but that's the way
it is today). Then we can pass --libbpf-compat=0.4.0 in link-vmlinux.sh
in the newer kernels, which would turn on the new feature.

