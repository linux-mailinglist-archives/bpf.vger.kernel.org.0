Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA695E9903
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 07:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiIZFyB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 01:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIZFyA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 01:54:00 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2174.outbound.protection.outlook.com [40.92.63.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F96222B5
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 22:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a96kc4uchasaj8JBToQfR6K3I2N9DYndeKTXB0f9BoTlhlpI1XJMexJgNPUJ096Wp4lUvr9zPznPiyqO4rh/WJOJmkqeCkh097ZR2LW44VrGSJRabWrqkDZ/leehPMBISrAwg4niGIq6gZxZRzGk59CKjv1xjaepd1FPsltgxZaSMt6UiJj77IIP0EKdWqRoLjp38xWQk0yEpV0BzdHpeD/lkAjGhebYcCo7etopEwm6idzDvLRsWDXebNt7Z3+rw3U6FbCVxlO3oG58UO+91kKcbUJmGnYBrIaqckewGVuUhO3IFfIx90sApUPJIwVE7PiN1VLSrelwjxrd9/gN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8sbbyi+GmhQfBKTowlwm24/MVC3bPhK/HlpliuyC/M=;
 b=WBRK+HAdmyRkHMYmNX6VhCps5Iiln4M85pUy0BRr+JCheOJeCuJSjHwdsFKCXDaPwwv40Hr2DmRhJRLpd3zG90HVH1fYYiitPstSQHloCFkDWui8QE2I4jK2ZPqN7xuY8qyBe6Ww6kMfOuVJyXeTX2Vl5p3toJ8RbAwoHVtxjES6MQ8q3XGNiyM9RuZFrv5056A7OfGGuMM+KEhvw9Qd6RGqARQy1U4fSJ7TTmDOOuMbmLCyPW0L1Obyzpi3MORRo+gG73yEs24igClU/5MSNw8wVOJOzzhuDfsEIEuE6sN+PbLCbVS1FKO9nMmNai6358U22yheJgNFpDhFl0rPIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8sbbyi+GmhQfBKTowlwm24/MVC3bPhK/HlpliuyC/M=;
 b=uzcyW/M7jSZQcCQuzT4dB+oyA59FcVJJN2jyEvfJAWdWFXN0iTcjue+LRrvw2tZ2zUgAVgn7Q+BAXH/clK746E4Xb2F2tOzdxa4kuensN93pOu9J48nk1RDUwE/xviRKDJfh6krdZdOgqsHOI34ytufpHLyu0hHzksyIG5DnpWKtLQKKCBiLiwIKqmLwMTOOoTXwFUpf04N3lSdDYidU5QBVLtNnKYUeQJOOjW12XBQo++69SZjJMJPqxfTplQcKk4wuHaxU0szhalzcAXzgCBjubeHuhqJomu8iE7mxcVwWOwjh6a3jdR8NTKo/CzKzmqKNkDJ7b9i1hGLLFdsDfA==
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ac::13) by
 SYBP282MB0219.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:64::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.22; Mon, 26 Sep 2022 05:53:55 +0000
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::549a:65d7:eae8:3983]) by SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::549a:65d7:eae8:3983%7]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 05:53:55 +0000
From:   Tianyi Liu <i.pear@outlook.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, trivial@kernel.org,
        Tianyi Liu <i.pear@outlook.com>
