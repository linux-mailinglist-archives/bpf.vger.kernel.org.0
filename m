Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0481475B1
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 01:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgAXAtP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 19:49:15 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52003 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbgAXAtO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 19:49:14 -0500
Received: by mail-pj1-f67.google.com with SMTP id d15so270134pjw.1;
        Thu, 23 Jan 2020 16:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3Zx+AN61IF0BQ3ZHWJ/I2PLD8xvxqj6iim/6I3vz3zw=;
        b=Yzd78GKae8Ooi+1HUPZVAw+/bAYHPIMRFCvNe4V61CsX+jHr4USPVYyTe0e6ngif/x
         IcShJiJUF8BCLvyAO02ZYtKwWFCne6X5UAUgIVGE/7urJ2jwrQvGBZ56fo//WkNP0BlB
         doSU4Et5KDETuCYItPhOgBK3jMThO0NM0f92T0eB2eAXhkleXjPYzvWpKHc6WcF7V6qK
         kWas6xK15lHM3u2z0/+FM7cbpvrP2GiBCdrZ+lOeUlTGP8039cacWHvjQmWaXBfP2j/X
         2G+GH58wOUGfzCnX76haTFusPr7bRVU2YG490ezC1yW7au9LoWS1nCve6f2lAwG1hkul
         X++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3Zx+AN61IF0BQ3ZHWJ/I2PLD8xvxqj6iim/6I3vz3zw=;
        b=HFfAxbbt8OloBoITA6BDWmxNrh8IKaMd48vVZ4qEQytgE0Gb9I3GjcGUdrNN8t9DYj
         e2Qo29jZbn/Cu+J0KcmcJ6Yf7T6tpBHsce5fQF3/3RwZUhq5l/rt21qk+ka/NdUigOml
         lcH+etIFqfQ439Qwm3X1Pb+f2B4kgg+H2gs+Hg9dyd/8I7GQrsTCj82uEUNpyoIw2tGY
         BI7RvRqrzBbgGMTXcNUC5uYdo6rI++f6e9qmGQerCF38r5n+ndFjzLT9gQwtXfdgBLCQ
         cCc49OC1ZFVS5QxHqdnTA81Z1skSweKUxQ4sEmcqGQgsNiMJ2e3a3faFCM8dumYjE/EG
         aICg==
X-Gm-Message-State: APjAAAVQoH2m615dawuzXoJBDy8YYrh1tOz0wf4O/WLEjTaSAXJRlGzA
        LArugMltJ/qid87uRjze6eo=
X-Google-Smtp-Source: APXvYqxeOEdtBqoGfGjt1LQYFG7OXtStPNaOgaC3aOuy04Tu4/ylUatDRmOB8bUL4eSc0sglolUMfQ==
X-Received: by 2002:a17:902:d205:: with SMTP id t5mr886567ply.138.1579826954054;
        Thu, 23 Jan 2020 16:49:14 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id u11sm4076591pjn.2.2020.01.23.16.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 16:49:13 -0800 (PST)
Date:   Thu, 23 Jan 2020 16:49:04 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Message-ID: <5e2a3f00a996a_7f9e2ab8c3f9e5c4a6@john-XPS-13-9370.notmuch>
In-Reply-To: <20200123212312.3963-2-dxu@dxuuu.xyz>
References: <20200123212312.3963-1-dxu@dxuuu.xyz>
 <20200123212312.3963-2-dxu@dxuuu.xyz>
Subject: RE: [PATCH v3 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
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
>  include/uapi/linux/bpf.h | 15 ++++++++++++++-
>  kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletion(-)
> 

[...]

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

There appears to be agreement to clear the extra buffer on error but what about
in the non-error case? I expect one usage pattern is to submit a fairly large
buffer, large enough to handle worse case nr, in this case we end up zero'ing
memory even in the succesful case. Can we skip the clear in this case? Maybe
its not too important either way but seems unnecessary.

> +	memset(buf + to_copy, 0, to_clear);
> +	return err;
> +}
