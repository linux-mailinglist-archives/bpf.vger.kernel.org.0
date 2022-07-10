Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B72156D043
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiGJRAa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 13:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGJRA3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 13:00:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D911EE05;
        Sun, 10 Jul 2022 10:00:27 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26AGQ1an027784;
        Sun, 10 Jul 2022 10:00:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AX3sZpld4uZNIJzc5NvoxAL2yF1mCM67aB8Jo92vJEU=;
 b=mUMuYeDNDW/kql/AK1EpHgeJkds1njyCtGRX8KacLpclhr6kP3MVf30LdDEHiT2yB0Gp
 BcN1Za/ghxv2JEcYEChJEAwLWMVLO5An0LvJNcUdqSDDQnK4arfLWbDLshcaGmA6AarP
 b++4EKa8/HvIZ3h1L0/QLSIRHLa4xOL28CE= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h76srcwna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Jul 2022 10:00:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkswRwpyVID6IWdF5Z66pMfQvP1epN348jUW4bVYoYsuQ4JlWEDA1fyXg0aljodJcBCPTlp9FLXMkNCj9Xt0E2VHX8edxNIOts0B1VHrN4pZAwB0TSoe4ueTdhizd0gD2dUTgiJL4//qxyhSb0jjncm6GEIF4XUSYvVgX1z2Xvbci9SYwxO716yfzt7uymupCPslRkXdhOm6cEXmj42VAWiZtdQ8Qr5FmFTVYfeWW1Wky8jDtpkVMllRg5eM0ICZjz+8gerb7Mp/aeZRf/I2H185Qyds/Y6YrTn+JPZ67faTZctzSjd9n7YVu+Jo36IU/7UetaG6h8aRzPBWMuvXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX3sZpld4uZNIJzc5NvoxAL2yF1mCM67aB8Jo92vJEU=;
 b=TGXcjwNNeSFbKSfYSQRFPOr5vNdhl+mjPTkwsNS+OBOQKwZxcp+1S3kpi8Us2ZxtCp8TmAWoMHyVbhs94+uKS3RlDwWhvaMVKhqFyqgwvQ5SmSswgGGWeyPSnQxe60FVUOdYeYr8LhhE4QBRy93jqxZ4OU2WLNBb7fgDOrXtD+xKII7zlHJ1mC/6jzYJtMZfxWSNXqFQBVtD7QanURrGUN9FMe9YmIxucG9vMvv+ZnrV7gTwX7t7GZFNoe45pSuzhHoSVwogi0rTgLvYI5vsbaYz8UzDKTSZ9l9XDOXpR/Ne9vI7eG2FolaHtMvddudXl/OEuWV6mGmUJG/KWR07pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1286.namprd15.prod.outlook.com (2603:10b6:903:10d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Sun, 10 Jul
 2022 16:59:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5417.025; Sun, 10 Jul 2022
 16:59:58 +0000
Message-ID: <fd51d0bb-8908-ede1-6d7a-37ed82badebf@fb.com>
Date:   Sun, 10 Jul 2022 09:59:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] bpf: fix 'dubious one-bit signed bitfield'
 warnings
