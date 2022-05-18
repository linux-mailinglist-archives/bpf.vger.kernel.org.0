Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC7852C569
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 23:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243078AbiERVKR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 17:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243004AbiERVKQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 17:10:16 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7324236764
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 14:10:13 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IKiCm7027653;
        Wed, 18 May 2022 14:09:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=d1mgyHrMRFKaknLydAHVDFeoXoM2ogXWhUYt/KiA9Es=;
 b=jGUp0OvjaxHkSQzOUf6iZUcEBe1EiEEqdJ1isYVuqUyvz26NOvKvcBE9UGi/JtHe7Xgf
 I0p5jcFIPtH2SMACiBh2TM0NtIHc9H9+BqUpwaqajkeyhUl//Q3Dp9SDvs/bk3wjviN0
 B2ADSoqOkyAfLzohpqVQ0cEx2LY027CYtMs= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4ap6v98n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJwFixZ9FdO5dE5DTM4YvmY5bfEl27rWcZWZ4Ac0Y8hlFwDBmP/U+eVUT8Gg4PAs/F37oGDOAmsdovbJUGEUCpn0WHOr/8hj3wiqETgvOaX4PFv7h/ieyy5R3B1Miyp459J4Q2CnxWIvcNL7vQIJPmx992KHiuyCf0CP1wmQe86rw2/uzB4/BbTSDUwDA4x26pkf11NrqKA2aP73mMtCj0QgrDtrTts8NJvys9YBPxtTsVgg9f5XCkoRZ25NdWQFNKmCy5tqfqe1SiNR16JDBQnT1qhlMzZLTpuryelD2dCI7uoyDpHPxNRbGArDM+ukiZEZWt1PMmHYIeuE7BpESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1mgyHrMRFKaknLydAHVDFeoXoM2ogXWhUYt/KiA9Es=;
 b=B3jLhxiA8l0Zte5jHZaAcrmIEMeeys+U8fzObaiLYHP/Dk56NpQKeGY+NSiOlknKEAY7lL52+xIGRjowcLFcenf9KwdjNE/6GcejLNzNYrn2VHkWrHi8XYQtZQO95kXYp71E5mMNWGMc8xO2FMFuP7lvI13jDcBMM5zJXDqb/aYsA3nRRvPpMsV15CXZ9voDOT+n7bwai3xRTmYpFuHpAY6k2GsC87fpwo+/iU98mLtcLF5gTMOh2MVsqku2ihkqJIQmuT4ZObxw7ztE3mSzcyV/qcRMOyIrNSiGgt/e1XK3j+V49MZlneAozspLRaVUDsn4Mzu2AYo6iRGUQGvZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO6PR15MB4228.namprd15.prod.outlook.com (2603:10b6:5:349::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 21:09:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 21:09:57 +0000
Message-ID: <a5976134-3e16-94ea-fd7b-1053b83747a4@fb.com>
Date:   Wed, 18 May 2022 14:09:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 10/18] libbpf: Add enum64 relocation support
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220514031221.3240268-1-yhs@fb.com>
 <20220514031314.3244410-1-yhs@fb.com>
 <CAEf4BzarwX0idepo1nA8QvyirRYQ-hZL3ZxKh3H=HWP=8P-=LQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzarwX0idepo1nA8QvyirRYQ-hZL3ZxKh3H=HWP=8P-=LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:405:75::47) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 727fed61-91cd-49dc-b804-08da3912c2fc
