Return-Path: <bpf+bounces-6989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9388576FF8A
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 13:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48846282628
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AB9BA2F;
	Fri,  4 Aug 2023 11:35:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F357AD5F
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 11:35:47 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB6111B;
	Fri,  4 Aug 2023 04:35:46 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373LDiSZ002032;
	Fri, 4 Aug 2023 11:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1YjumwQJTTAOk6U5p4ydekcCYvOW/JcQuAh+X9HAGs0=;
 b=22+1EFxAEpEp0CPB5xXfX9LC/04PebgPpuh4KTxP/rv6AjlBJYzza94o2bcl2v1chSmj
 VKv71WyiNDgwg+TQZrNJWHPXm5ysZGgkf9l45BC6QaIpsQp22HUIRPXOWYejEHIiv42p
 bmjTX9eW+tdbmGjzlhnTJhwxcYE+W0L4L/d0mt8DIOLIXr8DgpAxbuHz0XrcDYcN5jk7
 y/Ma6qDp1YAw2RH7gFvcMKtM8WENcMuanEM7u0Yn65hUnGwLEbYIQ0w7TydwCaLuHZrw
 NYcih8iv/MGCro1iNXR4b7YQCM1BRdCyFoE7pYFP4EGQ0idFz2/g9T/4qPI5pyyT8s1z ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spcbn5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Aug 2023 11:34:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374Ack6v006638;
	Fri, 4 Aug 2023 11:34:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8kfh76uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Aug 2023 11:34:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTqjwKeQmblXDceo8gUB5uoaS5T2Czdx29ytHj9j21FW3OSdK0i8YJFn2KPfKWXYZzH+PkiVaQGIkYcVnkWjlThBuEbUNNhNgBNdSqkTOocyA0lGTd80PBeBBg9Q6NLw7+OR/zL2toStb08CufeL06k48GaHectO7WMsFB5uepMJ3ErPc57HbI27s+EeLoDf5qhvu4fyGdTnq8R29XcvkAS9ow9AAgXcGEaIkR1ms5FnR8bPQs+HCN4OJfgIrLz8/uGPnEHT3ABi7EVMV2bOYHizndEx15VkdRX5Bnou0IBF48gLlc9u6G+vByakNEizJ4iwamprRmAl9ig+ZHOVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YjumwQJTTAOk6U5p4ydekcCYvOW/JcQuAh+X9HAGs0=;
 b=LWTxX1qSe8SLaiPcQt63ryhaksmQLdxSQt9wPx364JBeuiXHCcCencIlv5DInUPFx9AneF8Hu9pmCVrmTOwq9yuVTwVoOscQw5u6TeLpuMt+4Xi6ASUNxub5nrpcy27tHhny81hheel+HbtjE899Ge8GipLMpwyeHiJY9doc0mTKyoogpWv2NiyMSQuAWYHNpkpZiSroYQFDpmGxKhnNWTmxIOsYc03MjjxbcL4FpJrn16wbpWeGgXIGwlaef3NjbaLdG6txmjPXkQyMtWwoP1k+f3HgSABGs4PzstHMUMWrm05Y1RvZMeiRpS6Z6/xxYZ31Xa1F2jnQSJWeAVhWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YjumwQJTTAOk6U5p4ydekcCYvOW/JcQuAh+X9HAGs0=;
 b=0C/4l+wfjPq3vqqFyCzIRWmtOZOVbDvLsX4Gbu1+nJ/0yyNC1Cb/KPAvKgyaxHx3X0Ivs7jl8kgvhLCqztLDVg1Wzofbpm+VQiYSZay0Vy7V7iYm8WcDd9DSnt3URtPacqOMhTYWWv/ZA3c1ucUxHxDw/a2+d5gALos+jol8f3M=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 11:34:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6652.022; Fri, 4 Aug 2023
 11:34:48 +0000
