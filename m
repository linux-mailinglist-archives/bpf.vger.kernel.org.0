Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20BB1A4C5A
	for <lists+bpf@lfdr.de>; Sat, 11 Apr 2020 00:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDJW55 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Apr 2020 18:57:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726582AbgDJW55 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Apr 2020 18:57:57 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AMoxAb002853;
        Fri, 10 Apr 2020 15:57:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=aAbJPsMVKu6feH5ZR1esfVwBBs2DIA4txRGoltw1fhQ=;
 b=WU586HqyxJtrKME+hkqCi1G7zP6Ws43RNtHKrD5mwB6FwitdxTBVKOufNND8TUnt2jRx
 GRwd6YVh5LxTVqfyvfXLOwY+vey+yY5CtKIpYEhfGHvVdtW8g1SsTNEMZcHVp+Wwkjir
 rMC80/WjCg1D3RiqTwjjG0J9U5rLDYUOPHs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30aur3a6qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Apr 2020 15:57:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 10 Apr 2020 15:57:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWYCLdvxOFacUvtkyZtElu4iXjepe4qCevgIkBO/gWDTb/R1wF9+JgMUmXvCAnQGUG1bqkOBIrSMpHw/zFQP4LI8YnoHCtZG7+sXqaHt+fFIxzJ1Vr//m7W/fc3MelzLWdF2TQUFZ10Dx10Zvgg87omy6dqx2tCZmZPpesudW3ygfhduyYwaYypCYiwureVVYC7nrBb6IfNyaUBHf/2Kq7THJt8Ar4u5GpdmfEY/WGqGnrF3FOkOz/6MMzL4oiC/i4ErGb3dpEpEVCGeB+LBJjMW0q8ohlkLXrhWKh+Cte+ptN5GDpMVJQPXasb5hx58TUIPKh61mbx2W0dNQ/4h+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAbJPsMVKu6feH5ZR1esfVwBBs2DIA4txRGoltw1fhQ=;
 b=YnKW3tvgf/xl4xX4InWh4awGS7ho8BzUsbfmlsGGE8YuKo6PeRXR9aDM9fWdiEByrriEiSe04IGh4N0664YwXXQ7/CiQqx1udci0o2jfnkD2AYCfPxfwja8zCuDjViD/2Q0bdxsO3VxC3i5iKV6FZ0lOeqsGf32iMwLGF2tTx8DKwY+dBmNA+X7PsKgrU0KRetldngOLpCJnfkdnSbb5VCP5O7DyFIj4gHPmYZ6rUZeo/STcBiID8TYIlpDeZAjJ1eMwTTQfi5S8Znq0xMuWkHUFErkNdVWZ4CfaMjj5nSU+iCmrVXled2FUNmHETxNfi5DTr+q6mLnosJjQcPc9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAbJPsMVKu6feH5ZR1esfVwBBs2DIA4txRGoltw1fhQ=;
 b=EcYuPYIH0uY8Wwv33Nqx+WtpbZz6qtMQPN/vk4fIFfYZKM9a+RzLRCAf0FlqCndVvRMicOG52XNdqaOshAWFwHK4/Wscq7pQZRgGQedwSuq+7CUHne3S5e8yF9yZFwA/FSiiSL7LQrpopjMcRjcKXrMhSulkhWwsie0E2O/PwgU=
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB2839.namprd15.prod.outlook.com (2603:10b6:a03:fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.18; Fri, 10 Apr
 2020 22:57:42 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::90d6:ec75:fde:e992]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::90d6:ec75:fde:e992%7]) with mapi id 15.20.2878.023; Fri, 10 Apr 2020
 22:57:42 +0000
Date:   Fri, 10 Apr 2020 15:57:39 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf 1/2] libbpf: Fix loading cgroup_skb/egress with ret
 in [2, 3]
