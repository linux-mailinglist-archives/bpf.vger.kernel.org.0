Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2086B59A595
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 20:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349812AbiHSSWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 14:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349855AbiHSSWs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 14:22:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAF9BC810
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 11:22:48 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JFAXXc020616;
        Fri, 19 Aug 2022 11:22:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=hQb/NLObOKF2c0H/wvvfOj+z+ZMthvQB3bSZ4sSXAj4=;
 b=j4Y9OfrzNYSMuAGean0wOe96XpFT2nypzu4NbreDr8276PfS0bjg077POqCD9C7fc+cE
 HwjElARKjRjaJjfdhr3WbY9Ko7P6Z5JK3yv0E+Ow8EnADbh/w/1MgcGHz2fehr/kw5vV
 0o3+mBgPthhmEHE7zAlehFNvoojdvCD/8JY= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j29tmuagx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 11:22:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N55qOs2MOnutdD1io/q37VvOardyYG0unTIURk0bnbjyBUKEW5Kz9gQmUfiFdDkjnjYslJpXTH27cFqpisI+9bp3UYcigdwI0m5SpFDngpo82l4mUpJYxBw9c3WZiwHaX/e8+OaurHZPfiJbKoA+JtziEQQ+8coYJiJS2/MFJyuZTNYNFIaXiRtJRf/LhPtXIvo8pd+nm+Joyizm3Spl3BVYP0o/FnC/DIuYe9nZOPq3rjizj2Z+ZfK+gGrbz8X37QFepFyQoAiSv3GD6RaW/m5Gd9NL4N/Tm3C8eT8rX9cC3+DyeNg4lnwzrDDNwJr9S5edzW+8mgpajzu75roN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQb/NLObOKF2c0H/wvvfOj+z+ZMthvQB3bSZ4sSXAj4=;
 b=Du23LX4v6vwfubl9F2ZG8NajA2WyUNOU9sNv0Ty9nJDWWOXJ44PJwxEv8g1AYwxa+JH5b5YynF5NrEVh+mIOT8NmwDVtRy4+94HU4GDhEy314NdkPo+fFCDSURb8WMicQdbnI/y5yb48y/c0Ls+I/P6+TPoXG4PUYVQt+PzNGhh8WkgaROd5tDs1CrPqOjimV3cF6X0bNE5I8/w4MAj9I4HzQogh2RUnNtNAjs9pOUsV77+clPVp3ZrfVXUtetM+zsGDVJhrIWLsH+X0iDNf932QnNqO6iOnceuA+w5CAfuEIbjJ/k4O5evxnTRe46X16c/dUwk4T8i8CI6Q9OrXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BN8PR15MB2979.namprd15.prod.outlook.com (2603:10b6:408:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 19 Aug
 2022 18:22:27 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%5]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 18:22:27 +0000
Date:   Fri, 19 Aug 2022 11:22:25 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v3 3/5] bpf: expose bpf_strtol and bpf_strtoul
 to all program types
