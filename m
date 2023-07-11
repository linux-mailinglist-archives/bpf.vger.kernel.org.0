Return-Path: <bpf+bounces-4777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3568974F5B4
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC45928189C
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414401DDC5;
	Tue, 11 Jul 2023 16:39:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7318C31;
	Tue, 11 Jul 2023 16:39:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2123.outbound.protection.outlook.com [40.107.243.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05B4E54;
	Tue, 11 Jul 2023 09:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkVbkrvZXL5NVp2Mp1ZP4WmeMlM8Y4uvuvAqopdzNCWSR1rhEq3cc2k2Vt7TDJuZCUEv9/xQmvIwkY8Yu8ZMw2qKNWXWtkk63+Rd62HNQbY/zhCtJNcg3MFnRNb7ZpmNw6EFsAIB6YA3CJLLHQf4fXhcxb40FG71+BVBrzuoo15jLnqwIHLahRfqeixKO57wsVjfVFSHe84SWl5LQLgi2Qvy9sMTHVtGPNIcZigORgkjACYw/jKdEgy5S32QrgYyxXVgOTg39PjMcEV2X6zBiKwsqJSorMgo1rXiaJTY0VeJqApB1j7tBCLlvuyYG6/S8T+14RG6IV20C0jxqCiDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx6A1fuYcAtC9ylVbt7r/PrRgyDq68Z4655vQJaqb1o=;
 b=YPYrm1IMZjto01ZgXHwKXuhTB5XX61rgjc/HmQbPqMzkvDubekLbWYM4sA7dddUDraeCfRwBEt/wGuXSXjblo5Co4CuMZX49/WUDXOIJ2FLs8BXBZ4f0+Fo1eglhN51X6dJlfDdQqX4SLPZvHZaNrZbtg5us17L+1AdIONj0hTJQAqXJogl1P/jJwhhFt8v9aSGDuB3UjTjyVC7QPhb3mEVJXiz/eor+erN2LeRb51slxDnKX0KYBGJfGnuz7WkOQrI2ZA+btckKSmjjPktQdhLpfsIqEyLWn+APwaMHa/HJ4qPiFTyq65wkYV4Tgxpp6cjccL+ZUe1uLQL8lY9ibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx6A1fuYcAtC9ylVbt7r/PrRgyDq68Z4655vQJaqb1o=;
 b=tUvnHhLjl5v3DmAcFgqJMwpVuFiACQpSfaIAGW1N5ZnqRbyEp3oKY88coYZkYUwgzm0J8FngsAolNnQS6H4zdjXparD3Ioahp4kFQ6Io3v2e2o64Z0IgYIgmlz6dR34RhKHQBLOYmiB19WjlAg8AveLnVBqbavzLPUQ8pXesTSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BL0PR13MB4481.namprd13.prod.outlook.com (2603:10b6:208:1c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 16:39:36 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 16:39:36 +0000
Date: Tue, 11 Jul 2023 17:39:27 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Xin Liu <liuxin350@huawei.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	hsinweih@uci.edu, jakub@cloudflare.com, john.fastabend@gmail.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzbot+49f6cef45247ff249498@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, yanan@huawei.com,
	wuchangye@huawei.com, xiesongyang@huawei.com,
	kongweibin2@huawei.com, zhangmingyi5@huawei.com
Subject: Re: [PATCH bpf-next] bpf, sockops: Enhance the return capability of
 sockops
Message-ID: <ZK2Fvzl8yygg4/sT@corigine.com>
References: <20230706100243.318109-1-liuxin350@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706100243.318109-1-liuxin350@huawei.com>
X-ClientProxiedBy: LO4P123CA0650.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BL0PR13MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a5d501-0a82-4e50-9065-08db822d6984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0LNmtYZUdKqa8rQyaTPnYF+CszC0UotT0ZhE3ikb0bzObipBrBgKwJCWrZoHbkTIGejwGZiXJ7yE4Absnr/UVeng3yP8NVJYnQtVRvU+4JpubUZ+QFOm47+Th1ujycZSJUmhzRyoSqe8SNltbUh475w/PaadlIdc+hMUSAwS1QG9T/x1+6asGhrBXQfThhxvb+B24DPnSzvfUGVMOJAF+5fCqxiGrPQHK33VK8EUua+rkIMmyJ5vN/zxhirFGkBTkCX2juqGw87xIM0MSx4uzQJ6PHR2FT0WWLmtpNYpTOhAuHO7tIJdYCLbO0Qd3Ap+XA9u+CdFVF+W7kpMAjtlsZwirOtDCiALXoFVlts24ijzzDDOr8pwTe8JarU2h7gQicIXv1PhychAq87Z5cl2SdJyv20OQQ7PaOtBraMsv7YFHbOGohufKoFR1ND3cucnJ03wONOnp0r7DWC861GENcLVSXf3/30E/QIwSFK9tuvPFQcKNoHfvu0TJjiD2OnsqJ0F/zp2XklPXXjxq5L+TAEXuMfeAARXzV6ldaO4dSQS90xneeAip4xZvLkxWfdu6tFJ0stmg5Td0AXQ9pmydp+l4dNDspu6vXhTe+nXQUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39830400003)(376002)(136003)(366004)(346002)(451199021)(6486002)(186003)(6666004)(86362001)(2616005)(478600001)(6506007)(26005)(44832011)(7416002)(316002)(36756003)(8936002)(8676002)(41300700001)(5660300002)(558084003)(6512007)(66476007)(66556008)(66946007)(6916009)(2906002)(4326008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ld8NzC1Ygcu42fPM/2Kn7l+wCwVXS4dPUmM0GmxeOXiVzE4OQGhxAWtRybvi?=
 =?us-ascii?Q?9Oi6EhtJNcSqiKkAXZ4r03f+tdRVHvE/Qc+TdP8T9VVHrctizQCjOUO5hEMX?=
 =?us-ascii?Q?T32POJa8FZSbYSiGlOb2dUknNogLWyTr6tATM9cKgKREQmHqrNGWe9W2AN6Q?=
 =?us-ascii?Q?uSRZ0x1HsLf+RrcLvnTH3ry9gj/N8qS5N22vo9ipx7mLOwQLTToUtkTQUU3y?=
 =?us-ascii?Q?/HS/s510gaP6wSEpGsWqJgtFiOCHamdraJYOteP6F47TDUuLwN2Y/3olG0ef?=
 =?us-ascii?Q?e/BYcbyu65HPKr4VTD7GhVGD7bSH2YqZ7WAMpCBSk3QK3f7tRoORzp7VgWPb?=
 =?us-ascii?Q?+Rsq1rC0xJ5hMjlbQLwUdIxiNsV1P1VTIghg7/9ALKwqsn9h1ChGGqxp3S+C?=
 =?us-ascii?Q?oNZJRb4xih7bO1bjn+5borLzofHXWQOBwc5KfDVzKWveT2X0/5p5ijehiKd+?=
 =?us-ascii?Q?OZ0v5N+kCwz1enFM749IAvmQiz2uvw07biWZbH+M3Vy38xJCxrjB2dLllJeg?=
 =?us-ascii?Q?Ghtik05o0g5/JuOppdC/8xaV3A/IqLBPWNF08rcEzKloMMu1D3C/9DIWBlpG?=
 =?us-ascii?Q?izsSRr/WDE3jUL3uI8Nug3ita5pR3yjNdbdJk5jlIBXISbwXNVN7dhk3YT4E?=
 =?us-ascii?Q?seKfLGPId5tHeSND72qV+ClS97zhNWmoCiBJBTJAy2Bb8tggJgOnuziCkdQZ?=
 =?us-ascii?Q?pIPJUgBXELsHfKZHZDVzCDc4oYd3J8I+2uhalpySzv2HyYcW+wUD7I6xzCG4?=
 =?us-ascii?Q?gb57M7V+t6Y/2jqFIoRXFcVYuTYOOFUz9G8If8haCBdGTKbgDK7oH2iHi8/T?=
 =?us-ascii?Q?HimVE6iSG/IEdnnRf9ijxOmXbiM0YhjjY+OFDK2fzbniJ2pGu6e7OJEtGI1f?=
 =?us-ascii?Q?QU/8NhUwX12JSa6aVwjX/T0lo4GNCzfuBZ0ATbfvVaQQCSZSzIPs9Pwg7xnN?=
 =?us-ascii?Q?I+TCSE28lt6SPn1QK7+kWJUPYNeYhoiYFPv0inFlPA85h7cFgn7nEkA0HnSv?=
 =?us-ascii?Q?cOkqUaNBbdJipg3yd4SpU9VOLoB0A0q9VqYVNnNgiXOsstYYi1FzeHKxRLEH?=
 =?us-ascii?Q?4wLLsVhPhZWqbnCVCGysu0M1s6MgD0iP4n5pjU8Y167H3Ss2RCgUY1K4xx2X?=
 =?us-ascii?Q?Vksnl1fHMwtYkrh77XQ+wyzowWAw8Pb1O3B5EUdmc7fd5BaQ8D7WWBrh/y0X?=
 =?us-ascii?Q?4Xe2tFv1bRLS78xzrxII8Pvw2MPF5YeWIvqRV2BfYL1sfUpjmB9SUUhvT2Vk?=
 =?us-ascii?Q?tyKNdoMD6Bnpe6obpeXvO4ewKg/n6swkpFdL9fizbvA2ZvJTwKUgad1DVP0B?=
 =?us-ascii?Q?TFFuMW13PnxSRiF81ssRwVdxIsAOt+gEQgwrByR/+dx/HgPvglYzZgX36lhi?=
 =?us-ascii?Q?qciSMadPSlZlEMeK8QB1qW7JIXYmE8IDgTbwJl40Bba3cId/uxf0AbTq/4hy?=
 =?us-ascii?Q?aohH8JTVlNUhOlOSeLK2q9G/I4iDfRFiGaZpyQTkWEJn5IPulDWmNlV3H6nJ?=
 =?us-ascii?Q?pvl5RDcGveeqJANfEbFHkT7sOHRWLvLZq16jrCujquFyczqLLARHd++zksMc?=
 =?us-ascii?Q?/K/Sp3EGeUVZH7leAoxA1UuKLK4hsEqC3SMRzQ4NXdXbkvK8fb4MMovkFpVz?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a5d501-0a82-4e50-9065-08db822d6984
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:39:35.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnS7PdO8uFEHb2te4tFYIzdVxH6PP94pFvvaKCnH9TIMyxh90dEyj0h46aIs1R5n28Dz0iEav75dCKOo/4n35aiYSsLMz6CYwnfxGurpRBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4481
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 06:02:43PM +0800, Xin Liu wrote:
> Since commit 2585cd62f098 ("bpf: Only reply field should be writeable"),
> sockops is not allowd to modify the replylong field except replylong[0].

nit: allowd -> allowed

