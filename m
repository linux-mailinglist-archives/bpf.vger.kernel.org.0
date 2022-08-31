Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D955A7490
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 05:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiHaDlB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 23:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiHaDk6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 23:40:58 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204649082D;
        Tue, 30 Aug 2022 20:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtZGfHeGB8Sba48FX+dVSncJY8lg8ddzUXWGXGgyXGlqJOMYU4+PMFMOt9Q6hK3PG3R0n+KD7NiHx9fVPxdf++BZmibuxF5f9QPssDEZhzgzY8DoqT5IH77aAoS/3KwvyEA/I5pkz3ee1MKBtrROwi4cCxyQ7LcW6Xg82bIxS/zIuSoyel45VpS8AH1cVp9+U3OyQ20VrSkzWvErcbRNv0TaD8TXho8ztWQ3BFzA8lIK5Qg4CNtHKP33d8ZSgBxCH6BANnlruMIaX8IyOVRbfRqmXHMzzvGMRL+ZOrhIpWFXKBgpDdA8kDvvNgurd/+nZ6tKr8JqahFdNoDYevTSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=in9wjtgnajbNW4tHrYgmdU4SD/DTY62xaE2XT02Scek=;
 b=g5pF2JDM8jZo3Y/qgZNPE6jhBA7sOFzeMp5jIIPVwgGz89kR2R1ma/3bH3GO+IPIi21QVGgkKExVSSFacvHY5gME+fR5se53c2AawOtNGI/XOL+BY/zIskruLaVWwkxWD/+lMq5aFJq6tZPLA+kmdJS+ysxv32N37eb4YbyfI0Ien9WNuQ+N/UCRwcXSd9D+uQvpAXOKbgNvB69AjXyIc5r3CmnXRO00OjN9BHh7y3tX2/MYYJL71bq40MRsZdyoK0z6sbADEhK/OEnF5WRbs0TrmCiTRvelN/PNH2j8wN/8udB3Ow8ZTOwNbgNlK85nPIomYbgRa9JLAmQyCvLHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in9wjtgnajbNW4tHrYgmdU4SD/DTY62xaE2XT02Scek=;
 b=IBCFi8HHKieh+XDGKwc6Udtjahrj5DUn1iAPSFyw7xQWZcKAdUdQA7Ten2xc1tbHkuDsGQRzwl/GApK89XoxZ4GDsCrWNGHZFoF/zSDDXeBLhQbRHRY8QADGAwc8pGN/m8NkGKwj94o6CiQSmD3AD38vJZ/g2krwlo2+KGY3V7Hi745uf36DJBrRaxvHsyk5hbEgnddu3PnI6IS1s3pCrpfVlD4AzbVE74KJo4yk0ge5kvm29tivfIDgmniVzVuptMsAiBC+ZKGEHVNvLXSQhNbjj0n5yqLllkU2ApvE6uP8OWOlQti8lmzA+tgINCFd2rcsG/lGsUWpYJJzi78eyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by DBAPR04MB7365.eurprd04.prod.outlook.com (2603:10a6:10:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 03:40:53 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::f95c:9464:9bc0:f49b]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::f95c:9464:9bc0:f49b%9]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 03:40:53 +0000
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH] MAINTAINERS: Add include/linux/tnum.h to BPF CORE
Date:   Wed, 31 Aug 2022 11:40:39 +0800
Message-Id: <20220831034039.17998-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR0502CA0038.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::15) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fe32cc7-3a85-456d-629f-08da8b029ae4
X-MS-TrafficTypeDiagnostic: DBAPR04MB7365:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbGzqiLIiAfXhzCzqWw9f+eNltXjmh2QeO4Fq4br6Ps2KEZJW+ZiRmEGwWBHtF6rUL4Dtl5CWMJkSVYVVFqQ4A1JnK/WFnDA8zWhj1JEMssIzGF5snjNHpx9eXCn5eTb1XtHEIjjxpxfBudmUN97BLXxWdXNbUtrU8UOapNcRYi0cmGqgpxbpSg+oPiT74AC1ryaSvne5OGv64/P0oCWOmMG4CCyuQdo3z1tFxl90E4Lbi20SyZOX/+UwHdyvsgMyn+wH4nnppa3aRNYrVsdaZIu3N14v8yB/5M13rsjSpcLRM4+IAtI8Z8rgQifMzwdlwYEQgw4ae/T4G0CZ3Q5No21OQ3MIOKfFv9r0tkkt1fGJ3HKswW6JN6Zv5SkwXRJli8H3HoWE+FHi1AZnx0yUH3pWl6s4piFwDDDoxEOVOylSxcTHAF2D/ZzSqsBAiKps6RuxM3wfrxXReHNX5i4JKdelvbWAatLSHXtJN7NNhlSM+0HfXYc5Ok/6Q6UJcFuVsioDWyKF1vbj/poxh0xW5+8WpkKseoJZXyo0uvkKmFDQMj4IHEZe5yfCseVhKt8j7+7s+BNFLbYHV1tBZVSkxDOeR1ZdFtRUsIy001CUnXCwWxll3O0/fyXz6UD8JqK3FRdEEynH5au0bTfF4RPyD5tliVsh9a6JS6IOXu/lLUszmsfRk2LMEdvTG8GQX6tjQFDQOMI0k3U8ubSsWR7vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(346002)(396003)(66946007)(66556008)(4744005)(2616005)(450100002)(6506007)(316002)(6486002)(26005)(6512007)(66476007)(86362001)(41300700001)(2906002)(38100700002)(8676002)(4326008)(1076003)(107886003)(186003)(6666004)(478600001)(5660300002)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iW38XZOnIgBTLVQm88kgL4tOG0bKnTfGGEl0lVs3JP1BivWduE3x2CIITjuo?=
 =?us-ascii?Q?/cUqo9mMpkqnThtsLBPCqDedVe4t+MHdk56KVJ2rwzNuoITsXegP9rQ4P8gJ?=
 =?us-ascii?Q?Ez8htVHiYhcnuGTfKz0RXAMXB3+vTZi3eZ9k0opf84QubNT0bwTd2xOYa9r+?=
 =?us-ascii?Q?gvcv5Od8qd5YuyLCN41xP9aKUppyUsnstSlGEm4ZrJ1xvnQGCq6aOrQtE8Zk?=
 =?us-ascii?Q?xvEfWgrzqXXsSjRuM7ZKH0fkLL2NYrIKd+fgAcYRyftlsZwC4NXN9K0wsRMU?=
 =?us-ascii?Q?ozTCOba28rijOyPedQytYEyEqc+xcmyGaw7STd+Z0ocPFMN2rdiMI8uyAXB9?=
 =?us-ascii?Q?5+dd+KbhmLvNbkdX0c8AJCrYnXWG+O62FHWiYhDK1stfUj/eETHKL7N5ti3E?=
 =?us-ascii?Q?kqqHiKLRS+z4Otwjdqz7swu6BO8mJZa0FIgrtJfrvEODOOxcvTpaayo7N1ZN?=
 =?us-ascii?Q?aK0RWPrIOVSFFP3hbPwO2CVbkMDVxamO/T6XPN8RXxvTzVSVtEnXgAdBLwcc?=
 =?us-ascii?Q?PZa2q5jI9JU+h5IjJ+Lk7KHUWHqdx9uRmSPXIeCAG3Hi00y9cZGwrF3/6AH7?=
 =?us-ascii?Q?6+6g0sfVajaqojdCOQ/yFwbJL45vCDEXRXHROQ4/ygKlyydTfuIEQl4H4fPh?=
 =?us-ascii?Q?4zev375l5KRj4wMxi0nYHKXgLqwa2pSPsz2UWYKIy9VRRKz36E4T5NBxcl3s?=
 =?us-ascii?Q?DyjMOYbhA4B0TJwm8VrAqESZRXOskGkd41wnJ6VeoxcaGFTHAZ3ppathlNA6?=
 =?us-ascii?Q?OGMT6sXGDrKyh0Y6pFxwNHUMbvlJMN+DaPvS8dpXQ7H7oZXuZvBX2yWRoGOH?=
 =?us-ascii?Q?tJkrdsHRwR+yOEiORZWq8EoT3vZ8N5ej59s6lBJ8YjGIWDDGsg+qqJSHlniy?=
 =?us-ascii?Q?q+C+f9svosZMk0ezzORjYbI8WMAH3Io6PBGnDeD0b4pwt0brqIOgtshkHmGS?=
 =?us-ascii?Q?H/SWVvfcXO1Fm42FMesl3nh2LJW3Xj+Sn6jHngRZ0p+0aq/T3smzB5UQboKC?=
 =?us-ascii?Q?Ab9vNViN8p7ECYQCkIcwqWXbZM/C+caDginBbU9ytT4KR3J0qyyaR+tx/2jN?=
 =?us-ascii?Q?Wxs/9F6tnCeS9/O9s4DVGa2lT75bl2KBewV1HobhbMKLPExcwwNmVWCtd9hp?=
 =?us-ascii?Q?7p9hy4UsfUPqwCOytV7jL/J+v8+MFvt8bivaqWxwLR0rx/olQO2gOL2vKgqB?=
 =?us-ascii?Q?A1IFE1K1iXstA+PUACrK7/kXDvVK0U39thYg5Mtj2O7TM7riyYxtSia9F5uf?=
 =?us-ascii?Q?DRtBGyjBjMNCer58/WiJzTtS1+pQJXMZOs33f1QhuwJ209NbZ1A4A3n60K+z?=
 =?us-ascii?Q?neZbCTBsqPx2GMGubr8XojkuK53F6i4lFtnwcSUJyo/bTl8X6GHLMw99bpwB?=
 =?us-ascii?Q?+1hguhmr230ccf0K2GinNP3Km5whVnDuB36mvn5QzzgpiaFSVRNH3rJOxsOA?=
 =?us-ascii?Q?zPcHdUl1RwQspGCR9T9Td6x+fviO9PYFCTJ4vMkLxD6EeB8+zaSTUk6Hbj+C?=
 =?us-ascii?Q?eLy9cU0SoUt3ujsFxyhSm0WEXEaAmcTKlXcIQ5P7g5B3iFeC7HwmznM+vYH4?=
 =?us-ascii?Q?Fk56EKE3Rf0dw5Zma2vZcfrMMGroSIZ6flPl27p2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe32cc7-3a85-456d-629f-08da8b029ae4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 03:40:53.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAAFfV3mEDJgmxKIqa6z8YtPA/PncmzLq7Em2t+XK4cFfhEjI9oPIdHXC8KKSSfkfOqsAkysT8USuGblGEw+Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7365
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Maintainers of the kerne/bpf/tnum.c are also the maintainers of the
corresponding header file include/linux/tnum.h.

Add the file entry for include/linux/tnum.h to the appropriate section
in MAINTAINERS.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2d64020399b..4639c458f678 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3816,6 +3816,7 @@ F:	kernel/bpf/dispatcher.c
 F:	kernel/bpf/trampoline.c
 F:	include/linux/bpf*
 F:	include/linux/filter.h
+F:	include/linux/tnum.h
 
 BPF [BTF]
 M:	Martin KaFai Lau <martin.lau@linux.dev>
-- 
2.37.2

