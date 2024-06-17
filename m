Return-Path: <bpf+bounces-32298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D6990B1AC
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 16:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4931288D5D
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0852219939C;
	Mon, 17 Jun 2024 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yrajmcqq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bnw+UGG+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C1194A43
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631099; cv=fail; b=qyiIWLQAJss2BWhrJP2TcetfTknq43Pif7P0jCBZ0j9ih/OqG0pZypVRJoIJskJeNEAHKzr7Vw2VwyP2XkecYAEflDEpA/394tUJ760OKJBMUm+UCky7ZoyYru2JAO7EDqHptO+hmeQGym49M48g4GdUQUVymbfFlg3CIRo+3+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631099; c=relaxed/simple;
	bh=K1BS1f430P36MheScwxNU4kADUxQlxnm15ucasNPHlo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M4GbeFKUIglxUVdPtHrpf1y7LJgHNxgVnWPHvJcBkARY+yJD5vRLZzSxyuLcnVpT7s3g2mI/+ekV0KbmUwjndiMXxLiJHgQHVI3D0q/J/tAcR7d3qgrz8hMwMmnns/q5vgAQ4vEYDn461f9+YgQ4BoU/+y/c0wWTfGCqsQeVr0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yrajmcqq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bnw+UGG+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H7fRkc020002;
	Mon, 17 Jun 2024 13:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=4BMIxI2qeN4WR5P6R3dcrbXcXoxkq8g6ZuKnhZofBCY=; b=
	YrajmcqqgFFe9WZ4UXD2jcXliIsDsdm+WLc1xNHYkPzjp1mvhBA5cWUsINEQeAeY
	diVlysDTK4hEDGo/1ve5pDt1VzFEhDvZ1wLNQc7XGcTJP5Xhptgr+1ctyavzZT/c
	b6piZ83KVwyWmVZjVMMjXMqJsTiJastpnD2dZReZtTl1UHOQXUKlAdVtAAlpCBSn
	Kl1zV8EyDU5FeF85zG+mCb1h/qX/83YLOtbzdrtcC75ZTlDFwZ8DI+ZubKL1EmMC
	193Hv1nhOR4LTzp2wSvza08P1WDP+VpSYq1inkXup7kxi9hSMMtMxg3pYtfftv5x
	EOYjNBkCduu7LeH9EhrB5Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1cc2pey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 13:31:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HCCpKY034687;
	Mon, 17 Jun 2024 13:31:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d6pw1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 13:31:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW52FGNz14/HDyalpyQIcdshtg4k5tU8EkXK3g5Y8Th5fWsJxt8eqeQB1ucEv6A71BXNDWf+PIWG0MfEdTrW8h8hcwdYd5F9foJ3gGpCjwPEaKfhkvTZEBNUFXRWaJJk8/WkjD3SSepG1RmQRI4dLfXc8Saszbe2VQBiRB6NscYnmCuPt6rG9omVdVh1F4MRLj6g5aT8JEFDfeVb3AqrY+4uBpLuC00xS+0wEIsQoK2uHbZWT4ME/FEL8W60il5Z6nkLhJYeFK8WrSDq+bpfy1fFOQ3I3OpTkltxYB7Packpsr7Isi6xuMgIowiUS0ExMdg6yEV1geHRxkXqXBYntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BMIxI2qeN4WR5P6R3dcrbXcXoxkq8g6ZuKnhZofBCY=;
 b=UkYeQgeGgxoCubk8qpckZX5dms7M4LTQTCzFDNL+oDhSbbqGq3D+ueKMIMR0lPb5QFIBbtqoYhDXfGWY6vgcm3h/Vq4/LWZrFgIr7wjCeVhIr1TOpmCmTEpR+fpACc7HcwpMEqglWDXUl5atL0nZqiGnuimiRZVR8qgrMvYIuCWIzmPENrULAO4UWhTponlX6kKOQ+uumf6bAxhcBcvgAy6WWhSjjh4JznbgXCmk6/BH27tDoz//s10M4gKKf10pNYqQpfOVy+Krwqt8AsMSFZOa4oDPkcCovLFTXwlUDWz42Iq49DhzAWkzaL8Rinx9nvDBECaLo+2Ocm084modTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BMIxI2qeN4WR5P6R3dcrbXcXoxkq8g6ZuKnhZofBCY=;
 b=bnw+UGG+OfOZsoKR9d/YxZN22f8jVd637LJMXFrboXq/CkexgkmZKu1PzjMCTeDyeN7ZqvzXXuiKELofOvv8SI30e2J/fGmMlHgHLU9ZoGH0+sK/0KOgnaih3Ekxq7+gUL0fOnUncFYQt59Iq/0tlThqbHT9/s6ZEs/mjLQnego=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB6318.namprd10.prod.outlook.com (2603:10b6:806:251::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 13:31:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 13:31:09 +0000
Message-ID: <78d4775c-2b26-4eec-a032-a0d61052395b@oracle.com>
Date: Mon, 17 Jun 2024 14:31:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf-next 8/9] libbpf,bpf: share BTF relocate-related
 code with kernel
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
        bpf@vger.kernel.org
