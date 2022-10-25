Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFA160CACF
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 13:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiJYLW5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 07:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiJYLWz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 07:22:55 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-oln040092066044.outbound.protection.outlook.com [40.92.66.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6F7143A54
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 04:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho655yyyOlNh32c45rcZ7EVxGMUO7fkTrb2EcciEfb0h+LU1GAJNphPE9yahp45EN+cZNjG7Jw7ugk0dV/R4gSgJg2wCQp6+piy4DTpYpCGRbaskDMxdyDUxzmutdVgF+S2L2OoLekSkXdrmf9StcOEfn4yfaZ52Z1eOglhCRHk2bQP2+ikKUIxIjG7ns9YX32vWIoyIZPVFKKPYAcMt5jUK3OHwDqkVAjLgOeHMrKrdYCxjEBX0NpgnFH5UhXBEiX2/Cl5tMyG7dkvq3sPgCPNCaIs/hUEazIMZKI3CrMc9ucmVgHoqkbsEvpdADqC2pkSncoFxx+2FOQK1FOzzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjwDAAYdj5N1dnYFCwyVzXC1mo/+/E/V1EP1U+4o72w=;
 b=ebWdaMgcGk8veTziksMSOCwHbmFRCkesEQ9MtsjGs6lUgkkCxejgkzoM5PKUBu66ZLgZasMrlRroU4xeLApZxyqSrqpcskP1RsbuGIFOuPutxPm1sUKcX/6yYil9up9KZc7vihlzfl66fx2iFiuav5v23Ucq5tZFc0uaS+s+TZaj7GbdZtZAajc/lw5a/9nHIBhFJZOm5/ceOleswn6wS4k4J40zQ040E0PatYanWug6wh6xt0iEEJ8d33n5ddoi/fdx8gOY9g3cFKBBQrmLecM13lbq7eds/yk0YTEBRraBWk9ozZKmXq5gv0JnSc+JmIlVXL0O/oQECRO7YT8pvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjwDAAYdj5N1dnYFCwyVzXC1mo/+/E/V1EP1U+4o72w=;
 b=YG8HUhgKKjA5KwjYP4YRFuW8/ykgVEmOuVj2TTe80VNYh9ES0gr1uvLYN3QoGhZIFfxzMKQgMZ6htQLNYvztV7NRGPG+FFQkoY4fbh6reiRwV1KjcQH0HXYMPnBC5vv7SV6XW66mnbr3Q3ROo7zy3ulMdxw+knv+1RmoRclow2zfIEkw/eMZwfQeNx6SeyuvriSO4vuACSwz4r87hTCuWV5h46IB6tEle4B0ayUDktrTuq+Q0Ec9bCYNXyy1aZP8w35pW1ljs8OygPHEjwAAPWg3gjRmLjFa2iNwcjVYggsMrKDaFhUftynoL98IveuhMJSzdKyxKa7iPc+v++c9rg==
Received: from DU0P192MB1547.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34b::15)
 by PRAP192MB1508.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 11:22:50 +0000
