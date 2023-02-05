Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D223168B138
	for <lists+bpf@lfdr.de>; Sun,  5 Feb 2023 19:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjBESgr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Feb 2023 13:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBESgq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Feb 2023 13:36:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4474F1B546;
        Sun,  5 Feb 2023 10:36:45 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 315HHJLD025946;
        Sun, 5 Feb 2023 18:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NYQvzwIEGGP18UczLcfaIOZwBUQOvmO64ewrslOC+xM=;
 b=bxF8tsOoXVlH+nEsuNcpy9HkbXtUEoNOGPstmV11mmHKHFeMm0H1OFjM+7foDXhnVjh9
 nO2hkMsjidacYxHx993710MEyXQeZt4cFmtn+HAROBNQtKXzJG1KdfrR1hyi5C825bmG
 lwrkGaS2p2qDoz+Vf427cxgO79pc3d0crUUcficyUgPR/rqKNbLO3CoXYnW/2fAaF2ov
 arUcLjzMUwygyM5Kg0AJ43WQH2C8TrxseXG/xpRRIpf7jDEBgGI1MKR30vBx231/0cfU
 K9S593SD2h/UxffnGscpVwlx7kzRUrUA4/PqnAMqowAiYijJ4Va98OlmmmuO3zyyH1jC jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3njfen9ssf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Feb 2023 18:36:21 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 315IaKHc018143;
        Sun, 5 Feb 2023 18:36:20 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3njfen9srq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Feb 2023 18:36:20 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 315Dvi8G005516;
        Sun, 5 Feb 2023 18:36:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3nhf06s4sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Feb 2023 18:36:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 315IaFuQ43188566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 5 Feb 2023 18:36:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F02120043;
        Sun,  5 Feb 2023 18:36:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9241220040;
        Sun,  5 Feb 2023 18:36:14 +0000 (GMT)
Received: from [9.179.9.27] (unknown [9.179.9.27])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun,  5 Feb 2023 18:36:14 +0000 (GMT)
Message-ID: <96db3bf7d0a26b161a9846d8fe492c9bd0cb4c49.camel@linux.ibm.com>
Subject: Re: [PATCHv3 bpf-next 0/9] bpf: Move kernel test kfuncs into
 bpf_testmod
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>, linux-s390@vger.kernel.org
Date:   Sun, 05 Feb 2023 19:36:14 +0100
In-Reply-To: <Y9/yrKZkBK6yzXp+@krava>
References: <20230203162336.608323-1-jolsa@kernel.org>
         <CAADnVQKBYgN5nWG26s0s-U0=PMAWEc17aGWx76GLUc_PM22ZAw@mail.gmail.com>
         <Y9/yrKZkBK6yzXp+@krava>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v0N3VEJ7fvKol2Xe60eu-5bR_oKSLIWP
X-Proofpoint-GUID: hrrwoJ8DrqqWhXwQrYvTuRfFWda-CNSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-05_06,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302050161
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2023-02-05 at 19:17 +0100, Jiri Olsa wrote:
> On Sat, Feb 04, 2023 at 01:21:13AM -0800, Alexei Starovoitov wrote:
> > On Fri, Feb 3, 2023 at 8:23 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >=20
> > > hi,
> > > I noticed several times in discussions that we should move test
> > > kfuncs
> > > into kernel module, now perhaps even more pressing with all the
> > > kfunc
> > > effort. This patchset moves all the test kfuncs into bpf_testmod.
> > >=20
> > > I added bpf_testmod/bpf_testmod_kfunc.h header that is shared
> > > between
> > > bpf_testmod kernel module and BPF programs, which brings some
> > > difficulties
> > > with __ksym define. But I'm not sure having separate headers for
> > > BPF
> > > programs and for kernel module would be better.
> > >=20
> > > This patchset also needs:
> > > =C2=A0 74bc3a5acc82 bpf: Add missing btf_put to
> > > register_btf_id_dtor_kfuncs
> > > which is only in bpf/master now.
> >=20
> > I thought you've added this patch to CI,
> > but cb_refs is still failing on s390...
>=20
> the CI now fails for s390 with messages like:
> =C2=A0=C2=A0 2023-02-04T07:04:32.5185267Z=C2=A0=C2=A0=C2=A0 RES: address =
of kernel function
> bpf_kfunc_call_test_fail1 is out of range
>=20
> so now that we have test kfuncs in the module, the 's32 imm' value of
> the bpf call instructions can overflow when the offset between module
> and kernel is greater than 2GB ... as explained in the commit that
> added the verifier check:
>=20
> =C2=A0 8cbf062a250e bpf: Reject kfunc calls that overflow insn->imm
>=20
> not sure we can do anything about that on bpf side.. cc-ing s390 list
> and Ilya for ideas/thoughts
>=20
> maybe we could make bpf_testmod in-tree module and compile it as
> module
> just for some archs
>=20
> thoughts?

Hi,

I'd rather have this fixed - I guess the problem can affect the users.
The ksyms_module test is already denylisted because of that.
Unfortunately getting the kernel and the modules close together on
s390x is unlikely to happen in the foreseeable future.

What do you think about keeping the BTF ID inside the insn->imm field
and putting the 64-bit delta into bpf_insn_aux_data, replacing the
call_imm field that we already have there?

Best regards,
Ilya

>=20
> thanks,
> jirka

