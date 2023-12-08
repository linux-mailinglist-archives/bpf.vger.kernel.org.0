Return-Path: <bpf+bounces-17182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF1B80A32E
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 13:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46EA7B20BC1
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70881C696;
	Fri,  8 Dec 2023 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QE4bw8/J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HbKWt2n/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FF5199D
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 04:27:35 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8COwl7024853;
	Fri, 8 Dec 2023 12:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=fCtSdTmOvyfB6wS7nMWjE5xyzSyRC1L0QrQklGRFp9A=;
 b=QE4bw8/J5DZ6QoOT2WEmR6icOHXAgDuuE+Id6Q0oG/OOpMlUyGsysE/yqv1FBFJ877MS
 22FZbCKf1pxsrmkEuCxO5pKH1uqKagAcRQ88UyHOeMum+PwOnuFuZdl52jcJ2wclCcEz
 eF0zUgACUKv1L4YOchdycTlDqTuRWtod1Epep3jJIiHCHxGzPsXjbEn7KpcCPTmyX/up
 jQk+LWNc7+aJjCy2X5X2BIdSVSNBshLnnDbbHiSrVyFFJy4PhHDc3lAJ6UYc+JFu2obh
 3y2UvytV4k50QlzRMrt0xpC8NZWq4cgEr/1cEhnQCIJY8CSSgIK4tfCddZv6u+YJDh0R qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0hnuka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 12:27:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8BxV6u001759;
	Fri, 8 Dec 2023 12:27:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan8ts2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 12:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8hokL01UrQP8djf5+JY4CMDyRnCJzi7JxMe9TsZZGgklv6V4botCUYoc9yuSeDaZ8/5ukx2VIY/X4fDDHBS5E/aYyfuqM/NT1UaooYE3xNOpLdnrW2T0thprRw27FFkcYHsdD44RaRa9S7mqPMr3Vn8HOfffcF0CE0ULQenmuq1vDFjMvlVNpOLTyrFslQx2FwwAhOusHspJNWa1KtVHRWrEQm2K4f3yUDuuT8V6TSUZzcp4Mi+12YxSMQjy1VzKRbp7As+aAyerrhlerC6cub94Y8plVIYdLj+12DPkrpgpv7LtNrV0mQ4nPAb7G+LM0+T5AxyVyYGusLFgArbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCtSdTmOvyfB6wS7nMWjE5xyzSyRC1L0QrQklGRFp9A=;
 b=YRArNDiu6e9T7FjL8nbe1nIf1c1HHgC+jzjZ50cVfk2uxASMd4dhl+arFjWeGAKXsmvxPGwJKMn0ez2R0kh70rXmO11dV+YB+3Ah8YMMN7OgbsNZbNMdk/rUZpMmMz3qsols9lgjlYiLB9Q90uf0IcZSLJGvlouZOijQMokZWKnIAPpsKUdy+o5nqcAhzZMVDk1ANYPwyD5jrYz5xnbJm1bVX6mX8LET7+VQ2Dr7pHtS9j3ROjN202RkO8obm74XpELdieD9BcZKKJAm/tCs3Q62hiZYkIIpikCImUQWP+Xys+RGJR+AH6FVx9aoPBxAafy0tUuWc7JqbR7uls2KLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCtSdTmOvyfB6wS7nMWjE5xyzSyRC1L0QrQklGRFp9A=;
 b=HbKWt2n/2Q3MO706qCsqhhqltjAwoQ5ts3lxbLbICXUdqwqcOVeMm/dbhHb7pd5tsGtzsaeieGAzZv9IyUrzHVb43ukQnkDW8V489Abrx2S+Tera/qqIF8pWFeRV0FlhfKz5g6wecYxnFQdpO48/ZLNXuZepli+RrDbDSx5IuW4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 12:27:12 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 12:27:12 +0000
