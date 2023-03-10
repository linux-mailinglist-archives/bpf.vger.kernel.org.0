Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019346B3B7D
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 10:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCJJ60 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 04:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjCJJ6Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 04:58:25 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C7D56528;
        Fri, 10 Mar 2023 01:58:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlXg80kcBB9gyLWL9dxMIxlsGnyJKXXb096In/8z/9cy3lOM/nzpkPXUkvEvbKLokEnwpsgGW3cMHakNBc9MRN1xp2JbCkV15jwYgizhChTymbe7guURQ7CxnyHH4Kf/fVRuisIzZ4l9bfxz57faV5EVY6oUsChrEHR3sOPYXpfhBshSrb0n6D6LcCWfB2a7LHxE/QsH3iD8MmyXGqwv8I1K7Zqb2f+rhOoh7RbbnCDHYTuq108vvaiizf3jZFsfzwhd2xj1J4v6W6QqZBgMH0djz9nPpP81RywMtaZ9FTaYLGt5/IMIXEX725KUr75XGrCOHHgptxprAkPXfBiqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYHJBIb9EpxxjYobCrwg7kyTJnDaIPt0LZUYRb38ehU=;
 b=HQ0sAElgbgc/kFu/aKsjoW3MhAjOlDjQV++g4GOLiCSo+zx77DyDQ4tCbvBhD0PHMde3MLPFGQYZVVz1bOvQlAn7tyjD32aNIneVMQ+dbh3UcZHWzOaUKU+oUNPS2/TJ9+28WDO/v/DiG8b6g6sK7k5/uO/IGLW00xw9Dgwle3CM+sjrJPh16Yh1MVbN+09EBxoRa52Vr5nsrezA5XlKsfaKIKXN20dzuDDRN8aLuEJgrgMAs/pMRz7LymIP1owBAUakHTvLtsiFk3WKI3UMjloFn2W/3si69TIvDUVdbbLFWxeUnhVSHbWyebz/IPTXwXax62pmNkFndxXyjeCIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYHJBIb9EpxxjYobCrwg7kyTJnDaIPt0LZUYRb38ehU=;
 b=wreQLTjS7BVzCX+3cHwu5xU9zCi8Yn9EMrelvSsFfelubsmnCh0iU6G8uQbEXLyVA8aeGRvI+yo9itpskIWp8U5fTfa1kYjk/Qs1tyBQ4ijMdjuj9l5hME1gzN/+t1VWg2QAbGUXXJ2HGJLbaHxhStQ96w8NDIBf22e/KtXgk3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 09:58:18 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 09:58:18 +0000
