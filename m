Return-Path: <bpf+bounces-57763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDABAAFBEC
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4344D1664B5
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E9E22D4F3;
	Thu,  8 May 2025 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y7+6XRbw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ugsls+Gk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3321B4223;
	Thu,  8 May 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711987; cv=fail; b=Fv9uL5yBI3PEEe1djpiu39SV3Hu37NXF87fb8nmfSgAXay8V3efSaQEDnLyVnrieqvCnVnoyxrqr1qyIFHj290uXedWlWMfkUiNVU4h4KGRrqlZG2c6qXEjWESvHnlUbZa1XLrYQeHJUT3urm3XtU/fwbWPuDAGrjEUaRJ1VIL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711987; c=relaxed/simple;
	bh=Upjis87QmevMC5UYwgxdOOYsmJv0TqVbFZG8yRRf5CI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IrmakIr4kMuzxa6anWGYsLQUzdArUX9rWSyw7jWfNw+rV3MUWoN1zAqSCsyjEaA/Y3Lcc356Htg+R/pBhM2MzVEq5ZJogmL4p2PbHA9V5I1o64bNawrFIeEP90CS+0WNiozvISoiTtSRsJEjvJ//iPfM7bCUd7TEesxRiv1S46M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y7+6XRbw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ugsls+Gk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548DfxKQ017199;
	Thu, 8 May 2025 13:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7nzxG8SKNHTyxeMDKIHTVkeB3pScjPo7SJdg5T8qts0=; b=
	Y7+6XRbwbeyUlsXJ0SLEhxXZfx7lB1ZB3kYwZVEJJPt8Lil5MqL/54hx++Na3bHC
	s178sjKlKaer+NhOBul/IRZMtWcje16nkmZmKqP7X9LWemWF4t6hP+Pinyt3rgfq
	j6ays808dooYakhXQFZhhgT6CJeEZIFLc7F5bZcUQv2ea5Q8nconSWxZ2kKb+fVx
	hRVaxEhIzoCvcmVFMEsLDQQGiNWyxkm9NLebRYYNvx9+CFPGgdTOG72iCbpsRI7K
	79oGVAE/roRsPn3VKJ/jhzAO3G4O31kv/r/zawawJgFJ9FqUld34mHClhPR35NVA
	QxhREdKEAPqa9F6mFhbEGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gwndg0te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 13:46:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548DJL4m007370;
	Thu, 8 May 2025 13:46:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46fmsaa8md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 13:46:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaUiGcpbD4IvTvkF4kab4RC2mwgMgzQMokx/QYYKHI4DUHV6frpuPu71NgjWJ98Khod3vWtnnkTzE7/9iexFEMJ8FNQaJQ4sG6+ekKiceIUnHGorlbtX9iOym12kC2rLGTKC6VaWjoVUbkHF74pusg2QGyb9BF7RG0OFGDIx99B5gl7EO+krEQbiglCT++T84l1JQjvBF2ZfOtJc7+q6m+EPKwSXpKPdpyVxQyM3XyRid1eWvh2wGFY0RkHY7RF9EURfNcqnOLQA6Y75wBAdxOQKFn+CTNN3enY8d8CRXYAezk63mbI5LqvDV7sxDaaDiD2RYnRGcd96MZTy5lLBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nzxG8SKNHTyxeMDKIHTVkeB3pScjPo7SJdg5T8qts0=;
 b=noJfQlkceo5bBEtAEMRFGoqsrYaz/nDu3znZznScXmUBlYIFl73aWZlCYCinj8amoNZxyNI1OFQ8VkkkK6Knodc2NsfExCF8GkJWT2EAZP8O6kDtxrVE8MYS5KRDLITaaxeJQrHbOiInGtX91v2pm0AXNMunsrxfV5rGZG2QKtnlOaNit55sc2g8O6Zxyl0JLX4cGpQtNA0o7lIMRWFDlsosMtt4E/AZ29S7pxDR1s0ngaIAbgf1J4cS6GwrvnN7zNftKFOXkUygVVCYpiQU78I4Io3yg1Zp40rQ/wI9keehFZmxIcAqIjLUnwi230AMjhd7ELrZksyHT+QaRLnLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nzxG8SKNHTyxeMDKIHTVkeB3pScjPo7SJdg5T8qts0=;
 b=Ugsls+Gk5Fd7DLThe315iswVhrbEuB2Ha1liLKIGg4aNa2wZ1mxZcpJNShjdtmmsUAFhCbjewUGl9z4Cd4KytCepieyG5T+fArUi+qnoHTE8NfwbpB+g7OQG6I1QljvjWtcAVFrcnA2YWsLr/z5q+yXBKtkeja38VFglO+bLdCY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM3PPF743D15148.namprd10.prod.outlook.com (2603:10b6:f:fc00::c30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 13:46:04 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 13:46:03 +0000
Message-ID: <ae994be9-e0d8-45e4-8518-00488cbe3a1c@oracle.com>
Date: Thu, 8 May 2025 14:45:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 1/3] libbpf: update BPF_PROG2() to handle empty
 structs