Message-ID: <20220819182225.q4xjs6gmj6zzaz2i@kafai-mbp>
References: <20220818232729.2479330-1-sdf@google.com>
 <20220818232729.2479330-4-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818232729.2479330-4-sdf@google.com>
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5656a92d-c8ad-472f-b075-08da820fc578
X-MS-TrafficTypeDiagnostic: BN8PR15MB2979:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VR3nGGpqVj/mT+o7wLvMxBRSXilmkSVViPRxQk+juPrkoNw1G5alojkADbhJe71mvI2AHXlS0mLgNxlp7nRwDmcLmLAyXiQIMy89MC6uKXkXakVen1AEBy/B+IZy+yq8UEeji+IxTq/I8gqEhkgmZtb560YUpXYGf8BL78h9wPiwpIU0n76LQzPXMZ/LDnGfazdXZ+IdyA0Aozb1SBJyB27teF5sqKVql1e8e/RHcTUNRz7dh6qA+yuhkA4htOH+0p5NdWDbbyNMpEYnxijEd8WXs/8z77PwvA8EvZLr9OOwFLcrCGxNk+qIGy+fT3dMP4huYL19wHp6rblQlp7kq9S4Z/QKOBiO5SqcnjaQrAfSQr3+RQTk4l6d3f7mVuHJpff2HKPFB4UsaHl6ten6ZMYb/83/LdbqjCYjCNeMO7nFx7Momj+P+XPYJEcoFiEJJWoghKthadEyWJuu7TrY70ZhnKO/rcH+rYr19iy50tyuaZfsvbAKBxw/9ZZ6V5BMQEEOP4m6wp9lQ13i8ft9V5d4Eb3ovFYHxehiUwKv0LhJQjtmJS4BZV7XbJXrWTXb9C9emlAHbVhy+4qR2lWEFnv4g5Mf1C6u9K2vNCYnzhzSBqtU7oU9cJf7ipn7RcCl4tbcZtu9DNxgpO6dmY6Cis5OzX97lF45IzcYZeIvZidhEdu9Mqhv7KMwKZJCUBgxCfipEf+2Wlbs3SJW8MpTDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(376002)(396003)(346002)(39860400002)(136003)(8676002)(5660300002)(9686003)(52116002)(41300700001)(6512007)(7416002)(4744005)(2906002)(6916009)(478600001)(6486002)(8936002)(33716001)(6506007)(1076003)(186003)(86362001)(66946007)(66476007)(66556008)(316002)(4326008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DmikXKLl0iOiVrzwJaDkKQUCpROy5+6Hd05iG/QCNyj5vV9IYXbiga60VJz5?=
 =?us-ascii?Q?WKLTH6OKpmXnWQFHVU37TEodNrRVsfVGOXiZD+HF0zoNlBnnQSFMI4kyy4A2?=
 =?us-ascii?Q?ux2A7aWLVGPBITGuPlZXsVMEJkM0tPkz9t2sEpGDAGRhPyesUlA4lQbbBfvU?=
 =?us-ascii?Q?Dv4bestMrTio95HxDnjZbczdHWthsDIDi3X4u4Xgi9SlEK2sgkSrJU2X7c1A?=
 =?us-ascii?Q?GFGdckWdqp/pVwQyApzG+yweNdTijuaCHIhBl6RuBmWPmZySRLwFoWSSmhVe?=
 =?us-ascii?Q?eWD+kkcrkRzppgmnVxSCaUzR9sKkB/b82C1IgXqjqrSFgnfnLV262xMizQaJ?=
 =?us-ascii?Q?U/hYdbJ2lVWtF9oHNh2Ltkvr6OD8y6nVfvJoSXEfesWU7nh+8JWxrZVDqmUU?=
 =?us-ascii?Q?myc3qPZtpemCJiTyCMi1Rfk+kHzucJW6bKvnxgjtLIHO5JNHkucVN7EnSYav?=
 =?us-ascii?Q?u0G6+Q2r5aBV0iHsls0+Ty0r4AANwYA17YpxXG39AUvopa1pivC30Rrdv6DG?=
 =?us-ascii?Q?H6YzvIctaFTYQSL+hmXwdBZifaHHSX0Zujp4bioZREWc98o4tPe4Zhq6fiHs?=
 =?us-ascii?Q?sAjqaN2ljkTMapZTMeoO8oM7opr/76UG0m5Mm3V9TZz1elAUMApOI2CPAAiZ?=
 =?us-ascii?Q?PYMKDAG9P0ldFpVWvW0Swav6J9IStl/W7TDJ6PcgFYAq9P6U3R/ZZs+jKZDO?=
 =?us-ascii?Q?9ida9gqeV314CWdmYJC3osQWggCTPyo2PbMyx7V1C13SYnNGv9pPzA9BLN7H?=
 =?us-ascii?Q?O3KydiEDdFJ5v0Uc7c8HIkDcqoyAHlBZM7fSnZq6V7F91jQFPHd6c/S+4S/w?=
 =?us-ascii?Q?le/aVFfLRjiB1dBeR+D8awo4htUgRP22etx4rL7U5D4Od1h30cPnxU1hzHS6?=
 =?us-ascii?Q?NqO4aRxHRed0RTBWq9MokcGvGTDgxlU2t9eh4nvtgsKtqReT2AWPT6B+y+ek?=
 =?us-ascii?Q?con9VSy+rNYuYotaZWx289UBCP/dneK+dCTqrZ6N3zL4FOrd/kQr64tDcpTd?=
 =?us-ascii?Q?iEKlwUKNL6oSXaw1ANPAx7Q4xu7rnn5f9SzzUCN6GcxG/CVDlA2i0MXuvz3T?=
 =?us-ascii?Q?gryvaOUExmQEXN86uWu7U/aFIX2aBFd5B4kmp1Fjbyubuy1m3zA0myDiNUwd?=
 =?us-ascii?Q?xxGvxNorQFFa4jwJrpVuhkpU1qex0M6V5qFebVoEEHORSGKdKckGiFoDYweM?=
 =?us-ascii?Q?IoSuKecNDZF2qdq/VfhA4zdCzOjvBHW0dF/W9jdRf83tTXhcJuWO9gaezsyg?=
 =?us-ascii?Q?cybCxItGQsw4ChEYYxYw78sY2iP3mPzhgwRYAnSfcKT1PLLdYuMqdJODV4cW?=
 =?us-ascii?Q?clzvhlLWp/ckoHe8BTzMam04FCyxDKDGK+F7WCSWGxZkWjI/KgRpLTxd2joY?=
 =?us-ascii?Q?6qZIxZ3tKs03LVFWIPNXfpaN443oG7N5ppsNFC+WcfIYcAWrcyixknMr45+c?=
 =?us-ascii?Q?hZldR4PIyDVN4es3qu0VjKQ0mtevhqVmUoeQP5hpF9lnzojjT7dYB2Rdlw2Z?=
 =?us-ascii?Q?LZZNSgMY7YXC7h0ZoIiNHwbwp0+xkeFgom+dvdjLPSwBrQIdyIWYZnnXCym/?=
 =?us-ascii?Q?FyVlAcFe0ndW3eUBS25HM2Zw6gc6qsq8AnX4j1MzMvj6uMSc1+71fXyB56kj?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5656a92d-c8ad-472f-b075-08da820fc578
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 18:22:27.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFYcpTqWTAXKstGFSUOOaDOltyRxJ1JLR7PEePyV3ptzOJ9RmXzjNWmc3bdfTE93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2979
X-Proofpoint-GUID: RioT6ptQtM2wADyAHbUXvAhofKfmmKqW
X-Proofpoint-ORIG-GUID: RioT6ptQtM2wADyAHbUXvAhofKfmmKqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 04:27:27PM -0700, Stanislav Fomichev wrote:
> bpf_strncmp is already exposed everywhere. The motivation is to keep
> those helpers in kernel/bpf/helpers.c. Otherwise it's tempting to move
> them under kernel/bpf/cgroup.c because they are currently only used
> by sysctl prog types.
Acked-by: Martin KaFai Lau <kafai@fb.com>
