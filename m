Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5008D52C563
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 23:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbiERVMr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 17:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243004AbiERVMq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 17:12:46 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B71CFEC
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 14:12:45 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IKiB6t027642;
        Wed, 18 May 2022 14:12:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hycI70Hy529gbzIUfyoZLbbLiX0qYugk6lKvrAGUQt0=;
 b=pq2btP5VK1V8ncldO134fpH94H9zssSNDGvSd+YF/IBlV30h3YKCcnHtaSWpO8LcHF8Z
 meGeSVa2TDE2Ij3/qJQDCDbniF9otORJc+UOqGFnlyNhkvI3lSJAAcshgAOt2oOYb9xL
 khf6jNjtJB9n4+EIxg6QYp4Ybc5a2B+77o8= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4ap6v9rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:12:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT6D1kGMg5Fyf4kApXI+9qqj0P/DsVRVbHTya+kB9VHP1P68mKQJc/JrgFnK+DZdJkmncVLEuTyJ2A45t7bom3CG/bCxTsvGIFSHG90tmv6fry8Cf0WvYnwourarcwTg+8GndPJBLX3rYRwDRVppY4cZmgHyNnOPUzI5IDmYgg9HQZ1/xCLaH2S6l+3yV99s/pwyDkNSn0an43KhQxstySHnF8Up+gdXAMXNQkc6qNRIXGRoVmDBfPzn+/cOVFVJzoaPDzLlYtZRyz3INLPDhKcdEw+LDHDhETbL7OkEV8cKnf1H/w03MuZny88mmzyOoHZHAfiYgeKzrZeOXbXIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hycI70Hy529gbzIUfyoZLbbLiX0qYugk6lKvrAGUQt0=;
 b=HFJVR1bRySLdXPYSbA4tfIlIge7ho0NixybT6ojH6HlqKrsyOpLjICBnLXFgIfX69JDsfZ8tdBmkjHmaDQfPl6+IIPlfhbDjJW8j0jXjswXQgXsBMI8DJKg2FzklOKx/OY24xszsUWOIC9Bw1S8yf6t6evi23ULlh4FcxnZ8l+Cj01apKbScQDjyMZJWiClR+9wVG5yNvr78l/aCE7oEqxDbHWbNGv8EJ/Ak4eHChPgo6K1oNMvd9Tury020K/o6cgobRDmy9jLUBFuMZa0s5VXZ2ekVvYXoJGPO3/qH1/UA3fJaP6cR2THTAngQC0XkFiio/ahXo4dGnw5fhU0IRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB4264.namprd15.prod.outlook.com (2603:10b6:a03:a6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 21:12:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 21:12:27 +0000
Message-ID: <a8881bb3-54d0-2a3f-85be-1962316ad231@fb.com>
Date:   Wed, 18 May 2022 14:12:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 13/18] selftests/bpf: Test new enum kflag and
 enum64 API functions
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220514031221.3240268-1-yhs@fb.com>
 <20220514031329.3245856-1-yhs@fb.com>
 <CAEf4BzY5_-vc6+t0bfZ0y_0Rsi9Og9fa6EtSuQ=OyGYFFQvHwA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzY5_-vc6+t0bfZ0y_0Rsi9Og9fa6EtSuQ=OyGYFFQvHwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f7c0a71-9490-4011-46d8-08da39131c87
