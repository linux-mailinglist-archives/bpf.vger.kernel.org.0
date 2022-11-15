Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DED62A23E
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 20:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiKOTxx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 14:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiKOTxr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 14:53:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC814024
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 11:53:36 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFJpOIm002988;
        Tue, 15 Nov 2022 11:53:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=kXc5Y72w2JyiRg6AOaCYr3CJLdk/AWKTF78lduvW+2M=;
 b=hx58RufQXkRITYaz/4SjpzuYn9q/8oXDiSXqsav2zptp0OmpNMmtM1QeEp9CP/3+LVsW
 xDf1va45SaKjVCnqX5GLMjx5HtUNhQhgT3la8Cr4mHNOr1Cf5/Cadoh8xJ/qfH7AB1r5
 uuEyn/AUvYKjecOpfYDkkRuJABno9PMab7APESn1fNtFB1Veea0RAApGzjy/fuHKVJRi
 FIUREEDXchTtQMBaIJDHuKhfrHzdcteoDmYAM9vFRrOjqQhWLmwXMHcJzXJOrG8/gyI0
 EcrdHXJTBhi5bq6jwaSsw0KJ9CKLrVhxNbd/JfPxSkdkdP5I4Dj1+Haw1P0gWmRu7sPd yQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kveaustbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 11:53:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl7mqVaLrCF2dIQmdV+RHxfiX4kAoX1L/uEJW5M25pYTR0UdBZcWwHv8i0mkN5S/WpuIXs2XNtPwAFWr5JZ+Af7SAS92aD53ulHxC4gHtRPVd/fvpCB/2aB+1uJ7TccZap8EL65pXiryySv35g28gLVuAvWBPBdkg3bKojSPgZvkL3z44ZB3lJggEQRf3EPP6H6OlacC6oEquYpUnnOpwAWNP9h5KGSnr4S3d/rQ4xYBqNAeadl+6pNwfO3Q522OtjT1qc8z6h5GJnTOHyfT+NOvAZAFn6z1TVr8S4O9YF56zfSkYtXtjaJ6vWeAbDSR4Kl+q7uD1L7dmHsWv/deOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXc5Y72w2JyiRg6AOaCYr3CJLdk/AWKTF78lduvW+2M=;
 b=ZXOkF6fEVkdzdb5Z9qOGvOlWLvlQnjogiaR9jcSdTO1+jvyT/vv/VEINMeJUTF7i3DMZstrPek1nvlHUlx8ekCdG3vC9pXGp4DKmVgvfAnV6ja8t1yQYhG95mE6T1CMLhaBxAN7ALEaEOaQgkcyilHS2ALwB5aGYGf/e3s4tWm1WqJ2kxMugy8Rt6o57DmN4X/bVHyWeZBbN+wSTmPW2lwUUWyAegkLvPxsnSYohtmHDvJuGpDeRIOq/9W2piMfpLEen/dYdUCEZp7q86KG37DTIFMCwOGeuZ3vxrFIPafoaUXb/7z4FqL5oF0E9jbC5dJX8KTFZ+oHBIGZevlSg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1314.namprd15.prod.outlook.com (2603:10b6:404:e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 19:53:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 19:53:18 +0000
Message-ID: <e0429016-ea8c-2ffa-698a-3a252eb4545a@meta.com>
Date:   Tue, 15 Nov 2022 11:53:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Implement bpf_get_kern_btf_id()
 kfunc
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20221114162328.622665-1-yhs@fb.com> <87edu4i3j7.fsf@toke.dk>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <87edu4i3j7.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:217::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN6PR15MB1314:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a43e13-70e7-45d1-9ed5-08dac7430ab7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSW5gi1zBLxbAWuSy6UDLhdnUL61LAHtv6OqaEuanAs5FrUOZjV4KXO1m7twXzCXG7njMhthj5hZI/oKiS+xQoH5aHMeoENOsPmjz/pFgsSHoyMcpxkkK66SQFokluMd8c+oNyb2rPpe9BH+OF2JUN8N7AUxuI9KfSMhjZNNoD1fOQ3GsJkIaeTWDBq0Ad0L/A9VQ0nn4JMtOJjTi+FRvD46Q5eM65zVH3R11VAYvNekHvIqztXG4wf/myjm6u+Hy1c9ZDit+EPUjSpNOKu1O8BeAqsNN48dfJOtkTi75FePnxYUZDK+MiW6rBVnyvWZ6soD5V7Tjf+MVAls1LOxzAt5gfVlRlm7uztB6vFyIFPE+Mek2HGx+k0fevz5IxmPi4zKnKgAemjIRpij9Fw9WmS0I7zqL+xBAz6BtC3+DLVlxEMBSw7bO/ymM6HlP02jxgljSvZ5h3vs2F6P+tS3kQU4xYyzshJaivZ6bFR2NbojDyuB/cj3Yljwt6EZzv2KzWBm7GpkAkMNNdwBHC2XZHjjrlSl4IF0Fs1vMt7LNqYFpxjeTcoeAJ9yvyzFAwW5vNqAK/On2OgU3+zrarGykPwPE7ZtccXAcGTkZjeio1abA49xFvf622O3JyQhoTRQ15La+cK13YkiixAN9csPVvfbSxnYQhcxsw7GnH5L35wb3fTNYh7i5eM0LZNPHHdhk//R32XnvoTWc2mjJ9eoZnW+gvApdo5K4D4XZ1SNiHMlftRF74ZmJvIoEph791kGCnRV0WRKaE3H5TRCSc7KHbUoNqNBvPwNSTVMbRSyveQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(66556008)(66476007)(8676002)(66946007)(4326008)(83380400001)(36756003)(8936002)(41300700001)(5660300002)(66574015)(2616005)(53546011)(6512007)(6486002)(186003)(478600001)(54906003)(31696002)(110136005)(6506007)(86362001)(316002)(38100700002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkFwdVZudysvcngzSUJKRnhlOENoMnFkQXVjOU9KT1Z5b3c1Q2EraTVaampz?=
 =?utf-8?B?L1liVjRWaVB0SmxXRG1rSFJZWSs4RSszZHlpNU9LS0lPbEEzMWtQWE0vVzRR?=
 =?utf-8?B?L0xRUVh2OW5zQUJoZmxyTG9uUFVKV3ZrOUgxNDR2WTZTQWhXMG5wTmpVMkFx?=
 =?utf-8?B?OVI1OVVuSzRjK2tQWk5OWWh4QUZzNlI0RXNuTXc1aHBBVG5QOXJRanIyZ3Vu?=
 =?utf-8?B?dnFJRUloRlVRMnVlby9LbmFERWdkTXVYQXFEUWE1K3RUK0lwVWlCUnZiUlUy?=
 =?utf-8?B?enFvNW5PdXFoem9jMVMzZUVWUU1ualMrT0NiQWRJZk10WDcwalV5eGVvMzZO?=
 =?utf-8?B?SzM0ekFYNWNLK2lmYmt3SHo1d0t5RGdZQnhpSmpLQVhieWtyeEg4NEhVbUFW?=
 =?utf-8?B?Rk1Ibk1hRU4xdWVZY1ZFekRSb2dpNENJNU8vNFNqL3B6d0RiTm1MZTRLcjJ1?=
 =?utf-8?B?VEtjMVlLbENtS0tCUnlsWGJCeTJxTEYzQlFhMzNSYXBjZENYMjlISTl3QVRy?=
 =?utf-8?B?LzVWWVY5Ny9EQzc0amlWWndEYm1aUjRqMC9GaldlRGRjSThWWUNKTFk4Q2J2?=
 =?utf-8?B?d3NVSjRWRXNtc1RCWHA3bVFwWGExaVpjbVUyNStvQ1RBQWNzOVF2WC9sQVVp?=
 =?utf-8?B?a2FBaU01SGNYZE9OZ0J5Zm5uL1U5V3hMZ3FXSTZaRnAvQURYUDR5blljTVFr?=
 =?utf-8?B?QXUxeFk1RUJVODg3MWZtV1lRSy9pNjhuTklkcHQwMEFkb2c1dEZaUWR5empX?=
 =?utf-8?B?ZGgzNUxyaDlVY3Rmak8xV3l6K1dtcEVKS0EyekpraGhua1lhd2lJR0p6NDJ5?=
 =?utf-8?B?SGM0U0dLM3M0TENKaStZOEhSbzIveE1lQkRCRUFRd3AxLys0Ni80VFdTRzlD?=
 =?utf-8?B?OWE0QjlMVzdFYkpMUkwwdkVtS1VFa2pSOFR2c2ZRWlBLeXpTNzRYdmU0WXUr?=
 =?utf-8?B?Tm05bEFXaVR4UGNEbFZ4YmEzTFdpc0QyRmxtZzlpRlh0ZERYQVduMGFxeS8r?=
 =?utf-8?B?VDYzb2J6WngvNTNwRUltcXVqVUlWRmVRdjR5NSs1Z0tESU84Skh1QjI2aGhX?=
 =?utf-8?B?WE5tZDhjbGhCZXFGTGZSdjh4Y29ldzRzYUxFb2ZWRFBPb2dUVkVrc1l5VVpm?=
 =?utf-8?B?UU50ZDdUcXMyN29rRmxSMXV6VVAzUnZBTE1iWmpYOWFnbHQvdjA1alNxUnRv?=
 =?utf-8?B?Q2V3bm9rR2hWUUV3UXFhVUJhWmI5ZVhoLzB3ZXhIZ1FVUG9NN0FKZ296UERy?=
 =?utf-8?B?UU5hZGVxNzZpYU1vMk1GYkdKM0ZKWlZMbnZZNjdZUGV6dVRaeVovVzhCbERF?=
 =?utf-8?B?U0FBeXQvVlN1ejZvaldCbVVySjBUVVRxMVZnSC9OQXBkbnpWc2VjOUJsRVQ3?=
 =?utf-8?B?bFpYb0p1aUkxdDVVMkgwdXZvWjhlazhpNkg2RFBJM0pXeEpjcUVRa2VxWWZ6?=
 =?utf-8?B?cmhpa0pFMkFVUnRkY2VpOHJOOHIrbXRjRFVUb3pNTFpCMDhwenE5cEY4Q21m?=
 =?utf-8?B?eWMzUExlZjM3VWhEcFRWSERzQm1LRWRuYVRXRWlRVGdiYVFpZytob0QxdzFS?=
 =?utf-8?B?clk3WlhuUWN3eWNlQ3dZbXp0ZmlkajJZNVpsVDdhZFNyc2FteUlKRlk1c2FT?=
 =?utf-8?B?WEJJT0p1QzF5dko5d1daRENtZmF1OGUxQmxpZU1pb0dETytmOEN3U1dCa0xi?=
 =?utf-8?B?TUlBZ0dsNEw5RC8vTGRlVTczSnhBa3NMUUY4Q0xVSlIrOWtnTnkxemFpaTJM?=
 =?utf-8?B?ajRpcE8ybXliVEJSTDRDVjA3VlJVOWhDVXNmT1ZSbzAvc0JJVEpnRmVlN0Zp?=
 =?utf-8?B?YitNd092ZnJQdDRHdlU3NkVDYkZpTVNLTkJhZlZSamYvWDFFTGkzSGhZQXNl?=
 =?utf-8?B?TGgrMEZoTm1BNzhndEtHOFRMaW82clF3MjFDbVgwL2h2MHgwdkhRUDU3T3Jn?=
 =?utf-8?B?dVo1SUVIVWJsUWlZRW0rREVXTFdWMlEzN0lGK1hMV0p1SUJoVitrUllIODd0?=
 =?utf-8?B?a2xHbjU2RnBvQjIwRnFYaDdDM21Ca3hrY1M5R012Zzk3Z29mSW9Rem51MjU2?=
 =?utf-8?B?RkFmbDlxbUFuQmJhcExQQW54Sjg1ZVprS1hqUG9WMjNzdXhBMU5KeTVydG90?=
 =?utf-8?B?K0xWWk5lOGcwVUxOMDIvbVJENkNUV2Evb1dkdXgwbEpEYUV5ckhRRS9ZelZB?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a43e13-70e7-45d1-9ed5-08dac7430ab7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 19:53:18.4451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veo2F6VdQc6w8Sqt3tEXjMC5F2v5aUnF5Dx76J6+iMi3b+YLs4O4VMG+zymQLNtN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1314
X-Proofpoint-GUID: LEHvu5taosBZ-qY7GU4dANdgOuxuG0sS
X-Proofpoint-ORIG-GUID: LEHvu5taosBZ-qY7GU4dANdgOuxuG0sS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/15/22 8:30 AM, Toke Høiland-Jørgensen wrote:
> Yonghong Song <yhs@fb.com> writes:
> 
>> Currenty, a non-tracing bpf program typically has a single 'context' argument
>> with predefined uapi struct type. Following these uapi struct, user is able
>> to access other fields defined in uapi header. Inside the kernel, the
>> user-seen 'context' argument is replaced with 'kernel context' (or 'kcontext'
>> in short) which can access more information than what uapi header provides.
>> To access other info not in uapi header, people typically do two things:
>>    (1). extend uapi to access more fields rooted from 'context'.
>>    (2). use bpf_probe_read_kernl() helper to read particular field based on
>>      kcontext.
>> Using (1) needs uapi change and using (2) makes code more complex since
>> direct memory access is not allowed.
>>
>> There are already a few instances trying to access more information from
>> kcontext:
>>    (1). trying to access some fields from perf_event kcontext.
>>    (2). trying to access some fields from xdp kcontext.
>>
>> This patch set tried to allow direct memory access for kcontext fields
>> by introducing bpf_get_kern_btf_id() kfunc.
> 
> I think the general idea is neat. However, I'm a bit concerned that with
> this we're allowing networking BPF programs (like XDP) to walk more or
> less arbitrary kernel structures, which has thus far been something only
> tracing programs have had access to. So we probably require programs to
> have CAP_PERFMON to use this kfunc, no?

Make sense, since the kfunc is to enable tracing, yes CAP_PERFMON is
a good idea. I will make the change in the next revision.

> 
> -Toke
