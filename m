Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECE157BF5A
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 22:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiGTUxZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 16:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGTUxY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 16:53:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A272250720
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 13:53:23 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26KJxaaw015407;
        Wed, 20 Jul 2022 13:53:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=97F+yaQPZqSgx35fGDWVUgWcXURqKu35LvF1jH/E418=;
 b=NJnFnMcvyU1HuTk4dXWUHISee9+091dFXFk/49w7uM71kLU8zcMKwLMGVIGlnlRmKAGi
 lq0IxwXFlJg7Am7oBEjAgLRdiTxtPOZahx7XaZOCOoATlXqzYMxe3cjDiXF623OI++HU
 DPLX8iHigjh4wKGmNcp2BMvQfmv0R3GLBVI= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hdv8fas77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 13:53:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BClpRoXzLXfiOTiZE+gKULfa93l/DU8+PgxD4ash1g89OXfiDPhZA9PcxKGumDjPaRDW/i2RA0EoNU/8TFiZEn9ROyy7N0OlikcadKy/xePPc+P6Uf+5J5nk9jti+S6n1LGw8ukoe5YFBe22fkGtYWmPmx2U5q4SZvjjCy03H1Vxn4nlTLICWaFL+jI/T/veJAK4mZu4jdiFlN7mkfCC9F9l81cKbfWejbM6A2eUak4abqZh3AQYRQEiXi3G+PUrPnPKDQ2qWjLUq7K700btBBmp5dHJBmXuQQq+z3t55ctQvNG7ntr3Nr6yp3/soXJhm7fp8gQVVtbEZTHZ2H11Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97F+yaQPZqSgx35fGDWVUgWcXURqKu35LvF1jH/E418=;
 b=P0pUXkPY2uUMPAxdi+174nd/i9UqMTqA39B4shQk7uTVwMOjemkeZPDaU0qLKQjDmFy1MSDgWM9Pu7tDLQFgu7GDnqX6m/fvXgRCXIM9lJO6zeekMBf+aY6CEdLKwe+iFWzlkzGVcVPiMMFj+E9X8+cCPGrL1thIQI9YjUfJORhWeNDhxr6OFuHnZcin3V3LPMpgqxeJ5I72SGxDjDbEB0xzXOxUcd7nmQ42+lrK3jSF+yv/bXJfFrLj2xabOU8rF7Vxc/ph09sPAAA32/jFagGwg36kR/ns46LNmEK1JnvDazNAVH1MUw5tAqtLnWvw9yCxHYIAo/Ps8tSdwbPjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM5PR1501MB2103.namprd15.prod.outlook.com (2603:10b6:4:a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 20 Jul
 2022 20:52:57 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%8]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 20:52:57 +0000
