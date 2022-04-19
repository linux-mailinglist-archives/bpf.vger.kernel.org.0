Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7218B5063EF
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 07:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiDSFmg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 01:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348652AbiDSFme (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 01:42:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E37140E1
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 22:39:51 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23J0G6c8019173;
        Mon, 18 Apr 2022 22:39:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JyS3YPMsqdRaDcyfWV3Bh9vXcYLy5JGMd6mGTUWF0hY=;
 b=FKfCtgN9EOkxERdBLR1J/D9btrNUTK2nTEHwd0Vqx7+NZyr+5RFgLK8rqGptDlixfw77
 jW9NHHn8gk2Uuk66YEiNQpLEilak1zSG16uU0kt6YyyZvXG0+nvqwRLUygCLLCl/R3Lz
 996FauQJgJZ7BpC2mCp5c0W8aMtfjVzlWd0= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ffsfw5h4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 22:39:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TksvXahuGYrcJ9xzn7Y3ZESkmu0hJ/gMA21bSDPHuVq3oW5oVtyGAHUB7f8XA7ZUZPaJVQmIE38LDrU9j9FAi8JkzTvvSamaw0NBhHcXN7F5qzlqTPgBobyXXfIF4jHJRw1+5wLlBb0sj60qGknT+JIc/2m98DDFfclVlQh5HZVYlEHZJw/ylIMh6Bm+H+NXeIIp67bxNwRPJxdY06GMt6DXZtiCN9rKmx9j02qpMhnbpuT4lYwnlVTc2WhCP0Hr3IU9ma0NzgCvX++QwIw7FyjvbdeuLaQRdD+ZbG1DNQoyzr6St3iB6amf2VpZtvGZ8S7Kb58cgI5fnIqU3tAdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyS3YPMsqdRaDcyfWV3Bh9vXcYLy5JGMd6mGTUWF0hY=;
 b=VcHU62K4bSjxJq6w0yZ8NSDYCGUUEFwau9WTQAn09wjqz8hA1Mq1mAwkqIWWbCmggrBYAoG9DvnPXWu32kABZwHbFeQDwYIqRpncYiMScAMguzkKpl1MNUM3pGUmbIbx8xdTl34XVT+Pb8oK5aSdJoIZWgLz7APjOJ+hyi5tk5zrfRXmOxO5kM7CqYliZ3DBdK9Tvm0X5hip+J8Bo/gP3P7P/dwqT09xGY0QYlfmMBjs1Hx8SlRQnhaC/uYLGLzmCRyCDICuU5ug/gXRGJb+KxlVXhqRRacQqROQDbBmVKQBfRXhcHI4fhSPLWupk9Wh6TGLx7KGrGGwbBVjIUX8Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1201.namprd15.prod.outlook.com (2603:10b6:404:ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 05:39:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::24de:30b1:5d2:b901]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::24de:30b1:5d2:b901%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 05:39:34 +0000
Message-ID: <782d99bb-bce7-28a5-6688-8a0231686295@fb.com>
Date:   Mon, 18 Apr 2022 22:39:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Ensure type tags precede modifiers
 in BTF
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20220418224719.1604889-1-memxor@gmail.com>
 <20220418224719.1604889-2-memxor@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220418224719.1604889-2-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0046.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0de62ba-ac19-423b-1868-08da21c6fc54
X-MS-TrafficTypeDiagnostic: BN6PR15MB1201:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB120104C33F8D39D87B57645DD3F29@BN6PR15MB1201.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYTsN59ACMAWMVNwagolT5s5+Kz9P4y3MPSog3fIDgJHWnljUG+/ExIshbt0BXshJ3Z42ephNt966nLN/3NEfDzVYOztOIfeenHJLmiW8WKq32+bxQTEhs1KR6d4QNkmZAT4gY9ixI0PHB5Qn0kc1zQTOCNfoDOj50rkYS65xplpuGxpatv19C7a4z3LokWKd/7kAfVq9vn555eRPTsN0TZfQiZ90PV710Xf4DarsmAVPB2VVJnQia7uxwq3W5o5S+saj+KL932GCnCBJDaTpFzw+RZHn7zDYtoC06JVqxV7TJ2+oDWza6HUoBV/os01iMhXjS+5kEMMPGv2CBmcvKUZcTgLG2JAuS06cLjjS9NUN7TiYPsLcQ+0zWYkqQt43o4r1n4rg7sUuedDAau4dWkRDQ3AYfLEc1H6qr1Lhj0ZJ0G9Ri0+KZZne5sD1UP0dAr5Jx3Q5zkJC6L53GEHMyEeCbNz2TYcxXT36E72VDlLJuQSidNy264M1GnYQ9qMfCyrsV+ZaRAydcblqtLkiJ1D4QoJ70e/a3rcZj3zS7d8l8EIcYmgYgGHwzcZ2nJUrSfVpSihNhYZaLV2MxDBcnUjxNRFr2SWTjWDkL9SiDG2QUEo62W/4nWdlZOwgdg9yAxT+98tdIIVmi099zAKzlKU8e+9XyVpn5E/CLfbb0G6jNymJedyiAGXxI8CrZWVc2ySjgVbR8vFx4FmZRIkvf8WPOwtnfgQKjVNAkQJt0ZiCX5ISxA01O5B2YkWl95J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(52116002)(508600001)(53546011)(66556008)(186003)(2616005)(83380400001)(2906002)(86362001)(54906003)(66476007)(66946007)(8676002)(4326008)(31686004)(6486002)(316002)(8936002)(36756003)(5660300002)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGNhQmZFNEwzYXpWZ2hpWXBZUGpSam9JNGk0RGNzTUlUOWhyNlIwMW5xOXNB?=
 =?utf-8?B?cnlRVStkS1lKRVdjdm51MWFsbi9IajJoSlZtVzVDV0pISWdzOUtzaTFETUpE?=
 =?utf-8?B?YjUyTlhHdUZMZHp6KzZ0UTZNaFhmTllHM3UzeGp1cEowNHdyOWh0TXlBVDR2?=
 =?utf-8?B?dllMN1RLNTB1eFFjNTBQREpuYUJycGpPNUU2dUZiZC9QT2JXYlAxTGZRam5R?=
 =?utf-8?B?OGc4dS92ei9GWk9xa2g5Mkg0WW9heWxpdFk4eUJRblBPMkxESXhGRGgyYnJh?=
 =?utf-8?B?dStCTTR5djlwQXRmOUg4WlZXNUs4YlFYMURiUVJkZ0JtZUcwamZ4d3NzZHEw?=
 =?utf-8?B?U0RTWkVQajN5TUFpMWhmbU5jbS9sR1VGbUdTc2NKby9vTjhjNTl2OU55YXlY?=
 =?utf-8?B?OVRLN0UzekRURWY2RDV4V1NEcXhkSnRwZi8raWkyRkFuNXBwZWpmZm5FUjFN?=
 =?utf-8?B?aTVVcjVRM3RVVGRhTE03NXNmWUxaanRaa2Y4dWZUZksydUpBYTdtZVJZc1ht?=
 =?utf-8?B?d2txZVlRMWVUU0NScVphckxTdC92anV6OW5EWlk1eG1nK2VoaTdrUnZmUFlx?=
 =?utf-8?B?eldidWdvRk1sSWxvcDRVKzV1Y1daalJSU0VtUUFwL3BBTkNTZUNuNnZ1RElh?=
 =?utf-8?B?ZUI0a0V3VzJGRGNHZG8rVFp6cWFZZ0ZsU2g3QTNoK3Z2TEtYQkFrL1FNLzM3?=
 =?utf-8?B?Y1MrdkJuZ2kxL2Iva0w0TlV5aVNXZHB1QUUyaGw1d0FwUTR6YmFOaVloYkZ3?=
 =?utf-8?B?K2wxY1VtWFA5R1ppRnNQUFZ0TS9kSkJBaUU4ZGNJNFJaT05qOVMxTEZGYW1w?=
 =?utf-8?B?VTQ0NU85TjBlVXJnbGFEcVZ0VFBlRjd3NWFlV3NaSmhtQUFncW5kTWl4ekdz?=
 =?utf-8?B?VXdxR2RBWTc0ZDJ6cjVsNklReU9ZVHVXWmVCNGJlRTJKRDNrOGJiZVBXYW5V?=
 =?utf-8?B?TkJqMEpyYWJZMkF3dWxlVVR4cGFXUFF4RGhHR0k3WFpoMy9BL2owZEJuUVJv?=
 =?utf-8?B?UzBxTWZ3cHlCYWQ1R2NYcGh4QkNDNU9NU29pZ2hEWmI3UncxTWJEc1h2WXd0?=
 =?utf-8?B?ZTQvcEhvUUVyRHlUay9qVWdVZ3VSc1NIWU5YeHhiTVQ4NXBJcjdlZVVrNmRB?=
 =?utf-8?B?QVZsWmJvQ2dJdDNMLzVUcFNobHN2Qms5SnJ0R01veTVyUjhVTVpEamMxYjFy?=
 =?utf-8?B?djBQSzlkZlZCSW90YVVMWUk4MldlQitnN2xsTmRxbHNDSlQvRzd5WVdpVnlh?=
 =?utf-8?B?RHJQWXRCTXRleGNhenNEOVdkK1NEZUx2dmd4RzN6RFdua2RCOCtrM0JFbEU2?=
 =?utf-8?B?S1Njb2kwNU9rL0x5L05KdjVqZDNsY0lPZGJvVzkwbGc5c3k1MWNIYTNyZkND?=
 =?utf-8?B?R3QrakoxL0JYZk5xKzdMNXNTT2dMbys1d1pSL0dYM3BGc0ZFdjZFYmtkNG40?=
 =?utf-8?B?Y1h4emQwUGh2ZnRNblMweHRuY3lpRVV3V3VSWllWcDU4Qkw0K3ZRdXJmTURl?=
 =?utf-8?B?OU01YWJRblhJd2hNMXcwbjZFVFFZRExlWkhpaVpEMmJob0NudG1pVlhHMkpH?=
 =?utf-8?B?a3RDMTN5ajJUYkpRaHk1ekpKamNBY2V6dmgzbDZhZ01DZ3FXUlhNcTNNdndj?=
 =?utf-8?B?ZlhKTVo3MnlTTHQvcUl4MEFFeTdmdlZTNGUvbFc4NDZIUjJPZloxd3hWd2gv?=
 =?utf-8?B?R3hvMWw0QzdVM2pGb2J6WW9SVGJuaVJwZU1IVnJYNkMvZW5QN2dtdFltUkF3?=
 =?utf-8?B?NmFxbEd0d0hzZ2hlaTlHcU0wNWtGYXBpaFJob3RhVkxSOGVTN0d1OHBZSDlF?=
 =?utf-8?B?S1hvc1NGSTlyU0ZGcnMvMGpoSGJYbnI5Z1J5Vms2bEdjaXRNMytaTE9IVHZH?=
 =?utf-8?B?ZXlldGlIbGRaMXNLNnB5anZWTVU4VGphUjJBOUlMRzdiSW5MUjE1MkFEaXlJ?=
 =?utf-8?B?N0tSandRR3RmWStIaTdGcGlVaXZtSTE2eThtTVllWG1hMmxXY1FaNmlra09S?=
 =?utf-8?B?dHhRSVFtNno3cWVKNU5TY2pwNTRTamh3VDRSb1cxZWliVm9RSHlHVVFtNlNN?=
 =?utf-8?B?S21vZWZyc3F6Y1NOTUlzcE16OWpwQmlvamdvWnNKeGRUeU5lNjdvWHcvcWFF?=
 =?utf-8?B?R0lYUXVZT21jMzlYeE5XVWE2ekdHMFRmV0dudFBmNnV5a3JBNjU0K2VZWUFQ?=
 =?utf-8?B?QUVLTnJpWjdod1JxWmlCUW92c2FKczNqZUxzdkpoWitpNzV6ckRnS29TdXVV?=
 =?utf-8?B?Q01LNGU0SkloWXcwaHJzdnd1SG9ic0dqSTdkNHlobzcydDBqR2o1NTVDbzRL?=
 =?utf-8?B?emxTYjlZcHhBQm9YSVNCQ0dJM1REdFdJUkNuWTBjQlFnTXdhaEpiNEhTV252?=
 =?utf-8?Q?tkB5EUrXutvlKly4=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0de62ba-ac19-423b-1868-08da21c6fc54
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 05:39:34.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dd4bIb3/BoIBSZW0Rp8jBjV9wUty8L1rEnvm0hKgsAiBv1URshEn1MHXdFJs4OSf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1201
X-Proofpoint-ORIG-GUID: sgCkdFgBcUAMuJHhGuP6no43gwFCv8Ni
X-Proofpoint-GUID: sgCkdFgBcUAMuJHhGuP6no43gwFCv8Ni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_01,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/18/22 3:47 PM, Kumar Kartikeya Dwivedi wrote:
> It is guaranteed that for modifiers, clang always places type tags
> before other modifiers, and then the base type. We would like to rely on
> this guarantee inside the kernel to make it simple to parse type tags
> from BTF.
> 
> However, a user would be allowed to construct a BTF without such
> guarantees. Hence, add a pass to check that in modifier chains, type
> tags only occur at the head of the chain, and then don't occur later in
> the chain.
> 
> If we see a type tag, we can have one or more type tags preceding other
> modifiers that then never have another type tag. If we see other
> modifiers, all modifiers following them should never be a type tag.
> 
> Instead of having to walk chains we verified previously, we can remember
> the last good modifier type ID which headed a good chain. At that point,
> we must have verified all other chains headed by type IDs less than it.
> This makes the verification process less costly, and it becomes a simple
> O(n) pass.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Ack with a nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/btf.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0918a39279f6..c015ccd1c741 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4541,6 +4541,48 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
>   	return 0;
>   }
>   
> +static int btf_check_type_tags(struct btf_verifier_env *env,
> +			       struct btf *btf, int start_id)
> +{
> +	int i, n, good_id = start_id - 1;
> +	bool in_tags;
> +
> +	n = btf_nr_types(btf);
> +	for (i = start_id; i < n; i++) {
> +		const struct btf_type *t;
> +		u32 cur_id = i;
> +
> +		t = btf_type_by_id(btf, i);
> +		if (!t)
> +			return -EINVAL;
> +		if (!btf_type_is_modifier(t))
> +			continue;
> +
> +		cond_resched();
> +
> +		in_tags = btf_type_is_type_tag(t);
> +		while (btf_type_is_modifier(t)) {
> +			if (btf_type_is_type_tag(t)) {
> +				if (!in_tags) {
> +					btf_verifier_log(env, "Type tags don't precede modifiers");
> +					return -EINVAL;
> +				}
> +			} else if (in_tags) {
> +				in_tags = false;
> +			}
> +			if (cur_id <= good_id)
> +				break;
> +			/* Move to next type */
> +			cur_id = t->type;
> +			t = btf_type_by_id(btf, t->type);

t->type can be replaced with cur_id.

> +			if (!t)
> +				return -EINVAL;
> +		}
> +		good_id = i;
> +	}
> +	return 0;
> +}
> +
[...]
