Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A874D4D54C4
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 23:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbiCJWpG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 17:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344459AbiCJWpD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 17:45:03 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F97B18FAF7;
        Thu, 10 Mar 2022 14:43:51 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AIOcvo013561;
        Thu, 10 Mar 2022 14:43:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cj8vC6MKlMkMiXpgp5sGMrFdppgrAxN8NvlCwvnfMJM=;
 b=q3TFvvhfD6HJOA+68n1ZLlktEUpiNHu8ueLJnPB5NmrU6L8It4+yGDVhY6p5Ec+8Y+O9
 En/0j2OFeBzhlqsbQDQP8Lgo4hUaTbL1SiCKxjxH821pxeMx+PWiji17zAPb1Tic4W3o
 YjsihcXWek4OnxH9kJAK3L7f1bpv12hE2K4= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqpk71yyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 14:43:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xipmn7EyW7FNUdx+UP8R31BeSJ0YrLUjvzQLkH/kL8T1y9ngUdf6S6lJxKv9VjO4OAMDUd9L2GfdFL8vXYWQ0hmvpBtcYHzD5qZC347/0xKCGkY+iBnnFT6kI2G6DsZ+fJvUVgIwhGykBoArm2Gtt6gAjDN4H6MeVv3qd7lEyRCNCqzV7PJK2BJyBtNvHY9gZoVtVjsoDo/i5YkUpTaObzbm+Jad1U8MsOUuKtkzeeB4gsQglX5PEsXFMdF+uD/RHjLHOj20LqUvA14ox+HJdOUqHeNWy3brc0iaY+mz0mQBh43HGhpV2LS4YYfdPTb8xPdFrEonx8h//4T9zoBpeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj8vC6MKlMkMiXpgp5sGMrFdppgrAxN8NvlCwvnfMJM=;
 b=PG+9HUOUBFpZAJPpCZYbehTvJ88pcyP1ywn6ZKM4mAUmdQtbxSpBVuzJ+OoYI9Kl4QWxdbdmM0tldjyJmmMIQRYItFbGeD6Hhkm05a6W3C1If0Qgt1QoI/vKRH57yTk82BLe+hvwnuwg6U89fkxctEA4vg6ZDOdwEd9rFSJ31AxxqI37x5ZIwZk63+HI6excdpSq1ooryOgMlUl7XZfQERpaKjCa40kFF/i4JklVRbJltlEC7f/rlT5pxoR1plMXs5GdjYl31GhzSpB5TD451CPVnAXbdnPInyB/dEozhpmxteIoH0cfIx0UWhVp+XadecQU3YuTNRrI4RPXq7qkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2815.namprd15.prod.outlook.com (2603:10b6:208:12d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 22:43:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c5c7:1f39:edaf:9d48]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c5c7:1f39:edaf:9d48%4]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 22:43:32 +0000
