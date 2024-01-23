Return-Path: <bpf+bounces-20074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA91838A7A
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 10:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560C81F235FF
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12A59B72;
	Tue, 23 Jan 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dI0orKOZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hemau2Jw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B858225;
	Tue, 23 Jan 2024 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002872; cv=fail; b=UPluudyTNjDMQXarcqg1o+adwdiL1VgvjY9qd8B0d2Zh4XEjjnuaAnpOpApe6RoeIVWJ/bsu6JAhrV+8krqzz157sZSQY8D4Njawnx3+3E5sWPTHDKn4GNkx1daKohxLWtm/2LX2DMJ5niiSNT3+kVqQC9FZhCCaeCLoDx8vA/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002872; c=relaxed/simple;
	bh=jSKHJUK4js92WrLCmkVZfu1k8eM+VqX2oqILlt9dKRw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FeBQ1n6h8ukz2FKMTxd4Bz9lPjYPDi0iZF82Yc/bm6EzOLkOzC3JCk6/+yw12YgTppttUaVvx/hWdWK+xgnsco9NFAz+BXgK1f8fwa984x3MEObohk/SCHwDuIC5cNC6x2hLTlon5Z9oo1SlMm4McqvG62227swZ8QD13dCnElo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dI0orKOZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hemau2Jw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N6Yv6L013734;
	Tue, 23 Jan 2024 09:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=12s/1PgbDHB+hnaLn3dRDyWjbe4VlHehWtBlhBZ6p1M=;
 b=dI0orKOZHkUBArptMiJL1T59MJv5yAQ3DRGk3IrEa+YVR/I8foLEOPw09w+sLU7XIl8G
 wQ8KkLzuq+TU1dyZpoJ4yjTJlqX33fOgZlF0gtDvORTlqRwXGsZn0th/GGh4gdjNESqR
 GGwxuHyad4Gtn8gyApn9j9wE+1D7owwXKX35Fm1S2h6Ilm22KL29vJAYYg33KG5vFkq9
 fnsMMkfQ6cbqlxdas0NBeJlFKGK+8LRJt6tU4lyGElQHQahBsWM/XECx5Qc7/JWjmtzo
 SLeEU2Cck1pCefqPTd4agwcAxcyC1TeLhN2LOv2ycp0ZCKtYwSe9z4hbtKP2wMm77mO4 Xw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cxwqjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 09:41:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40N8iKw3018715;
	Tue, 23 Jan 2024 09:41:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3150uaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 09:41:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlAPiQH7eSGDNnkOfV/VYab+xCFTO+Ygdbl9/9DfwtH/OhWMb6iR125ETLVwZasJbzQB8xJ04RQhaVhlHoeVd3u2W/KoljlQIq7RtIaWt3mBTD+lQZOS2IWuV5ROkwPvWbKFKgZOfcb0wsRvmA1rDa2zrDdx6CvyyYGX8tfPcM6XU3rOpV0elz4OclpgyjcFsWbsR2gPTfP/9Bu8HzFIOA0Z2lZQnz+jQLMU8ulqUORgWCxz2/sFNsFGndlTbOFDwAti88ocq8RiS2dQ8vG73eUdxR9E/vYYt5gumGsr1MJRWIHXPQGnf2jWtgsZt6Bhe8cv+4fWWhf6nk3UaCpTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12s/1PgbDHB+hnaLn3dRDyWjbe4VlHehWtBlhBZ6p1M=;
 b=NW2xMgQJP3Y6jRPcMZadPJNCBvJnb3WsFwAcv6L8Gxo9QTcqxu5IaMiBFQ1xGjU5rhcOXm71o39h4dwAYbbGB4n/shfXK7XD1C9cGs4RnLQQc1u0fHa+WKsJRYi/gSzfzmwkFcP2nef+Gu/JbEcAjn3Lv+xc1rZXCfryg7iaXhr8qy2GXNLMx3fYxaflBHg5J+MWKWGKLMrTu1XyMk7CTGPmwpTMorjgVa78f4ZQpxlYQSWgeT2PPIfsKq5oCp9yi8wcso8EMhGUrHjTMErel1cceAu6ZXw+6p2Cb86OdYW0F/7cM+SF5Y6JEBHD/1hjPaWLwfxHzvObiZmP5kopZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12s/1PgbDHB+hnaLn3dRDyWjbe4VlHehWtBlhBZ6p1M=;
 b=Hemau2Jwf0kecDEMyQnB9FBgtcix1Lr+X0yxPgY29qMt8ca8/Bda+veMaJFoTDmchoBcw7uBx0jdv8K73eikXYBVejL5BEPK4eJ0BNgMwov5HH3TRHVbHN7dxHSbntXuTg7iBr0i8TQZRhIKcs0bXJQ1SOm1I6T70frbFrkSG9A=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 09:41:05 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 09:41:05 +0000
