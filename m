Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4089F5F7C9F
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 19:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJGR7C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 13:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJGR7C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 13:59:02 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075040.outbound.protection.outlook.com [40.92.75.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534489E0FE;
        Fri,  7 Oct 2022 10:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0vII5iDCs2n3yJDXRYqAnTwO9GSB3yJQkUtrcURHoM8d3IB+sX1rZ/N+V5Nmr7lNSUzZQmnnrBPk36G/MCBjvldWBA8YwhxzVf6iFmcFwb7G7vfHDphD0fxXO0HYlGv+Wxk+RuyWa/Yc19n4nzjfFGoZ3rctXfCRgyCLT9qMx3MTzUwIXYRrVrkbBEl8jzf9R5n7ZOpf+FGfFqtqoxtBAcb9eBqG9QgPsq2YOepBV9ZypbN8M7NqSWbWg2NyfHDCpxs6X+lvKw32l2kark8Grx1u2ElJI4cf8T6MWAXONCESPaxIbBzDWEqeFQoNoV41RB9vOKleDdJXbaUSBAjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yblowbd5Zuaa4vQ+Zif7he3ubH8X67C9idAQOZVm1M=;
 b=iY0fq3WvSD9rKKQ/dBe8/1QjLiTK960caq3grZ29Ul+fG1FmjWLRepN1IPvZE4mlYFCLCsSWLuurKKlIaHa7hNUyFPJgIxsm3WrbSP75ko1R7NSkZ1L5Fcl4/aTiSSGF7eq1pm5/IA4iLCXuKtg+AmnVES903QmkyR6WgLL7Zk9HxX9lOBwBX8TDsaU9UcTajtZ4YJr71tGq5jyY5QUI7rGSG+9n5AQ3cuOe5AO01/dqQazNzU75O1/iCQDa8fTCMofJ0o8kBNEjg4kagOtbeKW0bQ9f0kZRDFxUuOIJ/iGTKj65LbCwR2+3aUGCRfl2B+5kIBaZZ/FO2gyVw0HFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yblowbd5Zuaa4vQ+Zif7he3ubH8X67C9idAQOZVm1M=;
 b=TaOlCURIFQYeicLPBnm2vEO5mNNT72IMb+e2P1EoKXT4bKS9plVrUGD4e1cKidhxpnRussDIzdpA259sZMBQz10NkT+VR6wU1haFXSLGtHoj/YD0hNwtQe5QBRY/Ub4SWpcpuAkiUElodKnkFc6YjMcQXquGJxmp5mM0PixHsxF9l8QSJrnRCIBitbdsJvNr1xGE74e51EuSJCmUcw4YHdIiuM7pebQhJFc7PghaG0fOZ2sJm03anmegRVEES/DXNSBsKurk6JTas169KucJi2kEgs5NYboNigGVW3uCMNJfLxtiyPzQmkATavD2Fkw/O1l9GtdhdUAF7Lm8Om0mpA==
Received: from DU0P192MB1547.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34b::15)
 by DU0P192MB1973.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:40f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 17:58:55 +0000