Date:   Wed, 20 Jul 2022 13:52:55 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     sdf@google.com
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] RFC: libbpf: resolve rodata lookups
Message-ID: <20220720205255.4v3y3a4xttesfkn6@kafai-mbp.dhcp.thefacebook.com>
References: <20220718190748.2988882-1-sdf@google.com>
 <CAADnVQLxh_pt8bgoo=_CS3voab7HuQautZGfHQMM=TmQmVr2pQ@mail.gmail.com>
 <CAKH8qBv9q=eXBq9XSKEN2Nce5Wf0MJEX_zbTi12p4r3WCjmBEw@mail.gmail.com>
 <CAKH8qBv66=Fdea0u-vbu-Q=P9pySo+tjy5YpPPcNo8dF0qN8bw@mail.gmail.com>
 <CAADnVQ+Gmo=B=NpXofq=LmFq6HsJZ-X9D1a4MwSLK3k_F9SEqg@mail.gmail.com>
 <Ytc8RvDTpEmC0pQD@google.com>
 <YthDy8uhE2ky0rBr@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YthDy8uhE2ky0rBr@google.com>
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea370dd3-3485-4d12-1cc3-08da6a91d35d
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2103:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzV3GpBVTUirmOLFZYQYmaqpx/qaiAEiM4LdaDmdEkJUOILtbaa8jCZkQgTI6mF7fwu45+pYSdFK+V6bticn983N7HF1+2Ok+caSZCQ/rSXpsWd4PhFwflmdk6lhguiO5/tC3rNKNXodP/o69r4OyiEZJOhIFZA5cSmOMej8cjsmqzCya7HJYPfb4mm3VgUWWQL2Ddjqpmc1frgk4co+i++fGp2Ya08JBYrubMG9she1r8Ayh4i0VaN6+55DrUCjEXY8aJqynxE2nGyCirR6I/jY2oBSJBOyLZeQ28BZVO66SFCefkvHlmtUcQxsZuYSsdaqi1IM7J46a7Yoy0TUwqBiIFQCUc9ZAY9klgSX18ND+6Cm8EQStPRL0F8mpkG9HQvp7hBe09PUUX1zN2/9RBfSjmY42Jjwc/5OZiGDTrDJ7Bn4idL+VaXfxSjyWFm5bmK1CSLtKMqeUlpGnwvqeiGBqU//Bs2NXUCTPWHDyfuA9a7tDZ3KF7xNtR/1qgs1PqfR0Ur8zsvtMX+VJxh571ooioDWZJBGtSjTWnd47cBq96ucGgtjMEyyP46OwAAIM/61qEvbtQC6Mtka5eHpvxIXeOYwx9v1l1qKvDq3oms8LzKrTS8RioxEyJq7y2Qsn2E/rnde4cGSuaqYP6ZKWjcSyLoCMuvEDilIwfuALau+AQs2K4s5BR3HNmg6raDUUyoZhVsIdlVAaYekw83aBI3/3tDUqmUPUsaqQkCx9H6B8jweUnmngjnl5zunAdY5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(83380400001)(66476007)(38100700002)(186003)(66556008)(1076003)(316002)(4326008)(5660300002)(54906003)(8936002)(66946007)(6916009)(8676002)(7416002)(6512007)(52116002)(9686003)(6506007)(41300700001)(53546011)(6486002)(478600001)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4dVbqfD4yQDZhUxJUUp0u5zu8C2MgkqpIljqXY3CvqgtrQ/DRU477ip6IchY?=
 =?us-ascii?Q?iD3NimGp6oM88wUue4sJx63w3KQREZn6XbZgxL8Rc7Mwa0wTxr4JECQ+1aC1?=
 =?us-ascii?Q?SEdTpfSM8WXn7B6VO0j98o0K0lnRUyqX5bikRQIf8WDHaf7K7Q4VPcecC4Zw?=
 =?us-ascii?Q?AtEh+h2Vs/5/MTNPWPgH0dxSI1udAXqTV+hDvVTry+9Vkv1PUdw/antXEZp6?=
 =?us-ascii?Q?CyZBGsbWuL5hqTYo1OXOvj32SYDYoh7VssJAd/RVpoStCIgTnNAMN/wmtT2J?=
 =?us-ascii?Q?y5WFJ7vKwcIkdEa1HXNTUE0ueOW7ZdMsB+oGpJ+TPDwBQVYEjdp95/XYNNDu?=
 =?us-ascii?Q?inhrWS5/5wjKF2GvwohIZLRDpM6iT0AImI0jYYPSDEhegzawNem+WBUk/U7L?=
 =?us-ascii?Q?0xDSB/APFifJ23pJPTV//rsxZP1O/j92j/O5xqw0nbttto91IqLMA7/vjbFe?=
 =?us-ascii?Q?Zpqat4cTfH5KvokO7szqiSiU+WqCpaCZiLlsUifajmLLyhTIa8HdTcLtioM2?=
 =?us-ascii?Q?62nr8WbGt/mIQEOiHs57QBLjPAmdt4Aftw3StMo5NAzPtrVYxjx5CpgOLv65?=
 =?us-ascii?Q?dnffgNMUaGh+X1fAAxDs8vAWg9t4DUx6Vdu2V4klvwOl2lztDxVnBlgmCJBs?=
 =?us-ascii?Q?68YL/2FAyASuirnp/KTR2031s3BcxuizlaznbestP66y1hAtrNzELPHNuans?=
 =?us-ascii?Q?6y/IkHXaQA1mNXcaVCqPcnNA9VB2T2FenL/Ae45SpT/7oyz6d3YyS/rYg7Ij?=
 =?us-ascii?Q?M9t4kyqJtDQ/xw5D6oOZLPJWmMpxX6w5sBB8duzfDZV990cGTTUS3QL7Ge1z?=
 =?us-ascii?Q?wsgJ5ZSKiqgAZVYW4U/wg1f8U7sLVv6EPR1BRAQDws0GX1yE+f5U9hmvHIpO?=
 =?us-ascii?Q?B3NciTA/mozFL5Zo0jq/ivt/hAhGubBWuJjfcHc3G6F7ktQifp2oqK911Gqi?=
 =?us-ascii?Q?zHoj4/w8CYx5NHp9K69pgOtqEAoWD269KpLCuSkAJstJtDJ2qnq7NlasvbGi?=
 =?us-ascii?Q?JWjMeAEgpChI1RuDtcMIYsBTSBz0VWqx89tlTyz/X6H9TxhzrNEik9grFPqE?=
 =?us-ascii?Q?uXna5yGXBob/QNHTKlDtUjVm7EC8CLMYWkLVfVlpHA7KyGJaN4lyoSqO7wI9?=
 =?us-ascii?Q?YHnVTdg3iRhRcVceh/NYb3ZWd2o5FLtAQfXibCG1QW8nkOC8MQusd+bkxuKo?=
 =?us-ascii?Q?3tKcOEHFWDLD3h358COTIkBsJ7smnDHU4p35sel5LCJQ1D5eZDdXq+JzSdsD?=
 =?us-ascii?Q?koILj4KqeJs8Mrd2LzgiPWiDEdTZXnfWZPS/D6sKzpBddT8T/iZBK6x7r0wN?=
 =?us-ascii?Q?nP76qOJWtOwiyf3XhBQ1afWl6VyNxL1QehqNGFaZnu1Wiphjtd5mw0K0lOQO?=
 =?us-ascii?Q?S6EYJ0eUMB7FaJi9Yi0OJ/1nIDiyRo1nBWvUeD1+2lhnj1RF+FBkoD06G7ZT?=
 =?us-ascii?Q?yNAMzC277htl1WPxJRdBw4lx9fyXsKaRlKRGS3ESFCuO9oS2adn8Sq9Qwv7U?=
 =?us-ascii?Q?vsQ/RYe823q9HN6oc0OqNuA+0nRbJh1MJFmD/yTQhgz3jvOt5t2vbthe8hL1?=
 =?us-ascii?Q?d+uZzfIw+ur5hvdA31HiWMu4tzwLfq0sD/VkRmeCBZUO9ks0yDp5zHg+I1rp?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea370dd3-3485-4d12-1cc3-08da6a91d35d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 20:52:57.7430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /T5WtUjULn0nUOCJDHR8tkQYBwSYNCYv2Tc0w/lJRZ0rqxjhsOU0jMSRkFrMAHiV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2103
