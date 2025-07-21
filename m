Return-Path: <bpf+bounces-63909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0C8B0C382
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 13:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA451AA4B1F
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF52BDC14;
	Mon, 21 Jul 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rKMprf7X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zBgswXCC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3B2BE63D;
	Mon, 21 Jul 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098102; cv=fail; b=Iwx67QgQFElncWgYq63Bdtuomy5ofWUsW37ba4lrE27JrInWBoKuBGyy5hjDkLg3rA7lvd7e/A+PFd52lPfrN0vBq117s8TUyTg3e4soIpNt6C3T5GzxIJ0QCZq6sYWYdMR2oF0eDWtYicTz81dwYK0WzWnL7izTrHKQYIwNPOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098102; c=relaxed/simple;
	bh=pCICv9vVsI5+wFNOnIv1QKcgo+VIviwnT+wjWeveqKU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Asnzq4lZ8a4Dqoolyz3oy27cw9LMFLQHK7LfN9mx3q4hHwk5XPLVKlDpRTX86vjtgkpG0BrkuUEAskXiewvZewA9/5tQgjoFiHRIqqw74kZGiMTiDY8Qg3xIfti5e8hxn5DSg9QGaHVl462Z3XICw22p+eTzvhIEHDBHdgjszjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rKMprf7X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zBgswXCC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LBBpuL011931;
	Mon, 21 Jul 2025 11:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HcIwLI7Iv5Z/a3Z1BP7ob/QFUml5+iTBrzIE5OLQLZI=; b=
	rKMprf7XfRrMSx82xfSIZ617h/MYfQyQIbcFMjKK0tV1W4ShMbWIH8cwgqhluBwT
	Pt/Z7vkY4LvkRV4lVD3o4D9dw5Zds/0ya5DSmxCZTKzvtsrlLlWshjbaFVDUcaVW
	1nf3AUBsPrTbwWZUE4Vi026cR1rt0wf0CkSFjQbR6vTQuteAFlherKw3Ko0RUzlQ
	BfrmjgHPoz1fb4L2nQCqjAuv7RSJ/j6TEoxaEx3JLYU1EXZFg1fqvll1Y5CqMQEx
	mkY4esGUcC/5UWHI6QSPh3KPhIH95WIN+Scm9UABr7Bmpi8hgGzex+BLiWEn0ARE
	kFNhP5k+39ckNlxn3aKATA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx2d7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 11:41:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56LA8F8D011001;
	Mon, 21 Jul 2025 11:41:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t7x12w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 11:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWHW717iJFADVztsTaL2nxOQPqelTvfxyr+HoPNC0du+iX6mL1ZGsSCpzB0BwGAVQjFu5WbUvEple3/ALJbZ9dR+Do/Jr9T1KpSsr3Mr7z0nMpSW07WbomJsxlfDpGte56cLjgehG8GU/no/2kjbv9y8QVnGCGCwqpRmw4QegHWwzBm8pNusqLFsiqStY24zMqdns/i1CDz3a23hHgrEF1LJbev3VuSUyJQO7LY1UQFKrsb5sTaAoJHfB8QWRxY2hmmlL1z2fYJWfYjc1gTnpKU9tE7hoJeDpGBzKercBq9hrAlHTo6JNrfsinOGIffApsJxPFVHgDYnMT58zqrHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcIwLI7Iv5Z/a3Z1BP7ob/QFUml5+iTBrzIE5OLQLZI=;
 b=BkAqoNZF6tYj1jTr+EmlGiXBV3DHn3NPsBeVhYvNN1VkKR6IUXLBU5FAULlMg6s1jkqkhSzr4Gvb4tGPjmOeJWJKl5TwTZ+uvY3oB1BcWipeBBD9RBiDe1DSlYNIpWthOkv35EC165JHTd3GSpLpiIxlx9MaKQR9e4PL7uVHG41HFe1dQkCBTXK0ggaSvw/mTPh+lEIYw8jX/9P7ApBaARIo8iT9avw/F+nsHRrlW81j9Ibiqim5+auTuV86MdtluqAMMsbhRWl2XderzqjqSE5SQTgMSb0LZ5DeE+2QcvQxepIGYrQJ9QZ72GVOsF5xErGd7bNVjwBK+sUA3ueJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcIwLI7Iv5Z/a3Z1BP7ob/QFUml5+iTBrzIE5OLQLZI=;
 b=zBgswXCC3RdWfinndpyzGPMtLMgecSchxFK/BPIEm8peT3GbsKJfTlY+zIGeLTYEvrAWhIusXahrJEpD2+KK+Za0rIgQqAOFfN1PrrOtqDQcIeod1N2Fgxywb4ytQNgzroN0KGaGZxxdAcR3EIB+K7SjYfLc8rbLZyVEcorq9Pg=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA1PR10MB7448.namprd10.prod.outlook.com (2603:10b6:208:44d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Mon, 21 Jul 2025 11:41:06 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8922.037; Mon, 21 Jul 2025
 11:41:06 +0000
Message-ID: <e4fece83-8267-4929-b1aa-65a9e2882dd8@oracle.com>
Date: Mon, 21 Jul 2025 12:41:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC dwarves] btf_encoder: Remove duplicates from functions
 entries