Message-ID: <1d2a2af0-40db-80f9-da13-caf53f3d9118@oracle.com>
Date: Fri, 8 Dec 2023 12:27:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH bpf-next 0/1] use preserve_static_offset in bpf uapi
 headers
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yonghong.song@linux.dev, jose.marchesi@oracle.com
References: <20231208000531.19179-1-eddyz87@gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231208000531.19179-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0420.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: de1d291e-67f9-4556-0df6-08dbf7e9013c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KvisllUarwXqzle/diPKsUR4SzWoG7HjYJP/m5gviPVxezQJjtCFZ6uJyOm6IAma00eMjA2A48UQnwX9W6d9uOXMGDJN7J8rl0V9UjbWLZmQovBPuWQDPGviAQbwDuaVcxEKfCSSs9GGjM2DFJoJ+cYVUh6vSyXTn7W9AHQDJpfRdiBeRFnyD0hfabMw0uYS7WKy8PwMQjsFcfkh9um6GVFuATe4jI50JT786rvZO48OGSJhmbZDk2GZtZN/x2db4Tj4KGJfZ7SIIBax8fWuw21+oux3xnAOi77peQD6G+s/0oposP7JQdIy4dZ7x1w2nR8OWx5vjA44LJzQ5I7jZvYG/BBz7zCyiwAkJiaO7DvxPmYglDY9vna4Snq/5kTH45YnMvf82Z1CzBWrcDhWoXpE+C3OC6sb+HnFqPInLt093EYICTXpAL8ir9LQTlJdj4FUqb3DeTEhLl7zrbPwc6OW7GWdaVOPERnlcCDQnhjT8z2gq03mONASRlMVJNzvMifSXD993/uP7Yy0AFhcA+EzVQDGHaYigI8ZwTuRiImLH5AQ9BuiL/hK6ANypUDxQS8qmiBVpqxB6GIjQrYf3vrBVPDF7WBWA44R7y1KvHAUh+USrW3BUN8cWQ5HNP2WxqUlE7tJCiFQrafrb59B9g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(316002)(66476007)(66946007)(66556008)(6506007)(41300700001)(6666004)(36756003)(107886003)(2616005)(478600001)(53546011)(6512007)(966005)(6486002)(31696002)(86362001)(83380400001)(38100700002)(44832011)(2906002)(31686004)(5660300002)(66899024)(8676002)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnkxUGdHWW1WYmtNYU9ZZFE0QS9lM1NsVTkzUGhDdEN2Zk5qOEhsVUVLcHFF?=
 =?utf-8?B?THhHMlFLQ0F3MGJZcURWTE9nVlJkZithWERKWWVDM2NnaWthV2VubVNVa09R?=
 =?utf-8?B?cENhWEl4T1F4QVF3Y2Q1dk8yaFk4TnphTkQwVVcweURGdlFlV2Z5MVJ5Y0I4?=
 =?utf-8?B?ajF3MFVCc01CMjZhN3ZJa3hwTXBDb3RtaWMyWXM2dktEd3ZKZzc4Y0Q1UWxh?=
 =?utf-8?B?cElkR1pIWlAxZTdDZ0RKTFZQMFErQ1ZNQ2MzUThueThNb1FZNkRxRCtGVWVL?=
 =?utf-8?B?L3JMTFFDVmVibExaMGdsc0RkemZVYjNoNk4yMG0zVkcyS01SaFgvaVFXajZ6?=
 =?utf-8?B?UGJ5WDIveUJlTXdrTk8xNEtuaXlaQlA0OWpuaTA1NjlVRWRIREFTM05KSmZG?=
 =?utf-8?B?aXRTKzlQUE5nUFhQYmtscHVnbWtnN2o5SVQ1aVdpTTIxMFR3K3dZNWI4YVZz?=
 =?utf-8?B?SDlJV0NFK0JBaGsxWHdXRGN6K1Z1R0tFTHlBWERobXFMd3d2enhjdE5yZmJG?=
 =?utf-8?B?RFpwVVBKeWtrc3FzaTMwVVZDU1FsWkxXbklHaXVOdThpTkh3dmdhSW55OSty?=
 =?utf-8?B?eEU4dHI3R2djTEhwLzlDcWx1dk9WUTBRSWZBeWFEOXk2bkJnTDAwWjNCTStM?=
 =?utf-8?B?RmRFZU5aY2gyYlVuQzJRNnFINi9oNm5vWUxaY2NiU25XeDRLditxelRYSmRI?=
 =?utf-8?B?RllYL0JCMFFnMVJxc3lhc2dZMkdpMFhCMzJYVWd5UExhL3lTUHhPa2RKeGtx?=
 =?utf-8?B?ZzZiYXFqR1M4eUJpSEtaUVpiZG5ySWhQY1FIVXkvSUJReU9reHRYRVBuMXhY?=
 =?utf-8?B?a1VoaElIendOYTMxUmNINTYxRFZycUZYa3hDNE1qY2FPSnRuUXJoRHJNMXdZ?=
 =?utf-8?B?a0cyQkNVZ3N5NzdteUE2T0o3WTY4OS9NaFhlWE96bTh6WVFxR0ZmVE0yT2Fu?=
 =?utf-8?B?VkE3OWtLbGpyWWdkMUsyVGFmdWN1ekV6cGI2OUpNVWx4WHhGR2VDWkJIMEpx?=
 =?utf-8?B?QU1wYWluM1RvMlFEanJ2OURHZWRQU2pydllxcS9xREMrdEp3RmcySXpvUnp0?=
 =?utf-8?B?MWtKNnptY3QyRXAyNGUzSDRSRmlONC9YanZydmtvMDd1bWhyQXJYMXNHVkk5?=
 =?utf-8?B?MWxBUmJqMmZUTEhOUzh1MGppc2lYckFSWnU0N0JNUzV6b3psUWVRcms0NFVq?=
 =?utf-8?B?MTlTcmg0UmFaZlpkdHdZTWIzQ2pBQzJ6dkxMZThrZkdlMVc2ZVpVV0MyNE5s?=
 =?utf-8?B?RkQ3NWtUeGNvSmpEb1V2V2VQQVd6UW1Sdzk3ZHBrb1J3c2FPUXhyNzAxU3Ft?=
 =?utf-8?B?S2NkYzd5YkR5UmxDVmozOE1DZzYvYnRjRUdKbCsrYVNMT3MwRHlmOHRBNExR?=
 =?utf-8?B?RU5VMVRWV2xSNi95MG03L0RsMDA1cndzRktaV095UlBlUzhuYXBocldJOFp0?=
 =?utf-8?B?eld4SkdjS0svSmpCSW9McUtVTWVMd1VFSy9LeHRUcCtGR1ZZTDR3OElhYnoz?=
 =?utf-8?B?Y1NjelpkRlQ2bGdKZ3pFNWkzU2VjVEo1WUZjcnVOd3llaEFENDI0eWkxK0hT?=
 =?utf-8?B?M1dET3E1TGVDV2NjYS91TEl4VUg4QzNGTjJReC9iQ2IxSU16dGRCZFRxTlda?=
 =?utf-8?B?alk0TzVWWVd6dEl4dFVNV1J2Rmw4cm90cDE3d3crLzJ0cHJRc0s1ZGlTVW1l?=
 =?utf-8?B?YWVteFNJOW5JVWJIRWY4VVlMakhKbUZPNVl3SVpCMnFMRDYrSVFCajY5SHo3?=
 =?utf-8?B?eUI1U09razRRVE04NjhVYSt2YWkxYzVOdUwxUU9KeWZIZnBYZ3UzZmJoYkRK?=
 =?utf-8?B?K2tYVFBUcEdkeEVzQkpNdmJuT3dyZUtqWW1mbm5sMXVkTVowS1U4TDJXY0Nq?=
 =?utf-8?B?dzVZcDdhUVBwODV1a1BKbDdSYzZqZ3NkdmtzakpIcHZOdzFxaXJVNjdYdzB6?=
 =?utf-8?B?dExBT0tHNWhnZjZ1YzNndVpuVkJZNGQ2RFhWdWFiSjVWR05vYkhCNlZqM0NV?=
 =?utf-8?B?RlR4NjhSdkJ3cGVpQTJRQkRoZXAwMURaWXhEdEwzZlIveFYxUER4ZnNsUUVR?=
 =?utf-8?B?QlB0NEtlVjF5TGlIR3UySHVtNXRrUVNDNzVWUjdpdlBXZ241dEdpa0NVZ0E4?=
 =?utf-8?B?dEduUk5KN0xVN1g0eE0xeVMwdlpKLzZSaUNIcE8vU0FhTXVRV1ZQVktYN014?=
 =?utf-8?Q?B9tCHcConvG45CPeBJVkAX8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rk32S3VA6lUiXHlxqfjTiQX/JKBZTOpXa1jW5Xxv13WXjmTsuicUJBYEIWoV0FejxREcgdAYR34xp0L2hwa2wWhoQ6PZjFIGHm9KBg0Eolp0BdqCtjgZDh1fsZ3aJ8SfazcGhv3HutK+ag4lkud0n4Xq88HNTy1ptKZxW+DEQYrR5SslSKmGPQeg7rQXuqbPk9FXuqG9pvB8VH6z2JoauOV97BOPAx6KTicH8hOF3X+d80TIIGp4kvfCQasmxZZw7rg9n52J+45eBb01twAgRkuK+YjVQKTIw4rIIiDECWYT2QYjETeWO42/k6F9tDw3UwW1y+szpTuXefa8Rl1Go+xZL4GWqu6/zxb7CMRaPpSgVx2/y8RhUfx3391qpaASAEbAAeK/8l9lmcrytDClawZsWxcL3iZEigZwQFV8QgijNuVi4+cbIcQu/7muk0R9aFwKVHe/05CQ38gq1oxRtlL+nRw2V0xiQ7ye5La5emJYQSJpMpuV8U3NR69ujKJtI9ElSgxXZ72XzpWf2LLBMIU8ouOv0OZHakzKDTwvN2XR8bcxKqvh3KyEMZug3EhCILIq3szWYIHB/Vwi7SB6FZk4yRbFZDTNxyH+fw0X6cYvfDAJ0SozcgiU2bypzznoLASXv/xZSVGPXWGqNW38uBeFgr6QHw3YoBFE86U/4VfyTHPx1frrVcByGm70u9WWh9R0mwCqg/SG/6c16CyQ3gpJ3llm7AI4xsMxBXtks1C0z7mxITdIWaXZ2Y5+BKqGog3DJPPc5AqfsYIuUXWhaCPAG3grQRWVOPTfJqqURNsEYMU/VIs4bYLORjBSfxYtgj6uxHUO2ZHhFTOldsYqgWzYr0Kl+mWPGOeW6RCgEpBN8SSEhfAIQ+HbKwWFhZQiNm7a98QuqPhFQfEmA+HEmg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1d291e-67f9-4556-0df6-08dbf7e9013c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 12:27:12.4804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZ337IGEY2Bc4FBdFsV/d5IueW/cB1rvKLZvKo9klGEHx0zi97xfjHrEorM5RCE18u57ItiuvFUWL9SmyfzyBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_06,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080104
