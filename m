Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650B862EF12
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 09:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiKRISk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 03:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiKRISk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 03:18:40 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-oln040092074059.outbound.protection.outlook.com [40.92.74.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A74DDEE3;
        Fri, 18 Nov 2022 00:18:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InNl/J7kuS36erUXrUsmKlvwXrpNXHWKs/fz716eXJ63ca94/psNTsg0L+5vGO0cqHtOM1iPMu/UJbb8MN6MBQH2ko2Srq3nlLcugsbY22yQJDD7mj+HzOiD/5HZRsDqNL3/AuGOicbEK/gMj+qzFU8BD3WzRGd5MxZ44j2fAZ1Ko0kFGgzMapN8FMV8qcXyzZlq6EGqDuqqLXKkwV3hz8t/E125Wtgls9QqETcZQhcOwnt7LkMVsKjdDxNVifALQJeo25U+w8NSKX3SQmp+2UffbA/ekit57JTzKj6jigTazqBAO1OlvZvo1CinEYfFAlZq+njsNT4owXpEqBrRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u61pKmHBuxiL5W/F+mDmCTdVaGnUofJGsLzby/8qhOw=;
 b=WOWt3gThIP8a0Gphfo2PiqrPgD+BYvVO2Izb3F2IUCHSDzbV3nHDN0o6Re/uquzvzCch6CWlLewZevrP0h/KKFGe7u7Dzx5dEFrSpnVp7Jn7JXIm7lo/zwXzNYy/MAFqncgHsqdJu78myQzvJ2mVEb9viFVf6iE16N+vO7edyZ5NV2NijhspzsBD0xbYvNZDpLEZDogjjRoNlkoQOUbtEBJ+LErQ8ytlfDCBB6T11h9V3kG8RBz/TY1iWG3kpbQ7GxpZ4lUnsC6fR1yB6NQ0g06w2hsCzUo5kmN2khgYlmsI4h6g8/CKbXP8KLCDKlravfA0FuXRJEirUkjzroRAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u61pKmHBuxiL5W/F+mDmCTdVaGnUofJGsLzby/8qhOw=;
 b=FVxfsroFGnHF5l0oIoWOfHBGB8IBdqsELkzFQHondIt+5qeADTwKMJTZN6DPziI2TeHbWIHl5/PzJEaguTAvILAjUDNlU+Ozt4xmBCNMExnFLk0JkpMeD2/M8nWJhNFFY/CJZ/QMr5xB6Fr6nQsywxFBw8Yjahpje/a7eoAYH5jE8fU1Fs872/fjgSk4Nac1LHOPoQ6HRxEWM+E5FX/eCl3Zz4PaAuLN1dWaOT9RhdbU2eaGcqOcZku1jC9gDj1FzyygaUoz5vg3cgllJRTt3rOJhy992SAYe17OYhqAtG9z02f3yv1Jza9AtX5k+iOb7eH5Kyc2FQJ7T/+b+XA32w==
Received: from DU0P192MB1547.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34b::15)
 by AS2P192MB2071.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 08:18:35 +0000
