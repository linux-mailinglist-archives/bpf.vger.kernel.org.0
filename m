Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52AD52C576
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243120AbiERVLN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 17:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243252AbiERVLJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 17:11:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F1A2FE45
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 14:11:05 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24IKi7ts012756;
        Wed, 18 May 2022 14:10:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4fusLV4TrtI0Lvpk1xcgp7ScoBTGEqfuMm1QwN1goKU=;
 b=cfM2KXP+z8KK8guSi7OvWGOYCbNUzNJZfuVWVbgCdeg8bJ4KZzYHYw5vsYTZ5EH4gIyG
 gK1GwjMBiJTiLpuF2QENCMdRgRfiQ1ieGKJgcPCxk6+uXbOrOWo+bU6MeCmT8ouep/DK
 Ttqn/m/IGZpe39diYR71EEIryDzOvYgs7aA= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g4myhqbyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xa3ivzTem34HyHmXuKldnHXfVM4ZHZDUQrG7hx/TDdoXCzC3dYwob8DiqXEONmGJZTLlmivMaXwafGtTx9zmeyZtsp8b7lCrtWTOrhcPhAgG5LYZdNUjWWwswcO3xEgZHlzBBMyNNMR/lpADcJokogM6HuDW5k1SoOMEeMTHoZEojBoBQL2w1azW2h3HVNqUvIrsQSidB7ydmcr+lcNqOe+vXxfEU7xTiH/RhyhVhVvTI84ibrQ0ovnHU06KD9VJXNXDu9prMz5fi7YZ3zbv+jdpmd8gFYicbatmEExxh6uxKWOh9eF1frvOVEsmvyHckalJjkjWwSVhGhZFEyU3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fusLV4TrtI0Lvpk1xcgp7ScoBTGEqfuMm1QwN1goKU=;
 b=W6McszfcmMqujgGljp3Ra5uX8CIhJ6qRJz/IxZ0lJxa+Ku14P8mj8z5Hd+gjuzDHRI5OTYCj/D+swMhjWqqO/WJR7Kk87jBVGveiRjaP22AWiszQJZCdCXLTlRjgRkFh5XIRPiRMSFZl5fRu/GXpFIDo7XNMuUodqdUzDw5V90q+qsy8GhPys8ExtsxgMtvZn2aUqmYeyCIPc2n4t882IlVvr19ZViseKQVvzdY8KGgO9XfJspXqW35rMHUohD3mX9Ky9LHUTM7DvwYTeZzoau1AfS6BbQ1+1pI2d8cqQCcpGfrO/mFdNq4c84VPNInXVVlZ4oIhWuOf7aOtgsfDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1152.namprd15.prod.outlook.com (2603:10b6:320:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 18 May
 2022 21:10:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 21:10:48 +0000
Message-ID: <b59b2370-de7c-752b-1acb-6afe81550c92@fb.com>
Date:   Wed, 18 May 2022 14:10:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 11/18] bpftool: Add btf enum64 support
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220514031221.3240268-1-yhs@fb.com>
 <20220514031319.3245326-1-yhs@fb.com>
 <CAEf4BzZcPVsKzx+abjJruRAeg++iod6YnTfBWGhUkyit6VsGPw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZcPVsKzx+abjJruRAeg++iod6YnTfBWGhUkyit6VsGPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:a03:60::36) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9a75dc8-4cc0-444e-b40d-08da3912e158
