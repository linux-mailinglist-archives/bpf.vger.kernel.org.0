Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9860D670CC7
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 00:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjAQXJB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 18:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjAQXHs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 18:07:48 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3A444BD4
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 14:43:00 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HLFLiI014060;
        Tue, 17 Jan 2023 14:42:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=GzAzIQ+bZmHz5hAveMxy/A5NM16YfUF2HH24cp27L88=;
 b=TJqcHvauO/qcPvzYX7TX9AJSgUzj6+ZMqByqcRlxKHeQl44Rba+ibo4sEarg6RXjnC7m
 i2amBW/n3RJeD9nJOXIeBYDbkEoBU2FdYwYhSTBiWpHQPHCxU7+j57ywJqPbxRgRXnb3
 /NRoRqrUAGjPRhvHelqIo7b1FdwFqEYb7IXGxB/ksUEvDOJjvjMTO/PO8iX9QdnhhCMv
 3XJsJFWSxIj5ZUoqXICZbP3eToFv+nreT25v+2Ta2Anda06U8DH7w0H0D5f5p9lTgtsZ
 S/B6lRAjGLpxVhujZlTTDpMHjoIPuuEBsWtWlZG2BWHx1AdGTsrKDCFbygnv4JBpehQ9 WA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5jdx6a73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 14:42:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aa6x+MqXyhzUC/Of+vZtYnwFzKmzPNyht1WzBYQpFGkZ4i7gVRX3MmFu2/FNqhmDZ4NyDa+yhhaMUZO7e0qWYDCZ/0GEATKPwjilON/6CjDl4Mh5tQsqWPSmuwhCQ98Thjne2ceou8octJsFDMCeVvQnSkigIM1HpCjkB+u2r9hLm+QEQj8gLeQc1ma9pfTuYIA7h2ZSB/OuXfBQZRSfUiPXgRfprhznTBOQMJsLjH7piaDtokCJKPxFcvzHzqZyiwWm5+rUdm/t4v8QOUkbCcTsOnogoXET2Pg9G6PUp998nhPazdytInusXZ2IEBDHWy+oZpWqhe68yfSWwmqmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzAzIQ+bZmHz5hAveMxy/A5NM16YfUF2HH24cp27L88=;
 b=P4c4rxw0gvrvv3+a/nhrBUZx7Kuarj8NwfRR1PSjMwFEPZQd2KKfQwXDkV9VqoNgKjfX3Borx86yRZJrBNlV8FDG/tKhvgfsKaHdl+5O6olWIdNbOfzve0QOv7D1wHPNS4i1AeBWDvQYRmBSjtTgWlLKEvAGuU59ohnJGfGzbQKIsB5W66afuky5FrYXncDmvcuA+YPTsbSqRSyRAdN+ZZEMFZZ3xgEEqHAi9UPpyn1Q9hmVmed+abTNJ0bjOwdmcNIcJdTQrZaKCNaroZaPP4D8uxBUaEF+il9Nl4CzyJMltAPXRm0cSlzcemw2mAWCydOTTz3XhqFog3ZYSW5w0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by DS0PR15MB5472.namprd15.prod.outlook.com (2603:10b6:8:c4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 22:42:41 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::406a:f351:63a7:7a0c]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::406a:f351:63a7:7a0c%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 22:42:41 +0000
Message-ID: <58508fcb-5b0f-5e29-8e2d-3e2d3c77118a@meta.com>
Date:   Tue, 17 Jan 2023 17:42:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next 1/2] bpf: Migrate release_on_unlock logic to
 non-owning ref semantics
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20221230010738.45277-1-alexei.starovoitov@gmail.com>
 <CAADnVQ+Ur_Z2j9SEP73BZdYPQrMxzjOWa-45z-cw9zvtANTmCQ@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <CAADnVQ+Ur_Z2j9SEP73BZdYPQrMxzjOWa-45z-cw9zvtANTmCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:208:234::28) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|DS0PR15MB5472:EE_
