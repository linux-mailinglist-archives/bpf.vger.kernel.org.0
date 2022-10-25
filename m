Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170C860C1AE
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 04:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJYC1L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 22:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJYC1J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 22:27:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1D9B1BBB
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 19:27:08 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ONmY5s015325;
        Mon, 24 Oct 2022 19:26:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=a1U/IjaIRHbUp22mx1NbPgLXsshMDL04xsHNFfFhFwI=;
 b=DiwacnXU51VXhEdUAM91e+NlH5n66gTPAIdd98vxiMWSgN7PC8VxZO/1AYZt6VLrXfFj
 QpTmcb251cVK0ouqEHAFVnYzIct62hyb+EnJghySg2WHW+rh98GDjastUmjwsRqb2oXX
 1bgE6Xuy2+no3nBI00R7JP3lifapmUSahlxY3CfQu6m65y5CP69kr77gF9GcElJym8WH
 R5/JkKdv3PpjJboIEe3N1q04AE6QeNyhoPkgYFpL1u/lHD962RT0273y2HSnj1fTb2O5
 M0b57kld7tlv4WOF1qyvkEAHhmohxh8UKWLa3yJUmS2gzm/Q+aYX6/w5t/Dloeo37Hbb 4Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kcdmuhh33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 19:26:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUm2w0na0pwXDCRW9fxMn1ZLSQ+kcgFFkKMKlS0l8cjCMYiKmeG9NezJzQlnrUD9c27+b2Wq8JUQKCXCHFmGCAKKAKEArQBPVZ72pUbaDfcS0EVh6baZsl6PUjjq3A4hPo9rjsY91LUIX70PnMEnZAQFcBFLEPU+znJYKVtTz+4nM4RYKjezSHYBhtws4RKJo2dl0QdBbHgxD9fCfHhC9pOwTk+b+zHWeap2ct/fAG1ussyuJbvaS7s4iwWdAkIezsiV5+wm9av90kLzcm++WYKaaQ6zhy5YCJ2KlXceakIMaRsKaFRmXaLvI/oPT8boYyzb+2LM/3LsW5CpspafcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1U/IjaIRHbUp22mx1NbPgLXsshMDL04xsHNFfFhFwI=;
 b=hD3k6B1Mof3i/r/ijJD8w2Pxyr9Zv+jP/G7nLbyjBYGnRTMzVzOy/U/VFJ09vGWx8HRZ5tIKDgd0hLxhjoWZlZqxjq5Y60sNGSWrKhQ9s62kLRfDbU2U49uJKnCnwSUyMmPgwMOCMJ3nV3dCq+M2582uacH0vYvU6TUGbmSR0Qv0/AXsER6A2qi52dzAJHfFg8DylF7Mt6jVRBCMhl5ELcwzH/bVLw2Y8Ia6IWFsv1cOv7jUmb+8IWS8H8pwE0Et6dh/M3QJTbwtZNdeQkhH/M7UxWsCUV+k9lavUMe7fjRqHbIqKaSo9kHg//jdz2yQTGkmOZ1A5Kimdmn30XLKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB3217.namprd15.prod.outlook.com (2603:10b6:408:aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 25 Oct
 2022 02:26:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 02:26:48 +0000
Message-ID: <7705d131-c213-a73c-5e6b-70f7b6c1a4cf@meta.com>
Date:   Mon, 24 Oct 2022 19:26:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v4 6/7] selftests/bpf: Add selftests for new
 cgroup local storage
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180546.2863789-1-yhs@fb.com>
 <d1b0ab2c-db05-d629-4545-a1d9d95955e9@linux.dev>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <d1b0ab2c-db05-d629-4545-a1d9d95955e9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0450.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN8PR15MB3217:EE_
