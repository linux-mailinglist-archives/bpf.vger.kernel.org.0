Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0264A6422
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 19:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbiBASlY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 13:41:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19172 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230156AbiBASlY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 13:41:24 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211HDfaa003724;
        Tue, 1 Feb 2022 10:41:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vdoN/XHgncQADJnP3aygiHnCOlpdja9C5t2HABuVo5o=;
 b=XXqVl7fiHtMEP8cFfEeLRuJyc00XZEC/GRr6phA9mkhVaQvJ2Y5XTaB8DqtZOO2PWEiI
 UF+VW5s9gXdA0FetDq0kHjUO+v9/vkUVWClAcNQ9ehPfvNg32EYebaqjicdoyVeddbfK
 yuEwTC0gna+XsT59KdjxMSP3pYGSFM7Nna8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dy6n9ss78-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Feb 2022 10:41:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 10:40:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRjCu9BgKBlTRGEQNET9oNk41/wQu+QzT4CRrM1HXq6F1jZWbDe4Fxl9YUatCZny3u8LzypFoDOHgNV1UXcuZaEcbhtYODgrjNRgV7hOzalHO+wi+V5DKqbZemKvVX9pzw8FcuR5c/PEYeJL9uNuynM8l+cVLjLUTXue5jfN+t3ZevLp1m3mwBfKYnx3tHX3HFyl6hsaQomm+Y9wRL4kppVUPqtF8GrGLdov55h4ryKDwTtGEESKn/fJlfqGrx4kfnTn9h+lfCKGhJ+kYogszfAtelsItDeEoMmK+A3qll/Jq1V2Q6Do0LzHasP4pbSNPXaBr2VQzcS954jkqZtG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdoN/XHgncQADJnP3aygiHnCOlpdja9C5t2HABuVo5o=;
 b=fXvLsR5TFNuKqcHp5nl7N40UtXA8udoJNylvQnTb2GH7Cd+6N95GUtw9iIou2C/ryY+4VvPgtDSwfU74doL4Y8OOEQPEAxggxMd5uy1LoLFvq0GMcvE1CU8k/tUgF3M3pdUimF+HCDpVfpcRPHCZOZAdUpOvH/KBNFZgQiJDOn0DsBPKZTPEr5Tff45XDjjnOhSGwcz1uPaey/pfAkHga6nQ9sLaepTgenznM0HAeEGDKU8m49uMCuyE8+JTD1U1uTR3tBQh+G9xOSLSfZ/seJAOYzlx5W6MroxsDitNevH68RjEKrEoD+aPBfmH9/1gxAbjbbOH5EV/OtHt7g1Jeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by DM6PR15MB2620.namprd15.prod.outlook.com (2603:10b6:5:1a5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Tue, 1 Feb
 2022 18:40:57 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437%6]) with mapi id 15.20.4930.021; Tue, 1 Feb 2022
 18:40:57 +0000
Date:   Tue, 1 Feb 2022 10:40:54 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <davem@davemloft.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/7] libbpf: Add support for bpf iter in light
 skeleton.
Message-ID: <20220201184054.fviyzpmzholmf4fd@kafai-mbp.dhcp.thefacebook.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
 <20220131220528.98088-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220131220528.98088-2-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: MW4PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:303:dd::31) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2963df0-a586-4160-94b5-08d9e5b2628c