X-MS-Office365-Filtering-Correlation-Id: 619acb98-e7bf-46bd-dbd7-08daf8dc2494
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dFOrQ6DbZLP9Wu6anzAFaJr25PQThZqWCNkReEu4xMvkVoWzpMlXuE6K2/YPwwmGynLU2p3msM6/G5+8MPMKHQgl7lriELYaH873kOLWIr+Sr+HMQVU8tlckjHQoTEmc+gaa4myYc46gMzJCetXmaaR+5zAjdU2Dm7SniK8beKeKtJoUb0DOq/FMWf84RAOgx37lfykKckfmEcTpmu7zpZXmYKEliXYOVamSQu8U/N5m5wovXmjE24Kc8WAwYxh7eGmxVD1/siO+xKdn9kvF8i1M6+kctCcTSmrjL0MIBRgD5yvzxKc1qzNv2B++WYJQKQcoPMXrI5tuYei1r2qAtnxMsjr0IAqp3OvJ70XA2/NUH6bNazlyTamaiuC+ACsjGJYu/E5DYS3QRAM/TwfRzbmiAgK6hnaxcJ+C/KM79E0MsSwPuz2OcDux7uaJikCg2U65JGPyUf6yAv5bc3v5hZeJtN/Ge7A3ZCtdX5fozmyW17xOTAaTH8LCZdhQaCV9xI3Vm6X/IGAIEJaoVKMjtHVe1Jb+CbpTUqg90c/ARcsr98Q+vzEt//hNwHcsmi+0k2vSxgJUprPxcVxyPnCzoVXk2VIbNuWvt0R59DIId5w5m6+o0F6ALIf3tOMPvGakPc2Md3RCRVv1XBQ+3HuAABSWxbX69+mJIcYEfC4I3JXvaIbCaQEtrI98XMjqvXkK7hauweyezfLfb/3jX1vEgxWIa8a3+WqrI6uLVO/OSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(31686004)(66899015)(36756003)(86362001)(2906002)(31696002)(8676002)(8936002)(66556008)(66476007)(4326008)(66946007)(83380400001)(5660300002)(38100700002)(110136005)(6486002)(54906003)(316002)(41300700001)(2616005)(478600001)(6512007)(186003)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2pVR3V4aVBPcUwwNEpmVEJMK3FHcWxySUs0MFM3Z3hZMGg5Tnk5Rm1NVDlu?=
 =?utf-8?B?MTlRc2JhcGZaWER2bFQvaEdFbG12bW5HeUJOK0NtU0lxVkVEVUtCL29nZGd1?=
 =?utf-8?B?S2RCQnhWdmo0TTltUGg3dlJqcVBZNVg1Zk5DOWFUc0dTQ2VUL2Q0TW1LUHRZ?=
 =?utf-8?B?N2ZERS9rODRjWlRpLzNVUzg5VDZQaEoraE1EcWhPajlzRVNNZ0VXNTRodVR2?=
 =?utf-8?B?REJQaG9aMDVSa09TMHVQSzNhM0xNeUR4NlQxZkpKVm9IeDFnalpnUHVRTWVu?=
 =?utf-8?B?eENwWHordHNIMmJKTzR4bDFvYjVqUUZEUkpLL2FxOXFUWUdnSU5tT3RPZmxY?=
 =?utf-8?B?Szh6Q2JzNUFMM1VxM2Vyd081NzVuVEJaZS9abDVYZEUzQy9uOXVOaTMvcEhV?=
 =?utf-8?B?UXlxN0ZZV3g1THVFV2VZZmRwemxwMU5jWldiQkVGUFlOdnVMdUNJbnU1Rk5v?=
 =?utf-8?B?d2cyTnFoM25sa0VmeXd2a2NqdmttdEpTaUIyRGkzUDFlOFljdS9yQW5Ca1ht?=
 =?utf-8?B?QWhQcDFIUlJQSlZwTzBWOS9BQ3dSbUxhUmFpUERMSE95TU1PU2o4ZWZKZjdx?=
 =?utf-8?B?K2NuckNvb2lteXNvNEQzOGt6OWN4VWlQOWVGUWF3Y0VOaE0wekdHVzErUU1P?=
 =?utf-8?B?SVB6VWN1ZitySVVKKy9QYWdONEFRK2loekRUT0hBNHVraUFIK2hQM1BSa2dN?=
 =?utf-8?B?d3ZPVmNqWWtQZGw3eUJIR0Z3MEJHZWcrcTdMeFM2NVozNHlyOWNHaTFya3I5?=
 =?utf-8?B?Z3B4OGQzOC8xQmRCaUVtRGxNdWFjTEVTWDhKOTkyMFRDWHVib3U4NlUvWnh6?=
 =?utf-8?B?V0pDSTRpR0VaOXlTR1lndWtNNXJ4cXE5aTZGdWRBdFAyb3lqS3RSL1FoODZW?=
 =?utf-8?B?dWpKMU9lTjA5VGxyZ3NBc3AvMzc4VElGc1RjcksyZFBvdCtKUVRDMlViMEY4?=
 =?utf-8?B?cUtPMlAwblNBdlBMMEVmZktsMFgzb2MwbEJvOGJNcDVEVEx6UFhCa1JUemMr?=
 =?utf-8?B?Z1RYMkwxcDVJb0N4VVFHcFZRaGgvS0x2MEU1K2dXbTUwR2tqUlRMV1J2b1ZD?=
 =?utf-8?B?clh3R3hmM2ErS2VWSlBiYlk2ejEyK0NVa3MwSXpQZzNKYTh6MTZzQmZicEFi?=
 =?utf-8?B?VEhYUjA3c2FzUWwzMEdmRXo2OEhJNXZoeUd4L09mb1hxYXlxUkNLTW1YYjh5?=
 =?utf-8?B?ZkszSnJhbHF3Q0Z3YjhEZ2lpc05KekZOdForY0ZSL3I1dEExdnlVOHNqWSs4?=
 =?utf-8?B?akZISGQxcmRoNkNMUUY2b2Z4eTF6QnJ2b2JMazRXZW8rbEFEbGZGcFRnVFR5?=
 =?utf-8?B?cjBkMWZ1elVQQWZaUnV6TWpFcnlNZ3hJaVI2dVJYbStTMm9uVFZvZFlYNU5i?=
 =?utf-8?B?TlV3VVBqdEFteDNjQm5rMWtseE5zdTVGcFBIV3VEYXY0eUZYa2xjelZSSkZl?=
 =?utf-8?B?bm5BZTRETmlZQk5wZjFBOGFaK0gvMlBKVXVOdnA0dXpuWTcwRUxpR05LZnFI?=
 =?utf-8?B?K3h3UTNLMzM5Tk44K2lTV2dSN0JPeUdicnQ4bUpmYzBGQ3M5blRMdEVhNkVW?=
 =?utf-8?B?MXJTSm9hYnZSNFNEZEk4UXBwQkpTVGU3S3g5VVl0RkRNWlpidFZrQW42dVhD?=
 =?utf-8?B?Um5rN3BuNzhJZTU2U3JqSWdaeFhTZEJoWXNzS2xvbHFaYW5kaHFWUEx0cnFl?=
 =?utf-8?B?b2htb0tKQ0hOemhIUFRUMVI4amVmS1dhN0ppN0Z2M09BVTl5UERMdCt3emta?=
 =?utf-8?B?ZkhBcFBZdG4xc3hjZnpZV2NOV1NCbURHeC9FZ0hsTHJUblMxQmRKZ24reHc5?=
 =?utf-8?B?d1llVllGaGt6N0dqRUprWmREZlUyRS8xTE5OMklZWDFOTTRVMExuN3NIOTEw?=
 =?utf-8?B?cHhaQlliKzFxTmh6ZWc1SFVVRXRmcVdaWWMrNmZsTVZRUlVQV0JyOCs3Ukk1?=
 =?utf-8?B?ODlFbmFyKzVPTVd4RGF5VktNc1l0ZWcyUXh1V0dKR3ZVUjF1dHFLMXRac2tz?=
 =?utf-8?B?d2VJK29CaWdEMmV3SUR6OFZaSjF5VlZ0SDZHdG03eVNRanJOMS9qVTViZ0ZP?=
 =?utf-8?B?VzdRMkpmaTZOWnBNcDNrN3hGZmtDUHNxaXBwUDBCYit2NnFmb3VyZjhUNm9w?=
 =?utf-8?B?aG5BTHA2S1l5MTAvTUR1dlVJMDIyTlhLT2JZREFxcHZhUmxUL1NSVFRqVzha?=
 =?utf-8?Q?YDFhfSc0XGBzNk39ZODWyHU=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619acb98-e7bf-46bd-dbd7-08daf8dc2494
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 22:42:41.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+Ux+WZ68NgrFs80iTbNM/kkwvO94C2fe8oPjOVFOMJMSe1OnYkSuWjN+QkbBbU6A4Dx6N5La+6ZqfoI/IzfNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5472
X-Proofpoint-ORIG-GUID: njzEWN_H4tF3eLYRvxGIlgfsBmp0m5UE
X-Proofpoint-GUID: njzEWN_H4tF3eLYRvxGIlgfsBmp0m5UE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/29/22 8:13 PM, Alexei Starovoitov wrote:
> On Thu, Dec 29, 2022 at 5:07 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> @@ -11959,7 +11956,10 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>                 dst_reg->type = PTR_TO_MAP_VALUE;
>>                 dst_reg->off = aux->map_off;
>>                 WARN_ON_ONCE(map->max_entries != 1);
>> -               /* We want reg->id to be same (0) as map_value is not distinct */
>> +               /* map->id is positive s32. Negative map->id will not collide with env->id_gen.
>> +                * This lets us track active_lock state as single u32 instead of pair { map|btf, id }
>> +                */
>> +               dst_reg->id = -map->id;
> 
> Here is what I meant in my earlier reply to Dave's patches 1 and 2.
> imo this is a simpler implementation of the same logic.
> The only tricky part is above bit that is necessary
> to use a single u32 in bpf_reg_state to track active_lock.
> We can follow up with clean up of active_lock comparison
> in other places of the verifier.
> Instead of:
>                 if (map)
>                         cur->active_lock.ptr = map;
>                 else
>                         cur->active_lock.ptr = btf;
>                 cur->active_lock.id = reg->id;
> it will be:
>   cur->active_lock_id = reg->id;
> 
> Another cleanup is needed to compare active_lock_id properly
> in regsafe().
> 
> Thoughts?

