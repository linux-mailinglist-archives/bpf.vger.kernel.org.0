Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0067957A3E7
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 18:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiGSQEN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiGSQEG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 12:04:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009C751422;
        Tue, 19 Jul 2022 09:04:05 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JDRAWl030336;
        Tue, 19 Jul 2022 09:04:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=l7docGpi0oXsQWAC64iBFYk20Ki65Ziy8cdgv6lAzIE=;
 b=qAcAof63+dgmmuK+tRWxJyr80BTgg+xy1P5SI4wSobm+r19qf2YJ/AUNLfD9IgadzAPW
 9Z0fBqWHxMBL55QSys0Our3jiuK1pX34mfq0eCM5vUaqkTNI9YMDxsA8qEx+ahlfEbzM
 RoqtzGBxeQL5n3EZbDav6mK574zzYKqHKR4= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hdvpq1gau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 09:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmf1n1StoKRt0ycz11kHkuUsyeFhKOqvCCnfTbUq0+E+NORpzR3paEF6D0SiUewLiwEBQPLq1VaznDlsgpcOkt6xo5A0iJefPHfJravb4t9SNF5aLq0WI0Zs9p1YoZa/M4hwwJWQ96gqf6wSM7ZVwQ/q9plreENPz4lJc3dhq5VbnCyc+N2VgUvdjuCbQ0bqm8lsT4BLmR2gM/JQdyNUOeBVYS5OqQfHavQJLXU1BfZKX1aAR7P8YL/LJib99eSzbzYIBtTovgsgpDWxyBFe/KC6RqM1q51goR+z3hnKEH8Qv0LvKDJ9MNmWDWQldmA7Ys/mmTWZVoFSNuoGvkCb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7docGpi0oXsQWAC64iBFYk20Ki65Ziy8cdgv6lAzIE=;
 b=QcPMOrqdSDWeYffCxB3kxSQuBXGG4vzEumONebGtHR6fxEhWON5n8CI1DeYsLrI+N1vpVKTHdeSldmugCtmN5FueowtywT4xAgR9El8zr3GzGmnd9STnv6yKcg54tC0B2HjPogSJP0+3AChycHFdfyh1fH1ovxIeaDiL9zoBfp2EVohhCnpwZ29ZWTDtaVVRVgF0tuN+VRwNbIrLJDn+jZ+Z6py3ImRuDeUWR9kGp5HZUrXAJxvHPO3w9IU/sAeCXpk8lYFW0z0Z5S48kBWmkGW6VuhJoGoc7pDhNFJshBWDvah0ABXrxSKJjg/Vz0CVvmUk0dH4SXkqJR/RGsNKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1243.namprd15.prod.outlook.com (2603:10b6:3:b3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Tue, 19 Jul 2022 16:03:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 16:03:59 +0000
Message-ID: <5500f935-f598-7ef1-c80f-6da7f12ef778@fb.com>
Date:   Tue, 19 Jul 2022 09:03:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v3] bpf, docs: document BPF_MAP_TYPE_HASH and variants
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, sdf@google.com
References: <20220718125847.1390-1-donald.hunter@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220718125847.1390-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0334.namprd04.prod.outlook.com
 (2603:10b6:303:8a::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21bcac36-09cf-444e-5c67-08da69a04aa3
X-MS-TrafficTypeDiagnostic: DM5PR15MB1243:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lhobm4oqQy1vcGph6lyWvWSLDPgUh62nEdeMelqbPRfmBQ9gQrnBERkhwoy/kAUUSn4TjKVNooXpCqsefG/uTdASD7lPxiMsgrZJ4UriUFLp4l9Neyp4d44CUhXQNdn5m4AUIVO3G7VVEXTa4ILa+Vz+SVtaCktLKZRWGRkcD5EBDXEJ1om+RYxd7RkzKefJL8bc9mwohVb1Wxg72xvI5gry0gCAugN1W+dJjLMlegovygOTpcA/ENiW1x/rsdhDrcGqD96NFvMUpO9cRQrnbHZMdyiY5tlkqaYSn0u/VPApqqGWv3zZ+AWPFC+Etug/MSvHQdy622NlaldUBfwdXgy5dSJF3RnyOSDi0bGmEYI1A+HXhCtEv5274LBSnpcUKwF6yqDSksoqoM4N3BklOtAE0gneTieex18J7lvABNqusjKGqLQH4TaLe48ItMom+TwIyWUClOLE5Wug3KCAncsm3lQ9VtCtdncUFxZb7jTn56giBQUnQp2PcfvgxVNC/ETs5tV7nfGF8H5fTEI+BPj4OebISEcVDbqCQlakOzLHM4WGl0VEW/5S6TmEzfUbQ7YhYmT2R4QtgRKwo2Eu5C0cbWnpy8pc95lpNYDPt5SNqqp/gU1PvY2ymEs/HDr/rSxO2aPJXCZ0QhdF8/lpJtF6t+MuDM3QSWuArHlRyH2dccvgEdIfHkeFauIfwW+Dhiwkr6cON+eGM38cez4jj5L0uXTDMTM/ssQB9Q6E0jEQVZdSken/8LI6GFD4yfQOOojwKynJJjwldXyWIwmDxOmZ4iDXXolNnWgh6V2ubzI5Trd/weulTMhMfkKDpiSRfS+VXdDk88MckcznGi+S9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(31696002)(8936002)(66556008)(38100700002)(86362001)(6506007)(6486002)(53546011)(4744005)(31686004)(478600001)(186003)(6512007)(36756003)(83380400001)(316002)(2616005)(4326008)(66946007)(66476007)(8676002)(6666004)(5660300002)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUl0ZENGSGdHMEkzam1HbHFnVzNBZHhpNEx2UG5wS1RCV0hHanJDZHo0VU8r?=
 =?utf-8?B?REI3a3pvY0tQUGM5T2drb0tyUVZGT1g1YnFLY21nMDBDajZVZ3JOck9BR2dU?=
 =?utf-8?B?Z3RBRkMyQ2k0SUFtN1lHRU5UbEVFYTFNMVBnS0dKeFZMdU4wVHJoaHI0TkZ6?=
 =?utf-8?B?Y1IvSG5jeGRsRWZxb1pvajFWZit6Y3hMTTR3UTg1ci8vV2dNWXZvdHM3Q1Js?=
 =?utf-8?B?eU94N3pGTnlwMWRSODFzK1MybGpNYzN2MXlCdUIwUFcxRzlkY1oxa282aEdv?=
 =?utf-8?B?ZS9LZGZDU0VxMDcyV0FoamdBRkxaRXk1WEpBZ1VRbVYzc2l2L3NobHVqQS9H?=
 =?utf-8?B?WjdyTTMvUE1tR210blpHczdrakpTM1dmSGJRMFZTem8ySXlsTUo5ZDhLU0s4?=
 =?utf-8?B?dThnOHRPM3BjdzV2bHFBK21RRG5VUGY2R1pKRVZvWnJkc3hqK3grRmpmYjEz?=
 =?utf-8?B?Mk1KdWZLSzBISkdPOWpXWlQ2UnFZVWl3SWZ0cVNQQTM1emc4eUFPTUNoVW01?=
 =?utf-8?B?aTZ6TzRZS3JNYkNubnFXUmcwSlYzRmpjZU5KUytpNURrbWpENXk4elVPZFFh?=
 =?utf-8?B?ckZSVzd3aUV4ZitCSUJFdlB1cWNhdlo4dU1SbnRZWWZoNVpXWUNSM2xpSERW?=
 =?utf-8?B?WkdCQWZuTUJRTVJlaVgyWEJJZ2JTQ3pmNklodUZIU3psOEYvbTVPanBUR3NV?=
 =?utf-8?B?WDgvVGZhcWlZbWVrYjBqb3dZK1RKQ0pNY0dSWld4TVV0OHltekZpSlFBYWdJ?=
 =?utf-8?B?MkN4MURtUk9IM24zYlBmbWpSWDc5R3JCN0MzRFcvbVFiMTZ1QmJFb25Vai9L?=
 =?utf-8?B?SjNlb0JWTGNyZS8vLzJxaFNpMEJVa3BHeGp0L1RDbG5NREVFektBQlFac1Z1?=
 =?utf-8?B?YlBWTHJIRTdhTEwyT3ZHeXRyRko4MURTSWJubXVLdUZtWERKK0RUcFFydk1Y?=
 =?utf-8?B?MVBiTHBvcmdxWDZKWWNaOTJ5ejgybkZtMzFhUGQ3NUxqcEI2YjdpQlp4U1M0?=
 =?utf-8?B?blhuM1JFNWxlMDgzRzhHL001LzdZQU1EcTBJK2lsNlNmeVVmS01mTUJBTnJO?=
 =?utf-8?B?VW0vQ2FiczdRc3JoTks2YTJYRlFXNUJPZmRSV2RneUVXNi9nN1hKUWtPS3J5?=
 =?utf-8?B?MVFVRjJ6UG9lamRiSGpsUXNCQm81dXBLRzJSUGVSSmp3S3pKY2dvUXdzMHhO?=
 =?utf-8?B?alh1d01rTFAwMnIvb0dPUzhFb1ZnVUxyOHJOekMzZnNPd1M5QTRpMHV1M1NI?=
 =?utf-8?B?UXVXVUY4b3hRbEVNZks3WkprOVo4YjI3Um5KZHVXNDNPampjTUlhQy9iemxo?=
 =?utf-8?B?V3JBVnNIMGIwd21JQ1ozNU1DRnJUSDdTSVR4TnV0YzFRRDFWc1BFeUFnMVVH?=
 =?utf-8?B?ZDVVRUNpMnZINE9Zb2VRYUtmWEZqVHZsQ0VPQ3NhbERxZ3JTNHJYZEY0VllG?=
 =?utf-8?B?K2RyazdscUhKSWUyeHBSZzkxNlFWOUNTQjBoQXFFWUNtUzN4cldiWU51cksz?=
 =?utf-8?B?QXFTR21mbmhuaFJkaTAyYmVqR2FWMlJwSjJiaHBrdlB4Y1dsSW14SjRYOFpp?=
 =?utf-8?B?cjFWeDgzM0hYZ0tOOGlpdTVpYmZHQjhMYjA4dFJVeDUvellEVVJkcldUUStu?=
 =?utf-8?B?RXE4bFVrcWhZNnZnWmM4WXFaOFd6eW1qQ2RQWG5QTitjSGl5bW5zUHVoNFZH?=
 =?utf-8?B?T3cvSU1JLzNlZmxRTWdjU29FOWhCK0RTdmZYRG1wYzQ2L3pVaWdMNDBvV0JX?=
 =?utf-8?B?ZEJkWmZqQ05MSnNBaTczTHRham5kZUd4Vk15TkZrdWtyOVZ2NkJNQk9OOEZ0?=
 =?utf-8?B?K1cxOCtxeFVucURNM2JaSHhiSjlKWjZrMktFTVhYaXNMWnlra3l3MW9kZG5i?=
 =?utf-8?B?SXBIQ1RuZ3FOcjZNa0pFMWNiclZyeWNlT01OWFpqV21xUE1WTll3bWdaT1Ix?=
 =?utf-8?B?UldjTFNObERTQ2VsQmF3SlJvdHJhdWp0RFUvTGVJSWUyd1NIbmNETjFheGlo?=
 =?utf-8?B?OS9WYWx5MXpWRng3SHdqTGoybE5QallMa29HWjVNMWZaR3dQam9mb1dCUFlo?=
 =?utf-8?B?M2tKVkZOY2JUaE5KLzdkRjlVR1JmQjlIem44K1pyWitFb2syaDJHUHNxMStF?=
 =?utf-8?Q?HpP77eI9Kf1x4nqaaioiFvhBO?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bcac36-09cf-444e-5c67-08da69a04aa3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 16:03:59.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: it5ckk02a44uQicg7wvhpRT3KHnxwc7C1Dwi8pWsEaoUo4OqIkiD/YCWS8xo/pD4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1243
X-Proofpoint-ORIG-GUID: _7IHGBUJEGjEOrV3JH3ZeR51xmHLzeqV
X-Proofpoint-GUID: _7IHGBUJEGjEOrV3JH3ZeR51xmHLzeqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_04,2022-07-19_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/18/22 5:58 AM, Donald Hunter wrote:
> Add documentation for BPF_MAP_TYPE_HASH including kernel version
> introduced, usage and examples. Document BPF_MAP_TYPE_PERCPU_HASH,
> BPF_MAP_TYPE_LRU_HASH and BPF_MAP_TYPE_LRU_PERCPU_HASH variations.
> 
> Note that this file is included in the BPF documentation by the glob in
> Documentation/bpf/maps.rst
> 
> v3:
> Fix typos reported by Stanislav Fomichev and Yonghong Song.
> Add note about iteration and deletion as requested by Yonghong Song.
> 
> v2:
> Describe memory allocation semantics as suggested by Stanislav Fomichev.
> Fix u64 typo reported by Stanislav Fomichev.
> Cut down usage examples to only show usage in context.
> Updated patch description to follow style recommendation, reported by
> Bagas Sanjaya.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