Received: from DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 ([fe80::a67b:5da2:88f8:f28b]) by DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 ([fe80::a67b:5da2:88f8:f28b%8]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 08:18:35 +0000
From:   Ji Rongfeng <SikoJobs@outlook.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, joannelkoong@gmail.com,
        kuifeng@fb.com, lorenzo@kernel.org, maximmi@nvidia.com,
        quentin@isovalent.com, Ji Rongfeng <SikoJobs@outlook.com>
Subject: [PATCH bpf v2] bpf: Update bpf_{g,s}etsockopt() documentation
Date:   Fri, 18 Nov 2022 16:18:18 +0800
Message-ID: <DU0P192MB15479B86200B1216EC90E162D6099@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [vVHr3sqmR/7yKXVXYtFV1ftDNVWo3JPn]
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:34b::15)
X-Microsoft-Original-Message-ID: <20221118081818.10255-1-SikoJobs@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0P192MB1547:EE_|AS2P192MB2071:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd4950e-9739-4cc5-67e4-08dac93d7c5b
X-MS-Exchange-SLBlob-MailProps: bJx5BVzHBHsILvVQHLXIxLUaAFlyAqiS49al4+JVAPe4uoEFRL4lbl1/+oOkw5T1R4jSKW7B7lAtvqI4iCHJNVY26eYBC0TZr7DJsdVjP23/KfYozqVe9k486RLA5MRm8p6n9zvV/z7/y6mcn2hwnjsXXHvElrSDEUFs4GL1bIpYRYKM9A9sBEXdOs5TEV3iYHa6SEZQQczhbyQUSE/3AulEPXWLVedgaV1OA9lB8BNmC0MgCqmngZ0ZhIJwzr2L5o/4qLlIi2v/k2VTSFDKo4jeVxuFSseI4PIydsc9mBstfNCXSm5iUq0AZo/0PtSYvPmGAG5DaRvFKpMQRrl/1eER5sMYBeNU/U8EkE/zMkS4p7DEYXxZFt6sQlTXMp38k4KBvhDJT/A2ZtFqjAPzCCGpLz0pZpFK6AbdzZo8xYQxgKaCBOzTigJImII3Hm20hcxHBZ9kweCHKiOkRfvYrroBqiiJEGphnrlY4YA5Xm/IQp63dbyEgIzchUBXGf9jZhKKJ40m9tQbDUgqjAkNoV/TtE9Jz301WIfCAqBB4V3Fpyf96+K6JBo1R4NhHEwoj8ON++xevqoD1krOQjdyqdpM7AtJYcsYBqxVVz55ug8oXmAc2nJvy+gD9aDWfV1BRLuKmExRk6TBTOJF6ngtyizkA6xtKkZ+
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOrTKu4RP2So5WIIOXnUZEB1lgyLyQ9XKMVy4oLBebWxdnF1O1XY2J2P1uhMJv5qGz72B/xIcJyzqmvBFKPsmSKJdW2hvlYjq+aT771g1ItCMF9acUggi2RddWTW8Lteq2U/lAbfvvrZUJyO3Z1f5Rp5UVpPFKQDeCHobP+KNBRFRErv6M0torGGjR864ie3bM+uYqpR4aCXY9jsdRsdpMZwCED0x4tmG5QASbRBM+dpt9gSQhlPfw9djaa1Cht86OTyFg7fphKKd64kVRKrekS8hJ5wYg+lu1ybRl6JzwOc2pk+h0zY+GT1UjAEt2OQShmoVLMjqL+USMPxwN5QnKpXpmHFTWENwoHyMityA+sMzsyMsgvIc8k7sFiiA3OevsjKGLP+etypLER49XYEfIUgBOjtcX0Shn7pqvwc+SdZI/ZsIoZH8JrjysrpvrbXpsdhMJoHNoAgyIWIJTuYmdnEzRGtxb/AGrtcnr4bvaDW7AJGF9BfifzWmFOvF/72Js2OgcsxnobhjHck+cz8XjLCNd7yG+QEec/kY9FiwzRn2iCc3rbwYMBpYudR59WbXw1nuoRF2RXX2EhxpsVJrUqBOQ3nJkJlPDznlyp4Io06p3wxb5mUkGcq1zQ/BufYsiHhjwnK1d30nPmbhbvbTg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?msDgTV/+PloTsTzGZy7FaHpSuQYspwAhtrfdrw5uXLx54H52aCK3d98m9dN3?=
 =?us-ascii?Q?yixfm5UMLINTJLGjEp6Ru563i/szfQYARG/EayPVCGRVQsU4jPbZ9tLYjBvE?=
 =?us-ascii?Q?dZqfCTNQZZuT0no54A3EQLW0EyM5c24Dm0b+sp/UJTbtnFsEvmNlWwfO2v/n?=
 =?us-ascii?Q?sXH21VKIMEFs7kx+xYkFqUMZzvIKfo0w4Pfu5Ecfd3hqfq7cZIgutzf2/YYA?=
 =?us-ascii?Q?OrhIJujL9+o+72vQS8fg/LV2UJ3YxixZ/qextT6sIA3zX8ylIzt1WZ+fILKR?=
 =?us-ascii?Q?WsCGjqqr1eCorG7E1O5MEWoWV6lIgyRGfDLqXZPo53zSqoEs0z91tSlVQeBS?=
 =?us-ascii?Q?+KZkgdNBfgqCxFW5vdLiCUcEMwznxCjaO3Z2cCPjMfaV16vA+h6r5OQIbOXn?=
 =?us-ascii?Q?QLiQqNK6zcaxVXm5ST1FP+OPCabi86vrU77j9v2P83TjfLKnSTuXT84tpCcF?=
 =?us-ascii?Q?wK/VypS03X5S+qh5j8tj1/XQBfPUGIWqPdr92wTKY82IOiIlPAorHIWNHOsn?=
 =?us-ascii?Q?27vtmcWuMf1OZCv3WRQ4QVhVRKBkGz9FXLGdRWgZXLZ4LaUQTmcmgy0i+VQF?=
 =?us-ascii?Q?KE78gqlM7U5sam2sbPC72o8Ej0q+Om7blowwG2DBNdlCyiKY7F9ndQSVQ/XO?=
 =?us-ascii?Q?cpnhQhGSi9jY/dAFC2FVcePhAsyapMw9bojjha4Qb46f/t3wf7kNKjICJHv8?=
 =?us-ascii?Q?UwDaNTRdqrXNzZpgtrSRJZlo23Phk6651/VguZth8A2ugD+XEhoIu32kB/yJ?=
 =?us-ascii?Q?kFMYINqyjXqoJlmy7eWXNrsYY7LTu8WV6SZ/6+exaXUK7wE+BIKaebltzz68?=
 =?us-ascii?Q?BV7K4S9LUsCMM3qiCC151fE1mU7BZD7slhFpchZIebyBixuYA7rVUeHb/E/t?=
 =?us-ascii?Q?553C5hNK426Ydjn6/2LMIfd3tvU7IDN3DGXSFkho9XF1TAUr0l48FgGDLxAq?=
 =?us-ascii?Q?D4DyZc4ANzwxjS7toJPfwPZ8TkKF2URM5P6dp0zsgq6Ig94pjmFeZXwiKz3/?=
 =?us-ascii?Q?e7fUNQ28urHfOEPgI4fuQXEmSQFb7YnmiG9oSlxlAHqgzHd+Fagu61kJSa6O?=
 =?us-ascii?Q?uCAxtFL6qkkIoVir8eDLmUqCzK0061FXGUxg0f1WlV/XIwI0N9oEQ/RxYzar?=
 =?us-ascii?Q?L1h9MWvY/Nv9ER/W/O3kCA59hvfsP1C5Wkf/WrxAgzh+Tdwa5EaTIqcMziMl?=
 =?us-ascii?Q?JQb8tL+9dLF7lpjXtb+jDWUpR3omtZNZg42yLZArL4BWbLERrA2r67J5FicV?=
 =?us-ascii?Q?LuH8R+gKZBFbL3iLAPgqH4GwFqyrdMZNHbpKlUqbhw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd4950e-9739-4cc5-67e4-08dac93d7c5b
