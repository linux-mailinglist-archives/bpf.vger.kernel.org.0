Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B924DDD32
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 16:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiCRPqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiCRPqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 11:46:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226FB65DD
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 08:44:54 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I14jJ5003944;
        Fri, 18 Mar 2022 08:44:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QL10X9LVQP2kjCGy5illXsMaCxBakOG/oawy5cnstLA=;
 b=PO+3jCvDUyp7PUZKChfvyIovkwGnkUJoGxLP/KH1WTW6x4m/bfaph8KDib6EOin6s+G1
 xZT0Em3UDRatwb5kB2qIgZ5yya9uYnh1ZztxXyIOifVpGU9Bjf6FR68fXdc/F8jn/IXR
 /8YcAlmNjgwKpXI6SCKq0HrMiWtlboDdz0o= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3evg3punen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 08:44:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyGUTJWRjur5mtzrUCunEPtf/B6B8v3L9WVqSPVlm3YpJsjvxNy98eLXJ1SA0VKI/Ncz/1jXd3pmjxwF6bYKTvoXNU3agqX0RZAb1vIwnpjrA7OEFrCsLCi0FSu6i8+7XAU8UqKR4Lb+9Z2NAolO6U5ZUAIwrQ8GAtFhjNakksSoEsoiVl8YvREEoxAXw1B+1KeBY5oc4R2FxhBhC7RLwdpA+DDZ3DiSU/3sMGZgf4ZRDx1p3GhnrdH4d+giWxSIcy1xluj3IIyaIexQIhlSqgcCYu+HzULq67TTh2pK61ujihfDa3MTlnlubQ+BOfyzut3A5Tc0PgFb8TTSAzORww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL10X9LVQP2kjCGy5illXsMaCxBakOG/oawy5cnstLA=;
 b=N1IjKKfIrRHWgbjkbR73cPwUnE/OSqZcACayTJ//1ranWZrCWJ3m1gDXvjlGB1N/LEsZlHBneQdkJuUpN1TN2Nau/nxDOI3+hwwbPG9VXtR91C0Gx+nwxfT9zK14/frmfkaUJAXuVTN3kYtOz1JIRdsMkIx4MEzBMx00zYApGn6fZft+0KligOy3XfxkTOi5DgNw3Y7540XszHSn+mt25xgbntPUQU3ZYei3jtZCjZ/V93nsY2eCuSefHPVFAIWhd0J2V8zbEqxGlayj2B4TzJNcwQunNVpzJTw/7U+kijp67aIY7++wta+UC8Yy93BnxXjuBwfl7KvHFaaYBiOLQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB4799.namprd15.prod.outlook.com (2603:10b6:208:185::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 15:44:37 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 15:44:37 +0000
