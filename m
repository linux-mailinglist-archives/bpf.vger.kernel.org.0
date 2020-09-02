Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20CE25A4CC
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 07:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBFI1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 01:08:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29562 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbgIBFIY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Sep 2020 01:08:24 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08255WPb020179;
        Tue, 1 Sep 2020 22:08:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=G6mLan7t+ygJb18lcaD6CQTvx8/AAUrNt3iGPHFbm0s=;
 b=oGQUhjd/PooFaDlb7RtarznId0BwkK9O+AUzQ9+OU75Uo5b+Ki9bU7mLJfBseW5PuJx4
 AHLNwKMLh2MjnH2reFEWwmQeTZOuedfEIUC7rLCot/hkVeN/HcP0xfFfy3phPWSga6Y4
 VkMk4/jqC9gkBAIIIr8Jbylyh4fXx8iTgIY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 337mhp24pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Sep 2020 22:08:05 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Sep 2020 22:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY+U3EGmaPogXFvt0Rkusl3fIPTJ8+Cy0H92pvLUxCSR6lZt4W1VeDrDxBK5nMd/Lrp4uhduL+4qD08pTJwtumwc4rL0qjRNw4JgN0P4d26O1j9aR5JMPW12XBvyIEoeXg8quQdgYw2W7sruyfoWdNf/wvida4VB0l+ArBBQogoEnFRC9ExIVuE70obhu+IKFzrMwMcTObF4onms1o2YHY/hYDmpvO3a1bULi7aReKaT5Fh8xwJ7LPus3En8QevgtprTBcBE/NAIBbW1aPn+g4nA/ABLpDe5RbC1Jzm90TBqoB9zH1DCChBm+Bm5jm0jIJHXxbJTs9nD8K8XKJZqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6mLan7t+ygJb18lcaD6CQTvx8/AAUrNt3iGPHFbm0s=;
 b=b4EbJIkoSEPTv/qppNMqFJkUcqbfdlawQKzGrjmLO/T3wCuSMd031+8n5prXDceREChm6GfvyZx13NIPNs8yiapnKcpMh/h68MM0aFN0gm4AMVm9uA2vgOSNwRVYMYuxXmGXMTTBMXiuAHqNxwzaY9M7cs3KVg26+Gv7IZhKnbRwFuvaDjX/tB8RJ+YLXP+rCIMr2d71S8DKoM39sIvvAEE95tu2HvYed3+CbeqbiQt9F36keQ/BGg4+5i72Gzd5WG5VgwrJosaTHYdTWvfPLmlWoColtQfx/qsyKG7rAYYicnHVeXVXtyM/+xeqm2grlIVo9W5HZpNywhp6YPZUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6mLan7t+ygJb18lcaD6CQTvx8/AAUrNt3iGPHFbm0s=;
 b=F6kYy2Zub8ESteSiivBoDZFRx71Iyvw9KNFR6D59dGdWRP/wvV6IJh4ULCDSJe70Z+d572cOceAeqLS1ovuWOBCOJT3IVFE5Ob8ZdKjsW8w55VxmzzDoGkQpL3Zw7c8giXGHfqGRgHQYXWlFcLnMLE5fipz1rHsmUuR2dfPnM7s=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3510.namprd15.prod.outlook.com (2603:10b6:a03:112::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 05:08:02 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 05:08:02 +0000
Subject: Re: [PATCH bpf-next v2 2/4] net: Allow iterating sockmap and sockhash
To:     Lorenz Bauer <lmb@cloudflare.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <jakub@cloudflare.com>,
        <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>
References: <20200901103210.54607-1-lmb@cloudflare.com>
 <20200901103210.54607-3-lmb@cloudflare.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <770162b0-7511-8d21-4d34-cb9b8aa191d0@fb.com>
Date:   Tue, 1 Sep 2020 22:08:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <20200901103210.54607-3-lmb@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:c0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.7 via Frontend Transport; Wed, 2 Sep 2020 05:08:02 +0000
X-Originating-IP: [2620:10d:c090:400::5:b90d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cbe389f-e786-4a9d-cf58-08d84efe2b12
X-MS-TrafficTypeDiagnostic: BYAPR15MB3510:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3510C7D1D472ADA1C4B68280D32F0@BYAPR15MB3510.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /d1UrKX3RP/ry3g1ToPK1p5A/gjGEy4hU3LUJ0Jgqcq208kpQOK0N+upciaHJJMHRxTjoKcZjnPR464plNPXu+GcJJmiVTEw+wBGMB6a0wBcODAMoERwNi/VjEjhgpUdrssI0ylDaoheGEgVpQ2blYH7DMLgLmfSmW0tn8rD2BeAt+jBEFME6UKjq7TXNPVSi4M4dM6JlmFF4yhccqdBcDHcIyeU0vfyL7bFou0A+toFL2VsjX3/fUP2EQouW3un7ptt5jZdPFYD/ctpxdkhBM6pov0YparkaOhJk0VaePZUwRjWyObeXNvtNqG+oZ0kwflHmxZSoe2pUevVMqHJhYqnQvhQb5GwMErBzLtwOqnX2fk6b9IbMc72uoihzaTk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(396003)(376002)(31696002)(53546011)(8936002)(36756003)(52116002)(5660300002)(83380400001)(2906002)(16576012)(478600001)(66476007)(6486002)(2616005)(31686004)(66946007)(4326008)(66556008)(86362001)(956004)(186003)(316002)(30864003)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FIQVsPy9oPflEjrS4ABGdIf1Z7jbUONpfMhfhsd+8J0+nMYvn/uasB+JXO8O48JYwYB+aWVsihUvnggNkfE48aeuABuKQbUWphnINfCrjUabeEL9qUe7UUHHjMp4srsiXu9ZKhfN7t+kzdz3iZ6JEcWwVsgUhOkPfQwjpBDfB0D/yQ/xuunRNq3JYwXZDgdkE20UNSVluiXmvNttlo3v8VkvsCcgRcklLfaik/TA4a46wIy5RDxppCB/oWdSPtZ4WB72Ud/z5jnzMg6QqmHX1f5p9N0L7pBbx2JeqWl8MtyyTZCbZcdOTLJjioR/KgD/HSGrCKgrSxxaPiFsfANrgmZk66PuR0Ffw2LMyNRa1T3VQ3ftqlbAN0PqLg5orza6LxXaKektOPYFfNU1KNxPFcnvucWdQHmuXIj+Z3Ol65T5doGFT5Y/HnVRSeFSXaOSMSTBiX+HaVRYTmph/+19tcmril+O0V0TOYI6+86CfwwNyA15D8vAOFo1wHqTy1OKw3/HRvY+ABJmew9LugEIOPrj4imDrzXTKc5C9l/EzLN3BmmVE/a86HmpN5QbLFztiQfqB/4y7pGVWSJlhjjBGyLSaoBovJ8VbERKPOfqb2Ujp+38azAlQE8741Ay4++KkmsCuoBjTr9ns4tZgsJTD99igkAUF1/XzCP6phhJg1M=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbe389f-e786-4a9d-cf58-08d84efe2b12
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 05:08:02.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FSYXzdFHpLVkkQHOtlGoyVpu8ddEvXCTR86sYd9NE8uR/XLlol5nqRcroCGxGUD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3510
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-01,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020048
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/1/20 3:32 AM, Lorenz Bauer wrote:
> Add bpf_iter support for sockmap / sockhash, based on the bpf_sk_storage and
> hashtable implementation. sockmap and sockhash share the same iteration
> context: a pointer to an arbitrary key and a pointer to a socket. Both
> pointers may be NULL, and so BPF has to perform a NULL check before accessing
> them. Technically it's not possible for sockhash iteration to yield a NULL
> socket, but we ignore this to be able to use a single iteration point.

There seems some misunderstanding about when the NULL object may be
passed to the bpf program. The original design is to always pass valid
object except the last iteration. If you see a NULL object (key/sock),
that means it is the end of iteration, so you can finish aggregating
the data and may send them to the user space.

Sending NULL object in the middle of iterations is bad as bpf program
will just check NULL and returns.

The current arraymap iterator returns valid value for each index
in the range. Since even if user did not assign anything for an index,
the kernel still allocates storage for that index with default value 0.

For sockmap, it looks it is possible that some index may contain NULL
socket pointer. I suggest skip these array elements and already returns
a non-NULL object.

> 
> Iteration will visit all keys that remain unmodified during the lifetime of
> the iterator. It may or may not visit newly added ones.
> 
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>   net/core/sock_map.c | 283 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 283 insertions(+)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index ffdf94a30c87..4767f9df2b8b 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -703,6 +703,114 @@ const struct bpf_func_proto bpf_msg_redirect_map_proto = {
>   	.arg4_type      = ARG_ANYTHING,
>   };
>   
> +struct sock_map_seq_info {
> +	struct bpf_map *map;
> +	struct sock *sk;
> +	u32 index;
> +};
> +
> +struct bpf_iter__sockmap {
> +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
> +	__bpf_md_ptr(struct bpf_map *, map);
> +	__bpf_md_ptr(void *, key);
> +	__bpf_md_ptr(struct bpf_sock *, sk);
> +};
> +
> +DEFINE_BPF_ITER_FUNC(sockmap, struct bpf_iter_meta *meta,
> +		     struct bpf_map *map, void *key,
> +		     struct sock *sk)
> +
> +static void *sock_map_seq_lookup_elem(struct sock_map_seq_info *info)
> +{
> +	if (unlikely(info->index >= info->map->max_entries))
> +		return NULL;
> +
> +	info->sk = __sock_map_lookup_elem(info->map, info->index);
> +
> +	/* can't return sk directly, since that might be NULL */

As said in the above, suggest to skip NULL socket and always return
valid non-NULL socket.

> +	return info;
> +}
> +
> +static void *sock_map_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +	struct sock_map_seq_info *info = seq->private;
> +
> +	if (*pos == 0)
> +		++*pos;
> +
> +	/* pairs with sock_map_seq_stop */
> +	rcu_read_lock();
> +	return sock_map_seq_lookup_elem(info);
> +}
> +
> +static void *sock_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	struct sock_map_seq_info *info = seq->private;
> +
> +	++*pos;
> +	++info->index;
> +
> +	return sock_map_seq_lookup_elem(info);
> +}
> +
> +static int __sock_map_seq_show(struct seq_file *seq, void *v)
> +{
> +	struct sock_map_seq_info *info = seq->private;
> +	struct bpf_iter__sockmap ctx = {};
> +	struct bpf_iter_meta meta;
> +	struct bpf_prog *prog;
> +
> +	meta.seq = seq;
> +	prog = bpf_iter_get_info(&meta, !v);
> +	if (!prog)
> +		return 0;
> +
> +	ctx.meta = &meta;
> +	ctx.map = info->map;
> +	if (v) {
> +		ctx.key = &info->index;
> +		ctx.sk = (struct bpf_sock *)info->sk;
> +	}
> +
> +	return bpf_iter_run_prog(prog, &ctx);
> +}
> +
> +static int sock_map_seq_show(struct seq_file *seq, void *v)
> +{
> +	return __sock_map_seq_show(seq, v);
> +}
> +
> +static void sock_map_seq_stop(struct seq_file *seq, void *v)
> +{
> +	if (!v)
> +		(void)__sock_map_seq_show(seq, NULL);
> +
> +	/* pairs with sock_map_seq_start */
> +	rcu_read_unlock();
> +}
> +
> +static const struct seq_operations sock_map_seq_ops = {
> +	.start	= sock_map_seq_start,
> +	.next	= sock_map_seq_next,
> +	.stop	= sock_map_seq_stop,
> +	.show	= sock_map_seq_show,
> +};
> +
> +static int sock_map_init_seq_private(void *priv_data,
> +				     struct bpf_iter_aux_info *aux)
> +{
> +	struct sock_map_seq_info *info = priv_data;
> +
> +	info->map = aux->map;
> +	return 0;
> +}
> +
> +static const struct bpf_iter_seq_info sock_map_iter_seq_info = {
> +	.seq_ops		= &sock_map_seq_ops,
> +	.init_seq_private	= sock_map_init_seq_private,
> +	.seq_priv_size		= sizeof(struct sock_map_seq_info),
> +};
> +
>   static int sock_map_btf_id;
>   const struct bpf_map_ops sock_map_ops = {
>   	.map_alloc		= sock_map_alloc,
> @@ -716,6 +824,7 @@ const struct bpf_map_ops sock_map_ops = {
>   	.map_check_btf		= map_check_no_btf,
>   	.map_btf_name		= "bpf_stab",
>   	.map_btf_id		= &sock_map_btf_id,
> +	.iter_seq_info		= &sock_map_iter_seq_info,
>   };
>   
>   struct bpf_shtab_elem {
> @@ -1198,6 +1307,121 @@ const struct bpf_func_proto bpf_msg_redirect_hash_proto = {
>   	.arg4_type      = ARG_ANYTHING,
>   };
>   
> +struct sock_hash_seq_info {
> +	struct bpf_map *map;
> +	struct bpf_shtab *htab;
> +	u32 bucket_id;
> +};
> +
> +static void *sock_hash_seq_find_next(struct sock_hash_seq_info *info,
> +				     struct bpf_shtab_elem *prev_elem)
> +{
> +	const struct bpf_shtab *htab = info->htab;
> +	struct bpf_shtab_bucket *bucket;
> +	struct bpf_shtab_elem *elem;
> +	struct hlist_node *node;
> +
> +	/* try to find next elem in the same bucket */
> +	if (prev_elem) {
> +		node = rcu_dereference_raw(hlist_next_rcu(&prev_elem->node));
> +		elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
> +		if (elem)
> +			return elem;
> +
> +		/* no more elements, continue in the next bucket */
> +		info->bucket_id++;
> +	}

Looks like there are some earlier discussion on lock is not needed here?
It would be good to add some comments here.

> +	for (; info->bucket_id < htab->buckets_num; info->bucket_id++) {
> +		bucket = &htab->buckets[info->bucket_id];
> +		node = rcu_dereference_raw(hlist_first_rcu(&bucket->head));
> +		elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
> +		if (elem)
> +			return elem;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void *sock_hash_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +	struct sock_hash_seq_info *info = seq->private;
> +
> +	if (*pos == 0)
> +		++*pos;
> +
> +	/* pairs with sock_hash_seq_stop */
> +	rcu_read_lock();
> +	return sock_hash_seq_find_next(info, NULL);
> +}
> +
> +static void *sock_hash_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	struct sock_hash_seq_info *info = seq->private;
> +
> +	++*pos;
> +	return sock_hash_seq_find_next(info, v);
> +}
> +
> +static int __sock_hash_seq_show(struct seq_file *seq, struct bpf_shtab_elem *elem)
> +{
> +	struct sock_hash_seq_info *info = seq->private;
> +	struct bpf_iter__sockmap ctx = {};
> +	struct bpf_iter_meta meta;
> +	struct bpf_prog *prog;
> +
> +	meta.seq = seq;
> +	prog = bpf_iter_get_info(&meta, !elem);
> +	if (!prog)
> +		return 0;
> +
> +	ctx.meta = &meta;
> +	ctx.map = info->map;
> +	if (elem) {
> +		ctx.key = elem->key;
> +		ctx.sk = (struct bpf_sock *)elem->sk;
> +	}
> +
> +	return bpf_iter_run_prog(prog, &ctx);
> +}
> +
> +static int sock_hash_seq_show(struct seq_file *seq, void *v)
> +{
> +	return __sock_hash_seq_show(seq, v);
> +}
> +
> +static void sock_hash_seq_stop(struct seq_file *seq, void *v)
> +{
> +	if (!v)
> +		(void)__sock_hash_seq_show(seq, NULL);
> +
> +	/* pairs with sock_hash_seq_start */
> +	rcu_read_unlock();
> +}
> +
> +static const struct seq_operations sock_hash_seq_ops = {
> +	.start	= sock_hash_seq_start,
> +	.next	= sock_hash_seq_next,
> +	.stop	= sock_hash_seq_stop,
> +	.show	= sock_hash_seq_show,
> +};
> +
> +static int sock_hash_init_seq_private(void *priv_data,
> +				     struct bpf_iter_aux_info *aux)
> +{
> +	struct sock_hash_seq_info *info = priv_data;
> +
> +	info->map = aux->map;
> +	info->htab = container_of(aux->map, struct bpf_shtab, map);
> +	return 0;
> +}
> +
> +static const struct bpf_iter_seq_info sock_hash_iter_seq_info = {
> +	.seq_ops		= &sock_hash_seq_ops,
> +	.init_seq_private	= sock_hash_init_seq_private,
> +	.seq_priv_size		= sizeof(struct sock_hash_seq_info),
> +};
> +
>   static int sock_hash_map_btf_id;
>   const struct bpf_map_ops sock_hash_ops = {
>   	.map_alloc		= sock_hash_alloc,
> @@ -1211,6 +1435,7 @@ const struct bpf_map_ops sock_hash_ops = {
>   	.map_check_btf		= map_check_no_btf,
>   	.map_btf_name		= "bpf_shtab",
>   	.map_btf_id		= &sock_hash_map_btf_id,
> +	.iter_seq_info		= &sock_hash_iter_seq_info,
>   };
>   
>   static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
> @@ -1321,3 +1546,61 @@ void sock_map_close(struct sock *sk, long timeout)
>   	release_sock(sk);
>   	saved_close(sk, timeout);
>   }
> +
> +static int sock_map_iter_attach_target(struct bpf_prog *prog,
> +				       union bpf_iter_link_info *linfo,
> +				       struct bpf_iter_aux_info *aux)
> +{
> +	struct bpf_map *map;
> +	int err = -EINVAL;
> +
> +	if (!linfo->map.map_fd)
> +		return -EBADF;
> +
> +	map = bpf_map_get_with_uref(linfo->map.map_fd);
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	if (map->map_type != BPF_MAP_TYPE_SOCKMAP &&
> +	    map->map_type != BPF_MAP_TYPE_SOCKHASH)
> +		goto put_map;
> +
> +	if (prog->aux->max_rdonly_access > map->key_size) {
> +		err = -EACCES;
> +		goto put_map;
> +	}
> +
> +	aux->map = map;
> +	return 0;
> +
> +put_map:
> +	bpf_map_put_with_uref(map);
> +	return err;
> +}
> +
> +static void sock_map_iter_detach_target(struct bpf_iter_aux_info *aux)
> +{
> +	bpf_map_put_with_uref(aux->map);
> +}
> +
> +static struct bpf_iter_reg sock_map_iter_reg = {
> +	.target			= "sockmap",
> +	.attach_target		= sock_map_iter_attach_target,
> +	.detach_target		= sock_map_iter_detach_target,
> +	.show_fdinfo		= bpf_iter_map_show_fdinfo,
> +	.fill_link_info		= bpf_iter_map_fill_link_info,
> +	.ctx_arg_info_size	= 2,
> +	.ctx_arg_info		= {
> +		{ offsetof(struct bpf_iter__sockmap, key),
> +		  PTR_TO_RDONLY_BUF_OR_NULL },
> +		{ offsetof(struct bpf_iter__sockmap, sk),
> +		  PTR_TO_SOCKET_OR_NULL },
> +	},
> +	.seq_info		= &sock_map_iter_seq_info,

The .seq_info here is not needed here. The sock_map_iter_seq_info
or sock_hash_iter_seq_info already registered in corresponding
map_ops.

> +};
> +
> +static int __init bpf_sockmap_iter_init(void)
> +{
> +	return bpf_iter_reg_target(&sock_map_iter_reg);
> +}
> +late_initcall(bpf_sockmap_iter_init);
> 
