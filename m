Return-Path: <bpf+bounces-5329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31A5759A35
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6629E281985
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9EE16428;
	Wed, 19 Jul 2023 15:50:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F9F156D1
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 15:50:38 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D103E53;
	Wed, 19 Jul 2023 08:50:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOYJb027141;
	Wed, 19 Jul 2023 15:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=IAae7Pa71sDaCQr0GqSugahvSbck4iElL/eOZXvjBmc=;
 b=WoHWH6fjSsYhF1H0zCVDq+/5XIPmgiE7vq48hh8fa7FUKwgIAdBTwpoFCmWuRlsCjdOJ
 a8zIuPKQJT4xRFvoEvVeS5xs5rK+hy9djFYwmPvZX1whq4W3ZU5a2iJoFUcTiw7rY22Q
 FxJxrlknuNAxT0HMcVuEyyjaPssSKc5DCggO9GDLaeKEqOot+zHhFxPsx0al4wM6Buz0
 XiwDOmXhA+FCg+0K5QGRCyS4n7kYs/46dSogs/esjTk9YDk+/o6xzloUxXaRsn3m6rqn
 FJ8HcUT7QXIlfY4t6f2jEh9QFqT/uV2YXkjUTQPn2QzlPAuaVKOuJo2Y0FcHUR6hXroV +A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run787pdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 15:49:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JESA10038302;
	Wed, 19 Jul 2023 15:49:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw71vdc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 15:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwlNkXK4KyVNfVQRIJMDjKiRTHKkKrrfn0RYVmfnlbHj6/X1IrwLba946ga9D8rnkc/gk7WyLwQSfSRtzOcVI0tZNKYlxUmRYnTFHudM4mPAKt3QnB4+dwJtPpUzqddl12pJquJWian99BfAKQ4rRgnUwk1ayjT2PmH3aXZ8w2t7geQ2KuZV9MgsZuQThYALO8FShKvlgRLbGra31NKFMTOeByfHuJNCw5nYAoXfR09uVLQ2StNqOTi70AewxwvZ0rojR80QK9FwG6tFmE7wrLHFR6Y7YgM3gXpCJaLrXji1nCNrJePqqxL3HjPcB8EV3ypBgbjbAaugIEVNCNmG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAae7Pa71sDaCQr0GqSugahvSbck4iElL/eOZXvjBmc=;
 b=F3wvH2dOauaHfo3D5fKeznnDpj4+orcPRajrhUiilAxS5DeaFHbHJsba35c83PAD8yvBe+va4ITKYHJYbheNTdG3UaXGaVwsavzBtJo6lGjlvuVZA/VjJy+A/lREZl/JREKdD0/8W+DHrOcIV/zO6VAFW7+DU/PIAq+H6Do5LhJk2NKq5fIQV4mFgIeWGU7lSNmYIGG+6/GH9CHLpDQY23C+755yREYeqwhX0IHYxCusxK3AJ3+GCcLDMyd8zZRYu5WzS+b/MJ+gKFk2Oe7Pb3MCIIBRNEnwmjari/ivWOOrSt1ZOMu/ZHq8b2aRE5RghLozirEKs6ctqQ0wiMa+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAae7Pa71sDaCQr0GqSugahvSbck4iElL/eOZXvjBmc=;
 b=vZvdsiTXpKzc6ECHFC9Tabe20hw9iyvbI31mz9u/9cLP9wR9RmiI39fduwBuQ1ZPxkDy8DKl/vq3ymL1YuicCAHBdYqWTj1/2qYVTYMk7q/yg88bOQ5rjVUjj4zHQUv047hd/wvlRx9I4b5ySg5wjCpRw+wz35hw970+P2+j28k=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6846.namprd10.prod.outlook.com (2603:10b6:8:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 15:49:28 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 15:49:28 +0000
Message-ID: <155f6f0c-de1a-2069-35d4-b08c1df5821a@oracle.com>
Date: Wed, 19 Jul 2023 16:49:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API and
 getting func-param API to BTF
Content-Language: en-GB
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
 <168960741686.34107.6330273416064011062.stgit@devnote2>
 <13926373-1beb-16f4-180e-f529a8c9b0a7@oracle.com>
 <20230720002446.83aa066ea37af9482751ee8d@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230720002446.83aa066ea37af9482751ee8d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0069.eurprd03.prod.outlook.com (2603:10a6:208::46)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c55215-6a01-4a3f-5058-08db886fbbfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BfqdBeHTkgTIhwaz4NiV6JcJi6Wa1SA5AUHLXiXC0Yb8v2w97jXdA3epMlAJFNQISkpZVu6YR6ybyScXn/quZVXA4pQKyDzuSQUK5T5O4HYdaDv1c/TlHgjaCWm0jvaLctJpg5HusaVixZu/C0n4ZxFnOUY/tn3RyYu2TUk7WisLdHWrRL3QTgn3qrjxsqVj0USONraKdm54iEgin9OZUxSz4iuLLszSY90kvq1SUjuYtXqOpcrinvsi3Rgpxr/Ohe4Y4u/1WTqGbpAmxDkMHxH2kD4ebOVOuv3n6psc6wx7BxcAfBwhCaqZpOROXLABajE+l2XUgQC4Yomip+35E2Z6SerQBltkJgH/N2HjUmKDhx9JYGVhH2ugS02VNQwyZclGODtS2BjNnaozKwsgiA232wNgwyacJi227Fec1AXHiacuU/E6UfTbNx37WDiZaC1DBdqlnAEzAuNhJ6ozdgABQxTASETxvwcWySlelOnVpF8iMFQooCZajQpIcqmHi36QJOUYkQ4CbKDH8JzVP1gx6DbNwNWIyuK5H6eV5EC/Sw8iClvlyvvcdpj0cAChlrZgpHSMHiu4CHn9WmhimfFKU3NL1yJiaGIfHZMqKIKf0xbzz3L4lgai7ywmyNK7C9qSosUJjY1Vgk0hfVWxoQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(53546011)(36756003)(54906003)(478600001)(6666004)(6512007)(6486002)(966005)(186003)(6506007)(86362001)(31696002)(41300700001)(6916009)(4326008)(316002)(66946007)(66556008)(66476007)(31686004)(8936002)(44832011)(8676002)(38100700002)(5660300002)(2616005)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WjhlQzRIQk13RkduRy8vamZPdWRsUHFMRHp5K09wYjVPM3ZkaDZ0YmxzU0Zh?=
 =?utf-8?B?NUg5N1dlVW1XaHp0YTdBYkR1dllIV0FQR2piRVZpQWdVeFMxaThuWng5RXRG?=
 =?utf-8?B?VE1HSDhvUytqY2xiVmRhYVJLajZMZ0VYWVBocHZpY29LQzEreHE3bXpMVUJB?=
 =?utf-8?B?dVdJalRGamdWeko3NU8yMGJHZUJRVndQbGZCY1ZWb0VUSkhROXNyakUvbDdH?=
 =?utf-8?B?aldTY0M5YXplbEtZTFFrMFFwVWFiNDI0QnMvWHBWejlYNWxNKzBrR2JoVWVa?=
 =?utf-8?B?a0lpMktwSVF0bUwyR29SWnRPczRJUCtxY0NHNEhkMFJiU2ZqRmZRREEwWisv?=
 =?utf-8?B?YzFHQWRLUlBERmxqRlh3QUNJMVAzY0c3R09ueVM5dzF2cmFrSUJZcHM4Rnp6?=
 =?utf-8?B?QVl0aytaeGJhQlFBOEt6Wk55bWhZVnAvWWtVZmIyeURBRFJ4eDE2RXNJUHh6?=
 =?utf-8?B?VkRsNUU4dm9IeUxaVHRpQnpQUU52WnFyak1zWlZqZm1DMlNFeVhQdmNLMVox?=
 =?utf-8?B?UVZVTy92OVk0QTc1bk1kSytkVmNkYytGYmx6bXEvaEQ2OURWOW5VY2wxQndt?=
 =?utf-8?B?RVhYVS9ZbEx2U0wwbUVLMUVRR0NWRitFYjZ1VlUwalNSMXNWKzU2OFhqNEJM?=
 =?utf-8?B?UFhGVHlaTnkvU2JVbTNYYyt2V3U3WW1EY3BQREF5REczOW1qMDRhUFNPazVu?=
 =?utf-8?B?THdaRWRORHlFNkZDSklFaGpWd2NjckN5MVFkeGt6SDdnTXd6Y0lVRFBhRGNK?=
 =?utf-8?B?TXhFeGQrOUhDcDR4anBKemhrM1NkTUZBWGJKWXVubkgyOG5qMW5KTkRZWEpB?=
 =?utf-8?B?OWlpV3VjbVI0K2NDMithNnFjUzZaS1g0Wk1iTWF6a2NsYXd1bmFQVHpsSlNa?=
 =?utf-8?B?UGNZeU1xM1Z6T1BEUFhwMVhwWGtib2pLYmFoREpXdjd1Z3BMaDFZMmdrUHdI?=
 =?utf-8?B?dHI3QkFzMXdsOEZiR2F1eUVURFZqK2IxNk1qWDBuU3ZLODRMT1M2NVJ2RnRv?=
 =?utf-8?B?b0NFd0VTaS95WWs0aXdQTXN5QkdWeitZQ1NYNGN6Y3VZb2xPc1dmbzZQblo4?=
 =?utf-8?B?WlZYc3Jkd3hhUmhscVBVczRGQ0M1STRRZkwxamo5MlF5RHdOWDBlVTVRdHB2?=
 =?utf-8?B?dEZCOXlzZytvMDBMRFdMYTZIWUFvVm9JV3g5M0t5N1JQVjJVNzFkOGZWcGsz?=
 =?utf-8?B?bE9JZUtKcjBJVVFVVzVYeXl4dTU1dFY3VHJLOVFOWlJManlFMFY1TWc5WGpM?=
 =?utf-8?B?SXpyalJmVkFVcS9oQ0V1cVo0UEtZNFVzaGdJamgzcGpCOHU2VC9YVmFTSHda?=
 =?utf-8?B?WkprUUJPSUNwUTM3ZWp6aVVFMHViWkpiR3VOY2RYVW1oMkZNVEJIbWdTRTQr?=
 =?utf-8?B?UW9NVURvSGJTaDZDNXVNd2ZtWGVydmlJS1ZRRi91NjBHcnpTa3BrNTkwMXpq?=
 =?utf-8?B?QU9qWlVpaVZUVk5zMGlJdGt6bEtYR0pmazhOUnVEMjhpK1NFb2paMktHdFJr?=
 =?utf-8?B?dFd5N3RMbWt3RlVubzIxTEFqVFc2VFNuRnUwcmN3VkorUnArQkxMZ0xQWkw3?=
 =?utf-8?B?VXlLRVNiMkRyM09yR1pkbW80bG1NUG9aSy8wZ0lka2Y5MG9BQ0VFYVhlNWxB?=
 =?utf-8?B?MkNWc1pPY1AwMjhEcXNjUDhGZ2tDSlpQZ1JzTnZ0NGJJNlRpNFJqWmkxWUtX?=
 =?utf-8?B?RUpDWnRlZ21GbDhqMjdIZ0R5WmIzMlNEZU1DZWp4YUtEKzZGYWNHSEVMWVAw?=
 =?utf-8?B?VWh2R0VHNmdiMEtxbDJIU2FaMDc3QVh2UHlKSWcxeUpXNS9ZYllLcXNJbzNu?=
 =?utf-8?B?NEZNNWphTll2eTlhM1VqdW13aUE3MlA1UGdZSVRsZnE4bnJOc1ZDRE5JU2JU?=
 =?utf-8?B?VElKdjlXa3RzQ0oxbXdIcms2TDRnU2RsZk8wdTZBMmErUFM2c21kY2RBTndB?=
 =?utf-8?B?ekVFUUcyWGUvM2E3OFRaaVZZeGMvYzFXVUpNOXhVdVFTbkpkTHp6QTkzSFR0?=
 =?utf-8?B?dld6Z3JxUmpFQlpZYWNkQ2IrSFdsVDlDNlJNR2tscDlmNEpOamJOV09aajR3?=
 =?utf-8?B?WWdBVTlhT3hZbVRrZ3ZDcFg1a2xnTDdLaStyMzVzWVd6RENmblE1OHJ4cGNT?=
 =?utf-8?B?cHRQUGc0WHF3UHlGZnR6VjAzbFpuSkRxYVlHVjdoUFNIb0dJczNZOThiSllL?=
 =?utf-8?Q?NSnMK4Vf3ynixU+xgR+ImLU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AyfCEfWYpSBS6lvgsFdqBg2owmvbdZezfOD1i51EDMamEBE+b5Jeoz8y5w8fBxZ2kpcmYnwI0/68Rf6jBnisc6gzFu9CRiRcwzwtxfZaQJIHPc0mRUWtdy7YqvMMsUVT3TRKf7lieuDZrVBV1yjlrbMvUFUe1VM4tNcoMX7HMGk+nhZtlKqVhsNvSIbYve5uBoB5WI6hMxyG1eEpkILlCIKosP8inmoCmiWcryEk0P3il5MOi39hXrkw9L9hhczv5+qbgs5CGWXDe74OfashDNvlYNcOAJr154YpVtBsp0vHLZp0WWmc89pKarxa9DgilfVm4YsJlQQEK+kLW2wriXsPaJf+YWitr9lDoNWWKOVIDW4AU/NjgnLyCnRUA3uiB/EUIleKcq/dt8awtMqZHMl1FeZvD1Y88jVxFPcEocyp3W28rLkyg8tB1sZ3lrY/74wYBYPNLAzkqTqS8qwIuazIzl0lGvnGZZNvwaLS9OkBCz9kUKiFvIrRg4cO5aFDHNAfiRMc4ENktPZgKaLuE0I4kkNKoEsD+I6DL141LXQpP2P6xIe9J9mh1QQaeaNyQf0O/azLrO5cG5kC/xz5ivKmH/7jmBUN3p9VtQJvNi5H7v1HgADwn4I0St9GHsEjCsCieuJ7Sn0d198f7BHiJNAFYOFQ29WmVge4xiFGSTuJvL7Rto+yfezipKkFukdf3ESzBwOKrcblQrLcQbVIvQHh16rg0Oc01LIAkjaPztBRIqVJoP/LNaamkYJL7tDlGRjd4r11JnoD7gBKDrq2tLfw/l4xk1k3NnNTrXSCT0Wy74rKkdn07PXidxIHJtmMKOE7zfi5jhy/6ttSK8Qhawo1sXpd1urf1h09HwTdjuk3fiVhpZQySMTLLeqiTh1F
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c55215-6a01-4a3f-5058-08db886fbbfb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 15:49:28.1395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRrnVPo/awT4PeJo+r8pKJOZ5m3gulSfKFkXQMZ+nodjnwixOU9DeLIlxxz1g0Jgq+UibEWaIWzYPt1sGKqAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_11,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190142
X-Proofpoint-ORIG-GUID: 0-G0NLd40onGI-9Xy9QYKSvW7g09REEY
X-Proofpoint-GUID: 0-G0NLd40onGI-9Xy9QYKSvW7g09REEY
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 19/07/2023 16:24, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Jul 2023 13:36:48 +0100
> Alan Maguire <alan.maguire@oracle.com> wrote:
> 
>> On 17/07/2023 16:23, Masami Hiramatsu (Google) wrote:
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Move generic function-proto find API and getting function parameter API
>>> to BTF library code from trace_probe.c. This will avoid redundant efforts
>>> on different feature.
>>>
>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>> ---
>>>  include/linux/btf.h        |    4 ++++
>>>  kernel/bpf/btf.c           |   45 ++++++++++++++++++++++++++++++++++++++++
>>>  kernel/trace/trace_probe.c |   50 +++++++++++++-------------------------------
>>>  3 files changed, 64 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>> index cac9f304e27a..98fbbcdd72ec 100644
>>> --- a/include/linux/btf.h
>>> +++ b/include/linux/btf.h
>>> @@ -221,6 +221,10 @@ const struct btf_type *
>>>  btf_resolve_size(const struct btf *btf, const struct btf_type *type,
>>>  		 u32 *type_size);
>>>  const char *btf_type_str(const struct btf_type *t);
>>> +const struct btf_type *btf_find_func_proto(struct btf *btf,
>>> +					   const char *func_name);
>>> +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
>>> +					   s32 *nr);
>>>  
>>>  #define for_each_member(i, struct_type, member)			\
>>>  	for (i = 0, member = btf_type_member(struct_type);	\
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 817204d53372..e015b52956cb 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -1947,6 +1947,51 @@ btf_resolve_size(const struct btf *btf, const struct btf_type *type,
>>>  	return __btf_resolve_size(btf, type, type_size, NULL, NULL, NULL, NULL);
>>>  }
>>>  
>>> +/*
>>> + * Find a functio proto type by name, and return it.
>>> + * Return NULL if not found, or return -EINVAL if parameter is invalid.
>>> + */
>>> +const struct btf_type *btf_find_func_proto(struct btf *btf, const char *func_name)
>>> +{
>>> +	const struct btf_type *t;
>>> +	s32 id;
>>> +
>>> +	if (!btf || !func_name)
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>> +	id = btf_find_by_name_kind(btf, func_name, BTF_KIND_FUNC);
>>
>> as mentioned in my other mail, there are cases where the function name
>> may have a .isra.0 suffix, but the BTF representation will not. I looked
>> at this and it seems like symbol names are validated via
>> traceprobe_parse_event_name() - will this validation allow a "."-suffix
>> name? I tried the following (with pahole v1.25 that emits BTF for
>> schedule_work.isra.0):
>>
>> [45454] FUNC 'schedule_work' type_id=45453 linkage=static
> 
> That's a good point! I'm checking fprobe, but kprobes actually
> uses those suffixed names.
> 
>>
>> $ echo 'f schedule_work.isra.0 $arg*' >> dynamic_events
>> bash: echo: write error: No such file or directory
> 
> So maybe fprobe doesn't accept that.
> 
>> So presuming that such "."-suffixed names are allowed, would it make
>> sense to fall back to search BTF for the prefix ("schedule_work")
>> instead of the full name ("schedule_work.isra.0"), as the former is what
>> makes it into the BTF representation? Thanks!
> 
> OK, that's not a problem. My concern is that some "constprop" functions
> will replace a part of parameter with constant value (so it can skip
> passing some arguments). BTF argument may not work in such case.
> Let me check it.
>

If the --btf_skip_inconsistent_proto option (also specified for pahole
v1.25) is working as expected, any such cases shouldn't make it into
BTF. The idea is we skip representing any static functions in BTF that

1. have multiple different function prototypes (since we don't yet have
good mechanisms to choose which one the user was referring to); or
2. use an unexpected register for a parameter. We gather that info from
DWARF and then make choices on whether to skip adding the function to
BTF or not.

See dwarf_loader.c in https://github.com/acmel/dwarves for more details
on the process used if needed.

The only exception for case 2 - where we allow unexpected registers - is
where multiple registers are used to represent a >64 bit structure
passed as a parameter by value. It might make sense to exclude such
functions from fprobe support (there's only a few of these functions in
the kernel if I remember, so it's no huge loss).

So long story short, if a function made it into in BTF, it is likely
using the registers you expect it to, unless it has a struct parameter.
It might be worth excluding such functions if you're worried about
getting unreliable data.

Thanks!

Alan

> Thank you,
> 
>>
>> Alan
>>
>>> +	if (id <= 0)
>>> +		return NULL;
>>> +
>>> +	/* Get BTF_KIND_FUNC type */
>>> +	t = btf_type_by_id(btf, id);
>>> +	if (!t || !btf_type_is_func(t))
>>> +		return NULL;
>>> +
>>> +	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
>>> +	t = btf_type_by_id(btf, t->type);
>>> +	if (!t || !btf_type_is_func_proto(t))
>>> +		return NULL;
>>> +
>>> +	return t;
>>> +}
>>> +
>>> +/*
>>> + * Get function parameter with the number of parameters.
>>> + * This can return NULL if the function has no parameters.
>>> + */
>>> +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
>>> +{
>>> +	if (!func_proto || !nr)
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>> +	*nr = btf_type_vlen(func_proto);
>>> +	if (*nr > 0)
>>> +		return (const struct btf_param *)(func_proto + 1);
>>> +	else
>>> +		return NULL;
>>> +}
>>> +
>>>  static u32 btf_resolved_type_id(const struct btf *btf, u32 type_id)
>>>  {
>>>  	while (type_id < btf->start_id)
>>> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
>>> index c68a72707852..cd89fc1ebb42 100644
>>> --- a/kernel/trace/trace_probe.c
>>> +++ b/kernel/trace/trace_probe.c
>>> @@ -371,47 +371,23 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
>>>  	return NULL;
>>>  }
>>>  
>>> -static const struct btf_type *find_btf_func_proto(const char *funcname)
>>> -{
>>> -	struct btf *btf = traceprobe_get_btf();
>>> -	const struct btf_type *t;
>>> -	s32 id;
>>> -
>>> -	if (!btf || !funcname)
>>> -		return ERR_PTR(-EINVAL);
>>> -
>>> -	id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
>>> -	if (id <= 0)
>>> -		return ERR_PTR(-ENOENT);
>>> -
>>> -	/* Get BTF_KIND_FUNC type */
>>> -	t = btf_type_by_id(btf, id);
>>> -	if (!t || !btf_type_is_func(t))
>>> -		return ERR_PTR(-ENOENT);
>>> -
>>> -	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
>>> -	t = btf_type_by_id(btf, t->type);
>>> -	if (!t || !btf_type_is_func_proto(t))
>>> -		return ERR_PTR(-ENOENT);
>>> -
>>> -	return t;
>>> -}
>>> -
>>>  static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
>>>  						   bool tracepoint)
>>>  {
>>> +	struct btf *btf = traceprobe_get_btf();
>>>  	const struct btf_param *param;
>>>  	const struct btf_type *t;
>>>  
>>> -	if (!funcname || !nr)
>>> +	if (!funcname || !nr || !btf)
>>>  		return ERR_PTR(-EINVAL);
>>>  
>>> -	t = find_btf_func_proto(funcname);
>>> -	if (IS_ERR(t))
>>> +	t = btf_find_func_proto(btf, funcname);
>>> +	if (IS_ERR_OR_NULL(t))
>>>  		return (const struct btf_param *)t;
>>>  
>>> -	*nr = btf_type_vlen(t);
>>> -	param = (const struct btf_param *)(t + 1);
>>> +	param = btf_get_func_param(t, nr);
>>> +	if (IS_ERR_OR_NULL(param))
>>> +		return param;
>>>  
>>>  	/* Hide the first 'data' argument of tracepoint */
>>>  	if (tracepoint) {
>>> @@ -490,8 +466,8 @@ static const struct fetch_type *parse_btf_retval_type(
>>>  	const struct btf_type *t;
>>>  
>>>  	if (btf && ctx->funcname) {
>>> -		t = find_btf_func_proto(ctx->funcname);
>>> -		if (!IS_ERR(t))
>>> +		t = btf_find_func_proto(btf, ctx->funcname);
>>> +		if (!IS_ERR_OR_NULL(t))
>>>  			typestr = type_from_btf_id(btf, t->type);
>>>  	}
>>>  
>>> @@ -500,10 +476,14 @@ static const struct fetch_type *parse_btf_retval_type(
>>>  
>>>  static bool is_btf_retval_void(const char *funcname)
>>>  {
>>> +	struct btf *btf = traceprobe_get_btf();
>>>  	const struct btf_type *t;
>>>  
>>> -	t = find_btf_func_proto(funcname);
>>> -	if (IS_ERR(t))
>>> +	if (!btf)
>>> +		return false;
>>> +
>>> +	t = btf_find_func_proto(btf, funcname);
>>> +	if (IS_ERR_OR_NULL(t))
>>>  		return false;
>>>  
>>>  	return t->type == 0;
>>>
>>>
> 
> 