Content-Language: en-US
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     mptcp@lists.linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220710083523.1620722-1-matthieu.baerts@tessares.net>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220710083523.1620722-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a15c58f-a34a-4ecf-c502-08da62959ef1
X-MS-TrafficTypeDiagnostic: CY4PR15MB1286:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdWWaqMWdh+wxwMc1x+r4uye8nnv2ieoHzAiGzDITF0kViyIZiYDL7nyQn1QIhQwkJQsSJOVO1PgmgfvTsneqKc9j7Uo8dZtKu6X18MJqkxaTNCH5cM7DsOA3MAbu/T1jsxx+ptO87ky+cQLqiolMlpf75S0AtflIBF1iIcaUi/Yw3AAj2RRBe6hNKlR4/+SkheyYjJ8+NiVwh0yUavpG2yenoAAxseWmK0duGvsB0M0bDUL0zETvWVt5A7CLtrojPpfQ64DlHBmWYi+JFoTENxWpAK/utfOWIDM+IjBPoxzhCJaakhsG3+LhHG7bFer0NBf3Qb3EC6Q2e+wn9r82aOYPZ3gDRlm1CWLaFyFSdAKQd6gPKn6fhN4RXre68b/fm2iLn3Ffy+h0lJAs2ILpqfvJMcJsL9nuR4J12ICHrbyIvjzpNlgx04DZiZGC35VhvZ+msV0BHYgup5wiiIqJa/n14U296T3VzrNRtiGvYEbU37GOlj5NAZgG1HiEV00m3cpui79MthGpt6ICH20rxN0KNG7DsWnx7Mad91xztifXwLirVt/wJuOgalWDj7Rl16vU41L9W46c+K824HDKYgT/C3v729UVtpXtwsWNzzelhSnphf1uoRvmCic5RUVmylpdbI2+B6/SVJ1N4AyF9b38tQkq9MBVMbh1nHQ+Gh3sY52D9q1h8F2PZBhVv7a8OlXTCeMW7Vo26THrJhDxg592MbmBjxzILlINfHQEgW9TAEvXN7G65p3kPCUj1wfFIrTwPIx0GP2gnVZ27l/QJFZ710MeF8kkKOobbe3XhtVWOywvZknUAbdwg2iVhMEtBJX3XmlkMwaeYqrPCosabdMQQgQUg7Cav8AALt5nR9q3cTK8Q08u1ZksKGp5Zpd2/scDsjWoFZ5nArbRfz7lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(110136005)(41300700001)(316002)(478600001)(6486002)(966005)(53546011)(6506007)(6666004)(2906002)(4326008)(8676002)(66556008)(66946007)(66476007)(7416002)(5660300002)(8936002)(31686004)(38100700002)(36756003)(921005)(86362001)(31696002)(6512007)(83380400001)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0U1aHFPc3pCdmhnVGk3d3QwQ2NkRkY4YlpHT3BGV24wM2tuczJyTW5yTjBs?=
 =?utf-8?B?TUFUU2hrb1YxcEUxSElDUFVHbExRUTRnaXVQQ2hPWXBDTDgzdTR4cVk1RlR5?=
 =?utf-8?B?akEvSk5MYkNoRE5aNmRUd1orQWhwWDNoY0lxQWN3QXBTcHl2cDVtVkdsOXBB?=
 =?utf-8?B?b1JMVExZVjFiNnlFK0tLS2pycVlkSVJFU2hYWEN3Mlk5bnJjWUtGWGgwZlA3?=
 =?utf-8?B?ZlgwK0RBNFpkNlpsNGh1TkJoNUpmSEFHcTdrVDJNb2NERVkyUThoZFNXY3lM?=
 =?utf-8?B?UEpnRXBQNk5aQU0xdHNpSDFkRG9tUHJ5RjAvSWI0bmpRdWdnblZrc29SaGUx?=
 =?utf-8?B?alRaZHQ1NHRRS3FNN3FLWEY2eDAvTWhiVHFXNWlLWkNaSmx0aHNidWFXREd5?=
 =?utf-8?B?SHZTT3BsZ1ByUTA5aEliWjAyUGNDeU5Gci8zcHJGcjJ2Si9hajVuTHRKSi8v?=
 =?utf-8?B?dG1LN09QNkN5UnY3SjJsMzFOby92L1g0bWtHUWtWQWlpMWt3S3ZGRG1OR0J1?=
 =?utf-8?B?QlF1eERBN0dmMk5nVDBVa1ZJZXVEWjhUQVlPbjFJc2tkVFZMOWoyNlgwK0Rw?=
 =?utf-8?B?cXJlSk9lcGhsRkRINmxXSVl3SlRONzlSaWdzQXpadGhicDhtbGVJU0VxSkJC?=
 =?utf-8?B?M1AxRnhabEtFbHVMYTh0NjZtRkxCMkd4aTlaRzRJSzVPUWtCKzhnaGpmanpq?=
 =?utf-8?B?M1l1cmJvcXRXd0FnZEZYZmRvUXNLYndQMjBTWTFYaXFlK21mNlU2QTd2WDF0?=
 =?utf-8?B?MTAwakV4Ly8wYm4rbFpPNTZPVUxBQ2R4dDFCU2psc2JxSjFnYm5STkVKVzlH?=
 =?utf-8?B?czBnMGYwVWJiQm5mV0JZR0RIeWk3dmFIcXBMVlJ5NXM0TkRuRVUyTTNocnlz?=
 =?utf-8?B?MVBqaUpVM1BWWmtFVE9yOElCbVZsaVhVOEUyR2NHS3FZd0tVMnhvK2V1UU9I?=
 =?utf-8?B?VkpabVJOSXl2VHhBb1FFcy93cU9TM2lkN0xLUlBWUEZFcWgzV2xPY1N2ankx?=
 =?utf-8?B?QkNTWGp2WFNDV1dxRUkzN1JEOFNYOWhUeDMrbmtaRS9jWFpKU1YrN2FxUzcy?=
 =?utf-8?B?UXhLSTkxK1UrL08rUTNxdlpPZWFvNkpiSmRUOEY5QnpENGhTSldDb2JKN3d2?=
 =?utf-8?B?VFZqMkE5dS9WMU9MNTA2c242cVpYejNOanNIbFdMRi8zdHhuSmd0akMzSm1q?=
 =?utf-8?B?NXdwTGVYeHJGVGlycUJXMzNrVUlCWTBoNmtOWEMxZTlDeElsTkowdnJzUmNp?=
 =?utf-8?B?a1BpcGJIVm1XVnJoU3RkejRqVEZjdXBFVmZBbEdtTzBaWTBkNG56VUxHTlFh?=
 =?utf-8?B?b2J3ZEg0NHhpRkt1Z0gvZU11VlFTN05pY3ZsRVo4bWk3QnhUdHcrTnFmaWVD?=
 =?utf-8?B?MFlzdUVMQzBXZDROc2tTV1dnVjhodlliczB0bEtscFlnUHNRS0xWRitrbGZr?=
 =?utf-8?B?UmRsL0RaWElTYlI3RGlSbDA0dk9DRTZYUnFBNjZXLzY4VmdyQVNTaFpzNlVT?=
 =?utf-8?B?ck1hWlVBMUtVMTA3cEtZM2tjQnN0WXdGRE51a29VaHMzcW5PakxmVWU4dC80?=
 =?utf-8?B?Um1xZXR5Z1E1RXlxa0hjaEU4ZmNpeGV6TlVlV1RrK3RKSlc2VStGcXJ1K0Nn?=
 =?utf-8?B?VCtFRWk2VHdhQmxZaURZbmthSXBLREQyYTQ4Tm9DcE9za0h2WjVVWU1JUkYy?=
 =?utf-8?B?UUEzRnpId2VudjRFQnBvWVgxN3kyZjBhd3lyODhDT1BReDlWa3dBQUw5Mk5Z?=
 =?utf-8?B?d3NIZzdVNlFYN0tJcHBKdzNXdDgxOFM3NHIvRkw5MHVvMkdvRlhZMkRoM2tj?=
 =?utf-8?B?dHpYMS92N2lLSTNhbnhQVGFxUlMrVXgydmFwWENmQmZaZWZ2OEFGb1A4SmtI?=
 =?utf-8?B?YzgyRUxnQzVHSGZLRFM3OGZTVjZ6UE93NTJ3RWdRRUZuVlB2MHY0TWgzTWkz?=
 =?utf-8?B?T0NHeERDSjlUd2E3VGI1eENJREdTaW9tanRCbG9LOHp3QXU5S3c5dC9TVmNS?=
 =?utf-8?B?Mm5pTEdVN2Q0ZUt0Wmt1ZGRXaDRuRjBjNldGMUViQ29zVXViU3dLUUVXQmY3?=
 =?utf-8?B?M1BKQ2hSOG1MY0tnQWRoa1k3YW9XUXZ2K1laZjF5RVpuTjY1R25HekZ2Q1dw?=
 =?utf-8?Q?oYJsZGJmHILU4hOwiZUH8uScB?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a15c58f-a34a-4ecf-c502-08da62959ef1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 16:59:58.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: demNL9tmqSMIIbYp9hm/NpWbXhoysZF84vDjQKZ8CX67RR45e+BLKD1wEGgD/5ug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1286