Subject: [PATCH] libbpf: Add friendly error prompt for missing .BTF section
Date:   Mon, 26 Sep 2022 13:53:16 +0800
Message-ID: <SY4P282MB1084C694AB3F6C2DD3DD3A379D529@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [dJrkSN0qj7TrcdPVAftlRYUIqcNgoHjzNMxfrLK/2ONAamC8qL+gjA==]
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:ac::13)
X-Microsoft-Original-Message-ID: <20220926055316.2411573-1-i.pear@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1084:EE_|SYBP282MB0219:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddc1bad-b817-4110-32fc-08da9f837f06
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3kzD6Up0rDzZ8UqTTLWxQanAYElf40bL0Uw++QjI1YBu6kI/fD646wq2WU0aKpS1AnxbnK1+Rlxm4H3sau3Uuy6tE6Z4F3fplUuIELC4zvHqcxlpDoh5gOODjtDjRpTYaWSfr2nVaQz+T/82/M3HmyCJKqWCJ5idewm4VOmgDIJSnowWtK0iHsXTrzwKgtsY0cRDHjFrV0UBQ2Rt6UsBckmjGZOWGMCwG/8szHInTAV08eIy21NpkPNOWWb/rLj3CoC1ZsKUN6WXJy5kUCJlwBZUJl+mb+l/LSSgOYgfWEatLYie75Q0rY51AuOM+3XlSqKkh3owG7oPwQHKaMAq3CuoxOitnCd9dAY9lPXlP9c59jrNPwfjgVdb6+knwzwoMyjwEbBo8pEpDZT98y4ZEeFKBqjDJGpD6WYW5CWExmGl4SzdCahpdUEJ3N+jkWNZZPv6kJLHZ4SG77WxaFvPd4SK7iiqO5SMQbcAvDTpxqgMvfWaoOLiU9NFJ48puIvtWZT772WWIh/8tuNhCFbn24AlA582pKPh9YL4kKr/vGJR3tRqIMjbHtNqlYCCCv9jtHYgktkXwourQulFsThOI2aSBMYnTdyzrBqJ1UD0nObtFXi+g0T5mTypIPZ5F+2oDE8YK8h+IeHrZ9lLZKGERm/Yi89bLLTvbUmGkXco07Y881mqNjhQYqa1p2ssTbzfqRVKfbps9wi/oiicxiTe1xQPArYENJZrPq3XLqsHYvyFDXjpHlBJ/C3KCO9GP29ESA+vHkLcFlS2jTT2t4/c2W7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFGxOuc6CkZV1+jMJFPWkMaRUFyfDgvWQiiGA18D+QNAfHMth3rSGNxy/LnfmNK2uscJwhCFWziZ2AG3RMx0ADOvmTdzbYBqyoLW47slU4vhq6MxosH7CCQw3/97ZuMJAPHvroUzgIQ/knm+XvpoqjmjB5fApGXzmQJky57ffTbN1EClISss+1/B+LVXRf0jTXqu7KWYZRgUhBtmP6Q2vArZZePSdeAyKUVDWraK9KiK3zO7rN1u/1g8zjjaIPP9SZe5Yd5TjUcySZEoG/ZKTwnL6ktmaQBCT5ImwN1OfVQttA0I3+bwMK+5HINqKMs0T3GGsJ/PxpanYc09OF6W9P4c/0S/I06zkaISfvHkmHjsqr49vDqN8wvEFak6Rx3nA1K4myDpeF59JW5/ZeJc3z36gGaUG1KI0FPFRRaefb1Lg3svVa/blkyuotjAiDs0C2lJQgwuTFsvvEPEx4dAsKdUUPI4Pay6NoPGzCLYLenlUOvSbb1/pHps72yzXir6ySKs3hXnVM35/nsUv0jAvkzlTWcWCEXTeIeeNaFXel6r+tGBV2bf1pQvRfYD1qPAgBDIAKbp1CRszQDOTqaj4pFo7FzWrBbYn24FmGEfXk//OCV2V+fYg0f1jj58gSodOkj6311i2/6k1g25iVe8Lw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sAYtn2mDOu09aCviMssAo5PdhBYriOTVyyqB+phGSeAM5pEUv6vbvAyUQ7V3?=
 =?us-ascii?Q?ILxd/KdQuBCakjzhVLiPeQWHL2wgsYA/Z4R1Irxm0ygkimrU0fmJFN7wyBUx?=
 =?us-ascii?Q?hTW034Nmcx4B/UOM/PHOQJQy8ZFuqglJ6Mqj1ukjL/ZI+ZJaYypPdLkFY6W/?=
 =?us-ascii?Q?VTCW8bX+nocI0mhVJjODqxxBeKoPxYkHY14iwxS8C764xg0v6KGjFS6Y8MJs?=
 =?us-ascii?Q?QcfYkcU7l+CrtLWqwUrilEOZMhtd9OidpNiCQkROf2fjn2MEtyDO4/JfZ9sZ?=
 =?us-ascii?Q?B1QBLGt1e6tvmcJJMp+GmXs8JVtyz1+1PPn33IkNKXM4i98vHE0hOcBMDQgx?=
 =?us-ascii?Q?oK/q7VgDGWsO6SrwFq5KpPPgTu7mT+x7HmF9MsermeBIICODF47PFi/zQnro?=
 =?us-ascii?Q?tLFjSTFUup3b90FpLnLJt2EkPUOo9e0gMiHWBZveLLLggH8Ph5tgq2ggnBsv?=
 =?us-ascii?Q?RFMhLhhv0Q4o0vmi0Qh4Y9S76OGCjtpkU2ki18EGaQtbOwF5sgmLrkPVxNZO?=
 =?us-ascii?Q?7uOzDvu4uRWWmL+eG3ECBKm3nZTBSo0hNyLIfTu4Gc30rNbookWbho0CQngE?=
 =?us-ascii?Q?Qb/Pij6zzyVNVfr5eVr7Cz45Z3iyWT7+M6Dsx7Pwpu4No7BMRUbBaf2vhPy8?=
 =?us-ascii?Q?ZaaKYzdr0yZFxjkCbbnGVCNvvjukhbcTbbjALR4o0u/5a5miUZGkiTDiHeaT?=
 =?us-ascii?Q?nPjgVHqnqgFIOQ5NueU2yCaii8IudmwYlBgyNmvKFpjCENkpsBHkF6Z0kVAi?=
 =?us-ascii?Q?e9ND4iXNARMDhwIam29APeIZTk9vX8YV02IycOCUQo94sKkQBKoBhDbdFt4s?=
 =?us-ascii?Q?CTRy6omh0ogAiiBhSWKTRi+dhkYfoyTLIZ+k11+9shTDwTHPBqa3REuAR0Uw?=
 =?us-ascii?Q?RwQyGiJb+cuXC0ut8LIfnWTAxd7RBZIbN5jh8vtvlxCEKOaJWYDBLA940xFx?=
 =?us-ascii?Q?z8oUpqh05ooLy7TFV++dTsOsH2kS0BhsWH3nVF03MMSChrOH3M3mwftxtfGO?=
 =?us-ascii?Q?eppueyjkpFhOwHqtdtE/pfie6HQseDNIULmsnVKKLx9xjKddK2jkPweUNfzo?=
 =?us-ascii?Q?SiRKMJGmAiLCB5wxNv2+Sd4yVhZDWvh6kpa8kmiCxdEaI8Oc5wLnKXQ1GPjv?=
 =?us-ascii?Q?CZxXZNbGN/lqJ3dS7ZByBarcHXWkGP9gNIlT15NG3oQnATosWDdOsXBuawOO?=
 =?us-ascii?Q?DJR9Vk1Knb5N2F4zH4V2O7JwbBptVEh5MXG/vv0h2jFwSxrv6OzOSoMiYe1f?=
 =?us-ascii?Q?AKBRUcCGxz8ETmzEX+hNDvaNL/SxRTIJA/dzbRd/2uTg5rAok7Ggj0R9HOwb?=
 =?us-ascii?Q?2b8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddc1bad-b817-4110-32fc-08da9f837f06
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 05:53:55.1209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB0219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fresh users usually forget to turn on BTF generating flags compiling
kernels, and will receive a confusing error "No such file or directory"
(from return value ENOENT) with command "bpftool btf dump file vmlinux".

Hope this can help them find the mistake.

Signed-off-by: Tianyi Liu <i.pear@outlook.com>
---
 tools/lib/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d14f1a52..9fbae1f3d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -990,6 +990,8 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 	err = 0;
 
 	if (!btf_data) {
+		pr_warn("Failed to get section %s from ELF %s, check CONFIG_DEBUG_INFO_BTF if compiling kernel\n",
+			BTF_ELF_SEC, path);
 		err = -ENOENT;
 		goto done;
 	}
-- 
2.37.3

