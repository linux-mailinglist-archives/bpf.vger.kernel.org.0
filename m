Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B246B36BE
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 07:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCJGlv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 01:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCJGlu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 01:41:50 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4020BD462D;
        Thu,  9 Mar 2023 22:41:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S59FXM1unp5D5E6rIvDwz/QIZnY2b6nQZW1fi6KRUmbDjnamIF1fOpXYCveADe0ttVLdgVr2Tt+xKesAWWpdm/HhUZ5L9qJw8/wwOS8NaU7EqA+O31cOmme1+RmAy6KtdNDwR9Vu4oq6Fss6omyw8aySL9M86x02KRlf92t9WBNuoEOFdGSKP2Vme5Wo49GgHQwzb2UJM5veRY1NPiOZDZ5E5qpoy0gfXbPR9DjD2pED64mtDPpbhl4/vG6bA2MPH6QJeII3gKI5FJqWtywd+G/hz/wHIDJPLRKDzsEHRRtjfpSYGSvFPn4CK2+LTjXKxwbCxEJFp+DVVQXTRvgLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0O6d0NWz4oBUf5gbHOa6yEW5cT7LmuQdwQyuzis4iQ=;
 b=jLrR34rUzx/BN012y/sH0s9G/c9k0LG1tfwBGJZaZg427ufgwpzphX0hHr4PlkWqRxsPX29AGsvh+3pEo2/BuQ+YjC9iYXZRYMc+D8yo2IkRvlSKz3f3kbJcCwRm/C2TixOrBzp4rRMJb/8uOEA8aniCyy3xKA4x3n8KlWb/sYUa5nTSSEduxM0AuLlzy7T+sMhxzQsuO7agCsCMnkZo9Vlr4+/XB235xNMiiSOOFYP0kXkGKshD0IRX5u7rlW9xE9IvqFuawk1Yk0Y2DgJtDqxSVv7ICOJBXUdGnIfXF/aSVG63NKutatagR27JRcjok3adx3gfeUCAVq/hmZH/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0O6d0NWz4oBUf5gbHOa6yEW5cT7LmuQdwQyuzis4iQ=;
 b=Rnm+1se+hIkIGnx75gIYK9kH2z23qcDKG8Qm7MnlrGOD/xnaXcUxUJd5ICuVlW3abzW8QE7ZdzbrrP9ge74L1aW8pK8q35rzPHBgwFjjXm+sRD+Jk/64sOq6IEpLWRGIDcZ/+7NbnHZINLyJDLMd0QVg1TuqOXScE7bOtWZ+n1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 06:40:43 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 06:40:43 +0000
