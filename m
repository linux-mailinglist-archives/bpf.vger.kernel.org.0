Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC42E5A745B
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 05:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiHaDTa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 23:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHaDT2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 23:19:28 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2060.outbound.protection.outlook.com [40.107.104.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51DB44567;
        Tue, 30 Aug 2022 20:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwyeA5uI8josFqKCZHmQi6/bb3pDuutlHywbjYh4/VhXgXlAJJUbtn/jS357nm5BRL/SDzBLmV2rW5rA6G8at85yLr2G1y4FG9RLaM/unJvhF6mMSQDApNnAEVtG+cEpmbmC1fQ+zJkZtsJiLwJjvf4afXKfVfGUnzOF7gNg6qiAplyYu564AFZD+fTGxyF/eignbtKyKbiagIU2Vjacs34xAP5ZzDn3ldI36U+s/cqyYZOk7QNMUP1Uc0qV6o0iypoHs9urq7DNG+GPcV/czjGVZi48Ds6xjDtOMi3NaXI0+FLPBmSEZj7KS+6p59u4Lq/uuj0JuiVOh4FWt2qq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+NpH7QIzCoaLqU8/pzbeuh2XZFNVPLJt8BIWr4PVrk=;
 b=d5vPYwgCz5ttp5yNRBJBw2Q6O+/Lhuxf2jMD4k+bhmoGSFHpYKn3NvVocQXRs4bxxXjDnb/5ZCqNtLsZnndPv+f4kEKYmwDib8AOiuOqSAfiLhJ8y7XsglpJkMgI+tsV2+6uSZLREgVxwLRHWzahD5ylm6961iySK4DmiYbTxjfG8IuC9xb7tzn5Ki9/2z7K57u60rYFgSLX6kg+uZtxYNZoQJNzVDm7HRta2DsmtmzegfoSlMxAvncmTK7/ec0sfY5kFRPj0AcJxUwHzEqywslALg84Jx2L3ImxKT4t1Xtabrn3Z156M+99Q3j+RL0DNdpBwOvQT/CCoACPna/9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+NpH7QIzCoaLqU8/pzbeuh2XZFNVPLJt8BIWr4PVrk=;
 b=xMv7pljY4g/tbNbc+EJS+CiSwlmA5/M1P7YJTLIxkGhwDQHKxMgCkHSOTUMdp51L8jHVqTPCW6rUw2JBdGHk78WCZoOQ6JzOdqIbvQ2NQ1LzOj7OD41prVux40tDgJSu2czwsxpUm59MlvbPaILAexXEREGBk8qcCGcQ8zd65b/fXhwhrfBO4Znkc++adKDRWWAjX7GNBCC1G13AUnQcDmb6VEszhpsBSCpFNqgVajAlcKxO7ejMGpw92uE1im702WbLJL/bwpbpQ51FrZ2/Rds1rqUWOK96HAA7lxK1qALSCiArprPbChIMK4KNQtXwyufzsCspUnluZ+PoGtEhkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AM5PR04MB3009.eurprd04.prod.outlook.com (2603:10a6:206:10::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 03:19:24 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::f95c:9464:9bc0:f49b]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::f95c:9464:9bc0:f49b%9]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 03:19:24 +0000
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "John Fastabend" <john.fastabend@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [RFC bpf-next 0/2] bpf: tnums: warn against the usage of tnum_in(tnum_range(), ...)
Date:   Wed, 31 Aug 2022 11:19:05 +0800
Message-Id: <20220831031907.16133-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9680f7f-07d7-4280-998a-08da8aff996f
X-MS-TrafficTypeDiagnostic: AM5PR04MB3009:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wG1qQx0iPx6Yakg/jln7zxsreNudhqdW9mRDF85Z0q/OVSGzhU69GzvY+Z2roxxg3+G3Y9JLTHZPwIstFDmruLuU8Pa2QKA3s8drkdL/yaV4LS4bOC6CySkWHPP/3vLGXQ1r2raoKpE8W6U4vhGuOh39S3WkKX3n2KK20pyYj66XFy3wMIfrVo0vQ2pZ7f0QVodarkkoNfEcrJ6ToeojcsGumnjPbNPTg6UjFp97qa13oVH3wSSW1XyXGBtQIypenINlY7T44Od75JmfqqBhOhTDXhuaF1YK1Onf8VFvzZyjvTxMMmHNVDl1G1aOR7a6JxkZLH8N3GzomjiOzRq4lEYWWsIYavMUY8eqG0WYP1lwOYsYKRz0vf3c8DeNBLKLD9ARloqket7Zk41ggV+q9JLAJ8SVMrqEcJA/Ia+RxUuFWKCJ0XNb3NSS5DZkhJgRIXow6jirmXc/Ss5AHS4DbfMNcqzasR6lMZCefaYmwcYfve0ON2PHA7nHPNAclkp5J8z2tTMOzwnkYfsDdPXDFQg0C5g6/RCxm7vHZBNqnYUKUdOGUYO/F4rZEuW+ugNpPVlo055nqQWWlY7zxRk4numRzZ5dfNtbcyVAcDIq6k36pUa/RGVaz7jQh/RnpTzMW2vF+e4UkkX7AZ7G7lrzKn0GbtIkWGRk7/azlrRaQ3ZC2DP1f3gKpnxjgCnhjteyPpzj768u/QnKlvq/pF4CDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(39860400002)(366004)(136003)(38100700002)(26005)(6506007)(2906002)(107886003)(6666004)(2616005)(6512007)(186003)(83380400001)(6486002)(86362001)(8676002)(66946007)(316002)(66556008)(66476007)(54906003)(4326008)(36756003)(1076003)(8936002)(41300700001)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5gR/daOm0u+srdkbx6rmQcFDJo5xaYMpYbIZG/m1cD3vYKjUEdegnxXN00SK?=
 =?us-ascii?Q?s8M9m1WlxQzRQwShSvJzLSJ6wiELLrmkj+LP5QMxty7CScJo8YSSyrAn0jQk?=
 =?us-ascii?Q?7eqvYcZDalWHAAoJHMSsqqmRuYUVEOSipjxGLs74OFhyqKTuGtuGvqm3mV3i?=
 =?us-ascii?Q?TPrTRbdUVKJxu4Cs0Bcpr+fDrNYGhpSRk4eBDGIalJOyuEAI1JYK/maHLQJd?=
 =?us-ascii?Q?IQeVY+ez+S3/cCG3ijai85MXNfx2i9TpOGjI0PfM3xQHR5mlG8X1eRyUYQUT?=
 =?us-ascii?Q?EBHpgimcNRFmM0itNBDBvzizhZnyWx65pdVHvOq3J1+r53P59zrTu29hU+Bv?=
 =?us-ascii?Q?vj6LWnxUixo03vwKVcFz2QCUe8doNrh63HNfc8X3cU+iD+T3uWMoGuCGtyTz?=
 =?us-ascii?Q?cRMHR+y9sR963g9E++ebgJkdwvASnoeAzwZQgJRsBe+ML5Fk6MscVKiTQoc9?=
 =?us-ascii?Q?evlRN9gW4wri3pvK6T3hLz9IvKtuRDe3iTtJQTad5HIamuP9UEBDoCesbiBj?=
 =?us-ascii?Q?beSlPNJXvGXaNTvXbZX9BzlF5eLDDDk7v6Axd0fdjyeHOt/LOTjd5IYX4LNP?=
 =?us-ascii?Q?HY7tkUj25atWbPdliMwuViRjegYNEVQ7gUo5wxXKCsS6hpkW6eoW/kevzScS?=
 =?us-ascii?Q?OkaR08apv6dW31gPIfcxUXUAs37bVNARWgaeoasZzLtOtihMOoQcbMK7EawO?=
 =?us-ascii?Q?meGF6a+uxX7HXx6lk1he5ZVAE1bHVH2ED7TKDc/za3o9MSui1ZFH5FvG0T4Z?=
 =?us-ascii?Q?nn9DThlyw5XgerG9PJ/0sBetnOj/Cc/gyp1AV4Zdv90PudzSjjIsNjYd2W8w?=
 =?us-ascii?Q?6oMbThWf08Zlfl4qK/VTNdyG118EH+5MTj47Mhhjq82NYP79Vt0+nQ9dVP6E?=
 =?us-ascii?Q?qR7QzUfsyobc56y4Pt+V8MgXj1gKR89qUCJYV1WlTY8WLpqwCLvBxDB/atV9?=
 =?us-ascii?Q?wHLQKc1hv/LfIrmGRSJCivL4hMa927hLTaTmbAmj7gKm8xLjqdwYGXwu4f0J?=
 =?us-ascii?Q?LXYCFjIjbo7Z57lA+eLJHCBzA96ZCFrwgBfvemMn3rM8IQp8IGo65jGaHkC6?=
 =?us-ascii?Q?7ktmtGRIp+ffj5y129R49rY85xDEwyNJoY7N7rlrixhopCvaSYWFWxhdHHLd?=
 =?us-ascii?Q?7vQucgMp8BW82+5pJmg41NUSpiRbpUVPfaGen6FQkwaaxQAS4zdJaqu+hA+B?=
 =?us-ascii?Q?1u5NZ3E/VZTc1ekLYNvK4Uls++KtCOwO7Rpzkp52daZLlIyDrmR86PGsleKs?=
 =?us-ascii?Q?Mrsdf9FU8td3HfuTyZGlw8i2MB+jHVAMR1+zMkNOZ3v8HFX1VBdkieLYQw1Q?=
 =?us-ascii?Q?WYSoCNG+bGNWnzyDVisYbq/pLL5c5KVs8EpFLggZ5lSqoLx1kIXzfkGQURy7?=
 =?us-ascii?Q?JEHcHq6jDoiGReBj5RtzVTdwlgeBaFZyoFjd+OlL74wL9OSC/L7STwFB6YuR?=
 =?us-ascii?Q?J5vtTBxqm0MU6Zv/9TiF/EwfwcOTXRM5MldymI3pYJuFGewXeEyZIgR7cIqA?=
 =?us-ascii?Q?2ru7edCvN4ohlPoOT7sZ4gWy2IObMJt42pbvrknPz2nCJT9OBPaB5arY/Rr3?=
 =?us-ascii?Q?Vf6c9CcTtgQabTwWD5na1PO4JmqVBbjhj3MXvFXB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9680f7f-07d7-4280-998a-08da8aff996f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 03:19:23.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OA0DpkmEujr7uYfiYUryn7hs5OZ0GZDzpsGzrjO6B5UR8Sn+ZMd2NpXwWOr9uPllr4NgSBUFEEyH6A7uAFqLSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit a657182a5c51 ("bpf: Don't use tnum_range on array range checking
for poke descriptors") has shown that using tnum_range() as argument to
tnum_in() can lead to misleading code that looks like tight bound check
when in fact the actual allowed range is much wider.

This patchset is a follow up of the above commit. I've audited other
usage of tnum_in() in verifier and have concluded that all of either
provides a tight bound check, or is using reg->var_off as the first
argument, and thus safe.

To prevent the problematic tnum_in(tnum_range(), ...) usage, add
documentation in the tnum.h header file to warn against it.

This is sent as an RFC for two reasons:
1. Gather feedback on whether it's possible to prevent the problematic
   usage besides relying just on documentation. 

   One invasive option is to switch bound-checks done with
   tnum_in(tnum_range(), ...) to use reg->u{min,max}_value instead,
   which should always provide a tight bound check.

   Alternatively maybe problematic usage can be detected through
   development tool (sparse or Coccinelle?), but I know rather little
   about them.
   
2. Attach a proof for the claimed safe usage of tnum_in(tnum_range(), ...)
   found in patch 1, where the proof itself is not meant to be
   merged.

Shung-Hsi Yu (2):
  bpf: tnums: warn against the usage of tnum_in(tnum_range(), ...)
  proof for the safe usage of tnum_in()

 include/linux/tnum.h |  20 +++++-
 tnum_in.py           | 158 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100755 tnum_in.py

-- 
2.37.2