X-MS-TrafficTypeDiagnostic: CO6PR15MB4228:EE_
X-Microsoft-Antispam-PRVS: <CO6PR15MB42289C3A3B31E6D09C7EC474D3D19@CO6PR15MB4228.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPdKop0vch6hTAKZDhlmW6key/mIGLWRG8vBJmZJUlMtKGoQEAGp2VvSamsqODxhUNMMLhmUFs3VKusc/pwbmzrLMOAzKwgWB5JslWgWCdHXIASaVc5x7yqWNNk78tjTpCvdwLC4/i+3yPKnTzsSMN6016ttM+jrmV1BysYE5gyq29FFHlImi3elX41rEPyw25opNePX4jjuNDZga4Cs19HNocyzsVwkhfht9UpyLTqUsHeaoxqlT8yXzbWsqHNJIXCbFlTQLpHs2EIP+QGByQDFJCfTotFlXXxa395yGyn85DqaPNYbuxaIH17z2A/zPH1U8j0IOeoAzWcQ8sPc3aTAvAFuvckd9tGdalFoFcC9d2ClSG/Xy3msZc9U5G/UOPVsHg/kxAyO/8zr8W7THuR0oj77TbC1S6MO6UVtUJvqeujOMBKBObZ6bgAlOGY2DXS+xmZDpnxq2H2cw+EtrhrkUgXSi8pyvEMuo5mVyfD4+LlxXx7U08NorkaC+gemkaaTMNkFNa4XHmmkhlwjVKZKHVbOwE/qqP3EDWyeBD4Yqubz6AMEXfDXjKPZhQQLVTd0eu8U0rFtoiYFkgGd/B2J53s/XhF8brDtjOqRIL0zGiCVJBpYWT6Zq6AtXA/kZr+ZXe3C+hdaW1D0JBNoe1FBsluttMTuibcmFUQZbyQqYzEDh9Yj1WWT/YJha7/MMHBDEs4bNTVz7ixWbGxhS8RwTe0jCGw2wQ0o68BxqZw7RjmEhzyCQcJEah9knBR8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(8936002)(5660300002)(66946007)(6512007)(6506007)(508600001)(38100700002)(2906002)(66556008)(53546011)(36756003)(31696002)(2616005)(54906003)(316002)(86362001)(31686004)(8676002)(6666004)(66476007)(6916009)(52116002)(6486002)(4326008)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2JmRWJJK3cyUUxYWUVkM1dWL3pMckt2VUN6RXBFZjR1OGF5L0dZU2ZOa1F0?=
 =?utf-8?B?ZDN1YllDcDdlc2pWOEh4WlRNYW56M3ZLM1hWUkxwVUd4OUFNNjFOVTFXTmRI?=
 =?utf-8?B?S0IrNm8ra0tydmVjcWF2WmZmdGNNTEVVaUZZRDAzQi9Db2R0RndqeWFuck5X?=
 =?utf-8?B?TkxOaHZKd2dPYTNkekhjVDd2MHB1bWYzRW90S3VScGdyVGNhUEpKRGFodjJw?=
 =?utf-8?B?ZGJ2UHJFRGFINHlMUWZZRzlmQ2ZPc0EyQlRlblJ1MjZ0SEZMcVhCSjZxcm54?=
 =?utf-8?B?SG8rZVkxbEtrendJbzZKL3R3SlcwcFVDRmswcHArMFNBUG95cExYeVFVcVQ1?=
 =?utf-8?B?SytYNXBxamVjTEhtRmZwWllobGxHT0xCZ1hKbmMyUzVpNXpaR1BZZ1diMWJk?=
 =?utf-8?B?aFIvaU4zS2VoaVRac0hDRXNxVmw2bUJQZzAzMWxXQnp4OUFOT0E0SXFZZHNZ?=
 =?utf-8?B?YXVYNXc0NWhaaGh3c0N3ckUrZkR2N2pMR2VGZ3lyZ0pOTVd2Q3hQa0Rud1NZ?=
 =?utf-8?B?RXBlNW1nYitZZmJmamtvc2JlN2k4dHpucUVObExHN2lyeTlxaURRRHFWc2Vx?=
 =?utf-8?B?VHhGclJnaTE3NFBodEpmcm5VZjBDd0xCOUJwejJtOXF1SWE4SFNYRjNxM1Nv?=
 =?utf-8?B?VjVYUVcyc0oyeDBNRC91ajNYbWhEOHJCd3B6ckpPaWlObExBanVvTzUxeCt1?=
 =?utf-8?B?VE9QOElVYXpFQStzRURuZk5HVFNZcDZsMmJJZGlJeEFNUVczM2ZWYzBVbUVz?=
 =?utf-8?B?YStQOVkrdHVQMGxQZHdPZ0lNS1g3enhJcDBFaU1ucm5YY0NRRmNTTHFyd1hs?=
 =?utf-8?B?SUNYYWFMTlo3NmIrSWhSM1Fuenc1TE91M083a0x6Z01Gd3IzUEp3SUV1anVW?=
 =?utf-8?B?NWFnUVJ5QzJuYUpocHNWSGIrQ0tmeWcyOEIyNHdtOGxyd0pkUDIzak0xakRo?=
 =?utf-8?B?REVjN3pwYzR6NWhHWUdHOHN6VU9RWThpd1NNQzJKNXQyV2dKaUlwczBzUVRD?=
 =?utf-8?B?VHRuVWNpWDJMc2E1TUlkUUhXaEZScHZWalVwUUQrWldPVGRsZlhBa3FKVnAx?=
 =?utf-8?B?bDFmbXFRN2lSSW9SM2F6MElPekJIYk56RnlHNDNCcy9JaXBQZnlpSFVTL1Bt?=
 =?utf-8?B?RXBiSDM5b0ZlN0ZkVW4wWFBuSlprNmNwQW96Z3Y5Q0gyb1JxTU9HcnZQcm1x?=
 =?utf-8?B?YXZxQXZRS0YxRUdiaFlBVlV5ZjdwMDNsY0lnMlJ6b21pOWk2WWN5eHVrUWlj?=
 =?utf-8?B?QS9mRnpsYkxRRXBVVEFWTFlHNk1BcXVaYkNLRUNPeUlsNm9mQ0p4M1BwNUc3?=
 =?utf-8?B?ajB1NnJ6eHJlV1V1S0Q5djFnc0tGU2dqTEFscU5BTXdkUGpRMGFoV05qK2xI?=
 =?utf-8?B?NGhpSXJXL1RUVnFKODk0MzlZdlRmUFk4MXVhTkpWd2tFQUZEakNIK09WTlpY?=
 =?utf-8?B?V0ZKT2haMDk4T3RlK3RkZXh1ejg2RkFJclhzTmtCemlsZ3BRcGQyb2JvREY5?=
 =?utf-8?B?UFhnZ1pXckk2QnhreTEvb0x5blZUQ09XcmJKZ0QxcEdQb2Ruci9ReVFmYSs2?=
 =?utf-8?B?b2MzVWRwM2gzSHJzejJ1RUlvVHVqSjRUcDdzeFdzbE1ldmMvcGF5cFplR2N6?=
 =?utf-8?B?ZUpKT0M1VzJjMXgyMk53MzBMSldCc0pSeWJQYkt3VlhBVnRBSHVzU2NFQm1K?=
 =?utf-8?B?S3VPN3RjcmtzN3hVek8xU3ZWRDlPZzk3OFdBVHlkNVowZXcxcUcrRzdlYUNv?=
 =?utf-8?B?dEV6OE82Q1VWbnVhK2JhSXpMdlJjTDlTd2x0NVFXeHExK0ljREp5eDVLbzZv?=
 =?utf-8?B?a2cwY3NMdHBZOHpxeUU4aFBQSEVQZlp5Z2xzZUhLbEk0WkVkN1hWNFA3RFEz?=
 =?utf-8?B?SW5WNkYvUHg4ei9CK0ZtZVZZUVlSWmVnUXV0WHhFVWxLYzFDMW85cFpVMkJD?=
 =?utf-8?B?cHFKL3JyNG9kMGxwZXluVW95Zmw4MkV1eDlVS1VLMGhjaS80UHRxMDNFNWNR?=
 =?utf-8?B?bjRDZUFmK1pBMHdDUStrUDZwcjYzQ0pWeThoZk5uYWlkS3dYSWVrUWN6a0M2?=
 =?utf-8?B?WmdsaEs2MkdaaGJSWnBVc3doUnh6WnJPUTBneDVrcGRrbHVWd0ZDOHBNQ0k4?=
 =?utf-8?B?U09rb1UyZXBHdE5ldHVvQ1E4dmVvZHVXY3p2aEFIR1ZoRUhWcGxsbWx4Tzlk?=
 =?utf-8?B?cjRQUFBnck9rcGZmcGFXN3VkRUZBVVFvNHlCWVY3OFFMeXc2WE51ZjNSZ0lC?=
 =?utf-8?B?YWR6Ty9vbHJMUU8yWU80WnAyWU1zQlBHUER3Szc1QjE0MTV1QUZwTzlLM0h4?=
 =?utf-8?B?cytCK050T1JCbzlDazRWR0o4VEFXMGkvOWlmcVZDL24yaDFtQ3crS0UyRXVr?=
 =?utf-8?Q?AwgDHVzTpMwyaEH4=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727fed61-91cd-49dc-b804-08da3912c2fc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:09:57.0976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVh5VmciEkk5PNAvelEU/ZaX7Lspi82jxXsu7WUIAGiUl22+BA58yt1MSORJ3tGP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4228
