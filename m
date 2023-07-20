Return-Path: <bpf+bounces-5563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD03875BAF3
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 01:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4A42820E4
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 23:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9037182CB;
	Thu, 20 Jul 2023 23:00:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73314011
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 23:00:49 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ACE92;
	Thu, 20 Jul 2023 16:00:47 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KLMkk6025864;
	Thu, 20 Jul 2023 23:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QbPmz/q1ClYKKgQ3VQUG0hNvAO857VwBnwM47aCJTAI=;
 b=pdom+BZuPfTTnCQpCnV3RYiGIJMAMQqXJwGT2T8SZ43yvqbtFIFLFQ9MZdhz+SQuNu6h
 XAbNtNs89ztBUt3wjwnrFiX0jQxU0eAwV6EOmS+b27z8z+bVxmzjRbTRbB5OX/BTQD7o
 +5EY1L9oVWIsOs7IaXXQdGwHS0Fh9D4mU6BqNHs6coMNg08Lxr9K+5auDneRBm5DA1mW
 53QKasyyS46DyJ6gG+n5bkUmrgh2ldhWXOVTo7AQ7SNrQsm14iGmXJslJgzQkyCROEfR
 Z/tUaEues1wRVAs6HJbErUmQMnaKwzdfIXTci+5kixRuHGQnJQhbiJ834cTBd7ffsXY4 4w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88tyxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 23:00:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KLFqTF007852;
	Thu, 20 Jul 2023 23:00:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw92cka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 23:00:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbOMbnFybfdQ5cSPwxEkfD7IF6Sy0kiVWvj9JCTbr2gbLd4VKHZB3DRov1ZEjUHmYAV9DPDzjcLcLP3zlRaRXqTcBCn6+t2IpKZ9CWKrIsjph5zVXeFvY3pPpUw2ON2truZPXm+p4wifGE6V9G2YrvMTn62tqW1H5LkLHpP5ZHHBcv1v31TQzcd0ZLXdC4Hs6xGm1OhjkDJ9QIChSVrHpk2s7Sb2E26xHS3IjC1La9CdpQr/jlSx28PeU0ghti3wLifcJAjWkgtNKRom2rtqtNRRhwcO438S6gd5q/oPYf56D6sByVKTUqmBph9+cubL0sXHNvuEbpjX4wR8WiZ3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbPmz/q1ClYKKgQ3VQUG0hNvAO857VwBnwM47aCJTAI=;
 b=lpUbz2L0aEQ0mqBzf/rY3nFOtehXNbpeOPBCqCvErlv0YJdF/roL/xjIqvdc4xQ29ywqhBex5uFQKlrkrCFH5pEBOdTpvM6WUwcEH3jfBRGYTVrI4gPtTzxPnl8mJzYFeyrGWSR6XVo+RL8phA8NvnInzh36GEuwKR82GolDiiRGVKIUgKeCS5fwGnBHh5R2Zj9Ppc/fzUduEhYmJ2r/pxGbPfnjMU+DHNlpUbF7UM+Mtc+M0iGk3S9scv/2ToVsh1NdnC1ZkLLvI7gtT6XaOKDoN7XELZ8zly8ILTg+NS2PDRurqPrGsGSd2gj1TwDI611arztGO9/Y9VozIUGK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbPmz/q1ClYKKgQ3VQUG0hNvAO857VwBnwM47aCJTAI=;
 b=laTO6wJVtmAQoFM/Q+vIq7b19fjRPhPLhF31BBCfY1orFdb7P0XFS94d1vmXcIZQaKvZa9Z9vmBxg6R7vZAJqiveslhtgK6unyaAhcgMNVsjGi7hcT4/FZQTOnnIyz7sO4D+imdq60TasfegbmQAazXeWdMFK7FpgmsP2mRvVVA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB5820.namprd10.prod.outlook.com (2603:10b6:510:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 23:00:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 23:00:37 +0000
Message-ID: <18605821-d4f1-c8e2-74eb-a91fc06d53b7@oracle.com>
Date: Fri, 21 Jul 2023 00:00:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 8/9] selftests/ftrace: Add BTF fields access testcases
Content-Language: en-GB
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
 <168960747750.34107.6104527579648222887.stgit@devnote2>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <168960747750.34107.6104527579648222887.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0031.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba0f78b-1103-4e15-ced8-08db8975218b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	52IByGCGXJxai8X1pDUTQOnVtkX3g/fYJOm+7mZonIvwzkxH8lGKGYS1hizdpOVlu5kgPhCSk6iijQP1YTESO/YuHDztZcFDnEbHrAkMTqiJ5d53oTYkZZ6KDqZdzEnyCHrNIxyjKyTytaLHX5FQoIDkNaVOCYhGDxHspy5l9734eDJ8Udmae0fIQ6ueBZKxzoOF8hIomvkeDrh8W5pZhBe9UoQmubscePP7YQljFc9q6qrrn1Sl3bLnY/AJKDOmrzlZWZ3fAc/xNhHbeVUnLBHPc0pjqP+3qyH2pTXgDXsmEn31bw9LtcnknDYZiM/Inv8L16a6DwI6LLECYRLxk1gk/NmkGttFra3ulPeQy0Q3dF0ud8+dt8yj+6Mr1WCuItMxgto8tEX+Sr2b7EnbFaBbeqSijU+MOJt2docGz7D/1YDKx4erMmrR8K4tNhdUtgR3HOMee5wJ+sd2YTC8qc5zun1MjUhbSrekzWQ07c2ASpBMvTPyOg7DGIPxbQkg3otoNecpV0VzfkF9km9bRtipV1kXFS1WHFgyy5kQ+QAnulCvWmRWdnr0QFguj47Y5WY26zXYHbddNBUVcyT8YUYem4H6kQpVZ7iRU50PdOafvN5NV3cb184PC5Z0C4j2DTPlm69vIenNP4SFveYKsw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(31686004)(2906002)(44832011)(8936002)(8676002)(66476007)(4326008)(66946007)(316002)(41300700001)(66556008)(5660300002)(6486002)(6512007)(36756003)(6506007)(186003)(478600001)(6666004)(54906003)(53546011)(2616005)(83380400001)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUdjMWpnUURmOTRkSXlZUnNaQVhjUi9GQ0x3OEtuTDd2NzVwaTlwbnZXSDBV?=
 =?utf-8?B?Sy9BSHpJMVZ5T2JpZVgvbnFsMTMyMm9oRUhBVkt1Ym9MUTRJV29VRk1aWkJj?=
 =?utf-8?B?cVh4Z2RKS1JLUDh1UzBTS2dmRXFqakg4MFVDVFo5MURKRjZwQjF4MnFpdHRo?=
 =?utf-8?B?VUg0alJ3WE5tQzdWOTNsbEh1cFo4ZXMrZ0pVYVNaZVJ2U1VMZjJrNVdaTUhw?=
 =?utf-8?B?STJja2pzSEp0T3o2dnB2NUxuQVIwc0ZxaU1WT1QydUY0clZvT3BtQ3Q0SG5a?=
 =?utf-8?B?TWdsaGFrSlhiRklYSnIvT0FiTzdCamYxdHloZ25lK2VmdHppaTdFYWl3VHFr?=
 =?utf-8?B?YTFSMUhmV3FHK3hzbitrUTlHVGxTYW1TM3J6UlUwWVJPcjZpenU1S0szWmcz?=
 =?utf-8?B?RTMxdnNRZFliWlhSVjkyaDlSVEFKK3BwdCtkaEpmeStyN3hRak9VSDgwUzRn?=
 =?utf-8?B?TmwxZ3V0bUFpU21KSEJQTGlLZjF1NXVtZ0tqTEhBUmN1ek16VVQwOFJCSHRh?=
 =?utf-8?B?MndnUjc0V1dzTGNYVlozcC91b0dqSWxPZEliYkY5WEZkYjdqOFl1M0NORDJL?=
 =?utf-8?B?Rmo4VGhPNm9zTGEzZStWd3hhR202UWZOaWZuTFU3OUpTaE9QOWozYjJIQ2xv?=
 =?utf-8?B?YUZ4d3MzeFU1SnNCTVlzSTNpVUhSZk1nem9UYnZhN2RtU3pkKzVSakdPd2N0?=
 =?utf-8?B?S0hNWDZ3NU1lR3MvSUNXaWVPb1VCSU9TNlJkNU5IdHA5RjM4NG9mM0pWQU5p?=
 =?utf-8?B?aCt5NWF3ZVFHRCtRRExNWnpUTHR0UGJxRVlqcStoTlZVYnFoRmJqSjFCcnRD?=
 =?utf-8?B?RFc3ZW9zNlRzNkVEaUF1MnRyUk9hZ3ErL0tPWUNUVWMxOWpOMm1ZeCtMUDEv?=
 =?utf-8?B?UmY2MDJkZTBaMGprSmxLTnZqTjM2NjRLclUwOVZNWmFnMWxKL3BRdGVZRWVo?=
 =?utf-8?B?WlVKVXdFTGlPWmpCTXpXa3ljMVIwQUo3T1N1ZzB6dVhMTE91RU4yUVdpZTRt?=
 =?utf-8?B?THYrRnlzTG1SSWNhNlFtM1g2Y3pwL29jOHB1SUFIN1BjdWNCbEt6a2xwK0dB?=
 =?utf-8?B?U1d4TGZkdmt6cmNnK1JxUmYxcVJiRythem1FSS9zNGtsN1JCcTZUcjJqTzlX?=
 =?utf-8?B?SE44ODJTaWNyUlNnc0FuVnQyUjN0dmZHZkV4Y1lZQUxwLzJyeHBLRzVyUFlp?=
 =?utf-8?B?T1liam5PdWZnbVZNQm5MS2k0OVVwVjhTbklWOHAvNHJpc1N4Y1VaeFZKb0pE?=
 =?utf-8?B?VXp5VzFXN3JXOGNyRURjNFdQZWpwSTZxYnVnTXFOY3QxQ3BoejhPNWFMY3Bw?=
 =?utf-8?B?c2R6UGhkV2tHVXBnV0hWby9UcDRSZlN1Rk83cGpNMmV0djFJVHRuc2ZDVzVI?=
 =?utf-8?B?Qkx6VVdWcDZEdDNEMGZmZWZzK1ExTy83T0tPU081SmlmZUZCbTI3Yzlza21i?=
 =?utf-8?B?UVZLSE9aK3RSNHdid1h1cXpqMXdhUGtXNWhKdTRvbkRaNG9zNkRuSlo3ZzBN?=
 =?utf-8?B?ZmJxdHlIeXVkcW0zOEMvemt2Q0xUYWkrOUtJdnRLclFWUWhQTXhOMmJoTzly?=
 =?utf-8?B?RlNOejhnWGJKd3hDQUpzZUpTVjZEWW43R0dPckZzU2QyaUlsMFFLSFNZbVZW?=
 =?utf-8?B?aEhrQURaTG5PTjBFNHlBRlgxakF5OXMxZE4wOGNYa0xuQUNBSGltbFYvdmpS?=
 =?utf-8?B?MXFtNkUzYlNSakRJWjZ6ek5TRXdhS21MMEZWKzBIWm5hZDg2TU1HUVJHT09w?=
 =?utf-8?B?cDBZNjMya0VBVXJHMmhEcTAyZHhEUE94dFBqMHl6VEJ1UjQwVWNSbVg2aGhV?=
 =?utf-8?B?aUJqV0cyZDdjVGdPY1RHZ2xsRElCU2RIMDVFMnJzaGN5aHhSSDJVMm9SRGdp?=
 =?utf-8?B?SnRTa2VadStTNncvcFNlSnNCQkRwRHQ5TUlGM3VNZGZPelRmMXJZWkM5NE02?=
 =?utf-8?B?bXJYRTJ5aU5Ia2FJbC9YQk9nOTRtUWZhckxITk95VDRzUnAxNE8wOXk0VC9r?=
 =?utf-8?B?cXE1cDZDNDIyTmE3VmNFNFoxZzZiVDlJZmpJZlJwYi9xSUhhRnExemNldFhK?=
 =?utf-8?B?VDlsMklqYnhsYmFLYTVzS3B5clZwYTJWbnNodjZMUXJyTlI5cUgrbzZvS1M5?=
 =?utf-8?B?R0JwMnNUL2hRditxVXA4N1ZTL3JDdjc4eDZSOGlJVzRydFN1MDhrV0MwZEVD?=
 =?utf-8?Q?f4gNXGo7N49C5c+TTBwXK9M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mjlaBfsudakv+1ePh/WnuRC3z3ITNC5jYfCq88xSFnzJm+MwogGq+QRcajxmE7f13vm6WOb/++S4f5PTw+kC73SsW7NRHI0CIEabAiC+M4LUec7cV7ZKuYSUBzcCsMXxo5t0rBGAbRaM73EvPuaU6kxuK1SbXycn0sDPRZWwOoSLxjmtzH/xySOZiG6M6Ce4ATObVd7tQuIRKC7qR7KwiFFQNH0f3oeNZh3/HaO4WEjefDE2C0coepIxdv04K/kAwH7C7UkxqqGIdjcUwQKDICfOqpfZ8TDOW1SlX6FSeD2QsRrRg4ZjiEKOj0Q6azH9bcJ637C7xLPvqCXGe68YD0Ze0uGbeyuWvbLz07IJcXLuaqb3hffBxNheaUwNZnYxE+mTKaYicqs2rwhqy1RIuq9PaGoyxnrjEDSRlTGRUyj8dAgavkGzYT0kfrbnGqM9hxR48ZyPz/eaZcfNpVmMAl1xVVPkNE05DyWpOiedz+RQzCe/P502ZOlPMSfIayrrKsrcfFtratRpo62S+jdO99h+xD/ccnITUXGTzikVujntMI405MKBN6SiHOk5Ez781zmX9YOGTa+lB+HL5kVbCN7Hmo0VSpgqNz6TWvPU7Lb6aFmOnaOyNf3rFtLqpRurxsKmKmd+ZuzMGcPdSx7ZR9N7kIgHHMwA0ze7iiD1zKMOi02+DPaoBq8C91S039I5OW7NWwpO8L+1P157hZAUz9NFjJosdBHd2ILO6Kjh2rnkE35NAUcqP6NBobfVxVPkj2tSBL+OeKodK0R3TbMEbJfXceKIZDB1Bo09Kjb3n4U50wkeKqQ5uW75LHw4HRwEMzVUC0GwyTP2GOpl/8ByL/385F/l3/daM3d4ywl5LkVxFKu+KjwLmvZQxzjN9zBAUrF8/yvU1CxUvnWjRLO81g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba0f78b-1103-4e15-ced8-08db8975218b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 23:00:37.1973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2otUUkEU0vn19C8OWKhzLpjVEVsSAsIliKSH4f5k2bOkDezyOEt0Vjr13cDRxsjMX/lRA3d2BDKq2luConNKHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200196
