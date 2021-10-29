Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE75443F761
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 08:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhJ2GnK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 02:43:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36716 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232128AbhJ2GnJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 02:43:09 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SKhMkl024865;
        Thu, 28 Oct 2021 23:40:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=IYLcE1RyAaoLzNNMtrJiDEkuq890hoKoLQLxqy01sSw=;
 b=FwWCNZvd/FTXPOLkRq5y4g3DPkMaE6z/kd2Vz+gvhz0MkRRZ3W52QajZPUrrbO+EHktT
 h4RIAARY9PGwJmaPEw8JtqBoA0EUV+7OWfX0whEWr9vxpdgZJR01flzKjO+gfVIHik/5
 DIvi2kNUIJ57+1nCgrnxrET/pBAJbIE9tv4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3byupmemwk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 23:40:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 28 Oct 2021 23:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORwyWObBvQCAC4sTGwXkktcjF8qrUJrvk+NDaOuop/jLin/n19nEfD71sfRNGW5zNEtN48BRJ1yjfj98g9qr0o6YXssg9284/Mue1dvBGeCPdVReSIRUhQ68j41iC2Zxec8cEgdc2ZUAfdSdrv27QJtQIvLN1HKO/uBRZPl/Ip48TsNyWAD0gHD1Mbo6gWq+SKjSzBj6ce9pORFU/vMS8yeeYBSRR5oDtI9jYOsnvpl9FEpHsl9Qb1tjenlYo6GdyTKwwgOZDuyWJmI3PPKjMgJ9i/RuIQNbUGZCUN5mBSibmrQnwelgVtzk2mluh6w29gvImM2xkZMfJMV7AEJnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pDKKsDk2fUi+otVHa3frhxlqWBRXIzcR6wn4KAodjQ=;
 b=oIAYIDXDp4AOzBF5PE59C7KsdiuibD6TzKVrw35f+alv5FH4znANrVwP3EziTswK++P5Rsf8WgPUzMEu881DkelJA/DH1MhOIfO2qzOB0pylEXwjdsEr6B51nbJzJq0BwSx0v6Y1tu35Tv/Gnfnkmx9Udp9ZgnJnMiCjyacc7zCDz2I2//u3u7/LtvVnhJ0fqvaTpoTT8mfzuQK1s3rHPbpt+/n26ptdoITXi2TBOwE6JEohsUKFlB6+6KRd7aS0OutOLAAnwgbiGL5FaTw9fZ24bAE8/NYmDscaGnB4MbykOGu+8p/kTXecS9UJnr0wKT8i3Mllw9cS+TLxAa1lvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4594.namprd15.prod.outlook.com (2603:10b6:806:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 06:40:26 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%7]) with mapi id 15.20.4628.020; Fri, 29 Oct 2021
 06:40:26 +0000