X-Proofpoint-GUID: FnJJ8X5ef3TGxvdGunKLNxJqufmSc9Wo
X-Proofpoint-ORIG-GUID: FnJJ8X5ef3TGxvdGunKLNxJqufmSc9Wo
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



On 5/17/22 4:32 PM, Andrii Nakryiko wrote:
> On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> The enum64 relocation support is added. The bpf local type
>> could be either enum or enum64 and the remote type could be
>> either enum or enum64 too. The all combinations of local enum/enum64
>> and remote enum/enum64 are supported.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/btf.h       |  7 ++++++
>>   tools/lib/bpf/libbpf.c    |  7 +++---
>>   tools/lib/bpf/relo_core.c | 49 ++++++++++++++++++++++++++-------------
>>   3 files changed, 44 insertions(+), 19 deletions(-)
>>
> 
> [...]
> 
>>          memset(targ_spec, 0, sizeof(*targ_spec));
>>          targ_spec->btf = targ_btf;
>> @@ -494,18 +498,22 @@ static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
>>
>>          if (core_relo_is_enumval_based(local_spec->relo_kind)) {
>>                  size_t local_essent_len, targ_essent_len;
>> -               const struct btf_enum *e;
>>                  const char *targ_name;
>>
>>                  /* has to resolve to an enum */
>>                  targ_type = skip_mods_and_typedefs(targ_spec->btf, targ_id, &targ_id);
>> -               if (!btf_is_enum(targ_type))
>> +               if (!btf_type_is_any_enum(targ_type))
> 
> just noticed this discrepancy, can you please rename
> s/btf_type_is_any_enum/btf_is_any_enum/ so it's consistent with
> btf_is_enum and btf_is_enum64?

okay.

> 
>>                          return 0;
>>
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
>> @@ -681,7 +689,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
>>                  break;
>>          case BPF_CORE_FIELD_SIGNED:
>>                  /* enums will be assumed unsigned */
> 
> we don't have to assume anymore, right? let's use kflag for btf_is_any_enum()?

old comment is not accurate any more, will remove.

> 
>> -               *val = btf_is_enum(mt) ||
>> +               *val = btf_type_is_any_enum(mt) ||
>>                         (btf_int_encoding(mt) & BTF_INT_SIGNED);
>>                  if (validate)
>>                          *validate = true; /* signedness is never ambiguous */
> 
> [...]
> 
>> @@ -1089,10 +1097,19 @@ int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *s
>>
>>          if (core_relo_is_enumval_based(spec->relo_kind)) {
>>                  t = skip_mods_and_typedefs(spec->btf, type_id, NULL);
>> -               e = btf_enum(t) + spec->raw_spec[0];
>> -               s = btf__name_by_offset(spec->btf, e->name_off);
>> +               if (btf_is_enum(t)) {
>> +                       const struct btf_enum *e;
>>
>> -               append_buf("::%s = %u", s, e->val);
>> +                       e = btf_enum(t) + spec->raw_spec[0];
>> +                       s = btf__name_by_offset(spec->btf, e->name_off);
>> +                       append_buf("::%s = %u", s, e->val);
>> +               } else {
>> +                       const struct btf_enum64 *e;
>> +
>> +                       e = btf_enum64(t) + spec->raw_spec[0];
>> +                       s = btf__name_by_offset(spec->btf, e->name_off);
>> +                       append_buf("::%s = %llu", s, btf_enum64_value(e));
> 
> nit: we do have a sign bit now, so maybe let's print %lld or %llu
> (same for %d and %u above)? btw, please cast (unsigned long long) here

will do.

> 
>> +               }
>>                  return len;
>>          }
>>
>> --
>> 2.30.2
>>
