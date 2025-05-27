Return-Path: <bpf+bounces-59034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12B5AC5DDB
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 01:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FB11BA6737
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 23:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDBC20E6E6;
	Tue, 27 May 2025 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JioYweCT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D011F17EB
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748389644; cv=none; b=hYeYvqEP3MLiS9PsfVie8RtMR0PjTkLEmbMlvgdiSYB1MZDGJf6U5K9bPEcc10NHNVC44KyHk6fwrwIQv5goYzveDRZCoJpmrU1OPn0Ld/Y/jLPnZCMqVsRuhhk8F3GKn90mPtZQeq3SimcI+BHM6SLHwsClDs4Y6a0QvJEWO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748389644; c=relaxed/simple;
	bh=93fuf/ldw5Nu0SmrvQbGD1FoQi2xZ50NodD7+PXWOX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GTWx9DzwFyIIGhj7zwLD4MPZOJh0N8l2ZA5K8xafKrMMweNiFc4/ZqGPKIhdnoNxiPnMsxxN58SOoSCc39Gwn2qplWe1RNmGPXd8Lw3cLpKfZtxfXFKnWgBknHlRs6k81a4fSa4itvBCecrx0+Rju/EA99T+bLY5rV6XUJtl9MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JioYweCT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22e033a3a07so37496195ad.0
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 16:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748389642; x=1748994442; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KDjuww7W8of7rB9QwI5S4llRBlZ6TJ4OP986mqV1290=;
        b=JioYweCT7Y2dZ7+wszos9zhmztrItB2uwXNLp90G0hc5fYtzhbyCaoJOt3h3nyWyVS
         U+yaoJ6rjoOd27FK7tKX3UujhX+pZ9jaD61rGCbFK72RHPI5nLooeLZJfQyVk5uzNZpr
         MuRqlUjZzz8S7b7s4NvFrt37DYabX/3fK6WJVzcuYf7sbUFGgU9vqO/Gzr0zuZTiUIGR
         Eidil2ch0yRd56HDCO3C0Hk383hilPOx0FCOXxe+00wANWdGEBPJ0JwFPQBBl+P/lwiT
         9ZQhEMkGWXolF1EC5GjZX4iiXAf0wTRn/uzvUw5D3OFiXc4/rvXD4rnLSxl8j6DR89Ho
         gIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748389642; x=1748994442;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDjuww7W8of7rB9QwI5S4llRBlZ6TJ4OP986mqV1290=;
        b=vgpEKBPondXdjH3oTk+QuYZd17u6rRuz+k8aEWrwwTeKrqJhxoMcVU6kzc52Jt06G1
         wZykCXyDmhUTVpVgFxCEfeztDwdBPle6fE6YINPI7mJEfH5PksZxNgvHj1YgH7sXwF3G
         p/+gMWIgxuRzafKqPd5PMo9BYi8tm3QImxyLvfnkJzVCoQTPWbnEkUq1fejI3A/kIf+g
         HO/sxR5JEEzAXuwQnPDaG9Q984ahEZowlfjqLwRn0dMzmI8xSImbqGz60W7eZMkNWMGK
         /thqxQnUxZ16FT7D72Rvf/WIj1LSHYrKEailhAixn2aoFAc++VddUEa0SxBHHkquEY0p
         uY3Q==
X-Gm-Message-State: AOJu0YyCL+MU3Lxntt5s7oLScRO4zG8q2VgFY/NlKd4MTcOW4dUaQg/u
	BlY3l8eQv8mjnYZMYc+qLxGJ+g1Ay08iTpPSOb4+mbDRhr7vaTB7Ok9I
X-Gm-Gg: ASbGncuD3A+0yCbfi2zHMFfpL4DKo1OZV+PP5WsTIhEsftmGTmpwwQFUI3lvgmpxl0R
	9d3gG6vuEzBwlZXbPabssyg28bETOVfcr8sqm6hg31nngMXq7vaawbs0DPlQekrMW0el852Oz86
	512ccywCVuLYlfa/a7a0W7OYvvYNx4rLAyW2ZPzbfgxuNIYq9rtnndZBvAbzJ7Ry+9L4Vc0ooxz
	zoT06m0XRii7T6wJoE3Db2NQAHZz2Ot/Dn2iMSFejcm+RvHjAUbqJfvtE1oMAIYNRiJU3Nyzt4W
	kqhlzBDK8aYz8T29IJnUq0Qqx6lwQy3yRFsv73tlvVZijN2zXneCjqs=
