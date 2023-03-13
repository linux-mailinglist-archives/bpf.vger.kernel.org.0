Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9216B7CBE
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 16:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCMPxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 11:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCMPw7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 11:52:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA55577C8E;
        Mon, 13 Mar 2023 08:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4H0yxs3nrBNtKP0YcGudzXA+lGlXDODRqJDtm/o8yfScP8/+BtEN1IlaEkpm2jd21KqsYA1alquEKmUM2saol9quK4mJ6UV3sBp/O6LUQ2chrftZb2z1s//GNkzl5Sqzi6w7swxTHGb/zqSyYq7OuGqZPEGeLGPxYxfAwIThjhkxowG9VZrwWB/7XaHzvbLn/frBP4+FzvcgGYCvIUr2506M8VeaQ1fhc0et7XCGa8JiWQCUXNWpS+ROGXNiQxYZ7zEUINWhXymxjVDq9726PPnIW9BIbfM802MyiWbQjTxQfec72E9k3bA8xeoyaH8mjBL7eVW4rbYEhtW7jEBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adlrGznXuZpeHcklbVG4UdNDuImzefKq+HtruUCKIPM=;
 b=DRWtxVsSamIiNHC/47kghO/pnA7qA5EMyjq8jePiYETdqwedEcYVmI1RCREjN8SwTslNdn4NwSoCSeJ5BVyK3+zENnH6XbpkyCpfV1Y2oCB+1y/HV4K+iXnJHzMicXwvvQzoxeXaCk003+psblZTvq/XURZgeJI3+vO5QFGfcSRXH3bh9/EMcKQbx6rmVIr25NOxB81gLFxSsBXpFivxG6MQfxL4BM71htSkuCHXRiPhLlvD+tWEdwMKx7vkasjxfjYCeS4xAfZ6fFs23lgpT0lLyUsL4mvrsqrNIBvGZUwoY1pxu9WjManagr499zNoiixzGxSp6qQYwZ9UyjzHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adlrGznXuZpeHcklbVG4UdNDuImzefKq+HtruUCKIPM=;
 b=GNqYPP8nIQvSLYJow62166XaL2wo9CN9FK2T3pT2hPM1in4g1X4jDjsa1F1OUb1RC0oIvaP4qn6Xcojd+oWE/ws3/I/axO3GK32v4LhGvlGiyg/8LFex4FtVUdTiTBIMkn1ObGyetJLsfHDBgUoRfuZiINmADbZoHrxATBQpBUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 15:51:46 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 15:51:46 +0000
