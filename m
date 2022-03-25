Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD264E7934
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 17:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359819AbiCYQsN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377012AbiCYQsH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 12:48:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25C6E338A
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 09:46:33 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22P0IU9C028855;
        Fri, 25 Mar 2022 09:46:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3UYm30fSWfyuZyGSuLg4nyKRdKbh4HSbVhMUHcfpw9A=;
 b=YbyO/EzGLBPt2g1c96I6nGQsExXQI0uKehiCs7jFXgWMwf+jM/sYWNfaH2gbwoL8BUCg
 NR5mR39dZiq5qcE+Rbj7amcuNN8STGR2+kB2SsVk3GaULnM4gLrXQXydwSA7aH3ZyzAl
 vWy28LLe3Xb0PoiquXxJVFghICkDynLs21M= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by m0089730.ppops.net (PPS) with ESMTPS id 3f0rh9m6c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 09:46:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+WBtA/tMSPeytd0SNYX5J6W84McZNtPUjWPOEFT98HryLKbdhHMvkqA5SM5JRnU+Eu0kkgqR97rBrqxcIPr1LdQFLHvaEHcZSTclzPyUTaxEF5N7ZraZXDJ+7JZ/dT695dqZ79AmAj72Adk+mjbeVlXPrUfC/Rpllb3GWiZrwq/ikMAMRmQd+yktbU9mY1qY76eXsmPQ63FqrbrpVynTwCXzuvttKeS1cUc7BeW5PwFDKPlIPTlDIQwzUQ7xRr2IomlBeAz5xpAvRPEtmv2jWSRXu76OG37uOdbeXwEBzDKvxx1VJhGr9hqa7CNBY1uZ0NONWVRBoCEhn2owrmebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UYm30fSWfyuZyGSuLg4nyKRdKbh4HSbVhMUHcfpw9A=;
 b=moUNoMYaA/4+h+zS5Eo7umdg6mHqUTrsI/yvWChRPix41S/lWXHvOr5lVjMC+cLnzTFOhoV6Tj2LeewaNAp+HH3oERCGf46M/1UR27OvU6grBZYxAyyBY0udf5drpaOkaehO6oI7venYONIxHUchqalwtR739XVBk/t4K0zfxSlBruaLtPG7isoaMlmhkYb8Tjf8WhZLCwbmRLsbAXqsE3GAEc3Pjlzra3/UHpxUb+tdRurEjTKCA7cGN2CZ3kLxYobssHifP7iTPHUs+ktmYDg0xHsj0c9awlToN1BTBQHJ/sHMYrN+jYOQXIVaflnkza93WKK4cIEli5HTvMEKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2332.namprd15.prod.outlook.com (2603:10b6:5:88::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:46:26 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 16:46:26 +0000
Message-ID: <2dea8e1c-b3c8-d9ae-aed8-fc78dd624a51@fb.com>
Date:   Fri, 25 Mar 2022 09:46:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] [PATCH bpf-next v2 0/3] bpf: Add support to set and
 get
