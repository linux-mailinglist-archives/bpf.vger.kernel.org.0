Return-Path: <bpf+bounces-61182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F0AE1F2D
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 17:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF48E3B6766
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972332D323D;
	Fri, 20 Jun 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uug/MGBQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lXAzExUA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942012BD5BF
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434142; cv=fail; b=RolOLwg5pvOIc8YltMC77TW8Ng8e7EkRzYV/b6WYehigVOhCFzJv5EG+S04tV1VCaBWzGz2Hr3F3fFg2BiwKkcO3dlJWdmlPfmBVQiAufHcNM+YFciusUGgubLOVfsom8V9eUQDErCw6NHWHnq5z6CftB5MS4cXNOYUku5VHl54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434142; c=relaxed/simple;
	bh=Ulk3TnxaaWXd5b02cdJpxGwOf2ro3Umo9YZ+hry8pns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NsVHU5pG0NBkYXPbsbY2UgJdwI2fdqnW8jX5yMaxv6+dSKgKdkr5OYelUB2xl+hhAV6jxqk4snKZXuzm3U3xYLZ9rMfeRqWHBtIy36SFGErbSGzJYnp/qVQFS/h874319mDqesR34yJGfDlR2nl3DudoAzCH556gLoY83qznGZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uug/MGBQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lXAzExUA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KEBmxq023364;
	Fri, 20 Jun 2025 15:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sq2uj2r/8OJ+MxeDxNdnYdUWpWR68fqye/gpgXVbzGA=; b=
	Uug/MGBQwdgcIHW8nfzww4LY03GjaZXDpzu8LQAFlZqOzzO7tjjyZ3aze5M5DiLV
	t8cWcnt1/apVuXnlScTJKRfRD3sd+jFDOVr3qgPNuPmTjR2wrA4V29rcV9S6Mvdy
	/hXUIYtCmJwPh77oJ2HJAd/O+Pf7hVKBAD6i4F9MouwGEMD+n/JZj+dnw05zgHx6
	LDCJUUCfZs/YRkZLfmJ2/OIx83No91PEMSHPOvRU5uUonBa7EYx9we9r5GLWWJ1h
	uiKs1ZGs+78ZGzwxyqxQSxnb4fytrVcYiyk8nxjukJsk/k/BLMAsv0n83e/yQtG+
	fIRLRwYr4lFEhomz5Npc/Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900f3y7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 15:41:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55KEObBj021594;
	Fri, 20 Jun 2025 15:41:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhcts6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 15:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KM2aWFjg7+kxCv0rn6wC2bg2IzKzDdjjs9nk2+QAvhElIi+X7Z9e3HDsY1SIJcqZnZx4yZaDtjUqY0u/9VjJWIwzLgiEnqoza6ioXp+a1BoNIzhGJQ8662Hot50xQxAAA1naxhugue8maigmy+YB/LrxX9LwjKLS1OMuOMzYZxf9R2rfTlFXfKHFci8W5Y5R8VNIPQQmPGdzXqTQSVHpolEQWU+KATA1wb9DL3CboiZmIW6zcZsqbqVV3NcrUTZXwQfVEU5W0Dn845iq6dZBVKF2JCkB4zZTykTzQkNgwgERPZFQbIhdFoIwQCXYhnDUQOevaxrFzlPtJntGxGzEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sq2uj2r/8OJ+MxeDxNdnYdUWpWR68fqye/gpgXVbzGA=;
 b=IfVG9mH6cfo/a3SMb+g0rkiS5OUfMBkJg5IFIqByp6+Dwz8Jel4K3BI0GCibw+zSsluNhFXOl9wTJa4Me94VTlInBQekoUGkH7znoAP+9kyGxVobPDghisiejrFTtYtM4VON5r6Ng2jXJ+upnRq+qfG5UqjowqPX/jbw4XEU1RNmAnRQi2iVTIik1tXTfdhxNGlE+FW1BYprZHPSq1cHTKk19rbQhUeX3+fGHDwzuQMFQrul/HqBtQ2Z4+l2L9DjZ5YClwOBPttTzQjBcmVIcB6hEIOFbERZMjPHEys6pqWNaLd402clYYvRYWPh6TWCjrj8ZJalQRr7YbADrnmykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sq2uj2r/8OJ+MxeDxNdnYdUWpWR68fqye/gpgXVbzGA=;
 b=lXAzExUAe1VFV51cVPMZOkNyCUgCgc3y/hNB4VoEFa0+NrMd5tv6tNzOUz7IAMaLrpwmM0JSjJmq8koVxJd4mq/8OFa4fGabSENPdIxRO4/gufMgZJgSzLZXu6C3sRTbHR28zZo9RexFAYviwcQ+Fksr1yXx/xeCYB/DKVCOFug=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA1PR10MB7114.namprd10.prod.outlook.com (2603:10b6:208:3fd::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.23; Fri, 20 Jun 2025 15:41:55 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 15:41:55 +0000
Message-ID: <769e1fb7-d4b2-47cb-b71d-7db2168cb5aa@oracle.com>
Date: Fri, 20 Jun 2025 16:41:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: add btf dedup test covering
 module BTF dedup
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, mykolal@fb.com,
        bpf@vger.kernel.org
References: <20250430134249.2451066-1-alan.maguire@oracle.com>
 <aFVjVoafmmPeUqiz@krava> <aFVnWxNycW6ZtQAU@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aFVnWxNycW6ZtQAU@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0362.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::7) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA1PR10MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: f426948a-1260-4d44-a6c0-08ddb010fbc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHhXdlhXeTZYSys0NHJ4REloSVFRZFJUZC8rcklDR0MzaVlnbGdwbENwa1Nu?=
 =?utf-8?B?MFNnc2x1M0xaek9CUjRmTWdnNk9kSytRODJsaldQSU1kRkxQQVpNUmFNSTJ4?=
 =?utf-8?B?M0ZEKzl1N280U0tDakFqRkJrb3VONysyd1lhMlZKNHdIYlYwa0orb3lORmx2?=
 =?utf-8?B?cHYxVFhrcktoZDJ3Nys5ZFFRZ0NYVGQyRERWWThSQXFlTGpCZnA2RHdtQkI2?=
 =?utf-8?B?SnB3eGc2NklxR3lMcGdoU1NYbFVhN0hPZHozZHQzempidTNRa01TUll3QU5J?=
 =?utf-8?B?ck84V0pnZ08rdW1sZkI2dzU4c2xLMkgvSExJVHhGTkFrSlRLMXM0NVhMelF5?=
 =?utf-8?B?Tm91OVdBY3RYdlNzNHU2RFlqcVU5MXd5a2lPbkttUjUySmpyMkFpOHRKK3V0?=
 =?utf-8?B?aURMNkhDN2s5RUZoQkRsOHVZWlVTQldMQnVEUUhBZHBpeXdraW1PN3VSTUxB?=
 =?utf-8?B?N2RXd1JpMnRqV0czYXRiU3RpcU5hV3FiOVR5b0dJU01FcDRJcjhoWW5qWWhG?=
 =?utf-8?B?N0ZYQmNDZlIvcGloR1JyK2M5ZWxOeCtkRjh3NnZyeGM1aldmSEEydFhRRStT?=
 =?utf-8?B?dlRsaXB2dnluYlNiVWtGSEpkTndWVm5UaGJ1OTErRFZWZXNDYXJVWGxZbk1w?=
 =?utf-8?B?SXA3andlb2FNdFAvclJZUHBMRXpNQ0tBT2hXYWQxNVZ2U0c1Rkdscm1HMFRG?=
 =?utf-8?B?SWpJbkllV05SRTl0MWhDdklMTk5GRytKbG5rYTlyZEFFR20vb2NOZFNVQllB?=
 =?utf-8?B?dGRYNU14VDd3WlF0d01WYVF6aFF4S2NOK0dWM3I2eWFZb1dnaG5lNTVmbVFS?=
 =?utf-8?B?azBrUy9ZTmVJdHNrMWptS0lXbXhTd0lXcjRrWDhoU0drK1A0MG4xbzRkdVQz?=
 =?utf-8?B?RTVUV1VkSEhTOHhLQUQrUWUvQ1VDOUxLVXViYUZxUjBGelQvVGUvVmswQmNI?=
 =?utf-8?B?SFJQQjFpaUIybzllY1h3MjgyWmZteTlzS01qdHRWQTJzREpiS0pvNVdVRlU3?=
 =?utf-8?B?b3RGbitVTGJWMXBFeTBoNmRoSTZmQ0crVmtSUGx6YXU5aFVPTWc1RDR1czdB?=
 =?utf-8?B?ZmhiZTRTUS96QTRtdmsrNTlOQjJsdjZlalFMb2VVbVNKRmpIR1ZjQ0g2QWt4?=
 =?utf-8?B?OCswbUdMbk5uWUFSNkxteWROOE8zWk9yb2dqNjhpV0UxZ204L1VYWFBON1ZG?=
 =?utf-8?B?b3RxbCs3Q1VCeWM4RU14a0svV1NUYzZsekgrSkZmc1NRZHkrZ2RkVysrU0hB?=
 =?utf-8?B?dTduTHp1VHA0MGhBMTk3RWxaMWlja1VoRXY5MVFhdVB1QmdaLzlEd0MwYytx?=
 =?utf-8?B?S25BbU4xaHNVZVZrVkpORVErajF1NFhjcDl1UHdTWjdzMm9vZHdtbnRzR3B1?=
 =?utf-8?B?dlliS1AvblZSUTBacFBOaC82U1dBSE94VVFEbkZBWTczUVB5R0NIS0hOeVJK?=
 =?utf-8?B?ZDZkdTdrVUxDc2xVZjI5T3ViY3cxSms0Uy9ZeTdNVm55all2QnNXenJWOEtZ?=
 =?utf-8?B?VU5aN29XRTZ2MnVHZ2tHN3oyTUJ1NlBaZDRDcHpIWnU5TEFFc3o2TE04ZkFs?=
 =?utf-8?B?L2FMYyswTEtlV2tWcHhyZjdsOU1XOHZSMGczRWRldEJNaDIxODE2dlpvWXBT?=
 =?utf-8?B?SXpCN2VpQ000bmxBb0ZDdWxnUzNDRjFtaXMvUjIzSGNqeTdoa3lHU0xrM3l5?=
 =?utf-8?B?eXplYktBVlM0cTJQaTZDREZBOExVbDVRaEcwTUExMURPT2t3MmM0OFN6TjBq?=
 =?utf-8?B?Ty8rblpveC9CVGtyV1JnUXVFK3dRRS9OUzBYNU95WGh5K0gybk9sYzFaUytO?=
 =?utf-8?B?NFZpUEIremRCVjFWblRsMmhtRWVUUE9GdTNWaDJWK2VpSXNCQXAvQU5BTUxN?=
 =?utf-8?B?VGE0c3lyRXRWUUdpS2pUUVpXQmk5NW5seEkwS1FFL3BuSkJ2OWpXbWpvcUVU?=
 =?utf-8?Q?7rP+swRi/qM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDQ5ekRkSnd1djhSQUZReEFFUmR5TGJCZ3B1OWpqWncwclZ2UUs3RmZCdzdo?=
 =?utf-8?B?d09waEp1UjNnTllRVGtKcWx0eVkvZzUxcjFsMWkyZXhmZksvNDdiUE5SelZ1?=
 =?utf-8?B?MnVDMmhwTlplaXhZSm1NUHFsYUZqTkJNbDRHdVgrREtadU1McjE3cmt3aUhw?=
 =?utf-8?B?RUE2TmVGeVJkWk52MnpiSjlZTmd0bUhEOEtNeWR3RmNBdmQrUkRRQlBkZWF2?=
 =?utf-8?B?WjF6bnQzMmF4UlFBV1Rpa0RMcUgzK0EwZVVrcVhvZSs0OXlWa1N6MXk2eHBZ?=
 =?utf-8?B?VFQ5K295a1JGZVlNZjZGQ1BHRFlVeXQxNUxuZ1RYdm80UkYvUlh6Vmg1ajRq?=
 =?utf-8?B?dTdpc0JmNWgvKzZ1by9EWGJveHhLOVhJblFwL0U3MnhGY1UvTlY3V3BrSkdT?=
 =?utf-8?B?cE9NOXpCZGFwWXJsanZROXFkczRha01vSXBXVE9JQkZ3ZFprSlB3MFo5QzF2?=
 =?utf-8?B?Y2dxOEpFZVJWT1pZY3ZxWHJ5N0hFYks0RkFpNnBzcFEvNUIwblJmYjJkTDhB?=
 =?utf-8?B?RFpHQjlzQit4MWJ3QzQzZ1lSTXRNUGhtY045czFUWEFaTk91ZEhPRTZFVHU1?=
 =?utf-8?B?REV4OWZiNm9UZ2hZSGNmUlFSY25pVVlFRFpBOE9UREJSRzNGQitnQnE2eVRS?=
 =?utf-8?B?RHFFTDQrL09wdVBadk9SSjYxRGl4dlBBWmZvMXBZQ0tST08rc0lMQTlpbmpx?=
 =?utf-8?B?aEZMbXpNRkFGZ01qNEdKcVNhYmxHSFNvMi8rRHVIclZnbTlBRy9FSUdhendF?=
 =?utf-8?B?NGxuM1g0cEZJWll1SW9SMjVUVWw5TXVwMVp1aG9BWTQvdmJta1FuWk1JWWVZ?=
 =?utf-8?B?aG9RaEhQczFadzcrQ0ZsMTRWalhXYytpZkl4QUE0S1A2WStSTHNhSnplQmxr?=
 =?utf-8?B?VnRMREdHNzdKSFdLNkdtWkY3N2MwZWVsd3NUN3Z6SndwajBtNzJGNTlHcHlD?=
 =?utf-8?B?bU1LdkFSK0pwQ3lJNzdrSFQ0OVlsOGZYNkxmMnQ2VU0vQzJpbHBqZEovei9S?=
 =?utf-8?B?K3pVMUxkdGhDMm1mVU5SK3c2ZEdscXhTY01NaU1vYWVXZ3dqT0ZHUUQ4TEFV?=
 =?utf-8?B?SXd1NjZiNWFSWDV4WlZpS1hEZjlUV3lMYW5VemJ0azdpUXpsQ21CMzEwNWZ1?=
 =?utf-8?B?T2lyb2c4WHYrVlVkeGVrVjMyVkRXV3NwWmJDSUhhSHJEUm9MQTU2MGJpWXAv?=
 =?utf-8?B?bkp6cTZKOWRyNHdMNkFLdjM1eTRuZnVYd1haeFhDSlNNODN1SEt4UGN3bFdM?=
 =?utf-8?B?V1BrU2l1ZFRLamR4SUlVVnorY2ZuSVVNQXVRV2Y1VVhwNmxuU0ljdlEvMXA3?=
 =?utf-8?B?NTh1MkFOV0U5M0lkVlRTRnBWejdCUmhOZWZ4cmhGbEs0cXkzZ3NwYlpKWmVG?=
 =?utf-8?B?RkVFVFNMejIvWFlqK21WeFVEQS8vRnFxVXpvUHhTcHR0NnJXZDRKWnk3eTRh?=
 =?utf-8?B?eDY4MmNqWW80VTJ6S1c2RFVEKzdmcm1kSGFzeCs0c29tN3oyTVZhNHdvN0ZF?=
 =?utf-8?B?Wk9VUW9yQnJ0aW50bFcxeU1YMGVCSC9ROFZ4Ky9QcGxMSmI4Qkc0dWpNaHN3?=
 =?utf-8?B?eG1MZVNMSHZYK0pseWhNVXU0VjFxR3NhWlo2UGQySXUvZEdoSzZUZTFsU0N4?=
 =?utf-8?B?dXp1cFhINWRDSGxvb0xTL2xIbzRPMFc4VHJsZVV2UGo4MjAxVkZYRGxQRTFr?=
 =?utf-8?B?cDVQRnF3UXVRcEd6a05hS0NIWTNCZXNuV0FPQ2kydWM3UUpMRmJqRjRXVEJa?=
 =?utf-8?B?ekdaT2M0dkFMRlp1cTVlVTdvdHJma3UxTWZyRGpxL0tha2xOOFhjc2xmYU15?=
 =?utf-8?B?SnY2c2kwOHBSSGZicjJwWngzRWRlQ0o4NVFPZmtjVzhVU1o5Y255VWpWSHZw?=
 =?utf-8?B?UnZoYU9WOXdMNURYWlBQY3A2NVltaDh5b2t4cVl1cGtPK2V2c3BqRWpHVHpY?=
 =?utf-8?B?RUFwbFl0dkdzdVA5SHREcDJIUGxLZk5QSFlBSkRWSlRlM1lRdUNuUUxpSlE1?=
 =?utf-8?B?YmxLaU80Q1dSSllUT1NhVWRmVUczaEFzVVRoSmxKNDRJRlMyeDlET1IveEQr?=
 =?utf-8?B?cllBNE1IMWswS2tLQ0FwTmkyTVdzM1FVbDdiaFVUbDBoZjB1OC9mWDhqQ0x6?=
 =?utf-8?Q?bUETDc7pJ/IeAndPzDd1ibnPS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jpj37CyezDqO6PcpGsxkuMuDiUMQ8+NKf8xcSG32k17+/pU4fjkILkksiCBrwlaf+L3JVba6ATGACagt4XGHA0rRQB/SdWk1dHzIOYvZNaaw7HyLkY77AQppBPha7D8E8oY2OmR1anZT7hVZl0MWLyY767jQoqdnDMWFjxT6VoGlRLuYxHngVAmkxHNePa1+jQe0DJ/lR6qEaOOK49mEFExAaOncwJInvNrczWSwxPZUh7ID4O7svLhj18wu4dczQksYXqjGeLUI/FJG9g3rHJXsoErfsWH0dYSjG9r4MjMxT9cwzIbesmbC/XO4mQDIjNq8dgjFgXz723UlODKiOn0QdZj+S0n2alyoafk9GoT1rqPAZdbgm8wSQ+auMGGHQgHMmSTAZjY/e17kFdNceCqJuLRLTATOszgmdnixDz9idh01uTwK9QlTFDQDR4oIywJqpigo4X1J2BDJn1Xnb6Ypiig9KDQAaVTqrodsDF1usTTll7WHjCfGtsIY5LMPdvg3xDaN4widZi7eqloKYqV8itZdaGS6QUq5/HKV9IIc8k7Z0AN4SLLqSPY3z6AcxV8FeKQGwnYJ4KahooFk3mlZN8KHVUQ9m6OWIgjrOw0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f426948a-1260-4d44-a6c0-08ddb010fbc4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 15:41:55.0442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRfZfo9exv5Js/FOzucT3HhTXSkUJrADUqMnltmJcfw81yCMmXNraic3Ye14uqOWJAuswOGLDAnmpfaqMCcUnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506200111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDExMSBTYWx0ZWRfX5DjeWQEB1DnR WDi7G0Gxz2+plyE6C4fbGSD0a6UhERF9gVMWimRjsBLI2/u2W+DmnzJnv9zD1GnviJG55YxkCgS s0Xq/hBpso70+jiBlpVvirlM82VBsCIrT9wxD4vylEdMxzaQ9oE2BiyLHDxNUdvGwx5JFoyh6jF
 yDWLVxj+1rTax1jhJPBHoBdfyR0452cpKrrHtg+epLMK/IdOoupr+Vq+H8ZAQ10NaTtRzwUjlf9 HWmn/yYf+XKNydoLmayXXl80j3FwdPDQhfc2Skgze4y3pDyclujawMz+UwIfrXrB/LcD9xSKKEL QMw8crqyFJkV9YXs5yYt8DpeuvEkfJ7+htrcFeI61kwiKmkYRdR/fryP1Kkz4CK9q25ecATTK6E
 E+S5lki1APjquSnywkaJO+h+hhI+XPkkmtU57VqmH/o0uaPtD3wrwaUnVqiLQsv8Js687tQR
