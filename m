Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9A458D3D2
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 08:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbiHIGdw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 02:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbiHIGds (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 02:33:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950162019F;
        Mon,  8 Aug 2022 23:33:46 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278NSHVS009585;
        Mon, 8 Aug 2022 23:33:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=thCvk7XQkvuZj/EhZXx51lNiHa+su9/WN3zSOT5gr28=;
 b=BfYo9kr0gvFr7+kprJk3wloP1BME2v3RVMhe2ZpYbVTzG4gNhTAVTd2rN2AdSANHPk38
 tDocNVGatg50Jbkxt97YCDCjO7w9LkFs8r0/+7swHBIPbfH6G34wwD6LbafzZI98l7Yh
 0WgvGQ6K+WgMIqkFVsvbu2bVnfPbXYCnmUU= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hsnty7bkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 23:33:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA8PP9CSu+jWWPj8MOegKlSt6zLwFmp4IVXKNZPKYD9DzDOjUrR4EbnxIzm2OBMhgTCBIbdibEJMQMSgiSpx4GyakEiXzVX+A+yPN8i12XYWGjMjlbx4VAbacKkFlUft1Publa7MXjXXXDcv6cESFji2OrEoa8QXznr1auSjryVC3eKY3iePNHzMfz4xEW5mKrMCaNNHjYRvZJ+45lZB9c+fu2zxTM5ZlHOwhKdKusnyKuZsQAyi1Hx5Hw7Pg467QVFB9KLuLSNXwWiBQDyBNaywcmqEe5epF0drpd9qXxRRRJjtxsb2Z2vYl6arvlUA8AH/6q2y9VIuDytadMhU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thCvk7XQkvuZj/EhZXx51lNiHa+su9/WN3zSOT5gr28=;
 b=IbIFM1VPHS8nQuGAF6d+yoCNJVt/OJbj+QszceTR1KJ8ZBW4nKshlvtV+ptGxweLmxtjUyMi9FmAOuy1V2Wi8V9WxxxEhhhbeScnXm5jHblTdLUC+eS2aSB7AiczdtTvNy8wPhT7gcMfcQ06ypYr1uXSgQXCF3ONgKvQzMA0d2dwhr6XqralTMtVdPJtCtgxrO/YsHGg0wnCDqEVdCRh0LJw/oFh1Y1MhVunBSALV8/17UpPsecwgJ002yUgTG79SiMU4LUyzljEwwO8gqAdH9P+dVjJ2aprFHHW/nEl7KvgqafwHX6Q0+1+ImGB0hcvUyxmA25tPApFA6EvEnjv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4197.namprd15.prod.outlook.com (2603:10b6:510:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 06:33:29 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 06:33:28 +0000
Message-ID: <df64d9b9-6b00-379d-3a3d-98041c8789df@fb.com>
Date:   Mon, 8 Aug 2022 23:33:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH dwarves] dwarf_loader: encode char type as signed
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220807175309.4186342-1-yhs@fb.com>
 <CAEf4BzZJdqxOS_8VLX73z94GCUBVW4k6hKo3WGHyv4n-jQ-niQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZJdqxOS_8VLX73z94GCUBVW4k6hKo3WGHyv4n-jQ-niQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5743460a-c2ee-42bc-56bd-08da79d11228
X-MS-TrafficTypeDiagnostic: PH0PR15MB4197:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0jnngw1Q2K2KdRLINMsaQtCYAoSG4fwrxXsMQdQv/Ty/nD/BXYI3QSNoAOHdVcVQ7IHwn3VtEV7TfgnIgAQ2AYWAZ8YvIsFcvXJEdSFzJBjNOcEbQ9bJRCXLGuS/x5o81v/mLq9MbgyDkoQ9QQi1dlvZjIhFlHfG2pzTwFc5adeDm4TetnSBxDdQ6+fc7ojHiqzlpsWnjnZ3WkhiHm14zs9SB8ElO0yt0s3z41b5htgzt4BVyXdOZiD7LIzXiwSv07QP6stz/bss0Oe5ckutW3Bsz7FfTVNZ7+73D3n3+lSASxkzEWMNflYSrXTRw0DZEeirmJQMb5bNjY6xTd472evteQnD9mjuWvCo5WmRjp5h+XODyTcMs0u5JHYOQC7gGQ8DKBr5ROqnfrpA/m+hbVvnu4/THdHCPq4gYYgrixtqstFplw270FM2ksZEMyCgF9NUKOYZd6bmKg016Pa7VG4jNXUNWPDnqcAfgFEGanurcacgOJmkiZ2xQPP24BVftO7FuXbsymPl1BfhsxxhykkX9gPMC/OwUcdrLRguTa+dHXixrmCyV0M3ehQDWLkoRZjzxLvddV7PEbvcdulE9mPvn+Rixtl8QDF74pP33jDolCnYfftiLxnVnLLZz06HIFUg6ect+MInhVHcaWATlQke+dVHhOdPOIn9z7he71iP9elFexYIduXrpYBq0aMzcexjSZQ3O8enCVjvPokZeRhU/KKk30/gBtB1VO/Gyb6h92XMOMKCCOeOE3YqlJjKqNqgxMRq6yYXKCmqlO81ulFuGcu6b1LzSUGzyRI/5U3Fc3Qv2LJVaKpDSzM/2nXNLAUJLQyy0YA//jfA/LAFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(4326008)(66476007)(66556008)(66946007)(83380400001)(8676002)(6916009)(54906003)(41300700001)(316002)(31686004)(36756003)(6506007)(53546011)(6512007)(186003)(2616005)(2906002)(8936002)(5660300002)(478600001)(6486002)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1g5VkdkUW9rT2pyTkE5V3lib21kWnAzWWd6YWpjRmx1OEtrdzhHQUdtZU4w?=
 =?utf-8?B?cmorRXFxeUpza3RIdlRFNE9kbmJDaXJpTDZteFhEWnQ3NGk5MzNjSFFZc0px?=
 =?utf-8?B?eVg0ZjhRcTJvYlZIeDlST1IzV2R2cE1NMkxQV2s3K1RSck1wM29TanVhbXFD?=
 =?utf-8?B?RVVMS0d0WG5rM3llMzNUS0d6Qk5Edk4yNTRpRVI0Y01QaG1EQVEvSUppSllu?=
 =?utf-8?B?Q1V1WlBBNkluZmxZK25FbE41dGpHNGMzb2gwQ1hUWDdsZE4xL1VoOHFTYWh5?=
 =?utf-8?B?U1RiRjUwT2IxUk5GR2JJR1RZWG1QT2NWb2UyVWU5UFZnbGNUTlM5bFhTVDJi?=
 =?utf-8?B?c0xGcU1kR09hbFcrTTVaWGZTTi9BemFWN0h5M0IxaGNrb3E4Ny9HTkh4ejJl?=
 =?utf-8?B?RTh6NjBydm41VUNyTlNLaDBObjhVejhpVDNndEl6dHoyRkhtNitnb0hUbVVX?=
 =?utf-8?B?blB4VDQ4dmdNaU1WS1orWVQ5TVVoa2poSzliSkVSSHdLZllpVDQzZDlBbVY3?=
 =?utf-8?B?R0lnTlByakMvcTNCUUFHZEIzNG02bjY5bHBacTRxWWc5NVNsU25zVmpOVy8v?=
 =?utf-8?B?REFIeUFDQittTlBaTFo0cUFaM3FmSG0ydUN6NndZR3l4dGo5SUNobVhoOEZ0?=
 =?utf-8?B?OU1CMkVNdGJvc1FLUWx2bVpWdlNjeHhTNGM5bkVrV0hqRm13M0thMUxTMVBW?=
 =?utf-8?B?dmNwQjRkZW00citzRWM5MnlEc1dkdDNraUc4aTJpOERyc2plSmdNRG1tTjZG?=
 =?utf-8?B?dURFaVE4ZFVUSTVYSjU2ODNLa0RGWXYyRjNIYy91U3lGQnljVUN3OThZL0NQ?=
 =?utf-8?B?RzlBb0M2WmVKRFFUUXZnTHd6ZmIvTG94bEhRQ21TNlVOY0hhWDd6Qmx4d00v?=
 =?utf-8?B?UUc1aVh4V3JHKy92RHR1UWRLZUhQMUNNa3MwN1FzVWxRU2MwVzlpeVYrem81?=
 =?utf-8?B?UjFnRHdySFFKbUI2MjhOcW9PZlhTRTZoYUR3cjdzM3NPekM4UGx6eDJteUJS?=
 =?utf-8?B?ekI4Y1BWcnVDMWw5NUx6bTFsN1VGZFZZNmhSNWQ2UmM1MmwyZ2xrRy9QY2Fj?=
 =?utf-8?B?dHZhMHZjQ2hVcEt5WitBZVVoRXMwNFRwTUNnaFRVeHkzWlZaT091Unp4OWV1?=
 =?utf-8?B?WU05elkvaHVuQlRCWTdwN2hRb21CejNmelk1TzZEUnpqTlk0MDRGeHBERzhG?=
 =?utf-8?B?SXYzZDNWVU11ckxzUXkySHhLcEttOXVuWWJ6NUNmNlo2Y3o4dVZyODFTemk0?=
 =?utf-8?B?a004Nnl6UjFrVE1NeS9JWXdlcVNrWkhrVGg3ZDRvT1lzejdaK3dIWFpYK3BY?=
 =?utf-8?B?SlZqMFlrb3F5TGQvblVNL0RYNG8ySWNCdDZ6bkhBMlROMjVEQ1psR0ZiSmJR?=
 =?utf-8?B?NkU4V1VTdnhMRWZndGVuL2Y0WTd1VjhONU8valk0cHhsanYyLzRmeVhXa2RR?=
 =?utf-8?B?WStaOTk0Sjk1R05GUXVDR3l2dEJSNnJZYkE3UEU2VlhOU1hJWjF1TjZFVDFm?=
 =?utf-8?B?RHI1ZFVvRnJFQjhlR3MyRWVkemlKc2RHTU44VFh6NmxSRk9oVHBTa2QrNTg1?=
 =?utf-8?B?bnlCR0dOcGVtdnIzRU9YMnF1NjNvdW9tUlVaYjh2ZXRPc0JLMFlySi84ODNT?=
 =?utf-8?B?dlFUKzhZODQremFmZDJ0MklNRnRhclFubHpncmRQVzhodlZwbGo2b3R3SHUw?=
 =?utf-8?B?NjFKZE9EalBqV1JlclpRTm9jZVRBWExROG13MmxxQlZob09NUlF5YisrTU5n?=
 =?utf-8?B?TmJkV2V4eUZ1b3RsL3lkMXZxNHVTSTN6WGFwalYrZFhDWUJFcEhEU3pHTFlJ?=
 =?utf-8?B?VHBlS2dQSVJYQ3ZRK0hlQTg3SWx1ZWlnUDdNb3lDTkFma2pwV2wwb1NTcG1v?=
 =?utf-8?B?WW9id3pUVVRXbkxkd3FtQlFVK1IrdmU4VzNMN2JOMEMzQ005Y1NWNDVvVEVu?=
 =?utf-8?B?emxnK29uWEVlMkw2cnRmOThIYkZCc2oxUW9McTRrMVprRGh4TGd4VXIxMmhq?=
 =?utf-8?B?Q0xmNG9xVHVaZlFXZ2d3Tjg5QjFVZFV5NGRhWHl2Vm00ZlF1ZFAxdkZrK0tB?=
 =?utf-8?B?eGNpUjlBZWU2WUwxVXhDN0lTMFdhTW9yb3hGdU1Fck0zWDRlTndac0w5U0lw?=
 =?utf-8?B?TFJQZFJwdGdNd0dRcmVvb2psRlR5Y0dOSzc3MS82YTJZamRNQk5FaEpidk81?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5743460a-c2ee-42bc-56bd-08da79d11228
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 06:33:28.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IwrZhts/DjWvERoym8+ZvwxtWLGQzC7Tb3noP+HSCDcWCXdrKWvD5BfhivXCp2V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4197
X-Proofpoint-GUID: 2xybe6sW8MIIK_VmMjJePwWPgKWY7asw
X-Proofpoint-ORIG-GUID: 2xybe6sW8MIIK_VmMjJePwWPgKWY7asw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_01,2022-06-22_01
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



On 8/8/22 3:52 PM, Andrii Nakryiko wrote:
> On Sun, Aug 7, 2022 at 10:53 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Currently, the pahole treats 'char' or 'signed char' type
>> as unsigned in BTF generation. The following is an example,
>>    $ cat t.c
>>    signed char a;
>>    char b;
>>    $ clang -O2 -g -c t.c
>>    $ pahole -JV t.o
>>    ...
>>    [1] INT signed char size=1 nr_bits=8 encoding=(none)
>>    [2] INT char size=1 nr_bits=8 encoding=(none)
>> In the above encoding '(none)' implies unsigned type.
>>
>> But if the same program is compiled with bpf target,
>>    $ clang -target bpf -O2 -g -c t.c
>>    $ bpftool btf dump file t.o
>>    [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>>    [2] VAR 'a' type_id=1, linkage=global
>>    [3] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>>    [4] VAR 'b' type_id=3, linkage=global
>>    [5] DATASEC '.bss' size=0 vlen=2
>>            type_id=2 offset=0 size=1 (VAR 'a')
>>            type_id=4 offset=0 size=1 (VAR 'b')
>> the 'char' and 'signed char' are encoded as SIGNED integers.
>>
>> Encode 'char' and 'signed char' as SIGNED should be a right to
>> do and it will be consistent with bpf implementation.
>>
>> With this patch,
>>    $ pahole -JV t.o
>>    ...
>>    [1] INT signed char size=1 nr_bits=8 encoding=SIGNED
>>    [2] INT char size=1 nr_bits=8 encoding=SIGNED
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> LGTM.
> 
> Is there a plan to also add CHAR encoding bit?

Not yet... Need more thinking about use cases and backward comparability 
issues.

> 
> 
>>   dwarf_loader.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index d892bc3..c2ad2a0 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -560,7 +560,7 @@ static struct base_type *base_type__new(Dwarf_Die *die, struct cu *cu, struct co
>>                  bt->bit_size = attr_numeric(die, DW_AT_byte_size) * 8;
>>                  uint64_t encoding = attr_numeric(die, DW_AT_encoding);
>>                  bt->is_bool = encoding == DW_ATE_boolean;
>> -               bt->is_signed = encoding == DW_ATE_signed;
>> +               bt->is_signed = (encoding == DW_ATE_signed) || (encoding == DW_ATE_signed_char);
>>                  bt->is_varargs = false;
>>                  bt->name_has_encoding = true;
>>                  bt->float_type = encoding_to_float_type(encoding);
>> --
>> 2.30.2
>>
