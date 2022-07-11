Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4175709E9
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiGKSZc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 14:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiGKSZb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 14:25:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32843F32D
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 11:25:30 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BIGgA5026144;
        Mon, 11 Jul 2022 18:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sduFRhSbBGGps1BWDqjvtnLZsk2QS3Nt1I/TXh164aY=;
 b=It9CvKbgmY8vZKrWYYuCXxF3ffWABBW7GeeH825ZOw+MXyoLhgHqKMqAmuee12O7lW6p
 y/tTEWOiEHFm1LO02AsL0yaGWQ2bs64UD+QnKYdPhalGqC4tfAZU/LkIqoW15ziF04Sq
 d9zl8c8mcrGTPzZQ5Eu82B/eLry6OLHcqgezBA6+l62QgFR3giwi9hRCBslewFDGKfiU
 uop+4DIagxa+855fcFKll+1LlUDZdU6zE0s/dGeQHp9ahpqcZcwnphr7R241zt6idbGw
 uLeOmXCr5SfnzVaVkDsx6wCBmf5liNHArDMQZpf9UWR3mw8XVMIHRb7+bBH3Z12V4mOz Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h8s0885fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 18:25:11 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26BIIlIJ030472;
        Mon, 11 Jul 2022 18:25:11 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h8s0885fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 18:25:11 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26BILjOe001532;
        Mon, 11 Jul 2022 18:25:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3h71a8jagp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 18:25:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26BIP6t623986484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 18:25:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BC1852050;
        Mon, 11 Jul 2022 18:25:06 +0000 (GMT)
Received: from [9.171.48.196] (unknown [9.171.48.196])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3535A5204E;
        Mon, 11 Jul 2022 18:25:06 +0000 (GMT)
Message-ID: <cc50280e54d463d5da703e85770c87ede3f2655d.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 0/3] libbpf: add better syscall kprobing
 support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Date:   Mon, 11 Jul 2022 20:25:05 +0200
In-Reply-To: <CAEf4BzaocVmZrdSg4d5xiTeqK+n5ZNUuMso6BW-2x15Wj3rGmQ@mail.gmail.com>
References: <20220707004118.298323-1-andrii@kernel.org>
         <50414987fbd393cde6d28ac9877e9f9b1527cb28.camel@linux.ibm.com>
         <CAEf4BzaocVmZrdSg4d5xiTeqK+n5ZNUuMso6BW-2x15Wj3rGmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b4RnkhQHnxKCJ_9YrrqzElDd2Ta4W2MO
X-Proofpoint-GUID: h6vFvZumwwT-thdzHrrz610PJS3khZb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_23,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207110077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-07-07 at 13:59 -0700, Andrii Nakryiko wrote:
> On Thu, Jul 7, 2022 at 8:51 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > On Wed, 2022-07-06 at 17:41 -0700, Andrii Nakryiko wrote:
> > > This RFC patch set is to gather feedback about new
> > > SEC("ksyscall") and SEC("kretsyscall") section definitions meant
> > > to
> > > simplify
> > > life of BPF users that want to trace Linux syscalls without
> > > having to
> > > know or
> > > care about things like CONFIG_ARCH_HAS_SYSCALL_WRAPPER and
> > > related
> > > arch-specific
> > > vs arch-agnostic __<arch>_sys_xxx vs __se_sys_xxx function names,
> > > calling
> > > convention woes ("nested" pt_regs), etc. All this is quite
> > > annoying
> > > to
> > > remember and care about as BPF user, especially if the goal is to
> > > write
> > > achitecture- and kernel version-agnostic BPF code (e.g., things
> > > like
> > > libbpf-tools, etc).
> > > 
> > > By using SEC("ksyscall/xxx")/SEC("kretsyscall/xxx") user clearly
> > > communicates
> > > the desire to kprobe/kretprobe kernel function that corresponds
> > > to
> > > the
> > > specified syscall. Libbpf will take care of all the details of
> > > determining
> > > correct function name and calling conventions.
> > > 
> > > This patch set also improves BPF_KPROBE_SYSCALL (and renames it
> > > to
> > > BPF_KSYSCALL to match SEC("ksyscall")) macro to take into account
> > > CONFIG_ARCH_HAS_SYSCALL_WRAPPER instead of hard-coding whether
> > > host
> > > architecture is expected to use syscall wrapper or not (which is
> > > less
> > > reliable
> > > and can change over time).
> > > 
> > > It would be great to get feedback about the overall feature, but
> > > also
> > > I'd
> > > appreciate help with testing this, especially for non-x86_64
> > > architectures.
> > > 
> > > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > > Cc: Kenta Tada <kenta.tada@sony.com>
> > > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> > > 
> > > Andrii Nakryiko (3):
> > >   libbpf: improve and rename BPF_KPROBE_SYSCALL
> > >   libbpf: add ksyscall/kretsyscall sections support for syscall
> > > kprobes
> > >   selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in
> > > selftests
> > > 
> > >  tools/lib/bpf/bpf_tracing.h                   |  44 +++++--
> > >  tools/lib/bpf/libbpf.c                        | 109
> > > ++++++++++++++++++
> > >  tools/lib/bpf/libbpf.h                        |  16 +++
> > >  tools/lib/bpf/libbpf.map                      |   1 +
> > >  tools/lib/bpf/libbpf_internal.h               |   2 +
> > >  .../selftests/bpf/progs/bpf_syscall_macro.c   |   6 +-
> > >  .../selftests/bpf/progs/test_attach_probe.c   |   6 +-
> > >  .../selftests/bpf/progs/test_probe_user.c     |  27 +----
> > >  8 files changed, 172 insertions(+), 39 deletions(-)
> > 
> > Hi Andrii,
> > 
> > Looks interesting, I will give it a try on s390x a bit later.
> > 
> > In the meantime just one remark: if we want to create a truly
> > seamless
> > solution, we might need to take care of quirks associated with the
> > following kernel #defines:
> > 
> > * __ARCH_WANT_SYS_OLD_MMAP (real arguments are in memory)
> > * CONFIG_CLONE_BACKWARDS (child_tidptr/tls swapped)
> > * CONFIG_CLONE_BACKWARDS2 (newsp/clone_flags swapped)
> > * CONFIG_CLONE_BACKWARDS3 (extra arg: stack_size)
> > 
> > or at least document that users need to be careful with mmap() and
> > clone() probes. Also, there might be more of that out there, but
> > that's
> > what I'm constantly running into on s390x.
> > 
> 
> Tbh, this space seems so messy, that I don't think it's realistic to
> try to have a completely seamless solution. As I replied to Alexei, I
> didn't have an intention to support compat and 32-bit syscalls, for
> example. This seems to be also a quirk that users will have to
> discover and handle on their own. In my mind there is always plain
> SEC("kprobe") if SEC("ksyscall") gets in a way to handle
> compat/32-bit/quirks like the ones you mentioned.
> 
> But maybe the right answer is just to not add SEC("ksyscall") at all?

I think it's a valuable feature, even if it doesn't handle compat
syscalls and all the other calling convention quirks. IMHO these things
just need to be clearly spelled in the documentation.

In order to keep the possibility to handle them in the future, I would
write something like:

    At the moment SEC("ksyscall") does not handle all the calling
    convention quirks for mmap(), clone() and compat syscalls. This may
    or may not change in the future. Therefore it is recommended to use
    SEC("kprobe") for these syscalls.

What do you think?