X-MS-Exchange-CrossTenant-AuthSource: DU0P192MB1547.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 08:18:35.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* append missing optnames to the end
* simplify bpf_getsockopt()'s doc

Signed-off-by: Ji Rongfeng <SikoJobs@outlook.com>
---
 include/uapi/linux/bpf.h       | 20 ++++++++++++--------
 tools/include/uapi/linux/bpf.h | 20 ++++++++++++--------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 51b9aa640ad2..14f29d95ea71 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2576,14 +2576,19 @@ union bpf_attr {
  * 		* **SOL_SOCKET**, which supports the following *optname*\ s:
  * 		  **SO_RCVBUF**, **SO_SNDBUF**, **SO_MAX_PACING_RATE**,
  * 		  **SO_PRIORITY**, **SO_RCVLOWAT**, **SO_MARK**,
- * 		  **SO_BINDTODEVICE**, **SO_KEEPALIVE**.
+ * 		  **SO_BINDTODEVICE**, **SO_KEEPALIVE**, **SO_REUSEADDR**,
+ * 		  **SO_REUSEPORT**, **SO_BINDTOIFINDEX**, **SO_TXREHASH**.
  * 		* **IPPROTO_TCP**, which supports the following *optname*\ s:
  * 		  **TCP_CONGESTION**, **TCP_BPF_IW**,
  * 		  **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
  * 		  **TCP_KEEPIDLE**, **TCP_KEEPINTVL**, **TCP_KEEPCNT**,
- *		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**.
+ * 		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**,
+ * 		  **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
+ * 		  **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
+ * 		  **TCP_BPF_RTO_MIN**.
  * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
- * 		* **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
+ * 		* **IPPROTO_IPV6**, which supports the following *optname*\ s:
+ * 		  **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
  *
@@ -2800,12 +2805,11 @@ union bpf_attr {
  * 		  and **BPF_CGROUP_INET6_CONNECT**.
  *
  * 		This helper actually implements a subset of **getsockopt()**.
- * 		It supports the following *level*\ s:
+ * 		It supports the same set of *optname*\ s that supported by
+ * 		**bpf_setsockopt**\ () helper with a few exceptions:
  *
- * 		* **IPPROTO_TCP**, which supports *optname*
- * 		  **TCP_CONGESTION**.
- * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
- * 		* **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
+ * 		* **bpf_setsockopt**\ () helper only: **TCP_BPF_***.
+ * 		* **bpf_getsockopt**\ () helper only: **TCP_SAVED_SYNC**.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
  *
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 51b9aa640ad2..14f29d95ea71 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2576,14 +2576,19 @@ union bpf_attr {
  * 		* **SOL_SOCKET**, which supports the following *optname*\ s:
  * 		  **SO_RCVBUF**, **SO_SNDBUF**, **SO_MAX_PACING_RATE**,
  * 		  **SO_PRIORITY**, **SO_RCVLOWAT**, **SO_MARK**,
- * 		  **SO_BINDTODEVICE**, **SO_KEEPALIVE**.
+ * 		  **SO_BINDTODEVICE**, **SO_KEEPALIVE**, **SO_REUSEADDR**,
+ * 		  **SO_REUSEPORT**, **SO_BINDTOIFINDEX**, **SO_TXREHASH**.
  * 		* **IPPROTO_TCP**, which supports the following *optname*\ s:
  * 		  **TCP_CONGESTION**, **TCP_BPF_IW**,
  * 		  **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
  * 		  **TCP_KEEPIDLE**, **TCP_KEEPINTVL**, **TCP_KEEPCNT**,
- *		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**.
+ * 		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**,
+ * 		  **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
+ * 		  **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
+ * 		  **TCP_BPF_RTO_MIN**.
  * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
- * 		* **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
+ * 		* **IPPROTO_IPV6**, which supports the following *optname*\ s:
+ * 		  **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
  *
@@ -2800,12 +2805,11 @@ union bpf_attr {
  * 		  and **BPF_CGROUP_INET6_CONNECT**.
  *
  * 		This helper actually implements a subset of **getsockopt()**.
- * 		It supports the following *level*\ s:
+ * 		It supports the same set of *optname*\ s that supported by
+ * 		**bpf_setsockopt**\ () helper with a few exceptions:
  *
- * 		* **IPPROTO_TCP**, which supports *optname*
- * 		  **TCP_CONGESTION**.
- * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
- * 		* **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
+ * 		* **bpf_setsockopt**\ () helper only: **TCP_BPF_***.
+ * 		* **bpf_getsockopt**\ () helper only: **TCP_SAVED_SYNC**.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
  *
-- 
2.30.2

