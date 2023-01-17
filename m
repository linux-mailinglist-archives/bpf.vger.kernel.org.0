Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47A666D6C6
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 08:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjAQHSW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 02:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjAQHSU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 02:18:20 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E2A227BF
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 23:18:19 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H1tDiu016425;
        Mon, 16 Jan 2023 23:18:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=l1pelwaXqNrdn5k/KwU9w+K0fDlZREfebmBrik6fFqA=;
 b=KpIgDmDv3DkLJu6sPgYwjtKsyQIMS6S9+pX+rl+srhJY+s+FwapoWwQ/jljguacsBwq8
 MjYQyuoAFHwu1yPYFthZ1WaX18a6mXzW6elOiRzBLWshcrzCQETu/uwAX7B628MCZAZG
 +m+1OcJS2qSblEwAoLl9CbrI4WrY4D5dNLWkmXRSGlfiiJNxOTWlwkEqKYJ+Dpz8E6LF
 fLHXXxO+UP3AT3kziHW/edvRjEi4sucvjBCL9dvRRddOUWmvvhhKo+ytPIqlLq6Mv1IM
 NRWN0rVpiSwS3Lo3J8Ey0kgWdEvZK9Y+qyljZdafkn5362nNcKNLSppB/CrGwrgO5ezo Ug== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5jdx14sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 23:18:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2aYaJWsMTHxSkFewwWEQJ+tbZtOR3uBIBauW9x5sUuWuU7wGpp9UZIUFq8ZhYCjT3dlJXhVDpsJVsG3HYJwcEx5QUVX2Ta+2Uin4AuyyJ7Aa0+k8FsImBol+iNnv9PmLROZIu2XHcuRNFzgkYkauJ5trz+P3LT+hCXQ/XgJE1Fwa3EKNkrJJ/IpTe613i5xNMlmku4vAMsKxKRw+oHaE0HXB7BaeQNaZaopyextaocbxNPbIaawyOCRkwKw+729H7tPGtDQEvunuc/QdpzMplQHVeZp7xcbrIlfjbOqn+XcvmrKtqPfvGQEpMXYnl6rg9+iUKGnZ83xLRzmX6zTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1pelwaXqNrdn5k/KwU9w+K0fDlZREfebmBrik6fFqA=;
 b=Ah+kixmK36Smx8UlcYUgSFiYwOyvwYUcrtIsfUUiSnSzlA2sp5jg/zsnxO/iuhxmbbGSg30VDpb7Db9lUim1QWPL2EOG75sEoYL6MIC0muFlbMegC6RSpRY/hFwSk3vJhOS3Wz/+6jFJAOLEtqotewmODR8C08iiGG6D0DALxyOaepTYKKH4aFkz/sD2UXBd8qSqNBDtsmflSwU31EsP2pi126qY/UjXI8cy/sAy/4L1kGsaDnApiH5636P3n5FGZBmIUFI0TlPVU6tE6fXlxmktCvJ6k4/lEd5rYEipfmt4OscdHRrRKdLZzZwBlgH39RYpcK+V9tbYY33TROR6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY8PR15MB5928.namprd15.prod.outlook.com (2603:10b6:930:7a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 07:17:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 07:17:59 +0000
Message-ID: <37b0ea1f-0c28-2858-550f-27f89563e588@meta.com>
Date:   Mon, 16 Jan 2023 23:17:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCHv3 bpf-next 1/2] bpf: Do not allow to load sleepable
 BPF_TRACE_RAW_TP program
