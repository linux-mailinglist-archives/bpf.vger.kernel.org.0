Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7695873F5
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiHAWdY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiHAWdW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:33:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72597220F5
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:33:19 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KBHCw014588;
        Mon, 1 Aug 2022 15:32:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Z3YmEVEm8ZWY3kjcAYHlq3odDvgNo9tuWYKpj9lIH3M=;
 b=K+UidQ5i3cBLXibUjC2nSHf1cbE7FDy9i3bibPQiQX8L747z7mxsey8aoZfisuXyCbAr
 oolDa7tWoMmvtFs3X30zNPBGYqYaPS425M7sfxNZJunL5DQDexm7hYYzFRa4yW9zUiLY
 NBiP2xoQbnClBJG6mvt6iUitmZOqIJb6ts0= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn3y3ej02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 15:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5H9GuuDJAt/zi1yeq91Olhxx0zXq+5H9M5b3o9//pSkptObYL5ckk0J3Tr2ilC00P4t6pRftrhdKFZtIKO+pJ1+CCaNFr8pSxWBz4Z5YP9dhuNHJr4Ilvrkje3V9MKSQPHqKqb9OBxmIX3c1l11WiiGvbbCUJGvVu12PXjTNcQImdsHVmDqzFM8MPO4hrNMo8LeJTHylGs2ZGQREsUNSFWOuNTOYFYewPXpOJgDzvHRO9UIyUZd6RfGsIUgUYjr5pp4bNm33lc2rqzAsGDmPini51+EqglipL0LLgrnqBubZjek/JQPTnL6g9IvnArYDrcv0vvHWMziV05bbcWhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3YmEVEm8ZWY3kjcAYHlq3odDvgNo9tuWYKpj9lIH3M=;
 b=ZfhUxyfBZy0BMZovWiwo1n6zAAfiHUcDbqw0ps+uHptml0aBmtXhrEThIoOVqCVb/jGB+k6LrgH1SR91Yo30PvNn8rqfuBV833REn38NUDtaDGuu4fpWJpmRhKZ4Bf8+36XMc3QIMM1QS2eIVeaFUalI4M+boTVqzoeGyB0gfP7QttEr0OavowD7f15yXKgNG+gtWAP4h4DjMQ4ZF+ujT0Cu48nA++hD0waBJrmsBVLk4lmD60bsUGBW2EbpcZrjG/HKekvPjgklWDhsI+bdC0DaQcOfbRAHYv4llQYRTs40g09A2gb8JpUEnvJb5+j2N5uOo9kCkloB2ugbs5ajvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by CY5PR15MB5487.namprd15.prod.outlook.com (2603:10b6:930:34::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 22:32:41 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 22:32:41 +0000
Date:   Mon, 1 Aug 2022 15:32:39 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220801223239.25z2krjm6ucid3fh@kafai-mbp.dhcp.thefacebook.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com>
 <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1YXSx11TGhKhAZ20R81pUsgBVeAooGJjTR7dR5iyP_eeQ@mail.gmail.com>
 <20220801193850.2qkf6uiic7nrwrfm@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1ZCQ5nRB=jBUxPFyS4OhMvDX1t4ddFYX2LqkepMZg-12w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZCQ5nRB=jBUxPFyS4OhMvDX1t4ddFYX2LqkepMZg-12w@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:a03:54::23) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae79416f-7677-4b52-2b02-08da740dbeb1