Before Kumar's commit d0d78c1df9b1d ("bpf: Allow locking bpf_spin_lock global
variables"), setting of dst_reg->id in that code path was guarded by "does
map val have spin_lock check":

  if (btf_record_has_field(map->record, BPF_SPIN_LOCK))
    dst_reg->id = ++env->id_gen;

Should we do that here as well? Not sure what the implications of overzealous
setting of dst_reg->id are.


More generally: I see why doing -map->id will not overlap with env->id_gen
in practice. For PTR_TO_BTF_ID, I'm not sure that we'll always have a nonzero
reg->id here. check_kfunc_call has

  if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
    regs[BPF_REG_0].id = ++env->id_gen;

when checking retval, but there's no such equivalent in check_helper_call,
which instead does

  if (type_may_be_null(regs[BPF_REG_0].type))
    regs[BPF_REG_0].id = ++env->id_gen;

and similar in a few paths.

Should we ensure that "any PTR_TO_BTF_ID reg that has a spin_lock must
have a nonzero id"? If we don't, a helper which returns
PTR_TO_BTF_ID w/ spin_lock that isn't MAYBE_NULL will break this whole scheme.


Some future-proofing concerns:

Kumar's commit above mentions this in the summary:

  Note that this can be extended in the future to also remember offset
  used for locking, so that we can introduce multiple bpf_spin_lock fields
  in the same allocation.

When the above happens we'll need to go back to a struct - or some packed
int - to describe "lock identity" anyways.

IIRC in the long term we wanted to stop overloading reg->id's meaning,
with the ideal end state being reg->id used only for "null id" purposes. If so,
this is moving us back towards the overloaded state.

Happy to take this over and respin once we're done discussing, unless you
want to do it.
