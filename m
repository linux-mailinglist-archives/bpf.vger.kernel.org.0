Return-Path: <bpf+bounces-29488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601A98C2930
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD741F23AED
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FC117C98;
	Fri, 10 May 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DZiivurh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EPQqGJte"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F417580
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715361915; cv=fail; b=LW3mwDF9vRbXVNz9qEeBRHSK1s9HGaps/GlaMIbcUbZFF5zoPvPgWOb89U/TSkzVen7BV/NncZXYUWIOkPrX5uAtkq033BkH8XugnGD1UqWQ78y8i/3asEcoZ6Y5pzPBxy1OtMKefAXZiqoppwDdI9nSKbF5l1givET8gXTpEVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715361915; c=relaxed/simple;
	bh=b+3Q7rQaHCa+CMFfcizFKDUVNfcjMpAw90Z9C3UYnYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=KuU75td4nx4Wu7Th+XndsOQa5aPjfN/MrcpP+tdUDpwKU+l3l7ORdVf1nzhW6t1hu9cO6uFXtBCG6F/6fFLNqfA/3F298L7tax/etK9jIo+Z1EWzXwyCrn0ZBQ8SKNcolT8g3rGTQy4H10FS1j39dTKU2sh+AhTZnbBm+O0t6Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DZiivurh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EPQqGJte; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AGiiQa030825;
	Fri, 10 May 2024 17:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=D7YJxyynhz4GjDYyVrdsvyg8eTur6K5Z4WlJ1yRCqJY=;
 b=DZiivurhiwqhQsDTqB+yzWIu7PhRMuW5vpYvXU05+g9JdO8laGa56EzLR8YUZVXYurpc
 tGbcMBup2gbjOx6eUg2ppTvwikZ/+pg84ePgbKNgfJRF81ZV9QtbtJCmTCFEXIY4nXGH
 aw9Nu0UOZZAf3KRpCl4qRkOEm9ej23l695SbxCTG61QJ529cz/SdcKsBujl/BU4bFUJ4
 riNoAOUIdUTcZSV5spLJ0iZClHaX9okg9TmM9+20857UwHxLrPVqDx04kQ34ZFR/U2JJ
 CmD/7y3UvnyY80V1CQVZYpz64pf1V7SnnLbMXXQAX6QzOs5wqAhowR4uS6fewJN47Grq vA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1a0j9n1f-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 17:25:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44AGBW4Q017810;
	Fri, 10 May 2024 17:16:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfq4n3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 17:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6ixJ4Eue85gmHg7ilDBRlI5OUo0OVzv8qCb7KtLYK3D96Omx0FPdIZKJ9TFBOj3kv8ak0FGsqfWS6tSZdPcyx+f1UAQ5kM1CHQ4+WlqSBkIyUEjLKj5Dw9w/rCwWGmUdM12OWIIyFvOBpOODlb9WiiXD9trBEKimVJBtCG2BJPGlY/5EMxT++eBsZf0ge8HTMtOe5T5Knshu+Wd03r6Lu+CrDs0coweBNE+0rrUxmEX8z4HxjvdJ3SCqgHljbolF0yf+IztSIb/uIzsiJV9ndw++zGjdB3dXWqde6a7AKVMFlhytZyAvq6JEWw0QnPBtLmZz/Z6+NCoYKbTmJ4BzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7YJxyynhz4GjDYyVrdsvyg8eTur6K5Z4WlJ1yRCqJY=;
 b=VD1kVJ7bta/iwM5z/9YrRVpW58Da8Qbm8jHp2n09xfID2A5Z5g5m5Fas1Mp6BbIEflcvanQzrrLwzwi+u4TMNum6/v6FWYlzWPQ3yuHy9ZTNA3TemP5hsj5Jnw+UPI5Z79GgCjZk06xsJOGib+2ZHyVOMAw7ldHpV5yi5gfPrAes/a1be49bMtqOZFZINzchK2gActQiscasvz8kEz9/HvFeSA97TkiZUryTjZOMnvUw/dqR+gSxhZzz7dZfuboV29kAkVAFhkX7nunZfH2OL6Ijtuz2Fdf65GN/CopmsHJVJ7Ysj2gNQcHWsanjwTbWxiGw0eTe1nXCUrpX6EbVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7YJxyynhz4GjDYyVrdsvyg8eTur6K5Z4WlJ1yRCqJY=;
 b=EPQqGJteUwq4ERBURqwQ565REjkW5EKxdjtHE7lRF9FSxUEmS9UVVYtBF7BxAVfSwLmqq2kY7VA4ZiFAjwBIiBIhkHcwDgzYWtzIIQDsRKqsCZqDzp3+RvsP8CJuWPvFAtQwMc2vxBP1g5b9Re6tpyhEqP+y6CGlJcpdcB7RNF0=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by MW4PR10MB6584.namprd10.prod.outlook.com (2603:10b6:303:226::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Fri, 10 May
 2024 17:16:46 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.049; Fri, 10 May 2024
 17:16:46 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, David Faust <david.faust@oracle.com>,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: Re: [PATCH bpf-next] bpf: make list_for_each_entry portable
In-Reply-To: <CAADnVQ+-w1cD83mE0u0QhCP4cCvSSB1-GNoqErYRRhtxcwkTmg@mail.gmail.com>
	(Alexei Starovoitov's message of "Fri, 10 May 2024 10:03:51 -0700")
References: <20240509084650.17546-1-jose.marchesi@oracle.com>
	<CAADnVQJRpCX+vmwCu3xYz+V4Bq1gn3vnCAZk3CAJcB3KUq_-Cg@mail.gmail.com>
	<874jb62ht9.fsf@oracle.com>
	<CAADnVQ+-w1cD83mE0u0QhCP4cCvSSB1-GNoqErYRRhtxcwkTmg@mail.gmail.com>
Date: Fri, 10 May 2024 19:16:42 +0200
Message-ID: <87plttsi2t.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0502.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::21) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|MW4PR10MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: b81bf3c2-02c6-4665-19b0-08dc7114f88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VThYTlpiMGdGME81cjZrQ1laTlNSN2JKNzFaaWxsYjU0M1pXTzdNVGF5bXkz?=
 =?utf-8?B?dHFiaXJORmYwQkxtSGxRYTBaeWEybklMK2kvVDZUNnVud0d6NmxnZC9UTW94?=
 =?utf-8?B?NTFYZkJ0Uk5WQW9nSlhZSml3VGRKL2Y2KysyVHdBT3VyVldrZUVFNTVxZk9M?=
 =?utf-8?B?S2NNcVd3M01OMy9lMTVzKy9Ca05jdG5PRjZMd3RRTGFieFFGQ1Bza1ErTnNZ?=
 =?utf-8?B?d1l3RWcvNWRuRmlnVTFhNHNpeGxhdnVnenVmQTMyYU82VXdZTGMxeEZNUi9w?=
 =?utf-8?B?aU8yaWorYktaSm1VcHVodThWYWdCRUpxTXJlMnlUeStiR3owekczUi9oK1BQ?=
 =?utf-8?B?TmRHaHErNFFaRkhUZm0zSFdPVldOTWd1SW42Vm4rd1RoeGJCeDZPUU5ud3o2?=
 =?utf-8?B?eVowbGpOQjNEbzl0NU56Y2Z4YmF5TFIrci9WRFd1WkJPZXoyand5ZUJwQzVq?=
 =?utf-8?B?Uk9UbVBGWm8yazlRZTFUU0VnaFRyNXdsSjRKdmNHTHgrTkNpNjF5ZXcyMkVK?=
 =?utf-8?B?dWxYVmxpbHB5Z20waENuL2MxdGdIclpCcUJUdjZTQzFSeURQSlRQUklWM05J?=
 =?utf-8?B?TFcwZXFrMlBSZGFOd2ZiTUpMOFJTZVZnd0grdXRQTllEQTIxS2NRSXp0Qko1?=
 =?utf-8?B?VENQeklUeFl0U3Blekt3dHlwZmQ0dDlMVlNta0ErVlFFSWdHZTJLTkYrRG83?=
 =?utf-8?B?SjlNQkJvbk9BaEZrZ2twWnhlTDhMNHFMelNUNmh1aEZOcXM4S0YxT1kzbHRO?=
 =?utf-8?B?SjJ6TEhOUnFldzlqOFpFOEwrbTdkbTJWdlU5TEF2UXo0UWxaU0JXQW45QkY0?=
 =?utf-8?B?TzMwWCtrbHJudWJEamxHWkdNaWhmN0dYQVM3QTNibkc2aWtLSUpBYmFWTVFn?=
 =?utf-8?B?SmltVTVLVnQxait1QVVjblJzTFdQajlPcnplTXJwN3FTOTVMM0psY0xVQ090?=
 =?utf-8?B?VEdPNVBOZXkyQjNkM2xjZTlNMVdUYVl4enNubUQrWjRDZlB4SlM5dG1yMzF4?=
 =?utf-8?B?cW9VdURGeG53eFg2ekVDWUtCMGFRYm0xMGsyRjZzSXJBVUg0b0d5TG15Y01t?=
 =?utf-8?B?QXl6U3ZFTmRmd25EOU5pOHlTcTB5T3NEUFpobzBzeHJQaDB1Y0QzT3k1ajgv?=
 =?utf-8?B?Y0I1clgxRFcxT0M1c2Jud3dlL2lkdUNLaVhKY0MrdE1iZ1FUR2l2VGJiZVd5?=
 =?utf-8?B?SFJUcTZFYjlhL0txOS9sMk9WSGEyNHo2bHhrRk91TERpbjdMaEdCS2JhN2Zu?=
 =?utf-8?B?VEY2OW4xbnhCWmIrL0ZhVldGUWg0LzVTc1hyZFBLbUdnUEN2UjhCRm9HdWpu?=
 =?utf-8?B?a3luV1U3K09lckI0K0hFQXlFQ2VRTzhpN1l5djU2ZmptTGswMlJqOGtOSXhF?=
 =?utf-8?B?ODkzQ0ZNR1hyS29Mbmx4YWZFM3JRdHVlM0RJM1Y5cStZVXJvUndXZVl1U1hH?=
 =?utf-8?B?MFY0RDhjVHZaYlNDZXBFZzJURmlCU3k0KzVFRXNwWjJvZTFPblFjVkc0UlpU?=
 =?utf-8?B?YndvUkNwS3FHTHFLdjFRbDR0MGFZcjFDOGVDd0Q3TXBTTDFLczcxdmEyejRa?=
 =?utf-8?B?anZrQkc1d2VZU1BhMmJpK3NJS0xVNnVvR1JKRHhxZDBIbU5SWnMzYW1GZmxu?=
 =?utf-8?B?Q2tqTVM3K0ppOWNrR1lFNTlaN2NvM3VYaHc2Ym1hWDl2QzV1QU5ocEd2b3ZG?=
 =?utf-8?B?WDhMR0FXSEVUOE1CbmVPa0JiV0YxbXJCdEVIQjkvWlJIWXZMYkhYU29RPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RExtSTBNNkd6dWxiOXg2R2ZndThLb2h0MHR1a1QzcnJjaTNwb2RqejBhNlZl?=
 =?utf-8?B?bksxQkQ0UXJYQkE0V3ZtQ3lGeGxqK1NJL1ZzZkJOU3Fxc0tkV3F1ZzR3ZVRj?=
 =?utf-8?B?YUllbnFyQ3VKR3JhUkhpczNmWGJvT2ZQdE83QnNUUzFFaDJUOFRESUk0VGVG?=
 =?utf-8?B?ay9GaG9XQUVzT2ZWWTlSeVdpdXVValpzVkQxMkNKVGVaNzFDSVhyczkrb3V1?=
 =?utf-8?B?UERaSDA4YnBJN2J0RmJXKzZRNk1teWg1SzVHUVJzdHpiNUZlekhUTnlnZitF?=
 =?utf-8?B?eE1KcFdhK0NuaEhhRFdmRUJyeVdrTFhSTStFN29iZHk1ZDMyQ3ZFZnA4T3Fo?=
 =?utf-8?B?c0Z4c1RINjlEM1BwcXlnZXZzYnVoSVhCdnZsU1ZHL1lxWWxrRE9GaFByWlh5?=
 =?utf-8?B?a2F0L25wQ0hJQmc1cllXUDV1QldQNHRTai9XalBjYWhZTmJKNUNza3MzK3lm?=
 =?utf-8?B?U1ZCVGlITzdtbWc2UkNUZlF5VVY0YmhNUGVrTWJEV1V3RW5zelJoS0hDMGpW?=
 =?utf-8?B?WGhzemVKdFJPV0xFSmoxN2UzZ1dDWGFnVzFjM1BCNktjaDE0ZW5VNFVJY1ZF?=
 =?utf-8?B?WVJ6SEM3Mk0rdXdsYmxkRDF6Tm1BV0h1VHlFY3g2TWtGbktVRWlEajcrbFd5?=
 =?utf-8?B?S21TKzg1OW56RFVxbjhNTjVyVXErUVBSQVVBeTBoNHp2c3dnTy8yY01vYWpz?=
 =?utf-8?B?alVpSVk1U1pJL0F4WkVUczJ6Kyt1dzBPdGx6Sk9kZElESTJId0YzOFNVWGxT?=
 =?utf-8?B?QkRuTU1wR1VhTmx2ZmZhM1BaZmJod2xDVmFyZEVYWmUzMTl4SWpKMXNZTXRE?=
 =?utf-8?B?TEZxL2dnbmlZQk9mQ1ZUaUZTZ1JIUVZNOU15OWlVc2FhZi9aZE1wSGdiRFpp?=
 =?utf-8?B?Uzc5amdMZVZqa1BvdWdWYUxlMFRjbEJaZ2Jrc2hucTAzSzY2THYrT3QwTTlt?=
 =?utf-8?B?Sy9vVHU5eTIzWWZsTG4wTjl4UUF5dldTQ2pRQ2k3Y29mNGZ5OVg1VXJpb2NJ?=
 =?utf-8?B?a3Y2WUZCMDJFNE1rR2VMckhhV1BYVHdmVDB1N2NqYk5tUysxa3RRL3pXdzZU?=
 =?utf-8?B?N1pDUWl4cmFhMFlDQXpEdkN5VHBDMTNsZ2ZwNkFIbkJKMlRDckN4R3JUSzBQ?=
 =?utf-8?B?K1ZDTzB2VHpqS1M5M29HK2tpSDdEK296ZzN3SWRvbzFtRjg2WTErbFdjV2xT?=
 =?utf-8?B?K3Mwakk1bFhBdnp2Q1ZwajRKb09BcU4waDJBYTJVZHJTbjRGcmJnT2tIR3hN?=
 =?utf-8?B?bXVjUy9mVzhEN1BZSStmdkhZcy9RcldJRlp0amg3NGZteWVIT0RGdFNvbi9B?=
 =?utf-8?B?MzR0ellhcEpRVm9yV1JKQ0ZEQWlOSkVnM04vdGRZNWtUZzhhcFV5ZllRM09R?=
 =?utf-8?B?VzBHS20wRkR5TG10TmkrelVOcU9DTDFSRXBJT0Y3eXRDRVRIQ0VJUlluSWZm?=
 =?utf-8?B?YkoyUzFtWTBJNkFYelZpemZCcUdZQzVrS0ZmZWwxQk4yRFNXclJLOS9HaUxW?=
 =?utf-8?B?SUR0RzJ5RGpxSTA2WEVrbWJWUDA2dHlvQWMyQVhWMlFEWFl3aXAyQTJhZ28y?=
 =?utf-8?B?SkdpTU8weGtLZ3lKL011ckdjcXFLM0hISFhxcjNYN3hhUzNqNWwwOTY1RElh?=
 =?utf-8?B?c1VvSy8zTFJRQ2J0d1I0WGxyNVFjYm9uKys0bzNBY1BrQlFDa2dzYytWYTRX?=
 =?utf-8?B?SjdJUHR6bzBFT1hJcUlGcmJhMi9jSUFlRUxvajlLZlhPUXdXSXZRNHJoRmNs?=
 =?utf-8?B?U1ZMc3h5djdvaWZROEl2c1lUaEJtQVJmZ28yd01TRGdTR2JUeEliT2ttZWs1?=
 =?utf-8?B?anRXRGpENkVkYkMyWGtiTlJ2MG1Jby8vNWJzMDYyNk5FUlJGM1ZVa3RwaUpj?=
 =?utf-8?B?VU90Ui9UY25uVHU2MkJmWW5HMHlkSHN2djA3VDQ0czlZckIvUEhFZytmVkU5?=
 =?utf-8?B?eWJGc2NpYVlwMGcwdk9CWUhXWXNlZXl0R0YzQWFYczQyZmJGWW1wSFRVbnlD?=
 =?utf-8?B?Mm9FMVV1UGYyVjBFSzBBN3pramJwbmNYUDVIVGJ0elY5VkViNGM1aTZHTk9n?=
 =?utf-8?B?cS9XdEZPd29DRHo2WnZqZUNoQXFFZlZlRnk4bktrYzc2YUdJOCsranM0LzJH?=
 =?utf-8?B?WW9KTVN6VndOVUlOZTNwSHNZUmtjSDJPZHdoVEM0eWZqalZzR2Jlck5XazVo?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R3QXHcsVa1+12ZFaew7jwcB2G0NhYyZePUWxI0ZrXMhwONb0+NgDztCwRcc/eZlclx8ya4SYj+BL+GPHf8bqm6scnEBzOcGmYhrFmSp+zX79ZgOVAc1G2yc1VziAdqfc+Uq9yQb8nsrg5QdJz7AFe82JgNLQ6VDtHu0wwL7pcKzgrnmhRSujU0XJ1xmd8zF4ImCAvn9OfB33nHO6ivyIJ+RiLPCy2gEBjXiQoQMEdQh7Yu0uS4sj+5cHH0iHt+6UkhmXfVPuQO//HJ6akRep+WesTAzQIsx/yiIx+DBiQHaKnoExiAHMsOETGA7f5cKg/Ofsswdpg67cBXjdQBrdJtY0dIRo33dp9kwlyFQJfB3y1dqUWOd3hVyWPLAwmoFUu7xIVb6qHSpgfZzAb0U1TPf0OVgup1yLdZqCExe7jYM9nhD/gLAn0NH4DHbj6BFSfpCM8SUkYOm9O2ZbDbQb1CxAXG43oFH3ECNs5R42H5FSIaEX9uwaVUhqFYBtS/Pz2wdBltWchQN5vbGoOBRyh/96Muu8VL+k7QU2hydRw7p7qzJLggBRk5eiN74O/Hr5iYXhCdHGAd5hJrBNJeZcIKxBHxUM54Zy33amXYyyO8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81bf3c2-02c6-4665-19b0-08dc7114f88b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 17:16:46.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9a5hEp+XBeW/B0AqG3xLi4t4JS5N623a/W/65xDfZcElK2UYKCMlIvX4RXDS/hMNp8n41zFOsyZJyNDabwDRRTAwxoke3epZQ1tS2VenKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100124
X-Proofpoint-ORIG-GUID: W41_xVsfCZYrJdBMJ3SwzG6Txct6cqIl
X-Proofpoint-GUID: W41_xVsfCZYrJdBMJ3SwzG6Txct6cqIl


> On Fri, May 10, 2024 at 1:27=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Thu, May 9, 2024 at 1:47=E2=80=AFAM Jose E. Marchesi
>> > <jose.marchesi@oracle.com> wrote:
>> >> +/* A `break' executed in the head of a `for' loop statement is bound
>> >> +   to the current loop in clang, but it is bound to the enclosing lo=
op
>> >> +   in GCC.  Note both compilers optimize the outer loop out with -O1
>> >> +   and higher.  This macro shall be used to annotate any loop that
>> >> +   uses cond_break within its header.  */
>> >> +#ifdef __clang__
>> >> +#define __compat_break
>> >> +#else
>> >> +#define __compat_break for (int __control =3D 1; __control; --__cont=
rol)
>> >> +#endif
>> > ..
>> >> +       __compat_break
>> >>         for (i =3D zero; i < cnt; cond_break, i++) {
>> >>                 struct elem __arena *n =3D bpf_alloc(sizeof(*n));
>> >
>> > This is too ugly. It ruins the readability of the code.
>> > Let's introduce can_loop macro similar to cond_break
>> > that returns 0 or 1 instead of break/continue and use it as:
>> >
>> >         for (i =3D zero; i < cnt && can_loop; i++) {
>> >
>> > pw-bot: cr
>>
>> I went with the ugliness because I was trying to avoid rewriting the
>> loops in the tests, assuming the tests were actually testing using
>> cond_break in these particular locations would result in a particular
>> number of iterations.
>>
>> The loops
>>
>>   for (i =3D zero; i < cnt; cond_break, i++) BODY
>>
>> and
>>
>>   for (i =3D zero; i < cnt && can_loop; i++) BODY
>>
>> are not equivalent if can_loop implements the same logic than
>> cond_break.
>
> It's off by one and it's fine.
> The loops don't and shouldn't expect the precise number allowed
> by may_goto.

Ok, understood.

I assume you also want to use can_loop also in the definition of
list_for_each_entry?

> btw there are tests that use cond_break inside {}.
> They don't need to change.

Yes I noticed these.  Won't touch them.

>
>>
>> The may_goto instructions are somehow patched at run-time, and in a
>> predictable way since the tests are checking for explicit iteration
>> counts, right?
>
> They're patched by the verifier, but they're unpredictable.
> Right now it's a simpler counter, but sooner or later
> it will be time based.

