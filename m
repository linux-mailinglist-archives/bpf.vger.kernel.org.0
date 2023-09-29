Return-Path: <bpf+bounces-11132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252A57B3B5C
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 22:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 6AFF9B20B66
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 20:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8D37150;
	Fri, 29 Sep 2023 20:43:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136AF8F62;
	Fri, 29 Sep 2023 20:43:17 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020017.outbound.protection.outlook.com [52.101.56.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C4F1AA;
	Fri, 29 Sep 2023 13:43:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALJ+mWKhoXa4J4C4ng2WSfW/McOL3VSDN9mKgChRJsp/RUCQrzxbP9DlXhgoIGCAVzmAIhBPBP373iYTWX8EXXaK4T8l8IRIYr1ng+0f4NvJSs5AsKPkUkn8MAuEo953EFw4ARDkAAlT/oYRD4ej+S/2lIzj1xkt3H1yCyweIGlgzj17n+dEKw+r93eGLw9tkDtCL12Ihc94Mj1AAZFh5acx0WSbRtRS7iouzk8KHpg23tjf0ExX9JxIK6dJsqN6w91CA2kBkEOvggn6mUSg9CYK1V1n5FRSWog5X4CVeRfj66Ng4xWBDMNKmPmWJacjOIsoR1Znpx2Lf2r1Xry45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxT8qLiEFsyVUsdKnnu4mDC0v1cHYjdqSUmOxEJXQs8=;
 b=CichUJnYcNuRUrM1an7WSeYUKyckXcqLQN9KzuTxF3xDBcWnqpbV4JWOccsbjCRQw6RJTH8C8++WLHgDJ5U9O2t2dPeIAZaa7hH+uOetEUs8vXwPGHjHPBPOvbrxa375A1st3MrI1eTkmKkEoeNXksdGKnskMJ/9powNUSdFz3O7u2AdNqse3GtR/bTf4XsEruWBICoha6WCa2I90t0CEcsJWHpxp7I/E3hdEttF+WK7f9/AKOoh/knNfehbyTohcBDleE0/Pq5x7ugQrc4Fa7KJS/WyE2kYK3aN+Zxdz1K37sHqp+2Q99bTkySRWLndGdsq9su7ow8StGlTPXpJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxT8qLiEFsyVUsdKnnu4mDC0v1cHYjdqSUmOxEJXQs8=;
 b=DDXdn6M9lI5ZJTi4E76/SRtzkn3tksmVu7WR4bb5UXPu1i56MFMyU4eERXHb4o+OYpAiD7dbjUNSzkSH3/i/YuCLiJiCQdYHv5hjWiww6zFCyr8ZWZMvkNCIxTATkiMrOwHhwb3CI91dQ9tZa65324lybQNt6/jWCg06iVcEHFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by MW4PR21MB1969.namprd21.prod.outlook.com (2603:10b6:303:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.8; Fri, 29 Sep
 2023 20:43:13 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::1d4f:5006:aed7:78aa]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::1d4f:5006:aed7:78aa%6]) with mapi id 15.20.6863.016; Fri, 29 Sep 2023
 20:43:13 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	stephen@networkplumber.org,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	sharmaajay@microsoft.com,
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net,v2, 0/3] net: mana: Fix some TX processing bugs
Date: Fri, 29 Sep 2023 13:42:24 -0700
Message-Id: <1696020147-14989-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|MW4PR21MB1969:EE_
X-MS-Office365-Filtering-Correlation-Id: 762f0d67-afce-4c13-f28f-08dbc12cb2d4
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 U9SfSOUEzu8ckqbodITsATG1ND+A4+AVWU65gWf/c2JDjBAi4+umnOmZSiO1HLxyThL6nwavTClFQh/ztw2DPqWbMFtl7Yzv8SXnkEMEUzh8V70prv5kdvnaLG5ON1tXNwVUEEddjhA49HW7oixSBEBfMIJYp37U+Alot+pEmHXbog/r4UaHja8EtFHlRov9ilBjyGnq9DDQ0LRzOeUVFuJUVps6sgM+gD6lyk7kpFSicGli6j9AP6iLzYazx/cc/Aufk4Gq2jXq1ia5khXhzebvO1F8/NWlxkpNFJihCb/jhawUYeaPB3qSHTat1r54gzwDkHw/nDJLAOU/40qWvl4IW51eBaUoesFdMXBJJT38/rFIr3zhTFHX6cvEAwZBpAzAO/BsOzUBc1xdKLoI/BFpqO9wccEyg0SKyx4qaNEgUkqjdeEH4wfuHTXv3Hpxc+J/SpjT/vZ2NxzU3o2o4BIJNuJih3vIxbd6nkvFqL/99OoKh6e28+jSryRBrar1NSDHtPPC/tv7ZyHSRrkmAkeLs9msEhc+IdHM29JVzO3VKIzMYOOnqXdC736cL3B/4op4Zf76rONiEcgdY3faaH11FdTUD7CUxIlT+iLymN+vGGqi1uQJvllQg6QGFiHm9w17nWukmsgMb79atXQaP1dRPhgiRbGitUglWjQwv7g=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(7416002)(4744005)(6512007)(2906002)(82960400001)(82950400001)(5660300002)(52116002)(6506007)(6486002)(7846003)(2616005)(26005)(83380400001)(36756003)(6666004)(478600001)(41300700001)(38350700002)(38100700002)(8936002)(8676002)(316002)(4326008)(10290500003)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?MAdgxnYgJKQzrAq0Epfrh2vBKUiafZOuC6hH43ypCDT9nFRQsAva0uAArE1V?=
 =?us-ascii?Q?xU/tnGrqP7C94LArsHayqpxXB6HmHPAoCyCMiShRxnWgBuVGVdRvvBZuE69u?=
 =?us-ascii?Q?2LsaJSULrysWoPbrhTa+VyvngH47BS863wT0Al0n8dqyyF29E3PTokW7ls39?=
 =?us-ascii?Q?u43J95efKnW2hKJD9+GCYHoG6ICIT6mcN8u5IYUauQJcD64ev2qGoh5LJmbo?=
 =?us-ascii?Q?eT2gLXxdu2gTAwmeKZD4Gz5mxKxD2ioia9haBPyfIllVtbrea0SXp2cA4nWJ?=
 =?us-ascii?Q?Kqp0zMLKCuaDh6Gm3Y3A7rbqfCCif/qw9ckDebPlblADY8iv5GH7luonltEJ?=
 =?us-ascii?Q?Ak4tZ3MCpVwO6NGUIWdnIe9wbdOt2BEGCz057nCiAfnbutBkdOsXyoVB7247?=
 =?us-ascii?Q?YALWGjVekHiL7j6MMWKBGGNjlIfPNe+GpiG1Aaba6AIKMMBSmeoIrlsWVJwj?=
 =?us-ascii?Q?0pFM78s4/sdTvCujKweGsIbgbi0mUiz6RL/OgIZKEDTjbDxruB1DOxpv+gJn?=
 =?us-ascii?Q?0apE+Jxnkm2GPYSWXAwK0j68k+b8zmgOdZUc6jts8K6BwfeALioHq7oZRCry?=
 =?us-ascii?Q?IITx7un54Wa8Jl0UnczWvPdVCAL0yKcH0kHFqtnu7i2BxJigH1gJOascyR2V?=
 =?us-ascii?Q?Hirpo2N5U0SI2rA1Q1dSj7KpzHDDOLgWi55ZlPSlmOg3Mr/yJOTnQTkW08Cg?=
 =?us-ascii?Q?FGGb32AKRoQhOMtrk3YCvqa+EN7/sjMr0vQwpUGOZRikoCMl4N1T0fsig9AB?=
 =?us-ascii?Q?GQIWmWCRMHPvbSlTcQUrGRplDkOQa679AoqxkCVxwSpAOP96tHSbco++YxJq?=
 =?us-ascii?Q?qoP3xEoCWT4pzQ2SvMYbgZZEP1CJtK5knoCrbvF8tyksgjPUgL1pn9/HN9kb?=
 =?us-ascii?Q?nII45v6GUfa1kcH3qgzJBZ3SrLbGukKNYRqqYDIZ5QcZA+TLqALvStV370g1?=
 =?us-ascii?Q?UO8X/7Td8zQAwEjKVTev3IQB2T0qliylzsBSk4QgVd9ALhh8rLVFLq9zYOaV?=
 =?us-ascii?Q?JUr+FQbCmeyC4Ww1GqMkVoO0W6mPLdviYhDZE/cdSy//W/fiF15Uf6IcZ05z?=
 =?us-ascii?Q?x5VIgtBK2RvaX6SLKZn23tE8l0iIp0r8Yr5mH2Za2pl3u2NnPgCw2t9lx3xD?=
 =?us-ascii?Q?uCB6UKaqoMN5/3BFL8FY2JcIfbVEzpwmvMGOCr4Y7047GMf6s2noHgiOcf4o?=
 =?us-ascii?Q?FeBmCmJc2VxN/Mg+GG1jsMEtlNV/ED1SguBzATOWD6f8TaErZLXN5K82O6Lx?=
 =?us-ascii?Q?c2anfBkFLr71m3p/oKvKo5puzBuvEpB1sLm9twEQ1awpawbDev9wUtdkDzjI?=
 =?us-ascii?Q?IXGig4NjwzmeFxdkVpsPHT2k9RZUvObbQ/KThvfmya9cxVGAiK9mzeiPp8sN?=
 =?us-ascii?Q?DCKH7jScYTWR57IDHkGcJE4a2V6HpATHlx4mzgrNJ2KoySxUxEF9pmWYrxLu?=
 =?us-ascii?Q?y0mVs5l6QRAKbyPMgTdGZ0Hn3sF4U/gXyIR81ZP/k3JyTZrf++y6nf85TTpv?=
 =?us-ascii?Q?VptC4UBQ4IyjEGc9UAU/8KW2mTI9UatD59eAZCv2Xnzq7EcFEEouDClzGuhQ?=
 =?us-ascii?Q?c57vsiqCb19jS1mnHrHy3IG5Wwnn9d7BSHLNDirP?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762f0d67-afce-4c13-f28f-08dbc12cb2d4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 20:43:13.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DG4CUhcZ7n4NKEoU9k9BX09IP1qFP6rzhQefoUTNc5VqFdUAHmsBQdHde/T7lrL+G4kAiErSVlDSA1ooK+iWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1969
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix TX processing bugs on error handling, tso_bytes calculation,
and sge0 size.

Haiyang Zhang (3):
  net: mana: Fix TX CQE error handling
  net: mana: Fix the tso_bytes calculation
  net: mana: Fix oversized sge0 for GSO packets

 drivers/net/ethernet/microsoft/mana/mana_en.c | 211 ++++++++++++------
 include/net/mana/mana.h                       |   5 +-
 2 files changed, 149 insertions(+), 67 deletions(-)

-- 
2.25.1


