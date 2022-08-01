Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D98587459
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 01:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiHAXXe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 19:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiHAXXd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 19:23:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3016B1705C
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 16:23:32 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 271NFbca017987;
        Mon, 1 Aug 2022 16:23:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=THCCh+I5Yw6JFQ/OPEQsDWSL7cWV0ZMCsR0BOqCYt5s=;
 b=DLqQmuGlqAD72EX54RLbgWYfzKCxNAnYQGWaS8H0z9WRxbC+cbRu3A+x/biNrfTAeNyt
 CQ4TSc4X7e6SYy1MEt5+/a2Q+H7IqxegC4YAq4zsVNYEhz3JKMvGGThvIcoZjJLAalfk
 eMo/UPG8gpHVrJtz2Tbqpb8MYzYYFgzDMxk= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hn057qmpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 16:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQzWW1wNWPEBHpExkeibjhvu6uCvk+nF5uQ+7CwzEcMvvuj9zjpfc7/5nqbeef4NbggC2q0N0SiPCppAp7KJRWea+fdicWHN1VbS4553JHe6k7KYnmOZq6KkKX6foVujsEiK5fS4cDIQUnfZE3NoRM0B2rDw/4qn4w0352aiIo2fda1JchSDux/t2Yxm4xGgO9XS06Dre+WkG0z5V7FGHu874p3+XZVlSO3YOo/KG5TBkfpMBLwBNkXmYT3I3jJsGJpGrZNbqZKElkT1jduJgLr9g9sWdau+KVTpvJC9hjzMUKp0iELZF61+F6CY19YksUSdhoYQHLhfvlGlQkfLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THCCh+I5Yw6JFQ/OPEQsDWSL7cWV0ZMCsR0BOqCYt5s=;
 b=OoNxb6nu8+eBcClBBgME1rkTLOnNCqSeME22b00/msYnYFe1+Y7EVtIiGKAOpYGpectefuq9j8MKjAG8nXW2eZDmeM8fWbTsoPIHDiytSd1l7/IZTQnYg54LwEwOL+rxbPGIQRbNsMCPOgiK+a1XnnhyfggTArVSMcY5Wx6WhOWEzXJ+XgOJLvPK4Rcyw4PViyno9j8eIzY7uKjJrdR51OLoIPjR7krsgT8askH9QkwUCOjpXWurelHpcGBMUy9ZN4IwKlDRyTRbrv/CyjK/1/0zbSshChzcw7jLrPX+y3aVwg+lhwiph4yI7RbVc2n6IttDAyO8ejh7ydQQPaoqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SJ0PR15MB4694.namprd15.prod.outlook.com (2603:10b6:a03:37b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 23:23:16 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 23:23:16 +0000
Date:   Mon, 1 Aug 2022 16:23:14 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220801232314.shzlt7ws3sp7d744@kafai-mbp.dhcp.thefacebook.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com>
 <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1YXSx11TGhKhAZ20R81pUsgBVeAooGJjTR7dR5iyP_eeQ@mail.gmail.com>
 <20220801193850.2qkf6uiic7nrwrfm@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1ZCQ5nRB=jBUxPFyS4OhMvDX1t4ddFYX2LqkepMZg-12w@mail.gmail.com>
 <20220801223239.25z2krjm6ucid3fh@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzbjFOXFYeRHwnny1p-GWfMDiOqC6zGMSBjGkjY8RQi5Qw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbjFOXFYeRHwnny1p-GWfMDiOqC6zGMSBjGkjY8RQi5Qw@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d9b3a5a-4ddb-4b6a-1c30-08da7414cfad
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4694:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGiwLne60IANGUEXY/sApujNDNRrCAK0TH+ceBey56+Ko+J35xJPhlBnRkpsndcVsy54UojflR46vq/Z1nf5DITjdYfwtFo9MSx/5cd0Wn1rWAdQt0IgGYDHqqjyhJH+pze0iAVABuvyJXWQYb+1Vkyra/1BhTGBQ4cL7o2vMt6rAY8OC5zwDB6CkdfFoqCyv2MJs8aahOQjzKRYaqTGZ8U0NaIpgHiqwPIyS3CgpInU8ObnIf8+BcVAvVrDZCmFOp/N1y1KoruXJ7rDZF+jmDeWuRrtujIvZLM+JreowsIAUmRQPa/Dy3iEZLUPsKrlt6uCYGmiamvKW0+/UrPcUaXsyT+Ogi+8k6S0LuQAxKpBTVwjuFeH7pdHdRz2qj05DxjOd4upk/0hnDjS6hRLjZYnYfnnjejNmxNvJQBOimeyH33COYZpKkr9SIlZQafPVOhjflZQtPTx9kRngOLBoVp0E9btKoNFJs5xDP/Z5UR/O4SYhNPOH37GVEQudqIkpUlvedDsACQShugaTzmaN1kG7kmRZBEf9/29dwwmECO+GTcIGs8vC2yo3ipWVofW1RTYm4OSXAORVA9+NEhCzo3Kl43y/QsT0Q4fLeY9iP7rtn6lR96G4plwmakZ7GQ3wWfpAecyygKr2zfDGb2vW42qrKu4XCaFLDDo69/xbYcZF9ac1coWYZV2ia+ZaflP62oIYh4bccqJUnNIknJ8fhos38gmvj+U8gqyFZiu4hRShJRoTRVdUrtM8n+5TWlN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(54906003)(6916009)(316002)(41300700001)(52116002)(6512007)(9686003)(86362001)(53546011)(83380400001)(6506007)(478600001)(66946007)(66476007)(4326008)(2906002)(8676002)(66556008)(38100700002)(186003)(6486002)(5660300002)(1076003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DryOSZk2Mzw05F0GqyBmYIP2HqFNaaaGTV82t0rMQsjWW1xXMRCNuFW8ztRq?=
 =?us-ascii?Q?/7ITrof30OjCOGUeKlfv9UZoP0F38mAX1aKKO3h6lziWEi2kF5CEUqPm4Nvb?=
 =?us-ascii?Q?hKftEQfFEWeupxSP7xa9k5IpbLDUand0AK6r9YtweIxU8LkiBKgTpiGSTk+I?=
 =?us-ascii?Q?BsPC3Pr9w0Mrn6SyHFyihaLYim8IIx0kMy03i0kDgxLryHsNhR4tsGucRprV?=
 =?us-ascii?Q?Z6k8JGxj7KH8yoeZPkKeOoVV3I1tfWmDJzQZq09KvtZygI7qpaTDwi/znQsd?=
 =?us-ascii?Q?8FbG/A5vWujz5GAoyjz9VXBC8Vmv0rvTCcDism1xxZ6hnx4QLs+sdpULc1V6?=
 =?us-ascii?Q?JMfYilFPElkcUpalsPcBsR/Js+kytitX8SQBQ4JvB5zo7vQhWhJ771G4eWKh?=
 =?us-ascii?Q?o2EMKFSfIB0nscc2XIl7YGpLqSpMiZszSRJwzACbKuhYBI3VcAYvk/ixGctp?=
 =?us-ascii?Q?++dWtMmw0ZWIkAWWbEgHZEJAuWhMErkwf3PuCOj3r9MjHCe4cU6xEEWR5fI3?=
 =?us-ascii?Q?JLyewtU8Rbkv2bpPm1eGqZ+UcHTnTVcrisR6KIWIDrOF57Pvwhy9o7JwrD9f?=
 =?us-ascii?Q?3qT06WUiPUCILox49UoNfKvRR1LzicxgGnIky1khn4TvYAgIP4ABxnRBDrad?=
 =?us-ascii?Q?cNNRNDCZWHv6hz/X+ObG6MYsa8djCN6M94IpsZi3Pgxyp3yj2a2zrUXs7TZ9?=
 =?us-ascii?Q?TLe4gv/1q/B4aVnMOj7WVJnAn1XDtjqQAAjYm18lij6o5lmv249ppAyWlxUb?=
 =?us-ascii?Q?bbST76xQLUmyZqTECCksZCw28dugRgMoyVF8O13x+tgVgmLKbEjC3wnKoURw?=
 =?us-ascii?Q?/lo5dnq2QM9vuBjnrFgyG3x3pcgWmj+Zx4vusH0B8GD3cWV8Ktlv/NUnFoqr?=
 =?us-ascii?Q?e3rKWAWaEbWkO0aK0DDN12Ar0UfQ97skpSJDEWRs2j9DzfkPLz/JvwJUW+C4?=
 =?us-ascii?Q?j2ZIO0XQToMCD+0qJ4lqXLxD1iRL884WLfXNOfDcd11mEua16wQVUa+6o68L?=
 =?us-ascii?Q?D7/4KbBiWv669BCLzFtAC6xcQwL+OA7Nt59FRjiQSGGjU62Y77ySuiapkXqy?=
 =?us-ascii?Q?04uuAW9+mWg4IiaQzc9Bp5L6xvV1kyc8iDhtJaaeACFGGs5ILebzcA+Fmhom?=
 =?us-ascii?Q?jPWD+bcvf1XymtLnW5gU3DQVoG9ac3rYU2z/iU3HfHmCR6Ywe+sKFGW5yrwM?=
 =?us-ascii?Q?KbNyHhD7QK16LEPgISa+hc3VWsZgIT4B85au8MRLpOAklbLwpoIQoqvoJfkB?=
 =?us-ascii?Q?j1844CcRN7HiyRp6lVHh4hMN74S1abNUnkgcgM0tN9Dl+0Nji4K3ov/aRb7n?=
 =?us-ascii?Q?dUBLT7DjS29kZoC8IbjcB4isiTNu0tog39Ng96UOafI2708Ws0PlsYcXIVoK?=
 =?us-ascii?Q?U/Lh4DszrkOluxMw0lLbrXuk8Pu/NgaJdei9UvaeYcqYF7MsHqXqZCIevr1u?=
 =?us-ascii?Q?UaCk+dxBsfT8aKrdDJPyK7LDPuIIGbELkdBmnZ+vDbLhbQNg452z36DHDPMQ?=
 =?us-ascii?Q?1ONAejifBExDWzEOE84VbxjKmnlOyPnkGcquotzVrGO6Oesv6iSXgO2bLB1h?=
 =?us-ascii?Q?GZmXF38PWc2k33FSyc3UB3uiJxodvDGyrRDw+y9TXn9iQR0nRoxhQ0MtdKmu?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9b3a5a-4ddb-4b6a-1c30-08da7414cfad
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 23:23:16.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPJMPcFLVzC5B7Rc6JE3b0yH/Sld3sPTfxmINdTPZHS883rDw1r6aHifXzCThKd2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4694
X-Proofpoint-GUID: UuE0YNmt9uxqqpyAKbnU6hZvfALpboKg
X-Proofpoint-ORIG-GUID: UuE0YNmt9uxqqpyAKbnU6hZvfALpboKg
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

On Mon, Aug 01, 2022 at 03:58:41PM -0700, Andrii Nakryiko wrote:
> On Mon, Aug 1, 2022 at 3:33 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Mon, Aug 01, 2022 at 02:16:23PM -0700, Joanne Koong wrote:
> > > On Mon, Aug 1, 2022 at 12:38 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > On Mon, Aug 01, 2022 at 10:52:14AM -0700, Joanne Koong wrote:
> > > > > > Since we are on bpf_dynptr_write, what is the reason
> > > > > > on limiting it to the skb_headlen() ?  Not implying one
> > > > > > way is better than another.  would like to undertand the reason
> > > > > > behind it since it is not clear in the commit message.
> > > > > For bpf_dynptr_write, if we don't limit it to skb_headlen() then there
> > > > > may be writes that pull the skb, so any existing data slices to the
> > > > > skb must be invalidated. However, in the verifier we can't detect when
> > > > > the data slice should be invalidated vs. when it shouldn't (eg
> > > > > detecting when a write goes into the paged area vs when the write is
> > > > > only in the head). If the prog wants to write into the paged area, I
> > > > > think the only way it can work is if it pulls the data first with
> > > > > bpf_skb_pull_data before calling bpf_dynptr_write. I will add this to
> > > > > the commit message in v2
> > > > Note that current verifier unconditionally invalidates PTR_TO_PACKET
> > > > after bpf_skb_store_bytes().  Potentially the same could be done for
> > > > other new helper like bpf_dynptr_write().  I think this bpf_dynptr_write()
> > > > behavior cannot be changed later, so want to raise this possibility here
> > > > just in case it wasn't considered before.
> > >
> > > Thanks for raising this possibility. To me, it seems more intuitive
> > > from the user standpoint to have bpf_dynptr_write() on a paged area
> > > fail (even if bpf_dynptr_read() on that same offset succeeds) than to
> > > have bpf_dynptr_write() always invalidate all dynptr slices related to
> > > that skb. I think most writes will be to the data in the head area,
> > > which seems unfortunate that bpf_dynptr_writes to the head area would
> > > invalidate the dynptr slices regardless.
> > >
> > > What are your thoughts? Do you think you prefer having
> > > bpf_dynptr_write() always work regardless of where the data is? If so,
> > > I'm happy to make that change for v2 :)
> > Yeah, it sounds like an optimization to avoid unnecessarily
> > invalidating the sliced data.
> >
> > To be honest, I am not sure how often the dynptr_data()+dynptr_write() combo will
> > be used considering there is usually a pkt read before a pkt write in
> > the pkt modification use case.  If I got that far to have a sliced data pointer
> > to satisfy what I need for reading,  I would try to avoid making extra call
> > to dyptr_write() to modify it.
> >
> > I would prefer user can have similar expectation (no need to worry pkt layout)
> > between dynptr_read() and dynptr_write(), and also has similar experience to
> > the bpf_skb_load_bytes() and bpf_skb_store_bytes().  Otherwise, it is just
> > unnecessary rules for user to remember while there is no clear benefit on
> > the chance of this optimization.
> >
> 
> Are you saying that bpf_dynptr_read() shouldn't read from non-linear
> part of skb (and thus match more restrictive bpf_dynptr_write), or are
> you saying you'd rather have bpf_dynptr_write() write into non-linear
> part but invalidate bpf_dynptr_data() pointers?
The latter.  Read and write without worrying about the skb layout.

Also, if the prog needs to call a helper to write, it knows the bytes are
not in the data pointer.  Then it needs to bpf_skb_pull_data() before
it can call write.  However, after bpf_skb_pull_data(), why the prog
needs to call the write helper instead of directly getting a new
data pointer and write to it?  If the prog needs to write many many
bytes, a write helper may then help.

> 
> I guess I agree about consistency and that it seems like in practice
> you'd use bpf_dynptr_data() to work with headers and stuff like that
> at known locations, and then if you need to modify the rest of payload
> you'd do either bpf_skb_load_bytes()/bpf_skb_store_bytes() or
> bpf_dynptr_read()/bpf_dynptr_write() which would invalidate
> bpf_dynptr_data() pointers (but that would be ok by that time).
imo, read, write and then go back to read is less common.
writing bytes without first reading them is also less common.

> 
> 
> > I won't insist though.  User can always stay with the bpf_skb_load_bytes()
> > and bpf_skb_store_bytes() to avoid worrying about the skb layout.
> >
> > > >
> > > > Thinking from the existing bpf_skb_{load,store}_bytes() and skb->data perspective.
> > > > If the user changes the skb by directly using skb->data to avoid calling
> > > > load_bytes()/store_bytes(), the user will do the necessary bpf_skb_pull_data()
> > > > before reading/writing the skb->data.  If load_bytes()+store_bytes() is used instead,
> > > > it would be hard to reason why the earlier bpf_skb_load_bytes() can load a particular
> > > > byte but [may] need to make an extra bpf_skb_pull_data() call before it can use
> > > > bpf_skb_store_bytes() to store a modified byte at the same offset.