To: martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
        tony.ambardar@gmail.com, alexis.lothore@bootlin.com
Cc: eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, dwarves@vger.kernel.org
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
 <20250508132237.1817317-2-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250508132237.1817317-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0158.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::26) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM3PPF743D15148:EE_
X-MS-Office365-Filtering-Correlation-Id: be199346-0a56-455c-e0e2-08dd8e36acf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bCs2TFZwLzNheUFBZjNqRElYbm5qUlZSb3JseTZ3QWRGVWtJaTVPSW5qUHJy?=
 =?utf-8?B?eEdWZjRzRzZScTNERXBueDViMnhTT2tVejlkVHZoMHJJV2xLQm9sMFdYeHpG?=
 =?utf-8?B?bUNQb2ZHQ01SUzdiZ3VBRHpBZEthNnZXN1RXbkdidDZzUjBkcmxqb0VPUExY?=
 =?utf-8?B?NUlQam5rN3NHT2p4VndDT01EblNoeiszWkhJUEtLRlQ1L0pmVHNMamtCa2FW?=
 =?utf-8?B?VWdRWnR4TzBma0hKNFhKaFZ5RERSMGtNM2Q3MEd5Ung2czBnNVBxTEh0TzRR?=
 =?utf-8?B?c2xIcndzTVRKa21YVm80UnMrN3Btby9FUmpNc3l2ZGovQjQ2MEtmZGdadXBO?=
 =?utf-8?B?aGRUNmp0QzRRWlhNdngwY0h2Rm1CSW1wUDdVc1h3WkxmOHIyQThvVUFwYk56?=
 =?utf-8?B?T0RLcnRnVHB1NVpVNUlWa25jN3paRmdTQ1dtb0J3TlF5VVNtWStOWFZyZUZR?=
 =?utf-8?B?N0liOFVvZjZDZUNTbEhpOXN6TUp2dU1KM3lGSURLbnprOE5sT1RJQmFBUWlX?=
 =?utf-8?B?T21XbDJvSDQ0M3JFeFF2SjVaQzhJMGJDWTFHcmRxc0VaNlhRejg0ZFg0cWto?=
 =?utf-8?B?RHhHMGMxK2RsNXFDVnBDOXF6eFFsUnpaVlh2YkhvWnFKSzFmOGUyVnJHb0hi?=
 =?utf-8?B?amlmbk1JTFQzUmtMRFhzTkNLWldxLzdYRk13VXQ1M09keWRlZTBNRXVkTFcv?=
 =?utf-8?B?R204OE1jMkRlelhKTmNBcjMwUUNBMWdmL09DM1VhZ1psL3Y5R085UVlGajV2?=
 =?utf-8?B?dUxybmxlY1FMZCs1cGpPK2t2KzltTnE1RmU2amI4cy9LZTRQSTZ5L0M4S0xV?=
 =?utf-8?B?blRzaUxmWUJOK2RaYXRZejBzVTI0TG1kUkIvRmpkU3liOHlrR3FsZkVjTjE2?=
 =?utf-8?B?bVFzb2ZYa1ErNXIybEx1QVQ4WVc5amJCNkhzM2VDc0t0eUV6dmExZTNmclo0?=
 =?utf-8?B?MnpiVk95UWR6L2lDTjdCWGxmRnJSZUpkY3poRHlldG9VR2lQUWVHYmxqWGtT?=
 =?utf-8?B?TDVJai8yMnhLRlFCYWZQdTZFT1pNS1RGSERhK3ZqUVhVaUlsRTh3YXBwaFNP?=
 =?utf-8?B?K3JUdE1aZFdaR2NBZWlLRVFreC81d0lsU1NKZU1rdzZIZnZuS3FIREd2VjRn?=
 =?utf-8?B?R3FTTm9VbWgrVC90Y2owbzlCQ1YzNjJFNVZYd3BNbHdDQ2xzMUV6NG9sS1Ix?=
 =?utf-8?B?bFN2UzdQcTJCak9ZMnJoU1U1NHpJYitXajFrV2dHL3JocGtlTVQ5YzRCaWRD?=
 =?utf-8?B?NERtNDV0TmVnNW10aGZkc3hTRTFxRlBXSnh0VXZCeEJYQTcrVzhrenBaM2VC?=
 =?utf-8?B?R1dsK1IvYmJBdlJLS0QyOW9qVEtaRTkyMVNMTE9PSENsWGJ1OGVmODRPandT?=
 =?utf-8?B?WVVkcFdkRFIyMmswK1pzblp1c0hCV0FMbk9KR2ZpSCt0NHBqUnRVMDlIQWZo?=
 =?utf-8?B?c295SDh6bmp4NjliNVdiS1U5MUpEUnNReExsLzhkYVY3OHZxcng4SGY1N244?=
 =?utf-8?B?THNVNXpGaHBzbk5XT2RlRC9tUmFkdFA0RHhXU3NQRGYwYkJoN05vcG5DRVdm?=
 =?utf-8?B?cHpJOHFzR1JJYTc0azFJR1YyWXRHMWZNUFJkbUNpQ2RMa0Y2Y3JBaWN6MnhE?=
 =?utf-8?B?WEx2V0xOSnltRVBKazQrb3Y0a3FLdFU3RWpnUlY2aGtLWXd6M3NzVmJ6N1Yr?=
 =?utf-8?B?NG1VWDRwenhBNVh6czRRMU1MQ3J1OHUxYytPdGxkNUU5QTgrZlp4WHZPZlNZ?=
 =?utf-8?B?MFR4MGRETjNwRzZzSWFPbjhuL2RiSHlicE83UXZ4LzVHMU9icXc5d2VLS1hv?=
 =?utf-8?B?ZHB0UHY0NlBqSmQra1BkMWRDeE1PTVc5b205NUFkczhnV1ZiTFhVMG1rZlU5?=
 =?utf-8?B?K2FyZm1xM1VrSFVDUnZtcHUybVR2TEp5R3RpUUZ2eUg2SXJDWktaZnZJakhB?=
 =?utf-8?Q?IC3EcsDOEzA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFErbGNqZnVzcXRTNzJDclZUR1BleFpNSUo1bStBZ1h3WENCdzFZMi9yYk1B?=
 =?utf-8?B?NUZJUGV2NWN0MmJBdkkxZE5PU0MrRjNjdSt5SVV6K0YyUC8vOHIyYjBlVDQ5?=
 =?utf-8?B?VktqNkJkMEVzZmJWMDVYZ0c4TXB6b2JEbkE3NXFXK3pWNElCY1NiMmVqZkc3?=
 =?utf-8?B?Tit3Rk5wWFBidFd3b016b294NCs1VW96cnJTMG1NWGZ6Y2pualhRMzYrd3Bk?=
 =?utf-8?B?OTZvZWpxdVhVcXZ5cC9WMk1aTkFNSEljOStqdnJEemJBdzF5WjJacVM1eG1R?=
 =?utf-8?B?K2V6Y3NJL3hQZnFVL3B5TXdZd3BYQ1lmVzBCeE9FMFFBY1EzS3I0bnAxeVpI?=
 =?utf-8?B?V2Q1eUZRVC9URFRBYXpOeXlpMVpLUVFFZVR6NUgweGVuQlB4SXpaVkJkL0ln?=
 =?utf-8?B?WEZwMW54OVlyL2VvSDEvRitDc0Y3QTI1TVVWc3Q1RXlmY0poQVZFU2I3dlBx?=
 =?utf-8?B?WXJ4aWlJQTZQc0lUQnRHSUxmTVdOSEtLYi94WjIvaGltMzd2dGhqQ3BSdVpk?=
 =?utf-8?B?UWIreEg2S1g2L2RsVTE3RDhETSs2SFpqTUQ0SmRDQzZ6QVhBNUh4eFpzdW5F?=
 =?utf-8?B?M3E2OHZaTWduMldXWmhOeElvUEQ1MENhbmVFZ1owVlRLazJhdEtiMjlzSnp3?=
 =?utf-8?B?RXJmTFdQTlEzTkQyUkJpNVMxWFd6N25ObVlIc3NJb3Q3bEpvVTBtYktGNnU5?=
 =?utf-8?B?SlIvbE44SUhyVCtDTHVVdVZuV21xL2U1ZkJsWjB3aG5HajU2SVU1N3d0RWZn?=
 =?utf-8?B?N3haTGw4TCs0KzFtS2svVTNZeWQ0amZ4T0loS0xjN2ZBenNoL1MrV21ZRVY3?=
 =?utf-8?B?YTN4cklVOFI3V0s4S3B6dFEvb1hVTDdNTmZvOGt2bmNid25leDZxNXRxcW5l?=
 =?utf-8?B?YmNVS0hWZnRrd3ZVZHAzN05nWmIyeWlUTmJmSmFtY0ZQVzRjU3lhZ1BOdDFB?=
 =?utf-8?B?d1B2eW1LWFVYSWZKc3UzMGVsdGFrQmNVOXRzT3N5UTA3VFZ5QmFVZHQrdTYz?=
 =?utf-8?B?UFZndlplYnlxTzBtcnlURjZuOUltNm9tdXhyWlZxOW1VRE5lbDN0NGdYVFFm?=
 =?utf-8?B?VkpSYmd5UnZJcVRSbElDdUJtckVMYldxMWtnNXM0b1pwUUwyU3BHaXNRUVVO?=
 =?utf-8?B?ZkxWMDhVMUdrNGg3N2UyS0s5S3VsUEo5WUxQUXhibGwvbExRWDQ3MUhoMVdw?=
 =?utf-8?B?TGN0SHMyNS9zTUtWMUM1aTBseElMWUxtcDFQVjBQcVVPeUZ2Um1BVFNFOFdv?=
 =?utf-8?B?L0ZsbFNHZ3hUQnJ0dDhFblByK2RKbElUWFdva3BZcDE1UFFKRW9qOHFSdGZM?=
 =?utf-8?B?dGdneG5SRkpCNFl5Ujh4YVl0VXZ0VjUyT0EyY2Q3eDRHUzNSakNnSTZaTUZs?=
 =?utf-8?B?UEhUOVozc1FSOTk4WnVkRzBuQ0dhb1FxbVJKWERhY3Q5VDUwQk1KVmw3bVlK?=
 =?utf-8?B?dXNqRG52UnovamJEK0NMZFphODdURDJDQU9qYlcvVGZrOEx0WitWLy95Q2Vl?=
 =?utf-8?B?dXpmUFNQbmw0STcwSHN2SmNUVGF6QllJUlhoZkhHSUlLdktpeDlCTkY3SDVy?=
 =?utf-8?B?UTlLRXl1RzFjcTIwamxIYmh4Mk9xdmJkLzViMlREbTdXYnl3dTJXcjY3cFdl?=
 =?utf-8?B?QlNBVmdNUU43Y2FHdmdMQlI4Qmp4dU55ZlZqbHF1UVl6V1RCN0pQZDM4d1Jm?=
 =?utf-8?B?V1daVzN3dlRBam5zbVBSOElWNlo2VTRPTTMwUmFTYld3NU9iNHVCbTViZktG?=
 =?utf-8?B?WHZOR0xvVURXRGFyY1d3MXhUQm5RRitYZ1QrN1hReVhFcjBOZGdHZ2lhQ0N0?=
 =?utf-8?B?NWxDUVJCMnlJRXRobnloN3VuTEQ4ZW9lRVd3U1MrZnZJYU1VTzN4aC9yWlFm?=
 =?utf-8?B?UnVoeG0zREFhc1ZJQUVVV0hPZGN0U1BFSHhrTFliTXEvU0hManpZVHA1RkFM?=
 =?utf-8?B?QXpFWWpiNE9DYWtudTZmN3Y0WUpYcmFMdG9uRmN5WVpreDdGYkdDUHl5cjJX?=
 =?utf-8?B?UlhWNWwwL3JDMWp3cjgyU2thYWxqVUhVeG5tcVhrTWJZSUdta29ycm9xWHUy?=
 =?utf-8?B?V25tak5IM09Bekg5VExZbmdrYmMxci9SSE9FbmV0aGRRRUE1M1RDSkZIL0l5?=
 =?utf-8?B?bkk2Q2xMdWk3d3N3K09tY0c3VyswVWNEUU5FQ2VRK29VRy9HOTNaL1VBSHZq?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Oe9+MyiLOGdRBsktcFu5x+XPlXkRkpPisvMrLOr7Jp5GjYrKXSHCKWfbSDfBXLj4LA6RkhFlnERiC/4rqRGOZekg1UII192SnVaQn4eDFZHpvlQjdoC6h2WXlcVqyd8qzSgLkaNhOtKwOUtOJY+wyavRcE2kGy0As1woAgzcahSLBNCOVMkaJzDftGzYJhjk/vMrexuX4oVIlJqDzkgIBhQNMu84ihcYru0f6MNAd6e3rU23jPoYQ7qPV+rCHCQaOR6Ynwf3yEP9bfym6WHHsJYeREF1B7s3oZXDeOzcqUXP8FcZs6YDUzgBy223tIPaXvsoEro/AiqNACGIWxGGx7+n8LHjnSo9ZS32vxFCwvqPBC15rQuVspR7Z2XHvlq0yVa60GwXEveVfXL82mO4vTvztlL09dAb7DwfnGPvfxXfq7strSkpGmR+R6Schfri65TQhh41TwBzmpOP4a2XM4E3lm+oDWnxCvbx43NSiLXFxjly4hin+EIBNy946bp7coPJoqyljmnP1TLMP4dt6cL+lZkMWRjvtfEeqrB3RoeQY5zooxMfauhQ/emcuoz7kKb5Az5nInHfTBZGcAbgmTLFumrkzW6/oB/MZPbAqf0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be199346-0a56-455c-e0e2-08dd8e36acf2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:46:03.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgUZrVXiqJdizJlTbpbTzqVNrNdZm50uz1d3MiS6zq9FhugYWqFKthEi2zVIjkdx+xEUelfxhvrVHFatxGVN0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF743D15148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505080116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDExNiBTYWx0ZWRfXygaghvx+ooTW IjJ1rpVbU4k215glb6mCiWzFRx9eqUVeaMTqz+Ugcsv1xBdu+ZL5SWtwSv8pNdVbyE3S4pCHI8n 2eoprupBL0asuAl1roJuXWVLNN9KrQ9Zg6lcv1Lv4Z4DeL2hs65NpqVWZKMBW/z50SOM8K0FCA9
 u1ri5VA+PYwY75LwbeDxGjBm2sLRN2EwR1tJuOq+NybcgFTgTM6wf8fvvIeUWZ9Udezc+w6j80L rAfumY93N3b9iKTrMKgJGkVjjjf3uDDIOXLUzihkMj6Md2kU3+7xMAFxYcQrna/wQeqJUk8mrgA gibu+cHTOjlisPbTXhHVdoKldXaft6Nxyr1ihN5JidGnDYdT5bAXE4HryDgyC2IDDMD3z99N+fm
 /Vie8BaFia/bsdXPZJ+u4DxPI5nGg6NMBO5E1Ntou4EE09p3YPDW6XriyXqlPKr56xvzd9z7