Message-ID: <f4d8296d-dc7a-509e-aba3-741d22f889dd@oracle.com>
Date: Tue, 23 Jan 2024 09:40:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Better error message for kernels not compiled with BTF
Content-Language: en-GB
To: Ian Rogers <irogers@google.com>, bpf <bpf@vger.kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
References: <CAP-5=fU+DN_+Y=Y4gtELUsJxKNDDCOvJzPHvjUVaUoeFAzNnig@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAP-5=fU+DN_+Y=Y4gtELUsJxKNDDCOvJzPHvjUVaUoeFAzNnig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 44797beb-1cba-408c-b8b8-08dc1bf76b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lG+xzaUF8n5jW+uoUSS/QV7Tv6cSAOMbiERa5e4BYXLURfxP0TEp9/EOhFzR2MWBzHUuJ4phkqIBLgdZ7f5Wu4/v8agFHTpwXbL4Bcgu7GisyKbXE+NtbsFU2PttySkSay6HlrRxrEkqvWNrtsQAExmf4q6KM70v2Pgi9mqPYE5hxI5EQB/mDrHYDC/CvH43UGwlG+2sP49wifUrMSNYgz9bAsZhLW0IeYCP1h9/tqIQfCAw7pEodI2K63qsmu1/lv+sHc7+c2tueSOi/upjVG9jTfwkEYcy0431AxSycfJKn8POo2V4wTpl1tuvmFfoLq9/lwnLOLwkR7rQbxjrh0kyX36eYKo5XRrZ1Z7faIvjxGKl9EzknkzvuTPj7azGHjjy8eoECmoYF5UkWoKj7YAkcpKO15ovI5c4wj004sSZrr1a1C8NrhUucrUuogBMNVxfmdkSceRMOC5Obi4J8OiaT21ZQzJSIMZQw0J6YtG2o56ZbJdis3b/fJ0PxKx/tXpis8Pf2y3GJopqc2Le9UIe1BL3/Hd/AK0QF8xGqmP8mQ4UkJwc3ubZne2A8V1z9ADn5JUDdyFXMRspHQ6hpGCVY6QYpSX/ufc4VzrmW1r4s1GMbPk+NQu2dBbl0eULKUfyOjTO1v5rGM3sijph5g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(478600001)(41300700001)(31696002)(86362001)(36756003)(38100700002)(83380400001)(5660300002)(6506007)(316002)(8936002)(4326008)(6512007)(8676002)(966005)(6486002)(110136005)(66476007)(15650500001)(66946007)(2906002)(66556008)(53546011)(2616005)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFVjUU1wNER0V0lkc0FZY0c2SWgwZFFUTjJhNFlaR0tsTWo0NlkyWnluYVBU?=
 =?utf-8?B?OHMyWFZKU0I0cnVRWUZUaVBnTCtSZlhJRk8vZWg2SXZlRngxTU1XRytORjZv?=
 =?utf-8?B?K1BrZ1pURFZDZE9MVU1wNVByQjRSRDRreDQrNmpIaVRFa25rOXhqY0kwbHhP?=
 =?utf-8?B?MlpFbWR1QjY2d2s0OTRrcWhZVjVzN05kd25GekZGUW5STTUrMEFkZE8xSDdv?=
 =?utf-8?B?QkJDYU9RQjVzbXRFTDk1bWRtcDhCVlJwNDdWS3ZtUkphYTgwdFBPVlA0RzRo?=
 =?utf-8?B?TnZsVkVKMWdya0Q4MUh1b0Ntd1lHMDlMZ2x5SHcreXJ6c2RXYWdQOExxelY3?=
 =?utf-8?B?amJEaUpUdU9Ed1kwVHp1VUt5azZCMFZDSHIxZm1IdUxSTFVEbnNNVS9HVmVk?=
 =?utf-8?B?ZTRyNGhsalBjaTJibmhpTHJDV0ZkR3ZWS1ZRZkl5Vk5WWmNFTmpCUmVlUGlU?=
 =?utf-8?B?ZGoyZEpQdTdsUUtYWC90NU1Xa0VmQlRIMU9KdzIrbGRrZThGWFZxeDZXUmE3?=
 =?utf-8?B?a1hJWjZHNEhlUzAxOW5jMGM5WWNFMmE3Yi8wRUdWdFpoTlVBcVcycjlUdHEv?=
 =?utf-8?B?K3doYkdnVUVOdWdWaFVrZlVucTdEaFdPZldkL2RZeVU4R005TWpHYm82cUl3?=
 =?utf-8?B?M2E2cVorV0UxOUl5TENyRGxQMnQwVm9xNERFbzhhN3FxTlhGN0I3TFBGY0Ez?=
 =?utf-8?B?c2labGdoODBRM0Q0c1RzN0E5Q2haYXpKNWtDSUdZUGJrdVNMN3ZHWFU5c0JP?=
 =?utf-8?B?eXpoRldtY0E3eFE5U0k0UWo3SEtnSlZDbGF6OHhjcjYwbVhpQ09BKzNNWEhG?=
 =?utf-8?B?aHlENEs3RG5PK0xycjR0aHd0ZFoyN3ozdWNJSDFnVVp6RFV2ZWhYYkZ0SVJL?=
 =?utf-8?B?dWZPK3UzUVh5Q0VsZFp2aUN3M0hCbjFiZmZJNTgydm9BUHdDZVlXdlJZMllW?=
 =?utf-8?B?b1dsQ2VOT2VtSmk4bGJVaVEzZUsveGlweHBFVFU4ZDZ3WS9RU1hqOSs4MU1T?=
 =?utf-8?B?dGsvYWtWeVMwWm1Kd043Y3BnUEdwQ0FXaXFEalJkM0pGUWJyczc3cGVHUUtT?=
 =?utf-8?B?RnVDeVUrWVBoZlZ6cE5nYXJ6ZlRaZS9lV21xNFduRUV4Qm53cGxEN29VOG5m?=
 =?utf-8?B?bnovUGJUaEEvWHRYZjNRRmlrcmJlSkU3V0VrcmdBR3N4L1R4ZHJDU3lIU3Y3?=
 =?utf-8?B?eGM2aDhsT0s5K3JOc2FKZkd4UjMvSFpCbmN4VVhFR3YxVm8raXhCT0IvWVFi?=
 =?utf-8?B?TFZvdjRYUHVwdHE0M2E5UjZlWENvZTJZU0ZwMjhZQ09vRWZiQ0h2RkNpOU10?=
 =?utf-8?B?eDg1d3lneGNkcnZONm5RNGtIakdrOVlRK3NxYnNxY3RKdXZxSm5heGg5RTJK?=
 =?utf-8?B?UTZ3VmdVZVRXQ3hKK05mVUNzYmZIUjVhU3FUQWcxYVV5b3FDTk9aUWpOTzRW?=
 =?utf-8?B?L0dxRGdQWXJkY0NCNlE0SGRuaDdsaVVkWVk1QnU4ek5xWkZUSCtpNnFDbmsz?=
 =?utf-8?B?dG1mejJiZ1RIN29zTEN4WEZyV2VvajNaaHJOYnZLQUpGUGQwS2pyMlVEbHhz?=
 =?utf-8?B?YXEzNk9WYWNVejdoblZIMkhQbHdpa1RCWDJIWnZOTXhIdTNXVU9GNDZVMzMz?=
 =?utf-8?B?Rk13amJ5N20wc1orTUJtK1hURU4rZDZRYjRxY0JlNkxxc0p5bGU4RktBbEFS?=
 =?utf-8?B?TXFIdlVEcVhzSWVhN1hKNDhacWd1L3dWUjdtbWhLdlZkb0ZWamtpRTl4RERa?=
 =?utf-8?B?UHAxUnF4YTBWYjdYcGZ0M05MLzNaNU92cWFPUXd3YWRuUnpwdXVOWE1VSVhs?=
 =?utf-8?B?Nko4UXh4RHNyT3lodGsxSENIdnZKaFk2NlkzVnJUREtMbFZBd2RHNGEyRFZP?=
 =?utf-8?B?aHNGei9tWFV3VGlER1A0Y0YzOFl3U3VtTFRJaFBTejhoWDFSamJTdmNCQlFK?=
 =?utf-8?B?bXVpQzVOT3FxMGpJODhHV2ZraGNNUUx1MERlSG9wU1lFd2JuQ2JET3BpK2lD?=
 =?utf-8?B?SG5nakJNSklKUGduZUE0QWNlTHNhT1NvYU5ZQk1pTndhTm1udWNNUUxwajV6?=
 =?utf-8?B?TW9nalVVZU9XRmNqMTF0SUQ1YWZOWmJZODUzUWNNQzFQeVpxZnBZVncyU2ty?=
 =?utf-8?B?Y0JkSGV1ZTJ0b2pRSG5OSklac3FjcGREdmpGNEdJYitKa01GdWk4SGxTRWxZ?=
 =?utf-8?Q?9ceqSH1QkvDYzisDUi88dh8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uMwZt9zSKoo14ZpkU/sutgUySFPoDotXFAh9O6J6p+AEvLwarYeZHLXe8cm1U2L/apEkLyOgrPUzMSp0hjAqaQ3cpOKaLVciPsSwbrqlgQjJYbiAHzwWlkdHgkwDJW1q7Gc6DJERnKR6SeN+8YretFOE0VRONE8BeiCAU5nmu7xzlWbDrrXaywSmVmYcp+d24T4TO9hiiMbGkou0Iyx96TysG6nOfq5Owa3srrOonhv6A85XmxFkGLiypXsVU7EER+m21iqyf8TgnEayR+jTvC4i76LN6e3t/+g2KLb/GAQBVS5tFG+Grl2hcsy7+35Bw33OHU8UaPeLxN+HBMkofDPIWM3JFKvGUQUrH7SdLog4vwY1s3IiXkCn53wR1FYBAP729YNSbiGFC5DyTUSeUmkRWt13MNA0pnId61Tm6ucOy1RzDtwF8uiA8hE1SXnnqAao3R6Fk7SlgS2bfI1qefVwxoz+7N0XhfHEzYX0Jc98atq60rA9RLdp0yb/ULtlH44PpPo92U4VKtsQtBJ7APvFhLaryjG//BSDiTwA5ALXyo2VyWtvxr2/QArgSrsTM2G4etYCEN/fnd0InOniVKmsd0Gvj9yHDSlRFd5WkbE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44797beb-1cba-408c-b8b8-08dc1bf76b0f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 09:41:05.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5tBtOBRNgbd1uCESjbRbZ3wcyxGMxn7QwqNUrC/hwX+KcCXpxE29Fqf44237tVPxzf9jy6QfAd5rP89gUcUUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_04,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230069
