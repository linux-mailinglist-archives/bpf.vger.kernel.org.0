Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7174324624
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 23:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBXWPt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 17:15:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49398 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233276AbhBXWPs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 17:15:48 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11OME4rS023331;
        Wed, 24 Feb 2021 14:14:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ZQU2vhbGN+icMX3VknSjYi23gPNwkHNOJtrnScBFvs4=;
 b=FBMplRJy2VNLEz4XrAWO/Zvwra1fN2hXYgiJK/4fY3bexBXD1K6ZL3K24eW6Q47VKiog
 d3IsrDfrzvIV3orELxxRVcTDrNBo4CeplQODeIFT/O8lb9eHc7J4c8sEN0a8qm5qJt7U
 dGzR3C5BcKa7YDiigYcL9h8nFRqwAv+HTxQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36vx7s2mdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Feb 2021 14:14:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 14:14:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3Dj6ddc2FcBX2LzkT8gGi0qi/9eE5YRzIdZG46KvRZVusovcFj2x+ZApTXqGxGzzxtCl3IhhPQD9he0cBtybqTMpIcwL3Hzqm+dRj2mIMJyxzLmu9D4rPzmpZQtOsLZXDXAybRaoatubR746QPogJD9zU7IsqMoJMdmzzc0CYS4tX3hZzNJbnTvrTMolF03J2b5jEQB0FkfqYq/PSOGwTRzwAlK2WjZ2murObZUXjju/pT9Gjeqq3CQU/cAGYYVbogCU0Hlmskd17OZu+WYKDsqowmAKCSuQEVqhAjA1x1xeg3pD6YLCS3FbmObO7e/JOy0aMlBYVfwfZpRYUzJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQU2vhbGN+icMX3VknSjYi23gPNwkHNOJtrnScBFvs4=;
 b=BvSopzU1J3wdaZyrEBswo6TtTg6KScp/ZJ3ssBOcwSsgZR/3Oy0X8qN3GKJOXtBBnedxOKRM+Z1qVojmlPzD2FJrBjxWsQG+zLOC+7NdIvH/6ASLbGtvo6THFY/R57/HhNYUpE/KgJlpJCTT3n5qPkBb7LH2hFraYrNrx7GFt2zyRe863O8ey02tgirqetQdR88bGbyjTM4s8M+3woyMarvs25EdWG8c/nGXURzhmOPl1udpMvm1vK8scbUZXEbGQ+iZN0cRGqyjn5I+kClpVxI61EStHytSzSBFTopQ3W4sdtPWUoRzuTK5Vw+sxDZuGP1oq8W4UvMOcOKiaXtAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2695.namprd15.prod.outlook.com (2603:10b6:a03:150::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 22:14:43 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0%5]) with mapi id 15.20.3868.032; Wed, 24 Feb 2021
 22:14:43 +0000
Date:   Wed, 24 Feb 2021 14:14:40 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Brendan Jackman <jackmanb@google.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v4 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
Message-ID: <20210224221440.4ncxz7vyo7weygm3@kafai-mbp.dhcp.thefacebook.com>
References: <20210223150845.1857620-1-jackmanb@google.com>
 <20210224054757.3b3zfzng2pvqhbf5@kafai-mbp.dhcp.thefacebook.com>
 <CA+i-1C0NyLrMDiFnD9Jdrs_ww-a7kX7XaEaT1YiyrC5w0LJdXA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+i-1C0NyLrMDiFnD9Jdrs_ww-a7kX7XaEaT1YiyrC5w0LJdXA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:88e6]
