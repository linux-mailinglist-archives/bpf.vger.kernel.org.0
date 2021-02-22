Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5D3322034
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 20:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhBVTdf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 14:33:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13430 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233305AbhBVTcN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Feb 2021 14:32:13 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11MJJ2QR015937;
        Mon, 22 Feb 2021 11:31:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=XxCuT3rbeIf7iCy9zs66Q2K8itTgXbtShXjaeAG+huc=;
 b=IU5Qxo9Q2zt9l1W6X/s8KwlzxfTXC9oyXSzzDUcUAycJ8YU2Fme1v/zYJxG7Wl+/3PgP
 qdqEMAV+XH7BEDtUFivdlBojpQ4f9HNr1qS68jPRa5A0uPs5BeKAU4btv1dG4fKbVrCD
 EXn9wq/SWisjzhIOb7s7XvBirwg1dL2fBjc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 36ukhy6rpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Feb 2021 11:31:16 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Feb 2021 11:31:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCpPaOOOyUTK75Jj8Xrg6IqK8ZEGpbRVqLjJqf7vcZnpR5wsIGzNwEJCvPgvwTqlJ+VkIp+iqed0wWKZTpVbOVDHJChXTjWKunCLhuYw+L6bIIPAXbxvCIKwKjXyBmb7VotMY9mVXg0HGguR0CNtC0ZLc3bBpEzauh/UDtaV3zn7hG1SNe9cG1mqr8Pro7TpvibqFFPQd3ihJvOxnTKmUGjrGNU4nArnNoKP6SlWxfByN5kOZDBawSIWDjQN1TyxoT/eJ64pXmxO+46qw7Qb02gYjTjNfP/3kt4mduc4viaGVv4xeceb73Y0/S9ONgZ3n1QLDjjBlvBwug5vf0/qdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxCuT3rbeIf7iCy9zs66Q2K8itTgXbtShXjaeAG+huc=;
 b=meK8MjKmgpnbSytmRz4zINQuvX8QLcV1hxVjBpyLhtM9odAof5x7mr8D4hWX6qs//U3NE5agZKvYmUd7FeYSs4oiYJv+uW+7yI1KOoO5FGKOaoRNcH+SN1wJBxDv/PtH+xIzFO9MMmKXT9nkktk1oEzq88YoANya5+nh8RvcC+PvVanos+17Z70Vz+UYZWIuehljeTle3C7WXAzFZmodshgDR66vUFx+6ZfOothmm1z05tesM648BwZnBfi+WuOX8dUpEGhgjdGf6WNvvOmHlJC1mGprKHLFDIY9PWtjYdubw9rTzOIYO+ZzdairHQSx8nyDdnXFFFd5GomXFUvJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: ubique.spb.ru; dkim=none (message not signed)
 header.d=none;ubique.spb.ru; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3464.namprd15.prod.outlook.com (2603:10b6:a03:10a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Mon, 22 Feb
 2021 19:31:14 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0%5]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 19:31:14 +0000
Date:   Mon, 22 Feb 2021 11:31:11 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <songliubraving@fb.com>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>, <rdna@fb.com>
Subject: Re: [PATCH v1 bpf-next] bpf: Drop imprecise log message
Message-ID: <20210222193111.3koc5bo3czetwltx@kafai-mbp.dhcp.thefacebook.com>
References: <20210221195729.92278-1-me@ubique.spb.ru>
 <20210222091050.160161-1-me@ubique.spb.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210222091050.160161-1-me@ubique.spb.ru>
