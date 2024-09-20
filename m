Return-Path: <bpf+bounces-40122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2FE97D26C
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 10:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60084B23EF7
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9209078685;
	Fri, 20 Sep 2024 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i7ZA30FI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vR4zkkOn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596D6F2FE;
	Fri, 20 Sep 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820359; cv=fail; b=ddBotpTyvh488qEzn4XQ5I8jQg8akEthdMTx/9rbDkLZbg0gkfWY7+40ycebjmtqRNFGMw+kqQRJA8iF1b3l9l9WRxwnAHcFMWFhJqtfvBW/3yFp77fQEOtCXAM5cVz7Uwtf4hpj0U9/FBRX21PjItc33dTTQzAAFwNkBEaafeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820359; c=relaxed/simple;
	bh=6EZ2luigtO88K4R5Op/3rpy0CT8BTVs94pxIvz41LGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WQaHbDpW3NPnYxbjKOKmZSWZ9n2JAlv8ICpbrLIexDI4zrHzRA8XTrT0f7K5bd5vrF7RglovXdnnMi2TbvHi8EUoa89pQMfNUN0pgME8mYCbXHHT7YML7Du9rpGl3Be2TYCW6Vgx24fAiG/jYOKYdquyxoJG9+uIKQWohhQ0l9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i7ZA30FI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vR4zkkOn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7u3gr029014;
	Fri, 20 Sep 2024 08:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=mwl5gp7wqfaZGY7yQqD5/hsyLm8D/edNP5UlFYcrpA4=; b=
	i7ZA30FI76UPfVT53sPpo/ffrCeQcH0IowZmVCo48iu2+ag8gbR1vwZJAjqu6aeT
	+gkiQLC+rF8mYGuQ3ey3kKN3RWLfu1Y0YWjQ0wSJXOkGg6EFPzxK02P8sMMrjaUf
	D2p5y0qXR8eGc7jdQPozUEgFky55SCPtUxj6UJqU6Uwh/28fHWSUOhW7WojbCF/m
	w/LLDHF+YsbApJ/0XWRknJnAH49NMgoEUg+Et7jjbze7kzP5gG13caSWwDT6U1A/
	cb+NaLfKAMTBnEt5/4odJmpeMCbgkhOC4CqQvyvSgQYORU4B9VDLyx2PvJtd+Ehj
	H0ahLkCMVCcA/lVNBrlsFQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfx55y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 08:19:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48K6MuPo000430;
	Fri, 20 Sep 2024 08:19:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nye05935-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 08:19:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3ufcaAkODkQxnVIr+NgZTjoviKw8/eAdsNyt9N1gW2YYMfaYwQuoliBSLoioQCzxXeb7HySWPvk41RIF7lO98fdTPAC6bm94tAC5kZOf5kRqgIDvEt9TN15r826eJjJph48G1v2CAnzJVLZCsTgM5/dYqIsaoa5W1Zch5MwDRU14BU/niskOBA/iNSY0OrObmVAmfunHiIZQlbWnQX6ZSnwUHAebb879J6VxSCgAiAjyyoMjpkiHHSQLT0n8MBT3VcAgvjiSKWxDXOoikDdX0yb6ZrXjd8gsQ/wEN2WQRcsbPIjFk3VNSaP/LcdrruichVxkZL4QornxAEQOnVSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwl5gp7wqfaZGY7yQqD5/hsyLm8D/edNP5UlFYcrpA4=;
 b=raZ7hH6oaE2XgMt5ixdyHDBqRbdYyH3J4zHkPCf2edrBKDVkBfrQ34UTFPHLgbuVjmMLoxqjgpkr7XYwFNX9rLsUKkyZysLJp3PxMdQRVCdlkn9Smr0hvroJNubGjqu061SgNMyzIsaD43gIh8vXaJUKpXg0nlcuP2WOEldsZFE0qY904VRb1762VZGyZN0i0Arv9jivZjKEthqEPLbQABs8RGXrYbDIqAWbpg3wjiQfgLQuj21uLbpDmmlGGmfz8KIoBjpwIl5jx/u0cxoMvWqA1eGhX2xS41WIRfcQDqwIzbvf+BwAQfHODE38CiSread3/V17Ze1TsnNPnysNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwl5gp7wqfaZGY7yQqD5/hsyLm8D/edNP5UlFYcrpA4=;
 b=vR4zkkOnHwNIGYeiKq+QF5vqtxaW1PWzoveRfV6Zgs257J67NJM74zd3dGtkuSVQiLrJOmE6attmPxO1+T/Gh0VjUtQS61l/z4hNm4k2bkVgcUxkScQylW2OWt+9Cyrpa6PR05FhgNhYo6cMhHpFutD29NhWDQA4PosW22mwOy0=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DM4PR10MB6037.namprd10.prod.outlook.com (2603:10b6:8:bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.9; Fri, 20 Sep 2024 08:19:10 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8005.006; Fri, 20 Sep 2024
 08:19:10 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v2 1/4] dutil: return ELF section name when looked up by index
