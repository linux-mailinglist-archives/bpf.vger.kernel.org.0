Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608225F7C72
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 19:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiJGRsn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 13:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJGRsm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 13:48:42 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B8D258C
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 10:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXh+n5OG2TJsJEPn3GyadcPnEQKVn9IJ1dw4WaIWYPzX8N9rxIp158sQ35HP7STiAtWX6RpPV4tDeAE1eKZJNJLfeUB4yyLQpnbwC0JsfLh50sYzJ30FdPLJqOz8hYvj7TfksiptR6YmLedM3A8jVolm9woFXJVbw9CQpss7Eh4RIgnRk21V8hL85Cq91uDQGTmYRFSCa4r6IOXBxZVYloSYDSmvx2Rzsv8ukIHVP7HAFETXG6YSlAwkY87ZgqWO4E5OuD77ESWNMhXmUQ2rDDUMbxFe+f7D1ECoxSKI69kLqXofjLP4TEzGH5vCT5YiX8XHE0ytxsI6zPsyVjt2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy4ppwWJgjmoJFYL48HnyJ/TzaQFBtqbkKZSDBLhyKk=;
 b=hdazlOnA8jLb8/VoHKnj+YtTV8pxoxAQvpA0plDMqKTyy8mP2yl/CvPUMV0mFdbDLJ3Lyf/9fhJowvY3FrRnMuZUzWWwmZYMuGhL2FSXbQbOglqZ0TC1e424Ma0RHuGyiiS4kfdKqXaDbF+2ATRLsFZCzRy6axvFMFisWD62/WXRAM/djmD8Soi9pI4yN7z0fcLmoFVUMrFoUaD6qPRM1rez+aJPvsYlNtRImtAqbUs7VXJ0Pi+CX9V+pz+OrQAzZMG9KBn522Avr1OrV8utcEcj/ZHKrTcPf7Ixt0L+dzhz93NSOODtTGzfIsfbcu17LbJl/d93nJwzuPsEtj3WgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy4ppwWJgjmoJFYL48HnyJ/TzaQFBtqbkKZSDBLhyKk=;
 b=nH6mHu8AzNxdM6/Xk5f9k80+bYe6BePKsp4bNNnH8yCL06XXCkzLePH1SfOj/6lRU4Vv/QjQdX2TW8ovvhcl8HTAJzzgc/+Ys4fQEdAraJy6pzuPmPg8XyVq/IWkGl1Fcgq76xmnvKu/UszVCDK13fPgZm+N5ux3x/H6J8uX48w538cp+2JMiCWZKtTGmWIE6oKWBEiEz+LHXdcGPmVyAp8gSVHZvbDWIA7dX+fhTrcTNjh3/9c6MG/DmigMwJ4OgqfGXYL2PyXsqCnqfP5TJsMOhVoUKHvqazYGL59CcDTQv+jcyoQ5+Y4+vcx/dDMOLpOPQ+sJwQ9wubd24daQjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by PAXPR04MB9350.eurprd04.prod.outlook.com (2603:10a6:102:2b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 17:48:36 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2%5]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 17:48:35 +0000
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
Subject: [PATCH bpf 0/3] libbpf: fix fuzzer-reported issues
Date:   Sat,  8 Oct 2022 01:48:13 +0800
Message-Id: <20221007174816.17536-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:404:a::17) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|PAXPR04MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9faa40-9153-4815-3d80-08daa88c287f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+JX2as7hR/BROastMi/neLsw+tzxkh8GqeBNVM1ucTMQJ4TnHETsWorNP9k54dq5hkQpFBjPPFAMXr0gckGMYSYmjqWGYS2lLms7rc2E22Cy33ymgS7YYndWFgPwjqVW5raN3vhl05n45U+nPUVSV08pckfAZ+DavydTwhIFD8cQBuZYclGA/jPh67tsieEvlHtL4EAxoEaRQEk8mD51X1tnUsRBZ+HWX3wtBtev37YLxBn6oVl0QYBdKQudnE//l8VkL/hl5Q9bq3aGdIeK9s9onfCYMZyWRoBgqp7xgTf51XyQQHS3j1gmjI+cBMQfzBXdothr9SMqBK2eCIdaRCkKL4OadmFje6dMozYz7dnGZ8VraV3A/Wv65onPxlrC4xZnTNAZoD7IkkIx/3f/sFANmWGaDLRwnsH3D5+TbApaGhgWmxGuspB2Lpc2zYuWernBlRNsA+ddDRE0eqsc+ia3B1taMZDL5XR0YKdYGJVCO31F2VSPNdVzIqyUNqo8jhbzALLn49GK6tthMYtVq/QIdU41e/FxynE9jzGB/9LiYpEYYwt1hoIvf7aA1Uz7c6RoJg/v6YobrUd3UtaPCOCVQguGgqNUs+K7KTI1wrsR9flwUP/qAsPpp4YlbrFc2nAkUnQy5d2A6Kke4XtUA+KaG5GVHn5AKe6Fm/oDBYtTA2HzHO32gIMVCxAhrUTPdghtbT9hW2AgueGiFMdEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(1076003)(41300700001)(54906003)(186003)(66476007)(86362001)(7416002)(8936002)(6916009)(66556008)(4744005)(6486002)(66946007)(5660300002)(8676002)(2906002)(316002)(4326008)(6506007)(478600001)(6512007)(2616005)(38100700002)(83380400001)(6666004)(36756003)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jox4xziM8TsQvSh4Foa283YBWVffkXUvfgBE4tM1VU/ZFkBhReCiG3LREkxa?=
 =?us-ascii?Q?9Dj96dXV4hK2ZsSxFz2E1pWhgcL5j70R/poYU+UAIp5Zcwgw0zNC+HtI373Q?=
 =?us-ascii?Q?ppB1pfUGYn4gEMXsOG5ZwmSMWrWFqVnyR3ucYTmz52yBMs9MoJH0/h1fjLMp?=
 =?us-ascii?Q?Hr6FUeUw7DarAM0CVd7CCB+XRaFODJjurqvedkyxpJTpmH5ogImi4YIpZ/AD?=
 =?us-ascii?Q?hXyGryMEBRuvnlW9r2ptkpYK9+tHGtYPSQ3QYDPPnAeryhNlEqcFaT6JcabD?=
 =?us-ascii?Q?/3EQ5DcqBu604F3h0cxSu9O4IRj1CEmk1SsUu2zeaeddZOP5jXeDmsRGXVCI?=
 =?us-ascii?Q?5n9avkBFV83lQ1E45uiPhPGOxiHHYso6jw6PrXHZNNTuLu24/WVRdbiNO6Fx?=
 =?us-ascii?Q?YjQDydd+XAorTDyfy2BN14HsY2DdcFBCVq4oO7i2tms7cwuqWBs3mPutu2Br?=
 =?us-ascii?Q?04rXE75CFZFRgHz13bvNTXKsZKS4lrcMbFtURRNZsjgR8M27jQscmG975itA?=
 =?us-ascii?Q?KUwKrdgaYJbKM75sTJHMg44/404gycb+l4+6stg5fsr9nv45Iy011LuiIYnx?=
 =?us-ascii?Q?DmnORl254ZENFUhylg5q+E31gRFP94ShPJy/H0p1i/gUPUwRR4S51GKDstZA?=
 =?us-ascii?Q?ggnOnMrvYWXJEO1yYaKlp6NskXlcJawi3PLYZ/mcGq2UYCAebIYjpKG4QPrH?=
 =?us-ascii?Q?Q7wY0oolPrIrSWF7dIPaGLmydW/mfGib0FHf6LZAvzL6F6jzVFgfFeP+iUgB?=
 =?us-ascii?Q?QoOnkmFah/uDw59dmSfdK6iy1ihE8S9fLAVv+UzTjmE4UAdYssN54t4en8+y?=
 =?us-ascii?Q?z+OGte44uFffF1q+B6K/Odh++jMytQqzZKoeKha1VclCelAs7NUbVh6gnMgH?=
 =?us-ascii?Q?nFbf1l1x8dI7wRZlaoGy/sP2TkY/sU99JPA5Hd5HNgt5ixI+KJZ/MHfOZQV4?=
 =?us-ascii?Q?kkbl2w3XtIzsWgWi3xTJFUaq2gNTOBpVdmLRN4SynDY4QJJK+M9I1HZMy2yU?=
 =?us-ascii?Q?FUNmk1BoXW7jv5k9gwncDanX8c2L/xA0Y2TmAEjgWTt48qzHiFPTKSJGk9yo?=
 =?us-ascii?Q?LXJQX4w+Q1dHcKVcOrEOZQlfj4yAX1FbrIfr0Swf8A+LfvOZIEth692i7pU1?=
 =?us-ascii?Q?hpOpNRT/Nqir5KSKL43+rKSI1rZHceZ9JCrxGd1OjH0SMbIoqi5yyzm1xfD1?=
 =?us-ascii?Q?qMosyVZd4x+J+DYOrVxLup651kCpkvdIWaxbgRkV/5Sr9ox35QJIFr/vbVuF?=
 =?us-ascii?Q?FMaubulJFmW21ba/05VVQqhk87mb+xYoXq4aaZnGu4ohgv4TV6chbeNz5+8R?=
 =?us-ascii?Q?ObHERcFQR0a+S4x4cc7ZyncUjzvmEiJ2P9r47naf7/zmm8fLezwIphNB2uDJ?=
 =?us-ascii?Q?aFOWEo9uC0PN8LaGv0lHRG0fY4km5wLtDUURzgaMsQNBIPE5k47yjHBC3E+x?=
 =?us-ascii?Q?mGsbRXiElfPvgyYl6p1pUe0PrhK0XOrmvh7sD+dOylBGSMj8sjOBys63LKBC?=
 =?us-ascii?Q?agilyizt7HF23GWCv6VIuusuCt+r/0s2btMHO+sJzvHt9488GXgIskOpyIMQ?=
 =?us-ascii?Q?BZQErQc1wtPJG0LBFDBRD5IOAe4L/8tGCh4cuHW0QtMCemP8T/N3nFCR83w0?=
 =?us-ascii?Q?qKlqNvx+cgAt0Hj/WKS0DjBHhP1djJYGNJeO9NTpun1B?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9faa40-9153-4815-3d80-08daa88c287f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 17:48:35.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poNRgC0VouNIHc+ohGiYzLznV0DIE5qRN2D9IhSEEv+9HAgGef6R0A8F54X/uhN1HAwH+3X6Ra/0bMjLTb7Uvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, this patch set fixes several fuzzer-reported issues of libbpf when
dealing with (malformed) BPF object file.

The 1st patch fix out-of-bound heap write reported by oss-fuzz
(currently incorrectly marked as fixed). The 2nd and 3rd patch fix
null-pointer dereference found by locally-run fuzzer.

Suggest at least taking the 1st fix in this patch set or apply an
alternative fix for it (see the extra note after its commit message for
detail).

Shung-Hsi Yu (3):
  libbpf: use elf_getshdrnum() instead of e_shnum
  libbpf: fix null-pointer dereference in find_prog_by_sec_insn()
  libbpf: deal with section with no data gracefully

 tools/lib/bpf/libbpf.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)


base-commit: 0326074ff4652329f2a1a9c8685104576bd8d131
--
2.37.3

