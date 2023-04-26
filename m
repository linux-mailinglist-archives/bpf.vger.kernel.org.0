Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519F86EFBEC
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 22:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjDZUux (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 16:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjDZUuw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 16:50:52 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01076213A;
        Wed, 26 Apr 2023 13:50:23 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QHl8KR028280;
        Wed, 26 Apr 2023 13:49:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=1sUpvc6uuRT38vDmZoquyBO2N4Q9bnKDIdqcLKy0Jv4=;
 b=ClCXngj2kcW8UwC3gWfpQtAZswxDFpIeL8yrgAu26aB7XY4oWUs+Dyw7pgGkDfZwLibv
 +z9nH/JJt46cMHuC1LsrtLG1niy+8X9YAUVKZA8bGSb1qNzt13+I6f1M6VmhlXoyE78m
 HgJpjXS0V2Mpz5r98veoQhWeau88eyXEytR0+076VRHU6VGMYueHLq24DBphCU3EyCkb
 ujheK6ybnkOwgf9ob6ys+T58RyzHnhTCE2YOUOMNixG43WD555LESXrkP8OLt7jgsdTe
 MX+4w6y1T8fVPIgW0fyuQxJ2w6/DPF8BF6qaRvMvZaU9K2hMepTuQTm9gewCmScu5v6i KA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6qfky74c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 13:49:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=De5sBTyvzgIdrFxn/qyji5dkwz/mF4ChBWP0EpXP8vdy+5b1EIUZ9g0/tNQSyGZ55r488uzDPGoaAm0FuIUsO+DNwnkzZk3ZpU6JM8ZCXc8Y8brlRsPMs0Yaqh4ouheVd7M9nwVcTPxGDB0WbPuqtuiJ+Pk41ZD2H7aiM5qBDVEPEG9QL4hQcnN2cFYz3JyrU535je1W0rfYsSfAWtI9j1qTtKDdquj3airw09ERpS6pnbjS9Wcc5e1QxcV9UiZIYcBr+UQJT58mridwPY3p+3egptkK0PDTQ+RFM4UlWDBFVsF8YNkDjaUPhHPLW+mY+68sy3VrYumpzkxQxfK8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sUpvc6uuRT38vDmZoquyBO2N4Q9bnKDIdqcLKy0Jv4=;
 b=GVz9rQYhco776c0odOBGb0AleoMUvbt8X07+IpHCqZ0mljU6aFKvDRqxHAC1TUdvaH5smSbR1uRhBUBE4MyJfor9E6ktvFgPNbSWViCHjkDpXQAjyIoRuk6I5/wdZuh85HnhXsWz9te9rt7xdkcv18DB40OaDyHjiuBzBmHT3XxAmS3xAXimX1DBfKYff4Za//R0Nl5SaPEkEkkrdtH4dKTKgzEhw/51cIqVFGwyvWHi1mWJEl41NIZz66txb91S71aShglJDyQj4XTBdp2iPBKclaKN1zsfiB85qIn1ktm1FsOGbGL5Q4hO1v3b7hUCP4KoGWPu7Tg9FEO42+Xmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB4826.namprd15.prod.outlook.com (2603:10b6:303:fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 20:49:50 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 20:49:49 +0000
Message-ID: <632e7eb5-dcd9-5863-da59-30d7a27aceda@meta.com>
Date:   Wed, 26 Apr 2023 13:49:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH dwarves] btf_encoder: Fix a dwarf type
 DW_ATE_unsigned_1024 to btf encoding issue
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eduard Zingerman <eddyz87@gmail.com>, kernel-team@fb.com,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
References: <20230426055030.3743074-1-yhs@fb.com>
 <CAKwvOdnXh0e0F=_5nuVcMNsHAkqkc+K5FrOmktFZ76z3X_zHug@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAKwvOdnXh0e0F=_5nuVcMNsHAkqkc+K5FrOmktFZ76z3X_zHug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0364.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO1PR15MB4826:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f82d82b-cb85-40f5-ff22-08db4697c700
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eMrA+imGGw7SYc6yWMPRhRRdwFNIonl9MSrPIb+3OUug5/JLY13bS3QaJBO0cdmb9dT9BxGzYk7memPxr7GaxWBtprM1nIpgxUNBNWO4XFLvJ516uym/DMt7xqDOnELUdPH4ZGePsqm+XZwi1Q6vvqFSAInFovMEnlQeE1O+KRxCtuHMkgMw35BbSGYfm6jXUCOwO3/vX1E3J7zCcOxfq5hsWOEI1iISqgUlV4h+PJqEne29WvEVhJ90ADk3AjZIHWuR7VEh3DSR6zn4eYJ+COTA9VoOJMBvRlmZIlScq0awizJSfKlV5O2uCHavdgkedT8GPczo0z17LBm6MeIfBPvgVbKKbTEh2+g2SOMsYO1Yvj76kyxeCIo7n1E0fTVgJ/IUMX1MRycW7vhA4yrQr2pMAVqFclINbtgVWFQqiHdTAVbOPUK+PwuPZj8Ruk7R8eS5M0HJvtIXS0a9RvybsCW92wbxMijduqt9++dGJnwcQLJEPlwKt+qjbZbu8rMeqD9XHL0DR8c81NBMCIuYywJoo92o/F0xzp9GnNXHQSr49WGCCqlmOWh4muM6Uv2VN7FRqinU+RI5khw7rXR2aSg3BWojTfHeaQis0sgEY4XNcSi/U7SCCCz7Vszfs5nHOfl2l2j2jIHpUxJzC2M2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199021)(2906002)(2616005)(110136005)(53546011)(83380400001)(478600001)(6486002)(54906003)(66946007)(66556008)(966005)(6666004)(4326008)(66476007)(186003)(8676002)(5660300002)(6506007)(316002)(41300700001)(8936002)(6512007)(86362001)(31696002)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2g3bzZrTTRQVDF4V2VsKzhleGFheURHd1J1bXBITi91bFd0VVArcjFMZ0d0?=
 =?utf-8?B?MVRDUCtnR1RTbVlrdjFIbFU4ckJmWTJpMkhRWm5uVjZ5RWtaSzc0NGZZRGZD?=
 =?utf-8?B?VjRBaks0WHludENVQXRjY1k2N0FmZncvYmswVHdrMzBpaVJTaFcxTDJna3Bk?=
 =?utf-8?B?UU5iMk1FQzZsbU5ZRnJwWjZnVWd2eG1rTGxPRXJIKzd2Z1VOUDdmNUpFVWVr?=
 =?utf-8?B?YlI2RDlMdlhqL3Z4dU9MakZSdXI0L3E5Y1JUemNNNUp1VU92NGlwTG01TFFX?=
 =?utf-8?B?R21zOW1OdndYVXA0NUhTb3QySFVLbnlucmFVWjJ0U1JkdDZ5SGZZRUdFdTR2?=
 =?utf-8?B?YU5FZnJSakNRVmFhZWhSN1FNcWU1czFFbzlQT09nQkxOVGxDcHlQNXovemFw?=
 =?utf-8?B?UjlHTllhVEM4Y0gyQU84UUxIdEFDY2ZJK2tPNFRMKzR6UzNiR0pIenJURG03?=
 =?utf-8?B?aG5teUNNbmJOM3Z3MG9ueFVHMzlSTHNuWFl3YTVqT1dBM0dPZ0ZaK29kZW5X?=
 =?utf-8?B?TnNUSHlKbHRqU0c1dFBaUVNpbFR0dG52SmFuVG9oaUN1OXFUcnB5dWR4Q2l3?=
 =?utf-8?B?WFd1V3ZxM1Rpa3NxaFZOYjRJZlR6cG8wd01wTStTRWFrV05zZG4xUGJJVndE?=
 =?utf-8?B?MGNEaytmdm41WjZkNGFnN3lhOTR3ZzFGdVpKak9yZnJQRmpsYjFoZ3VRUmdq?=
 =?utf-8?B?bFd5dzVwNUlWdEYwZWRPY2w5RFA5cUZpSUc4VkxiaC83UFVXTWs5V0JIem9p?=
 =?utf-8?B?YTVkWmVsSDFBU3NLL3JydktQT1IxVHhtZVNxMlZNTWNqZlQvejRWRy84NmhJ?=
 =?utf-8?B?R1dzOWNPWHhFcVgxcFQxdGl0VkFPNjBEbkQxdFkyd250SE84a2RHWVdXNTJw?=
 =?utf-8?B?R2RXQTlKVnNMUW1iNWs3MDY3Wko4UDVPeVJjMmFNZVBRNnR3aXJNWlFHWHRJ?=
 =?utf-8?B?LzNtSzhnTHFsM2ExRkRHSnBucDl1S3pDTzJNblplUkRza083S05oVlhQSVRt?=
 =?utf-8?B?d3IvdnpkeUxKbjRaUlVpY2lVcmxncWF0aEFCNGRuUjdSUnY5MTdPK1E3REJQ?=
 =?utf-8?B?bGsvRG1tZXBVbldwTHpOZGdHOEpyMElCRm9lS1E1cG5TNWZPTkliaGFaSkps?=
 =?utf-8?B?WTgrd3hkUWxzUFQ3Y0tXN0pTUlF3eXJQTlhvVlZBdkEzREJ4VkMzZmY4V0d6?=
 =?utf-8?B?dUNJaUpFcUpDSVlIamt5N01rZEYwaTVPMERRTk5LOFhyWUptODlmeEFXK1Mz?=
 =?utf-8?B?T3BXUjFpNGxOeUNnd2tQNFlpSUJXMkhXU1Axby9lVGZFN3htbXR3NkRrbEVq?=
 =?utf-8?B?VDdPQUxxUDlnVUlobXJsRlFuZGNlZ2dLdWJCd2dYTkdoZlM4dGxNeUpFcjVG?=
 =?utf-8?B?TklDK0Z2K1gxN0E2Y004UFZpa1FNQ25PQWpYc1RoY2JleVhVeEltUDA4eSs0?=
 =?utf-8?B?NURlM0I3NFQ4N0xsNVVRUFpWZzZmTUxjRkNQSExGVDZpMzRvcnZjalRROGQy?=
 =?utf-8?B?cHFyQ3N0MUNVSTVVWWFweURuM1NvUFJ5bDlIazlXY0g2SnF5R0I4dXFuL2xp?=
 =?utf-8?B?TE00U2ZuMVZLSmJ1WGROV0E3czZrZHByQmk1dlRyK3N1U1ZVa1ZqT3Rja1Z5?=
 =?utf-8?B?SmdYSHlXMXYzbGFvMitrNVkxNC9EZnJWVTlPMU1taFNiNjdURmVUZDlUbDVB?=
 =?utf-8?B?SDBnVk1RUFlYcnNLb2Via1BXaXlQczZKTlRtM3A0VDR3YmN5WmRHTnptQTM2?=
 =?utf-8?B?S3gxdUhaWHdZQTNOY3VBUG13R0FyTWNPdy9YTTlzUjlrRWE2YjAwMWJCUk5Z?=
 =?utf-8?B?TmM1QVZrdkMzRkdDV1IrUW5iU0NXUy9oU2pJNTZGeERabFhnYnV4M2kvenZ1?=
 =?utf-8?B?NnFYbE05aVVoQ2k3V1ZZb096QjZxOXlOUXJMU1U0MGNCN21PZ2o5TFhSVVVv?=
 =?utf-8?B?SklWczVrQ3p6K3hsVDlaay9pYVY2RWhsWW1sQklOMjN0UDNBMlJhWk1tOFlG?=
 =?utf-8?B?TXcvRHFGZytLSDNpb0ticmx0cGpEalErZ0RPSVp1bzRyalhHWElzMjZWemVn?=
 =?utf-8?B?aFB2dDBCdnVuQy80VC9rYkxCU1VOYmZMVXdyL2RVUFJWSXNJZFdvS3Z5dVUw?=
 =?utf-8?B?K3QwS0F3WHcvdzJUVXZFQ1c3UU5Uc3ZweDRMNkVnNWlJOWdOdlRacVBUM0Rx?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f82d82b-cb85-40f5-ff22-08db4697c700
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 20:49:49.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnRw0MjDE2mVlyHQZrTU0259zZ/kQhB7vxvtBHfyjnMf+YbPyQXczCowg79DxoSR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4826
X-Proofpoint-GUID: XQOBZFXEOA6xunPaemrRuOq3E5hrl01T
X-Proofpoint-ORIG-GUID: XQOBZFXEOA6xunPaemrRuOq3E5hrl01T
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/26/23 11:09 AM, Nick Desaulniers wrote:
> On Tue, Apr 25, 2023 at 10:50 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Nick Desaulniers reported an issue ([1]) where an 128-byte sized type
>> (DW_ATE_unsigned_1024) cannot be encoded into BTF with failure message
>> likes below:
>>    $ pahole -J reduced.o
>>    [2] INT DW_ATE_unsigned_1024 Error emitting BTF type
>>    Encountered error while encoding BTF.
>> See [1] for how to reproduce the issue.
>>
>> The failure is due to currently BTF int type only supports upto 16
>> bytes (__int128) and in this case the dwarf int type is 128-byte.
>>
>> The DW_ATE_unsigned_1024 is not a normal type for variable/func
>> declaration etc. It is used in DW_AT_location. There are two
>> ways to resolve this issue.
>>    (1). If btf encoding is expected, remove all dwarf int types
>>         where btf encoding will failure, e.g., non-power-of-2
>>         bytes, or greater than 16 bytes.
>>    (2). do a sanitization in btf_encoder ([2]).
>>
>> This patch uses method (2) since it is a simple fix in btf_encoder.
>> I checked my local built vmlinux with latest
>> bpf-next. There is only one instance of DW_ATE_unsigned_24 (used in
>> DW_AT_location) so I expect irregular int types should be very rare.
>>
>>    [1] https://github.com/libbpf/libbpf/pull/680
>>    [2] commit 7d8e829f636f ("btf_encoder: Sanitize non-regular int base type")
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
> 
> Thanks, this fixed the above reported error for me.  My report is just
> forwarded from Satya.
> 
> Reported-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> I don't know if that change has other implications for unusual byte sizes.
> 
> We might need to consider at some point waiting to validate
> DW_TAG_base_type until we know that they're not used outside of
> DW_AT_location expressions.

David Blaikie confirmed that indeed special types like 
DW_ATE_unsigned_1024 is indeed generated for DW_AT_location.
See https://github.com/libbpf/libbpf/pull/680 for details.

> 
>> ---
>>   btf_encoder.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 65f6e71..1aa0ad0 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -394,7 +394,7 @@ static int32_t btf_encoder__add_base_type(struct btf_encoder *encoder, const str
>>           * these non-regular int types to avoid libbpf/kernel complaints.
>>           */
>>          byte_sz = BITS_ROUNDUP_BYTES(bt->bit_size);
>> -       if (!byte_sz || (byte_sz & (byte_sz - 1))) {
>> +       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16) {
>>                  name = "__SANITIZED_FAKE_INT__";
>>                  byte_sz = 4;
>>          }
>> --
>> 2.34.1
>>
> 
> 