Message-ID: <20200410225739.GA95636@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1586547735.git.rdna@fb.com>
 <daa546903aa74cf844452b7f80788d67c15b42ea.1586547735.git.rdna@fb.com>
 <CAEf4BzYvPawqgdP+cU94+US=hKGaD8qCBFtnu_JZae3eJ0+SUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzYvPawqgdP+cU94+US=hKGaD8qCBFtnu_JZae3eJ0+SUw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: MWHPR01CA0027.prod.exchangelabs.com (2603:10b6:300:101::13)
 To BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:c982) by MWHPR01CA0027.prod.exchangelabs.com (2603:10b6:300:101::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Fri, 10 Apr 2020 22:57:41 +0000
X-Originating-IP: [2620:10d:c090:400::5:c982]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d18277d-edb5-4b70-f64d-08d7dda29302
X-MS-TrafficTypeDiagnostic: BYAPR15MB2839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2839FE1831ABE2283FB23C22A8DE0@BYAPR15MB2839.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(366004)(376002)(346002)(39860400002)(5660300002)(4326008)(6486002)(66476007)(66946007)(1076003)(8936002)(8676002)(81156014)(66556008)(9686003)(2906002)(16526019)(186003)(6916009)(478600001)(316002)(53546011)(86362001)(54906003)(52116002)(6496006)(33656002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXvOVYO1zRATLafHJQ3sqIy0H+jPREaKEHwBw5TFq7bQdlVUErMbV4wLTttq5Eoi416CSf0l2bS9tmCXf62AsZ/JU5kpzV5fr18YhqikPLaWvZXe+JdzVvZHDRfJr+jZW7px/EWHlr4v3ZCGGuRFxV/dkkWWF4vQPATtR2ghK3n5wYCMWRh90MGnEzcEUZzMv3aOCVk1RpBA8JilZUO739gUX0i0si0O6H+Rm5NWDzhPnfcWiTLw3GVvEIHP2ROrDKJsU93EdyGfeAQrbJqUC8EBxNZkDsPSlyWkrPQPHFs3bs016H4bt0jfJWi9qHrpXYcNyDsymsyPPkk3jvk7CI+bOQYqkJsBbzUkJ7WdEXHvaqqTaFognWCn4Y9BUTWD+3oYgtMNjr1R/MNpjsbIPwQJnwkH+/OrQA1MDPprEaQ7yW6Ee//q879uIGABCjr5
X-MS-Exchange-AntiSpam-MessageData: SdcmUckIPaPsXA5IEPk5u20TzrATtD8Ie5vmSNWoa7+5H9mwloICJruC7Po1s3wipMuKCFMsM6pv0MT2aB6AfKqryT9+Sf7i63GzPgbGZEiWn0KEVC3LdcPMbM6vrBKwCP29uheKLnhaXHk3gdk5U/OY4ovSa/3Q4LBuPKh9qwJrZBn1rABtbwaT9jEM33c2
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d18277d-edb5-4b70-f64d-08d7dda29302
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 22:57:41.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkxXjWvmKJvUfMcUnpk0CMMw44LP2akrTv5eUi2xu3HPy8OlY1bhnYz1kiSERGZ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2839
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_10:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100161
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> [Fri, 2020-04-10 13:39 -0700]:
> On Fri, Apr 10, 2020 at 12:54 PM Andrey Ignatov <rdna@fb.com> wrote:
> >
> > Initially BPF_CGROUP_INET_EGRESS hook didn't require specifying
> > expected_attach_type at loading time, but commit
> >
> >   5cf1e9145630 ("bpf: cgroup inet skb programs can return 0 to 3")
> >
> > changed it so that expected_attach_type must be specified if program can
> > return either 2 or 3 (before it was either 0 or 1) to communicate
> > congestion notification to caller.
> >
> > At the same time loading w/o expected_attach_type is still supported for
> > backward compatibility if program retval is in tnum_range(0, 1).
> >
> > Though libbpf currently supports guessing prog/attach/expected_attach
> > types only for "old" mode (retval in [0; 1]). And if cgroup_skb egress
> > program stars returning e.g. 2 (corresponds to NET_XMIT_CN), then
> > guessing breaks and, e.g. bpftool can't load an object with such a
> > program anymore:
> >
> >   # bpftool prog loadall tools/testing/selftests/bpf/test_skb.o /sys/fs/bpf/test_skb
> >   libbpf: load bpf program failed: Invalid argument
> >   libbpf: -- BEGIN DUMP LOG ---
> >   libbpf:
> >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> >   0: (85) call pc+5
> >
> >    ... skip ...
> >
> >   from 87 to 1: R0_w=invP2 R10=fp0
> >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> >   1: (bc) w1 = w0
> >   2: (b4) w0 = 1
> >   3: (16) if w1 == 0x0 goto pc+1
> >   4: (b4) w0 = 2
> >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> >   5: (95) exit
> >   At program exit the register R0 has value (0x2; 0x0) should have been in (0x0; 0x1)
> >   processed 96 insns (limit 1000000) max_states_per_insn 1 total_states 10 peak_states 10 mark_read 2
> >
> >   libbpf: -- END LOG --
> >   libbpf: failed to load program 'cgroup_skb/egress'
> >   libbpf: failed to load object 'tools/testing/selftests/bpf/test_skb.o'
> >   Error: failed to load object file
> >
> > Fix it by introducing another entry in libbpf section_defs that makes the load
> > happens with expected_attach_type: cgroup_skb/egress/expected
> >
> > That name may not be ideal, but I don't have a better option.
> 
> That's a really bad name :) But maybe instead of having another
> section_def, turn existing section def into the one that does specify
> expected_attach_type?

Unfortunately, unless I'm missing something, it'll break loading on
older kernels.

Specifically before commit 5e43f899b03a ("bpf: Check attach type at prog
load time") BPF_PROG_LOAD_LAST_FIELD was prog_ifindex what means that on
kernels before that commit all bytes in bpf_attr have to be zero at
loading time, otherwise the check in bpf_prog_load:

	if (CHECK_ATTR(BPF_PROG_LOAD))
		return -EINVAL;

will fail. If libbpf starts loading with expected_attach_type set on
those kernels, that load will fail.

That's why I didn't converted existing BPF_APROG_SEC to BPF_EAPROG_SEC.

> Seems like kernels accept expected_attach_type
> for a while now, so it might be ok backwards compatibility-wise?

Sure, that commit is from 2018, but I guess backward compatibility
should still be maintained in this case? That's a question to
maintainers though. If simply changing BPF_APROG_SEC to BPF_EAPROG_SEC
is an option that works for me.


> Otherwise, we can teach libbpf to retry program load without expected
> attach type for cgroup_skb/egress?

Looks like a lot of work compared to simply adding a new section name
(or changing existing section if backward compatibility is not a concern
here).

But that work may work may outweigh inconvenience on user side so no
strong preferences. If this is what you were going to do anyway, that
may work as well.


> > Strictly speaking this is not a fix but rather a missing feature, that's
> > why there is no Fixes tag. But it still seems to be a good idea to merge
> > it to stable tree to fix loading programs that use a feature available
> > for almost a year.
> >
> > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index ff9174282a8c..c909352f894d 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -6330,6 +6330,8 @@ static const struct bpf_sec_def section_defs[] = {
> >         BPF_PROG_SEC("lwt_seg6local",           BPF_PROG_TYPE_LWT_SEG6LOCAL),
> >         BPF_APROG_SEC("cgroup_skb/ingress",     BPF_PROG_TYPE_CGROUP_SKB,
> >                                                 BPF_CGROUP_INET_INGRESS),
> > +       BPF_EAPROG_SEC("cgroup_skb/egress/expected", BPF_PROG_TYPE_CGROUP_SKB,
> > +                                               BPF_CGROUP_INET_EGRESS),
> >         BPF_APROG_SEC("cgroup_skb/egress",      BPF_PROG_TYPE_CGROUP_SKB,
> >                                                 BPF_CGROUP_INET_EGRESS),
> >         BPF_APROG_COMPAT("cgroup/skb",          BPF_PROG_TYPE_CGROUP_SKB),
> > --
> > 2.24.1
> >

-- 
Andrey Ignatov
