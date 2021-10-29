Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC4444057F
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 00:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhJ2Wdr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 18:33:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43074 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhJ2Wdq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 18:33:46 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TLXCK3023996;
        Fri, 29 Oct 2021 15:31:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=G39O87wbUBoFi33kV4F4qH5SIlD4dczeV4Vlx67qoak=;
 b=b8c01Qq5BoNz6htRImbKhPSQODecC9RaLFftG5FFZcujnaOOq1nNDwUdHJLoT7seABZv
 TFy/qg4jTvjCg2LWWn0UpqW0PRA100lP/m5CSe4osa3QqaAagOOhr1R756yQNGQGD/oW
 mtrO3YlOMxu1WfnDDhAlnPG0XljSQA0z8P0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0mdnkaru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Oct 2021 15:31:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 15:31:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn9EklrEb5tMd3D4NGg1jjLhdQPKiwxb2CGGzt0jIrBGfa7cBRMHqJqlNfVaX/pFSgp0gZz/rNmhrsJKU0fglN2Ey776wUt14JhQJNEWerkrOyD0CpT8UiIdqIyrtAp/wYeReE8pPgPCNyOenvES+2ctbfo1OzLHhMC2eMpr4FUOS747Ib5n7dHCGxvvOEf2QbkF47AjDZ7Gmkv4OjQ4Xz7qoz0EwOepJ00fF0eoN8mvXMqdZowlT1mfSNapRhtVV84i28I02Fykx133dceoHVH48L5h8WmeIUsLI3NzHC8BbQ4NY7douGqmVHNpGENgS8CKhgVvqDuJ7yagMTr7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G39O87wbUBoFi33kV4F4qH5SIlD4dczeV4Vlx67qoak=;
 b=h3WL1IEN+xYMN+k2ygo62vDV0Cuo3clT4E6yO5cCw5375Wva7r9OgWv3t/UntLfE7+x5rUUWKEvlH9XGpJ9Oy6jhTxGWg7s3GzaOJJSPC84YQepGzX90Rvlwcz1TVMsb5xzizCoOkTwduvt/dgzHqQ4+eILaWmxa4aV7GTZxThBbnk3J0gLguwnvdnyVsfJOpMWGiNoVMv5YIl32z+zlA5qloDjkP7WYO1vLGU7A5/MtZ+iUX7qAi7vuh+9dHDEtjuqTJ1fx7OaGWpCEJuKgoH8G/26GFpEwjTe2VzhWnfKd56nsJb38INx1aGx+jVIXlQ1zhYH2I1s56DmjthOpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR15MB2240.namprd15.prod.outlook.com (2603:10b6:805:22::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 22:31:03 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b%7]) with mapi id 15.20.4649.017; Fri, 29 Oct 2021
 22:31:02 +0000