X-Proofpoint-ORIG-GUID: vsHitmehQWcV3KxmEYNsELblC6miEqH6
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=68558147 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=Wl1av3PICH1qI0TRMwoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vsHitmehQWcV3KxmEYNsELblC6miEqH6

On 20/06/2025 14:51, Jiri Olsa wrote:
> On Fri, Jun 20, 2025 at 03:34:14PM +0200, Jiri Olsa wrote:
>> On Wed, Apr 30, 2025 at 02:42:49PM +0100, Alan Maguire wrote:
>>> Recently issues were observed with module BTF deduplication failures
>>> [1].  Add a dedup selftest that ensures that core kernel types are
>>> referenced from split BTF as base BTF types.  To do this use bpf_testmod
>>> functions which utilize core kernel types, specifically
>>>
>>> ssize_t
>>> bpf_testmod_test_write(struct file *file, struct kobject *kobj,
>>>                        struct bin_attribute *bin_attr,
>>>                        char *buf, loff_t off, size_t len);
>>>
>>> __bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk);
>>>
>>> __bpf_kfunc void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb);
>>>
>>> For each of these ensure that the types they reference -
>>> struct file, struct kobject, struct bin_attr etc - are in base BTF.
>>> Note that because bpf_testmod.ko is built with distilled base BTF
>>> the associated reference types - i.e. the PTR that points at a
>>> "struct file" - will be in split BTF.  As a result the test resolves
>>> typedef and pointer references and verifies the pointed-at or
>>> typedef'ed type is in base BTF.  Because we use BTF from
>>> /sys/kernel/btf/bpf_testmod relocation has occurred for the
>>> referenced types and they will be base - not distilled base - types.
>>>
>>> For large-scale dedup issues, we see such types appear in split BTF and
>>> as a result this test fails.  Hence it is proposed as a test which will
>>> fail when large-scale dedup issues have occurred.
>>>
>>> [1] https://lore.kernel.org/dwarves/CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com/
>>>
>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>
>> hi Alan,
>> this one started to fail in my tests.. it's likely some screw up in
>> my environment, but I haven't found the cause yet, I'm using the
>> pahole 1.30 .. just cheking if it's known issue already ;-)
> 
> hum, it might be my gcc-14 .. will upgrade
>

hi Jiri, is it possible you were using the pre-dedup-fix pahole, i.e.
the official 1.30, or a version without

commit 6362d1f1657e3381e3e622d70364145f72804504
Author: Alan Maguire <alan.maguire@oracle.com>
Date:   Tue Apr 29 20:49:05 2025 +0100

    pahole: Sync with libbpf mainline

    To pull in dedup fix in

    commit 8e64c387c942 ("libbpf: Add identical pointer detection to
btf_dedup_is_equiv()")

    sync with latest libbpf.

? That would mean you would hit the module dedup failure and the test
would fail as a result. If that's the case, if you could try syncing to
the "next" branch of pahole and see if it recurs, that would be great!
Thanks!

Alan

> jirka


