Return-Path: <bpf+bounces-9510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7643798902
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C873281E8B
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7715A6AA4;
	Fri,  8 Sep 2023 14:40:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33135231
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 14:40:34 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9251BF1
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 07:40:32 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388EaO6R002800;
	Fri, 8 Sep 2023 14:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=yzjkv9jSUO3cy3eiorsmm0EcPqdzb1euluKT5qTNy3I=;
 b=pXHYG3dVdLW0pqbQyYJL075TJHcH2iS0uAnWXEgWL+Tg7uCXDI5EcBnNSLOcjh47C9ob
 MpP9smI6pXCDRN2+GFpPriHhej3oRHkQDSYSopw9eHUnXFxaBTH0eDlKwnF57PAtdw86
 f52mb/lVUxe7L7f7SdhW+DIKKdFfuBg7Al92BJvE43Q3bIZGU92H1l6VSDfxLCmMI8mO
 f7uY+nOzTeITUg7szbOuVVNO7ufI1rotNK0CwOcW5/RVWI8e3qjcLMfjyL9sRbJxtxWh
 nd0aF+Jo3PXKzVasTviyBdrkMe8JoDRc3+eZjdzYxJ+lLIOxE/QslZQN6SbveVs1Nxse 1A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t05bng1km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Sep 2023 14:40:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388EZNk2030480;
	Fri, 8 Sep 2023 14:40:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3syfy1fqmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Sep 2023 14:40:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht/t9DpMdPAgAnQD2Bkv1rCx6NP/v/FsuiKOyG8GlAPWXMLV94q3qzfAQJwgZeanfLZrKgA0Pn+aswjE0wcDC55CqBasOFUk66ZdYivjkdK49YbQnRt/8JsWIZuj/77JFrBEZpRuFxfWVOJzAQQWrGZb43K/F4zt2fWTtpy58sUmdp0ul4nZhZVhFUkKIIEdaj+2NYHqvg6jedBhUUzl8qd1Uzv0hFKwg2MBzkWIkJF7neUNI0NmFS22TEZQjKiqRzdeydHq7GlCVjFTEnP5/Fm2bAEX0CkVCik10oK0elE5Mm4Be6wkJ8GeooYQ3SX7Te01dsciv9f5NBLt+rCZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzjkv9jSUO3cy3eiorsmm0EcPqdzb1euluKT5qTNy3I=;
 b=FTpG1lt64Q+bjf9f935ge9e9oWgKQZBHvUcV+Zs36FYeoRVEemlgTYkA9+XyR7IN0rzbMyzFu9ih1S+AzkDDqWnsWIevtRBReiNmjhgkPqDb6RVh8F0+i/T0iZBnllmrNbx6doDaP/TlJQ/9Y+82CNskYc45wUWkmYtFPqTHDrsUPAEy5z8zr1GMJwgFIrV8NAOSVTUf+lNezL51uAxFUhCdLKdQxjBNI797dztCELDywA4iuM0YildpQqxx9FmcsYMspHS97i4NnswiKAfGOBLuA+zp5VqECDZPx458+0ff4XZ2wX0OBI9yrRtvF7iV7QFokU7sSTu3qqxbRWsE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzjkv9jSUO3cy3eiorsmm0EcPqdzb1euluKT5qTNy3I=;
 b=F9lnQIiiNj6QXyEqJCWda7BT7x8pUIwwvSsCXGwcOna3tzF5AbtS3SDm1/0ESmzpdZ+CgJPHlZaNUcZovjY3gonTo6LtENboAiC3D2l/LF8gJhVopf9xJfVNtKBWubabzy4PTHwXBP9N6MPEzEC7sjIPUCKq9M6NxGHhd53Zj1A=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN0PR10MB5984.namprd10.prod.outlook.com (2603:10b6:208:3c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 14:40:10 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::7ae6:dcdd:3e38:5829]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::7ae6:dcdd:3e38:5829%3]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 14:40:10 +0000