To: Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20250717152512.488022-1-jolsa@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250717152512.488022-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:208:1::30) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA1PR10MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a7004b-e828-49b1-8c59-08ddc84b7acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDloaTV2WXJIVTZCOVUyR1NWSWNlbmdSKzRsWWJMTVduS1pZM3dqNFdxd0xt?=
 =?utf-8?B?S1VPKzhzeFphOTVmYmhpZmtVZE1oVld4aXN0SjRiclNUei9tWkpDSTdyb0pM?=
 =?utf-8?B?aW53QW9RVFRPamt1SFhpYkY2a3gwNGZxUExCc2hYYWhyeEtHT3d0OHFFM21H?=
 =?utf-8?B?dXA2SmRscmppQjNEWXNheDdEQURBQUloVjlaRHRNbXhNRnpVYjVXRjd4cmRo?=
 =?utf-8?B?aktvK1hkcWk0b01SempSMHJGbWJkNXhHT1dYcGhITmNON2M2QjhkYisvWDFp?=
 =?utf-8?B?cEU1cDlVNXQxTER2RHlkdDVXZGNncmpMSERXam1UYXB4MHl0S1NJQlJnYlBX?=
 =?utf-8?B?dHhhWWViZXluNUxkTmZvMDQ0c1ErOWtOUi9YVDhsVzJoRHpyTGk1RU5sbGt3?=
 =?utf-8?B?TVQrd1g0NlBqK01wdXg5TUFEU2ZpeVVzZTc2Wk1oeG9WSjdDYXJOZWZkZkFm?=
 =?utf-8?B?Y0RUYTBzcXNUaEYrRkZlMHY3UmJIM2ErQWYrRXVWSEk0dzFGNkh3UDZqRlZz?=
 =?utf-8?B?eUlVanhaVzdzTUtGMC9uLzBKMnJpb3NXZDBOcWdza09EQUZPaUpPaDEyaEVH?=
 =?utf-8?B?ZW5rM0MxUzUyNDVXa21KSzRXU2g3VVdkRnc2TTByOEhxVytvaENHcEZMd2lG?=
 =?utf-8?B?RUNJVWxmK1N0MHRUbnJKTWRvZm5sYjN0M0xpOG45RzdxdFBPck1uei9jUU9j?=
 =?utf-8?B?c2R1V0poai9BTGNWNUdITXROcTR4aDZXbjl4U0IvdGtwYWRRaEhuRWt6V1Fa?=
 =?utf-8?B?bUowajMxWG5mZGZNTkNaaVRRTWN6VmJmY1VKWW1TWjRWWWF6SS9mK1Z2WHEw?=
 =?utf-8?B?OWVWU2JDU0NST3lkL2hvTktMaXp6UXhEWGM3cS9XRGJ5VUlNajljRHVJb2pp?=
 =?utf-8?B?bzlhSGRLdm9hbUJUck8yNzZqMnFDREdiSzd6NUlUdXZvM0p2N3I5NWpCUmJw?=
 =?utf-8?B?eWZwMUQrb3NnK25ZZHkxNnFBZmF0SmYrcnB3aXFuUkRxRU1WV1dYajJhY0ov?=
 =?utf-8?B?d3pMbFZsZzBnQUIzNm1mWHZoNTdKY0hoVXZuMGN2bEJEZnQ5dUhFUURtS0pu?=
 =?utf-8?B?bHl4aEt6cjh1VnNneXJCc25YNkI0bDhRR1p4UXl3M3hWNXA5ekRRUVQ0TTda?=
 =?utf-8?B?TkFraEI3Z0dxa1g1eUpPSWwwOGxkKzB0WXVZbnZBOFNMZ0dzM2lMSXp5Nm9z?=
 =?utf-8?B?ZmF4SGhia25HNVo4dzdlWUwyR05kbnJEaEhPcG5Xb29GTDBMSHM3L1BsbHZu?=
 =?utf-8?B?Rk1KVXRDRFd5SncwNC9IY3V5ZXJjNW5kQWdMZDVVbEYrM0lQSWVFQ1JSUmNV?=
 =?utf-8?B?QWdkSlhqczFOTmxXQWF5Wi9HVXk0U0huYk8zNE8wVHpLOFg3NUl0OFlIMmNC?=
 =?utf-8?B?Uk0wN0s1bXVLNE1IWUROV3Vna3JBZnY5OXFKRVFoZm5PZVZabXRvaTdrUEZO?=
 =?utf-8?B?QmxmNS93S0hEclNFenNGTzArVU5jUWtlNDJQZFN0Q0ZlL1dWYkQrVVM0Uis2?=
 =?utf-8?B?SlJjZll1S295OUFpRUQ3dUNlOVk0ZXc2UTEwamkycHdiZlBhcEZ4R2IrUEgz?=
 =?utf-8?B?SVNKZWxDUnJNL3FWbGRUR0ZTNUxxTmhUb0VKdWI4aVZ0SlFZOVl1cXJKcloz?=
 =?utf-8?B?Y0RueitwZG1BRzgxMWlBdFNxRVdZUVppQ25KcmJWRTVGUmtuNDBlNk8zbnVw?=
 =?utf-8?B?NjgvNS9Oak1Ec2FLL2oxYUFpQWduN2RXK3Evc3J0SnpCSmMxcG9ubHFSakxH?=
 =?utf-8?B?ZjArbk9EUkJ5UGlUV1dPRmZuOGxOc3MxaWRlR2ZHRDFiQ3MvOEY2SE53c1Ez?=
 =?utf-8?B?UW5laGdNTlYvS09JZnhlbk9yRzJDekIyb1kxZTZldUt1ellESEtWell2UHZ6?=
 =?utf-8?Q?ca0ODcQt64eAp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2Z5aGpMWDNNcDZka3RtWng3aEpDTnRaQ0tFcnFvYVZ6WEJNUVJ3anRhY0dV?=
 =?utf-8?B?UDYyb2gwQVZ0bFR1SkVaZ0laNWZvWmxCS0VlMWpqbHhvTWVDY0o0a2hnN3Fq?=
 =?utf-8?B?THNGemgrMHBneHk2c0luU0dsNk1lZjkvTzRabThIeXlYT1IxTkJCZjUySmoy?=
 =?utf-8?B?dFRtcjdUT3l5M0psQTdlLzdTNkJkcWVDV0F2cTlTSkNSbVlWeit0VlZPTGZQ?=
 =?utf-8?B?ajljV0JpbXFXd0xNUmJTUFBpSlNxazVyTTFpQlliYW9CTWhZNFBmRXRXTVRG?=
 =?utf-8?B?MmZGK0UrYU1WanhkNUwwMHF2WStBS1NaTk1EMENiRFNsVUpzVEo4cHVlME9H?=
 =?utf-8?B?eHNFYVJLblArQlpxbGlDei9acEZjY3QyajRBNmViNWo2L0thK1dFRkh4ZEt1?=
 =?utf-8?B?NjNKb1dxMXYvdVZqdUdpdHJoMFViajcwQlNDU004UW4rTS9FdmJQUmxyMS9q?=
 =?utf-8?B?OGpNODJMdUtUM0dZRUUrQkxhM1h5S3BJb0ZqRUtwcEtMRXAxY0QwdWw4T2Fv?=
 =?utf-8?B?NTVYMEdLdzFhNVAwYW9KaGlySnBLV0xuTXRIQ1FMUFl3eFRDQTdLVTdxNDQ2?=
 =?utf-8?B?MGdGYm1wSWtyNmN3aTVzbk5VQ3NrWDlTN1JzcGtRN1FrQTdOZjZRbk8rZEN3?=
 =?utf-8?B?Z2xFZTVmK3JpVGdRQ213TVVpdzNvVFppWTNYbGJXVHpCTDNraFYzUFZpMW02?=
 =?utf-8?B?bXJEVGVHVURyRzNpL3g0ZEM1aURFUGM2Z25EaVF1R1ZqL2xKOTNDY1lWRE0x?=
 =?utf-8?B?Q0daTXdPamk0ck5SOWNzWGE5VGxqMzVVNmFLZHhWSHUzTXNMZzk1VGQydUUw?=
 =?utf-8?B?b0RYbmlkUTJMREdIQ0RCWWRZOEQwVnN0WndSMXpGL1Bmb0FYQjVnaU51QUhD?=
 =?utf-8?B?Z2VSUU1aYmpzbjBaVmNJSzQrNVl5emlCZzE3ZGY1dVFKVFR2YlR0c01tMCtr?=
 =?utf-8?B?L0t0OEdLd2dPUS9RSHFNVnZidFU5Mlp1UkR1cUtqUkRqN1l0YjFGQkhEOTZN?=
 =?utf-8?B?cGZsbDVtcXVPaWp0bmNxMnJOMGJma0NnU29jNEJCa0VzWlRyRStwR2hVamtY?=
 =?utf-8?B?aytFTEV4cUc1Q21vNytvL0tTQzZla1o2c2xXZmlpdzN4d2d2cW5yNEdVWHJx?=
 =?utf-8?B?bFdzTFcrczZQd0ZqYjlhYWdsd0crZ205bk9tZzlOeFVpUjBZTFBpZ3RpTDhr?=
 =?utf-8?B?OVNzRDAxS1I0bGY2SXNTZUJxd1Nrb0ZRRXVSQXpyU2Vxa01mUUIxMHdGblJK?=
 =?utf-8?B?ZWQ2OTBERHpXQzlYWnAzUjVKZjlWeHZNNGsrbFdneUo4bUViTXhKUWgreTA3?=
 =?utf-8?B?VFNkUTZ2V1Fnc0VZTUcxeU80NUZueTRyQ0ZWZXpRSUoxWWw2bFZkQlBHU056?=
 =?utf-8?B?ZGpjeFhxcTd2VlAxalI1eWFBbVhSMktqaVdEdTNEZFBjRUJrZjJpbjVJWkxl?=
 =?utf-8?B?OFYwTmY1Sm50Y0RNYkdDNU5hUW9FbVFiZEVRRGRUYUFhcWh5L1ozOStVN3BH?=
 =?utf-8?B?NEZCZGQ2NmNHcGpzSGNaTklPV05NdFNhdDVqWEh3UUs1S0M2aTFLREEvc3I3?=
 =?utf-8?B?MFliZlFSSC91UEpSZ2RFY2czMmd6d0lkZ2twSHJKcnNZNUttSFZsTlNzZVNF?=
 =?utf-8?B?R2dSTWVQbTl3elRCc0R6bGZMbW92RnJndnFXYUIwOVBNT1R5Y0pkeVI0MTU2?=
 =?utf-8?B?U21zZ3pQMXNJRGlkVGdZVCtDWkxnamZJVnZ6ZE00TmxtVjRleHM1aXVqY2FY?=
 =?utf-8?B?amJieGkxUUVtNUExdWhFRjB2MzE5U2w2YUloUXV0UldUci9XQU4wQ2xDTE1Z?=
 =?utf-8?B?RzBhNzdLM2pXalh3ZUNiRGpPb3hmRXNXT0laNk1Qb21BZXZxWVdUVU5wSm1O?=
 =?utf-8?B?b25xd0FzRGVzVHB6NFR2QWdPMWxQWnFmeUh2dkhRTzJ5MmI1VVZvMHN2Y3NK?=
 =?utf-8?B?MGZYNUdmVTI4dkpaK1lpSlY1VzVBblc5QUl5TGdESkRrTG5iTE5RT2pNd25v?=
 =?utf-8?B?L0xoS2FhTm40U2gwSThJbmIvMzBtOWJyT2ZtVjBtTjI3d3BmN0wyZFJwYU5v?=
 =?utf-8?B?dTBRa2hTTjBjSEVOcGx2OGVLbTNqY3R5aERXcFg2Qjh1TXluWi9VTkprVjdt?=
 =?utf-8?B?OGQyK3ViYU1ZRDFMZjNKdWE5Y24rM0ZQRkFpWWZ4Ky96WUZ2dzdOem0yZEJk?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZIVGErVtHdcIm5yAbMCjgRi65gD72R+RNhKFIPy6wyEgAqjMiL9kBKVcS75kGT3RrVE3plkI3Mt/zM/yCiG4UprjRVTrDIRbAp3hcbQE35YYaB82W7NtNM/Hl9flHI9ZoTaZRoEkYE8AP8JsY/oCRXnqLegtWRvBQ2Sul08cf4bvdYgBW3KflsFUiR3aP04xjBC4feqg55SoHOopp7C9KczHqlHepcnXzEPdZRW77z5QKxaQzjd5Pim7NOPvIopvaa19tuuG2D7B7Bv52nBuM6jM0tlVhganQFVbKSjAGXCTMtzVVWOlgw1J9lu2yq8KWCx46VHtPvWljutMuLeQVl8M/DCbr5k78311090RVXgwieVdBfi+qs4Vbp8/3ep7osLmx4f+jOB1MuaNxfnPE+9xG2+e7WKnB0GKLb7zMYPEzzEX1JZh/4dqq3lwAfrgIHpSJzBgzAkUF5DZ2z83cRup35q5M+rtbty4C0vnHWnK5AGItyWrv6SgpFMeBeMhyKT4bbrPyiilxpIuPJln5THFizv3Jh/NHkUBgifgz4EMJVyA1Jl29hDoMeWf+bUFJngO1Oy/CuJL0iMh/FTq55VxnMZF9CVCTKNXX3kpT0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a7004b-e828-49b1-8c59-08ddc84b7acc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 11:41:06.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUBUclbdwlX8nNhwEBK44qrJkgZjnFd9RWoaNoCYpw1Wx+S/kZJQHZMIy0+ylQNLB25dmUjUybyJvRNIpeQCoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507210103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEwNCBTYWx0ZWRfXzx1r8IIMNjQ6
 R9mOonHc0HLqjEEuMbVMqKd4O3de/TybEdh1ql4Tg1zu5MwYTT6j8cRGXAUdYnB+8sf11TtTGuv
 YD1HDUiGmZVbeXptIhgYr+0XYWgtGkhXWQW7BUtQaUpXMGswXmgiap0UwLamFIa3BoUH5dQu2us
 wRWl+xP1ilK4ssIH/N/FiqgCGjDNnfiuxK9Xp0i+pPMJme9/u7HFZrLG8lhB2lEsleRWh+k42Bh
 38gL2b9L2Xyfs0zBonm4jX375IFPgBSi7Yjl5c+IK2e0QOJuZZ30fDzjIgI8OxgFcJouCiSrj0z
 M0SJgt1K1/mKtI+iTVJwo5jMTU0vzoPHTkIwUQwANtFE5wMWCz/r2gXfIw9jD4BPSDuF0HEt8ST
 y7VPbXG4pbepxTHye0Aam0veOAeVrzZdFMqXBeeCry65anOajyGS9Wza+PMfciKC9+4+99bx
