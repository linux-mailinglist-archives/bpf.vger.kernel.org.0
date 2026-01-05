Return-Path: <bpf+bounces-77848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39877CF4C79
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 17:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F9C316EB4F
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F421B2EBDD9;
	Mon,  5 Jan 2026 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bjQ5j/Ja";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZPrQUlpM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED67652F88;
	Mon,  5 Jan 2026 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629269; cv=fail; b=sty1I4w4+UNBbvT4orpsI+Y6v1FR3AIrvX74+qQ9ipWYqrKx1v46W1vSU0cpGHa3CnDzLkd+80Z0+2oT1oABnxyGPvxa6oatIGzdXCzIwCRyA1g495K8L3IeznAWidxirITztiqKrq4x5GPfUSo71dFfGR476w0cqOangrkfzkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629269; c=relaxed/simple;
	bh=+z8j8zWt0DXfzlENWCe3NbgoBkkbSBtzW2VBliUHObc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=SwIjeNgWhmw/PB7VvawJg+2OyAa9+mniv9iLxvPflOZxLbjOgGDXeWIBiF0Zy6qqzFcxvC0/jUi01+lk+iYrNvUZgpkD/MzOQT2IuUUeF2h6H4XJu3rf6feQ4phtj2V96Al4kKBvQQ+W+Kff1FltGLmGNTPNHDk/a7lGkylr1uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bjQ5j/Ja; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZPrQUlpM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605FFP5H1672240;
	Mon, 5 Jan 2026 16:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4xWO6De2UVcUoLDwz4Pya283n5KPWnJ3NFWICL6dn9I=; b=
	bjQ5j/Ja9RW26M3MjKEDNVq2s9GXagwVMQe3OEza073/FSCSm9kCBUP3kmtjVe/Q
	GIQZAEmgD/VfP2DvulWuzh8K+rOHBVualJwKnHUGUcfipRTg7qVC+oB+ZuddxUUk
	2p1KKMhizgo3dpKjZt7DGtPuh/tK1j9a31TqpPBVo6y5VJCyouug3fcqzpwZuKWd
	0BNXcVdPtjboWGHGJ8jyxGGow9CyhxzHyjzFuHAKhVLv6gtMLfWsSEidMdGx/YZZ
	HmhN9pdN19pp8Zf4NyjBAbvN0dxrCHRMxIXiqPjBCh0ijC/nO2x6SKAbTWzLTTuW
	Ld/LORcL42fQGuT29gc8Jg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev37syqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 16:06:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 605EkXus030798;
	Mon, 5 Jan 2026 16:06:01 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjbhuaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 16:06:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wy4X0ootjKQtuIGLnv9nQLNvEoly0HigPHp068lU7gQXpnrRoBJge3kBeazA/Tce1+ZB8eA6r4IeQOwzBv5s+4ffAq11gjPqOgVCWuQNy39ytKMKBmIsQwJJhZr1qp9UeyQ140K9NORzDpr5D9X/16gyJZ676gtNyB6mT6tnZaORRSqKeNKSAcjxsGgMgar8a86119RIkMrV4UbgX/Aqw6jL7bDr1yuIIIlFkblzHCq93cWaxfajCYWqE47rwtNZ76uB1e+Zei2Ohb2DMt14R6pTFo9C8h7pEiw+BuRvoDpHtdMU8APbalBCHVEY5+szha5mMGWz25+c18aU86qxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xWO6De2UVcUoLDwz4Pya283n5KPWnJ3NFWICL6dn9I=;
 b=vPDKQ8DC1p6lCzxeo+DLerGOTaq2z90XL9pkZE4le+2n3n/0ljFwkdg6lRbga9/qw+/o7/u6RP/lz5NSFn11OP7zoRelOkGZ8glKIYCSxxBHIiygLc966/8JskiECoHeCQ/EEq3ExV1fL9Bvsi6uq7c9PxFORLIfY/esL59TUnEIAdCSEvzUVH8Zi+Ma8rzPCUbb+HxDWm/78yByX8CnojFwuGGtKqihxTDXcwNpTdtOgkB/IOghjZ3h1JHc5nK5hjN8Fx/W6ORtr2IPabGpq+za8cp2v/OFyVNGkvhD2x5yskPwrcFHyoUm2qVHHN7jHJFBfYx/UyhtipXt71n25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xWO6De2UVcUoLDwz4Pya283n5KPWnJ3NFWICL6dn9I=;
 b=ZPrQUlpMB1Rxdc679nKsuF3DkjCXvgxp6reQWvXbHDndVU0ASiAvA+MM6txNzK3x9UQC+ZCYphK6uQTOKJmiol4FuH2Sq4UjFRDJ06IZ8QhqrRucY25a6g9XtC2VdilzY53HWWBo3ewvH5leY/bDUm+jVCkwfVianQu5kWh/R9w=
Received: from CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18)
 by SA2PR10MB4571.namprd10.prod.outlook.com (2603:10b6:806:11d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 16:05:56 +0000
Received: from CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc]) by CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 16:05:55 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: "WanLi Niu" <kiraskyler@163.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
 <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song
 <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Menglong Dong
 <menglong8.dong@gmail.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, WanLi Niu <niuwl1@chinatelecom.cn>,
        Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [PATCH v4 bpf-next] bpftool: Make skeleton C++ compatible with
 explicit casts