X-MS-TrafficTypeDiagnostic: BYAPR15MB4264:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB4264278FFC4232395DF5C441D3D19@BYAPR15MB4264.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nvd8URLLR5sUCUXE/VC4nz3SFBssg1X86BAY728oiKwpzMrZAAfhWsfwhV1SsDp73vrAWSxO572g2wPiQR+4YIpUIQGJQKQMaKXJ6bznuKGwREEiCN2cSEBbM3BTz6TkMVpWA9ilCF+m4MknXu9tMRLOXpRmbUJk6ffbu8zSDLEti1TsEMDO7gYXBLfOj4fruR5C7ewcvUjP/2vLIrRcvxOqQxetQUdItKUPv/FvElT4SmVHxnHSfusw3MK2zqxRjC5uQe5HCBvJzCKXPOP98eRqaIILoexY/JCgZq7wi9Pi1pQRbLDMzS9UpAGHG8RsCMNiI9d+5P6cH4e+NnSt/d3p6EundAdDRSY8GogR15O2OgaNxhmZA2deDRM6Q+9WksLxT425TRagT5sMBqJF+b4Ur5HoqTqg9XVvRj7wtNqHYeeAsU5e8QqwLMQz48sSmKz1LwGrATFhz4/nnTPHonWx1KIbXoIxHmppLdGCy2Cb0yMO0HaTZC1Dgu2DGP5Re2xpgQl7F/5sGLNc/025UJzB3A5K1+Yj+JK0R+Z5igWocyRXdZ1sMH4T+HlvmIr7ANfBepYb/OuHFRamnGcnX9hd5y7IlGYK5rzkCtsRcUdhisqCQ/h/xyWt9KuBc7h41a1Dmoro/99wLLgmcgFWVFjxt8j0I/MDVuQIiik+WA4Z4sQFUxu5/sy2v2sTMjEceA/L5mlf3N5CiZgDbVfYRcNcA6DLhPuzU9+KtL1+nMdblWzxkWUrfSL6ox8CAqPG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(83380400001)(316002)(6486002)(8676002)(2616005)(4326008)(66556008)(66476007)(2906002)(31686004)(86362001)(36756003)(6666004)(52116002)(6506007)(53546011)(6512007)(508600001)(31696002)(5660300002)(66946007)(186003)(6916009)(54906003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajRuekhkTzdKbENtZ3A4S3J2UlRNb1hwSkpDanRBZkx6NHVxU3gzZVZXSjJS?=
 =?utf-8?B?SWRPb0pZdXBKZUIzVXRzQ1FTMm81NEtsSmJjUE9aZXBleTA5eUhmcmhQMTZF?=
 =?utf-8?B?ZTVKVkRQYTQrMkkxdUVZUXVMY01qSEowSkt2T1d3NU91eGFtWnBOTHd1TWZT?=
 =?utf-8?B?NFNVMmlwbUlBcmE1UW5JQjlBbnhxNWxjZFJpR2ZGQTRQSjltVlUyY0RPdEg3?=
 =?utf-8?B?OXV1ajdJQTByUlFJeCs0cmJYMWJLdHptdUkzNnVrbFYybkFmNDN0TjR5Q1Q2?=
 =?utf-8?B?ay9pbGhyYlkwa1lRZ3kydVo5Z0xWQWo3eUhKR2l5SkQzem10ZmNHekhGYkV0?=
 =?utf-8?B?Tk1Nc0pnaXBMN1B1TC9JTUJOemo2cEpmVGN1NGt4SVJsY0xaRmJGNjlOQnVQ?=
 =?utf-8?B?NEJLNGw1SzczTlpmVEdncEo5Vkt5Zmp6aVdtNEx6N3RBSnRNdm5HVDlpR1BO?=
 =?utf-8?B?YkdBK2hMbjg0amNkWXVyM05OUnZmQjZYamNVa2YyWGdZVU1BK1lnRStkT0w2?=
 =?utf-8?B?cDAwbVl5QlhJeERBMW16cTdmT1dzQkh4M1lmN1AydGZYSEQ1NFpNQjN3cERD?=
 =?utf-8?B?R0dYdFU4K0Fkb0c5Qm8yajgyNmwwNHJwS3N3SEt2ZUV4NG9qUHlJOFVuekZ6?=
 =?utf-8?B?SnowakNtUkxlRmc2MlNKNFg5L0JkV3h6eWI4bHFFTlpDWVUrUGxrbTE0SmZT?=
 =?utf-8?B?UllmMk5kMGU4NThRY1FYWFB2dUw0aVV6djZMd1dPd2RTcUg3NnErQ01kTUd0?=
 =?utf-8?B?VFIxLzNaQnNmMmVIOUxOejFpU2FrT2dpQ3J0K2FReHVlMVA4dDF1L2NaQThz?=
 =?utf-8?B?NUIweGlDY0tIeVN4eDBWR0prMHZaYUk1SGFRbTE5RWhRNUpXN3FZNk9TT2tC?=
 =?utf-8?B?RVl3MW5FQ040RWprd0pmazlwRnR3QjhRNnhjVk9va1p6ZVAzLzJLTVNUTVVM?=
 =?utf-8?B?N0xMd0xCQktFc1gvYWZnd0NlNUE5a0pPTFBCMFpkNStwM2N1eW1NN1hGcVhk?=
 =?utf-8?B?aWhHL2pnZDl5V1RNUm9ZSHVzcDZjTWRuL3dNdVVoanRRMkc3d251eC9UZy9O?=
 =?utf-8?B?K2M5Z0Z6bDJQOTA1QnhEYzVTSUpFREtFWm9lcHlyc2RnSjYxNlBkcEYvc1oz?=
 =?utf-8?B?R0tab2FuZnlXQ2E0TGpzelJkNEJvVmxUUGtHOWVtc1N5anFCaEpvWDhMN1Jr?=
 =?utf-8?B?TStibDdCYXNaeEx5bUJMNFdxYUZ2RFZ0MDhZUXNPR0t3UEJyU1JSTjh2SUlU?=
 =?utf-8?B?RCtUOEQxdEcxZnNOUzJOejd0MVltSHRodXhjdklkOStvYXY2bjVHaFpOdEdN?=
 =?utf-8?B?RGRIYlY1UmRWRnhEZkM2WGREbGltQXVsUk9vajlZYTVUeXBjZ0gvbmNwbk9V?=
 =?utf-8?B?VG5ndi80Y3M4a1VoeUdIRlRoQTZLNzIyZGpPZEJnMENhcUJVS3h1TVpXMktR?=
 =?utf-8?B?Q2RUZWM4ME5ubCsyRXVHQjJER3NxR2d2dnlBakJzamIya2NDanp6WG1FV2dV?=
 =?utf-8?B?R2ZYbkxXcGcrTWV2WFNoc2p5QWRxVEVIZDdRWmp6QitJNERNWlM4Y0hhQmJO?=
 =?utf-8?B?bFpNaURzVFBhQmJVZWptRmZrSTN2MmNMT0Yva0dTVlI5M3VVNGlseWhrSWM3?=
 =?utf-8?B?T092WUtPUFE4TWFScFZBUEYwcVNiU3lkNXB2UHBJQi9MdHBRVTJTMG9uaEQv?=
 =?utf-8?B?aWR5emZpMDBYUUpWMTkydGNuZWYxUUU3TkJESXM2b3A0dTVBT1NZQ2t2cEI1?=
 =?utf-8?B?NERWd0lMZVNPNWU2dkIwdHhXNzY3N1puWUtiaktxMjBsOTRJK0lKbitIajJV?=
 =?utf-8?B?QmNtRmorNklseFdpbmowVDFLNzQ1czhVWjE1TWtjTmdiODYxWmFLWkxvT1cz?=
 =?utf-8?B?clhIV1hHdE8wYXhyMUE3WC9SVjRiOXBNMk9lSmg0WUg3b21rL2gzNGtGVkNG?=
 =?utf-8?B?R1NaSEJPdyt2Wi9jQnBTR2NwOXQrK3NORUxBcGV2M3ZjNm00czcyOVpnRWZo?=
 =?utf-8?B?RkRMS2pCTHZ0YWtZRjFTeC8wOVYrMTBpQ3E4OXczbzkyb0lBU1dGYUFFRnAw?=
 =?utf-8?B?aCszOGZXeC9icWFkY1VGM0MrQzMvRE9aOC9McXhMcVRmV3Z0WHc1dFJMVjRT?=
 =?utf-8?B?Ti93MzdQK1YvM1d6b3dqUEJOckVBVTd1eGdqUG81NE1XNVBmaUxkSVVUM0Qv?=
 =?utf-8?B?b2J0RzNZT2dYSG9tRVhGSVJFZGxnR1lWYlkxWDhDeWdXb2JydjA2RzI3dkU5?=
 =?utf-8?B?SkFIbmIyM2ZGUlYreFNvUFdZYU5Bak5ZVlNCQW1nVUhqaytVQStEeVpLMTZo?=
 =?utf-8?B?c2dpMXRIeTlMMGp5N0tzMitOVThDNzVLYWIydVAyanExMWxKKzVXRGpnTTAr?=
 =?utf-8?Q?AzZzTx093zf02/aY=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7c0a71-9490-4011-46d8-08da39131c87
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:12:27.3229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+Wyiyhazpb69wmEm6Opb9TmjYWVNyGwM205bBISIWZQydi/UsOMkHaWUqkJbWnd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4264
X-Proofpoint-GUID: HxSYILshOokUS-O2CnuQZQQf27cA4y04
X-Proofpoint-ORIG-GUID: HxSYILshOokUS-O2CnuQZQQf27cA4y04
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/17/22 4:40 PM, Andrii Nakryiko wrote:
> On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add tests to use the new enum kflag and enum64 API functions
>> in selftest btf_write.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/btf_helpers.c     |  21 +++-
>>   .../selftests/bpf/prog_tests/btf_write.c      | 114 +++++++++++++-----
>>   2 files changed, 105 insertions(+), 30 deletions(-)
> 
> [...]
> 
>> @@ -307,6 +308,48 @@ static void gen_btf(struct btf *btf)
>>          ASSERT_EQ(t->type, 1, "tag_type");
>>          ASSERT_STREQ(btf_type_raw_dump(btf, 20),
>>                       "[20] TYPE_TAG 'tag1' type_id=1", "raw_dump");
>> +
>> +       /* ENUM64 */
>> +       id = btf__add_enum64(btf, "e1", 8, true);
>> +       ASSERT_EQ(id, 21, "enum64_id");
>> +       err = btf__add_enum64_value(btf, "v1", -1);
>> +       ASSERT_OK(err, "v1_res");
>> +       err = btf__add_enum64_value(btf, "v2", 0x123456789); /* 4886718345 */
>> +       ASSERT_OK(err, "v2_res");
>> +       t = btf__type_by_id(btf, 21);
>> +       ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "e1", "enum64_name");
>> +       ASSERT_EQ(btf_kind(t), BTF_KIND_ENUM64, "enum64_kind");
>> +       ASSERT_EQ(btf_vlen(t), 2, "enum64_vlen");
>> +       ASSERT_EQ(t->size, 8, "enum64_sz");
>> +       v64 = btf_enum64(t) + 0;
>> +       ASSERT_STREQ(btf__str_by_offset(btf, v64->name_off), "v1", "v1_name");
>> +       ASSERT_EQ(v64->val_hi32, 0xffffffff, "v1_val");
>> +       ASSERT_EQ(v64->val_lo32, 0xffffffff, "v1_val");
>> +       v64 = btf_enum64(t) + 1;
>> +       ASSERT_STREQ(btf__str_by_offset(btf, v64->name_off), "v2", "v2_name");
>> +       ASSERT_EQ(v64->val_hi32, 0x1, "v2_val");
>> +       ASSERT_EQ(v64->val_lo32, 0x23456789, "v2_val");
>> +       ASSERT_STREQ(btf_type_raw_dump(btf, 21),
>> +                    "[21] ENUM64 'e1' size=8 vlen=2\n"
> 
> we should emit and validate kflag for enum/enum64. Or maybe
> "encoding=SIGNED|UNSIGNED" to match INT's output, not sure which one
> is best, but we probably want to make sure that kflag is reflected in
> bpftool and selftests output, right?

My intention is the value print out itself will show it is signed or
unsigned as below. But it doesn't hurt to explicit print out kflag as 
well. Will do.

> 
>> +                    "\t'v1' val=-1\n"
>> +                    "\t'v2' val=4886718345", "raw_dump");
>> +
>> +       id = btf__add_enum64(btf, "e1", 8, false);
>> +       ASSERT_EQ(id, 22, "enum64_id");
>> +       err = btf__add_enum64_value(btf, "v1", 0xffffffffFFFFFFFF); /* 18446744073709551615 */
>> +       ASSERT_OK(err, "v1_res");
>> +       t = btf__type_by_id(btf, 22);
>> +       ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "e1", "enum64_name");
>> +       ASSERT_EQ(btf_kind(t), BTF_KIND_ENUM64, "enum64_kind");
>> +       ASSERT_EQ(btf_vlen(t), 1, "enum64_vlen");
>> +       ASSERT_EQ(t->size, 8, "enum64_sz");
>> +       v64 = btf_enum64(t) + 0;
>> +       ASSERT_STREQ(btf__str_by_offset(btf, v64->name_off), "v1", "v1_name");
>> +       ASSERT_EQ(v64->val_hi32, 0xffffffff, "v1_val");
>> +       ASSERT_EQ(v64->val_lo32, 0xffffffff, "v1_val");
>> +       ASSERT_STREQ(btf_type_raw_dump(btf, 22),
>> +                    "[22] ENUM64 'e1' size=8 vlen=1\n"
>> +                    "\t'v1' val=18446744073709551615", "raw_dump");
>>   }
>>
>>   static void test_btf_add()
> 
> [...]
