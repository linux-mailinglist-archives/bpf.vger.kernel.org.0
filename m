Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF7E58CADD
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243290AbiHHO5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243311AbiHHO45 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:56:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C085713D0B
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:56:55 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 278ClLoX018421;
        Mon, 8 Aug 2022 07:56:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=M5lXdvmllZH6q5pCWEOCd30/51Q4tctRfFpcfGgWmn4=;
 b=IG9K9tv2wl8jFbpL/h7YjEOuodyF0qTiaZiAqh9Mbh2nIO7le70hR6Iy7vsnqBPdvZSM
 4d14Sch2/9VIovXJeINcxpZKCHhMggTmlwn3tdVyBUSBlLwap9eCJkclTQQXXULnHQGC
 ZZ08ulhuGNRS+sOKsQqApu71O+SvI8O+M9M= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hskywjds6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 07:56:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foq5y2tojR7j9iIZrYWyOW13J3jXq1DRUl+rd7rYjLG40KknKvGXwOPeFr+ED2AZKKcUdVDblm6L8e169emxpf3DYKFmMxJ95SpNynpcmvWANmbB5XslxWF23p8EWFd4XhCdbfLeEHk3Ybz6yAqm4FmiwrfqrlwFn/z/vx2oZxtwlR9izB6QVdcTMMgSPXD+eMDy3vs1gHh8S8jVlpU+2jK22TkwT2t5tvCQmFnj7b891BngBw/8JHdqk5qmwksO6KoFgZRe07eL2WN1ORamDIWK7pIhJYPJlt8fCZnZwPUKoAzZTYtHsfjse+p3ZYRCiTTFlHmc0WwJv1zHAoEfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5lXdvmllZH6q5pCWEOCd30/51Q4tctRfFpcfGgWmn4=;
 b=WDKujhxQy+NPFDrS81TdsIhtdtMDZ44NiGETr4M26xNicgdIzEsYTk3SM8u8AeFIdqF3iELHF/QPDA1L9XAPivumZPTPv3xLyWBVp9YUPSkvfCpBQoJ2GF2J4+7V/dINrEWxAd6XamGXgwIcl6lQg7C0TEsbRloF9GC14eewJAG4BvNrrCPOkqLFvNUjfyDRqmtSrDOoyIEgNWp04w7L60ROWyiQTGlVeAAzlAHCA+1cOU/uSGV/VK02J8v/ssdcATx+Rmo1HICBa80uKZCeC2LUtCxEojkoAFymVSqBnN9PB0cNszepjq421c3B9hWQF1NMiOi0nlnbtoTPIj40Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB4055.namprd15.prod.outlook.com (2603:10b6:5:2be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 14:56:20 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 14:56:20 +0000
Message-ID: <0685fcd4-9d3b-064c-21f4-0302e57f1baf@fb.com>
Date:   Mon, 8 Aug 2022 07:56:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf 5/9] bpf: Check the validity of max_rdwr_access for sk
 storage map iterator
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, houtao1@huawei.com
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
 <20220806074019.2756957-6-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220806074019.2756957-6-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33f96f32-4b99-4e12-2943-08da794e2743