Content-Language: en-US
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
References: <20230116132901.161494-1-jolsa@kernel.org>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230116132901.161494-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0172.namprd05.prod.outlook.com
 (2603:10b6:a03:339::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY8PR15MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9d3f74-a41e-4c96-20a5-08daf85af655
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQYMtDbkVVhkjO6ZojGdv0O7NegaHdFLMw2RMRTTdmS9FxcvbusBquFolTJIX3LlFO2sDSwcNBzPs6GvnOMj9Ajnk398cvSlFS5WUYPL+aWGTEJiwmvVO/BrMrDqSDW/+wDQSvbQdVX1kcCaiq46n+mQg8efP5uDBP5usnbaAPy50xBv7rnDsXnlpi4iZM6+g4AdtI3QLEyHUIcB371+xoDvpoaP7kESDTPeKqh4/mp6esNdVqOhgQbor51sDL7HJbylSGH9rriFeavy/tse3j4uKly4kkIGMCTHJ6TN/2jo7t1XodRTRtlucFytPkbDxIv+BMOPFydPgRAP+Er5wgudJ4ovPnITQNhh5l/G8M94+mzrScM7jQi82Om0GuSHkj/bdj0kpHOIrxezubA8NtUw+gWk9yAMmr81/NaUQ16KEeuo31EE68n2sFIyiWvqml0lhwk9mdpalN7FQd5w2DCYPVYYsZjIbFNOtz/TdQ/nYfpGVPgO3BumMrCkUMuSTygJmx0PlJ/YBMbdyJx9Ew3KzGde4aFo6dVDEG7au+607sjyocsdinU6kHwhUYV9+tMdmrHb27k+2yjnO7vxyw1YwBcM6FCP4530H9bqNeSvmKG9xzagRW5LYHBGgfFCstT8DV3Ms+KeUJBNw5I5i59KRMVBc4NhTdfcPtXKGYBk/KnwjKnmIZQ1L9mw3ECNb5l0iPKZOiCi3ZZtAs+65taKwqf2PnkBwv7J1V1Andc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(83380400001)(31686004)(186003)(54906003)(110136005)(6486002)(6512007)(478600001)(36756003)(31696002)(38100700002)(2616005)(86362001)(41300700001)(2906002)(53546011)(6506007)(6666004)(66556008)(66476007)(4326008)(8676002)(66946007)(7416002)(8936002)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXhHRVVZeWlEQ1pGRXBWWDFnN0RHVC8zUnEzV0FiVjdOQTkxNjJhcldtK1Z2?=
 =?utf-8?B?U3Rtb2lqNVRBRm9sRXNEbm1jNDJwYXpXQXVFWGhlaXBMeWhsdUVvMWlORWlD?=
 =?utf-8?B?eDEya1JsRnA3OVp5K25hT0MzZk5YbUFEVWtCQmg2ZndwT3ZSZVp2Ui9rc0lk?=
 =?utf-8?B?SmZ0MjROQTBTY3dFUGloSTdVWk5hcmw1NzE1ckV2c3B1M0MyL053ZHR2Vldq?=
 =?utf-8?B?a2FoQ1BMLzlkQjArVGFEekhhM3JENWkvNTZmT2RaWkRPdXM2bXh4emNlZXBa?=
 =?utf-8?B?dGVjdkRadWQ1ZnBQaWRkWVlmUzJTS3VLY2x4UTVMRXZmMEU3Vmx3QW9BVm9z?=
 =?utf-8?B?SnVoYWtabktnQzYwL1hEcVZNaDhnaERYcisxcTJ2QzBMMUMvNU5GSEp1U0Ur?=
 =?utf-8?B?ZjlQdUc3eWhGWFJ5aXlJWUlnbHVneVcwNUlZRnM0clMwbmZqcW1jOGI1R3RN?=
 =?utf-8?B?SGtsSWJtTmNlWnVSQXdYQmlFMFA3aWIyYWI2eVAxZjRsWnQ2UGcyYmtTM2hG?=
 =?utf-8?B?YWQ4UG1NMEE2WktQYWdoZ3ltZWJqMXFmVCtYTDkxQXVrM2FWQWw0bTR0cHVD?=
 =?utf-8?B?TzNxUXlqQS9zMTA5WDlzZEcxSjJhZjlpS1RQYTRlVENyT1RNVTBldDhTUDRJ?=
 =?utf-8?B?eFlLMmtuRnEvdEc2R2NDWVY0SlhSaDFzV0xGMnpKZzRZSDh1dzI3L29IU3Iy?=
 =?utf-8?B?UXhscFBpc1VZdWxVRzhwcVF3elhpYkdXcEsxdkl4ZHRDM1d6NEV5WW1VanFN?=
 =?utf-8?B?ZEJGOVRoc3JQT3pnTnpid3pMYWlWM0NOc29yaEZzOEpFbzFKa0UwNmR2eE1t?=
 =?utf-8?B?Q2VlZ28vVkJ5UzJhZzlHMjd2LzhWYUhzcVRSL1A1WGJCTXZ1LzNyTmRIbjFF?=
 =?utf-8?B?NUUvZWlFamlhVVZ2MW41bmFCQXo0RXJJTkU1OVpSMEN1ZHdpSXYrRGZHUXlr?=
 =?utf-8?B?MDNWNjg1bDZKZGZMTzJkcXdxVkNJL25KcXRiNUdSenkxcVJhaGx6eHhTUnd0?=
 =?utf-8?B?R3YwcGMyTHhJTCtKeEZ1WmxHVkd4THUxcTZPZ1AyUDVpNWxCdHViQWdkK25a?=
 =?utf-8?B?WDJKRzNWeUk2SjNpSHRaZlhVTkVqOWJVemxhc0lJS0RrbWtqNkRBZE5aSlRt?=
 =?utf-8?B?czJjTHhjZlNDa0RkM0xFRno0SC9qMG0zbVVNbzV6cktuQ1FNVUpkWXc3d0Zj?=
 =?utf-8?B?YUxvdGlkWnJ1Q2JuZ0wzVkxkUG1xbjNIWDRRcDN2eEFpTDFQbTNhQlhnRkRZ?=
 =?utf-8?B?UndqV3lyUVZIUXlIRHRkclE3UFZIWjNKOHFBdTFsVFJjZkIyclBrK3ZpU3RU?=
 =?utf-8?B?Q0FQcGViQmFnK01FT3J4cmdwQVRhZnNPNTRxUVdNYXJmdmEwN0I3dVpEVDNp?=
 =?utf-8?B?dW1GajJCaW5rTnlHQk0raGozQTFkRVBmcTdYc0JtV29VMW5LSzNYTmlVRzM0?=
 =?utf-8?B?eGhWY2kvdmpDUk56anh1L0tyMS9yVWpydVpsWXBNSm5UK1Rxd3FoQ29qdmxu?=
 =?utf-8?B?RThKWGpxTUFENEFwK0o4OUFqS1VkUHBHMC8vUmo3Qmdtak1HTHh1cWc0alhP?=
 =?utf-8?B?cDFWL0UyUFR4WUIvSkd1bW5SaFV3aUlJTWpqTHF1aUZTRGtGNWtVYldENEFq?=
 =?utf-8?B?a1h4THRVY01WV0ZRenVUWldZbjNXUnRYMmFJVUhvUm5rcVVESEZPRzVBTUcw?=
 =?utf-8?B?YnJOQWFHRmRac2s5Tm9aUUFqeFkyejRVTHFIVFhKWmYvWVQ4eVhPMkVBbGdN?=
 =?utf-8?B?QWU0eHNudmQ3TkYrUU9oQU9RUTJOdSs3UVd4VmsxYUxZS2w0UnVOTC9Vakc1?=
 =?utf-8?B?VFVUL2dJS0VFNXAzTmc5NUM1T1VUWk1jZGdnU0VxN1krV0JELzZrNFlOYXJU?=
 =?utf-8?B?Mk44NXp5RHhvcjY1US9BS0FBN0QxTExvY1dtRXN2SnB1aDN4YUs4SFpwMTNl?=
 =?utf-8?B?eGNWMHlpMnFjVHlpU1VxSXlXNnNzdkhRTi9pUzVmSEIvdVhZNjVFLzdzZXFt?=
 =?utf-8?B?MlpnenRKQ2pXU1I2VWVEeHEwZlhZa2F6eFROaVBPeU14ZHozc3FERThubW14?=
 =?utf-8?B?NklCL20rdUsycTlPY2RLYXA1N21FVzYrVENRaWNkeTlzNGdrSEZoQy9nT2Fw?=
 =?utf-8?B?eXZZQUkwSVEyTUdyWVIvVGdtM1d1cGJ1UTRkYklTT2tSdEw0U2pzeGg4NG52?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9d3f74-a41e-4c96-20a5-08daf85af655
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 07:17:59.2521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sU1E6VJJogTUv3VxAvXMY8cdKRpoir0jtpLXwrGPIIBRNuLNKvZyPEn8tErmuKSX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5928
X-Proofpoint-ORIG-GUID: n3Ihau0wwp8uY1tcfMm-i5rlMxvqRZsx
X-Proofpoint-GUID: n3Ihau0wwp8uY1tcfMm-i5rlMxvqRZsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_03,2023-01-13_02,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/16/23 5:29 AM, Jiri Olsa wrote:
> Currently we allow to load any tracing program as sleepable,
> but BPF_TRACE_RAW_TP can't sleep. Making the check explicit
> for tracing programs attach types, so sleepable BPF_TRACE_RAW_TP
> will fail to load.
> 
> Updating the verifier error to mention iter programs as well.
> 
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Ack with a minor comment below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
> v3 changes:
>    - use switch in can_be_sleepable [Alexei]
>    - added acks [Song]
> 
>   kernel/bpf/verifier.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fa4c911603e9..966dbfc14288 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16743,6 +16743,23 @@ BTF_ID(func, rcu_read_unlock_strict)
>   #endif
>   BTF_SET_END(btf_id_deny)
>   
> +static bool can_be_sleepable(struct bpf_prog *prog)
> +{
> +	if (prog->type == BPF_PROG_TYPE_TRACING) {
> +		switch (prog->expected_attach_type) {
> +		case BPF_TRACE_FENTRY:
> +		case BPF_TRACE_FEXIT:
> +		case BPF_MODIFY_RETURN:
> +		case BPF_TRACE_ITER:
> +			return true;
> +		default:
> +			return false;
> +		}
> +	}
> +	return prog->type == BPF_PROG_TYPE_LSM ||
> +	       prog->type == BPF_PROG_TYPE_KPROBE;
> +}
> +
>   static int check_attach_btf_id(struct bpf_verifier_env *env)
>   {
>   	struct bpf_prog *prog = env->prog;
> @@ -16761,9 +16778,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>   		return -EINVAL;
>   	}
>   
> -	if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
> -	    prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE) {
> -		verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
> +	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
> +		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and kprobe/uprobe programs can be sleepable\n");

actually kprobe programs cannot be sleepable. See kernel/events/core.c.
perf_event_set_bpf_prog(...)
...

         if (prog->type == BPF_PROG_TYPE_KPROBE && prog->aux->sleepable 
&& !is_uprobe)
                 /* only uprobe programs are allowed to be sleepable */
                 return -EINVAL;

So I suggest to add a comment and remove the above 'kprobe' from error 
message.


>   		return -EINVAL;
>   	}
>   
