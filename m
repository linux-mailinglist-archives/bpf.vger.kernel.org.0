Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644145A71F9
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 01:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiH3Xqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 19:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiH3Xqj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 19:46:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E02E6714A
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 16:46:38 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UNP5ao022328;
        Tue, 30 Aug 2022 23:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6VS+8g1c5yTm86V6Z7geIOOiHYrPAHYNrOHK8UBI4wc=;
 b=baytaV9dHIHFOy2JLXdqHI7kFQbgiRdZN9DBQBTrUMCwoHfn+Ube7Ge76nVuHTJ4I0c/
 t7PkK7rpHxcq60BSgoF95mb7Y357XP01OH2Z4vP98PHyJ7L3WfrgLcoB4QfK39lTnrJ8
 Usc2DYO67xDZ89l05wYkZPdnlNmGqKHZ8ua2lfy3nypMP08lWRQofjv7+Kov/dIjLuMl
 cJXM7khtOABpAyOroqNi8Q9xCYeC7kffV532ynF5BAK6zQErAAAPV4GoRC2gDbsGotiy
 Xa+/oXkmRs8cRJvU+ZASVhswwfusR/j39GWORetLszlQLiEFkPYYnXNqPvD7EENZpB4L kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9v70rchh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 23:46:15 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27UNSR0M032387;
        Tue, 30 Aug 2022 23:46:15 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9v70rcgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 23:46:14 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27UNa7p1023142;
        Tue, 30 Aug 2022 23:46:13 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3j7ahhu6yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 23:46:13 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27UNkAMH41615830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 23:46:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8CE3A4053;
        Tue, 30 Aug 2022 23:46:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED012A4040;
        Tue, 30 Aug 2022 23:46:09 +0000 (GMT)
Received: from [9.171.5.135] (unknown [9.171.5.135])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 23:46:09 +0000 (GMT)
Message-ID: <969a14281a7791c334d476825863ee449964dd0c.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 0/2] bpf,ftrace: bpf dispatcher function fix
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jiri Olsa <olsajiri@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Date:   Wed, 31 Aug 2022 01:46:09 +0200
In-Reply-To: <480244bd73be4fca57da47801b9135c2b4ad9457.camel@linux.ibm.com>
References: <20220826184608.141475-1-jolsa@kernel.org>
         <9099057e-124c-8f30-c29d-54be85eeebfd@iogearbox.net>
         <Yw4VSr7X8hacimrB@krava>
         <480244bd73be4fca57da47801b9135c2b4ad9457.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HcIwAdRKMjaHr7gimuAwuDpe33CTcnM6
X-Proofpoint-ORIG-GUID: Q3fkXRtutWAaKZjOkovqd3u5PubWCAHl
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-08-30 at 18:46 +0200, Ilya Leoshkevich wrote:
> On Tue, 2022-08-30 at 15:48 +0200, Jiri Olsa wrote:
> > On Tue, Aug 30, 2022 at 12:25:25AM +0200, Daniel Borkmann wrote:
> > > On 8/26/22 8:46 PM, Jiri Olsa wrote:
> > > > hi,
> > > > as discussed [1] sending fix that moves bpf dispatcher function
> > > > of out
> > > > ftrace locations together with Peter's
> > > > HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> > > > dependency change.
> > > 
> > > Looks like the series breaks s390x builds; BPF CI link:
> > > 
> > > https://github.com/kernel-patches/bpf/runs/8079411784?check_suite_focus=true
> > > 
> > >   [...]
> > >     CC      net/xfrm/xfrm_state.o
> > >     CC      net/packet/af_packet.o
> > >   {standard input}: Assembler messages:
> > >   {standard input}:16055: Error: bad expression
> > >   {standard input}:16056: Error: bad expression
> > >   {standard input}:16057: Error: bad expression
> > >   {standard input}:16058: Error: bad expression
> > >   {standard input}:16059: Error: bad expression
> > >     CC      drivers/s390/char/raw3270.o
> > >     CC      net/ipv6/ip6_output.o
> > >   [...]
> > >     CC      net/xfrm/xfrm_output.o
> > >     CC      net/ipv6/ip6_input.o
> > >   {standard input}:16055: Error: invalid operands (*ABS* and
> > > *UND*
> > > sections) for `%'
> > >   {standard input}:16056: Error: invalid operands (*ABS* and
> > > *UND*
> > > sections) for `%'
> > >   {standard input}:16057: Error: invalid operands (*ABS* and
> > > *UND*
> > > sections) for `%'
> > >   {standard input}:16058: Error: invalid operands (*ABS* and
> > > *UND*
> > > sections) for `%'
> > >   {standard input}:16059: Error: invalid operands (*ABS* and
> > > *UND*
> > > sections) for `%'
> > >   make[3]: *** [scripts/Makefile.build:249: net/core/filter.o]
> > > Error 1
> > >   make[2]: *** [scripts/Makefile.build:465: net/core] Error 2
> > >   make[2]: *** Waiting for unfinished jobs....
> > >     CC      net/ipv4/tcp_fastopen.o
> > >   [...]
> > >     CC      lib/percpu-refcount.o
> > >   make[1]: *** [Makefile:1855: net] Error 2
> > >     CC      lib/rhashtable.o
> > >   make[1]: *** Waiting for unfinished jobs....
> > >     CC      lib/base64.o
> > >   [...]
> > >     AR      lib/built-in.a
> > >     CC      kernel/kheaders.o
> > >     AR      kernel/built-in.a
> > >   make: *** [Makefile:353: __build_one_by_one] Error 2
> > >   Error: Process completed with exit code 2.
> > 
> > 
> > it does not break on my cross build with gcc 12, but I can
> > reproduce with gcc 8 (CI seems to be on gcc 9)
> > 
> > the problem seems to be wrong assembler code with extra '%'
> > that's generated for patchable_function_entry(5)
> > 
> > gcc 8 generates:
> > 
> > .LPFE1:
> >         nopr    %%r0
> >         nopr    %%r0
> >         nopr    %%r0
> >         nopr    %%r0
> >         nopr    %%r0
> > 
> > and gcc 12 generates:
> > 
> > .LPFE1:
> >         nopr    %r0
> >         nopr    %r0
> >         nopr    %r0
> >         nopr    %r0
> >         nopr    %r0
> > 
> > perhaps we need to upgrade gcc in CI? cc-ing Ilya, any idea?
> > 
> > thanks,
> > jirka
> 
> It's not obvious to me which gcc commit fixed this; I will bisect and
> find out. This will take some time.
> 
> However, officially, the kernel must be buildable by gcc 5.1+.
> Whatever I find, it's unlikely that we'll be able to backport it
> that far.
> 
> Therefore I think we need to find a way to conditionally
> do something else when using broken gccs. Or maybe just keep this
> x86-only after all.
> 
> Best regards,
> Ilya

FWIW, bisect points to

https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=45d06a4045bebc3dbaaf0b1c676f4e22b7c6aca1

which makes perfect sense. Still, as I mentioned above, it's probably
worth tolerating brokens gccs instead of spending time backporting this
everywhere. And upgrading the CI machine will only paper over the
issue.

At a closer look, it looks weird to me that we have
patchable_function_entry(5) in a common header. If this optimization
is ever implemented for another architecture, a different number will
be required.

For simplicity, would it make sense to hide this under an #ifdef?
Something like this (untested):

#ifdef CONFIG_X86
#define BPF_DISPATCHER_ATTRIBUTES
__attribute__((patchable_function_entry(5)))
#else
#define BPF_DISPATCHER_ATTRIBUTES
#endif

Best regards,
Ilya