Message-ID: <2e9e8cb7-bc8f-96b0-1f2b-8259ba895cf9@fb.com>
Date:   Fri, 18 Mar 2022 08:44:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH bpf-next] bpftool: add BPF_TRACE_KPROBE_MULTI to attach
 type names table
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220318150106.2933343-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220318150106.2933343-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0031.namprd22.prod.outlook.com
 (2603:10b6:300:69::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cc3cabb-010c-4bc7-699d-08da08f63537
X-MS-TrafficTypeDiagnostic: MN2PR15MB4799:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB4799E0E23E87139D0E63837FD3139@MN2PR15MB4799.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2328nvDRxFStbvFGzmZ3NODFdenAZpJ/K1rjvbKvcKbtHT4QkFwGGaIUtTJVe6FhUz7fgyVKZXPREFNAVcIdYd2Vh3iNpVUsJO8THmnLxOgpnZ2ynKXogR7EiiPRi+xVn3znqfhB4Tpr+sEudKuqRoT/rS7ugbHXgA9DCB3z8ZRiLKCbTDmROApn+sBwZd5bqwTiYNoOUeFU5kJOhHQ1fGnaPrjzoUdaTB11xWyhI97dF0EwhK7CL2Whh0XuLP3Har0dtYSx5vOPc7BOI3RG2eZ0XhxcGKfTglPimPfUAtq4290Swl8wIjwZ9esWLWqE7Az+q+J7cg7qwqESFGxEVOOtehPWYcn+6piMZ/oNqiRelos9vQg1tu2I0Wf0g0LmHsUnw3r6zCvuyEGmwEM6aLWlGV7TUPa0mnFViRKOhh9GJIgzii5+BAGONl9peOh21QTFwsq9VueAq0iUs6EWh5FprF8TNT6clx1IQIgsdvkC4/bgek26Yb3Ncx847C8BpLNf3ljhTHud5KsRkAHGUOftfBE90NQc3zKeS+vENnnTpIvyO/4LFZpobTApAJjXVkYpJyYSTeEKmN/t+cnLNUELL4w/xmZv7ZkjvnGAVQEs5AYeasL/6/2hV1vLMQvxjRWG+viqXxf8Lmm2vdG12cZsLCZctqiYt5xD13irK9prdw8qgS6lu33jTeIzDFTt3uQjMnbg9LtpXSfLBjldObrYd1ALoo1ZVLDTJ1jpx/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(5660300002)(8936002)(2906002)(6666004)(6512007)(31686004)(6486002)(508600001)(6506007)(53546011)(52116002)(83380400001)(36756003)(38100700002)(86362001)(31696002)(66556008)(66476007)(66946007)(316002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEFhUS9lWUV5UTVpai9kU0hleWdtOHZCRTYrWW8raU91U1pSQzVFYTlncjlY?=
 =?utf-8?B?emhhZ0NWdDc2VnFZS2VvS05lNzV6L0xEVjlwbitDbDJsYTJyN1BkSzJ0N1JP?=
 =?utf-8?B?K2JvSE4yTVNVSGNheitOazJtR2R3T2FlaFpSeEs4TEZLbGNjSHd4N3RZcm42?=
 =?utf-8?B?R0dWem9UbEVqL3M0emhZNkYrN2dqamJUaGIyRlJVM3hjdm5oa3dWSWhvVUhn?=
 =?utf-8?B?QlorWFNGR3gybGF3b0V4NEtqRGhlZ3hjcWxQaG5mcGt0V2Q1NWxPQUxwSWxD?=
 =?utf-8?B?elJMSFl6R3dwZ3FHSm52ZlgwQjFtL2ZxVmQxenJYalZUSlU1Z2NWb3RTUFpp?=
 =?utf-8?B?VnJ0S05NSCs5SjFQOEtCdFlBU1kxYzQxVVRvUmxkR3FtUDg1ZWhBR1lER1Jh?=
 =?utf-8?B?amtwRDJsTzh6SW9YOEswQTZyREp3OFhBQ1VveWdsdGNFMU5KUlFacGlpMjMx?=
 =?utf-8?B?eGlLM0ZZMStMT1NpZnVBSTJkZ2hwQjVTSERmZlRNT2xQWm5DQ2YydGhLSk1h?=
 =?utf-8?B?L1BUNG5yM0xWZmQ0VU10TDY3eHVzckJubERZbEs5MTlRS1BTQ0FMZ1daYzBh?=
 =?utf-8?B?ZUFzVFcrc3pjS2cvdkY3UHlsU0EzNkYvQS9vV1pPdVhVMjY0dmNLWmV6T3Vp?=
 =?utf-8?B?QnkrbVRyeG5heENTbFROM1hXME5VS1VkNHlHaWZsTTBmd1o5V2NFdWpVZlVn?=
 =?utf-8?B?RWpYQ0ZPSWlYdFpXekpoWm1Xb3Y4VmJER29ISklaZVI2VnkxMFZCTHZsdjhO?=
 =?utf-8?B?Ujdpd1VQM3JHM2pJaWc2bzF3TXpRMGZ2MDZCS3pBakNYUExNbmF4YzNUWHh2?=
 =?utf-8?B?SmtpUERwMmRPbmVHQlN0dnd5enpIRHg2TlNCQzQvWXNrSnZISGdxVzJ3Snh4?=
 =?utf-8?B?amZzRFVleXBid1FwMTkxT0xENEc5cFFZdjNLd2dub2w0SThxSXpmdWhQdHBq?=
 =?utf-8?B?S3k0dy9TYktodjNBby9SSFJmenlJQ3JFb2twQlhnSHppVW5qOTVBV01qQ1lI?=
 =?utf-8?B?VnJ6Ylk4RE9oM2FYaitiSnVuVEIyZ0R6eUhKRDUxODU3T0JuTTBNZDRqbmY3?=
 =?utf-8?B?azQ3THlsdkpJUDkyZjVrTGZNcEh6Wlp2OEQ1dzdnMWJmNmloNlVPU05Cb2RW?=
 =?utf-8?B?ZlAzaG5EUlRMek1GUG9YcUptU3JkaHZXWU9oaHhEenk3K0VIYy9ubG1MbU10?=
 =?utf-8?B?SWd4Wkx1QWRqQjJNQklPL0R0cTZxSnppMnY3Y2xoTnlERUEzSG9mMnJmekZE?=
 =?utf-8?B?VDI1VFNLdEhUSDlhUmhkZ25XOTVHWXpOc1JoTWJmY3BjdVYyRkhrMGVaYlRK?=
 =?utf-8?B?OXcrbU5LdzlHLzV3a0NaNlZiR083SEZJZXh1c1dnV0cza2tsNm12YnF6K0xw?=
 =?utf-8?B?OE43S1Uxd1JxckxUMURyblNFNm9DcU9hVzQ5cUdPTmY4VHdVKytQTHpUc0h1?=
 =?utf-8?B?LzlzRUZwd1B5dEZ1N05iaFlwOTRhaE1TWkNiV1dOcjN2UXlTb0lkM2xTQUIz?=
 =?utf-8?B?cVdhVHZCUk5ESk81T0g2V01JcU9FdXJ1VGlML3JySjRTN0hOS1Z4RDNMT2VT?=
 =?utf-8?B?dzRqamdlWUZkWkNHbUhtZWxVMWhiOVNSeTNoeVRwTUsxWXJDWFJQY3AvMHRh?=
 =?utf-8?B?bGFWK3BqNlk4bi8wWTIya09UTE1QY2pzWlhNUGlUcmlmYkxvWlUreUIyZEFO?=
 =?utf-8?B?ZThoK04rOEkzd2FHYnBEenorWko5bndMMUQ4MEZEYnU0b2JRc2dIOFZNU0pS?=
 =?utf-8?B?QXZmNWd0V21jdGljNi9Rd2lRQ0NCZE1VMUQzYnFsU0NXNkR3bHZNcWVLTkli?=
 =?utf-8?B?UU1oUDEyRHY0b3JiQ2cvczdsM1pIeWl5TzRCYVZMUmVIdEYybjlGZE1JNlBl?=
 =?utf-8?B?QWFTQ01hZkh5Qy80dytkeU5WSGpUblJkTDNzQVEyenRBL0g2ZytVMkVXOGcw?=
 =?utf-8?B?bHBPSklaS0IxSmZrdG9tTHk3MnViWnE5RzFzVUtpUWxqYWFpeFk4WUFWa1lx?=
 =?utf-8?B?VVV0T21hdGpRPT0=?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc3cabb-010c-4bc7-699d-08da08f63537
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 15:44:37.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6853uV+zf+p99sdGgOSotM4uI7B+poCJKgd5/e1HeB8odBsHgPfO9WfN7Z2db8h9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4799
X-Proofpoint-ORIG-GUID: U2PObpLJEb-2t_C4uA2hO0otprR9IYJM
X-Proofpoint-GUID: U2PObpLJEb-2t_C4uA2hO0otprR9IYJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_10,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/18/22 8:01 AM, Andrii Nakryiko wrote:
> BPF_TRACE_KPROBE_MULTI is a new attach type name, add it to bpftool's
> table. This fixes a currently failing CI bpftool check.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

One nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/bpf/bpftool/common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 606743c6db41..b091923c71cb 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -56,7 +56,6 @@ const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
>   	[BPF_CGROUP_UDP6_RECVMSG]	= "recvmsg6",
>   	[BPF_CGROUP_GETSOCKOPT]		= "getsockopt",
>   	[BPF_CGROUP_SETSOCKOPT]		= "setsockopt",
> -
>   	[BPF_SK_SKB_STREAM_PARSER]	= "sk_skb_stream_parser",
>   	[BPF_SK_SKB_STREAM_VERDICT]	= "sk_skb_stream_verdict",
>   	[BPF_SK_SKB_VERDICT]		= "sk_skb_verdict",
> @@ -76,6 +75,7 @@ const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
>   	[BPF_SK_REUSEPORT_SELECT]	= "sk_skb_reuseport_select",
>   	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	= "sk_skb_reuseport_select_or_migrate",
>   	[BPF_PERF_EVENT]		= "perf_event",
> +	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_bulti",

trace_kprobe_multi?

>   };
>   
>   void p_err(const char *fmt, ...)
