Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C8E146197
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 06:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgAWFjc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 00:39:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41497 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWFjc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 00:39:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so779044pgk.8;
        Wed, 22 Jan 2020 21:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=522Me73twh2nTYCu4hIkEamQ+hvQqmKh9bh03C17Xgg=;
        b=biECtVc3WF7mpVNb+rOtM9ClESkGxqr3sPZxfkJXyVFFCz2PuyrsZumnWXHcxWFEkv
         PiWdXpD+QVyh5RwykXpvo/y9y5ozaEgLY9CWRAo+I/YV7+63njkmfn/H4Vlvix2PEL3h
         rt1oCzyhMrF1MHd5LQxlN3yqZsMDWwWPiJNnQa4yy6ypzQbNfHr4hUQku+OjfTfLcrqB
         6qdhuMqAeZVa4NtCa/nR7OuTvDoVTV6gUCdY0QBw/Zdv3O5vB0UjrG0OzUJNBxyhJqZx
         ylg39RWYArBduTmQdfeILP5Fw+TyqG8E5G6uoKY+YJSOK94zqCEY3DraD4LFdmLO21aa
         AhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=522Me73twh2nTYCu4hIkEamQ+hvQqmKh9bh03C17Xgg=;
        b=pO9L/bIT0cMn1aQIKV86ouuHwrFcK3ARAgQ25UE0/eqvQgZYxYqkxbk55yxIJfhsoV
         vs/dI5eQw/HkxzPnpe6dHyfddZoD1EhWTtGykFr2oGV/ujjlwEJsRvLcvqJoROUba3YV
         JNUqoI55t9Te7KzW6dSl8xTFow2FHVkqnnvLlwRrgqR1zYPgQaS6X4ADtWpfBglZ7GyF
         ScsijHJ/0+kQBndJb80nBSPsTJwQ5ESkn4klDrIt9ZMwnUuvWF/9ixFDluftsxdSg3+3
         PxXVo8Mb0KVbzNd/DaQKja61iufx9MLn18W/7UQ1WS2N5QPSqccpQ9JwXj3f/hMXnJhb
         rmmA==
X-Gm-Message-State: APjAAAUOVG1a58o0QJKAvfPIHk+vzPN9ClcAn6lgJLAnFVbOh9EgYzz/
        /RlFESjudt1SzC8bDB63qwncjoYp
X-Google-Smtp-Source: APXvYqwvYftf6cYBhtE6CDjxHWZ49NFhmJOGdHzSWMM/8zK4aWYWOaWtHe6orEcvdndyPYRDaJilMg==
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr2087578pgk.357.1579757971574;
        Wed, 22 Jan 2020 21:39:31 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id b126sm927914pga.19.2020.01.22.21.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 21:39:30 -0800 (PST)
Date:   Wed, 22 Jan 2020 21:39:21 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Message-ID: <5e293189e298d_1bc42ab516c865b8a1@john-XPS-13-9370.notmuch>
In-Reply-To: <20200122202220.21335-2-dxu@dxuuu.xyz>
References: <20200122202220.21335-1-dxu@dxuuu.xyz>
 <20200122202220.21335-2-dxu@dxuuu.xyz>
Subject: RE: [PATCH v2 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Xu wrote:
> Branch records are a CPU feature that can be configured to record
> certain branches that are taken during code execution. This data is
> particularly interesting for profile guided optimizations. perf has had
> branch record support for a while but the data collection can be a bit
> coarse grained.
> 
> We (Facebook) have seen in experiments that associating metadata with
> branch records can improve results (after postprocessing). We generally
> use bpf_probe_read_*() to get metadata out of userspace. That's why bpf
> support for branch records is useful.
> 
> Aside from this particular use case, having branch data available to bpf
> progs can be useful to get stack traces out of userspace applications
> that omit frame pointers.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/uapi/linux/bpf.h | 13 ++++++++++++-
>  kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 033d90a2282d..7350c5be6158 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2885,6 +2885,16 @@ union bpf_attr {
>   *		**-EPERM** if no permission to send the *sig*.
>   *
>   *		**-EAGAIN** if bpf program can try again.
> + *
> + * int bpf_perf_prog_read_branches(struct bpf_perf_event_data *ctx, void *buf, u32 buf_size)
> + * 	Description
> + * 		For en eBPF program attached to a perf event, retrieve the
> + * 		branch records (struct perf_branch_entry) associated to *ctx*
> + * 		and store it in	the buffer pointed by *buf* up to size
> + * 		*buf_size* bytes.

It seems extra bytes in buf will be cleared. The number of bytes
copied is returned so I don't see any reason to clear the extra bytes I would
just let the BPF program do this if they care. But it should be noted in
the description at least.

> + * 	Return
> + *		On success, number of bytes written to *buf*. On error, a
> + *		negative value.
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -3004,7 +3014,8 @@ union bpf_attr {
>  	FN(probe_read_user_str),	\
>  	FN(probe_read_kernel_str),	\
>  	FN(tcp_send_ack),		\
> -	FN(send_signal_thread),
> +	FN(send_signal_thread),		\
> +	FN(perf_prog_read_branches),
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>   * function eBPF program intends to call
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 19e793aa441a..24c51272a1f7 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1028,6 +1028,35 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
>           .arg3_type      = ARG_CONST_SIZE,
>  };
>  
> +BPF_CALL_3(bpf_perf_prog_read_branches, struct bpf_perf_event_data_kern *, ctx,
> +	   void *, buf, u32, size)
> +{
> +	struct perf_branch_stack *br_stack = ctx->data->br_stack;
> +	u32 to_copy = 0, to_clear = size;
> +	int err = -EINVAL;
> +
> +	if (unlikely(!br_stack))
> +		goto clear;
> +
> +	to_copy = min_t(u32, br_stack->nr * sizeof(struct perf_branch_entry), size);
> +	to_clear -= to_copy;
> +
> +	memcpy(buf, br_stack->entries, to_copy);
> +	err = to_copy;
> +clear:
> +	memset(buf + to_copy, 0, to_clear);

Here, why do this at all? If the user cares they can clear the bytes
directly from the BPF program. I suspect its probably going to be
wasted work in most cases. If its needed for some reason provide 
a comment with it.

> +	return err;
> +}

[...]
