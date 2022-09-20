Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8B05BEB46
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiITQnK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiITQnJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 12:43:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61EA66119
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 09:43:08 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KDtEXx012219;
        Tue, 20 Sep 2022 09:43:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=llGIG0aTttENjdTbzDo4x+PHVYF6NkT1WLQMhtU7d9U=;
 b=pHIowubOl3/2p256m3sM9dNs3O0ivw2f5P1AsRhOGcJVmWMZSPf9LVZHFMyh9LqKgpIZ
 j7pF+HdfUtCDNSTv4uqZzr+96re195cvpg35yn1faeYGgqaGwbpY7BqrPfdtKyD//GsJ
 r3WJDjJE2qq0KtDfnz3naw3oVP3J+8mVBTI= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jpkp3v5we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 09:43:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm+ESMcLAQZAXwuEMv6Kif3sVfEddzr1rnpklRg+NnpjJeZk1DviVGgBXEZ0FzHCWRmOAthnza7T2mLds5T7LlzGbcHZuJyikiBEafLUoStqZtTeOq3nPV0pXA4nhrBud4u+x/r3/uArqHzWEgmOkM/v1+qHSIiaZmhWziS0jx6LscFNl3J0mwRIZR4Z8dsZYRxzfi8TOF8fqivg4KMdhvk8PRZ07KkP8q/zvoD8zpFsFeR/N4uMWZukb9hXwcKkT5HStdXPZu+m03ArhWx21fQ4id6XfFwazp/5BKnP1VWo1+DqsmU0n5u33ldXyrsvJfMQT/BXx20Q6JJszhp9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llGIG0aTttENjdTbzDo4x+PHVYF6NkT1WLQMhtU7d9U=;
 b=FHtmgBPhiC/nhXM2cJOr8A4zV3i07H3xc7maF9tI48TdBmYWwA2xKyLPAdRVgJAKRwK03vAU2dhT12JeVBT541wl8f18Mrp3cxKAeTF5M2eDvJ09uYXu8tu/XoZn/HjrCtoGlex802tScfxHXgfpPIb/LI5oQmsEA7+o4VGhv+ENqovJw15uVFSGjvRVqflaNveo1I3VfdKydOksoBzsJbrZJpnAJMvbaLeQJjuQCS/NwUgQLqaaoFliW9TTF2oU+TVzzzfrCo/ejSzi55AulW27Kxlsjpjol8wDzUXJGHEjwNCMOhtwvF5fbECCG1R/s6xwjPUmnC2HUBkJ+25iNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB4269.namprd15.prod.outlook.com (2603:10b6:805:e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 16:43:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 16:43:02 +0000
Message-ID: <737a8c08-5f2d-304a-adb8-f9f33d9e3ef3@fb.com>
Date:   Tue, 20 Sep 2022 09:42:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: LLVM 15.00 github repo build panic to run
 test_core_reloc_kernel.c
Content-Language: en-US
To:     Vincent Li <vincent.mc.li@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CAK3+h2ykSR=CXBDZs-_9JjBTim=2E4QHAzvkP=WR5Ke3EFd6Ow@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAK3+h2ykSR=CXBDZs-_9JjBTim=2E4QHAzvkP=WR5Ke3EFd6Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BL1PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:208:2be::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN6PR15MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d70dabd-ffe7-4c4d-08cb-08da9b272f4c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REEXmDIO9aHetK9UjvuyF/FQkSsD069h4wGBhxBjVEtQxD385Lj4GsySfI8u/cTHWicra2AQT4v1aq1ZQmEBMPsh1JWvqc/eWJxOS03nXhdcfLga1WsEwvH8ntvecbDR8riTrJloTFsxl+YsCw6YONF7c2Wlj/Zfg2zB8obulcTkMBW76TtFqAqhOLsBRZoCf5ng0ib+iakaBzl20OdqMmtwlWappySFGzSjAeZ56G1mc3gdEao6+AOsHJdKub8ylbAWuzwsrXasXJ7JyjrdB2V4mlHm+fa7fs4mu42gOMC+4MU0v+/gJYjGQpqEJWZw18tmao3wxsGqp2j59yQ3ZdGUKCr9KzCZmO8RYGhmhaAYlQ3bfsIAP/nF1RJO/v/FcqydaWW3hEEIp8uxurtYgT9OS1/tvNZYZxouWC1QdKvwAL5+gQBnASBLWHNq9j/WZM8QBcrvwzK59ld+7UODUiHnWfhe/1SAJEPggBgtOcrI3Gx4627aJ01NFeIRv1D2NIYuVnc2usBF/FmJj5YXRnsE2jf51JzGvW3Pq8z1ZdOCrL3acHT1Tr0JZbeekUShmoUsYcndrfV6D7ADK4NEVSownoTzWMYIckp/t75YsN20T6R+HLjt+DrMpjMA7o5xLRZKz+I1jBrShnvhbGzfomZHyHQ+sscXJM5E6yPmk9YTvZliW9oi2E/9w600dQVxTFvZwvyzD6sphGKDkCHY19eNnuI9SlJYTjnTZZvVumHmn9GHsSU2XdkY0PBfLtudGeNxc6yAtkHo++jmIqNr0W6qXiJWYxFsJs4K/Pw5Lrg6idBB/8UTA/5S4BkYlRLs62s8AkDCjIqcAtYtEBluNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(31696002)(86362001)(38100700002)(316002)(2906002)(110136005)(53546011)(6506007)(6512007)(2616005)(186003)(6486002)(6666004)(558084003)(41300700001)(478600001)(966005)(36756003)(31686004)(5660300002)(8676002)(66476007)(66556008)(8936002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWhyOEV4SGo2VHJDd09tdFNmNVl5RTNmbXNaM09SUkJ3UVFHcFA0azR2RmU2?=
 =?utf-8?B?ZW9iUzhhbmFRNzl1cGtVUzUzZ3YxUDMzS042MXRkM0pVSHM4VXo4dHVQYk1x?=
 =?utf-8?B?YXpHRHhERmpvd2pqWTE4R0tidXZiMmdHMVdoZThyM3Yybkx5YVhCTjA5eWJS?=
 =?utf-8?B?aDZTbVp5K0dqejJHR3dCMHdJTnA0UnhlaU5nWXh4T1Avczh0Y3JzdlRiNjJE?=
 =?utf-8?B?d2NGdFlyRlNtR1A3M1BNaXh3Z2NTZzRhOWVUM3BWSlA3MjlRRndMaDkyK0lP?=
 =?utf-8?B?YXVSNzVqanYzY1hmUzM4NHRsVVlzM3Q1WHdUbklSY0VjTGxndG9CaXVCU2NM?=
 =?utf-8?B?ek5DWGEyN283T1FWbGIzOU5oeHJZMHpNTDNHMDFwV2ZrekdpTnl6RnlyMXQy?=
 =?utf-8?B?RU4yWCtwcWkxY3lXMzNkQ3NHZ1EyNytoTG8xWVF2ZEdYeU5XeHcwYkRxSnMx?=
 =?utf-8?B?UjNNZGtiTUhEaTBwMldIdlZmVmM4c2JmK1FTck5hS1cvSHF6RjhaN285OWps?=
 =?utf-8?B?N3N5NUllVy9Pekhyd0IrS3Y5SGNmQTdaaS9CUmRFUVU3bVpQUnlOUXkvV0dB?=
 =?utf-8?B?Y29TUzdpZ1IvaTJ0dlhsWk4rWmp3Z1hWZXU0czd5MkczM3lpZHdZVHpxOTNK?=
 =?utf-8?B?dHdQRXpqdVQxTUdtcmg3MzJHOXVsZUVCZ2swd3ZrWFlPU2VXL245ajIxSEUx?=
 =?utf-8?B?d0cvZzdVMG1iOVRVcGUvWE9qd20xbjF3eXNRMU9BQSszNy9FK2VqdTRXa2ZU?=
 =?utf-8?B?cW5GUDhHZjFhaWMvNmJESVFKM2duY01JajVNNkJ0cnV6OS9BRXRrR09wZHpv?=
 =?utf-8?B?Y0poUEtXZjBqWHU2QnBiQUg2V2JOY2tjZkdmREVycDlyTVVzbG1FUmtDMnJn?=
 =?utf-8?B?V2NZcDlGY0FGaE5xcDlWcE9TTXB6ampTUkQ2UVpyalVPbnpLZjB1LytRZFFh?=
 =?utf-8?B?ZWRSTm11TVFDSWVFS0VOY1VJOVJ2TGdneFZyd3VnTGtsUkpiME9iVzFxUGc0?=
 =?utf-8?B?OGVKd2U1RWowUW9wZi9EWURKcWcyZEZZeGxEbkcxUzRoTDE3K1lrZzdGM2JH?=
 =?utf-8?B?T3kvMjZycEtFR0wvdEtkUGVINzhxaHpzcEF6UzEwN0piTkczMDBrUDlXSlBu?=
 =?utf-8?B?eHljSFdwdkdiM2xUUUk1NitubEdUYkR6TStxM3g4K2MzTmJGSHlJQnIwcHM0?=
 =?utf-8?B?ZTN1OTVheFJkUHcvS2VmVjFJMG9VUHBIVEdrUHZybzZhYjR0Q3JWNUIzaFZW?=
 =?utf-8?B?dWtMREdqQXJ4Q3YxVHRrZlZTZitJZGdIN3NUbDR3bE4rdHF6b0locE82N0sx?=
 =?utf-8?B?RWFvbi9wUkNNUUdDdXBxVkpSUWE0UnZndDNaUktZUWZhZ0ZKa0xKKzIxQ1lu?=
 =?utf-8?B?QUlPVFhGWWpnWnhDQ05tQ2JiRzZyWXVwQ09nWk1uSGdHUXdwWFFzcFZpU3Bt?=
 =?utf-8?B?MFkxVzAzVTRyY3dUUjlhTXplc0ZPbllDNnlmQ2YvMzA0VHloOURFQzUzaitp?=
 =?utf-8?B?VUs5Nzg3ZURhWG5yZWM0RWtQN09Rdm5NTTZkYW5zQzcvbDRTaWZvY2dOQUYv?=
 =?utf-8?B?NW16OGpVTG1sWW9ma0hubklZcjFDM1NuZ0kvVGZVVEhsVWk1ako0cmFvdWEv?=
 =?utf-8?B?cy85ek5KaUdwZnFUZE83VkpralVtbVZjVVZ4WnFqZVF4VjYwdkJCNE00MW4v?=
 =?utf-8?B?bXc5bDJKdGxJY2puaUI1M1d3VmVIdTJVQlRsVXAzeVhvcDNhdFNCTDZNeHNG?=
 =?utf-8?B?Q0ZJTkE1WU55K2RDSDFsbkF2dHEyK0R3OUEzRkNMSUJ2OXZiY3hGNTdIeDE2?=
 =?utf-8?B?YkZncmdKRCtoWFE1aW00d3dqUHYvMFF6NVVvaUMySm9xdkJLMlBtZ004Y2Iv?=
 =?utf-8?B?bUFtQlpVQkMvcjRqSmFxYmo5NUxFNGJFUkVFLzN2YmphSXNDdFpqRlNra0dL?=
 =?utf-8?B?MFBqeXVyaThvckZmQ2dMaVNaSEdNSGtHSnAxM0YrUHU5Tk1hditRU3JiUmla?=
 =?utf-8?B?SitBamFKQnFwSHlyS0c3MHBNQWo4RzdQQmxkcmxBZEtmTFNEbmRUR0o2Snh0?=
 =?utf-8?B?elQwZk0wVThRaFFSYVB2YnRMNXFDdHFuWExuOFRzcEZwYkJyeURaTjRrU2J6?=
 =?utf-8?Q?RDJY+QGP1RmdSWoiPNpwCV8X0?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d70dabd-ffe7-4c4d-08cb-08da9b272f4c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 16:43:02.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbD4LYd32hqkZ3I4McLJM1iCTxUzvAEq0hH//hYzdztJ6Vfv8CHfOKqISrw1b7B3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB4269
X-Proofpoint-ORIG-GUID: cBaZgzgdA0PjbbG8Ff1ZJ7ZVdZV-29HC
X-Proofpoint-GUID: cBaZgzgdA0PjbbG8Ff1ZJ7ZVdZV-29HC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_07,2022-09-20_02,2022-06-22_01
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/20/22 9:36 AM, Vincent Li wrote:
> Hi Yonghong,
> 
> In case you missed the report :), I ran into LLVM Clang 15.00 panic
> when run bpf selftest, I reported in
> https://github.com/llvm/llvm-project/issues/57598

sure. will take a look.

> 
> Thanks!