X-Proofpoint-ORIG-GUID: Bam4-9gSbJUNm1X1eqV4PXnJIHdSWEuK
X-Authority-Analysis: v=2.4 cv=G/wcE8k5 c=1 sm=1 tr=0 ts=681cb5a0 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=uar72TSLDlmCAonfPAIA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-GUID: Bam4-9gSbJUNm1X1eqV4PXnJIHdSWEuK

On 08/05/2025 14:22, Alan Maguire wrote:
> In the kernel we occasionally find empty structs as parameters to
> functions, usually because some arch-specific field(s) are not present.
> Ensure that when such structs are used as parameters to functions we
> handle the fact that no registers are used in their representation.
> 
> Deliberately not using a Fixes: tag here because for this to be useful
> we need a more recent pahole with [1].
>

apologies, this isn't quite right; we had exceptions in pahole encoding
ensuring struct parameters didn't require strict parameter/register
matching, it's just that moving to a size-based determination in the v1
of Tony's patch left zero-sized structs out. So we should probably mention

Fixes: 34586d29f8df ("libbpf: Add new BPF_PROG2 macro")

> [1] https://lore.kernel.org/dwarves/20250502070318.1561924-1-tony.ambardar@gmail.com/
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index a8f6cd4841b0..7629650251dc 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -694,12 +694,13 @@ ____##name(unsigned long long *ctx, ##args)
>  #endif
>  
>  #define ___bpf_treg_cnt(t) \
> +	__builtin_choose_expr(sizeof(t) == 0, 0,	\
>  	__builtin_choose_expr(sizeof(t) == 1, 1,	\
>  	__builtin_choose_expr(sizeof(t) == 2, 1,	\
>  	__builtin_choose_expr(sizeof(t) == 4, 1,	\
>  	__builtin_choose_expr(sizeof(t) == 8, 1,	\
>  	__builtin_choose_expr(sizeof(t) == 16, 2,	\
> -			      (void)0)))))
> +			      (void)0))))))
>  
>  #define ___bpf_reg_cnt0()		(0)
>  #define ___bpf_reg_cnt1(t, x)		(___bpf_reg_cnt0() + ___bpf_treg_cnt(t))
> @@ -717,12 +718,13 @@ ____##name(unsigned long long *ctx, ##args)
>  #define ___bpf_reg_cnt(args...)	 ___bpf_apply(___bpf_reg_cnt, ___bpf_narg2(args))(args)
>  
>  #define ___bpf_union_arg(t, x, n) \
> +	__builtin_choose_expr(sizeof(t) == 0, ({ t ___t; ___t; }), \
>  	__builtin_choose_expr(sizeof(t) == 1, ({ union { __u8 z[1]; t x; } ___t = { .z = {ctx[n]}}; ___t.x; }), \
>  	__builtin_choose_expr(sizeof(t) == 2, ({ union { __u16 z[1]; t x; } ___t = { .z = {ctx[n]} }; ___t.x; }), \
>  	__builtin_choose_expr(sizeof(t) == 4, ({ union { __u32 z[1]; t x; } ___t = { .z = {ctx[n]} }; ___t.x; }), \
>  	__builtin_choose_expr(sizeof(t) == 8, ({ union { __u64 z[1]; t x; } ___t = {.z = {ctx[n]} }; ___t.x; }), \
>  	__builtin_choose_expr(sizeof(t) == 16, ({ union { __u64 z[2]; t x; } ___t = {.z = {ctx[n], ctx[n + 1]} }; ___t.x; }), \
> -			      (void)0)))))
> +			      (void)0))))))
>  
>  #define ___bpf_ctx_arg0(n, args...)
>  #define ___bpf_ctx_arg1(n, t, x)		, ___bpf_union_arg(t, x, n - ___bpf_reg_cnt1(t, x))


