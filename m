Return-Path: <bpf+bounces-37521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 985AF956E57
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 17:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EF31F2158E
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D01C1741D9;
	Mon, 19 Aug 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VeyGS7AY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NWEMf0Nh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983716C68F
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080318; cv=fail; b=fL8Q/KaMKt3PC2GR4Vlr8Hc9pXtdMKLPh5ICmTzMuoceXt2RJTT9vicmpGzsMSKVrJr6wkvtXpCJZufT4i3b/ps6Imp+58guM4siOs7orhVquEmMRyKCsqSh67di0t4Z7D+J7hH/ohLBuunGeluJMZZ6VIep8Cu9SGcvjOcrV9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080318; c=relaxed/simple;
	bh=M6viDdIvbBCln5EPHXmnhiqm24jMM23I+0M9uLRZLHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mm9VBdz3DnRFIi+X5Br+/fycZSKU1pPagWyHskUj9urQml8/3yZdPOFbEDdTWH/gUWLwfT4yAcOL3sbr0X8hJqZuh2vZRUs2gVyeLuR9gkylSqy2q17WIUGnD0QkJ9eQUM1mXif045GyXTRpmRuFkF4fFoxXTJGkKobcNuPISAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VeyGS7AY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NWEMf0Nh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6s34016701;
	Mon, 19 Aug 2024 15:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=2xqX1CIYywwAFjtNMGRk1mKfTi+Zu4jjMh8QXXiS9Dk=; b=
	VeyGS7AY308XaHeDaHvfOC2ZKSPkHoCYR1tMay627lIK7t0UYzzJfGeefCCsZ2K3
	6KEp8g53JGBRAzxzy1akZr8tFgnOymLWiULePdD/6+4DAzWxWcBGDI5PGsbq/yME
	J+dF8KKi2xagSMWFRe2wlaWt4k/qizqit2Tvm1jcbnXOIdsytZ3TG6AHcklisMKV
	JVASfMTjvuooiRTUK9wKgMlmmfCUkdKi1ZoFbQpJDpn6+pClq+cKzEhh/qmMbcD3
	O4AAtkyCaumniE6JyKR0Z5dpBnufN6S8oslOqC3yAweyuMZRea+dEC3U2McJkKJM
	8XGmDYQq25rUt5+4N2XU5g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdstudu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 15:11:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JEbHWu030779;
	Mon, 19 Aug 2024 15:11:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 413h9bffxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 15:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nD0028eA6VtA67le6zuLMfb3wec/htQ5nVKqbfZtnkytBGRe4OgbdCAPH7sqZbaCYprfzhvGXdi+GUDs4ymI8y4WbjTpWzHIzgwIDWM5lm3YporzNBLD7QQJH04VP92xbv0f5RWaBD1tsnUJGXje4/xJKhmbnWMLDa9trWcGUK5VB8TlJd9IohyeMtvcncDeCfPSBMexGYkLH/R1pgE1c0LAAp/+4pU9DwRn8pseeoD9as8qD0ZQRw+qx/9xc5wfOHctu6YeG9nkyXpY7vDaQAT/I+5n8xS88Dsxti3/9+ifsAQ+ooa3oEQs2/4z28C0oNDXHKFb/t3s0+jflk+Qlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xqX1CIYywwAFjtNMGRk1mKfTi+Zu4jjMh8QXXiS9Dk=;
 b=gJkffKCReQQ2RXHMqYK4Xf95xKUPtdZvfGTy1ZapuQLlojuVWmYRQhFxx+hqCsvgorV2zyuH6BGNrjcwDdHQ9HjF9lbWOTLLrVmPOfAmXkwzrWbovzMWv3iLAyzIqmsSMzHM91CFnXJSDLNJxQEpl5HBx5sEMOcds30woz2PGGWKlgufVNESmvHuIl3ho8ICN0hGTZfn3LSwkrnZaVQ+0ITrnVuP1qjHKeNemcAJxAg++YlfqyCLT59NgwNtpGMHAfrNMCkkbaj4AUDaLQOzobGuVKJ76Y90W32D/0nX5hNxlrR6NDWt8w1X65RGFhw0MjdjFtyoUcm5zYad6knmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xqX1CIYywwAFjtNMGRk1mKfTi+Zu4jjMh8QXXiS9Dk=;
 b=NWEMf0NhSvVkBMDvnCPsgil9OF0G6eZCwf23h+57TVsfqkN62n6dv4hOapX0QRqVVehfXr37oDHKM6GgIoahLU71g9GarGNSajm49uFLr0Nbqgk3AVXNkZwsKSFBuD0FeVhmD5Q3SfdWw8TgO0bdZBpVEcVK0U3tGAffr2SKxiE=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11; Mon, 19 Aug 2024 15:11:48 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%2]) with mapi id 15.20.7875.016; Mon, 19 Aug 2024
 15:11:48 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Leon Hwang <hffilwlqm@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>
