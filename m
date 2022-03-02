Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0429C4CB135
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 22:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiCBVYm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 16:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245078AbiCBVYm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 16:24:42 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6959C55750;
        Wed,  2 Mar 2022 13:23:58 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222JMpq6011178;
        Wed, 2 Mar 2022 13:23:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GLYTafprSBdejc8WL16AaUVfJGZp/F/RCRQ4hj+7Pxc=;
 b=QuTjm091toUF+QbBzpnN0INGSpXWRY/YNEC6pV1NzjJcuof10pn3aMVo1ow6eCp681L7
 wn7azNP3ISJ2ktuQvsAdgytgF50Ob3SpZr2aoZKB80r6hfsgQ0F4cWSY1YkcGMV11xbF
 oW1jj8cc8FCgRLiYJWxHkTn6qftqsbSLf74= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ejaqwtxw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:23:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtrwH31w2GLH42jvGZTz72QyFudkEXLpEPHiXL6CfhMhYhVoGI+MNTLGj7v4E8PG03Tn6izrQMFjvyLU16mQcBO4pqq/PoTpnKrfL4jNAducLCf/PzzAHfy0MHHXnzUvvkIm1s0sDOnhe7WedaLdRemMpwl/GtM5aN7WQ2s9LWOsoKcnDedmvcGSS+TAg1zlOGAPntreZnY4qKldA41kOtTBuw+LlBrdGdNig6ninXnVnoIl0I3rIEv7haO21aAzR+dzDTwiHnwjfnwkYEwPHANIpOsIb5vF0B9WzK2BYPi48ZKloOnWP9FUa8dxQbOUGiyVQA3ryj/Mu387FplXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLYTafprSBdejc8WL16AaUVfJGZp/F/RCRQ4hj+7Pxc=;
 b=izBnaGDO+hD7cecq5RnvPbAR9JPHzWlm5fZkCfKNEb2Sk+EFjZQHqbbvCmcKnQh0xcVyY5xof1rUsvlnxYLNBn5EXdYolUhuuPcHiikBtpy/FKH4jNtJq2F3ks32xRHfvvT55cOwatdGxLHhohN6uA9MsBo2l91noyUEIi9hnHGrI2E0mC2pH4cd3nOlS23LZGiXyOXE8gkSrQ52ezFeT0R46Wgj2IXq+ouv1sLtQhWG+lzseXqoJFTIyH5Ne1zggZU3RGIfYKfdTtO8aDcD8d7qMTZ64TkV6ba6AxWXGbeiC3xRdLy0Nl2nKhl+d/tdsDW/fLjEuBBQN7OoHKWklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2173.namprd15.prod.outlook.com (2603:10b6:805:9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Wed, 2 Mar
 2022 21:23:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 21:23:40 +0000
Message-ID: <c323bce9-a04e-b1c3-580a-783fde259d60@fb.com>
Date:   Wed, 2 Mar 2022 13:23:35 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Introduce sleepable tracepoints
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-5-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220225234339.2386398-5-haoluo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: CO2PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:104:1::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7442dde6-95b6-48e1-4430-08d9fc92eb9d
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2173:EE_
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2173A1324AE4C8D5C3E2B151D3039@SN6PR1501MB2173.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Y8Appe9o+bE/E2Cxn3GKYMAoIRRrqyPJvcWXQT4nn/yCUhGQrqzaHIHY3iXMyWTVsz/C4b5QSy1iFKYjP1FewGIQ+2d0luZu4mJYOjcBaX6A3jx/fRBLb79pg2V5vKDk7GArR42myoJwcyfKqZliKb+EU0Aev0ztCzvcE3Q5teG2xEctSCg0ciPxLE4RDACqX54ksegQRcj+31nHONx1NQmEydFImpbbVoOGQvtFrhDdMZy1jiUNp1FxbeVft8dk7+ZKuBTPcjlou+3oU/MsAPeD6yVdwubt5u6X1keYYlNJnKCYZKfFOlgnSt3vICJPQ7qL0YE+wc83M4BeqZn/Isut2L1Xlp+CK4t+GrolHWjQrzpNV9hLGj3JQCR9KsxQnr/NhAuUl4N9F6OfsNn0tHWo2+QE5yPGFlHHw2ZTLWMK67/b+vfckTLJ1pzqX3SgiPTYTunocFnD3Wgsz9kp+c2MzCtj266T01aVBROc2OSl/0UAegW2ZbjRswcK/FAYTzWmlU5M3igNUbbtWTOERoh/d8KWzUdm9nzgZ6z8XSpQtgarg7Brc/9TEBLdifASDKlUpNwAtKEjWr9OmP/oluwUI6J7GvuMttWU+zRDwqhQTUTgDzM2onDIu0P6Q5M7ECEBEu/N6r15F9ULuffhtbwYqRmhoJo8TYwIlFGqPpJLhcpveU8H16x3zDNTyZU2G2QOWSr9EZOFpYM7nJVIPHo+V6lNSQe9QLFCN/wQxdkdmMsRGmA6FzG1TkYFA7joa5BrK4B4g8wHMD9afAoooSIdImMB9OYrAhOYwDk3YqBQ8bj+8t6F66VBVUBcNQ06AdcEnK/TYU5/wgSt4zWbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(6486002)(2906002)(966005)(6512007)(6666004)(186003)(6506007)(52116002)(2616005)(31686004)(8676002)(31696002)(86362001)(7416002)(53546011)(4326008)(8936002)(66946007)(66476007)(66556008)(36756003)(54906003)(110136005)(316002)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SThNZzd5a05hc3QydkphRTYxcnNyN1BGU3B6MCtNc2VhTjdWNE5nYU90bm9o?=
 =?utf-8?B?YVNpTnM0WGpkdUlvWkJJU3BlZmpmM1cyQVp5OU9RQmgrMzI1Z2Vaa25qZHNv?=
 =?utf-8?B?bjFGM1pHcWNpVy9vNE1hWlovZ09Sa1RFMDlzek5pN2M1MTBKeXZkUkVrQjdC?=
 =?utf-8?B?eDQ4VTJYQXJIaWRsVWZwTGtPamNzekVWaXFhamwwNTBvRFY3Z2RFR1NqY09S?=
 =?utf-8?B?WUZ0ZHVaQ1VDKytXVDJNMXNib3F2WWJ4MjlkcUlJWHAzNk8xYVdocG00Ukdo?=
 =?utf-8?B?c3ZERW1kVGQrcklWZGorYWJHTndzVmM4WTlNZFhCOVJvNHlKZDJyaU9tSFM2?=
 =?utf-8?B?eThGeGVvcUxYaXBDS0pSTXJwdE1iVkZRdGFXTjRZZlFhTFBJU09YMkU0UGJY?=
 =?utf-8?B?MTRCQWtVaThtWkRjT0YzUkRPcnQ2dmNQczlhQkxiQ1hhM0RqcGx5azR6SVlJ?=
 =?utf-8?B?eXdITGhUOGRxMTUvQTdSYktkVVc5UURCdGoxSDUzU2NkaTNVWDNNK2J3VWJZ?=
 =?utf-8?B?QkpVcXdZaityWDVWNXRVWTNLQU5jT3Z1Yjd0OUVYcERsZWQ1ODhnNlEzTmJn?=
 =?utf-8?B?L1pZQlFMR1BkKzBkQXJ5RUR6NC9LRnkxdHJEOEZyUVd3OCtod3k3VDFiTnNk?=
 =?utf-8?B?YlVodWs5ZkVHeGdWaHhDWnZjQngxSXo2ZGFBdTQ5cTRyM3VWSjBsYm56Vlg0?=
 =?utf-8?B?Q0x6UDNKd1E0MlZaeXdtWFoxZjB2WTgzZ1pRVkgxYktSTW9TTHZVQ3gydklm?=
 =?utf-8?B?SUZZZVVQVkp5L3lqL2Z3YlVlR3RsK3BmNzgyWUdjdm9scHVxc3VDalpBUGlB?=
 =?utf-8?B?R1dCKzhYQVM3Q2pYZG1vSUpjQ3RjV1locGZveVlxcXRqZUdkM2dWS1J2R285?=
 =?utf-8?B?Tm9hcVJZc3NGVE4rVFhJUG5QeXpHT3RDL3JvZlliZzU1b1RQN3VLQ3o4TDhh?=
 =?utf-8?B?bi9Xek4rL1RqRlJBbnp3M20zU0wwWkNuRHlHVCtGNE8rTC8xbUI4c3dST1k2?=
 =?utf-8?B?Q0tNcHdFYmVxRnRYUjgxeENmMEtkNzFyS05JTHdMOGhTUmZINkF0UGlJYkpl?=
 =?utf-8?B?ZHdlN2dtaVV0ZE8ySld6ajVYMndKYTdOb3g1eEZUQldOOS9uRnRTUGxiR1RC?=
 =?utf-8?B?Z1N1WnQvVzFTeEE3clhOU1NwbVI2bzRJR2lhSHUrMDVOSytFY1Z1NmQwWW9F?=
 =?utf-8?B?NTVvd0lva3dncGxNanUwNUUvdDU0SHVzT1lvNHNZanJmL3dXMXl2QlE4NTJQ?=
 =?utf-8?B?NE1LQWRDN1d4aUdtQlhqZ2VwQVhEOWtWZnpQMkxDYzZPYkluOHVpbm1aM09C?=
 =?utf-8?B?Z1dvVU42bWlEY3dWc253eVBjWmJrVHViV2NYNEVadE9XbHVtQnhEczhRbXlZ?=
 =?utf-8?B?OEhnVEhnaVlNMWp2RklQeTJkMG9yemx5UitiS296WU1NVG1RVTlsVDU2YXFy?=
 =?utf-8?B?SmpnaW9GeEwxSEtqUVp6OEpDQWh0T1R4SGZjRVIzdUMrSWVpcm85Vll0d01B?=
 =?utf-8?B?Y2FoSzJDcmQ2UVNIeW1EY1FucDJpTlB0ZnJVTzZuZ1NQZURIVlhsTlZMVkxK?=
 =?utf-8?B?MExvejc0bzlhVkFubGtlM1lMZ3dXaWtmTGVhZGoraEFRcE5vd1VOOXhTUmNj?=
 =?utf-8?B?MGlYL2JHeEtrNFp4NHMyNEsrTTQwL3lyL3hLNElzaWRHTWVqTlV4ejY5YkJM?=
 =?utf-8?B?UUF0M2U3QUN4eVVoejhES242OG1TNnJRdk5xakRmN2I0NjNSeXFabDhsM09J?=
 =?utf-8?B?c3Q5dVVyNDRQblhBOEZ0UFpzR2Yvam5HZHZrTk5LTFh2SVRqbzVackRndm1Q?=
 =?utf-8?B?ZUpKUU81L24vRkJZeHY0ZUUyRko0Nmlsd0IyOXd3bks4SlJJOGN6YTdrRHFk?=
 =?utf-8?B?YWRYKzFLQTh3czBBQ1dtN3FqRi9jbWNXdmFNMUU2MTNhMjNmZ0J3WW1YWEds?=
 =?utf-8?B?dlduUzdwMUtjdmR0a0Y5QTBJVW5NQk1SelRybG1iNDVGN3RIdWNHVlNFZjdP?=
 =?utf-8?B?cisxUWVXUUtRVm4zRlRSZERnS2VYMkJoWGlWUXNXNFJXc1BReGlGbEUrQUhZ?=
 =?utf-8?B?Y2FFWDRWenRteEwvODdyOVlwUG1xV2FFM1lNMCtiRTRmclJYVy94cVpOQndl?=
 =?utf-8?B?c0JCNzRsdTJKNkxHdkFEa1Zrelc3OEFjTEFFa00waHFxcjNRVGd6L1FnZnRn?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7442dde6-95b6-48e1-4430-08d9fc92eb9d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 21:23:39.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMd3gdz8b7n9UqSbYvwi5RxRaRFQbfr8WFJoMN7DKXnO8lZbmN1PhtjPli+0pFX1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2173
X-Proofpoint-GUID: r9TFOuyMGduukZ8fTqjirddvVW5tueyp
X-Proofpoint-ORIG-GUID: r9TFOuyMGduukZ8fTqjirddvVW5tueyp
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020089
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/25/22 3:43 PM, Hao Luo wrote:
> Add a new type of bpf tracepoints: sleepable tracepoints, which allows
> the handler to make calls that may sleep. With sleepable tracepoints, a
> set of syscall helpers (which may sleep) may also be called from
> sleepable tracepoints.

There are some old discussions on sleepable tracepoints, maybe
worthwhile to take a look.

https://lore.kernel.org/bpf/20210218222125.46565-5-mjeanson@efficios.com/T/

> 
> In the following patches, we will whitelist some tracepoints to be
> sleepable.
> 
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>   include/linux/bpf.h             | 10 +++++++-
>   include/linux/tracepoint-defs.h |  1 +
>   include/trace/bpf_probe.h       | 22 ++++++++++++++----
>   kernel/bpf/syscall.c            | 41 +++++++++++++++++++++++----------
>   kernel/trace/bpf_trace.c        |  5 ++++
>   5 files changed, 61 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c36eeced3838..759ade7b24b3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1810,6 +1810,9 @@ struct bpf_prog *bpf_prog_by_id(u32 id);
>   struct bpf_link *bpf_link_by_id(u32 id);
>   
>   const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
> +const struct bpf_func_proto *
> +tracing_prog_syscall_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
> +
>   void bpf_task_storage_free(struct task_struct *task);
>   bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
>   const struct btf_func_model *
> @@ -1822,7 +1825,6 @@ struct bpf_core_ctx {
>   
>   int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
>   		   int relo_idx, void *insn);
> -
>   #else /* !CONFIG_BPF_SYSCALL */
>   static inline struct bpf_prog *bpf_prog_get(u32 ufd)
>   {
> @@ -2011,6 +2013,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>   	return NULL;
>   }
>   
> +static inline struct bpf_func_proto *
> +tracing_prog_syscall_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +{
> +	return NULL;
> +}
> +
>   static inline void bpf_task_storage_free(struct task_struct *task)
>   {
>   }
> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> index e7c2276be33e..c73c7ab3680e 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -51,6 +51,7 @@ struct bpf_raw_event_map {
>   	void			*bpf_func;
>   	u32			num_args;
>   	u32			writable_size;
> +	u32			sleepable;
>   } __aligned(32);
>   
>   /*
[...]
