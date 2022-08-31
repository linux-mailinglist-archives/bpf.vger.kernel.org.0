Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AF25A7461
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 05:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiHaDTu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 23:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiHaDTn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 23:19:43 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F3AB532B;
        Tue, 30 Aug 2022 20:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7A1debJy/RqC3xKmwZBBcLX1PZT9GV14GOhU7TXjFCe+7GK2QEJMaGs2lb5AR0fQU/chYLi8N98KyvmogYmVu3Kbtx8e8TyHarguVOndW8zBWU912jvU0l+ZutX9lUroknxkc/mYTqk9QtbN2DtA8aTXi2ap0lroIxGKy1RdiE8+XCRn+j34pY8eBQXnGCu8sO50BclXcMABDAU1ykcwrr77QbfikwpO86OJPK+X3VSSBugqLxu1Hq5GeFYxH/I1Cy1id2v7jQpJY1hrIRTSv9cbtRINuVcNxsoKR7n4m9gHZEjq0SfAyaPlPeYJn9A7NiW/GHfhYhGY+5QiDbH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5x4I3LevNmwk45Oba9a+3ZqWAENvhlIreg22lv7WHo=;
 b=AbsOW7CO+/RVWRAcil1Z6UjyoGlHTkChdrVAgQD8xO55lQNtaTrCSvoVtDC1jz2nSwmOeJWHiPdRiPn7A7OvHOZaVOjWLoIroKyF3sB6JjTW4D85Ug2saj/n4LtPxoZxc/NYG6oXuJHr9lCyy4ho4Tz1h5ltU0uVM+cD4xz37xPf4AAshhUy3wrtb01zVOoT1HHwN5GwGmFvXJRM01RZvS5SlRsZLG13euPK1gzQqcoigBxOr1IYAMI2WUg9ydTRz5XuNf9AnisL0w5i+Svk1jXAcvEZEVNl4bSoNYeiQ1IyatYpyo9wyIYQty9vV2UTuANQPRfGmYWbVWbwcCMwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5x4I3LevNmwk45Oba9a+3ZqWAENvhlIreg22lv7WHo=;
 b=fNHrjt+jZQN+x5o0KILRgHaR7PF7633jYldEtyJwlivIDk172766te2OhkXDst4d9CBCWo/rcd+hvSrRA2gRdRGVy8z9u8JhjYt/eIoN4LT5LK+bZR5QeeSgBrZu1ODleGeZ3WcvHEqLZFQOPC7EPdGlfrSb1/J0VqgiSA1F0jcoA+RuD8amr/kFZt12pQ5oQJAZCK4IG6JdhDgvgOQD4EsadSzDGlZBOHw4yOjsnjkchvZRyOIKfRTR8SB9rDfLg54KVTwzNbTn800Ar/U2NB7Aka9OGNuIfe5TVVHMJswh21JsowunYcqB7GgjhN5ejJZQ+g08rK31lF3ELPlVkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AM5PR04MB3009.eurprd04.prod.outlook.com (2603:10a6:206:10::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 03:19:35 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::f95c:9464:9bc0:f49b]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::f95c:9464:9bc0:f49b%9]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 03:19:35 +0000
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "John Fastabend" <john.fastabend@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [RFC bpf-next 1/2] bpf: tnums: warn against the usage of tnum_in(tnum_range(), ...)
Date:   Wed, 31 Aug 2022 11:19:06 +0800
Message-Id: <20220831031907.16133-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831031907.16133-1-shung-hsi.yu@suse.com>
References: <20220831031907.16133-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2d38ff4-a488-4cee-9379-08da8affa0e8
X-MS-TrafficTypeDiagnostic: AM5PR04MB3009:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCwQ8hCZLc5tRDJFfP+dOliD6p2cV5k7i87DQ3DixyGpv0d6bm0F0j99ulLKVEZEF5rOBCa2YTBe5/L+wug3JR3HeqUcrGQV03ttIczylNB9sF9FWaoMMRqVm+jrBic806TKQIuj7/iIONrtKYbgBaOFLjI4IuMno9UaGhM7FaXwX3WWTPiKvJUrLl217ESYrXgwDNYY6Q22uEp688WyLAD9vS26TAEarD4BYEYyYICM2XICwbuNFD5VP5LNokV8peNp0CaZa6oaNRhlFTdlxsctqMgkkUBOu2BW+JLKE/7gLmQtUTceDlY/SYvOkXa+7/BBynE1oNhbXiNugYcQaeQGj3B9KfOXSaOceTeyRXszEn5xIG06ZFeGdsXPCI86OysjAX3ANgnqMpP7fkEZWo2IOngGTQdnLid1i7KrP4RPa6Opoj4ehgWTQiaJfIJ1NQF6zW9ddTKTMcg833UdFyU5NLFeJefWEyK3ZtViPHqB0E6VqDYGvKGQ33B+RfAEgEW730XAoA4QH7zz1/CNji+RdcJcE57vKE95WI5j2T0xe9QfLm/5aco0nsgWeKct8goPg/UpfFdD9ZTFskaGuiMBmihG3uTPnQIZ1pjaFdr47bbdM9WUYZGNin6AdAv/D+GcQfb4nI6U7uth89EXsOXZQMZkueRrKa+3h90xMBffUyDk+VPY/TpCoe+bm6DN/YEI2wveYSFG6X+0zUa2l/1z+TbCesWFrvkWzbBRVrOT6z65N+rC8/Nn/x+plT5d3mLt+RxO2eltVz0LNNbPNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(39860400002)(366004)(136003)(38100700002)(26005)(6506007)(2906002)(107886003)(6666004)(2616005)(6512007)(186003)(83380400001)(6486002)(86362001)(8676002)(66946007)(316002)(66556008)(66476007)(54906003)(4326008)(36756003)(1076003)(966005)(8936002)(41300700001)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YjTWmJ82Z6XTvuxofdJYOq3i+V0ZjuWEryJfvlNLLX3JgALAHvpUSDgPgBm0?=
 =?us-ascii?Q?jlUeHznXgB/J33ZDd/vMCbOsnmzc0jZf/fkBRToTQxK690hFpfejcX+1FKxK?=
 =?us-ascii?Q?ZwwwjzHnOs7wafaqJwg9KairdUU/fDj2rEnBkEiwM4Je++LYrIvAXm1IW8SY?=
 =?us-ascii?Q?ufRrcTO6aEQAtHPbK+cVHX8p8hboXMICphw9xUCbivsnXrELcRqrKM7z9mts?=
 =?us-ascii?Q?QInwdWBvY+bdWYCIQydbXxIltzoIevGohaLJPO5ZolQXnpNgqfm3mR9JeZ8f?=
 =?us-ascii?Q?kocWc6El00Hzr8xIAPgDyYV7lL1OLfNc0lZONkU5aplvnJZD/z3du62XzXse?=
 =?us-ascii?Q?IojFNQbmcLb0MDjgVXuzTB8hPNnDrrDJcmwckkCvUheeIlmeNByGfC4CLFTO?=
 =?us-ascii?Q?4xKT0+qf1qwv0vzED4bJjyJNM2GFFPG2ZOoUSI+Janr5LsXQqUVpmqkegdun?=
 =?us-ascii?Q?3R7/2KvAIzCqDH+XgQ9fWG5pECzjpEkdbJhXOwnheBTCUHIR6+qQo3ophkUZ?=
 =?us-ascii?Q?RXKC0NsbsrASrQFBzY5aUwynwj3ltDVe4SSDtFrHXWLAtuVivLKMkIOOz00S?=
 =?us-ascii?Q?m4ILQBjU3zwEvtFoDgt0y+Ek+kk7qhkte3cWut84RZO4Uq9H310sEYmNKyMk?=
 =?us-ascii?Q?HPhgeaW3EQ6g6v1+QT/FwMkCeLhL3e01zruzk8EBHSIv/sLx+jZso3941SNQ?=
 =?us-ascii?Q?TCQb/9TkWAV9+IN5z243NiUmNMMt9nw9wNqlp145aGMshS8nhyZ9AJaR/6jo?=
 =?us-ascii?Q?5TEdZ31Yme/p0U4xVMfglpuvChmnM6McQl/S9Jrv9LaEcp3jGvaSx3WB9i9J?=
 =?us-ascii?Q?MtffYuCfG9RqY2V9aWcH4MZWoxPR1vzf2nIL8dYYbmYHveGran5IVcUp91sX?=
 =?us-ascii?Q?YasSPhmlH9GsgnhHpqqxXgF4vKSfSYWkWVTcQ2VyvSGZl1FXRk0Qh/GzNEQg?=
 =?us-ascii?Q?4hE2R2g6oUyEQ/LnhHpUSp37zRl/LNCptIVkuQ11k2jJqM2szR1TBtA4TTrI?=
 =?us-ascii?Q?A6ev1kF3KijW34+8RKc9uwVg7HwsrMAbuGxbpiYasTNfeHm0Ez3nqurR5C4W?=
 =?us-ascii?Q?bmniNx6RRHuDjn4zqpgIm4cLuhI3y8bRY01k9rDOnNTj8friN88UG9vN9j8a?=
 =?us-ascii?Q?pNz+b31oaLp2U7su4+aYz6Ct21N2zyOj6uf2XG1gUjvz7uwUPXS+dBKzGjxR?=
 =?us-ascii?Q?10nz8fN058Hy5M1BLqQ+AUqnNQ5haYa1TxpyIGlS6CeCzp7/lhrdfHUsNmt0?=
 =?us-ascii?Q?pjHssnh/QG2GIKCTArJwRSwcZCALKdJvAy17QC1/sM18RClG2PijLNXML4mz?=
 =?us-ascii?Q?a7dG3LwDOViooX5Z0P0nGtN8fta6a3U8/0v9DF4tKsNj1Kmue333p94ID0Su?=
 =?us-ascii?Q?SC52et17qNReB9sFKkkH9qjVjcnnZD6chHaH2gnrLQVSGH3XqQTaDIUxcXzx?=
 =?us-ascii?Q?7GVFgUPAEF+tCHnX8SEER5bn0CYpsyDKywAHiUB7hvW3O8yq6JoSWO+ZsI2h?=
 =?us-ascii?Q?00964dL0X8cjpzV9gt4KeioDqSjqs/yKrIocyeq5XjgRCjpEGoHrsRR6cCQl?=
 =?us-ascii?Q?Z0rke0oBGZrjkm5yvVmz7WxKFDJjNefv64qB4j0F?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d38ff4-a488-4cee-9379-08da8affa0e8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 03:19:34.9267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3XzMI7+6XY2WpePvHdm4G4vQ0ankg0wjrKB1CDrQC+KhwK2JHV8L9qpkiMu3aHhlUYmdVvecQmI6Hu3CXXn0g==
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