X-MS-TrafficTypeDiagnostic: MWHPR15MB1152:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB115230CEA5D78C330D743FE9D3D19@MWHPR15MB1152.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUJ5soxVKf6+HzHBhlLRw7StV8qzDBvWyxYKeRxJMGcMDPpaMPu4N4BRBroPnvd8JkXbhwllmewx0Ka3ZcesSXd2/h8CjvnQyB1JQQjwJv6S/7V7qkmvn7Gtdp6tuj+udnTf6TT85aFZYMP3MrdS0d+5Pxefvp8hPG0Yr2YOZ4r+4CRcq2CJW2YJw0GLVNL/p8L3vpRnpnbjeOQsjcM5mUoRF+xE6C8XGHsJBAcFhuixoeOcUtR9ic+8CAYSuV9lyo+Qu8p2o4I8B9U+nOaB2EYnpoeJJzI3ZgCYZtl8LMGvw2KQ0Yqw2Ur89F9CSYGEkBp0a/EmyK5I2CBYRX8F2Vd13G6wEqad3xjp7ZI2yoj01yc7BfH2i8yGpXOk+b+VnErkOkRznuoKVagqayZrBP0j9NokTWt8AUpy2az1qFVdEBSpeoLALTeZStJ9ZvvWGhuX9WelwHmkENiXuN/uBc3GFa7u+ZJG08HbcXqRwhIzVNSfvAQQlCBT/WEB4a7lHiAE9Moi3ud5TmbfVv3c8yvBepGvogdA4gsq65JcYcFGnydP2IU3uyA+/QXO5WGOr5xLhC5BVSYMjwePnKA0lKnEF7DF7RvaihFK6NHA3nI3RKmTXdN3vWpD0zrxahulo3qBzYiN+DE389/PF8ozHlpbwcIcJWlUUryDsMXt3QdvjC166MRvy3ze1UqEvOVdS3eeABik2oq4mTCP/xkf6V2IY+TRPB4jcR2ycbbzgx812eCYArnkcRBP7tHFAKro
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(8676002)(54906003)(6916009)(36756003)(66476007)(6486002)(508600001)(66946007)(4326008)(66556008)(83380400001)(8936002)(2906002)(38100700002)(186003)(52116002)(53546011)(5660300002)(86362001)(31686004)(31696002)(6506007)(6512007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anhncHozL3hkdHMrcjJPYStRa2UyTi9idzZ6TDFLT3YxZjgycHRzRm5BUkNm?=
 =?utf-8?B?Z2hXRjFjc25vYWxlMnJhc3I4c0k5TnI4R2IyOC9NcTZFMHJOWTcweEh2bHJa?=
 =?utf-8?B?UWh6TTQvNUhpSVg5dHFZN3ErUmJqVzhVdXNKYU16Sk1EQlU3K0U3OTcwTjli?=
 =?utf-8?B?aTMzVm5qUDNMaE9Hb0lFWHU2SXg5U2wxVjNvMXhWSGMzd3FLQUZLRGljaVZp?=
 =?utf-8?B?eUZQNU5PUWhKYVRJbnNTL0FTY2oyaE5QT1dSdDJ3bDJYbDJNeEx2VU1UTGtU?=
 =?utf-8?B?ZjN2ZGtLa0s0U081dkFwdnpRaGhiV3FDNUIrMjZVdnBCc3pqMDhML3o4UGpX?=
 =?utf-8?B?dGw2Z25tNE1SQWdLWkt4MlBIMFpjWmlZRUdLWlhvS29DcDFKbHF0Si96VHh5?=
 =?utf-8?B?cWpReGRjZWxST3ZGTEZhRFNpRzhLSG1JS3JhSmh0aU1rL01kYkhzOVhFTTNy?=
 =?utf-8?B?bkx3alczWXIrQytpQWZLQmp1WGxQT0k5RXFrb1JMZ1h3dCtXLy9MZlBMc1N4?=
 =?utf-8?B?VUpYbzFEQm5GNk8yQmYrWUJHd0FhcVZrOEFMcVRUSDVJcmlOWkhQZnN3Z2dT?=
 =?utf-8?B?L1hsNnR3ZjNkaWg3emFmeFpPa1JmbGVrVkpTYWhXVGZ0clZUL0djQkI4VWxG?=
 =?utf-8?B?ZUJWb1R1K3NLc2laSE5FeWYybEVEeHFGR0xqTTZ4dndHeW5JKzFZVWtpL2xq?=
 =?utf-8?B?UCsyWHZSZEZrOUpXSWtidFhzaDFFK2w5aU80YURrQlBLZU9lSWFnbCsvZ09q?=
 =?utf-8?B?ZFkrTXRWdS9IcGNRdzBodk9TMS9ybDRqM2RhNjA3YjBaVGR0Tyt4MkNXczBS?=
 =?utf-8?B?NU5jSzZHejRPWWdVNTE5ZHhxc3E1RENCOEZIaExRcG91eno3OUN0Vlpybndj?=
 =?utf-8?B?UTJaOEUzT1poQURBU3QyeTFFMitoa1IydVZEVGZ1YjRDTkpUWEtCazhBUDJT?=
 =?utf-8?B?Si9YUmhPSHA3Q3Q0N0YrNmx1MEFkVkg2VldXRDRlamtSQThBNVdQN3l6RzEr?=
 =?utf-8?B?RmFldm1yT2wwNGdXYk04dXJIUHlaQWZWUE9zQ216cDVBV2RXVHVyQUdNTEpx?=
 =?utf-8?B?aEFPUTlMRnpnZExYNzRKVndQZUltNmhrLzdpRGNYTHdhQ3IxSEx6Z01NZUxN?=
 =?utf-8?B?aTJnU3lhUGppZEMvcVNiUHU3KzBlN2doVGZGVFFkYzREZmZBZ2RsRzJQV2NY?=
 =?utf-8?B?Z1lCSUFMckxERUhxRUN5OTJGRzhEZkszNG1QdkdBbkVEYytJOUJDL1NkZUMx?=
 =?utf-8?B?L2NRZ0xlSkhNOWRjdVdya0t2d2ZLOHM5R1JINlVFZ2ZHWHJKbVYxQ0JWZW1C?=
 =?utf-8?B?REVFN1JxKzROcDZFNkdhVDUvaElmRnlCdGRWNTBMbU1zV3Y3SG4zNEZ6T2N0?=
 =?utf-8?B?bnVSNjA3RTkwdGp2c1d4aWFFTEdoaUVrSjk0dDN2YnAwaHVlRStXRzJEczQz?=
 =?utf-8?B?TWI1THBJVUZnZ1dEZ3VKcWFlOFBqYkE5L1FLUXZ0ZDNwTWVWZUtOWmxZVmhO?=
 =?utf-8?B?VUZQTHMvekRUTkZCeGl3cUl0blBLUE1rd0hpb3JmZEpGYi85K29LQ0ZKME96?=
 =?utf-8?B?S3dhVFFBWGlqRDQxWnFvNlJYM2V2WTlFR2VUcU1sSTJ2WEVXdHV5SWZmVVcx?=
 =?utf-8?B?ZTdNQkxlbVhiVW5vTGh5aVRBS1JQWGtESnI0Qzk2YXh6QkNGQ1Bqc3grSlBI?=
 =?utf-8?B?Wk5HKzdBWE9LQjFMY1RGenZTQ1lKMi91MEUxYU1XM2FmUlJSOWpMOVlRQS9N?=
 =?utf-8?B?MGpIREhUQzMvWFBQbWZtQU8veVhxWGJDNkhsR0Q4TTZieDU4SktrcmJJVGsy?=
 =?utf-8?B?NmsydHhpcnliTFprWFo3eEV3aEtYWnQwMUlDa2FQYkswQ1BsUUlkNjErY0xD?=
 =?utf-8?B?N1BUdmNSbWFZS3JydFdCclFvVmxaU2w1NGpLU2ZmS0dUbFZxZm5FTHlRS1BL?=
 =?utf-8?B?UFJBbHNwdDgvYVo1OFlkQTIyUEp1V0N0ajM4elR2MWpUamhuMEZOa25mclh5?=
 =?utf-8?B?N3hUS0xNMnFLQWZxK3FXYm0vd3lTNGdLS2lPallXbmlhMWFlUHhnWVVNZi9h?=
 =?utf-8?B?UzBNaTVpMmptRk5qNU9jaFpJOGNUVjRyay9oTjQ3NXVaVGptaFpzRnZ0K1RK?=
 =?utf-8?B?bS9BSEJ1MllVbWxnL1N1SHdreGtqdUQ5NVZESWlNYkQyeVQ2U3dLYU9yUkd0?=
 =?utf-8?B?MG1xNHFnSndSUmNiZXM3eGFHK3p0ZjNMZFJ6QVN2b3k5WURmcTdaUkU5N25W?=
 =?utf-8?B?R09ORGt3T0N2b1VYbU9zZjMrWWVSakVqdVR5ZldvYkVhNlBZK2hyd2RGaGVE?=
 =?utf-8?B?bUJtTUYzemJFSzhsMUhoTndGNnJiS2hoY2FzbFJRbGk5Z0E2T0JkV0lxVzZl?=
 =?utf-8?Q?qJDOoXtcvo0IRIAM=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a75dc8-4cc0-444e-b40d-08da3912e158
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:10:48.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwzpG0LwZKe2X6xJrP91V8pbi/qkBUAoRzHzTcaTdQy4rMY0QOOgm706yeJNNVC9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1152
X-Proofpoint-ORIG-GUID: XXNoZfJ7LJenEjKfXEepp6YafDKcUsjI
X-Proofpoint-GUID: XXNoZfJ7LJenEjKfXEepp6YafDKcUsjI
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



On 5/17/22 4:38 PM, Andrii Nakryiko wrote:
> On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add BTF_KIND_ENUM64 support.
>> For example, the following enum is defined in uapi bpf.h.
>>    $ cat core.c
>>    enum A {
>>          BPF_F_INDEX_MASK                = 0xffffffffULL,
>>          BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
>>          BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
>>    } g;
>> Compiled with
>>    clang -target bpf -O2 -g -c core.c
>> Using bpftool to dump types and generate format C file:
>>    $ bpftool btf dump file core.o
>>    ...
>>    [1] ENUM64 'A' size=8 vlen=3
>>          'BPF_F_INDEX_MASK' val=4294967295ULL
>>          'BPF_F_CURRENT_CPU' val=4294967295ULL
>>          'BPF_F_CTXLEN_MASK' val=4503595332403200ULL
>>    $ bpftool btf dump file core.o format c
>>    ...
>>    enum A {
>>          BPF_F_INDEX_MASK = 4294967295ULL,
>>          BPF_F_CURRENT_CPU = 4294967295ULL,
>>          BPF_F_CTXLEN_MASK = 4503595332403200ULL,
>>    };
>>    ...
>>
>> The 64bit value is represented properly in BTF and C dump.
>>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/bpf/bpftool/btf.c        | 49 ++++++++++++++++++++++++++++++++--
>>   tools/bpf/bpftool/btf_dumper.c | 29 ++++++++++++++++++++
>>   tools/bpf/bpftool/gen.c        |  1 +
>>   3 files changed, 77 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index a2c665beda87..9e5db870fe53 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -40,6 +40,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>>          [BTF_KIND_FLOAT]        = "FLOAT",
>>          [BTF_KIND_DECL_TAG]     = "DECL_TAG",
>>          [BTF_KIND_TYPE_TAG]     = "TYPE_TAG",
>> +       [BTF_KIND_ENUM64]       = "ENUM64",
>>   };
>>
>>   struct btf_attach_point {
>> @@ -228,10 +229,54 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>>                          if (json_output) {
>>                                  jsonw_start_object(w);
>>                                  jsonw_string_field(w, "name", name);
>> -                               jsonw_uint_field(w, "val", v->val);
>> +                               if (btf_kflag(t))
>> +                                       jsonw_int_field(w, "val", v->val);
>> +                               else
>> +                                       jsonw_uint_field(w, "val", v->val);
>>                                  jsonw_end_object(w);
>>                          } else {
>> -                               printf("\n\t'%s' val=%u", name, v->val);
>> +                               if (btf_kflag(t))
>> +                                       printf("\n\t'%s' val=%d", name, v->val);
>> +                               else
>> +                                       printf("\n\t'%s' val=%u", name, v->val);
>> +                       }
>> +               }
>> +               if (json_output)
>> +                       jsonw_end_array(w);
>> +               break;
>> +       }
>> +       case BTF_KIND_ENUM64: {
>> +               const struct btf_enum64 *v = btf_enum64(t);
>> +               __u16 vlen = btf_vlen(t);
>> +               int i;
>> +
>> +               if (json_output) {
>> +                       jsonw_uint_field(w, "size", t->size);
>> +                       jsonw_uint_field(w, "vlen", vlen);
>> +                       jsonw_name(w, "values");
>> +                       jsonw_start_array(w);
>> +               } else {
>> +                       printf(" size=%u vlen=%u", t->size, vlen);
>> +               }
>> +               for (i = 0; i < vlen; i++, v++) {
>> +                       const char *name = btf_str(btf, v->name_off);
>> +                       __u64 val = ((__u64)v->val_hi32 << 32) | v->val_lo32;
>> +
>> +                       if (json_output) {
>> +                               jsonw_start_object(w);
>> +                               jsonw_string_field(w, "name", name);
> 
> forgot emitting kflag itself (both in bpftool and in selftests), let's
> add that for both enum and enum64?

will do. I will also check other places whether I missed or not.

> 
>> +                               if (btf_kflag(t))
>> +                                       jsonw_int_field(w, "val", val);
>> +                               else
>> +                                       jsonw_uint_field(w, "val", val);
>> +                               jsonw_end_object(w);
>> +                       } else {
>> +                               if (btf_kflag(t))
>> +                                       printf("\n\t'%s' val=%lldLL", name,
>> +                                              (unsigned long long)val);
>> +                               else
>> +                                       printf("\n\t'%s' val=%lluULL", name,
>> +                                              (unsigned long long)val);
>>                          }
>>                  }
>>                  if (json_output)
> 
> [...]
