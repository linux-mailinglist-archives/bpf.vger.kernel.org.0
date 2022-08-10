Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C5D58F0B5
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 18:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiHJQsx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 12:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiHJQsw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 12:48:52 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A4722B27
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 09:48:51 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ADBluo012658;
        Wed, 10 Aug 2022 09:47:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=yeGtBYOfrA5xcSwuf4XXDMpLnAbJCQJIPFYVuCTYDwY=;
 b=nDvQs/CfTH5KfAxjg+mGEHxFhEfq4eJbUqZxLP+RtEMOvA7biJHSXajQyEkMIVsDPIdx
 7Pe+WHhNMTfmwKy5HXcsbjcMsDDopl6zdosObpeYDOIjc+3NuI+yvf7pdi1yPhRRfYW8
 2gpBePVbfTbfH/dlladgqHNdBRiZHOxtDjk= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb69vaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 09:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIgdvtzlShNyU3l8nf2ouWPyOszUXzdR1935AG0fRIVyF6JmewpOaJX/ff5/iTdmY08Gt2AFiOne3/lb6ZRed0OxVi1EW1IfNPlZ6FSpCdEL7UWeCyomdLFnEryIrfrkbZ5e0i1PgMfWlrwrk0wv/0gIq4Ifg3L4CEEOVj5HpFxB7EyR6ozT5ZIfP07SWndAfqljWRYx5goWu9BSfmjUb+X8xzbRw4kL7y1swCDd3pSQ0Uic+Dxkq7hN/KZZfQ+0KNz65b9GOazkGCmPk6vItNE7JBq9bhJZBFo6EzM2FnW0uu/qS0MvpnqWnNmXKBhWFNQImdrdlpKlXKH3QvYMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeGtBYOfrA5xcSwuf4XXDMpLnAbJCQJIPFYVuCTYDwY=;
 b=jVaF4rDq6wuj1hzGscihGq35gx+sDkvbdPb3tuDOqThY1SIroR4U6tZzmR4CMNpWrp821dRTrFve0vAxIjebZzjBl+0JZjzsDGBqYC9/620EM5/FKSXdZ+0Phpf7vFsAOiNYzYUjFeYq2Zd8fCFghRjD25yfkXYu4r9I6bdANRcdRcZqY0c9m9AtcESWzaDgUZl4Jc8LTstKFPi3q5BYMva5b4K91NZ4F91OfDmI+zkCx7l7hSTApUzhu819WTqsf5PsEEOhezl6Lq9jD6NCIqEknFcLdYJ4OXgK+Wz7agKmTKbWy4VA8zzeBoRpY7LevdpfVuSG4xzQPowj9C6h0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM6PR15MB3420.namprd15.prod.outlook.com (2603:10b6:5:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Wed, 10 Aug
 2022 16:47:51 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 16:47:51 +0000
Date:   Wed, 10 Aug 2022 09:47:48 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: Re: [PATCH bpf v2 3/9] bpf: Acquire map uref in .init_seq_private
 for sock local storage map iterator
Message-ID: <20220810164748.2q5zsevsy4w42rek@kafai-mbp>
References: <20220810080538.1845898-1-houtao@huaweicloud.com>
 <20220810080538.1845898-4-houtao@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810080538.1845898-4-houtao@huaweicloud.com>
X-ClientProxiedBy: SJ0PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::10) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29fa10e2-76f0-4a87-43ee-08da7af01073
X-MS-TrafficTypeDiagnostic: DM6PR15MB3420:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eN7vU6OYV2DV5R2csO85/5vwanswiMWGikMjFGQvkKTB5lrMeC80cueYLT1RXUIsIg6gAp/K/7y8zabkVazHVD57V6jJoViToLtjvGUWsCY7E2FA5Ki/Gmtm2BxDa+EJVlOR6CKo3zQ5qnyIqwtkRE5enZ1TXV1j3EqvBPkv3nFLsR3LUoMQM8ke9aNAMpLs/GebE1Hi6k0RQywg8D6gnk7dHA93OEZrRY3zkvoR6ira7o3o3INztSvHuBae7jDVxQs7phj017M0UBTbH2kE35pNbI3WZdGe/b7O+TDwNFobwcaK7R/W/eD6+sOtxeNM5q1iv+QyRZW5TdPmpEWF/AuoC+CoTQCH693G9HPcY70QrwvtGOZBXKdxHSI3WJarYuI/VT+/lo8Jg/x2gfqD5W5Z2RSYZ7aY2/7oeOj4XqfAH3/uTpbGMDOBJLU6AT8FAPlJXRO3Ajcfmn5kklHkL5eTyHJaZ0quwZ2YIKFR7GvtIb9ExfYbuLu1wjfVu7GNmMOAYA+5B+1Nye+lEnobil6o8DG6W9K+UPiPlP1OucQ9F6k6YXCMT+lLM0TjSrH5IZjx2wg0qWnQ/dhIAgxSdPDyVaX87UFz9sOfQIr8lwS+uHo6paNf42ZtRuBHT9x7dahD1OygVPRjHwM1Zp0PnLA4uVpEuFLY4idpTpod0RVYUR9IdE0KL/UkQKsWW2ZwaV0K1p1BMW2Rs9mDAqXu3I/SqOHkpzrC7H4dOfHCX5eMBMMYWJ95n4QM4wUFtSSvLZsLaSzxN31znmqPOVqtBM9j0ReDYIEtvAHdCfEDf4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(66476007)(33716001)(4744005)(38100700002)(7416002)(66556008)(66946007)(478600001)(6486002)(54906003)(8676002)(8936002)(5660300002)(6916009)(86362001)(4326008)(6512007)(1076003)(186003)(316002)(9686003)(6666004)(52116002)(6506007)(2906002)(41300700001)(142923001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G19dGzXmQdqpS7dce0U2PY2CKa+uUDeGgPtFO0vQ3vh1unXf7BvVYfI0Yzsj?=
 =?us-ascii?Q?SrmhqvNkLdyjRHdfww6S1BFEJwUHYrpFlz41qPnnqpdq5muXUjClVSYllj0F?=
 =?us-ascii?Q?yneIpY83UKzUGkr63+Thz9h2IRHriyetCuf9CIEbfZn3ma2mdzsfvOdjtxFR?=
 =?us-ascii?Q?kRI/Q2vcAZdcTC38UJmute7EyrSGp/tuUBU6Fiks2Yr5GRWl+7adpE6qns01?=
 =?us-ascii?Q?e+UW/SlPtJPHdGXh4+YdfZDig/Pz1pzxkTxitsqAsSV7B38uuD7GbcXflFA+?=
 =?us-ascii?Q?v52OOwHajUxeqixH9POR24envMIukYNu1YHoNi0UGyyfufu4OQgLf4bEEst6?=
 =?us-ascii?Q?KlZIJD4e2BJ5g2VCSotEW7c7fAXTnJxjJV5SrbHT2QTXseYftJoCyFcSxuHs?=
 =?us-ascii?Q?uLSmQI6tQkL26oMMXQmKq9LHZhq5wNtQaOnuWiQy8IX3UWXeXwxbp7/UQuWC?=
 =?us-ascii?Q?IA4nS/YJs3cEEJhNS6Ck7+AAcMZqEviWFEAbzzKZCsTqXRL0WMVsyHS6gacN?=
 =?us-ascii?Q?lX7B3Z2JIn99jI3WG9WN6dLPy1MZlWui3mjsexrjBXAoImbprlPuEYwtZYyy?=
 =?us-ascii?Q?mDVKRQ60gipOLG0ah3+S2Rmw7DQWw2dPvl4pMGi+6OX6AIsYOH5OJbbND721?=
 =?us-ascii?Q?vhYlpm14yEMeL9fJYgfxyIS202RzIJZa66+/F+zyb05p9wxvtnOQ+GhPiSBr?=
 =?us-ascii?Q?Y3BhFXUzmJA0Q5JCBD/02X0sv5vGlXLSLio5OgCwPHZy7NyWESNREN08+sKR?=
 =?us-ascii?Q?96XcIberZWmbe7czlbQZae8icm8wFHNlKGtq7dSlzrPh6HRQYnw0VaHO6yzT?=
 =?us-ascii?Q?1PHE2uDmFIkghupJ+oDnwdarur1vHQqQL++0D7y+9aQjLuscre1KRjdUyU56?=
 =?us-ascii?Q?BHEjZJg7YD4t+rgD1zs/D+cgdyktdNY9QTbtaGy2DQ+o34ancJVppjAKbz7u?=
 =?us-ascii?Q?UP+tETTg0kL9yqVsrnQR/QMjy9pUCWEDy2mEo5DLcqzrg0/axmHqerX3pKP6?=
 =?us-ascii?Q?v4MSWXVrc406NuMCwVBdwjjbDtRD9RGUdflK6HBOnxkQqTRF5XGTpgIB6Pa3?=
 =?us-ascii?Q?2au+VeRKC2uRVdj1fUvuRL3H2POR0FEJUWygbzukzpr/74gnov2Xj/zkOzm0?=
 =?us-ascii?Q?2FrxhnBWVuwO/Kiajqdwx+rYk8d5TVH7vySWrqYtgjempFastDPnorAf0I15?=
 =?us-ascii?Q?51jilO2ky03fPibxqHMEF4EMq/AsZZq/0TNAHbtn9MxxiP3j9WBogDwcHasI?=
 =?us-ascii?Q?5k+u2q/Dvpvb52Td3aBxITXVvCQcsggT9U/Hwu37gluClFyivNPKTDP++sV1?=
 =?us-ascii?Q?NsbAINgkk1soEBxh1Y9+mW/6rUlywvs5wFUH3fUDSyhN3R+6M8IskUBlMxy6?=
 =?us-ascii?Q?fWKedfzjeLDhH2S/XI2Qk5r/NI0bJMtPINiMljldW5bYv0spxhB4HdB/oE4W?=
 =?us-ascii?Q?+uh8XOHRdTSz01Z8AJNAZ57GUsHG25LiaIfQcK3uyBxAHk2PD+jsbux+m2Mj?=
 =?us-ascii?Q?10WybS2V7MQ5NY0SUZnDr0WtdmS4HLRjWz+oQj8+IL1aQC+e86DzG26XDqhf?=
 =?us-ascii?Q?QXbu86Dd50xNMgvl9fvwbRrokAcC0ULorU1slMJ9N4VfJ9RTpyG561siXWkD?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fa10e2-76f0-4a87-43ee-08da7af01073
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 16:47:51.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vza9dhU1leydMgi3yiTWm0BFFWBm43E+vnyEelotqPNeeZix7TWMf88c7/JmER+e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3420
X-Proofpoint-GUID: lWeIH9wzvduAjKPJJtwNGSCUkVN1OGxS
X-Proofpoint-ORIG-GUID: lWeIH9wzvduAjKPJJtwNGSCUkVN1OGxS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_08,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 10, 2022 at 04:05:32PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> bpf_iter_attach_map() acquires a map uref, and the uref may be released
> before or in the middle of iterating map elements. For example, the uref
> could be released in bpf_iter_detach_map() as part of
> bpf_link_release(), or could be released in bpf_map_put_with_uref() as
> part of bpf_map_release().
> 
> So acquiring an extra map uref in bpf_iter_init_sk_storage_map() and
> releasing it in bpf_iter_fini_sk_storage_map().
Acked-by: Martin KaFai Lau <kafai@fb.com>
