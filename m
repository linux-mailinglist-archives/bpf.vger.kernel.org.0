Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F05D25B2EE
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 19:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIBR3z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 13:29:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37650 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIBR3y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Sep 2020 13:29:54 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082HTZn5011217;
        Wed, 2 Sep 2020 10:29:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DssT1jt+M43PgJxmY5ulPUrSVbsOLfqGmKdqsD0movI=;
 b=NrVxfLOxaWah1XYq9vlHmwQPn9sTr1ULojovdkm5wZSOD7lqa5sP05LPwgSRTq5U8JLc
 qnBuoLOEAdEGW0mX/clegPOlUprj50piixuiWBn82W/Bv9Fdk/TJfSLyXM+ZLnI/AbaJ
 KwgooCExKvWKG4ufW5hwkKKnlHJXKZif4lE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33ae5ugs1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Sep 2020 10:29:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Sep 2020 10:29:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjiY8Qlh9AS8SaE/FbSgv/LPXSQlHFf2z9K4KqjHzFJerW66hMqDGGqhzqRyPYd6IPOm9DU0if2acZZ6ANZNYBfXzi8QTeCaWeRtsn/UEiSV2d3x7bxdWvrByCUbJufBeSJdmKfMglLgeA5O3ioKCNAedkC0cCq/V8ckMBkm69uifgLFfkSK3gzUkxlsUHi74jRjuGbJdqIigZ23dCyiuIgELdFbSkGBy1n/r1inAkD0fM/qPNV4dZqXamTQDkBIeEQKTM/hMNgUQaVZ526fEa0M0YPpSULijrNTvVH7aCJv+OLmsYzzWWL0fu6L2zmfLfCGJQGaMZ+r8timqs/ECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DssT1jt+M43PgJxmY5ulPUrSVbsOLfqGmKdqsD0movI=;
 b=fDC8f/US0Ym+KnJva6+PSzex9AFJzYdZQ5vGK0fmOi/8JGjuKecX4tOXRQ/5CMLrUEy99GAEjh5Gev1XMY7BcKby9/+0z397qRqseGNJriCqsQOqxYL1TgJT5jWKT3nQ+PKhNkXjhlDXCWOrJGe/AGjg0Q9Jvh7DlBioXRBNmdRUfGo1GwOkoFrjSqWm+9c/4QCV2zOKfFMtL88cK2AI8zUTc7e8/ILwceD6OwoR//gXcWy02vu3Uj0rjnluxWnfce0r5tK31qVg8uSqnAOQ6myFjdL/n00B+oOaxgtjOL6+bo6RCDN1uOhtGazF288uG4K9tt0vxhpykCWqJ5cIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DssT1jt+M43PgJxmY5ulPUrSVbsOLfqGmKdqsD0movI=;
 b=WSTItEAVtJBCseA64CpkuRLnPTlHUB68WOsx69VYUttkjWzpKPGThHzcJPoW7rQwCO2LeSeLdLQGOv9hwL0B0hXAbb8M/vzp/d+KAlN/GhyTRVaKJrxS2SwGBUCu3R9/3L4JX7fbOItX9W6urtybvo2H6VaXiILgJuuXeO51o94=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3368.namprd15.prod.outlook.com (2603:10b6:a03:102::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 2 Sep
 2020 17:29:03 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 17:29:03 +0000
Subject: Re: [PATCH bpf-next v2 2/4] net: Allow iterating sockmap and sockhash
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
References: <20200901103210.54607-1-lmb@cloudflare.com>
 <20200901103210.54607-3-lmb@cloudflare.com>
 <770162b0-7511-8d21-4d34-cb9b8aa191d0@fb.com>
 <CACAyw9-c6m_-ezAR7yPk=APMgCLJxQtOrNQrxyWGE1TFA0tG1g@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d9bd48d8-7e4e-3f12-4ba0-793e244f6934@fb.com>
Date:   Wed, 2 Sep 2020 10:29:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <CACAyw9-c6m_-ezAR7yPk=APMgCLJxQtOrNQrxyWGE1TFA0tG1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:74::16) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:74::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Wed, 2 Sep 2020 17:29:02 +0000
X-Originating-IP: [2620:10d:c090:400::5:b612]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3640463b-1218-4866-4a37-08d84f65af98
X-MS-TrafficTypeDiagnostic: BYAPR15MB3368:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3368382C5442FE4C0219B3CBD32F0@BYAPR15MB3368.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vJOhvFMHZGfYD9rzYVEtjf9VQ5IQzHp29MtFCC8wuUZ+iO7H1JSIgO/9xWhgBscHmOjLFmcG7kqHa5TMpiQ2sTPt2dAdrqgzT5Rsas9R1sJRnL7fkYk0d6BtVi68fcvQYdv3EgZVMQ5zh6cxs9UEiY/bi0ZZVNAJuAPfPnqTAI9a/J6i+xYiBWXNtd77/sqFhmt9P4mS11LkC3fsrnB7ElyFXrbQDfBjpEHmn6aUHjjZyGld1Wv+QEiMI7d4xQrpUnDx0WGyqDmaLZCYZms1TE5OPDKBII3A+MhJcVSADWIQ2ne7etZq1S3hcJdznkiC6AgCoUupav7q49JkdSzkbr6Syo82jaVm8CFhARDMP8Ftk++bWBiKcV0n6uaqHBG8TITSvMKmDHlLx6d3s1G3oXRrSZIXvHYkWvO+Nm2YyQ4Zn6wneFhYKPyEcmeyPlAILdJk4e8I0+GNmrjoisUJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(396003)(136003)(8936002)(956004)(2906002)(5660300002)(30864003)(31686004)(186003)(16576012)(2616005)(53546011)(6916009)(6486002)(8676002)(66946007)(66556008)(54906003)(52116002)(478600001)(316002)(966005)(66476007)(4326008)(36756003)(31696002)(83380400001)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OCB6gJNxGWeeIaIY5EjZcyxKgXu7rF/mzGl2bp/lsGxvRqA1clu7mITdxILdusa5PsL238In9kQK2ooUPYInKsX0Q1+fQDC7AAin5tJcoA2jaTVIVjEGoYjHebvWg03f9H1NKSyGYFeOELNE/QKyiVfwB7JKhBF+mY+4vujStGA/0QxXpNxmKiKrri7M25SlJ0ikLfp8uP27J3f51CpsACjdspFHVmsHlQ3PFt2zs6uLb426Rj4YwfXtXv3vmBgYEZZipr+AU1v+Ggng31IIVn+cPoKi+vhtTFF6zAaOGa2VUcCaIODQLTAmI2FCyLYQq9leBDwJ2pWpsKDM6VJTORdYgAHPZnpTi286A3rZnpMblsdtuPyBCEtzifqPRgCnHHDQ2TPSLW/izdlOqQfW31Q606L8vD35dlJwyW4DVtBKENeHoaftC/QA1o83EXtJRg7cvoBIbmq+Qn/E7QSvRAmdTRovqDMCWlfzEB9uU6k3mij03iUmTs/2ONd09eh5zaIIWIMbI2xsGs5VfpeN0ENtGHT+G9BWJgyS0wLe/e+/IA4PhNFkWgNRUVc4BQdxnf1U42tSQucafhq/HqNz2NhA19TeSzsG3DEbKy+dEnJuKEcSxs25sCJG0XTf0jEyMa4kpJcYXrhNbQQtwehWj8VnzCRw+5ZnZRpKySbUpRA=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3640463b-1218-4866-4a37-08d84f65af98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 17:29:03.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwT7qWJZ8qNLZyyarExa8ztYhP63RcifwRoFLTOkRhuYGUd/lGy5TJgbX5iPlzs+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3368
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_12:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020166
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/2/20 1:58 AM, Lorenz Bauer wrote:
> On Wed, 2 Sep 2020 at 06:08, Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 9/1/20 3:32 AM, Lorenz Bauer wrote:
>>> Add bpf_iter support for sockmap / sockhash, based on the bpf_sk_storage and
>>> hashtable implementation. sockmap and sockhash share the same iteration
>>> context: a pointer to an arbitrary key and a pointer to a socket. Both
>>> pointers may be NULL, and so BPF has to perform a NULL check before accessing
>>> them. Technically it's not possible for sockhash iteration to yield a NULL
>>> socket, but we ignore this to be able to use a single iteration point.
>>
>> There seems some misunderstanding about when the NULL object may be
>> passed to the bpf program. The original design is to always pass valid
>> object except the last iteration. If you see a NULL object (key/sock),
>> that means it is the end of iteration, so you can finish aggregating
>> the data and may send them to the user space.
>>
>> Sending NULL object in the middle of iterations is bad as bpf program
>> will just check NULL and returns.
>>
>> The current arraymap iterator returns valid value for each index
>> in the range. Since even if user did not assign anything for an index,
>> the kernel still allocates storage for that index with default value 0.
> 
> I think that the current behaviour is actually in line with the NULL:
> while sk may be NULL during iteration, key is guaranteed to be !NULL
> except on the last iteration. This holds for sockmap and sockhash.
> 
> The wording of the commit message is a bit lacking. I'm trying to say
> that for sockhash, ctx->sk will never be NULL (except during) the last
> iteration. So in theory, sockhash could use a distinct context which
> uses PTR_TO_SOCKET instead of PTR_TO_SOCKET_OR_NULL. However, I think
> a single context for both sockmap and sockhash is nicer.
> 
>>
>> For sockmap, it looks it is possible that some index may contain NULL
>> socket pointer. I suggest skip these array elements and already returns
>> a non-NULL object.
> 
> I think this would make sockmap inconsistent with other array map
> iteration. It also breaks a use case: as you can see in the test, I
> use sk == NULL to trigger map_delete_elem in the target, instead of
> map_update_elem.

