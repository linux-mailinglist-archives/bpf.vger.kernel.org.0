Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E786A6369FD
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 20:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiKWTl0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 14:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbiKWTl0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 14:41:26 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C2790388
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 11:41:25 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANHsESf024607;
        Wed, 23 Nov 2022 11:41:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=cG1MQ/ZvYcTq8NL2TZhjbRaFbp6JBE0LGWEVM43WDZA=;
 b=LYAtnKgumRNj2vz88oBfAnB34QSjco3ds3277KHmiSax9t1Ew965Jh9zdPRPL0ro/U7g
 0ARA9g/1Ahra6fHCh35SojA1y2cDzMQ3j35aSCwmscT4yjnM4vm05vyiwM/qoLhhPlFk
 buXTURB9j7Ocg3vImLCjgaue6gT2qyz1ZXTmp9H8qT+mdZfMDKMm6iECgD6jZIQpAViW
 EAfz+luk5Hfyk6CWqlBoXKZikmJLvoHhZ/53vcbJ9xQrrX2hVZQrxrMvEY3RMDo8XSB7
 6B/8hJO8y0bKM1+5kpWXD4vmjK1lTuRdOX68l48EQwwIE7NCHTZpEdbwM4FSfqqxDqKG Wg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m1cg3natx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 11:41:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K04yzrm6gwv7s4fB9bKBLPo7yqBrVoczc9ui4hgpOM76NqITANhPoq2qK7z1IvcgoPyxWQ+oDsxYqY5c01FK1ExgHjCggfF1OuVU6D05OY8OXGIf80Ho6tBk+tbS4/BkKiwTXjY9EriqsMtXDJ33W58T7sb2m4IGzkRm1cOQmcpicjXHMteQv9Ztn6lbYf3a4R0GcxvlH+4MQUBNY7vUM6MghI2gs/4qk0rIV9OoeEzCYrnfvGE6FB92HOqWcRntgHtZw7F5JCCnN3tZnb1f8dmiqVhwvghcl3WVaDkS3KDst/nykWw8byPWmOPmF4UDV86O1zAbCUAQBTVB6PMDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG1MQ/ZvYcTq8NL2TZhjbRaFbp6JBE0LGWEVM43WDZA=;
 b=koaOqdO40ifK8MGqgVfUXi2Hvt3uXbjUVrD9ugn3SSk+/rr8uk4WIn3mHs/SUsZnYwM5tb2QAsQnqZAvlqROMPyMubNna+los0lf3wrSWhB2nB56J2S+2byfNgmgK4FU36/ohUerDvp9tCRr1e6JXtl6/n1ORRf5+OIRfZ815Go5HKgJCIVnkvldujxYFLlLJO7BfizJ92AXZE+qoILXa19tDAMULSvXuox5Xm7YsMjpVIsQwxkwOSX2RPhj1fXy4Xlwy1HfkahCDHdrxBK9mHTWul/AIcjW91n74unY6KLSZKSX+sc/KrFulC81HdHNdrZisCjBdX1tk7nKABw1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3959.namprd15.prod.outlook.com (2603:10b6:5:295::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Wed, 23 Nov
 2022 19:41:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Wed, 23 Nov 2022
 19:41:01 +0000
Message-ID: <707a94be-59cd-32cb-aab3-edfa4601965a@meta.com>
Date:   Wed, 23 Nov 2022 11:40:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next 2/2] bpf: prevent decl_tag from being referenced
 in func_proto arg
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org,
        syzbot+8dd0551dda6020944c5d@syzkaller.appspotmail.com
