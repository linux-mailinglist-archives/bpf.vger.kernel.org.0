Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D305710B2
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 05:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiGLDQc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 23:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGLDQb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 23:16:31 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2044.outbound.protection.outlook.com [40.92.99.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FF42DA94;
        Mon, 11 Jul 2022 20:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRlJQx+Iq1jG6iZ3aykvccQJfN/8kx/o5iZypX7QbkooLV4PPEi8plE4lGBsOhGH36i85U5sm9kDjDs++TMhZ3ve2GfS/lNeDXvcpkJamiao0DYaQnFwwKNSUR10yDHUK9B+P2caN8vSvsvlGtEKDnSpt/Mxz6YX3xYPZjTX+xtD08NFng2BEnTfLOEAoCz+JecuuKjss4xUpah4bXkfnoeSgPhFZJeGQyYAbNrvCM14fpXqQeGmc4xiKD13BWsPxb/99ATcs+AVmOMaHy1PebY6xhYK4GT7BA3sV3CAlrcXixp8kMHrRWldevOjjYZH35V1ITJEAYA5n5Qs7aFpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viDxE8fxSZ+cQQKLavv/Z3/OP/pBesfqXVmgHlCRMbw=;
 b=O/mwRvRX/wMscrdvKD+dPM6XGI+5nFR3NCs9JaR/5Rfc0WHEAsDOFiqAJY1jIg0EAHA7/Q3eI8XKxjle5Oj50TFK+VA/BBbrNluAsEGBCLiDPV2EwOIiF8YYpRUfanMyy5DmxQmuBBnHz1YYypLxgEvJBxok7AGPo2YHiHkX4y3Jjz3HEjLPiHmRiIHnGmWnZMpoteopjvgCpSkRldIGXuFfxw1S2gXYhMeDyi57bcrMpj97CoBEkGg8iQXQYjkZw2Re7Au04S3ggGgc1AWMbuK4QqFLXKpSYVDNrkHlNsLTcQKisFpEll+THFXJsE+noPlOLu1DQ7p/1oPurxKlLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viDxE8fxSZ+cQQKLavv/Z3/OP/pBesfqXVmgHlCRMbw=;
 b=ZlxqK5NKnSizGJsk4i6suWkF6oKxqTMJEat0FX4AOgES5TWuaQp7JM21sD7odC5Tshxo3sXL8orjo89A4f+54TsFPwNFsWxd8p/QQ33LJj6YAG65LqVK5B93om2xd0AfiG7jcENzyyYUn0YUrWdtud9rbzhXfb9zEZKg54MXSVcghd55O+2zG4g9Axa6zq4EUHcgpUfpIBq4LQxWKzQzHYXXYLABNWTcvz9HyP4t4PYlsOi7Uy0m0mWqjTNfcfI7IDV698TojJ8WL+xhVBRbOauDVzR0DOaUsTTyXa7m8KSKTRFAa6tWhpoHeRU51dNF9WRQR79VJ/dY176TQFWDmg==
Received: from OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b9::12)
 by TYAP286MB0697.JPNP286.PROD.OUTLOOK.COM (2603:1096:402:3a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Tue, 12 Jul
 2022 03:16:27 +0000
Received: from OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5999:44e0:89f9:487d]) by OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5999:44e0:89f9:487d%9]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 03:16:27 +0000
From:   Anquan Wu <leiqi96@hotmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anquan Wu <leiqi96@hotmail.com>
Subject: [PATCH v2] libbpf: fix the name of a reused map
Date:   Tue, 12 Jul 2022 11:15:40 +0800
Message-ID: <OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [/zrxoIPZWVaCEsqJgCnTCFTMY+A6FT62]
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1b9::12)
X-Microsoft-Original-Message-ID: <20220712031540.3277051-1-leiqi96@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4660b69f-4ec8-4103-62c8-08da63b4e819
X-MS-Exchange-SLBlob-MailProps: KBSGuA5p8vC4gFkNvkq3vRp8K5DObyap/cOkj6CUVC74IgXJKZx8ABpJTtTsbeJSqQDf3DfgZxUxFj5E+rhD3HHAThzGhHzT7sRKb8BKktQjmPNAhg8Xn6ADEtbuiX1gjGb8AZWRG5oW62d/oZwn3+5gZMwl8ZcbA/Y2gnIoPBMxWu8Lama7KV/W9VN8N5Nzi61YOq9qALrqSLRn7tHT4FOd3Arhh0NE8Zt1+SH59qJCj+0e28Uw1gsCxBN/pBfU5lqF95xXiE7HFWZjPnGacvSziCf0eGkmMYorqO7ZH41P/yW17fexxLSsar+yMFi6fQ0jqLAIhegJjQfcjIz3FIXIbgzSYoO9RD1vpJHlA1Sw7BgRJDW3xg/8zaUWgjv3gkGmbmPKEIolRDiS6W7zNFJrQ+MXnawgG56ZCx43sigvRNqGkoBiXS60yNUIk1DGjI5Y0lvp1z+eJosHH5wddHf2SeKsjzdBDrzT7iov9L8SnMc8cKmAhwSpJ7IFG6CXopArkayB1k/9Q4xwejiHznX9m05t7IGX514Fh9jrSFgGORxk3uaItpwCUS2Qa4Mxiw6PLAgkN92+oqAjJs6qSoNgob9xNBjVa0qQdh1ysWSUjBxad8orRpWFhqRxRwyic3UNyLdigFDCTxyOmKYK4xJ30r5c88PvZGd1PqNQ1NOCIyoJxPvcLWGLYSsmBAdfY97PvkQ2aW9rywZDK8Gi98zGwBRvCzPkZybq//0WyyNBv0QcexdA4E0YvV2idFBSEKtXJkCz3D8sehv3vx8lJUg427nvst+mVMDSjckplzI=
X-MS-TrafficTypeDiagnostic: TYAP286MB0697:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wie8YqohoDf3Bxn/wMo656v9mZ4PybnYKg992okUFjFUyc/MJOhf5m8StSMlV44AF543dly+PbJVxc6b6EoAebCVQLC69YhWIWt69s/z6/5JUNubHna9nPM/QqEWVyj2l6cYB5o2K5KfZj7QN5q9MWcpp+PyT9KO7sKe2JZZP3rs1+pI9agyhHX0NWt+3H2WVAOMK7BBsSLBK4sxGomNUaHrXIwz2OTyXeHP0gQolOYuEb9b8zoLzgIRIag/dmKOZGoJPE6XGz0AtQSfiCnWDSvVla209GtS56dj+C13f7tTogC2/Zt6rUpyGyzQiddfs2iOQzbeQjKVF37xfUQOfxfFskmW+DRAwBc7+xxLCReAagvZ3vhWcnwrxkPhLcNNuI1Y4p1QxZG8yb78P0ifN3MGwfd2HfiEMDTkKcIwDsuW6ngM72+9eQ2rNytKCX7/atpm+FAmdZ4ExwkFJvrIDoD7+gCP9h+rZlWtI6p/aF92SdYIqvJltd3CJjw/SU/EnyPdnihPeXW2qgvS9z5+V4sxQV5oOGILegvZAYk/kDwpMi04bjRc8umc36Jz5vjsozTanlG6qp+bKvhF5xlatS1C7T1e4PT9I9pZjxGFstqZS4KEhMJRvfdNEIzJM8rxYx6AsCbFIXCVkQ/4qoMqt9FfmKCWXp4/1tWqzdyI40JtG0Lpe8RfAwiQ/tRLvh7p
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzRxRFJSbHlrMlVxUG96Z2Z4MUhXN0NmUmh0WnlTazRDSmpCMkFNenJqc0h0?=
 =?utf-8?B?eGdxbDhXMmZKSHJQS29yZEY5cmJPUG93TDVHd29aMGtRaWREc2I0M0toNzU3?=
 =?utf-8?B?bXFwTzJXZmxBUysxTjBUSHZvWGRjdnJtd0VmWHZUV3JmVHd5UkZvN1N1OXZw?=
 =?utf-8?B?ZjV4cUFwYkhrT3FvSkoyZndVLzhMVkF1eURGU0M3RW5CalRGMVlYT2J6SjZs?=
 =?utf-8?B?NGcyNUg3eU10bUg4eTlCQjhRdCtaZ0t3bW9odU5Ed24xZ2dyOEZHa0Y2TVJC?=
 =?utf-8?B?cVN0ZWt1Um1NdWtFYU8vdFliRVhON0tYZFRKRnZTZHd3b0ZpRG5keDM3ZTJW?=
 =?utf-8?B?SWNGd0FMMENpdXdQdllrKzlDMXVIMDREamFnamhtbUM2NCtGSVNCbWZWc0x5?=
 =?utf-8?B?bUdFOEFRZm9seVpER3ExaTJDWTF3Y1hPSElXNE5CN2tnd0VWb2h3WWU1K2xq?=
 =?utf-8?B?K2ZYdnRFNDZ6SWJJdUNMdm9FT3Q5YzkwMXFoZ0t1WHc1VXlmZVcvelJscmZY?=
 =?utf-8?B?MlY1TWpVUmZxSy9NNzZ0N2pkRk1DWjVRcE9MUUhFRU9jWkhZQ0xrM0FzMXYx?=
 =?utf-8?B?b2tkV2RzLzV1NjIrVFFMelRjVEhuM283d2ljUVEzTnZ0K1owNzl5cXU5Z1lx?=
 =?utf-8?B?WElya2luR1prYkVEZS9DZm1XSjhpMVAyY1R1MEtxOWlHZmloNFVLdVNDRkhT?=
 =?utf-8?B?Q3FhWkh2V2dhUGZpS3g3RXU1UTB5a3c0UWZibDFCemlwcVA1akdpQ05QN3Jz?=
 =?utf-8?B?VXhXeHJvQnFBMGNZYzdpRUJIVUxmckh6b0ZSZHNQZGNoMndSYVRDeGsreWJh?=
 =?utf-8?B?d3VOUk5pbUgwcEJHMkxkVkh4QmhUeGs2bTM2WVNDRnVoZXNnTURnUUFyaFpQ?=
 =?utf-8?B?Wi9FY2lSM2FKT0gvQnMvcEZVZEtlMUI1Q1FSa1hST01sZXpiSUd6MmVYRURU?=
 =?utf-8?B?S1JDUGxMb2hiQXRobWR6QVBhU1NLeHlmdHhRNitQenVnRDdFc3h0bjFza1Nn?=
 =?utf-8?B?VUFFVldTUWhJTFZ3MnJxdWNZeVduZkVIZ09JVG9LNDdMM0k5SmN5NDBOZmwr?=
 =?utf-8?B?eG9BVC9RRFpNRm9BSHg5T0VCSW84Zlo2QVdDOXpOTTMyYkhmb0o0ZzRLcThy?=
 =?utf-8?B?ejloVXhGTzFrSEdaZjROdXZCdWVFaGkwOWRpaFBPVzdRU2pvSGxsa0NuN3FI?=
 =?utf-8?B?UVVUSEt1THlGR0pTUTBoM0dDdldjZWt1RFZXRGl5Ym4xQWdnQXhaQ3cyaWIr?=
 =?utf-8?B?R3lzMXo5SmtaYkRmL2dsR1dsSGdwYms0MHBoZ2NYTHR4Yk5NcFFZTEtyNWdZ?=
 =?utf-8?B?NnVRNU1HaElWd1A3M3ZKTFd6TWJPUitKalduWEUvYkF2a3dCaXZ3RXNUd2NB?=
 =?utf-8?B?amcwaFBvUCtNNWQ2MGNyaEd3U2VBUzgvRkNxU2x5RHljZ0RaNENsdWZsSjBm?=
 =?utf-8?B?aGltK3F6Q0dCMEN6V2hXdHhNWFFGTEJLcFRHeDhybnVNQ3VlMVhQbEJzSUpi?=
 =?utf-8?B?c1p4cDJvWVBLRWlJU2ZCV3ErejMxSEFuMEk5QmppVERvSmxObjd3bE1xd2Fu?=
 =?utf-8?B?SFZtQ3ZucFN6Z3lwSFNIS1VlUTdsaWRtM1FCNHhST3BMTlY3SFpKMHlLcmtK?=
 =?utf-8?B?S01QSlMveDBDY2laYlg0QklEQW9uaTR6TW5LVjJYdlBNZGsreXMxTXQxQjJn?=
 =?utf-8?B?dXdiWXoxRG15SlFxeE4zOE5VUFJMMitFTHU5T1N0YTVTZWY3MUhmaDhnPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4660b69f-4ec8-4103-62c8-08da63b4e819
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 03:16:27.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAP286MB0697
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF map name is limited to BPF_OBJ_NAME_LEN.
A map name is defined as being longer than BPF_OBJ_NAME_LEN,
it will be truncated to BPF_OBJ_NAME_LEN when a userspace program
calls libbpf to create the map. A pinned map also generates a path
in the /sys. If the previous program wanted to reuse the map，
it can not get bpf_map by name, because the name of the map is only
partially the same as the name which get from pinned path.