Message-ID: <aeec58b4-df59-c424-da1a-2fa8cb108e54@oracle.com>
Date: Fri, 8 Sep 2023 15:40:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add tests for symbol
 versioning for uprobe
Content-Language: en-GB
To: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        olsajiri@gmail.com
References: <20230905151257.729192-1-hengqi.chen@gmail.com>
 <20230905151257.729192-4-hengqi.chen@gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230905151257.729192-4-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN0PR10MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: e0141915-705e-43cd-4501-08dbb07980fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nQqkDz0ZyqWKYqQ3zP928MH29V2l6jdfL9VIVYhTmWqY1nmae7QFjr8gnfSd0V4URff4ARv/mSyIHcWYanoce4fIOcIoXm2efmsivjc90tVF81Hbey7PFJP8FT3it1UT8drF8x5DOTTRa2lju3Msbdl8C6qB3D0VrWF9rv9zMwnTS8kzqHWhIcUL86hS2uLIdAnNGZ4T4f8txufn58N2+hl3XIg+evGMoOM75Q7DYkcWX6keQMHAGYIafF4wzFA6ICEB4Kuo1zhfscoQU2EOFy8jfEW+a456jPCiozUQwEim2GpQevyp2Lo3llvEba4HCUN8jmpQ+5dZDQ7lDGGMrS/DgduBAD0V3xT9Oaxn0VcnH+E09gr5VUwc0X3PZf7wmE/S4z7E0qjufVtih+cOIYB9aeVjPz/4r/mvqcyAAArXwbrF10GBylt9TV1uPqIb3UyXDN4PvAqUXfEBR2q+cDZFV3Q0vYl+FEBcB8fBetPnl8uTeeJXckAa+5VPqgFhJydmHuPzVEZhdLE/Y/7onvljA36yJdL2jvTYoZANhJOJKqZcRkIVp9ZM8Asg+n0kBnaw6K1PwXM96FfvlZWDdUhux0SDfeXgupNK+7yJ5TWvFanbsmR+CbhPNtjCijs+vgDXHdrFqzf43LzLwMhpqA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(186009)(451199024)(1800799009)(44832011)(5660300002)(4326008)(6486002)(6506007)(8676002)(8936002)(66476007)(30864003)(66946007)(66556008)(41300700001)(316002)(31686004)(478600001)(2906002)(53546011)(6666004)(6512007)(2616005)(83380400001)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eEp6M3hVWXFzYS9RZFVoUlRmNzNHaGlDRjRDTmFJUUdBYWxXaVQ1YW84MXUv?=
 =?utf-8?B?bUFzZStmTEF2QkNmamR5VVRnR213MG1uSkJPYUJjVlI5Q2dzaFIxZFRyUUZw?=
 =?utf-8?B?THgyTXJXTHN3RWx4T0J2YTVJVE1GTHo3bnBEOExVL3VxeUtMU1FUR1Y4OHhr?=
 =?utf-8?B?MklpMGVXZkp0SWhxdW1GaHlZTXBHeTJzWjBiY2l0THpkUWlxU2FzVTNMZ2dh?=
 =?utf-8?B?VGtacnM4bXZ1azl5cXdnVk1TaWZNWFFZaHVrQktNcWhydDlOS0NhbEZhbEtS?=
 =?utf-8?B?aUpZb0FYR2xPUUdSNDdsMGxrbGpzMTMrV2lJM3VsNGk1UGJnd2l0ajRFeUwy?=
 =?utf-8?B?ZStiT1dqOFVXb3RFUFp1VkFYWm8vNko5Mkk1eWowNEVJdms2UXJ6TnpCdkZT?=
 =?utf-8?B?bU4rYWN5S0NTZFlaeEN6Y2JrR2JGUmFtbnkyTWxEbXZZQkhLM0JVam9PdWZ0?=
 =?utf-8?B?NVlDbFN5TnRjNk1ITkE2dk1UT1gyNSt1R0RheWprNTVTTHRqVEd3WmIydXBu?=
 =?utf-8?B?VldaS3BKbG8vUHZNQVZac0xleHAzRjZKL3I0aExLTEwweWhWUGozL3RUWEJW?=
 =?utf-8?B?WjBZaE9SMTJ4L3ZBdS9aQjJlNEdyOFl2eDZsMStzVDBTTXBSSjFnVGxGL3hW?=
 =?utf-8?B?c0JjN3dmS2YzUmdKT2JaWGRMTFhwSWlUNXgzTkpXV3RRcE4xQTlYeENGMk4v?=
 =?utf-8?B?QlRNRkNKVzkwK1lyYzFVU3FyektwL1d0Uld1YjM2cVhtWFNtaHRzd1FSOUVx?=
 =?utf-8?B?MjBDanIxR24yczRIbHlWRUFjYUdTNFFGK3FRVG9SVmNPZXZqcXdvNDhJZUJp?=
 =?utf-8?B?TlQ2Z045QjVRczVQU3BqcVpacXN3M0FVa3ROeUdneHFsQTUxQVprN2ZlTVNU?=
 =?utf-8?B?YlFCMmlnOVJObEFJZExNOUhoNnVmaWh2UkZjY25WNUMzWXl4OWc3S202SmtN?=
 =?utf-8?B?WXhXaXJXNkEvNmN3d1BwVm92Ym1ha2NuUXcvMTU2dkw5dHJVbUY3NWdJaTUy?=
 =?utf-8?B?VFVoT2VmazdVZmY0dXdLZ3lRUkxYc0lVbEswTkRGZVoyVForM2t0ZUlTTFV3?=
 =?utf-8?B?K2FnL0pFaFlIdndHYUUxQ1BvMVVWOUFxMWIxNUhjV0lTZEpveXRkK3lsZFkr?=
 =?utf-8?B?UHloYm9iWHEvVXM5clp5eGF6SExkcm5XeVZ4WGdzeUswbk5xNGlZamVqMm9H?=
 =?utf-8?B?SVBvSXUzYXdlYXJZcGt1QTdSVVFNZDlieXZEZlRMRVJhM1cxamtjdTVybzFm?=
 =?utf-8?B?MzMycmcyT3R5ZG02UUF4NEtlcVl3RlQ3bUU1UEwwK3pVU2JUbGFYWmdxbUxl?=
 =?utf-8?B?Zm1WenAvekVtN2xJKzNWM3IyMC9iQUZEQVpQOGZZMmRMSXB5QW9tYUtzckdL?=
 =?utf-8?B?TW0yT1EvNm9Ic01kNXlqK2xqQnpIclhPR2NwSXlqQklpb29RMmpwcWRFNFRE?=
 =?utf-8?B?a0FNQlArdm9OeThRRzVVWGEra0N1SHVNQlM2eHpWZWw3MEYySzV0aDRQa01Q?=
 =?utf-8?B?VEI1ZW9INnVPSyt3ek80N25xL2c3QmcrRnBUU05IdFNWRlFWS0xlMG9BQi8r?=
 =?utf-8?B?S25TQkNYUWRpMXA1MHFHYnVMcGVCQUFRaEFEVUxkMm8vejlKNnRRQWdFb29V?=
 =?utf-8?B?TE9yV3NFaldyMlV4WVFLdHMzUGI1TlBaZTYzWUIya002NTFYVDBhYnVscS9r?=
 =?utf-8?B?T3AybTBUVnBrMXFWUDArNUVIM3VZdkFGejJ0c05ETUh3TFBDSUR0WW1pZkd3?=
 =?utf-8?B?ZmQrTXFlWEtWOGdjWGMwTDkrTHAyaWxOTndtQVlGUC9UbTBPU1NHaFdmaUs4?=
 =?utf-8?B?VndleHE0LzZybGprbmNKbjIvRk5YV2VaY1RZbzhzZDVGajNsTkhmVG9CMFVR?=
 =?utf-8?B?enJLRmFHajRldkZoeHRTeXdwTm0ydEpMa3hXUUtTOWFON1NCRkE3U3hZOEx1?=
 =?utf-8?B?emhGbCs4RVA4MU1kMWZwM3pURjZlaFVQMStQVU52NHMrY2t2NW1CRmZ1RWlE?=
 =?utf-8?B?RXNjWWVPN28yZ3AyOEphZWQ1WVpDQldPbjFFMEIvMGhyNGNjdUN0OFBESS9V?=
 =?utf-8?B?TEtwMmk1RFFWZ1NYbXZBc3hSL3Z5REJaS3g2Z2dSVTJtQXU0RkIwYTFlZ3Y1?=
 =?utf-8?B?QlhMMHRibjVuOU0zOXRVMUR6a1RCK3hVcEJCMWlwbG4vM1dLWkJ6bmFkeXNF?=
 =?utf-8?Q?lkf/WYmhsv1rqB09HXSGIqU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RtNHtHIKJykOSFQndqx09NioQjd6rt9eFWAOPOQpPz3MPXjCgMk9jactk/ZM6IWeB5glR7hIEoWrGOOj5tnOF5yDeVbEAXdN+nC+Ny0206wyYgD+mRRDze0K67BTl7t7OGPbFDaGj87gtWG8Y2qzYHDhLPcXvMQCSXvqnbYaEgBeonRR6tKLZiqGDGoaOEAJYG9i9nbEbBMdXSI5cYpl0AA6Hok96we6P5JiMeTozIys4Tp6mpo61KHMsDcYdBxohjMm9qcfXLi+GyfBIEXJW9mALjcqIOUgTT4u9VZ3PcPenHOCYS0zDBzol9EarWGSIW6todyq2tnPyAHBs92/2WvQeCcsy4Kzf32Om4oSeVd9MeiXD5z6Xh1dN+diNpjtfvh/dmR6urse3ZJoUlqRJTmTzhIzIUvjgBc7vsur2LsMBWGY6il89Fw7K0o+qaqzw7XDJAvPYJYoLjFIBHlTYGevY4oPlS5AaBefin1LhGa22wVSit5EhAPt9LnYv7t6QX1ocEo2ndmbt8mreOECFnc0HqgdsTHyqeqPTkBL03geOOUWMef+QZTAJxXKOIBRo4YE7tqIM/254oKUWiRwSvfTY8Sbc1FzgORwMSBE17R2UEtdk4JfhLgy2nr9TG87aCaSPz6AUFUxU6t3fBuYp5gc0SQZzis32Rm/Wm9tNJjYgfXlRkLWT0wjMF7Pm4rHo5JFMGa4hoZw18S8I0OZ8O5GmlpC/HqCG0DMGWHaVLsyPwJNinsVsnmqDQO55QPCeZWgHULjgULYtw2QZLdbE3/CSQPTpZWcXxlCvmkI7CgnTATLjGJ0BLHnyRb3xlHW3cl8U51GiP+/PQtvd5kjWYQSvdiEoQe3LKjRS2EZ2y8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0141915-705e-43cd-4501-08dbb07980fe
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 14:40:10.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeSnKjKcgWQZYUY5TvPwcsDa3bsnHM0V1Kk1PHzVEKMC57o/SDskbgkRFP43q4oPtsoK1kp7RQuqMq2R3DeRSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080136
X-Proofpoint-GUID: HGJbkCb8JaLle9BWjq-72-E3EW0rjOMt
X-Proofpoint-ORIG-GUID: HGJbkCb8JaLle9BWjq-72-E3EW0rjOMt
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/09/2023 16:12, Hengqi Chen wrote:
> This exercises the newly added dynsym symbol versioning logics.
> Now we accept symbols in form of func, func@LIB_VERSION or
> func@@LIB_VERSION.
> 
> The test rely on liburandom_read.so. For liburandom_read.so, we have:
> 
>     $ nm -D liburandom_read.so
>                      w __cxa_finalize@GLIBC_2.17
>                      w __gmon_start__
>                      w _ITM_deregisterTMCloneTable
>                      w _ITM_registerTMCloneTable
>     0000000000000000 A LIBURANDOM_READ_1.0.0
>     0000000000000000 A LIBURANDOM_READ_2.0.0
>     000000000000081c T urandlib_api@@LIBURANDOM_READ_2.0.0
>     0000000000000814 T urandlib_api@LIBURANDOM_READ_1.0.0
>     0000000000000824 T urandlib_api_sameoffset@LIBURANDOM_READ_1.0.0
>     0000000000000824 T urandlib_api_sameoffset@@LIBURANDOM_READ_2.0.0
>     000000000000082c T urandlib_read_without_sema@@LIBURANDOM_READ_1.0.0
>     00000000000007c4 T urandlib_read_with_sema@@LIBURANDOM_READ_1.0.0
>     0000000000011018 D urandlib_read_with_sema_semaphore@@LIBURANDOM_READ_1.0.0
> 
> For `urandlib_api`, specifying `urandlib_api` will cause a conflict because
> there are two symbols named urandlib_api and both are global bind.
> For `urandlib_api_sameoffset`, there are also two symbols in the .so, but
> both are at the same offset and essentially they refer to the same function
> so no conflict.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