Message-ID: <1719817f-6ae9-8f0b-5075-657cb4e80e20@oracle.com>
Date: Fri, 4 Aug 2023 12:34:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
To: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230804093804.47039-2-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 167721ed-9835-48bd-e6a7-08db94deced6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o11ilt+SpcybqFM0W4+EqvpNp+yXMDAw4BgpIl+q2MfWVrxzGXsfPxBvkh1Z2+p6vMYd5U5hLvE1iNlKGLhtbli+N/7fFErnvienkRIlDqm45C+z23vBPskpP9vq0WrVt1gV7wLWMagaF+VebOdbuf4+jyFtgPkNeyXvSuNyWGeu5gioFpEDBMHkuBGugPrHSS9B13tZNne2lwnyVBb0wDjomL6pGCgjQOWtYJ88x/nH+wahp5+lhWqlr6/chEppbrC8Aw8YOzDgoPkC1STD3dmabhofVT8WNHE67i+4uWFPRQo0XwUnkeXtC25tSqVHwut+Gj3nZLFowXHiuh/yuqplba4nWRAszmXlkY7WUrbN5gXeR+ZPBQB1sJq02Utu+cDEASG3bvxuyp90mVxxZ59EtskWtsjKVIfnVMOAJ6CeIjyGqt5dvItY6bJ/bd0mNsu20UcirUdzUONrmh+O/k79d/QxWjS9PuwgsDvBQiVJkuETgNW0zzNrjD2g2NujI3i97ENxOnSocYFA7konPI5mizWPDOUexPCbd39KFZT2S6QpZhoBq0KPsXAL8uPGNAQDKWgJbaM6Y1fjXV9TiUOux6dCxzUrAOc1kIoZjZld1kuiJr5+pBbyKAS1hTOAU/IEc4NXMDLG8CjtADHH1A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(186006)(1800799003)(6666004)(6486002)(6512007)(86362001)(31696002)(6506007)(36756003)(2616005)(53546011)(83380400001)(38100700002)(5660300002)(41300700001)(8936002)(8676002)(31686004)(4326008)(2906002)(66556008)(66476007)(66946007)(316002)(7416002)(478600001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnZkRWFUdmpxcXVzR3B0QkhnTWlIUG5ra1BLekR6eWk5anlmb1M3VEVoRHUy?=
 =?utf-8?B?aCtqL3QyOVJxRjZSTGxuZHFYNW1lV1VLMEs5c00yOS9Sd2JwM0Q4TlJ3NzVu?=
 =?utf-8?B?bHVvVmJkN0I2Y0pjR3hteGdYeWVrVW5lUmpucXNENWkvUWQ1NHpwKzk4VVdO?=
 =?utf-8?B?M2J2TjN1NUk4cHpoblk4REhFMXZzMXBqZW5lT1FzOG9JTmpDSDJIMlB2YUI5?=
 =?utf-8?B?ZW91WThNN1pDazV1VFdhWGhBZ2l6c3lzYmRPRjNzYU0vVEo4cFpEaGJXMnRh?=
 =?utf-8?B?bXhmMFJ6alFtV2JNa2VFMTBBYzNtT2xFb25vSkNDUnIvdGszdktXZXpkK296?=
 =?utf-8?B?S2xrcElKUE9Nbi9mNUdML05GemFjcVczT3EvVEl1ODhqa3EwQTFlTDA1c1FG?=
 =?utf-8?B?VU1CT1g2V0hZenpOYU00N0tXeHBwa2RRNlhsL2xKVUhkU2luSHhhS0tESGRs?=
 =?utf-8?B?eFlFdTVMYVJvb0ZCVElvZmhnU25OcS85YlIwSFRPWE0wbDYxVHlPczBhT1BL?=
 =?utf-8?B?TU9aWFFhcUVKemgwazdYa0FGc1FXQnJ2ak9MU0FBeWNTYStLZVRjZGg2ejRY?=
 =?utf-8?B?RnZyNE5iRmJ1MWsyV0c2ckQvQ1dMNmY4S2pSMnBvQXFLY2FDRFNIZGhac0JW?=
 =?utf-8?B?WjRZRnJoaVJVZFc5ZzQwU3dvRFV3dUNZNFd0T0lVT1hEdmNoTVhZQmxRaThM?=
 =?utf-8?B?d2Z1VmZFMUxpMjBpT3g4bzh1cUdMM0piY3FxbzNRUm5IbUxjUkJtSUM2aVRY?=
 =?utf-8?B?b2gvdTRYa3BqTkxmNmxvaVBNUGlhemowYUpmL0tPT21LQW5vZ0xEQTNEN2RK?=
 =?utf-8?B?bVV4R1BvbEhaS0FkTGt4USt2SG8yNXl1RFNsakZXbFFpZjMvVlBTWjM2QWcr?=
 =?utf-8?B?Q1p1K1drMDVLcHVvSC91YzlZSHJQU1BPWFg3QWxYRllwYmNxR2Nvd0xaMGhS?=
 =?utf-8?B?VmM3M3cxTXh1MGhnaTZVSm8yUkJZTTZEeWRVVUJRNTVLZENXNjVZWFh3anV6?=
 =?utf-8?B?aXZ3RVpRam1rTkZqa2ZwaFFiVWtjU2Y3V2FpZjhodnJKdmM5bWxCSmlIQVpv?=
 =?utf-8?B?eVV6OXEwcFZ0NDNSRWU1THkrdktVQkxxMFVUcm5USFp4VHI1bE9XZ2VJUDZw?=
 =?utf-8?B?T3M2UHpTaUQzQ2xjTkZHamt3ZTkrOGluRzk1RldnMTc2VmhWZ3lDR0VBZk1Y?=
 =?utf-8?B?OVM3NjdFSmJBOEhGUXBTc3JVdWM4NkJxOEVLUHk0R04yeW13R1dEcnJjRllI?=
 =?utf-8?B?VXBMa29WaThxYTFsMnhyZUVBY0hBNDhNRmthRVpjUGVqRjk5eVJzUFhSSmlm?=
 =?utf-8?B?aStKZWhodTlrRWR1b0tIQzBUZ3RIMlJ3TUZXYWc3eWRkM2xub0pFUnNWeVU0?=
 =?utf-8?B?c0pYcWV1UlFXQmJNbEdDbW1TSEI0V2tidGF4WFVYWktzRjE1RVBmZjhqcWFo?=
 =?utf-8?B?YVAzVU9WK1o3UWZjait1aWpZdktkNE9EZ01BSUhOSml1VkhUeHRWbHFXOVJo?=
 =?utf-8?B?dkNXQzREV01UeHlEc3VFTG8wNGk3SUlJaytiNWZOaWNFQ3FVYWlLZTVtY3d0?=
 =?utf-8?B?M2pWV0tvbUdnZUgyc2xxYkxBbzJGck50a1hmUkZPOWR3VUhsMmlycGxWWndH?=
 =?utf-8?B?Yng2Ukxqdklqci9URzJ0TWdQZCsydUJlYXVGRjlSN3RQVjhLTnIxZXBWRktV?=
 =?utf-8?B?cERyTW1PVUlCRmt3VHV1cUVoR2ZIM2EwZkxac3RjRWY3QmxqeWZUV284RzFQ?=
 =?utf-8?B?OFkzTTYwZTZhbjJrUXg5a0JreWdWYzZSMWFnZjJYNjVLREFDWGtlM1V5Q1VT?=
 =?utf-8?B?d1dsSFdTakk5Z0ZOaWFpT1o5V0RCR29VVkJSVEZPRStBZ2M2azNPMERsaXBk?=
 =?utf-8?B?YmRHYndDd3N2NXZwR05ITkFzaU4zUm83ZVhUeWthMFoyS2haNDdjdHZNMUFR?=
 =?utf-8?B?Y2lwc2M1VVQrQktFN0JlZEpkR3VZNjRoY0lVNXlUUFRrS3FJcHZGaTJ2NXRh?=
 =?utf-8?B?VUUvMmtVbXFrd3pKSzRSblM0V2ZIQldZc0MyTWduSE45ZlJ5SWswR1hBSlJ1?=
 =?utf-8?B?SkxtOTFiblhmYy9oRzhEQkNIMEk5TmhHY2t5bmxsYjliK011dWJhUTNGM3Nu?=
 =?utf-8?B?aGtjTGMzdFJyRzU4WnpydnRxNFhIRW9xWW1ieWJOMllRTURmbnZIa3dpc0Vn?=
 =?utf-8?Q?wsiuPeAqfohVnk14EPROREY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dMO+kjD28l/FkDdD90CwJJrx6EUu3LKqK82TPfZ5WhF8E/aQA36sLiksLjZ5bZ4tno+yqBwttsHU3Ug32gtaQQdWdvyUKSPV5djk/9YbT78xeHc9y5t83vM4L4czqb3rXVXiEYR4FLnEj8/weRNV25FTKvaq37i1nb8mxdVOkrsxFjJfVOS7Z4HgG1Otp8S6aVFg9aMmCq0EWYvcTBRRXb/YwYx1gK1v3gBd6pQFUEfPp/4wj9Y6FLnNFAqtSeL/veCh+SyJDLrw07J14cpk6fVIZf9joU9hZoO0ouI6pCylMRduMUjSdg9lRkLfG1MBEPzQX9H07ZMHUinSCGHgjeLiswAv5bxWjMos4sgyYNvTzmi/nle4Yx5L3GMjpm9m0215I1NE0UYpKl5TP+RRvyT6ZAoQ51ThLJr47bW8XsHR0wLLBlLbjkss16xtR14MYoeN82MA/Vi4Yir5K436zm9BsdJKZLw9jr+nWClylc8/vZnkr3zPCb/1wzGDJgpon+tdqb7D2HWHwCiGal9nk90q3PGqyJfv+iBo6PB/lQvAtxkGcCVZqppk3PrettY1ney6ZJIPgvy0NKbItEnM/Eryy8qUPKDM0vH9PSKWU+wnuWp6JNqRSlIay4LTCLINBg200l/Jh+BrtMuy92XjNKuOxrKkNLpOAjPg53FP/wxjo0HJujwtifwhRYMcfEefbh8YPvALiHJhbNNMzzBiOh1Pu+4j+dnEEsSwV2bhoHZ+x8u0s/TM13Nccbpi6C9pKXZFBk4sbes5QuLgMq3yd/jiRrNX+HstPEpY7T9pJJgI7WalvTG/QA6eEfwY/dG2/Kl5SheSUrVSaWPAC5H2AVLx7V/nrG5c8tQR7VXU2FNEigvsk6IYHxqkwDP+rsOyRYsnD9uHXtRZp2cWVLLZgiHqPhsufK3VM59cZzNroRo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167721ed-9835-48bd-e6a7-08db94deced6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 11:34:47.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsx6y1Pn/K9Rl7hsX23L5Fe/np9Z+B82qzM3YGvw9eR7OMLEG2p33qEvuW0H3YC5ypsXJPab5ewNgY/LnCATIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040102
X-Proofpoint-ORIG-GUID: 9oWF-MnJOwplmnZrmxWakMgEP9wz12RC
X-Proofpoint-GUID: 9oWF-MnJOwplmnZrmxWakMgEP9wz12RC
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 04/08/2023 10:38, Chuyi Zhou wrote:
> This patch adds a new hook bpf_select_task in oom_evaluate_task. It

bpf_select_task() feels like too generic a name - bpf_oom_select_task()
might make the context clearer.

I'd also suggest adding a documentation patch for a new
Documentation/bpf/oom.rst or whatever to describe how it is all supposed
to work.

> takes oc and current iterating task as parameters and returns a result
> indicating which one is selected by bpf program.
> 
> Although bpf_select_task is used to bypass the default method, there are
> some existing rules should be obeyed. Specifically, we skip these
> "unkillable" tasks(e.g., kthread, MMF_OOM_SKIP, in_vfork()).So we do not
> consider tasks with lowest score returned by oom_badness except it was
> caused by OOM_SCORE_ADJ_MIN.
> 
> If we attach a prog to the hook, the interface is enabled only when we have
> successfully chosen at least one valid candidate in previous iteraion. This
> is to avoid that we find nothing if bpf program rejects all tasks.
> 

I don't know anything about OOM mechanisms, so maybe it's just me, but I
found this confusing. Relying on the previous iteration to control
current iteration behaviour seems risky - even if BPF found a victim in
iteration N, it's no guarantee it will in iteration N+1.

Naively I would have thought the right answer here would be to honour
the choice OOM would have made (in the absence of BPF execution) for
cases where BPF did not select a victim. Is that sort of scheme
workable? Does that make sense from the mm side, or would we actually
want to fall back to

	pr_warn("Out of memory and no killable processes...\n");

...if BPF didn't select a process?

The danger here seems to be that the current non-BPF mechanism seems to
be guaranteed to find a chosen victim, but delegating to BPF is not. So
what is the right behaviour for such cases from the mm perspective?

(One thing that would probably be worth doing from the BPF side would be
to add a tracepoint to mark the scenario where nothing was chosen for
OOM kill via BPF; this would allow BPF programs to catch the fact that
their OOM selection mechanisms didn't work.)

Alan

> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  mm/oom_kill.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 612b5597d3af..aec4c55ed49a 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -18,6 +18,7 @@
>   *  kernel subsystems and hints as to where to find out what things do.
>   */
>  
> +#include <linux/bpf.h>
>  #include <linux/oom.h>
>  #include <linux/mm.h>
>  #include <linux/err.h>
> @@ -210,6 +211,16 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
>  	if (!p)
>  		return LONG_MIN;
>  
> +	/*
> +	 * If task is allocating a lot of memory and has been marked to be
> +	 * killed first if it triggers an oom, then set points to LONG_MAX.
> +	 * It will be selected unless we keep oc->chosen through bpf interface.
> +	 */
> +	if (oom_task_origin(p)) {
> +		task_unlock(p);
> +		return LONG_MAX;
> +	}
> +
>  	/*
>  	 * Do not even consider tasks which are explicitly marked oom
>  	 * unkillable or have been already oom reaped or the are in
> @@ -305,8 +316,30 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
>  	return CONSTRAINT_NONE;
>  }
>  
> +enum bpf_select_ret {
> +	BPF_SELECT_DISABLE,
> +	BPF_SELECT_TASK,
> +	BPF_SELECT_CHOSEN,
> +};
> +
> +__weak noinline int bpf_select_task(struct oom_control *oc,
> +				struct task_struct *task, long badness_points)
> +{
> +	return BPF_SELECT_DISABLE;
> +}
> +
> +BTF_SET8_START(oom_bpf_fmodret_ids)
> +BTF_ID_FLAGS(func, bpf_select_task)
> +BTF_SET8_END(oom_bpf_fmodret_ids)
> +
> +static const struct btf_kfunc_id_set oom_bpf_fmodret_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &oom_bpf_fmodret_ids,
> +};
> +
>  static int oom_evaluate_task(struct task_struct *task, void *arg)
>  {
> +	enum bpf_select_ret bpf_ret = BPF_SELECT_DISABLE;
>  	struct oom_control *oc = arg;
>  	long points;
>  
> @@ -329,17 +362,23 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>  		goto abort;
>  	}
>  
> +	points = oom_badness(task, oc->totalpages);
> +
>  	/*
> -	 * If task is allocating a lot of memory and has been marked to be
> -	 * killed first if it triggers an oom, then select it.
> +	 * Do not consider tasks with lowest score value except it was caused
> +	 * by OOM_SCORE_ADJ_MIN. Give these tasks a chance to be selected by
> +	 * bpf interface.
>  	 */
> -	if (oom_task_origin(task)) {
> -		points = LONG_MAX;
> +	if (points == LONG_MIN && task->signal->oom_score_adj != OOM_SCORE_ADJ_MIN)
> +		goto next;
> +
> +	if (oc->chosen)
> +		bpf_ret = bpf_select_task(oc, task, points);
> +
> +	if (bpf_ret == BPF_SELECT_TASK)
>  		goto select;
> -	}
>  
> -	points = oom_badness(task, oc->totalpages);
> -	if (points == LONG_MIN || points < oc->chosen_points)
> +	if (bpf_ret == BPF_SELECT_CHOSEN || points == LONG_MIN || points < oc->chosen_points)
>  		goto next;
>  
>  select:
> @@ -732,10 +771,14 @@ static struct ctl_table vm_oom_kill_table[] = {
>  
>  static int __init oom_init(void)
>  {
> +	int err;
>  	oom_reaper_th = kthread_run(oom_reaper, NULL, "oom_reaper");
>  #ifdef CONFIG_SYSCTL
>  	register_sysctl_init("vm", vm_oom_kill_table);
>  #endif

probably worth having #ifdef CONFIG_BPF or similar here..

> +	err = register_btf_fmodret_id_set(&oom_bpf_fmodret_set);
> +	if (err)
> +		pr_warn("error while registering oom fmodret entrypoints: %d", err);
>  	return 0;
>  }
>  subsys_initcall(oom_init)

