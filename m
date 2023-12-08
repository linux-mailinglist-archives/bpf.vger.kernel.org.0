Return-Path: <bpf+bounces-17191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D7D80A78B
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 16:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6241C208F1
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E28831A74;
	Fri,  8 Dec 2023 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GIQ0MOpf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LqWeOkuX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16120171E
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 07:36:19 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8EdEEK025974;
	Fri, 8 Dec 2023 15:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uX7Q2ad6pgd9oxEom1BRXxkmgZtgfbRltraldkwxtAs=;
 b=GIQ0MOpf4HhOPO/4coOFZguegu/lbqsVG7Uqof37+EMDAWc6JS0IaheEKuiIqi2X9Vms
 E+RK1BjGWYbGuXPhrW7GpTf4QqVOzbOitwhJ6EAPq2sQL+RIQyAuF89SKulMJyEh1CyL
 R5SPoNSXb0nY01lNefFkNFiEIP1l1vTPrM0mSn//F4OkW9+y6fPAP6fcRVB5kRPV9wiq
 V+x5VUHB12iYGxwz1iXOqaVTiZ7CzPzAbZFIKLSYpGyRm2ARhtn3bb0rGhNMXSseXE0T
 BC4XGEctfk2AlnkijGqzHJ/ZxAqHLQyYZXFnKJoahCN7dXzPiY4TFDO71e6HYVpwDbEU LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdda66qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 15:35:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8EF8CU040497;
	Fri, 8 Dec 2023 15:35:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utanf29hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 15:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne5qt3vFevLBgVA9+DCkr5pIBQucWyNOT2pesKZhzyd4i5fv5UeHvqmO3pe9IjAXdg1zmAY5z8ugdcGJo1Q/+sQGoexWQTcx/WjtKWJ7M2fGN/qKpdW1FYuzP4QZMe38bluSzTwUes2VE4tEk309AUinivLvbqoTejCgsrTTtvVRBQv0dnUbp40jdTlz6CZPq5SoEu3tj7GO9WyAQ1d3ZWVH4sPe6axCGCo7BNSTmFKLamDqdUG3Kv6Bw2stIRDssxZ8c3jT32Xaas+BinIE+9gZB4/2jxXaMBfaK89FdnlUOfIUaCaQxoEfnKlFv8YnqzadiUjajIIOTr3GLOB15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX7Q2ad6pgd9oxEom1BRXxkmgZtgfbRltraldkwxtAs=;
 b=R6I5z6VONEeMtmtuWYWZZXCZUbrO+UbKDLMnp+6Ldk/KknaRxbFOKEhvzjhnrO2CLxKGyaqXfwwXr2K8Uod1RTZtG50JErI1i+lVR+I9fPRbl2q8/IphO7u8E2XIWy/Nt4qE5L/TBlsBXz6Ei5RCCM3s3CrnC6Rm479HJSld9Dw4gbiB0xfdyWv6JlyY6wTX5y5Af8uw0Cv5HJV95qTlyl50UX4naD48YJcVEQ2azAhfXPO1p+gHLG9bg3mkUDN3ZV0Oe40I3vbQVygQ2BUkljG9rPVajfR1rjwA319YdzOVrU2WLUivA/JKoFgzpIMXxaV0iLsONGjWBAYyngb2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX7Q2ad6pgd9oxEom1BRXxkmgZtgfbRltraldkwxtAs=;
 b=LqWeOkuXgz9Pug0pTibrZQMBaE2izK6YgyMQhKXCVxU+08LNT7hnfs+CUf2EZcPWr0IEDF6OqcfWz0nO+nnKW3ePCd/xYZIfBTbuF4S7rH9wz7c3HWkTTt1wib8Cmt1Gn45fFsMCEmhYJBO+be2v7qDSThqCxATlUJ7zvG8KaBI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB6808.namprd10.prod.outlook.com (2603:10b6:208:428::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 15:35:55 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 15:35:55 +0000
Message-ID: <b8ae795d-b010-f451-38d9-8357da66a291@oracle.com>
Date: Fri, 8 Dec 2023 15:35:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH bpf-next 0/1] use preserve_static_offset in bpf uapi
 headers
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yonghong.song@linux.dev, jose.marchesi@oracle.com
References: <20231208000531.19179-1-eddyz87@gmail.com>
 <1d2a2af0-40db-80f9-da13-caf53f3d9118@oracle.com>
 <069960f88faa6740b9059ff428f7f209d8e8d6d2.camel@gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <069960f88faa6740b9059ff428f7f209d8e8d6d2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0477.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 1410524e-f1af-4eaf-2ae2-08dbf8035e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9iHUQOfqkFW8SEC6Sin6lIacw8oaSKcp3xJfoYH5CdLEn0owRWjNL0JYR3bcEpWFoHds3Sd6PpJ+ki0Kf3l2aX3VYyTKA2xq5Sfx8RlaoGmSpwownjF9CTj9W7kY/EIIoiubcS7iHcagR3tVkuPozUlCRJ9nta/MN/Ays/b2y0wgrwyWZ2IMQbOjp5gp4Z7e8EgDFOGZ3aUPgmRTZ8Of3YEI5W/NJNZA3Pfl6KjmpwacPbUYhM8HtYBuNqiQo/8C2eOWLbcRowq16N20VEwCB9mpB8R+9MzwE/d+IcCXxbbeGqwz8DVf7iZtNpqo0ILfmrAg9bMHqyPSmxZfeHqZXe5Yhset6x4vLBCvkYJDCbJTjcTaWoO3xG/XYOHQ00cbIEdfkMBphDhFVfBu7Kl7NVFf/yCbm4eNib8ReEUUFFaXMlwmamB21Mwy9sIuJOao85rYExC0Yx6BKuaLUUct0d00j++AH5eBwQkP/KCixuwB2jC/fgqJNqHVykAQZT02IJkIv/Xy5h8hnmZlAnH+VaTFWNzpvg5dVql8u+bPUr9MjosRnWMxfIaNmqZZWWT/HOeBoXKHD9lT6snJJvRB5rWEgRU3KWdiS7BwKpfqm7U15dqsY+BBc5oKDhLbm+lrFFINaT2zOWx1Y6AYI26k0A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(6666004)(6506007)(478600001)(38100700002)(6512007)(107886003)(83380400001)(66899024)(2616005)(53546011)(5660300002)(8936002)(2906002)(8676002)(31696002)(86362001)(41300700001)(4326008)(36756003)(44832011)(66946007)(66476007)(66556008)(316002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ejBURm9FNy9KWmZCNFNGZ1FZRDVmbGtCL0NEOENKakFvRm1GYktrejJJZlo0?=
 =?utf-8?B?L3N4OGRqSVNxZS93eE1pZktGN1g3VHRCeVhSUlh0eHVIcmRvVzhSenF2ZWo3?=
 =?utf-8?B?azhXS29OamlGdFpMeFZJTDc4QWZ5YkFLaDE1UXJRRXh5SVlyU0czaktDcVNq?=
 =?utf-8?B?T0J6T2dDREdEbWpnaGs5QXp2WldNaVRZWnV1QUltRTRJdkljbG9EYWdoTUxQ?=
 =?utf-8?B?YnNudGFXZmlabnFBUlExUG5BZlhQZ213aklRZXJTQlJ5RklzR2FWWjRHa0Zr?=
 =?utf-8?B?cTlZdmRHTjBlcEV1L1Blc3lQWmxxNTQyOGhVUkxtVDRLVGVNQ05jYW9mRy9H?=
 =?utf-8?B?UFduQmxiNjBTTlRDTGFjeTljMXR2TU82MGFiVVhOOGx4NmFnRUoraTlCVUlF?=
 =?utf-8?B?THRCb1RoZ0NPamxpVCswQkw1ZXREZEJsdDFyOUNLUytDMzU1QXFiNEJLV2JX?=
 =?utf-8?B?RGhnUkN5bitmdEpCbnN1TDdaT21uSXNZYXg0R0JLSWZNL2dIb3ZmL09aVWxD?=
 =?utf-8?B?dU15MlZGbndYdVNZZGdibXZVRzRtbFpFbVRxbGIxK2UrWVVualMzc3pEVDU5?=
 =?utf-8?B?alF4TmlvbWxWeFVXMVlNeFFjVi9RNFFiUVlNYmF2R3BGUzEzaytJSDlHWGoz?=
 =?utf-8?B?TG12SUFJTTE1SCttNThpa2pIbmY1U3JXaUVqQkF2NllYV1JnV1JiLys2WmNY?=
 =?utf-8?B?RXNKK2F0ZG84UVNDa3RLREhjVlJEQnBaZ2ZISVBJbW1aNXZjRm55cFQ3U0sw?=
 =?utf-8?B?T0dOZjIrSmhzeFBpTjZsSjQrZlpPSGJISXNBNFcvVForeWpBNkNXcG5tWkVP?=
 =?utf-8?B?WU16bGgxUWJicWs1QlVsRVFyMmMvWmxtQ1orVlV1MFRuTUN4MjlBc3BTNm4w?=
 =?utf-8?B?d21TNlZ6dWNYWkNqMEVLbjNtU1dhVWlSTnViYVZHK1N1VTVnc1lXK0RRenZG?=
 =?utf-8?B?SDJtaVNXN2NmMWpCaHN0WW40OXBrTGhubEZVRTJUSFFSVjdQbCtBWm1wd0xh?=
 =?utf-8?B?a1lWdmZ5RkdzcCt6SjFZK05TNHAwcFNlZnlKS0NndUE2YTZHNjNKM1FGR25k?=
 =?utf-8?B?Skk1eEF0amZkUTFzTmFYNGVZb1dENmdNZzhINWdiN1FWOHVJWjVqZ2Fwem5y?=
 =?utf-8?B?Qno4TEZmM2ZjM1N6MEY3bFk3Z0ZxWjQrTXBjeDN1dmMyeUhrRUJ2OFdaOXYv?=
 =?utf-8?B?ait5WElqOUFsNk5zUi9Xc01BNm5hZVR4LythOTlaUmpTR2g0bDlXc1kzdkxS?=
 =?utf-8?B?b3pTamdFTHI4Ry84dFJ6MlRCZXBtTzR5SzFGajlIcG5LQitCa2htOGZnV1dB?=
 =?utf-8?B?YU5lMGZwKzVWTzlmZWZmSXlRMktKYVd3Z0hjZ05teGdydGhGTUErUTd1a3Jv?=
 =?utf-8?B?ZlVxT2hzS3BWVW42R2hGbi9yUGxQSTV6b1A4N1haSXc2c2J5ZVkrcnEyVnNh?=
 =?utf-8?B?UU5NY1NKam5XRjg5cHhyY0lGalJJQ1R4UVZsUjRSSks1ZkwvSGJJdE1rQXBT?=
 =?utf-8?B?RjhMdU5lVVZYclE1TnRZV0l5dnd1cDdZTkFwVm5BaHFXVGwyUkw2RFppZ2Fj?=
 =?utf-8?B?RHhRekd1cE5MNmplejh3UDArRFJ5VVdBeEprWTJkZnBBRVBwM2FyazNjM1hj?=
 =?utf-8?B?SDE1c0QrS0ZONXJIWXBKamhMcXl1QTVjRkJSMnVEZjhzbk5WeVFUMWZLVmVG?=
 =?utf-8?B?TnNQaWZOZmd1aWQzV0hTenpkZWcrRHE5R05QdGdJZ0tSOUUySUJ2Tno2aC9W?=
 =?utf-8?B?WWpnQjBja3hZWWtiRUtsRTFJZWYxejZ1d0NJcTUzMlhncFd2WForeWg2N2Y4?=
 =?utf-8?B?aGdkWjVPNHM1VGs0NWp2TDBGYU5iTWdMYXplcWMvSGl0SlQvRmtSUmFrV29S?=
 =?utf-8?B?amVjZkhJNTYvNUxGZGRXd3N2NXF4aWc3aDNORlBRa3VwTmVxMXUrazNBdXRK?=
 =?utf-8?B?SUdYRXBvN09VbU5NWTRaN1lSeEMxS3R0RUFJcTJCWStWNjZrMU50a0kyejJy?=
 =?utf-8?B?UUs1UnpHQ0dMVWlxWlg3bDhPOWhPQmM2ZTAwQmxxV3hnNno3TlhhRjNwWE44?=
 =?utf-8?B?VWtqSCt2Zk5ROW14a1hWMEN1ZFdVQjQvTFJUc1RtYU8xbFdkYUpHbDNvVUlN?=
 =?utf-8?B?VG9taXQ5S2VuVWtoYzlCY1dFOE5rbkFKNnREUVlRRUVsUlBBYU9CSWJ2cmU3?=
 =?utf-8?Q?m7I/q3vsBKAMCfS0Wny943Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	D7ZDfNOs9tRmxu8jEl9PHywlhxzwxUGvkJZBY0VZP7CLvNC/C0prCu8FJun1UELmHqwcZfdv5LI73NZn7jcDeldG68SofsN/cErp+nkHzCRi/vlj+lyMinW7StHASWVngOArrXroR3y/l5jTMlwvlD+Cgl10T7s9MTmaE4uzU6cUdQ/v3Eje6FWXMWhfnuGDj/skecSMxJTIqcsMF+bzDz3Qifm7NknIcjXWtEZI3LSxqgQTRvto0dy3KpxQxsVBdvgqR6GEYqlczlWMVjO238CKb8g+7k3me7ZwzfWQNGpbOa1KrMtkyy7CvRvHTWqiqzYGZxTYaMVT8d2Ffn5DUCsKP8/XO+WC5OtlwIvIn0Lj/x4nYcSqx9ZQjqx5iitglWyPwDgglAjtpPbiz3CEimZ59izWD0XERGiNCN4rD6QRI0YRSHF8TNXvszLndkExxMCfqYMIsnEvqnFHN9bFpRFk5Qr11PSp6N98C9vJDlNNd6kV7MQppeSBPOUnGY32+S1wQJSsEIPUsjCR6ftTxc5N+bGtemjSGN2LgsoAtEKVdX4vjdcc3WbmEdg4C11gbw93NupWxf+GrGTvQ8OSHBupvGiMV3dt6kxAM+K/h8qg/q88+soQ9bzUbqLnoJ1p4pBp8H74FCcpx1A29L2xfncleA/sQdJRsNlQp6maT2rjSbP69DVteK4NgRd8zhpOKhJDHq/4DcltYyLX2nwx58+qwt3Ui78UB71F8RTPNbFXNFyjkvsUP+qxoit4VQdIPXyTknPGpAikpep01W8OUpEAHaJBnfBbxcc+LNa8LywsN6YODJPpiKaUM0xEMNej11+bPCIt1Ub8yF/eGoYF5ofND7H6Of+xdAJSh94FnD88zDx8iyPuXEgAe75ofAjtCsPXMsOiWQ7YgnlLpP1Rhg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1410524e-f1af-4eaf-2ae2-08dbf8035e25
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 15:35:55.2738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysfKuMgGXUXSynvOVy3qlPJ6lk7ps7WJBA3NORX1p7PFZiLo6hJm8PtXWCo+d79oiCMpWBb73867o/2DZU3RGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_10,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080128
X-Proofpoint-GUID: 5HVo7lujG_P6uTA7pve3SZcRM9OxzSGK
X-Proofpoint-ORIG-GUID: 5HVo7lujG_P6uTA7pve3SZcRM9OxzSGK

On 08/12/2023 14:21, Eduard Zingerman wrote:
> On Fri, 2023-12-08 at 12:27 +0000, Alan Maguire wrote:
> [...]
>> Sorry if this is a digression, but I'm trying to understand how
>> this might intersect with vmlinux.h's
>>
>> #pragma clang attribute push (__attribute__((preserve_access_index)),
>> apply_to = record
>>
>> Since that is currently applied to all structures in vmlinux.h, does
>> that protect us from the above scenario when BPF code is compiled and
>> #include's vmlinux.h (I suspect not from what you say below but just
>> wanted to check)? I realize we get extra relocation info that we don't
>> need since the offsets for these BPF context structures are recalcuated
>> by the verifier, but given that clang needs to record the relocations,
>> does it also constrain the generated code to avoid these "increment
>> pointer, use zero offset" instruction patterns? Or can they still occur
>> with preserve_access_index applied to the structure? Sorry, might be a
>> naive question but it's not clear to me how (if at all) the mechanisms
>> might interact.
> 
> Unfortunately preserve_access_index does not save us from this problem.
> This is the case because field reads and writes are split as two LLVM
> IR instructions: getelementptr to get an address, and load/store
> to/from that address. The preserve_access_index transformation
> rewrites the getelementptr but does not touch load/store.
> 
> For example, consider the following C code:
> 
>     /* #define __ctx __attribute__((preserve_static_offset)) */
>     /* #define __pai */
>     #define __ctx
>     #define __pai __attribute__((preserve_access_index))
> 
>     extern int magic2(int);
> 
>     struct bpf_sock {
>       int bound_dev_if;
>       int family;
>     } __ctx __pai;
> 
>     struct bpf_sockopt {
>       int _;
>       struct bpf_sock *sk;
>       int level;
>       int optlen;
>     } __ctx __pai;
> 
>     int known_load_sink_example_1(struct bpf_sockopt *ctx)
>     {
>       unsigned g = 0;
>       switch (ctx->level) {
>       case 10:
>         g = magic2(ctx->sk->family);
>         break;
>       case 20:
>         g = magic2(ctx->optlen);
>         break;
>       }
>       return g % 2;
>     }
> 
> Here is how it is compiled:
> 
>     $ clang -g -O2 --target=bpf -mcpu=v3 -c e3.c -o - | llvm-objdump --no-show-raw-insn -Sdr -
>     ...
>     0000000000000000 <known_load_sink_example_1>:
>     ;   switch (ctx->level) {
>            0:   r2 = *(u32 *)(r1 + 0x10)
>             0000000000000000:  CO-RE <byte_off> [2] struct bpf_sockopt::level (0:2)
>            1:   if w2 == 0x14 goto +0x5 <LBB0_3>
>            2:   w0 = 0x0
>     ;   switch (ctx->level) {
>            3:   if w2 != 0xa goto +0x8 <LBB0_5>
>     ;     g = magic2(ctx->sk->family);
>            4:   r1 = *(u64 *)(r1 + 0x8)
>             0000000000000020:  CO-RE <byte_off> [2] struct bpf_sockopt::sk (0:1)
>            5:   r2 = 0x4
>             0000000000000028:  CO-RE <byte_off> [7] struct bpf_sock::family (0:1)
>            6:   goto +0x1 <LBB0_4>
> 
>     0000000000000038 <LBB0_3>:
>            7:   r2 = 0x14
>             0000000000000038:  CO-RE <byte_off> [2] struct bpf_sockopt::optlen (0:3)
> 
>     0000000000000040 <LBB0_4>:
>            8:   r1 += r2
>            9:   r1 = *(u32 *)(r1 + 0x0)  <---------------- verifier error would
>           10:   call -0x1                                  be reported for this insn
>             0000000000000050:  R_BPF_64_32  magic2
>     ;   return g % 2;
>           11:   w0 &= 0x1
> 
>     0000000000000060 <LBB0_5>:
>           12:   exit
> 
>> The reason I ask is if it was safe to assume that code generation would
>> avoid such patterns with preserve_access_index, it might avoid needing
>> to update vmlinux.h generation.
> 
> In current LLVM implementation preserve_static_offset has priority
> over preserve_access_index. So changing __pai/__ctx definitions above helps.
> (And this priority of one attribute over the other was the reason to
>  have preserve_static_offset as an attribute, not as
>  btf_decl_tag("preserve_static_offset"). Although that is unfortunate
>  for vmlinux.h, as we already have means to preserve decl tags).
>

Thanks for the explanation!

> [...]
> 
>>> How to add the same definitions in vmlinux.h is an open question,
>>> and most likely requires bpftool modification:
>>> - Hard code generation of __bpf_ctx based on type names?
>>> - Mark context types with some special
>>>   __attribute__((btf_decl_tag("preserve_static_offset")))
>>>   and convert it to __attribute__((preserve_static_offset))?
>>
>> To me it seems like whatever mechanism supports identification of such
>> structures would need to live in vmlinux BTF as ideally it should be
>> possible to generate vmlinux.h purely from that BTF. That seems to argue
>> for the declaration tag approach.
> 
> Tbh, I like the decl tag approach a bit more too.
> Although macro definition would be somewhat ridiculous:
> 
>     #if __has_attribute(preserve_static_offset) && defined(__bpf__)
>     #define __bpf_ctx __attribute__((preserve_static_offset)) \
>                       __attribute__((btf_decl_tag("preserve_static_offset")))
>     #else
>     #define __bpf_ctx
>     #endif
>

As macro definitions go, that's not that ridiculous ;-)

If we add it to vmlinux.h, would be good to have a

#ifdef BPF_NO_PRESERVE_STATIC_OFFSET
#undef __bpf_ctx
#define __bpf_ctx
#endif

...too, just in case the user wanted to use CO-RE with any of the types
covered. Thanks!

Alan