X-MS-Office365-Filtering-Correlation-Id: 203f207d-60fb-49e1-9df1-08dab6305e76
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wrcnSsQj3rdpQ3A0K8KDBdQEUZp756GyzGgnYakvhd8Wejqphme5RmmFadlf0C4Cnh051Ga6Pz1Ey0eAtPh3mRTerBGIqvY6Nx4fX90yARKtoyUdUcUXsm2xtLx9eKgXItscd8oAQHC6NbhXnaXDt4DXi1z+CJOhF8RVmQ9U6ElAf8CFvFSsmwRe462SUh0LnQBLmthC3mqBxx5RYXpdMOknX7OCoQAXvzE1wk/cVz4ZVXgR1/P+AUQD3bvCWzKMxxszuFvR9G/GetBbSfwYhcUJ+VGszGGZ71cFsRRfi9e11XhBezbXj7xlSStTmux34QdbyaMQqpTTwNCY/0CJWqUeXwzA+gRRlnYf8Vv+oWVPcbQ2EuYfRgAcac7XEuYjZ+KogtWrfJHxQHBAn9z2QA9jfCzqhKJa0fK7JJPiuE2QVhC9ggxOcleRVyV/t1gqt5Jg09PVySshj1F1tHlsxpcDjvlr513Ull5rzYHGQT7r622I4jhn/EFZ3BfAmd10Xn2AUDMhqDJwbRcR0lD6ijyUvb3jm0gKQIPHFteBEG3AfcIwwzGLA2C5gDHA7wgcAj6zxLTWbdju51hten2l1lLBqFh+wFqZOtxH9WWTgzG7tCdJYl16/lDAP6m0kei2AcwT5ssPFvCpcqc2eoVhhgMMj6DqmRmN1n3hX0gjWqDg/oydCFBNdZU1nQrVm6DR+ktGAOvz83rSG2xgr2N1y0vWqHPlkzPIvVgrmjwVKJdSj35EQ+/rT7taLtT5SCtY+LjUMKkZVY2cPmt6UCS7JXin+r/JtPK5raaURbPNjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(66556008)(66476007)(8676002)(4326008)(66946007)(2906002)(2616005)(31696002)(6486002)(186003)(6666004)(86362001)(6512007)(6506007)(478600001)(53546011)(36756003)(316002)(54906003)(110136005)(83380400001)(8936002)(31686004)(38100700002)(4744005)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5QOUJjcDVDWXY4aEZzZldFdlNSS2JkM055cTN4dkJkazFWSW5tREhHVnhR?=
 =?utf-8?B?TzA3VEtnYiswWmFpWDlQSXJCRk1JYnQyVnZzR0c2RkZ6SURBK0M5blJwaHl3?=
 =?utf-8?B?bEFBaXk4Um9JdEpaZDhQeEcwWXl1UjJ1R3pheDFCa2UvRGszT2h5aUZLUGhq?=
 =?utf-8?B?ditUNDcyemgvaXcyYTM5N1EwWHdEL3M2MFZBOVZZaHlhWVF5cEJMWVJmMng2?=
 =?utf-8?B?cS8zQ2w5RVV5MHdrOGllRVpjWUY5VnNwOWhka1R4SUhIVHhDM2xOVDNvWmxI?=
 =?utf-8?B?Y1B5WW41ZXpwY3luODljK0pHQ3A5dHFyWmlhUUtBZXNncmZpNkMzTGVydjFO?=
 =?utf-8?B?Q0NoOU1qUlg1ZGVzMGJ6U0FNYklzMTRSdGdvWWd6OVQxbWpqb0gyMko0RHRI?=
 =?utf-8?B?UnZ6NTlZK2hzSFJ1WVh3QzUzQVU1N3lNN0kwNFBlRi9UZXNNNzhuNEdHRE8r?=
 =?utf-8?B?RTNrYjA4eFNkbnpOMDVqNGlGREJSUGxCdy9uRWFMMkw5NlkxeEM3SktSV0dV?=
 =?utf-8?B?RS9QMTZiemZ1UDFRNERmNFBrN2tLTk4ydXdFRWFUc3BPTktGWEFVZWxJSVpS?=
 =?utf-8?B?Rk5CNHdTOHpaTFZlcy94TGg1TVYwaG56QjgweFhQNWJ3MzBuSkhpMjRsQ2dj?=
 =?utf-8?B?WldLY1BaMjNudzBYWTV1c2JKSDNsWW9kM1pDUzEvWHpWNGFRMndRbWpLSm5K?=
 =?utf-8?B?LzRDc2lrYjhJWEI3V2lpaXdmY1MzMzloUm9OVEc5a3dwVEk5dG90UXRiUEZR?=
 =?utf-8?B?bWJuTlRuOEZTWGxMRWVqL3pkTzlhMTlEMlFUa3pKNkt0V2NOT2VpTXpmLzRW?=
 =?utf-8?B?N1N0MzNLS3hRWTlmaXBIUC9IaFdqSmFYdmJvWk9yN1pGc2l4Nkt4S2MvSnNj?=
 =?utf-8?B?eGV4S09lYTlXa20wQ3U5dURlWnpsaEVzRGxCTmcya1p2Qm95dVRydElPSk1a?=
 =?utf-8?B?bUdqMmFEYk1GRDZ2ejRHTW04elFxM3BMNXVVTHhuRzhwNS8xSHhReTcrb0tq?=
 =?utf-8?B?KzFwYU91STVjbHIvZnltWitqM2k5bmtLTEt0bHNiaEJXVmlXbko5b1ByUEYv?=
 =?utf-8?B?L3NXZHNuVDA3OUdCY0UwUU9jOFZlMWJQODliajYxbVNzU0hPcFBvVXJQcnNa?=
 =?utf-8?B?UVV6TFpqdEcvSHpMZjZmaWtPWi9Kc05jNVgxdU1jVm5sRDdyT01LdnZZUUVY?=
 =?utf-8?B?WTgyRmt4bDBYcEx2TkhRZmVlTm0zbjd5Y0RySjBxUkNNbm0xYkgxNFNhK2pa?=
 =?utf-8?B?NzNVK1puYUxBcWx1cmdZTDhiME5leFU0dDF4eUV2YjNBTDFBQVVJZkh3RDZF?=
 =?utf-8?B?Tm94d0JLcXg5UU1TOHcwd2FjZDJGVTVIL2U0VG5qZjBPTk9wNkc3eldheStn?=
 =?utf-8?B?d0pwVEpnMit3dWcyTHpMekxnYldENFp2TG9abUFvYnN6VEwzS1lBK285VVo3?=
 =?utf-8?B?Y2dWMUdmakYxQ0xJc01haGZ6U01ZbnA4ejlvYVg4UE1IVXJ3bDlqdGhDVjd6?=
 =?utf-8?B?bWJqYmtOY1hpZXFJR3cyT0lrcGdpbDdaaUM4WkpuY0hMeWowQm14Q0RRVHlQ?=
 =?utf-8?B?V0VMazkrdkRSRFNTQm9qRzUyZy9WSXNNUHpYblo4V3lvYmNWYU5WUUxqR25C?=
 =?utf-8?B?SGNYYzZsTng0dzB2Yk02OUd2Q25Td2Fsd1JpcXd2V1VEYWYvajI4OGZLbDdG?=
 =?utf-8?B?MVhPZGNHYnFYSTV0VE5UWktxTGJaQnpmWEdvNk00Z3o1ZUxRRERSaXl2YVla?=
 =?utf-8?B?dUNPbzc5OHI1aVR3Y3d2a21udks4OVZOZk0zVnJSenlIRkgveXZIbEE0Tk9T?=
 =?utf-8?B?TkVWYjc3NG5uKy9rWk0wclMzQ0QxYi90aVRpU3pRc3l0eUkwd0M3dktjNUhx?=
 =?utf-8?B?bXQyd00xRU42QXNYSHQwNFliNU0rcHdITW9XY0FaUVJWRER0R1ZvMHAxOXNq?=
 =?utf-8?B?MkhwZnpRQUo3c0E1cUw1cFMxcmgrWG43RjFaa29OdVdqWWs4dG9CZlEydDBm?=
 =?utf-8?B?eS96WW5hV3dhVFZYQ0NVOU5mT3NnVWtEcnAyek1udmNUaWUzZkhqY3RTc0Y4?=
 =?utf-8?B?SjR1VkZYRjNRbmpkODQvQlRzaXBnL2hyZTVOOFRpQ29ma0FuL1lzSG93M1A0?=
 =?utf-8?Q?InPYD8/uL+Rv3rNfHRVTdvNDP?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203f207d-60fb-49e1-9df1-08dab6305e76
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 02:26:48.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eSVcULhmtlX9gr+JBsPoq898/J3snRxmntT//cyM7jyV1X5tYH2nsRrALMBLPIG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3217
X-Proofpoint-GUID: A64ThDkbwAA9KB2YLU3AGh0me_F4z8yM
X-Proofpoint-ORIG-GUID: A64ThDkbwAA9KB2YLU3AGh0me_F4z8yM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_09,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/24/22 1:30 PM, Martin KaFai Lau wrote:
> On 10/23/22 11:05 AM, Yonghong Song wrote:
>> Add two tests for new cgroup local storage, one to test bpf program 
>> helpers
>> and user space map APIs, and the other to test recursive fentry
>> triggering won't deadlock.
> 
> Other than tracing, it will be very useful to add a 
> bpf_cgrp_storage_get() usage in a cgroup-bpf prog.  Exercising this 
> helper in the existing SEC(cgroup)/SEC(sockops) tests should be pretty 
> easy.  eg. The SEC("cgroup/connect6") in socket_cookie_prog.c.

Will do.
> 
