Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F80359763C
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 21:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbiHQTIH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 15:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbiHQTIG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 15:08:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE3A86C32
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 12:08:05 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27HHrwmv017343;
        Wed, 17 Aug 2022 12:07:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xY4in2uOyJYzr85Ba4X28fq9rI0i0zMS1UGSmRgWKFc=;
 b=fWa8RJH/3Kr2a0V/Un0ldCKHOdet+W82Dm2wMx0TnngBLTdek3SvfO6+0WF8HQZfo/Rf
 Vfe+/J6A+8f1bhzMsUAFLv9ZTqliHRHjM1OV4FoCszLylkZLa54nAanhXRt4ihlmqZPt
 N6jr6M0iiUcyFxowrdVsTdD/LRgF1olx/Ic= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j0nvjnfmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 12:07:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzlb7ADY+EYyS7O4v2bRKYz8vZzPk3l64J5NYXCMgc0mzYK019T4dWj9/PsSn5b/sVJaAPif0Luf9qYemInmSJL4w6rLNjz6hb/Tusvj2aWZ5003u5WkJHn07QOVKSFo5teTJmDmNF96IDpsI3QgGlmSLyPS+yy08L3pQYNGUB8aQuBJo5lUVaxiYhxTD3ouUgMw7gVhohEeydWmnjRRrvWkFV5rfSbvDj0GswycCO0HCi3MMBxo625+awptyTLiWAEgnOcejQhRxSsWYGyvM2zX2ARbkf+2jd2ydUpN3JjSt9bXRefXDBbgv43oupkkXOfgDeGQSfOAIgx3x+uU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY4in2uOyJYzr85Ba4X28fq9rI0i0zMS1UGSmRgWKFc=;
 b=LZz9VxWB7fwYTduc8rYEoJtcVt8xhLEV3UCPAUbT1eps99BglXCd5M32i8xL+TM4Q2yPgJZMjQyGXTgylpeOxKjxveuUOfmD5YhGN4ck9BF6znbqkFVJPEvS/2T2TJ6d1FjvL8iGt//QGSK/VN5eJS8t4aRP5APrr8mwmHhUSFMkSc3Jf+2ftz2XjKpNKSm6FG3RbRB+qQe7eYicquwL2fvMod8JZuMllIrHKbRSOTEg4wgRrdnpmIq+Eye5bv96xeEg7ibZPUwpHHdmsPdLSeDJswc4tfOLwq2VIwHcp9/HnbLAYzH+KpFZo3u8egL9YEOwnXbpvcZDAvtW1zpzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by CY4PR15MB1637.namprd15.prod.outlook.com (2603:10b6:903:131::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 19:07:46 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 19:07:46 +0000
Date:   Wed, 17 Aug 2022 12:07:43 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v2 0/3] bpf: expose bpf_{g,s}et_retval to more
 cgroup hooks
