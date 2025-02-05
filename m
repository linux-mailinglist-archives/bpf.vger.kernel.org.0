Return-Path: <bpf+bounces-50558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC353A29A2B
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 20:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1C31882DED
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 19:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34697205AA1;
	Wed,  5 Feb 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gJTrWsfZ"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2059.outbound.protection.outlook.com [40.92.48.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB348201278;
	Wed,  5 Feb 2025 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784048; cv=fail; b=e/pwkpaDCqFmwUXNwhLTBoG7ePMTp2seC5bLAlOU6W5ueVOqFeOPZMYJJN5WHOGga+lxuIQk44ktJz2+kSX5S/tgd8/AqtypPrig1Eneuewttzc1gxOhDVRqe1J8xKgK5rpm4xqjqEgtm0ury9mH+NaFa+ksETYK1sbty4WcCRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784048; c=relaxed/simple;
	bh=iF/Sj2xmE/lkkU7TNtMtOXxE37PcwLkFvVAAoL70Sqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MGQQmqp6wptr8/HGFYrv4Q+PBaa99i6sOqwow+duoVmPkqFkmVboKyTsT4dzrQ0h0lCHYPSvRU6LeWP+TiAZqtu6pOCj0GduN4Mph94WYrfGEe9sSYNzT85gPuUxtMQivvfjnPCqyPbujJhrFz+Tfofwe4yavun/+eaYPih9qAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gJTrWsfZ; arc=fail smtp.client-ip=40.92.48.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmy6eJNzUk33BpB0sKz+VUeTtiHo/JGHo3zvHDsLAsMIpZnoWSXvkQvNs7wdCsXt8SbVJJmbhq/Wcn40D+ZrDwxdd2MkZiJ4dv9IfBjLKpf4I8TR/1wBZO5+heQKYUH2zurVK6o6ZKEvvqzxdVr5Bf5OPSr9HZEjp/dFpYBsLDHPMJT1JSNW0WHPI6MKjiFt0HLdelDI7ziJC8amvydIF5eHzjDMf1ZZRtnfatsrYxuVKnvSHEHpPHI3xqn6Yc3GHFoEQrg7BzgRmbPT+CSvi9aRt1Ta01hGZ6u/n/+fw+s4JOI7X2+GRn+nhc2oVIRbQxr7F7AwIgz8OeauT1peyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+WTB3O48p96U5to3kKDjXTN2klXt1eb56dzL2GARNQ=;
 b=bSAFnImpinlgDQ3xdTy2+IT4hDBT5CFNcBKWdrSDyzxbS4uA3jbAiIT3G9XdyWZ+C4NVZv8lsMrKJvBHpKp4Va/dYSX2BRNo+Z0dVacsLvPBewEhwi8rthxmyxGAQqgIJz6ZeR2wPB6Xmnf6P+bq62H0BN/A0HrGxdq6jx9BPU77iXI9Ph84mLByUCyeJ49Uw+YZ+V9vSTAEgqBcC+w7X4dAKwmjoWQpDWjIbGfgZWhX198sr/YoGLqYw/3fsYELTVfBMdmjOtrsd0Iy3JRMmEOLhRO6FvslMb+cfZimXWRQiwqUk/MyDXf7FRPeK1zmZFdBYa8m+slag2yASKIMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+WTB3O48p96U5to3kKDjXTN2klXt1eb56dzL2GARNQ=;
 b=gJTrWsfZZoMycBFrKlwVJ7GSAc7feHr6OUb0dgRUbPj9dmrA4egldmSSwyrVXGYuai1Oz9Fava37g7KiMsSG+N0jrqn9ZxPzscAM3BzA+0rPsx64aXB9+LZd44wm3h3Pt5ZaJnltgiSvoCaCgcb9NvgY9REzniFzzFzLuwDadZPSsXV7pLJ/y1/IkMWY/xu/IHFjJnp1retPBiSvsyefrtJV2or90/O/5U0bs3K5a0+EUzUedLd79BDagEv3Zo5QE7Y/EXTzDlkS8h6k8cx/dCfYt9u9wZmEXe2DGi81MKxFoeFWnikVI9X38xaseDwwd5oyoOCUPOt82sdbLQ+Fog==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DU0PR03MB9077.eurprd03.prod.outlook.com (2603:10a6:10:464::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 19:34:04 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 19:34:04 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 4/8] sched_ext: Add filter for scx_kfunc_ids_dispatch
