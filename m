Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A3A5F7C73
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJGRsy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 13:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJGRsx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 13:48:53 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D7ED2583
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 10:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaT+AN+spk5k5UsgHG/H8VkBGViODZXIb+8foU9rTAQrcG3owtSUKh+VqvpgSclWYSQl2e6Rll8aqllXhUkvF8aIiRIGGaD0tJWU2FDz4I+0GvwV2+rp4Kl+m/utRKKe3SViBWiCk6Ka0IKGwkTMEGG25KP/k2O3kNgvz8PHExEcG+13WyUgQMHaorjQD/kQce0Lm/a2PONaF+hV+RamDijzluq6mRE+wd0z2215bE9a+3PuumuSXgfiz1FLN7yEm6qvTWbUqDCwSE1ZYcfin+vRKDlw+3aTamwXqwFj57LYdkCI1zllib7bNoh2HExmILKrVLopFRvV0MfaQsYj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA/HdeLUmfl9Nf9LWOL9XWuYBa5m7oytraKtKgLDhoQ=;
 b=JH3Vl44WZzPU7zivnzDdf9/2iXqsE6RT7phJbJHqHLtA57ZAhmnH2GzZYmH8AdlH2sxtsQN5cYiBSRjzfkjOmWkdsb+B6f4MQ+HIdDTB3qAy9RsG6qhwPh52n/d4DnXSil1JIWNZdfGYad3jRrjfKIf9tguSwM1XDhjcf6zCvGSDC7xVfTEr0xHvJX+Abea6XwDTioBd5SUH0iTBwYvNm0EHlOITkv2iI5ndTldcIRlLu+njgBe5mrJ7+2I1PGpfsfMHds8fUPDVw1blUILaIfs9tBWRI3Q4rj4x8ojPvQkBh4jZSpBtk/AdHBmt6z6AixeBZvHoLiCrBOOGnaHkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA/HdeLUmfl9Nf9LWOL9XWuYBa5m7oytraKtKgLDhoQ=;
 b=QjU7U5ZdbV33sdWky9h6CgKqx/0dU3oXIiMl5AoV9hNvrHMaWDl/4rR2zSjHmReDfqG2OAaxryzB66QAuPcA8j4+VB3wycyduEAwZlQbjf3YXfycRq5KUChUyeUAKUbduUq4xcNY5xoDPt3CEId62D+SklBqf2xoSL9etZiZ6zTeu5Rs/YGfyJFQG+XFvZe2JyQfMfcIESIf/NquBzT7es/Dnu093flmH3R/DN1sk3VdyzBwHupmfyVnrXqcVWLPBO2FOXpZt1NFDhxzXG/O5O1kfAPmInic7WwDsW/TtvD+N1n1RJlaCfe4rriAj/JErj9heoLVD24AE8JD3PeMLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by PAXPR04MB9350.eurprd04.prod.outlook.com (2603:10a6:102:2b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 17:48:49 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2%5]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 17:48:49 +0000
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
Subject: [PATCH bpf 1/3] libbpf: use elf_getshdrnum() instead of e_shnum
Date:   Sat,  8 Oct 2022 01:48:14 +0800
Message-Id: <20221007174816.17536-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007174816.17536-1-shung-hsi.yu@suse.com>
References: <20221007174816.17536-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:404:a::29) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|PAXPR04MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9ac113-1f1a-40c1-73a7-08daa88c3082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvVpsjamiqhmSvsFsRSH1iM68ItyX3ADetZ8Jy07DrCAGhSo+FpvTUz+aquWrx4Wa/Yq/2PLg3EfvqmiZ6nrjAF+3Jo6i8nMlGx1H3SULhYrUuYf8pCqe+i87+JlMVaNGY8w0MqhVvQUTKXxsJt/h0x+z9TRFcMo1YFMIrZtApYAjF3idBDHqW3HRH4ctyj6oyQhhIYLeJ9nDMGdRjdaMyEkxKR6D0ryPpTATsr1yb+YAkeDo0vIL/07+9q+/5Wqh9r0XtbJWxFijfAZU2e5b9PG0ahYTGR+1/awqSElNAf6C1cbHqntwO2F821tewEx5P82wRDoR2uOE8ONpUn0VT7khFmyihyvzZsm5/DYH9jnDR11ReDoUrNDUSx5xrdZrp/hq/YrMSduUJfaTaLD+xxMsyDG/CQmfyqmG46X1dT8G+sfaGx6YqnD5jodxnidCpqxxdfZS1z2I7yUEqjuMCYilCFZ4KHPtm9ZbgKYDf3ct4UIXLX68NOqPLNHyLqr8uPoEOBPae07F6tB2CDgmuPNQ9wSNiLCqfSfer2sfs1cmS1MqTV3Hf8JM728qIuOlJQZ0/MyEQQlT/WMOI8l9v18/jvxLd+u9G/nO8+gkjwUNmsD9QXxa8061Z3i/sVluOCUtx4m8ja/0hNYLNp7gZUSLQ22kWGy/RTkE1i967kg9RILVrR4BAPlea4zjMaHSOjdf/2raC7KOj1XBExnNYt61H53JNoOZUzSyNj9r/p1BQe550/Clp8O8AW0XNUWnnkV0rO4/jKrPMGSliuoyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(1076003)(41300700001)(54906003)(186003)(66476007)(86362001)(966005)(7416002)(8936002)(6916009)(66556008)(6486002)(66946007)(5660300002)(8676002)(2906002)(316002)(4326008)(6506007)(478600001)(6512007)(2616005)(38100700002)(83380400001)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PAj9Pph1/v2xJbVKe+cdckZPgTD6hyVaZMPe3A0uVcsKfUEaXyGLMD64rdkJ?=
 =?us-ascii?Q?hTDWetHrx7oEsEfNhs6uqS/NPD5TrrVmsXzlS2+VMrgFRMRL1VCnPLwcoZaY?=
 =?us-ascii?Q?XBrJ9OpIrp+cPaUFcd8a2/TmuFihZjS72wXZG9tDGin1b5YXVAAjrJdyBpCF?=
 =?us-ascii?Q?G2GeNRTymMeG3vRShocSJstlD0wQ8pCJ4ldDevc9yhEzd4aeODMXpZ3rX/1z?=
 =?us-ascii?Q?V8XuiIYseeRNTEnXn3uMyLSoPUJIz1ue/wOjsqjqv5q4jqmNG1vJ0O0zf+K4?=
 =?us-ascii?Q?g8XI9Qb4A0g32S4kvvZ88hLSKHoj7Sfo1GjEzE2reRn6iwUuFlEuvb59zEeU?=
 =?us-ascii?Q?Q0bMEfuS16lhE8HyRdA90R4meB0kJtS0IVsuNfW5Hg4soKa6UtQYrTjrTcpC?=
 =?us-ascii?Q?gRlP9NLiwlqbe37ARENREEztJc6+1zA3JrpE2OkJWbh4zmHDGIFBWGQTIBee?=
 =?us-ascii?Q?dqz0bUguYf9Wo8S7FjcQ8HOpSRltV+VbN2M06OA3wvOED6M/c+t7kQR5BTUn?=
 =?us-ascii?Q?hAF/kByU/79JUVZQQ21MNXr3Izd4up+zUt6jGIQQm7MqIirXQ9VuoviXuFBL?=
 =?us-ascii?Q?lTZ2exDFobxElr73dgIoyAh/nzsZVWt+7o6c2o+u5Ag8RE3XM2kbcmJjlM00?=
 =?us-ascii?Q?d6EIZS9D0y4HLEnrbIqvYI1K00HsLxFmA4yM9eR80t7FcjGeQxoniGmz7jWG?=
 =?us-ascii?Q?xOCDzXpyVvm75qU6AUmtpEvTpTjkiZfeMzCxUFliR3hOHMi8jFDJE103kxv8?=
 =?us-ascii?Q?7HjM7Z7h474u2qKaU31+3CISB9JPoHb7/26mqZEvO25l4KdZO9X2wtpSNOo3?=
 =?us-ascii?Q?Ql2k/cSYAObSiG12iPWUr0J3aF/SIDal4lHCOkMnq7uRS1rGBLQ7ZL0OzA0U?=
 =?us-ascii?Q?FZnVCGJlhYe4OF74C1Pg392+K3YgYoBUYalW8az+LNWDhJ3gmqF4GKpUr15n?=
 =?us-ascii?Q?sY95esVqh315xwuCSVK2Gd2PcuFAI+Fo9PJZXT3EHxXiGmUIzJWEZrJfaeRQ?=
 =?us-ascii?Q?v/Iyg7Ffh9z7oA9tf3/bCyMQv0mEU7Ynsa809So6kZ1lXPEhnDEkRTKKQW6N?=
 =?us-ascii?Q?eQCUqEc/g+IjmR4EQ+qlvsAtmYFf86xffJqT5z5ROSD5nJ8kYde4ITgoob9N?=
 =?us-ascii?Q?3m5NNlxdjFhzhQf3GSi9Vxf1JAdPOmJeoBpgsAXgIgn9q4LQ7cpMOS+hcszb?=
 =?us-ascii?Q?bjcv3PKfpsux/bY+WBOm1KLU/mCERoZtwceeNFZ5vbTqTGJKi+Q0KSgbquaD?=
 =?us-ascii?Q?PlFvdo4oXkEuu0AGb5+ibVQQcPIf3GpJIpl0jpBRrxc/F5EujD1btSeQhU7f?=
 =?us-ascii?Q?iODNbJx8MzDItw5TJaa60Nnp+O1TjIKQLQtOSYBgPJi0CAiP5t175+nejHMn?=
 =?us-ascii?Q?TVXxErbSFpquVoRisMwN1ohKiA+zmuVoFdDbk5VmkbkYOdof42aRDqbzhj9S?=
 =?us-ascii?Q?p9E0pY8PMFoPp8gjf9GLbSboE9aGxNc+k3oL84N7lSkju6EtFUY1YWNlHYbN?=
 =?us-ascii?Q?PhVB42yPLO1tXXp+yXr5HM2hhkq8dOZlsvT0YNjQ//63MJJqHqj0DDmPptSE?=
 =?us-ascii?Q?/z4nLOA9m98XvxctbCOhC1on7G9J0Gdflv/3bkhYOlUG8HQvBMtxroKlc6l4?=
 =?us-ascii?Q?L/F2n+MeIJS67/L+TD/41+2ab0NoKdhHExB04eaSIDuU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9ac113-1f1a-40c1-73a7-08daa88c3082
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 17:48:49.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76QJyLfsMu0Wn1L4i64Hg8M9mR8/bLcqxcUGXrOr5bTePmT/e/so8QKX0tYeU2BY/DpXMkrFEiM/nsCb15YUTQ==
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

