Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B332E4E7914
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 17:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbiCYQnW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 12:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245627AbiCYQnS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 12:43:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25950E09B2
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 09:41:44 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22PGYa3p027120;
        Fri, 25 Mar 2022 09:41:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sREurQAyate73vd8kN0ICQMUe+d0fkIvQc85vZsAd9A=;
 b=iMGsF2v8T3nFL97Y6s47Y4YpmSICFlhNW9beaRsJJIz7ZH6hjEQsqUvN955tPYi50rT7
 /bVReYVl5SX51qSr7C84GnvaZ/GNZejQ7aMzUWa3PlUkVPhqNiAdxjMhfRdEVLSGaZKs
 Zs3dnA2057xp6OduIegcBLKIInGPDBmWJuI= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f02uwcspr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 09:41:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkpWfRLmvaEg852Pd6alQwoleVa3QP4I1N8/BJGSkNj5TQT8XR0ELJ3L+7pCqke9T/kir4Dz87AGSoJWj37H8cJEYpaB5Ad97iTDYfBIgK3+6JluRhe8PEgBlIQy2cnQlQ1Z+YufgOqI1/nUl4WqDWc7OGYaE4hd7q2/iGXjKQJYJ5i4UWlGrb00HL/egx9+nz1ys1lA0LJYAf2cVmNlfERIa3t8425vsnyXreRrCXulOM4AM/PsKPkMrzMamzAxAPfVfJmv6OHcgwb30pKMuJVz/BbGCzZP7pXNtkUg8qWoKTuF+V5dzc9KVxLMjeZqQdaiLRaU1guBLRCRaZiAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sREurQAyate73vd8kN0ICQMUe+d0fkIvQc85vZsAd9A=;
 b=drpbMZjsFWktxcpOcVWj0/pG94U182tQ0Qi1XJYaN/mgNjIFLtSys4tOr06s1C0qYUhiXRqADu1ah5s84RWBuFlCeEHBbPdYkIjnaY/z6WYVPUEtz+zaNZhklWTQNaZ2Z+Gh6qrUi6VSLGC6jkc3pyNy43OGwsdEti33qQFQkstQo5xLe2KINDMd5r5B7O2F92Y92L8Y+7CLwBvAOjeyHteTdpNBkR3wBFadGGHkWLwnX0u8iy/fsTMlXkAEO2Uo/DDjpE1S6kpMHNRkohqi2gNjWLpWl6abVKQ0FT+X+qDkMR1v1lqvzgofIyxLo2r5rdLXBVeZDlFfv9yZUJYZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4644.namprd15.prod.outlook.com (2603:10b6:806:19f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:41:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 16:41:37 +0000
Message-ID: <1e206112-c610-d4e5-1ab6-e78ea3e2dcea@fb.com>
Date:   Fri, 25 Mar 2022 09:41:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] [PATCH bpf-next v2 2/3] selftests/bpf: add ipv4 vxlan
 tunnel source testcase