X-Proofpoint-GUID: p6HPfhMhoJUkjf7SVIgJIRLvnlBiuUar
X-Proofpoint-ORIG-GUID: p6HPfhMhoJUkjf7SVIgJIRLvnlBiuUar
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 17/07/2023 16:24, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add test cases for accessing the data structure fields using BTF info.
> This includes the field access from parameters and retval, and accessing
> string information.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

One suggestion below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
> Changes in v2:
>  - Use '$retval' instead of 'retval'.
>  - Add a test that use both '$retval' and '$arg1' for fprobe.
> ---
>  .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   11 +++++++++++
>  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 ++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
> index b89de1771655..93b94468967b 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
> @@ -21,6 +21,8 @@ echo 0 > events/enable
>  echo > dynamic_events
>  
>  TP=kfree
> +TP2=kmem_cache_alloc
> +TP3=getname_flags
>  
>  if [ "$FPROBES" ] ; then
>  echo "f:fpevent $TP object" >> dynamic_events
> @@ -33,6 +35,7 @@ echo > dynamic_events
>  
>  echo "f:fpevent $TP "'$arg1' >> dynamic_events
>  grep -q "fpevent.*object=object" dynamic_events
> +
>  echo > dynamic_events
>  
>  echo "f:fpevent $TP "'$arg*' >> dynamic_events
> @@ -45,6 +48,14 @@ fi
>  
>  echo > dynamic_events
>  
> +echo "t:tpevent $TP2 name=s->name:string" >> dynamic_events
> +echo "f:fpevent ${TP3}%return path=\$retval->name:string" >> dynamic_events
> +

