Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F275FBF22
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 04:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJLCYS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 22:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJLCYR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 22:24:17 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00044.outbound.protection.outlook.com [40.107.0.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130DA75499
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 19:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNVNW6NiwGR0MrQs14JKoQTvzP8Ex2Ltylak6IXBvThep9VHZ/SQozJApWsgnNou5ZmpBk/+GUJKpCSsReutdPTrA53rmzlD+M/46YXhliEJqeJXu2DarJzCNVPzq4zX6GslELt1zrrNSZT8zBluNHU7G1++XVATEapKKRmmRL1jdDEsz0rTbOxplDzz0QVz0EJKio/bJjj0YZG4ZsjVSrY4+rDotAVRCJKYjjw4CH7T4iS0K1HVtvboQ+xny51JJ69KuMRNV3zvMRZptWjWrI8wVbDdqXSYx8sLyi6huOYDjIX9zBwvH3xN12QWwC6HkMZdYjhokSJazUqcS5wtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQSUkLiF8j5KVXhie56eyNFoLVPUVEDUa6BxHGHtQsI=;
 b=DqddY+nzRr5Fv1reLY3hTm/cQkNBcAUwbkcor/JDKaKrk8Np/fls7Ij8bsLRhhGzK3blU7ZK2f5VLPo12htXiug739050+9shW5VNAFqdUdMRTPFrVfaxhvXg6rEdwAazZKQzLx4hmvO7EoTyXSNDIYGaXEDS6RWzuEmRxp8eWl21iB7pO3QYdbiuFP/x6N+FuB8dTW6hU96RdUqKeoFii1JRfNOasuP4aZ8k4qYladIPwMcVmasb9EqiR0OhjJ1Rk9hXv69VJ5lIbwIkte4+f90uD/1HTiBA6ihikykjVUdWUX8eC8LO0S7C451sG8H55pPurPXEfALRqNt54Om6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQSUkLiF8j5KVXhie56eyNFoLVPUVEDUa6BxHGHtQsI=;
 b=WNKGI+T912XW8f1rFDa33oiqv9NDYY+P//AQLcc37isDZLvyPMolOFhqf7yzjBI9Pw6h2KJ2FcpDezgHeSF+T8ixWeqgBt4XiEa6dRGccPUQ8kzdazas92sLHZmj4gk6E6zBCGoUfHhQNkocjCSG9keq88JnUSxZ2T/MLL6wOZwkCVtY2J+MRrwxK2nsjFxvXaunfCaoPe+3aQCBgsgBHetsi0HH1p273XvSYFu972nxl5BnTC/v5CzZcs04nnsP7PbZWn0aqWdar+74Rn019hYvmjbP/nKAgXeb9AJ1xHUiuLkMFqmA5scIrD49iBLcQ0aFFR4VV16823MeIplCrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by PAXPR04MB9204.eurprd04.prod.outlook.com (2603:10a6:102:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 02:24:14 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2%5]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 02:24:14 +0000
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
Subject: [PATCH bpf-next v2 1/3] libbpf: use elf_getshdrnum() instead of e_shnum
Date:   Wed, 12 Oct 2022 10:23:51 +0800
Message-Id: <20221012022353.7350-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012022353.7350-1-shung-hsi.yu@suse.com>
References: <20221012022353.7350-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::15) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|PAXPR04MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: bae65e29-e60e-49d6-da12-08daabf8dadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2XQSrTd7GORiJjaGEv7wzOs8tkjzT1pM9A7HPWx2QZ0N/vUg9OZ2UdY0KSsLFeWHzR0X6rWNpg8hxHu0R4pifllLenq1uchXytPTIWZ1jb7s40aYb+Ric4lNz1M1+0UMEupiXVCK/hA2EyJXHuMG+5ly1lypUqMxZJeAYRCw8ZD1kn4m4I4i4JsuQwD+xKlIk29c1pv9Bcvu240yHkDzcAUMjUk/1rSsazkINWXHY3kpQPFJVKs1FdSUAL32aXFJeoEotSvXyqHyL6lyrG4QpEk5TvPH+kp5dREX63ti3km3VoWuglMJN51JryxQTAsbWRq+WtCHpJ7BblPbTQnG/Mgi8co5voCe5u+hDK78YP1E38k2mGt1lpNQlNJ7mAKyY1EutEyZVr+GZOvdor9ydzw8ng5NgK8mBU4dJrqGV1weQB8ylcHeCrfARPK5s8GsegiUyYAKHOcmaC03LGE7dH/tPzhQGr01Xqq0jyAm9AGswcLwI5Sn5ge0ufcNJlEMgEsRudkRjQhE5u9iDUa1Nw+vkbDfVejPS3B5G3HjHq/V6KmMcy0FS7VD4f+BPStSuGDu/UX0vySWsfQf82H9M4EfHoRBXz2I7svbfLqZU858yz77H5o6ueJli6PQzjqLgHnyatccvUAvgpNByphZfkGUjCH41JeNEAXCzoZkCRYr4XwyaK6TKsCR9VGrnQihLPHR3oANRYbzloi9DgP/txrkMLhyakPURbuxPBe7L0b2NqJkVYvh20citRvQAaV+HG11d9XJ5JihgPEiexcLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(1076003)(6512007)(26005)(186003)(316002)(38100700002)(966005)(6486002)(54906003)(36756003)(478600001)(6916009)(86362001)(8676002)(6666004)(2616005)(6506007)(83380400001)(5660300002)(7416002)(4326008)(8936002)(66556008)(66946007)(66476007)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mV69WClHeSHKeompTT7j5o0kNRSPQc+628wN0IeejatTLKj8IOUo44JOpsnF?=
 =?us-ascii?Q?mn9QIJLkc4zeHhDY6ck9aWMAz55/tiLkMVfFDVllMtHLF0KhyG6FL36RK+tH?=
 =?us-ascii?Q?7bcXmalLsnvQw8+OTV+v+LsR22bPO7GYp6UportTsO+L+maBm3VxJcr8XJuv?=
 =?us-ascii?Q?zv+HWaAvxjBtIqTWI3B+SB6ZA19r4RoDDi89XS0xOKu29OLXBEs6X/5yCU+u?=
 =?us-ascii?Q?mRM1VJUVImOm3i5MmBlnKM86hKNpMXQU5kfJammS7qgefDsBjjv2uQTE990u?=
 =?us-ascii?Q?iS50899nDztH4ndvH3G37kCxG8NZL2SdpKbV6u3BCvXYrlxxTt/gIv+KzlVi?=
 =?us-ascii?Q?gIAfOfnpQjcZbBjRCZP8lDgwTK2vUZ/Pt7ru8Ac1upv7Tztmyhx11dA9nW1z?=
 =?us-ascii?Q?LaOg096IKETSDMtqTqvwYPCoA3eeazuA7YZ7ot0sgUDd5W/TcUXysY5XxOzE?=
 =?us-ascii?Q?gTTZtkmfaOlp7t8Zy6Uvc/om0dnxr0oXmoxufD/onTf6gdlxAWW5QVhqrqM7?=
 =?us-ascii?Q?HeRuwgKT/ZffwEZ30/SZNXU25vfwixXcUF9DARC0w1gzJBbsk1CYx20Pfu+m?=
 =?us-ascii?Q?QRCZWKI1I9nvh3oGSlPrxdPL7MEHnojAoYVuUmpt092yYZ4MPUyzaGIq7DTw?=
 =?us-ascii?Q?akl9/dyYQ9jAZ1WVAnFXhV4JumpVAYNbTCYZVGDcbBPB3ZfB4m1OI5w2W8cP?=
 =?us-ascii?Q?AZKndoJ4kjyYzi4iB+IbrhC9XvKb3mYMc/343j8TyLypK17fvmxSRXQktTIF?=
 =?us-ascii?Q?4odWIU31B8heAe7l77iq/cVxPJ7iyYeQK6C93nM46YvuN0K7oYRZ/H7J0Dj1?=
 =?us-ascii?Q?fwrT0HNEwnUrQxt8Dghogtg3oH7Nj/3mY1qGAIDuEOtRwyK+MKwiPI8k/ggz?=
 =?us-ascii?Q?J+BFcmO0D7nWlqZGJrv7Ndtt+qTCTr7AzdkRAH1mhLDahKGpvWgDxMBkcYgS?=
 =?us-ascii?Q?Y08vLZcc8THxwleYyhyk0N0+dpR3Dg4F9lU9o8i4Qb7/CHrJJUoz4WpBJV6I?=
 =?us-ascii?Q?e7tDObeLB4H2fcrQNtjSea+5TOPJS49vnUoQrswFnTEkbj0Ey0Fnn1FMKHBB?=
 =?us-ascii?Q?YLdA5Hwifn0R8XeZyE7gkRfuJ1r3vHUq+pbjYIEE4DtxBgnXXPbKI+xQVfB2?=
 =?us-ascii?Q?bt1npntjmj02IjQXjg/tZo3i8EH8wjS112uIg5unS6b7zlX7Nv/GmljP/9AX?=
 =?us-ascii?Q?UgZWaKTpf8htPgdwgTsatu3f+EAyx0CrT9MWwwhdpcblbnTq/48l8Y9XEVQ3?=
 =?us-ascii?Q?VQVxeu3Gfn+uNGVqshyy1nm7/MExJ+RlyWsdMlYWAGPlr8rHTAXzjfdYMy17?=
 =?us-ascii?Q?8vM06tWUA8dpW1mwJMaX8DTc0kCN5uU8awBOkBvjF+A4FW2KGhK8Hsk17x+W?=
 =?us-ascii?Q?9GFqEDPdFoQmpxjwK30CGhtL4WhjcgQ67GtCuMXsrZnvjwPFWsw7PVU7TOpm?=
 =?us-ascii?Q?1S3hVG/kn0S7gp30OJxSqr5VrrvSfOFAQRcnNmhfBRyyc/nOFFH5sMbWeyxo?=
 =?us-ascii?Q?X4NLet/jr6RXEICcem2OPQE113n0QCcGQwIVMrQZopLZxVj+0oQJSgYabqAv?=
 =?us-ascii?Q?HApH7TsFkgnLBwuA/CK+asHnWiacHtOIIhiF+skr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae65e29-e60e-49d6-da12-08daabf8dadf
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 02:24:14.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Zg30m+I5RL4BkfvlD9Et2ykEfiaDx0l1Q3Paulh5NVaAKZXbeimloHt5aOOSFaaDRHh71KxsX6TuGv80c9lzQ==
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
the section header count. Where as libelf implemented an extra logic
that, when e_shnum == 0 && e_shoff != 0, will use sh_size member of the
initial section header as the real section header count (part of ELF
spec to accommodate situation where section header counter is larger
than SHN_LORESERVE).

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
 tools/lib/bpf/libbpf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 184ce1684dcd..2e8ac13de6a0 100644
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
@@ -3312,10 +3312,15 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 	Elf64_Shdr *sh;

 	/* ELF section indices are 0-based, but sec #0 is special "invalid"
-	 * section. e_shnum does include sec #0, so e_shnum is the necessary
-	 * size of an array to keep all the sections.
+	 * section. Since section count retrieved by elf_getshdrnum() does
+	 * include sec #0, it is already the necessary size of an array to keep
+	 * all the sections.
 	 */
-	obj->efile.sec_cnt = obj->efile.ehdr->e_shnum;
+	if (elf_getshdrnum(obj->efile.elf, &obj->efile.sec_cnt)) {
+		pr_warn("elf: failed to get the number of sections for %s: %s\n",
+			obj->path, elf_errmsg(-1));
+		return -LIBBPF_ERRNO__FORMAT;
+	}
 	obj->efile.secs = calloc(obj->efile.sec_cnt, sizeof(*obj->efile.secs));
 	if (!obj->efile.secs)
 		return -ENOMEM;
--
2.37.3

