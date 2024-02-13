Return-Path: <bpf+bounces-21831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2D852896
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 07:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72E31C214AC
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 06:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F37612E49;
	Tue, 13 Feb 2024 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AUf351s8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JYjsI93i"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA9125DE
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707804678; cv=fail; b=OlGcGU/zeHvVJ/Cq+Pf4A9XMcLJK4hileReNSaflHeDSO+5Ed05zk+XLHadjC2quVk6kh4nsxR3U6SabB9AACnqOuxMmwrX2X8u8xMtL8JO5ttZb0jRMj7ZrNFDKh8QcYbcS6Kk3OhSXB56He7/7lnhgtPmqtgSl9yxwOOA7rSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707804678; c=relaxed/simple;
	bh=7m5qzJPEnzibkL4el4TxFpZzw8hln1iOiJYP/l8xS7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=T8HeB2zMOR3eesLFQenwvnVB/dIPQX57f+OQsW5p5lzTizyz5vtlDw6LO1GMOSmg9tQgtiyAGsH4mK1LhVrDtE8lzE9dyO3JkgJvjBluXU55qVfHkpoIiLHLtScZQWVI5bPiLsTbQDk1U3AlcMwT0TJzmUuN4iwnbmdqMdVEyW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AUf351s8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JYjsI93i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5Z8Tw006137;
	Tue, 13 Feb 2024 06:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=AiZetBIqXKNA96nJDf3qjFaUmJjeAQ76KBhans+19x4=;
 b=AUf351s87GBRYKp7hTn/kAErYFBOGyExSew2sycLu7hlLe7B/cv659IIBpp+9KiQDoYr
 3Nay1S1+zHLEZNPOqkoD3gDYxYLmU/+mToTMSX7k4k2fOSPPQNll1dQo/5N2Ir5J5H3j
 1+MIOzIUwmVF0dd+0x7PEiuC7jiIqwBfitKK9k6YYyJszDmzNjB4EfDJObLnqZ9j4eB2
 xiY9AzfeDGgQIZzuWdRkbSuJIIQNdTksdLuheqrdekGQBU13eRLoTXt8/y0YpF+p85h5
 1Db5jbMaxsziT4apD/3sFLgji5Y8Wi7w8EPCpvJyCdxNMKZlN2hs9XJ0DVaQbTGxaoC9 Ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82d7r2rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 06:11:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D42SKv000682;
	Tue, 13 Feb 2024 06:11:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6v1qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 06:11:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4I0CshggVMH6uw+tgh5uR2aycJ76IjnOcsTF0xjd5nLvaEXUWVu7woGxCO11wQ4ckzQrvgb503xF19j4ielDvQuK+J2Ma2u5OHvKDhHX3Vcdqr3/n+hGUXJC0OZ0w4kdHY70Rf2ToQsez7V8tR+FPXfkZI81kStmbxNmEmmJqNyjGSwr2ap2OiRydFFfL6H6w/ZlP1xy9zLiCu+oqONcNF+eXJSEFQZTXjzejnR4O+p3MxnN9wLb7OLkCn5mGjcBPLuMuiStq+mbHEwvQxeC5/YzbYyj8xvJ6qq++JsWyESYvk5g42xlyEDpBxOSlBOC57pVGXZ7IhojZV0mfqBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiZetBIqXKNA96nJDf3qjFaUmJjeAQ76KBhans+19x4=;
 b=D7gu40nVa0K99dREhX4ax3e89eXmqM//4I3FRH7nVRoAnK0qxGD53iIQZmZIsysM/qRercLX8d3EOTpSoO8SLE2FsdJPZkmq6OWh9BM20o9xoefhxg1Unkf+fioIgfHPQrr50i8r8U3UtNORap2OjdrHYDQtkSzGRV3G/omtJqlA+bt43SM972KG4KloOYdav+kgrTclUEgpvBYZtmxJP1sCKhI7Ynzp5FUQan+gHXr9YnJz5PdkdbV7xUh0uzaN4wnPtQYFDp7lS3K6Yh8bO4xO+ZJrgTW2gjLug3j2XWJrQNhMe85JNJGPiaYLIJdFfd1q/ZrEin+lfBLb69rDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiZetBIqXKNA96nJDf3qjFaUmJjeAQ76KBhans+19x4=;
 b=JYjsI93ijZWCWA2conYAabCc8NHPeP6kTvbJdUAXfpCrfVp9MdYciBhIpQa7hBa49YcnXkhKXcCLvSkwsvqpRRYEbGLHUiVAGNTM5HJvjZTw3rQGKJjjEP/Ahz8RXzNvW39WxuYZKa8Uw+TXqUoUKccWS+i/Uq8ERJ+rGjax8Kc=