References: <20240613095014.357981-1-alan.maguire@oracle.com>
 <20240613095014.357981-9-alan.maguire@oracle.com>
 <3a1dd525bee2875f370e73a0416d115018ed7e52.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <3a1dd525bee2875f370e73a0416d115018ed7e52.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0625.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af446cf-cad3-497f-2132-08dc8ed1bfa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZlVoOHc0VGxjM0pMWEhzdDJDRWNkTlVhVXFIWTJXQWtQSGsvT1F1eEw1Vm1X?=
 =?utf-8?B?TSt4cXpQZjUzY0M3RENBYkhoLzVxRGZ1UWNqaVlxNUVmemxHMHhKZmMyOWph?=
 =?utf-8?B?bmNPc3RQSU9vcGJORXFmOHpvOU5paEVPVFBlS3BIOGhORFBGVURXZ3ZuTlhJ?=
 =?utf-8?B?ZlFOTnkrYXY5U1F0SHhvanZ4NUdMcXRtNFVDd3RaR3VndktRWUU0UXJEaWZ4?=
 =?utf-8?B?anZJOVNpRG5MZWo3UFlERHFSVzFuTzZITklZcWF5S1VYazE2M2RtQTRYZ0pr?=
 =?utf-8?B?Nk96UkdPbjdjNVpMb2h4bTRodE1iSlNpN0xrRmcvanlNMkplNGkralFoZE9w?=
 =?utf-8?B?dWlMLzlIeWFCT1BERjBWbWRWakE0SkRwQjhZam4rc0ZTNHd2eFh0ZnNUWGFV?=
 =?utf-8?B?OWordjJ3cnBwWEZzZy9XejA3NUxkY1NrdjgvRGhtNU9ZVEwyNTMvcnBWSVlU?=
 =?utf-8?B?L2J5aWhHVEtMR1Q5dklBUzJLTXFWb3BLdSsxa0NjRUJuMHNWMXlqSDI4bFZs?=
 =?utf-8?B?ZTRmZnl0ZFY4STFSOXlBVFd2cTJpTXVYT0NUMElNcEZQaEE2WFU2UGVzbW5U?=
 =?utf-8?B?K3I2TnByZkJ4V2haWDBQVE9zQk9ab3gzWXJoVUU2alZLS2trQ3dNL0dNYmxO?=
 =?utf-8?B?aG04dlZObGZCUFdySUsxcHE3WXo2aGVoandVbHF5RkVqa0UrR0lhOW1UV0lI?=
 =?utf-8?B?dTVXbExUQURhN2N5TGpobldrZGo5dmgxckg1ck9HT3JqekRvU3FNTThFSDNL?=
 =?utf-8?B?OWJkM2IraUNOQXFRejlsY3BIQU81UHFPY0V5SmNaTStTdS9xdXFEa0JvTjFq?=
 =?utf-8?B?aVhyWE15eGJyalRNZmszVFlLbFBSZStnVjJnYXFjSVhiNE96WjFiV2dpcHg2?=
 =?utf-8?B?UUp6am8wV2ZSNEFoVld1eStLemwxbmMza0RrYU9DclNieHdDeVhHbVc2SUo4?=
 =?utf-8?B?Ym5SeXdkcHA4RktSWHFzWVZoaWcyRzdIMWJTSHYzbU5RSmtzblAxNDhmYWc1?=
 =?utf-8?B?aFRLUGZXUmRwL3pOdVBlZkVuYU90VVNNMFVJRkUxdGdia25pWnBOR3gvT2My?=
 =?utf-8?B?bTBPcml3bzZTLzQrRWZuelBhWS8xRDF2T085OWs3bHJjT1dTVngyUnZSN3hu?=
 =?utf-8?B?dVJyVnRPektONVVNMHM5RHlZNnk0Mnhqdm90cmx6aFFITmFRQkFsRk9kUFpW?=
 =?utf-8?B?bEFoMDc4ZUR1L1h3cTd5S3JjcGFyaGZERFlST29lT3hRcEJETGJpZXdiVTVr?=
 =?utf-8?B?SDFIVjRXZFNkdXE1czFZRUlCdGRGOTFhUVhPMHhTZDNmRWkxMzd2ODJUQlJE?=
 =?utf-8?B?SEhMVzlOc1Z1Y1JQanc4R3BSVkEyVGNkSVo3U0VpM1pIOU41MEpXTHZnSU81?=
 =?utf-8?B?UGhGZHNoNkx1OU9xSXZ3UFljRlhxSG5NaWZNblAzcVp1TmpkRVZLNlVBTWN4?=
 =?utf-8?B?UUV0dU5UUGtjRklFcExsb2hKQUxkUzhCNmd4UmRvbjBhMnBxSXVFL2gzcXVR?=
 =?utf-8?B?b0FmMllUWTlzeGpBZTB5cGNSekdrTnpYaWdVRGZreVlhZFZHR1hrSm1rQVF6?=
 =?utf-8?B?eHJkTUNLcUxpYUpMdlF5MWpMaktXZ1FocklQUHVGMElqVkNIMGlNMmpGRDlj?=
 =?utf-8?B?dGxmWlFWTE5sUGYwVkJqQkUvS0tsalJjdVlEdWU3WWVITE9HSmpRS3ZBUFph?=
 =?utf-8?B?eEt0eVArTkhPbEhZcmhXcjI2bHVJZS94SWJsZVRjN0pTQmpWUEFRS2lRZXVW?=
 =?utf-8?Q?1knS5Jme63QmCGaYRvxQXQI/SJJF4uaI72uXfyd?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UlZBcC96cTZ6U1d6UXc4ZWpLOXJ6NG1qYlZ4NG1VVStSajY1Q1RrckVnN1lX?=
 =?utf-8?B?MDRDRUVKWk4rckpCcXNIWTlJWVBydDFDZlVBcEVjZWE3SmllT0l3Q1ZhOWhB?=
 =?utf-8?B?ZEljWmExZzZxTzRneW9HUUhaQ0YyakhiTlU1Q3RQNytrYlEvTS9GamVBTWFE?=
 =?utf-8?B?Yzh2bWZ5SU1idXUrNUJOVVkrajVadnJPSHhYZGU0WGdpektHVFNWeG5zZVgy?=
 =?utf-8?B?N2FkVUd3MitMY0ZaamdDN1IzdkVsM0xMU2NxaS9uYWtDd2Y5RGhOV1doNTF2?=
 =?utf-8?B?Yk9VQ25wRG1ucWVwNXFFT1RlSjBZSnR2Q2dpMVBxTDhaYm4yYWJxL3FIRXFN?=
 =?utf-8?B?MFBDanFXVnBreDNpc2V4bGNsck45SHBCWXZFdTRwd24xK0VBdG03ZUVENUxJ?=
 =?utf-8?B?eE9TWTUxYTlNdXU1bURaRkRnVWhNaHFIaUdlYVFzcWtFcWMyNmhOQndqbjYv?=
 =?utf-8?B?U0RBanpQMkRuQmh5NWRTQWVzOW5XbjRzV3JSUnV1QjI2VGQwUzhKdnRRSU0z?=
 =?utf-8?B?TXN6WFp4QlpMeVlvNW9Yb0pINWdOQlpCZnNPRElFcXdqWGtTcWxleVRQNkJ5?=
 =?utf-8?B?NEdIcjAyd2xVbzlXVjNVWFZVS2l3RjZPZmhuWjFNMGNNMlJMWUJYb3g2SVZq?=
 =?utf-8?B?eU5JeVRsVC93U0pMTUhMUTMvMGh2T0xnbHZ1WW1yWW8rODJlT3Y3cGIrN3NI?=
 =?utf-8?B?RExMKzlXRjB5TXlCRzIvL3BjU3BrWW0xeFBFZDEvTHMwUlo5eEhYWnRvNDhk?=
 =?utf-8?B?YStSLzFuanloek5JVklZRjJraHVRdE03bW9oYnZjM0QveElnVEErQ2lMbFla?=
 =?utf-8?B?NXBnbW0vYjBWb0JKYVJuLzF3OENTcVpwNmVhRlltczk4bjN1eEhjUDNRNzlM?=
 =?utf-8?B?WHRXVmhiS1NnV0t0YWZEZXNydmxTY3d6d3VPV2hUc2NQeHFOWDAwK3NoYXo4?=
 =?utf-8?B?Y2dMc3NKbkZIRndPcDNTRjNtaE1Uc3AwbXVCcXE4ME1TSjRuNVhqN09lR01m?=
 =?utf-8?B?MTBTcE5wbzdFK21PNXdQOXJFV2o3cWN6S3lwSmo3ZytVV2R2eTFvTzlvSEVR?=
 =?utf-8?B?bDV3cjMwS01uZXhHbmMyT0daWEFPNUU5V0I5OFZzNnVWTU1rV2paYlVOSkpu?=
 =?utf-8?B?TVJ2Szd2YVgyZWtROXZwTVJLMXZJYzUrTTZ2ZG5BTXdSTnM4dmZaUmZ6QTJX?=
 =?utf-8?B?S25uZ3V4Zmo4RkFBbDdTSFFMSGRZOXU3d3ZHNDJKdGc2Mm1HS0N4TEN2L1pX?=
 =?utf-8?B?RUROZzhTeUQzSUU3Q0dEUnJ1WUlYalk1SjA4VElIQXQxeW1QWUhSUUp0Ym9U?=
 =?utf-8?B?ZWx5RmlXMnAzZDVJVTlrUnRuYzhvdFQ1djRvbkVSSlhFOFBoUTkxSXpTTnJp?=
 =?utf-8?B?TStxUWk5WEk1SzQ1QUtaclA0cUNZZ1BPSFQ5dE5pZGI3Q0gwemFENUxuZk5y?=
 =?utf-8?B?aXQ5bFloYVMvZXl0QzJZenBEcGthSkloMWYrWGZXNG1tUWN2ekVCdFphWGpi?=
 =?utf-8?B?VFpqSm9wdVNRWVp1cTV5Z0pvYUtnbE1adEdJZnEyb2lXcmpEV1haZ1VwbWN3?=
 =?utf-8?B?b0hOa01selorTG1uVXhLY0R5ZHErZ1J2QkRBUmk1ZURoQTVZQ1VBMit2Tml6?=
 =?utf-8?B?dU0yNWxaNEtwRkNUS3FoSzN3dGhZakUzMWRsOTBvbHoxNmkvYjJvTFZoUGJh?=
 =?utf-8?B?NWs3UDZxaks3SDI1M0EvTWZuaTNMdUZ6amJqR010dVhjR2h0SFloRy9idENa?=
 =?utf-8?B?Z0xPVzVaK2FpOUh5dXg2UElhZjhqRlJMUjFUR1JJVzJXUkRpMDlMaUpkN1Br?=
 =?utf-8?B?NVYvNkJrOEFUWFF1V1JRQnJzc1BCdGRZaUNaVzI3TkIwd3RxU1JHa2VWZGRO?=
 =?utf-8?B?N2xkM3duM0tZUDJySytkVkU2T3U4WnR3YkNtOGtmRGUybURRUitVMDZJSGZ3?=
 =?utf-8?B?L25aNDZZa1BYL1NJNmVXdHp3VWk0V0pSeHpLK3ZFYWhrNkdPWVRzOXpSOGdK?=
 =?utf-8?B?QThMYmJRSzFTZXhVQTRkMWErczFuV0VXWjVIQzZueTZRQnQ2SGFJckRBWWhJ?=
 =?utf-8?B?SHM4aXhuZnoyTzRjL09ydHZkNTNGbGNkY3BQWEhQeHB4TnVoaU1oUU5ubDVE?=
 =?utf-8?B?K2NyMjM2SUdXWCsya2JYSlFobVZGMHMvazZRaDhTUE83UHNkNGZWeklrREtD?=
 =?utf-8?Q?ABQHN6UbkzMGkhiplUtz8q0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F3wO68QYTQ09PBRkCDeK0psdN/qDuAaG3mXD7rwwFwOL9PibBaqWpt+7HyhvhlhprGMq4oEklZyhTwdbSJLv/cvE0EBtipPFX6y/JC1QjXhIIxbc9p2O4EO38nl2q3alVREnqnazDSvKqv/zR/UNke9q4jEF3REk7zGLHwn6FZDq1TIchGp8zSSqmxHyoMOwHOcPNRjufVqkzBWgEq396CUWS/lJvOEODe5II6enBNTNKQXpXRlld2oP5xuHsPOS7NUmhZH4B6ro5LwI6K9QufHhMUC0N2j7zbLbj9oVWDB3KIZqKxrQgRnaM78iaCUjWxxxYANjbGEcaSUiFu5GmL8nadcI6+MNFPDcgPvww99lqisNcZlQJTXgJtp7fXc7/u8filLfWfczBuCuh+AuRjsVjHFlOL8PhgoYLt1rSQgpgVPhz65ipDIdWNR5tD3KXteMlnUP0V1z1HtBQW9UMi0UwOyPNngVDcw9s2nK0wNonMmbvyenb7KOqm2jsgOo63zuR4EEMOzHDQZXld7HXOdVbWR7WigXA1pzgm2ijOFDNYQgVz04CVu/m8oN4dyEw3MSMhOQy4pd9WeE6FQ1/o2Nqf15OhJVO5X4yBUT9fs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af446cf-cad3-497f-2132-08dc8ed1bfa1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 13:31:09.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eBZckFV3ZVVpsbuhnwYzlducl+5eZO13ftaw/SMZssMlhYJHmxuFgpvlC8951Y+fSB4z66uNipxKmpbnsnJDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406170104