X-Google-Smtp-Source: AGHT+IE+RKCPvOLHi0A4xUnlqiYYgjDnxnMemPUWTu/Rt9HSdQkYB5x9ZqAMg3XYvd3dVtMt8mhX1A==
X-Received: by 2002:a17:903:2f8c:b0:234:bca7:292e with SMTP id d9443c01a7336-234bca735e8mr32855155ad.14.1748389641659;
        Tue, 27 May 2025 16:47:21 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::7:461c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234cc120abfsm1588115ad.102.2025.05.27.16.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 16:47:21 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  kkd@meta.com,  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 01/11] bpf: Introduce BPF standard streams
In-Reply-To: <20250524011849.681425-2-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Fri, 23 May 2025 18:18:39 -0700")
References: <20250524011849.681425-1-memxor@gmail.com>
	<20250524011849.681425-2-memxor@gmail.com>
Date: Tue, 27 May 2025 16:47:18 -0700
Message-ID: <m2cybt62gp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

Overall logic seems right to me, a few comments below.

[...]

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5b25d278409b..d298746f4dcc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1538,6 +1538,41 @@ struct btf_mod_pair {
>  
>  struct bpf_kfunc_desc_tab;
>  
> +enum bpf_stream_id {
> +	BPF_STDOUT = 1,
> +	BPF_STDERR = 2,
> +};
> +
> +struct bpf_stream_elem {
> +	struct llist_node node;
> +	int total_len;
> +	int consumed_len;
> +	char str[];
> +};
> +
> +struct bpf_stream_elem_batch {
> +	struct llist_node *node;
> +};

This type is not used anymore.

> +
> +enum {
> +	BPF_STREAM_MAX_CAPACITY = (4 * 1024U * 1024U),
> +};
> +
> +struct bpf_stream {
> +	enum bpf_stream_id stream_id;

Nit: `stream_id` is never read, as streams are identified by a position
     in the bpf_prog_aux->stream.

> +	atomic_t capacity;
> +	struct llist_head log;
> +
> +	rqspinlock_t lock;
> +	struct llist_node *backlog_head;
> +	struct llist_node *backlog_tail;

Nit: maybe add comments describing what kind of data is in the llist_{head,node}? E.g.:

	atomic_t capacity;
	struct llist_head log;		 /* list of struct bpf_stream_elem in LIFO order */

	rqspinlock_t lock;		 /* backlog_{head,tail} lock */
	struct llist_node *backlog_head; /* list of struct bpf_stream_elem in FIFO order */
	struct llist_node *backlog_tail;


> +};
> +
> +struct bpf_stream_stage {
> +	struct llist_head log;
> +	int len;
> +};
> +

[...]

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> new file mode 100644
> index 000000000000..b9e6f7a43b1b
> --- /dev/null
> +++ b/kernel/bpf/stream.c

[...]

> +int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
> +			    enum bpf_stream_id stream_id)
> +{
> +	struct llist_node *list, *head, *tail;
> +	struct bpf_stream *stream;
> +	int ret;
> +
> +	stream = bpf_stream_get(stream_id, prog->aux);
> +	if (!stream)
> +		return -EINVAL;
> +
> +	ret = bpf_stream_consume_capacity(stream, ss->len);
> +	if (ret)
> +		return ret;
> +
> +	list = llist_del_all(&ss->log);
> +	head = list;
> +
> +	if (!list)
> +		return 0;
> +	while (llist_next(list)) {
> +		tail = llist_next(list);
> +		list = tail;
> +	}
> +	llist_add_batch(head, tail, &stream->log);

If `llist_next(list) == NULL` at entry `tail` is never assigned?

> +	return 0;
> +}

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d5807d2efc92..5ab8742d2c00 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13882,10 +13882,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			regs[BPF_REG_0].type = PTR_TO_BTF_ID;
>  			regs[BPF_REG_0].btf_id = ptr_type_id;
>  
> -			if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
> +			if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache]) {
>  				regs[BPF_REG_0].type |= PTR_UNTRUSTED;
> -
> -			if (is_iter_next_kfunc(&meta)) {
> +			} else if (is_iter_next_kfunc(&meta)) {

Nit: unrelated change?

>  				struct bpf_reg_state *cur_iter;
>  
>  				cur_iter = get_iter_from_state(env->cur_state, &meta);

[...]

