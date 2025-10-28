Return-Path: <bpf+bounces-72514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C0FC14189
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 11:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA9F407BF1
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 10:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E1930147E;
	Tue, 28 Oct 2025 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IJNf/5UY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wjqknGLA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E22620DE
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647112; cv=fail; b=H5LRm1o394hhKCxjOpZmvCn0fJu+VYlYiUo8UFQpdEcMD7iNAq3eYADkN7PAzDkonsNpOj58UiXmNMWwXEU0HkdSkJvc5uKVaRMp5NO4js8Ss0neYRwz34zV+m/fQkQ8X7Jzi0wWRBmaMQroTv3eZGGosKkynPMsa9kl91ialNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647112; c=relaxed/simple;
	bh=pQonB/uhqQ01mBFr14igN4MK8i9Yb02Q5Q1SPG6m4Ew=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MmvllzmkxTA/oAExvcSALWIRpIy1rWtdMe+56Jb1jEOy/zS3O5J5wgeR/kf8pNLi4px1Q6sc/Q2x7kRy+VIUX4LOwCZUmzoCaFJHWeiBv+P8irUOHTmrujQAE84l+Onkw+xdtsVmtfEETwFdlOuW7Qyb06XvvSQBI+1+1/VPysQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IJNf/5UY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wjqknGLA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NHe7016923;
	Tue, 28 Oct 2025 10:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KpLMeahK1DAJqxSI/8JpYKA2yF7RuW9yFoNjv08Vzn4=; b=
	IJNf/5UYs+oEECkrVjVRY5H+YFrw8umJO3y7WK6DS62Yta6IW5V3fvKF/Vt6py/C
	Ui9Ord8U5JVAvvr54P6WCQeAwM9uXuQPITOaskdNxb3pIhQ7xu49skNZJKkaL3Jy
	fieNv9DYnMpxyY5b8nmrg9R0Fx2HW1jY0Be0j2JTbdqcKnYA5kySMGd/r386OadK
	OwJ3tIpnIoy0eChAHEXByLWm6uzfYCeDjfdi1A9/onV9wc9HiAUmPTW2eoWCnKVi
	JFPsvXa9c3lVD6yMSk1m4ayb/0yMPONYf1xk5kxKluge+7dEX7XyshurlM2DmVpT
	Out0zJz47KXKHIBAHB/eBw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0q3s5qt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 10:25:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SAFLkX009116;
	Tue, 28 Oct 2025 10:25:07 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n0f8cf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 10:25:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfoIZvoru9w1XsaP7odnj/WMFy2WEd90GOP80sJlK6Iyk7v70hcGxAY4E7uxNn/aBRIeqPdZ7b/4bLDSaHyQw1Rh9OfYDWc0Jw/4cBg4kfRswwin/su4gIbWTGjGODeafMXHDNC+FYYfy2ISQmhWuqSkJcwDeqvFH7IhQqZJGhkHEdKxsZOICAMpFqn6fx8QCsMZk4gIJAEMfTCNRpGyUcHVMO5SkiRxOul2/9wI15MeRI/ZSpYRSTXcZHNAylI+zxfS6T0A4aW6yR3fLrV0gUjjDGFKwL1uSfOjDzfFPplzl4RV58JR52TCIsQ4lKml7MgEB6Ia6ibUp0KIUgyobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpLMeahK1DAJqxSI/8JpYKA2yF7RuW9yFoNjv08Vzn4=;
 b=qdwdLVaOALDaShJ198LnrZ7DO7K9aBqLNQYSvd2kzsO99Dxwa1Al7GuFIlWi+LA//OD9uFZ1gV27fi4iT8K3AipiC7VEmTC7YncFm4+NYGcgd3wtxzzwqSvC+9SuI9Acp/ahk3TfZLEzBZgGi/0FHlFggSxud/jHgurW2l0z7qnhmWWUNrIVunBLV9EDvUMCbmEFfb8nm9H7dTKjwXO3yQxD08qnZhQI4Ecemkr1Y3ik0FwWsXUkGnTey4HyvY+jirs9bc8QGHGzlO3QrHXRDhmJzFus+lJUVL3r2MGkKR9LAlXNtEK3oYweHO1nUVQckMAw3dOml6WxBWH4hiuLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpLMeahK1DAJqxSI/8JpYKA2yF7RuW9yFoNjv08Vzn4=;
 b=wjqknGLAm1EWqMKeZjwP2KlQkDUchYPrDy3WTmod9Ct+EHu48H59tq4YrVRC2hs2+UmniPk8N+HOCEc27qRKImBPgIwBRPtKzkt67gdhOqj/0FXVsQ1KXYhTE6ZMMVyHdCgeVsNCvNZPZxgBIS0k8PbwzrFs5a6QUVHAKyST5k0=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by BY5PR10MB4353.namprd10.prod.outlook.com (2603:10b6:a03:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 10:24:59 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 10:24:59 +0000
Message-ID: <a25db80c-864f-4d29-9c46-d9d226dffc12@oracle.com>
Date: Tue, 28 Oct 2025 15:54:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [bug-report] Build error in tools/testing/selftests/bpf/
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
        kpsingh@kernel.org
References: <e9a3bfc2-2e9b-4ace-8443-52a951a4707b@oracle.com>
 <708fcb30-42bf-4525-aefe-cf9791bf70e0@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <708fcb30-42bf-4525-aefe-cf9791bf70e0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|BY5PR10MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e23d2c-3719-4c33-5292-08de160c3f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGhuWno2RHlUNFNsWURHbmdxTnQ0eUVELzZUenBQeTA5VC9NM1p4SGNObDdY?=
 =?utf-8?B?c3UrVFludC9kQmdzMzBDcHRQWEtvbDg1UnBFdFBjNFV6RkdCMHZQSExsNDIr?=
 =?utf-8?B?YlVSeVlWSEN0czNtUmpGUERteWVlbFg0a3BYeE9zMWU4cE53N3hZYk4yd2xF?=
 =?utf-8?B?Q0hTckRuRWsvWHpTd29mWElzdWpNNittWUpGcWFaSWFVK2o5cHdTYTNabldz?=
 =?utf-8?B?ZmNIcGp5Vk9hQjJQV0UrS2NoYkF2cFVhUnBqUlR6akhHdVhYemRRcGhuMEdP?=
 =?utf-8?B?ZDRkM2R5ZThpd2cyWjFaeDNpaHBlSTJxWE4yMzJvY0ZCTHE2SjB5aEprbDh1?=
 =?utf-8?B?YVhFUW1TTUd2TXNKeHdkOXhrdkxWQ1FKRmRZZWZzdEZOWWtzSGRpOEV4TTZE?=
 =?utf-8?B?WnFTSjUwZkNmZDdXT1R2QUVaZC90SVRFeHRQazl3V1VNajA5U1lQVFEyZEZ6?=
 =?utf-8?B?VnNCWVpnTlJXcFdZK25CbUlLeFQrbCtEQmhucVdOeGxJQWJoTDVFdWRPeE9p?=
 =?utf-8?B?NlBkU2RocTc5ZnNmdFM5aDdpVnRDNDFBaDMxN3FHR0c5UVdvMmF1N0lPdWRp?=
 =?utf-8?B?UHZjdG5WRlZYa0h2SFNiWmRJb2xIQzYrOEhtY210QTJzdk1ET2JaWXpSUFl3?=
 =?utf-8?B?QUlBTUQrN0QwMFdtTDdqK2RKVWdaTzc1MkNjdU0rbmhhNHc0M3NtZzloV3J2?=
 =?utf-8?B?MnBUd3VXaDJuYzlUbXZJLy9oQzk3TUZhVTRIVFh1UDNyN3FOaysvUUwwS1hN?=
 =?utf-8?B?QWtDMTFCODJPRHNCTHMzY2ZXK2hQUk9DUHlOd2VJUHh0TXlXY3k2MUYwR0lG?=
 =?utf-8?B?cnA4eHdjSmJwVms2UkUxTVByUmpWY2haOG5HRUtjUFYra1N2bWU2N00wM1li?=
 =?utf-8?B?UERtMWxzZjBpRXJoSDFDcm5sODY5T0N6T2h5djVBZmxtUm5JQTh1WGFtdm94?=
 =?utf-8?B?eUpOY0xMVzF3RTJKRTRzeVZacWlBREdQMWJWQkRqVEMwTXBxaEI4Q3hXVTlD?=
 =?utf-8?B?Y05iM1dUSG5rZEFjbnZ1MENPMWcvZ3JkT3RWOGVYRmZoUUx3dXZCZFlOanRK?=
 =?utf-8?B?cFNmbGR5NXhNQThVL2oyYmVKN1pKMGlubzd3emF0WkoxRW1lRnkzb3JlaWJs?=
 =?utf-8?B?K0ZESldUam5DRFE0elRFc3BRQzBMcVRLMHR6WWhUYUlTN05xWTJJanBqaE4r?=
 =?utf-8?B?NE1IVWhrdGI1U2hFa0hqVW8yM3Z3TXdMQzBMbkZIOXd0ckptZWVqQ0hxYU9N?=
 =?utf-8?B?ZVltL1ROMzg2RkhZUmlRbEZUTU1mbFdxWXpiUllleFQzc2JRSlRMd3RmbnY4?=
 =?utf-8?B?aFRtdm9YUDZkSlRMOElXN21Yc2FVNnZLaHVkQVBsR1ZxQjNndjdnOHkyVnYz?=
 =?utf-8?B?a3gvSW5zK3VidW5oTWtZdm5BUXZ6czAyNnNpZVdEbzBkQmtId29ud1JGWWF3?=
 =?utf-8?B?aTlmUlYwZEFmTHNFbWt3Y1pBcUFadVkvQjcrZk1hdTJ4SE9LYlZPT0MyOFdP?=
 =?utf-8?B?Sy9ZcnQ1WmxsOTJqSnpKZERoQlIxTmYyS080MFE3ODZtOENQdlpQdWdYNEUw?=
 =?utf-8?B?NURUT1hrTXdVZ3B5WHJQT0VtSzVNVGtuK04zZyt1b1VXSTRsL200TUhCWnp2?=
 =?utf-8?B?RWdEczB2aXRRR3N0Q2NCbTZ6b1R3WkJBdzZjUHNwODhjMGdRNXkwdFdidDFB?=
 =?utf-8?B?NHJnMkFMamRmSHFyOWRCeVFKaU93MWFRRFNnVk5NaU9mYmU1SVFzMTRtdTRi?=
 =?utf-8?B?bDBuMmJ4Vyt3WjR6VjdaeTFtUWw3VEdRSmJkTkZNTGFvUFpvNHdqSEk3c2w3?=
 =?utf-8?B?Q2I0Vk1jTTh4Qmc2emVVdzEvMzRoSEh1M0lvM29qMHpzKy9zSFlBUytlVXlu?=
 =?utf-8?B?cVljcGRqK0ZqVk82eEUydGVodkttZ2txendPWlNVa0owaysyUS9jdk5PR1cr?=
 =?utf-8?Q?V2y9tCrWPzCIGlgNswSENxvHe60EUDf8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0RLcDYzaXNjbnU5bFhURmhGY3Y4TnMvNlVUOEgyY2p5UnNqV1F5WnFyU1cr?=
 =?utf-8?B?UzBmUWNUNnI5MmtnZGlMUkJxSDZLcG10MjBGbXNaRGl0d05UWFBscW4yZFdL?=
 =?utf-8?B?VlViZXBQVEVoZ0w0bkRZb2JPNmZ4eDh1SFdOQmQzK2FmNUE3c3Y2N1IwY1Er?=
 =?utf-8?B?MzNRYkxyYWRFMVFWdWhGeWlER0lna3dPNnNwaE1kVE54M3crTmJHUmRZMFlw?=
 =?utf-8?B?TVdzdGhBWXd6cmFRcUxpU0FUUEY1QVVsR2Q0dzlIMmJwY2RSb0wrSkF1WmIw?=
 =?utf-8?B?VWpDUlkzdytjVUN2c2Y1RmlOZmNRUEJBVjcwQXl3SjBId3pzK3lJZkhZWmtn?=
 =?utf-8?B?T3NPcXVuMlU1SlhxVE81KzduWFdMWGVkVlVvVWQ3by9uWk1sdVFiWTlDc3Fh?=
 =?utf-8?B?ZTBDUGI3L0xtaUNKU001ZkxMRTVTZExLNjFabXBtVEhXUyt4UnNVZnlidnE1?=
 =?utf-8?B?R2JEWmlBS3N6cytOdS9BUEJyS1lOQ1hpdWIzK0xCTWtxSVJzK3lCV1c5cUlm?=
 =?utf-8?B?OGp3TWptOU4wREI5Nk04alVsMGtiNGpYZ2lTejg0M2ZPMjF1bXJYb1pSWW54?=
 =?utf-8?B?Ym5nNG1iK2IrTHlMKzlQOVRsdncrY1kxdzNoSkNuN3RMdWRyMzJ5Z3d5ODll?=
 =?utf-8?B?bjZOUjdsQ0p3S2MvUkFienc1N1NPMTcwSk91WUJBZlU3UUltOUxEYlJoRFZT?=
 =?utf-8?B?cDhJUGVQTXpWMHRVRlpzc2tNdWNvSlhMNi9IME5ZdzdRbnNpZEcxSHRJVjB4?=
 =?utf-8?B?ZklEOXE0UVRaRHRrZlFWeGRNdTRiR29yeFdPRk56VXRJZVkweEN5Uk1TdVND?=
 =?utf-8?B?Q1I0RGpJMTh6bldxVGcySERrUzI3d09JN3BNellvRzlJTExUeEpQdGs3a1Vl?=
 =?utf-8?B?cGQzRStaWHpxTWhScHpLK3dYTlgwTFkyd3F3aVNxVzFON25kS1FiL2tTelNR?=
 =?utf-8?B?YWZLeTIzcFJCNlhRZGhRSzhONS80LzdBVkF2aXpkTThnemFaRk1WZG1VY0l2?=
 =?utf-8?B?YVQ4WUhYRURRTldzU0p1cEd6WjcvUTl3QmY0eEswME9jMVZ4RW9WR3lUeisz?=
 =?utf-8?B?cWRUK1ZMcWMzOFNvY0ZRWHZ3MHdRTkFmMk5vd2t2N0Fod2xjQkNsb01BZUx3?=
 =?utf-8?B?dlZDaUVpRFVsek5iVE10Y04xTHduc0gwdXpoUmU0NEY5YW8vZXpDWmc5c24z?=
 =?utf-8?B?dXBYZzBiZTFJNW5rMGFDOW5XWHF1YXhGWFRPRW1Zc3ZRd1dYM21yU0FhVWlT?=
 =?utf-8?B?T2VNUU5kWUhtUytaZ2l6a0NZaFRINWZUbjBjK0pGSlVLV09QU3M3UndEQmps?=
 =?utf-8?B?WmR1TVQwaWFveklzZU1ncW4yWFphTGtZWlJIZmxkSXZwZ3B4cjlXOVU0Sjh4?=
 =?utf-8?B?ZkVvQzdheDh5cUpmUHFLaUIwbFk5UkRMdXkrc21aMy9nWW95dDVFUHZUUHFU?=
 =?utf-8?B?WkljMFR6U1l3WGQ4eXBmbzVHTmgyN0JRZDBiaUFXd2YvRWRvQkJqSXEyTjFB?=
 =?utf-8?B?cis4QjMwUU5WbkV3N3o1eVZNcENDNUJ0aUlhRTNnOVM4QUJsUGhVbHNxNEJQ?=
 =?utf-8?B?djQ4NUMzM3NKeFJ6RUZ0dERoMmN0VTQ5bHJXYnhndnFKOE5qR21WSWN5SlBw?=
 =?utf-8?B?Z2JaZXJjSjNsN2JKZ3RrWlV3am4vclZlSUtPc01nVFNPUS9XREwrdVZLWmsv?=
 =?utf-8?B?eFU1MHd0dnBDeHNpbWNvOE51MHBGN1YrT2tuY2d0ZmVFZU1Nb2h6NnIxNWgx?=
 =?utf-8?B?LzBKZThybW93bHM0Q3pMU0Zud1JVaC9iS0w0TWorRGlPRFROS1V2VnBCTGRk?=
 =?utf-8?B?bFdPaGVLN0hsQVZnamsyb2xkc0FHdnBwMytmbmFqbnRsbFNhYloxYUFFMGpK?=
 =?utf-8?B?TjZzaGNLM0ZEOElwQ0dWU2c1Z0F3M0hpN3JnajRhbU9Xa3JUVWoxY1BsS3U0?=
 =?utf-8?B?Z2pYNmIrVGJvZW9hZzdXcHNOd0VCeVJHSXZwN1NFTEljMU10d1F0UDMwbk1x?=
 =?utf-8?B?NlpxelZIcnUycEJYZFBUWUhMVm9EZ3hxYUl5dHQ0Z1Z3Rmgva3lZYXkvalM4?=
 =?utf-8?B?ZnV5ZUdxdVhnN3lXZHNWRW1KR1QxTUVDOTBnSUJRYWZmK2FORiszR3A2eTN2?=
 =?utf-8?B?cnJKYmhjK09CeXV6VTF5dzZSM3lzVFZwZkh4dlF2UnQ2cmxpS1lWOVdvNkdK?=
 =?utf-8?Q?TQOZQRnyVruWQeYTMF1qWPI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/kyoG6pmsK+qp7OzOQec7JL+W1o8nXfF8h6ZWDLh1goBj7NoXujzc7PqZqOn/EpNZ0RaIKY6PJsQI+btj0L6CUDFstous9DxEiwjWIHTq7K6I3Y1INw/KLre+z3sGUgSIqtau36DVjsHOVBslgVsZuXXpQtgAVX6dRWsOczeD8MH/a7e11QsQKn+e55bbnRxi8jrUiStfN/pOrqSBcJ3JobULak6C4uLRBPdiUgFoF/RR/JtBAPnM/5y7bGJz0V6mZQjohMxHKoPMlinTVYRBSJ8avY/CPPJAGdsXcYl59vonkML0iFPHd7Owp2isW1GnIjG8HpF9RvXC8fvV2DbPToWd0h6391QMKJ5R4t2/u+IW86FgBxxaiiwdr+pjy9KS2RF6oK/cwG9zo8HlCcirVKszPfOuehJH4xJAxYcVeC6g85f7y3QcszRBbPlfAUS9P0XcCeObRuCauzuVb0hc5K7O+B+Rq+RGECPF1EI5biYV+bL6uywfd25wm+pc6ygiU9rZIMlcPuGIRT6fJNk3xLY3xbR2qW+C+1XtrGPJMFlLgR3i6pezmVW8Qxipe0hlcfZTTWHDp+VOvldmGsaGIOPgIyK3+rZDPkjt5BBqVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e23d2c-3719-4c33-5292-08de160c3f24
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:24:59.0742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckR2cbHd3ixTnLb1visWNICRIo6DtXSc9QC/dd581IeF4FPm4rAnQ/X7iuESJywOdbfPq6rhwpI3avYk2UHuYspx6CFa89TaIIClONAHIaEDu1VkhP7MvZ7LKqOn8wTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4353
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510280088
X-Proofpoint-ORIG-GUID: -7IkGWEYJaSnx7qAQRY6ILcC7UoHtdYm
X-Proofpoint-GUID: -7IkGWEYJaSnx7qAQRY6ILcC7UoHtdYm
X-Authority-Analysis: v=2.4 cv=Q57fIo2a c=1 sm=1 tr=0 ts=69009a04 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-YRFKC3K5HISpUTu2ZYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAzMSBTYWx0ZWRfX/cZs/zFSHwps
 gtmfClWUsArl/x3KJ0M5IpeqgU7vwy1YXm0KDGut1TekquXMWWHiHx9J3o4zYH1d/6QUYvzlKXu
 k2Rv2eBsMcKjk3FeHo5zzrBHI9raeVZhVBPy5mkh0ejhTHZh7kYIaI5UsQFaTOhKwPW7u3H1Uao
 oByVK5p87ibSR+j8lhQsUNUTYYrqwocRACOiOQALxuZk562l/F05NIM71ubv8ciGjlH56oblrLz
 lFsIDxMYk09CYxjQHdPULI3M24FCULcErOUrrmWluTjguyHeVyKuIB8juxx0nSBq2K2PozVKbVq
 iWS6+3Wysx+YYytfA6N5nv2GsfCfvQ+lSBJ64R/LqUectthU4x35GkGx7JMhT3Z0+PALrBdQWk8
 ryFfxOr1UB0RC+hnLIuKRxEyTtjI/yT39tSH/C/m+cs14pc+7XQ=

Hi Alan,

On 28/10/25 15:45, Alan Maguire wrote:
> On 28/10/2025 09:31, Harshit Mogalapalli wrote:
>> Hi all,
>>
>> I am seeing a build failure with latest bpf-next:
>>
>>
>> [root@hamogala-Kbuild bpf-next]# git describe
>> bpf-next-6.16-44604-gf9db3a38224e
>> [root@hamogala-Kbuild bpf-next]# make -j$(nproc) -C tools/testing/
>> selftests/bpf/
>> make: Entering directory '/home/opc/bpf-next/tools/testing/selftests/bpf'
>>
>> Usage:
>>         xxd [options] [infile [outfile]]
>>      or
>>         xxd -r [-s [-]offset] [-c cols] [-ps] [infile [outfile]]
>> Options:
>>      -a          toggle autoskip: A single '*' replaces nul-lines.
>> Default off.
>>      -b          binary digit dump (incompatible with -ps,-i,-r). Default
>> hex.
>>      -C          capitalize variable names in C include file style (-i).
>>      -c cols     format <cols> octets per line. Default 16 (-i: 12, -ps:
>> 30).
>>      -E          show characters in EBCDIC. Default ASCII.
>>      -e          little-endian dump (incompatible with -ps,-i,-r).
>>      -g          number of octets per group in normal output. Default 2
>> (-e: 4).
>>      -h          print this summary.
>>      -i          output in C include file style.
>>      -l len      stop after <len> octets.
>>      -o off      add <off> to the displayed file position.
>>      -ps         output in postscript plain hexdump style.
>>      -r          reverse operation: convert (or patch) hexdump into binary.
>>      -r -s off   revert with <off> added to file positions found in hexdump.
>>      -d          show offset in decimal instead of hex.
>>      -s [+][-]seek  start at <seek> bytes abs. (or +: rel.) infile offset.
>>      -u          use upper case hex letters.
>>      -v          show version: "xxd V1.10 27oct98 by Juergen Weigert".
>> make: *** [Makefile:726: verification_cert.h] Error 1
>> make: *** Deleting file 'verification_cert.h'
>> make: Leaving directory '/home/opc/bpf-next/tools/testing/selftests/bpf'
>>
>> This looks related to: commit: b720903e2b14 ("selftests/bpf: Enable
>> signature verification for some lskel tests")
>>
>>
> 
> hi Harshit, I ran into this too; it turns out the version of
> /usr/bin/xxd needs to support the -n (name) option and only the
> vim-common v9 or later version supports that. The name option allows the
> user to provide a name not derived implicitly from the file path
> apparently. It _might_ make sense to do something like the below since
> it would loosen the requirement for a very new vim-common package to be
> installed. Many distros may not have a new enough xxd packaged, and as a
> result run into this issue.
> 

Ah, thanks for explaining.

> The patch simply creates a symlink to the cert with the right name,
> allowing xxd to generate the header without the -n option.
> 
> diff --git a/tools/testing/selftests/bpf/Makefile
> b/tools/testing/selftests/bpf/Makefile
> index 7437c325179e..a276f83d7c52 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -722,7 +722,8 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
>          $(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
> 
>   $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
> -       $(Q)xxd -i -n test_progs_verification_cert $< > $@
> +       $(Q)ln -fs $< test_progs_verification_cert && \
> +       xxd -i test_progs_verification_cert > $@
> 
>   # Define test_progs test runner.
>   TRUNNER_TESTS_DIR := prog_tests
> 
Agree, this works for me.
Thanks for providing a fix.

Regards,
Harshit