In-Reply-To: <7219135.9fee.19b8e385eb5.Coremail.kiraskyler@163.com>
References: <20260104021402.2968-1-kiraskyler@163.com>
	<20260105071231.2501-1-kiraskyler@163.com> <87eco4nuri.fsf@oracle.com>
	<7219135.9fee.19b8e385eb5.Coremail.kiraskyler@163.com>
Date: Mon, 05 Jan 2026 17:05:53 +0100
Message-ID: <87seckf3j2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::7) To CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:EE_|SA2PR10MB4571:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a51ea4-bcdc-44f5-b166-08de4c744ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmlCUDhKcGpnZldzMmtYcy9qVlc0QmIybWtUbFpoblV6OUlXelhaaCtTbzF0?=
 =?utf-8?B?SEx5WWFNaVdBd2JreUpnT0pVdnJFSzYxNEtoOUN3ZFU2amg3UzNCZzNDUU5v?=
 =?utf-8?B?OThqdVRkS0tSMDFZVnlDVlhnNnd0SU85cUZMUFVoaVp3eG9MREJQbEpvLzRq?=
 =?utf-8?B?aFErTVNWcWlEaEpVSllaSUM1UkdUQ1Q2MC9WcVppYjdNNjVEYnE1YlR6K1VK?=
 =?utf-8?B?UDBDK1IwVVJwd0lFd2tpMGZkQ3F1VXN4a1hXOXEyMmtRaDNCbHJ6VEUyTGdu?=
 =?utf-8?B?NG5Bc0ZCSkNqQk8xRHBEdmNzQ3c5ZGZUYlNHOENmQUpYdmU0SUI5a2lXaGYz?=
 =?utf-8?B?TlpielBKYkhlU0YxdG9VK0x0NnVPRlRpNU5jaEVKWFY1ZjhoZzFlVEhpYjJ3?=
 =?utf-8?B?c0FpUVJmUmpzQWZTS2RSY2FqZUpkV1JMbjk5a0hlb1g3NnRrSG9VTjlVazJX?=
 =?utf-8?B?YjZ5Z3Axc3daM25GU2hjQmtITTFCQ1dwVjg4NHBMbDBIOGE0MmpNOXFpby90?=
 =?utf-8?B?QWdTdktQNlFRcW8wbDBGVUcySkVZK29KR3Y5WHVSditYalZaV0w3NXh4S1BF?=
 =?utf-8?B?TGFidlpTczgwUWFQaHNZc25RTTNZQ0I4UkE2T3hsRDQ3YmljdHNCWmlEcW5M?=
 =?utf-8?B?akYxZndtMnpVOWJwRG10cFRTSlMzMGdJbXRFTmxtdVBnNnVneDl1QlJNSWNJ?=
 =?utf-8?B?bXZVeit2eWlsWHdYaGJ2VUcvdU9NVkx6ZklBbUNucEltTGtHQlpNT3h2emNZ?=
 =?utf-8?B?QnVwTGUrVWkvNHJ1WDlDNHUyV0srRUtDeHFIS2dpNXdoUFdzR1hHZjJWRnZW?=
 =?utf-8?B?bmxMNmFjMkRXQXRIWVJrdGJMTmxNTExuV09jcEpIYUdhTWVrN0w0bGw3NmZE?=
 =?utf-8?B?TlhEVFNScmdmaitJa3pKRG5DSTY4bFFsZ3ZOUjRDR0JOTjY5ckpIQ3IzQ25u?=
 =?utf-8?B?TFg2OGNGTStnVno2dFZVZUw5Vk5kVkhQMi8yUExvTDY3alYzcXoxd2lQd0dQ?=
 =?utf-8?B?YXhyLzR3TkVjRHdmREpjbm45dUZlSzZSNUdtMDRMOWlNSXpyOUZBUFA1T3BD?=
 =?utf-8?B?RFh4YkUxak5nVjAxNXBQc0FHd25mQmpJY2hwRVhpdHJITzc0VnRReU8wOTRJ?=
 =?utf-8?B?THVGWUVaUHN0Nm9aZHB2SEpqQld5SlRoUG9odHdQR2dVUm1KNkRYWldHbkU4?=
 =?utf-8?B?UGxROE5jS0xZRXBxdXJvcllXT1JzVk5EREpVSm5Mbmtvby91a1dwbmFjRjlt?=
 =?utf-8?B?RUN5dFV1Ynp4RWRkMFExaHpLYmJuczV1cmM2MXAzZ1ZDRURVZmFJamFhaFB5?=
 =?utf-8?B?SXExQnBwTU5GWjg2NjBIdjhQNW9NY3p0Y0lKVjcwcVNUZXlyaU1ueHNrQWQ5?=
 =?utf-8?B?MFF0V0lBVmQvTU1DcC9CUjJ5RS9oZEtBV2pmZit3K2xpekFTUFQ1OTBja3Rz?=
 =?utf-8?B?VkZtbTdlbmJaVW1aMHRxZ2lWRVR2ZXdKbEx5enAzRkQvdmNzdEl1OG1JMy8r?=
 =?utf-8?B?azhPRmhpZ3dFMXorQVRibkkvdlh6YnpxSjFWSkZ3bEtjRlFkM2JtdTZJMkgz?=
 =?utf-8?B?WllnUXE5ZHd5amxRdWhuRmhla2tzRlZlSkp0K0tCaHZkTDJsRXBXN1UyaW9E?=
 =?utf-8?B?MGZhMlNMQ2ovWDRGUnFYWDVNVVFDMG84MzZpelpoUFdSSWtHSHRPdUxFQzNI?=
 =?utf-8?B?UytkaEp3cXFvOGlwTXZmSi94TFZpNDJubmRJdS9sQXloallkaVRvaUlWTFpF?=
 =?utf-8?B?UjVFOUk3cVpWQTN0Uk9aTGtzZmFTQkJWWXZyVCtXcWJOU2Z0WHVUcVJZR2NG?=
 =?utf-8?B?NkhhTCtLQ3FTMnVhNzg5SzdwemtINkFBZmFXdk96YWFCUVJOU3AxTFJWY0Jk?=
 =?utf-8?B?SWpEYlhxWkJYaTUzM3B6R3dDOGljTFBsOHA5cE5jM3M3WXg3ak1oMU0rbzRW?=
 =?utf-8?B?a0J0ZHJoYThFeThtM3d3eEwwZjlIL0ZvM1ZLUG1pVE9oL3hSMi9VNDczSGpK?=
 =?utf-8?B?WHpzekFkZmNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4500.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXBKZGloRGswM20wUGhIVnF3NHNPWEFvQ0xUaHJFaTB0d2ZpRzBVZldZQTlu?=
 =?utf-8?B?d3drcytNWWFUSWc3MWVheTVEZ3NiN2RSNHZlQ3p5Nll2MDVkd2ZxY1dPaS9m?=
 =?utf-8?B?UlRsc1hEWlVYV3pjTUV5YitOUEltSFhzLzRCT0tWV2FXb3RvMFBWbkxia1cx?=
 =?utf-8?B?dkNkQTFFWjh6SW8rOHFRLzdpZVZJV3NVeS9oY1U4QjE3RWtJbGxlQzN1TS9Q?=
 =?utf-8?B?N0RsdHo2QkFHazRGSUNsNDV0RTY5MFgyWldPVGJFQXBPdEFWQ3JLMmdGbi8y?=
 =?utf-8?B?V1VqdnF2NG5nWC9Hdm1Tck94RXlOcmRkbmZDWmNvQ3UvZlhBa0FvVndUSk9N?=
 =?utf-8?B?TjNBVXdES2VOblBhR1Vyd1ZQNUkvWmVRdm9VeVkzTGRZa2ZqUmlPY2JEY2Vq?=
 =?utf-8?B?ZVdWVVBOcHQ1bUp4S0JsQlNCNUhYbjFQLzRRYUFmRGh5enRFTnphSk1RMkpH?=
 =?utf-8?B?eWcvWTFlR01YMEhXb201QzY2NnF1Y1JwbnlxeGdSNjBaYlR0bVhuNHBtRmVS?=
 =?utf-8?B?VU1nR09HQWx1T0RWaVlYLzRLaldDcU4vVGNNOTgwQzZtMzBFeisyU3pqaTZ0?=
 =?utf-8?B?QWhUcVZxSzUxeEEybnkzZ0k3QzAxek40anpYb1lJdHpTSlV6ZmxDSWNsVDBU?=
 =?utf-8?B?MXZvOTV5ZW9wRk5HNytUUTlsbTJWU2h4QjVQZFB2MW9EdndKRytLNkNNRzA1?=
 =?utf-8?B?Y3BqUE5jRTZNTWVGSUxnZUpybkhUNklGVnhLTlV3eWZsV09hZ2lPcENDWGJI?=
 =?utf-8?B?b29uRllyNVdObXFsbFNtdnByV3RpeWJTTnZXNnRHQ3A5bmw1NzJONzRDWEh1?=
 =?utf-8?B?a1VKNHUvMWdtUnhUMCtoMUowMCtWTnFpOUQyV1U5YUZhMkF1RThRM3BDSWV2?=
 =?utf-8?B?ZndyelBVNXgweXQ2WDBnOS8wank1ZWZHMmxQcXdMb2hiUnNTM25VUlhsZWlt?=
 =?utf-8?B?SG1SYUlTZ2VDTnJid1ZYWWFEcCszbmdXTVJ6WnYxbEtVUmhrZHZMb1BrUExK?=
 =?utf-8?B?WnJOREl5S0llU29nc2NZNENkeExOTy9iMSttVVNMZGV2YnA2dEVKckxzaDlr?=
 =?utf-8?B?Y0xJUlBXNWo2ZXRFazh4R24zUkhtUDJ6bEtrMDArMllRemJBZ1VVWGoyc3FN?=
 =?utf-8?B?QTFtTlZ2dnlSQ3lDNFlaa3dkNE5qOGNYdTB3bGczWXFDRDlYanlheHR1RVpt?=
 =?utf-8?B?b0FhUWV0RzBxUEZaZ1pDU0F4enlmUVcydVdqWE9xcmF5bjhzNmp2K29ndUg0?=
 =?utf-8?B?K3RGbzZTYTI2TUYvcHNnaWFsZE1oTStEM05ReHZ4WDBjbTZZdDkwcTRWS2tT?=
 =?utf-8?B?NlBqdFIxYXNCZzE0aHJ2RTFyNnlYYWQwVXpKRnJvUmk4UTIwK1pXZnpoL0NO?=
 =?utf-8?B?U01Od0dBV1dDYUxOZFhuSDlyZEJJOHV6bnJnTUZtbG82d0NEb3NZVUZPT2Fy?=
 =?utf-8?B?di85UUNsbjIzT2JBTjFUTEtEQWVjZUY3SUFpUS91MjBwbm1IYURRM0NJTTRx?=
 =?utf-8?B?ZmRXc3R6Tmd0bXgvYWNQQzNXN2pveUtsWHBuY3JlUmdhdEFWM254VVZhZjg1?=
 =?utf-8?B?Nm5TRkQvNTE4eDFOcFFTRVdBUy9Dd0hwSDJIeGY5YnYvbXZPSWdMTHlYZW40?=
 =?utf-8?B?SDlJWWNjYnJ5cTVMMGZaMFpteldlWStzcnJHNytEd2ZNT0pER1RCSTcvc0FV?=
 =?utf-8?B?clBxbitNenBySFVxUmFJN2hnZFdIeDRuZ3d6ZS9kWk9MQ1ZjRXM1VDhyTGJO?=
 =?utf-8?B?elNobmozTGpzWlZYYnIvYld0cE0wNHZqMGNzS3dXbHdyY1l4YmZnVThoYXF3?=
 =?utf-8?B?QStuM1B3V1BwdkhlaUJFNGxPMUs4SFQrcmdKMlI4c2hYcnN4N0pJQzVjNWNz?=
 =?utf-8?B?Mng0aHFPYjVpTitQc2hTSStkcitmUytyNFRmS0hhdFpvaFdsdHdDTWJVY2pQ?=
 =?utf-8?B?NkROd2hMK0lFOSswblY0TnZGcjU1R3lHZkFqMEZYM2p6V2tSSDQ4Ykc4dGlE?=
 =?utf-8?B?aVVBeWtaSERCRDRjYnh1dHFEZGMzamNvRWdZaWx5NG4xeHdJZzVSWmF3Q1pa?=
 =?utf-8?B?Q01EblhsS28zMFRsb3I0eER4ekFXamZwZFY4SE85SklDVUx2Z0RpOFBoWUZv?=
 =?utf-8?B?d0hYQUx5MWFuaXdnYnJhNUZPTGhOTHJFLzhiSEFyd2xlM1hHbTNRakNNVWM5?=
 =?utf-8?B?Z01MS1ZxcUtKbm9JdkZ3RXgwTXlNY3pQcmdTc1Azd29nbEdNZTVsQ1lFM001?=
 =?utf-8?B?bGZkYUYrSWJiL0tROFdKbFJkT2R6Vks3UXNVSXFMMXRIaE40dkt3VDlIVTVY?=
 =?utf-8?B?ZTRVZlR3S0JuczNDM2I5VC9MSjhkdVRBblg3VENkeWtkOUR3bXk2QT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/pYmH1nGaesJAZ+9it8jwP9M00OdYozseKHK54JfomDE9sHTAU0Tqx3vW9Xb2E4HJDwiRStmAj+T9sZ5nF9i/yPjdaeOR2Phwrvln7gqXmkD2pFJM9gEhZVEPWfeutgFt7NZFXRZ0cS7/Ii1SE7Mzj6tq8p02yoZvNyVqAEAp29qCZkJGWUKZTzJ+CuldnrlHJxll1pppTTzFDOIOEBwWPfI5kvPxPw/Yp90cXs5649KO941HBUe3d/oHL9M7iFWg6E1gSj4z/GSS4unis5oyCsMic3NwhDRzTYZuE2bVZeTrivTBDP46FyMIq9WwxA9LCDLlLp7J3EJPCXCCaHEWdesm9mDqazWVS10YqMV/nGIgR0bkeVaRAiExpubdwdTSSzwUbs1a3D4LOmMoUjLpnsAVDgRTxkiOs2ZDbysjhkG2gkdk+9BF+lsCHb7leNBwnOSntVPvCkQ0D88+C6/yRVgsEjf4lPdMzUTsQTYAZV+CeapBSHIw7w0xEACYthWwpNUK8d8xsfS+mllvQRpfR8bjW/q1yTg8r0eU1VFJ7EspZCFXjSZr/7pU1nN6BXmadMgnZf29CynVc/OZjdrubjYi0+rfHN8NRBzBR4g140=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a51ea4-bcdc-44f5-b166-08de4c744ed4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4500.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 16:05:55.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbsXmKUP3ubRxbu92CB4I8Xh6kFwygxNDyVRSZbFdLiKVCuvUx0ENSVwP4d9xNaYNZsSwQ/wcSnEkhm1AmdZJiSVtcddGWXob0jeLxdtX2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE0MSBTYWx0ZWRfXyiWC2/aTQjY4
 zFsygFwHw+Sgb9q3QoYs+N1p8YdOQeVpIZ/K7T7IDJQGJiv7wkzhyOxb7G1COtN2B5zNoo/LLqL
 wt+8atZm0yTvV6ainouvAu2CqAdswPTXpcTc4PW4+J6Q9eihdHa1Bv/nA35mgNRoBog1H8vvvHN
 7+wFN/YKxSJTOLjw2kL2p11hVPz/fA7sqNzTtVsNdCvnwE+CCbKw1HI/957MzOoSsywWWMylFYP
 nsrnl0GLLbnRPZcPXbB/Wkf5P3hwHp/UaSum+d2diGco68wyqDyow9uBS7fznk2/uT4aZxL+eZ9
 R0BTpMb2s16NCkJQClr6vk3jf4g1xbnizjEeer8YM/9d8kBmLcoF8AbBmnOZXLyo2IH2TY3Z8hi
 OZqr46O5dG/i6bF1llsFMnDZEfxaOaqvpGzKUls94CHZ1XrM/HIRY8qX0QR7qmWSAPsqNjeZng1
 dx5Bx3rcvc1+ud9ypVjnLPhlIc2quU6B/PGsmGjA=
