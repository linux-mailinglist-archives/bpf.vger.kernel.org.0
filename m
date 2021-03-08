Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143AA33063A
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 04:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhCHDDh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Mar 2021 22:03:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8970 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232369AbhCHDDV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Mar 2021 22:03:21 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1282YNd7085962;
        Sun, 7 Mar 2021 22:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9JzW+pp8XdAZhgrWYlEy6+4/o1Mjk3B+X19mmKfvaqQ=;
 b=to7ids8KVNNsjJ5Sz0B9I+oHdGHtv+ytMmm5BNpZfU3xmgqh5h7yLwh9ii9EVImruoaf
 2T3ZpbBBcxc1aXz5CiVnlKuUSY9xGknajh3wZKp4kY0/M3TZ97W/wx7YbQX5vR2tYKh/
 R7674xm4LMmSo5JuKPu2/J++1EdF/OYgvEAvbc891pxSat8C0qc3mhCvemJ/Lgz13C/U
 zX+EpdSe2P8G2hsZ8vZGEhy9jA4Z0LIk/iPI6KswSMSVfBBsSqWkgjeLC80dRFuLR2dG
 IvzuREPNkC2ySHwPcM8d50gWuJj1yuUWDRaORNgQOBu7pEX2OtAXMa8EyfkkWQ2mqC4U Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375b8frexq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 22:03:07 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1282YfpL086695;
        Sun, 7 Mar 2021 22:03:04 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375b8frew3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 22:03:04 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1282wIAI018839;
        Mon, 8 Mar 2021 03:03:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3741c89eey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 03:03:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12832xBq41812438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Mar 2021 03:02:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5716CA405F;
        Mon,  8 Mar 2021 03:02:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8A1CA4060;
        Mon,  8 Mar 2021 03:02:58 +0000 (GMT)