X-Proofpoint-GUID: jUs2mODmbdB8vrzKcVJ0tJqBEOwrA5VQ
X-Proofpoint-ORIG-GUID: jUs2mODmbdB8vrzKcVJ0tJqBEOwrA5VQ

On 08/12/2023 00:05, Eduard Zingerman wrote:
> For certain program context types, the verifier applies the
> verifier.c:convert_ctx_access() transformation.
> It modifies ST/STX/LDX instructions that access program context.
> convert_ctx_access() updates the offset field of these instructions
> changing "virtual" offset by offset corresponding to data
> representation in the running kernel.
> 
> For this transformation to be applicable access to the context field
> shouldn't use pointer arithmetics. For example, consider the read of
> __sk_buff->pkt_type field.
> If translated as a single ST instruction:
> 
>     r0 = *(u32 *)(r1 + 4);
> 
> The verifier would accept such code and patch the offset in the
> instruction, however, if translated as a pair of instructions:
> 
>     r1 += 4;
>     r0 = *(u32 *)(r1 + 0);
> 
> The verifier would reject such code.
>

Sorry if this is a digression, but I'm trying to understand how
this might intersect with vmlinux.h's

#pragma clang attribute push (__attribute__((preserve_access_index)),
apply_to = record

Since that is currently applied to all structures in vmlinux.h, does
that protect us from the above scenario when BPF code is compiled and
#include's vmlinux.h (I suspect not from what you say below but just
wanted to check)? I realize we get extra relocation info that we don't
need since the offsets for these BPF context structures are recalcuated
by the verifier, but given that clang needs to record the relocations,
does it also constrain the generated code to avoid these "increment
pointer, use zero offset" instruction patterns? Or can they still occur
with preserve_access_index applied to the structure? Sorry, might be a
naive question but it's not clear to me how (if at all) the mechanisms
might interact.

