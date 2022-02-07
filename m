Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C264ABF5D
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 14:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiBGND2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 08:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390519AbiBGLy4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 06:54:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C15EC03FEC4
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 03:52:57 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2179iXa3027612;
        Mon, 7 Feb 2022 11:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=XQ5GG5ya0ejs+jhLIYSwl1NFIKuL8UB9nXHmerXa2Hs=;
 b=FtyzX8JRH3YhgGe4WNzzwVsMEYAsbJRtBEZwloNNOtzzUgpyi1RrLPCpk2Dr3eXPw6Pc
 mtIY8mlR12qZDzdA0X2dYhuwgjB+nZDjxFGcNOuVA025Z+MgUdnlQaFeBJmva7F+qHc2
 G7OVuKnEj0Lnx1b5UE6UhV0a139hZPBZ44mDFKyGaD8dFh+GgUPUUWNCr7sqVeS+bUuW
 BbuaesoHiqioZx7Ww0hexOHJe3dwTqR3oB23hcIuxTkz1k9VBI7vlrJGxPiMQ0oGG60g
 HJFXvaUB2B6nz/MiZBGKiw6ZqjjI3xNooNq5xm78OgonWxN8dpDD8aB8x4kR7dcB2YLJ ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22wh9mms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 11:52:42 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 217B3SYV027677;
        Mon, 7 Feb 2022 11:52:41 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22wh9mkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 11:52:41 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 217BgJd2031333;
        Mon, 7 Feb 2022 11:52:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3e1gghu3mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 11:52:39 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 217BqYTI34930968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Feb 2022 11:52:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8155DA405F;
        Mon,  7 Feb 2022 11:52:34 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E431A4065;
        Mon,  7 Feb 2022 11:52:34 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Feb 2022 11:52:34 +0000 (GMT)
Message-ID: <e01e42fdb43deefacda093ba2e6add680179600f.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 0/2] Fix bpf_perf_event_data ABI breakage
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        bpf <bpf@vger.kernel.org>
Date:   Mon, 07 Feb 2022 12:52:33 +0100
In-Reply-To: <CAEf4BzZfn4-dbnRcsStu+EoKD12EoKCShcoAVH9Gj0mqieBAaw@mail.gmail.com>
References: <20220206145350.2069779-1-iii@linux.ibm.com>
         <CAEf4Bzb1To5+uLdRiJEJUJo4PckVDEBEtENC14Cuf-mkxrnxgA@mail.gmail.com>
         <5e4b012be25cbbb44ecb935de745e17ed5c16f28.camel@linux.ibm.com>
         <CAEf4BzZfn4-dbnRcsStu+EoKD12EoKCShcoAVH9Gj0mqieBAaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wLaUeGmDVmPG_XEJzBpUyIl6sNkzy2-Z
X-Proofpoint-ORIG-GUID: gNd9dxcXQnCkJ2pxvbvopObJ-uD-joVS
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_03,2022-02-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202070072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2022-02-06 at 22:23 -0800, Andrii Nakryiko wrote:
> On Sun, Feb 6, 2022 at 11:57 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > On Sun, 2022-02-06 at 11:31 -0800, Andrii Nakryiko wrote:
> > > On Sun, Feb 6, 2022 at 6:54 AM Ilya Leoshkevich
> > > <iii@linux.ibm.com>
> > > wrote:
> > > > 
> > > > libbpf CI noticed that my recent changes broke
> > > > bpf_perf_event_data
> > > > ABI
> > > > on s390 [1]. Testing shows that they introduced a similar
> > > > breakage
> > > > on
> > > > arm64. The problem is that we are not allowed to extend
> > > > user_pt_regs,
> > > > since it's used by bpf_perf_event_data.
> > > > 
> > > > This series fixes these problems by removing the new members
> > > > and
> > > > introducing user_pt_regs_v2 instead.
> > > > 
> > > > [1] https://github.com/libbpf/libbpf/runs/5079938810
> > > > 
> > > > Ilya Leoshkevich (2):
> > > >   s390/bpf: Introduce user_pt_regs_v2
> > > >   arm64/bpf: Introduce struct user_pt_regs_v2
> > > 
> > > Given it is bpf_perf_event_data and thus bpf_user_pt_regs_t
> > > definitions that are set in stone now, wouldn't it be better to
> > > instead just change
> > > 
> > > typedef user_pt_regs bpf_user_pt_regs_t; (s390x)
> > > typedef struct user_pt_regs bpf_user_pt_regs_t; (arm64)
> > > 
> > > to just define that fixed layout instead of reusing
> > > user_ptr_regs?
> > > 
> > > This whole v2 business looks really ugly.
> > 
> > Wouldn't it break compilation of code like this?
> > 
> >     bpf_perf_event_data data;
> >     user_pt_regs *regs = &data.regs;
> 
> why would it break? user_pt_regs gained extra fields at the end, so
> whoever works with the assumption of an old definition of
> user_pt_regs
> *through pointer* should be totally fine. The problem with
> bpf_perf_event_data is that user_pt_regs are embedded in the struct
> directly, so adding anything to it changes bpf_perf_event_data
> layout.

I meant only building from source, at runtime it should be fine. At
compile time, the compiler should at least warn that pointer types
don't match.

> I, of course, can't know if this breaks any other use case (including
> ones you mentioned below), but using user_pt_regs_v2 will probably
> not
> work with CO-RE, because older kernels won't have such type defined
> (and thus relocations will fail).
> 
> I'm not sure the origins of the need for user_pt_regs (as opposed to
> using pt_regs directly, like x86-64 does), but with CO-RE and
> vmlinux.h it would be more reliable and straightforward to just stick
> to kernel-internal struct pt_regs everywhere. And for non-CO-RE
> macros
> maybe just using an offset within struct pt_regs (i.e.,
> offsetofend(gprs)) would do it?

offsetofend sounds like a nice compromise. I'll give it a try, thanks.

> > 
> > Additionaly, after this I'm no longer sure I haven't missed any
> > other
> > places where user_pt_regs might be used. For example, arm64 seems
> > to be
> > using it not only for BPF, but also for ptrace?
> > 
> > static int gpr_get(struct task_struct *target,
> >                    const struct user_regset *regset,
> >                    struct membuf to)
> > {
> >         struct user_pt_regs *uregs = &task_pt_regs(target)-
> > >user_regs;
> >         return membuf_write(&to, uregs, sizeof(*uregs));
> > }
> > 
> > and then in e.g. gdb:
> > 
> > static void
> > aarch64_fill_gregset (struct regcache *regcache, void *buf)
> > {
> >   struct user_pt_regs *regset = (struct user_pt_regs *) buf;
> >   ...
> > 
> > I'm also not a big fan of the _v2 solution, but it looked the
> > safest
> > to me. At least for s390, a viable alternative that Vasily proposed
> > would be to go ahead with replacing args[1] with orig_gpr2 and then
> > also backporting the patch, so that the new libbpf would still work
> > on
> > the old stable kernels. But this won't work for arm64.

