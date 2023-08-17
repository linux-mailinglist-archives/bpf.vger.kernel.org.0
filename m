Return-Path: <bpf+bounces-8004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5AF77FD1A
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 19:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91431C21473
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 17:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9954F171C6;
	Thu, 17 Aug 2023 17:37:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922F14F7B
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 17:37:57 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFE310C8
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 10:37:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HFxEuY028287;
	Thu, 17 Aug 2023 17:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=k7x3aWylRJnk5DUks2CIVhs/R6QhAgKdEjEmsvMIWSM=;
 b=jMOboEMnVI0cNgVqo7A5LX3l40F5A1IO3RaDJjRkT0ebVTn5Cl7qx29Wd808S1vwrzKy
 yZZFYqGOddq3oXTqw7PMwWdSViuBkGy7X7Y9q0CsDIb0qqgwu6wyIfUXQGPOPxK2mR8V
 qeuyYdEW5iW8F2ORlBWWDyJaVR9nllScXnyQAQdUFWH2SMzGo2jKlkZTnYVTCuHZEe00
 VRhZtaezG/KvK5dnNGFjCfTo9GDeDwWNwH2iGcLb1wrdTm+uAYifrLzScQWDyZcgZanK
 VsBYy1OFpFoxHkloWhXuhzMfLsTh+atCzp7CvYrgUv/P0EVPDCBPe0QVO6r8Yu8dQl0B 3A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y324yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Aug 2023 17:37:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HHAm0R007184;
	Thu, 17 Aug 2023 17:37:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2g5rjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Aug 2023 17:37:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoJAhdMnXLSEm9jYWPXWVb4WsToeue3+n+jZN/OSCGji51aC9sOxOAkrvZkaDeX+iHJjQXFnW4OW2jU4K5X8MDzAkTqUlHvNQDKVVn76a4EhfHzv0hbfCl4hduswckvNbE3Ai0rlXnOvMTi5anoYUjR5Qm6MeFzsDDHIPxOS1Kxkr6OWiaDwdubOHYXu+kPGu7J2AjnfH4lx7O425QI684/UlKxcW7sTKqx9UVmAq0lz6swCzZKMuxxCYsF2tefSEeIomNsNXL1H9RE6k47YrtbmH5MHiZvl7/CDhEkkghGStYcPeMuWODxMaJYDpSFdzN6uHa0gflj/2HnqLlDKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7x3aWylRJnk5DUks2CIVhs/R6QhAgKdEjEmsvMIWSM=;
 b=huH0leD6IXh6xvVxbaQHeJc9BOnFETlQge2zWUjJyuFKHBdII383E27SQFohdUDHWrBUAtknnqD/7Vs0nmNOPTJJ/RAWnedOTTBrZ3m6dyukZLYUS3MFg3VC9eO2zguNl7qgRXe+PyfxsI+fgpXjHh637oH2u/g1oiePtlleZ4DKq8sqolBmrC509+IgSTmQlbXLUb849+ZZr+iarePjeAXQdjWWHksuZyORijNYWhymH72iYhUUJX7ULjasS9W5Dq2ZOI3p2elf493IRm4TU0hyARJS2jzpyGgq+EMX5tpIwDn3qoKxfSaYXox0/uYuE2xS85/kvXEGGQ0CZzdMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7x3aWylRJnk5DUks2CIVhs/R6QhAgKdEjEmsvMIWSM=;
 b=JtWuSepjoOfazhb7+lds9V7nrFgUS77FPbN7ds9M7rj0JxgGwCRDyeEChv6EGkEU0bI2TcmFrqvUNqJ73cccwbdiRDpk7blZnvSERMq0zIZelWtb0JaIMwzWoUWtgmEabbA6cl+d5ASTv1NkyiZkCQuppizm1UQdi/W5ETny52M=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by PH7PR10MB6649.namprd10.prod.outlook.com (2603:10b6:510:208::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 17:37:48 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7d31:72cf:ebed:894f]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7d31:72cf:ebed:894f%5]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 17:37:47 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: Masks and overflow of signed immediates in BPF instructions
In-Reply-To: <83e093b1-97ec-14e3-56ee-8258eea66709@linux.dev> (Yonghong Song's
	message of "Thu, 17 Aug 2023 10:14:43 -0700")