The syscall information below show that map name "process_pinned_map"
is truncated to "process_pinned_".

    bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/process_pinned_map",
    bpf_fd=0, file_flags=0}, 144) = -1 ENOENT (No such file or directory)

    bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4,
    value_size=4,max_entries=1024, map_flags=0, inner_map_fd=0,
    map_name="process_pinned_",map_ifindex=0, btf_fd=3, btf_key_type_id=6,
    btf_value_type_id=10,btf_vmlinux_value_type_id=0}, 72) = 4

This patch check that if the name of pinned map are the same as the
actual name for the first (BPF_OBJ_NAME_LEN - 1),
bpf map still uses the name which is included in bpf object.

Signed-off-by: Anquan Wu <leiqi96@hotmail.com>
---

v2: compare against zero explicitly

v1: https://lore.kernel.org/linux-kernel/OSZP286MB1725A2361FA2EE8432C4D5F4B8879@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM/
---
 tools/lib/bpf/libbpf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e89cc9c885b3..7b4d3604dfb4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4328,6 +4328,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 {
 	struct bpf_map_info info = {};
 	__u32 len = sizeof(info);
+	__u32 name_len;
 	int new_fd, err;
 	char *new_name;
 
@@ -4337,7 +4338,12 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 	if (err)
 		return libbpf_err(err);
 
-	new_name = strdup(info.name);
+	name_len = strlen(info.name);
+	if (name_len == BPF_OBJ_NAME_LEN - 1 && strncmp(map->name, info.name, name_len) == 0)
+		new_name = strdup(map->name);
+	else
+		new_name = strdup(info.name);
+
 	if (!new_name)
 		return libbpf_err(-errno);
 
-- 
2.32.0