X-Proofpoint-GUID: J_BdxAiV5F2dX3WaOtzqR_n8J5BeKjRI
X-Proofpoint-ORIG-GUID: J_BdxAiV5F2dX3WaOtzqR_n8J5BeKjRI
X-Authority-Analysis: v=2.4 cv=F89at6hN c=1 sm=1 tr=0 ts=695be169 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=yPCof4ZbAAAA:8 a=7ye_zi1hKM_BEm8CpxkA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654


>> FWIW I tested the reproducer with gcc-bpf and got no pointer conversion
>> warnings (not that I was expecting anything different, but just in
>> case):
>>
>>  $ bpf-unknown-none-gcc -std=3Dgnu11 -I./tools/include -g -O2 -c text.bp=
f.c -o test.bpf.o
>>  $ bpftool gen skeleton test.bpf.o -L > test.bpf.skel.h
>>  $ g++ -c test.cpp -I.
>
> Thanks for testing.
>
> The issue only occurs when bpftool gen skeleton is used in use_loader
> mode (bpftool gen skeleton -L|--use-loader).
>
> Could you double-check if -L was included? I can reproduce the error
> reliably with it =E2=80=94 here=E2=80=99s the full output:

I meant to say that I tested the reproducer _with your patch applied_.
It indeed cures the issue :)

