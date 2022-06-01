Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9453AE1E
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 22:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiFAUml (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiFAUmk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 16:42:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B291A35AF
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 13:24:16 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251BReUb028025;
        Wed, 1 Jun 2022 12:14:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4sZVyPrWs6Alu/GMYS+BSWHU+vc9FyBxVa6j1SmJ4AI=;
 b=Mo+JOnJ6NrEoqqPubvGAUsmi6bXQEeNrWTTNRIpLF4CL9iArE5XyfmUYAoCbdKv8dPv/
 PcI+uU4TLLPXJpgDFd+QuwG8tEkr0luisVwNwmmjcu7/HZuSy29GFaZXyLdxESVLqKHZ
 ohEnsdyLniinR5gaTtBSGzvU7KBIB07OWvg= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gdj4t2dpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 12:14:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCAv+nIyJ+tSjt6OpRzvxoxjSuQ6y5S7P41nZsX6t6pURcgHKxU+r2VSjR67J4GtSdTYSqRXZi3alLFkt+opQXBEu8nkWjzVmfSXxQbz0NnQbjBGJbJ+/TRkzQFDzB5E2nmllPIgsmLUo6SCCE+tUxxnggq1SZk+rzN3ti7Cw/M3nkNPF/0K0Vs8NZUFR5iShpAV8sRVlrIDkHMVDXlA2Cki10Sg8tRRbO+M3PiHcnjA2Rgl2NTLmztxsJInI0wF1TxKD3IR35MMs15xiMFsGZ9Ymz/93WKTnoq0Xq6qR4kH70wZmpdwtXO+qZjC/4YbRpBiVG/onM/FpaI+JZbAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sZVyPrWs6Alu/GMYS+BSWHU+vc9FyBxVa6j1SmJ4AI=;
 b=ZXV8MuaPYyflDyJMQg//neR/X+7vH88pXel06V8BoaoXPqXYeUduKMTUfyXBvcVS+NyyjGgw8EqwdhFHsZIzb2F0nvMiXntN/xniKGG/qaiD0P5PZhs0eirzaP8a9zGxs9ICCOxT7FgeSik5cZbFjnpmsz02gIqX7DBlI2sKdeJ8JtmLJ2AJw/swEkGiz5m/IxbQiQ+YAYvMT6Wucguq8zsGX7iyCUVv8DbCz1R2RwlRjiKlKfeWZwN/dQfU9IUls3lrha6atUGlE3yH6Wfv2nAsGKgKzCCLPuchtDN5ycdAo/0OrXxNv6p1RNRON9yjmLjCHP9L3jh27NlKtAGBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4185.namprd15.prod.outlook.com (2603:10b6:a03:2ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 19:14:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2%7]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 19:14:44 +0000
Message-ID: <442f83af-70dd-da94-5cd6-5098c173cd35@fb.com>
Date:   Wed, 1 Jun 2022 12:14:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH bpf-next v3 10/18] libbpf: Add enum64 relocation support
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220526185432.2545879-1-yhs@fb.com>
 <20220526185524.2550356-1-yhs@fb.com>
 <CAEf4BzYp=9pntdwgc40RF5-1RhwgJqPyQ8B7svaX_TzfO+joag@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzYp=9pntdwgc40RF5-1RhwgJqPyQ8B7svaX_TzfO+joag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 576c9eee-918e-492c-b546-08da4402fc70
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4185:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4185A90A2CCC77900D6410A0D3DF9@SJ0PR15MB4185.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9w/x6L1z+xiPIna142bUs2o3MC3XwCdolLc6je+HfGGdMd9YHbviZ4TTKWN+pGC/dUSt1Tvx6/z69iraeAjZUPpVVlsitWhk+IEWSB9eU3BUfvcam2bUqlo+HyDI47J2UGgq9iC9acGkbseOwd0gn13XMvr73DmsNGWRTihn1K3MdJDORzm/xlQ6Q7WmC8KXHQFLk5yx+z2ucQx19UQRQ+0JuCd+sAd/eKhMAmWKNMCaSR8NqgoqcLkSO5/T/au16OTPf1dDDlB6IMaoB0oLnUtzFTTxBujx+AnUmqASU8BI/WIeZv1QltSlBeYZ2+Usft4JNoz2KezMZ47GuTTUFuzcv2eOY9dXmQrvR6dXbv9fNGaT+HBPcAuFAMNSCOnWrq8QX7UBpFP6ZAlPmDggVlB9IzrZLR0EJbszwHerp6L/mDOquaac/qndp+2N7mU6jWtDsQ3For2/uXlYw7sz5fXw7SP//bemkvCVXt/xHbbBNsUftAT0wahNkdijaYms23JIEPRfcmKlcx0xa21PqQ5bMfyHiYE6nTwn8SkCuGJc8Az7BYWbNr4+xOQLp1YcI95EsW5d/67sECw71HrW7zDbdBX+6lGgTv4SJ8WKexuQMWJ8BnF6ACsZ5J4cFBzU/GDJfI934rGxEPNXdOx9WS83me758sFGfZfpJczKRvU6S0CxD5HSbk20PNDc3iXWrgH8GobbZiSi06SoUM/4O7CafnvVP979FDtiPK486j8mQaGVKHCO6hh+WkNkMKi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(508600001)(4326008)(54906003)(8676002)(86362001)(6486002)(316002)(6506007)(2616005)(186003)(83380400001)(2906002)(53546011)(31696002)(66946007)(66476007)(66556008)(36756003)(5660300002)(52116002)(6916009)(8936002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlloenI4cWVRZklTS0FtQ2Y0TjZqTEcvUSt3NFhuM25NUXJBY2FrSzRpdEZm?=
 =?utf-8?B?bDZyYXAxcmFIUUZWd09KNHJzSllwT2JYZS8zYUJIK0d2bURZMmsxYjgxdWZy?=
 =?utf-8?B?L3NUM2JBdVhPOStidTR2c3VnWW1scExYaU90d1dEV0NTYXVydVBvVFhQMFow?=
 =?utf-8?B?UThkSUlyVi8rSTcyYXZUQlJWbnY2M0ZZdEVZelhMb3RrUi82K0FFUm1jSW9v?=
 =?utf-8?B?a1ZYYk43OC9ZcVg5Um1UbVNrckkxQ3BENC9nUmpKcXpZTjBEOFAvZm1ZSmNt?=
 =?utf-8?B?NEVIRzhpL01qZDlTdVg0YXhYVEJ4cndQb3BDM1U2bFJJWXJiZDUwVGtxcDZI?=
 =?utf-8?B?Z0ZPTEx2YU90Y0RGVUM1dSs5V2dENWJSRmZUdVhyOXZTeXRWRmwvbmp4Z3Zt?=
 =?utf-8?B?VTkxQ2FCN0U0MTBMVGpUb1hGOGo5UzB2cENGVHYxSGlKODFIY1V6SHNqa0FI?=
 =?utf-8?B?MGdhbnFSNktjbDAzR2JtczV2ckNLNEJNc1NNTjg4YVdKbWliZENoOGZyL3d0?=
 =?utf-8?B?TitDTlZFRFI1djdMTkd4N0hueWw2UDdGM3hlZWY4SGsxZzhUK3lpYjNUYitM?=
 =?utf-8?B?NkFmdTAzVk9SWUkyY3FzR3ZESSt2elBWUzRZTmQ4ZkROb0xWWjdFSUVHTitE?=
 =?utf-8?B?dE01STdwSHdQMmRTcjJTa2FmWWNOR0JEQUNlUkNsOGJ4QmlhUW82emxEaks4?=
 =?utf-8?B?SGI1czZ2cmJYeGNKWUpURUIzWXpUV1lPcmVGNFVlRlp5VnVYYVNyUEFHU0pT?=
 =?utf-8?B?RFhEYUNsK0R4RE4wZm5MRUwvckpPTUpRRVF3YlpnalZNSldoUUF5YmZoYkRV?=
 =?utf-8?B?Wk90dVJDeHVYWjIvenVUd2hwSko5dDJwU2FPUVlMT3ZJYnZSUjl6dURtakhz?=
 =?utf-8?B?SGwzSmRJKzZiMWwwY2U3cEE4T3RsSEdRK3J4RWE3WnlCNjRDb3VPTlQwVGJw?=
 =?utf-8?B?VXhzWG9sbmFaYjB3cUVIUGZseStHR2o0VHA5QXMwdVNsQ0hjekZUT1ZGM3RM?=
 =?utf-8?B?QW5KOEIrWlArOUoxekVJa2pGZVVLZXpmQ3pmeitSbzk1eFVPdXAvV0ZuMlht?=
 =?utf-8?B?QXNFZ3JuZnQ5NzhjUlE5VC9UWkp6MFBCS1NtemlSY1ZwNUVPVk9tb0hFanhm?=
 =?utf-8?B?ZTBlanFXc1lFVlM5SmJFS0hwUENsdHVzanZCZ2hubjZZcnpEc0NQRG01ckwy?=
 =?utf-8?B?cGlYZUovbmt1VDUyMTl1V044bHBGM0ZWY1ZCbmkzak5YMjRxenpWcUVienF2?=
 =?utf-8?B?Q213TnlqQkVaeXZWT1M4UnQ5MWM0d2dGZjRlcEhBamJWemdPcEc4Z2UwYmFD?=
 =?utf-8?B?ekl4dmFvbGtKcmxJc0xnalBqZjE2L3BpMHFZWHFZYXZiWE5ZUEhHdnBWR1NW?=
 =?utf-8?B?OTNrSUhlUG5WOE9ib20wRFBTRWNyTVczdWEra05jQm1vaXd5dlVUeGkxL1cy?=
 =?utf-8?B?dStmZUF0Z1FhdU94dWJTaTEyaEtIaHJJWkNXSkJrbllSTmIzekFCTXZjb3Vs?=
 =?utf-8?B?ZFdyUUV4RzBWVVpya256dXllWmw4b29HYzB5MTdZSDFGQ2tOeFNPVW4xTFh1?=
 =?utf-8?B?SFllZk9GZjY0cGZFQUZLTmU2L0hWOHJiRHY2WVZ1cXVxSkRkemlQV0pYbWwx?=
 =?utf-8?B?YUl6SzVDMDZ1TXN4QWFZRklEWThIN1lScGF4Y0Z6UHFQaG9zWDhtSW4rdlhS?=
 =?utf-8?B?dmYxd0NVdXl4RjVlTVRibjdYRGw5SElyRStPaE4vSzl0bGxTR0M3dFlJOVk3?=
 =?utf-8?B?Ymp5YVVHUEpKVjZXTXppejQ4cG1nYWE3Z28rT3R3bTl6aWpmZ1c3M1d4azZ0?=
 =?utf-8?B?cjVWYU1ENjF6TjBiTkIxWWMvMGtxdmRKcjBIYnFHcVo4d095MWNXWitrVFJO?=
 =?utf-8?B?QWFBRDBwRHloNVpodkhwcWFVVWZmQnoxdERhMzR6am8xRUVtQXhEb0t0N244?=
 =?utf-8?B?d3V2MGlNNnZackRYRHFSckJ3TlZURnhFbGdVWm5PU3RqWUFVbE56ZWFoZy9J?=
 =?utf-8?B?c0owNnNoSVRiK05WRmhBV3pJdk94WUQ4aDlTcFh2dUVvZ1F5dnp0MktJRVkw?=
 =?utf-8?B?S1JKUHdSUUdsWXVNNzBEZXlSYXlGV0JoZU0rS3N1SHVsS0R1ZmFReXJDRFE4?=
 =?utf-8?B?d0JWdXo2Mlljb0IrRFRXakhKWFJrV0tYS2wrTjZNU2JpL1lDejZqZXNCSHQv?=
 =?utf-8?B?TTU5ayt4dEtaNkRwT09lMFliYm9LK0JJSUY5RXg4akRHVnNqcGVWSkZCR1h2?=
 =?utf-8?B?TDcyaWNUOXNyTHdZN2l2MEpJczdTaWhMbWN3a3pIcFd6YmtjbEhUU1ZpWDNY?=
 =?utf-8?B?bDQvQVd3aWpWRHJxZEd3SDZqbjVEOGRXZ3QzczgwaGMyelQ5MDl3WERYUVdR?=
 =?utf-8?Q?2PQK9RMd6CakRDWg=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576c9eee-918e-492c-b546-08da4402fc70
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 19:14:44.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXlxY/ZPO3ufdJ4AURQ0LATZKXVo2InPcliRm3HCWQL4Ztq17tm2DBM3oojLe9lB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4185
X-Proofpoint-GUID: g1CLVTL15bHXv4X55gor7xNaaLSpdMXj
X-Proofpoint-ORIG-GUID: g1CLVTL15bHXv4X55gor7xNaaLSpdMXj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_07,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/31/22 5:07 PM, Andrii Nakryiko wrote:
> On Thu, May 26, 2022 at 11:55 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> The enum64 relocation support is added. The bpf local type
>> could be either enum or enum64 and the remote type could be
>> either enum or enum64 too. The all combinations of local enum/enum64
>> and remote enum/enum64 are supported.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/btf.h       |  7 +++++
>>   tools/lib/bpf/libbpf.c    |  7 ++---
>>   tools/lib/bpf/relo_core.c | 54 +++++++++++++++++++++++++++------------
>>   3 files changed, 48 insertions(+), 20 deletions(-)
>>
> 
> [...]
> 
>>                  local_essent_len = bpf_core_essential_name_len(local_acc->name);
>>
>> -               for (i = 0, e = btf_enum(targ_type); i < btf_vlen(targ_type); i++, e++) {
>> -                       targ_name = btf__name_by_offset(targ_spec->btf, e->name_off);
>> +               for (i = 0; i < btf_vlen(targ_type); i++) {
>> +                       if (btf_is_enum(targ_type))
>> +                               name_off = btf_enum(targ_type)[i].name_off;
>> +                       else
>> +                               name_off = btf_enum64(targ_type)[i].name_off;
>> +
>> +                       targ_name = btf__name_by_offset(targ_spec->btf, name_off);
>>                          targ_essent_len = bpf_core_essential_name_len(targ_name);
>>                          if (targ_essent_len != local_essent_len)
>>                                  continue;
>> @@ -680,8 +688,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
>>                  *val = byte_sz;
>>                  break;
>>          case BPF_CORE_FIELD_SIGNED:
>> -               /* enums will be assumed unsigned */
>> -               *val = btf_is_enum(mt) ||
>> +               *val = btf_type_is_any_enum(mt) ||
> 
> wouldn't this be more correct with kflag meaning "signed":
> 
> (btf_type_is_any_enum(mt) && btf_kflag(mt)) ||

Will fix.

> 
> ?
> 
>>                         (btf_int_encoding(mt) & BTF_INT_SIGNED);
>>                  if (validate)
>>                          *validate = true; /* signedness is never ambiguous */
>> @@ -754,7 +761,6 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>>                                        __u64 *val)
>>   {
>>          const struct btf_type *t;
>> -       const struct btf_enum *e;
>>
>>          switch (relo->kind) {
>>          case BPF_CORE_ENUMVAL_EXISTS:
>> @@ -764,8 +770,10 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>>                  if (!spec)
>>                          return -EUCLEAN; /* request instruction poisoning */
>>                  t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
>> -               e = btf_enum(t) + spec->spec[0].idx;
>> -               *val = e->val;
>> +               if (btf_is_enum(t))
>> +                       *val = btf_enum(t)[spec->spec[0].idx].val;
>> +               else
>> +                       *val = btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
>>                  break;
>>          default:
>>                  return -EOPNOTSUPP;
>> @@ -1060,7 +1068,6 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>   int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *spec)
>>   {
>>          const struct btf_type *t;
>> -       const struct btf_enum *e;
>>          const char *s;
>>          __u32 type_id;
>>          int i, len = 0;
>> @@ -1089,10 +1096,23 @@ int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *s
>>
>>          if (core_relo_is_enumval_based(spec->relo_kind)) {
>>                  t = skip_mods_and_typedefs(spec->btf, type_id, NULL);
>> -               e = btf_enum(t) + spec->raw_spec[0];
>> -               s = btf__name_by_offset(spec->btf, e->name_off);
>> +               if (btf_is_enum(t)) {
>> +                       const struct btf_enum *e;
>> +                       const char *fmt_str;
>> +
>> +                       e = btf_enum(t) + spec->raw_spec[0];
>> +                       s = btf__name_by_offset(spec->btf, e->name_off);
>> +                       fmt_str = BTF_INFO_KFLAG(t->info) ? "::%s = %d" : "::%s = %u";
> 
> minor nit: btf_kflag(t) instead of BTF_INFO_KFLAGS(t->info)?

relo_core.c is used by both the kernel and libbpf. The btf_kflag
is not available in kernel. That is why I am using BTF_INFO_KFLAG.
I guess I can introduce btf_kflag in the kernel to avoid using
BTF_INFO_KFLAG.

> 
> 
> 
>> +                       append_buf(fmt_str, s, e->val);
>> +               } else {
>> +                       const struct btf_enum64 *e;
>> +                       const char *fmt_str;
>>
>> -               append_buf("::%s = %u", s, e->val);
>> +                       e = btf_enum64(t) + spec->raw_spec[0];
>> +                       s = btf__name_by_offset(spec->btf, e->name_off);
>> +                       fmt_str = BTF_INFO_KFLAG(t->info) ? "::%s = %lld" : "::%s = %llu";
>> +                       append_buf(fmt_str, s, (unsigned long long)btf_enum64_value(e));
>> +               }
>>                  return len;
>>          }
>>
>> --
>> 2.30.2
>>
