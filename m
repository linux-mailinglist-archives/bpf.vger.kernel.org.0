Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E017598CF1
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 21:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiHRTzG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 15:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiHRTzF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 15:55:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A95CE483
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 12:55:03 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IJeNqf003507;
        Thu, 18 Aug 2022 12:54:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=pP4XuPtlREEkUvEZXF9Sa+coVvZa7zJXtV80MIpZHi0=;
 b=ejvDClRQKxYEjBUJKkPdWIbcSsX2ewiwjQpE5fqAgzQf3UyK+Akl+5DiqQJq90Vl3lAF
 G4sqe7iwgfCbEHAWo1h2hlvLMAiP64kUiNTjH+Ota/W/9hc+c00gkC7vuhZHEFFp0WW5
 XCshJxDftGYhO8nYnB1D7SMuG7vNWtPTmto= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j1ajd6ber-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 12:54:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ky4fG//LJZxQB+y4kgoEnzCftKguOyPTNt6uHvmc1U+/yUS+nrzVfWn8xLV/563vip4f01dbfg4NTO/Uwx78hqhH7dVZBxj6Nh/oEpKiywpDS7hcUbOmLhGInZQeAJfubXp9oWAG0Sq6XGOgA9iF6OwxMOgCay1EicsRTNqapFiBwCQqQwGPVvBhTUIlHcU/nWYbo6DYF38qRdTMR0qgW7rVqeF9iZncHpnZ6PCIKX7wqK1t3WnuihfP3V/MMg9U49EjbY+l50mp3bw8DvvCxZObP0nVNsa8BWel6o4HOdpmLsPk3g7s6Ip2L+G9u3SYUK8Y0FJb1oruQ8XrYrm95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP4XuPtlREEkUvEZXF9Sa+coVvZa7zJXtV80MIpZHi0=;
 b=P6z6jeKKfU2DNMn+vi2/hCzLv6lQkGHmIVxt7B4DbE/r7yZsJq6LEsLqwdquc6X+oVxomALYsNQR7Y8J5F4aDYIvGqvVbIwZHVusabmmHMVUspYXXZHOhR7LaFfRRCe0IL583LUdT2oi4zM+wwzrplQBrfR/jN7CuNw8zUXqb7CddT4jtgViXTmNp/jFm6RcWFlKgtHbHvGxxG/b6m8fCZVp4ZDcR3flCHWedGZmfh3rv2E8e/CulBT5i+MhlwUoR7Ef+t94K6eNAEb6FZmUlrDt1Oo6oDCT5QbvCKaM+3u9HhGjBMku08CiVyAE5J3uTG6BN+u1IHUfAigWHtlxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BN7PR15MB2466.namprd15.prod.outlook.com (2603:10b6:406:8d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 19:54:41 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%5]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 19:54:41 +0000
Date:   Thu, 18 Aug 2022 12:54:39 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v2 0/3] bpf: expose bpf_{g,s}et_retval to more
 cgroup hooks
Message-ID: <20220818195439.prc6agfycoradiwx@kafai-mbp>
References: <20220816201214.2489910-1-sdf@google.com>
 <20220817190743.rgudkmzunhtd5vxf@kafai-mbp>
 <CAKH8qBukudivY5XMwq6k42oUmHdAnbBAw2AjMeBT+Qnj3OZZhQ@mail.gmail.com>
 <20220817232736.6j7axkx4qpujusco@kafai-mbp>
 <CAKH8qBuk_DWPohB5whU-7teqh5XKN+HiMeafAwkodkB8mEo1YQ@mail.gmail.com>
 <20220818002144.2rk4yrmhqgivlqke@kafai-mbp>
 <CAKH8qBtY2wUy4U+pkEr14LrJxJBFfDdGk8wQxbBn=42Muw0g1w@mail.gmail.com>
 <20220818181556.3o37jnz6ov63gftb@kafai-mbp>
 <CAKH8qBsJFDW-a-PMVOssVXbYEPEhKKi2v2tZj+uTBeNHZ5wO4w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBsJFDW-a-PMVOssVXbYEPEhKKi2v2tZj+uTBeNHZ5wO4w@mail.gmail.com>
