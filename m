Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11C81A4C6B
	for <lists+bpf@lfdr.de>; Sat, 11 Apr 2020 01:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDJXCu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Apr 2020 19:02:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11128 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbgDJXCu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Apr 2020 19:02:50 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AMncbI020211;
        Fri, 10 Apr 2020 16:02:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=CvWDXQ5qIvaTBzD4RdodSim0Jjg8oRp//rNHQqD7ITQ=;
 b=V/XfORjWilUtFgqMv/VyHsVpkWTumEDueRbf+j+FuHRC/TpU7inzBhXcWDqQDyoklQZi
 7yws5LT2SvG1Uj76jUQPCU8lFA8aj0TAd9MV+LhVirHiRJ58kz3CffeOseASDUA4H+86
 vy/94h+rK7s14ZwjnZ/W5hB3OKW6Nvpmr6w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30atqk2px3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Apr 2020 16:02:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 10 Apr 2020 16:02:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4Z59ENFspZ5z3Ghj3EetsgtBX2+tof3dSBQYB0OyuGGckJwxReRIjX8WLn9VaujXuerZXVirD+7O7NF/PnFhw3AQRU0/BvyMDuyFRQgZZ1VgwMj9wMfC/VdEq9/dSWoZripbA8iIMdQxyzCOM1muQJ4QxCve8p8BRkcPwk9UZj7k2CWdgJzGdPb6hFPIC2CLgZEiCM2EtfNAOgKb1SM5x8oEg/xt//MnciMGfyVlSm96gtb3NHt5RoL694wn6hsrLx3x4Qe9dhMSNYoHKYtWFBaa0yFT7mhzM02PLqjzQUsC4uvSNkd2hGEr0uRtCqawRAhTXOSDndtzk3u61ER7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvWDXQ5qIvaTBzD4RdodSim0Jjg8oRp//rNHQqD7ITQ=;
 b=kL161ko4GukJc/WFqlcYNrlZyjo+0CtuN0fSd5EKNlMADKKXnRdVNP2RpmbK82M8Vb8I72sRCDreQlBBgzNa85yG2Bg172sbKLrW66JR2J8ifaMFzEP1bn1F7SBJ86nfRSHGIeCRZvLhky17G6lGcc+RUJjZE+xsy6uZicSlzCCkm22JktQTE6EPbRl47wM++iJ9b6vN7fPnL7fpleAs9cZBKuURq4CfCc5F4q6XMWxdMu/4OBiujRg/8sMPRNAnVraGzTGNBaAXmtn4McqAUmu75IgoYjvsPsQdwb2qNKdNmdHkmrlPx4J2+soXOEGp23cK4GIiPEKateUuLEtNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvWDXQ5qIvaTBzD4RdodSim0Jjg8oRp//rNHQqD7ITQ=;
 b=LU6XfSmHfU5r70fJN04rNU/59DianZumFG0kieHkicbtwVoI2JOicrEMnIeleQxrvpD1DPIqpntUNPmbySF/u/lxAm3U7eQe9qkindcVlaw18TqKB1mb/CkptP5oAkEkAqDG0LkXpuZyQz2nO3Z+UC/3XsE8M3YLxQxtPiXM3g8=
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB2357.namprd15.prod.outlook.com (2603:10b6:a02:82::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 10 Apr
 2020 23:02:34 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::90d6:ec75:fde:e992]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::90d6:ec75:fde:e992%7]) with mapi id 15.20.2878.023; Fri, 10 Apr 2020
 23:02:34 +0000
Date:   Fri, 10 Apr 2020 16:02:32 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf 1/2] libbpf: Fix loading cgroup_skb/egress with ret
 in [2, 3]
Message-ID: <20200410230232.GB95636@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1586547735.git.rdna@fb.com>
 <daa546903aa74cf844452b7f80788d67c15b42ea.1586547735.git.rdna@fb.com>
 <CAEf4BzYvPawqgdP+cU94+US=hKGaD8qCBFtnu_JZae3eJ0+SUw@mail.gmail.com>
 <20200410211444.opudqya3jvbdbqte@ast-mbp>
 <CAEf4Bzab+3-gFPnrmc_2f3NogXvckox=QpGWVZiCNxTGQK9v7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4Bzab+3-gFPnrmc_2f3NogXvckox=QpGWVZiCNxTGQK9v7A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: CO2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:100::24)
 To BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:c982) by CO2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:100::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20 via Frontend Transport; Fri, 10 Apr 2020 23:02:34 +0000
