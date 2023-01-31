Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C6F682E18
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 14:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjAaNhC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 08:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjAaNhB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 08:37:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03B7EB56
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 05:37:00 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VCGHwA011815;
        Tue, 31 Jan 2023 13:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Z6lN0stkJp9UKLboMWKyNyOC8kZh/0mLr+XfyolVvmM=;
 b=kfyoXgqvgZqdSIE+w28GyCOSRoK6dN9j9t/7oSKUOpfCrpxGHrPnumBx8SkLHWB6Y+7J
 KZ7kjGNIeIabF5TFvJA5ZXMZxDDHFufup8JK0S2S1VfaCPe90/klxnHJMxYebx9Q9oZh
 Kt+2GCgJcjOrRBVel3QUWYQXl7ceA2NSr+lxv4OHNT+V8qFu48VrM+kCApKuYxbfdUuA
 tBb9Y8PIAiJIdaaQB/bXA1tApkOn0pA4F4PsA8Tic802/RR2q2qJ6voK882bNAJ/LPMw
 3JuQy8vWBApQCsfyig3NS2CfM7yUaSMGXkE3Toi37Aq4cR+hifQ50u76z2p+FSp4jHq/ TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf2ug1xqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 13:36:45 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VCvtmj016519;
        Tue, 31 Jan 2023 13:36:45 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf2ug1xpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 13:36:45 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30UGNBWR018390;
        Tue, 31 Jan 2023 13:36:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3ndn6u9t4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 13:36:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VDadqg48234962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 13:36:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B47402004B;
        Tue, 31 Jan 2023 13:36:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65EDE20040;
        Tue, 31 Jan 2023 13:36:39 +0000 (GMT)
Received: from [9.155.209.149] (unknown [9.155.209.149])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 13:36:39 +0000 (GMT)
Message-ID: <bdb3f8f0d81c0c2c05fc8003beda2f351ce1a504.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 0/8] Support bpf trampoline for s390x - CI
 issue
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Date:   Tue, 31 Jan 2023 14:36:39 +0100
In-Reply-To: <CAADnVQ+f3_AdYjvOCHystXe1vEmXzpABbLzU4tLZD7Wuu1CCgA@mail.gmail.com>
References: <20230129190501.1624747-1-iii@linux.ibm.com>
         <CAADnVQL4Kmk-Hz5XB_AiVC+xVBhVvBqBZTTtedAJC5op2xGD6g@mail.gmail.com>
         <32bf5c1fc3dcfcf735f34f83e89cbb821878b931.camel@linux.ibm.com>
         <CAADnVQ+f3_AdYjvOCHystXe1vEmXzpABbLzU4tLZD7Wuu1CCgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3bRFnSOhWOd8cjpG2XP9CeyD6CpC_K_v
X-Proofpoint-GUID: NK7z2uZODIHot-aAxXXubzCFT2A1Kvmx
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-01-30 at 19:13 -0800, Alexei Starovoitov wrote:
> On Mon, Jan 30, 2023 at 10:56 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > On Sun, 2023-01-29 at 19:28 -0800, Alexei Starovoitov wrote:
> > > On Sun, Jan 29, 2023 at 11:05 AM Ilya Leoshkevich
> > > <iii@linux.ibm.com>
> > > wrote:
> > > >=20
> > > > v2:
> > > > https://lore.kernel.org/bpf/20230128000650.1516334-1-iii@linux.ibm.=
com/#t
> > > > v2 -> v3:
> > > > - Make __arch_prepare_bpf_trampoline static.
> > > > =C2=A0 (Reported-by: kernel test robot <lkp@intel.com>)
> > > > - Support both old- and new- style map definitions in
> > > > sk_assign.
> > > > (Alexei)
> > > > - Trim DENYLIST.s390x. (Alexei)
> > > > - Adjust s390x vmlinux path in vmtest.sh.
> > > > - Drop merged fixes.
> > >=20
> > > It looks great. Applied.
> > >=20
> > > Sadly clang repo is unreliable today. I've kicked BPF CI multiple
> > > times,
> > > but it didn't manage to fetch the clang. Pushed anyway.
> > > Pls watch for BPF CI failures in future runs.
> >=20
> > I think this is because llvm-toolchain-focal contains llvm 17 now.
> > So we need to either use llvm-toolchain-focal-16, or set
> > llvm_default_version=3D16 in libbpf/ci.
>=20
> Yep. That was fixed.
> Looks like only one test is failing on s390:
> test_synproxy:PASS:./xdp_synproxy --iface tmp1 --single 0 nsec
> expect_str:FAIL:SYNACKs after connection unexpected SYNACKs after
> connection: actual '' !=3D expected 'Total SYNACKs generated: 1\x0A'
>=20
> #284/1 xdp_synproxy/xdp:FAIL
> #284 xdp_synproxy:FAIL
> Summary: 260/1530 PASSED, 31 SKIPPED, 1 FAILED

Thanks! Where do you see the xdp_synproxy failure? I checked the jobs
at [1] and rather see two migrate_reuseport failures ([2], [3]):

  count_requests:FAIL:count in BPF prog unexpected count in BPF prog:
actual 10 !=3D expected 25
  #127/7   migrate_reuseport/IPv6 TCP_NEW_SYN_RECV
reqsk_timer_handler:FAIL

  count_requests:FAIL:count in BPF prog unexpected count in BPF prog:
actual 14 !=3D expected 25
  #127/4   migrate_reuseport/IPv4 TCP_NEW_SYN_RECV
inet_csk_complete_hashdance:FAIL

I tried running vmtest.sh in a loop, and could not reproduce neither
the xdp_synproxy nor the migrate_reuseport failure.

In migrate_reuseport, from the userspace perspective everything works,
(count_requests:PASS:count in userspace 0 nsec). This means that we
always get to the bpf_sk_select_reuseport() call and it succeeds.
The eBPF program still records at least some migrations while the
connection is in the TCP_NEW_SYN_RECV state, so I wonder if other
migrations, for whatever reason, happen in a different state?

[1] https://github.com/libbpf/libbpf/actions/workflows/test.yml
[2]
https://github.com/libbpf/libbpf/actions/runs/4049227053/jobs/6965361085#st=
ep:30:8908
[3]
https://github.com/libbpf/libbpf/actions/runs/4049783307/jobs/6966526594#st=
ep:30:8911
