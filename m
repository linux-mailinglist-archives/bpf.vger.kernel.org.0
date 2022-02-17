Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A536A4BAD93
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 00:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiBQXzr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 18:55:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiBQXzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 18:55:43 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC16F140D6
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 15:55:26 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21HLV5IN021567;
        Thu, 17 Feb 2022 15:55:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=W/cz7/+ar7v1GjuR/BVtNF/cHiyyijlhJF03UpqqI78=;
 b=AqYj02iXhhTfXh3+F+1tx4xGy0XohGsJvjsafXYj/KCvgtDdwkorcTkvl+jJCIVhG7zb
 3IR08tQyeS1jDFn0eq0xtDGoCbs9uADGIZpMQn/T5K3AVGygEtTzTZVIeiYxnUpsJew9
 MpsCHiPqTG5b8ZuE5LCazTN+RH9M1pLrCjU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e9e837515-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Feb 2022 15:55:09 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 15:55:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j708LzdwVQdh/dqVZXFu0OutVn58TVC/SQZXZrSiZI0v5yQqOCwlCqrmqJD9dt1t+a3/TyyjdBHtjITM4BrvrenaaR6yNlDbikYGFTX3mCbRRdkN9iMX0cexSEDpwkBCKoWIZjPv1ZuUuatoLaxwHgXdLvWyRPvotqoIZ+Yribem0I2AOrdXI/JrudIH57Q3omdGelpeuD0H0eXd0RLuTiK9LMp0+QnGUSVpvI4RZe4vF+yXxRV39/L1ic/SzXMPfjxcaMVpjLHFLcZbkwYA0DXed940bMxxZIpaKH/o3YMO/2JqYmni36eEuqP4ugtOPP3R/8EAqFr8lRE8SkgD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/cz7/+ar7v1GjuR/BVtNF/cHiyyijlhJF03UpqqI78=;
 b=jjKyCnLb81cC7KcJ+NOCazFWfUWDIhxrziOksXscN94XuQNbOzhjIookvEwQnJLvhmDccebrWxj4gb0xFlEdnDsOJoBzRL4UQt9aIvaN/h0OMx0b07+26IDCG1Zb3dlr6NrUqBd4T4vUgBs6TZWAmAOzpSgqOW8DTVi3dd+OEJ+NLCeJIKi6bd/fwtuYuoqSfKuwggt/XydQwFTni225lKx8RAL8WQRsAODJyyKo8HQpM3q6+CT4imDoia7TWAzI5vUVrZpnV9TObX0q8DZ3NyTCml1cE11c7U9iAolPhlWwk+QTVJkIs4fVYdL5qxa9jG8yGRrqTDtSz6r4dJpgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4621.namprd15.prod.outlook.com (2603:10b6:510:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 17 Feb
 2022 23:55:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 23:55:04 +0000
Message-ID: <d3d11e33-754c-dcc0-a63c-697ecfb63de0@fb.com>
Date:   Thu, 17 Feb 2022 15:55:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a clang
 deprecated-declarations compilation error
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220217194005.2765348-1-yhs@fb.com>
 <CAEf4BzaWczdp4JnK8t-Fd95zsVcadUuXmE9nB_icvnimztfDWg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzaWczdp4JnK8t-Fd95zsVcadUuXmE9nB_icvnimztfDWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0238.namprd04.prod.outlook.com
 (2603:10b6:303:87::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e420a8df-4a38-4134-281b-08d9f270eb24
X-MS-TrafficTypeDiagnostic: PH0PR15MB4621:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB4621EF1A42B76BD742CBDCB1D3369@PH0PR15MB4621.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6O8T+LRp2QKSa8aAO6eqskFYkVT+5y2TgbTwntioXk0our3U6Ukk0BAVdb2lgiV/1oDiGnY355sxN3krnK9SPMBQTcrlTaeP9VNUkCUZw7cJheGpWNgqD9VVGMC5TpHicsLUKhLZv928EsLeTagloyBLXiauvejxkcVwV3V5fUbWrrtG2ZUJDZSZ8C+lB5fupP5jBTMsv+QrFn7w1HHBmqwi5/6oIGJRpkbMTnoqYdpICUNoIPACI7vXez/1lBWRBB8UjTn5lBJx4Mpn8xeguewU41HRqZI81kliHt4GqgUzhrdx4DcKD4ls/M1+MLEgQFtChMZspAjAGTokLrsnRILPmXB9L4U6RmjPxCYr2lhBKX15cpfsT21rf2AvdbKJF1ly5xR0kEvXFKTcLm8m5KH/zJAGJCjys1e9ZZohOCtITpu4iVcFwbDZFpgyPPaISUxbiTGQhNXisEN7mbJinWGQEshqcB/jlrLKG60aOhDK4M6WuqdF1Z4zW0J26vwVd/mJRaUkwd6wkO/Wd76t/PUo0TetSKjNf0BOYnnAtBAzRh9YeFHAaiqkdiJGC5swE4ew6B3eEwTWchD1RkaqZsCPlKoOWRzJPJXWvpIiHU4S7bsEh8Y+cqlGLWhZRIqNYLOrvmCbU2Uoc8aBNXJSRkCFu/IvVuIDy+6NoUKRi8bNQRjgoF6TsPf+/IInGn9iEQpP/hEBPB9cMiZDDgH+YqQww5JoGFD1+wfhXc2ZRVbADwGAujWkAIQ2IIcLkih
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(31686004)(4326008)(6916009)(31696002)(6666004)(86362001)(5660300002)(6506007)(8936002)(8676002)(6512007)(66946007)(186003)(2906002)(36756003)(38100700002)(54906003)(52116002)(6486002)(316002)(83380400001)(53546011)(2616005)(66476007)(66556008)(2004002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3NVTmZNRnRWZE1vWVVtZTJIRmZheHFFcUM2dFBxR0FsbEhwZnJlMGNlNlIw?=
 =?utf-8?B?NTQyYThMV3IvOVpBT1RjRlliVElraHFNVURSSmpMME5kTFpVNENTd2J1S1pR?=
 =?utf-8?B?c1dXVUpFS3JLa0F1NERCK1lRcjB3V0NEUmRvdlFDUk15V2t2clJuQUpzT2lW?=
 =?utf-8?B?bG1yaUNOdVk3Zk9WNVAyN0FBbnppNE91MUVpUkQyOGp2MUlnVGxDakwyMW1F?=
 =?utf-8?B?Y0JmWFdSSDJIWTdxbTRoY1hwZXFha3pIMWxrekROdGlNdmI3eVU0N0V6MG04?=
 =?utf-8?B?bkI2WkNqaWlscU9NcDZ5NEJOclF1RW9UNXNHWVk5RXNPblN5ZmRaTHlieXE2?=
 =?utf-8?B?Z29vQUlvVFNDbE1TRE9tMk5YREtNcTNXUHEvdjN2bThyZkk3MjNNSXlaSDVO?=
 =?utf-8?B?eSs5Z2U0L0twdkk0YmpES2xMYkFBbFpIVndJY0dFczhuRmZQSW5tU1JIYTM2?=
 =?utf-8?B?T0NMNkpRUm84b09YbkVEYnk0MjJobmlUT3NyLy92dmVESWwyYjhLT0pvMTRH?=
 =?utf-8?B?eG9jMXViODB5TnF2Y3JXNjIraVpXMEJrMXR0ZlpEL294Z1FDQTZ1b1pkOVpK?=
 =?utf-8?B?YXVzUmJPVTFyaWZMWDNidHZDZE1XQUxSelFPMDBTakE1SWR5YllvZDFnRTE0?=
 =?utf-8?B?b1JNRHphbmZQbUZXOHpvY28yZVZwbVdnS21VNmJwdHQ0Y3RnWStaMUl6ZzZE?=
 =?utf-8?B?ZkN2Z0VvajdaNC9UN1ludS84a3R1UGFTK0NxWitaTEgwRzJGc1FFaWtEL1JV?=
 =?utf-8?B?WldHdGZKdWkyNzVTZVVwZUYvOVh6VkdiZTdoaDBCZ2Y0VmZ2OXBETHF1UDBv?=
 =?utf-8?B?UThDVzBWZkhUQk1GSEVqQ0N5SDZOZDFoaTYwYmxJTWFqeXJlNzJsZXlYbE45?=
 =?utf-8?B?QlZvZzc3T28wU0EyVkRMaEZObmFJUS8vc3U1TzZCd2xxRllEb29pRDdKck5q?=
 =?utf-8?B?dEdhOEE0cTJId3Z0MlljNkdMenJoMVV1eHIvdkFOUEliMDN6ZDA2bjQ1ZXU2?=
 =?utf-8?B?bWxkZWhKTFZXbWJkdm5PcFZ5TnRQVWt6ZENENkZsMHlva2p5aXZoelBkQ04v?=
 =?utf-8?B?K3BqOWlxd1ZhUVIvenNZRithTjErZHRUVUtOOHpTcGJEUTA2Z3A2dVQ1UllY?=
 =?utf-8?B?cEQrMUl0WElBdmZmbDBQN2lLREhDNWxXMHdZNGgvWU80WnEzcEQ5MTBYdEkr?=
 =?utf-8?B?WjQwNVNoaTNZWS9pYk5iU0VTbFY1T3RjcEhpdUVMSjhpQlNRbGRsNGVBWU5Z?=
 =?utf-8?B?WHJSZUtzMVBPVThWY3orWVdjQk1YbkpFMm9jenkxRzNhSUlvdUV3WEtYRHIr?=
 =?utf-8?B?NEZwUFpETDZRdGNvYXF6YlE0TGFBV0o4NmFWcWRKckt1TmFQdnBQQzhoUXJ6?=
 =?utf-8?B?NVRnUUE2TXhEVi9OMFM2T1Z0eklFbkhQcldyVWZQYnlkdXBRQTBodk5XWnZp?=
 =?utf-8?B?OVd0SlQ2SG1YUTIrQnJzdUxhczFhUkt5YXl4Z2kxbFM4enp2SWdXclBsdExQ?=
 =?utf-8?B?NFFDSW11UlVlTWQxdHBSM0w0OG4rTEREMWpKTDE3N0xyV0xCM0hUUXdGQzNq?=
 =?utf-8?B?RHZxRmRKSnRmOVM4TE0rYjZsUXZiait4OXVpd0QyS0pmS1o0WEhQODFRMmoz?=
 =?utf-8?B?a2MraTgyWVE5UldLcS90VUVxUE1TYkpIMG1sZ01VZHF3Y1JWblpqanluU3RG?=
 =?utf-8?B?Z3pveFRTT1pNdjRRd1VsbTE3M0NLang5cndDOEs2WDFxb2VaNVZGMitvalRO?=
 =?utf-8?B?Z2V5Nms2Rk1IRlMyTTh0bVpKQ3o5Q1NnUEQ1NEVqUERkNzVNN1V0OFdnOHds?=
 =?utf-8?B?RXlxczFGMmNIRmFhaWxYU29uODhQbjRnazkxY01BQnBXVkFxVlllUUdFWS9F?=
 =?utf-8?B?em5nOWpFOVdHVlVqakJWaHRxWFFzV3VacjZlSnVOckRabEYwd2tkM3djaGlo?=
 =?utf-8?B?QVc4cHlBWHZDRm9QSUFia08xalZnOHhnNXJXbE5YYWNNNGJ5Nk5LdFQ0dmxU?=
 =?utf-8?B?MzMwVCtwZ3AyNGNaNlpvYnUyOUw4eUM3b0poaDVhNDBrMzZVNGJlRmNuMVQ0?=
 =?utf-8?B?SXk4OEwvbjJvM3ZEb3RaRUg3bjh2SVRIbW4yL2o0RDg4ZVVndEwrMGlmVVdJ?=
 =?utf-8?Q?vulzkC4jopGWVKufd5zVu2tkV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e420a8df-4a38-4134-281b-08d9f270eb24
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 23:55:04.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu4pLtX/uBdk5zAYafdthAZrJcGGwXW+ex+9w/F21sX8w6zTV3iOs9JsJt4lQegL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4621
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 8mL8V3oFIMwcCIt5oLxtg2uD2ucemnTE
X-Proofpoint-GUID: 8mL8V3oFIMwcCIt5oLxtg2uD2ucemnTE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_09,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202170115
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/17/22 1:59 PM, Andrii Nakryiko wrote:
> On Thu, Feb 17, 2022 at 11:40 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Build the kernel and selftest with clang compiler with LLVM=1,
>>    make -j LLVM=1
>>    make -C tools/testing/selftests/bpf -j LLVM=1
>>
>> I hit the following selftests/bpf compilation error:
>>    In file included from test_cpp.cpp:3:
>>    /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf.h:73:8:
>>      error: 'relaxed_core_relocs' is deprecated: libbpf v0.6+: field has no effect [-Werror,-Wdeprecated-declarations]
>>    struct bpf_object_open_opts {
>>           ^
>>    test_cpp.cpp:56:2: note: in implicit move constructor for 'bpf_object_open_opts' first required here
>>            LIBBPF_OPTS(bpf_object_open_opts, opts);
>>            ^
>>    /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:77:3: note: expanded from macro 'LIBBPF_OPTS'
>>                    (struct TYPE) {                                             \
>>                    ^
>>    /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf.h:90:2: note: 'relaxed_core_relocs' has been explicitly marked deprecated here
>>            LIBBPF_DEPRECATED_SINCE(0, 6, "field has no effect")
>>            ^
>>    /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:24:4: note: expanded from macro 'LIBBPF_DEPRECATED_SINCE'
>>                    (LIBBPF_DEPRECATED("libbpf v" # major "." # minor "+: " msg))
>>                     ^
>>    /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:19:47: note: expanded from macro 'LIBBPF_DEPRECATED'
>>    #define LIBBPF_DEPRECATED(msg) __attribute__((deprecated(msg)))
>>
>> There are two ways to fix the issue, one is to use GCC diagnostic ignore pragma, and the
>> other is to open code bpf_object_open_opts instead of using LIBBPF_OPTS.
>> Since in general LIBBPF_OPTS is preferred, the patch fixed the issue by
>> adding proper GCC diagnostic ignore pragmas.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> Do you know why we see this only with Clang? Why GCC doesn't generate this?

Not a gcc internal expert. But I guess gcc didn't look into struct field 
deprecated attribute.

The following is a simpler reproducer. The structure initialization
in the code means the compiler needs to initialize each named field
with either default value (0) or provided value. If one of fields
is marked as deprecated, the compiler can emit warning message since
that field is accessed.

[$ ~/tmp3] cat t.cc
struct bpf_object_open_opts {
         long sz;
         const char *objname;
         int relax_maps;
         int relaxed_core_relocs __attribute__((deprecated("msg")));
         const char *pin_root_path;
};

void foo(void *);
int test(void) {
         struct bpf_object_open_opts tmp = (struct bpf_object_open_opts) 
{ .sz = 2, };
         foo(&tmp);
         return 0;
}

[$ ~/tmp3] clang++ -c -g t.cc -Wall -Werror
t.cc:1:8: error: 'relaxed_core_relocs' is deprecated: msg 
[-Werror,-Wdeprecated-declarations]
struct bpf_object_open_opts {
        ^
t.cc:11:43: note: in implicit move constructor for 
'bpf_object_open_opts' first required here
         struct bpf_object_open_opts tmp = (struct bpf_object_open_opts) 
{ .sz = 2, };
                                           ^
t.cc:5:41: note: 'relaxed_core_relocs' has been explicitly marked 
deprecated here
         int relaxed_core_relocs __attribute__((deprecated("msg")));
                                                ^
1 error generated.
[$ ~/tmp3] g++ -c -g t.cc -Wall -Werror
[$ ~/tmp3] g++ --version
g++ (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3)
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[$ ~/tmp3]

> 
> 
>>   tools/testing/selftests/bpf/test_cpp.cpp | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/selftests/bpf/test_cpp.cpp
>> index 773f165c4898..19ad172036da 100644
>> --- a/tools/testing/selftests/bpf/test_cpp.cpp
>> +++ b/tools/testing/selftests/bpf/test_cpp.cpp
>> @@ -1,6 +1,9 @@
>>   /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
>>   #include <iostream>
>> +#pragma GCC diagnostic push
>> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
>>   #include <bpf/libbpf.h>
>> +#pragma GCC diagnostic pop
>>   #include <bpf/bpf.h>
>>   #include <bpf/btf.h>
>>   #include "test_core_extern.skel.h"
>> --
>> 2.30.2
>>