Content-Language: en-US
To:     fankaixi.li@bytedance.com, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, andrii@kernel.org
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-3-fankaixi.li@bytedance.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220322154231.55044-3-fankaixi.li@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0383.namprd04.prod.outlook.com
 (2603:10b6:303:81::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd3c5ee6-68a7-4a58-93fd-08da0e7e54a8
X-MS-TrafficTypeDiagnostic: SA1PR15MB4644:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB4644D3821EE4FF6C2749C6CED31A9@SA1PR15MB4644.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHyxCN2FGQQp/Q7Sx/TcNXxLUjgl0VLzRPjOgX3Fjpui3kI4jSGhxthoJ2ty/REel5bUhnLKxxeGTLaHYXsoieZZNiAxMDhNqOPATfSXJt6DqbLPNvAKZVhCoY91GkkdyJ9+9lGCWMgny+U50tnZgy1C8CiBndv9C8ycx5xqAqaH3uXHRlBXx+AwJkSugkRWMI0RLurdTbQKbf4YqbDTZf64cpxTbl4GmJjS6XGRrQHCw0Ltwpj+eyymVDJhSITrjgp7V+7J/8j6ehDVkSzVWZg9yO7Hki4yT0JY+vvfn1/Bqke3sMuj/ap9GzS4bXh7eo3leV9sM2CDkAg5svz+0TnDMYflVokr+DSUZfNrWBCdixN32mWycM9gnupG+7wZVYRCyfB+1ImIB1SBLfwdDfdd8Cp9DWoJhpuLfldzfFKp8HV0jIHqaau+HM4Jk7BOEs6kdexWQe0H1cx8JY8LHbUZl44nlE1ZPQD6VyMEVodemHAE5RO9C/IEceh37MzDKqMr38Y8yU3NtkhuPKMcbyMYrCi1iuOnXvl6pNTKosvdjKaSamRXLEcFezX+IGtgSHIhVLhn7K6g82zZtOJWq3rgF+pj3NsfnocQSv/dEXolxx4J6lQf9oYUQ0vUK73zsks/Nsn8W7gJX4adlqU9b82QaYLEh3kyuVXiS2NWWSLqtDQzUhtSUUKVazTsQ4X6ADgbJgWDB4B/XIf6Pd/Nw3nm7chdAVioWcuSRx3ulLdgCL4aYaa3zDtOoJIKSzsr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(52116002)(53546011)(86362001)(4326008)(316002)(508600001)(31696002)(38100700002)(66556008)(8676002)(66946007)(66476007)(8936002)(6512007)(36756003)(6486002)(83380400001)(6666004)(6506007)(2616005)(2906002)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG8vSVNQd1pKdkN1U0QxcmpQODExTDVWbHJvZzUwSTBZN0dWNTFrTGpmeWNO?=
 =?utf-8?B?eUZUOUQyRTlJMGtMbzQ5a1VuRU56WWJ2K1VPbkplc3YrTzZIOWNWTUlPV3BW?=
 =?utf-8?B?R3NXdXhvd0hDZTVQOGY2b0NOMGtndDhlR0ZrYmxGQmx0dldqWk5pcnBFV0dS?=
 =?utf-8?B?anYzQTNYMU5jNHRVWXkva3J6ZWg5b0lRaUtLMGh3N2M3My9aTU1BNWNxak1I?=
 =?utf-8?B?MkZzeEU3bWwrOWtxTWIzaUp4TWZ1QnlmUWRpZ3Z2azVNTWMrQWN5cHNBckVV?=
 =?utf-8?B?U1h3YmpuMEE3ems1U1dZV0dlUS9udGgzbUxXU1VYVUtjd295dmNSQ3dsalRT?=
 =?utf-8?B?ZmJocXRSNGdTajA2blRTRjBkVW5Ya0pBTStUZXNHNER4Y1EwV204NjVEZzZG?=
 =?utf-8?B?RVB3RUQwVVFjYUV5a3VBKzVLR0NKMjlpYjB5TW5zT2FPRDFMeDNwdEprL2V3?=
 =?utf-8?B?TTdIQVBZRkl6clVIMzJKVXVXOXdLUWd2bjhMTDJWLzh3Zll1M1ZJRW1sZEtn?=
 =?utf-8?B?WlVWVElSd2ZkZ25aKzRyanQyeWl5NkhzS1FWTHNXZjJuZ3lKQ1pEd3VmQXRB?=
 =?utf-8?B?Nk0zaG94Z0I2ZEE2cHNMNVg0TXFocm9VMWhsQ0gzbFhFSVE5UkxQMjBjMHlW?=
 =?utf-8?B?VnJoM29MQ1VzRnJOOTFQODZIbnpMdFB4L2FKLzdBdnJXdEJkWjIzUmo5U0J5?=
 =?utf-8?B?eGo5SHFDZmtCaUVlOEtXMzNMcDJ4NHRqa1lkeStZV0NneEJ2bXBoT0U1RDJY?=
 =?utf-8?B?UTZiMG9tM2dSM3N4RG5VeUdPcytFWDVQak1LSmRsR1Eyc1BzOStBVWJpMnFS?=
 =?utf-8?B?dHRXSDkxQUoxU0MxNmpoZ20zVnI0NElQSzJ4MUJiaEx2QXZjM1ZQSzI4RVNx?=
 =?utf-8?B?ZzdjS3k5OTFaWXpuVk9nL01kN2hhVTNLSFBuZDBGM0xHYnZMRjR0K0p6Z3RQ?=
 =?utf-8?B?cnlsQ2dCYTFZbU05bE9mOTduekNQMHE0cTFYd2tsNmVPa2FYd2F1WUR1ZzRa?=
 =?utf-8?B?clVYQkhHSlRZSVE4cnU4OGZGekI4a254dThYdEFuWjRCbWc1cHk5emVheWJ3?=
 =?utf-8?B?Q3JkaURDTTZWbDh4RzVSNWg2NG1XUlBTclNQRUpyOG92eTlKY1JlUUZoT3pP?=
 =?utf-8?B?NFo3eEw2QlNVZHo2bGpIdUkxcUxaZURHdXoyQmY0MlVVUnNiSW1NazdNRXYx?=
 =?utf-8?B?WDlBWnl5TmlIYS9ETy9iRzMyMHdyMEV0NGVVSDNleCt0QkFMNlpWL0hMZVkr?=
 =?utf-8?B?Yms3Wk1vbDNBZHE0N1FCN0FRMTl6eXZobHltbjQwNi9XTmt2NFE5V3pRWDFr?=
 =?utf-8?B?MzFMeEc5OENRWWxxKzlsczhJN0ZNZFZyN2pRc0dsdk5NNGFld0VjSWJ1aHlG?=
 =?utf-8?B?ODBTRFRiZFhZOVNxSHppOWNITmtHMlV3bHJvSElQcVpIN3d4RFhSK0d2WXdJ?=
 =?utf-8?B?aTJFclB4NEdyRTgwUm9uVEx0OUQwaHg0TnpFbVhxS09YTnduOHFqcC96S1hi?=
 =?utf-8?B?d1VYSnNTMlQrVjB6elhXSVVWM0VsUlZKL0svV1VFSU13SDJhZWYwcE1MZTZx?=
 =?utf-8?B?M2hodzBBQ0ZMbEtHUFRienhQNWZOcFpXWS9hT25DS3pxek16QjJONSt5NVli?=
 =?utf-8?B?ZjNiSjlQU0prTDl6dDVSKy9ONFczUnZpcEk1dTh2NllFZEgxaXl6eCs3L1Rh?=
 =?utf-8?B?QU5WcTN3bDRONm9YT3dIYUppZ29nS24zRmM4aGdiTVR3UzZQbUJvYkpCRG1L?=
 =?utf-8?B?TlUzb0xWbldLeHNmVXNpeG05MGJvMFhkVEhWTm4reVJBSnIvSHVZTk84N0M3?=
 =?utf-8?B?TkRZUVB0WTRzaTl2eGNOZ001dXlsMXY5Z0owK2FhV0FOMUJyTm81RXpMYUdW?=
 =?utf-8?B?R21vU3Zlb0JnVSt5NGJQVzRVdHNoTjduTFhUZGdWV3NiYllNQ2M5cTFoa1oy?=
 =?utf-8?B?WVlVVFcyOFZUQWpPZFJsS2V2T2Y3YUxsZzcvTDZSbDVvYnFXc1hsakJHd2V6?=
 =?utf-8?B?UWwyUXU5NHdpMEVLMlpPd1ZtQU1sdGFBTVVvNCt3YnQwUnIrKzVlcUpQU3pp?=
 =?utf-8?B?MVFmM1hzM0tyS0IrV3lDdVF4V1lZeXkwb3NJQlBCbHlvT1o4NFBWZXprQnNT?=
 =?utf-8?B?UGQwUjc3NnpkNlNPOFZpZDRzTTlsYTBMQzI1MGdNSmRBVjIvTWpPemcxUWpD?=
 =?utf-8?B?SDh5M3VtaG4zc2Jjb0EyZ2hCVU9VbkJ2S0MxNmVsdllhd0VFUGVnNW5wMzIz?=
 =?utf-8?B?VThNY2JsMWprNEdCbHU4S0ExSXQrWnVKYWhNWVVrZHRwYlhvQVFZWkFPTDU1?=
 =?utf-8?B?KzMxdjBrbmN1QW1WcEtGM0k3dlRUZndWMit4OVNNd2NJT3FPeGZlcTFQVnJE?=
 =?utf-8?Q?7TRGlyp1uwpvx6Ms=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3c5ee6-68a7-4a58-93fd-08da0e7e54a8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:41:37.6442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75KDUgXffb8EVC+ATSGYehCiOaR/3vwqoV+voiF1+5IQT17MnACiNAlNN2ZQ33fV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4644
X-Proofpoint-ORIG-GUID: mHJ1hAsnqUmD7i8qvr1Y3MNM9QAN2vb1
X-Proofpoint-GUID: mHJ1hAsnqUmD7i8qvr1Y3MNM9QAN2vb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_05,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/22/22 8:42 AM, fankaixi.li@bytedance.com wrote:
> From: "kaixi.fan" <fankaixi.li@bytedance.com>
> 
> Vxlan tunnel is chosen to test bpf code could configure tunnel
> source ipv4 address.

The added test configures tunnel source ipv4 address.

 >It's sufficient to prove that other types
> tunnels could also do it.

Could you be more specific what other types will also use source ipv4 
address. It is too vague to claim "it's sufficient to prove ...".


> In the vxlan tunnel testcase, two underlay ipv4 addresses
> are configured on veth device in root namespace. Test bpf kernel
> code would configure the secondary ipv4 address as the tunnel
> source ip.
> 
> Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>

Again, please use proper name in Signed-off-by tag.

> ---
>   .../selftests/bpf/progs/test_tunnel_kern.c    | 64 +++++++++++++++++++
>   tools/testing/selftests/bpf/test_tunnel.sh    | 37 ++++++++++-
>   2 files changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> index ef0dde83b85a..ab635c55ae9b 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -676,4 +676,68 @@ int _xfrm_get_state(struct __sk_buff *skb)
>   	return TC_ACT_OK;
>   }
>   
> +SEC("vxlan_set_tunnel_src")
> +int _vxlan_set_tunnel_src(struct __sk_buff *skb)
> +{
> +	int ret;
> +	struct bpf_tunnel_key key;
> +	struct vxlan_metadata md;
> +
> +	__builtin_memset(&key, 0x0, sizeof(key));
> +	key.local_ipv4 = 0xac100114; /* 172.16.1.20 */
> +	key.remote_ipv4 = 0xac100164; /* 172.16.1.100 */
> +	key.tunnel_id = 2;
> +	key.tunnel_tos = 0;
> +	key.tunnel_ttl = 64;
> +
> +	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
> +				     BPF_F_ZERO_CSUM_TX);
> +	if (ret < 0) {
> +		ERROR(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	md.gbp = 0x800FF; /* Set VXLAN Group Policy extension */
> +	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
> +	if (ret < 0) {
> +		ERROR(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	return TC_ACT_OK;
> +}
> +
> +SEC("vxlan_get_tunnel_src")
> +int _vxlan_get_tunnel_src(struct __sk_buff *skb)
> +{
> +	int ret;
> +	struct bpf_tunnel_key key;
> +	struct vxlan_metadata md;
> +	char fmt[] = "key %d remote ip 0x%x source ip 0x%x\n";
> +	char fmt2[] = "vxlan gbp 0x%x\n";
> +
> +	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
> +	if (ret < 0) {
> +		ERROR(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	ret = bpf_skb_get_tunnel_opt(skb, &md, sizeof(md));
> +	if (ret < 0) {
> +		ERROR(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	bpf_trace_printk(fmt, sizeof(fmt),
> +			 key.tunnel_id, key.remote_ipv4, key.local_ipv4);
> +	bpf_trace_printk(fmt2, sizeof(fmt2),

In bpf_helpers.h, bpf_printk can be used instead of bpf_trace_printk.

> +			 md.gbp);
> +
> +	if (key.local_ipv4 != 0xac100114) {

I would suggest to make 0xac100114 a macro, so both set_* and get_* 
programs can use the same macro, which makes it easier to understand
and check.

> +		ERROR(ret);
> +		return TC_ACT_SHOT;
> +	}
> +	return TC_ACT_OK;
> +}
> +
[...]
