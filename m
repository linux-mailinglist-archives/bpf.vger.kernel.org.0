Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6FA5874EC
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 02:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiHBA4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 20:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHBA4l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 20:56:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E607545041
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 17:56:39 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271NFiD7031221;
        Mon, 1 Aug 2022 17:56:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7zrv43mTCtr8BZ1JifQ8diHnZ54FTNjBRyFPQRZG7bI=;
 b=qeIsldIrNrp2xGGmDghcEDyYkjDNq/u1EnP9K1cdYBlgLDcT4E3OMbwM0dlLMBeZQWEw
 t6MCj8Jx5m45biHf7lwKVhmwmJprQHZyiO4njMyNBu7kYlnx0iLwXCiHgjXbP1G4KzDz
 x7l0o/1g3TRSdvapPEhHiM7Cm7KUXuMKi+E= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn3y3f5ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 17:56:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkSR4o8DUaxcXK4dtDZwIpchVoBjNl0H7LjNB6q8avSaw+0YwJUAzri8wUq+eeOo9w/PtkvaSedRmoa35NJfRqLt4Uujk2icS0qGYaHntnMq/V+qj09iAK4t2BadHJvNO6vS/bqXer7+GUEagtZ/LDDfo5Tyi4ZlnhwyN6QEb7LgsLN+OlbGLgaHEzVmkddpWTOi1O8aufG4IrMuvAD3iGW5CtGY6LpUXsTixcw93/0FSSceSKybmVFWABuMCACFjTzv9pLEDEVzyGJn37eNweh2+fxGDO8yvRScpBo3BdI99g7ZmjwD+MwC3MRwP7mmO50/xOClS/2a6NYxYgYziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zrv43mTCtr8BZ1JifQ8diHnZ54FTNjBRyFPQRZG7bI=;
 b=hRJq7XYPhRN8lWSyKqy5p035rXmO3o3R00n6WvJzM3rIFDofC4xwFJkPJRbnStSUUwETjpaYsnY4316VrN068YUIyiGcRxbyX/fv1zQ6giHz/vvBkUGlJNL7u2pccuFcTge9I8JPPt/rndJkL6DD5GTtLnXCY00VMtLcKiPUWWmajzybsxN/TqRDYw36+xkfpHAenwz550JLkNQH6nUTbEDweMrJlCNdwNnuIQkjSe9EyC5eH1b3sXbx5eIdWWST3uH+3/ebCkA93B8QxNMwtYAJYpAG6Dc4D6PFtwGE1JrtF12AkgGrspkM5cf+UKlXc9Nmdk0+T+A1JIkIfLfyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SJ0PR15MB4582.namprd15.prod.outlook.com (2603:10b6:a03:378::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 00:56:22 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 00:56:22 +0000
Date:   Mon, 1 Aug 2022 17:56:21 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220802005621.d6sjq72l357eesp6@kafai-mbp.dhcp.thefacebook.com>
References: <20220726184706.954822-2-joannelkoong@gmail.com>
 <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1YXSx11TGhKhAZ20R81pUsgBVeAooGJjTR7dR5iyP_eeQ@mail.gmail.com>
 <20220801193850.2qkf6uiic7nrwrfm@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1ZCQ5nRB=jBUxPFyS4OhMvDX1t4ddFYX2LqkepMZg-12w@mail.gmail.com>
 <20220801223239.25z2krjm6ucid3fh@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzbjFOXFYeRHwnny1p-GWfMDiOqC6zGMSBjGkjY8RQi5Qw@mail.gmail.com>
 <20220801232314.shzlt7ws3sp7d744@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801232314.shzlt7ws3sp7d744@kafai-mbp.dhcp.thefacebook.com>
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08694705-8fb9-47a3-810b-08da7421d1a0
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4582:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g277Q1RGOJiFgwhvsEbfYPiLFgbOdq/BxXUWLJ0bgaj8ZgQrXMaWfKJ2OTKWIfYOFWyRKJN+wzKhBooOYJ++8dYMN1Zv9405QiasTOy/k3k9C+uVkATMRSndWFaBShkP8ZtsQJfWtTEWfaW8MTvUdeI96fH0xGZcCKWnhELKAxgjuipbIsR404v2tRfdJ4/5/ib/KXzMsn3g9ebyX/NUU2vTCYKfdiEMPSZnkl0l7xAA590G6rpKXaPEzzH0GXU8WAxj8p5XN1PEQCU8OeeOKszKW5e0UsRN5fl3UZRqoPMUWF4FdDjaCwGlvXeCEz54MxhPrAyqYE0t38VxTiztg0Z7EUZhD6DtbRLPNJ9T23BevWwBnHKGhwfn+cXpoRKiSRLXHrMLKj6udD+zfAC7nhaAzTYoKOR0UoTnDI2YpF1nYJ2+HCYPrBC0YjBqpmPi3F71DY9tAoWZEaVgatqLPVKk7t6N/fOOfchYHxy8UJujsGwASdzjv/rDnNaCjIdNqdbeLO6DKoAEMWiMdOwvoNi2FBdfWz1zbzLMdrk87JLPzBuZsTCR+hSK9s0Q6B3ifYwlvjamyQJ/VMXneMzRbQwCwZMNvkCDY8jS+Krff4u685Mo48XZrEqIt+AcIWsZZ3U7Ml53w1+foitnu0zplnp6MllkuXHCJHljCu2LEQLKkLpUm2uCkhmAt9/x78EIo8cl6aUWzqQsai98sprbtk3AzPs1/o+p+jP3z6eQntXwMVAtN7dmchgCCn6S7I1I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(38100700002)(52116002)(53546011)(6486002)(9686003)(6512007)(6506007)(66556008)(41300700001)(478600001)(66476007)(5660300002)(2906002)(86362001)(8936002)(8676002)(83380400001)(4326008)(54906003)(316002)(6916009)(186003)(1076003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9OnbU8FVS3pryZdmspNi9gy9GcW0wBJlAj5TM1SQ0nB6tP2XSgMZIS5Qhyc9?=
 =?us-ascii?Q?z9vhspnWRyeHBHDS3CciDNukxY/gXYClmmOD5jH0oyOD3DUL2QImWnycCEIO?=
 =?us-ascii?Q?zqjUvlmThVG8lmC8ubqugGEtkEWsF7x3OxRLEa2gC5vjtwegCUuHc0/LmBZm?=
 =?us-ascii?Q?kjNhpTP5MBxuvGKQJv1ofF4lYe5PpoY+acPl3wLV0pzEUQ/Kx8WZGM2uizol?=
 =?us-ascii?Q?R+d7LTd12im7pXrUA05jtf9GD6vOkU2KaKwYUK1l0Z2BnlxmNxBLshuoiOVa?=
 =?us-ascii?Q?pf7lvgc0NkLOZTZyItGhrNiSi+M5fITJ/S0x73gkpbaosG9+4k2ZPgUvrvBW?=
 =?us-ascii?Q?H8CWoWMGrNZZR2nnoDoynwjFBBzoEKcpn0UBcSxBuHfzocqJmLswrta1K/d/?=
 =?us-ascii?Q?Jr1DcHauIJQImviCikvfqTApdZm9ALTVgtUoe1rOidUSAJJQ3Euf7iwSD30D?=
 =?us-ascii?Q?qMt/4JC3wyFC3cKtulTKrF8S6kLMHWlQIPg31E9FuucIxPnzudWeFMhoKtgb?=
 =?us-ascii?Q?6uihXEj8DEt6O+LhfuT3TtbB8bqJ00g1GN2H0VydGWxhCzru9Y4q8d9tC7R3?=
 =?us-ascii?Q?NsBiVyxkJWsgXMYRCQKvFhqViXbRUPyXt4lZ2+UrjoudngVsOki1pzrVszxv?=
 =?us-ascii?Q?Z1k1+Wmd9qet5BB4KmJzc527S0YBOZ1L/xRYY9rfMChHrpBpcfuTKWDE0hUq?=
 =?us-ascii?Q?LQgFMjj/ymvjbzyKwF/efn0hvo4FBf+UA0v09qoMpm2vClkRquCWuzKY3L2q?=
 =?us-ascii?Q?w8Q5kGOMe5oC77dZ3LL1Ds5O24Fs3jicKEsU41FVqZ7AADf/n7GQjWb46HiM?=
 =?us-ascii?Q?jXsjk3Pl9B7r2zFj+Ha5FdVFXxmkaqnYsGOXJwk+NBt7RS4Su20A7UKMPYju?=
 =?us-ascii?Q?OEThEFow7C8WsnnGJXakyNSXC8pm3Dq9h6LK5Jh+nKxNPWJDutMouhiglqwD?=
 =?us-ascii?Q?AUBssN9rphTrIZGwvs5rvjUYZK3/33xHLx+rMOGB5vcNKnuT0TFVMbzBh4ZD?=
 =?us-ascii?Q?/wExobwqHxXmLNlYEL5SDrdMMW6hjjKRepAA9Vx3DYn460/CmV+dFeJrnNMR?=
 =?us-ascii?Q?85kzXhkoz1dLRAoK5dCy+/Udn5FS07hZIYK3BHHvfrMcV5se6gek8WgbtKJM?=
 =?us-ascii?Q?sR6NHueGItJfqc7W9rh1UxpenbHSbVYGwt5YzPEdxB/EBtLJgafg3tV3/XTT?=
 =?us-ascii?Q?g2lgWsxc9volSiMg2z/unrC0MYGr6Nf3yWiPg2TvvQfrzddJz4Hn4xdAaKuY?=
 =?us-ascii?Q?CggRLT3m/++jzJYP0Y4+PdGyMO+Q/LblIQAMryNV8w3Q4cXRk0JWnFAAfJ9p?=
 =?us-ascii?Q?2bidSOPJNz7Hj+E+6xAW9VdWU816L9J0TpAlGPANrTAn8AtQFmFNuyqT5H3k?=
 =?us-ascii?Q?bHaAddx52X6Ba4ni+jNgCNVAa/OQgNW6eKid4fVDSpHJL09WdaDtsB2DpFqn?=
 =?us-ascii?Q?m1cR4Y6/O2SwQVozThCi9GtBvXQBx0q413VJsVOVdTglsvd4qvWzsLn7hplF?=
 =?us-ascii?Q?76+bhTbVfWml9JhTal+EaPRjAzpdDlGW95Mpg8YmDeeZ8VvOMkvHiS4zCJ0e?=
 =?us-ascii?Q?5uGCLvDYIG/aYVEt+Bydiy/sJoFLJargci0V2O7yqYpvPS+suV9yh1T88czw?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08694705-8fb9-47a3-810b-08da7421d1a0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 00:56:22.7597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPLI/IOpR937QT4cFbu47e32pKRHjlEPR3Ktn9oR+YvMepRRwCssP6uk+yWOG74U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4582
X-Proofpoint-ORIG-GUID: -yLah69Iz9u4ahBl710E3xRLLr6KNQ0k
X-Proofpoint-GUID: -yLah69Iz9u4ahBl710E3xRLLr6KNQ0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_12,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 01, 2022 at 04:23:16PM -0700, Martin KaFai Lau wrote:
> On Mon, Aug 01, 2022 at 03:58:41PM -0700, Andrii Nakryiko wrote:
> > On Mon, Aug 1, 2022 at 3:33 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Mon, Aug 01, 2022 at 02:16:23PM -0700, Joanne Koong wrote:
> > > > On Mon, Aug 1, 2022 at 12:38 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > >
> > > > > On Mon, Aug 01, 2022 at 10:52:14AM -0700, Joanne Koong wrote:
> > > > > > > Since we are on bpf_dynptr_write, what is the reason
> > > > > > > on limiting it to the skb_headlen() ?  Not implying one
> > > > > > > way is better than another.  would like to undertand the reason
> > > > > > > behind it since it is not clear in the commit message.
> > > > > > For bpf_dynptr_write, if we don't limit it to skb_headlen() then there
> > > > > > may be writes that pull the skb, so any existing data slices to the
> > > > > > skb must be invalidated. However, in the verifier we can't detect when
> > > > > > the data slice should be invalidated vs. when it shouldn't (eg
> > > > > > detecting when a write goes into the paged area vs when the write is
> > > > > > only in the head). If the prog wants to write into the paged area, I
> > > > > > think the only way it can work is if it pulls the data first with
> > > > > > bpf_skb_pull_data before calling bpf_dynptr_write. I will add this to
> > > > > > the commit message in v2
> > > > > Note that current verifier unconditionally invalidates PTR_TO_PACKET
> > > > > after bpf_skb_store_bytes().  Potentially the same could be done for
> > > > > other new helper like bpf_dynptr_write().  I think this bpf_dynptr_write()
> > > > > behavior cannot be changed later, so want to raise this possibility here
> > > > > just in case it wasn't considered before.
> > > >
> > > > Thanks for raising this possibility. To me, it seems more intuitive
> > > > from the user standpoint to have bpf_dynptr_write() on a paged area
> > > > fail (even if bpf_dynptr_read() on that same offset succeeds) than to
> > > > have bpf_dynptr_write() always invalidate all dynptr slices related to
> > > > that skb. I think most writes will be to the data in the head area,
> > > > which seems unfortunate that bpf_dynptr_writes to the head area would
> > > > invalidate the dynptr slices regardless.
> > > >
> > > > What are your thoughts? Do you think you prefer having
> > > > bpf_dynptr_write() always work regardless of where the data is? If so,
> > > > I'm happy to make that change for v2 :)
> > > Yeah, it sounds like an optimization to avoid unnecessarily
> > > invalidating the sliced data.
> > >
> > > To be honest, I am not sure how often the dynptr_data()+dynptr_write() combo will
> > > be used considering there is usually a pkt read before a pkt write in
> > > the pkt modification use case.  If I got that far to have a sliced data pointer
> > > to satisfy what I need for reading,  I would try to avoid making extra call
> > > to dyptr_write() to modify it.
> > >
> > > I would prefer user can have similar expectation (no need to worry pkt layout)
> > > between dynptr_read() and dynptr_write(), and also has similar experience to
> > > the bpf_skb_load_bytes() and bpf_skb_store_bytes().  Otherwise, it is just
> > > unnecessary rules for user to remember while there is no clear benefit on
> > > the chance of this optimization.
> > >
> > 
> > Are you saying that bpf_dynptr_read() shouldn't read from non-linear
> > part of skb (and thus match more restrictive bpf_dynptr_write), or are
> > you saying you'd rather have bpf_dynptr_write() write into non-linear
> > part but invalidate bpf_dynptr_data() pointers?
> The latter.  Read and write without worrying about the skb layout.
> 
> Also, if the prog needs to call a helper to write, it knows the bytes are
> not in the data pointer.  Then it needs to bpf_skb_pull_data() before
> it can call write.  However, after bpf_skb_pull_data(), why the prog
> needs to call the write helper instead of directly getting a new
> data pointer and write to it?  If the prog needs to write many many
> bytes, a write helper may then help.
After another thought, other than the non-linear handling,
bpf_skb_store_bytes() / dynptr_write() is more useful in
the 'BPF_F_RECOMPUTE_CSUM | BPF_F_INVALIDATE_HASH' flags.

That said,  my preference is still to have the same expectation on
non-linear data for both dynptr_read() and dynptr_write().  Considering
the user can fall back to use bpf_skb_load_bytes() and
bpf_skb_store_bytes(), I am fine with the current patch also.

> 
> > 
> > I guess I agree about consistency and that it seems like in practice
> > you'd use bpf_dynptr_data() to work with headers and stuff like that
> > at known locations, and then if you need to modify the rest of payload
> > you'd do either bpf_skb_load_bytes()/bpf_skb_store_bytes() or
> > bpf_dynptr_read()/bpf_dynptr_write() which would invalidate
> > bpf_dynptr_data() pointers (but that would be ok by that time).
> imo, read, write and then go back to read is less common.
> writing bytes without first reading them is also less common.
