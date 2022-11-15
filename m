Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADFF62A1B4
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 20:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKOTQX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 14:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKOTQX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 14:16:23 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7239212083
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 11:16:21 -0800 (PST)
Message-ID: <33b5fc4e-be12-3aa8-b063-47aa998b951c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668539780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYYSYZHcg3nPCqrrTa0lZUWDeIYN9RtJ5/NHhDQjFhg=;
        b=mFAM/vxaiKORXF0e9cd3fz3g5RVrt03dlkv6tVrkk/N5k8EMECsR6jFHataS/dRqvGBI2u
        GYfseYb+1MdT3mi82zLQM/NLshe8DSeFM9WyjtN3JmguOSpsR3k/fWGsjn+38xV9mzjZgz
        Hols8wTXvUNvGywGqiYA3+fFl510jxw=
Date:   Tue, 15 Nov 2022 11:16:15 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
 <20221111063417.1603111-2-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221111063417.1603111-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/10/22 10:34 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> For many bpf iterator (e.g., cgroup iterator), iterator link acquires
> the reference of iteration target in .attach_target(), but iterator link
> may be closed before or in the middle of iteration, so iterator will
> need to acquire the reference of iteration target as well to prevent
> potential use-after-free. To avoid doing the acquisition in
> .init_seq_private() for each iterator type, just pin iterator link in
> iterator.

iiuc, a link currently will go away when all its fds closed and pinned file 
removed.  After this change, the link will stay until the last iter is closed(). 
  Before then, the user space can still "bpftool link show" and even get the 
link back by bpf_link_get_fd_by_id().  If this is the case, it would be useful 
to explain it in the commit message.

and does this new behavior make sense when comparing with other link types?

> 
> Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   kernel/bpf/bpf_iter.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 5dc307bdeaeb..67d899011cb2 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -20,7 +20,7 @@ struct bpf_iter_link {
>   };
>   
>   struct bpf_iter_priv_data {
> -	struct bpf_iter_target_info *tinfo;
> +	struct bpf_iter_link *link;
>   	const struct bpf_iter_seq_info *seq_info;
>   	struct bpf_prog *prog;
>   	u64 session_id;
> @@ -79,7 +79,7 @@ static bool bpf_iter_support_resched(struct seq_file *seq)
>   
>   	iter_priv = container_of(seq->private, struct bpf_iter_priv_data,
>   				 target_private);
> -	return bpf_iter_target_support_resched(iter_priv->tinfo);
> +	return bpf_iter_target_support_resched(iter_priv->link->tinfo);
>   }
>   
>   /* maximum visited objects before bailing out */
> @@ -276,6 +276,7 @@ static int iter_release(struct inode *inode, struct file *file)
>   		iter_priv->seq_info->fini_seq_private(seq->private);
>   
>   	bpf_prog_put(iter_priv->prog);
> +	bpf_link_put(&iter_priv->link->link);
>   	seq->private = iter_priv;
>   
>   	return seq_release_private(inode, file);
> @@ -576,11 +577,19 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
>   }
>   
>   static void init_seq_meta(struct bpf_iter_priv_data *priv_data,
> -			  struct bpf_iter_target_info *tinfo,
> +			  struct bpf_iter_link *link,
>   			  const struct bpf_iter_seq_info *seq_info,
>   			  struct bpf_prog *prog)
>   {
> -	priv_data->tinfo = tinfo;
> +	/* For many bpf iterator, iterator link acquires the reference of
> +	 * iteration target in .attach_target(), but iterator link may be
> +	 * closed before or in the middle of iteration, so iterator will
> +	 * need to acquire the reference of iteration target as well. To
> +	 * avoid doing the acquisition in .init_seq_private() for each
> +	 * iterator type, just pin iterator link in iterator.
> +	 */
> +	bpf_link_inc(&link->link);
> +	priv_data->link = link;
>   	priv_data->seq_info = seq_info;
>   	priv_data->prog = prog;
>   	priv_data->session_id = atomic64_inc_return(&session_id);
> @@ -592,7 +601,6 @@ static int prepare_seq_file(struct file *file, struct bpf_iter_link *link,
>   			    const struct bpf_iter_seq_info *seq_info)
>   {
>   	struct bpf_iter_priv_data *priv_data;
> -	struct bpf_iter_target_info *tinfo;
>   	struct bpf_prog *prog;
>   	u32 total_priv_dsize;
>   	struct seq_file *seq;
> @@ -603,7 +611,6 @@ static int prepare_seq_file(struct file *file, struct bpf_iter_link *link,
>   	bpf_prog_inc(prog);
>   	mutex_unlock(&link_mutex);
>   
> -	tinfo = link->tinfo;
>   	total_priv_dsize = offsetof(struct bpf_iter_priv_data, target_private) +
>   			   seq_info->seq_priv_size;
>   	priv_data = __seq_open_private(file, seq_info->seq_ops,
> @@ -619,7 +626,7 @@ static int prepare_seq_file(struct file *file, struct bpf_iter_link *link,
>   			goto release_seq_file;
>   	}
>   
> -	init_seq_meta(priv_data, tinfo, seq_info, prog);
> +	init_seq_meta(priv_data, link, seq_info, prog);
>   	seq = file->private_data;
>   	seq->private = priv_data->target_private;
>   