Great work putting tests together for this! One small suggestion if
there's a v3; would it be worth having a uretprobe test that uses
library version specification too?

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>


> ---
>  tools/testing/selftests/bpf/Makefile          |  5 +-
>  .../testing/selftests/bpf/liburandom_read.map | 15 +++
>  .../testing/selftests/bpf/prog_tests/uprobe.c | 95 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/test_uprobe.c | 61 ++++++++++++
>  tools/testing/selftests/bpf/urandom_read.c    |  9 ++
>  .../testing/selftests/bpf/urandom_read_lib1.c | 41 ++++++++
>  6 files changed, 224 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/liburandom_read.map
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_uprobe.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index edef49fcd23e..49ff9c716b79 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -193,11 +193,12 @@ endif
> 
>  # Filter out -static for liburandom_read.so and its dependent targets so that static builds
>  # do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
> -$(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
> +$(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom_read.map
>  	$(call msg,LIB,,$@)
>  	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS))   \
> -		     $^ $(filter-out -static,$(LDLIBS))	     \
> +		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
>  		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
> +		     -Wl,--version-script=liburandom_read.map \
>  		     -fPIC -shared -o $@
> 
>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
> diff --git a/tools/testing/selftests/bpf/liburandom_read.map b/tools/testing/selftests/bpf/liburandom_read.map
> new file mode 100644
> index 000000000000..38a97a419a04
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/liburandom_read.map
> @@ -0,0 +1,15 @@
> +LIBURANDOM_READ_1.0.0 {
> +	global:
> +		urandlib_api;
> +		urandlib_api_sameoffset;
> +		urandlib_read_without_sema;
> +		urandlib_read_with_sema;
> +		urandlib_read_with_sema_semaphore;
> +	local:
> +		*;
> +};
> +
> +LIBURANDOM_READ_2.0.0 {
> +	global:
> +		urandlib_api;
> +} LIBURANDOM_READ_1.0.0;
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe.c b/tools/testing/selftests/bpf/prog_tests/uprobe.c
> new file mode 100644
> index 000000000000..6c619bcca41c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Hengqi Chen */
> +
> +#include <test_progs.h>
> +#include "test_uprobe.skel.h"
> +
> +static FILE *urand_spawn(int *pid)
> +{
> +	FILE *f;
> +
> +	/* urandom_read's stdout is wired into f */
> +	f = popen("./urandom_read 1 report-pid", "r");
> +	if (!f)
> +		return NULL;
> +
> +	if (fscanf(f, "%d", pid) != 1) {
> +		pclose(f);
> +		errno = EINVAL;
> +		return NULL;
> +	}
> +
> +	return f;
> +}
> +
> +static int urand_trigger(FILE **urand_pipe)
> +{
> +	int exit_code;
> +
> +	/* pclose() waits for child process to exit and returns their exit code */
> +	exit_code = pclose(*urand_pipe);
> +	*urand_pipe = NULL;
> +
> +	return exit_code;
> +}
> +
> +void test_uprobe(void)
> +{
> +	LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> +	struct test_uprobe *skel;
> +	FILE *urand_pipe = NULL;
> +	int urand_pid = 0, err;
> +
> +	skel = test_uprobe__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	urand_pipe = urand_spawn(&urand_pid);
> +	if (!ASSERT_OK_PTR(urand_pipe, "urand_spawn"))
> +		goto cleanup;
> +
> +	skel->bss->my_pid = urand_pid;
> +
> +	/* Manual attach uprobe to urandlib_api
> +	 * There are two `urandlib_api` symbols in .dynsym section:
> +	 *   - urandlib_api@LIBURANDOM_READ_1.0.0
> +	 *   - urandlib_api@LIBURANDOM_READ_1.0.0
> +	 * Both are global bind and would cause a conflict if user
> +	 * specify the symbol name without a version suffix
> +	 */
> +	uprobe_opts.func_name = "urandlib_api";
> +	skel->links.test4 = bpf_program__attach_uprobe_opts(skel->progs.test4,
> +							    urand_pid,
> +							    "./liburandom_read.so",
> +							    0 /* offset */,
> +							    &uprobe_opts);
> +	if (!ASSERT_ERR_PTR(skel->links.test4, "urandlib_api_attach_conflict"))
> +		goto cleanup;
> +
> +	uprobe_opts.func_name = "urandlib_api@LIBURANDOM_READ_1.0.0";
> +	skel->links.test4 = bpf_program__attach_uprobe_opts(skel->progs.test4,
> +							    urand_pid,
> +							    "./liburandom_read.so",
> +							    0 /* offset */,
> +							    &uprobe_opts);
> +	if (!ASSERT_OK_PTR(skel->links.test4, "urandlib_api_attach_ok"))
> +		goto cleanup;
> +
> +	/* Auto attach 3 uprobes to urandlib_api_sameoffset */
> +	err = test_uprobe__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	/* trigger urandom_read */
> +	ASSERT_OK(urand_trigger(&urand_pipe), "urand_exit_code");
> +
> +	ASSERT_EQ(skel->bss->test1_result, 1, "urandlib_api_sameoffset");
> +	ASSERT_EQ(skel->bss->test2_result, 1, "urandlib_api_sameoffset@v1");
> +	ASSERT_EQ(skel->bss->test3_result, 1, "urandlib_api_sameoffset@@v2");
> +	ASSERT_EQ(skel->bss->test4_result, 1, "urandlib_api");
> +
> +cleanup:
> +	if (urand_pipe)
> +		pclose(urand_pipe);
> +	test_uprobe__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_uprobe.c b/tools/testing/selftests/bpf/progs/test_uprobe.c
> new file mode 100644
> index 000000000000..8680280558da
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_uprobe.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Hengqi Chen */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +pid_t my_pid = 0;
> +
> +int test1_result = 0;
> +int test2_result = 0;
> +int test3_result = 0;
> +int test4_result = 0;
> +
> +SEC("uprobe/./liburandom_read.so:urandlib_api_sameoffset")
> +int BPF_UPROBE(test1)
> +{
> +	pid_t pid = bpf_get_current_pid_tgid() >> 32;
> +
> +	if (pid != my_pid)
> +		return 0;
> +
> +	test1_result = 1;
> +	return 0;
> +}
> +
> +SEC("uprobe/./liburandom_read.so:urandlib_api_sameoffset@LIBURANDOM_READ_1.0.0")
> +int BPF_UPROBE(test2)
> +{
> +	pid_t pid = bpf_get_current_pid_tgid() >> 32;
> +
> +	if (pid != my_pid)
> +		return 0;
> +
> +	test2_result = 1;
> +	return 0;
> +}
> +
> +SEC("uprobe/./liburandom_read.so:urandlib_api_sameoffset@@LIBURANDOM_READ_2.0.0")
> +int BPF_UPROBE(test3)
> +{
> +	pid_t pid = bpf_get_current_pid_tgid() >> 32;
> +
> +	if (pid != my_pid)
> +		return 0;
> +
> +	test3_result = 1;
> +	return 0;
> +}
> +
> +SEC("uprobe")
> +int BPF_UPROBE(test4)
> +{
> +	pid_t pid = bpf_get_current_pid_tgid() >> 32;
> +
> +	if (pid != my_pid)
> +		return 0;
> +
> +	test4_result = 1;
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/urandom_read.c b/tools/testing/selftests/bpf/urandom_read.c
> index e92644d0fa75..b28e910a8fbb 100644
> --- a/tools/testing/selftests/bpf/urandom_read.c
> +++ b/tools/testing/selftests/bpf/urandom_read.c
> @@ -21,6 +21,11 @@ void urand_read_without_sema(int iter_num, int iter_cnt, int read_sz);
>  void urandlib_read_with_sema(int iter_num, int iter_cnt, int read_sz);
>  void urandlib_read_without_sema(int iter_num, int iter_cnt, int read_sz);
> 
> +int urandlib_api(void);
> +__asm__(".symver urandlib_api_old,urandlib_api@LIBURANDOM_READ_1.0.0");
> +int urandlib_api_old(void);
> +int urandlib_api_sameoffset(void);
> +
>  unsigned short urand_read_with_sema_semaphore SEC(".probes");
> 
>  static __attribute__((noinline))
> @@ -83,6 +88,10 @@ int main(int argc, char *argv[])
> 
>  	urandom_read(fd, count);
> 
> +	urandlib_api();
> +	urandlib_api_old();
> +	urandlib_api_sameoffset();
> +
>  	close(fd);
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/urandom_read_lib1.c b/tools/testing/selftests/bpf/urandom_read_lib1.c
> index 86186e24b740..403b0735e223 100644
> --- a/tools/testing/selftests/bpf/urandom_read_lib1.c
> +++ b/tools/testing/selftests/bpf/urandom_read_lib1.c
> @@ -11,3 +11,44 @@ void urandlib_read_with_sema(int iter_num, int iter_cnt, int read_sz)
>  {
>  	STAP_PROBE3(urandlib, read_with_sema, iter_num, iter_cnt, read_sz);
>  }
> +
> +/* Symbol versioning is different between static and shared library.
> + * Properly versioned symbols are needed for shared library, but
> + * only the symbol of the new version is needed for static library.
> + * Starting with GNU C 10, use symver attribute instead of .symver assembler
> + * directive, which works better with GCC LTO builds.
> + */
> +#if defined(__GNUC__) && __GNUC__ >= 10
> +
> +#define DEFAULT_VERSION(internal_name, api_name, version) \
> +	__attribute__((symver(#api_name "@@" #version)))
> +#define COMPAT_VERSION(internal_name, api_name, version) \
> +	__attribute__((symver(#api_name "@" #version)))
> +
> +#else
> +
> +#define COMPAT_VERSION(internal_name, api_name, version) \
> +	asm(".symver " #internal_name "," #api_name "@" #version);
> +#define DEFAULT_VERSION(internal_name, api_name, version) \
> +	asm(".symver " #internal_name "," #api_name "@@" #version);
> +
> +#endif
> +
> +COMPAT_VERSION(urandlib_api_v1, urandlib_api, LIBURANDOM_READ_1.0.0)
> +int urandlib_api_v1(void)
> +{
> +	return 1;
> +}
> +
> +DEFAULT_VERSION(urandlib_api_v2, urandlib_api, LIBURANDOM_READ_2.0.0)
> +int urandlib_api_v2(void)
> +{
> +	return 2;
> +}
> +
> +COMPAT_VERSION(urandlib_api_sameoffset, urandlib_api_sameoffset, LIBURANDOM_READ_1.0.0)
> +DEFAULT_VERSION(urandlib_api_sameoffset, urandlib_api_sameoffset, LIBURANDOM_READ_2.0.0)
> +int urandlib_api_sameoffset(void)
> +{
> +	return 3;
> +}
> --
> 2.34.1