Received: from DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 ([fe80::3f9c:e469:df81:a8c]) by DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 ([fe80::3f9c:e469:df81:a8c%7]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 17:58:55 +0000
From:   Rongfeng Ji <SikoJobs@outlook.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, joannelkoong@gmail.com,
        kuifeng@fb.com, maximmi@nvidia.com, quentin@isovalent.com
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rongfeng Ji <SikoJobs@outlook.com>
Subject: [PATCH] bpf: Add SO_REUSEPORT to bpf_{g,s}etsockopt documentation
Date:   Sat,  8 Oct 2022 01:55:27 +0800
Message-ID: <DU0P192MB15474ECC548CE7103DCE65FBD65F9@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [BzbPVww4seePhmhnJ95z0mZaXmqkvYo7]
X-ClientProxiedBy: SJ0PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::25) To DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:34b::15)
X-Microsoft-Original-Message-ID: <20221007175527.3598-1-SikoJobs@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0P192MB1547:EE_|DU0P192MB1973:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce1f44e-3a46-4417-c3ee-08daa88d99a7
X-MS-Exchange-SLBlob-MailProps: mGbhpWj/ezqIhG3IsDqY105x3GR9xChsl0L/L4CntpCG+piFhZZJBPc9skfbMtx+Ey67HxAXdJQNGkv657eaZcK+hhuxrvsClrbQrxjC11AqF9vuVbq7gX6HiPFW51c1VNjtLi8bAnmhzT4Q/AkrR6NPFX3LUKONDAQZTf2+jGlhe2fh1h/GCRDEKWhiSDOsrzwE0L84wQ9rY5/TSB0HK4XyYp0h/H8vvi4bl9nUGm/xsAJ57SVNvGdLrQBWYUTTmH3JNeOB0FKy8wKpMM1xrpP24/VCG7zM0iQYK7VaeXCXcn93PIGihGYJi1sqS+NwqRrXNGdA2x0CBuUVmNCZTayGYUXHnrALxYd/prqFuyQVYgtyBOlAUlPkhaVEOL4tObmyRPivtEFIlnibmRz5aPFLMqOdbySY81WHK7IUqB4sdYd+xTL+/x+iyweNzBX7GzMGXP22PPmmRp+gXHclOy0f2n8VKY0MqHPgdjtLNN6eAAYy27rlMdrA1p567vKS2VGfjIKaekbTj4IdmM4hdXNyAg/UGW4YeZn9ZDzLhKUYybleHtDWOjXXgrbUAZbE3YKHC6Xr3LkU9OecY3YQWzc4w7X3JzdczDei73t4DIBZh1VvI2GTlY846RCOmg5lcff9P+qrvgbMHu/QtbLO2G1Mf8pAV2NyvwcNj6IhFILN/BGKJoeBGVjHTCJz72SjfXdMb8+1bCwdyz/uGZYzliQ8BWYKb3HxnujitSbjyFFFxNPYJkNRbOb32Ndc93T54p+npLvcb0+nXGODwE1gIw==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BmpNK8WEAZFgIRntrs+uEgprq+7xNTwYbE4mOrbGOpszjSV81IOBVobPdP1Bov0SS5L1Gtz3X94TQtQrzWEsM87GYu+ipvWLlXbMvftrawUUY+cori39UGPpkfrygmbGH8hspfw6LQCUItrSwjdsvCqMzZdKDHxgZxuJHEntCimbO7hu7l8k9pr9qOk7p1MMNrh8SYntWwILx0D+ATNzWvg0yHGPUGf38D+ataU951duuxm/SZ3yALog26fyo6SG+1QLiir4dxugc6+apQOowTLDMyVRipNcpOWzgLmXKV+f/vc5+m55x1O+m7741uOfv2s3Nu4eiPlk+51kxyiFPf+lutVRMMafIAzmY/rtCu3OXjMHkY+loxpTsyD+przipNukEnlixSvv43EZl6L+j2WsoypQiUy+YDxwcqXQbb3s5/Vs2BOVGLX7bSJTMkrRLn84ZhRP66HTduqz/hm/5zP6kZ1fX2kB8cKjW+wSwI5mywGSkgNsU+gdTlPYWiQUZoAle0LEmzQAeDfuav1MQirH3YnmPM0uH+MQNtpDv4VyvSekyKqXX0uBfnxKRQbYxkQauB+0bUNOOE1Pqkbl/ZFBIkF9i5aS45zn5Ul6GBy9cEc26U5AqPyxW9mqhLChBoOET+YnkfQXKbteGitpK6N8ehl29arw5s17ivXgvjmvqFmheNV0IIWvBmMdT4iH
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1P8M6Vbc9kM0LhUpnEkE+EcoMm/5U2p867Tk7KjVDWOuz8t/iTYd1b5V9/j?=
 =?us-ascii?Q?CYgNj7FFBicLqELB3BRvDRehEbyhGq1lREiZJ4XRgEz/4YkcjAHgj4H0iFVX?=
 =?us-ascii?Q?l/g/tL9fZ2zqEkJgWO0blSo1G64GtGEaz+D8YBUIHTsTlT1r5CDZzMOTuDL/?=
 =?us-ascii?Q?QMechmitdf12dq9gqlCkg/MeP2/zTvPjXju4HVFMb737hiWPfjy1EfMR2MyE?=
 =?us-ascii?Q?foLvIRe7n2YQ3evm6xGmUzGOq28/kx8Q00P++2OUl4gBd6lamMtg/UHYrP52?=
 =?us-ascii?Q?vgIVUDe1Gh0HJ40P0F9a7ejOMZADBeifxDo6BDPJ3W04XDPeXDqr07ByHPRQ?=
 =?us-ascii?Q?evcUnfSFyZ+xJXmk0sUXi25YWGKFoR7oenCk/uBYTYiW8ykzFCuR6WajCARo?=
 =?us-ascii?Q?9W0bIvlb8ChHGAlpxvr+MdwQ1/yBLxtdTiNCoHro7jn37Pvx+EH1N1Shx2zU?=
 =?us-ascii?Q?aus0d3m4kouO2noT6HqWg0kXKvLZptZMokCfUULJ1gn+ynn02+yxKC4xbv0G?=
 =?us-ascii?Q?tn4YL/Y3vcnRBRzW+1IpzQPCO0ZZZVThzrK8S0JFhW8UdJuyZD39rDrlTNoK?=
 =?us-ascii?Q?YolGrkM4gStBnUp9t7bhrpHyQVXfSINrDCcgmg8/PPC+RIRk65tS9MvFOppt?=
 =?us-ascii?Q?chjWXcmX+MCcDQmEuPLuIRO37fNdYHchiRLnJl+d1SI+DpwpGiUzwj5MC5kv?=
 =?us-ascii?Q?IAmUUwTBDuULq/8ZtYv+y/Zxq8NLl484biNjamCTD5yTyA1J8IjQjUnviXj3?=
 =?us-ascii?Q?wsKbDBJG0jlVnm/X9C9wzQeGERNaUq/n4tsj4OvCGsUTB/9gpypdURff3Ich?=
 =?us-ascii?Q?DKP+XIlK7FH+cSQNa0H+TcdBV4CySrFAPG6+3cFsMi88Pb9+yCaelT6B16qh?=
 =?us-ascii?Q?JWjKuJqnDOjwj3qkV70tOUNV7Ml1/hohwFGA8OA/qUUN3pG9RbH1Uq3xwDgY?=
 =?us-ascii?Q?Ard05HLn7IAIyQPmRuzodCi7ZL5ERgmCvuiF+51P5zT08Sj2J9TxWx5z0Czz?=
 =?us-ascii?Q?WBoksHB9MUckKdCXdr/EedIcipoavYnQvw3isBlhbP/0aqwCNlUqCy6igt9t?=
 =?us-ascii?Q?ReGXm/pXR3kPbrNcdideApIv3Q9/rkji1sKeeJMsk/Bj7LYqtxLS8S3E7Fm3?=
 =?us-ascii?Q?rT7C2g+dtcvHiGOxjCIbUiGJ4XNKJn5MgR7s+qXC93WNibZKdLIptDNA/Nmo?=
 =?us-ascii?Q?C2f+3glHvwp6FIabu9Sx3Pg+5aBEVQOumTgTcKyaxRRiWehB0r8nFgvbfRuJ?=
 =?us-ascii?Q?srRvdy82QlZhREiwmWntnXJmz/QNZMpVwBVR5AHPpA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce1f44e-3a46-4417-c3ee-08daa88d99a7
