Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5F066C421
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 16:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjAPPk1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 10:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAPPkW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 10:40:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6027717151
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 07:40:13 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30GF7oUT028557;
        Mon, 16 Jan 2023 15:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4enlayALZMnS25U7WMoE/VvWSKiqFp+0hZ49bOrGZic=;
 b=PmbtiFDGsmQcsPq/LovDTGTVjPOU34OHnRo10hX1/9dGlpuN/olpw2N0YVPyZ3X3Pr3f
 fIuPFdLkMI00/jPGotCZ3sL+AnVaHavDxhqUabXIYidrSNyos11gyisV+mJVqng9sN3d
 HWmu+m+uAA2OT1Z/vPlUDwmpAj/whs6OuJS2h9ZAodd3OTWm1+S41zSFZwvsAgM5I/8p
 R3Zpgu+YUbflNem2XPkUrP0vLn3wGc6wpMIkrxt1KGMbiyD5f2syPh+cRdhNXAT8ctKa
 OXR/gkoNI/ATXG4wQ3145AdcMZvPCvduAiDlDiqEsQ+3VQc5AR1KHQvwkq9tYVLxz2MG gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n56qt48fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 15:39:42 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30GF81Vh029183;
        Mon, 16 Jan 2023 15:39:42 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n56qt48eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 15:39:41 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30GFbHZo025842;
        Mon, 16 Jan 2023 15:39:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n3m16hwdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 15:39:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30GFdaUj47382906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 15:39:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC2072004D;
        Mon, 16 Jan 2023 15:39:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E61D320043;
        Mon, 16 Jan 2023 15:39:35 +0000 (GMT)
Received: from [9.171.43.41] (unknown [9.171.43.41])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jan 2023 15:39:35 +0000 (GMT)
Message-ID: <32e687a289caa088306c088f5f41b2a0081fac04.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 00/25] libbpf: extend [ku]probe and syscall
 argument tracing support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Pu Lehui <pulehui@huawei.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Vladimir Isaev <isaev@synopsys.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Kenta Tada <Kenta.Tada@sony.com>,
        Florent Revest <revest@chromium.org>
Date:   Mon, 16 Jan 2023 16:39:35 +0100
In-Reply-To: <6baf4921-9d97-e90c-55b4-40b41b1bec61@oracle.com>
References: <20230113083404.4015489-1-andrii@kernel.org>
         <6baf4921-9d97-e90c-55b4-40b41b1bec61@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qj7m9HXs0kpzipX7VT754BsKqU-e2eFv
X-Proofpoint-ORIG-GUID: MQEAQsH7gCwLFglE95Dw_tqSWqkTyanC
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_13,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-01-16 at 15:10 +0000, Alan Maguire wrote:
> On 13/01/2023 08:33, Andrii Nakryiko wrote:
> > This patch set fixes and extends libbpf's bpf_tracing.h support for
> > tracing
> > arguments of kprobes/uprobes, and syscall as a special case.
> >=20
> > Depending on the architecture, anywhere between 3 and 8 arguments
> > can be
> > passed to a function in registers (so relevant to kprobes and
> > uprobes), but
> > before this patch set libbpf's macros in bpf_tracing.h only
> > supported up to
> > 5 arguments, which is limiting in practice. This patch set extends
> > bpf_tracing.h to support up to 8 arguments, if architecture allows.
> > This
> > includes explicit PT_REGS_PARMx() macro family, as well as
> > BPF_KPROBE() macro.
> >=20
> > Now, with tracing syscall arguments situation is sometimes quite
> > different.
> > For a lot of architectures syscall argument passing through
> > registers differs
> > from function call sequence at least a little. For i386 it differs
> > *a lot*.
> > This patch set addresses this issue across all currently supported
> > architectures and hopefully fixes existing issues. syscall(2)
> > manpage defines
> > that either 6 or 7 arguments can be supported, depending on
> > architecture, so
> > libbpf defines 6 or 7 registers per architecture to be used to
> > fetch syscall
> > arguments.
> >=20
> > Also, BPF_UPROBE and BPF_URETPROBE are introduced as part of this
> > patch set.
> > They are aliases for BPF_KPROBE and BPF_KRETPROBE (as mechanics of
> > argument
> > fetching of kernel functions and user-space functions are
> > identical), but it
> > allows BPF users to have less confusing BPF-side code when working
> > with
> > uprobes.
> >=20
> > For both sets of changes selftests are extended to test these new
> > register
> > definitions to architecture-defined limits. Unfortunately I don't
> > have ability
> > to test it on all architectures, and BPF CI only tests 3
> > architecture (x86-64,
> > arm64, and s390x), so it would be greatly appreciated if CC'ed
> > people can help
> > review and test changes on architectures they are familiar with
> > (and maybe
> > have direct access to for testing). Thank you.
> >=20
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > Cc: Pu Lehui <pulehui@huawei.com>
> > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> > Cc: Vladimir Isaev <isaev@synopsys.com>
> > Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > Cc: Kenta Tada <Kenta.Tada@sony.com>
> > Cc: Florent Revest <revest@chromium.org>
> >=20
>=20
> This is fantastic, a huge step forward!
>=20
> For the series (tested on aarch64):
>=20
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> =C2=A0
> One question - I couldn't parse the s390x documentation (or find
> anything else) which stated the function calling conventions for
> that platform. Currently we support 5 register function call args
> for s390x - is that the right number?

Hi,

you can find the s390x ABI documentation here:

https://github.com/IBM/s390x-abi/releases/download/v1.6/lzsabi_s390x.pdf

It's indeed 5 registers for normal calls: %r2-%r6.
The other arguments are passed on stack (*(long *)(%r15 + 160), etc).

For syscalls it's 6: %r2-%r7. That is specified in man 2 syscall.

Best regards,
Ilya
