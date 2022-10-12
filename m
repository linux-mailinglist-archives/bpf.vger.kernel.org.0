Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968465FBF23
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 04:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJLCYX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 22:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJLCYW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 22:24:22 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00048.outbound.protection.outlook.com [40.107.0.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DD2A487F
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 19:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5Djy8C4mJWM2If7q9HZaYtsB7oKvp96xTvZktnWBIrRVXBHyCY9GWXacNedybYw6GBlFxTEZptivQs5py3B6g+jSa1qWakmlp/vH4ozSKBJgL0BHEH+Qz3+8OE6PerYwxIwf+4LVxBCcufr7PzZpJ9xf3k6gxJcP9dTqMHdrEjxk7NSMCaZp98Wm8eQ5h4Iuw50tsyQdelW51zjZTIF3S3WgVxoKFJGBgdHuVXBDxhVIah3kBDJKVzb2BR8azq1GhWgbDSn1JhpHU9tzfVfknONUWVgUIqhUgCYyIexlgXD7+95T7ung+DuW7Bs5d8Vba7tGT5Dv+oMLDn659Onow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCV/P9zXYPd7c3pkHoquAC7biOmqxwyrpm+RefEc0AI=;
 b=FTxnVt16hq14e7wXjtwj0gXgCAKcpDq8ZvX93LzxCLPrhESVp03BgYOiEYGiIgv5CzgV3GLUyhFL9qbkychNCP9VCJwRjQuoXPajWcR4u9mBcSnAmPT33PpEOKszsTN+GHBWAt9tPTOJX6b/OGjfDZhF+Dth1ocnAnETSqRxt5bsObVua92fd67EKarGuYXhIHyNrUMEBEoR8aYed2dJxf066Nmu06UOJ9h0ydganDWW4ToyodhLXL6ROTa/RvHL1H0c8AxnKeSmDzandSKwG6v0pcVO/YCmG2BwQTieb+LUTamAKFKsmDa62vL2Ejmn1tPU7++DIKkweyX5Oe5LWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCV/P9zXYPd7c3pkHoquAC7biOmqxwyrpm+RefEc0AI=;
 b=oSIDkU3XMdHvMtx2AmnCLbLn7BCI11nqQcjnwuChTfbMwpTGkLiBQOX1pWXpYPWIPfFeLFXtumqRC/nzD/AK7ivF/qleTxWaQ9tH3ZPeBd7NE5usYZOawoRj06YqF/jjuIMdvn72Gob0hidhwigZk2kkv0Ele8tOU4ca3o4o+ZAm9sMmvG7dSkh7oz3AqyQAmxi9sWsZ6ke+k4rCJ2VT69p4c6H70gF5+b3Wo/IN7lzUTq+grjNcj+zV08W7RUuimgxAtu7fWCEX7gcNvqcBbs0Wz3gQSS8mw6LmAc0r3dT08qlO8n75h3QabzOZGyYgED9Uhtn7inm+QSX/qXkAcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by PAXPR04MB9204.eurprd04.prod.outlook.com (2603:10a6:102:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 02:24:18 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2%5]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 02:24:18 +0000
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v2 2/3] libbpf: deal with section with no data gracefully
Date:   Wed, 12 Oct 2022 10:23:52 +0800
Message-Id: <20221012022353.7350-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012022353.7350-1-shung-hsi.yu@suse.com>
References: <20221012022353.7350-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|PAXPR04MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: b030cadd-8267-46df-0bdb-08daabf8dd66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jKcOhEXUqOzWCMN5i2QROh42pazkAR4zJoeJgvMS/b5ibBGX/b47UsFctduuF+VZ7oMxYy7Mi5o/UYmFkBbF/yo3EJnjgeq0qUTXLB2DfDC2pDpejEX7W3s8gZ1W5advvKJmc5jsP42N/VCppD8zEC2/+Yl5lrl+7H8cKBFHpwVxME7bnrgbWsDx4ceqtK1LSqYEBpub498aGszJQzj0X6kCSvn18c3SXNdz4sxlfxWfwXv29tx0YeJRm0cvdZZgGfAVfRieM2DBqwWQsE1LlmR603oY73LeCQmVRkG6F9vL4zdjuPp/GPWTF+GW/AwPdX9fZQtpT4hxZhPM2HpocjQ5jPGR2QrtJPHkdfSEC+K4O7Pblf0+7AZdVIkSw1+Tf4ah8WBmhPjYfZSNsdzL7PzLiYYlXVS8Ct4Y79yax/iS/JRENEwHu5Tvh30FoNYhbdyGU873a5vqLCKR7QDIMNjNsoBQwsUFl9iOsJmxxchg10/1o4RvifFrd0D8BCcG+7uPStnABi2pydRp63azC6hXgknNBTSPmU94DNczaZj4OaI2WE1h004kpq0c4H/BjkIDX5uaFjbElJ83+WSyll9VlCjMNxwF/p/wQCoVRFzQS8AhK62CbDFT86ROrx/7pSnoqqUo/sZu3OroCQ9ogfF1mNeVkDSvgUh1hS770AO5kmU63mZyjrQ4Dakjdf5VuRBCWkPq9SIcC7Mnt+pmLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(1076003)(6512007)(26005)(186003)(316002)(38100700002)(6486002)(54906003)(36756003)(478600001)(6916009)(86362001)(8676002)(6666004)(2616005)(6506007)(83380400001)(5660300002)(7416002)(4326008)(8936002)(66556008)(66946007)(66476007)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CuKF5B5f3PGj7VuO6fehc/kR6Kd73b/oGm8pbVB2bQfTIX7QXLolt+z24YY4?=
 =?us-ascii?Q?8j2FKduhNvrTzYdjymAf1JzGxw66Yr0XVFQCB3GE9K11K2dbdk7B4pDxO9PF?=
 =?us-ascii?Q?rYZb8pTJb3oQkCxsno6X+/+f8hIrGqB4E5tVbS81TcwWeqdcNOz+cKBBJaXn?=
 =?us-ascii?Q?BguwysKa8gXh744zYY0OWlWiaoVKQnd8stpCRYLvMleEF+1OTbTzDDxjSJWy?=
 =?us-ascii?Q?u7CE4AjnUd7LPpiv5NuuiX1yHEf6BLf6rPosu8mAVZtMrSuiTuP/deKn2oAb?=
 =?us-ascii?Q?gcI65zUL7QAadabylz2izBcpsaLOEMo8N8nZVH/Vepn4Oy+Oh1FVjMXeo/G3?=
 =?us-ascii?Q?r8xPj8zbuyQWmjiRQR0ga91jjvCLq3tFfFZwzefJ9kvwtXODKdez3xbY4KrA?=
 =?us-ascii?Q?4IxbyKJ5hDuzcCzlr3gToGg2Bb5hQG8fSJbfFHQBqcpWBd25HCK+Px4dh4lS?=
 =?us-ascii?Q?vvBlAgbAMwxdChH/kezSe6uMvydRE6djb5WwHyuYTKl7Tw5Mh1yqCrWiDqVz?=
 =?us-ascii?Q?AuETIfUH3KM3tslvmnzgfqbGYg2PixQENIqfCl2pqZOp/yAzTbRA0yhPDibS?=
 =?us-ascii?Q?xI6/61UvnfgBB1Ye9MgHzDq2h7W7PuaT+b4c4D6AhQQpLq1nmAei4mo9FncO?=
 =?us-ascii?Q?st1gnedA5vXmJ7XPYH9UWsk9bw3sIIV0UMxRU6vFNUYTIE7yj939hHmKkh9I?=
 =?us-ascii?Q?eUIwi5K13hqrfeUTV4vkf+hyRL0HOLOAh206/FR/xP4IvGxENTgjGc7oo4LI?=
 =?us-ascii?Q?NWJHznXE5OJnrijb5U61Njpz2CkHYVa5T/n9xnCrNHH/W1QOlom7PnMwbNMd?=
 =?us-ascii?Q?CHACK6y6LbMFu4oUunldnyMtkQ/Zor0QdEe7Uq+VgUehLrqHO8KHlvXcJM2h?=
 =?us-ascii?Q?0JO9JZmb24sphseowuh+Kve4SIUht+8/lyzPk/E6xJkjlKbYauI0KOGdthwI?=
 =?us-ascii?Q?gDC9sVemEMI82gYmFjDcRra17cIxd0k7i4FPPsiuodrAQhm44JygZyLn6Azr?=
 =?us-ascii?Q?KsWArEAp99lqgOxaF19Uhj/ajHVEDE78t7/ZKzusdBCkl2uZrCua0SA64mak?=
 =?us-ascii?Q?j/8AsR5fVCdrdPU+yRnpbMIMibGtJN/KPNZsdyPmZ+3LxCKplNS6N9Xq6/MB?=
 =?us-ascii?Q?uxhUGNvd2ZvdcgX6TTQAunTSUJDzeg4AStafKeTu26rEcBpMcR7a6yzoE3nx?=
 =?us-ascii?Q?nEihCtHjvpSfwpBeAIK4POoUnbDj1M3wtTq1HjkTqIcWrHVR5AiI78XJW3JQ?=
 =?us-ascii?Q?02VKvHzXetZrBKglRj9Re7wKAf/p2aLG1Oz7xHQLJteT3SNRyFkkaVErNArQ?=
 =?us-ascii?Q?z8t4ZtKcYvHDm5E2Zlm9bDBDV2a+WGDjCUt83xS1RAluaaewQia9rQpB6+50?=
 =?us-ascii?Q?3hkpEBQh093NNeZ4YvvxNCOHHsMovL4PTTq913vJtBaT+SY+VfwNQpjbrRwy?=
 =?us-ascii?Q?lHUH3WtSeHrOZ+WHA4QAJIM1BIvBmA17JvVZetofsplI4VcKz4gPO2pi/Ym+?=
 =?us-ascii?Q?aWupoWXNqfe6UFDALrz0W8gvZ0J/xOo/qvV8BxJY8UvgmP3KmVKZ4Pedk00D?=
 =?us-ascii?Q?nTWhXkbFoPtEw/TUN6ilSyQGAoEO/oD0XbL8vQx8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b030cadd-8267-46df-0bdb-08daabf8dd66
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 02:24:18.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PdELYDYHEcgE5YKs0wl/IuxRqQgl5LidWQwv1IDz8rnNTNWZfl0alm6uZFkH4ICH7rnl5aiwSBWyx4umOmvRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ELF section data pointer returned by libelf may be NULL (if section has
SHT_NOBITS), so null check section data pointer before attempting to
copy license and kversion section.

Fixes: cb1e5e961991 ("bpf tools: Collect version and license from ELF sections")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/lib/bpf/libbpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2e8ac13de6a0..29e9df0c232b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1408,6 +1408,10 @@ static int bpf_object__check_endianness(struct bpf_object *obj)
 static int
 bpf_object__init_license(struct bpf_object *obj, void *data, size_t size)
 {
+	if (!data) {
+		pr_warn("invalid license section in %s\n", obj->path);
+		return -LIBBPF_ERRNO__FORMAT;
+	}
 	/* libbpf_strlcpy() only copies first N - 1 bytes, so size + 1 won't
 	 * go over allowed ELF data section buffer
 	 */
@@ -1421,7 +1425,7 @@ bpf_object__init_kversion(struct bpf_object *obj, void *data, size_t size)
 {
 	__u32 kver;

-	if (size != sizeof(kver)) {
+	if (!data || size != sizeof(kver)) {
 		pr_warn("invalid kver section in %s\n", obj->path);
 		return -LIBBPF_ERRNO__FORMAT;
 	}
--
2.37.3