Sorry it wasn't clear.

>
> $ rpm -qf `which bpf-unknown-none-gcc`
> gcc-bpf-unknown-none-15.2.1-1.fc42.x86_64
> $ bpf-unknown-none-gcc -std=3Dgnu11 -I/usr/include -g -O2 -c test.bpf.c -=
o test.bpf.o
> $ bpftool gen skeleton test.bpf.o -L > test.bpf.skel.h
> libbpf: elf: skipping section(2) .data (size 0)
> libbpf: elf: skipping unrecognized data section(7) .comment
> libbpf: prog 'handle': missing .BTF.ext line info for the main program, s=
kipping all of .BTF.ext line info.
> $ g++ -c test.cpp -I.
> In file included from test.cpp:4:
> test.bpf.skel.h: In function =E2=80=98test_bpf* test_bpf__open()=E2=80=99=
:
> test.bpf.skel.h:65:26: error: invalid conversion from =E2=80=98void*=E2=
=80=99 to =E2=80=98test_bpf*=E2=80=99 [-fpermissive]
>    65 |         skel =3D skel_alloc(sizeof(*skel));
>       |                ~~~~~~~~~~^~~~~~~~~~~~~~~
>       |                          |
>       |                          void*
> test.bpf.skel.h:68:55: error: invalid use of =E2=80=98void=E2=80=99
>    68 |         skel->ctx.sz =3D (void *)&skel->links - (void *)skel;
>       |                                                       ^~~~
> test.bpf.skel.h:73:47: error: invalid conversion from =E2=80=98void*=E2=
=80=99 to =E2=80=98test_bpf::test_bpf__bss*=E2=80=99 [-fpermissive]
>    73 |                 skel->bss =3D skel_prep_map_data((void *)data, 40=
96,
>       |                             ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~=
~
>       |                                               |
>       |                                               void*
>    74 |                                                 sizeof(data) - 1)=
;
>       |                                                 ~~~~~~~~~~~~~~~~~
> test.bpf.skel.h: In function =E2=80=98int test_bpf__load(test_bpf*)=E2=80=
=99:
> test.bpf.skel.h:196:43: error: invalid conversion from =E2=80=98void*=E2=
=80=99 to =E2=80=98test_bpf::test_bpf__bss*=E2=80=99 [-fpermissive]
>   196 |         skel->bss =3D skel_finalize_map_data(&skel->maps.bss.init=
ial_value,
>       |                     ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
>       |                                           |
>       |                                           void*
>   197 |                                         4096, PROT_READ | PROT_WR=
ITE, skel->maps.bss.map_fd);
>       |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~
> $ cat test.bpf.skel.h=20
> /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> /* THIS FILE IS AUTOGENERATED BY BPFTOOL! */
> #ifndef __TEST_BPF_SKEL_H__
> #define __TEST_BPF_SKEL_H__
>
> #include <bpf/skel_internal.h>
>
> struct test_bpf {
>         struct bpf_loader_ctx ctx;
>         struct {
>                 struct bpf_map_desc bss;
>         } maps;
>         struct {
>                 struct bpf_prog_desc handle;
>         } progs;
>         struct {
>                 int handle_fd;
>         } links;
>         struct test_bpf__bss {
>                 int val;
>         } *bss;
> };
>
> static inline int
> test_bpf__handle__attach(struct test_bpf *skel)
> {
>         int prog_fd =3D skel->progs.handle.prog_fd;
>         int fd =3D skel_raw_tracepoint_open("sched_wakeup_new", prog_fd);
>
>         if (fd > 0)
>                 skel->links.handle_fd =3D fd;
>         return fd;
> }
>
> static inline int
> test_bpf__attach(struct test_bpf *skel)
> {
>         int ret =3D 0;
>
>         ret =3D ret < 0 ? ret : test_bpf__handle__attach(skel);
>         return ret < 0 ? ret : 0;
> }
>
> static inline void
> test_bpf__detach(struct test_bpf *skel)
> {
>         skel_closenz(skel->links.handle_fd);
> }
> static void
> test_bpf__destroy(struct test_bpf *skel)
> {
>         if (!skel)
>                 return;
>         test_bpf__detach(skel);
>         skel_closenz(skel->progs.handle.prog_fd);
>         skel_free_map_data(skel->bss, skel->maps.bss.initial_value, 4096)=
;
>         skel_closenz(skel->maps.bss.map_fd);
>         skel_free(skel);
> }
> static inline struct test_bpf *
> test_bpf__open(void)
> {
>         struct test_bpf *skel;
>
>         skel =3D skel_alloc(sizeof(*skel));
>         if (!skel)
>                 goto cleanup;
>         skel->ctx.sz =3D (void *)&skel->links - (void *)skel;
>         {
>                 static const char data[] __attribute__((__aligned__(8))) =
=3D "\
> \0\0\0\0";
>
>                 skel->bss =3D skel_prep_map_data((void *)data, 4096,
>                                                 sizeof(data) - 1);
>                 if (!skel->bss)
>                         goto cleanup;
>                 skel->maps.bss.initial_value =3D (__u64) (long) skel->bss=
;
>         }
>         return skel;
> cleanup:
>         test_bpf__destroy(skel);
>         return NULL;
> }
>
> static inline int
> test_bpf__load(struct test_bpf *skel)
> {
>         struct bpf_load_and_run_opts opts =3D {};
>         int err;
>         static const char opts_data[] __attribute__((__aligned__(8))) =3D=
 "\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x9f\xeb\=
x01\0\
> \x18\0\0\0\0\0\0\0\x64\0\0\0\x64\0\0\0\x41\0\0\0\0\0\0\0\x01\0\0\x0d\x02\=
0\0\0\
> \x18\0\0\0\x03\0\0\0\x08\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\x01\0\0\0\0\0\=
0\0\
> \x02\0\0\0\0\x13\0\0\0\0\0\0\x0e\x02\0\0\0\x01\0\0\0\x0c\0\0\0\x01\0\0\x0=
c\x01\
> \0\0\0\x3c\0\0\0\x01\0\0\x0f\x04\0\0\0\x04\0\0\0\0\0\0\0\x04\0\0\0\0\x68\=
x61\
> \x6e\x64\x6c\x65\0\x69\x6e\x74\0\x68\x61\x6e\x64\x6c\x65\0\x76\x61\x6c\0\=
0\x63\
> \x74\x78\0\x72\x61\x77\x5f\x74\x72\x61\x63\x65\x70\x6f\x69\x6e\x74\x2f\x7=
3\x63\
> \x68\x65\x64\x5f\x77\x61\x6b\x65\x75\x70\x5f\x6e\x65\x77\0\x2e\x62\x73\x7=
3\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xbd\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x0=
2\0\0\
> \0\x04\0\0\0\x04\0\0\0\x01\0\0\0\0\x04\0\0\0\0\0\0\0\0\0\0\x74\x65\x73\x7=
4\x5f\
> \x62\x70\x66\x2e\x62\x73\x73\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x06\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xb7\0\0\0\0\0\0\0\x95\=
0\0\0\
> \0\0\0\0\0\0\0\0\x05\0\0\0\x11\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x68\x61\x6e\x64\x6c\x65\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\x10\0\0\0\0\0\0\0";
>         static const char opts_insn[] __attribute__((__aligned__(8))) =3D=
 "\
> \xbf\x16\0\0\0\0\0\0\xbf\xa1\0\0\0\0\0\0\x07\x01\0\0\x78\xff\xff\xff\xb7\=
x02\0\
> \0\x88\0\0\0\xb7\x03\0\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x05\0\x11\0\0\0\0\0\=
x61\
> \xa1\x78\xff\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x7=
c\xff\
> \0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x80\xff\0\0\0\=
0\xd5\
> \x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\x61\
> \x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\=
0\0\0\
> \xbf\x70\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\=
0\0\0\
> \0\0\0\0\0\xd8\x05\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\=
0\0\0\
> \0\0\0\0\0\0\0\xd4\x05\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\=
x61\0\
> \0\0\0\0\0\0\0\0\0\xc8\x05\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\=
0\0\0\
> \0\x05\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc0\x05\0\0\x7b\x01\0\0\0\0\0\0\xb=
7\x01\
> \0\0\x12\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xc0\x05\0\0\xb7\x03\0\0\x1c\0\=
0\0\
> \x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xd7\xff\0\0\0\0\x63\x7a\=
x78\
> \xff\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\x06\=
0\0\
> \x63\x01\0\0\0\0\0\0\x61\x60\x1c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\=
0\0\0\
> \0\0\0\0\0\0\xec\x05\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\=
0\0\0\
> \0\0\0\0\0\0\0\xe0\x05\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\=
x07\0\
> \0\0\0\0\0\xc5\x07\xc6\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x6=
3\x71\
> \0\0\0\0\0\0\x79\x63\x20\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\=
0\0\0\
> \0\0\0\x28\x06\0\0\xb7\x02\0\0\x04\0\0\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\=
0\x01\
> \0\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x6=
2\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\=
x38\
> \x06\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x30\x06\0\0\x18\=
x61\0\
> \0\0\0\0\0\0\0\0\0\x40\x06\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\=
0\0\0\
> \x28\x06\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x48\x06\0\0\x7b\x01\0\0\0\0\0\0\=
xb7\
> \x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x38\x06\0\0\xb7\x03\0\0\x2=
0\0\0\
> \0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xa2\xff\0\0\0\0\x18\x6=
0\0\0\
> \0\0\0\0\0\0\0\0\x58\x06\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x88\x06\0\0\x7b\=
x01\0\
> \0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x60\x06\0\0\x18\x61\0\0\0\0\0\0\0\=
0\0\0\
> \x80\x06\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x70\x06\0\0\=
x18\
> \x61\0\0\0\0\0\0\0\0\0\0\xc8\x06\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\=
0\0\0\
> \0\0\0\x78\x06\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xd8\x06\0\0\x7b\x01\0\0\0\=
0\0\0\
> \x18\x60\0\0\0\0\0\0\0\0\0\0\x78\x06\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xf8\=
x06\0\
> \0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x18\x61\0\0\0\=
0\0\0\
> \0\0\0\0\xf0\x06\0\0\x7b\x01\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\0\=
0\0\0\
> \0\0\0\0\0\0\x90\x06\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\x6=
1\0\0\
> \0\0\0\0\0\0\0\0\x94\x06\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\x1=
8\x61\
> \0\0\0\0\0\0\0\0\0\0\x98\x06\0\0\x7b\x01\0\0\0\0\0\0\x61\xa0\x78\xff\0\0\=
0\0\
> \x18\x61\0\0\0\0\0\0\0\0\0\0\xc0\x06\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\=
x05\0\
> \0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x78\x06\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\=
0\0\
> \xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x6d\xff\0\0\0\0\x63\x7a\x80\xff\0\=
0\0\0\
> \x61\xa1\x78\xff\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\=
0\0\
> \xa8\0\0\0\x61\xa0\x80\xff\0\0\0\0\x63\x06\x28\0\0\0\0\0\x18\x61\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\0\0\xb7\0\0\0\0\0\0\=
0\x95\
> \0\0\0\0\0\0\0";
>         opts.ctx =3D (struct bpf_loader_ctx *)skel;
>         opts.data_sz =3D sizeof(opts_data) - 1;
>         opts.data =3D (void *)opts_data;
>         opts.insns_sz =3D sizeof(opts_insn) - 1;
>         opts.insns =3D (void *)opts_insn;
>
>         err =3D bpf_load_and_run(&opts);
>         if (err < 0)
>                 return err;
>         skel->bss =3D skel_finalize_map_data(&skel->maps.bss.initial_valu=
e,
>                                         4096, PROT_READ | PROT_WRITE, ske=
l->maps.bss.map_fd);
>         if (!skel->bss)
>                 return -ENOMEM;
>         return 0;
> }
>
> static inline struct test_bpf *
> test_bpf__open_and_load(void)
> {
>         struct test_bpf *skel;
>
>         skel =3D test_bpf__open();
>         if (!skel)
>                 return NULL;
>         if (test_bpf__load(skel)) {
>                 test_bpf__destroy(skel);
>                 return NULL;
>         }
>         return skel;
> }
>
> __attribute__((unused)) static void
> test_bpf__assert(struct test_bpf *s __attribute__((unused)))
> {
> #ifdef __cplusplus
> #define _Static_assert static_assert
> #endif
>         _Static_assert(sizeof(s->bss->val) =3D=3D 4, "unexpected size of =
'val'");
> #ifdef __cplusplus
> #undef _Static_assert
> #endif
> }
>
> #endif /* __TEST_BPF_SKEL_H__ */
>
> At 2026-01-05 19:50:25, "Jose E. Marchesi" <jose.marchesi@oracle.com> wro=
te:
>>
>>FWIW I tested the reproducer with gcc-bpf and got no pointer conversion
>>warnings (not that I was expecting anything different, but just in
>>case):
>>
>> $ bpf-unknown-none-gcc -std=3Dgnu11 -I./tools/include -g -O2 -c text.bpf=
.c -o test.bpf.o
>> $ bpftool gen skeleton test.bpf.o -L > test.bpf.skel.h
>> $ g++ -c test.cpp -I.
>>
>>> From: WanLi Niu <niuwl1@chinatelecom.cn>
>>>
>>> Fix C++ compilation errors in generated skeleton by adding explicit
>>> pointer casts and using integer subtraction for offset calculation.
>>>
>>> Use struct outer::inner syntax under __cplusplus to access nested skele=
ton map
>>> structs, ensuring C++ compilation compatibility while preserving C supp=
ort
>>>
>>> error: invalid conversion from 'void*' to '<obj_name>*' [-fpermissive]
>>>       |         skel =3D skel_alloc(sizeof(*skel));
>>>       |                ~~~~~~~~~~^~~~~~~~~~~~~~~
>>>       |                          |
>>>       |                          void*
>>>
>>> error: arithmetic on pointers to void
>>>       |         skel->ctx.sz =3D (void *)&skel->links - (void *)skel;
>>>       |                        ~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
>>>
>>> error: assigning to 'struct <obj_name>__<ident> *' from incompatible ty=
pe 'void *'
>>>       |                 skel-><ident> =3D skel_prep_map_data((void *)da=
ta, 4096,
>>>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
>>>       |                                                 sizeof(data) - =
1);
>>>       |                                                 ~~~~~~~~~~~~~~~=
~~
>>>
>>> error: assigning to 'struct <obj_name>__<ident> *' from incompatible ty=
pe 'void *'
>>>       |         skel-><ident> =3D skel_finalize_map_data(&skel->maps.<i=
dent>.initial_value,
>>>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
>>>       |                                         4096, PROT_READ | PROT_=
WRITE, skel->maps.<ident>.map_fd);
>>>       |                                         ~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Minimum reproducer:
>>>
>>> 	$ cat test.bpf.c
>>> 	int val; // placed in .bss section
>>>
>>> 	#include "vmlinux.h"
>>> 	#include <bpf/bpf_helpers.h>
>>>
>>> 	SEC("raw_tracepoint/sched_wakeup_new") int handle(void *ctx) { return =
0; }
>>>
>>> 	$ cat test.cpp
>>> 	#include <cerrno>
>>>
>>> 	extern "C" {
>>> 	#include "test.bpf.skel.h"
>>> 	}
>>>
>>> 	$ bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
>>> 	$ clang -g -O2 -target bpf -c test.bpf.c -o test.bpf.o
>>> 	$ bpftool gen skeleton test.bpf.o -L  > test.bpf.skel.h
>>> 	$ g++ -c test.cpp -I.
>>>
>>> Signed-off-by: WanLi Niu <niuwl1@chinatelecom.cn>
>>> Co-developed-by: Menglong Dong <dongml2@chinatelecom.cn>
>>> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>>> ---
>>> changelog:
>>> v4:
>>> - Add a minimum reproducer to demonstrate the issue, as suggested by Yo=
nghong Song
>>>
>>> v3: https://lore.kernel.org/all/20260104021402.2968-1-kiraskyler@163.co=
m/
>>> - Fix two additional <obj_name>__<ident> type mismatches as suggested b=
y Yonghong Song
>>>
>>> v2: https://lore.kernel.org/all/20251231102929.3843-1-kiraskyler@163.co=
m/
>>> - Use generic (struct %1$s *) instead of project-specific (struct trace=
_bpf *)
>>>
>>> v1: https://lore.kernel.org/all/20251231092541.3352-1-kiraskyler@163.co=
m/
>>> ---
>>>  tools/bpf/bpftool/gen.c | 16 ++++++++++++----
>>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>>> index 993c7d9484a4..010861b7d0ea 100644
>>> --- a/tools/bpf/bpftool/gen.c
>>> +++ b/tools/bpf/bpftool/gen.c
>>> @@ -731,10 +731,10 @@ static int gen_trace(struct bpf_object *obj, cons=
t char *obj_name, const char *h
>>>  		{							    \n\
>>>  			struct %1$s *skel;				    \n\
>>>  									    \n\
>>> -			skel =3D skel_alloc(sizeof(*skel));		    \n\
>>> +			skel =3D (struct %1$s *)skel_alloc(sizeof(*skel));    \n\
>>>  			if (!skel)					    \n\
>>>  				goto cleanup;				    \n\
>>> -			skel->ctx.sz =3D (void *)&skel->links - (void *)skel; \n\
>>> +			skel->ctx.sz =3D (__u64)&skel->links - (__u64)skel;   \n\
>>>  		",
>>>  		obj_name, opts.data_sz);
>>>  	bpf_object__for_each_map(map, obj) {
>>> @@ -755,13 +755,17 @@ static int gen_trace(struct bpf_object *obj, cons=
t char *obj_name, const char *h
>>>  		\n\
>>>  		\";							    \n\
>>>  									    \n\
>>> +		#ifdef __cplusplus                                          \n\
>>> +				skel->%1$s =3D (struct %3$s::%3$s__%1$s *)skel_prep_map_data((void=
 *)data, %2$zd,\n\
>>> +		#else                                                       \n\
>>>  				skel->%1$s =3D skel_prep_map_data((void *)data, %2$zd,\n\
>>> +		#endif							    \n\
>>>  								sizeof(data) - 1);\n\
>>>  				if (!skel->%1$s)			    \n\
>>>  					goto cleanup;			    \n\
>>>  				skel->maps.%1$s.initial_value =3D (__u64) (long) skel->%1$s;\n\
>>>  			}						    \n\
>>> -			", ident, bpf_map_mmap_sz(map));
>>> +			", ident, bpf_map_mmap_sz(map), obj_name);
>>>  	}
>>>  	codegen("\
>>>  		\n\
>>> @@ -857,12 +861,16 @@ static int gen_trace(struct bpf_object *obj, cons=
t char *obj_name, const char *h
>>> =20
>>>  		codegen("\
>>>  		\n\
>>> +		#ifdef __cplusplus					    \n\
>>> +			skel->%1$s =3D (struct %4$s::%4$s__%1$s *)skel_finalize_map_data(&s=
kel->maps.%1$s.initial_value,\n\
>>> +		#else							    \n\
>>>  			skel->%1$s =3D skel_finalize_map_data(&skel->maps.%1$s.initial_valu=
e,  \n\
>>> +		#endif							    \n\
>>>  							%2$zd, %3$s, skel->maps.%1$s.map_fd);\n\
>>>  			if (!skel->%1$s)				    \n\
>>>  				return -ENOMEM;				    \n\
>>>  			",
>>> -		       ident, bpf_map_mmap_sz(map), mmap_flags);
>>> +		       ident, bpf_map_mmap_sz(map), mmap_flags, obj_name);
>>>  	}
>>>  	codegen("\
>>>  		\n\

