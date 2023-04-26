Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B898C6EEB34
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 02:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbjDZAEB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 20:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbjDZAD6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 20:03:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031B88699
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 17:03:56 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLEMJO012487;
        Tue, 25 Apr 2023 17:03:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=2v0fZx5qEArUJA3fYbt/2qrG8l5pf46shGtu4qh6+j4=;
 b=cXjKlVypU0NmWERKfRp4/Y3Y0xJD34COBLNWtXrrbxfGZg9Wv6tus+BGQJDbx/OPq221
 QnEwKKs/XPLsh1QdvfdaUFcYBDop0BTrBZOb4RTeLshc3PrwLsdAwlFcoq7GhpSV6Joo
 M967Z1aF1emGQq5bMKc19klFMvVY15L8CX5ehKEPUxoXAj/a0RQ9kAW74DmILx9B1a9c
 oun2/WnVjgeRqlAeKcJ0vVqdVKBZhUQKw7i6FqwA4zLoEwk7SkbFhHuOb799hewMjL2X
 O+69cWYQM/ztok2vPMm5ktTJvVdDpb1g1z+HOcNZT2FVB0DXvO616LgKhbxfpF5hJCps MQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q687r6nyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 17:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzMgeG3QG2OGT7DgYH+ejxg5+zAx6OfbYEoJ+27CLFYNCKzQCzXSk+vBD2ufkDvTD0lVsmFEj+hRKIiecVUH+bjMcJFZImU41bPypIwx8s0VcHnvGrhgOUyVnegYD9+1dqblPr8crAhzpqOOL7g4GcvCzj/sbjTqEhwiXB82GFEvi+ehhtNixhlBREikSc8eRPVWtNyjkx2ggqfMUivH8XJBqj/dPUJvgLxE90lXdvie42NchMjhu40bkr9a5Crht/tIXGt7owQVGuitftUshx0KyViWDjNjLwP0fTMPK/OnyoqIQgVdpqFY44BKFmVpXfBRsoRdj82icOM1s4cqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2v0fZx5qEArUJA3fYbt/2qrG8l5pf46shGtu4qh6+j4=;
 b=HEPptQODAzjAYNTwUKA+ymh9fH7t6ymuUcOL+G3K6OoUPUEnfy2nyumD6QadwKjk8GBBX6aydYa1E/wQWFOLO0vWUUqTuO8zIdRjvJS5faDZ2E5RYmttPi4I+ZMUyhDRGk/0Dps/6LBhATtr5OrHtBgzgqxDWhl4c5/RWFir4TbvL27VacV6wJuKSCSKkhmUEqhXKmdE+ZyegbFYA6Q/jEB3qLQc31Xgui3oS3i9AkaUpHok9Kl33mO/0kpUMiw7+OzVWKf97DJcAg9cV+B5n6/3gFp/rWggArkOjRf4EohnsFidGJ1k1I9ooHKbipUY1p6YvfGEcHJicL68TemuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3926.namprd15.prod.outlook.com (2603:10b6:5:2b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 00:03:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 00:03:37 +0000
Message-ID: <0aa9d56b-9c23-9229-5c37-a40b14489869@meta.com>
Date:   Tue, 25 Apr 2023 17:03:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RFC/PATCH bpf-next 02/20] bpf: Add cookies support for
 uprobe_multi link
