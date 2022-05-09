Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F240C51F25D
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 03:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiEIBbB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 May 2022 21:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiEIBLJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 21:11:09 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C6EBF6A
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 18:07:16 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248LN5cu022956;
        Sun, 8 May 2022 18:07:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ojLLknLmpji4pSGVEdj5GQAfrxesB5d6iyNpvuKwbd4=;
 b=gIZAXrdA7kxJ/4OOVAq5SkKzG3E0hYayyL7tA4npCMUKjPtVvIC+vYmMTfpcvrRoz91B
 ycXGB7J5uQIgPqm60N6NOEw/RrndY/j02VzttwpS7pawga5M7s5QAb/yaT1RuB5qDJqJ
 4KDp5e/B2sj67Bc+hHGrKpIPczKXdpbXvx0= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwpksdrhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 May 2022 18:07:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNOYm95vUirB7/RCbUbGI2oIjm3zfeLojmWOglnu1komhEEH7ZP4m5W6m1ll73NmW4RJg4Rc21UbMNOw+k2L1SO3FXuoGZSOOo5O4oMEgFw5slvfZirm+Qq/BdF0WpJPDJ452zPg5ldNCyYYe14fRXlIwzbdhnd9SHc14CQ1GH5PUDJmgagunuUvbny/oQTNmLK0NzAU11WtTXg2xB+2i7hjqQr+YSWoca24xAJFYsWJwHuEzcXCltpF+oDvmFRedEGBItUU+nKIndkiJJDwYdjF0WaJ05foiTuuKOTDmoB7eM/T4BwPu8VApisOoVvtjcThrpGLel2d2/XEzApWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojLLknLmpji4pSGVEdj5GQAfrxesB5d6iyNpvuKwbd4=;
 b=Tg74YwDxa/LZIs4aZ1d7aj16Nb9qghTyW198QwnPdgBC8ztDLv8relwyR7ZeKo+103CvoCdIj7pmCFM5yyTr1xFhaaTzn1X8VU2ryQfq1EdhXPjEBER6wqOsrlYu6JypDAiCFi8YIuE+38QeO7Bt3oQ+eOinWx5JCmfCbF5eOUU13S9ej7hPpyrJ7sCI3x5DIjhxuK1WGvkbdG/tzWrVAIi2CQS4DWwz3HfvLU795QN0pEQcFRaSrqjeRELK6pplwfxkzzX3XG810QOMdYAvmsgjcItpE94YREDsMHCrwrIAVppXjqb5dUhupTgJn2FJ/WMW/hO5iBwsvnEtnqcKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BY3PR15MB5076.namprd15.prod.outlook.com (2603:10b6:a03:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 01:07:00 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 01:07:00 +0000
Message-ID: <acabc26f-2d6c-ee74-f99f-58ba3f796401@fb.com>
Date:   Sun, 8 May 2022 21:06:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 02/12] libbpf: Permit 64bit relocation value
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190012.2577087-1-yhs@fb.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220501190012.2577087-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:208:32a::9) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4f48e76-cc18-49e4-d88d-08da31583863
X-MS-TrafficTypeDiagnostic: BY3PR15MB5076:EE_
X-Microsoft-Antispam-PRVS: <BY3PR15MB5076EF54C4C4CB41DDC2778AA0C69@BY3PR15MB5076.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8D9otXjVfPB7MMsap3jwYECPueISJTgMlxeX7l8mTNgQJiYGOV+qfBKhiU6wA8Iqg9aEmAPpwt4bgJXHBSLBhCkHMv1e0f4J1Re7s6akg0eKNvoWdLKnjmKvr8mTRnJhPBBer//W94uYK7KsbWZFg24KAXMiYEa55PpgNbvhxPu7D/XKMw4M+dvMf4qbvLAnxN9avZIgW/n0aSBGjeVKaXantT7aTGCAJPydvVMheHOhaviTzsqR6MzlhCkshyYEOF8DRvrIfx4hpyx/vmzTAKGig+HnSudbOIryhTQs4pBTUY1suIqXhc4TwNO8GDevgaered5mzMLbRq67Jorfl5HsbEODjfYGsXOA29qfEZy8/FBbKSh8UEHRYk7Xh7wCaoYjQt0VF0kidtJNPMhGn0zoGNf0sHCP8h9Eq0xz59cCmFVBfnMDoPaC320WRPs7Zc5dAQfBVckdNWP9MK/vziod+zDYQHH6TbejizTxKaAYeF+2bSfiAQvMy2FzVoaKpvBdy5G9F1RPiTI7Nrprw+HX5u11ERY5kfYDgQTbQnhnBUpkslkUQg61CNoYbvZtBXZY3/dNY+3FsW1MFBL9RErW89wP234lF7rMmKNlY5GUqxs70Iflzka3Up+r3vJ3tE5u0KWD47Oq1adMRGNSm+uOyNjKxX14EvJfMZRouRaLWe6Bx+kzBchWd9XTcaPXRxF1GCY1PHHNigD2V8XIeFopk3UW3k/IqFfcCw/BiEuJTak6WjG/DGabvadtA7SJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(5660300002)(508600001)(8936002)(38100700002)(66476007)(54906003)(66556008)(186003)(31686004)(36756003)(66946007)(86362001)(31696002)(4326008)(8676002)(2616005)(6512007)(83380400001)(6486002)(6506007)(2906002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEk4WDJkRnRlbnhLdGI2SnE4WEVncXR6bW9ZQjFzRHo0VGRrNzJYd0FtMWg0?=
 =?utf-8?B?UmUzaUpEbHF3K2JGVWlhOEh5S2NtY2xKNXIwd3JyRExrY3hxdlB6d2V0VGJz?=
 =?utf-8?B?UXJqVks1c2g1TjNyUU5tejE4V09oYkZpRWdPKzBoZk9mMmlmVzdYUEdYK1ZD?=
 =?utf-8?B?djNTaHE2Zmo1aUkyVCtvMXJ3b1psWUFHdGw5RHhNSk41V0ZXait3OVBUMDZa?=
 =?utf-8?B?ZStEUy96Q2ZHRnBhRGpVZnVTRDdSNENQOWlwWVhVbmJaQXM3WVV5QnNLM05D?=
 =?utf-8?B?VjdyZmFrZkYyNTNxMFhmd2JMUmdnR1VoVldEWi84MDkxd241TlVqY3E2cW5Y?=
 =?utf-8?B?Sno1eXIzb2Rma0srTTVFVGNTSjQ2d1RFS0NkdGFZZUwvdlFJYTZvWUwxY2Ew?=
 =?utf-8?B?WGFGUURXSTY0Y2x4bE0wc01iVXJFMFVISDBZVUs1U2ZwdFpQendGeVE2anI0?=
 =?utf-8?B?Um5xcE10RmduendMbUVuTVRDTGVrNjhLM3dlZGtUUExWdmRDNWc4Q1VEeGRO?=
 =?utf-8?B?elpDWXVVVlBsamhHUnhOSnZvTmd2bDd1aWJZcjF1UFV6bHlkMVFMT1lzb054?=
 =?utf-8?B?QUFCMkhuVmp2QnAwQUYraGNCRXZGcVlYOWNPUTVzVXpuRjR0UmdBWkx5eC9k?=
 =?utf-8?B?N3pveVRKTlVIL1FQZzdwWkxHeTdVMEdIYVM4WmR6WndxZEVQSGg4R1hjUkMr?=
 =?utf-8?B?TnBZT2VyV01LaUlxM2o0MlBRRjM1dWIrY2lKUHF3MFc0czVUejlqYlpFaUQz?=
 =?utf-8?B?Y0t2SkRWUnN2cnF4TEFyTE1jNytJT2NQK2F6VjRrS1hTTVZhOU1OZVphNGdj?=
 =?utf-8?B?ZkR2N3lhYStQakVOR0RJZXRPUGtCV2wwTFlCU1hqOVNsUm1YNHE0WkhISVg2?=
 =?utf-8?B?VWtDOFpLSWNTeVZqdGVPUUlEUTBTM1hLZXRRVHpibzAvMEJqNi9jMng0RVpi?=
 =?utf-8?B?aUJhVENTMU4zYnhpdGp4dldIN1FrWXBiT3B4VFNSZ0ExNWNndVN4bE5uY2V1?=
 =?utf-8?B?dExJNDJsMFVMOUI4TzBVRGhzNjE5MzV0eDlqNG95WmUyZjM2ajVtUHlJK2g3?=
 =?utf-8?B?MjJEajRpMmlwaUphcXMwL2tBL0c3R0w0MGZpMEpKalpRdkFFYmxoajRDWEFo?=
 =?utf-8?B?dmdLS1JyUG9rNVlLYktURTdwL1hjZlMxVisvUjVCU0g4T1ZWZ3pXQ09zbUlz?=
 =?utf-8?B?R21JR3RUWmJpQ01YTE5hc3BJV3pETTNaN0VKSklZd09vanZpeXBCQTlrOUQ0?=
 =?utf-8?B?ZUpTdEhlenczbThjQUhsVmo2ZUF0L3ZJeGZIUkVGOExZUFNhOWhJb1JKaHow?=
 =?utf-8?B?MjZDZGNPZ09tYTZUY3BIZUYrVHRFaFQ1d1V0ME9zU1JueDQvbzRDVHhzelV1?=
 =?utf-8?B?dGRFdEhzZEtTbllHSEhwd0VsN3VUZmdUUnlrcHRkT0VuWk5NVkFmL3JZVDAv?=
 =?utf-8?B?QjFwNm44aDFiRlcxdHJFSXROZlBBQ1pOM0JXYUsvdUs5SVVMZ0dyWnVpRXBl?=
 =?utf-8?B?aDFUbEZ4QkJqL2NHU3FMUlhDcmFRQkg1Ym9KanBzRFRPUkpIZGZoTHZhSFEv?=
 =?utf-8?B?YXlxWFVoQkNibFZaNENIdTlxQzF6b0pGSitCMUFUS2gzL0dreW9YM1pSV055?=
 =?utf-8?B?dndUNkZGSU13ZzZkNGNyZjl5SnVnbWp4WnNuWVNPenp0NVZtajhJMkd2WEY3?=
 =?utf-8?B?a0JBc0xGc2E1djZwSlZTYmg5Wk5XWnBCcnpTNlJ6cCtocS9JVEQwbWtiNEZt?=
 =?utf-8?B?dDl2TFpIVURPNHBLaEl0c05uWEk2MzBhcDZnNmJabkpsMy92SWhSMkpnaFl0?=
 =?utf-8?B?dHdmR3ZULzh4OWxXZXM5cm9SRE9mUm5yenN3cnErSkZMTXp4RjhKQys5d2Zz?=
 =?utf-8?B?TDlXK2JnMmNOcTJCNnRqY3hDNndDZnc5NlBVWVlQUUZBSWtJeS95bEVVMWlr?=
 =?utf-8?B?ZUI2aTgzWFJxY0VlT1BFVTJLc0pacm1mOWwzaE9jRlVvYXRiMnN6aFQ3bWhU?=
 =?utf-8?B?YjV2TytmekJ2U2VrRGdMY3djSWh0UEVFU1NRWEJWNUdSbkt6cHZ4b3RTVS9J?=
 =?utf-8?B?VzZpbHdFZU1kSnJYTk01VFpocmZuNHl1RU1pVEVvMVlwVTdMYVBQbDkwMitz?=
 =?utf-8?B?aXNwUVBnSHF5amsvam5sOXh0M3Nsdm82SjRYUnEza2J1RGlaa3lQaUJjWVAw?=
 =?utf-8?B?UTlVV2FFcXFERENLMTN4aTY5Yk9WdXFnUHZlQWNCL0xVS1V1MkNEZXFVZFJy?=
 =?utf-8?B?YXY2cGVzSWdRSHF3d2RCTEczWnBGK24ydTRRUHlyQ2lmdTNMVGpqUzZoVklz?=
 =?utf-8?B?M014dCsvTjMvdThNVjZnb2F0ZmRhZXlQR1ZEbVFNVVdNajc2T0l4U1RzQm54?=
 =?utf-8?Q?uHDCUs3VyVfw8p1KAaeUaJdO7XdmK+BwVtFLc?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f48e76-cc18-49e4-d88d-08da31583863
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 01:07:00.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJcz/2wDnTOErP5Oieqhf/uZqre/y50VFRDJSKjBt0vQfBAUuSTkHJGCR9ksS8Dntry0b1qcUbm0icJEqba0iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5076
X-Proofpoint-GUID: qSmAlu4ZBWBBaYrCkHvJex31mSdr28Fh
X-Proofpoint-ORIG-GUID: qSmAlu4ZBWBBaYrCkHvJex31mSdr28Fh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/1/22 3:00 PM, Yonghong Song wrote:   
> Currently, the libbpf limits the relocation value to be 32bit
> since all current relocations have such a limit. But with
> BTF_KIND_ENUM64 support, the enum value could be 64bit.
> So let us permit 64bit relocation value in libbpf.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/relo_core.c | 24 ++++++++++++------------
>  tools/lib/bpf/relo_core.h |  4 ++--
>  2 files changed, 14 insertions(+), 14 deletions(-)

[...]

> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index ba4453dfd1ed..2ed94daabbe5 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c

[...]


> @@ -1035,7 +1035,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>  
>  		insn[0].imm = new_val;
>  		insn[1].imm = 0; /* currently only 32-bit values are supported */
> -		pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %u\n",
> +		pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %llu\n",
>  			 prog_name, relo_idx, insn_idx,
>  			 (unsigned long long)imm, new_val);
>  		break;

Since new_val is 64bit now, should the insn[1].imm be set here, and the comment
about 32-bit be removed?