Message-ID: <479da7ad-66ba-870e-a2ac-c1378e2f452b@amd.com>
Date:   Mon, 13 Mar 2023 21:21:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC/PATCHSET 0/9] perf record: Implement BPF sample filter (v4)
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
 <9f692bd9-94e4-ee60-2174-561685b9b39a@amd.com> <ZAumkq2L2bo8wDCk@google.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZAumkq2L2bo8wDCk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d6ae51-7fd2-4ce2-207d-08db23dad92e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLdl5Y821loT9sJVXe6ePad+sSTc9JudWa++OnAEMgs6jwiX15liujqxQyn/EwZJ2u4Vg9GpW8jh3/oVLuOBtLFfcCxex8bRH765RbxqHEQXlLEdYkhkfpy9SexKG2rYMWguWJP3Z0EVGrVyc6PJ1ABZ2y0TZ/4teRxMlBJgtM2aim/+zdD56uB1iiZupdn7HLau45xPuiK1PtrvqExKxvTEHxMj7rJSscJlRYItwQt1mLtwGxDVLfbpIRnNP+eQtfnFNdQZFlUuUk1734i3syyoMANHqDau0my/FNYnRM1GLf2kN0BS23Z9ppCuoh8m17QSeYeWuUtFSELka+1aZdvBhcg/OiktyA8+UVXjwa6hInlycyzyCDDlSZavTngEf4TyNZhs1UrqPOMKdP74HBbD4pgYbds4PIMJevMTB24GU5ZUnGKu6ZPEh5v/Gjw/ulXrSznsltcNM+MFKBo77iFE4C1iatY4YMz/d7AwTEmD0ISgsdSfj289/ziSEGt1S1/6KmscyOe7Tlpn9va3H4TpyqdOI//iGSmxiIgxAZo1azRcNGa7kRNLBX8noLC8WQFVuRnUweDAtG4NYHVNOU3NLqRf4/UaGFKimIlXjkHTsf4vKQ+DzaeypNk1Ue8t2LR9zQx1CHb7jCHl/mLKISNVh9p2piJQFHF9rYAiVFfi/enWeRSmJaNC8EW9kv6eo7wZnBdD4J9ug0D8v+RWQrrW4iFcte5+1p1eOmojXbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199018)(478600001)(83380400001)(2906002)(38100700002)(86362001)(8936002)(7416002)(5660300002)(44832011)(31696002)(36756003)(8676002)(6916009)(66556008)(66476007)(66946007)(4326008)(54906003)(41300700001)(316002)(26005)(6666004)(186003)(2616005)(6512007)(6506007)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWI4NFNmdDJRTDUvVmZQUGRkajhQMFRGYW9JUXY1c1pJTHBZSk9uanhQdXV0?=
 =?utf-8?B?NE1GNGRBM2wyZlAyaVZuSUtqcFdZWlNnZDlqamZlYWFOSi9UUkNlUkIvK3VW?=
 =?utf-8?B?TS9Hc2F4N1J5ZkQ2ZlBRbXAzYjlqNllUdmVSQ0Rac0kzVGtKN25wblQ3WU5M?=
 =?utf-8?B?aEt1R05xem12eGhlS0lScWpBdmFLaThEelJqam5TSTJJbXh3MStFSVI3UlZV?=
 =?utf-8?B?V1NPU0hHbkdCYWp1TmEvZTVNSzFjNXBpTUZOWlFTM3VZdTRLTGtNdEgvQVdn?=
 =?utf-8?B?Z0RsRVpPQk9iTkRxc0N5UGNYaHBFdHdCVnBDZjJmVjl6OFpoNHZHVWRnMW9O?=
 =?utf-8?B?OHlIUDR2UUV3K0NMdUpEdlB4cVVTVFk1WFpKSmFaMnFuTkRtZmNCQVM0OFJp?=
 =?utf-8?B?Wnp1MTllVklHVTZIQ2lXcGM0NjErT1UvUnVsTVBHNzBUSmFIYUE5ZHI0aTlo?=
 =?utf-8?B?SGlCYXBMblUyUm91c3EwaW43eC9PVVR2dTQ1ZkZsR2QxT2xRZVVzT2dETU9G?=
 =?utf-8?B?V1lRdVhiZ2w4eklyV0FKamJmbk8zdENhMGZTYW1tRDd2SjVlUmFuZ1F2VGZs?=
 =?utf-8?B?V0NhMzJWQmNjdGZ4dXZCSWRCd2dHaWtiNy92QVNBVGRta2JZZ1BJMFZOUW5H?=
 =?utf-8?B?VU5RZVFDN2g4WWM2K1VzTFlmaEpaMUMwMllKb1lJV3A5RjJhb1hBcno1bW83?=
 =?utf-8?B?S0ZmYjFDY290NzVvemZxM1BOMEVFSCtuZnNuVVV1a3VrZXhoZGxSRGd2ZG50?=
 =?utf-8?B?cVlJNldtemlBK3N6d0p3bDVrQWJtbHF5WitDbmczZzVMNjBCTGY4QUgxekdB?=
 =?utf-8?B?cmR2YUd3VXhUZzhoSVVNNHduQ010eTFxRGNVWE5STENRbUVpRDh0QXVrODND?=
 =?utf-8?B?TjZNZis0d2pYbXhJVGtwZFpzb3YrcllIb21KSzJSNjNiY0g4ektPcTVDamVq?=
 =?utf-8?B?eWdrcXJjNmJoTWpMZXgrK2wycTFFY05oQ1dUNWdHTlZuUlR0eFp0OEVQSVRD?=
 =?utf-8?B?NXorR3VnRjA4MmNFU0JNSG9sNVNDOUhkNWJTQU5CbGVGZ2tvRjZ4RHc5YUdH?=
 =?utf-8?B?Z3o3RTlRQXJpNkNJK0x5QWY1NDJPa1RFblVjUTFxME9IMkZYb2I1SkVJUGRx?=
 =?utf-8?B?cEJ1YXBKZG5uQU9ISE1UdXB6RFZnRzhTeUsrb0NaMTRIbHFQcnFBemFDb3Iy?=
 =?utf-8?B?eXlhdkVrb0xuMENIdWN5ZE8xOFNuajducXlMeXd0WHFKNmRsNnUwTThjVWRm?=
 =?utf-8?B?VzVpcEw4eTFNQmR2N3Z1V2Y0YVdEaXh3ZC8vekwvY2FSSFBZWi9BMFd0VnRC?=
 =?utf-8?B?bDFNUnViSTE0NWJYYVhWZldDUVZaOFRlVWdGdkcrSkxkakMrajNKK095OXRo?=
 =?utf-8?B?VU52c1ZXNjFGdEtEd3VLdUJmbThCUHZIVzVzaHptL0RvTFg3a2d3MUk1R0NC?=
 =?utf-8?B?MEIrd0VadmJIbEx6WjhLZkNiTU8ydFgrTmw4bW96aTZSSWFwZzY5RVlHV1JF?=
 =?utf-8?B?MVRMNzVHWVZxK09FaVNWNVdpTXkxMk1nL3d0WlJOeG5rTFVpMWtvVW1DRVVW?=
 =?utf-8?B?SXh3UGtPcmlxYlk4YWxyU0J2N0Q4KzFVcGNOais5dWZ3Sk5UOVlnWWEvQXVm?=
 =?utf-8?B?VXJBaElrOVZiVmZUVDNOWlVHZ2ovVnB3Qm5RV0tVQnFWRGNxRHJsVnE1dFhI?=
 =?utf-8?B?WUtPc3lEQ20rY2k1SUtKUkdVYmVXeVFvdWlTOTZQYkZLMmEzVFAvRERlOUlQ?=
 =?utf-8?B?V1ZaVmtHc2JCTjNiTG1UUjJua0RVMStLblIrTzZjSnBrdkR1cEpuSU9nRW52?=
 =?utf-8?B?OUY2Uk9ZU1NYc0QveXNaWHFKT2FaWUE1bHk2a3N5cUpITTl5UHJsWFpRMloy?=
 =?utf-8?B?T3lTTkQ5S2FEakZVcm9sMkl0blBOaVRhdklUOVNUZDZRQ3N5TjdWM2hneng3?=
 =?utf-8?B?SzBkYjN3Q003N1ZIK1NicHFXRjN1Rmg4eVFibnMyVEtzL01Ec2VqbjY1c0Jk?=
 =?utf-8?B?ZXdlVFBreUZ3WGpnNFB0ZmpyOTJGaVBCT05sY2hPSEpMMzErRzc1Q091MElm?=
 =?utf-8?B?VGVGYVJYK0p0VXVjemRJN2sxS0ZqakZJdFlKOWwwc01JSWdzL1d3dEpyNUln?=
 =?utf-8?Q?mtuxh5jglUcv5os4uaRN2XQM7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d6ae51-7fd2-4ce2-207d-08db23dad92e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 15:51:46.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiIWf9xQj0vcaJYanjBk7m0UaE4PBm0e4m4hxaP4opkHWvXtJIxA8yCGPEO7+hh/XJ3t8JBcPKqgacILUYC4qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>> However, if I add "mem_lvl == l1" (or l2 / ram) in the filter, I see mostly
>> all samples are getting lost:
>>
>>   $ sudo ./perf record -d -e ibs_op//p --filter 'mem_op == load, mem_lvl == l1' -c 100000 ~/test
>>   [ perf record: Woken up 1 times to write data ]
>>   [ perf record: Captured and wrote 0.019 MB perf.data ]
>>
>>   $ sudo ./perf report --stat | grep SAMPLE
>>     LOST_SAMPLES events:          1  ( 0.8%)
>>     LOST_SAMPLES events:     136332
>>
>> What am I missing?
> 
> It seems IBS PMU doesn't set the mem_lvlnum field in the data source.
> As I said in the patch 7, 'mem_lvl' actually uses mem_lvlnum fields
> instead of mem_lvl because it's preferred according to the comment in
> the UAPI header.
> 
> /*
>  * PERF_MEM_LVL_* namespace being depricated to some extent in the
>  * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
>  * Supporting this namespace inorder to not break defined ABIs.
>  *
>  * memory hierarchy (memory level, hit or miss)
>  */
> 
> I'll post a patch to set it separately.

Got it. I saw your patch, will review it.

Thanks,
Ravi