Message-ID: <e0b8bc63-c330-4d6a-ca49-6315648dd815@fb.com>
Date:   Fri, 29 Oct 2021 15:30:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add bloom map success test
 for userspace calls
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>
References: <20211029170126.4189338-1-joannekoong@fb.com>
 <20211029170126.4189338-4-joannekoong@fb.com>
 <d2de3cf7-7f0f-dbdc-63e3-c91478b16ae7@fb.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <d2de3cf7-7f0f-dbdc-63e3-c91478b16ae7@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:301:4a::12) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c8::1716] (2620:10d:c090:400::5:9469) by MWHPR1201CA0002.namprd12.prod.outlook.com (2603:10b6:301:4a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 22:31:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9c5832d-ba8a-4476-7b63-08d99b2bca1e
X-MS-TrafficTypeDiagnostic: SN6PR15MB2240:
X-Microsoft-Antispam-PRVS: <SN6PR15MB22406FB108EFC41A4134A517D2879@SN6PR15MB2240.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQWKKClROAnCmhOWhRJOZAN6mGdWr5O4WAlMevxZIfQFPO4bz4y5K12voj/uMgLij7LLIoNQLSkvaJJ+bnkp6SdpTk6AqIFzoCd/sU+Nqw55YYAg1TlX6o6MPGlhXFsDnCRBzYbrTOC6mNsHEHmxj251uGqfPSNrNxfNIPMGzG67w84AUFHEpjtMN1jIZjy0eBHeVkFqhdUWM2CVBsNHoPCmG6kQhGPjkOHTVNt+8n6wFu2hdMWYWV8T8Z7yNQPtrIjdXuh1EYcRDrSAyXDUBWTxAxbPEM4ionGSptjIKW0MMbjaJtAKJhnBGGjxKyuXx1knSwE5B4ThswK/aaGZG7TBkPAey+COX7KWRbdBkVcLRpgdkv9NGBVu6kqGQWfgGwIR0ri3Hkq8v3BGA02kjaKYe23SvDT3ckkGpQXjghNUFw0/PjsJbBcAzkFJ5dI7wxP71ivyArVp0B9tqLFFzkAxoyqa3kYd6oEnFJ6bjnF3KPkMQ5/JfjxJvfCeVuJ5pjz4orgPanumvkzCvrTBAbZ0rbXdZR2G+g7mLduKSmp7GRiLOEv2lRV12/AkdiOoEi9jvEuYy3Ga+9hPdfsW7sp0qoYlAjpiKTAxTu6Bx+5IAa9vPg9A7XDIHvTT69tCSLAwUQwfRNEDbJXwHextX8Hh9EDeKyHRd+Fir7ghn7qyAt6zxHirVMvp9E1WfNa9spm/6YJHJ5fLstZbqxq3hvcqhuVuK7X/H8+nkyGC5+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(53546011)(2906002)(8676002)(31686004)(6486002)(4326008)(316002)(86362001)(36756003)(5660300002)(508600001)(38100700002)(31696002)(2616005)(66476007)(83380400001)(66556008)(186003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpyYW5KVzVQcFRTQWVWcHFLVVAyOHVvZS91VVB3eDIrdGtxQWVzZmI3clhi?=
 =?utf-8?B?SkxBOXIzbFVZRitmc3hhZHp5ZW4rekxrc1lPNkZURDRSek9LTEZ3cjJYdE55?=
 =?utf-8?B?VmtRbStEUjYxWjlrL01iMjMzTUpCOUF2Wmo1OEZmVkVVUHFOZmtzYTNKRGFU?=
 =?utf-8?B?Z3I5bUpVT0IwdWtkbzY3d0w4cWJiQ2sxWldtSXpmbXArUXFraEhJTHBhSXRK?=
 =?utf-8?B?QUp1VDhEWUNyTzJxQ0xDVW8yeUhTcnN3MmVOcFlSVFFBQU5WaWxhanhnNWEy?=
 =?utf-8?B?SlpFdis1WVJYNWVSdmlFZzB3azNmWXhBY0MwQzVHN08xQkdoMlNOand0eWd3?=
 =?utf-8?B?VUVkbjNPaGxKOU1hNjBIUjRmMzhPQzhZTWRaNnE3b243c1dTMUorVzd0TGxv?=
 =?utf-8?B?c3FtNnFrYUlkM2xQMTlvMnc5cjRIUmNRc2I2QXBGY0YwYTBvdlcvS3QyWXVt?=
 =?utf-8?B?QUxPQWlTb0x1VVNSL21ZRGlCRUNjcUhYNzJXbHlkSCtUMHJmY0dPMVhyREVW?=
 =?utf-8?B?cCtrbkN2d3ExMldHRHM1SEZrWmF4a1JuOEl6VEVrNjZaK2VJekZIY0ZmMDFR?=
 =?utf-8?B?NVZxOGNLUVd5S1hBaldpc1BSUXF3WnhJcUdzRW5RbDBXWmZLSFRuVng3cDdw?=
 =?utf-8?B?aXVySjVDWkZDSVBTR2FjT1F5Z2t1T1AyYVpVck8zZ0YxYzE2NGlmemM5Y1RN?=
 =?utf-8?B?dGR6Q2lUNm9lQ1pQeDU1dkpoMVMrSUlXQUplVE1QeW1qd3dvRC9vWXpsVXlt?=
 =?utf-8?B?R3BRSWlWczFveURDSG9EcEJMcG1hb2g3U1BhSHAvcVpBR3JvbWdmT3lINXgv?=
 =?utf-8?B?VjA0VnF0cWdQVGhsTE05MXdWWHBRLzVKMUpROGZ6akRQY1c0ckR4TTNRU1d0?=
 =?utf-8?B?MVVaem1MejZLdXJEelZHcVczTnlVYm1zZnJITXFsWE9pdG1Yb0RPVGQrOXMx?=
 =?utf-8?B?ck1RQlY1NUdIR0tjV1huQW9yUldRZzFKOExYQjcxMkNWa2NBZXJKYXYrS3Bi?=
 =?utf-8?B?SE55MXI1REdPSUN4cEZMNC9lbk1CMGhwZFRjRkQrREVNb2NKcDdDenJjamlM?=
 =?utf-8?B?eDB6WjdNNFlZOE0xMXF1bmZqazdWdmo4Yk5Nczk5SS9sbUdKWTBacmJGZ1Zu?=
 =?utf-8?B?NzVuaWF1eVorNDRlWTI3UXBnK3JQaTFzUXNsOE01Y1dZSHNDcVl6c2cwM0F4?=
 =?utf-8?B?YjFmc3l4Vm1xSlFaTkpwRnZVU1h2dS9NYnhBS1RVVDRsY0dCYkJSRXZSZGNy?=
 =?utf-8?B?Tm40Vk1oYllaSURhWkNxL0o5TEdXVG03bkhQcXAyM01FakllSkxvVTJSbE5m?=
 =?utf-8?B?eWMrb1htRDNMejU3Um0zNk1OTDczaHBnSWRJVEw5bFRaMis2c3JtM21zRzZG?=
 =?utf-8?B?SGZ5MnNhSUNPaWcyZFhTWVNtSHQrSUZFUGJmSG1JK2ZKKytQWStQOVhTNEJk?=
 =?utf-8?B?N3BBSitwU2x3ajM1TFJlMnZqaGlQMThKN1UyU0t6MFFLWXIraFFlTWhPNm5m?=
 =?utf-8?B?cTZzZnROa2lXRFpxRE5NUnRsaUdWQlc3dklsSUQyT2hWQkxJY3IyVVFEYTgv?=
 =?utf-8?B?bnZwWlczbjNlRnJobGJIU1lSOE1waXB3M1IxRkxjR0VHMjFXdTdNL3VtOUZU?=
 =?utf-8?B?a0xsVDVvZWtPY1hzL2l5K3dBMzQza29jaU8wUjlvNDJ1TVllSmtxRnlSM3Jn?=
 =?utf-8?B?TFJPTVV5eUhySnBRLzUrRStHUXBLMHFlSWF6SWQ0cDNvNTc2RGZNODUreElM?=
 =?utf-8?B?M0kvQXFqYWt3dlE0YzF2RHdzRU9KV0RUQXBwTmdOWUEvUGtTd3BCUzBaOS9X?=
 =?utf-8?B?RFhWQ1RqUEEwK0ZtcVdmb0pKTExlVGZiWlNra0tDcHpGVGptbnpRa1ZkV0tY?=
 =?utf-8?B?QTd2cjdjVVpCVWNlZ1ZheXRtZTdpQi9DOGFTdUNBWEFNaDAzZERIaUJNZHNR?=
 =?utf-8?B?U3l3UU1wVUJnQkcveDRZUTEvaEUxNVR3clVPVnR5VGJSOWVkWlNwb0s2TXE5?=
 =?utf-8?B?bFFFelcvN3locG9tMkgxRWYxTlY3T0tLbTcyWVhhbmhJZ3JYTVRpMlhOdkcz?=
 =?utf-8?B?Wms0ZjliS3U2RXRGcGtlbUFNZ2tIOWxtMGNVY05qUGxyU2puMC9SRCtJQi8r?=
 =?utf-8?B?eEMwM2pEdzl6cXVrVzdKbUhkeE9hN2NDZ25GSjAzNjBlWUVQU1oyYWFkUWVS?=
 =?utf-8?Q?CvNDlGv0INAVXEMXEEa8xOWNRPq5k7phF71v4LdSFQ3Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c5832d-ba8a-4476-7b63-08d99b2bca1e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 22:31:02.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaVIk3zI/QVH+6GJ2TsazmhkAGWfgSEuIgEfOUbvChxISCEg9s1j+HxQQb9uk6Qe48mVt9/Njp66Hm//DzJesA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2240
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: F7PYkP6Uw07zFSlL24pH4yTgj_fCJGwz
X-Proofpoint-ORIG-GUID: F7PYkP6Uw07zFSlL24pH4yTgj_fCJGwz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_06,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/29/21 3:04 PM, Yonghong Song wrote:

> On 10/29/21 10:01 AM, Joanne Koong wrote:
>> This patch has two changes:
>> 1) Adds a new function "test_success_cases" to test
>> successfully creating + adding + looking up a value
>> in a bloom filter map from the userspace side.
>>
>> 2) Use bpf_create_map instead of bpf_create_map_xattr in
>> the "test_fail_cases" to make the code look cleaner.
>>
>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
>
> LGTM with one minor comment below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
>> ---
>>   .../bpf/prog_tests/bloom_filter_map.c         | 53 ++++++++++++-------
>>   1 file changed, 33 insertions(+), 20 deletions(-)
>>
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c 
>> b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
>> index 9aa3fbed918b..dbc0035e43e5 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
>> @@ -7,44 +7,32 @@
>>     static void test_fail_cases(void)
>>   {
>> -    struct bpf_create_map_attr xattr = {
>> -        .name = "bloom_filter_map",
>> -        .map_type = BPF_MAP_TYPE_BLOOM_FILTER,
>> -        .max_entries = 100,
>> -        .value_size = 11,
>> -    };
>>       __u32 value;
>>       int fd, err;
>>         /* Invalid key size */
>> -    xattr.key_size = 4;
>> -    fd = bpf_create_map_xattr(&xattr);
>> +    fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 4, sizeof(value), 
>> 100, 0);
>>       if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid key 
>> size"))
>>           close(fd);
>> -    xattr.key_size = 0;
>>         /* Invalid value size */
>> -    xattr.value_size = 0;
>> -    fd = bpf_create_map_xattr(&xattr);
>> +    fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, 0, 100, 0);
>>       if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid 
>> value size 0"))
>>           close(fd);
>> -    xattr.value_size = 11;
>>         /* Invalid max entries size */
>> -    xattr.max_entries = 0;
>> -    fd = bpf_create_map_xattr(&xattr);
>> -    if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid max 
>> entries size"))
>> +    fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 
>> 0, 0);
>> +    if (!ASSERT_LT(fd, 0,
>> +               "bpf_create_map bloom filter invalid max entries size"))
>
> It is OK to have "bpf_create_map ..." in the same line as ASSERT_LT
> for better readability and consistent with other ASSERT_LT. It is over 
> 80 but less than 100 char's per line.
>
Great, I will send out v2 of this patchset where this line break is 
removed.
Thanks for reviewing the patchset!
>>           close(fd);
>> -    xattr.max_entries = 100;
>>         /* Bloom filter maps do not support BPF_F_NO_PREALLOC */
>> -    xattr.map_flags = BPF_F_NO_PREALLOC;
>> -    fd = bpf_create_map_xattr(&xattr);
>> +    fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 
>> 100,
>> +                BPF_F_NO_PREALLOC);
>>       if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid 
>> flags"))
>>           close(fd);
>> -    xattr.map_flags = 0;
>>   -    fd = bpf_create_map_xattr(&xattr);
>> +    fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 
>> 100, 0);
>>       if (!ASSERT_GE(fd, 0, "bpf_create_map bloom filter"))
>>           return;
>>   @@ -67,6 +55,30 @@ static void test_fail_cases(void)
>>       close(fd);
>>   }
> [...]