Sorry, I missed this one (using sk == NULL to trigger map_delete_elem)
in the test case.
I thought that key != NULL && sk == NULL is simply skipped by bpf 
program. If you have a use case for key != NULL && sk == NULL, yes,
you can pass to bpf program. So the current iterating of sockmap looks
okay to me.

> 
>>
>>>
>>> Iteration will visit all keys that remain unmodified during the lifetime of
>>> the iterator. It may or may not visit newly added ones.
>>>
>>> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
>>> ---
>>>    net/core/sock_map.c | 283 ++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 283 insertions(+)
>>>
>>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>>> index ffdf94a30c87..4767f9df2b8b 100644
>>> --- a/net/core/sock_map.c
>>> +++ b/net/core/sock_map.c
>>> @@ -703,6 +703,114 @@ const struct bpf_func_proto bpf_msg_redirect_map_proto = {
>>>        .arg4_type      = ARG_ANYTHING,
>>>    };
>>>
>>> +struct sock_map_seq_info {
>>> +     struct bpf_map *map;
>>> +     struct sock *sk;
>>> +     u32 index;
>>> +};
>>> +
>>> +struct bpf_iter__sockmap {
>>> +     __bpf_md_ptr(struct bpf_iter_meta *, meta);
>>> +     __bpf_md_ptr(struct bpf_map *, map);
>>> +     __bpf_md_ptr(void *, key);
>>> +     __bpf_md_ptr(struct bpf_sock *, sk);
>>> +};
>>> +
>>> +DEFINE_BPF_ITER_FUNC(sockmap, struct bpf_iter_meta *meta,
>>> +                  struct bpf_map *map, void *key,
>>> +                  struct sock *sk)
>>> +
>>> +static void *sock_map_seq_lookup_elem(struct sock_map_seq_info *info)
>>> +{
>>> +     if (unlikely(info->index >= info->map->max_entries))
>>> +             return NULL;
>>> +
>>> +     info->sk = __sock_map_lookup_elem(info->map, info->index);
>>> +
>>> +     /* can't return sk directly, since that might be NULL */
>>
>> As said in the above, suggest to skip NULL socket and always return
>> valid non-NULL socket.
>>
>>> +     return info;
>>> +}
>>> +
>>> +static void *sock_map_seq_start(struct seq_file *seq, loff_t *pos)
>>> +{
>>> +     struct sock_map_seq_info *info = seq->private;
>>> +
>>> +     if (*pos == 0)
>>> +             ++*pos;
>>> +
>>> +     /* pairs with sock_map_seq_stop */
>>> +     rcu_read_lock();
>>> +     return sock_map_seq_lookup_elem(info);
>>> +}
>>> +
>>> +static void *sock_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>>> +{
>>> +     struct sock_map_seq_info *info = seq->private;
>>> +
>>> +     ++*pos;
>>> +     ++info->index;
>>> +
>>> +     return sock_map_seq_lookup_elem(info);
>>> +}
>>> +
>>> +static int __sock_map_seq_show(struct seq_file *seq, void *v)
>>> +{
>>> +     struct sock_map_seq_info *info = seq->private;
>>> +     struct bpf_iter__sockmap ctx = {};
>>> +     struct bpf_iter_meta meta;
>>> +     struct bpf_prog *prog;
>>> +
>>> +     meta.seq = seq;
>>> +     prog = bpf_iter_get_info(&meta, !v);
>>> +     if (!prog)
>>> +             return 0;
>>> +
>>> +     ctx.meta = &meta;
>>> +     ctx.map = info->map;
>>> +     if (v) {
>>> +             ctx.key = &info->index;
>>> +             ctx.sk = (struct bpf_sock *)info->sk;
>>> +     }
>>> +
>>> +     return bpf_iter_run_prog(prog, &ctx);
>>> +}
>>> +
>>> +static int sock_map_seq_show(struct seq_file *seq, void *v)
>>> +{
>>> +     return __sock_map_seq_show(seq, v);
>>> +}
>>> +
>>> +static void sock_map_seq_stop(struct seq_file *seq, void *v)
>>> +{
>>> +     if (!v)
>>> +             (void)__sock_map_seq_show(seq, NULL);
>>> +
>>> +     /* pairs with sock_map_seq_start */
>>> +     rcu_read_unlock();
>>> +}
>>> +
>>> +static const struct seq_operations sock_map_seq_ops = {
>>> +     .start  = sock_map_seq_start,
>>> +     .next   = sock_map_seq_next,
>>> +     .stop   = sock_map_seq_stop,
>>> +     .show   = sock_map_seq_show,
>>> +};
>>> +
>>> +static int sock_map_init_seq_private(void *priv_data,
>>> +                                  struct bpf_iter_aux_info *aux)
>>> +{
>>> +     struct sock_map_seq_info *info = priv_data;
>>> +
>>> +     info->map = aux->map;
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct bpf_iter_seq_info sock_map_iter_seq_info = {
>>> +     .seq_ops                = &sock_map_seq_ops,
>>> +     .init_seq_private       = sock_map_init_seq_private,
>>> +     .seq_priv_size          = sizeof(struct sock_map_seq_info),
>>> +};
>>> +
>>>    static int sock_map_btf_id;
>>>    const struct bpf_map_ops sock_map_ops = {
>>>        .map_alloc              = sock_map_alloc,
>>> @@ -716,6 +824,7 @@ const struct bpf_map_ops sock_map_ops = {
>>>        .map_check_btf          = map_check_no_btf,
>>>        .map_btf_name           = "bpf_stab",
>>>        .map_btf_id             = &sock_map_btf_id,
>>> +     .iter_seq_info          = &sock_map_iter_seq_info,
>>>    };
>>>
>>>    struct bpf_shtab_elem {
>>> @@ -1198,6 +1307,121 @@ const struct bpf_func_proto bpf_msg_redirect_hash_proto = {
>>>        .arg4_type      = ARG_ANYTHING,
>>>    };
>>>
>>> +struct sock_hash_seq_info {
>>> +     struct bpf_map *map;
>>> +     struct bpf_shtab *htab;
>>> +     u32 bucket_id;
>>> +};
>>> +
>>> +static void *sock_hash_seq_find_next(struct sock_hash_seq_info *info,
>>> +                                  struct bpf_shtab_elem *prev_elem)
>>> +{
>>> +     const struct bpf_shtab *htab = info->htab;
>>> +     struct bpf_shtab_bucket *bucket;
>>> +     struct bpf_shtab_elem *elem;
>>> +     struct hlist_node *node;
>>> +
>>> +     /* try to find next elem in the same bucket */
>>> +     if (prev_elem) {
>>> +             node = rcu_dereference_raw(hlist_next_rcu(&prev_elem->node));
>>> +             elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
>>> +             if (elem)
>>> +                     return elem;
>>> +
>>> +             /* no more elements, continue in the next bucket */
>>> +             info->bucket_id++;
>>> +     }
>>
>> Looks like there are some earlier discussion on lock is not needed here?
>> It would be good to add some comments here.
> 
> I've discussed it with Jakub off-list, but I was hoping that either
> you or John can weigh in here. I think taking the bucket lock is
> actually dangerous and could lead to a deadlock if the iterator
> triggers an update of the same bucket.
> 
> Parts of sockhash were probably copied from the regular hashtable, so
> maybe you can shed some light why the hashtable iterator takes the
> bucket lock?

We need to take bucket lock since another bpf program might be 
update/delete elements in the hash table. In that case, bpf program
may see the garbage value.  We did not use rcu read lock, which
is certainly another option.

To support the deletion during iterating, the original thinking
is to accumulate the keys to be deleted and deleting them after
the whole bucket has been visited and bucket lock is released.
This is not implemented yet. This might apply to update as well.

You brought up a good point here. Currently for hashmap and
sk_storage_map iterators, bucket lock is taken, this will have
issues if the same map is updated or deleted in bpf program.
rcu read lock might be a good alternative here unless we want
verifier to restrict the visited map should not have update/delete
operation in the bpf program. Will look into it more.

Another data point, existing netlink iterator also uses 
rcu_read_{lock,unlock}.
  seq_ops->start():
      rcu_read_lock();
  seq_ops->next():
      rcu_read_unlock();
      /* next element */
      rcu_read_lock();
  seq_ops->stop();
      rcu_read_unlock();

> 
>>
>>> +     for (; info->bucket_id < htab->buckets_num; info->bucket_id++) {
>>> +             bucket = &htab->buckets[info->bucket_id];
>>> +             node = rcu_dereference_raw(hlist_first_rcu(&bucket->head));
>>> +             elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
>>> +             if (elem)
>>> +                     return elem;
>>> +     }
>>> +
>>> +     return NULL;
>>> +}
>>> +
>>> +static void *sock_hash_seq_start(struct seq_file *seq, loff_t *pos)
>>> +{
>>> +     struct sock_hash_seq_info *info = seq->private;
>>> +
>>> +     if (*pos == 0)
>>> +             ++*pos;
>>> +
>>> +     /* pairs with sock_hash_seq_stop */
>>> +     rcu_read_lock();
>>> +     return sock_hash_seq_find_next(info, NULL);
>>> +}
>>> +
>>> +static void *sock_hash_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>>> +{
>>> +     struct sock_hash_seq_info *info = seq->private;
>>> +
>>> +     ++*pos;
>>> +     return sock_hash_seq_find_next(info, v);
>>> +}
>>> +
>>> +static int __sock_hash_seq_show(struct seq_file *seq, struct bpf_shtab_elem *elem)
>>> +{
>>> +     struct sock_hash_seq_info *info = seq->private;
>>> +     struct bpf_iter__sockmap ctx = {};
>>> +     struct bpf_iter_meta meta;
>>> +     struct bpf_prog *prog;
>>> +
>>> +     meta.seq = seq;
>>> +     prog = bpf_iter_get_info(&meta, !elem);
>>> +     if (!prog)
>>> +             return 0;
>>> +
>>> +     ctx.meta = &meta;
>>> +     ctx.map = info->map;
>>> +     if (elem) {
>>> +             ctx.key = elem->key;
>>> +             ctx.sk = (struct bpf_sock *)elem->sk;
>>> +     }
>>> +
>>> +     return bpf_iter_run_prog(prog, &ctx);
>>> +}
>>> +
>>> +static int sock_hash_seq_show(struct seq_file *seq, void *v)
>>> +{
>>> +     return __sock_hash_seq_show(seq, v);
>>> +}
>>> +
>>> +static void sock_hash_seq_stop(struct seq_file *seq, void *v)
>>> +{
>>> +     if (!v)
>>> +             (void)__sock_hash_seq_show(seq, NULL);
>>> +
>>> +     /* pairs with sock_hash_seq_start */
>>> +     rcu_read_unlock();
>>> +}
>>> +
>>> +static const struct seq_operations sock_hash_seq_ops = {
>>> +     .start  = sock_hash_seq_start,
>>> +     .next   = sock_hash_seq_next,
>>> +     .stop   = sock_hash_seq_stop,
>>> +     .show   = sock_hash_seq_show,
>>> +};
>>> +
>>> +static int sock_hash_init_seq_private(void *priv_data,
>>> +                                  struct bpf_iter_aux_info *aux)
>>> +{
>>> +     struct sock_hash_seq_info *info = priv_data;
>>> +
>>> +     info->map = aux->map;
>>> +     info->htab = container_of(aux->map, struct bpf_shtab, map);
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct bpf_iter_seq_info sock_hash_iter_seq_info = {
>>> +     .seq_ops                = &sock_hash_seq_ops,
>>> +     .init_seq_private       = sock_hash_init_seq_private,
>>> +     .seq_priv_size          = sizeof(struct sock_hash_seq_info),
>>> +};
>>> +
>>>    static int sock_hash_map_btf_id;
>>>    const struct bpf_map_ops sock_hash_ops = {
>>>        .map_alloc              = sock_hash_alloc,
>>> @@ -1211,6 +1435,7 @@ const struct bpf_map_ops sock_hash_ops = {
>>>        .map_check_btf          = map_check_no_btf,
>>>        .map_btf_name           = "bpf_shtab",
>>>        .map_btf_id             = &sock_hash_map_btf_id,
>>> +     .iter_seq_info          = &sock_hash_iter_seq_info,
>>>    };
>>>
>>>    static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
>>> @@ -1321,3 +1546,61 @@ void sock_map_close(struct sock *sk, long timeout)
>>>        release_sock(sk);
>>>        saved_close(sk, timeout);
>>>    }
>>> +
>>> +static int sock_map_iter_attach_target(struct bpf_prog *prog,
>>> +                                    union bpf_iter_link_info *linfo,
>>> +                                    struct bpf_iter_aux_info *aux)
>>> +{
>>> +     struct bpf_map *map;
>>> +     int err = -EINVAL;
>>> +
>>> +     if (!linfo->map.map_fd)
>>> +             return -EBADF;
>>> +
>>> +     map = bpf_map_get_with_uref(linfo->map.map_fd);
>>> +     if (IS_ERR(map))
>>> +             return PTR_ERR(map);
>>> +
>>> +     if (map->map_type != BPF_MAP_TYPE_SOCKMAP &&
>>> +         map->map_type != BPF_MAP_TYPE_SOCKHASH)
>>> +             goto put_map;
>>> +
>>> +     if (prog->aux->max_rdonly_access > map->key_size) {
>>> +             err = -EACCES;
>>> +             goto put_map;
>>> +     }
>>> +
>>> +     aux->map = map;
>>> +     return 0;
>>> +
>>> +put_map:
>>> +     bpf_map_put_with_uref(map);
>>> +     return err;
>>> +}
>>> +
>>> +static void sock_map_iter_detach_target(struct bpf_iter_aux_info *aux)
>>> +{
>>> +     bpf_map_put_with_uref(aux->map);
>>> +}
>>> +
>>> +static struct bpf_iter_reg sock_map_iter_reg = {
>>> +     .target                 = "sockmap",
>>> +     .attach_target          = sock_map_iter_attach_target,
>>> +     .detach_target          = sock_map_iter_detach_target,
>>> +     .show_fdinfo            = bpf_iter_map_show_fdinfo,
>>> +     .fill_link_info         = bpf_iter_map_fill_link_info,
>>> +     .ctx_arg_info_size      = 2,
>>> +     .ctx_arg_info           = {
>>> +             { offsetof(struct bpf_iter__sockmap, key),
>>> +               PTR_TO_RDONLY_BUF_OR_NULL },
>>> +             { offsetof(struct bpf_iter__sockmap, sk),
>>> +               PTR_TO_SOCKET_OR_NULL },
>>> +     },
>>> +     .seq_info               = &sock_map_iter_seq_info,
>>
>> The .seq_info here is not needed here. The sock_map_iter_seq_info
>> or sock_hash_iter_seq_info already registered in corresponding
>> map_ops.
> 
> Ack.
> 
> 
>>
>>> +};
>>> +
>>> +static int __init bpf_sockmap_iter_init(void)
>>> +{
>>> +     return bpf_iter_reg_target(&sock_map_iter_reg);
>>> +}
>>> +late_initcall(bpf_sockmap_iter_init);
>>>
> 
> 
> 
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
> 
> https://urldefense.proofpoint.com/v2/url?u=http-3A__www.cloudflare.com&d=DwIBaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=BteHwk9J57c1AK2H61fPmukqxtl7p3ULOX0Wh33EHRY&s=wOObIqNJV3t4PuUNP8wjKVpF6Jdg0KWurobhHNjpbuw&e=
> 