Document such behavior to warn against its usage in general, and suggest
some scenario where result can be trusted.

Link: https://lore.kernel.org/bpf/984b37f9fdf7ac36831d2137415a4a915744c1b6.1661462653.git.daniel@iogearbox.net/
Link: https://www.openwall.com/lists/oss-security/2022/08/26/1
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/tnum.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index 498dbcedb451..0ec4cda9e174 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -21,7 +21,12 @@ struct tnum {
 struct tnum tnum_const(u64 value);
 /* A completely unknown value */
 extern const struct tnum tnum_unknown;
-/* A value that's unknown except that @min <= value <= @max */
+/* An unknown value that is a superset of @min <= value <= @max.
+ *
+ * Could including values outside the range of [@min, @max].
+ * For example tnum_range(0, 2) is represented by {0, 1, 2, *3*}, rather than
+ * the intended set of {0, 1, 2}.
+ */
 struct tnum tnum_range(u64 min, u64 max);
 
 /* Arithmetic and logical ops */
@@ -73,7 +78,18 @@ static inline bool tnum_is_unknown(struct tnum a)
  */
 bool tnum_is_aligned(struct tnum a, u64 size);
 
-/* Returns true if @b represents a subset of @a. */
+/* Returns true if @b represents a subset of @a.
+ *
+ * Note that using tnum_range() as @a requires extra cautions as tnum_in() may
+ * return true unexpectedly due to tnum limited ability to represent tight
+ * range, e.g.
+ *
+ *   tnum_in(tnum_range(0, 2), tnum_const(3)) == true
+ *
+ * As a rule of thumb, if @a is explicitly coded rather than coming from
+ * reg->var_off, it should be in form of tnum_const(), tnum_range(0, 2**n - 1),
+ * or tnum_range(2**n, 2**(n+1) - 1).
+ */
 bool tnum_in(struct tnum a, struct tnum b);
 
 /* Formatting functions.  These have snprintf-like semantics: they will write
-- 
2.37.2