References: <877cpwgzgh.fsf@oracle.com>
	<ab4264da-7c73-e7c5-334d-ed61c9fdd241@linux.dev>
	<87leec44v1.fsf@oracle.com> <87wmxv2ut4.fsf@oracle.com>
	<bbd86b4e-89ea-8e60-883e-f348117483b4@linux.dev>
	<878raa14rc.fsf@oracle.com>
	<92974205-730f-4815-1eda-f8ee8217d8dc@linux.dev>
	<83e093b1-97ec-14e3-56ee-8258eea66709@linux.dev>
Date: Thu, 17 Aug 2023 19:37:29 +0200
Message-ID: <87o7j5wox2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO0P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::20) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|PH7PR10MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: aed77d2c-0b9c-4752-9717-08db9f48ac06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tXURo2G4tmnJKACVdawgj1GnISRfRV0/4QUigxN4SOIPCW3DZbA6db3vP3eB6WkF1alLB0YSgIjzSKenFA/1DKU7RM2ZtImb8ByhZT4dK78BxDu33BlPqVSofoFrtmS9Q7IRTg5NGnG67CqJvdgEAKc+IOSPhy/wYTugNl5F7TKdh+mA+5ckFUDremXJ4NQNhsJ7iaX+K+O0ppL3IM3qhdgVE3JvPlr78mTghKW6FzqoWKJqHNj4SQ4mDItKskkBzzJTmR4Ag1MwwOzaw+C0VPdS4JDAJykusTBm2DHRbAdms8+FK2O9iU+dieMw61EHem5rDWnhbdsD/gi4Aie48YuTUyZ8mGjnBsNd0wnxg6NQVspSgRsURO6a4mMTnxNgK13EZ3WWz8lLcFNTH6Ub7+4w+p5/Y2zSLBzK/l24MscwWJp21sjeLVYgJZrWXbWFx5XfNUahPYgsWXXUBTpu2v20rV1WK47PkUJtXGp+A48IaCJiuz67BdtV9v/qELgvR4ErWfh0QfDhL/sg8MGsB2oXKJhMsBQMGHCH8AnqqR4x1Z6BlZLFaogDBa6COs4i/bg83ZbOTXdRz9vhQPyjIH5v0WhuDijykUd2zRNieBg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(36756003)(6506007)(107886003)(6666004)(2616005)(6486002)(6512007)(53546011)(5660300002)(41300700001)(316002)(66476007)(66556008)(66946007)(6916009)(4326008)(8676002)(8936002)(38100700002)(14773001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bDJIMVR5NGlQNm02TXdaRE9pVThPYjRWVzN0ZjRRMFFzeUVIdDQ0QnB3N1ND?=
 =?utf-8?B?bGl0bC9RQUhRdDVra3drZndvSS9udisvdVIrUGhaL1hrQVJkeXBkUDh2Tmh6?=
 =?utf-8?B?c011bkdTTzFFNFZBb2R6M0N2SnA1ZThDUExDd2ZBK3VVY0hnVjNCMDdqbzhC?=
 =?utf-8?B?bkpZRE9WQ2tjMVdtaUR2czhuYmxpMDd5amw3WWd0OGQxTlpDVjVLMUxROHMx?=
 =?utf-8?B?YzNneUVZbTRGdHIwS1NCSE55Q295K3pjQnBmbERNTkVaOXoxR2RTWDdSSEhY?=
 =?utf-8?B?b0xENzN0aUdrNEhRVlNVZUhsTVg5TjF5ZTJkTzN6NWRkQ2lSTFNkaFJ5ZEN3?=
 =?utf-8?B?M1FJZ2prVjRHYVNXeWJzamV2QTdPOVdZeGRmNWZkK0ZZRG8vamtBN3JSaGFP?=
 =?utf-8?B?Y2dHM2FHVlNFVktpcW9WS2tCVXpHMnJjVk9pS3lvNjBUcWJ5R1dSWlZqb0tT?=
 =?utf-8?B?VzVneDI3cG13RGdOTmE4WmlCTGw4U3NzZU4wM2YrcmpMbmNDMDlwbEw2YVFI?=
 =?utf-8?B?QVlJU2FLY0hudGl4VVpRWG5pdFdDN3pVNVA0L01CUElpN3Q5bDRWcEM4SFFB?=
 =?utf-8?B?aElLcEh1TWo1cGNrQzBTanIzRG8wWGkxWXVqYW5QSlB2OGVGdVVzRndDUUhV?=
 =?utf-8?B?MWlqdWNXZExvZWpzTXNqZHdiTHpZVStPZ2UrZnl2UXpQQVoxUDlyYVdDV1B0?=
 =?utf-8?B?R3NmN2VKN2g2ekU2Vzk4NTV0cWhyaEtqUjJncyswQ203VWI3Qmttb3NNR3Fq?=
 =?utf-8?B?b3ZDdkwyY21TcVJJaWMvZG40VmJWcGh3QjFBcnltUHErS0g1a3lqTWNNckhi?=
 =?utf-8?B?ZHQyUm1EN05FeldKNW1lRUpYL0QyT2cxSW9ZRmxrUWFOdGtOU0JKWk5UK09J?=
 =?utf-8?B?TlIvbWNyaVBvLzhvamtPcGgwbVdqbnBheE04NHQvSmpGNUdMU1FsWFZGcGpU?=
 =?utf-8?B?Ym1WV2V4YXhBMzNkTXdDOFFJYmx1RGU2UGk0aHdISEV1QmsyOGZna1kxcmt5?=
 =?utf-8?B?cUFESGpjZ2JRdW9PdVd3cDRNbkIxckwwbm9iNUdQMTAzcWZJank4N0twRURu?=
 =?utf-8?B?MEtxZGY3V0I4ckVVOFpoNlh3c2JEbjdxSldqOTRkaGJ3NlpxTjFsaHowVXlO?=
 =?utf-8?B?OGg0NzlPWktoS0x6T1R3SDV2UjR2YnV2aWFEOFU5c0RQNkIzOGJvUzlCcmo2?=
 =?utf-8?B?VUVPa1oyVkxyVU9ObjVORk9DOXZ3WEJqLzBLZlJSa2l4YWRhR2hEa3kvZlFP?=
 =?utf-8?B?OUg3c2VYTTBESEZWR3NVNGhPcDhrYnJ4amdRZDdoeE4zT3lTUk1sZTlpcE5B?=
 =?utf-8?B?Zmw4dzBvRVdYaDJsWkFlRHlLSFM3Wm4xNzVkQU5GQllNZjNNSmVyMTQyNUxG?=
 =?utf-8?B?NHkwRWlGbENFcVFHMkRNcGwwYXU2aXB1V091cHJRcjJFY3V4bUtuSWR6ZkQ0?=
 =?utf-8?B?ZEdXTUNaV0M2dVdQV1ZKMVV3dmRoY1BXT2I3T09Rd2VlNVRMdmJSTmRhSlZ4?=
 =?utf-8?B?SENpT2kxRjhZcVkxU0xvNjNtWnlDVkEzSlk0Z3ArUVVpUlJQeWVTQXczeTJq?=
 =?utf-8?B?bDZRVExIWGZkMk1MV3NmNVFZMXZlZENRUW90QmxRMUxsUVZOa0NIZU1xZXpJ?=
 =?utf-8?B?Vm5CSWM0NjhvTlVnRDc5Q0JuUlJ5L0dScjJUbDU3MitHV0pLc2RMZEZUWDl2?=
 =?utf-8?B?L3Q4WC9DREZvVzV0cmNPVVUrcHc5SlBYS1YvTWs0VE5rVlNlYU5kcnNWdGVw?=
 =?utf-8?B?Z2YzdStMeFVwVTFxazN2Smwxa2xwTE5KSG82dzVNODZHVmlFNWd0YndJZkd2?=
 =?utf-8?B?RWwwNGNFaTQ0NXUveklzb1g0dW9zWE9IRnJIUUpQQlBMWmJMdlRHSGVJTWFE?=
 =?utf-8?B?U0tkeDl1Q1NYR1FGaU45dzRZcloxSFBnc293L3FraktTY1hVVzBpK1NkNGNL?=
 =?utf-8?B?dVNPa2RXMU1YVmlOQUxEckxIVWNVNExUUENabExVZVhQMTJ4ZEdvUmNJQ2RI?=
 =?utf-8?B?VTJ4MEJQQ2Fvbk5sTGE2UEFxNmdwZkw1V1lXcHI5UW8rVlBRaS9ueUk5djZu?=
 =?utf-8?B?anRULzdTS3RYcXFPZ29OQ3JVZGFublVrZmEya0tnR3IxVzFzRmJqT3gwSElw?=
 =?utf-8?B?djd6K0hlZUxIZlpUeWxyZndLWVV2MTdVRlR3SFpYYjlwWSt5djRVcy9QZjRG?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cO307R5lDdJMUSCFyjRq6nmLnmDbpFSlY12fp1PzWZEY5YQD2owa+WNS+r8twKKiTLGew4KDMXr4fXJZki39jkBWv6a8zix8jrvhK62WCAgKo5zY02MUCH/xo3kOmT9/RHTKA0f/XrP0HDsquyU4rNbIYY05SBXZX3MuEpz3zFbEXEjmIzOtdNzS43C3yYI7NG2zm+jzt6joFKkD2aS13jOVoDr+iDy1w9JSb30eHV8OPHstXWRqZqXfDQMZ5wQ7TryVc1q5puY1ysiICMPNz7zIacPgyBdIhxCdQcvnQ0RJAG8b8Yqw9F09OUKh6SxGvSFDogSsPOg3TvOZEUS8LS7oI/8i8EuslkxF+r1InGbJVg8w/FFbh4VG/O3d9I7rgckgQcEv/V+5NzYln8b9yQtT5dvjmdM6wfgmAbu1utDOTcjh5y3AxANIgMsbgUEbnfIG0JkUONP2PM9H+HLJJddCBrwUBe10IjMtnjzqyXl7dExhtymwpeW02SL+doSA6+6Mf+UcFoY1JOFdRWnyC/xqLx8Pb8tduYdnOhJr/If8gnbd/2iwXzib+L/9znxgAiLXszFWPaAHCcn8vpjMFxrhvIZ0uWq1j45w2PH4vFL0unQ8AZbZ0alKw4xUUKgyckOdWOgGI1ZlxzzhUPvGSQEq7mXzubO77O4U5IF71fO7pCzBptdiS8gvy/wPol5AI7kGhSe9X4Lpo/2bbaJDnFd3Gdq9IaSU3TKFg9KlmiAZ5QTgvHPYhs9AdQMYjjdEPuwCL5DIOHBWWyrI3h0ZsOrHqTD7Bfrco0kRES3AmeE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed77d2c-0b9c-4752-9717-08db9f48ac06
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 17:37:47.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnzV6Xtgag24jnPEEFEipHrLP9O+TsKmLtajDzdd+Gpg2hRTfyxNGzWo567S8Wr4yGNNNo7fa2jQF7IdZJ451dDhsgUQiMBntAftyQszD0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_13,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=950 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170158
X-Proofpoint-ORIG-GUID: FUjdMPMEUYE0fZYpXtmp7FTwj-1zETOf
X-Proofpoint-GUID: FUjdMPMEUYE0fZYpXtmp7FTwj-1zETOf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On 8/17/23 9:23 AM, Yonghong Song wrote:
>> On 8/17/23 1:01 AM, Jose E. Marchesi wrote:
>>>
>>>> [...]
>>>> In llvm, for inline asm, 0xfffffffe, 4294967294 and -2 have the same
>>>> 4-byte bit-wise encoding, so they will be all encoded the same
>>>> 0xfffffffe in the actual insn.
>>>>
>>>> The following is an example for x86 target in llvm:
>>>>
>>>> $ cat t.c
>>>> int foo() {
>>>> =C2=A0=C2=A0 int a, b;
>>>>
>>>> =C2=A0=C2=A0 asm volatile("movl $0xfffffffe, %0" : "=3Dr"(a) :);
>>>> =C2=A0=C2=A0 asm volatile("movl $-2, %0" : "=3Dr"(b) :);
>>>> =C2=A0=C2=A0 return a + b;
>>>> }
>>>> $ clang -O2 -c t.c
>>>> $ llvm-objdump -d t.o
>>>>
>>>> t.o:=C2=A0=C2=A0=C2=A0 file format elf64-x86-64
>>>>
>>>> Disassembly of section .text:
>>>>
>>>> 0000000000000000 <foo>:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0: b9 fe ff ff ff=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 movl=C2=A0=C2=A0=C2=A0 $0xfffffffe, %ecx #
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D 0xFFFFFFFE
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5: b8 fe ff ff ff=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 movl=C2=A0=C2=A0=C2=A0 $0xfffffffe, %eax #
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D 0xFFFFFFFE
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a: 01 c8=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addl=C2=A0=C2=A0=C2=A0 =
%ecx, %eax
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c: c3=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retq
>>>> $
>>>>
>>>> Whether it is 0xfffffffe or -2, the insn encoding is the same
>>>> and disasm prints out 0xfffffffe.
>>>
>>> Thanks for the explanation.
>>>
>>> I have pushed the commit below to binutils that makes GAS match the llv=
m
>>> assembler behavior regarding constant immediates.=C2=A0 With this patch=
 there
>>> are no more assembler errors when building the kernel bpf selftests.
>> Great! Thanks.
>>=20
>>>
>>> Note however that there is one pending divergence in the behavior of
>>> both assemblers when facing invalid programs where immediate operands
>>> cannot be represented in the number of bits of the field like in:
>>>
>>> =C2=A0=C2=A0 $ cat foo.s
>>> =C2=A0=C2=A0 if r1 > r2 goto 0x3fff1
>>>
>>> llvm silently truncates it to 16-bit:
>>>
>>> =C2=A0=C2=A0 $ clang -target bpf foo.s
>>> =C2=A0=C2=A0 $ bpf-unkonwn-none-objdump -M pseudoc -dr foo.o
>>> =C2=A0=C2=A0 0000000000000000 <.text>:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0 2d 21 f1 ff 00 00 0=
0 00=C2=A0=C2=A0=C2=A0=C2=A0 if r1>r2 goto -15
>>>
>>> GAS emits an error instead:
>>>
>>> =C2=A0=C2=A0 $ as -mdialect=3Dpseudoc foo.s
>>> =C2=A0=C2=A0 foo.s: Assembler messages:
>>> =C2=A0=C2=A0 foo.s:1: Error: pc-relative offset out of range, shall fit=
 in 16 bits.
>>>
>>> (The same happens with 32-bit immediates.)
>>>
>>> We think the error is pertinent, and we recommend the llvm assembler to
>>> behave the same way.
>> Thanks! We will take a look at this issue soon.
>
> A patch like below can issue the warning for the above case:
>
> diff --git a/llvm/lib/Target/BPF/MCTargetDesc/BPFMCCodeEmitter.cpp
> b/llvm/lib/Target/BPF/MCTargetDesc/BPFMCCodeEmitter.cpp
> index 420a2aad480a..fca6bf30fb4b 100644
> --- a/llvm/lib/Target/BPF/MCTargetDesc/BPFMCCodeEmitter.cpp
> +++ b/llvm/lib/Target/BPF/MCTargetDesc/BPFMCCodeEmitter.cpp
> @@ -136,6 +136,12 @@ void BPFMCCodeEmitter::encodeInstruction(const
> MCInst &MI,
>      OSE.write<uint16_t>(0);
>      OSE.write<uint32_t>(Imm >> 32);
>    } else {
> +    if (Opcode =3D=3D BPF::JUGT_rr) {
> +      const MCOperand &MO =3D MI.getOperand(2);
> +      int64_t Imm =3D MO.isImm() ? MO.getImm() : 0;
> +      if (Imm > INT16_MAX || Imm < INT16_MIN)

Shouldn't that be:

  if (Imm > UINT16_MAX || Imm < INT16_MIN)

?

> +        report_fatal_error("Branch target out of insn range");
> +    }
>      // Get instruction encoding and emit it
>      uint64_t Value =3D getBinaryCodeForInstr(MI, Fixups, STI);
>      CB.push_back(Value >> 56);
>
> Need to generalize to other related conditional/unconditional
> operands. Will have a formal patch for llvm soon.
>
> Thanks.

