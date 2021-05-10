Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C975A3796BE
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 20:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhEJSCS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 14:02:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36648 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232262AbhEJSCR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 May 2021 14:02:17 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14AI0Ok4018284;
        Mon, 10 May 2021 11:01:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cSp89mbQw3cdI4ATc4+61fPjfjeRkwSnWrZfu55oIyo=;
 b=nM8IXaD+JL0XFR6SPe0B4cdRLTqK4H6ZK1/qpCWe3KZKtJglI0CBlf8QLDLZ/pJ33RYf
 nnu42EjvJOqN3ET/A7b6OU08qdVRLEXwBbjg15nB8efV0K24mTwWBTtTwkYoc49f/trk
 G38wK6cV9mKRYemSnGuApn1mOPZCWucdfB8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38ead3xhq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 May 2021 11:01:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 11:01:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK36RIFfydlM0YdINtJ8wORF3fykNMyq9PT4eqs6R2Fss9acaelgcGwwJWOZVr5rlHvkur4FlAF1sO3vJWRhc+s4YCF6IHQm5iLMbhSMcnNIraBQQHqyez4v5XIUFRSKhX0ZPa4LErk32tP+71MIj9T+ASQEMHFqG0ddFGePFkvXGuX8xBVtMTj0jSdhymi1FwRoUwNcUIp/qPC01i3W5ZmgfYcZ3PsaBajRqqjYn1wQrSP0sSnrV3Zomjt5WBsvmLb3Qv99xYjW44yARU2jwRmHiuzWaCUIvgnrw4iHgGuG44EBGxnqu+oSRt0VwNccLAfqtsFXWyd/LJU79uSqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPbrdXBPN2x3iWt0EatW1vj9cWoSbUFxoynbvHKWp0o=;
 b=Gt7FI68G85DEykmIQSnTgsOFgoU2Y06tc/WgiqYd8bMR6F4NOiJHapeSozjVxxNzxLpp4+GH7kYM3pzJgsdeEVLc7WTIu4wUJMCTlJA2qnEFDvx4zIItn290BZ/wxodUUcrNmes5i4uZBnqZ6kA53lnTkRPYn27P4EnyXJoTkCvtwGX/SwghNVpxl06edVxqRuRUnq8PRZiGWC6ypYEVxUf+9QalwAwLLa2F8hGbp+42TS0X7bKimuelFgq9ig8DJ1Gi6v/LqaFgbe9C8xZS69S5hsM+a5p02xfkxjSwVaMANfIkAz+7Q8GPkrVLQ5j/PF0dnDxb7mOKrN7+x/ZHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2725.namprd15.prod.outlook.com (2603:10b6:a03:158::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 18:01:03 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 18:01:03 +0000
Date:   Mon, 10 May 2021 11:00:59 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, <dwarves@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v2 dwarves] btf: Remove ftrace filter
Message-ID: <20210510180059.tz527zrb6bcqjrl7@kafai-mbp.dhcp.thefacebook.com>
References: <20210506205622.3663956-1-kafai@fb.com>
 <YJSr7S7dRty3K8Wd@archlinux-ax161>
 <20210508050321.2qrmkzq7zjpphqo7@kafai-mbp.dhcp.thefacebook.com>
 <20210508105301.GD12700@kitsune.suse.cz>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20210508105301.GD12700@kitsune.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:9201]