This commit replace e_shnum with the elf_getshdrnum() helper to fix two
oss-fuzz-reported heap-buffer overflow in __bpf_object__open. Both
reports are incorrectly marked as fixed and while still being
reproducible in the latest libbpf.

  # clusterfuzz-testcase-minimized-bpf-object-fuzzer-5747922482888704
  libbpf: loading object 'fuzz-object' from buffer
  libbpf: sec_cnt is 0
  libbpf: elf: section(1) .data, size 0, link 538976288, flags 2020202020202020, type=2
  libbpf: elf: section(2) .data, size 32, link 538976288, flags 202020202020ff20, type=1
  =================================================================
  ==13==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6020000000c0 at pc 0x0000005a7b46 bp 0x7ffd12214af0 sp 0x7ffd12214ae8
  WRITE of size 4 at 0x6020000000c0 thread T0
  SCARINESS: 46 (4-byte-write-heap-buffer-overflow-far-from-bounds)
      #0 0x5a7b45 in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3414:24
      #1 0x5733c0 in bpf_object_open /src/libbpf/src/libbpf.c:7223:16
      #2 0x5739fd in bpf_object__open_mem /src/libbpf/src/libbpf.c:7263:20
      ...

The issue lie in libbpf's direct use of e_shnum field in ELF header as
the section header count. Where as libelf, on the other hand,
implemented an extra logic that, when e_shnum is zero and e_shoff is not
zero, will use sh_size member of the initial section header as the real
section header count (part of ELF spec to accommodate situation where
section header counter is larger than SHN_LORESERVE).