Received: from DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 ([fe80::792f:212a:68d9:bd26]) by DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 ([fe80::792f:212a:68d9:bd26%6]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 11:22:50 +0000
From:   Rongfeng Ji <SikoJobs@outlook.com>
To:     bpf@vger.kernel.org
Cc:     martin.lau@linux.dev, ast@kernel.org,
        Rongfeng Ji <SikoJobs@outlook.com>
Subject: [PATCH bpf] bpf: Return -EINVAL on calling bpf_setsockopt(TCP_SAVED_SYN)
Date:   Tue, 25 Oct 2022 19:22:35 +0800
Message-ID: <DU0P192MB1547197315863E8092FC603AD6319@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [0t+AaHjz+kwQvtnW64sS5R/Alvj1mKmr]
X-ClientProxiedBy: BYAPR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:74::46) To DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:34b::15)
X-Microsoft-Original-Message-ID: <20221025112235.653-1-SikoJobs@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0P192MB1547:EE_|PRAP192MB1508:EE_
X-MS-Office365-Filtering-Correlation-Id: 645fde5e-c065-4602-0354-08dab67b400a
X-MS-Exchange-SLBlob-MailProps: laRBL560oLSDAxiCsf/0m7Jo0tfeWsHg4hPXy5Ff0m4g+Ghru7Bar1rOGZ37tCElzNMbbQBOYqXDtNcVjW+RyibPTXzxRYPfyKTkB9kpc55BFDFH+/7XX7+7g1TrnKHH3G6vFuIrK5GkNGhsmYqePysRMXkzO7ae2eRZGVfovU2S6v/XbQVVwHlTAihQEySsFtkyt63RzOysGM0RL81jyRmPi+bo+51hr5q1j+f3F0mbTksuz4LPOgcBU1aCT7EXR7qfBcUfSzRpnMiz9Ik8ISeNku8HoDVnSJSEXW/D24heHvNN7Fi4wAfrLoQdJEYmXaFFlMLaGDjI/5LAkzREUFL7zlD1J+MOPV7ff2MpaixgDYet7AsVoMjX0s8gFNsvGJdx5jsQnuPUgj7w4zZQS4+dzQaODRH0tgYFo3i7Ycfcjk/aLO6jNb8Uim+s5jZc9XdIESevatXVI/ZEKL3OeXeu0GI/GQy1SK5AVshJMrCLhku9pdGqHCy5V88ojxzsihIVu8JEDIV9hCt24T8N/Gmcqa/dC4bu7/1Gntnse3SGvPTwcTDpg4WvsG7KGhF9SGjlMT0w3gwuZ5UJfP/CxRFZXvTPv0XemOrc8w2VPxmG8iltEh+vW0UTJaglrJV3HsWhhu/mQWSnxCN9v8tas0hxAaedUECeUgqRKFFDRwNskKdeTiNl+54zb5fdx9PQQQ+G0sF01HHIoonh/8LY7S3Nql0CFF/d+X9RmaIdAja23p3vTwHW0OfD5FyDikgHZA8/qF/qeWMdR683mTtOxP42EWlEMUvV
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftgA0QTKxKyllCf2KkDHyluKEnmb+r4p1ULxPif9fy7a8EWrNouCvI4P2cuctf4R/dkMIJ+XBPc/GPRVgi8JjzOSBvAyDPw6ONO7rCexyYmfnh/SLPYdEVsrnu88Y4yaT/iTLVCRdDFfsOyoh0NR8o0knQ/uif+KTqY44Xr3KGjcrML8RV1+EwCkc2LUh0H2YmQioLLvcrIf+IVzAXm3VdBsBrIIl9pDnrdSeIGcWBbXiJc9AVMvtdg+ucpM3rGIHph3HO2oU19h7wkUzLsyTx8cfciES1++YLO2wdqqP2fbs00J+Rzdn6JxLsgWh/f7WiBu9XWHckfdoItTdT4BnyWf9cxAazDh9Eu9pP3EVIKuDB8jjSH+shY/G7OzZcs36z+6iwoBOpFH03rEUtQFRTXBGpolnU6ws7b9aRX2BFWdbVSWrN/JQKTBkCFhNx4Bo0jHQieu1gEhJtk9rKv/eMhhOrX7h2HGdOjP1KR2nyoSpqrxd0WFxbaS+cBTeY3lIJuPDVa26ZzgHzg3jI40gnWVrLyPMaPtVLP5UBabwjMR86PuHqFd+iA40WST6U0XpKAww3Au8iqpD4ZHQ8+PfSC55sZ9hi/E6/byBZKlXUDvkH3VqUhDqJ+FfLsNMcCg8eT6IXVwuF4jVRS2gG5YKFAWw+qSzFmxGTvJScXeSwyF69COKTvw5kb8xCj4aA3g
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?io1WWsHsFeAbL5WCOo75hM9hNJ4Q8mrJtk/8H1SSjoY3cugUOpmqonDI597s?=
 =?us-ascii?Q?y3x9D49WTsg9CLb9Te97u5Ml+oKu9ovtRRh1Azn7jBm2FY1nb2TOEI3/8iH9?=
 =?us-ascii?Q?z0p2ZD670V208qIHsJ7RoucjQZ2IA4vuQ0zx86GJLU9cltLmuLnYJo+E+CP+?=
 =?us-ascii?Q?yxVj81jNOpRtBtcHNmQ7kcwPDa0WMQhHpZ+nYlj4QYnhNt40ouMJ0BmB0SPy?=
 =?us-ascii?Q?ClCfljJJ5ka5KxkCEb+aZ5osO1ZDg8xwdgVUaaj5ldwfY+gTdPge/sCxBuIL?=
 =?us-ascii?Q?bh4dTMbkvKNThcH042aSmeO2VMwtNI4j5Jhh32Ey374mO4QUWqWlRveA9obn?=
 =?us-ascii?Q?3axpTHn1nmVJru1f3hzbUzcuM1aCNXOm6YwG1fpTTo2lKaVQTgcBqfTyKksB?=
 =?us-ascii?Q?tnvZU3x7AlnSMShUYB1wb5d+W8vTbKobRDzEmpp+9UGttK0+vRDFkxR9PP0w?=
 =?us-ascii?Q?9lc9QycYRYmThJpnBr9fxhY15sQP6XXNfpP8j/eV64PihmAm9eMNL7N2ulla?=
 =?us-ascii?Q?9CWS7LTbTSBkugd+irAdmdKezWGeDzNKnnxChi2Q3A5pdVbI+/S0+/r5A6fg?=
 =?us-ascii?Q?lBhxaEr6OL3jbQfyDEyUVX2OpJhEv5NmYBVlgmK8zmkQr6wkywjlFq+mZ1MC?=
 =?us-ascii?Q?sOU8e/deO/iRXZdAiTO8rd9Vl+/DdhZMtG0XKlhM01y0CvD4UYYsZQlehahy?=
 =?us-ascii?Q?0AAB+GhozAsL6aUJuQqVhp022nKrbClhWHgHRc3WtQ6eUfKumCS6w2lB6QKW?=
 =?us-ascii?Q?H7neNuK3kuDHtsI+0goqo5VS365p5VCIRWEa7mM7ImCvzSeDvw/WwoYrgINj?=
 =?us-ascii?Q?xshnYR/NzF4eau3RwN9zKPCYlth0tIPZzDgPda1EKMQVgYGa3fR/5RP/ZmNC?=
 =?us-ascii?Q?0PRtnXS6xjXkpluJvDNndtsKhmoqAOXk7iHlAdBWFRsWboLgNAkmXR2jQGIQ?=
 =?us-ascii?Q?gtQEYHTlrsBc4dUaR8OkN0khSjRuXC/FJ85hVbarviAuKL+e8fqyL1dTgDo5?=
 =?us-ascii?Q?/iM88kcbHF8DZsR3Y12o02NHEUN6mZumxwOOAzSSAkbcYtabr+b5bp9jy/+C?=
 =?us-ascii?Q?dl6mYl6yGydeiEBUYslFESdAgeCeXo1JhaHpfKfyl8UShZOQqlKT9WTagHVp?=
 =?us-ascii?Q?J6qb4vPllLiruZZMiNUVGo5mhFr+2c8cNKiXkWTOK+xxhcoF8ruukvGcRXD8?=
 =?us-ascii?Q?3s5QuOkZZkJYAt/Z/U83chKzftT0n6lPxE36/8wdyghOqjcyOtHJVEYfhgke?=
 =?us-ascii?Q?CF70f7pSlb0IRAGlrzjlIepQ2C3alEgOK1Aos2FEHw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645fde5e-c065-4602-0354-08dab67b400a
X-MS-Exchange-CrossTenant-AuthSource: DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 11:22:50.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP192MB1508
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

TCP_SAVED_SYN is not supported by do_tcp_setsockopt(), but it is not
rejected by sol_tcp_sockopt() during calling bpf_setsockopt(), which
results in returning -ENOPROTOOPT instead of common -EINVAL.

This patch fixes the issue.

Signed-off-by: Rongfeng Ji <SikoJobs@outlook.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index bb0136e7a8e4..42cd7ec8cc4c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5206,6 +5206,9 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 		return do_tcp_getsockopt(sk, SOL_TCP, optname,
 					 KERNEL_SOCKPTR(optval),
 					 KERNEL_SOCKPTR(optlen));
+	} else {
+		if (optname == TCP_SAVED_SYN)
+			return -EINVAL;
 	}
 
 	return do_tcp_setsockopt(sk, SOL_TCP, optname,
-- 
2.30.2

