Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03705B0C1E
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiIGSFi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 14:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIGSFQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 14:05:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C4ACE1B
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 11:05:12 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287Hnc2I011714;
        Wed, 7 Sep 2022 11:04:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dS3VnG0MpJ9pKU33G7Rw8dbIUYaU80levDNSCgcG9W4=;
 b=lWXhTS7ci5folGRdJLPDBPxnCMfrKOQfOCqbPgVHVyDbzPGNexLAsqmtDKXZzWo6JnEx
 wQp6e18dBcAYf+ze05eNyO5ae3cGApCit15gUxCuwvrtaOStpaUn8d0a5Gde9gyeSzhA
 gowZuV8sYxcBjN8ibSivKnBA6CsavrWCXPM= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3je0d13q0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 11:04:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OljcJbsa7ZxfSqGZ89vjI7B4OyKn4r34yJmf9nWpRj0qx/AZl0em4TD0LDRyyzuH6lngyaznSBuKcFEG8MjAKx1BuZbF97+uZNhAiOme74zeKfP18aTOFqF6iOZDjwfiCLMwzmn2C2yFY/YVyMA2DHo3u7A2ydFS2TnX8sWxCrt8ToZXoSOKX7pyp28yeUassNMEP5fQpPmpnF5JGzAfN7r/Rffn7wvhq91Ws95Eoc1YQWapalqlRU66N0D+Jhnk2rgNt6SLQiSRKdfK9fM94meJjhRBerkzqAOkp+rIdZGYbvcLTzZn/e20Aae8a3xvzHbbTLjMusop7bd+FlhwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wnV5kG+1s9cjHmfS+4XXLF05VnaqSrnu0l1JWix39I=;
 b=DZ0wUBykSomifnTYgzicRr8g7rVLr2OPwzY9qRzOzb/66IW0wJ3hzl1Ul1XntSrA0puN4FBqbqLSpenay6ylWvfH28REQlIlIo8IhESQ6WWX6TOklgEZ3ADkY7nFl4JEUNJiLepNMqWU9dQil7g3S540E6/KaOLf2htzd4CZMvCqDKoudfwVY1OXzw7dR7k7AqivSxAOFOjdTHQnsJP4FjG5L18y+zP6HMdBziOZGtdlT3NafH3gijzew1vmZioR4ENVUjUpSi+naMPUMPgSy4YtsINYwLxz0JHFqDLRFWbYMwsp7mViznntmEGcYAcYR5tXKbUaumaKp5qixEeTxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1851.namprd15.prod.outlook.com (2603:10b6:4:58::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 18:04:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 18:04:53 +0000
Message-ID: <d9f6ddaa-1180-a635-1179-7381671b8d7a@fb.com>
Date:   Wed, 7 Sep 2022 11:04:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v4 2/8] bpf: x86: Support in-register struct
 arguments in trampoline programs
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220831152641.2077476-1-yhs@fb.com>
 <20220831152652.2078600-1-yhs@fb.com>
 <CAADnVQKb4Js-57c69Ryfdf3Tu3=Ray_Ovqjm7_2ZHw1LX3qgxg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQKb4Js-57c69Ryfdf3Tu3=Ray_Ovqjm7_2ZHw1LX3qgxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR15MB1851:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0b1bf3-3ee1-4ea9-ff57-08da90fb76f0
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3rmJD1nEbsdctyXa04x0XxphJcKEvnFuRUklaHEXOz5FycVNdWMKEENl4eiwFhhl7Mso/Ov+nYm4zgmn4GV6ys6RtwTotlcaZ+ZCRjRJ2Qbp6dMRN3lFGdCLdEq03fSysntLV7Y8aN1RvzQMOeEjJZV+KTiVHSZP+aFv2S4CGpTLkW9ZpA5fl2RVkFBmtCEcFDwQp+/vqyFY0cucNJZ6m3c62eKvTFkNGke1LuDL5t/Qbt2WZHYq/bgcfs7WR4BRQFlz14pe03a0TokJ/62I7RIwLbPNRCOZUHOh8oxXApjhVMLlZGI7wHCrW/zKZxS/d2jw9PYtYdPnnqaMuPYURXdBsydwnSdmZ6q0WMNxCQX0gYMF8+JB8NNeS0XKiICHLW6oAYsxuvlszLIMpv+qLQWW7Ewz2Kn5E4lR78nax52oMSdu0cBXpi8/9pugZ4bnDyTVzOzS1Ewwa80JiUSjLOZzoL31rHjEcs2lsR0eOF91mQJma/s5e/39JEXp1qC4/AtsdxhXRSpIqIee2iWHteoxffebfohr9GwtT5C+DwNg9/UmEX+He1h4ab63FG2+8X5UREyibW9oTgQksDMFBccdtDYOd/nWT0Vo7UTVFZKOy8KT4SMWSIf4qS2wA81RBkw4saB1zmImVRBT2+dt15eh23bjteSEXFotY2qMw9ujm3oHLkfemGAK02ddq9DoXNzp/NcSBNGJzLd9YoRNL3pArfpe6VklclfL2nzmq8pRUKOHwjOMZ+qHP9R2L8dHqNTaOru2tCscvX9cyikq4m8lBe6tJI1nGcrooC/NBcvo7N2QMyxG22memcjRgFvqBS3nKvWwLmdpYVDIuNfOvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(31686004)(36756003)(86362001)(316002)(54906003)(31696002)(2906002)(38100700002)(5660300002)(8936002)(66476007)(6916009)(4326008)(53546011)(83380400001)(8676002)(66946007)(6512007)(6486002)(966005)(2616005)(186003)(478600001)(6506007)(66556008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG5PRmRkTng0UmRHNGI2dy9aQjJYWEZyV3FZQytXUGZZTURSci9EL2F1MGdl?=
 =?utf-8?B?RTQ0S1h0NVBSN0Z3RUJ3UWkzMXkxc1FpVHQza0tLZkxQZmsxWkhpZXRzbnE5?=
 =?utf-8?B?ejNUL3VhZ0tTd2FxTXF3MjlBeExscE5ZdzBRWEtWc1lRcDBIRE1abUQ4Y1pD?=
 =?utf-8?B?QXpHZmFRRU5XYit2S1FWWEh5TVBaQXN1am5paUJ1Y1VCL253Ynp3NEVsZ1FV?=
 =?utf-8?B?TkhvY29XWkZISnhlOVRvYWxNSVl6STFTUmFDeGRINlRDYU1CYS81Q0g2Q1Zs?=
 =?utf-8?B?MHhnTjZiT1RtWGhuRHB2TzNjQnVsS3ppN216T2tuRjNQeHVHTGZiclBURzZo?=
 =?utf-8?B?LzVlTENSYzd3N1JhOHlKc1NWY2V3RHpqU25EOXJ6WjFDN3dOZkEvbHVNa2xD?=
 =?utf-8?B?UVplWnJqSWpYUUZCUjVSb0dpdlpXbk1kRE5KOEZLRllacTVPWjMxb3VZMC8w?=
 =?utf-8?B?QWppZmMwWldzakJ3STB5U2R5dGpHWSs2eTBCLzFKVWVqMzJnRWF3d05BWVQr?=
 =?utf-8?B?YmtNN2p5aCtQMlZzMEtwWWFsaWtJQ25wajJZSlQvRWNxekR3UW1TK3JrQ3Y1?=
 =?utf-8?B?YnFUclZlTDY0eFE1cVhoWGxvVXZpdkNiM2pySEhNLzhDZmcyU2ZGWnNxcFJ0?=
 =?utf-8?B?UGJoUFdScjBTRlErc2RnbHd5dXRXdGJpdG5oS1RYbEZYaFJDODlOY3NRalNR?=
 =?utf-8?B?aU9uVlQ5cHFHR2tTZkFGMUU2NmpYaTF4TTI0QVpVZTVBMEZGTVQ0Z1grOVFY?=
 =?utf-8?B?YzZyL2RzR0lpblp3KzhxNS9RcnlEekNhWGdqR3N5SUxtNE4vbmNQN1RlM1Nu?=
 =?utf-8?B?QzhOQTd4UWlNdm4yUDJGaVJrMTV3MnoyczMxSHRLTFBsSFo3QXVkVmo5SHlk?=
 =?utf-8?B?ZXdhUjNlZDBjTHlOcWJwS0RqSjhLRVdSc2hiSjNuclk4bnhyQTZWUFNFY0hi?=
 =?utf-8?B?UXZuMmtya29MS3Q2VW1zYTZTVlJBUVRGSGoyRG5sOEJ3SGNvdXZrM0t1TE5p?=
 =?utf-8?B?N1VyUDhsQ0J0U0RVRExpa2FVVkpFQy92OWZUT1JWeGlSeDQyTWRaeG94YWE1?=
 =?utf-8?B?bmxDS1NtaFVwVloyemhJd3A4OVlLRC9pSXFpMnlBMXA4aFBLVFVrN2xzbENO?=
 =?utf-8?B?b1dWb0Y3WWp2V09HVVdhOTNSNU12U0tjMUMwQUhlQUpLRVpaKzRWb0tyK2J6?=
 =?utf-8?B?TVJQbGEzUVN4Tm9UK2YxV1U0V1VZMDRISjYxcFZ6bUxMK1FpU05BS2dKN2tw?=
 =?utf-8?B?dC9NMzZoOThhRDU0M1JPUjF4Ukl2TjFvaHNyb2sxNGR3dXRnSlBWVHgwWGpp?=
 =?utf-8?B?OTErejlrNCtmd0hYSnlvbWMyNitIZWl3TzFxdmM1bWhRNXkzU1RRNEMxZXBZ?=
 =?utf-8?B?VmdhdGllc3VXeUZEaFR2QUMxTzk3aVBuclRlYm5Hd25GUFA1SUhvb1A0Q01x?=
 =?utf-8?B?Q0UwWlNZUmVIbVZld1pvY0g2L2ZHb2crdE5EQllQQWJNajExVFdkYXVKOTVP?=
 =?utf-8?B?Z0tDQ3hDMTdQSVRaWmtiQ2NJakhLMm1ycWJYdEZ4YlF5d2YvN2ZEaSt0VXhP?=
 =?utf-8?B?bVpVNmlPZGlGQ1VMVXV0NzdsUTdrMGM4bDFMckk4RTJyaHZRZ05SV0doL1JR?=
 =?utf-8?B?L0hFNy9iVDNSdE8wRnk5eldJb21pQnR2T2g2MFREZWZNR1VyM2JtWVYrTnZl?=
 =?utf-8?B?NEQ5bnl3bUU4TVAySmViRHMvQUdnNTF4aC8yVjVRbW1aODJJU09OdGhMM0Rt?=
 =?utf-8?B?MUU4ZEpCNHVNb3ljRGtaWnpuUjlialBxTjNDMVQrNSs4TXU3VzNEcngyR2Nq?=
 =?utf-8?B?TnNWRnhvQWJPaHgxS2QyMFk0d0ZkZG42QTZjNWxwaFpQNnM3eXdXMFhBNWlj?=
 =?utf-8?B?ODhrY0lQeDd4djdsbHl0ZDR1Sk93b0h1a3NPTGp5QmNHcjN1QllPZ0cyMnF4?=
 =?utf-8?B?RkRIVWkzZCtocVpoM09VNHNwK1ptK2JSNGVqQW1KQjNTamlLSmhlL1hLUjk0?=
 =?utf-8?B?dHBEZ2dZNjNxNm1iTUVvVUo5NWx2M1FOU0NWYW1QOC80NkxvZmlXOFJjcXVP?=
 =?utf-8?B?eXNUQ3RUWHA5U2taN3QxdUxBcktIMitOUERBbEpVaGgrR243aUpwZXQ4bnAv?=
 =?utf-8?B?NEFCVEJpS0FhQUdZVnI2TWg3UDRzZVpqeW1IQmVtY0FqVUxIMGFudXNnQ0xD?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0b1bf3-3ee1-4ea9-ff57-08da90fb76f0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:04:53.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCTYo8WQr3viBPIQCtpxGCcN6Zn7MhnQTa4iwqrW89pWQUBF+TjIhN7hPnDbTIbu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1851
X-Proofpoint-GUID: EtPgD7137OtmnF3YxuKEmeDK-fwDeSDu
X-Proofpoint-ORIG-GUID: EtPgD7137OtmnF3YxuKEmeDK-fwDeSDu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/6/22 8:00 PM, Alexei Starovoitov wrote:
> On Wed, Aug 31, 2022 at 8:26 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> In C, struct value can be passed as a function argument.
>> For small structs, struct value may be passed in
>> one or more registers. For trampoline based bpf programs,
>> this would cause complication since one-to-one mapping between
>> function argument and arch argument register is not valid
>> any more.
>>
>> The latest llvm16 added bpf support to pass by values
>> for struct up to 16 bytes ([1]). This is also true for
>> x86_64 architecture where two registers will hold
>> the struct value if the struct size is >8 and <= 16.
>> This may not be true if one of struct member is 'double'
>> type but in current linux source code we don't have
>> such instance yet, so we assume all >8 && <= 16 struct
>> holds two general purpose argument registers.
>>
>> Also change on-stack nr_args value to the number
>> of registers holding the arguments. This will
>> permit bpf_get_func_arg() helper to get all
>> argument values.
>>
>>   [1] https://reviews.llvm.org/D132144
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 68 +++++++++++++++++++++++++++----------
>>   1 file changed, 51 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index c1f6c1c51d99..ae89f4143eb4 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1751,34 +1751,60 @@ st:                     if (is_imm8(insn->off))
>>   static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
>>                        int stack_size)
>>   {
>> -       int i;
>> +       int i, j, arg_size, nr_regs;
>>          /* Store function arguments to stack.
>>           * For a function that accepts two pointers the sequence will be:
>>           * mov QWORD PTR [rbp-0x10],rdi
>>           * mov QWORD PTR [rbp-0x8],rsi
>>           */
>> -       for (i = 0; i < min(nr_args, 6); i++)
>> -               emit_stx(prog, bytes_to_bpf_size(m->arg_size[i]),
>> -                        BPF_REG_FP,
>> -                        i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
>> -                        -(stack_size - i * 8));
>> +       for (i = 0, j = 0; i < min(nr_args, 6); i++) {
>> +               if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
>> +                       nr_regs = (m->arg_size[i] + 7) / 8;
>> +                       arg_size = 8;
>> +               } else {
>> +                       nr_regs = 1;
>> +                       arg_size = m->arg_size[i];
>> +               }
> 
> This bit begs for a common helper, but I'm not sure
> whether it will look better, so applied as-is.
> 
> BPF_PROG2 also feels unusual as an API macro name.
> We probably should bikeshed a bit and follow up
> if a better name is found.

I didn't come up with a better name either. But happy
to change to a different name if we agreed on one.
