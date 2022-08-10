Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94F558F12E
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiHJRGx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJRGw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:06:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47DD61B2F
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 10:06:51 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuhvp023576;
        Wed, 10 Aug 2022 10:05:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=tCznUFjTJCt0D0mtbSdfjAokKbp1qWo4tBg6G0jOGvQ=;
 b=IUZNDNFKcxYkmHwjP45iYfvVeYfZ+0ox0r8wrXxPgwRgA1Vowo2T1J7x7/sJC0auj2PF
 6+tlibWCkETxHRTjE6V1w1+2O7k9CNaofBAOLy0dSCFPWnRE8ZycljLCDS1QGKkBDqs1
 z7syQMmUd8GjIB31Ve5CdMibv068OljGrso= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdbat0e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 10:05:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIGXkXgr82B9aMZYgXvW6FOJosvHAGXDWk2ebd/irY8phJ0XhV5XXbS+pOA1/L1ZpJ0DBX9ZpGGuf8wJ7oimNTgY6Q1uf2YT4H0FYdo1WVvCbudLrgHp+9y1S9UAjUX6KxUcl+fdLD/LG8AnmYGqfU6W+k1XZdzEhu95T5ksvayrd2RDT1jPP4ufNPLXtwQepWajBX0NcZni6YReRrGdu0H4FX1wtj6bjqXOS0IBHsz8S4fRw1u8ykSodO5WUpRFM0c4Iw+I74BlWwFa+n0QEEOma2Tle4Gj8sSylgKBPMEhWELHlT2lpQbz7d6TiQ/9Rb4Q3e5SfikNXE1gWpp02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCznUFjTJCt0D0mtbSdfjAokKbp1qWo4tBg6G0jOGvQ=;
 b=QtdiTpTM0QwG4ks2o381LBt9xEZoZ3SwoqvzvuuTTQAyXoEIlYQg1OZgy4KHdDK1mMTIKpskOy4WHhOT+XvFjqUAnW3lzN46NHnYoCqtIETgLCCt3fOjmqYVFG6zVhvz66w0DhRnNopXSEoRxYcYqXUsPWYDbD7p85RQonPdwQDM28a62Al7f4qAgQlugQpHUGKJqqC7aTyziNksayE+SX9b8jisqUmc5cQMg2SFdMzhKp2ayvFiptpzwvGc/IQk09IbXxXG1x7aOOIOiOSQhg0qhocEJWQSFmyK625pxgZ11Hu8SuotlD8NqiCLuwi13e/000v00hoav4oYjpUSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by MN2PR15MB3024.namprd15.prod.outlook.com (2603:10b6:208:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 17:05:43 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 17:05:43 +0000
Date:   Wed, 10 Aug 2022 10:05:40 -0700
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
Subject: Re: [PATCH bpf v2 8/9] selftests/bpf: Add write tests for sk local
 storage map iterator
Message-ID: <20220810170540.7ozyubdkoiafqpjc@kafai-mbp>
References: <20220810080538.1845898-1-houtao@huaweicloud.com>
 <20220810080538.1845898-9-houtao@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810080538.1845898-9-houtao@huaweicloud.com>
X-ClientProxiedBy: SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::34) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92114d42-b185-40f0-20a8-08da7af28f3f
X-MS-TrafficTypeDiagnostic: MN2PR15MB3024:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHRlXzl61P+NwseOAE7YfdIiCt9TaDCHp/WC5v6S0qpx3Lit8ZvPJp8RcYZENaFYDqbd2Fvd78ramwZsy0HWnF7peaj1E32aGlT+cttHArQke7RwD6sOa3X+dCbKyT3NATza1uzvMcbNLQ+g2ZkdLqMCdu9hYhVsCM/3tC08yo8zGseXWLDrPmOVeuLpjo1LrCYPr27t1LQWOQ+nZOtOxcecQoPHOkHwPn2UE+F8uZTOiLf9RXqyuqbkX43u2zc6+1UAH0f2k3WjauxqRk9wAk+9rlwInZN8dhssudTtWyFEENNK5I24uwyAa//71FNL/YOxswr1mNRGEUmgGAohtR5ztvAWbfYYrYu8oI6xjSKKD+Ezj1KoR/EIfZViHRqNXfFmUluN59e7EiqNyXuF4Rgj4XXEa700GEqjUEKQAUVSsrUA1ZzuyuB6NFKx8ePZ0dQlDbewf6S1uLOUNB2IZFmBNJTd2/cgkdGdOdy+ykSkrtrFcLtzQcTGxH5eaY2KslzpGQj51oG9AYKSu4V0k7oGQ0i2JgBn6vPWXlx1L10E9adbNR0qISoN3Qbe8v32FwFq4x8XZGExAtK8VAi9t6DWdN+2NHL6oeeGVj+XMfz1TQ/WhVGxxJz29JP/dw8QphQHhukTL6Crn091oLzbK40pdUrhGFAdFI1wiv0onqN0IsaHZw95sZoEg+uSE2eQMVXbS5jw3LMKIxpzd60Cs9XW02kCb0t86sCKwjYN5Gaj9o5a27tUyVSpXq+SHbnp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(6512007)(52116002)(86362001)(9686003)(41300700001)(6506007)(1076003)(186003)(83380400001)(38100700002)(4326008)(8676002)(6916009)(66476007)(33716001)(66556008)(2906002)(8936002)(7416002)(6486002)(5660300002)(66946007)(558084003)(54906003)(316002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L/2M3wsrTrmkZ4eqE/odvw7LhQFZdAUroU0o8RHFfOrX7S4udkTDkWAuJdbq?=
 =?us-ascii?Q?2tTwbUt2JqML0kL0Z2qELiTZBcE9UofIMc6U6QAhlvzrjaJ3rANFjl4ukCcQ?=
 =?us-ascii?Q?awPtyqGH0DfjU8Ex5DTGFrKQd4GUIPHgJ3CWHb4DhS55e0kxMavP2/v/kNha?=
 =?us-ascii?Q?pRRC0fi1zagLjwsM32rH7U1nEh9myWJoTL9fJiROYGx6w23G8CsnhTxJSB+/?=
 =?us-ascii?Q?lxMTULiWwgXOOj5/HYHQ1GP2hzmXi3uPjt5rxdr9jGW2rV0Qi3Rm1oQ/LYoI?=
 =?us-ascii?Q?SkCHhJ5HXHx3U+7UWqSa52p5cFStS0xgiMFEyUhQJM2CYJQlBAPc/Gf6lQEo?=
 =?us-ascii?Q?KD/0yAEvMf7yIV5r7XkqhuBScjX9pOga65QG3fED7AZKbiaKqB6fSbDVO9Yq?=
 =?us-ascii?Q?X9l5GHrAADxr6N8KK1sG4x0x4/JKieq/sp1TJSWpj7usjO+rwT+zNksHeRBC?=
 =?us-ascii?Q?+3o5zlJHAA1kzQLBxv1Se1rVAhOZ1kRqOxOTNXvw0P9j8gVKZJJ1Yfoc+JkG?=
 =?us-ascii?Q?UchOygDwTO6yukHGwcmm08i5kJOy22L5y6Lh9AWSJ3Il/wXqaKyoworrBPMQ?=
 =?us-ascii?Q?fc+V71Rrew2+9XKWUCuuUfuIS5z4H8V67rS9jnlfWrYtO71sJM7NYMwX9wgb?=
 =?us-ascii?Q?bChGas16sWf8yytATtjOoVUMpWwIpTgdU1K+BVOSoPo0Y3jUd4IdinOnqBs5?=
 =?us-ascii?Q?PwDM8uer9oP2qIPa4+Q7Tsoqz92CVi143Nl1hg80FqKZIOMU4PZ45vphBr6+?=
 =?us-ascii?Q?B2IBWaOBhdYHo4D93rRX8QqTmLZiu6WK2nhTvLWnXeGzGd8QU0X3is8KKz8P?=
 =?us-ascii?Q?X7s964yibaFk0x64gtnuOfSoLoJ8rfOUb6a27osozSSEoNjpjcDriL44Cehg?=
 =?us-ascii?Q?9seIs+NskECZA+qTDOoBCadU/JWZT3rAHrbEUSeCwREzbxc+vnJ21RBs53SN?=
 =?us-ascii?Q?lHPAPYyOR05gUKuXjecB+qXKa3iEev4scXzGGvgxD7LM+NOltxMMmxtuKN6c?=
 =?us-ascii?Q?q6Ls62dKxjXCf9NkeYsaq8owvJoEfzus2RlUN7xA/3puvFYpljlNP+QNGPUN?=
 =?us-ascii?Q?0yJh7VrDj0B6OXy/Bdh4dwVG9xH2ga7lRdwSLh7NebEZP96kkVcG1yNqClIR?=
 =?us-ascii?Q?zAIbfYLkgWlUKibVMq8XxaKFd2o5S8wcpENNHu6n7aPb8GHfrm21EXVpo2t8?=
 =?us-ascii?Q?X2I8kssTYDuAE1vgxvAFa85K4uw3mZTwmdxkRCHiwrlpEs8Se8BUETV7CJNV?=
 =?us-ascii?Q?x/oy94f67wzr2peFB4P/Hs+a8W7pR+wMUUcSnMPpAhmhp+3j4LmTXclElrWL?=
 =?us-ascii?Q?y4VBlEqdUaphXNuYRAXgLPkJ42ENT/y9U7YJB7U/j8DSiDIq223BrLYuAGVn?=
 =?us-ascii?Q?ElFnlFOSZHOdd+JqpKA5ZJY27vqduONA9t4QSsGDb/cG2xDzBdmhgXHkXXKK?=
 =?us-ascii?Q?jMu5yOKlUcnbReCh6QSIC86XpNYEUv8Jko8TCtkIyJUHHQeZo+KUl7YVdnLu?=
 =?us-ascii?Q?QJaAwmztez0lrKcGQBZ/bRNrX4NciA0rmo9AUsFIMz+m88OZKmyEEsOkSDUN?=
 =?us-ascii?Q?sTSlkDVf9Gih85KFLclr5xxMQkEkP2uUclHMkbxVTxKmoSgP+vv51Ytl2FuT?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92114d42-b185-40f0-20a8-08da7af28f3f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 17:05:43.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ik1+HT6cGgR4MSatpvQz7PIBgyUN8+wAE4p+nbt3J3RuRAwMpvXig4jIM/qoPYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3024
X-Proofpoint-ORIG-GUID: CIzqapafxrOp2nErDTlZ_lLdB3hE1ZJU
X-Proofpoint-GUID: CIzqapafxrOp2nErDTlZ_lLdB3hE1ZJU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_10,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 10, 2022 at 04:05:37PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Add test to validate the overwrite of sock local storage map value in
> map iterator and another one to ensure out-of-bound value writing is
> rejected.
Acked-by: Martin KaFai Lau <kafai@fb.com>