Subject: [PATCH 3/3] selftest/bpf: Adapt inline asm operand constraint for GCC support
Date: Mon, 19 Aug 2024 16:11:29 +0100
Message-Id: <20240819151129.1366484-4-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
References: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e9e702-3237-42ee-dab1-08dcc0613ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SZIdQbFnqIA5Csaj87We6l6jlgTbK3aHL7dU/XBXjM4e0E/kkaI8l0aU8Mpk?=
 =?us-ascii?Q?6kD8sUKc3BrkKAT6v0OSjUK9TW9nz/3wzQpNtnXRK9bDbfoSMwPE28PhC6jH?=
 =?us-ascii?Q?jIAuvBFArWrJP7jUu9Ki3K48cQI9XKMAqmzX5lx4YpqAy5w51J6OaWDwv6XW?=
 =?us-ascii?Q?rKlhsR4haPfQgmuq+IkcUBtDvVuinZfAXHi1eV92ZswJ0dlTD8Qzzu9SoJ/+?=
 =?us-ascii?Q?5zMwzq/lhXvl0fx20F+AmUPfnjC+TvtMob0xuXLrFeGJr6jCuUZJJuYBP3+M?=
 =?us-ascii?Q?dmsoRrUO6gblSPHUV01dFtQ67umcreuVBF/4qN7GTjC84QRZ8/DlI/hubwAl?=
 =?us-ascii?Q?QMLVr5CYhw9OgpXZBWU4TBjzQapWu23D20REI8UZZo1WNX5PvI0nKDtIYXqq?=
 =?us-ascii?Q?Ekxmp3uAe0nzZt6GamRNAF4vUXTUxjpMpNOlnsSLx5MBIEFjyCs864qJJodL?=
 =?us-ascii?Q?DXvymxvRm3++gf1PsQ0MDvi6YPh08aGSwafYlkAlR41NNVl0btPp6DBjd0tm?=
 =?us-ascii?Q?bb98iQI3SERMvCpeVkWULdRlCEMAnZOCxWaNpRii/4DxwKhBrBSeEtm1QHSx?=
 =?us-ascii?Q?K96DQ5hN9eI6ipCwrtz/mFQQb6uM8ucP22uU9DS8NRXXeEY43M9hDVtuSv1G?=
 =?us-ascii?Q?L8IjvVcvyfZTeX+FA/V44OAJ4ihc6crDoG66Tgv7/r06NpK2ip7d1DR1xBPa?=
 =?us-ascii?Q?awfbxr1PJqm3N0XRJrZkyVbHQNgQymEHiIDN3k4mvtqm1BxurFDwE70hzQei?=
 =?us-ascii?Q?xTLAW8IewUR+CrfCLl1eFOprI2yxW2KbqQd51APU8VWzadwZSUJ6HSYK+cIO?=
 =?us-ascii?Q?oq6ObZsUdLFD8z6pwa8yBA3+z2CD/l2KaMA+sW3LVKuDZ0ScVvyde/0HQvF2?=
 =?us-ascii?Q?kR8g+OdfLPsalwAm5W3MKMXRhTRUkyKlpfX2laZMvWJipIX82sbQ53hmlljA?=
 =?us-ascii?Q?zIbTdlQRBBhaz+5BMcbkAvHj0kpGL8YOMxNngbb5EZMRpcsePoWVoVNdly6Y?=
 =?us-ascii?Q?Y9R5nV4iKwjGLwHQTPW6K2t/9ZAg0g2GFSWlO4MXqbQ2T1qgMoY54aXf1gIc?=
 =?us-ascii?Q?2V7d831pu80wFegpByVndfE713D/hTgayvBiezs11gl7iPzIFYYa3i0TQZeu?=
 =?us-ascii?Q?4Oqm76mQK11bjRKTaDF9ePMgDnOA50tyPqtLlJ3sEeKofQxdlqeByPm2s9Av?=
 =?us-ascii?Q?ZcDrnirBjm6r8f8TVOUNae+PrHNgk7Ccys0Bx11RQaom6HNZusxN1eWYYXX5?=
 =?us-ascii?Q?/zcE3NfiHKab6A5oNZVS7h5sDVespWZR1NYH1Wat+44fZ06neBNzeQeibcEb?=
 =?us-ascii?Q?jBCljTCVpUq7yvVfE1VR1U6lf2xK54gKpnMFPpAkHY2U+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yHPkjXrswwsM/0Vd8qxpF1oFwOABdev6YjXZzqVUZkaMtBwr/fC86v/WNyud?=
 =?us-ascii?Q?VSSOORhrDrONmq30qD2NbVgfsos6/TC++WAAMpaUtPf1ZHRyKYyPUsUZ4VMZ?=
 =?us-ascii?Q?waEskXBKeAR1DLIUa/NWieAvEBuR7DQL9nKMkDfKd2wsRExnDBKBD+88nrmk?=
 =?us-ascii?Q?SSyVDIRLoW7nrNIa4F9Pb/tc+UnJGg5jP/HfEynlbUAHCPzbUKCeG3M5Nuz2?=
 =?us-ascii?Q?gWnnx5BupEBsO0UoBSiE0WW2iK99TfxxFI9eipn0NWADx5KA0xiQWpqCTuMD?=
 =?us-ascii?Q?WcpwLAmKjQ5/fcdBEUDDiIcRFBHElaL61CCxwmODrXeFTrhMqIoWP8uZkWQn?=
 =?us-ascii?Q?rgbjdSaXBg1Y1hkICAXSfWgUPpsHBd0yUK3OiMSwLlTDkFVgFpxHIG3QjEkP?=
 =?us-ascii?Q?ksFvt/DUozWHR6vpNGArJJ19jnJpJeS1sehiKFLd29UdScLneaj+IQ4qJ3hG?=
 =?us-ascii?Q?jMyiWo2tNrJeDdKxlrgFSfls7oMt181FQHfaStctEJ1n7CXteerCrRXBxQdj?=
 =?us-ascii?Q?h4zJ9RFXaZXTt5JmP/fvjmcPtb1M60wNwFbKGMiIeTxa2xgriS/NB93NeyUG?=
 =?us-ascii?Q?Es2qTGU8kDijxSstqy4XygkPVdfN1rE3Jv33hTx/zLfZEEJSiAwvts3fepcI?=
 =?us-ascii?Q?RBNF3iwCqbm+Aj7OIlE/8zEc9dnj9srcF56aENZ0o+jMRAaHajFDyj+wNLWS?=
 =?us-ascii?Q?k+he3MlYW7v9CFw0mXGUiFhH96u46FYRP/zl5/OyilyeIMrKYNLbHLUaGsS3?=
 =?us-ascii?Q?T9ONVFQDme6nG/BaFxPi4BN1vRLdq8eoljxBflu3FqYsVLgQxCvNGWvkam5R?=
 =?us-ascii?Q?tRrq3PWG2UNrhkvlEtFUWBtH9SC/+rRmNVvlxE+h8AeIbE1PqmUh4RudpdYK?=
 =?us-ascii?Q?9om9ACsrdYk9pXtkemsjuMi5i6muGVYEFLinzO6x0ooZzAH9WFW7ZkOeExyK?=
 =?us-ascii?Q?zGVfjUhiXQOeXiZV/hHZXZ9cjzDjo6k6/DH1Jkp5ZLYP98cO9ftv1pHh6pg1?=
 =?us-ascii?Q?ordK76WRZ2pgFlZ+I7lusF0Z73YiYeFgB5eUXK/NnnOHCFbIrB256pUGDZAH?=
 =?us-ascii?Q?uiGQMLVc+uZFQ6IHKdSZD0uZUvcMoXykhlpHE8JIq0IA1qJx/CbU2nP+9Jee?=
 =?us-ascii?Q?r9OJ5O8+SVOfTYHZGFBCeyjxJaKtog2pnGoExZAiHJebnVK3I0ZicJeQucGW?=
 =?us-ascii?Q?Uh8eI0MJmP/O0wAiOIw0ctHh/wkGYFPxNynZ1Dl4BYnWAIYQK6KO6kUfR6o9?=
 =?us-ascii?Q?lOUoab+L+c/jMc798Hi03w4IbDRCUh6hKut+2Hn4+gped2XqtnAHwGpNO+ad?=
 =?us-ascii?Q?N1KFvyxxy8Z5EPsB73gljQLDRWtdqO2GwzfjBu92GyyWH3YjVrhNEBpT7glE?=
 =?us-ascii?Q?JMJ8nYoGvhZKbq+8YM8axlzX7XccktpVrtclSY1YE3SMWX69vvqjVSKz303K?=
 =?us-ascii?Q?404FRMfLTRbZHz42+hkdR+6tt51UeNMSrARWvpw+grNRk9qlfBXqOGWj0BLF?=
 =?us-ascii?Q?GFioKmbGhBFUNHwZfj1wrVxedTlEJ/lW5EUiGOKwXK1V7uiVWfMf69udylLX?=
 =?us-ascii?Q?luAVV6WwgX0+lLppJOPqsVjyuj4byJA7oIqDqcid0TWjka1jsy3E7+REdVss?=
 =?us-ascii?Q?W9HTadMdnMLF/4QmmGWukEI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6WC7sI/1cdYx3S8uKcL14OG5HrQcCaIFY8xRzQvW++kmPCB3TXI9xy5GdTSm0j2BU8xGXu2rMx+x3S/KJb+NPTtz2kp6oTbWC6U9MXWf2sZgWQamaLDUrYyVzlEqR/nK/kFoMVknlo2sNSnErZ6AZeEWde51VG/U49zlE84h+zvQuFckgJStNJuDbpfjdkRxE04660IvI/qHkLsg3GNoB1Lbg18ahe47MZrHKDz2Qgz8K1WU0lW7Rp1OFVcOl2NQyvKp97O+wkBNPrOyoCoBg5pz43unbipRWIM9ImJjqdkRjkU1Gy6wVAwclYKMWUZEzYxl1THPHXvMpv0UtTtUttx2bGU1ZekQw5MN5rnPzndLZhYNYOfHzQRIN5TU+Gk/FTiR3A1IUuk7knUoK6geATeNSLtxFohtPqcxgyJKIm+7Shc+3YEfTl/uDUOfyofWnXoyGUTmOVapSX0tblLwNcF2U9L58xbpg4XFHNx0AcPAn03O+1O5Xxk6+P99BAuFhNWoss1zi86GAaTBCbx9X/5wyY77JCAMh86L4LySoDI8GGc5LNgdtP5fz/I6A5Uv909GYNu19kNc2aMi3y7eJOR8bDxpmz9S30wWYAWEpak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e9e702-3237-42ee-dab1-08dcc0613ee1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:11:48.1167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9es4Lz6+2BnNjV2CbI/XsyADeeJYlLIel7eE/3UfKRs+c/NngBAiZIHW03vZk9yJ3y9ZnO76ffyBLl/zGN465tZS/cUcZIpEPssDoBqhHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408190101