The reason I ask is if it was safe to assume that code generation would
avoid such patterns with preserve_access_index, it might avoid needing
to update vmlinux.h generation.

> Occasionally clang shuffling code during compilation might break
> verifier expectations and cause verification errors, e.g. as in [0].
> Technically, this happens because each field read/write represented in
> LLVM IR as two operations: address lookup + memory access,
> and the compiler is free to move and substitute those independently.
> For example, LLVM can rewrite C code below:
> 
>     __u32 v;
>     if (...)
>       v = sk_buff->pkt_type;
>     else
>       v = sk_buff->mark;
> 
> As if it was written as so:
> 
>     __u32 v, *p;
>     if (...)
>       p = &sk_buff->pkt_type;  // r0 = 4; (offset of pkt_type)
>     else
>       p = &sk_buff->mark;      // r0 = 8; (offset of mark)
>     v = *p;                    // r1 += r0;
>                                // r0 = *(u32 *)(r1 + 0)
> 
> Which is a valid rewrite from the point of view of C semantics but won't
> pass verification, because convert_ctx_access() can no longer replace
> offset in 'r0 = *(u32 *)(r1 + 0)' with a constant.
> 
> Recently, attribute preserve_static_offset was added to
> clang [1] to tackle this problem. From its documentation:
> 
>   Clang supports the ``__attribute__((preserve_static_offset))``
>   attribute for the BPF target. This attribute may be attached to a
>   struct or union declaration. Reading or writing fields of types having
>   such annotation is guaranteed to generate LDX/ST/STX instruction with
>   an offset corresponding to the field.
> 
> The convert_ctx_access() transformation is applied when the context
> parameter has one of the following types:
> - __sk_buff
> - bpf_cgroup_dev_ctx
> - bpf_perf_event_data
> - bpf_sk_lookup
> - bpf_sock
> - bpf_sock_addr
> - bpf_sock_ops
> - bpf_sockopt
> - bpf_sysctl
> - sk_msg_md
> - sk_reuseport_md
> - xdp_md
> 
> From my understanding, BPF programs typically access definitions of
> these types in two ways:
> - via uapi headers linux/bpf.h and linux/bpf_perf_event.h;
> - via vmlinux.h.
> 
> This RFC seeks to mark with preserve_static_offset the definitions of
> the relevant context types within uapi headers.
> 
> The attribute is abstracted by '__bpf_ctx' macro. 
> As bpf.h and bpf_perf_event.h do not share any common include files,
> this RFC opts to copy the same definition of '__bpf_ctx' in both
> headers to avoid adding a new uapi header.
> (Another tempting location for '__bpf_ctx' is compiler_types.h /
>  compiler-clang.h, but these headers are not exported as uapi).
> 
> How to add the same definitions in vmlinux.h is an open question,
> and most likely requires bpftool modification:
> - Hard code generation of __bpf_ctx based on type names?
> - Mark context types with some special
>   __attribute__((btf_decl_tag("preserve_static_offset")))
>   and convert it to __attribute__((preserve_static_offset))?
>

To me it seems like whatever mechanism supports identification of such
structures would need to live in vmlinux BTF as ideally it should be
possible to generate vmlinux.h purely from that BTF. That seems to argue
for the declaration tag approach.

Thanks!

Alan

> Please suggest if any of the options above sound reasonable.
> 
> [0] https://lore.kernel.org/bpf/CAA-VZPmxh8o8EBcJ=m-DH4ytcxDFmo0JKsm1p1gf40kS0CE3NQ@mail.gmail.com/T/#m4b9ce2ce73b34f34172328f975235fc6f19841b6
> [1] 030b8cb1561d ("[BPF] Attribute preserve_static_offset for structs")
>     git@github.com:llvm/llvm-project.git
> 
> Eduard Zingerman (1):
>   bpf: Mark virtual BPF context structures as preserve_static_offset
> 
>  include/uapi/linux/bpf.h                  | 28 ++++++++++++++---------
>  include/uapi/linux/bpf_perf_event.h       |  8 ++++++-
>  tools/include/uapi/linux/bpf.h            | 28 ++++++++++++++---------
>  tools/include/uapi/linux/bpf_perf_event.h |  8 ++++++-
>  4 files changed, 48 insertions(+), 24 deletions(-)
> 

