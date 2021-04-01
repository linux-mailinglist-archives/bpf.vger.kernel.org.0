Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175DA3521C6
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 23:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhDAVl4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 17:41:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60808 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233974AbhDAVlz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Apr 2021 17:41:55 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131LVnoD016940;
        Thu, 1 Apr 2021 14:41:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RF1ZC+9OXAFgVP1Gt9a04tPipRi4dYPRmyHETOle0zE=;
 b=nreuRpsY7Nj0tn4HV8dnOrs9kV+4mtHbsIxHhG9ddkGH9kbqTLkcDIpWv+N5TI+16GF3
 HhNv5L3iBdgrazMVmpBLLhp+iPpL4PPFQn1FK5tG7a2dHi6yXJ4pX2rJtsoPBglwg973
 VdKsTdAPdGZMKb6sbsyjZ6VlyoFIivFLh9Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37n28y6m06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Apr 2021 14:41:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 14:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4CPlhk8BY4s46V1bcgStJT4WyAHH0EiDkoqL+dYqiES+T5U6p6nURG78f+sMGW1NGAi+aBTo6JtKPCR9dQkvBEFqXYvy0av7W9Yqhqr0XS2xRrAw0UIAFHnPwLyod+gBG8ShmaHLATmUrdo82lrzcQkP/1aUNSv/3ub6CKqqiIlGclnA8WAIBEwWUqRrzhtQjNKqo07LNmtitOiB1o/GacSNMqL1TlK5852aKSYK4eJC7Ye6evynwh2rhkN5mqoan+UfjdOJcQIzamUOZMqbdrkt/032CZEVjWRzfrEeRMDD9L1wR5YUFhgQtQwwPEvP3xGFCzKyI5QaVcyQP6EPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF1ZC+9OXAFgVP1Gt9a04tPipRi4dYPRmyHETOle0zE=;
 b=A5Jt1FKrqc7gUnqaOre9FvHQep4Ey3OqiR2/8LwJ/pMovDUe4WH0uEpCgwHm6bnTVH1mWHPMqFyH/BurhztTUfHTAxR5DiY1Cn8L+Km0vHmSDeX1LIpY/grrhO24b0mR6h34U3PXPAfy8zWrKd9YC7sywOlEVbj852Dk6RhBYuympO7yBpAccaTMW1oy/sdJibONxqynK+kW5TEbXq2jbUmoannb9bmWS0y65IpdtjBWuf1b3PvwhaDDVh3KJV9CqAKYGC3IBFwo6Ce4Lh8G3lOIq/KPnWxHTzpzfsHLJitkrUF6Z9Y3oom0sq67AsOUi/+ldHNb3JJ1Ra+bzCgQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2335.namprd15.prod.outlook.com (2603:10b6:805:24::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 21:41:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 21:41:48 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with
 abstract_origin properly
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>, <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210401213620.3056084-1-yhs@fb.com>
Message-ID: <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
Date:   Thu, 1 Apr 2021 14:41:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <20210401213620.3056084-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:fb66]
X-ClientProxiedBy: MW4PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:303:85::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::17eb] (2620:10d:c090:400::5:fb66) by MW4PR04CA0159.namprd04.prod.outlook.com (2603:10b6:303:85::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend Transport; Thu, 1 Apr 2021 21:41:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bc9064a-c7cd-43b6-3513-08d8f556f3ab
X-MS-TrafficTypeDiagnostic: SN6PR15MB2335:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB233556596363F90319AC2F5BD37B9@SN6PR15MB2335.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dQmqyROkalCoo6qK+U1LUbEZZI6qjzhNeNxCTSNTwBictgSJLr00sp7x6tsV9K0Nu9h6OF9paTMFJyC78fkprFhOQYoW47mrBr2WGI4ZCgQJApKPXLzA/RK4HKoGAKQY3La1V/Yhip1VyQeVXRCGzNqK2CfBdkLAdn5GFjtqd19QlBwSHcPXgLB287k+d6rgPGCqlcHz2Gd0nyWitfjLXl459quXaWLEyuEkfm8DrhxepKe2QN+zIYfgRCoaE2ImthdDB4bgFrY4T2JYPPwPzXxCsWJsbYgmEllaQ6jLm7861nveC6+tIJKNp4QZzF0XE9ceyUabWQxgPcKYbsoJEtd3wW8yCExpjbrf6YHnFZa/SoVSVz9DAlmGYjUmlg+5eQu106Bvp4G/kewFzvGsSRNUVpZdGVNvsHlGorIek6DVFUridjyJhbgenbMfQbijLQyiyp90Vc+A9ofvHVwDR4Q0bHa8VM3IuUL6PwUl+au1dKm1ntJckfkdHgCXBA0lrqRYtCXMSD0IM5byGfC7mAWVSB8vz36cUYeasdiPnwQrSPpw+HhPSc3EkxAV+gd3wJZMVJv9NIoYf7VLb/qZWia+3Jc6uO7d36BQcmERNukkurvyGjazk2EuJlY9bP4o2DNGYDjPiBXu3mM7bijazYC7dfBlAvncJs8HfcTpS3LnyINHM4Te+eLoTT+ycMy9Z00kZxDPTFQgwbmXyzP4QQBugSJjr23eMbdcGVEZ3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(478600001)(31686004)(4326008)(6486002)(52116002)(8676002)(8936002)(186003)(16526019)(2616005)(86362001)(36756003)(66946007)(66556008)(66476007)(54906003)(53546011)(316002)(31696002)(6666004)(83380400001)(38100700001)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?REx0QjhZN2ZCbG9CcVhEMmErOFVPdGx0N293ZEFRcXUzT2dUN0g4RkY5VjJt?=
 =?utf-8?B?VUMvVUNod0lZNDFPL1ZNUHFaT0xDZzRsWkc3Z0ZoQVBQbHFxSUlQL2VWTGJH?=
 =?utf-8?B?SzNicHFMTDFrUXJzcGlGdGZnc215ZGFXVEdiSTFiSHhaRHphQWpJbm82V1Fs?=
 =?utf-8?B?ZmsvN09VRTRxdkhXdnI3T2dwTXp6dHJtb0g1U2dlNzBRMXp5UUhXL0d0cTZ3?=
 =?utf-8?B?aENtU0NYTTQzd3J4YzVuazQ1UklZcS9LcCtBYTFXUmRYUjRIcVBnSFY3dFhi?=
 =?utf-8?B?OW5tVGVGK2tFYzV3OVE4bUJQK3VMbEZhcmV2dmR4RE43TWdSRS9YQUVFOTlJ?=
 =?utf-8?B?Y3AxeUlyeVA2bEQwN1hKS0c0anRVY1RoSjVNRWNOWkd3dUJBVWlnU005Skhi?=
 =?utf-8?B?Y3NLaEpDTU9lV1dabG5XVm9iOVhKUFd2dURDUW9XWHN5V0ZmZURYeFlNSitl?=
 =?utf-8?B?aVRPZzFnME1tNDgwcThweVNVZmFxOTROUktHREs1ZjVUSkZWM0grYU1rTXJD?=
 =?utf-8?B?aGlRdDJCYTZYN2dQM2Y3UXo5RDRheEhBS1JYdnY4aUhnQUY5QkFycFptZWYr?=
 =?utf-8?B?Z2hyd1A2dnNZSkFFTWo2M1VTSHNra3E5ckJGdXd2MHNES2xpdTRqWnJ2ZURn?=
 =?utf-8?B?NnliUVJwRVFVYjNIRW1LeHdtRUpOc2p0UzdFZWNieHFVd2dMTU9MdThOK0o4?=
 =?utf-8?B?VUdmSC9xTTRpSjQ2cEZTZ1cwVmFpTmJmOGx0QndrcTh5OCtRbUtTN2NPZUl1?=
 =?utf-8?B?cWg2VHZ0M21nRC9Ob1BLcm9QMHQ4MGhrRkhRekV1SWdLZklDcWZhN2NUVWRL?=
 =?utf-8?B?MFgvNWtvK0Z1RHBjejE0MFVKRFBtK3R6Tk84SzBPcDBQa2dSOE9oNTQzOXNq?=
 =?utf-8?B?ZGJLdVMyd1J3K1MxL2xKMUNJZi9jTHFmWEJzTWJ5SVVtVkVIekVZMWp0enZV?=
 =?utf-8?B?ekZoRVFLcDJJRzBDbGNQVTBsTm5Yc3BabVJQdnVscU1vem5vb3EzdnNhdVR1?=
 =?utf-8?B?cHhlZEpwNUFxUGlLNmpDV1o5REcwZ25mcmllUkk2UWhVeDNJTjd2UkNjWHhv?=
 =?utf-8?B?Z21za3FDZnFyc21ISGhOeFNGOEJPa1ZiaHpQNFRiSVB0YktnSnBNaWpuZllu?=
 =?utf-8?B?anhSWWxra28xazhTTk15Y2tMUlZWdGYvWUlEajd0OE5FZmZoakVtUWdtZENj?=
 =?utf-8?B?cjhLRlJoQ3NiSkw0T2JJVVVFVHkwSG5wMzdKekgzUVFoYlNKblRhVHhydkpm?=
 =?utf-8?B?cjNCS0FVNTd0NWh1dnVTc0lpSUVkUUFYTm41Zmdaa3FPZFdzd2wweGRQMHlQ?=
 =?utf-8?B?T1dFM3BKMUgxV1dVanRVcGxHNUNHb1Fwdk5MMkJrR2dFMXNjeHNwa3F1azBK?=
 =?utf-8?B?NWp0TFVaZnZnSDI0WFhFOEdtVVpLMWxjUmpDcjJ3YVFpdThPWEY3Ui9XR1V1?=
 =?utf-8?B?SG9aODNjV2IzcGhENG41d1pLb3F4UTJIOEpnS0VXaG9FTGk5YWFmOEkvN1cr?=
 =?utf-8?B?ZitmRFlmaUFpbXNSOFUzTnVwdEY1dEk3YWNMb0F0Mi91K29MejNaWmZIeDhy?=
 =?utf-8?B?S05hejBCQm9HMEpoQkovUmRoaTVpT2xrckIzaE9oTEp3SmZ5d1dHN3RHTHdR?=
 =?utf-8?B?clFtb3gzdm8rUE91cXpHQ3U4K0FmUVUxMHA5TTF3aXR4THJFNFQ5a0hLa1lw?=
 =?utf-8?B?UU9QeTVlTytPaUxmT1VwMTJLeG45UW5ORmtpRzZUeHdDNUhQRFlYZTZyellB?=
 =?utf-8?B?RjRxdjQvbWRINFZzeGdnMWxUL3dSNlYva3NxTmsrUHM4eHhka1RRYWo5c0ZY?=
 =?utf-8?Q?MDBo9UjaIZlqV4GgMdxV52eQGM3Op/JUiA7dg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc9064a-c7cd-43b6-3513-08d8f556f3ab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 21:41:47.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prbct2JfVz2qGz96hiOQcujx1Ap2w3j17MqJnRKHa7XM0Yy132IcPiThSpKYvxL0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2335
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: _2Y_SX08zZiH8b2_Uwv85gqtT48EYWsu
X-Proofpoint-ORIG-GUID: _2Y_SX08zZiH8b2_Uwv85gqtT48EYWsu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_13:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/1/21 2:36 PM, Yonghong Song wrote:
> With latest bpf-next built with clang lto (thin or full), I hit one test
> failures:
>    $ ./test_progs -t tcp
>    ...
>    libbpf: extern (func ksym) 'tcp_slow_start': func_proto [23] incompatible with kernel [115303]
>    libbpf: failed to load object 'bpf_cubic'
>    libbpf: failed to load BPF skeleton 'bpf_cubic': -22
>    test_cubic:FAIL:bpf_cubic__open_and_load failed
>    #9/2 cubic:FAIL
>    ...
> 
> The reason of the failure is due to bpf program 'tcp_slow_start'
> func signature is different from vmlinux BTF. bpf program uses
> the following signature:
>    extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked);
> which is identical to the kernel definition in linux:include/net/tcp.h:
>    u32 tcp_slow_start(struct tcp_sock *tp, u32 acked);
> While vmlinux BTF definition like:
>    [115303] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
>            'tp' type_id=39373
>            'acked' type_id=18
>    [115304] FUNC 'tcp_slow_start' type_id=115303 linkage=static
> The above is dumped with `bpftool btf dump file vmlinux`.
> You can see the ret_type_id is 0 and this caused the problem.
> 
> Looking at dwarf, we have:
> 
> 0x11f2ec67:   DW_TAG_subprogram
>                  DW_AT_low_pc    (0xffffffff81ed2330)
>                  DW_AT_high_pc   (0xffffffff81ed235c)
>                  DW_AT_frame_base        ()
>                  DW_AT_GNU_all_call_sites        (true)
>                  DW_AT_abstract_origin   (0x11f2ed66 "tcp_slow_start")
> ...
> 0x11f2ed66:   DW_TAG_subprogram
>                  DW_AT_name      ("tcp_slow_start")
>                  DW_AT_decl_file ("/home/yhs/work/bpf-next/net/ipv4/tcp_cong.c")
>                  DW_AT_decl_line (392)
>                  DW_AT_prototyped        (true)
>                  DW_AT_type      (0x11f130c2 "u32")
>                  DW_AT_external  (true)
>                  DW_AT_inline    (DW_INL_inlined)