X-Proofpoint-ORIG-GUID: Kmb-mWpByl0FgLx-E_PG7rrwllm95AfS
X-Proofpoint-GUID: Kmb-mWpByl0FgLx-E_PG7rrwllm95AfS

On 14/06/2024 23:49, Eduard Zingerman wrote:
> On Thu, 2024-06-13 at 10:50 +0100, Alan Maguire wrote:
>> Share relocation implementation with the kernel.  As part of this,
>> we also need the type/string iteration functions so add them to a
>> btf_iter.c file that also gets shared with the kernel. Relocation
>> code in kernel and userspace is identical save for the impementation
>> of the reparenting of split BTF to the relocated base BTF and
>> retrieval of BTF header from "struct btf"; these small functions
>> need separate user-space and kernel implementations.
>>
>> One other wrinkle on the kernel side is we have to map .BTF.ids in
>> modules as they were generated with the type ids used at BTF encoding
>> time. btf_relocate() optionally returns an array mapping from old BTF
>> ids to relocated ids, so we use that to fix up these references where
>> needed for kfuncs.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Hi Alan,
> 
> I've looked through this patch and all seems to look good,
> two minor notes below.
> 
> Thanks,
> Eduard
> 
> [...]
> 
>> @@ -8133,21 +8207,15 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
>>  		goto end;
>>  	}
>>  
>> -	/* We don't need to allocate, concatenate, and sort module sets, because
>> -	 * only one is allowed per hook. Hence, we can directly assign the
>> -	 * pointer and return.
>> -	 */
>> -	if (!vmlinux_set) {
>> -		tab->sets[hook] = add_set;
>> -		goto do_add_filter;
>> -	}
>> -
> 
> Is it necessary to adjust btf_free_kfunc_set_tab()? It currently skips
> freeing tab->sets[*] for modules. I've added two printk's and it looks
> like sets allocated for module here are leaking after insmod/rmmod.
>