Message-ID: <20220817190743.rgudkmzunhtd5vxf@kafai-mbp>
References: <20220816201214.2489910-1-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816201214.2489910-1-sdf@google.com>
X-ClientProxiedBy: BYAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::29) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2abfd66c-8fe8-4232-a0d0-08da8083c4f7
X-MS-TrafficTypeDiagnostic: CY4PR15MB1637:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2eOz2Yh09D5L59tiqN0SEj4eya/v+AGSy8PQf/ZHHRUpWSNfsYzfKWatnXPlhKesEV08i1C3IRlqEKtcXPlk6Uol9DXa6IASq7wzMy2hcK4nCFVbhlKr8JyTydw7T5vHnkHqbmZyTpFe2eAhuuHwHNIg6G0BalHuUUhHC1ipHrdhXIhHQmqbmhM03rad1Lu6I0DORPHlvQN1Twsw3AIVibPDZKmG4QEQDYyDaYJ3QtGlzmd0itSABnuWh0+vnxGeUkhJJ4nS9z6tbGldEH4s0+pj9wx+APc4Un7FPaoT89guNj0oQEZjGbYhD80A4WuvHEHqEC/zobWGiHpls+KK9mxKjwfuK/Q0iPOkayuVw0rux6hphI1KU8JUi3f9NbKHsMeFqjV7sJNOe3u27K9OoDh+8XJ5+8FfftFlD+4/UgmCCYX8c8vyh+pz8c+S5kbIqpqfHZFIpK0QPakHfWu3aIFHZ+s89SQg2QK2uNrOu4PjwXUTNlIu11HSdQl/HG/C/NFg44g5jFjfBjrXH/DQIU9Whk2zFCa7sDTe70d6bIAurdvqLGkUo7Uz0zj5NgCJmwLfd9q7OeOGNiLW6+tx6yOJwuhsNQQepnomjnrMGdetHS3g2nPfyOyMBSItfl/TMxIL7ohSey/nInBOBWr7KTK0UXh6TBOXdowiiPeuwol/pBbCWcdzAL4zErdbuixZcu7T+833vqtUVss8a1fIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(396003)(39860400002)(366004)(136003)(346002)(5660300002)(478600001)(4744005)(7416002)(316002)(6916009)(6666004)(41300700001)(66946007)(6486002)(66556008)(2906002)(8936002)(8676002)(66476007)(4326008)(1076003)(186003)(52116002)(9686003)(6512007)(6506007)(86362001)(33716001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2bupb7MdYg5WroM3gU18RfvXdlzkL3A59y64eaWK+YUuBUggrRfw8/s7cjc8?=
 =?us-ascii?Q?pC0ejEW/6CFoRcyBEMHlr/CjMjiPoeDS+cMjIiKoOPslcQyCaVDZzm/7GoEy?=
 =?us-ascii?Q?Zwiyk2YcRMjci4iaeQZPEwhWwx33fh7Kpn/Dn0a34nl4GvSp0/AI0JIo/Lhw?=
 =?us-ascii?Q?6z+6hT8raMZXJ9rqjSxAYxdsG7xd+j3E5bOyqAKZJSEYMc46Xq7VVwXQ0msc?=
 =?us-ascii?Q?qj803dTMvl3VWK2eWRW26RARic4DJLmd/JLBMkUgw+EZKqAVq1iRLV3GJAPf?=
 =?us-ascii?Q?tTAr8DQvRL9JMV2woWylUK6vFyyHPDjOz2HbEahRTBF/VJtIY/NdeZmfLv+R?=
 =?us-ascii?Q?xhE2Dhlqg6w8TEIigLqbhgXIg0eS4rp74WEi+lYbJdSs372DneqjN33t5q3w?=
 =?us-ascii?Q?oh6ULIm7zowBRQfRDVu2tAGXop2mG2l8RrgVgFQGHsn4rf7a7WLvS9YvhJ0P?=
 =?us-ascii?Q?2brAvXp5LTgXAN6kNnEnoX7u6AouEDqz9n98Kqa65Id/M9CKvUeebh07320M?=
 =?us-ascii?Q?iIwMjgFmSLQs5S/piCO8g14lktdIxTTYidKT/7KnZeiFfo7GP/u/szCfPr1A?=
 =?us-ascii?Q?RCCx9yihNSkWOn+QbLppL5yhb77h62Cr9RT7V+lojs2r7r69ZqHkch2dLzGe?=
 =?us-ascii?Q?XcNtiVibdm5kVS1Vhfhx1SJcIdwIsDn1plvvcZE+dSDCIwluiBVdufR7EEwu?=
 =?us-ascii?Q?Q808Edg5NIteuBJPhY83oVFDs3Bz732tBVU/8boH10UNzt7heOIGobqxsCv2?=
 =?us-ascii?Q?j9Pm2ConaoxZHNpX0qRaWH7/EDwhtdNuAy4X5TnVHYUhgLMjLfjvcLhuU9t5?=
 =?us-ascii?Q?zxpiQsQlBT6c/tMbfvchp5ktYkfb6uu8Dju/O1oQUIGbkORtd63oUl4j7Clp?=
 =?us-ascii?Q?gwzvm9YTedivqoMiFqyAbKJCqsCDpG3+tqviJoGEFr9E4p7T3q+79qMtcUax?=
 =?us-ascii?Q?wODaoGrT3mJeTDB7GKOTgBgCBqNolX6d8+QvLyVmw6HhsLaeqnXArZr6D1SK?=
 =?us-ascii?Q?zoFVI2sp64NsOx4JBbi6qnbXNwKZykxXhS1NkzSQDmbVFA0CAPQ9parxyabB?=
 =?us-ascii?Q?DgTFcGwv6vyC2oKhg3PmUNZ0grrC/Q/JQItqXPEAeqspL/QeS0SHDsNP0K0y?=
 =?us-ascii?Q?HLkMBVBzgP30z5bhpTTPPbseL/Zs9rl45yolV720HJeeywz1/TIFPvp1j57T?=
 =?us-ascii?Q?HH6yX75hHI61EZWBZ0u+9uMC3msaoA2PAmY6f55d11JOxQF9U08/lKOUdsLg?=
 =?us-ascii?Q?QaHBRhKN5nDVgUNx95UY08uDqI2WBaK4ruCVCKHjiadU5OUrMGuUXGE/fK0M?=
 =?us-ascii?Q?XpriLYXZykZzo4xcws2b81XKSuKx+u6RWFgv6HOO/dyqLRmDYhM7TNByQO9m?=
 =?us-ascii?Q?4Fgj6RTSCRinlqVgJcYrpQ+dyZba3KHILS/yAzJf5lLx2JMXfYHVvfviZR80?=
 =?us-ascii?Q?gQ6CUg4zux7vcT3CQh3PXbhaEZ34YbdcsfdWTYIRyVYXEJmK7+viYr+gVoN8?=
 =?us-ascii?Q?/Sprgv6SrIA5fLZrp2RVtuI5o1yNqpk0b959EvtEtco6qxMR+hd4fPGIqecS?=
 =?us-ascii?Q?7kn9BDZ3ZfjIgUGzVp3F8OV8GdsMhYLDW5WTX5jHCT60lTO8362klLCJD2Uj?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abfd66c-8fe8-4232-a0d0-08da8083c4f7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 19:07:46.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPUimZOZDXu2JbHK7n0JxrYZEEvhsazRBPFvmKEdPh98JiB9AEdJ473BZzwnfuNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1637
X-Proofpoint-GUID: _nQ45_eQ-ttWQmz22FjstkfTJFegZkfa
X-Proofpoint-ORIG-GUID: _nQ45_eQ-ttWQmz22FjstkfTJFegZkfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_13,2022-08-16_02,2022-06-22_01
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

On Tue, Aug 16, 2022 at 01:12:11PM -0700, Stanislav Fomichev wrote:
> Apparently, only a small subset of cgroup hooks actually falls
> back to cgroup_base_func_proto. This leads to unexpected result
> where not all cgroup helpers have bpf_{g,s}et_retval.
> 
> It's getting harder and harder to manage which helpers are exported
> to which hooks. We now have the following call chains:
> 
> - cg_skb_func_proto
>   - sk_filter_func_proto
>     - bpf_sk_base_func_proto
>       - bpf_base_func_proto
Could you explain how bpf_set_retval() will work with cgroup prog that
is not syscall and can return flags in the higher bit (e.g. cg_skb egress).
It will be a useful doc to add to the uapi bpf.h for
the bpf_set_retval() helper.
