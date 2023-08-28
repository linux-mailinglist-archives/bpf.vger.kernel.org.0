Return-Path: <bpf+bounces-8819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1339778A66D
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FE1280DD6
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCAE10F4;
	Mon, 28 Aug 2023 07:27:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395F5EC2
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:27:08 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3E8116
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 00:27:06 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S3TQY6007461;
	Mon, 28 Aug 2023 07:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9wEcoDW66feTNdg2qzt8PGcGYyTmU6TehZOIBpjmAb4=;
 b=ZBRhF7dZZkw9KtBT40NF7PqpsDtVGwRgIAk6BFxQZezeFfOrsGRgC3eAg9LRFm47DFN0
 EMjZBkrO1MP0ub++msKaI0I75JSFMv3hPjNFc3qY/iLCUoy300eaDTPS+7CXEqIi3rBT
 NQC4MCWC/Gsk85F67DxrnZcEqnovVQUdUomQZjL8V9CeBp184WXahMgWxAY5zhyeHqWB
 M9n/lKDvlpK9tm4jQ/YLdDIwEQAYf9osFHHzgzZSw+JJEIgQGqz5TLjYFVnjK8pie8bH
 cJRtaqnPqq1t7TBmm/0MfIXsC+rxAfxpe7JQ1wiQmer1rqtv0APn5USxrFiiqpKyLBLB qA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9fk22sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Aug 2023 07:26:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37S6STgH032686;
	Mon, 28 Aug 2023 07:26:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dkuuvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Aug 2023 07:26:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZnEcgFceVNond1ShU6NNKPlyAxRRBSA0IimrlLnPCFfgbxvDTwhx2kyZgsp/abnfiypCxnPtiJIfEOgim5gJBu/zD03fikGaHPrTvWXdrxcEYwcTJ/iKljnKkKVewrInvMyS+u+mcrYDMSBFnclFDXNkoCuGOuRJMRSRQtbi4CeHeg3rKmeJf723t8I9ecmvH63mgMZq2C8oPBpPlC6cJx5ruoCUvKltkr7fD+yMCexb/FCRAy7MiTE2DG4ruSQnH13mQkg01XtrbXTHIJN+DJJJigrKyuzMMkH00ra/koq60CNFuKhgLs1CdKN0/z9PuJCOauNxutJ9KEU6zPoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wEcoDW66feTNdg2qzt8PGcGYyTmU6TehZOIBpjmAb4=;
 b=O5r0iwzwQuaqsZrruDkyHIKnLTtTlv7tddLQQ714jpYiUDitWrqN9r/sQQF3Vdfdu/+Rdmw3fTFmH0h1bynuopoJOfB2M/DQLJPHqHdlRTeIEkdvCg6xT0DnloIyIx+vOkpM1BhsIgYic4p007sYIbJtgYPHOoP5h8a29mRoR2c+hOt9Nt2bQxVV7b7O2atI3u/exatINrgIuBRSb4tsUkPI5/eMhiqZ/QG5VKWdDrD8xLAVV/rg+nAJrIu9GmQsBBkBBCA5f7/zqUUqwa+k30SmbnL0UN+exeUyh2M/KtO81Y+3kStNtIv1ksU1NmpK/tjsK3RNH7VABznQe+eEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wEcoDW66feTNdg2qzt8PGcGYyTmU6TehZOIBpjmAb4=;
 b=pLQoeLxjvRoKtpAGMCrnOIO+0zrD8mLHKmI6BIaHlmNUdoSpWgEH/AGJm5yqfyAThnkHox1xlZqXLfQPTOaZUh6PifldE8n0UCH/z5bnN8rv/NYykmFitD3ScxngK+BjQnNKlsMHNjEn7zUz1USWN/BEFmWSupWPSOgzemj+B4I=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4805.namprd10.prod.outlook.com (2603:10b6:510:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 07:26:39 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 07:26:39 +0000
Message-ID: <a741f4ed-4da5-8481-236e-236d2f702ccd@oracle.com>
Date: Mon, 28 Aug 2023 08:26:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next] bpf: Prevent inlining of bpf_fentry_test7()
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230826200843.2210074-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230826200843.2210074-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0023.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::35) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: a161cffa-c111-4cc6-1bc2-08dba7981e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7ukdd/jPgJAEf8JCJzpgS057nKK4Z0/J/BcGrkumOfcAMuWgsjaI1vx6AQnwYn5KlukfHebguHDhQ56hV3M+HoyGAdxCmRtg1Q/V4Z7rjNfrtDR3fGHuOa8bu4ZTJm7uf/K4imCwq8nS2dOcAyVJdq68fEDjJvVgxrJK8jINFSO/ficoXTDLk9ng+SvcXVhvxINW+2tB5686sqhFcYIz/ZaldRcD6wb7Gf5+h1sbds0yld0dVyPh56E17y+jPdLeekXEy+YjLXn/2alddj7Y0AH/QBccKhRGOOuKppydFGaybGT3NdkMidgJFSC7+0bA55CwMOpoBPQWY5TjKlFs/8x+aFZd28+5i1n/4WYnDBe7MgUVRznBrcOZImveTexIGvpDcJyL1UQ8ZXjglET0XTs18RYIpdsoPpBqGF3nvkRimjjry2Ud/ZdR2UAQgpiRq6nsqU8kG21OI+avjE8U5uB5bAMQY3mdlRTOXOayzlHPEuVegKkQpUnm8wmBuQtAasZlBg/BPgPUj2HXUCIOq1lwHkMa93/ieDkc0yxfxXpU0b/ydsQUQJXdf19s5BNdivhQnEDslFzrznt/dvgf/TmxZyH6y2CGOSUq9HRVhveUDUU/o3pWbNI8bYuV94qyTn4tQhVFUbnO8v1nfnZCKg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(83380400001)(478600001)(31686004)(6486002)(2616005)(53546011)(6506007)(6512007)(6666004)(31696002)(5660300002)(86362001)(2906002)(44832011)(316002)(38100700002)(4326008)(41300700001)(66476007)(8936002)(8676002)(36756003)(66556008)(66946007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d0FtQVFFdThjYXVucm9jc1hyMUxsTWdvQzhuVDc1Mjdtb1g3N2ZMS1VhNWMx?=
 =?utf-8?B?MTVJSWtDaWQ0SDN2cjVmbnFVdzFLTGxOS3RGc3I3QVJFdlg0LzhTblB1cFBo?=
 =?utf-8?B?M1RSdXBGb0JoSDZHWU1Va2VBT2c2S2JDcVJ5UStsbjM5TlZsMnlCbU54Kzgy?=
 =?utf-8?B?eG5FY3pxMUxUY3RzSURXUU8vNjI5YUx3Z2tlOGc1Vmp4NGRiVngvZGJsMENH?=
 =?utf-8?B?M0hxa2ZSNnFIYXBuUGFMd0puRFlTZ2dWQUkxcUNyWCsyd2lBWlJWd29GWXN1?=
 =?utf-8?B?SUdEeWxpTWcxbFlObjJaTnBLWjVGUmNNdG9QdDhyRWVmbHQxVEpIY05MSVN5?=
 =?utf-8?B?VUsrR0VaM2xrTnp5eXdTZzBVZXBLODJqQVlyMmZOMVJjTlNXUFdTelFBTEMx?=
 =?utf-8?B?YjhNSFFqdWNENEJvRU5sZ2s0QjNvTm5ZVzZ5OGo0QTdvcmtZQ3B1TVFIVVFZ?=
 =?utf-8?B?UmN0VGp1eWhGL1Y4dSs1bmRIN3NOQUpPc1RHT1A3Ulg1VTg2UHNpVndVeU5V?=
 =?utf-8?B?Ump1MWEyNmk2R0xTRFd3VTZzR05nZVJJUGkwTW5nYnNueTFOTXkrTEFqU3Za?=
 =?utf-8?B?cmp6azV2UlRuTWJkMjZ1NzRvRWZOVmtaR1oyUURNOGNpbHhWNGVNNWZNQ0Vz?=
 =?utf-8?B?a0FvRXdLa0pSVnltUU90YVZ0SDhTNFoxVmpGOGo2VUxVZDlqNjFYQUhqcHQx?=
 =?utf-8?B?UDVuaTF2dERVekd6QzJwOUsvdDQwTk5xb2xqNkF0UjloUTFGQnNsb3phM2Zt?=
 =?utf-8?B?dlVtdFMwM3JKVVZjRmZRc0NnRUJVT0FudWRDYnI5VTRCQjlRWDE0MGw4Mnlz?=
 =?utf-8?B?V0dXUk5GbnZBYnlrN0hXdTROQW0vT2lCSnFRWUN2YkduN0c5K295TVlIL09Q?=
 =?utf-8?B?L0l2VGt5VWx4SzI5ekcybmxpbzl3cGxGbmFqYmxvNUFneEtHd2l4SldTWGZL?=
 =?utf-8?B?amoydmNhNmtuZmdmTWpMd2JKYzdaLzJNbFZyNFc4MGMzQVBiNXdHME5IZXdn?=
 =?utf-8?B?UTZJbWRvNEZXd05Ld1FxSkgxSmpzeUNRc3BWL2w0SWZtZ0p2Slo5Tmo2RWtE?=
 =?utf-8?B?d253KzRDOWxURDJRZ2wvdzVSbEJjUEFMWjRSenF3RVNBK0pXK0dOb1dySHBk?=
 =?utf-8?B?QWN6WElRc3c3TEQ3c3JZMDlEdnNVKzl4UFFZeVh1ZEZoK1N0OWppb2JGWVVT?=
 =?utf-8?B?SWZiR243ZzRqQU8rTFcyb3A5alkreG1vQkMxSXYxbGw0bGJENnR6dXNSVExh?=
 =?utf-8?B?NUQrU3Q4cjZHZkJaVXhvamFxbDlNK1JXYlByZFoxNGJxeERyazBjYjQ5S3hH?=
 =?utf-8?B?dklEZGtQYVc5NWpWRmFXY3krbUdqdDlHNG5GZ2VrNlNzZ0luMzRpa2dVL3d1?=
 =?utf-8?B?MHE1OGQxSUt0bXFwS2ZuNldPejZ5ajZGZ1FkbS93NEZjaWdCOFA1N1hPVkFm?=
 =?utf-8?B?Sk0zRDl5c2dCaTN5a3VDTDBCREp5ZWUxbGVaZkhlaUR6S1QvM2NIamxHUE1o?=
 =?utf-8?B?aTBIMFQ4enR1L1pKNmJNZjFYeXUyZHlCRGtoWEpsaEhYcHdpRlYwSzkrbHp6?=
 =?utf-8?B?K2NNU0UxMG5TQUpTam1VK09welhkTnVVYlpjZnk5Q0tlSzVpK3ZIVURJellp?=
 =?utf-8?B?Rm11WVVXV1NQdFdFbXljVkptY1NyTWM4UCtiTUZFd0QyNUJ2VWQwQSs0RzZU?=
 =?utf-8?B?M2ZHbVNjN0xpTENUdEtTWmhjbXFsSGpJYk1zYzNvZllsbDlTMDRUaEtzdXkv?=
 =?utf-8?B?OWJEanBhNmtnWVQ3aUhmbnJ2TXVCVGFpaEpPWG9QVGREVWQ1Q3dpQmVNb0dC?=
 =?utf-8?B?S2dHNnVqU3JPMmhXb1VsNzg5WXdORXZmL1pqUm9ud000UVhaVy9WKzlmdlZO?=
 =?utf-8?B?V2svY1N3T1cweGwybkFKVzZiQ1F2c1RyampNYldGY21WYUdwK1pMUjllRGlo?=
 =?utf-8?B?YWtrYTdxWHBjcXFzcmNvTXh6RUdWWkJ0cUFlcGJBdkJEaG0yaCs3M3NhOVBW?=
 =?utf-8?B?TndMUDNZRTRKdS9Na1U5OVBESUs1YUNOSlZJRkFyTXVBQTA5MkNaQjRFcDJT?=
 =?utf-8?B?bnR2V0ZLY1c2Z0hTZlFuYzhYdTE3aEoxOFgwUDl2VTJCZ2Jycjg5VDRxcmJs?=
 =?utf-8?B?ZDVGNnZ2cjJseUFMSEdWanN6QWMvRUM4SmxLdUFPTGh5RzRnUllJM0JpdWFQ?=
 =?utf-8?B?dGgxc3lldk54cVhIWWw3ZEQxVFZlWU9oczRscnVVMDJPeDR4SGhGL2Q2L29a?=
 =?utf-8?B?MmY5c3FlWGJpS1NNZVVZQU8vZTJ3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aVgW0ai/rTKEH2CymetxgQ8SGcO1/2HiuBvcIWjqwY5bPMal2vjeDRMAWJ8Tx58TM/0d8beMysCN1Zl1Ae/9g6yKobsp5KTBMr1lVyHMXeOCtLaZTqWQocYYnPhnck15fV3QuU6/LFDyB09yK5VwhFHds2Rc3tibWLGhurjs2PQzAKLqrJMCt9RVM2C61dHpd18A+3xJSJCKkiKb5nc0TV2NO+hDdI22NOQMOub6uUpUIZQEfjK6oVzMA0ucgGQzd63UeqSbSS149rWpj7pSpdZXpvE0CUKWZJ6L4LRS8O02Fm4+Wn9QhFyxNC2vEbO3Np47DfKrBc9vxdRBKlRD6Qj3qSg9YfTI8wjRsx4MYJejoDGTBqDiLt/tMcWZ863SNxvOo1V0Tx/t7t6TuvVjTsv7ZOUzr3gdegCslHYejyqJblDav0nIQvzWLDYFGCuCY4ihnaFiBFF0veSW9BWcuLV0fzsZdy9vbhUbBNUPJAFBOpZ/vL/wmw/9KMrjbkfVLOIDK2fuhjX9RX10xd73qwuBlVvY9tR2f1KnkkCByW79/M5s6GXrc2Dugeqhx2YHxrnODm3uzuFxj2XA5x+nOY+oj0ef5jdos5PDdJRqQOOFj9RpJCWF35z+eEfQMElNJQgfX65CzrrZgEoAnM/gO7EVrJQQlYEBNgnRj49or5+CTVsRGZzNGGMCXPNIDJF4E0OfcBYD3UfO1Na4tYjMlypAm7A2KzrFS3U21kDLsvhk3Xn1BbVKUNUAjY0iQyd9D2QWBOKr6pF44CnKKlUGo2IeYx+gj2vXNJxihlCO1iSL75Z1gLIljGKEcvepCS/NadkctdGC9Jg/7ZrDYflygV5oM8A0V1vIZO/5puaBXllpkxq8bWfL8YAkQfvIEr1x
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a161cffa-c111-4cc6-1bc2-08dba7981e59
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 07:26:39.2392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPRDMErPfpYxBGF2wFsyzyWNZG+160bj465wo8Uvk6z0oxMW6RJ+45PuQFQKkTsu0o4hcPSJrzrwjWxzigPMBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_04,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280066
X-Proofpoint-GUID: ODvOsaGT2MdW6Jkm1Bey5M20Pq8diTWF
X-Proofpoint-ORIG-GUID: ODvOsaGT2MdW6Jkm1Bey5M20Pq8diTWF
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/08/2023 21:08, Yonghong Song wrote:
> With latest clang18, I hit test_progs failures for the following test:
>   #13/2    bpf_cookie/multi_kprobe_link_api:FAIL
>   #13/3    bpf_cookie/multi_kprobe_attach_api:FAIL
>   #13      bpf_cookie:FAIL
>   #75      fentry_fexit:FAIL
>   #76/1    fentry_test/fentry:FAIL
>   #76      fentry_test:FAIL
>   #80/1    fexit_test/fexit:FAIL
>   #80      fexit_test:FAIL
>   #110/1   kprobe_multi_test/skel_api:FAIL
>   #110/2   kprobe_multi_test/link_api_addrs:FAIL
>   #110/3   kprobe_multi_test/link_api_syms:FAIL
>   #110/4   kprobe_multi_test/attach_api_pattern:FAIL
>   #110/5   kprobe_multi_test/attach_api_addrs:FAIL
>   #110/6   kprobe_multi_test/attach_api_syms:FAIL
>   #110     kprobe_multi_test:FAIL
> 
> For example, for #13/2, the error messages are
>   ...
>   kprobe_multi_test_run:FAIL:kprobe_test7_result unexpected kprobe_test7_result: actual 0 != expected 1
>   ...
>   kprobe_multi_test_run:FAIL:kretprobe_test7_result unexpected kretprobe_test7_result: actual 0 != expected 1
> 
> clang17 does not have this issue.
> 
> Further investigation shows that kernel func bpf_fentry_test7(), used
> in the above tests, is inlined by the compiler although it is
> marked as noinline.
> 
>   int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>   {
>         return (long)arg;
>   }
> 
> It is known that for simple functions like the above (e.g. just returning
> a constant or an input argument), the clang compiler may still do inlining
> for a noinline function. Adding 'asm volatile ("")' in the beginning of the
> bpf_fentry_test7() can prevent inlining.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Fixes: d923021c2ce12 ("bpf: Add tests for PTR_TO_BTF_ID vs. null
comparison")

...might help this land in stable trees too. Thanks!

> ---
>  net/bpf/test_run.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 57a7a64b84ed..0841f8d82419 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -543,6 +543,7 @@ struct bpf_fentry_test_t {
>  
>  int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>  {
> +	asm volatile ("");
>  	return (long)arg;
>  }
>  
Is there a risk bpf_fentry_test8/9 might get inlined too?