References: <20221123035422.872531-1-sdf@google.com>
 <20221123035422.872531-2-sdf@google.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221123035422.872531-2-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:332::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3959:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b5b1cc-cc80-44f1-d9b0-08dacd8aa6f6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3LqB8ftWmlc7Qtw+Gl0OmizX94NEYgEOtkYZEgx4JlQP32gQ3gF/xpQQj3JkMFiMWd1b0oMPemOu3mnD98kmFTv1WF/cZozHGg6IWue6MifhnprqucqRjoFCx1skvC10d6js937AxhzzCJgdzBmSZAyLfGOn1nmGYF2pkgJvnH4V+9ZRibWwUIL1MVHKezG98G1qEwuWXYyaaMJ+Mnq6bDTNIMR2Qvdl1qryJHSCfm2ea3v6eYDF1nJSbqICNKCWGogQZAqXq+iW8d7ZeUOTEA+uHObFG7SJ6CZSuOWSTXDMUNYCBF2Gk+Jhgspk0W1Np8rJFFJ4juFhZfdrC2Q7vBH0Ocr5927ZdKfWhX6g12zWIP7HalNdMYuxncTkWk/D5moDBfjZWNoJWIGW8oSXlsWVkc7FljR2o2xqdRB4c9B/cDE+GaBYqq5BlYCA3fGRyZ+fL/HcCALBckz7qgAFfOMbkAFOkkKmqsW+0fPu6OXqK67YcTxVBhrVR0SzWOZW7sIIZRbtIGnXUACOk2LyDqKTaqDn2ql2l8C72mt22SkvB4Vn7jMpkzi2ofJABbe7VmBxRksPPG0AHVA+gJw4mOVuDBeq9nsGNexP5YnLUz6OxfPlIXpFwyTQovW4V0y017YiClvXf8lz5l+PwHN7q5AwGiQ2tV+G7An6niVtB6j9XObIA2VG7I896aZfPFD5saxVpNu9bsPaAkseijEM96MXuPtoGeSwPYDUSM4yNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(4326008)(66946007)(8676002)(66556008)(41300700001)(66476007)(2906002)(31696002)(86362001)(6512007)(7416002)(8936002)(36756003)(2616005)(186003)(316002)(5660300002)(38100700002)(478600001)(6486002)(31686004)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cSt6eC8zbk00SnpuNXdhRktHQmdvRlAvallxNjZRV3FRYjZIZzV5MW9LNmFR?=
 =?utf-8?B?bkhzOFB6dTZQUjdIbUR6M2wwMHdUWm9odnl4MzJ0Sk9VMGswQ3phUVlVanlN?=
 =?utf-8?B?Z1VuempxMXI1a2ZnR293TFR3S0RJckc4bUloWFU4dDcxbXYyZEs1RENzWkJr?=
 =?utf-8?B?YkpzWW9HMnFVNHdkbWhaQTlRNGVWcWNvZFo0OVlSSEgyOUYwNFN3bzJsdDlp?=
 =?utf-8?B?bXEzRnZwVytKaDAzT1JTc0k1SU9KcVlvemlUcHNwbkg3Y2FBaDZMWTJaZHFD?=
 =?utf-8?B?Y1E2Q2l3VWpjcHV3bWYwbkx2dlRlSTVUeUtpaWVGc1pXY1g2ay93bFVBL0tU?=
 =?utf-8?B?ZDF3Qms1bjlhWDJtTW9FQ0taa2xTRWV1N2pBckJmRVc2ekVzSHRHd1RWTlVq?=
 =?utf-8?B?UDd0TDRpQllCNmdMV2F0YXNMdGpKYTdvcHp0c1I0YklmdVVDT21mYkVjMita?=
 =?utf-8?B?TkpWTDlCb3Z3bGFTWnRZK2prSktuWDVxaXdnMzhldVZqUWNGZ0dxamVIcmg5?=
 =?utf-8?B?SHJQaFBZR2dvWExkQjY3V0hrTGlWT3k4YWdvVkxlZ04zNjhiR2g5VUF2NkxD?=
 =?utf-8?B?UE9sRVliZ2RxeVdtMXR4cHBqNnkrMjJDYnR1dHlvemtlejVoUFhRa2twZE5H?=
 =?utf-8?B?Q1d1TlM1QUkvdGZRazlFT1lxMzkrVXRVUGZIbmNtbnF3RkNGVGRnZmtIQzJx?=
 =?utf-8?B?TGltUkV4SURNTkQxenAvendiNXFjUEtOSUt0d0NnTnd6aG1KQ0hiZ3B3dWdQ?=
 =?utf-8?B?Q1NtMXN5c3VhN040TkJkUUwvelJ5RENFWlZVSGZUMlFKNHVmSU1FSVIvVWhF?=
 =?utf-8?B?YzBteVUyQjQvY3REKzl1ZkxQeHp0b2MxTjJKeDBUQmsrVkZvQnEzR2Q3eTZX?=
 =?utf-8?B?ZmNXcDloc2RrMElsZGlhc3FZRm1WcDYvSllXNUNKSWNkcUNFNEI5WFVMU0dV?=
 =?utf-8?B?T1J0aDMzaUNmTFcyeFJ0ZHE2djhsZEZnb2wyeVZWNWZtVVZINzFwTG1pQm5E?=
 =?utf-8?B?NmVGOEF3TVd1MDVxSnlmenRiVC8zSVZJV1JIZjZVTUtFbnlWMG5wV3NqYzFZ?=
 =?utf-8?B?eW5jNExRUzdudEJIOStTd0VMWjZMelJxdUlaeDhEUytvYlBXWkxyTEFUWlZF?=
 =?utf-8?B?Q29hek5mZFN1YTBXamVJVnJFcGpjRHg4UjJOU0tRMktvbmxnQjQ4T25RM1dM?=
 =?utf-8?B?Yjc4L0tWV1ByWERDc3B3SXRPYW44QlRHZlBxQ3NwZVE1UFNyeXEwVEFuUWpt?=
 =?utf-8?B?MXUvRWliRUhHMlp3S3hCdGRzV2w0R3FqQVJYUVE1OE1BU0huR0RwTFYyYlBN?=
 =?utf-8?B?enE4YXRIZEJRR0hPdHZXZk4wbVgwbzBVeFYwcVVscWZUWHBZb2lyN3pNWTNJ?=
 =?utf-8?B?S0ZRQkRjNTByRUxoNnhnYjJ5WWFCSlVqZGY2N2FXUjVaVXl4Nk8vcUltOUUr?=
 =?utf-8?B?VGdjbENkTnhvMHY3THFUdXlUU0Mybm4yQTI1UE9SZ3Rja1dkWDJleExWalFW?=
 =?utf-8?B?TjdPdnZPdFczNEJwUml6OWNKbUJKSEtwUmlESE9hWVdPVWpha25EL0E0M0Q1?=
 =?utf-8?B?M0I2Rk01T2lnMVVnRGwxbUp3S21JWkxzUW5uOVdzRlJlVXdIbGlqZEdRYURP?=
 =?utf-8?B?dGI2WXhGdVVteXRMMU5ISjl6WU51TmtrZG4vTXJsa0pxY0Zrd3kvWTZ1NkV6?=
 =?utf-8?B?dzVsVFpJZlhuMmJza1ZXVXBqUUxtVWpLNVRPMUlOMFNhSHJHMVliVExJRjJo?=
 =?utf-8?B?ZnA5N09lTHBIQUw5ZDI3ZGxlUmVFbFREYTBUZjFHNnozUEVSVjFPcXBhYUM3?=
 =?utf-8?B?eUtaS3cyNEt0ZXV4WDVIVVhaSS9Bc25xMmdiSUYyWU5xQTRacnRDc0ZGcUxX?=
 =?utf-8?B?K0pXOVlPV3RUQWlKV3RnWmhGTjdjZGUvQTVMS1F4SGc1V2JjcFZ3Nm9BM1l2?=
 =?utf-8?B?WGNDNzhFdkRoc3VoSWI0U1p0WjZwRDV0T2pNNGRHdVM5SjQ2SkJVaVlGb0M4?=
 =?utf-8?B?WjVwck52ZTBCVDkyTmwwdUp4NGdXL3JWeDBJNHJKcnNvYkM5ZWtKTG8zY0JH?=
 =?utf-8?B?aSs3ZzdNa2JzTVErRkVpbFBHdDRIZGxaUkZnK0wwRXY4cmdTR1Q0Z3MxSk9F?=
 =?utf-8?B?dDgzUVIyZitjZWYvOFdsZ1BSZGE3L0xUa0F4VjB4VUFoYVgrS2VmZDdpajI2?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b5b1cc-cc80-44f1-d9b0-08dacd8aa6f6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 19:41:01.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZ3t9xtHgMI1HcxOstRUSUjN+DzZNaFcR56aypoh8COshJZtHbdxG/JERpOnRujB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3959