Content-Language: en-US
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-3-jolsa@kernel.org>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230424160447.2005755-3-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3926:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b921690-4f08-4700-0edb-08db45e9af76
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89esJdNlT75Y71Gn8piUpDrCoyeRrh42oupPKGxVnKRNkKrjkKIk+cjcS+ubgl4VWt+8nFyJtvBkn9JuJzf6P6DH1zDORwaO28x8ly/WdcwUatkfka0dxTUag7hTk68XTBKqouuB/KVgHVF7Thx3ie+4I95x/W0NY6iWQPHbK7azgj7pWwOUcpDYEb4pvcH5M0aVYgTMfBR2te0sUnHl1B3yjmWCpYhHUQMO+d0Fz/VUGQzGUZmC23LzBzp7zahD2V2NiBI2wSAeGiQ6P5Hmb+xtYmPEQbmbCnqpz16aXuB1zNPcTPH2JnQZHUfxhEeh1drlw7A0bgBS8adQvVRPop5DqM2O4FO1cKPblpY763Wzi7lHrsyxz+EDj6QQmWBFGutOZc5mfTXVYBT3qicIG5E9QF8VplMNIrr2Qe8KnZMJZEEmvs4GRV9hZQI3uKbCRK7U3xK34RLMlNoET8qIOu4KCDWPoS0lcUZPJdva1f+XLgfzVYVhweL0R1HgjlhP1MkfcZBlfdbyqivoSzlOLxDmszx1R3VTOu/gaTOiaAs6TdQFJ0aOkzZ0P0A535K9qaKXny59CwIoNtPXaAl2OzPnnuBm0XirCfULCUL9m2kaL6QeMfx1q5pdRrQsMsgAUeuu9yEbDwepzQI/2Vz8gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(186003)(31696002)(54906003)(110136005)(86362001)(478600001)(36756003)(6486002)(38100700002)(6666004)(2906002)(7416002)(5660300002)(8676002)(8936002)(66476007)(66556008)(4326008)(66946007)(41300700001)(316002)(6506007)(53546011)(6512007)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWdNcnEwRUF2bXVUY3htRVpVcXV3SERlM203eDhIVGxBT05PcU52c0pwbSt1?=
 =?utf-8?B?cmpXeTB1QWtObEVrdndkWXFlcHZEL29WVDVaZlFlQUlhK2hqbWs5Z2xxTUU0?=
 =?utf-8?B?RjUvNFk2eEJqRmNyZVdkSmtiVWxNSHRTOVhvenJLQkhJK2NWQUFrTEVWa0ZB?=
 =?utf-8?B?Ykx6TXdwTXREZlRuL1F4SlB5ZVN6Uys4OW5FS09lRk5DL2pDeitMbE03VTNj?=
 =?utf-8?B?RUFFZFhiYkpFQnJqcFpXRmRqVk1oMCt0NFFtTlcvclJDYTVvSFh5OTBkMGdR?=
 =?utf-8?B?TStudzYvaGxJYXd1UjRHVVRsdXhlTzZMVHZwM25Pc1FYbG1WSzY2YWVraWxU?=
 =?utf-8?B?bFMzYjd4cFZTOFBFK0M2ZTJDdk5GaisreC9CWGlRUXJpaHpRdEZBd0o1VXJZ?=
 =?utf-8?B?Y0xJamZzbDFtbEozWmhGYzIvcHZ1ZDhBMTZlMTBaY2Q5dUl4aU1wTi96MXRl?=
 =?utf-8?B?TlZ3a2Nwdm1QVWw1YTZ2YVhpb0JTcmRVNWtLZXlBaHpoeG85SytLUm9LcW1j?=
 =?utf-8?B?WGtPalROTHhpeE1ONktyYWpGRGorYTExZ1hZekt1UG1taHBiYlBRcDgyUUFL?=
 =?utf-8?B?TVF6SGp6cWN2N1U1VXJ4WHZrRURCSEU5Qm4zMzVyZ2dOL21adTI3aWs5ZHNW?=
 =?utf-8?B?TVVoMFpHSUxad0RsUnRLZGF5RUdERGhNbGpZNERaNThxNEwzMlF4UDRkeWNN?=
 =?utf-8?B?WFFiaTdINUZhTTY5bVR5N3FYVWR6ZGlKQnRaT1pIWTdEMDd2azBRcVJra0tN?=
 =?utf-8?B?WERlNlRPYUY5UEZzZkYwWGVmK3FCSmRWRUpCcHJFTzBWTENqR0htQnRheWJZ?=
 =?utf-8?B?ejdjemZLaG9rL2h4RVhBSTR0SU5GaWJLMXBpaWVhUnZzUXN2anhBdnhTaUdG?=
 =?utf-8?B?Zys3QTV4TFI5ekFONHJvcFF1aEg1Tko3Vzc0S2o1NWNnbUhycEFwVjFYaHVE?=
 =?utf-8?B?U1F1VTVweGVhMmVOL25KMCs5cytTMU02RnVhZk1XU0VEaDk1QXNDK3pvL0hG?=
 =?utf-8?B?OU9mTmxGVHUyZFZxRkN4ZDdqSU5hNGxXT2s2ZklKeWNrdlhTcUpDSjA1ZGNq?=
 =?utf-8?B?d1A3SnZqNEE0SSt5QjBtZVhHZHJjN3JlYUxzcjVMNGN1TlhxWWJRUXl4RHVl?=
 =?utf-8?B?bUdpcE1zTU56K0k1OWZyRFRYaHRTZk5uLzhYUHRXaVpveVRnTkZ3cGYxOXhV?=
 =?utf-8?B?Nm1hb0VxaHo1VUJyOXNCT0krdTdtakxiOVk3NHl1d1UxTk5nTVNMOCsxT0Mv?=
 =?utf-8?B?N2tEKzlCcnRiNzBnQ1BUTG5XZEV5dlNmcDFPcXZBOHNuM3NVMGdvNXlraitk?=
 =?utf-8?B?MFF6Z3B6azBxd0JHaHNzaE4xSEtwVU93Y0ZLNkFPenVDaFQzMWo2Nkp6bEpl?=
 =?utf-8?B?Q0psc0Z5bW50Q05GMHlOQWVEdjFDQzNObmZ2V09FY1VOdDN0UlpETHNVN216?=
 =?utf-8?B?VEd0aEt3Q2x0TVhlbGc3Z2UyK3FmSlA4Z20zM3BxbTB5aHk0SFk3cG9IYXIv?=
 =?utf-8?B?WkV4cFBvOGdiVXByaGlIa1FsWDJSOWhqcEw1ZWxpY2hLM3hSZGFIOGo1dzJZ?=
 =?utf-8?B?d2FpQlVBalpJYlJMT2tBWmtiY2tvNG1SWm9YRk1WWkFNWG5yOUttMlhtY2Qx?=
 =?utf-8?B?dGhOT0laOEVBVlRpRmpXcUdRMUtMancxNUZhbHBOSWFDNE1UbUhjSVVaWE5C?=
 =?utf-8?B?UldrQWN0cjNUVjMzek9jQkJwUCtkYkhpMFc3eXpGOGxFazcvb1JGTnM5TUxr?=
 =?utf-8?B?bzkrdElxQTU4Z1NVYkc4Nk03SkhHOThpVThhWVhQK0NXODV1UHhPR0dOb04y?=
 =?utf-8?B?cUkzc0JaYWVaYWJIM2UrK3V0aHpINU9aUmRlbmQ2bWN0S2lFWGlKY3hteUF2?=
 =?utf-8?B?VTlFSmoxcWpjTUxablZSelJlb2NqNHRzcDI2QndnRzE1SEpCaWVwUWt3Ny9o?=
 =?utf-8?B?MlNSTmtZTy9nNUs2Q0R6YUtQblNMc0FwZmhQc3N4NFJlRWxkaGZmYS9iMWwz?=
 =?utf-8?B?UWlPTUVhMjAvOUFjdEZkUEVCdHZyenNidUQzVE1wZW1xcnhuYXgzbkx2RC9X?=
 =?utf-8?B?RnIvL0l4c1dTQmxOc2FWcVRBcjI4RnJXUStaMVFRYWg3Z0x5WVZUVW1RcXZQ?=
 =?utf-8?B?NC9PeUtxRk9oVi9OM3ZlNVBGbmtSK3ZIMmFWcjdqcHcwM2xrK21EQk1YcGpH?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b921690-4f08-4700-0edb-08db45e9af76
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 00:03:37.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pWfawT+HW99WzkHNd/x1+TfYajWP31KfXTpcpDd/N+AnCknm+A02jx2CtD7Qpvi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3926
X-Proofpoint-ORIG-GUID: JYauYIKHPTW0djBQ4wAFYFrQ14n41KOP
X-Proofpoint-GUID: JYauYIKHPTW0djBQ4wAFYFrQ14n41KOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_10,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/24/23 9:04 AM, Jiri Olsa wrote:
> Adding support to specify cookies array for uprobe_multi link.
> 
> The cookies array share indexes and length with other uprobe_multi
> arrays (paths/offsets/ref_ctr_offsets).
> 
> The cookies[i] value defines cookie for i-the uprobe and will be
> returned by bpf_get_attach_cookie helper when called from ebpf
> program hooked to that specific uprobe.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   include/uapi/linux/bpf.h |  1 +
>   kernel/bpf/syscall.c     |  2 +-
>   kernel/trace/bpf_trace.c | 46 +++++++++++++++++++++++++++++++++++++---
>   3 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index debc041c6ca5..77ce2159478d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1581,6 +1581,7 @@ union bpf_attr {
>   				__aligned_u64	paths;
>   				__aligned_u64	offsets;
>   				__aligned_u64	ref_ctr_offsets;
> +				__aligned_u64	cookies;
>   			} uprobe_multi;
>   		};
>   	} link_create;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0b789a33317b..5b2dc7ae8616 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4566,7 +4566,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
>   	return err;
>   }
>   
> -#define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
> +#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.cookies
>   static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>   {
>   	enum bpf_prog_type ptype;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index b84a7d01abf4..f795cfc00e5f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -87,6 +87,8 @@ static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
>   static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx);
>   static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
>   
> +static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx);
> +
>   /**
>    * trace_call_bpf - invoke BPF program
>    * @call: tracepoint event
> @@ -1089,6 +1091,18 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_kmulti = {
>   	.arg1_type	= ARG_PTR_TO_CTX,
>   };
>   
> +BPF_CALL_1(bpf_get_attach_cookie_uprobe_multi, struct pt_regs *, regs)
> +{
> +	return bpf_uprobe_multi_cookie(current->bpf_ctx);
> +}

the argument regs is not used here.
looks like we have the same issue for
   bpf_get_attach_cookie_kprobe_multi
   bpf_get_attach_cookie_trace
   bpf_get_attach_cookie_tracing

I think this probably for preserving uapi. So I am okay with
the above, just want to point it out.

> +
> +static const struct bpf_func_proto bpf_get_attach_cookie_proto_umulti = {
> +	.func		= bpf_get_attach_cookie_uprobe_multi,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_CTX,
> +};
> +
[...]