X-Proofpoint-ORIG-GUID: vHJvVDT7ne5_Sd6HYMLJNOQT9SsKdyu-
X-Proofpoint-GUID: vHJvVDT7ne5_Sd6HYMLJNOQT9SsKdyu-

GCC errors when compiling tailcall_bpf2bpf_hierarchy2.c and
tailcall_bpf2bpf_hierarchy3.c with the following error:

progs/tailcall_bpf2bpf_hierarchy2.c: In function 'tailcall_bpf2bpf_hierarchy_2':
progs/tailcall_bpf2bpf_hierarchy2.c:66:9: error: input operand constraint contains '+'
   66 |         asm volatile (""::"r+"(ret));
      |         ^~~

Changed implementation to make use of __sink macro that abstracts the
desired behaviour.

The proposed change seems valid for both GCC and CLANG.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: David Faust <david.faust@oracle.com>
---
 .../testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c | 4 ++--
 .../testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
index 37604b0b97af..72fd0d577506 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
@@ -58,12 +58,12 @@ __retval(33)
 SEC("tc")
 int tailcall_bpf2bpf_hierarchy_2(struct __sk_buff *skb)
 {
-	volatile int ret = 0;
+	int ret = 0;
 
 	subprog_tail0(skb);
 	subprog_tail1(skb);
 
-	asm volatile (""::"r+"(ret));
+	__sink(ret);
 	return (count1 << 16) | count0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
index 0cdbb781fcbc..a7fb91cb05b7 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
@@ -51,11 +51,11 @@ __retval(33)
 SEC("tc")
 int tailcall_bpf2bpf_hierarchy_3(struct __sk_buff *skb)
 {
-	volatile int ret = 0;
+	int ret = 0;
 
 	bpf_tail_call_static(skb, &jmp_table0, 0);
 
-	asm volatile (""::"r+"(ret));
+	__sink(ret);
 	return ret;
 }
 
-- 
2.30.2