Received: from sig-9-145-31-74.uk.ibm.com (unknown [9.145.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Mar 2021 03:02:58 +0000 (GMT)
Message-ID: <5042b6b4d47ac2a8bb919909d43b1fe826fd9441.camel@linux.ibm.com>
Subject: Re: [PATCH] btf: Add support for the floating-point types
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Mon, 08 Mar 2021 04:02:58 +0100
In-Reply-To: <YETejOpEPkaP3UU1@kernel.org>
References: <20210306022203.152930-1-iii@linux.ibm.com>
         <CAEf4BzYvawU4jTKwoUagY0Bn0SYNwcSohb-ZAPq_rLvF5qLamg@mail.gmail.com>
         <YETSLwfibXxelBIN@kernel.org> <YETYtWwSFVMDAnCA@kernel.org>
         <YETaG9CZbrzMNmbh@kernel.org> <YETejOpEPkaP3UU1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-07_17:2021-03-03,2021-03-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 phishscore=0 impostorscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080010
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2021-03-07 at 11:09 -0300, Arnaldo Carvalho de Melo wrote:
> Adding Jiri to the CC list.
> 
> Em Sun, Mar 07, 2021 at 10:50:19AM -0300, Arnaldo Carvalho de Melo
> escreveu:
> > Em Sun, Mar 07, 2021 at 10:44:21AM -0300, Arnaldo Carvalho de Melo
> > escreveu:
> > > Em Sun, Mar 07, 2021 at 10:16:31AM -0300, Arnaldo Carvalho de Melo
> > > escreveu:
> > > > Em Sat, Mar 06, 2021 at 07:16:08PM -0800, Andrii Nakryiko
> > > > escreveu:
> > > > > On Fri, Mar 5, 2021 at 6:22 PM Ilya Leoshkevich
> > > > > <iii@linux.ibm.com> wrote:
> > > > > > 
> > > > > > Some BPF programs compiled on s390 fail to load, because s390
> > > > > > arch-specific linux headers contain float and double types.
> > > > > > 
> > > > > > Fix as follows:
> > > > > > 
> > > > > > - Make DWARF loader fill base_type.float_type.
> > > > > > 
> > > > > > - libbpf introduced support for the floating-point types in
> > > > > > commit
> > > > > >   986962fade5, so update the libbpf submodule to that version
> > > > > > and use
> > > > > >   the new btf__add_float() function in order to emit the
> > > > > > floating-point
> > > > > >   types when base_type.float_type is set.
> > > > > > 
> > > > > > Example of the resulting entry in the vmlinux BTF:
> > > > > > 
> > > > > >     [7164] FLOAT 'double' size=8
> > > 
> > > > > [PATCH dwarves] would make it a bit clearer that this is pahole
> > > > > patch.
> > > 
> > > > > But LGTM.
> > >  
> > > > So older versions of bpftool will fail with a .BTF section having
> > > > this
> > > > new float? I thought it would just skip it emitting a warning?
> > > > Probably
> > > > not possible as we don't have the record size encoded in a
> > > > header,
> > > > right?
> > >  
> > > > [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w FLOAT
> > > > [acme@five pahole]$ type pahole
> > > > pahole is /home/acme/bin/pahole
> > > > [acme@five pahole]$ ls -la ~/bin/pahole
> > > > lrwxrwxrwx. 1 acme acme 34 Jan 29 11:00 /home/acme/bin/pahole ->
> > > > /home/acme/git/pahole/build/pahole
> > > > [acme@five pahole]$ pahole -J vmlinux
> > > > [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w FLOAT
> > > > | head
> > > > Error: failed to load BTF from vmlinux: Invalid argument
> > > > [acme@five pahole]$
> > > > 
> > > > Perhaps the warning emitted by bpftool should suggest updating
> > > > the tool
> > > > as it found a record type it doesn't know about?
> > > > 
> > > > /me goes to update bpftool...
> > > 
> > > Works with the bpftool in bpf-next:
> > > 
> > > [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w FLOAT |
> > > head
> > > [8006] FLOAT 'double' size=8
> > > [acme@five pahole]$
> > 
> > Applied, with this committer notes:
> > 
> > Committer testing:
> > 
> >   $ rm -rf build  # To update the libbpf git submodule
> >   $ mkdir build
> >   $ cd build
> >   $ cmake ..
> >   $ cd ..
> >   $ make -C build
> >   # No BTF_KIND_FLOAT before:
> >   $ bpftool btf dump file vmlinux | grep -w FLOAT
> >   $ type pahole
> >   pahole is /home/acme/bin/pahole
> >   $ ls -la ~/bin/pahole
> >   lrwxrwxrwx. 1 acme acme 34 Jan 29 11:00 /home/acme/bin/pahole ->
> > /home/acme/git/pahole/build/pahole
> >   # Encode BTF:
> >   $ pahole -J vmlinux
> >   $ bpftool btf dump file vmlinux | grep -w FLOAT | head
> >   Error: failed to load BTF from vmlinux: Invalid argument
> >   $
> >   # Update bpftool to what is in bpf-next, then try again:
> >   $ bpftool btf dump file vmlinux | grep -w FLOAT
> >   [8006] FLOAT 'double' size=8
> >   $
> >   # Now check that pahole works well, i.e. that the BTF loader works
> >   $ pahole -F btf vmlinux -C sk_buff_head
> >   struct sk_buff_head {
> >         struct sk_buff *           next;                 /*     0    
> > 8 */
> >         struct sk_buff *           prev;                 /*     8    
> > 8 */
> >         __u32                      qlen;                 /*    16    
> > 4 */
> >         spinlock_t                 lock;                 /*    20    
> > 4 */
> > 
> >         /* size: 24, cachelines: 1, members: 4 */
> >         /* last cacheline: 24 bytes */
> >   };
> >   $
> >   $ pahole -F btf vmlinux  | wc -l
> >   122676
> >   $
> > 
> > Now will build a kernel with this new version, reboot, then push
> > publicly.
> 
> So now trying to build v5.12-rc2 with pahole supporting BTF_KIND_FLOAT:
> 
>   AS      .tmp_vmlinux.kallsyms2.S
>   LD      vmlinux
>   BTFIDS  vmlinux
> FAILED: load BTF from vmlinux: Invalid argument
> make[1]: *** [/home/acme/git/linux/Makefile:1197: vmlinux] Error 255
> make[1]: Leaving directory '/home/acme/git/build/v5.12.0-rc2'
> make: *** [Makefile:215: __sub-make] Error 2
> [acme@five linux]$
> 
> [acme@five linux]$ egrep BTF\|DWARF  ../build/v5.12.0-rc2/.config
> CONFIG_VIDEO_SONY_BTF_MPX=m
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> CONFIG_DEBUG_INFO_BTF=y
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> CONFIG_DEBUG_INFO_BTF_MODULES=y
> [acme@five linux]$
> 
> Ideas?
> 
> - Arnaldo

So v5.12-rc2 does not have this series yet:

https://lore.kernel.org/bpf/20210226202256.116518-1-iii@linux.ibm.com/

pahole generates a BTF_KIND_FLOAT, but libbpf from v5.12-rc2 doesn't 
know how to handle it and resolve_btfids fails.

I guess this is the first time a new BTF kind is added? I checked the
history, and kernel v5.2, which introduced DEBUG_INFO_BTF, already had
BTF_KIND_DATASEC.

So should I add a command-line option to pahole, which would tell it
the desired libbpf compatibility level?