X-Originating-IP: [2620:10d:c090:400::5:daf9]
X-ClientProxiedBy: MWHPR10CA0024.namprd10.prod.outlook.com (2603:10b6:301::34)
 To BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:daf9) by MWHPR10CA0024.namprd10.prod.outlook.com (2603:10b6:301::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 19:31:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cea4cb2f-7ba2-4a6b-26e6-08d8d7686ace
X-MS-TrafficTypeDiagnostic: BYAPR15MB3464:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB34641E8EB19A628ED9BAF555D5819@BYAPR15MB3464.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zo1SQzGShdtqFVk07513KX5SMrPxeCifH8tZn8WY+TAkTREbbOLnmudZqTu5KpabpfhB/TmoaT9Ll0jzA/6ZfOVTQIRNMkfYV1e8zzv8czqWmw+wNChVq+d289T+hjaWpe0q5urhG1/1LrDoFPkvRypPhswfuof1/TprsV5Rt4Zkt+2gWO5WM6dnOuvwfuj7+6sWgYTFjd3Qa1VQlUo3biIE9eGL/FsB/kvyiC2M6AF6VFwpe37ypJC4vOF4rIDv5vejB8vg0zdWm0hitLfKkrnMnrh1VMInq92EWIWtZl0dZ3w1GGwhfeFvjEZKjf7Dv8/2Sj+zJyHEgkeD1cmdApCGjRLylhokN3TSjysommVsQ0yFQcXeBDF64Z/NbH9/rqduqFwmjoBYPl5CtIInvqd0R15IHHXOYtG7uVFkyr9Cgvoc3EP2yiNdWrjTUqD1SHamkLa0G4CAA9HeAdKETeDLWdHnFaSFwnav39BAyzJ1rVnRFgHNJR1CQ3HprKVka6Q+GqGMpIMsLpd3cFb0Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(396003)(39860400002)(4326008)(8936002)(316002)(6916009)(8676002)(2906002)(478600001)(86362001)(9686003)(55016002)(15650500001)(186003)(4744005)(16526019)(66556008)(66476007)(7696005)(6506007)(52116002)(1076003)(83380400001)(66946007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fw0EKxGpzCUO4znYfmOz8rrdo8YQL73mJrzu8HA4foeagbTmp02qPbR408gn?=
 =?us-ascii?Q?+YfL7rQlb1HYJmvSG5S1dn1c7B280TSTlMA7X/5v/fTp31zTy+7lrWdvzFpU?=
 =?us-ascii?Q?Lf9qyMdAF/6nQcTbi4WaEG6QyX/fJ8i6V0lyIa7Oyd3W6xuhsId+G8fUpOCs?=
 =?us-ascii?Q?V8H6Xua3+p/34tmS/V96MMeLYCvuy8yHA5KB4BDZds+IoSimgyri6acRJQBD?=
 =?us-ascii?Q?PW3RwEcLQNfXVnptpV3BzTTAseEFzBQvXgShJ5xOFFvwK2PJM86wbsPhwWgH?=
 =?us-ascii?Q?KuusiiU7c+tAYl3Z3EFby346MbNcyWFNmcmKVBoObqg7ynJC+VSX9mFMNtCY?=
 =?us-ascii?Q?t4OK3rDG4qzUxjcZIo8pq4yglkIFHT03Q6B+4bzENG0wGBYs5op3ba8oEkzL?=
 =?us-ascii?Q?3Ikre0/Q2wpnqp6ruDcWHliCC6klVB0/S6Tryej/BVHx9fBviuPeu7qXGp1g?=
 =?us-ascii?Q?VP4E8mFrrssft0XeUpPB8AnF+nXHg+yJ/BU7n9MAC+Ltxn2COUa7ww167EoC?=
 =?us-ascii?Q?9KQ08ncInGNzZL3cu2AMnbNpE4nMpwGm3xmZ9t3YzmQ68xZ9066fF5rhJZK/?=
 =?us-ascii?Q?me6t05u5JmQTxcoD5pMtRZFGHhiCGe4B6L7n92gTtPOe7KEV3pt8HjFSxRkq?=
 =?us-ascii?Q?ou/YmgPFF+MdJYZsxJMlVXDLVXQKqZrzN4D8dMFnIc+iwti0s6+sMtDZCkZz?=
 =?us-ascii?Q?on+oHdkszhHugZnALWd0XnEp9Xz9ejO2IdlgYHOXv1QyfpMfgl3iiNQpNuZC?=
 =?us-ascii?Q?iT7nV/7cOct74165+Oz+Tji8CkzK2Gw1KIjqte0tfi2RhXZPfnHgzatPwcdf?=
 =?us-ascii?Q?IpTDdNtdcqCFjZg+kXOBV0DxuumR0+5LTw4KCnGYs8LBHN4dk4TtRHeJYw/y?=
 =?us-ascii?Q?8YaIcZXMSfal7AnL63j/JNQ15ue6LBfddd1hH2XdYIo0qppMfxri6lxGqLpA?=
 =?us-ascii?Q?kyZPexLs6j5y4Eii47V5bPhAbLQuFt7sFvu4XzEkhbG0ldBsR/XoTD7bX5LH?=
 =?us-ascii?Q?pF4cH9HL+MFvZT5vfSUfq74ldN9O1M+Ctt3oJTfQlExq1xVQuMHB+FJBHcUE?=
 =?us-ascii?Q?r9BlGRHD9XK0QvZBDrdag8w9WfMwapde25dDX/Mzu0N0ktgt5CYZv1NGBSs+?=
 =?us-ascii?Q?bervJw81h0XIu1rncpJCsB3HonqwzO1kRX+5kCc7jrscRnRmFKPZ3qFJnMbc?=
 =?us-ascii?Q?cnl/AuabwKtiU9zxZETWjfSit5WWN4WyogtvqEZfjg3ZhmeVoCCiysH2tZ8i?=
 =?us-ascii?Q?d3X57kIaM0ejZVX9dkTBR8Hhx30Gv6s3hECt1g3N36dMh0qAfZTdfwA0/M6G?=
 =?us-ascii?Q?2XGhVEQ7nBhWegjEWLPip0iDkfD93JWm+FRKOZpmdHDWwUVm9S0yolyynKL1?=
 =?us-ascii?Q?Xyvp0/Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cea4cb2f-7ba2-4a6b-26e6-08d8d7686ace
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 19:31:14.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uSr8rE/UNL8POl0cmKGPlVZG3DsfwldT1VsqlIRnmIrUHbADYp1i7tUgIAQaPTv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3464
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_06:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 mlxlogscore=737 impostorscore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220171
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 22, 2021 at 01:10:50PM +0400, Dmitrii Banshchikov wrote:
> Now it is possible for global function to have a pointer argument that
> points to something different than struct. Drop the irrelevant log
> message and keep the logic same.
Acked-by: Martin KaFai Lau <kafai@fb.com>

> Fixes: 4ddb74165ae5 ("bpf: Extract nullable reg type conversion into a helper function")
Should be this: e5069b9c23b3 ("bpf: Support pointers in global func args")?