Date: Wed,  5 Feb 2025 19:30:16 +0000
Message-ID:
 <AM6PR03MB50801CD54CE6044E66DB3FB899F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250205193020.184792-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DU0PR03MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: d85c7604-09d5-4c13-37dd-08dd461c0c6e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|8060799006|19110799003|5072599009|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dTjrjbs3f4iZKOyF1sA5ayB410StP54ZxTAu7Efohg1Wu2Z4VqDE3puG9Sc8?=
 =?us-ascii?Q?3Bg9WmNx4/USl3oDAIOHpqZPouxloVDU477YFgWjgn2N8PXTRTLDlEwE9wUv?=
 =?us-ascii?Q?UFAFPITtpVaImnEjWtTQXi+pKFnB27SplSofiDwFssN736tfutrtk7B1FrdP?=
 =?us-ascii?Q?tDtZpUsSJXvBnAlq+XDoYDrzF0UXddmSy4vJzx4NIYwQNl2Huhmp84YUqNcn?=
 =?us-ascii?Q?oLZi8vcbmygAsCxmv0kOBNYqVR+DF76hstUVpb0YVnMmw5BnvmSPDhUPDint?=
 =?us-ascii?Q?keVj27kAuN6DwqsCOOnW+p5ZSIZfBrlRKhC/Pkd/AwDgQOnn6BxaYdkMT3RM?=
 =?us-ascii?Q?NRtRwVbevLEkbcz9K0URM1UyhPk1UJh3uqgBwfNOo30JIPSwzKuWzXlY0EYQ?=
 =?us-ascii?Q?mCDFnPW8vCyb1u2IOEbG5TnxcnPbtz8bWPk42ZhBR0qJg3yoJ7uweg+ZNyOs?=
 =?us-ascii?Q?+vzYg1kTAG/fv9lZETWXGylzCqcPhISRstD+orCTDDTlyIlA13QY/bka/OKM?=
 =?us-ascii?Q?K44hbaTWnDNAXQD4RAAVKjlNgq0cLuWBjI6ufX9Ik78j6XvWq0XfTqbyLgdK?=
 =?us-ascii?Q?HQIwEGwIOxwt4FguoCoO3PG7cID4j3qaMP3jSBAzX1ID1KihqOYfGIm4+t3y?=
 =?us-ascii?Q?mKVkR1ajr8jep6xvcu9jcWMoS9sgRxOdPnyZN8EezbEcgjbbhcTKY0bkcUgJ?=
 =?us-ascii?Q?uS4o35+dj7iPpWctEvC1Z9elIkVHIF759sog8n7CdnMU6ZPw+2156zhlaPMH?=
 =?us-ascii?Q?7l/xXUZ0AqXZjTcYbt3BR7cmSkApsrDolfDHmWdH2CNdyjc+qOxF9nRQH1cR?=
 =?us-ascii?Q?rn1BTs0zxhmXjOwZRQ7H4l21o8Dihd5jgSx+GBJU+9wvHxTgehIUOzCK77Or?=
 =?us-ascii?Q?QhV2t28xmOKKa8I/K6d5G21EppPtqYjPt365jSBWW6PnzWbNuUJxtYRbZaR3?=
 =?us-ascii?Q?euBYa75cyiLUMvzqZwDm9uy9FrGuN3rxEN17PIzpvhtW+wk4FzDvZ2rEsIYf?=
 =?us-ascii?Q?Mn8uXMtzJNNqhe3FdKKb5mOpJ1Sg+kduD09JDaHrwvrlUotKZ7y3eJJ0qM/S?=
 =?us-ascii?Q?qUxqfTf4U3t6YLk82pCu55ASCP7yNQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3s0UC7xl1N0Rcuz6yMf4y/ZVe58JXHm1Ld4BEF7Jq+o5pQNn+Gr265cn1H4Q?=
 =?us-ascii?Q?7/npla5WUUpgeEVsRJIB33CeUadaNtbn+B1aWm9DpzpKxfy9uXza6/Sx9cWT?=
 =?us-ascii?Q?rxeSQ5NinMZTK8v585sqQlSriYva4DdlyPj55NCVs/AXVMbwchwlB+k+ppP3?=
 =?us-ascii?Q?+Prl73sxUHqPrNqc3GwZo3wE2DY8xQNwcPX2pFoRCPIOUPWnb+l6Bmqgq66w?=
 =?us-ascii?Q?VzLjKD1I+MpOlDiuop6/aFXa8FBni2te1NoJh2kZ3IhpEErvE9ZIcShigxpu?=
 =?us-ascii?Q?v0vbUvjOUueWfQreVEC9tdr8zHCjw2lL9I3UcW0J8xoLcET/9hGNMlW20l+0?=
 =?us-ascii?Q?F0lGFxRrmbiYbBB0WJKnAjyQ7TAqgcODH7rcxxPjIFPwOXiMZAEFcjZ+t1X5?=
 =?us-ascii?Q?ZgVjXJxcOTYjlmSkGvyIh3Qv1W5V7N61REkQ1uXeuIeVaihM5eS0pRQPePNz?=
 =?us-ascii?Q?z+iT/yXuWosHnG/4POfgeuvvjHP5o8XrokJ6SxFvpmGEryAF7KJlD40YKBoD?=
 =?us-ascii?Q?Z7yrnSAkavC8WYKd70aSHRx+gSagcEqbj/ESY5v0zuqbDadoF1w6BF6kcogX?=
 =?us-ascii?Q?lb3Zsk1lNxeiG7EVcVNMOvgP4rjS3Kki5rbuYBhallLqpLJdEWayfRTZRDRJ?=
 =?us-ascii?Q?yL9rMnT41rj182u6452GSdrRy/fRBjWxndeUQfw6vayBHV29oXUAo/2qyNlr?=
 =?us-ascii?Q?ak0MuTzuX0YW+HPQh/5feXqrUZLR5tHcJZKkOEmNutgbkPU8vv0pfMNy3nEp?=
 =?us-ascii?Q?DE4Td0a9VS1rCyce2vqqo2Dn//UEfB9YZhKPBoZeRuBL78yhekCsjehTBfR4?=
 =?us-ascii?Q?xSUMRUMOWgrFkMZAcskYMKReWocAxlyyMLaa9IljSicKkbOTJKXechnSJbaC?=
 =?us-ascii?Q?/6LbKpPE1pskdeUdhAEWyenqgXLiQGVlqWHkYdoGMBGkFH/O/8shv5uFNTtG?=
 =?us-ascii?Q?kX4VbPc0MpICx/sbQKUcJaWzOLCOmY5RmWC7txCLFUZ9frdYvPnQbBpIq8Ok?=
 =?us-ascii?Q?XW8nC2vhl8gD42mSGPgKwSeA2Xzik9rhHlJQaTKNYOUiOMor4BQV87D02sd0?=
 =?us-ascii?Q?DrklWwo0hXvp+gZAJFP8/1EFD/yg3G0VKD9UieOe9NhBZRTo4Bjo7+2EkXKJ?=
 =?us-ascii?Q?NCj1+tDg5EG3/Ek6TzYnjuzikcGp4BR8UoLzjU1+aFlYPYLbP72R9lCVX8en?=
 =?us-ascii?Q?M7/Zv8SS7RSj1e9lUav7zTcYKoBsgk+yp36xCxCa3SDJjIuttUaHy2V7gGep?=
 =?us-ascii?Q?UvuRmTP+LYV3BI5oxsHk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85c7604-09d5-4c13-37dd-08dd461c0c6e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 19:34:04.0219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9077

This patch adds filter for scx_kfunc_ids_dispatch.

The kfuncs in the scx_kfunc_ids_dispatch set can be used in dispatch
and other rq-locked operations.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/sched/ext.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d782ee618d54..caddcf41e5f1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6943,9 +6943,25 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
 
+static int scx_kfunc_ids_dispatch_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	u32 moff;
+
+	if (!btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id) ||
+	    prog->aux->st_ops != &bpf_sched_ext_ops)
+		return 0;
+
+	moff = prog->aux->attach_st_ops_member_off;
+	if (moff == offsetof(struct sched_ext_ops, dispatch))
+		return 0;
+
+	return scx_kfunc_ids_other_rqlocked_filter(prog, kfunc_id);
+}
+
 static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_dispatch,
+	.filter			= scx_kfunc_ids_dispatch_filter,
 };
 
 __bpf_kfunc_start_defs();
-- 
2.39.5