David,

Could you help confirm whether DW_AT_abstract_origin at a
DW_TAG_subprogram always points to another DW_TAG_subprogram,
or there are possible other cases?

Thanks,

> 
> We have a subprogram which has an abstract_origin pointing to
> the subprogram prototype with return type. Current one pass
> recoding cannot easily resolve this easily since
> at the time recoding for 0x11f2ec67, the return type in
> 0x11f2ed66 has not been resolved.
> 
> To simplify implementation, I just added another pass to
> go through all functions after recoding pass. This should
> resolve the above issue.
> 
> With this patch, among total 250999 functions in vmlinux,
> 4821 functions needs return type adjustment from type id 0
> to correct values. The above failed bpf selftest passed too.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   dwarf_loader.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> Arnaldo, this is the last known pahole bug in my hand w.r.t. clang
> LTO. With this, all self tests are passed except ones due
> to global function inlining, static variable promotion etc, which
> are not related to pahole.
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 026d137..367ac06 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2198,6 +2198,42 @@ out:
>   	return 0;
>   }
>   
> +static int cu__resolve_func_ret_types(struct cu *cu)
> +{
> +	struct ptr_table *pt = &cu->functions_table;
> +	uint32_t i;
> +
> +	for (i = 0; i < pt->nr_entries; ++i) {
> +		struct tag *tag = pt->entries[i];
> +
> +		if (tag == NULL || tag->type != 0)
> +			continue;
> +
> +		struct function *fn = tag__function(tag);
> +		if (!fn->abstract_origin)
> +			continue;
> +
> +		struct dwarf_tag *dtag = tag->priv;
> +		struct dwarf_tag *dfunc;
> +		dfunc = dwarf_cu__find_tag_by_ref(cu->priv, &dtag->abstract_origin);
> +		if (dfunc == NULL) {
> +			tag__print_abstract_origin_not_found(tag);
> +			return -1;
> +		}
> +
> +		/*
> +		 * Based on what I see it should be a subprogram,
> +		 * but double check anyway to ensure I won't mess up
> +		 * now and in the future.
> +		 */
> +		if (dfunc->tag->tag != DW_TAG_subprogram)
> +			continue;
> +
> +		tag->type = dfunc->tag->type;
> +	}
> +	return 0;
> +}
> +
>   static int cu__recode_dwarf_types_table(struct cu *cu,
>   					struct ptr_table *pt,
>   					uint32_t i)
> @@ -2637,6 +2673,16 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>   	/* process merged cu */
>   	if (cu__recode_dwarf_types(cu) != LSK__KEEPIT)
>   		return DWARF_CB_ABORT;
> +
> +	/*
> +	 * for lto build, the function return type may not be
> +	 * resolved due to the return type of a subprogram is
> +	 * encoded in another subprogram through abstract_origin
> +	 * tag. Let us visit all subprograms again to resolve this.
> +	 */
> +	if (cu__resolve_func_ret_types(cu) != LSK__KEEPIT)
> +		return DWARF_CB_ABORT;
> +
>   	if (finalize_cu_immediately(cus, cu, dcu, conf)
>   	    == LSK__STOP_LOADING)
>   		return DWARF_CB_ABORT;
> 