X-ClientProxiedBy: MWHPR10CA0019.namprd10.prod.outlook.com (2603:10b6:301::29)
 To BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:9201) by MWHPR10CA0019.namprd10.prod.outlook.com (2603:10b6:301::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 18:01:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 689b1e11-f5a7-4459-7e55-08d913dd9369
X-MS-TrafficTypeDiagnostic: BYAPR15MB2725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB27254D22C336687A85E06B88D5549@BYAPR15MB2725.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n466h6FSAJ9JMKLheBGLiNaDp5G8eeZ2eVAhEJzP6jvbt/Cv3h2XiPCo7NPnN2hUq0ofHiU3n0uNn80JCVMKxszZtrhMIDMUKPC0dvnnpic0sKt2cqfNVZ5LrElzrVX5i25UDU78gIsqS8qOiKrQTL+rBeNcUFnJARxPWzEaMznOI0IO74HCOyIG2UdwuoV/kad9tRbVQoge5/no6PMDcE19fuKVrNDsvKGQekHKsJaM7WG0EngEywDEdBAsDPN8v+fRMESH/iRqSHKbT9fsIuEUEPCOYj2x4vRkIkZ5G1fa+IO+UYfWTdq+J1uWGPDx89PbCAxGAPwgYM29vNHLas2M6m0BCKn8R4h6mHKC6aUMtZQCNuvMYdUg1j+JcYexZMlWkatuxqXH2RpyAE2TswetQTeqeJXsN5beRAdGcaw2V2a5amVaKf+p9ccKyTgD7rPzSXvkxhDHIlzfLPjMt8z+HcsVnGFUUMR0iW3B/6KkDVy5Ukc1iRFB/Li59KfQ4ipl00DKQ5IXNtxs4KOlFNeDnJ/vh6dQyiRrjtXLYrBoik3yKn+belbFVoz7NxG4oXbZlo5LxdXUYgBVCz38+dJkwLkawhJbg/WBpKz9X4Sz8rdpDCWQ+tmSYrUCk48Q87PKHCJKKmJSdA89GhV5qulFLatB4DoDE9G2AbfgwUwMxoK6P+7dtCya/WxyXgBJHmYTwwexlhPd8fgbXCPmvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(54906003)(478600001)(5660300002)(55016002)(966005)(186003)(4326008)(7696005)(8676002)(8936002)(6506007)(66476007)(52116002)(6666004)(6916009)(2906002)(83380400001)(316002)(66946007)(38100700002)(1076003)(86362001)(66556008)(9686003)(66574015)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?LOp7xcfzEkz3L5Br0L92lsLfEZvrrOZOutVYkLx3HPVFQVclJa1IfKnxU8?=
 =?iso-8859-1?Q?NBz7/g/Berw3KvLyLrfVE5pd4YhbqZGxSSmOAqLKI32mvmm0TOclEeZENu?=
 =?iso-8859-1?Q?giZwmIsO1PxAkBrHTcQME1EloqjkoFCaLQcjiJTpkbsou8UYEF6Uapr7XC?=
 =?iso-8859-1?Q?btg34RqMDbm0fr2H0Rt2njJ1p3gJYrIjJGJwhq4OGf/lhzVYye+MEn/POZ?=
 =?iso-8859-1?Q?z3s4qNsJyW2YLyYDn9I9VA1nn4UUwF47JjrHtPiweO8fao767tGNGbDykG?=
 =?iso-8859-1?Q?KYX5S/eTPdv3o/4W1wm2IQmefcFdb25yqAfZ4CMGWHRehaTPPug9v9+OVs?=
 =?iso-8859-1?Q?5Nr4UEl5tZNf7GqNiy4Wim4wEaQfShXgy3HrzzPXqRNjT3ETboHRUPYgyb?=
 =?iso-8859-1?Q?UT/oaXF+WL/bJS5fnPoJxeofsXpU9ism286Ss8YRSowfz8VJIyMY5nKtpO?=
 =?iso-8859-1?Q?DhdT2JEvC1xV9Duf+NHYOg5n6+/XixasiqvDuX483Ki3UOqOSkxaZ6ZDm0?=
 =?iso-8859-1?Q?2373kgcymEAOO5FUucfmIMci2TU8CHb2tyR8M9W0TEO6LGv0/PEs8BLAte?=
 =?iso-8859-1?Q?03MBeDtvhSJwByhNsHP6llmhn0IA9bhCnWTo05UUye8MbJgx9PWVKTGFu3?=
 =?iso-8859-1?Q?K8gIiiR/DyFruMfQBbOeLHEZ6bG2I59z7Mw3X8Q00NJRB6PqdTranH+Tt+?=
 =?iso-8859-1?Q?0ygWHdN8tNhpNJZPaG7U3Pvjw7G/NC2b2meB9gTUnmdk2LVCVvfLX4KGAL?=
 =?iso-8859-1?Q?SWS2UyLhf/LHcOm2hG5NEK05Fp0Lsv4ylmf0ekclHyMKyr3dXwk8hcYndl?=
 =?iso-8859-1?Q?uozofW+A8zfNPkl4PljClaaJ7ZT+sUOjDOa9EFvfo34OFcx47lqI210hke?=
 =?iso-8859-1?Q?l1z2u7xf7CvDqz/STdwCg9OcAgXfvjCfQqeECuXaG7Y+eDeMLzCJ/W65Bb?=
 =?iso-8859-1?Q?KZrEfHf6MTVCtAF6RmL73KMxhdqQnOX79+3/dxPkB/3+WYglV5KupIxxla?=
 =?iso-8859-1?Q?fIaTUtBgkqArbwGA+5Ke6urtj4cetu0ln1O1vw91VDFxuDoEZCfen89fbc?=
 =?iso-8859-1?Q?Da9M3aN2ud8toy7hACWWWMrw/vmf3b9bHrndNrVP0tas/27kJ9n2OdOt6k?=
 =?iso-8859-1?Q?Jfbx1I8/UvEmwa6Z65ePIgJ70nJRJd5VdQaKPeiwC5fLozkHpx7CaTV5Uo?=
 =?iso-8859-1?Q?YrkeL6g1B7lwIeWImdBfgjzFRfw7Q3B1qJvqE0wBoheJIGU5Mal/IxXNOT?=
 =?iso-8859-1?Q?dLwTneQ9OrHw2fjVHaPicRJucF7mPIAMndItKx9hSggFXpmfgMXQHNKV8Z?=
 =?iso-8859-1?Q?RvFvCck3CI08aLP0vk85AF0O8gI5YOlGT9wOfb1gHVoBZhfncRLpVgkard?=
 =?iso-8859-1?Q?ghLkx/0vZsZTg2/Uux3iwvK62hhiwWkw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 689b1e11-f5a7-4459-7e55-08d913dd9369
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 18:01:03.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxCDuYeM4igrMMTe3XyhFKKmDKs3MuAfFTMZV8yOGDcJuH7kZerI9UBnEGEYmSbp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2725
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Et-bVoezJ2y1IfBNsrhjQVFwyNSpl1ao
X-Proofpoint-ORIG-GUID: Et-bVoezJ2y1IfBNsrhjQVFwyNSpl1ao
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_11:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=838
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 08, 2021 at 12:53:01PM +0200, Michal Suchánek wrote:
> On Fri, May 07, 2021 at 10:03:21PM -0700, Martin KaFai Lau wrote:
> > On Thu, May 06, 2021 at 07:54:37PM -0700, Nathan Chancellor wrote:
> > > On Thu, May 06, 2021 at 01:56:22PM -0700, Martin KaFai Lau wrote:
> > > > BTF is currently generated for functions that are in ftrace list
> > > > or extern.
> > > > 
> > > > A recent use case also needs BTF generated for functions included in
> > > > allowlist.  In particular, the kernel
> > > > commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> > > > allows bpf program to directly call a few tcp cc kernel functions. Those
> > > > kernel functions are currently allowed only if CONFIG_DYNAMIC_FTRACE
> > > > is set to ensure they are in the ftrace list but this kconfig dependency
> > > > is unnecessary.
> > > > 
> > > > Those kernel functions are specified under an ELF section .BTF_ids.
> > > > There was an earlier attempt [0] to add another filter for the functions in
> > > > the .BTF_ids section.  That discussion concluded that the ftrace filter
> > > > should be removed instead.
> > > > 
> > > > This patch is to remove the ftrace filter and its related functions.
> > > > 
> > > > Number of BTF FUNC with and without is_ftrace_func():
> > > > My kconfig in x86: 40643 vs 46225
> > > > Jiri reported on arm: 25022 vs 55812
> > > > 
> > > > [0]: https://lore.kernel.org/dwarves/20210423213728.3538141-1-kafai@fb.com/
> > > > 
> > > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > > 
> > > This fixes an issue with Fedora's s390x config that CKI noticed:
> > > 
> > > https://groups.google.com/g/clang-built-linux/c/IzthpckBJvc/m/MPWGDmXiAwAJ  
> > > 
> > > Tested-by: Nathan Chancellor <nathan@kernel.org> # build
> > Thanks all for reviewing and testing.
> > 
> > In my cross compile ppc64 test, it does not solve the issue.
> > The problem is the tcp-cc functions (e.g. "cublictcp_*")
> > are not STT_FUNC in ppc64, so they are not collected in collect_function().
> > The ".cubictcp_*" is STT_FUNC though.
> > 
> > Since only the x86 (64 and 32) bpf jit can call these tcp-cc functions now
> > and there is no usage for adding them to .BTF_ids for other ARCHs,
> > I have post a patch to limit them to x86:
> > https://lore.kernel.org/bpf/20210508005011.3863757-1-kafai@fb.com/
> 
> That's probably not the way to go. If function symbols start with a dot
> in ppc64 elfv1 abi then pahole should learn to add a dot for ppc64 elfv1
> abi.
> 
> Or we can build ppc64 BE using the elfv2 abi and depend on elfv2 abi for
> BTF on ppc64. The patch for enabling elfv2 for BE is currently under
> discussion and I have the patch that adds the dependency ready as well.
ic.  I just learned the elfv2/LE vs elfv1/BE difference in ppc64.
elfv2 BE ppc64 support is on its way, so it is better to have DEBUG_INFO_BTF
depending on the ppc64-elfv2 related kconfig(s) instead of making an exception
handling in pahole.

If you have the	BTF ppc64-elfv2 dependency patch ready, does it make
sense to land this patch first independent of the ppc64 elfv2/BE
effort?

Could you share a pointer to the ppc64-elfv2 BE	patch?