X-Proofpoint-ORIG-GUID: g3K886w1gFNNuCAcrAwCyyY9C0gq2BEx
X-Proofpoint-GUID: g3K886w1gFNNuCAcrAwCyyY9C0gq2BEx

On 23/01/2024 00:18, Ian Rogers wrote:
> Hi,
> 
> if a kernel is compiled with CONFIG_DEBUG_INFO_BTF disabled then the
> libbpf fails on perf lock contention with:
> ```
> libbpf: failed to find valid kernel BTF
> libbpf: Error loading vmlinux BTF: -3
> libbpf: failed to load object 'lock_contention_bpf'
> libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> Failed to load lock-contention BPF skeleton
> lock contention BPF setup failed
> ```
> The same error message is seen with BCC's libbpf-tools. I saw these
> messages on default Rapberry Pi OS that is derived from Debian (more
> context in https://bugzilla.kernel.org/show_bug.cgi?id=218401).
> 
> Given that distributions are shipping perf and libbpf-tools that
> assume BTF is enabled, should CONFIG_DEBUG_INFO_BTF be enabled by
> default in the kernel?
>

That would be great, but if I remember one issue with this might be that
CONFIG_DEBUG_INFO_BTF depends on DEBUG_INFO (for the DWARF generation
that we construct BTF from), so I suspect enabling debug info by default
might be an issue. There has been discussion in the past about
supporting CONFIG_DEBUG_INFO_BTF in the non CONFIG_DEBUG_INFO case
(by temporarily generating DWARF then stripping it or similar).
What most distros usually do is strip the DWARF during packaging and
create debuginfo packages, but I imagine users who build kernels
themselves would want similar support if they were asking for
DEBUG_INFO_BTF but not DEBUG_INFO.

> Perhaps:
> ```
> libbpf: Error loading vmlinux BTF: -3
> ```
> Would be better as (especially if the user is root):
> ```
> libbpf: Error loading vmlinux BTF: -3 (was the kernel compiled with
> CONFIG_DEBUG_INFO_BTF?)
>

That would be great; one thing I think would really help users would be
to distinguish two cases in error messaging

1. /sys/kernel/btf/vmlinux is not there at all; for that case your above
error message is great (-ESRCH case)

2. /sys/kernel/btf/vmlinux is there, but can't be parsed, likely due to
it being built with newer BTF; the current libbpf being used to parse it
cannot read it (-EINVAL case). For this case something like ("BTF is
present, but cannot be read; it may be malformed, or the version of
libbpf reading it (%s) may be too old", version).

Having solution-oriented messaging for cases like this would really help
users I think. Thanks!

Alan


 ```
> 
> Thanks,
> Ian
> 