X-Proofpoint-GUID: fOqg1H5amesnIHVSNH3uSC3c6_z_LZn5
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=687e2755 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Z6pL59wdBUg8W8M7epsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fOqg1H5amesnIHVSNH3uSC3c6_z_LZn5

On 17/07/2025 16:25, Jiri Olsa wrote:
> Menglong reported issue where we can have function in BTF which has
> multiple addresses in kallsysm [1].
> 
> Rather than filtering this in runtime, let's teach pahole to remove
> such functions.
> 
> Removing duplicate records from functions entries that have more
> at least one different address. This way btf_encoder__find_function
> won't find such functions and they won't be added in BTF.
> 
> In my setup it removed 428 functions out of 77141.
>

Is such removal necessary? If the presence of an mcount annotation is
the requirement, couldn't we just utilize

/sys/kernel/tracing/available_filter_functions_addrs

to map name to address safely? It identifies mcount-containing functions
and some of these appear to be duplicates, for example there I see

ffffffff8376e8b4 acpi_attr_is_visible
ffffffff8379b7d4 acpi_attr_is_visible

?

> [1] https://lore.kernel.org/bpf/20250710070835.260831-1-dongml2@chinatelecom.cn/
> Reported-by: Menglong Dong <menglong8.dong@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> 
> Alan, 
> I'd like to test this in the pahole CI, is there a way to manualy trigger it?
> 