Received: from BN8PR10MB3107.namprd10.prod.outlook.com (2603:10b6:408:c2::18)
 by BL3PR10MB6065.namprd10.prod.outlook.com (2603:10b6:208:3b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 06:11:09 +0000
Received: from BN8PR10MB3107.namprd10.prod.outlook.com
 ([fe80::f03f:cc66:b93:fe45]) by BN8PR10MB3107.namprd10.prod.outlook.com
 ([fe80::f03f:cc66:b93:fe45%7]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 06:11:09 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: dthaler1968@googlemail.com,
        'Dave Thaler'
 <dthaler1968=40googlemail.com@dmarc.ietf.org>,
        bpf@vger.kernel.org, bpf@ietf.org
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in
 new conformance group
In-Reply-To: <a81da29b-b671-484a-8f3d-743f1dac44f1@linux.dev> (Yonghong Song's
	message of "Mon, 12 Feb 2024 14:48:53 -0800")
References: <20240212211310.8282-1-dthaler1968@gmail.com>
	<87le7ptlsq.fsf@oracle.com>
	<b5072dfb-ab2b-40eb-891e-630a02c58fe8@linux.dev>
	<036301da5dfd$be7d1b30$3b775190$@gmail.com>
	<a81da29b-b671-484a-8f3d-743f1dac44f1@linux.dev>
Date: Tue, 13 Feb 2024 07:11:05 +0100
Message-ID: <87zfw4sxl2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::10) To BN8PR10MB3107.namprd10.prod.outlook.com
 (2603:10b6:408:c2::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB3107:EE_|BL3PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4bd2e4-4083-4a11-fe29-08dc2c5a9222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	w+qS+tIFpoh8mDsB4ViCcacDPqKNsc38FD+irnpe+b7uHWce6ih39u7dgmocdtR9gyvB6iUS4L/vQXTEdGX8AGIj5r7CBFz6Z47ldIhetQq74U3YNfu/rl7YXPYonz8F8lkxcIooSgvSzXYIpViM4LoB+F9D5nNy1JKDWtH/HCrHbg7FSVGisDrb82b+OMOV3Se9lGm1UmPoGLpWwbfL5jG7Qz5jUHNhNjoJ931j3zJqUqQmUhfPRsMH7hW7TbmWzlyjsO088AcdQd1TLHz/TrlMS2wOCmAimSBHKUOV1K0rMlBeiSEOsYQsugQM7hyPEbfXHDqgafp5CgSh2Bz4LJYkOyiXmkswYNS04TkQ2KI9b9HCnMTO+lgBb44z7lC7/I3qv0tua1zq9c52T7mJPqKRHNrzUaqv1VJOku6+UemQ/90+RZAhp+R1qIh4GO0++NcqcuZq6K+jVWQbnC3ml9EWcHmfD88/eF9IfrrN99owwqrAR4Hgu4AgnWEGEYc96ZfrTnMLDQ85QwhmQenpSUdetItf5EpSgX/EGheUNLk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3107.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(966005)(478600001)(6512007)(41300700001)(6486002)(2906002)(5660300002)(8676002)(8936002)(4326008)(6666004)(66556008)(6506007)(53546011)(6916009)(66946007)(66476007)(316002)(83380400001)(2616005)(38100700002)(26005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HfetkEbXoeVingi4qrr4+FwrFd2wtZDcErHES2KG6QzBKYN3WahaR95Vo14Y?=
 =?us-ascii?Q?9x0HFoS8t9WwCe8KlnGdJiUke2hR3VDI/IMP0Zly9Ks2jxyojkOKIRCBawEL?=
 =?us-ascii?Q?wJNIcpbh/RS91fE9rgOOsAqbfWES0NeF+Ydfgj73svwaHXe+Cbh372BB1NB9?=
 =?us-ascii?Q?JSbW1mNguPo1X5Ocuf9TrnZ39D72/ERs4gmp1bF9qn4RsXL7zpTNPKrwFrOL?=
 =?us-ascii?Q?uBO+a5+VA40sTfG05L97ujNW8YsKNoitIrCYL9dWYesaKsgUgF/aZeXHr6z7?=
 =?us-ascii?Q?o8jmw9N1wWaJbUo9ItJjMudxz0IYLppf1RwbLbgpHsbs13t5le9hwyorjzpo?=
 =?us-ascii?Q?aQqM/lcpvhMWPvvbL1A4+XPmbl8+2Ug5u2DWyx/iZaL1ERy2b0R2nAyoGeI4?=
 =?us-ascii?Q?dE6kL33o7uCB6skBdXxfosHEPmw4C2xcVXrlnnjuHc96qt25VFCaR/46GqnH?=
 =?us-ascii?Q?d06sNfED53Vrejs+bPWmzyYxMIr80hc3qEGIA5jS4OiIQIJntLeUR/vPvd2f?=
 =?us-ascii?Q?w4NPQsM8yDY5galJ7WL6PDOWLH3a9CuBCY9SBVIjV4KfR5OD2oVZduRocQWx?=
 =?us-ascii?Q?oPoKhMelg6mgTWs9e07eoj6D0KurIohxlcQOq9wfEDEFe1B9CSztBFWwnI0u?=
 =?us-ascii?Q?D5b/cfMfw60P9MpD+7YbVNySxmdbGNCTCHThNJRSeB7DK7DdKAHFeME8TwZ2?=
 =?us-ascii?Q?m0wWrYcvikcFW6Jijf9fiGKwzdQ85e9DpeyHfqDLdPO5tHvufZjXW7uJqB3D?=
 =?us-ascii?Q?XNXadMUf0luIsuxsLXx6Ex4y8j9JCEEMwX51laYgwZD62TDfoOfH4k+3I5Ki?=
 =?us-ascii?Q?j2nW8KLker+ppWadTV/QEFbBq7qWbVk4tzwaVmgjd8aI9E+7ejmhuI8SVE1f?=
 =?us-ascii?Q?HvPU1v0YQFLJ/N3ZoiNc5jw7NeMlr2ImY2qrnK3BHUMRW2Lj6uRfopmQBV7c?=
 =?us-ascii?Q?57LfGx13+jM5G5NUfZ1R5zLCl/CNg0yYnLhUO1IC8upX1VHPzpmlnokcjQ9g?=
 =?us-ascii?Q?+Lwo2NOQcOAb2Lf8z8WrPh1WrPrigXDz0Ik5SteteRt5Y7DASZSeHZY1Htl6?=
 =?us-ascii?Q?2/vidAhX6AEgewlnOKWhy5AUd+CaxQirrFBrcAceE97NmSzg2rZP+I6voMy6?=
 =?us-ascii?Q?SR5LSNjAaR5kTRJFvB0Ohi2tmRmBEhlKRF7TXyMMrIUhFnhahbDthopGAqWH?=
 =?us-ascii?Q?gHv4JyyHATU9AshUV848K1aYsWx3EgXzCYiCWmR9n4N7KOMaeNd6K1wjuZJO?=
 =?us-ascii?Q?VcH9ZuB2+lfvsU9DcTQ+6lXLUnouUf92RE9AQ1pxjJvNnUjXfakTqbPUutYj?=
 =?us-ascii?Q?sP9c29pxKl1eD6rPJSLdvuzxiN5guZbya3vsR1Mb7Gj8AB6AGP8WUsV23YEj?=
 =?us-ascii?Q?bdnI23gOjsWnp/vpPoznNYBBKU1AXMjQIPWxfp/9udLpJUoua97zxru2jBwX?=
 =?us-ascii?Q?xLyOirKmCf+Qla3VHIinL4JzEgjtc1/nWJWTxupRXX4Knig0KCIXPrODHZki?=
 =?us-ascii?Q?JE95HAOeibCbcQvVxRtOV/ij37whWjRV0crz+PzI3jdc5+ZO24cAoweW97Mt?=
 =?us-ascii?Q?aahuN0/sf71geHR54zszEwdH8W2rGPjVbREI1KZQbPuFmj30HGuPtLUku0bA?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qecWANnL7BFgJK9A/0uEJukup6AJfm6uzy9N5RnvQoQfQupcp9t1WWpIrm7xUqdlzzdV2T0wdDxTFW8N8SNUOzVnXQDBwVYNevYk2MUAsMN8AVfWhJ6je7rcvt9TZKZleWgK+betxswMf8ZbnVcBGYhpfD3/ISlE/lUWa2nEyj/rF/rN3sVRwODHwJM1oYrOvwjWaDCp8vwXBCQHuURH4lDztHqFC5RwGeAUlPjVUrLOMZ520VENrcuOF0htsoHeAOWJpGSEXN7ty1uG7Hktvfxgs5KToNaNqusmwsFnMdFZF3hff5Obb3iWPx9VaFjCu9a9u3A8Q6m1JAr1ys0mHCYpSaoLbJKsfeWmw17A4kWHRNNU3Q5RwL/SpT6gS2jU+JgCG1uNZie/1x7F4mfIfnyKxfAaGmrKjmVmvikdUu1cPPAQWsirUfJXl179ytWa2E8RB16Tfu9B6Yk9ekSGSpCfu2kiCznrjZhAfeDDCYTlfMsepGy1kGb5y8/dk6JnrW9O6f5m0axLb9Git8p1XaU3bCiCx05jOUZl8fSCBOKZW5uU09xYkITTeqxbTJ/KqWi6xEiI6f0PWgb/3vBaDXyIHhF5Ip1qHxcFk1er0LQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4bd2e4-4083-4a11-fe29-08dc2c5a9222
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3107.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 06:11:09.2855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdTHoPB+By8UcFbXjVXRACt0QWG+MYlmcAFuDbqVVtofvuu+1pwtCI0p32L5C7R66e2NLZFfoUSkSbQZGl5uMl6EdUDNWbcJGPTAwrWVLp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130045
X-Proofpoint-ORIG-GUID: bhY7Ojpgbi8p3FuDZFzpBGXCgpw1A4Eu
X-Proofpoint-GUID: bhY7Ojpgbi8p3FuDZFzpBGXCgpw1A4Eu


> On 2/12/24 1:52 PM, dthaler1968@googlemail.com wrote:
>>> -----Original Message-----
>>> From: Yonghong Song <yonghong.song@linux.dev>
>>> Sent: Monday, February 12, 2024 1:49 PM
>>> To: Jose E. Marchesi <jose.marchesi@oracle.com>; Dave Thaler
>>> <dthaler1968=40googlemail.com@dmarc.ietf.org>
>>> Cc: bpf@vger.kernel.org; bpf@ietf.org; Dave Thaler
>>> <dthaler1968@gmail.com>
>>> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in new
>>> conformance group
>>>
>>>
>>> On 2/12/24 1:28 PM, Jose E. Marchesi wrote:
>>>>> +BPF_CALL  0x8    0x1  call PC += reg_val(imm)          BPF_JMP | BPF_X
>>> only, see `Program-local functions`_
>>>> If the instruction requires a register operand, why not using one of
>>>> the register fields?  Is there any reason for not doing that?
>>> Talked to Alexei and we think using dst_reg for the register for callx insn is
>>> better. I will craft a llvm patch for this today. Thanks!
>> Why dst_reg instead of src_reg?
>> BPF_X is supposed to mean use src_reg.
>
> Let us use dst_reg. Currently, for BPF_K, we have src_reg for a bunch
> of flags (pseudo call, kfunc call, etc.). So for BPF_X, let us preserve this
> property as well in case in the future we will introduce variants for
> callx. The following is the llvm diff:
>
> https://github.com/llvm/llvm-project/pull/81546

Thank you.

I believe Will will be sending a patch to binutils to change the
pseudo-C syntax for the instruction to callx instead of callr.  We will
then adapt GCC accordingly, and both compilers will be doing exactly the
same regarding callx.

>>
>> But this thread is about reserving/documenting the existing practice,
>> since anyone trying to use it would run into interop issues because
>> of existing clang.   Should we document both and list one as deprecated?
>
> I think just documenting the new encoding is good enough. But other
> people can chime in just in case that I missed something.
>
>>
>> Dave
>>