X-MS-TrafficTypeDiagnostic: CY5PR15MB5487:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50hZ+xhG4mRH3Ev7/vTGeH11qioGW2IwrlPHov9IhU+oVhALQC/GcxB0o58xQ2DkSy3//kBPn2kUc1YEm0n+Sa9lk4SLrJwANYK0qKnikdm0pVxnHED98MeG1JCsKsp2AXn6zCD4YMBfZ6o6HDTok7NNcL/LH5vqLRRDcDCFIRr308YdLepQ4GUIRPUMuctld2N6I5z2rCuJB3rs7LfJ08dnFtW43TtEl4Q9yVzJ7skCft8bTUtMm/rPG2I+unaOWaGoSl+i9siE7j0dBwoHVppmQ//E6/hLtK6Rk1dQjUkLQJ2R1TUIydXWw3XaSD+csFye8+1iXknvOMFZdPkIQfrNluMDkjkxQPNHlDnjsSvuKRvNLMAIZmbOyTZslr6rOWd8OduYIgE1Bn6eevJxWVYRH9r6Y0eKGEE4w+aSsb6+Dzun387mQgs2kLQQkji11K2i6oR7E5sS9S5631kx3rRwwGCNxXUUJSLOGJj3CaVToAOHczw7F2HhwM1kYTZ9t9Uyl/OsqJtlqDUrORQsumk8UoJ+X7QDUsPFbppHDEV+ddShosGoeUYSC8DmViqg0bR3sN0q6562ELRC7fXM9GxnRtssWbqT9RznRynl+TYk22Fky8a7w76fEKsKj9Uv/nBG6JEcZcaqNCk4NXGd9NZl7KVPx9YickG+FqisBHwSJZhkejKCPTAh2+gzyHN7p3mBegia58iAFAW5WVlK3oPCtIFMytUMC2o5/DgqdPhjP0ygCtTJaPI6ocNh+sPY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(66946007)(66476007)(8676002)(4326008)(66556008)(2906002)(5660300002)(8936002)(38100700002)(1076003)(6486002)(478600001)(186003)(52116002)(41300700001)(9686003)(6512007)(6506007)(6916009)(54906003)(316002)(53546011)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tDxhdo0vfl+XyzX8i1Pgr9pCWP2tQm2miUzCl2nszoQ3MPY1sH8NcisFDP0P?=
 =?us-ascii?Q?GNF1EUa+UIvl1/Y4BLjz5qocWQ4trWZ0+hG0hZ6FV+Fkg56NAXGIRgJ3+Xoi?=
 =?us-ascii?Q?XS7jWbX96a92DU25CYQp51jhPAuNUyx54lsAp0tER39wphq/eueuyhhIUcj6?=
 =?us-ascii?Q?9n0r5IAu4XIbVq/6FUTqAIXxS65DjHXn8vCbo05tb3mGSbksP0IYvxuXYRAv?=
 =?us-ascii?Q?TIoUHnOC56EPq+flP9gGImU7qHoPz2TkDHnOiCXMtG6KVD0wbXklX3xXHIKJ?=
 =?us-ascii?Q?BhLie5xwIB/zz/aJCHnKvUfpfBCtYOKGG493WwjvRoTxzeMQB38WT2zd3eW2?=
 =?us-ascii?Q?lZ0IdO+/lejVoD90McPFH+fkxLZnG1+8tbT0LyCcN1qqdgqvdCH8uZT7lG9A?=
 =?us-ascii?Q?3Rb6I3M9pjIUXmfwqp9mLe+tthyLF478TApZYjmmnM4asAK1SJdAk+7I2AmI?=
 =?us-ascii?Q?vIBB2fZbnZX7syBHJHO/4D+G9byhVWgbqoyi8HgNPkHaJsYvNDBIHnccv57F?=
 =?us-ascii?Q?Vo/RrkwvEmaCxrvbaKCqqibAKOm/WsH1sNklxBSCWw7ZHkKmw9+nWe7O8fgo?=
 =?us-ascii?Q?pQg2682g9uTYBxfmpZ1tK0SmVP6bZeGKq02NASkuRD8ljwHrpXbha+j3JcJm?=
 =?us-ascii?Q?vuSea0HXhGMJsOt+G3V+jCdu3thYAYdBwsX2kt+7IXM3cvrDz/qqEukYitQY?=
 =?us-ascii?Q?qI3ZTY5k2vbmxbtKM+UBD65SgmliNGB5Twd7SPzch/QCnkebvTn2vSCV/syC?=
 =?us-ascii?Q?JVPX2AV3mZ1xD1Ol3GckxxpPYWXrr+AJfFtBmhXK97l+S6QfkTsC00/QFnvr?=
 =?us-ascii?Q?uFFCEvyIYvMdd1u7GzwW+8FjDT0w8QtN0Fh7VjX6qG1ossuQ+4iYmmnzFJb0?=
 =?us-ascii?Q?6pH7mEUhq00jid+8j8jNfsSCnFTp45AsyPuT9zQ1ZZjcVZtzf821N0rcegQJ?=
 =?us-ascii?Q?1kiUUVvocy3/Or9mkty2PyFEMQUan5UWnptSbx1tySYNkAZyB5jPdSZiiNmX?=
 =?us-ascii?Q?qu/3d68KRKJgo8Q2dLcADxc/NTlPB+ScK6SDADsoH8jSvEL06f8gbrAePpj0?=
 =?us-ascii?Q?iVzV6SMS1STG+S89BMO3LjrR1WGfX/+y3ueA71QpW/vOySpOdH4RUPo0ynXQ?=
 =?us-ascii?Q?WNs/jU6uvBXvSZn1QmmiLcSLq8wA01mpafVtXEngiO3xZUCMsdnIbR5EPdZQ?=
 =?us-ascii?Q?wtdtWl96ic9I7XpxuKdVMjrr/HZbVy5Gj6AW3doICjCsLI89CIlS9EV+ct3Y?=
 =?us-ascii?Q?4qQL1kKXzkAtjafTFWoMW5+fwWK6tJxio1Pw3AgVwLFixoAztbKskO2IlTJB?=
 =?us-ascii?Q?KPG1s2IhVzhhIxwbVH5H48YKPv/Mtu4lD0GMaX7Mm8sjO0ifKgIbqTAoRKvC?=
 =?us-ascii?Q?Or4z2zl0WZSMDLQJb/7KZJExNhz8qS/4yCF4V5Pd7HqjVob9ptbpX53A37kv?=
 =?us-ascii?Q?HUJG8aBhwsI1ZyMUJ/lG2fyjfcgJA0gM8cFBHNgltnA95mWHiTOFBD1PvA+d?=
 =?us-ascii?Q?IHW35wPv+AwqEFRLy2OwCeyQeZPZ0pdAMxq9skLQcNfnSRQC9NErHZjuswGr?=
 =?us-ascii?Q?fhu99wCmhXZpgkTZu67D4UuOhB/bl+gUXb74LZ8RmVAd7X3ZdFzTtLoqubhX?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae79416f-7677-4b52-2b02-08da740dbeb1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 22:32:41.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PNB25lVIea1nBeUkoxLTNXOSs0QkH9bbfrvH1yQsk+hJcdQ+6U2Tqs4rooCwGk8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR15MB5487