X-Proofpoint-ORIG-GUID: sjn5eaFYbM4GF8qj2ySWGLVuDGk0HHh_
X-Proofpoint-GUID: sjn5eaFYbM4GF8qj2ySWGLVuDGk0HHh_
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-10_17,2022-07-08_01,2022-06-22_01
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



On 7/10/22 1:35 AM, Matthieu Baerts wrote:
> Our CI[1] reported these warnings when using Sparse:
> 
>    $ touch net/mptcp/bpf.c
>    $ make C=1 net/mptcp/bpf.o
>    net/mptcp/bpf.c: note: in included file:
>    include/linux/bpf_verifier.h:348:26: error: dubious one-bit signed bitfield
>    include/linux/bpf_verifier.h:349:29: error: dubious one-bit signed bitfield
> 
> These two fields from the new 'bpf_loop_inline_state' structure are used
> as booleans. Instead of declaring two 'unsigned int', we can declare
> them as 'bool'.
> 
> While at it, also set 'state->initialized' to 'true' instead of '1' to
> make it clearer it is linked to a 'bool' type.
> 
> [1] https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2643588487
> 
> Fixes: 1ade23711971 ("bpf: Inline calls to bpf_loop when callback is known")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>   include/linux/bpf_verifier.h | 8 ++++----
>   kernel/bpf/verifier.c        | 2 +-
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 81b19669efba..2ac424641cc3 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -345,10 +345,10 @@ struct bpf_verifier_state_list {
>   };
>   
>   struct bpf_loop_inline_state {
> -	int initialized:1; /* set to true upon first entry */
> -	int fit_for_inline:1; /* true if callback function is the same
> -			       * at each call and flags are always zero
> -			       */
> +	bool initialized; /* set to true upon first entry */
> +	bool fit_for_inline; /* true if callback function is the same
> +			      * at each call and flags are always zero
> +			      */

I think changing 'int' to 'unsigned' is a better alternative for
potentially adding more bitfields in the future. This is also a pattern
for many other kernel data structures.

>   	u32 callback_subprogno; /* valid when fit_for_inline is true */
>   };
>   
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 328cfab3af60..4fa49d852a59 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7144,7 +7144,7 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
>   	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
>   
>   	if (!state->initialized) {
> -		state->initialized = 1;
> +		state->initialized = true;
>   		state->fit_for_inline = loop_flag_is_zero(env);
>   		state->callback_subprogno = subprogno;
>   		return;