Message-ID: <9f692bd9-94e4-ee60-2174-561685b9b39a@amd.com>
Date:   Fri, 10 Mar 2023 12:10:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC/PATCHSET 0/9] perf record: Implement BPF sample filter (v4)
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
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230307233309.3546160-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3bc9eb-2307-4778-da4b-08db21325ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+nqJJiSw7ITp93Vb0Z80wUkGt5viiTTIWxe83xponw3qB74L0Wveh1934dJzqZI/SYmnc6N38X2/CM1iRprtewwa3oY3WzCK5As5yYfy4H81AFExo6fdSvsJy5C3XPJHLvo8GVZVgF+DOD+829Qz6G+Eqz5O3g1oM6aoB+yPByNFZ5ZV8JoCewdq4NuDKL3fU/ja+Yh6pFi3v/wkEfMX3+RmafzRjtuvkiAgNR3iaLzBo3iPePjmEnjZFkroY5X66tABkUqw/RWsuPx2H/ftUqKwrHhuY3UHFpb3SXTIuC5mueSZCapV+foGIVLx8Nu03jlPjlQ8G12jvaYCb5CvS2K+xMzcYupXZlwZ5azOYwG8vU2Qsfx+jejL6YqzAa2Ll1XuAUa3DIFqMBW/AQL0WFxgymMj5g4iRTABm4dM61q/frdwVoTQstR7mwuftABsufipgR62Ozidl8VMQMllYvB+AmQgYTobQN4KB85JaT1HekbRMHCIt2hefYz7QatppDTPU7qayio1W8xBph6HFzWQo1q0LdWtLpjfEYc+ej6nqbht22Fx40vSn1/W4k+R/OqJEuAq5NOfab5gyJFF6A4DBPDCGtzKtP6UCEx9EZuZXJvJwCwNfip9/qTKJ5jo3MnuIuZPQP0d+8c9T8HT1Sy9XU5mV6MEdcMHkv120aJbGPjoN0i+XXclwrGuGBBrlNgjrUo8a90WfF37Mbf8PvxtWcdDFL26X6bw6ecb50=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199018)(31696002)(36756003)(54906003)(26005)(110136005)(316002)(8936002)(5660300002)(6486002)(478600001)(7416002)(8676002)(66476007)(2906002)(66556008)(4326008)(66946007)(44832011)(41300700001)(6666004)(38100700002)(86362001)(6512007)(186003)(2616005)(6506007)(83380400001)(66899018)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW1kblhWNkdCOGxhVDVZVXlvaHluVVlUczc1bTJmL2p3amgxUE9mN05Xbi9F?=
 =?utf-8?B?VkxDcUJ1V2lQMktLd2puaFlwQ0ZMdnFYcjhKTkNqMjhPUVNQS1V6UzJFQ0N2?=
 =?utf-8?B?NTlLOFpXZ0Z3WlF3Q2tvYWprVnhHeWV5UXcvYlB1WTdBVjg0SmhaM0R1TkVt?=
 =?utf-8?B?cldsSWZlOUtEUHBDRmd3eUppRmpYc2ppbnE0VklNRUwvdFJMcHFsL2lDWjBQ?=
 =?utf-8?B?QmpTbHlCdlBIdE9hTTd2d1JoMlZ5amozOHdHNDR3eXZMcjAwQVNjYS9KUS80?=
 =?utf-8?B?TmEwbzluSUdJbUx5V0lWTjFITmFPZEU4bnNMYVkxVC9XR3BJdGZTUlB4blFY?=
 =?utf-8?B?b0pVQ0hKbFk0R2U0cVJhMVVTYzRrT0JtbkxhZ1lVT0x6T2xtaW9QOFRtRmFY?=
 =?utf-8?B?T1gxek9BTVA3cG1BY3NtQS9BTnFuZE1CUzJKL042N1NlNFNwemJ1YnZ4c0s4?=
 =?utf-8?B?Q01mN0Q4bk9vWHNIbU5MZTNTT0pXNlJ0NkVvV2xDZHd6UUNja0x5TElmdG1N?=
 =?utf-8?B?RHJJRFg2aFV3cTNhSnltamxVRWx0bXZGSlZocGh1S05iZlpxUXNsckhqZEYw?=
 =?utf-8?B?Q0l3eVBRNDBLVnVnWU5GZkZTUmVuQjlKaVZIL0cwOHJDOXpmT2t5eWZMYWp3?=
 =?utf-8?B?T0I3azc1VkdNcjkyZGNvM1IvenZHdE5pTDIxZ085bzB1ZURaNUxScndkMVYr?=
 =?utf-8?B?ZUgvRC9GWDZIUWV4VUtHd3l2aTY0S1ZNYlNpbEYxdnVhMGdSRXQxbUJnRVlh?=
 =?utf-8?B?clYyRm9xR1ZHM0NMUnNYMnV1N3dxU05CYlN4V3BxUlIwQWc0WWZrN1FYL1A3?=
 =?utf-8?B?a3R4SmhzdklRN2FFTG02N3Bpa0VFcU5IbW5HZTl2ZVRrY0FLR0k2UjhkcFNW?=
 =?utf-8?B?RzRLa3doaHBJRnJVZHhMWjV4SzVPQkR4VDhRWjVjRGZnWkxESDlqUkJpcUFQ?=
 =?utf-8?B?UnVQRVd6aE5nNm9saUcwTFdJQ1VUeGltdUF4V2E5aU10Y0VaYnIwZkJtZUJB?=
 =?utf-8?B?Ty9BYjRFN1pxRU16UVpUMzBCekJXUHU3bFRxMWhYcm1Qa2xNeHo3dWpHQm1K?=
 =?utf-8?B?MWRmSnNRVWIwZktyb1hwOTc0eC9LMDE3TEZUN2t0UkRqcWxRdVlKMnFyQUhm?=
 =?utf-8?B?Y2FBZWNZSUNva3JjUlZXZkRsM0tNYm4zU280YXRsNkdWMTJvRXBpWHlLbzM2?=
 =?utf-8?B?aW9yS1V2OHRZWEpGSVQwVVJHWEhzc2VOdS8rT1c2ckVzTlZTejFXL3ZyMEs0?=
 =?utf-8?B?Nm9odFRaN0s3Q0ZNa0plWGpGdlM0SWhNb3ZnMnY1SUtPcTRha1c0dGZoY2Vo?=
 =?utf-8?B?SEtYaWZKdXh6WjRubm1MLy9MU0thc1VnYTUrdTFETVFiOHdRN0dvd0tmTnpK?=
 =?utf-8?B?cCtZNUNMOXRodld6QmF5V0QySmhKMVhrOHBUNk5DZjNaSVRMdnNVOHU1NHRp?=
 =?utf-8?B?aXU5bkhnejZtMzlpdFFHT3RmSzI3aEc2ZnF0L3BQQUlTOU5wU05mNldBU3hU?=
 =?utf-8?B?dTlQNGVmUXUxRS8zVVNFODdQU2U3RjRZWktZaFpKVTRSdjhtQ1ZVc1pid0Ey?=
 =?utf-8?B?azByV084TXFKRFNHdldJai9Xc3JxcVZmZzVSNEVoTUdJa3I1SU9ZRFNyVVFv?=
 =?utf-8?B?YkRlTGlBdTBhaFR0UnVncXMxcm5MbXpLU1IwQTdHKzlrUjVRRjhUQS93VkNY?=
 =?utf-8?B?SkthcTNRemdYb0VMSStuZGJQendMSjY4N1BDc0k3VzNaZlZTaEdLcndPREFG?=
 =?utf-8?B?NUxzWXhuMUhGOFNPalQ1QTBJS3BBTjVLdE0yaHdQZGRHeHI3RFJQNWJYcnYz?=
 =?utf-8?B?VUdCaGF6ME01aXAyVUw4TlFsNWpaTmVRaWhlaWZvallXQi83QTluQVJDTE9z?=
 =?utf-8?B?ZzRZQThwSFdrY2FWbTlySktlN25xTVR2bFJHYjVSSWhlci9RWFp2YVRkYmxR?=
 =?utf-8?B?cFJWelptU0ZSSEROSXdmQjlvUGwvQ2UxbkpPU1JNci9xcjlGcmxucklGTDFP?=
 =?utf-8?B?b1dUZjVQT2VKQU00Q1kyUDBHeXEwNlVURFVWcFBjUTBnWVRqRmFzYkFDZlk3?=
 =?utf-8?B?V2psdzEwbzhSbWkwWkhLUkM2QWhmeFFvVS96Q3BYQUNobFFaakNMeDc2VDVa?=
 =?utf-8?Q?yxNERrIL+dPL5PgsLA644jmuW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3bc9eb-2307-4778-da4b-08db21325ed8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 06:40:43.0782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQA6LivAtNmMw844aPUv+84WQVUM3hBleJipt8NrhPiNbiaMNkcphaOHjWugL/2tl/GO6WUflhGm5+1KmqoGzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Namhyung,