Message-ID: <f2584838-8297-6c33-c4a0-39f20f325e6b@fb.com>
Date:   Thu, 10 Mar 2022 14:43:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH bpf-next] compiler_types: Refactor the use of btf_type_tag
 attribute.
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220310211655.3173786-1-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220310211655.3173786-1-haoluo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:303:85::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01e92d31-b028-49b6-e230-08da02e76798
X-MS-TrafficTypeDiagnostic: MN2PR15MB2815:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB2815A86D38BCD2BF675C3178D30B9@MN2PR15MB2815.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQDeUMljEFFmeLqWl4LXy9hdOqhziCKCJoTsQyXfqkHQrnXinMG17xNTr3mmx4rn2pzRLaGwuzkSM0y5/dcObbp4bWzFVRxtnsjRbD6Lru0Bvf7880r6RBn2ut+LAhnye3LFGOWQQMngf32ox9yKDZFiMMXRSoSNTQzvoWnH85q0BjRQvnvZupbmd5EIGAjSEV2fCifIFNm9rqb1sqlW0TxPimheKiPy3uDlgms1cnR3jAdyBMFYThdOS+TuWJycM0VOvtmKu5sbwDhbJ/TgBCEC6Mw9aUCrckcsUfzdNNFzbv/L0w0OM/2KZHt4GUikgWmt038/c9URP005TXZCdPEYjHsVuNXPlzTz80J6IJdPo2d4Twp73epfFpbH+jyr+wzIwURnU3dqVQBy+eM/rSmxlxE4Bc9WsMvVsuzpyCZkwDK4tm4comt1em1fW45uDtDQIq7qfXlhXfed8EwJT9H6+Au7nX3oKsOMUaAnPtPfjm2LMCYEb8YzPqBEDNqWcI5RJJgC6eBWcqx2UbAMSvsuToztLsZhjuX7qUGRpNBKECKKPMlkLBjmr6iAPiXxaG5olDVGiKV+s9oCrWaGsBwFAoG89plnZ8lXII01BwWyGnRE1maa+fMqfdr+T5wbfCdOXqJFNHZJqwJN7+H/yLrBA77HM6jiIwrEBAsVkqyAOKtWOXQGGtkXE8rUq2C+RomHWVng7KT8KIweciXIwH0V66FacrkwSLs8C7SzDNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(8936002)(5660300002)(110136005)(6486002)(4744005)(8676002)(4326008)(66556008)(66946007)(66476007)(2616005)(186003)(6666004)(508600001)(6512007)(53546011)(2906002)(52116002)(6506007)(36756003)(31696002)(86362001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SS91RUx2UXEwT1JqSVpzb1V4QXBvTWhxRXpsYnlzampoSm5oTjJqTzRYN2Qw?=
 =?utf-8?B?OXU5NTVoQlNIcXpzTGNYM3lPS3Izb3paWlA1bDBUYVZRZCt0TmFIOU1GK05M?=
 =?utf-8?B?dlozNC84Ry83bWtETkFlWmlLKzAyQVp2eTdFMlF2bjhDbklXVStOa0VzRVhy?=
 =?utf-8?B?QWl1d1FOVUpaYk0yNkhrZ1F3UVh3QWlEc2ZKSTFkdG90UTVYeElLdFViQTli?=
 =?utf-8?B?d2RMM05NaWxNZmRuODJFRE5GNndhQTcrZXVTblJSS3BaWkxYR2ZCOFhOS0tq?=
 =?utf-8?B?bVN3Ym1QSkViOGU0YWxMbWp5aWtnajBGZ1RJS1FXUDBId0hQWG9mSDNncUNt?=
 =?utf-8?B?ZUFUditSK3pqQWpDMVdIYUpJSFdtN1I0bFBSTmwwWGtSaW9OVXBiSXI5Tk1y?=
 =?utf-8?B?TzgzYXBLQ2pCdEtLUG9kL3BqNndRTGVwUlpmRXlySnYvYlFBR3ZFM1NzMG5r?=
 =?utf-8?B?YlZWLzhFYVcyeGpHNVhBTUMwT3hwRzROYnNZMU41cjRZRDVaWlhwVW1HYkY2?=
 =?utf-8?B?WXhEZGNBU3htT2F5VmU2YXJtUklHUnMzeDFvb0hKYVhVVEN3dUIrQVNLRTcv?=
 =?utf-8?B?dFlITHBCYjZqYWRVYlVQNVNvQXlvTk5HVUhKZW1YYkoyNkFTU2VkNW1Va3BO?=
 =?utf-8?B?aHZGSnRsSnovYzhBY1ZMK216aE5QN1pPR3JCOTlHSDgwMGJUdEhsR1NCd2d6?=
 =?utf-8?B?YnNMMnhVUFJNNVZMa3EvL2l3Ukk3V3FhTjdmaHVma25LOW4yRHZWUUkrMXpU?=
 =?utf-8?B?YVloRnpaVCtqTTdBWDR3WVI2bElpYmMzNFZ1VDVpY3c4dWFMT2g5Z2hVNnlH?=
 =?utf-8?B?R1cyOVBCcGE5d1BBK3BvZVh6RVMvdTBUUHVST3VtQWxXQ3pvMlZ3bWhDZVB3?=
 =?utf-8?B?YXd6MFQ1cDVId1JZL2o4eTF3YkVSNUdvTGF2RUdHTStQbmdlZk1Qb0M2OVJj?=
 =?utf-8?B?V2VvMlJOdW1kRmsyZzFZUjMxbFhjcERsTUlJMlNMN0E2QWZuUkU2UmdBMHFy?=
 =?utf-8?B?eFRhNmVJclY4QUlsQ2xhaUJBUzdxcHo5OHE5ZG9YZFJRTnRVaUZKUjYyaFBB?=
 =?utf-8?B?S0d0c2s2aFU4aXdUSVU3ZVhPVGhRdEthUzNEUlBBMjZsLzl2bG55QnNhQmdS?=
 =?utf-8?B?empBSkYxd2wyRVZubFNFRzQ4MkVhTWQva2ZDbXRLcVlVb3hjVTUyT1VsU0hh?=
 =?utf-8?B?eXZLWnQ5dXlHVStiSjFvSWlGUVBycUJDZytUcC9QbUZlYit4aFlydDZZMjFS?=
 =?utf-8?B?NERicW5qMTJTNER2YVdwZ0kwd2dwTXpRTEdzRjRIMmwzbTIxQWl4ZE5jVWwv?=
 =?utf-8?B?WjlwZCtqL2h4dlFlMjMyMFk3NTk1UFNlbkdZVlRKY0NmODJZSnpkTjBMa3FO?=
 =?utf-8?B?Um02MFVHL0hSVUlwNzd5QTBZd01aQWxhZ3g4NFQ3dDBqS2c0a25Nc1hiK2Y5?=
 =?utf-8?B?anlMeUNrUEswcHBaeDloSHJKVkNMMlZ4UVFDeGJHL1Bwem05YkJQZ2Q5Q0Jj?=
 =?utf-8?B?dGRuV3FzMWRSc2N0ZkMxbHkwRFNqVzlwUHRJTEFNekJvdHBnckRsZnVWOXBS?=
 =?utf-8?B?ZFllTGNKZ2JxczV3ZVh5WjU3aDFOeFM3anU4eDk0SCt0OXpQQU5OdldyckJT?=
 =?utf-8?B?VFJNRFdsangzRklpY1BKZEYwUHE3SnY4VzJhRThoc1FsZXI3S081TXhvWUVR?=
 =?utf-8?B?d2pOdllFYTZpK2ZzYjFVVFc2bHdmTDhYQjRhZVM2WG1Zb2plSzZvek5Rc0VV?=
 =?utf-8?B?c0NXdnZwVzBsZXFCcWhaVFU4K0JSaTdmQkFUZVRJemVWQ0ltWXNYTEFrV0ZI?=
 =?utf-8?B?NW1iUitrandFMjFzdG8wWUxJbXpaMDJHaHpGUVQ5b3dyMzRwRk4vUzlTdDF5?=
 =?utf-8?B?dG1QVnd6RVlOUThkN3k3ZnlDS0VFY2dRQ2kvKzhjRWlYNGlHOVNQVUlWV2d0?=
 =?utf-8?B?RWVDSW5HamhPaEVxRDhZMGhsRWFtMXlja2o3RmVKbVZJM0RaSUw5aGlXRTBF?=
 =?utf-8?B?Q2MvY0ZjcUZnPT0=?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e92d31-b028-49b6-e230-08da02e76798
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:43:32.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+uOjzipJxuPOFbhK9nEAdQF79GuCQkFXe9qOVFuc1M7alVeP86om6xAsBZ0RjU7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2815
X-Proofpoint-GUID: 4jsj6YQkkuM55jxc2n4NwDoq-apOm0sy
X-Proofpoint-ORIG-GUID: 4jsj6YQkkuM55jxc2n4NwDoq-apOm0sy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/10/22 1:16 PM, Hao Luo wrote:
> Previous patches have introduced the compiler attribute btf_type_tag for
> __user and __percpu. The availability of this attribute depends on
> some CONFIGs and compiler support. This patch refactors the use
> of btf_type_tag by introducing BTF_TYPE_TAG, which hides all the
> dependencies.
> 
> No functional change.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Signed-off-by: Hao Luo <haoluo@google.com>

LGTM. Thanks!

Acked-by: Yonghong Song <yhs@fb.com>
