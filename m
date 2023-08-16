Return-Path: <bpf+bounces-7891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4060077E0F0
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 13:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6316B1C2100C
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 11:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE4110795;
	Wed, 16 Aug 2023 11:55:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7118FBFA
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 11:55:31 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619F12123;
	Wed, 16 Aug 2023 04:55:30 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G7FfAk017933;
	Wed, 16 Aug 2023 11:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Rnkt79N0saezDTNF626vUwhXEjOJa2M6XIlNX7ElWvM=;
 b=ZRewKZnptxQJXTXOjRMtAZmWMbxmyv77SWw7wX9iC2VVCpYc/xnwjIYjozNk8DpgCd1T
 o6vWovHJpcRAsusAIcixkdVfyvwiRAyDlqGSxpqusFRAdwefyjDV1+wC7UyqjXzEostr
 gYKZ2tFev25VLnwTHs1QDJoJJ8+6ceMNs4MldScId38OoRkV1R1+q6vkG1xPb2Qqj5ja
 lvZ30+qME+FqCwxteRdUsyNxhUHGUpTTp+J0uhNPpylhv6F+Rh0MrJCw1SvpgSIc1TFJ
 Z8iDRCQUL6N4NX9RwMUGKAWIMz+GbNuV2wMHZqlIhmxxg7GWdCx5rEa3Q0t4jZEVOntU /Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c6rhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Aug 2023 11:54:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GAnS6p019946;
	Wed, 16 Aug 2023 11:54:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3wm30s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Aug 2023 11:54:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACiZhevphCdDjswvzIMzbgTT0xKJPbbnmUhqC5hW8x5H5UI+xjJuezEfffzak+pt12AeBLewXlob6GCGklJWKRlx5zPsjgDEG4P8A157kNNcoVmzgkg0ZfhJTMos2n2hr6cSDxCYagPQWJfsh8hdqbs3Kt85Bx681poO7jEBlooaAdMlXvnYtrahf/lsnMAX9z6/Daj2SY3nc482D0BUVj0COg/M+FyRx3QgK8SUBXXP1xzGt3G2DskcSnbA7ihJH36ksqhRJsigrDUz0XLEJ4Z7Ktpac/wxYvGV6Gc+Lngi+Ljlxe0zavtdvLu05BBYVonZ6KozlGCVx+vOjR/3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rnkt79N0saezDTNF626vUwhXEjOJa2M6XIlNX7ElWvM=;
 b=ZvL5YfaHcNZsnujXO5BIfjwI950gUS+ZzcEYqPVRDJvIiuaz1DkSmZRToDkejj8ACcdrUvbytxBO6wjNhDMDNufFTM+6/qH20de4dU86tH+B6TaGOhhOb0i8o6IvyZrDJP4scaznOB/5IzDq7kDVLiOmy8j17s0igH6EtOqs/IvgO+LtvHWcd35vVTCNyC6rWfwnUsaj58bDVqochFcdKogx8qij+1e2DGXFypzkKoDC7JWdeABw9aGp3Yh87yqP1cEcqhrJr8mii5OY2r2M3zF9xVGkKwoGQb6JXQo0sXnBk675ymH1X1YBXaNN26h9tD/ja/y5khIApApoymYBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnkt79N0saezDTNF626vUwhXEjOJa2M6XIlNX7ElWvM=;
 b=R66wkZIADZvAFB0Zru4AAuvzirlMwq5DTge46YvvGgRKpW0hhp3X97QiL9JA7TGNylbrl0l2bFWK62dAhxzEtuyN9Q1091KGsUamWFySBpfdMmQgHngWGXLZ7JDTYpJ1scE8oX2kMA4yLgxGCb6NLkCNaVqqZmJspYjv06NrWNY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB7635.namprd10.prod.outlook.com (2603:10b6:806:379::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 11:54:45 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 11:54:45 +0000
Message-ID: <d03cf025-925c-abae-b879-84226ada7999@oracle.com>
Date: Wed, 16 Aug 2023 12:54:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 3/5] mm: Add a tracepoint when OOM victim selection
 is failed
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-4-zhouchuyi@bytedance.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230810081319.65668-4-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0064.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::24) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4889dc-d3e5-4216-0d25-08db9e4f9570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BebwmWay7EES+T1dxnw59TP9ryv9r86EZMitC/JXe3FRxGTqVETeYFIi0hEIeb+KO/mmp29QuFeLJ7197pEzKL3DPRxj6DqmH0ovDdJRl9vJGSuN2QJOFch4NNuYAQnV5mIaMyk0StiNr4nm7TM7jHBdyoVPcZwu9TpmcI3e8OVrBVZ4GsZ+2tHIYxPWYcCtXVQpEg/C7lXrsob6fST2AwU6P0WfU3hT3xVCVcEGt5oW29IlEb1cg1xlNLSMuGWA1rbXKcPneI6xe1NyaOkjO8IFu8clJsvguGjtl07fW6qRvYIl6d2baVF8Qr/dNxeebJnjCcjmLwMqRITTa0FQteS1bI9wWlDK3qzywbGWU1ByFMhOwo1ljYIcdq+VqduoD9DDeFT0700HjqPRv656JPTcIXlVD9lRpOi0KsN3yHYU6uSUC2X4FZjq5BKBpo5go2wfhxKuiDvyAjP4d+NzHOhbqVRkTxMlmHrjcAu026TAYNkCCL7VfJHK0kmy8YljQRGsrz4BeECh6MS/c0j4N18HgjakWgF0ptrrx+pmlgB0S8VQSpmeSeeCbvo6riZjRcVuVgNesYnzpb+vrtNk/0Gjoiw7yMw8JzMvwUbG3HL9oy8HZwFnbgfzuAht84i4bd9TgGlTtFDFBOh+mpzv5w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(478600001)(7416002)(86362001)(6512007)(53546011)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGZ4NFJlUzN1MUNyRVVMYlBuTm15WjBERTNGSnBEY29qYzZFYSsyU2JMS0ZV?=
 =?utf-8?B?OTlSS2NuMUdUZDEzeHA3b2dJSGV0eVlWYmtLeWhBZUIvT0VFam9DNnZ1YmRJ?=
 =?utf-8?B?VzlSK093WURPaGZJMEpzOUJwUFdZYzFGa0h0OFhBdDNqWHdkV1h3OE1qOEJa?=
 =?utf-8?B?eDdpUDdsMlRlOWc2QWxvZHBDNGlURGRVUkpPWWFyNVZOaHJZZmlRNWFpMFRD?=
 =?utf-8?B?Y3pYR2UxMS9aWFhBNWN1UHp6WTVrRGZRU0Q0bWZab0VCREdNNGM0akpva0Fk?=
 =?utf-8?B?WmdtVU13NlE4M2k2VnhoazJvVmo4M0kzR1Ayc1NGaHNaaWNvY1VPNUEvdDIr?=
 =?utf-8?B?a3ZyWHQ2SjZSNXNXRlJtZUlTcGRodGkvVmFlTHBwS2htRktvRHZIKzByNjlB?=
 =?utf-8?B?SDY2QVRVRWYrVVp1QmdnS2VOOEp4Z2wrcXdyQlQzbkpNNXFUZFFkcHNEMlRR?=
 =?utf-8?B?SUxaWFFnbDBtYXdCdkRKVFcyT09XUURSMGRxaEEybnM3S0JVTDBiS2xWS3dD?=
 =?utf-8?B?NWg0RllNUXJKL3hSTC81OUhCeUs0aTQ0SHFxTFhKWHNqUmU1RWFKUXYrSkpG?=
 =?utf-8?B?aEFrenhVNDRUdHFVTkpKeWFJZFB1eDlvVE5ObktKV2NKZXIwbU9jaXc0eVFM?=
 =?utf-8?B?TFdXbHk0YkI0REZ4Z0RnWUJRZCs5MEVER2NZM0JkU1RMNXVmUmN6UXJHbGs5?=
 =?utf-8?B?N1BIM05nckJNTVQrS0FCaGYwNUlLb05kdGxYS2o3bXpwTnVwZHg3cmtXUG1J?=
 =?utf-8?B?bTNGT2JKN2xTVnp0TDJnWFhCYUJGNVF5SkFrY2RGalVpekZ2N0Q2LzU0Zlpq?=
 =?utf-8?B?M2JCZDV1WWZGblRHQy9kbklpYWxRdnYzOWtuYlp2OVE5SW1CUnZiSCtuMUQr?=
 =?utf-8?B?djJHTUxPRHVYY0RodjlLWkZFSDR5aU1Kb0QrLzlpMkVLWk1zVXdWbjdHdWtS?=
 =?utf-8?B?eHhhZTJWa29OeDRkNUN1TkUvdzVTWTlPcVVPWnNnTHRHQkJaTkV0OWRXaDNx?=
 =?utf-8?B?YVpnWHZRUjR5K2R4bXZTdE1RRWorRVZadEpjQ0Jja29veXRJcG5TT0k3c0ln?=
 =?utf-8?B?c3YrTjZIWUhEbEZET24xUWgvWlJHd1ZWTWVLUWdoSjkwcFFKWmw5ZUNsNUcy?=
 =?utf-8?B?M1MzZitrY1J5dVpEM0VKdU1ScDEzM3IrczNSUVpROFBFWE01K2RRdzdPWEM1?=
 =?utf-8?B?YlliSS9XTzliVk9SUFdPSWsycEdVQmtmdXoycEFhUTBYTC8veWhoVU5MeG5V?=
 =?utf-8?B?SGJvTWhkN3l0K0laa0tETnh1aDE1R0pwT2prTUdmeXQwQmVJYkdGbHlwSllE?=
 =?utf-8?B?TVA5NzdXU3Q2QnZzSC9zbzhxK3NtckNoNnZJa3lId2daR3dzYU81T2hWMzlw?=
 =?utf-8?B?VWVxMHFZZzlvQlRYWVpWVERWTHVUV3g3azRYQ1ZRZGFpYkQ3QThFdzAvakZ6?=
 =?utf-8?B?VTA5RS96RktwYkZRa2U0NENLalFFd0tPN3JmZlNjY3hWZUx2OVYxVEV2VUg3?=
 =?utf-8?B?ZmVmSGRIMFBpb3VDV2xNTGpvY0wwTjVROWlacWpqUG9ZY3pUeGIzYnpMWjV0?=
 =?utf-8?B?ZEZIcldLZkEvMXlLejRzaFZNWktyREpSdGpBd3Z5NUluNnVjN0UzMjFhQjJR?=
 =?utf-8?B?YXhwdEZlWGpGbkJ1TGZDY09ydWV2UnQ1Z20wNU1iZWtDNG9INVdmaks1ZlJu?=
 =?utf-8?B?d3pLYVF4TDVwTzljb2RkakUvaDBwc2VrWlJGeWtyaTJob3dTdGU3OWxjdk9Y?=
 =?utf-8?B?d0NzYjNnSmI3eWsySldiNnNORWlJNGRHVkJjNExaYWFsS0M0WjZ0d3VHeHlk?=
 =?utf-8?B?Q0tuTWlIc2NZakd2cGN3V3dlLy9ZWmtDMG4xSTYyVlRUTGd4bkdEOGxUYW8r?=
 =?utf-8?B?K1JGN1k5endVVDlsbC84bFFJem14Kzc5YU9VZUREcG15UnVIUERZQ3hrOUc3?=
 =?utf-8?B?NVJoTnFQVlZSb3hySGJWeUxoV05GMk1PSW9kbTB5TWZBRmg3U1J3V2FWSlB1?=
 =?utf-8?B?MmI3RGNNT2xVSmxOeWNEVkJ2SzRlbnhqUWJ0OXJ0YW9iem9pRkVFQXVGbm54?=
 =?utf-8?B?bVptZ0VYajlpdVlxdldvK2RWR2lQK3I3M1U4ZnFiakVTTC9JQ3ZRcmtZRWUz?=
 =?utf-8?B?SVFpa21SL2F0ZDlhaUJFakllbHJjRWJTcGtsUkFhNTRRRG9lQ0grd1VoK3BI?=
 =?utf-8?Q?XFKjOuK7H+LEiink0CeDaC8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GX3enUbfaKIlPz29i5+WTJkITBKQhNwIMmlXYGc/UZIrcu1XbfG6kqyTELNZ0K+gzWDGaZy+5tD4D8iAB09yak4gS/OKfl/k7CbCD0tdxgz9aHbFG4Cu9nC0rMAzchJmPieMcTt/mnTaCV9ai6gYRl9MjcB9UB6XjqY4LHxDM9LlOKe+ikIEYT+0jRTgJw6sCJo0Eew0W7hLKsfM6Ggyj+QP0RBp4IGh2aYXjP9XG5pyyQwLinhDr0EZC4ViJkwggCEkgEs652+fVyd4STBqqLoTPqA4sOYpJwSUvLIjqmwaXWkwT9rLYceKO9XLkThY8DfYK+E6RWm0K4WKAT3Kaw9IyVGzvWn0n/o3e5fYrOvriGXJZtvKDzRSON67yTRHzfw5LyqJZWXxZ8gGNrtYEk04uteC0rdPlte/fflzN2eYkxWfqHKEoSahiLRp/LS74sgHtFOa8cR3DQgTJStRCHBpeRl6XZ6T4q+y3+I1nZKKYFmJgcHUPdVdNT04NUlgMhw6vmXSV6de+x7Q4QpmGH0eoQN+yD5Tryw6RXJ3iHBaFtdnyLlbj+gmyq+ZqR/C1RuWn3JwQZYvOnGUWOl0zBNHS8L5jHRRhgClMmIRLcnJzzQeVMSB6Ccb8x1vIBm2a0GHNzrLdvuCMTpDRFJlfweGzaCx1CQdCDp76r6VRyFsv06Q06KQXchhWd/Uq83Yc2dLPA5QOQhv4zKPr8NUwC+5RtoTkqRxSWJU+RrX0efSozzKiXjvSo6j+fDjhQdSQ9zSIEKy2ELIJnGhWT1mZIlUpKRDk18KPmvfh+93VYHzyURAAKm1JcN5N10HiwjGSaNVpMfaUirYuzEOVkpI5myclhj4xisWKuP1ctBbaDNYKDaE7DbDGR+3XM1771/WHAFBywvFUEmDaItKtVhiSVSED3XsF42JkV8jjjUICeI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4889dc-d3e5-4216-0d25-08db9e4f9570
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 11:54:45.2320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gttH7FY9vRU9WuFjUFL2vOs4n5Fti+r4LAHpiol3bDXuGuhxQRMKVdAJ9Z2Zof9RXZ9AHH9bmdNnswyZWTvVGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_10,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160103
X-Proofpoint-GUID: u2bBcu6-Kn8bEL-w-73m-HQahH69Fnp7
X-Proofpoint-ORIG-GUID: u2bBcu6-Kn8bEL-w-73m-HQahH69Fnp7
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/08/2023 09:13, Chuyi Zhou wrote:
> This patch add a tracepoint to mark the scenario where nothing was
> chosen for OOM killer. This would allow BPF programs to catch the fact
> that the BPF OOM policy didn't work well.
> 
> Suggested-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  include/trace/events/oom.h | 18 ++++++++++++++++++
>  mm/oom_kill.c              |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
> index 26a11e4a2c36..b6ae1134229c 100644
> --- a/include/trace/events/oom.h
> +++ b/include/trace/events/oom.h
> @@ -6,6 +6,7 @@
>  #define _TRACE_OOM_H
>  #include <linux/tracepoint.h>
>  #include <trace/events/mmflags.h>
> +#include <linux/oom.h>
>  
>  TRACE_EVENT(oom_score_adj_update,
>  
> @@ -151,6 +152,23 @@ TRACE_EVENT(skip_task_reaping,
>  	TP_printk("pid=%d", __entry->pid)
>  );
>  
> +TRACE_EVENT(select_bad_process_end,
> +

would oom_select_bad_process_fail be a better name here?
"_end" is kind of neutral, whereas "_fail" indicates something
unexpected happened.

> +	TP_PROTO(struct oom_control *oc),
> +
> +	TP_ARGS(oc),
> +
> +	TP_STRUCT__entry(
> +		__array(char, policy_name, POLICY_NAME_LEN)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->policy_name, oc->policy_name, POLICY_NAME_LEN);
> +	),
> +
> +	TP_printk("policy_name=%s", __entry->policy_name)
> +);
> +
>  #ifdef CONFIG_COMPACTION
>  TRACE_EVENT(compact_retry,
>  
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 3239dcdba4d7..af40a1b750fa 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1235,6 +1235,7 @@ bool out_of_memory(struct oom_control *oc)
>  	select_bad_process(oc);
>  	/* Found nothing?!?! */
>  	if (!oc->chosen) {
> +		trace_select_bad_process_end(oc);
>  		dump_header(oc, NULL);
>  		pr_warn("Out of memory and no killable processes...\n");
>  		/*