could we test a numeric value like kmem_cache_alloc object size?
also if combos of -> and . are allowed, would be good to test one of
those too.

> +grep -q "tpevent.*name=s->name:string" dynamic_events
> +grep -q "fpevent.*path=\$retval->name:string" dynamic_events
> +
> +echo > dynamic_events
> +
>  if [ "$KPROBES" ] ; then
>  echo "p:kpevent $TP object" >> dynamic_events
>  grep -q "kpevent.*object=object" dynamic_events
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
> index 72563b2e0812..49758f77c923 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
> @@ -103,6 +103,10 @@ check_error 'f vfs_read%return ^$arg*'		# NOFENTRY_ARGS
>  check_error 'f vfs_read ^hoge'			# NO_BTFARG
>  check_error 'f kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
>  check_error 'f kfree%return ^$retval'		# NO_RETVAL
> +check_error 'f vfs_read%return $retval->^foo'	# NO_PTR_STRCT
> +check_error 'f vfs_read file->^foo'		# NO_BTF_FIELD
> +check_error 'f vfs_read file^-.foo'		# BAD_HYPHEN
> +check_error 'f vfs_read ^file:string'		# BAD_TYPE4STR
>  else
>  check_error 'f vfs_read ^$arg*'			# NOSUP_BTFARG
>  check_error 't kfree ^$arg*'			# NOSUP_BTFARG
> 
> 