X-MS-TrafficTypeDiagnostic: DM6PR15MB2620:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB2620CB17BF57A9590BE6F584D5269@DM6PR15MB2620.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbxiArfvcp2abgYu5UTe38Akr+mlWcJvAOSCUFl34Q7YSIFMsJDtvDW8vx659CQ10Zq4NJm6hwvO1ueJJMsfU0Y0z7NTIT/eHM58rngqgaqDtqqaRh/UBLOJfVU5M+LPKIX38Mjb7CC7nR9R3WmiJIyrFNSeWQUqUh9VZaJd1CGcgfJQaVqWu2ecYnc2AWK6aJ46pXXcxACOF9rCD2vWlRzCrHfXvGbvCZDRaFLWUHMYel7KfXXWqj66HaOa8tbyWnUxb+TNJI8SmnrDLQZ9YafAC7m87p8LU4BOULX6TqS7RaVfgQPybJeDIX2czIJOFUwv2PM0b3VpHNK/WUf5ap24iNbKSRoho/MA35h5pgCm7SKBrG9+Rq2J0MuAu0V16w0xkW3UQpgpZ96ijzGusaKSUveDWfPZt2cR+HKXikCqPeX9ns5TIDeJdKEqQu90gfPhZC0rhRS879izQBtKGN4F6EUrv0VNhcpxJy0zq/fUKFAxiB30HNNTPMyg9wy6OCvgAPEItK1TDkFb4NnTByheUcL0+aYs8IlV5SYx9GI+HLMbQDBF18uqlz1RK3Xf7wp7QwXCRdpvco0A9PsEav5LrH7znPFwDRemZxNNjMF46XGclIT5vxou48r9CYefc0deIncpps9ulGcDD5PjdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(6506007)(6666004)(9686003)(6512007)(5660300002)(508600001)(558084003)(1076003)(316002)(186003)(6486002)(52116002)(66556008)(86362001)(8936002)(8676002)(4326008)(38100700002)(66476007)(66946007)(2906002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cz/e8ahIktj4iMUiC0lC49Vtx73fCAxRH/+742fiJTvgZYcxCKEpo4gtgPnF?=
 =?us-ascii?Q?K2/zBcVfMwoZrlqjN1M4UN/Dd4nKI2PnkFFnROFzc0bmwNmAB9L4GT82wfdx?=
 =?us-ascii?Q?IxWamIfRNcytHIDXo4Rox41Mp4xmveX0Ns1z9t6z4S2Vd1UWqJycl6EYGY8q?=
 =?us-ascii?Q?r7TcsfD9kCDvLpn4sj6LbFrq8kJqlqR876hnG42YKIYX1tuATEI08oBLDrBl?=
 =?us-ascii?Q?A05dUyBaGuNLfyJf6VY8iW4wfg5aOSDn0cPsqI18teI+IezKa/U6v9dBFXiJ?=
 =?us-ascii?Q?XjvBrxgX0Rysh8ll8MhJB5WJT3ou0ulL9n09eIbFG4zb5KObmcsEvc7WkipA?=
 =?us-ascii?Q?9AF8BVspxtWcLxxZOtkH9abr5+0Cq+sJHoTPMMIh4lqeLYK5ZC7E7SspWAZl?=
 =?us-ascii?Q?crXyKFobUHZrybuIG7rRNJFt/dsmrLalLtLGTvqbZSu+RwnbEbl12MPPn2yC?=
 =?us-ascii?Q?y4Jngff6J3H4IYcERAM/qOQFCLD4nGbWDitGgNPuqzfI9Q3ovwjYEJZnrMsc?=
 =?us-ascii?Q?RTgXTFli6EVkyuS8NF5yDUwPzEb0NQP3COI3toxsp6m+fToyluSlgT+6LmKX?=
 =?us-ascii?Q?cYbL4tfv7OkvkD7IJZlCyNOhhG5zJp2GiS4x38u5As8eDU7ZSXuKnZhyn6Fl?=
 =?us-ascii?Q?FEliUikuOca+uaDFeZYRr8YopND35GW1p7pRZOfmJ++ZpJdKHcr5l3um39L/?=
 =?us-ascii?Q?BIdavICmaVEsbHSFPE5+ZmxFETzyfLkT3OdirNGxyX1dV7NQQelsCbgoHqcd?=
 =?us-ascii?Q?Nlmp9YSONaz025eoDYpNJxq2n07wKDSrk1nMKiuEpMQOyUN0ws6CQ+goYSIO?=
 =?us-ascii?Q?yEYKrWhfjZC/i/uL+hynzyLLPBmos0pJ2qLNJ6vVcTDHz4h8JIci5fZd78OW?=
 =?us-ascii?Q?N3Yq7+xX2IPxPfCSVGaLpZUlCvqyoMdx3/b2UiXSE2PGWttFYkeDtIH0lgpp?=
 =?us-ascii?Q?S6o2TNSqWwvIkTJaC97lYq//qN1Blj09bK2+bQo9bKG+o1yG9tzHHqO3oDrl?=
 =?us-ascii?Q?jT0NhdQUb8izWEfbAhcyPi7ec0BmUI5FIWFaQTGuIeQ9xPE8NBwRe1ZNC5Dd?=
 =?us-ascii?Q?n2jmShk303apglo1LMNspo1Gb2OsCYKapE2ildSi1l8ofO9JZcVhcyHw+Jxx?=
 =?us-ascii?Q?L3zmeVq7pZH0rOQ0bgRYaLsoapI5Ac8iPujgNlwvR3MsTts3XBkm9m2ssABB?=
 =?us-ascii?Q?/Jllr/z4AQJW19zwQ4Nyx1wIxAijQcD/u9yHXjD4NjSGYFPdmeP4dMGb2kWm?=
 =?us-ascii?Q?s1OIzsMCwUTF+InoYRQ8eAL6hAAzjOm0mFiBh1VJ8byo2+9pyQ5CxisAtfhQ?=
 =?us-ascii?Q?wxA/c8VzGZH8WX3PX1fAuVqz+J5geHHm/vA8ToOdUzr87A/t46D6llN1Y9/s?=
 =?us-ascii?Q?zFBzWJns158ANrqtVDLRlj34PN9gkLbZAXf4X88z9OSe+Q7o0qR+HBTvIEVl?=
 =?us-ascii?Q?eQV5lfbZ6qaTsITFVsjg+To10P1vuZtK2x46lEViaLBbsD+kY7uY38kXfmtb?=
 =?us-ascii?Q?cliMmIYjnNHnGbprVjOlUBrKwuaaoveF1lhiRQ0/ydxeZ/RWN8Ons9OwGVDS?=
 =?us-ascii?Q?3+Yw7Rgy74XpxY4KYHjASSC9gX1vCtoiyJZY3NJ8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2963df0-a586-4160-94b5-08d9e5b2628c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 18:40:57.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4kqyP81gjCNmYz93tMaZ5QkeYU65avCIU0YEghDPybAfCDRt3YCiQldlCXpX2Vv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2620
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 6NQ2eheHap3h569s4SNYEjVIL6i1s7gV
X-Proofpoint-GUID: 6NQ2eheHap3h569s4SNYEjVIL6i1s7gV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 mlxlogscore=685 mlxscore=0 adultscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 31, 2022 at 02:05:22PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> bpf iterator programs should use bpf_link_create to attach instead of
> bpf_raw_tracepoint_open like other tracing programs.
Acked-by: Martin KaFai Lau <kafai@fb.com>