X-MS-Exchange-CrossTenant-AuthSource: DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 17:58:55.5608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1973
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SO_REUSEPORT has been supported by bpf_{g,s}etsockopt for a long time.
It is added at the beginning of the optname list under level
SOL_SOCKET because it is supported by both helper functions.

Signed-off-by: Rongfeng Ji <SikoJobs@outlook.com>
---
 include/uapi/linux/bpf.h       | 7 ++++---
 tools/include/uapi/linux/bpf.h | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 51b9aa640ad2..ccae9cb833b8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2574,9 +2574,9 @@ union bpf_attr {
  * 		It supports the following *level*\ s:
  *
  * 		* **SOL_SOCKET**, which supports the following *optname*\ s:
- * 		  **SO_RCVBUF**, **SO_SNDBUF**, **SO_MAX_PACING_RATE**,
- * 		  **SO_PRIORITY**, **SO_RCVLOWAT**, **SO_MARK**,
- * 		  **SO_BINDTODEVICE**, **SO_KEEPALIVE**.
+ * 		  **SO_REUSEPORT**, **SO_RCVBUF**, **SO_SNDBUF**,
+ * 		  **SO_MAX_PACING_RATE**, **SO_PRIORITY**, **SO_RCVLOWAT**,
+ * 		  **SO_MARK**, **SO_BINDTODEVICE**, **SO_KEEPALIVE**.
  * 		* **IPPROTO_TCP**, which supports the following *optname*\ s:
  * 		  **TCP_CONGESTION**, **TCP_BPF_IW**,
  * 		  **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
@@ -2802,6 +2802,7 @@ union bpf_attr {
  * 		This helper actually implements a subset of **getsockopt()**.
  * 		It supports the following *level*\ s:
  *
+ * 		* **SOL_SOCKET**, which supports *optname* **SO_REUSEPORT**.
  * 		* **IPPROTO_TCP**, which supports *optname*
  * 		  **TCP_CONGESTION**.
  * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 51b9aa640ad2..ccae9cb833b8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2574,9 +2574,9 @@ union bpf_attr {
  * 		It supports the following *level*\ s:
  *
  * 		* **SOL_SOCKET**, which supports the following *optname*\ s:
- * 		  **SO_RCVBUF**, **SO_SNDBUF**, **SO_MAX_PACING_RATE**,
- * 		  **SO_PRIORITY**, **SO_RCVLOWAT**, **SO_MARK**,
- * 		  **SO_BINDTODEVICE**, **SO_KEEPALIVE**.
+ * 		  **SO_REUSEPORT**, **SO_RCVBUF**, **SO_SNDBUF**,
+ * 		  **SO_MAX_PACING_RATE**, **SO_PRIORITY**, **SO_RCVLOWAT**,
+ * 		  **SO_MARK**, **SO_BINDTODEVICE**, **SO_KEEPALIVE**.
  * 		* **IPPROTO_TCP**, which supports the following *optname*\ s:
  * 		  **TCP_CONGESTION**, **TCP_BPF_IW**,
  * 		  **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
@@ -2802,6 +2802,7 @@ union bpf_attr {
  * 		This helper actually implements a subset of **getsockopt()**.
  * 		It supports the following *level*\ s:
  *
+ * 		* **SOL_SOCKET**, which supports *optname* **SO_REUSEPORT**.
  * 		* **IPPROTO_TCP**, which supports *optname*
  * 		  **TCP_CONGESTION**.
  * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
-- 
2.30.2