X-Originating-IP: [2620:10d:c090:400::5:c982]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95ff096e-bb2f-4ee1-c302-08d7dda34180
X-MS-TrafficTypeDiagnostic: BYAPR15MB2357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2357B852479B1C9A4008F6F2A8DE0@BYAPR15MB2357.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(376002)(136003)(39860400002)(366004)(346002)(33656002)(5660300002)(66556008)(66946007)(8676002)(1076003)(53546011)(6916009)(81156014)(8936002)(478600001)(16526019)(186003)(66476007)(2906002)(4326008)(6486002)(54906003)(9686003)(52116002)(6496006)(86362001)(316002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42AdElP9z/IYjp6J6CiGqHqBNBOsebTrExp5c6NZL8s4JPsUTUeLGtgyA4V45yCucGijyexyNfUbAcitmv0+8UfTczlD7owe/ob8+VB/lZAfVdUWNH29GQ0WCfGOT9TITUjx2dwvHL99B2T0MrzH+fSqOvMlINRzpRnj7L4kicAQ0wTrHsNn0ozYdOf80ACyQzpygILGlWcWuQlkPBhQlQApzY2i/l+1J2xZBDHmSvNbcM01DqZcxqOcUcrzT5rud2rU/cCOYqP/877+2oo/snIK936okpy15/neRudCdl6Fugmf1w1tAHqVrRXHYVmjtup8L/3hJRGraDG2Nr+2VwzCa5ubSIDxX//0q9Uxr1sJ1WTlVvgAWG9R8J8y1tX7UrB3XWYy2Vp+svEDzxG1GhMPEMxCfHzaRHtLzVEqqBzCiX4wPiDr3bBpp9jmY5cq
X-MS-Exchange-AntiSpam-MessageData: Hpcu4tzEo5DU3SzIcRshCn1wlzk36TQZ9DE9xQVQVAdP2vyIbHkeLgYx39aL8+FnYY6iBQBgR9HQSJ69YQ6C6zl6/4n4iSrYT6LB8m0LSNomUU8I+pvVjlTLhsrBFFf+nSzwwTCe8U6LDSETMad7HXgL1TyXvp9gUHMr1SBJjf9zOhUlfYy5sLh7hkIwjWEm
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ff096e-bb2f-4ee1-c302-08d7dda34180
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 23:02:34.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlRdFToEP/dtjrs2k08WRC1K6E5zadDbuXROglu9+PCdS69LvKnPjA85dHUX/kDc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2357
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_10:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100161
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> [Fri, 2020-04-10 14:52 -0700]:
> On Fri, Apr 10, 2020 at 2:14 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Apr 10, 2020 at 01:39:03PM -0700, Andrii Nakryiko wrote:
> > > On Fri, Apr 10, 2020 at 12:54 PM Andrey Ignatov <rdna@fb.com> wrote:
> > > >
> > > > Initially BPF_CGROUP_INET_EGRESS hook didn't require specifying
> > > > expected_attach_type at loading time, but commit
> > > >
> > > >   5cf1e9145630 ("bpf: cgroup inet skb programs can return 0 to 3")
> > > >
> > > > changed it so that expected_attach_type must be specified if program can
> > > > return either 2 or 3 (before it was either 0 or 1) to communicate
> > > > congestion notification to caller.
> > > >
> > > > At the same time loading w/o expected_attach_type is still supported for
> > > > backward compatibility if program retval is in tnum_range(0, 1).
> > > >
> > > > Though libbpf currently supports guessing prog/attach/expected_attach
> > > > types only for "old" mode (retval in [0; 1]). And if cgroup_skb egress
> > > > program stars returning e.g. 2 (corresponds to NET_XMIT_CN), then
> > > > guessing breaks and, e.g. bpftool can't load an object with such a
> > > > program anymore:
> > > >
> > > >   # bpftool prog loadall tools/testing/selftests/bpf/test_skb.o /sys/fs/bpf/test_skb
> > > >   libbpf: load bpf program failed: Invalid argument
> > > >   libbpf: -- BEGIN DUMP LOG ---
> > > >   libbpf:
> > > >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> > > >   0: (85) call pc+5
> > > >
> > > >    ... skip ...
> > > >
> > > >   from 87 to 1: R0_w=invP2 R10=fp0
> > > >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> > > >   1: (bc) w1 = w0
> > > >   2: (b4) w0 = 1
> > > >   3: (16) if w1 == 0x0 goto pc+1
> > > >   4: (b4) w0 = 2
> > > >   ; return tc_prog(skb) == TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
> > > >   5: (95) exit
> > > >   At program exit the register R0 has value (0x2; 0x0) should have been in (0x0; 0x1)
> > > >   processed 96 insns (limit 1000000) max_states_per_insn 1 total_states 10 peak_states 10 mark_read 2
> > > >
> > > >   libbpf: -- END LOG --
> > > >   libbpf: failed to load program 'cgroup_skb/egress'
> > > >   libbpf: failed to load object 'tools/testing/selftests/bpf/test_skb.o'
> > > >   Error: failed to load object file
> > > >
> > > > Fix it by introducing another entry in libbpf section_defs that makes the load
> > > > happens with expected_attach_type: cgroup_skb/egress/expected
> > > >
> > > > That name may not be ideal, but I don't have a better option.
> > >
> > > That's a really bad name :) But maybe instead of having another
> > > section_def, turn existing section def into the one that does specify
> > > expected_attach_type? Seems like kernels accept expected_attach_type
> > > for a while now, so it might be ok backwards compatibility-wise?
> > > Otherwise, we can teach libbpf to retry program load without expected
> > > attach type for cgroup_skb/egress?
> > >
> > > >
> > > > Strictly speaking this is not a fix but rather a missing feature, that's
> > > > why there is no Fixes tag. But it still seems to be a good idea to merge
> > > > it to stable tree to fix loading programs that use a feature available
> > > > for almost a year.
> > > >
> > > > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index ff9174282a8c..c909352f894d 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -6330,6 +6330,8 @@ static const struct bpf_sec_def section_defs[] = {
> > > >         BPF_PROG_SEC("lwt_seg6local",           BPF_PROG_TYPE_LWT_SEG6LOCAL),
> > > >         BPF_APROG_SEC("cgroup_skb/ingress",     BPF_PROG_TYPE_CGROUP_SKB,
> > > >                                                 BPF_CGROUP_INET_INGRESS),
> > > > +       BPF_EAPROG_SEC("cgroup_skb/egress/expected", BPF_PROG_TYPE_CGROUP_SKB,
> > > > +                                               BPF_CGROUP_INET_EGRESS),
> > > >         BPF_APROG_SEC("cgroup_skb/egress",      BPF_PROG_TYPE_CGROUP_SKB,
> > > >                                                 BPF_CGROUP_INET_EGRESS),
> >
> > are you saying that when bpf prog has SEC("cgroup_skb/egress",.. libbpf actually
> > _not_ passing BPF_CGROUP_INET_EGRESS as expected_attach to the kernel?
> 
> Yes, that seems to be the difference between BPF_EAPROG_SEC and BPF_APROG_SEC.

Yeah, "EA" version adds expected_attach_type ("E" stands for "expected")
at load time and "A" version only specifies attach type to use at attach
time (stands for "attach").

> 
> > I think it's a libbpf bug and not something to workaround with retries.
> 
> This predates me, but I assume it's a backwards-compatibility move.
> Because older kernels might know about expected_attach_type, but still
> allow ingress/egress programs to be attached. I'm fine with dropping

Only egress.
ingress doesn't have that problem.

> that (I actually had to work around this problem in
> bpf_program__attach_cgroup), but if anyone is feeling strongly about
> tiny chance of breaking something, we'll have to teach libbpf to retry
> load without expected_attach_type, if that one fails (which fails in
> its own way, so I'd rather not do it).

Answered backward compatibility point in the previous e-mail.

-- 
Andrey Ignatov
