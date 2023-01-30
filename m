Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF7E6819B9
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 19:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbjA3S4s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 13:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjA3S4r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 13:56:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC2D2B094
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 10:56:47 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UImtoG007690;
        Mon, 30 Jan 2023 18:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9KlxGs55Qbygkb4pc9bfp2PVeitMQYvqt8YCCfiJ8Tw=;
 b=Zqmfe4lZ02IMnxNpZyggHKZK2LmT6pC9oUb9G1E4+AaVJFLGCAYc6xgmw0xi450ZH3F6
 RA7TnReud21uzpf18Hr/HFfqofjcSVWwMcQ1WfbI2e8je8Vg2DSYQuEmG26Fz7liFWHN
 zJATyAA6gihyFzyAvkS5ag1C+tSFI5oKYTjOEdVoG28zfFOd7NoKTaEuQCfWTSqWHyUP
 5eQIOnmX7BlzZENCLhAjlUK5eLGHeoREhjasiA9g585DinsHuJxP8fLFlQlPxVlY+QJs
 uo3hR3XtisAZBpSQzx7ft8JwGjh5WxW/+Vs0FlELh1BSq8ATeQX26fCIUtDomiAbW0NZ vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nekgm05rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 18:56:32 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30UIo0rf010767;
        Mon, 30 Jan 2023 18:56:32 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nekgm05qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 18:56:32 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30U1scxx004065;
        Mon, 30 Jan 2023 18:56:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ncvv69ury-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 18:56:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UIuQ1l32571768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 18:56:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 311F720040;
        Mon, 30 Jan 2023 18:56:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D96820049;
        Mon, 30 Jan 2023 18:56:25 +0000 (GMT)
Received: from [9.171.65.104] (unknown [9.171.65.104])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 18:56:25 +0000 (GMT)
Message-ID: <32bf5c1fc3dcfcf735f34f83e89cbb821878b931.camel@linux.ibm.com>
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
        Manu Bretelle <chantr4@gmail.com>
Date:   Mon, 30 Jan 2023 19:56:25 +0100
In-Reply-To: <CAADnVQL4Kmk-Hz5XB_AiVC+xVBhVvBqBZTTtedAJC5op2xGD6g@mail.gmail.com>
References: <20230129190501.1624747-1-iii@linux.ibm.com>
         <CAADnVQL4Kmk-Hz5XB_AiVC+xVBhVvBqBZTTtedAJC5op2xGD6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f-NPs1EPSrwxooHkWp_1Amtz_R1sxx-G
X-Proofpoint-GUID: OtfgW3VRMyuOQa5jZtrWdy1vIJn5KRfL
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=815
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300177
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2023-01-29 at 19:28 -0800, Alexei Starovoitov wrote:
> On Sun, Jan 29, 2023 at 11:05 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > v2:
> > https://lore.kernel.org/bpf/20230128000650.1516334-1-iii@linux.ibm.com/=
#t
> > v2 -> v3:
> > - Make __arch_prepare_bpf_trampoline static.
> > =C2=A0 (Reported-by: kernel test robot <lkp@intel.com>)
> > - Support both old- and new- style map definitions in sk_assign.
> > (Alexei)
> > - Trim DENYLIST.s390x. (Alexei)
> > - Adjust s390x vmlinux path in vmtest.sh.
> > - Drop merged fixes.
>=20
> It looks great. Applied.
>=20
> Sadly clang repo is unreliable today. I've kicked BPF CI multiple
> times,
> but it didn't manage to fetch the clang. Pushed anyway.
> Pls watch for BPF CI failures in future runs.

I think this is because llvm-toolchain-focal contains llvm 17 now.
So we need to either use llvm-toolchain-focal-16, or set
llvm_default_version=3D16 in libbpf/ci.