X-ClientProxiedBy: BYAPR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::43) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9b0420b-ad97-4a62-5a8a-08da81537d93
X-MS-TrafficTypeDiagnostic: BN7PR15MB2466:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxWKDJEPf9DENN7NQuo+hzaHH4n5BiPNXsvzpHPK3VgJEyiuJyo9mGP0k5hPPDTJrj6orBRZFds7KirZLaJUzEg7HgXE3u/zzATDztjSTYLdP0IN9X5iTlxl78K6qxKAHgXQfsZfs3AaH4oY4Fx7YUmP3QInmNWgHwVkE/v3HYslA2m5/UkP6XCMMGrBbLvSJg9lRtT+u+qKu93EsVbQspDI1Tut1EEFeSqZavp9JIiEscLQHlOgWIx36WeQRCxgvizkfxA9XySbM7MIL7J1IJuxB36gpvEJM5TyzMRRCCmgYdWotzsLkJ//ylHITQ+PnPsrizNQM3VMtNSs1JEvpcxTWUDZPYskeMRAqtDv0i4SOt872nfRe04n4Rs4ZJrnmo+2IcsRBtNhgBlw1BrOFR018HeHHSgHoRRcgpa6xjM0g+vSJgWr/6XQWPIAM/XMxJiFTsZY3JKNEzfNCCud66oJNx5MdgYclEoYXHipgY7/a2nT5kg6E9ABsCs/8XINhBzcRtv5FR1m8gylY7MF/CjoXogRK6bRxQYox/yfF4sC8PDZ6R9BcKp8lmxGrOQYmqQx1SRyhkD390aFVbtSf9RU9oKRv05QoELGvdvoB/wXEfMthCGN8U158hqcMcTzvmgcRDSoPXWsIDD3K4OhmLUE4W/XEso7XViFTsp2P0NIiwy60tSvm0EylhzYbxehJ5Jiu8Mnqwo7Le26MlOM7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(86362001)(38100700002)(66556008)(8676002)(66946007)(66476007)(316002)(4326008)(7416002)(52116002)(53546011)(6486002)(478600001)(8936002)(83380400001)(5660300002)(6506007)(1076003)(41300700001)(186003)(6916009)(9686003)(2906002)(33716001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/LHg8YXXbmF8LwnAE6fSlLxxxJw+9I3P809KiN7+IeJ2YQrWCEzby0rD2AD?=
 =?us-ascii?Q?nEEahQ8ZCMKni1u4htR6tKtn9jpIcZ2dwVOiDZkF2KmMNKQ4N8t/nohuFS5P?=
 =?us-ascii?Q?Yg3hxYY3z2+2Bwa2gUW9FnruNEe8QNmEfL5dCwhmVJ20KjBEgqemgvI/N/v7?=
 =?us-ascii?Q?EEmZVaviARgWN7tLvHnkP4LHZktGyU3rh5egXtVSQDNzucHGDaozUs/xFYmg?=
 =?us-ascii?Q?EQJGFYi/lGtMPLZt8PQwb5IftJ45pEcyqLefSJVLlq7yz0qt/vWnTw+mC8jy?=
 =?us-ascii?Q?Ylaw8wZui2geY8PI4ttT8uUJDtIRkJxmAkTVAjR1NmiKNg2D+Uf5zjkmBixe?=
 =?us-ascii?Q?61d1JdoBUfzATLnnxegOMVCkHGXMkarS9uMfEMWq1w2yzebnvgCkyl18eDmt?=
 =?us-ascii?Q?tjFUZ8mOXqt7N7En4EbGsKv/N0V0s9nPuFsxiShhZMsZ90g7kDWWaPoAq7DR?=
 =?us-ascii?Q?sFTGPv0M2zUPJJ5IDOqFFXXu4j8EMS09nTgAhxtRIUwXr+wGYH1rIa/wGOda?=
 =?us-ascii?Q?BCRI3SUZCDCqaTSIYuMATP7pSnCnR1gnzhDpNW+9FWc+0rlOhrL6NUeR3WKc?=
 =?us-ascii?Q?ekLVy5ibfLlyYYFW5IyfpoDvNCD9iYFR8lOq28sSm4ma+bi8ms6F+wKsxh7s?=
 =?us-ascii?Q?1n5yGrpVajfVND1K2lR3qe3zHIKnqSYbYphThyJ+dE0425A9b0gNzYPPhNBb?=
 =?us-ascii?Q?o1C4MYLshdOBapdwrhzhleJRHPzg4N61/kdsXqp3I0WP8MEHOBzH1aa2gOMF?=
 =?us-ascii?Q?uI6+diI8Zp9uI1ybJfTwHOzds9jIfFTzOw27npUJ++CDsCrDs6sVL3SN20IA?=
 =?us-ascii?Q?sTE1cm9s5bClWyn6FzEUjvncD+Y1W4/AiUiqmNuWCE6n2X/bI8X2aySQ1EL/?=
 =?us-ascii?Q?+wU+MZpFVVfvGaNRPEtoAACkKuxr4HXnOiut0ddkWy0Os7tCrJk+9q1HAyX8?=
 =?us-ascii?Q?bQnPkmFhvCUJZBxmMLpwim37/8oBY9QbHawYT2fnQnMVHCO8rCV28XYaXOUF?=
 =?us-ascii?Q?5jMfo/oE2L9dkSFZVHQO1DqOJn5WuszbA7X76xZsPMqWMlYFCIlP3qvp1cuj?=
 =?us-ascii?Q?SZRjFKkYmAD7FUE43dfyDD6I+6WXJdheJ0g6mtwA6+A00TEcQU1JhVJn0GkN?=
 =?us-ascii?Q?vWUDgKr/G/muNVDnu27T4mq+wSD3QpaiDR1bFo8BAxKRs3RGSBytL9+sTE3m?=
 =?us-ascii?Q?kL8PfQqP1ep/nJDlVD7a8roTClOkzyzsMUJO4ZtVmsbMtEQU0LwvDkgbELHg?=
 =?us-ascii?Q?7Vih2oEXZ5tUspIaKh3XrXSHRw69qlRT2DMy/M2WES0yKsk5r5OpiyUltmzJ?=
 =?us-ascii?Q?C/OnHsyZV294ulqe8kjmrOF7S2hLp+KQ0YTz9fOsJX4KcikOoGIlFQUGc1jA?=
 =?us-ascii?Q?boHWp/vGHd8Bs/uKBCqkGP0uj/xBXrhVufdmnlHC0CZvemprJv8N8f7BKNyX?=
 =?us-ascii?Q?fRuK9XaEeULL8P14Cs8jy8/D3t2yQg9kVfZGd4eQfsKaQj6B2tyZKprS0a6K?=
 =?us-ascii?Q?rk7HQpcd/yopqODjOb1a6QVDO+nOgz3F1ZmLf1bhWBmeWK87z1gFpWL8qWY8?=
 =?us-ascii?Q?b8heILgosiEWemM8Hy3EVP2LrusOpD+qrIN4AbwuxLDYRtQVu12x7KC431PL?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b0420b-ad97-4a62-5a8a-08da81537d93
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 19:54:41.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BimJz6rmbgKys5Xe3NG+Yn4DdeRVklC23NEjep5RBqKY8JNdBfFZkCU6oQkpnEao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2466
X-Proofpoint-GUID: lOcbrAWD2n_m6ZcJ055ldBiKcPbYqn3q
X-Proofpoint-ORIG-GUID: lOcbrAWD2n_m6ZcJ055ldBiKcPbYqn3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_14,2022-08-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 11:30:21AM -0700, Stanislav Fomichev wrote:
> On Thu, Aug 18, 2022 at 11:16 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Wed, Aug 17, 2022 at 08:42:54PM -0700, Stanislav Fomichev wrote:
> > > On Wed, Aug 17, 2022 at 5:21 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > On Wed, Aug 17, 2022 at 04:59:06PM -0700, Stanislav Fomichev wrote:
> > > > > On Wed, Aug 17, 2022 at 4:27 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > > >
> > > > > > On Wed, Aug 17, 2022 at 03:41:26PM -0700, Stanislav Fomichev wrote:
> > > > > > > On Wed, Aug 17, 2022 at 12:07 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Aug 16, 2022 at 01:12:11PM -0700, Stanislav Fomichev wrote:
> > > > > > > > > Apparently, only a small subset of cgroup hooks actually falls
> > > > > > > > > back to cgroup_base_func_proto. This leads to unexpected result
> > > > > > > > > where not all cgroup helpers have bpf_{g,s}et_retval.
> > > > > > > > >
> > > > > > > > > It's getting harder and harder to manage which helpers are exported
> > > > > > > > > to which hooks. We now have the following call chains:
> > > > > > > > >
> > > > > > > > > - cg_skb_func_proto
> > > > > > > > >   - sk_filter_func_proto
> > > > > > > > >     - bpf_sk_base_func_proto
> > > > > > > > >       - bpf_base_func_proto
> > > > > > > > Could you explain how bpf_set_retval() will work with cgroup prog that
> > > > > > > > is not syscall and can return flags in the higher bit (e.g. cg_skb egress).
> > > > > > > > It will be a useful doc to add to the uapi bpf.h for
> > > > > > > > the bpf_set_retval() helper.
> > > > > > >
> > > > > > > I think it's the same case as the case without bpf_set_retval? I don't
> > > > > > > think the flags can be exported via bpf_set_retval, it just lets the
> > > > > > > users override EPERM.
> > > > > > eg. Before, a cg_skb@egress prog returns 3 to mean NET_XMIT_CN.
> > > > > > What if the prog now returns 3 and also bpf_set_retval(-Exxxx).
> > > > > > If I read how __cgroup_bpf_run_filter_skb() uses bpf_prog_run_array_cg()
> > > > > > correctly,  __cgroup_bpf_run_filter_skb() will return NET_XMIT_DROP
> > > > > > instead of the -Exxxx.  The -Exxxx is probably what the bpf prog
> > > > > > is expecting after calling bpf_set_retval(-Exxxx) ?
> > > > > > Thinking more about it, should __cgroup_bpf_run_filter_skb() always
> > > > > > return -Exxxx whenever a -ve retval is set in bpf_set_retval() ?
> > > > >
> > > > > I think we used to have "return 0/1/2/3" to indicate different
> > > > > conditions but then switched to "return 1/0" + flags.
> > > > For 'int bpf_prog_run_array_cg(..., u32 *ret_flags)'?
> > > > I think it is more like return "0 (OK)/-Exxxx" + ret_flags now.
> > >
> > > Yes, right now that's that case. What I meant to say is that for the
> > > BPF program itself, the api is still "return a set of predefined
> > > values". We don't advertise the flags to the bpf programs. 'return 2'
> > > is a perfectly valid return for cgroup/egress that will tx the packet
> > > with a cn. (where bpf_prog_run_array_cg sees it as a 'return 0 + (1 <<
> > > 1)')
> > >
> > > > > So, technically, "return 3 + bpf_set_retval" is still fundamentally a
> > > > > "return 3" api-wise.
> > > > hm....for the exisiting usecase (eg. CGROUP_SETSOCKOPT), what does
> > > > "bpf-prog-return 1 + bpf_set_retval(-EPERM)" mean?
> > >
> > > I think bpf_set_retval takes precedence and in this case bpf_prog_run
> > > wrapper will return -EPERM to the caller.
> > > Will try to document that as well.
> > >
> > > > > I guess we can make bpf_set_retval override that but let me start by
> > > > > trying to document what we currently have.
> > > > To be clear, for cg_skb case, I meant to clear the ret_flags only if
> > > > run_ctx.retval is set.
> > >
> > > Are you suggesting something like the following?
> > >
> > > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > > index fd113bd2f79c..c110cbe52001 100644
> > > --- a/kernel/bpf/cgroup.c
> > > +++ b/kernel/bpf/cgroup.c
> > > @@ -61,6 +61,8 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
> > >         bpf_reset_run_ctx(old_run_ctx);
> > >         rcu_read_unlock();
> > >         migrate_enable();
> > > +       if (IS_ERR_VALUE((long)run_ctx.retval))
> > > +               *ret_flags = 0;
> > >         return run_ctx.retval;
> > >  }
> > >
> > > I think this will break the 'return 2' case? But is it worth it doing
> > > it more carefully like this? LMKWYT.
> > The below should work. Not sure it is worth it
> > but before doing this...
> >
> > During this discussion, I think I am not clear what is the use case
> > on bpf_{g,s}et_retval() for cg_skb.  Could you describe how it will be
> > used in your use case?  Is it for another tracing program to get
> > a different return value from (eg.) sk_filter_trim_cap or ip[6]_output?
> >
> > Not meaning the helper should not be exposed.  It is easier
> > to think with some examples.
> 
> I don't really need them in cg_skb, I want them in cg_sock so I can
> return a custom errno from socket() syscall.
bpf_{g,s}et_retval() will probably be useful for sock_addr too.
There is a BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE falling
into a similar bucket.  However, I think it should be fine
since the higher bit is only used when the bpf prog
returns OK.

> You're probably right and it doesn't make sense to support them in
> cg_skb. Most of the
> BPF_CGROUP_RUN_PROG_INET_INGRESS/BPF_CGROUP_RUN_PROG_INET_EGRESS
> callers don't seem to care about returned error code? (from my brief
> grepping)
> Let's maybe err on the safe side and special case cg_skb for now (in
> cgroup_common_func_proto) and not expose retval helpers?
Ah. I was under the wrong impression that you have a use case
on cg_skb because cg_skb_func_proto was in the stack
example above :)

Yep, lets disable the bpf_{g,s}et_retval() helper for CGROUP_SKB
and also SOCK_OP(S) for now.
