Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAC62C1482
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 20:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgKWT3o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 14:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbgKWT3o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 14:29:44 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F71C0613CF
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 11:29:44 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h21so342848wmb.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 11:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nk7XAwrc4JtHsC6t3SdKIufDahwr9DGKRVrPai3tKug=;
        b=A/LwwWwvNMMZxjdebzIA1SLoR2qDjZSnVpwV0pvUs9ArT6nlgC5O8gdlhI78i/UX60
         zE5xBTd01kyIie8dOt/SnaRP/GNFb9YBhWFxYbBnZ/0s6vmjeY4CivY1ULIVrSRo4EBY
         uZ6BDh2H6/RgDWoojZxbXQ6dnc5HcL8oW2Xg0NBR75V5XsF/QtWpYtNX4U3RDH0+S7w8
         o7FtcBJqCzIRPh2HdJlEuVlExfUyVCAHA3hV9gJkwn22NrY+rcYXfuf8cDfhV5ltUBWd
         Hqla1BhexIJ0wTvq2ixq17RZsDn7gQM1pQo/TjJBwbxwHAzY1Scm9tU16qMt9DzAkHrM
         czCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nk7XAwrc4JtHsC6t3SdKIufDahwr9DGKRVrPai3tKug=;
        b=D+ib6dQqhFS8aDVe8zG5uy33Jeldp9JZlxB2kwfCCOrTcOS+iVpSlDpL7O9dGw7zao
         xb+Rjrsml/WqjDQOG1CZ9nBh0FrW8lI7sALmjajq+dlNuR2RTdoHW8ryVyLiZagVs/uv
         D6asjV11GIsMntvhMr7u+OCgdny2fP5pX02ixuly/KhSjr2RlxLWm2nWwq0C1qBd5EAk
         WaPGs5q8AoqrgMvJWZXT+PLprmJX7SEgk/wu4MItky3VwIhdIoZVdFvwHY4nP3pXoqLM
         o3NNX2vfFN2xAxqaxcN9IZ2wUhRU8YUvyVJk2s1diLpnkZsd9WxERPyh6rc8Y+H0lJBu
         tTEg==
X-Gm-Message-State: AOAM533j+/SGdAFFAuy1As51jW6ZQwfANBLeHZnEF4iv0D40v0Z73sKK
        BxP+HUrdoRVmLbP9B8v9MLQIVRHiViSqhw==
X-Google-Smtp-Source: ABdhPJzwp8MgaHvy8b1cwYkQ9wTDhjMqlWXS0yQvRXQTgjR4O4MeOIpcqejOjQHGFeq/9veRza/ZmQ==
X-Received: by 2002:a05:600c:2311:: with SMTP id 17mr483109wmo.40.1606159782574;
        Mon, 23 Nov 2020 11:29:42 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id w11sm490323wmg.36.2020.11.23.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 11:29:41 -0800 (PST)
Date:   Mon, 23 Nov 2020 19:29:38 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH 6/7] bpf: Add instructions for atomic_cmpxchg and friends
Message-ID: <20201123192938.GA1524298@google.com>
References: <20201123173202.1335708-1-jackmanb@google.com>
 <20201123173202.1335708-7-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123173202.1335708-7-jackmanb@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Looks like I half-baked some last-minute changes before sending this
out. If you disable the JIT, test_verifier will fail.

On Mon, Nov 23, 2020 at 05:32:01PM +0000, Brendan Jackman wrote:
> diff --git a/include/linux/filter.h b/include/linux/filter.h
...
> +#define BPF_ATOMIC_SET(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_SET })
> +

Should be deleted, and in the tools/ copy too. There's a test case in
the later commit that should be changed to assert that instructions like
this fail to verify.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 14f5053daf22..2e611d3695bf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3602,10 +3602,14 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>  {
>  	struct bpf_reg_state *regs = cur_regs(env);
>  	int err;
> +	int load_reg;
>  
>  	switch (insn->imm) {
>  	case BPF_ADD:
>  	case BPF_ADD | BPF_FETCH:
> +	case BPF_SET:

Should be deleted.

> +	case BPF_SET | BPF_FETCH:
> +	case BPF_CMPSET | BPF_FETCH: /* CMPSET without FETCH is not supported */
>  		break;
>  	default:
>  		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);

I'll fold the fix into the next revision along with the comments
generated by this initial version.
