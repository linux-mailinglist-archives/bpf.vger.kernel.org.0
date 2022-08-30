Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38BF5A68BA
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 18:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiH3QtB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiH3Qs7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 12:48:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F278CB943C
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 09:48:58 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UGU7oW032847;
        Tue, 30 Aug 2022 16:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BHYi+b0IRvWUKwAUo2ZsrIK5SUUkorJwUFjV3EePe4A=;
 b=tRdRZs+Y5+RpZQqddqefPnOOrcGHc3NcspUqodSn1F146/SymHR+38X1j1HPkj/nzBZU
 iXAaLR6UT5ZGw3CoLAzY2U5i4p2KanZlYNGA6M9kODPTwCnUzF5Kssbub3l6BFi5ATnC
 qzFFEpxsN3/4QIMPf0kyvVhUGZ/fZBb3C7Y5iiOpfCy7+fnL8V8IKLbnK+gEzpV5guEQ
 +XTzGivX3CxafHRPaN1bEs3Pw1CMiGCPcFFeMQFA8BiQvCIeDP2S+y0K8HqunPru8MQ3
 MVOd3Bh7lHNGDlVtjWvgcRh2AYBXSLZrNLz3i4fWV23bn/LrMmTDLsIU/jpBQgml8gCd qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9p4a0fba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 16:46:24 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27UGW3kk038682;
        Tue, 30 Aug 2022 16:46:24 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9p4a0faf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 16:46:24 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27UGLicb017705;
        Tue, 30 Aug 2022 16:46:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3j7aw9axfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 16:46:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27UGkJ5339846294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 16:46:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 786ACA405C;
        Tue, 30 Aug 2022 16:46:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2AB7A405B;
        Tue, 30 Aug 2022 16:46:18 +0000 (GMT)
Received: from [9.171.5.135] (unknown [9.171.5.135])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 16:46:18 +0000 (GMT)
Message-ID: <480244bd73be4fca57da47801b9135c2b4ad9457.camel@linux.ibm.com>
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
Date:   Tue, 30 Aug 2022 18:46:18 +0200
In-Reply-To: <Yw4VSr7X8hacimrB@krava>
References: <20220826184608.141475-1-jolsa@kernel.org>
         <9099057e-124c-8f30-c29d-54be85eeebfd@iogearbox.net>
         <Yw4VSr7X8hacimrB@krava>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p3_fXXzGntHEHRtdxN2y7pLwC9-fIFwK
X-Proofpoint-ORIG-GUID: C50DECv9sg92C1HRB7UvkcAIarvXEi3-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-08-30 at 15:48 +0200, Jiri Olsa wrote:
> On Tue, Aug 30, 2022 at 12:25:25AM +0200, Daniel Borkmann wrote:
> > On 8/26/22 8:46 PM, Jiri Olsa wrote:
> > > hi,
> > > as discussed [1] sending fix that moves bpf dispatcher function
> > > of out
> > > ftrace locations together with Peter's
> > > HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> > > dependency change.
> > 
> > Looks like the series breaks s390x builds; BPF CI link:
> > 
> > https://github.com/kernel-patches/bpf/runs/8079411784?check_suite_focus=true
> > 
> >   [...]
> >     CC      net/xfrm/xfrm_state.o
> >     CC      net/packet/af_packet.o
> >   {standard input}: Assembler messages:
> >   {standard input}:16055: Error: bad expression
> >   {standard input}:16056: Error: bad expression
> >   {standard input}:16057: Error: bad expression
> >   {standard input}:16058: Error: bad expression
> >   {standard input}:16059: Error: bad expression
> >     CC      drivers/s390/char/raw3270.o
> >     CC      net/ipv6/ip6_output.o
> >   [...]
> >     CC      net/xfrm/xfrm_output.o
> >     CC      net/ipv6/ip6_input.o
> >   {standard input}:16055: Error: invalid operands (*ABS* and *UND*
> > sections) for `%'
> >   {standard input}:16056: Error: invalid operands (*ABS* and *UND*
> > sections) for `%'
> >   {standard input}:16057: Error: invalid operands (*ABS* and *UND*
> > sections) for `%'
> >   {standard input}:16058: Error: invalid operands (*ABS* and *UND*
> > sections) for `%'
> >   {standard input}:16059: Error: invalid operands (*ABS* and *UND*
> > sections) for `%'
> >   make[3]: *** [scripts/Makefile.build:249: net/core/filter.o]
> > Error 1
> >   make[2]: *** [scripts/Makefile.build:465: net/core] Error 2
> >   make[2]: *** Waiting for unfinished jobs....
> >     CC      net/ipv4/tcp_fastopen.o
> >   [...]
> >     CC      lib/percpu-refcount.o
> >   make[1]: *** [Makefile:1855: net] Error 2
> >     CC      lib/rhashtable.o
> >   make[1]: *** Waiting for unfinished jobs....
> >     CC      lib/base64.o
> >   [...]
> >     AR      lib/built-in.a
> >     CC      kernel/kheaders.o
> >     AR      kernel/built-in.a
> >   make: *** [Makefile:353: __build_one_by_one] Error 2
> >   Error: Process completed with exit code 2.
> 
> 
> it does not break on my cross build with gcc 12, but I can
> reproduce with gcc 8 (CI seems to be on gcc 9)
> 
> the problem seems to be wrong assembler code with extra '%'
> that's generated for patchable_function_entry(5)
> 
> gcc 8 generates:
> 
> .LPFE1:
>         nopr    %%r0
>         nopr    %%r0
>         nopr    %%r0
>         nopr    %%r0
>         nopr    %%r0
> 
> and gcc 12 generates:
> 
> .LPFE1:
>         nopr    %r0
>         nopr    %r0
>         nopr    %r0
>         nopr    %r0
>         nopr    %r0
> 
> perhaps we need to upgrade gcc in CI? cc-ing Ilya, any idea?
> 
> thanks,
> jirka

It's not obvious to me which gcc commit fixed this; I will bisect and
find out. This will take some time.

However, officially, the kernel must be buildable by gcc 5.1+.
Whatever I find, it's unlikely that we'll be able to backport it
that far.

Therefore I think we need to find a way to conditionally
do something else when using broken gccs. Or maybe just keep this
x86-only after all.

Best regards,
Ilya
