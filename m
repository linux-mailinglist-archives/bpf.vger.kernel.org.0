Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784116216F1
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 15:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiKHOkO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 09:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiKHOkL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 09:40:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF7E12AC8;
        Tue,  8 Nov 2022 06:40:10 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A8BCpLY005338;
        Tue, 8 Nov 2022 06:39:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=iaoiTZX6PJNHXsYLY7+QR6eQ1b5pVcD8n+gs/W+9Xhs=;
 b=m/N9AD7GCpYHNTzFGb9RkryqywXHgcNKRgr9GBCAMnraLluwK7I57rSFW9LZtay8+71V
 prUIIE+CZhFQydVpM91dXZyH17aTb8Uw+9kxRQNosdbJ4Ww/AAx0aGC7611H0yEV9DCn
 DxnnMTR7IQCAzlUhIeaVHDOHZEGJ1HnIE252fZq4glnNKlBPRHEq22A3B3bwZ5TSldw2
 SZMgDOvCfyF/KFYo1sc/Hpsy3aEEgYcxu5bs9k99hwalUxZtZYLJptdkCKFlgYDhna6U
 ucIQ3FBUbnRcun83goLQzhpPyo/a0ab+ky3W5lTOTi61yLBvCCmxr2cUFr1spyHcP3S1 4A== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kqp1mhgvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 06:39:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+ELo9ShOfMooaQlXkn6QoNFOt+U5VLj0VDEK+09xJ07StpdTZS892G204M/MtQrdHM3ql+wJksvT1/we1DmYK/Ls36+NHce/IyKOM+xUn8hISR7E6eFwuaZio7OUJQVdP8j3ro8aIkJemmhipYK+DQgMT0/Cs+JlKF+urjCnPovDyA+eKlU29vIa4I7DKfFad4Vej9DqsMtSfbMxpHeNzNitYEneBurXoJHDaR2ZzJg+9sJpPIL2hg6F0Nwq8zhi8HQyGaWo11Adt/ZJqxfx4BZhWInUkJKt3sQP4YoPfhhcO9xjgzCOePdRbMO/w1F1hAXncsMAGRtSkQaE2wWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaoiTZX6PJNHXsYLY7+QR6eQ1b5pVcD8n+gs/W+9Xhs=;
 b=UvhEZUDSYmxj9yeNiksdi4unSKXdkC3gHTuHCVJD4DIZVp9o6a8Rgegr7MPvDReOfHJSOkEc1pUSW/0Ziw9vfHqrmsDM8Rw60DODgriYHS1IxyRSsnD2cjf3EsT45EQH9DeRDTmKOlv7NUTBH9bU04b7maG2V8kpSOXFJwhV8uBcuE/Z6FMZ1jo4m8WLRfJ2SAxN5YuR5RA330NzXmTTA0NILewSShvRNoVo5++sb2pXeTrhOfDNN9neRhFNA3ZxlfrNWnQqSfm3U8jOLqv7/iDU10fE5xvGWD8FR45VXsx8HVmlWa7Q/j1JoXoCjy2dKmV63slSn1KgUrS3/J/JyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS7PR15MB5328.namprd15.prod.outlook.com (2603:10b6:8:73::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 14:39:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 14:39:52 +0000
Message-ID: <afef6c5a-1ec4-9a9b-adec-aaed31f11d14@meta.com>
Date:   Tue, 8 Nov 2022 06:39:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v3] docs/bpf: Document BPF map types QUEUE and
 STACK
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20221108093314.44851-1-donald.hunter@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108093314.44851-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:a03:100::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS7PR15MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: e0440d37-4c00-4c67-e12c-08dac1971871
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfzElPWXHQUz+Oq4gbaJoBrxcZU/cBnhIx+I+3pzOm6c/8Iy3yhXqK7L8vXPh0PjBG50oPNJSJqVfqo8/hEtIQJ7ZSZGjkdXdugXVAbEFzdMobojkuLyow9PsuVIj10Zm7kGloX+NWfrsS8IvAxmwYmCmwF6yqiGCG7C4L1Y5mbxxotwg2HfVFSi+2Yd2nNxWg+T/L6s8/J183gwOcT/KaRXbZ4QSGd/Vbh9GM72+3XGi+AgvbqijqFtv6TBl7phiXtMhkoAkezKpGp1HYcegcQrqcWUFtRSRZKNGfLDrCN3hVmfbnriEZ4X0tHMkQdkIstiLgylG77pmJeT74tgDxmt/WWujfGjGsIoC+8IPy/QNDPgG+V9Gx76W4e2j13oq8WQBksRksYmGvY9zYeeauqxAHZwHIZQH87bC7D5iNazDI1oKOYKJwuawvJraM+YKwTyZJU7EFaA5tsCwRjUtqixJPTg/2SlHhf+ZjZc7fsQ4/q+eZw9hS/BuI2pn5+majPo3hMBJsGyK4J7AVAQXSRe6SPWnuLt+I4eJXKnRtgomp8H9lhBb4zQmq00jXOcH6OJO9+6NHnzBZW27hMPSebNZIlhtofVcbYzShlEY0m4lWYH54DlCiJZlXUKHXh1ucp5hEBgoYdKpBgLzmO7Zh08uj9tuVdgyDMAbqlZvfaALcOHbhoVGauN/4sQBWRqQWvJ3TLVYxiJ7zJwv5jlnNN7+0wWTGtAP2CF12K8D0xO6Dzvm2o5BAU0rMsrp9zVOq6HcpfsOlW4q6DDBuZj3e38Zd+vMWZ/U5lMWy8g4jw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(6486002)(478600001)(36756003)(6666004)(8676002)(66946007)(31696002)(66476007)(5660300002)(4326008)(86362001)(41300700001)(8936002)(54906003)(66556008)(2906002)(38100700002)(31686004)(558084003)(316002)(2616005)(53546011)(6506007)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUFnZlluc285UjJaQXBKVWNWVUtIYXZidXhJL0NOUHJNRFdKT2lubGZ2eGJW?=
 =?utf-8?B?V3F1STVONno1bUpQWkc5SmowNjA1bjNTVjh3cjZkenJJeEY5NEkyVnpmSHli?=
 =?utf-8?B?SmxmT1pFMUxUaDdQaWFqb3JaSXROQVEycFdzWDNxS2FUTG9xaEhKQndUSTRJ?=
 =?utf-8?B?YWtlWTJWK1VIL284UVZrTUV2M1dlNW5jOEd0cll1YzBvSG14ZjRVdWUrUVhD?=
 =?utf-8?B?aDBWb2J0THI3d05aTTg5MVF0M1MvanFBcFdNKzJaWTJSaHdlK0trVHRYWUwx?=
 =?utf-8?B?c2FsR1V0alJPVHlLZ1dqNFNxcUI3NTQ4YmRib3NjZ3JpK0RpRXB1RUNGUHdF?=
 =?utf-8?B?Ukh4enV1dTg3eTJxQXJpWllncHlGcVhsdmFMbGZmUkt1eDNxR3JoVkxuOW9h?=
 =?utf-8?B?SDAzQWgvdXJES1pORklqSDVMMFBPb0lVYjBoYzdSNVJOcFZ4TFhmTHVWcWtP?=
 =?utf-8?B?R1hiZWVpdWdXUTkzOFU5anZKUnJuaWRMcFFqMzdMOEM2Sm53NzlXZW9EMnFs?=
 =?utf-8?B?U1Bnc2FYKzdoVVFPemRBaWoyOUFsbmk0RlgxeDlpYWtoVFBBZ0M2eVZFL2Vm?=
 =?utf-8?B?RXY5NUVIWElVTENPVFIyek5kRmhSR2NMaldrbnlQU3pQZkFyRkxxckEyOStP?=
 =?utf-8?B?elM3NU0zRzN1Rm1vaFIwWkVCSkdDbHh0b0k0cTV3MGZ4RUNvb3FEMUFmM2Vo?=
 =?utf-8?B?M1g2OTRmdXNTSVFVRmlXN1NZVFA0L0ZQY3hBVC91YkJWeDU1bDdZNFpYVXNk?=
 =?utf-8?B?d3JpSjExOHdsWUFJeDVSNC9Sa3g2TDFWWWVoakM5KzlwTklqWkt4S2QvUHNq?=
 =?utf-8?B?UU5NRUpEbERrdVVMRVM3QmN5SjNqdXpNYjB2M2RCMGxiWitjcWl3RENFb0ZT?=
 =?utf-8?B?OUN3dTdXZytRYmpoWGNySEJrby8xbTRlMEZlUEplWVNIV2lDbEV4S3ZVeTdH?=
 =?utf-8?B?NCtoYnRVcVZTb1VKQ0RXMUdUVXF3Ry81UlNmRmQzOVM3VUVUZjZnc0ZNVVhk?=
 =?utf-8?B?Q1FSNXdoM3ZSc0xSNS9VdEgzMkx3QkphM0RUckRzbWwyZ0JqRHJEQVNQMDJt?=
 =?utf-8?B?NHpGY2tSSVduZlYyK1FxNHdqQmdDWGFFMEwvbWY4U1c3Z0Z1RWdmb1ZXOVZ6?=
 =?utf-8?B?MGFXeWkrZnJRVCtETU9Pd0dGQjZRQTlQczhuQmlTUFBORy9OSlNLV2U3NEJx?=
 =?utf-8?B?S2tLejNCNlVoeUZJOC8vd1lZVURnbGE3ejhjSFpCYm9neXdOV1VKL2pLTVRV?=
 =?utf-8?B?bHdiYXNqYml0U3lUZ255eVlXdG9ZbENsSWFkckI0R1JVTUluRExQdUhha0J3?=
 =?utf-8?B?bXhCVTZCVmpvaitQWE9WYldpMTU4dkFnSGJoU0Y5QWttaVZQdFVha3V0Z2lN?=
 =?utf-8?B?SllOM0VpSUdLaVJXekxjUE93NGhsakRHVmZ6b1cwRXFXZ1pWeXpiampNUUR0?=
 =?utf-8?B?TnhnekN2TW5PMk9CV25qV1QzaVF3bngzWXhYNTZHR0I4d0J6cTBIZ1VKRmRO?=
 =?utf-8?B?VGxkbVN3RXVVb2tNeVdpbEZyQjkvM1MzRUxYdTZ0cGhKT2U1c0xZUHJnMldm?=
 =?utf-8?B?aXliQ3dmZU84WHBXVCtoZHhFdjZiRHpWNkhuOTYzNWMySEJIbDRpaEJTcE9M?=
 =?utf-8?B?TjJ0dmdQSUFZcjhPMGkrZkorTTlnMU4yL29ZZFhES3o1azRrWDg2QTlza3dK?=
 =?utf-8?B?RHh4Zm1NME9JSzFIMFlvZFFTL3pqay9XL1ZSL0xMcWtydjZhZ3ZLNzE0MVND?=
 =?utf-8?B?TjZDUktxb3RlRmExdkNXc0ZBNlRUWEt5cnVVb2UyTEo4NHB4bXJ2RDhkakhU?=
 =?utf-8?B?NzZJNDYzR2hjMlB1amFNb0ExTzh3VmtGbEZteHlsRlU4WitlenlCVUp6WkJS?=
 =?utf-8?B?K0EvS1FiRjVmSGFQcVNyMG00MjlVWmt3a1g0VCt3ODlmZGhneFZyN3pyUElh?=
 =?utf-8?B?NFgxRVI0ck4rUGplWTNlS3dBOEgxZjg4WDI2VEJyalNNNVlCTjhJL3pPUFBD?=
 =?utf-8?B?QVBocVQwNkg3a3R2b3JGNHZlQzhyOE9JZExiejJ3TTRhd1lvQWduZjU3N0lS?=
 =?utf-8?B?MW83cTljZ1psc2wzcTBzTit6WXdxbmF0UGFEbGlDeXhKM21pRm01Q3ZDRmg3?=
 =?utf-8?B?S29lakVBRkIyelBXTnRaM1IwVnRvMnNibzF3bU11dkhkMitVS3NDNE9QYW5Z?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0440d37-4c00-4c67-e12c-08dac1971871
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 14:39:52.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQceoABNFzIzJ7V3kHN6uLG1JqNkxU/4jkQjEYpLj+wO/tk6tgHEHLBgkmwjSawj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB5328
X-Proofpoint-GUID: Tms3ZBTWEYtCegwiXdu5zHlRDFC1J-DU
X-Proofpoint-ORIG-GUID: Tms3ZBTWEYtCegwiXdu5zHlRDFC1J-DU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 1:33 AM, Donald Hunter wrote:
> Add documentation for BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK,
> including usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