Content-Language: en-US
To:     fankaixi.li@bytedance.com, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, andrii@kernel.org
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220322154231.55044-1-fankaixi.li@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MW4PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:303:85::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11921681-945a-496e-92aa-08da0e7f0106
X-MS-TrafficTypeDiagnostic: DM6PR15MB2332:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB2332865D3781747595FCE42CD31A9@DM6PR15MB2332.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARTwB1aLaC5UDGaTwyujkk6p+OIvlSZ2v+OHEUR9EPgvDXKM8fHfDjxn8hlDw/7bxxtV1qTE05MqmYnIW1Ug80j3dMsNh6Zff7NmseC+W7qMboSpmFdzrzJj9n5rwbVJ0VfFzNr21ptFpFsQggIFK0oU3gcaOkwuRGTCb8M2kOj7MHcvmKvDcbH5g8U5RQb5ZaJrHEajkx4jqt3EQWTK4fUxot7Zw20qJqhIeQU7geCNfORQhTTdCV/VqWLW2MsizDImxeB2hT7UjqgpE2KfsBLr4V+6KpRgKbSOHHBxqJPNvQlXB1jFF8G1FW2noot0eaIWbeo621rgB88WStUMPcbJ2uN0NHoDl4aYY/Z8Wy1SYUOI3LzYxhdzWjD5nKH5ZLWSiuOkTm4DdUkmPuwpzl/Y3/ebO5yXqWgzlb8Mkyqf++N//9JIinMPpvX+owdZTkaGx6AVPuWBFNpI/DimSyWZ1TBM1W9OSfqC5bAJBAoWsAQIUTvEQlhgFcrp6ynoVo9c0I72/6601wxRnoarBvoSt6wXQGg9eMPkyqaaYTc1QNh1vpfuKIcYz80zI01ixAf6D6MwuheTB8YwI8yDCLW/tGtuI6Y9z1TzFCX7SK1YNVMrKEidUUTn8Ar+YqPH4hmNnkLqNrbeJJgRR0eTclFc4Dgpe2LEhdxkE//l0P7GKlb+HbpeE2umzsVfDRWG7SvUAFwV+AoQvet1Z0mcuCRpCUzuMCcdfswH3uWe7gfw48ZtIZLov22mcWeyeX/AcUBUbQVW3akiSy7YWkLsPxx+de/nl9SkLQkOWnearJqIiuV4kZHpaAVX6HZVZ+IS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66476007)(5660300002)(2616005)(66946007)(66556008)(6666004)(2906002)(31696002)(86362001)(38100700002)(316002)(8936002)(83380400001)(6506007)(52116002)(53546011)(186003)(6512007)(966005)(508600001)(6486002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0FWYURiZC9wSmRnNFpiMkNDTG9VSWFVRGNFMHhXR1JSa0I0eGJ6c1hsaEVh?=
 =?utf-8?B?TnJBamtSVHVqSmN6djFrNFEyYzkyMERuLzdqYUVxczZMeDNJdFp4amgyN0FE?=
 =?utf-8?B?My9lSG9sSUwyTkJ5eG9MWjZWMmtwazBGbmUzOEM4OFV3MGpKMktOZ2YraVpa?=
 =?utf-8?B?SXpRNmk2WHJZL01oZ0g1dVdBQjl6ZlI2UG1sc09hckdmWkFDc25wVnpXWXNU?=
 =?utf-8?B?ZjA0ZmN5ZHJ1QVNDTklkcks0R1BTMjhHeUZrZFFESVpmUkZ2RnRCMFB4K2dh?=
 =?utf-8?B?dkFoVmUzSkRrWFZkeTZIMTZ3Q0pNdTdsakpIN0ZaRHFhR3hWSDg0T2RpeTZD?=
 =?utf-8?B?V0ZVZ3Y0NmsrVjJxUUZUOWk5UndUdDhSTE16aDFPYXVYaVlqRi9HY3Rhb2tl?=
 =?utf-8?B?cThUZFFQanlkbmpsU0RuZE9WRmduYmlBdXJKQlBDRVpRaDN3Ykl2R2hKd0c0?=
 =?utf-8?B?bWpnbVNISzhlc1N6ZkMvN0h1LzV5L0ZuM1R1UUVUT2o2WVlKcWp0ckdqSXVl?=
 =?utf-8?B?OHE2QlNDRWJoSTBneERvT0FJaTl6UVlQeFRBd1h3TlMvM25UYm9kTWNCK1Y4?=
 =?utf-8?B?TTAxRWlMZXhQYWw0VzJVeFpBa2M2SHB1RStHcDk0OGRLcDhrY1k0aEQ3VjFW?=
 =?utf-8?B?MTN6aGo1TTZVNldZUHhVVHJTTUpWWjRSNUlRN0dlRG1BbGFxQWM3UFZwM3hL?=
 =?utf-8?B?ZzhZZitobUgxKzBPMk1IYit1ZVNKc3l1dHJ3Q3NlWXY3VVgrZElHZEthbXJU?=
 =?utf-8?B?Uld5Y3BMVTdraVlMUUgreUk3by9LWVRGc0liVGE5dit3c1Q0WTVkK1dFVElE?=
 =?utf-8?B?WktVZnBFYUd6aEFqMVhiS082VDVYdytnS2VENVl6c2Z5dlBSdzVCRFdONXNT?=
 =?utf-8?B?Q3IrazFFRjc5T2hEYVE0d0doeUJPcURqd1RkSThkcHdpbXQ2NVVNcTN4eWFu?=
 =?utf-8?B?dmFvc0k0eVFMNWoxQXE4RHQwWFFvWElUVUZYOXFmVnM5NWxMUjQ5VjJGOFBn?=
 =?utf-8?B?akkvWTRSWkg1YWtETWhFSjNKcGJvVHhiWWYrT0xDdnpNWnNCN1o5QmduQ2l4?=
 =?utf-8?B?WTJxYUU3SkY0SE5LTmNSYWQ5L3ViM1F4UTZHYWhwYkJsaTJwZEdLc3VLUk1L?=
 =?utf-8?B?Z2JQSlJLUFZseTZXd0xiRWY2SGFWb1dkdGw1Z1Job1UzQnlRdldBMmlUMGxk?=
 =?utf-8?B?Mkg5aEQ2RzM5NERQZ05wN1ptYlJYcG5iV0V5a0t6UWY2ZHp1dEppbmprelNN?=
 =?utf-8?B?dVJ2M3dQWmIvQm9FcTU4KzI2UlZibVZiMmhCNFBtSmZwSGpyd0NVdlNvMlpr?=
 =?utf-8?B?TDNaN3k0Q1RQR094bVliU0FYOWtvekduQno5dUN4anRGdlNjU2wrZUptTnFP?=
 =?utf-8?B?VVdQWmxxT3piOTBOVkFJTWgxeWtlQUZuTDllMzhhak05YjcrRVF2cUJWd0Ev?=
 =?utf-8?B?VEZKT3Vteng2NC9iUDdseGZTdkVEcnp1NVpLdjZaN0hCVy9QYUNaS2t3VEow?=
 =?utf-8?B?NEE5UXZ4WFhvRks1SXU5dFFxN2t3RmlQWlFpdUF2b1I3MVJxYUU3dE10aThG?=
 =?utf-8?B?WUM0YktidzBsajArZXRIZDlIZDRtY000MTUwbDdPSWVmSW9hN1NUL2xESTkv?=
 =?utf-8?B?VGV4UmFFdENBSmt1cjBnTmFvNnV3c3NOTTlhZDdzQlhFRW5ubXF1Q3JLbzdj?=
 =?utf-8?B?Z1N1SmxwSDJUeDJEVWxVaklYcVExWXNjN2hjNy9nRTQxNFkrZWIvcWFFeU5V?=
 =?utf-8?B?WmNRTWo3YWdQbUxscDZDU1pwSHJiS3ZMOXpOVUZVdmN2bnVjS1c5ODk4bFpp?=
 =?utf-8?B?WHRmYUZZVlAvdjI3dytIckNGM0dVMllFWCtpR0x6MHc5eDNSSjFXbFFXSVF2?=
 =?utf-8?B?RXoxRjVXYmJCV0ltNWY0aFRIc3Y0alJpQlowQmFVa1ZhNGtGZ2xlaWNJcjcv?=
 =?utf-8?B?NktnS2NEbzY5TVBGYnRkaGE0S1NWc3VLMEpKOVRhd3BjLy9ZYzhmZ0l3aUZ4?=
 =?utf-8?B?V1U2MnY4aDhyTS9WQkpkM2p1WU4rT0NaU0x5clFld29kYU84WlZ1cUNxRWlh?=
 =?utf-8?B?ZUwvT3gwbnJVa0gzMGZNQjhnZFhSeEtmTmkxNUtXYVVXK3FwcHpRcURnTFQ2?=
 =?utf-8?B?dkpyNmdLcUJ2WWY3Z1JBeE9pWjdxZUdwbExJOXQrVVdONzRxNFBndm9YaHpj?=
 =?utf-8?B?NVpPS09KTkxNTHA5TkJnS1A3eHZmQlhPME1ZalpEcHlXWGdneW5OYTcyd0kx?=
 =?utf-8?B?Smw4ZWhHTDFNOThxVENNLzhHc3ovYmsvSEJzOWJONUVGQ0pTZVczUTRaNi9w?=
 =?utf-8?B?aEtkSHJDUG5wNjc3QmdUekM5S2tJTnR4K1JGZFl5Yzl1bUNJMDJoUVJ3S2hK?=
 =?utf-8?Q?yUVY1nx+hPkULgYc=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11921681-945a-496e-92aa-08da0e7f0106
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:46:26.8283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsmXfz/go7w29AKXcIByLqgIJEW/USazMQ8qQndGHCC4Ob+8LupWJBDw1Ij2aanf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2332
X-Proofpoint-ORIG-GUID: NCM4nDbxI1xElClNHRKblmtguUKa3X11
X-Proofpoint-GUID: NCM4nDbxI1xElClNHRKblmtguUKa3X11
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_05,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/22/22 8:42 AM, fankaixi.li@bytedance.com wrote:
> From: "kaixi.fan" <fankaixi.li@bytedance.com>
> 
> Now bpf code could not set tunnel source ip address of ip tunnel. So it
> could not support flow based tunnel mode completely. Because flow based
> tunnel mode could set tunnel source, destination ip address and tunnel
> key simultaneously.
> 
> Flow based tunnel is useful for overlay networks. And by configuring tunnel
> source ip address, user could make their networks more elastic.
> For example, tunnel source ip could be used to select different egress
> nic interface for different flows with same tunnel destination ip. Another
> example, user could choose one of multiple ip address of the egress nic
> interface as the packet's tunnel source ip.
> 
> v1 -> v2:
> v1: https://lore.kernel.org/bpf/20220319130538.55741-1-fankaixi.li@bytedance.com
> 
> - Add secondary ip and set tunnel remote ip in "add_vxlan_tunnel" and
> "add_ip6vxlan_tunnel"
> 
> kaixi.fan (3):
>    bpf: Add source ip in "struct bpf_tunnel_key"
>    selftests/bpf: add ipv4 vxlan tunnel source testcase
>    selftests/bpf: add ipv6 vxlan tunnel source testcase
> 
>   include/uapi/linux/bpf.h                      |   4 +
>   net/core/filter.c                             |   9 ++
>   tools/include/uapi/linux/bpf.h                |   4 +
>   .../selftests/bpf/progs/test_tunnel_kern.c    | 115 ++++++++++++++++++
>   tools/testing/selftests/bpf/test_tunnel.sh    |  80 +++++++++++-
>   5 files changed, 206 insertions(+), 6 deletions(-)

The subject "bpf: Add support to set and get" is incomplete.
