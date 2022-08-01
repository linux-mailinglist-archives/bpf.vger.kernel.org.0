Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0120587394
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 23:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiHAVtv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 17:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiHAVtu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 17:49:50 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617A933E3F
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 14:49:49 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KBKi2016663;
        Mon, 1 Aug 2022 14:49:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=b8DV+X99eRraVW+1fPUvntuIRWQetlxBn8ojMPYUyrY=;
 b=lzj7XFf+xVP3Qi9JuCjqs8qPm6KUH8uYW23n5ikbdEieD82aYIZ8whNe73GmLwFtVJpo
 EkFl6+nHrOdULz8XmydPDegc1uEXiy7pnolTqYngunxRJ0kfiDBCF7F30dwiYV7wpZWv
 IqaHNnt0U6ElgVoAxBkjNjb3H7aeUDxxSeE= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn25xewr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 14:49:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha57ZjIBx89TBQYIrFGhyCF1ROzAtCBuvBZ7OdLd3Z2igFzx7MvPhJ9ubbvf1Q2ro2hPMUXdn0vnMN1u9yLDWlkO4Nddg5JlkVO9ZG2IfZDhUH7pVpkHsIFbP3CwA1GVR0//EWd0ldEQq3fXkhlGI/BKOsHc91ZknZPFSm59PoSUqW5Lsox5ZgRQCKdlxoI0uhfhizsL3UokyYbJrV9xxB/RSlkcnoy5HzyJ2w8mCuEPYHfc9GqMqJFowVB5Y3oVXv+phKX80Rj3idEgKm3P/vsL25DANgBpwlG7/jQC+iAMV2l/vZYPFGli15y4U/Dee8J7P5hKXh6l1myoQtEBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8DV+X99eRraVW+1fPUvntuIRWQetlxBn8ojMPYUyrY=;
 b=ZRJ62m8APOQU48V5gBmy+D122iUvLNw/bVTsyVN9e4GVcYjDW6Q0tgAKbr+xFjohdw5LPRAHwLGgdzN+fL/eSNdSDEw4Ic30kM9oWgCHcufBfP53qrTTqGKHjhmieFHajfW+4kbkY2jKyjRwGLGEjwqXknmGH0yfesr0kbac8Frp1xZcn1yrh8N3oUGrl9t6q7iS5lg3NUYoltP9b7TfUPwW4zIwa6ALzsbtGIpMnzxYos4ecgX2Cb1k4z1PwW8dZg0GS40fwz12M6WjA/SQQNdPuV36H1Du6sk56eX9HusfuKBQx9AtliFV3bSvTQBiNvyajc0vCWT2YcGeoVz57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by SN7PR15MB4191.namprd15.prod.outlook.com (2603:10b6:806:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 21:49:31 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 21:49:31 +0000
Message-ID: <d747fc26-050f-e512-bbd2-d561a21cf10c@fb.com>
Date:   Mon, 1 Aug 2022 14:49:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 04/11] bpf: Add rbtree map
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-5-davemarchevsky@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <20220722183438.3319790-5-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95f2dea8-3005-4a27-f31f-08da7407b75e
X-MS-TrafficTypeDiagnostic: SN7PR15MB4191:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AEwODn48bG0M+H00me/P8EKksCq3eDbSYW3p7gyClfy70EYq7YaasfZspPf/blRwFYkmDLHKijl6un919PEcNiTpfBaVmplbgnhO9oLk7BQKtfbIIzMs+ntW/z8ehH2/PtQx2IpqGUKjVtXFrTc/lnwc4PSRPpEN+1wTcBNf8menBMOu+HomUc5htYWzs76+nVkNnn71T3CdJdixnEXaDS21pJ/ECfkT2DDtmA2gOO1udN0F4hvsZp12HPeAr9lsftfBf/pMjxtZQwua3OqsqLMxp30+CVKDj2izxkB0isTyZnfsLTtJGWApiy9z8PuntGVUzcYm2GJRjn1ccjvYRnGDu/eEGoJbduGYsa1YTKrULudPy4cJoy3CWL7P2hKqLu9b+NQjHT65XOSKZYURy6d+YeNqn1qK0oYR8AGGVzE4jKbW0Dgjd+H6gXsVnqltQOQE0ZDum+VkJWyAQYsDgqW6BiIbC10p57E2W5zzWe03d8s+cRDFUSYR+gzK8RyVVxwsrd3KcQd0hx35chSgue81VV1KDzn1bwLGemRTz870I6yMFd/eEHz1oDP2gYUa+R1UHOHaybR09GvFY07ROIyDOTdRdD8k71o9URMRHDxMGB68lCJJZtVhZPULyeBUM7OmzwWNg4krst8nKMKnXQ55EiEan/+rtWv23B6x5lKDr6i0+GMVjDZRfrTN8m6PSJ5pAYvZMhwIyPIdf89uyMgkfDfEYoozdgtW3RtxTwOZZE9SG+y+48F4o4mOTtAaEy71dZFNJ9ua4juDwMp0/6Ws0Hu2GR1MhVhwMK1exmHJZu88T4aUpNKzgQ8LJD7eGrLSVPqSflBJRtRBJ6Jlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(316002)(6512007)(54906003)(30864003)(5660300002)(8936002)(83380400001)(66556008)(66946007)(2616005)(66476007)(186003)(38100700002)(4326008)(8676002)(31686004)(41300700001)(6506007)(52116002)(478600001)(6486002)(86362001)(31696002)(53546011)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0JOQkFLVDZ1dXdvaE8yTVdOOVNvaVQrRDI1cnlMd0ZBUTNtVkp0YW5qOEpS?=
 =?utf-8?B?YjErWGZFRHROcGpoMFgwL0lOdm9oVjVLSXpVVUlUUW0zTEt3enRIODBRKzRs?=
 =?utf-8?B?MUtRU1dDOHNFM0pNR2NscCtFb01palBPcXlqNnJHZm9rK25la0doYzFFWlE5?=
 =?utf-8?B?emJFU213QkEwcW4wemRDMkczOU94amVLcmJmY29DK2xSRG9EZC95bUViMDY2?=
 =?utf-8?B?UVF3SEg4aVhNUitaM0w2STlXeDhma0JNMGZ5VHpCd2ZnZ2ZhMXhRbTlWYVMx?=
 =?utf-8?B?Vk1jWk1Cb0JkbDNmZjcrNDNXUkNraFJtQnMwQTJ0aXEzZTZnL1U0VWJJQTZx?=
 =?utf-8?B?TUN1ekhPVUZhUFBhSTFTRFI1UkpvaWZCMnZ5NkZKcWRyVy82bHJEVTVGWUVv?=
 =?utf-8?B?YzMrNUREZlAzajJ4UEhmZ1E5T3lnRjJ0T2xYSGN1RVgzNm40UHJwTElTME9q?=
 =?utf-8?B?TzFzOUowQVUvQVFoL2I2MHBCNFkrM0pHZUdGM2JxMDBGWGk3NDNYTVZVUm0y?=
 =?utf-8?B?VEIrNWRuckpyZ21WRFVrZWt4Z1ArVEVVZUFsRC8wOVRSa1dQWndSWFhoeWZh?=
 =?utf-8?B?WEp3a0taYkM3VmJ3cXdVbmo3Q25wWkhkRUVrZTBUUTZ2VlVIeEpvSUZMS2d4?=
 =?utf-8?B?YzVIWEdPMjl6Rmkrdk4xaVdTUVkzRG1kNXViU2VsRnp6K3hiY01vWFJGQVNE?=
 =?utf-8?B?a0NpNW04Qm16RVVPQTlwV1hwZGlHT3JLNnduMytJMDkvM2NIclluTzc0UWRB?=
 =?utf-8?B?Ymx5ZXF0Z3FzZk5nQlVwZDZLcHorVEtFalFrTTF3MlV6cTJQZ1AvQlpJdkY2?=
 =?utf-8?B?NFIvT0JvS0lqNHg0cStiUFZwN2xia1pQKzR4Y3MrbEVrdHJLK2xyK1JXSTdm?=
 =?utf-8?B?NUs1RmJjcjNIbUZlbWNpRXJzcXlZM0xUL2xNSmQxV0pTaUowYmlCZVNOdVFO?=
 =?utf-8?B?YXJBYmtDK2k2YjZYMlhCRDNTbzhOTjA2bG9oTTAzLzhDY1VmVlFGQXovTFNp?=
 =?utf-8?B?MTQwcVpHei9HZzk4VkdLaHF4UGdsTkJ3blBOblRWeEQwMVdKZHh1bDZKRnpS?=
 =?utf-8?B?bUlFMCtmTTZ2TUVkdGRYUjZqc2JlK2ZPZEF5bU03Sm80L09BSWV2UnYveHp4?=
 =?utf-8?B?WDVEV2gzVlZCSkZGcjlCdzgvcWFTa1kvZFoyMGZPVWlmSlhWWm9rY3ZxYnF0?=
 =?utf-8?B?bEV0ZDFIR3NHMkpjdTN0MUhCUmhwaDVzcXdjaGRHNitQZ2V4bkNPNXdMRE9s?=
 =?utf-8?B?eUFwQzF5VEs5Q2paUloxVHhqRjYzMkNNdzdPanBIbTJrcG1LQm81dUpyc3Bj?=
 =?utf-8?B?d2s5em05cy9TQUZoQVh6cXhKYVd1M1Z2NWZEOUM5UzhpbGp3Mk5mVlVJMTJT?=
 =?utf-8?B?K1V3ZmhyRFp6VnBUSWdFWW9VSVlVMlFCaWVHWnVDdi9YdEFlVjhCeFI2UXQ4?=
 =?utf-8?B?WWdEWWI4R1BtSEIwMlNCSW11SnVOYkc2WTZoSWdVNlFEMm5hMGFWcVNYWnpa?=
 =?utf-8?B?bWVHL2RNR3crTEhiMC9vNkVwK1VKTnZOM1NERGNLb1hqb2kvVGVteHVORXBi?=
 =?utf-8?B?TUl4QVIzMmM1SC9Db2ZGY1ZKL08ybHR3SjFiYXlJRm0zYzVUemcyODBCWW8y?=
 =?utf-8?B?UU9yMUF1VGZvc1NaUElSMGplNVNtVkNxU2NFRFpnYWZhMHp0OWJEeEpvNFMw?=
 =?utf-8?B?UUs3NXNJWitQN01hcnBiYnRoVVF3QW1yNDJMN2xZeVNKZTJKOU9IYXNlSksw?=
 =?utf-8?B?ZUdMRTlnWERucFJqQm56TnZnaTUxYzhwV0ZUL2hSRG4vWkxhYU43cC9tV0JV?=
 =?utf-8?B?bTJreG1mVzBaUUlqU1UwZnRNZ0NKM0w0aCsrTC91bE0rM2YyTzhvVWxSYXlL?=
 =?utf-8?B?T21NRDlVcThKQk5VNVBzZzRTMmYrdXdSbzVIZDVGem04dXF0d21BOEp6Slls?=
 =?utf-8?B?azhoRmdBLzFhWjJlNjFuaXlNaDJPRStoeFVZWGgvYzNvbDEyeFB0UEREaEF4?=
 =?utf-8?B?U0tYSVVtOUlYZklCLy9WL3JzVkRvUDhreXJKRnZQeE05VDQrcUU1eXNjU0VO?=
 =?utf-8?B?SERwa3JYSDljSmNKbXh3VnRoOG5yUWVoRVhnWk1NL0VUcDVLNkdrNWlIbjVs?=
 =?utf-8?B?WVovTnc3NW40eXp0WmpLRTY1dzk3RlNlMVZtR0hYSUd4NUI2b01pank0K004?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f2dea8-3005-4a27-f31f-08da7407b75e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 21:49:31.7642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8stN9E8kVItUfMMHIHJcNy/9s2X14D3sTY+mQplNatK3EpwJOEZ8cXZ+AlTPrji
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4191
X-Proofpoint-ORIG-GUID: QxrcYRGU0ilkBga1lxy0lDFcuchJj3jC
X-Proofpoint-GUID: QxrcYRGU0ilkBga1lxy0lDFcuchJj3jC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/22/22 11:34 AM, Dave Marchevsky wrote:
> +
> +static struct rb_node *rbtree_map_alloc_node(struct bpf_map *map, size_t sz)
> +{
> +	struct rb_node *node;
> +
> +	node = bpf_map_kmalloc_node(map, sz, GFP_KERNEL, map->numa_node);

As Yonghong pointed out this should be GFP_NOWAIT for now.
Later we can convert this to bpf_mem_alloc to make sure it's safe from 
any context.

> +	if (!node)
> +		return NULL;
> +	RB_CLEAR_NODE(node);
> +	return node;
> +}
> +
> +BPF_CALL_2(bpf_rbtree_alloc_node, struct bpf_map *, map, u32, sz)
> +{
> +	struct rb_node *node;
> +
> +	if (map->map_type != BPF_MAP_TYPE_RBTREE)
> +		return (u64)NULL;
> +
> +	if (sz < sizeof(*node))
> +		return (u64)NULL;
> +
> +	node = rbtree_map_alloc_node(map, (size_t)sz);
> +	if (!node)
> +		return (u64)NULL;
> +
> +	return (u64)node;
> +}
> +
> +const struct bpf_func_proto bpf_rbtree_alloc_node_proto = {
> +	.func = bpf_rbtree_alloc_node,
> +	.gpl_only = true,
> +	.ret_type = RET_PTR_TO_BTF_ID_OR_NULL,
> +	.ret_btf_id = &bpf_rbtree_btf_ids[0],

since the btf_id is unused please use
.ret_btf_id   = BPF_PTR_POISON
as bpf_kptr_xchg_proto() is doing.

> +
> +BPF_CALL_2(bpf_rbtree_remove, struct bpf_map *, map, void *, value)
> +{
> +	struct bpf_rbtree *tree = container_of(map, struct bpf_rbtree, map);
> +	struct rb_node *node = (struct rb_node *)value;
> +
> +	if (WARN_ON_ONCE(RB_EMPTY_NODE(node)))
> +		return (u64)NULL;
> +
> +	rb_erase_cached(node, &tree->root);
> +	RB_CLEAR_NODE(node);
> +	return (u64)node;
> +}
> +
> +const struct bpf_func_proto bpf_rbtree_remove_proto = {
> +	.func = bpf_rbtree_remove,
> +	.gpl_only = true,
> +	.ret_type = RET_PTR_TO_BTF_ID_OR_NULL,
> +	.ret_btf_id = &bpf_rbtree_btf_ids[0],
> +	.arg1_type = ARG_CONST_MAP_PTR,
> +	.arg2_type = ARG_PTR_TO_BTF_ID,
> +	.arg2_btf_id = &bpf_rbtree_btf_ids[0],

same for args.

> +
> +BTF_ID_LIST_SINGLE(bpf_rbtree_map_btf_ids, struct, bpf_rbtree)

can be removed?

> +const struct bpf_map_ops rbtree_map_ops = {
> +	.map_meta_equal = bpf_map_meta_equal,
> +	.map_alloc_check = rbtree_map_alloc_check,
> +	.map_alloc = rbtree_map_alloc,
> +	.map_free = rbtree_map_free,
> +	.map_get_next_key = rbtree_map_get_next_key,
> +	.map_push_elem = rbtree_map_push_elem,
> +	.map_peek_elem = rbtree_map_peek_elem,
> +	.map_pop_elem = rbtree_map_pop_elem,
> +	.map_lookup_elem = rbtree_map_lookup_elem,
> +	.map_update_elem = rbtree_map_update_elem,
> +	.map_delete_elem = rbtree_map_delete_elem,
> +	.map_check_btf = rbtree_map_check_btf,
> +	.map_btf_id = &bpf_rbtree_map_btf_ids[0],
> +};
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1f50becce141..535f673882cd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -481,7 +481,9 @@ static bool is_acquire_function(enum bpf_func_id func_id,
>   	    func_id == BPF_FUNC_sk_lookup_udp ||
>   	    func_id == BPF_FUNC_skc_lookup_tcp ||
>   	    func_id == BPF_FUNC_ringbuf_reserve ||
> -	    func_id == BPF_FUNC_kptr_xchg)
> +	    func_id == BPF_FUNC_kptr_xchg ||
> +	    func_id == BPF_FUNC_rbtree_alloc_node ||
> +	    func_id == BPF_FUNC_rbtree_remove)
>   		return true;
>   
>   	if (func_id == BPF_FUNC_map_lookup_elem &&
> @@ -531,6 +533,20 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
>   	       insn->imm == BPF_CMPXCHG;
>   }
>   
> +static bool function_manipulates_rbtree_node(enum bpf_func_id func_id)
> +{
> +	return func_id == BPF_FUNC_rbtree_add ||
> +		func_id == BPF_FUNC_rbtree_remove ||
> +		func_id == BPF_FUNC_rbtree_free_node;
> +}
> +
> +static bool function_returns_rbtree_node(enum bpf_func_id func_id)
> +{
> +	return func_id == BPF_FUNC_rbtree_alloc_node ||
> +		func_id == BPF_FUNC_rbtree_add ||
> +		func_id == BPF_FUNC_rbtree_remove;
> +}
> +
>   /* string representation of 'enum bpf_reg_type'
>    *
>    * Note that reg_type_str() can not appear more than once in a single verbose()
> @@ -3784,6 +3800,13 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
>   	return 0;
>   }
>

 >    * [ TODO: Existing logic prevents any writes to PTR_TO_BTF_ID. This
 >      broadly turned off in this patch and replaced with "no writes to
 >      struct rb_node is PTR_TO_BTF_ID struct has one". This is a hack and
 >      needs to be replaced. ]

..

> +static bool access_may_touch_field(u32 access_off, size_t access_sz,

can_write is more accurate.
There is no ambiguity here. atype == BPF_WRITE.

> +				   u32 field_off, size_t field_sz)
> +{
> +	return access_off < field_off + field_sz &&
> +		field_off < access_off + access_sz;
> +}
> +
>   /* if any part of struct field can be touched by
>    * load/store reject this program.
>    * To check that [x1, x2) overlaps with [y1, y2)
> @@ -4490,7 +4513,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>   	const char *tname = btf_name_by_offset(reg->btf, t->name_off);
>   	enum bpf_type_flag flag = 0;
>   	u32 btf_id;
> -	int ret;
> +	int ret, rb_node_off;
>   
>   	if (off < 0) {
>   		verbose(env,
> @@ -4527,8 +4550,13 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>   						  off, size, atype, &btf_id, &flag);
>   	} else {
>   		if (atype != BPF_READ) {
> -			verbose(env, "only read is supported\n");
> -			return -EACCES;
> +			rb_node_off = btf_find_rb_node(reg->btf, t);
> +			if (rb_node_off < 0 ||
> +			    access_may_touch_field(off, size, rb_node_off,
> +						   sizeof(struct rb_node))) {
> +				verbose(env, "only read is supported\n");
> +				return -EACCES;
> +			}

Allowing writes into ptr_to_btf_id probably should be a separate patch.
It's a big change.
btf_find_rb_node() alone is not enough.
Otherwise bpf progs will be able to write into any struct that has 
'rb_node'.
Maybe check that reg->btf == this prog's btf ?
Also allow writes into scalars only?
All pointers in prog's struct should be __kptr anyway to be safe.


>   		}
>   
>   		ret = btf_struct_access(&env->log, reg->btf, t, off, size,
> @@ -5764,6 +5792,17 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>   		if (meta->func_id == BPF_FUNC_kptr_xchg) {
>   			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno))
>   				return -EACCES;
> +		} else if (function_manipulates_rbtree_node(meta->func_id)) {
> +			if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> +						  meta->map_ptr->btf,
> +						  meta->map_ptr->btf_value_type_id,
> +						  strict_type_match)) {
> +				verbose(env, "rbtree: R%d is of type %s but %s is expected\n",
> +					regno, kernel_type_name(reg->btf, reg->btf_id),
> +					kernel_type_name(meta->map_ptr->btf,
> +							 meta->map_ptr->btf_value_type_id));
> +				return -EACCES;
> +			}
>   		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
>   						 btf_vmlinux, *arg_btf_id,
>   						 strict_type_match)) {
> @@ -6369,10 +6408,17 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
>   		break;
>   	case BPF_FUNC_map_pop_elem:
>   		if (map->map_type != BPF_MAP_TYPE_QUEUE &&
> +		    map->map_type != BPF_MAP_TYPE_RBTREE &&
>   		    map->map_type != BPF_MAP_TYPE_STACK)
>   			goto error;
>   		break;
>   	case BPF_FUNC_map_peek_elem:
> +		if (map->map_type != BPF_MAP_TYPE_QUEUE &&
> +		    map->map_type != BPF_MAP_TYPE_STACK &&
> +		    map->map_type != BPF_MAP_TYPE_RBTREE &&
> +		    map->map_type != BPF_MAP_TYPE_BLOOM_FILTER)
> +			goto error;
> +		break;
>   	case BPF_FUNC_map_push_elem:
>   		if (map->map_type != BPF_MAP_TYPE_QUEUE &&
>   		    map->map_type != BPF_MAP_TYPE_STACK &&
> @@ -6828,6 +6874,57 @@ static int set_loop_callback_state(struct bpf_verifier_env *env,
>   	return 0;
>   }
>   
> +static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
> +					 struct bpf_func_state *caller,
> +					 struct bpf_func_state *callee,
> +					 int insn_idx)
> +{
> +	struct bpf_map *map_ptr = caller->regs[BPF_REG_1].map_ptr;
> +
> +	/* bpf_rbtree_add(struct bpf_map *map, void *value, void *cb)
> +	 * cb(struct rb_node *a, const struct rb_node *b);
> +	 */
> +	callee->regs[BPF_REG_1].type = PTR_TO_MAP_VALUE;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
> +	callee->regs[BPF_REG_1].map_ptr = map_ptr;
> +
> +	callee->regs[BPF_REG_2].type = PTR_TO_MAP_VALUE;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
> +	callee->regs[BPF_REG_2].map_ptr = map_ptr;
> +
> +	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
> +	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
> +	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
> +	callee->in_callback_fn = true;
> +	return 0;
> +}
> +
> +static int set_rbtree_find_callback_state(struct bpf_verifier_env *env,
> +					  struct bpf_func_state *caller,
> +					  struct bpf_func_state *callee,
> +					  int insn_idx)
> +{
> +	struct bpf_map *map_ptr = caller->regs[BPF_REG_1].map_ptr;
> +
> +	/* bpf_rbtree_find(struct bpf_map *map, void *key, void *cb)
> +	 * cb(void *key, const struct rb_node *b);
> +	 */
> +	callee->regs[BPF_REG_1].type = PTR_TO_MAP_VALUE;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
> +	callee->regs[BPF_REG_1].map_ptr = map_ptr;
> +
> +	callee->regs[BPF_REG_2].type = PTR_TO_MAP_VALUE;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
> +	callee->regs[BPF_REG_2].map_ptr = map_ptr;
> +
> +	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
> +	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
> +	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
> +	callee->in_callback_fn = true;

add and find looks the same until this point.
Reuse set_rbtree_add_callback_state here?

> +	callee->callback_ret_range = tnum_range(0, U64_MAX);

that's to enforce that add's cb can only return 0 or 1 ?
But that would require bpf prog to have different cb-s for add and find.
Is this ok?

> +	return 0;
> +}
> +
>   static int set_timer_callback_state(struct bpf_verifier_env *env,
>   				    struct bpf_func_state *caller,
>   				    struct bpf_func_state *callee,
> @@ -7310,6 +7407,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>   		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
>   					set_loop_callback_state);
>   		break;
> +	case BPF_FUNC_rbtree_add:
> +		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> +					set_rbtree_add_callback_state);
> +		break;
> +	case BPF_FUNC_rbtree_find:
> +		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> +					set_rbtree_find_callback_state);
> +		break;
>   	case BPF_FUNC_dynptr_from_mem:
>   		if (regs[BPF_REG_1].type != PTR_TO_MAP_VALUE) {
>   			verbose(env, "Unsupported reg type %s for bpf_dynptr_from_mem data\n",
> @@ -7424,6 +7529,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>   		if (func_id == BPF_FUNC_kptr_xchg) {
>   			ret_btf = meta.kptr_off_desc->kptr.btf;
>   			ret_btf_id = meta.kptr_off_desc->kptr.btf_id;
> +		} else if (function_returns_rbtree_node(func_id)) {
> +			ret_btf = meta.map_ptr->btf;
> +			ret_btf_id = meta.map_ptr->btf_value_type_id;
>   		} else {
>   			ret_btf = btf_vmlinux;
>   			ret_btf_id = *fn->ret_btf_id;
> @@ -13462,8 +13570,10 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>   					BPF_SIZE((insn)->code);
>   				env->prog->aux->num_exentries++;
>   			} else if (resolve_prog_type(env->prog) != BPF_PROG_TYPE_STRUCT_OPS) {
> +				/*TODO: Not sure what to do here
>   				verbose(env, "Writes through BTF pointers are not allowed\n");
>   				return -EINVAL;
> +				*/

Not sure whether it's worth defining PTR_TO_BTF_ID | PROGS_BTF
for writeable ptr_to_btf_id as return value from rb_alloc/find/add.
It may help here and earlier ?

All ptr_to_btf_id were kernel's or module's BTF so far.
With this change the verifier will see prog's ptr_to_btf_id that point
to prog's BTF.
PROGS_BTF might be a useful flag to have ?

Then instead of
 > +		} else if (function_returns_rbtree_node(func_id)) {
 > +			ret_btf = meta.map_ptr->btf;
 > +			ret_btf_id = meta.map_ptr->btf_value_type_id;

it will check PROGS_BTF flag in proto->ret_type ?
Still not fully generic, since it takes btf and btf_id from the map.
But a bit cleaner than switch() by func_id ?
