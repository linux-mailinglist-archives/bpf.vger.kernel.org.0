Return-Path: <bpf+bounces-75648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F7FC8F4F7
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 16:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7700234765B
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E113358CC;
	Thu, 27 Nov 2025 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S8TZcUri";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HfcH2nq8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF319B5A3;
	Thu, 27 Nov 2025 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257782; cv=fail; b=e4iWTecvKvr8x+ypbS6trDf6kRApgqzA86B5k3cnoMB0Sal4wp0Il2V0NH6H2Z6bCqqm+bkp4X+rHd5aTitoC73nvXjDphhvlaSYdQMl0J+ekGA5QlDnmLWVUaJ5lyrARMazmN4w3Ue11jIrqt1b0DgiXvz2vEBWkl5saCXx+h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257782; c=relaxed/simple;
	bh=x9qtR4liwedQVV/iTW5LF7ogJOKNTQ6jFetYnVLWXTE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KOe9oVARVln5QPbWPyWrJlwI6fWrGq2r0sQ1hozRg3hXQyapWXQQ+fduKz/REJOe8L8P9MyrzMR7c9gPTlq54dcfHZCesk9Y3OxPxnOp49TIb1obx9PRr7+GMOOSn8Erh1muCHgEuyk/7S5M2twwd/Pl613ldnT3ZquYKec5uck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S8TZcUri; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HfcH2nq8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR9fYTF356103;
	Thu, 27 Nov 2025 15:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=T/rNiGe14VUw93mPvuQNrE3JknlP4ETz3/BQrqqEeZM=; b=
	S8TZcUrifzwttHnPOQoPK8FXygwTixma44lCZiiITxx/BgkK4MyHLTvfQK3W+fhY
	QuJCMbdQ2NFP3OdxvfAZPWorjF+oGLGqL9AYYEuMLpi2mZLLwiraeJqa5alH6bNB
	LlvHJiVrdMdqfjTAxkexkEtvvEcXPU230mgHedXs3Z46IPTp+c+n0PsQHzOmiF7d
	Ovjqy3S8fEeo8ibki/4TK5PRW1vyf+ZjaAG3boGmytPBw3jO8W+ZlVheuQ/QvhSK
	bXnBzzfYd+VCmmvy4xsZ7iiQ9KFbtCH5b9AHwwjB32s+l32cyA/pS9Hn66BDzR5D
	dgGOMl85SUo9b0gRjeUXpQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4apm7ugh85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 15:36:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARFU6Ac019517;
	Thu, 27 Nov 2025 15:36:09 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mcd6y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 15:36:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTKWi8/7XmhU+K3HQYdCRtIsHRdPK+3oGO0p60QBjvppd6NdD5SahnR//qxc2zvqLFSgwboT/nUMrSdjKb1Zf8kGCseGhD4ZLN99dUk8aNxlQwa9WE0HIrJ/MHaJludJ3yel4sYeSlmwOyySuIebnB1G+f0rbh54fLyaOqeRpm1otSz2Wz9TXvczF1CXxgISN5N75eBt7D90aHGcGmty9F6NUhAnDpwuk6l2hu92bcl+Z4rfPvP3KHB69bRw/VyNZeV2ydEVcAoTo+pzUB+4hFxMWEKQrHqjzoi69Aqrtze+kSrsIxJsOuImRS9tWlA8xeATGRNlYlil1FW/EA5Q4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/rNiGe14VUw93mPvuQNrE3JknlP4ETz3/BQrqqEeZM=;
 b=YdHOrpsVx0dx0gYksxImbqo7ZOLjhTJAGDlrJlG+mS35IVxYig1oR4FQliSXgaOtBBqbalelAG8hQyUKrzuKh6syWITzbfeumyI2FqEH/cL6xnvTyrNLgLzOVgXThhVhe4D0R6Ptx5tYS6Xd0O82rz8Pjpvmu01tOq7XG7jxI1qWyKRv1qeGA+8gbklpMCFXon2IqsR9Jzg31mUqW5afKuaFyWLtp0nGfMfQFYUn2OcQaOxqkxTvS8t/u8hJKAY7EcmKbpyTTmaO3yIBxJtGdaI/vfUb4hGotTbjSwKwt4F7lusNiz0Ww8HveyBsDfTva+FRMBswydbtjt73zrding==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/rNiGe14VUw93mPvuQNrE3JknlP4ETz3/BQrqqEeZM=;
 b=HfcH2nq8WclWfHddPERWL7B4iXPoW8AhSxZpszm9rsQBLZY3WIA0pZzyLum5tEMNbPCimSCGObSXUO0bJTvg1ZCmT/8MUKi3ijrWBTnJnGisaCbPc2khQQAUQb3SPxYxeIvqFburworAexuRMDhlHIfMyoTGQgEU14KgmnDuHW8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA1PR10MB997557.namprd10.prod.outlook.com (2603:10b6:806:4b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Thu, 27 Nov
 2025 15:36:06 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 15:36:06 +0000
Message-ID: <214308ce-763c-47a8-8719-70564b3ef49c@oracle.com>
Date: Thu, 27 Nov 2025 15:36:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: kernel build failure when CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN
 are enabled
To: Jiri Olsa <olsajiri@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>
Cc: Alan Adamson <alan.adamson@oracle.com>, bpf@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com>
 <aSgz3h0Ywa6i3gKT@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aSgz3h0Ywa6i3gKT@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA1PR10MB997557:EE_
X-MS-Office365-Filtering-Correlation-Id: 369f5130-e744-4a64-7f27-08de2dcaae36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|3122999012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N09wS0dWK3pKZzBnelRBcHBoQi9CL3JBNUdza25HNnQvbjFnS3BvblhpcGZr?=
 =?utf-8?B?ek9OSXlyWWVIdzVJWUY2VWExZWRlMnZvUWpmSFJtWEJVZ0xxQ1VuWkhydWJV?=
 =?utf-8?B?cnN5UCsvRmJYa0JncHlzaFlMbkRpRFM5eFk2K1ZtWDkzZ094WnM1WnE2eUMx?=
 =?utf-8?B?ZndwRnR1S0dCS1p2YVozZU4zamY1TkhPNlZNSFdPeGFSUzRMSkgrTFgwcFhv?=
 =?utf-8?B?dUFuV1I0OVFGcm02Ty9jL2hURzc4dEVoaGpDamkvUXBXNXg5VUNiUGF5WDd3?=
 =?utf-8?B?dmhaMmRaRUZubldBOUJ6eUlMdGpjRzV6RFZBNjA1K3gzNGE5aDBaeVRLNFp6?=
 =?utf-8?B?bE1rZ2hlVEtJUThnYU53bjFJVHJnMHFrRHFqN0dIaEFuMjdKQXprUkVtd01u?=
 =?utf-8?B?UHpMYzhxOFJLVU5OMG9KdDVhZGFIeERZY09aVmM1VVZnRHhGaHFzNlplNTk2?=
 =?utf-8?B?dUJ4TDNyczExZ1hoVmwrT2ExY3BCaUpNaHBFUmZweEtoYU51VWZReVRqbjg2?=
 =?utf-8?B?TlpZMUdmdGZyMytwUDk4a1JoZDE2Unpab05UMXgrZHg0NlFqdFBtUG9yZWxX?=
 =?utf-8?B?NlhGZDZ2anNkajVXU3cwM1pZYWV5SGZDaldaY2tpbUVhZW1mdlViaW04NEd2?=
 =?utf-8?B?MkxWdVlJWlRDOGZyTkRydGRDbnhGOHFXR0wvVXR0d0pRbFN1UjBOdzFvZE5V?=
 =?utf-8?B?all2ZXZlWGpuWUdSKy91WTVseDJoUVFPdDNRV3lvdmxucmNhaVdNN2RyNlFZ?=
 =?utf-8?B?QWsranJjQ2NBMzViRVQ4c2Rsdjc1NUxsbFlTNlhlZ2Fad1VaUm1JV1l1bnVz?=
 =?utf-8?B?bXhvMzI1bzRTcEphWHcyaFllWkV1SE4reHBMbkFhNFY3Qkszazl0YlMwTVkx?=
 =?utf-8?B?aDdFTDJxODZVNVkzT2FJdnJ6MGs2Tm0xalp0QjhDUFg5MzAzczNwVmlpaVZh?=
 =?utf-8?B?VGFicllUYnY5cStEdUVWdlBlTkY5WHdSdXZzanhTOE8vVUhVZzFVbCtQZ1h0?=
 =?utf-8?B?REdTR1dkaHZuZTN1OVpydldnNUpqc1FBZGdySko0S2pwNVgyZm0yWVh2enpL?=
 =?utf-8?B?UEk5OXJPVHk2dzMxT1pZcGFvcloyNUZQTUp3MTBpMFNGa0Rsa3IzWFpwemRL?=
 =?utf-8?B?VVhheWZPTUNuMEloNk9GWmY3cm4rSTFRYmh4dVc0WUIyY2RQc0Z3d2xjRGVU?=
 =?utf-8?B?cXNhVGRHenRuaWFjcU1WN0NrQnI2Mm1HL3RqLzZVY1BqcnYreTZicTA4VHRo?=
 =?utf-8?B?T0JsQzRzSDN0Q2x1S1RxOWt5eHVRdTRjNTg4ZWVIbWJxNmdCbDFmcGxQRnRw?=
 =?utf-8?B?cVdYemlrWElrajJmMHg4M2psTzY1ZEdMeE12dXhYVytCTERwSnVybVp0Wmdt?=
 =?utf-8?B?c3FPdXBuMFdjaC8vUUFscEYvTVFwRmRMQy9ScStVYWdHTmlnSGUydHFPYkox?=
 =?utf-8?B?bFYxRWlxWTltM2hTVVFYNHo3VXF5ZXgza2l3V3lIK1I0a3Jnd0dkVXB4UXR0?=
 =?utf-8?B?bUMrc0pzOTlvRkRCcjAwcUY4cE9SNU9jSmtwTVJxYTIxWFZTQ21rVkJQOWJI?=
 =?utf-8?B?bE16ell0SUJjVHE0R253aDJ5aHFUU3ppZUtaRFFRSUlIdkNvYlJkZTE3TWs2?=
 =?utf-8?B?eXJIK1lmdUlqV2NnTWkycmtEMWNSb1hJNlpPcEt6QWFIbUdsdlVHNko5d3dw?=
 =?utf-8?B?dVI4M1VSMFg1dmo4NkIwdXMrWk5TYVZCL28wZUQvMlpTbGszbmpuU1o3aXlv?=
 =?utf-8?B?eEhrb1JLUjBSai9MbXJhZElFUEExYmRKSy9vVmRzSHBpSmY0TjlMTXQ4Z25x?=
 =?utf-8?B?RUVERXkyTlNneldMRnRjTGVtZ1dZOHBKYjFuK1FDZXVCK1NDN09uMXVyaytl?=
 =?utf-8?B?QjJyODBRTmxKYUt2VE5uMGVFSGpZcmtYSmJTM3hZNXBVNEZjK3JwSFhBM0px?=
 =?utf-8?B?MzVEdktDb2NOMHA0SFFXZ3c4d1JWY1pzZXF4UVFnNnU4UW5mR2M0OEFsOHFZ?=
 =?utf-8?B?L1FoWFBGTnh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3122999012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VSszRmxhYVFZejBQQU9oSGo4N3NIRHhteEVWOTdKSTgzNzNNY1pyMUQxMHNy?=
 =?utf-8?B?c0lBWlBhczZLMk1iZkNkNldGRGttQjRKdVAwNGJJd2RXOUJkNGNaY2s3Yjlj?=
 =?utf-8?B?QjFMa3RMMjJneHBEK3lLdWRlY3Jmd3pLWUJtUDNEL0FCRTU4dlZldmY3RGJR?=
 =?utf-8?B?ZGdqeHRmSzZuek1qSlJoTWFUREhuQjBaVENxR3pEZHdsQ1puVHYwbm9LdU5q?=
 =?utf-8?B?MnJWdzlnZWg2ekpyUnJscjBRVFVHRzRwYnNBUkFqMHhrTDhaWGFkVUc0clAy?=
 =?utf-8?B?blFSV29jL0tWaWxUQTJGUjJiSnNJOXRDeVJZUmFPcENLVlorMzJ0VkMvSDlq?=
 =?utf-8?B?bEZLYjRCcklmUUR5VHIwQXZLUlJzWU8rclhJekh4a0ZROFI1UUhMYW1YSjMw?=
 =?utf-8?B?cGRRREJjNVdaZDNaaThYMTNraGE0SytKdE5vN2ZscTVJaWZOMGRYNC9udW9r?=
 =?utf-8?B?ZDFyYk5tVDdVN0hJU3hkMWJWcktsOHVNOHc4VXYwQ0I1bXZabmduNW90Skps?=
 =?utf-8?B?a2ZBbTdMZGdxbWw2alMwMlZZUWpKQ0hwNU5VTzZzZWJlcVREZFN3QmtVV1hN?=
 =?utf-8?B?TWFhaThRRWxFYlp2d2RxdXdNcDZvcTJnWUsvQUR1bmRxaXNJQVFFYmFoNVRU?=
 =?utf-8?B?NVZzMkFWQjkxOTQwUGZHNEpCT0hCNnd6bmZCclNzT3gyUndwOXQ1SzBzY1ZR?=
 =?utf-8?B?NlFtejVaelh2L2l5S0x3RWYrUjBqS01QT24zYmtEK1Z0aDFWVmJkUjNvN25D?=
 =?utf-8?B?eVJRYzU2L3hMZm1QeUhCV0RxTGp4MEh2cFhHb2tMWnFoc0RSNHVSbmlSOVNi?=
 =?utf-8?B?TVRwOVBGcExqR09QS3N2cXM0VTZYa29rMUxicG9QK0tDdEJueFo0TXdkWVJ2?=
 =?utf-8?B?M3FjK3JmUzJ6disxVlROWlRXN3lYeDBGeVpMM2NBMWpBaTNOc2Q3b3ZIb2Vj?=
 =?utf-8?B?L3NiSC9waERlUjN6bUZpNmpOS3Niek4vMGR2UEM4TUJEVXQySXR4cUhUakpO?=
 =?utf-8?B?bi9BRXI5V1NKZ2RHQjhXWEI0aGRZZDlURkNGVlpUMjVvcFdXNWJ4STFsU0g3?=
 =?utf-8?B?emRiSmpwcTRDQ3N2cEttWkMxNi9tYUI2bUFHZ29qQkJlZDBYZkNvZGxmZ1RP?=
 =?utf-8?B?ME5Cd3p5VCs3cm9FQ2ord1pxcTVJUkFBY2NvS0dOQnk1aWFkYTE5YWd6QWxI?=
 =?utf-8?B?MWR4VXpUaDd0VDdzV1VTNWtSS1Vkb0tUc1JJbmpTOHVEdngxdkpZdEwyZXpz?=
 =?utf-8?B?a00zcjZ4eVZJcXFEQ0NHUlp1K2RWTFB4cmVhUVVUSm9iVjFmaFFpd3VreEx2?=
 =?utf-8?B?a0wrRFZSdzNBR2xLSkNZVlpqTWxFcllITy82VDcrTTdMNk1IVGNkRTgzL0NQ?=
 =?utf-8?B?OEdFZEJrTEcwT08ySFQwNUEwSHNTSFlhN2ZMaEM3WXZSUThicS9Sdk5IbWRN?=
 =?utf-8?B?dmJmRVAyWUFTNzhQT0U5NlJOWGNxL2hFeG40U2JvNGdQejh5dXdGaEhCYzRp?=
 =?utf-8?B?SzRhNk9NNUdDVzh5MUozaXlPc0lTUmRNWVc5TEJJeEJNMWhzSlcxcGVqb3Fv?=
 =?utf-8?B?ZDl3OENFQmZoQ25nUDB6RlZnbTNubTRuSzU3OVc0azBacUhDd2dlcTFSWklu?=
 =?utf-8?B?QTU5K2g3U09JSWFEUVlJc2xJd2luTkQ4TTc2N2o1U3BoaWgrTFUwNUlpZTNE?=
 =?utf-8?B?MGZJZjVHMTdFcDFBMzRXVVk4R01paTNjb1c5UC9Ra1RiRllGbFZwMElraFh2?=
 =?utf-8?B?eU4yQS9wQUN4TWZ0dWp3YTdxMGhDUFJOQUlRYkN4NlBNc1pkYzAyWUYxS2to?=
 =?utf-8?B?NzJkcC82ZEVHdTMyV05vODJPTWFVVTl2bEgxc3Q3ZFhMdmhtYnVMeGZQRitL?=
 =?utf-8?B?TXdnQ213K3lPdlIzenFzOTZkMTNQYUxRS05HOG5UcjluQStMdEF4b2Q0YWlB?=
 =?utf-8?B?UThScFRtQS94MHFiNkJ1clFNd3Jqam9sUXNkRis1S0lSOGthdWxIWE1tRzRw?=
 =?utf-8?B?NVh2dUhHWXdxZ0lYNWlFZWtiTEhxdHR0cVdNb05seUtndm5EbU1ld3MxckhZ?=
 =?utf-8?B?NE5obkx1cldBTWxXdUxjdVFyVXpmenh1bzdRelNoNEQ3SFNoKytZVmNUemly?=
 =?utf-8?B?K3IvK3hPSVdiOTdlL2I4Vkw1SFd4RHc1aTBVNndSQ3h6c000b1l3K2xHKzJr?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8cKHa1qUvNE37kRORrlqPY2UzrEXFBRgMHB7M5xNjo+MwmVCrIu5R9nmaOx1HdKQqkVTcKJurx1RC7OO2saRSVAj9r9N+9ipjCuiFDAMDvAXkudaMpaqljtheMAJh2x6vGWyar/2iYAFw8IQa8QSVgOleuvGVJ9PehBPmkfrI8po9A01+ytZJo720j1QhD0NXCYLlC0yRlM7XqIuAeSdjs4pdYmt+ZeE7t/R25YRby/gJI+UZSe3TrMH8kN5qNzCt9mXiE+6cUnm8mIYZpZhM0nga2FczCS73YS0yhiUftiMePHlPUMa3BhCvVqJWQc79bFoela9lzAsa9JWCh/uW/F4uDn+P1UQyK/ZDE0O5Tz1Tjs09T0s+aro39l2kbodk/NagstxM5pbJnv/GFfY9xkNO0oJ3Xhxl6qTTAJIzDQV91wJ6RXYslCqOWhhxlRHA9a5TJWXpK4T5Ku7PS1uTyJU6/uX6psoYkeC1LBvgDHUN0rEJ18CsGVlX4UStVgQL+AfwZJtgYttdf5QfkdO77uck3l786Bvv12Kb/AXd5B0YvE8nNpr4ZGL79pgPw3pd564LvodZSJrusGqjny+d7sKPJpjlPL3/UT6H+Qo8yM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369f5130-e744-4a64-7f27-08de2dcaae36
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 15:36:06.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEKbsqeAky3vp2UULWeDA/x/7SXFaonwM1sOdVxmnQsNYYyQQbCIDp5vGnblGXjCea3ZPtmC0BYhl5qgI3UX5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511270116
X-Authority-Analysis: v=2.4 cv=RuHI7SmK c=1 sm=1 tr=0 ts=69286fea cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=yBgn2l3KOzHPuNscEeYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fvMltlobh2_6kzCSduoteuQL5olB-YOE
X-Proofpoint-GUID: fvMltlobh2_6kzCSduoteuQL5olB-YOE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDExNiBTYWx0ZWRfXz5OFarPQ9TBb
 bkHgW5PJWB5Dwwy4b+f3N9X+HEbyIONpa7YEeT8SFhBwkkEYwiqgdprokbdr7TU1j19KT8SYoxQ
 7DaY6zG1dijG87Zu60sl0vdJxRLL2h7w5Qr1OIkWvRk9Ew8mI1Vcvcu3vpERm0QyEy2BsqTA/LI
 +budxfme0a5XgeNEqo9uUt4Vovz1zk72YnVvQ21tCJcrHL+KfWslMNPxtL05JTVjeZtOgXQdc3Z
 HS3RprC5huC1ahJlTh/S+2OoN3GSKA56hX3gA5OzSSTkpKdDuAQuB3/iiB3dn7zx63dOrFk+oBb
 i0Kut2gDbQWsSzFsT0XkRbnwJwhwltm6cEHBh4g2mqZcrimNx6aP09NrNDV/ferxRJMZZ8Op2q9
 AjQuKHK31WCC9UCGgFrEyqdWmQTzBw==

On 27/11/2025 11:19, Jiri Olsa wrote:
> On Wed, Nov 26, 2025 at 03:59:28PM +0530, Nilay Shroff wrote:
>> Hi,
>>
>> I am encountering the following build failures when compiling the kernel source checked out
>> from the for-6.19/block branch [1]:
>>
>>   KSYMS   .tmp_vmlinux2.kallsyms.S
>>   AS      .tmp_vmlinux2.kallsyms.o
>>   LD      vmlinux.unstripped
>>   BTFIDS  vmlinux.unstripped
>> WARN: multiple IDs found for 'task_struct': 110, 3046 - using 110
>> WARN: multiple IDs found for 'module': 170, 3055 - using 170
>> WARN: multiple IDs found for 'file': 697, 3130 - using 697
>> WARN: multiple IDs found for 'vm_area_struct': 714, 3140 - using 714
>> WARN: multiple IDs found for 'seq_file': 1060, 3167 - using 1060
>> WARN: multiple IDs found for 'cgroup': 2355, 3304 - using 2355
>> WARN: multiple IDs found for 'inode': 553, 3339 - using 553
>> WARN: multiple IDs found for 'path': 586, 3369 - using 586
>> WARN: multiple IDs found for 'bpf_prog': 2565, 3640 - using 2565
>> WARN: multiple IDs found for 'bpf_map': 2657, 3837 - using 2657
>> WARN: multiple IDs found for 'bpf_link': 2849, 3965 - using 2849
>> [...]
>> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
>> make[2]: *** Deleting file 'vmlinux.unstripped'
>> make[1]: *** [/home/src/linux/Makefile:1242: vmlinux] Error 2
>> make: *** [Makefile:248: __sub-make] Error 2
>>
>>
>> The build failure appears after commit 42adb2d4ef24 (“fs: Add the __data_racy annotation
>> to backing_dev_info.ra_pages”) and commit 935a20d1bebf (“block: Remove queue freezing
>> from several sysfs store callbacks”). However, the root cause does not seem to be specific
> 
> yep, looks like __data_racy macro that adds 'volatile' to struct member is causing
> the mismatch during deduplication
> 
> when you enable KCSAN some objects may opt out from it (via KCSAN_SANITIZE := n or
> such) and they will be compiled without __SANITIZE_THREAD__ macro defined which means
> __data_racy will be empty .. and we will get 2 versions of 'struct backing_dev_info'
> which cascades up to the task_struct and others
> 
> not sure what's the best solution in here.. could we ignore volatile for
> the field in the struct during deduplication? 
> 

Yeah, it seems like a slightly looser form of equivalence matching might be needed.
The following libbpf change ignores modifiers in type equivalence comparison and 
resolves the issue for me. It might be too big a hammer though, what do folks think?

From 160fb6610d75d3cdc38a9729cc17875a302a7189 Mon Sep 17 00:00:00 2001
From: Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 27 Nov 2025 15:22:04 +0000
Subject: [RFC bpf-next] libbpf: BTF dedup should ignore modifiers in type
 equivalence checks

We see identical type problems in [1] as a result of an occasionally
applied volatile modifier to kernel data structures. Such things can
result from different header include patterns, explicit Makefile
rules etc.  As a result consider types with modifiers (const, volatile,
restrict, type tag) as equivalent for dedup equivalence testing purposes.

[1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/

Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index e5003885bda8..384194a6cdae 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4678,12 +4678,10 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 	cand_kind = btf_kind(cand_type);
 	canon_kind = btf_kind(canon_type);
 
-	if (cand_type->name_off != canon_type->name_off)
-		return 0;
-
 	/* FWD <--> STRUCT/UNION equivalence check, if enabled */
-	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD)
-	    && cand_kind != canon_kind) {
+	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD) &&
+	    cand_type->name_off == canon_type->name_off &&
+	    cand_kind != canon_kind) {
 		__u16 real_kind;
 		__u16 fwd_kind;
 
@@ -4700,7 +4698,24 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		return fwd_kind == real_kind;
 	}
 
-	if (cand_kind != canon_kind)
+	/*
+	 * Types are considered equivalent if modifiers (const, volatile,
+	 * restrict, type tag) are present for one but not the other.
+	 */
+	if (cand_kind != canon_kind) {
+		__u32 next_cand_id = cand_id;
+		__u32 next_canon_id = canon_id;
+
+		if (btf_is_mod(cand_type))
+			next_cand_id = cand_type->type;
+		if (btf_is_mod(canon_type))
+			next_canon_id = canon_type->type;
+		if (cand_id == next_cand_id && canon_id == next_canon_id)
+			return 0;
+		return btf_dedup_is_equiv(d, next_cand_id, next_canon_id);
+	}
+
+	if (cand_type->name_off != canon_type->name_off)
 		return 0;
 
 	switch (cand_kind) {
-- 
2.39.3