X-Proofpoint-ORIG-GUID: tE2dBI-N_KvLiLRoisBT7jIKUePqothZ
X-Proofpoint-GUID: tE2dBI-N_KvLiLRoisBT7jIKUePqothZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_11,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/22/22 7:54 PM, Stanislav Fomichev wrote:
> Syzkaller managed to hit anoher decl_tag issue:
> 
>   btf_func_proto_check kernel/bpf/btf.c:4506 [inline]
>   btf_check_all_types kernel/bpf/btf.c:4734 [inline]
>   btf_parse_type_sec+0x1175/0x1980 kernel/bpf/btf.c:4763
>   btf_parse kernel/bpf/btf.c:5042 [inline]
>   btf_new_fd+0x65a/0xb00 kernel/bpf/btf.c:6709
>   bpf_btf_load+0x6f/0x90 kernel/bpf/syscall.c:4342
>   __sys_bpf+0x50a/0x6c0 kernel/bpf/syscall.c:5034
>   __do_sys_bpf kernel/bpf/syscall.c:5093 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5091 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5091
>   do_syscall_64+0x54/0x70 arch/x86/entry/common.c:48
> 
> This seems similar to commit ea68376c8bed ("bpf: prevent decl_tag from
> being referenced in func_proto") but for the argument.
> 
> Reported-by: syzbot+8dd0551dda6020944c5d@syzkaller.appspotmail.com
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/btf.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 1a59cc7ad730..cb43cb842e16 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4792,6 +4792,11 @@ static int btf_func_proto_check(struct btf_verifier_env *env,
>   			break;
>   		}
>   
> +		if (btf_type_is_resolve_source_only(arg_type)) {
> +			btf_verifier_log_type(env, t, "Invalid arg#%u", i + 1);
> +			return -EINVAL;
> +		}
> +
>   		if (args[i].name_off &&
>   		    (!btf_name_offset_valid(btf, args[i].name_off) ||
>   		     !btf_name_valid_identifier(btf, args[i].name_off))) {