X-ClientProxiedBy: CO1PR15CA0102.namprd15.prod.outlook.com
 (2603:10b6:101:21::22) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:88e6) by CO1PR15CA0102.namprd15.prod.outlook.com (2603:10b6:101:21::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Wed, 24 Feb 2021 22:14:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8a4dca5-0004-442c-8e04-08d8d9119630
X-MS-TrafficTypeDiagnostic: BYAPR15MB2695:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26959834C1B93A17304129A2D59F9@BYAPR15MB2695.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLyFXSOeSvaj1nlThhgfNgSupYqqKvsrbOyIAhR0t5c2zSYwL4PDnEjUBA/9a9Ly9f64GdRaae9bdujsiHddQM1FBt+61LEChEZ+qu5HoSpb08hpVy/dHjyHjqYiE6i8xaRn/UZOws7YcWXUy7bEdo5IToWsx+WzbJ092ncYZnUkGBRF0SMNz0DCXCqHI9P+pJ2fNky1m5pC3Hihz3wS8+huuXbbSEdL5RsaKS2t7ZrvpQaBzA+hNvYcWh1AslMXAC1TqCcKEzm4xS7EDcMpoQ+FK50ogAjiN6VdjY0QyII0jY4nTZVVVJIMxkYd2KZj8M88F7mXtn07XOa8m9cN/TtYAp7GdcOLWOUCYt6Gp8ebpiab5CL2rlHGfDjZndYaBVD+aMq09aFFGJHWNcR+1cIhJcdP2eP/xo9ESgiNYh+kC4nX8H3ZD4jJCwfsX7FlUBDLrwqdk0USUaBTS896Tr7Iptu3LvamdFr/AwXErmK6DuSkYZaPU08bCuMM8ionGMpDNICYF4s4clKra61BqSfN05tTeq5zyvzZ4zEaCKA0+KrkXSGM8UQBSXgqDUOwYVPbgaXEx/rIPPjQkN2VrX5deM6+lJYBd4NzwCu/+F8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(39860400002)(376002)(1076003)(6916009)(4326008)(16526019)(55016002)(52116002)(8676002)(186003)(8936002)(5660300002)(2906002)(7696005)(478600001)(83380400001)(54906003)(66946007)(316002)(66556008)(86362001)(6506007)(9686003)(66476007)(17423001)(156123004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fL0FUhwwPJjgyemgTPoPWorxiJ7xpNoabNhY64sFrbLg5XKvt7BdGzj/nFOt?=
 =?us-ascii?Q?MpeRMFKvhnMGFBRWYpTArQo7oZVNdHyBBFl/lY5lzUqbXMniJn7TFokVVTV+?=
 =?us-ascii?Q?1CJzeMEuM/+4RpSjyuo0yA9QclYuMAx1+AvELgoFR/5yNhooezV7IWE06JLL?=
 =?us-ascii?Q?qczRkZgCmKpVIbbI7rkxdAP94M3GJvmcsbyX99fYJRzlqnPt53gO2kAXbHrJ?=
 =?us-ascii?Q?1OvykOd9xogKF69qiF2CdBxSvA+QeiDS9nuLqlb8DyuSp+g3l7gH/Ii+T9Be?=
 =?us-ascii?Q?Aan0++n7CB7Ot9g0SP/Zn/UfmFPvmMtiS4KV7T1kD3x6dG+v7M86nRcMV/U1?=
 =?us-ascii?Q?JPryf7dz1r9K3yh2yxZNOnKSaQ24CjawT5iOeJKUX2/IU+g4y/25+ZNiayL5?=
 =?us-ascii?Q?rvcLUKM/CafIoeGqhjCtL5Y2qFDJNxmfh3mzp4Qa+fLLxWzg2hSVXo+skDpH?=
 =?us-ascii?Q?fQjgfmx5YFvtZE7TnEOphzUPtk6lmEKY8RrbdYFlZqKJjmmK/OH+VJvZLE4S?=
 =?us-ascii?Q?ZLqpi3VPWIsofgU4tdiV5XmFeabHO+/eN6r6hz+BFH1wZsjlqiX7vSPwefnf?=
 =?us-ascii?Q?ceKcBiM3yS4dwcZCTHy4BXqVaXOWnyIPnzQf5ro4/PDZfDIeoxr9XTcP3FHS?=
 =?us-ascii?Q?S+qDWa4cmjVnfQmTtRE4PIfOSRp0r9kW0jsXjU0ffO6aM+uRfFxiiElz+G3x?=
 =?us-ascii?Q?wuhYVwQtk8Lajl5uSZt8avXxbNn1ykN9iqGrdkcyKzj/LEIO4fL8LS8bqJnF?=
 =?us-ascii?Q?koPKBmEOucPdebf+gl7GeQtOZrwCtMzzKbzK2S+dgvSclSVHJFx1Ogukja60?=
 =?us-ascii?Q?xqRBSBq6MAiy+d080GNTzj0kAyb6H64H5SXN0b87gFOg9vlhyr0mk7AQc0pa?=
 =?us-ascii?Q?0epcc2V3EkTmXV4c/edLfLuaGwW9amHKmVgHJlgK3UXuqlkcR3PVL0WPW8Xb?=
 =?us-ascii?Q?Su8wguL7HT3wXF2ngCeL9cSRwLIdaANSwSZhtgFh70NVqFoxCWGQrhiJbrUM?=
 =?us-ascii?Q?E1ghAQ/oKNXHt5k1A5QUMjVhLPfibyMOf6rQTQIIKFpo4XYvGMEB1XloN+xk?=
 =?us-ascii?Q?8fJXDq8uBT/GpIPBBOZrEienqgKNGwUEvK6dFlZRHt4e9Ex3IHI3rUHShEF4?=
 =?us-ascii?Q?Ad0yrhFSZ+j/nZgGYMIE+12XsCMvVsPI0O2EUvkk8ZCG048i2o6iW1Y06+R5?=
 =?us-ascii?Q?GD/AbnCu+aBKtN6FK4OTBgoFf6SaFOz3ih9yw6HoqiU74XGNc9HU40HlYA9n?=
 =?us-ascii?Q?2iy20KleS7u+2NrHpwB7gK9Zhar4bIKniSPyMknOjljyd1Nlp208TlXaBI2e?=
 =?us-ascii?Q?pCc7ZsLfi+nQNmPs9y0CLrAtfYG+Tepx290fdeF23VlXlQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a4dca5-0004-442c-8e04-08d8d9119630
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:14:43.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwpzTB1/U+dfDKwM/vVwc7hUIn0c1SH5+adz+yzMubd0ShoxXMfTsnjNoKme8j/Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2695
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_11:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240172
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 24, 2021 at 10:32:28AM +0100, Brendan Jackman wrote:
> On Wed, 24 Feb 2021 at 06:48, Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Tue, Feb 23, 2021 at 03:08:45PM +0000, Brendan Jackman wrote:
> > [ ... ]
> >
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 0ae015ad1e05..dcf18612841b 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -2342,6 +2342,10 @@ bool __weak bpf_helper_changes_pkt_data(void *func)
> > >  /* Return TRUE if the JIT backend wants verifier to enable sub-register usage
> > >   * analysis code and wants explicit zero extension inserted by verifier.
> > >   * Otherwise, return FALSE.
> > > + *
> > > + * The verifier inserts an explicit zero extension after BPF_CMPXCHGs even if
> > > + * you don't override this. JITs that don't want these extra insns can detect
> > > + * them using insn_is_zext.
> > >   */
> > >  bool __weak bpf_jit_needs_zext(void)
> > >  {
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 3d34ba492d46..ec1cbd565140 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -11061,8 +11061,16 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
> > >                        */
> > >                       if (WARN_ON(!(insn.imm & BPF_FETCH)))
> > >                               return -EINVAL;
> > > -                     load_reg = insn.imm == BPF_CMPXCHG ? BPF_REG_0
> > > -                                                        : insn.src_reg;
> > > +                     /* There should already be a zero-extension inserted after BPF_CMPXCHG. */
> > > +                     if (insn.imm == BPF_CMPXCHG) {
> > > +                             struct bpf_insn *next = &insns[adj_idx + 1];
> > > +
> > > +                             if (WARN_ON(!insn_is_zext(next) || next->dst_reg != insn.src_reg))
> > > +                                     return -EINVAL;
> > > +                             continue;
> > This is to avoid zext_patch again for the JITs with
> > bpf_jit_needs_zext() == true.
> >
> > IIUC, at this point, aux[adj_idx].zext_dst == true which
> > means that the check_atomic() has already marked the
> > reg0->subreg_def properly.
> 
> That's right... sorry I'm not sure if you're implying something here
> or just checking understanding?
> 
> > > +                     }
> > > +
> > > +                     load_reg = insn.src_reg;
> > >               } else {
> > >                       load_reg = insn.dst_reg;
> > >               }
> > > @@ -11666,6 +11674,27 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
> > >                       continue;
> > >               }
> > >
> > > +             /* BPF_CMPXCHG always loads a value into R0, therefore always
> > > +              * zero-extends. However some archs' equivalent instruction only
> > > +              * does this load when the comparison is successful. So here we
> > > +              * add a BPF_ZEXT_REG after every 32-bit CMPXCHG, so that such
> > > +              * archs' JITs don't need to deal with the issue. Archs that
> > > +              * don't face this issue may use insn_is_zext to detect and skip
> > > +              * the added instruction.
> > > +              */
> > > +             if (insn->code == (BPF_STX | BPF_W | BPF_ATOMIC) && insn->imm == BPF_CMPXCHG) {
> > > +                     struct bpf_insn zext_patch[2] = { *insn, BPF_ZEXT_REG(BPF_REG_0) };
> > Then should this zext_patch only be done for "!bpf_jit_needs_zext()"
> > such that the above change in opt_subreg_zext_lo32_rnd_hi32()
> > becomes unnecessary?
> 
> Yep that would work but I IMO it would be a more fragile expression of
> the logic: instead of directly checking whether something was done
> we'd be looking at a proxy for another part of the system's behaviour.
> I don't think it would win us anything in terms of clarity either?
hmmm... I find it quite confusing to read.

While the current opt_subreg_zext_lo32_rnd_hi32() has
already been doing the actual zext patching work based
on the zext_dst marking,
this patch does zext patch for cmpxchg before opt_subreg_zext_lo32_rnd_hi32()
even the zext_dst has already been marked.

Then later in opt_subreg_zext_lo32_rnd_hi32(), code is
added to avoid doing the zext patch again for the
"!bpf_jit_needs_zext()" case.

If there is other cases later, then changes have to be made
in both places, one does zext patch and then another to
avoid double patch for the "!bpf_jit_needs_zext()" case.

Why not only patch it when there is no other places doing it?

It may be better to do the zext patch for cmpxchg in
opt_subreg_zext_lo32_rnd_hi32() also.  Then all zext patch
is done in one place.  Something like:

static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
					const union bpf_attr *attr)
{

	for (i = 0; i < len; i++) {
		/* ... */
	
		if (!bpf_jit_needs_zext() && !is_cmpxchg_insn(insn))
			continue;

		/* do zext patch */
	}
}

Would that work?