Date:   Thu, 28 Oct 2021 23:40:22 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
CC:     <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <Kernel-team@fb.com>
Subject: Re: [PATCH v6 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20211029064022.7hz6wfzk5wnx4tv7@kafai-mbp.dhcp.thefacebook.com>
References: <20211027234504.30744-1-joannekoong@fb.com>
 <20211027234504.30744-2-joannekoong@fb.com>
 <20211028211424.m5y4kafaulvgke54@kafai-mbp.dhcp.thefacebook.com>
 <8ff8008f-baee-123c-d61f-0fd0140ff50d@fb.com>
 <20211029044916.d2e33y3jhwr2dvbi@kafai-mbp.dhcp.thefacebook.com>
 <6d930e97-424d-393d-4731-ac8eda9e5156@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d930e97-424d-393d-4731-ac8eda9e5156@fb.com>
X-ClientProxiedBy: MW4PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:303:8c::15) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:ae8b) by MW4PR03CA0130.namprd03.prod.outlook.com (2603:10b6:303:8c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 06:40:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9fa9724-29e0-4052-80f7-08d99aa6fd7e
X-MS-TrafficTypeDiagnostic: SA1PR15MB4594:
X-Microsoft-Antispam-PRVS: <SA1PR15MB45948C2273817F4E644E4B14D5879@SA1PR15MB4594.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+C8smbMvtuyCa0QlndXDADBB2YAchKYpEJB8jhsznOGMEwmdwMSfcbF30Lkln9Ws/1nun54NlplbdHezKzyRWz62gTgC7kZQW0ZJ9iZPs+L3scXiuthFuuNbltEb8/QT2d2rPrJhroyA56UunSB8UEl6WVm8kdznSiRQ5y4amzSMIBSt5hzar8uUWi3dUxjWQP7+eoVKXAqHhAUx8hQyA8+mupfYAYREchenJeXK3C0LOkS2hM1VES9TtgULyizPwmwg39e2LI76vJdMMLcjk/lLZJDUNP6U2kRX4B+Bc57m7H4dc5v+vs7vIWxh7scqCv0gEsdIOqeNzvyMQUWVyLGaCkkIy4nxrkUgD/dtQXi1s0ssm7xmfJZpOVXzMPMeLGcCMdhipN9aMoXYOMwGMODTZWtMHfVkWDAnw5t+GBDI7AUjElzh1QbzxIjRKHetUnjEvB3Fe8+m7GqS4iwBAtjOloMDm9ObbEO6LbxLGsWxVT9DCq8vMo1z1Fgy22zkBpq5XVR8D75boZXq3ZDcp++4ravtXeclJfr9bSWPOqaxsFOVuQ3CpR9OPq8x/cKHY2Q1UPoLacj1YPOF9sLn660Mywkz1vFrO9X6oWajhDnU2TbYK1PODfY+oQz4TyItgjo8mr7zttP9vtbcsF6xrIIy9C7sreGAyaAjyrbjNQgUlOUrnBFKeON79qb2+kwvz9rSw00DW0NbcVD1vOuxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(52116002)(1076003)(508600001)(55016002)(5660300002)(53546011)(8676002)(6506007)(7696005)(6636002)(8936002)(83380400001)(2906002)(9686003)(66556008)(66946007)(38100700002)(186003)(86362001)(6666004)(316002)(66476007)(6862004)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kWUYwr3rMk4vfEOnZvhdl88S1eaEJt3iZwUb3me2UjPTaSpKYNLBcAOG48?=
 =?iso-8859-1?Q?rVmZcw61e5yFR+LSK4QMjhI2dusdrTVeG6bbig0IbrlbYTDR64dMrQhrLv?=
 =?iso-8859-1?Q?Md77K9Th3uDu3hxODzSbTnDTMl53ay/eDu2qs6STXp0l4D8FjUwSxDRsmG?=
 =?iso-8859-1?Q?pdbm2tE2iYIxsZi/HXE0lwNmb2oFeCrMGQ6oKqztGc3BiWtywtSxElbAkO?=
 =?iso-8859-1?Q?mga+/H8WomlFdQG1AFlgGds5cGevZLElqF35QKdfWkxBdsE0rAlnepf3NL?=
 =?iso-8859-1?Q?4Vw1q1s7IOm3zOT/lSlpkqH5VponebNDv2nsOvLxTq0bLorSSpkC49+lPG?=
 =?iso-8859-1?Q?zQrkk+gMHpVS3gny+TeTidPaWfe4a+agaFJnrQ7CVK2CV1nPSFp155wQYi?=
 =?iso-8859-1?Q?lYCHNuB23unJn4/g6q5cv4Azy5ppm29LFbXRVK0MzhPlD6s8IK9mWs4+EN?=
 =?iso-8859-1?Q?DRxioGYnlQ09o0V2RiR69hwIz2Z0iwqTnZL3XKP4u9sljat9I//79kYCEs?=
 =?iso-8859-1?Q?DDhYeBkwGhdEdU/UsEUuzNWtZvf7PfKeC8xEW8xq1/1zzrMbo+kea8XVLm?=
 =?iso-8859-1?Q?jACBHz78j0dlDiw4E8nLjxLZ7ZYD0cuKT9no369NjmkGVqCeDgCXC8GgMF?=
 =?iso-8859-1?Q?yHM9/JWn8MsQZ+OBvP0QVxMKA0bDmzVO5O5BEuXUo49BALFFcXUZUHZy2P?=
 =?iso-8859-1?Q?KqNxhnZktMvdbgYsn5mGdE4PzeJ2+eLR8xQWINu1BEl4i3FWN+HYdLy+oE?=
 =?iso-8859-1?Q?0+zNz0WI9omxrvoPne5naRFPNpaGPhkQBG7aHFbX22WrD8uckMrc2SQt/G?=
 =?iso-8859-1?Q?En/BlSEilKVMNAejG4a6D0jA4WEQc8RY2h0zskKp27c5b1VF2i+EaDg0QA?=
 =?iso-8859-1?Q?LkO1Qw557vo/ZWLci8mV0EQTztUfkzjOsaEXxdj+gcNhdVXg4OXaK+9ONO?=
 =?iso-8859-1?Q?rlTju/82DQe4yRQEKFA6SsVsjUvJPgF/QDcyFM/DuVjB7Pj7nq1FAqFCjB?=
 =?iso-8859-1?Q?xyj4eByxA+670q5Yl1U3KHyxH9U5SQANxsqddpIpJqGYi7gG5Vsqoe8oAT?=
 =?iso-8859-1?Q?DQbg91ct0T5cH1LRvL0pA73WLx0vdQCiGv4jSpaNHMrV6C3s28kNJuC37+?=
 =?iso-8859-1?Q?gEw5mTj7qE4g0b7eBfaVuWPax0m+pycF3eXJyTPHnrm/JCoW7UHjon0idC?=
 =?iso-8859-1?Q?nbnmjyPD+C+sORNTg1R8y008uvSox1ipC4OsHWdxCRygT3oJ1NOeSZznYT?=
 =?iso-8859-1?Q?Nsu6MXEC6TMhXGCxXbzxWPRRyakRIT1C1Aokxt7BDZX4yKBpqzzVfVUlr2?=
 =?iso-8859-1?Q?KKAGBYT9lsh4Iy2Q9uspAY+PioXiLjXXaQPakfbDCSisrDitoBci+BDqpP?=
 =?iso-8859-1?Q?A5qb+uAIPTGR0IOEiYqNsRKeZ42AieZb8rdYIaHrTKLYz1+pqBFyshA1QP?=
 =?iso-8859-1?Q?GGbdryd0/pTKFXwA0/gpqzJ2LExghMv0OaIwmhLvSMxFA01mmO9rD+zw0k?=
 =?iso-8859-1?Q?9z6p+wYGyNCoLRTDdK5sGafzmur8byEWnthsznYPU6fg6hxK5nXx2tVIjb?=
 =?iso-8859-1?Q?AgTX5K9Lr9+NPfAw9spm52nmnbggRznq22fUiEK2TXa6zsjPhJlAkTX++s?=
 =?iso-8859-1?Q?6GGAj7w6WepDr/dE5M0mwqts/KJKPvkX7g/FOhlANiJ/ulDP8woJXdwA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fa9724-29e0-4052-80f7-08d99aa6fd7e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 06:40:25.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ev4WsXDroAIS7Rbyw8LqrQSn2aN/SDsimZiWPOrKFIuv1ZTo3kyGH8uz9J2UoK4N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4594
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 4R1IoBlofBhXqQ2HRaJ-SUywk3TFkKrZ
X-Proofpoint-GUID: 4R1IoBlofBhXqQ2HRaJ-SUywk3TFkKrZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110290036
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 28, 2021 at 10:52:22PM -0700, Joanne Koong wrote:
> On 10/28/21 9:49 PM, Martin KaFai Lau wrote:
> 
> > On Thu, Oct 28, 2021 at 08:17:23PM -0700, Joanne Koong wrote:
> > > On 10/28/21 2:14 PM, Martin KaFai Lau wrote:
> > > 
> > > On Wed, Oct 27, 2021 at 04:45:00PM -0700, Joanne Koong wrote:
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h > index
> > > 31421c74ba08..50105e0b8fcc 100644 > --- a/include/linux/bpf.h > +++
> > > b/include/linux/bpf.h > @@ -169,6 +169,7 @@ struct bpf_map { The
> > > earlier context is copied here:
> > > 
> > > 	struct bpf_map *inner_map_meta;
> > > #ifdef CONFIG_SECURITY
> > >          void *security;
> > > #endif
> > > 
> > > >  	u32 value_size; > u32 max_entries; > u32 map_flags; > + u64
> > > map_extra; /* any per-map-type extra fields */ There is a 4 byte
> > > hole before the new 'u64 map_extra'.  Try to move
> > > it before map_flags
> 
> Manually resuscitating your previous comment back into this email ^.
> 
> After rebasing to the latest master, I'm not seeing a significant difference
> anymore with map_extra before/after max_flags. This is what I see when
> running "pahole vmlinux.o":
> 
> With map_extra AFTER map_flags:
> 
> struct bpf_map {
>         const struct bpf_map_ops  * ops __attribute__((__aligned__(64)));
> /*     0     8 */
>         struct bpf_map *           inner_map_meta;       /* 8     8 */
>         void *                     security;             /* 16     8 */
>         enum bpf_map_type          map_type;             /* 24     4 */
>         u32                        key_size;             /* 28     4 */
>         u32                        value_size;           /* 32     4 */
>         u32                        max_entries;          /* 36     4 */
>         u32                        map_flags;            /* 40     4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         u64                        map_extra;            /* 48     8 */
>         int                        spin_lock_off;        /* 56     4 */
>         int                        timer_off;            /* 60     4 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         u32                        id;                   /* 64     4 */
>         int                        numa_node;            /* 68     4 */
>         u32                        btf_key_type_id;      /* 72     4 */
>         u32                        btf_value_type_id;    /* 76     4 */
>         struct btf *               btf;                  /* 80     8 */
>         struct mem_cgroup *        memcg;                /* 88     8 */
>         char                       name[16];             /* 96    16 */
>         u32                        btf_vmlinux_value_type_id; /* 112     4
> */
>         bool                       bypass_spec_v1;       /* 116     1 */
>         bool                       frozen;               /* 117     1 */
> 
>         /* XXX 10 bytes hole, try to pack */
> 
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         atomic64_t                 refcnt __attribute__((__aligned__(64)));
> /*   128     8 */
>         atomic64_t                 usercnt;              /* 136     8 */
>         struct work_struct         work;                 /* 144    72 */
>         /* --- cacheline 3 boundary (192 bytes) was 24 bytes ago --- */
>         struct mutex               freeze_mutex;         /* 216   144 */
>         /* --- cacheline 5 boundary (320 bytes) was 40 bytes ago --- */
>         u64                        writecnt;             /* 360     8 */
> 
>         /* size: 384, cachelines: 6, members: 26 */
>         /* sum members: 354, holes: 2, sum holes: 14 */
>         /* padding: 16 */
>         /* forced alignments: 2, forced holes: 1, sum forced holes: 10 */
> } __attribute__((__aligned__(64)));
> 
> 
> With map_extra BEFORE map_flags:
> 
> struct bpf_map {
>         const struct bpf_map_ops  * ops __attribute__((__aligned__(64)));
> /*     0     8 */
>         struct bpf_map *           inner_map_meta;       /* 8     8 */
>         void *                     security;             /* 16     8 */
>         enum bpf_map_type          map_type;             /* 24     4 */
>         u32                        key_size;             /* 28     4 */
>         u32                        value_size;           /* 32     4 */
>         u32                        max_entries;          /* 36     4 */
>         u64                        map_extra;            /* 40     8 */
>         u32                        map_flags;            /* 48     4 */
>         int                        spin_lock_off;        /* 52     4 */
>         int                        timer_off;            /* 56     4 */
>         u32                        id;                   /* 60     4 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         int                        numa_node;            /* 64     4 */
>         u32                        btf_key_type_id;      /* 68     4 */
>         u32                        btf_value_type_id;    /* 72     4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         struct btf *               btf;                  /* 80     8 */
>         struct mem_cgroup *        memcg;                /* 88     8 */
>         char                       name[16];             /* 96    16 */
>         u32                        btf_vmlinux_value_type_id; /* 112     4
> */
>         bool                       bypass_spec_v1;       /* 116     1 */
>         bool                       frozen;               /* 117     1 */
> 
>         /* XXX 10 bytes hole, try to pack */
> 
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         atomic64_t                 refcnt __attribute__((__aligned__(64)));
> /*   128     8 */
>         atomic64_t                 usercnt;              /* 136     8 */
>         struct work_struct         work;                 /* 144    72 */
>         /* --- cacheline 3 boundary (192 bytes) was 24 bytes ago --- */
>         struct mutex               freeze_mutex;         /* 216   144 */
>         /* --- cacheline 5 boundary (320 bytes) was 40 bytes ago --- */
>         u64                        writecnt;             /* 360     8 */
> 
>         /* size: 384, cachelines: 6, members: 26 */
>         /* sum members: 354, holes: 2, sum holes: 14 */
>         /* padding: 16 */
>         /* forced alignments: 2, forced holes: 1, sum forced holes: 10 */
> } __attribute__((__aligned__(64)));
> 
> 
> The main difference is that the "id" field is part of the 2nd cacheline when
> "map_extra" is after "map_flags", and is part of the 1st cacheline when
> "map_extra" is before "map_flags".
> 
> Do you think it's still worth it to move "map_extra" to before "map_flags"?
It looks like there is an existing 4 byte hole.  I would take this chance
to plunge it by using an existing 4 byte field.  Something like this:

diff --git i/include/linux/bpf.h w/include/linux/bpf.h
index 50105e0b8fcc..0e07c659acd4 100644
--- i/include/linux/bpf.h
+++ w/include/linux/bpf.h
@@ -169,22 +169,22 @@ struct bpf_map {
 	u32 value_size;
 	u32 max_entries;
 	u32 map_flags;
-	u64 map_extra; /* any per-map-type extra fields */
 	int spin_lock_off; /* >=0 valid offset, <0 error */
 	int timer_off; /* >=0 valid offset, <0 error */
 	u32 id;
 	int numa_node;
 	u32 btf_key_type_id;
 	u32 btf_value_type_id;
+	u32 btf_vmlinux_value_type_id;
+	u64 map_extra; /* any per-map-type extra fields */
 	struct btf *btf;
 #ifdef CONFIG_MEMCG_KMEM
 	struct mem_cgroup *memcg;
 #endif
 	char name[BPF_OBJ_NAME_LEN];
-	u32 btf_vmlinux_value_type_id;
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
-	/* 22 bytes hole */
+	/* 14 bytes hole */
 
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