The above inconsistency lead to libbpf writing into a zero-entry calloc
area. So intead of using e_shnum directly, use the elf_getshdrnum()
helper provided by libelf to retrieve the section header counter into
sec_cnt.

Link: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=40868
Link: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=40957
Fixes: 0d6988e16a12 ("libbpf: Fix section counting logic")
Fixes: 25bbbd7a444b ("libbpf: Remove assumptions about uniqueness of .rodata/.data/.bss maps")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---

To be honest I'm not sure if any of the BPF toolchain will produce such
ELF binary. Tools like readelf simply refuse to dump section header
table when e_shnum==0 && e_shoff !=0 case is encountered.

While we can use same approach as readelf, opting for a coherent view
with libelf for now since that should be less confusing.

---
 tools/lib/bpf/libbpf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 184ce1684dcd..a64e13c654f3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -597,7 +597,7 @@ struct elf_state {
 	size_t shstrndx; /* section index for section name strings */
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
-	int sec_cnt;
+	size_t sec_cnt;
 	int btf_maps_shndx;
 	__u32 btf_maps_sec_btf_id;
 	int text_shndx;
@@ -1369,6 +1369,13 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 		goto errout;
 	}

+	if (elf_getshdrnum(obj->efile.elf, &obj->efile.sec_cnt)) {
+		pr_warn("elf: failed to get the number of sections for %s: %s\n",
+			obj->path, elf_errmsg(-1));
+		err = -LIBBPF_ERRNO__FORMAT;
+		goto errout;
+	}
+
 	/* Elf is corrupted/truncated, avoid calling elf_strptr. */
 	if (!elf_rawdata(elf_getscn(elf, obj->efile.shstrndx), NULL)) {
 		pr_warn("elf: failed to get section names strings from %s: %s\n",
@@ -3315,7 +3322,6 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 	 * section. e_shnum does include sec #0, so e_shnum is the necessary
 	 * size of an array to keep all the sections.
 	 */
-	obj->efile.sec_cnt = obj->efile.ehdr->e_shnum;
 	obj->efile.secs = calloc(obj->efile.sec_cnt, sizeof(*obj->efile.secs));
 	if (!obj->efile.secs)
 		return -ENOMEM;
--
2.37.3

