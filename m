Return-Path: <bpf+bounces-1146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB3870EBAB
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 05:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1B21C20AC6
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 03:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7B715B2;
	Wed, 24 May 2023 03:06:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05513EC2
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 03:06:30 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC83DB3;
	Tue, 23 May 2023 20:06:28 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NKZiGA027516;
	Tue, 23 May 2023 20:06:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=w7EHWz5RXwUXDQvsjHLqSnEywJ/I3Ug2rxB7N+kMmTg=;
 b=fmMnJ+u3d1PBsmorCisn5KCz35OTdsmXY9w+xRKPPu7864HV2T5gl+hPrWV96T5fxZlz
 2RuHvCeghWpAl399H0qXgSNsV29YDqDyCWE/PoyYTYjPurxIUgY8S+NOpclsZBrBFJoZ
 J2RJR6lx/KLQFuYQb8bEMfy6kVjafjUX57vlxLUxQF8NW4tLSESubJ+pWAEdsd038MYd
 M+tpRpsgXMmYPYo/uVrVJ7Crd9Necy7BAYeHD7U6KvFASz8nKfnY54FF0NoXcMb7glNp
 FsMEpojSpTynJjVHbRYq3G3iOBeU1eCQsR2eC2/yWgL+DW0IhCCyr+79QrQFNvPfeedo 9g== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qrb9ddgjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 May 2023 20:06:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksOOg2EdddoMo1v0Fy3YXHpdZE8XrvuZP+UJFVtzz5MzRuDtND6fdP7/8wGLNCv5JbCOMZVtu27WFUv7GtdTZrusaj+8namYigKUuGKsQRfX/ng35cXS1Ue7SsUO0IZnHGRtvypZsNM/PHguW1Ede+qCn+cd1v/tq0nr3BGQqdBM9LqBVbqhmPN2C1djkcaZqlKv509qfFw6+5qma/aT6+FYOHBZwn5apW0EYT7yK64+2n+/OhEA5XVOFaiNzsSn2mKefMh3t9CzzzNBk/tDSuxw0jdX0p2YFUwDHSlPyNddntJiVxGKWvMDD6HexH0inbq4EGITkXjIBMI6ecbPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7EHWz5RXwUXDQvsjHLqSnEywJ/I3Ug2rxB7N+kMmTg=;
 b=K5BvwdYimVxty5W882dMvAz3z5/PDOcg3dF3YN9eUNMXE2eDGOKKERxs/QWTetNoEetyQ4qZFon7R8J5ZxzvtRZ3/QpOUtqsgHQUhpWnWQM8FCprdloc0oJOk/3AQL+9BhAsoFy9Xom6s4/tVFlJkJHboSCoUZQzuO8CVwNhI/ynmGjmLAtD+qwBuc7TZPrUfBXgLAyGUd9espcH7qyo3hTcMZd774zAz9c6+9OI3EGSGP6GkHOW1ZT/fs7tKNd6/b1KcyZ+R5S/i8QwSzsEcUZQFlCAnZvF4fcqoHhSaA6cwJhYVBZdae2PyKPcejogiBwQB7JvmbjDiiQrEjjhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB5993.namprd15.prod.outlook.com (2603:10b6:8:189::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 03:06:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 03:06:03 +0000
Message-ID: <f7b6f68e-f218-9d7f-22dc-3e4bac70051a@meta.com>
Date: Tue, 23 May 2023 20:05:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] [v2] bpf: hide unused bpf_patch_call_args
To: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230523194930.2116181-1-arnd@kernel.org>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230523194930.2116181-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 30128817-f385-4e34-6a44-08db5c03ced3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9uigE2hg4/mChDBW4h6Fia4obDBtkjHuq/FMw6AQ+3tf3UHOC6Y2bP0NFVp4cDuaLF363PnXRUc9+8FnKxte71NAeOAj9Ixzl/5mrnDTQ9wZPB+R7UAYOLoq0Big6eoMBiPXnYglvmS4NIa6SpAKp2caShZK1O52IFeTXmq3x4KEGR3hFvLsSpAZLOaG53tAW+PDLx6FouhVlu229b0rqVLSfkDXlZF4GnlRQeMunG8gieTL8zx1eeAMDGqWKAFSKQcM5/TI1lM1h7LFBNeAXoR/7SLhYwhH2QN/BJqkUjsgRki3PvYbSYVnNiEU1ReZw0rx6+YUkrxAfS+dz0+z9BOpuIBzFcRZjEpOx+gNxF2idu+acC3q3VpjJFmgyTNOmyfL/YmNjNpAN/bs8+xvdsplVktNpAiRuYt4P7Anx9W+i/0SzoB62fg8hxZCX8d4dom/2acNXT/WLJcUvtP/u76i+0hLsjazuEZm0+g/RBmnNcpqDUH+1Tgt6shsYkWz19p6+hcXlYtVPOp0RL6DH1YywLgHTh4ZQm4fQucCScBuZnNU42nurRc/PHUf3LCIcpBMkrduJh9JWgKB89NjDX8U/Fwqg8XndlCd9SrqClrHGVORaZ8K7lAyEKvI8l1TyMfv3kSzWT6VNv0vPq93oQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(6512007)(6506007)(53546011)(7416002)(2906002)(2616005)(36756003)(186003)(83380400001)(38100700002)(316002)(6666004)(66946007)(66556008)(66476007)(4326008)(86362001)(41300700001)(6486002)(54906003)(110136005)(478600001)(31696002)(31686004)(8676002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bTIyNzljYkJ2d0dUcVNNVUxNUDUzaWNHS3RVU2p5TGJJeW4waUtnaUQwUnlv?=
 =?utf-8?B?M3J0c2lLWEtJMVdZKzErZllpZ2lyWHJTODZFTnZEenhtR28zRldXSzBONWg4?=
 =?utf-8?B?dkowR28xQStDRExKOGJ4elVhZ2RaeUtzMzl3dUNmVmhVVGNva1NFOGp4Y0Ux?=
 =?utf-8?B?QXNndnlDVGVnV2RPMmVRelNNbllMbWpJNFZBeUg4ZStNaEdYeWkrNngraUFo?=
 =?utf-8?B?cGM0MDc4V0pUOTNSUmRvd3FYaG9PQXlMdVY4anVYUWc5a2JmUnBwVGZRTXJy?=
 =?utf-8?B?d0dZNE1nSUxKdUlXd2ZNUWRMOHF4Ukx0Qjl0dzBDUGFoWjFyajRzUGNBTkVt?=
 =?utf-8?B?d2cwcFFYcjFBRTVoeGYrc1BZR01FaXhQN21lVWpib2VqVnZmblN2RlVpd1I2?=
 =?utf-8?B?aVdUZ0l6WWJ3bDV4Yk5MR3Y4QXRDVmp3M1FndFZNK2VQQUIwaVFMNGVQZGtm?=
 =?utf-8?B?aUh3SGk2dFRUeklaaWxYYkZ3eHFQWFI1NWJVbHl1M3gxTWY1OGw4c01PRTJw?=
 =?utf-8?B?SHNONzhwUHJkN0hMcGp4MGJONWF5eEp5RlhmMCtZcUpRQmlISGlQZTRWcTMr?=
 =?utf-8?B?MHdaMlg0cnMyaW44NHorRUh6Q1N5bytVMjdtbVdNRjlYOGRzcXBEMktxY2hk?=
 =?utf-8?B?czZpaFFkdC9tRXF4Y3EwbFlhVlNHQ1Z4REh3TUYvWlcwTVhFSzVyVCtSYmcw?=
 =?utf-8?B?VmpQRGczUGM0WFVNcjBxaTZDOUVGd04xNmhESTkrZ0c0SGtmMllMWG9CblRU?=
 =?utf-8?B?UWFRd0xVeDRvV2JROWxEMFhKQ1ZMOFJ1Nkd4TFVpMUlrZ2xIYjl1ZXlBNWJm?=
 =?utf-8?B?U2tUNHdhUlJ3ZGFPNzdQODE3czRHa3Z5N3FxV05UcHJTTmVCaS9Fb1BEWUNE?=
 =?utf-8?B?TzBtS1VmZkJoTFAvV0wrc21seWxnUk5Ib0dveC80dUgzdmhBYXBoM0JXRG44?=
 =?utf-8?B?bmlYcFJqS0d5dmF3cnhJa0dsQVBOMTJ4dmZqRm1SdHVRRTFpYmQ0eENVVjBO?=
 =?utf-8?B?S3dFVHprbkV3ejRQTGwvem0ra3pCUmdwcUo2SUdGVEdzVS90OWdQejROakxL?=
 =?utf-8?B?YUp3ZWc1bTJjOHlFdjNTNlMyNGYxVkhJQlIrTDlrUVNFcDlXVlJYTE82NTVw?=
 =?utf-8?B?SzJIV3U0MWVpNjR2TU1BSzlCR3huMDJjWXV5MDU1cnI4SE1kdHRhUk9FNXFI?=
 =?utf-8?B?NEV0clAwek1oYWE0Qk02STczRWR3Y1RLNFZzUm12bzkxc3QzVHA3dCtEeE9h?=
 =?utf-8?B?QXh3N05wUnlvWmNrWVhOZFkvQy95MzUvTzRhcklIQVJnUnBuRGtRRVVsOVZK?=
 =?utf-8?B?T05HcHlSMXZVcGFiS1pQR3BhQU1URmh4YjI5N0RDRjh4V2ZGS1ZFa0Q4MUg0?=
 =?utf-8?B?c0pIRFIvSm9VZWZYNmhkQng1Sk5oZEVacDJ5SWRKbS9PVFhPM211OU9XbFBa?=
 =?utf-8?B?UGViaTZjbGtwYVVhVWlPUHh2cElLdDVybjRDRllMVWZlS0plR3UrWXhKRmhv?=
 =?utf-8?B?Y0FHQjRWMU1FSnhlNEVLRHhrdXlyZ240THFGYTRSRzRRWXRCQVBVZHRuMHV0?=
 =?utf-8?B?K1d2cExZQU1IZlBvaUk0eXUzNVRldHJ4TVdnWTY1bTRsTEN1RHFtSUJYRmw4?=
 =?utf-8?B?Mmk0VUN3VXVTejdDS0JIMGk1Sjlsd0pVK0FlTzNHREJtVksxQ3Bva2dtb2lr?=
 =?utf-8?B?TzZwdnA1S0xZZnduM0REazM0OUFSeHlKd3FwWUtMQ3hJRm5Bb0FIR2ZlMGRD?=
 =?utf-8?B?Q0tDZHN3WjdmUVlKL1Q3L0NJSUkvSHE4UytCdmFLdkxtUEFYV3poYUdvWEU2?=
 =?utf-8?B?STkxakxhcGNRNzNaWUV6KzhGRDZnMEorMUV5cll2WkNaa2wwd2xTU0xlSGEy?=
 =?utf-8?B?ZmVPOXFEMEFNUm5QQ1AyVmtuaUg3ZkVHV2lXVFBRQUl2cWxXOXNId2gwdi9K?=
 =?utf-8?B?ZGZ6NXpRdVhSZjJRbDhjS3B2eWJ1YStKRkZDTUJ2K3UyV24yMHJERks2OFBh?=
 =?utf-8?B?UXFtMXE5TTBQWnlSYmVLU1ZXRXhDd3FVcGRaRFozSHVjUmJmT3U0YmxMam5s?=
 =?utf-8?B?VVRnL2diN3lYLzFTZU95Z2tpNlVmR0F6V1ozajgvNm1WeDlzN05BRUNjVDNj?=
 =?utf-8?B?SjJvQlhieGJtb1ZDK1g0Q3dlSUhOSWR1MUE3aFQ2c0JOTk9YY1RlZ2QvUkhH?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30128817-f385-4e34-6a44-08db5c03ced3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 03:06:02.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zbw56hTWqgJyM6f/y7HQB6wMDRz3ZuZb1IMMMHejjZxxBJq4u81Nsx1N6JJEAh/b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5993
X-Proofpoint-ORIG-GUID: EjMyes3YKxZMu9GrHmg8hJp67PbFFO0G
X-Proofpoint-GUID: EjMyes3YKxZMu9GrHmg8hJp67PbFFO0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_16,2023-05-23_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/23/23 12:43 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function has no callers and no declaration when CONFIG_BPF_JIT_ALWAYS_ON
> is enabled:
> 
> kernel/bpf/core.c:2075:6: error: no previous prototype for 'bpf_patch_call_args' [-Werror=missing-prototypes]

If CONFIG_BPF_JIT_ALWAYS_ON is enabled, the definition of
bpf_patch_call_args should be invisible. Maybe I missed something.
Could you list *ALL& bpf related config options in your setup
so people can reproduce you above error messages?

> 
> Hide the definition as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: change indentation to align arguments better. Still not great
> as the line is just too long
> ---
>   kernel/bpf/core.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 7421487422d4..0926714641eb 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2064,14 +2064,16 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
>   };
>   #undef PROG_NAME_LIST
>   #define PROG_NAME_LIST(stack_size) PROG_NAME_ARGS(stack_size),
> -static u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
> -				  const struct bpf_insn *insn) = {
> +static __maybe_unused
> +u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
> +			   const struct bpf_insn *insn) = {
>   EVAL6(PROG_NAME_LIST, 32, 64, 96, 128, 160, 192)
>   EVAL6(PROG_NAME_LIST, 224, 256, 288, 320, 352, 384)
>   EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
>   };
>   #undef PROG_NAME_LIST
>   
> +#ifdef CONFIG_BPF_SYSCALL
>   void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>   {
>   	stack_depth = max_t(u32, stack_depth, 1);
> @@ -2080,6 +2082,7 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>   		__bpf_call_base_args;
>   	insn->code = BPF_JMP | BPF_CALL_ARGS;
>   }
> +#endif
>   
>   #else
>   static unsigned int __bpf_prog_ret0_warn(const void *ctx,