Date: Fri, 20 Sep 2024 01:18:58 -0700
Message-ID: <20240920081903.13473-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
References: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0042.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::31) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DM4PR10MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 57de1ac0-6172-44bd-4f44-08dcd94ce78c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xdLAm3apnZNmSZuJ4HYGYylX2lf42wAno7WnxzEQxf6Z6wZShLoLUiUgejFr?=
 =?us-ascii?Q?pWDPR/FPtiP+POoRvqWpVMxnx6hR8f0+1/a73N3SVDswGS21Sxlppg37SE9X?=
 =?us-ascii?Q?Gx2Bw8PPZ6DQskaYyvwNvCqka8R1/HRbhImNcffAHtkBmCZAdthgtB6mxAeh?=
 =?us-ascii?Q?yt4hUfMqoCXbv8SGDOrjjtEcD0T5VaOMx7b275j6dWqXKgCbdpxMZpl1NpXx?=
 =?us-ascii?Q?4b5jsjZBMKSr2Kx4rvLsWs90UWlSAQcA0g0kql1nRhQ2ng/uLadVyzM/TG1N?=
 =?us-ascii?Q?LLbX1f0dRd4ejRc04f/Zxcry0wAL/UVMlcmYJqjnv6eH8WtCvsLIZJDtmZPf?=
 =?us-ascii?Q?vRgWOIF3npfYsaAw68Gwz0ciDBUfDDF4Z9nqN5bC8QR4hS5TXnWgQ1We8OKV?=
 =?us-ascii?Q?9ajK6hwUyfKDHx/eVSKntUXichvqFOItvtG3VzWlu3d+xnE4Zif+F7t0zfPQ?=
 =?us-ascii?Q?f6IiZPEwmCdcjGSuqe+axQ9iXhC0wNCReMwfKdmEyMVL5vw2JnBEN9L6YmDM?=
 =?us-ascii?Q?COblvpU92W/DGEAcBVDmJyQ0QOYQCRNm4VYRp2Jp2PNDp779lMD+4VjpwbDx?=
 =?us-ascii?Q?D0hxtF8j7TTrWZenbqAqnxfD1vp6Xi3Kfscn2BcrtRnhD20TFdUH80lRN9zJ?=
 =?us-ascii?Q?uJqwKg43Wss+KoWihGbrZtszNgdr7/Bcew6P7eMZZ93RPPG+BM3qLbrvpWUV?=
 =?us-ascii?Q?zq6GXevM4+U+5B63LbRe9KRWPqmBJ34uG5uk3a99h0z3YYvoGbksyyFWBH57?=
 =?us-ascii?Q?Zj5EjhtXDbOWb9CafuiR5dRRDo4fCpw5Fiw2TNpscQ3cXW7COYH2XGxGExYx?=
 =?us-ascii?Q?X44ZdTAOAwhoG+dwLuYlLiEvgsEZl7zsMw3rD2Vtrz3mUw5E08BTkdf1JIk6?=
 =?us-ascii?Q?35+QVpje6GsS+L/eCi6hqnTfipUXo6wEMtRlY/G3VQ6NWLi3KRNNO896ynE1?=
 =?us-ascii?Q?M1D0UrByzdEG6Yvxo47VllsdUYjvKGVYhHJfT/Q+qYPpVJI+SQPmjRcexibn?=
 =?us-ascii?Q?bH0LinO7S6EeKZ/l/tPO9SZJNm2ZjqSHzNxOk6PQIJufFAK29cFoMRkNl2xJ?=
 =?us-ascii?Q?zN9ixQj/MIgWdka2bMiyzlOK2IC1IdP/NYqFtgIOJonxG5Q1cwM042SJuCwX?=
 =?us-ascii?Q?fBY9en2LJ/14QjgMdKnUCwDC7TBm19q6VhPggaeziuSdxPGQgiQa2ltu1HdX?=
 =?us-ascii?Q?VnxBxsukdvOQcyhKS1IH3mMBCSO0qRhjcu9DEb6kdL7v8IP2RgM/BR02lFwL?=
 =?us-ascii?Q?LvBvtHns6XKc62DWOmaMwygkVfk+iX1iI9T6KI5xnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/1DWlky8UAXC+D/i3gUBEsklwAAI1rJzUpypN7tE9ksPwQ16YkPF9wGfLC5?=
 =?us-ascii?Q?7mGT3O9zT3HJVCzwUCgupE0FobK4DeEK9CQL6I0E5VPDhSzXpzo+jmrGdltZ?=
 =?us-ascii?Q?08B16/zijhvVJAsj3FFjYKypf5OhGzubv3MPeYmxsjfCEwEjzcFbHzEhx4fD?=
 =?us-ascii?Q?hrOcmyzGsItPRgv7A00XrT0A5hKCxBT+nSlv8cQsVsjKnOE4TRyT4i8EuM+A?=
 =?us-ascii?Q?8cuM2XwczCtcfxrePdKOxQRlw7EzZE7RFo0nnM0hs9zra82TLiGtAbzQcacH?=
 =?us-ascii?Q?Epl4ey2MLMxZxiyQTEa9knXSVOZ9eZMj5u6CuVemPSAd+1tIHojLJuwK0ejz?=
 =?us-ascii?Q?JBnFpKSVun+Fhdy+3DhNkYYg4PG1zzRvzdN8vkhbnbecX4b0zL0YbJiUU9zL?=
 =?us-ascii?Q?sbZXkhXMEQ4L2TdA5Z1Dex06oxH0TAzzmqT+QLaLv1Elgc0kcrqbVIOPgj+v?=
 =?us-ascii?Q?aDmy33GtZfrK8aRe07jq/aSVWFLTJ4G7TPM8Alrok7yli0C7Y7Wld7cCBQtY?=
 =?us-ascii?Q?hHKIEqrEwjpEPHYYhzlqQKsyJO23Pu8RVg1ZCJao5tYUUOUB3AUApRVfBnbw?=
 =?us-ascii?Q?6u9dzspBBMvgbCiuuN08x8bzIwkZwTO/jBZ1s5QaKFEfpxjaXlQSqwlRPdo/?=
 =?us-ascii?Q?Joaxo9V4DAhJtHcMuEQVWeV/IWuDShIMmzX7qsFpvFTMVFbPo+tiQ9kzhhcj?=
 =?us-ascii?Q?LbIYcpNMD9mZv1+4YMOEj0kHxEfmUV0L78SWGkvgb8f7EavxHviUZcWIDJTH?=
 =?us-ascii?Q?jYsRFsWdWIGtWW5ZqG79yoAeAcP7wvPTRXU9MYLoAWs5pFu8sRCRXq9TC8a0?=
 =?us-ascii?Q?Zjxl9y2ejWrhdVY2kU/H4x4pugdzYanScYxen71n8Y6UTn/n7J+apmCR28V9?=
 =?us-ascii?Q?gcNCsax9g6ouz1lbOE3MqrVu5WxSaV/WAWwBwDq4yi3DU1hTzKJNrM+j63Ax?=
 =?us-ascii?Q?fZdtnZqfoLOicgZtAWzokQzpY/ORH6hDa+nqhHHA2YVyA0LXnmUYIo9E41yE?=
 =?us-ascii?Q?GaE+oGyK4c4xEP03JtWFyms0ugx2xTa9+LF6EDTemXO5WOK6qIFJatN9XFJQ?=
 =?us-ascii?Q?sx29gwOnCJYdv60DVHE/EekBq66g1huGfmRB+nYSKcanbfGS1Yuw1hbGXUqB?=
 =?us-ascii?Q?g0FDB3iLemoHlu2+Zjzjef6mMljztHkGW+HHqkMkWGFV+0bkJTgXjeq0/+e5?=
 =?us-ascii?Q?rDhdxxdUlv2BspIKjbpQhJrbL+tXDSsYArzvYmMl9VKKM94MJR1Qms6PBnEk?=
 =?us-ascii?Q?q4+EGxeoRRievU4436tilQ5amFgs//hRdL8dq86n7XWZz4ZVEEGOG1T/vUmd?=
 =?us-ascii?Q?drtq3tvqIVNeEAPP0LOCA3lEwyuxUe5MJROIm0GhHDYgJeGmiwupmRexWEIL?=
 =?us-ascii?Q?c3ClVrz9B5IjsXxuvrYzIwaObWWmqsZs40QwrNwYz8ri21PKhWtB9DCfeaGT?=
 =?us-ascii?Q?/6/5LiBAUUI79S+sUXjXqng8BpeSdI6OXDOUwAlP8oYDTjWbxmafke+ZvAwN?=
 =?us-ascii?Q?5SiN+/QbSrJLiM7W77bQYcIS4Ml9h5bqtwhfCu7OzluxorKPtLSP7QaxwOFN?=
 =?us-ascii?Q?8V+ZViZik5ckNS2l2HlPUTFwprf6gBC9JI+lOwYgif+gG1K58IkDKfMnL4rO?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3FTOX6WnAzbn31LInFBZH41q24PD6AS9WDee/D9ds3a6koOU5HoLKK4qbXCkGzdjonLWNdpnNTbIjgRsbQrJtk8JCzfZj62zGyWL0NJDK6CJTnhGf50YRMQR10F2lv8S4QxaA6cbl2gqXJO5vahPulVJs8i7+lsjFUsNvHePMGIfkxGaxg16zM8McZ0UHaIHUou8Ey/1Csuzj0gm8IM0hfWoNTdsjaJR6bGJvx8p5f4BH4UYsE4iMMt4S0LdtdN/3T7kcrpnt8xLyxUflAWHECw5SZsia0npsqLWM+d2YwQgVg8WOJdPyTAsBdI76IxKLjbnFOJ/74gT4hNzX28/lx53SfYifKr65DjyurpIDTOYXg94529B13yJ2dqzMy3xW/AjGtBl/tTvYnNPlNSDubKMUY86CmLz7u8NYUYdem7f3yZbCnt4TedFgwznx7vL8m07TAaxZOvYwl8X6zbi2tfcsOQb1vGYmIbu2ujVZAB25L8DqTh2BeILM80ZvDyS5D5WETfOjOLqhdwjFGxRiEPCmAQQsgvVuqQ7yUEtSjuzwSR1j+P/Tj1yQMDZui5lEFIadTMcoruevRilq/DJYDw2xFN1a0GxCbKmUp9aFx0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57de1ac0-6172-44bd-4f44-08dcd94ce78c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:19:10.6814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkzRWAa5aFpJm74WQCE0MuR3AytyF6rvKl1BgAmVlZs5qM1tAMAz4lfrXCc6SpxHugoPT/tVcbeS8/kggKtL18500uHjdkkp5bwUuBMEIhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_03,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409200058