great catch! I think we need

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index da70914264fa..ef793731d40f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1676,14 +1676,8 @@ static void btf_free_kfunc_set_tab(struct btf *btf)

        if (!tab)
                return;
-       /* For module BTF, we directly assign the sets being registered, so
-        * there is nothing to free except kfunc_set_tab.
-        */
-       if (btf_is_module(btf))
-               goto free_tab;
        for (hook = 0; hook < ARRAY_SIZE(tab->sets); hook++)
                kfree(tab->sets[hook]);
-free_tab:
        kfree(tab);
        btf->kfunc_set_tab = NULL;
 }


>>  	/* In case of vmlinux sets, there may be more than one set being
>>  	 * registered per hook. To create a unified set, we allocate a new set
>>  	 * and concatenate all individual sets being registered. While each set
>>  	 * is individually sorted, they may become unsorted when concatenated,
>>  	 * hence re-sorting the final set again is required to make binary
>>  	 * searching the set using btf_id_set8_contains function work.
>> +	 *
>> +	 * For module sets, we need to allocate as we may need to relocate
>> +	 * BTF ids.
>>  	 */
>>  	set_cnt = set ? set->cnt : 0;
>>  
> 
> [...]
> 
>> @@ -8451,6 +8522,13 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
>>  	btf->dtor_kfunc_tab = tab;
>>  
>>  	memcpy(tab->dtors + tab->cnt, dtors, add_cnt * sizeof(tab->dtors[0]));
>> +
>> +	/* remap BTF ids based on BTF relocation (if any) */
>> +	for (i = tab_cnt; i < tab_cnt + add_cnt; i++) {
>> +		tab->dtors[i].btf_id = btf_relocate_id(btf, tab->dtors[i].btf_id);
>> +		tab->dtors[i].kfunc_btf_id = btf_relocate_id(btf, tab->dtors[i].kfunc_btf_id);
> 
> The register_btf_id_dtor_kfuncs() is exported and thus could to be
> called from the modules, that's why you update it, right?
> Do we want to add such call to bpf_testmod? Currently, with kernel
> config used for selftests, I see only identity mappings.
>


Yep, we don't currently have coverage for dtors in bpf_testmod. I'll
look at adding that. Thanks!

Alan