Sorry, I should have tried earlier prototypes but missed it.

> Maybe more useful example is when it deals with precise memory events.
> On AMD processors with IBS, you can filter only memory load with L1
> dTLB is missed like below.
> 
>   $ sudo ./perf record -ad -e ibs_op//p \
>   > --filter 'mem_op == load, mem_dtlb > l1_hit' sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 1.338 MB perf.data (15 samples) ]

On my zen4 machine:

  $ sudo ./perf record -d -e ibs_op//p --filter 'mem_op == load' -c 100000 ~/test
  [ perf record: Woken up 6 times to write data ]
  [ perf record: Captured and wrote 1.436 MB perf.data (30966 samples) ]

  $ sudo ./perf mem report -F sample,mem --stdio
  #      Samples  Memory access
  # ............  ........................
           30325  L1 hit
             477  Local RAM hit
              89  L2 hit
              75  L3 hit

This looks good because IBS hw can't filter specific type of instruction
and thus unfiltered data will contain "NA" types of memory accesses, which
is absent here. So mem_op == load filter seems to be working.

However, if I add "mem_lvl == l1" (or l2 / ram) in the filter, I see mostly
all samples are getting lost:

  $ sudo ./perf record -d -e ibs_op//p --filter 'mem_op == load, mem_lvl == l1' -c 100000 ~/test
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.019 MB perf.data ]

  $ sudo ./perf report --stat | grep SAMPLE
    LOST_SAMPLES events:          1  ( 0.8%)
    LOST_SAMPLES events:     136332

What am I missing?

2nd observation, invalid expressions like 'mem_op == load, mem_dtlb == l1'
are not failing, instead recording misleading data:

  $ sudo ./perf record -d -e ibs_op//p --filter 'mem_op == load, mem_dtlb == l1' -c 100000 ~/test
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.047 MB perf.data (614 samples) ]

  $ sudo ./perf script -F data_src | grep "TLB N/A" | wc -l
  614

Thanks,
Ravi