X-Proofpoint-GUID: s7zCS-Wit7Fqx3RItXxyHCQu69gnAymX
X-Proofpoint-ORIG-GUID: s7zCS-Wit7Fqx3RItXxyHCQu69gnAymX

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 dutil.c | 14 +++++++++++---
 dutil.h |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/dutil.c b/dutil.c
index 97c4474..14f1340 100644
--- a/dutil.c
+++ b/dutil.c
@@ -207,13 +207,21 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t
 	return sec;
 }
 
-Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx)
+Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx, const char **name_out)
 {
 	Elf_Scn *sec;
+	size_t str_idx;
 
 	sec = elf_getscn(elf, idx);
-	if (sec)
-		gelf_getshdr(sec, shp);
+	if (!sec)
+		return NULL;
+	if (!gelf_getshdr(sec, shp))
+		return NULL;
+	if (name_out) {
+		if (elf_getshdrstrndx(elf, &str_idx))
+			return NULL;
+		*name_out = elf_strptr(elf, str_idx, shp->sh_name);
+	}
 	return sec;
 }
 
diff --git a/dutil.h b/dutil.h
index 335a17c..ff78aa6 100644
--- a/dutil.h
+++ b/dutil.h
@@ -328,7 +328,7 @@ void *zalloc(const size_t size);
 
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t *index);
 
-Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx);
+Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx, const char **name_out);
 
 #ifndef SHT_GNU_ATTRIBUTES
 /* Just a way to check if we're using an old elfutils version */
-- 
2.43.5


