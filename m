Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E4B62029C
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 23:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiKGWw3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 17:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKGWw1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 17:52:27 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B6E27FC1
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 14:52:26 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A7LKpn1024143;
        Mon, 7 Nov 2022 14:51:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=GwH63xa5MOdS96iG2dThAVpxolaJEYo7Lkd66H0BgM0=;
 b=V+PJK6Oi9mkMVMj4267MfoJwv9a6D3F9YLafKpe+l79F+Qj3+caagNeiWiQCPCCu/WgH
 eObcbSpjXLtaC9bY2CiT+cGKnZgZzO2K6Ohc10jrIeiqmvMGSfK+W6g7ptQddNq18T2R
 dwOukBkk4Ao56vgtGAnCnU0drfrUkdpQCbge8rO51CE23BJmgwZcN31oeKpnzFdXwHM/
 RpLblKdH3TvfjWcIUuMct3mqNDM5fUbeDdUK3ek0feftMXQkWwu6odXusKNYIbVh3IL5
 8ADsNbVx+gq0Pd/vyWKF/x1Wvh7/g/9kLz4twEy2r8IoW4YAG530CGkLzeh5ouFtnH0G jQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by m0001303.ppops.net (PPS) with ESMTPS id 3knkgvkspm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 14:51:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+xujPhIANgCRvddC4udp0GaizeQHJrUTLPvWrou02Hq6LMzr7Pq/OiZ8sY7+IAtALOl7Fg2mO9LI31VK4nYbQUXSVnwt1l24LF0FyB0X/bDIFjch6tJ4XX/1ZxyDbMOIbMXfBz/a0QCvZrsGF10UjIIift2fACge1elSwyT8GC36sJMz3K41/XBz6uL+tzcuaKceSfp4I7uIiAdWaMiu5b7xcCe7ma6UjtGqZmHTKuW+WCMi2ndvM8duK6b83vG6oTRGUNv6tPDBt5MifXxfnK7VEfXR+ZA4y1Sb3v/Vi78EfY5/k7IbRSy2wZQoW8yfXLXZAjkVSRbwVvXDyuhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwH63xa5MOdS96iG2dThAVpxolaJEYo7Lkd66H0BgM0=;
 b=GmSFoQl/781EjzD9TB+NbM4uvzBoMlwolgx8Wo2dOnnIZicbqgYZ9qAASor2PJNboaGcUfL5W5u1kDTJF0HYkbthyCAdUvg2gjchtq650UZTnweGEwdCBaDNhgmGd5S6hR7VhzGYfEsznkJMlvr6OR0VSoNDIvLqkk+Ca+SeHEVkeIG1UXr1oEFhZKNnJW4oVF8PGjIebYEU/UnyJW0AKtrsAvRCHpOGgVT6ULn9RQOzBWgZ6P0LbURf0VRkQXjL/14WebB0oFt1ZTmwPc8tmUgzPozkIUIG7oHS+gTDYjFqU+kXC5CGxS9ZB180xyNYaKES9a09YWkPmHexCup5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB4317.namprd15.prod.outlook.com (2603:10b6:208:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 22:51:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 22:51:56 +0000
Message-ID: <ddf788e1-ba97-4b5c-4cf2-5c79fc91b17e@meta.com>
Date:   Mon, 7 Nov 2022 14:51:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf 0/3] Pin the start cgroup for cgroup iterator
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Tejun Heo <tj@kernel.org>, houtao1@huawei.com
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221107074222.1323017-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:74::41) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfbfba9-a848-4d78-80a3-08dac112abbb
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUP7KSIhQAXRw9lkXjdOQm2a+sBWjVZXQDjx2J2f2CS2Gewsiypc2gUvrIco9HN+ww+ZyPB+Vp2gy4IAQgIrJ4rHslsv0/VWnyxB+7BapBjJeUWhsnmZUlZiE2D92CQaISD22v2zKLk13YEPg09YWkwj/qjYv5CPIchtwD77UHBDQ6OS+gb4OJ/76gU40sJeo8VGYeIE5AjKxLVGqPODJjeJgd0g26Y39GvSBelPmIsOsWsME+JOK2+0nRZPZVfD/WtO9EjsNLY7GRQo4HWEbcKL8B37Y3pJuxWvhJBo2+V/rZyu8HE4ftCD/i3laL/Tt5YXRKl0cz35PxWpNolv8lGibbfbCDgRLVQWCf4k+yNtpKmzvNMz9SRoxuvZxeiyyUXHesO8sHNPXBp2csi+9MGu/DZWc3CgtRUYvaDjOgvZr9mv0VoHF2IUtExZjGQTS7vX/AhnG/V/3iM8YZKkgyiR9NfWx3vNvOaUA/378MmlUHt4WIoPkJrnPH1SRCTIJJUX/MmU5RspbhqCThCO1z/0VvXkOtKtc1X8uPpcCtiKwDC9fBbGSOhjblFUYY55BPw0gdAn/ZROe+t1jfjZOlXe8YhtPNvyhTcOMmbyc2jpGDPhBfnof/uMbzUn2cknrGBFzE18IZx/BCkxtDEsHPJ5QE1wiynAfZIukyTOHiGVrxsoSSRYfp1AEfijzDSiZBTczGgBaguE34NZ2q3ijXCFTgDS7YnMAjN9B3p7tf4F/Zi68byeoW9a8T0OYN8kxwoOU2ddoDVVli2MyOBRqw9e7YJ0mfRH4AtZfAI8v0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(66899015)(36756003)(31686004)(86362001)(31696002)(66556008)(2616005)(2906002)(6666004)(186003)(53546011)(6512007)(66476007)(66946007)(4326008)(6506007)(478600001)(54906003)(8676002)(110136005)(7416002)(8936002)(316002)(38100700002)(6486002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjNnSG5rWHJCVXFvNzZBYzhvbGRuYkpkNTlncm1wMEhRL1FGMnhmQ0tZVWUr?=
 =?utf-8?B?Y0Npb3dWbHMyRXA5T05FZlc0cU00UjJXbDI4OWVpT1J3Z1MvbXRrUytIaVJq?=
 =?utf-8?B?TmxaSkRYVkNXUXRvM3ViNmMxUHI2MmpwTzR5YmFsSnNUMXlGTDBZV3l2clBW?=
 =?utf-8?B?cVV1b3FNZzJWTmNJRmtCOHAvUGRiTlo2UEpMZlhvbm4yZ3pIYjRoa2JWWTJP?=
 =?utf-8?B?VXdFNFlSSUl0cExFbXlQS0VGSDJha1Q0S3Qwb2p1SkxxS3ZhVHV0eVMzb0NI?=
 =?utf-8?B?UHBDTi9NYlBtZ3lzVlRZaXJpZzdNamdBQUJYSXhTeTlTbXVpRUkvbzZla0FM?=
 =?utf-8?B?ZXg0K2w5R01YRlE5N2RzQU9CUmozMGlSdEdVT3pQUzd0R2x0OERwbnExQXlQ?=
 =?utf-8?B?L09tTkgyMTIwVWV0M2U1ekQ2R0ZGTnZ1NTM0dngyWXBXdEFEb21tK2EraGV6?=
 =?utf-8?B?YVFTRmQvNFZ4bGFXTFFRbVdKZjJraDBFazMvcUlMbGY5NGtjdXJIZUFSVk9I?=
 =?utf-8?B?SkY1d2Z1U1E1d0lhQ2F3NjV1R3RqMExEOXhvZTdoSFlXa2N1Y1hEektWelhZ?=
 =?utf-8?B?UnppNjhxQXBINTh4bWRXOWFnNDRuQTdmMGNNbTZkWk9JRHU4aWRqSVBKQnlr?=
 =?utf-8?B?dGM1NlRUWE9LOGx5Q2JWNU1BalFNYVpTRUV0YkpvMTBYY1R5WStKZllEQXdT?=
 =?utf-8?B?NXcrK3M2NXMyN3hSa3EwSzFDWVp4dmIrZ3lSdkpwaXpxQ2tJWFFEekZlRTd3?=
 =?utf-8?B?Q1ZJYUNFSWtmRWo4U3RFSDR6NWE3K1B0cVBQSGtlZ1hoK0JpeFZ5RGV4RDN3?=
 =?utf-8?B?OGlRazhWclpaS2Q0MkJycGVRVFNnTmJmNXFNcmhIbzV6amZ6VXN5bGs5QlFs?=
 =?utf-8?B?UmFYUllhUFZSTER6UVBTVjhkcXlBTFJOaWhtbHB6dDQzdThoQjVnYUJLdkUr?=
 =?utf-8?B?YTkwVXpqZU9iUGF4WCs2Q2dWeVcrSWU3STFObmZxUTkvNHRrZGxqc21VTkI1?=
 =?utf-8?B?TEFkeFUrYzJnRmVmTlltZmh3dXROT0dWK3Q1Z0dIQVFrSXNUZ3ZaNS9aZlY1?=
 =?utf-8?B?M3NmZ1FFS25mUjc5WlJzdERYNGdSRDRKQU96WXhTTVVSd2FXeXovMTU1Sk4v?=
 =?utf-8?B?ZGhzTExDM0dWUFR2Q2RmZVZ2cUtwK1hrU2h2RVhHRUR6eVJucUJpZHJ1dDR4?=
 =?utf-8?B?LzlvVXBFTW1oMWViN1kvTGhDdWRaRU42dENJanRBUU9pOXpZVi9PT0E0aGpM?=
 =?utf-8?B?MEpUcjJLWElwLzIzMlprci9SOXBYc0pzNGphNGVacU9BQ3FvZHcyWHlhZWli?=
 =?utf-8?B?WDNaRDc5UlJZR0hyY0FSZ3pCRzZUMC9FSC9mTU0vRDhkeXRWNFV1SmVaUlhU?=
 =?utf-8?B?NmlmT2dkTGFZcFlwME5yNEw4WTdCbGhXK1QzeFV2cGFmbVVTQjNDczdybE9L?=
 =?utf-8?B?d2VTeUtmTDJZaVdZT2FMblY0KzFSbVkycEx1VU9WRGRLQzJCdVorOXRkUWV4?=
 =?utf-8?B?R1ZVU2EvcW9yc21Pckt0RnNib2Qwbm56TWlQd1grVENGNGVyWUh1Z1NZM0pQ?=
 =?utf-8?B?VE5sVjVJcFJBUFZxSm8rTS9QZVZYSndkRFUwNWxiVWhwcmNjVWp2Z2k1cnI0?=
 =?utf-8?B?T0tmWklhclBpOEh4cWhGSXZ4N2RRNWY3L1ZlOXNPZFBJS293emc1Ti94cEtu?=
 =?utf-8?B?RldHc2RoYWJ6MU50dDVFODRqMnBSc3hWZHdhaDZ2RU9ZeU1zK004YmRzTnJP?=
 =?utf-8?B?V29TTjl5ZHFUWHM0Tm5kcktlVjI0WENLMlhtemRzOUlJNTgrTHNlc3ZFNU1H?=
 =?utf-8?B?M29OcWJGTkhXdk5PN05SRXNRSVhyMFRyNEdkZXFZZDhQWGJCRG5QVjQ3MmVW?=
 =?utf-8?B?dWdUZEdHQVZ0d2RUcWRWcTJTdU1CajUwWEpqZTFxbDNmRGpicWl4b2xzY3Q4?=
 =?utf-8?B?cUV2QmtZZTg0OTZoaUNxalg3bkF4UXh5TWVmMCtrK3ZDZ1FtaHZlZmxub2Np?=
 =?utf-8?B?bnVsd1BmekpiWnJWK2s0ek9jNm1tVHZ1L2orcFlkMjA5ei9aKzZ3a2JVVDJx?=
 =?utf-8?B?dDdSczJQV3gwelZqdGlpSkhrL3gzbEFsV2xmWWdXOWczTUhEaWVuamNaNTFX?=
 =?utf-8?B?WnVTRDMwSGVzTGFVNkVwbGtqcjdHWW9iclNxU0VYQWZxRlc0eE9tMGhBWnNM?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfbfba9-a848-4d78-80a3-08dac112abbb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 22:51:56.3610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckWZM/Kp4k1tLo/CerhnZZwNenkj+ABl4tqrQujh/0KHu1exxaaaWbfI39GCtJG+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4317
X-Proofpoint-ORIG-GUID: 8obZqGtLfSez8_A3OE4qClmYrvPueTXB
X-Proofpoint-GUID: 8obZqGtLfSez8_A3OE4qClmYrvPueTXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/6/22 11:42 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset tries to fix the potential use-after-free problem in cgroup
> iterator. The problem is similar with the UAF problem fixed in map
> iterator and the fixes is also similar: pinning the iterated resource
> in .init_seq_private() and unpinning in .fini_seq_private(). Also adding
> a test to demonstrate the problem.
> 
> Not sure whether or not it will be helpful to add some comments for
> .init_seq_private() to state that the implementation of
> .init_seq_private() should not depend on iterator link to guarantee
> the liveness of iterated object. Comments are always welcome.

You added some comments in cgroup_iter init_seq_private(). Hopefully
that can serve as an example so for future iterators we can search
the code and remember to hold necessary references in init_seq_private()
function....

> 
> Hou Tao (3):
>    bpf: Pin the start cgroup in cgroup_iter_seq_init()
>    selftests/bpf: Add cgroup helper remove_cgroup()
>    selftests/bpf: Add test for cgroup iterator on a dead cgroup
> 
>   kernel/bpf/cgroup_iter.c                      | 14 ++++
>   tools/testing/selftests/bpf/cgroup_helpers.c  | 19 +++++
>   tools/testing/selftests/bpf/cgroup_helpers.h  |  1 +
>   .../selftests/bpf/prog_tests/cgroup_iter.c    | 78 +++++++++++++++++++
>   4 files changed, 112 insertions(+)
> 