Message-ID: <f5b3de20-797c-4ff6-a85b-06c85b4eaa1b@amd.com>
Date:   Fri, 10 Mar 2023 15:28:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC/PATCHSET 0/9] perf record: Implement BPF sample filter (v4)
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230307233309.3546160-1-namhyung@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230307233309.3546160-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::7) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d312a47-db2e-4637-72e5-08db214df943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+aMEqnBwXeJXrF8DyUDe195OECT9XPlJMQeutAVf2p+EJFc3d2ddeT5n4qmb7RGCWyvzcaXCF4d1685IYmBriFpZPdzhsSbg48TOfGj/Yhwvrsl6PnOrJLJd28xpvqB7vVLEmPWfUxynZ4KDxMNwz/TKLdoKOiLcuLesKiS4z5Dx5CC51hn6gYu/Y9+Z0Ec4r1I/84v2muojAa/QbNPQSKhW5j5w188mlprFu52UOWdPDCo+2+T7E1rwkw0PKsVbiLMwZbE5BHhb9JTSQEAW0p10g4O+HCKJw3s99sTe7vqsCOt5160L97Ai0E6DNDDvXaSpjdRKfDFz1M9rUFaX5jDyJumjKSFH9ZoY1OyA/lcDMiN4PESwrPIHCVa9p7U5AgoLPAAMpcCedEX2BoeF+pTgQOE32aeNZDOilDBk4ySyX1HIkWnY2LzS7PrbOYmfSMrrF2b7FlibLWyVx4YSi6tgWbGfQxfkqSS6TKBFflBFQPBZR+cVIsxnUDxMaAeBilUkQ7SDxvEpiF5Z4lJw+57L4Glk7jBwM9jdoFk8DIhersLMd0X2GT3ekoQzDkx1o2eh4Og3Ct3PwAOmzTfDnuGS5TdAdzBz4ivoyz0hEZlKzDXDWuia5AxRGDJR3QBWg0M5b4z7flHJX/f/SeSaoYR1hr9huUnsbrUGEfiX3ZubfK9fxMRAkPcs7emmnKZVTim4Y7YMTmXkYVZkkX6ZWM5lJioGvRvHXifbUcT9uk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199018)(2906002)(31686004)(83380400001)(36756003)(44832011)(5660300002)(7416002)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(4326008)(316002)(38100700002)(110136005)(86362001)(31696002)(54906003)(478600001)(186003)(2616005)(6512007)(6506007)(26005)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHBUeGRFNzkyejloaXMzN2RILzIwUkplZE9ib0R2NGIyZjQ5Yk5SeEwzODVj?=
 =?utf-8?B?TGR3YjMxRWpzdEY0b3NPY0tkQnlncEtGbjg0RWtqcmZQdW1VenFZL2NMRXgw?=
 =?utf-8?B?Vm5VbWMzNXdtY0xkU2NwTG9TMXlKbGY3UGZvaWhxU3RrZk8zQjVaWkl6UWFn?=
 =?utf-8?B?RzJiVVZzc0JVVW1xK2hhOWJhSVlGSFFHemdnSkJMbmxJUk5NaU02b01MK3E5?=
 =?utf-8?B?bDZhUkR0OXdYN0thY1V3TEozeXdrMCticHdrMmxEWWJjSm0zREhkNmkxMXd3?=
 =?utf-8?B?RGN1OURpWWZVcVN4T0RFOWpOWHpLdUo1bkZ2NDRKd0ZId3BQbUZIcFZFQzFT?=
 =?utf-8?B?dVZUaUk1MDJyYnRBNE8zSjlxb2ZBTEdndXJndExoSlVGamdpTXU3dFU1U0w5?=
 =?utf-8?B?dU10cmljdUxiKzBLMjl0N3BoYk9OVTlWcUVPakJCODRhbkY0aGkxcjB4VFFn?=
 =?utf-8?B?NFlRMnFPTUg4UWNxTmY0Q3IvK0FxelY2dXFHRTl6SEJldjkxNHNjMjBzVWlM?=
 =?utf-8?B?eE1HVEJrUXRRK2dVeFdWZkk5NmpYdmxFR0pMK0REWjVyZDkxSW43RGpWSW1S?=
 =?utf-8?B?WDF6aXVTSDU4UDBndlJNRHJja0lSbGEzVGJhcGxlSlFaRTlTT2o0QXRLaEZp?=
 =?utf-8?B?Zms0d2FKMDVSbmNtQmRQQ3k5N3oxMVFjNkhvcmlJUWRQMXBaclU5WU9qZDlu?=
 =?utf-8?B?b0hzVDRmcFJnK2dEYVlETXF2NHFPczlPQ1ZoYlJYVHpzK3VoNGVvSUhRTTNH?=
 =?utf-8?B?eE96ZXlVekthVEpZajhoU3BDem8yVTFEZDFGckdmOHhnN1BpSDE3QzQrZllt?=
 =?utf-8?B?V0tYcFcvZmpSSGhDbzVYYkhMYmZXR0VCelVOMUJrYmJUMUVpSk1BY1E2Rnha?=
 =?utf-8?B?SzBmb3BqaDJxSTdrNFhlNE5oNEhwWTdVbXcyMEJnbVdxYUdJNUxLNVllaE40?=
 =?utf-8?B?QWgzeGFTdW5yRkYrS3VYTGR3MGordVBrNVJxL0NBZllGYVFFQ3RnZEljZnUy?=
 =?utf-8?B?VXBCd1pKSUN1cDNvU25qSDd3RjMzRFQ4MHQ0Yzl5SkRGaThnamVORWJzSHh3?=
 =?utf-8?B?aXo5TkVDc3JnOEx5OHVYdkdOUC9rUFUxbUxJMUkyZzY3MDlNcUE3SXJkUjVn?=
 =?utf-8?B?NHFyVUNZaHJ6RzZvbzR2VVVnaC9VZ0xkK3djYXR4Vmh5aUltbk15bURkUTQ1?=
 =?utf-8?B?K25KZjRSRDBqQ0FVaHA4YlA5UFBxQWM2cC9PTW9mTTgrNlRNWlFzdlJ0VnRs?=
 =?utf-8?B?clNGWjVjL0Izano3QVpybFExbjZxQnRMbktzMnBGUGU2NTNOb2ROQW1iMmY1?=
 =?utf-8?B?V0pvWTZEeE9wcjFBMzFaSWcxNVVoSldLU01ybUFyMjBEWXJ6d3VKR0g1VGI5?=
 =?utf-8?B?aUJEY1FVVU5idFVaSVBQMzdZSXBmM0VYVzJTdkRWNjFLTW90RXNyaFcvZ3FY?=
 =?utf-8?B?b3lHQVZGTk5ybjZPeVJmUHpNN1BsMVA3M2g2cU5YUTZ0L1JxdXlUNWUvQ3Jm?=
 =?utf-8?B?UnZDWjdlb1JMRmdvVGdWMnBzeWVQcDVNZ2FQUVNnSXo0WmV1am5RZTdFL21i?=
 =?utf-8?B?MGdlTkx6VnRVeHhaT0Nld2tOMXdCekNrR3FqWFFjUkwrOFB4d2ZSMmlHVFNq?=
 =?utf-8?B?TDZ6UU1iL3F3R01ITmVXS1QxSkFXajkvaUVHMHRFcWRNSVpaejA5SUJvUnI3?=
 =?utf-8?B?eUFSby9TT3YwdVdZeG1nR0hoY0pZSjBrbHhFdkFqSmxFekZicVZ5by94Vzlw?=
 =?utf-8?B?TEZmWGMxb2tQTmtaUmpTTzFxVjU2WlF6QW1PR0JPRVE0S3BDRStoM21SWUY5?=
 =?utf-8?B?L2R5K2czUXVaU3crQld6TE5QU2hBNEhBVlFSTWRvUFBwWmM2QmV6UWlyYmFm?=
 =?utf-8?B?ZFQwbFhDUW5ScjBmRjZocmowblBFaDVGVVJIR2pIM29MSU55TlVHL2c0Si9W?=
 =?utf-8?B?UlRPbWtWcnVhc29ZTktoaUF5Zm9tK1VCN2pVWXlPYjN0RnliVFBEWm82dkd2?=
 =?utf-8?B?TklCYUJpTTA1SCtRSURsWlpoc3R4SWp3aFAxNEdoZ3hCbGxCWURFbm9ZQUNr?=
 =?utf-8?B?NFBCSS9hTkRablBiNnFydlhTMXJReWFwQ0FPSElFUHhTSTc4dEFMdTkyNkZF?=
 =?utf-8?Q?BxieJLZPfsiBR5wjnHAOKoxVi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d312a47-db2e-4637-72e5-08db214df943
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:58:18.4951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PGrDW9FW29lenz3xVqNjvCOkUwNqgHCo6N3eHEWLUUrY4X6OASitbViGENoKWHSYZBvn95TJbjauI4OSswTVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> It requires samples satisfy all the filter expressions otherwise it'd
> drop the sample.  IOW filter expressions are connected with logical AND
> operations unless they used "||" explicitly.  So if user has something
> like 'A, B || C, D', then BOTH A and D should be true AND either B or C
> also needs to be true.
> 
> Essentially the BPF filter expression is:
> 
>   <term> <operator> <value> (("," | "||") <term> <operator> <value>)*
> 
> The <term> can be one of:
>   ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
>   code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
>   p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
>   mem_dtlb, mem_blk, mem_hops
> 
> The <operator> can be one of:
>   ==, !=, >, >=, <, <=, &
> 
> The <value> can be one of:
>   <number> (for any term)
>   na, load, store, pfetch, exec (for mem_op)
>   l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
>   na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
>   remote (for mem_remote)
>   na, locked (for mem_locked)
>   na, l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault (for mem_dtlb)
>   na, by_data, by_addr (for mem_blk)
>   hops0, hops1, hops2, hops3 (for mem_hops)

I think this and few examples should be added in perf-record man page.

Thanks,
Ravi
