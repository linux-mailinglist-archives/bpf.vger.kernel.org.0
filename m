Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC86F587181
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 21:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiHATjK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 15:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiHATjJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 15:39:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DEF2B617
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 12:39:08 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271E1xK8030578;
        Mon, 1 Aug 2022 12:38:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ai/dS8muC285kzpSr1tArQymAzh+uSHW6JXav1UUfXw=;
 b=Fy7hv9oLHDdgSpAOOjs86jOaSaBkKAPoBFBN4hT0i4vkD6lM9gkMv7WLx2vtTIJnx2h0
 LzozNRRSVPmxJweDvyiT820qeUwzrl7JciXASAUAPVN97HKQEKCE8FItRMrS/vRLvQlB
 NOy07CT2G9PAoDjstd4Mnt/6uuUaifzFZIQ= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn1rrx1dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 12:38:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z96whEEYRycwVsLALbaky/xAa22vReXdUc99fjL8sZiKuVkeHXELJOSVEOh1B63xnapFEtHAUHt5O4nUrt5cCQslhwytuVU00exjfJk8wjj8dTpXQpHQvS1Zw6DqZjJZDLgCnhYsDN9hqfD+ign+BHKF5DNhmGcHP/mdG8e1wFfofzEh4eFFnxatudVT82xJpmx4OMELZLyWCGMEyoCfXi2E7P5P8gxV6PJnK2UXxf67+OEpq7QJvgKUiL85Qk/X6EG8eNSpftpfCn/mRR7lZ7hOjvrgB+xRqdWFodO+qU3m3CI3xA6xhn6bf13Q33LgFVf/nVh/K3R39V0H/v3afA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai/dS8muC285kzpSr1tArQymAzh+uSHW6JXav1UUfXw=;
 b=LFqiVhIXiEbJhn1AYjjSWhRXiQU0ODNNFfZmw1klh7Qp4dqZump4KwiG+NnYVYcBAQhXnJ9vHQh1MBcGprJU+P4b4VOITQ6JvFhXf4hIolajAKNGrMNyvYT+f4PnrMwJcAqIMwAlNQGPb5/KkURPkfNrOwPSeBbJsSsOnCF6CGo1sEHa7waJlA06y8LPi2wIlWfx8/DoP0Ul1isGZbvVg5IGH0B6K77Yb9t1q1i8q2x79jkkKs1B/6h6vaCG8f5r2oQhAAoS+379x+qN0x2vzNpMbyvKuWISEfaeGxeFTatTPKbsWt72PS1CTqc13UI+tgCi6e8MWUTqriw1Rzn0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SJ0PR15MB4374.namprd15.prod.outlook.com (2603:10b6:a03:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 19:38:52 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:38:52 +0000
Date:   Mon, 1 Aug 2022 12:38:50 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220801193850.2qkf6uiic7nrwrfm@kafai-mbp.dhcp.thefacebook.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com>
 <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1YXSx11TGhKhAZ20R81pUsgBVeAooGJjTR7dR5iyP_eeQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1YXSx11TGhKhAZ20R81pUsgBVeAooGJjTR7dR5iyP_eeQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89ed0919-013d-45f5-bea3-08da73f57666
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4374:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYGrzKW8X+BY/PUHhcZjV0yOFLQ8RiwhB0Dze5FrjfA4SV54AxfVuSW0UudptJ4c4f1rvFAa/D8bwRj9sYGXNYW9MR83/x24hBnLVIRgcmaS+aShx+6tgNTI45MaKZzo+za0jszGAGOyYRJp189RU4+eMg4oMB9VxMvql5DYGj/cqTQbfh3rjGXNY9/VONZADYRnFOIJEN5vUBhDkhrxSvZW2usGlLa6/6wieBx95nc5CPcO+lHrIv3T/K4cXVE/m1bOowEfAvVtEpHMrAvrbIVGpVSDJBMT/NxCFl7ZP5SuDoNTojcuhZ15PWGQaxmG+3PZCfmonL2PIcPJWgWKmfonOsqQ2TPF1VnPsvC/xmgfH0sMUUWQgwROwu7k6yybvE0piF0LErc8dSxWW/t44p47IMCtJeTcUtMUQi3s1PXbUKKE2bgdJl3Bs0eILMG91kMGCAWvdpNZZllvJD5Q0dgGmJA7bA6BgLlc/DcZFwNMgkzx5ImnX8f2eQl2mrmBYVIKzowyZbQ2wcukleJ4UMpFqusUZkeYrpL0NSvLTIhXNNhsR2KWucLL3ugJy8lqBGhYXSfh+XQtDCyI4iepOcAW4kutL9PcHwMRTcH0vq38oMubR3+BQIpetbdoQykB9QjG3YAAX+KFAkJyGKbt238b87wqrN3DcwIZ1Hc2GshHOuycPT7cXc0wfDvPu9YiFpp/7o23oy5GPWZTiRrs5rk+NE+idIEzooIG2PUqnjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(66556008)(66476007)(66946007)(8936002)(4326008)(8676002)(41300700001)(6486002)(478600001)(316002)(54906003)(6916009)(5660300002)(1076003)(2906002)(6512007)(6506007)(52116002)(186003)(83380400001)(38100700002)(9686003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d5lzEpZ+2HyXLYl+SMpi3lsNL1EDkvHwLXx9/S63PfOuONfYxA0Qv/b306aK?=
 =?us-ascii?Q?iaLbE+kUM5Suai7kg0Ya1UFA0542AKMQ4/l4yQyYfyzZc42BMGiZhm3eHZAK?=
 =?us-ascii?Q?hfQTe5YgAi+yPyIdqLXFaxJR676vxq2Or6KvgfEtiFnkUECTJ2WJlVtV4CXs?=
 =?us-ascii?Q?H+wmzNVbsIjKNxSAyx4f0c1Teejmun5Y3CKzJkhIvDUzjzK+pTzKSaM/xLiJ?=
 =?us-ascii?Q?PNC5FwN+X6QW7qfxmDscLFRJYF+GEn2kqr761gYSNDg6iERnXumjx+wyaHH9?=
 =?us-ascii?Q?e3ElQ4RqXJ2hkkqAgMnQawWnPaT1PUyu6UhNZTsgEYzWv6TJaa9Nwi725VeU?=
 =?us-ascii?Q?kj/K5rDEfTUmKWil9Iv/cgNWtjzTlRJft/jd3DXFWP4lfGBvBbbg/USfwPew?=
 =?us-ascii?Q?L3yjnsuhivmlEgHLI4k/2ejN9pJz+mRxwIrHjUOnhYra+4/SlKf7klV8iN2H?=
 =?us-ascii?Q?N+vWUgs5d3kK7LLNXUvAn0uqrF2mitm2pJk+xzdPsMkgK3YJmeAmtwSj/Mmd?=
 =?us-ascii?Q?KsTHbqj249dWP0WHmRfAUSpi49HUl5VIblrzXQeIBPJXuK6doM7k0WzmkuQB?=
 =?us-ascii?Q?JRIIDCpqCRqvmxSLaOwLyE8tZ5HORNeapsu970JLGqYATjI+J72ylOHdJ3Mo?=
 =?us-ascii?Q?MPGjrNUxy2eaBNtH8lZqZGSGhhPThVgrW07a+pAtCPx1HsQvOY1QZQrCeMKU?=
 =?us-ascii?Q?q5pNWM+GeUof5+J4NzBEN5GnzhaDXFH3YwBZfTpoK7ww9h63CDZ7R4y5scP6?=
 =?us-ascii?Q?hhSTt1V9aJp+fDcN97kZR9m1xV0oMbWHOnzZxp2c8ti3ORFQLmm1psQnw0gg?=
 =?us-ascii?Q?OHEK5GKoySUU3Mg8ljLh3er1sjPNXy7Bz2etAa6NGUj0ALlhHuarBfIdIVHo?=
 =?us-ascii?Q?dBfUWK0DcL4z5IvO7RP4htRP6qAj745sDsyvD6Q9KTCFx7vQxpxKpap42PCO?=
 =?us-ascii?Q?26OznSZCUClqAI0CYUrBZnkz5h4hYU5WPFm5BsBAmcT6KTa/syxIMb39PPaI?=
 =?us-ascii?Q?a9/kbgKTDx8tqNRXL0CiiKc+rzI/UV/CDpxEi5U4mYSNthtNvQHME9yDwjaj?=
 =?us-ascii?Q?1Q/kWMBUe9GKyz4eeELeCUn6bsQZ39UWm57sYLjNaq/PrkmTABvWtjyebF8k?=
 =?us-ascii?Q?/Riiezs3dUP7NNKVHqHRq78LdconyUbeHrwNFv5nWXWcabhj9xFWBE31IsT4?=
 =?us-ascii?Q?+1K1UPoelidr32n4eIHXBSI4nP3Y6I71YTHjcxBPDImsj7InSBwOJDM7Rckt?=
 =?us-ascii?Q?sVBL0z8xo+tTSv5mmzJ4tfvWuFgmhlhqCnpT+YvJlkvu7an64Vy/2gAixd8P?=
 =?us-ascii?Q?pG1GX+DFK8jNDzYemgYdgeaFTIfB4wZRS180l+SvCKKbe7/geoXIhOiJsLFy?=
 =?us-ascii?Q?yeDjFOSZDPeXHxoAuREpfxQQv9imsM0d1qx6lw6qnqdZeaQMJEAffmXYJQBl?=
 =?us-ascii?Q?3Iq1fLS+YwdD+0JKskESXBh4TAPqj+tAVpOn4LVIi3MSBDVHFGhtB51vOgqI?=
 =?us-ascii?Q?kKcB5CmWu/tZLlqJe8HUWn+FQ+kUwwrF0GzLS8Geqcjxq+X1223gMqdB04JT?=
 =?us-ascii?Q?bxx+jwvduoanWmKq8GP9tEXYrC1f7L6qhWfLmGA7HMoyFrOkEd2dg2gLEgD9?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ed0919-013d-45f5-bea3-08da73f57666
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 19:38:52.0735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mqdjBBgdoZyraAV+RDUBqrL89sBgKH6jqp4BTuqjl9JE8P/VTlEfTffiqGVlhAu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4374
X-Proofpoint-GUID: uzQicR6oebfwtziJH7qU8pg_9QoYDuoU
X-Proofpoint-ORIG-GUID: uzQicR6oebfwtziJH7qU8pg_9QoYDuoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_10,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 01, 2022 at 10:52:14AM -0700, Joanne Koong wrote:
> > Since we are on bpf_dynptr_write, what is the reason
> > on limiting it to the skb_headlen() ?  Not implying one
> > way is better than another.  would like to undertand the reason
> > behind it since it is not clear in the commit message.
> For bpf_dynptr_write, if we don't limit it to skb_headlen() then there
> may be writes that pull the skb, so any existing data slices to the
> skb must be invalidated. However, in the verifier we can't detect when
> the data slice should be invalidated vs. when it shouldn't (eg
> detecting when a write goes into the paged area vs when the write is
> only in the head). If the prog wants to write into the paged area, I
> think the only way it can work is if it pulls the data first with
> bpf_skb_pull_data before calling bpf_dynptr_write. I will add this to
> the commit message in v2
Note that current verifier unconditionally invalidates PTR_TO_PACKET
after bpf_skb_store_bytes().  Potentially the same could be done for
other new helper like bpf_dynptr_write().  I think this bpf_dynptr_write()
behavior cannot be changed later, so want to raise this possibility here
just in case it wasn't considered before.

Thinking from the existing bpf_skb_{load,store}_bytes() and skb->data perspective.
If the user changes the skb by directly using skb->data to avoid calling
load_bytes()/store_bytes(), the user will do the necessary bpf_skb_pull_data()
before reading/writing the skb->data.  If load_bytes()+store_bytes() is used instead,
it would be hard to reason why the earlier bpf_skb_load_bytes() can load a particular
byte but [may] need to make an extra bpf_skb_pull_data() call before it can use
bpf_skb_store_bytes() to store a modified byte at the same offset.