X-MS-TrafficTypeDiagnostic: DM6PR15MB4055:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAq5n7TW9u2P133t9TZu6820WDU2bcvSJ4BRf7QRY01tCXKmtW6cF0HMP0MRBln4jqo068x2q/QEKbTEI8EQItu/GQdpwr8GyPVVpVuqRmnJzHRPDSZvFB826WJqVZREHPlB4yLXbhTnRSGZPlbL+hgp1x1tUigbLVu9+c/TfVkKlx1M1WGofuWmqIoD0yZC9FUz5NEanGsHaYGw9chCe07NMV9cdZVWTEPgJnmk2Gte0DbpMuGBqvTzmuTgdjNJZOuOQbaqvFCfTI7HGttrxXkNXzZma4NKFT6PSzzCdys0YkitXqQ+nQ3e00xdkrDdp4Lt0DCmDQsu+AYNwR6c2iuIoXU/+qB1tgrNYGaKVUoPRSA+myfo32Gaw82vf1UcxThbr5si4ULQ7X2Wk5XjJU2hErGJg7ja2BSlb9s/wQ1SVEPFJa8IbIMZrLrAewcoYE9uBWRJxmj5s9TA6p+uaWSfaiZWOltd0x0VEhl36mq2a1bJmCsqQBDzy+ipiWp5G1A/Z7LHH+WWdCeOn02G0hWniCvUstx+hCZQM2m+nezpd6i4vPHYN+Yg9J9pJm96r2xTvoxMW1g6EoEEgHkDa36ko+IHuukoorR4GcqAwGebdlTjMdzViZiwQKDiZdOcxtsg4Mw2jmHB/eWogjVIHWtWR8bliWLEfMWMiDx3J0fa+tKw1IKTKxdd6sZnXTDvMD6vnQHfS5SLQOmLII+wk3yuAdrShTegnEelqP0l9CTNBfjMmXXnzPkWcnYcCsQAyjtmOLSjAW+WOQtVkXkewH2DQArrATDFOsnn6Bn7X3e0HSrQSYBiZwx+otZ48KheYXlon9da6Hbf0hKx48nvwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(41300700001)(6512007)(31696002)(86362001)(6666004)(53546011)(6506007)(38100700002)(83380400001)(2616005)(186003)(66476007)(4326008)(8676002)(66556008)(36756003)(7416002)(5660300002)(4744005)(2906002)(31686004)(66946007)(8936002)(6486002)(478600001)(54906003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVKMGxZQng4UTE3cWFmQWJpWmZLbCtyZVUyOU05L3M1QUdnci8vZ2dNeVVL?=
 =?utf-8?B?WEZ6WHhpSVVtZU84Q0pwN1FHQytLSUhyRURkZDBJQmhNdVdJVmRQVXBZTStK?=
 =?utf-8?B?WEtTZ0ZkMTdmMFpJV2FGKy9KcWh0QlgwL0ZCZVB0ZktZZm5xMGIvRmx1eUdM?=
 =?utf-8?B?eXMwdTc2V3hYVVpmcDJLakh2ZjlVd01NZEVNa2NrOUJlTmEwY2haMjVOR1pi?=
 =?utf-8?B?cktkYmJDenZPZEdtMHVRa1paTUl0NkE1dWtXaE5NY0JNT3k5QW13cHZSVFlp?=
 =?utf-8?B?M2NXZVpsT2U4eEwwQXdBamw1Z0t4L3ZvbEx6T2Jvc0hCdGV2N0xUcTdEQ29L?=
 =?utf-8?B?YlBuV2dGOElWTHpWK0htN05OaW1sOVpBMHFaRTFBQjRsdnJiOHJqSi90cnN4?=
 =?utf-8?B?SlVPUm1UckZjVXRZVTRCMk9mbjFxWEFwUzFDQjh6SEJldGZoNDJBbnVaanVF?=
 =?utf-8?B?TWZOVVRMMlU4WGZjNE9NZTRGdHo3UDJlaTNvaGFtdGdtcitFWWlmWktoVTVi?=
 =?utf-8?B?NGgyV0czMU1CeDdWQXdDNThWcjlSZ0NHNVBmRzJKSFhGZVVQM2J0VWdRWUFw?=
 =?utf-8?B?TCs5Y0tmTk81L0cwamJ0YXBuME5LS09oaXhJTlJKbjFtNW9jWW1uLzZ5eUxu?=
 =?utf-8?B?UitWTHE2M05SZlR1VHNQRVhzY0ZaeVdwSnAralAyM2o4emo0ZVpTd3BWeG40?=
 =?utf-8?B?SFYzTHFYUHdvbW9nZlNSMkw4MXR2TDV6OTJwK0RVbzJuY21WUVZwUU9xU3Vt?=
 =?utf-8?B?VHRDMVRzWUNDSkhrcWZNV0wxSlYwRFo4cmludW43ZW92YmhEQVE4OXNKMFVs?=
 =?utf-8?B?N1NxRjdicVdqS0J6aUk0Q0RvSHRmZDdCOE5hZlVCWEhQRTBPMS93M21PRGc3?=
 =?utf-8?B?NFljeE1HaU1ZM25adjB2cmNKeUMwc1FtVlkvbzFwL05RdHh4WTV0NTN2N2Uv?=
 =?utf-8?B?eUtmVTcyV2pROFA5WkVCY0J2dzhCeVIrVHF6bUdWemJ4YldtZm5yb0tYRzdC?=
 =?utf-8?B?YUZRUzBGU3JkQVVFVmVra1l2T0VPSzBOa1BUL1RYUmNBMm9EMmk4U0ZxQVRq?=
 =?utf-8?B?WmpzRUNhbkJDWXhHQ1lsTEltUVEwQk85emk3ck0wMDBSekp0bjEyVTJqTUNC?=
 =?utf-8?B?L05ITlYvdUVhSWg5b0o3WmxxTmFVTjBtQzhkZG1UK0NDLzRvVWpqcjA5UnR3?=
 =?utf-8?B?QjZvbENZRzdESDA2WjVibzFlZFAxeVJ4enRBVGRISnZlSWZQcWtuK2FCZEt1?=
 =?utf-8?B?UmpoQ0FSL1NjSUhtcUxGcG1OK3l4MHVBd2NKbWwyV0pGdHQxM2ZTYmFYMEdC?=
 =?utf-8?B?VHdWYVdxT2pNNmFDMjdpbW0zN2R2WEtZRGNsWUYyWHliRHhZVGlVZXk0WStJ?=
 =?utf-8?B?RHpOTWZzajl5WVVlNU1wdDhyRDB2amZTSVRBczg2azBxQ3g4ZVh6VDJoejlK?=
 =?utf-8?B?Nk9xZFBtUkE2bHQzUFdpYVF2NzV2NmJzS1JGSXBPdzJURWhJMHZXL0J5S2xQ?=
 =?utf-8?B?d1I0Tlk2NjBzU2ZVSkZhOWJab0FNQ0pmZm1GOFJ3NkU4N1NKcXZuL3RuK0FY?=
 =?utf-8?B?Uk5VOGVmTEFwYzBCSEZOcG9JNFBGL1QzQktjUW94eVVVYzhxSjViOFlTSFUx?=
 =?utf-8?B?WEladWNxQmNIOHUwMmhvdm9nald0SVhKdEJoVlNiZzhZaUlkQVgxcGZtdjVn?=
 =?utf-8?B?VkVERlV5dmR1YnBBUTBqdHNXR2dDOG9MNkJON2RIcGJUaUp3akZXUWs1czYy?=
 =?utf-8?B?alFDOHNTNFoyNWdaVWVBc0lUYXJSRWF4Y2JwNFJuWk9wR2JJWGYvMW5QMStR?=
 =?utf-8?B?d0pLR2srT3VnSmRJb3Rjd3Eva0wraGg1aE1UeWxDelNvYTVxaStHNE5HVXFj?=
 =?utf-8?B?Mk9kR21QRjIxcmw1K1RMYSt2ZGdkQ2FhaVh1WGJReEhsWDJwR0FDRDlYbHpj?=
 =?utf-8?B?eURRUXBkWkFtUEJBSTZRK21YbHhVVEV2Z05PVjFxUDFWU3F3RmtSRnhZNzhT?=
 =?utf-8?B?anIyL0hCM0NRZjZ6YjF5Q1VyeGF0RzAwYzNtVktDRmh1V2ttR2NWYStSMS9t?=
 =?utf-8?B?dzNLVjNSSmdhbHIzeVpUeTFaRElzK1kxRDZpd3RCZjFWSFBrTFY2M0IyLzc2?=
 =?utf-8?Q?J70rjtx/4BLtZFDcajkleWbBB?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f96f32-4b99-4e12-2943-08da794e2743
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 14:56:20.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BT5xiEnOacoeFWOvrAhN+6eBf72Q3sUq6CwOJE9DQC6s1egevRtimU9eV4UXhAYo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4055
X-Proofpoint-GUID: pF1nvVXsd9qCI0TymqzCqau23rEhC5vp
X-Proofpoint-ORIG-GUID: pF1nvVXsd9qCI0TymqzCqau23rEhC5vp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/6/22 12:40 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The value of sock map is writable in map iterator, so check
> max_rdwr_access instead of max_rdonly_access.
> 
> Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