X-Proofpoint-ORIG-GUID: IGbZiCi8Te0393_VP6AbBF2iszQrDTUl
X-Proofpoint-GUID: IGbZiCi8Te0393_VP6AbBF2iszQrDTUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 01, 2022 at 02:16:23PM -0700, Joanne Koong wrote:
> On Mon, Aug 1, 2022 at 12:38 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Mon, Aug 01, 2022 at 10:52:14AM -0700, Joanne Koong wrote:
> > > > Since we are on bpf_dynptr_write, what is the reason
> > > > on limiting it to the skb_headlen() ?  Not implying one
> > > > way is better than another.  would like to undertand the reason
> > > > behind it since it is not clear in the commit message.
> > > For bpf_dynptr_write, if we don't limit it to skb_headlen() then there
> > > may be writes that pull the skb, so any existing data slices to the
> > > skb must be invalidated. However, in the verifier we can't detect when
> > > the data slice should be invalidated vs. when it shouldn't (eg
> > > detecting when a write goes into the paged area vs when the write is
> > > only in the head). If the prog wants to write into the paged area, I
> > > think the only way it can work is if it pulls the data first with
> > > bpf_skb_pull_data before calling bpf_dynptr_write. I will add this to
> > > the commit message in v2
> > Note that current verifier unconditionally invalidates PTR_TO_PACKET
> > after bpf_skb_store_bytes().  Potentially the same could be done for
> > other new helper like bpf_dynptr_write().  I think this bpf_dynptr_write()
> > behavior cannot be changed later, so want to raise this possibility here
> > just in case it wasn't considered before.
> 
> Thanks for raising this possibility. To me, it seems more intuitive
> from the user standpoint to have bpf_dynptr_write() on a paged area
> fail (even if bpf_dynptr_read() on that same offset succeeds) than to
> have bpf_dynptr_write() always invalidate all dynptr slices related to
> that skb. I think most writes will be to the data in the head area,
> which seems unfortunate that bpf_dynptr_writes to the head area would
> invalidate the dynptr slices regardless.
> 
> What are your thoughts? Do you think you prefer having
> bpf_dynptr_write() always work regardless of where the data is? If so,
> I'm happy to make that change for v2 :)
Yeah, it sounds like an optimization to avoid unnecessarily
invalidating the sliced data.

To be honest, I am not sure how often the dynptr_data()+dynptr_write() combo will
be used considering there is usually a pkt read before a pkt write in
the pkt modification use case.  If I got that far to have a sliced data pointer
to satisfy what I need for reading,  I would try to avoid making extra call
to dyptr_write() to modify it.

I would prefer user can have similar expectation (no need to worry pkt layout)
between dynptr_read() and dynptr_write(), and also has similar experience to
the bpf_skb_load_bytes() and bpf_skb_store_bytes().  Otherwise, it is just
unnecessary rules for user to remember while there is no clear benefit on
the chance of this optimization.

I won't insist though.  User can always stay with the bpf_skb_load_bytes()
and bpf_skb_store_bytes() to avoid worrying about the skb layout.

> >
> > Thinking from the existing bpf_skb_{load,store}_bytes() and skb->data perspective.
> > If the user changes the skb by directly using skb->data to avoid calling
> > load_bytes()/store_bytes(), the user will do the necessary bpf_skb_pull_data()
> > before reading/writing the skb->data.  If load_bytes()+store_bytes() is used instead,
> > it would be hard to reason why the earlier bpf_skb_load_bytes() can load a particular
> > byte but [may] need to make an extra bpf_skb_pull_data() call before it can use
> > bpf_skb_store_bytes() to store a modified byte at the same offset.