Easiest way is to base from pahole's next branch and push to a github
repo; the tests will run as actions there. I've just merged the function
comparison work so that will be available if you base/sync a branch on
next from git.kernel.org/pub/scm/devel/pahole/pahole.git/ . Thanks!

Alan


> thanks,
> jirka
> 
> 
> ---
>  btf_encoder.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 16739066caae..a25fe2f8bfb1 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -99,6 +99,7 @@ struct elf_function {
>  	size_t		prefixlen;
>  	bool		kfunc;
>  	uint32_t	kfunc_flags;
> +	unsigned long	addr;
>  };
>  
>  struct elf_secinfo {
> @@ -1469,6 +1470,7 @@ static void elf_functions__collect_function(struct elf_functions *functions, GEl
>  
>  	func = &functions->entries[functions->cnt];
>  	func->name = name;
> +	func->addr = sym->st_value;
>  	if (strchr(name, '.')) {
>  		const char *suffix = strchr(name, '.');
>  
> @@ -2143,6 +2145,40 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
>  	return err;
>  }
>  
> +/*
> + * Remove name duplicates from functions->entries that have
> + * at least 2 different addresses.
> + */
> +static void functions_remove_dups(struct elf_functions *functions)
> +{
> +	struct elf_function *n = &functions->entries[0];
> +	bool matched = false, diff = false;
> +	int i, j;
> +
> +	for (i = 0, j = 1; i < functions->cnt && j < functions->cnt; i++, j++) {
> +		struct elf_function *a = &functions->entries[i];
> +		struct elf_function *b = &functions->entries[j];
> +
> +		if (!strcmp(a->name, b->name)) {
> +			matched = true;
> +			diff |= a->addr != b->addr;
> +			continue;
> +		}
> +
> +		/*
> +		 * Keep only not-matched entries and last one of the matched/duplicates
> +		 * ones if all of the matched entries had the same address.
> +		 **/
> +		if (!matched || !diff)
> +			*n++ = *a;
> +		matched = diff = false;
> +	}
> +
> +	if (!matched || !diff)
> +		*n++ = functions->entries[functions->cnt - 1];
> +	functions->cnt = n - &functions->entries[0];
> +}
> +
>  static int elf_functions__collect(struct elf_functions *functions)
>  {
>  	uint32_t nr_symbols = elf_symtab__nr_symbols(functions->symtab);
> @@ -2168,6 +2204,7 @@ static int elf_functions__collect(struct elf_functions *functions)
>  
>  	if (functions->cnt) {
>  		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), functions_cmp);
> +		functions_remove_dups(functions);
>  	} else {
>  		err = 0;
>  		goto out_free;