X-Proofpoint-GUID: CVxxvtzEye-yi24nE8wUjzBv5h488qNz
X-Proofpoint-ORIG-GUID: CVxxvtzEye-yi24nE8wUjzBv5h488qNz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 20, 2022 at 11:04:59AM -0700, sdf@google.com wrote:
> On 07/19, sdf@google.com wrote:
> > On 07/19, Alexei Starovoitov wrote:
> > > On Tue, Jul 19, 2022 at 2:41 PM Stanislav Fomichev <sdf@google.com>
> > wrote:
> > > >
> > > > On Tue, Jul 19, 2022 at 1:33 PM Stanislav Fomichev <sdf@google.com>
> > > wrote:
> > > > >
> > > > > On Tue, Jul 19, 2022 at 1:21 PM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Jul 18, 2022 at 12:07 PM Stanislav Fomichev
> > > <sdf@google.com> wrote:
> > > > > > >
> > > > > > > Motivation:
> > > > > > >
> > > > > > > Our bpf programs have a bunch of options which are set at the
> > > loading
> > > > > > > time. After loading, they don't change. We currently use array
> > map
> > > > > > > to store them and bpf program does the following:
> > > > > > >
> > > > > > > val = bpf_map_lookup_elem(&config_map, &key);
> > > > > > > if (likely(val && *val)) {
> > > > > > >   // do some optional feature
> > > > > > > }
> > > > > > >
> > > > > > > Since the configuration is static and we have a lot of those
> > > features,
> > > > > > > I feel like we're wasting precious cycles doing dynamic lookups
> > > > > > > (and stalling on memory loads).
> > > > > > >
> > > > > > > I was assuming that converting those to some fake kconfig
> > options
> > > > > > > would solve it, but it still seems like kconfig is stored in the
> > > > > > > global map and kconfig entries are resolved dynamically.
> > > > > > >
> > > > > > > Proposal:
> > > > > > >
> > > > > > > Resolve kconfig options statically upon loading. Basically
> > rewrite
> > > > > > > ld+ldx to two nops and 'mov val, x'.
> > > > > > >
> > > > > > > I'm also trying to rewrite conditional jump when the condition
> > is
> > > > > > > !imm. This seems to be catching all the cases in my program, but
> > > > > > > it's probably too hacky.
> > > > > > >
> > > > > > > I've attached very raw RFC patch to demonstrate the idea.
> > Anything
> > > > > > > I'm missing? Any potential problems with this approach?
> > > > > >
> > > > > > Have you considered using global variables for that?
> > > > > > With skeleton the user space has a natural way to set
> > > > > > all of these knobs after doing skel_open and before skel_load.
> > > > > > Then the verifier sees them as readonly vars and
> > > > > > automatically converts LDX into fixed constants and if the code
> > > > > > looks like if (my_config_var) then the verifier will remove
> > > > > > all the dead code too.
> > > > >
> > > > > Hm, that's a good alternative, let me try it out. Thanks!
> > > >
> > > > Turns out we already freeze kconfig map in libbpf:
> > > > if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG) {
> > > >         err = bpf_map_freeze(map->fd);
> > > >
> > > > And I've verified that I do hit bpf_map_direct_read in the verifier.
> > > >
> > > > But the code still stays the same (bpftool dump xlated):
> > > >   72: (18) r1 = map[id:24][0]+20
> > > >   74: (61) r1 = *(u32 *)(r1 +0)
> > > >   75: (bf) r2 = r9
> > > >   76: (b7) r0 = 0
> > > >   77: (15) if r1 == 0x0 goto pc+9
> > > >
> > > > I guess there is nothing for sanitize_dead_code to do because my
> > > > conditional is "if (likely(some_condition)) { do something }" and the
> > > > branch instruction itself is '.seen' by the verifier.
> 
> > > I bet your variable is not 'const'.
> > > Please see any of the progs in selftests that do:
> > > const volatile int var = 123;
> > > to express configs.
> 
> > Yeah, I was testing against the following:
> 
> > 	extern int CONFIG_XYZ __kconfig __weak;
> 
> > But ended up writing this small reproducer:
> 
> > 	struct __sk_buff;
> 
> > 	const volatile int CONFIG_DROP = 1; // volatile so it's not
> > 					    // clang-optimized
> 
> > 	__attribute__((section("tc"), used))
> > 	int my_config(struct __sk_buff *skb)
> > 	{
> > 		int ret = 0; /*TC_ACT_OK*/
> 
> > 		if (CONFIG_DROP)
> > 			ret = 2 /*TC_ACT_SHOT*/;
> 
> > 		return ret;
> > 	}
> 
> > $ bpftool map dump name my_confi.rodata
> 
> > [{
> >          "value": {
> >              ".rodata": [{
> >                      "CONFIG_DROP": 1
> >                  }
> >              ]
> >          }
> >      }
> > ]
> 
> > $ bpftool prog dump xlated name my_config
> 
> > int my_config(struct __sk_buff * skb):
> > ; if (CONFIG_DROP)
> >     0: (18) r1 = map[id:3][0]+0
> >     2: (61) r1 = *(u32 *)(r1 +0)
> >     3: (b4) w0 = 1
> > ; if (CONFIG_DROP)
> >     4: (64) w0 <<= 1
> > ; return ret;
> >     5: (95) exit
> 
> > The branch is gone, but the map lookup is still there :-(
> 
> Attached another RFC below which is doing the same but from the verifier
> side. It seems we should be able to resolve LD+LDX if their dst_reg
> is the same? If they are different, we should be able to pre-lookup
> LDX value at least. Would something like this work (haven't run full
> verifier/test_progs yet)?
> 
> (note, in this case, with kconfig, I still see the branch)
> 
>  test_fold_ro_ldx:PASS:open 0 nsec
>  test_fold_ro_ldx:PASS:load 0 nsec
>  test_fold_ro_ldx:PASS:bpf_obj_get_info_by_fd 0 nsec
>  int fold_ro_ldx(struct __sk_buff * skb):
>  ; if (CONFIG_DROP)
>     0: (b7) r1 = 1
>     1: (b4) w0 = 1
>  ; if (CONFIG_DROP)
>     2: (16) if w1 == 0x0 goto pc+1
>     3: (b4) w0 = 2
>  ; return ret;
>     4: (95) exit
>  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
>  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
>  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
>  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
>  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
>  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
>  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
>  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
>  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
>  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
>  #66      fold_ro_ldx:OK
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  kernel/bpf/verifier.c                         | 74 ++++++++++++++++++-
>  .../selftests/bpf/prog_tests/fold_ro_ldx.c    | 52 +++++++++++++
>  .../testing/selftests/bpf/progs/fold_ro_ldx.c | 20 +++++
>  3 files changed, 144 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fold_ro_ldx.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fold_ro_ldx.c
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c59c3df0fea6..ffedd8234288 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12695,6 +12695,69 @@ static bool bpf_map_is_cgroup_storage(struct
> bpf_map *map)
>  		map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
>  }
> 
> +/* if the map is read-only, we can try to fully resolve the load */
> +static bool fold_ro_pseudo_ldimm64(struct bpf_verifier_env *env,
> +				   struct bpf_map *map,
> +				   struct bpf_insn *insn)
> +{
> +	struct bpf_insn *ldx_insn = insn + 2;
> +	int dst_reg = ldx_insn->dst_reg;
> +	u64 val = 0;
> +	int size;
> +	int err;
> +
> +	if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr)
> +		return false;
> +
> +	/* 0: BPF_LD  r=MAP
> +	 * 1: BPF_LD  r=MAP
> +	 * 2: BPF_LDX r=MAP->VAL
> +	 */
> +
> +	if (BPF_CLASS((insn+0)->code) != BPF_LD ||
> +	    BPF_CLASS((insn+1)->code) != BPF_LD ||
> +	    BPF_CLASS((insn+2)->code) != BPF_LDX)
> +		return false;
> +
> +	if (BPF_MODE((insn+0)->code) != BPF_IMM ||
> +	    BPF_MODE((insn+1)->code) != BPF_IMM ||
> +	    BPF_MODE((insn+2)->code) != BPF_MEM)
> +		return false;
> +
> +	if (insn->src_reg != BPF_PSEUDO_MAP_VALUE &&
> +	    insn->src_reg != BPF_PSEUDO_MAP_IDX_VALUE)
> +		return false;
> +
> +	if (insn->dst_reg != ldx_insn->src_reg)
> +		return false;
> +
> +	if (ldx_insn->off != 0)
> +		return false;
> +
> +	size = bpf_size_to_bytes(BPF_SIZE(ldx_insn->code));
> +	if (size < 0 || size > 4)
> +		return false;
> +
> +	err = bpf_map_direct_read(map, (insn+1)->imm, size, &val);
> +	if (err)
> +		return false;
> +
> +	if (insn->dst_reg == ldx_insn->dst_reg) {
> +		/* LDX is using the same destination register as LD.
> +		 * This means we are not interested in the map
> +		 * pointer itself and can remove it.
> +		 */
> +		*(insn + 0) = BPF_JMP_A(0);
> +		*(insn + 1) = BPF_JMP_A(0);
> +		*(insn + 2) = BPF_ALU64_IMM(BPF_MOV, dst_reg, val);
Have you figured out why the branch is not removed
with BPF_ALU64_IMM(BPF_MOV) ?

Can it also support 8 bytes (BPF_DW) ?  Is it because there
is not enough space for ld_imm64?  so wonder if this
patching can be done in do_misc_fixups() instead.

> +		return true;
> +	}
> +
> +	*(insn + 2) = BPF_ALU64_IMM(BPF_MOV, dst_reg, val);
> +	/* Only LDX can be resolved, we still have to resolve LD address. */
> +	return false;
> +}
