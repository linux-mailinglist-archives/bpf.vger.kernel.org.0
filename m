Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0BD14951B
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2020 12:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgAYLNu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jan 2020 06:13:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39959 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgAYLNu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jan 2020 06:13:50 -0500
Received: by mail-qk1-f195.google.com with SMTP id t204so3975069qke.7
        for <bpf@vger.kernel.org>; Sat, 25 Jan 2020 03:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nWoqp30LEmmh1Vw2A74fmNpogh9daBW27TBk5Opv0MY=;
        b=UjhD4nTuuPgqoKgPCRxwCoNzqhSoPFdtFOy67XHISqcFB7n7TnGPFP+3kviIgTXZ1D
         YIFyOAVMfWX1sAwRGdvdX2Wt2lzSiFn9+81usAGdV4EhFosk1tuvBQAFZTgmOe/nEe8g
         9735p6sWoeTIhbN79t3OZsbCdiYl7SAiQIvYGnmUTvCkvI0+8bnm9gT4mmBxb09DxQNP
         G8mJnTJlUy/AmvLXILV+JkCe8fGTqEPIdxQkem6qws0fUisAgzNYDdNAf2ZxonWmMh1M
         IqoxzNWJHoqITGt2JtYNo5u1G6S32Ms6zq34Ccrz7XT5uxEKXLTUP1dB/OPHbs9Utido
         t9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nWoqp30LEmmh1Vw2A74fmNpogh9daBW27TBk5Opv0MY=;
        b=X88gZwpn47ZgwXbvIKAE7Y67bJ9TJ1XRfO3TbYluSrAouiCvnR9iA2eMJRBiPZu59g
         C9P0elBRBfBzmJ70OzCxSL+P0CiSscTW/pTHAFEzziazT2hsBQYf3uuCFG6616Daj5WO
         LquyznIv8DScLnyi8HdFNBAvi9Q0j3boCQZUo8cLVPf4I5NoQ9cM6eO6fXilPUOLxWSh
         jcIvwvthjS/b5xIclxExhk42ly4KJKaUYacwiupcdwMuvlvHKKLCMXwd0F4N2bM+dyJq
         voT5uxsIVovzc5m6TpSZeq21RRSZzi8424F8d7E2kjkJJzCYABRXMbKKs3CC5EQ7CdQk
         6TeA==
X-Gm-Message-State: APjAAAVexjh3wF0wSUaybt2pZMaCfcLA10gb3dAqSE3Xc824hXN3JjwZ
        CA2CMojxh6SGhNiSbu8Sqh8=
X-Google-Smtp-Source: APXvYqwHAjM9zwx9qPZW62BfnK9QEJHtDCHtZwoy3A+19UsfcxnXfx8GJBbeHaeFMbFLr7EdzYym/g==
X-Received: by 2002:a05:620a:791:: with SMTP id 17mr7276440qka.31.1579950828945;
        Sat, 25 Jan 2020 03:13:48 -0800 (PST)
Received: from ast-mbp ([2620:10d:c091:480::e383])
        by smtp.gmail.com with ESMTPSA id v4sm4319824qkj.64.2020.01.25.03.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jan 2020 03:13:48 -0800 (PST)
Date:   Sat, 25 Jan 2020 03:13:43 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [bpf PATCH] bpf: verifier, do_refine_retval_range may clamp umin
 to 0 incorrectly
Message-ID: <20200125111341.mu3r2c2dos5c5rpq@ast-mbp>
References: <157984984270.18622.13529102486040865869.stgit@john-XPS-13-9370>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157984984270.18622.13529102486040865869.stgit@john-XPS-13-9370>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 23, 2020 at 11:10:42PM -0800, John Fastabend wrote:
> @@ -3573,7 +3572,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
>  		 * to refine return values.
>  		 */
>  		meta->msize_smax_value = reg->smax_value;
> -		meta->msize_umax_value = reg->umax_value;
>  
>  		/* The register is SCALAR_VALUE; the access check
>  		 * happens using its boundaries.
> @@ -4078,9 +4076,9 @@ static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_type,
>  		return;
>  
>  	ret_reg->smax_value = meta->msize_smax_value;
> -	ret_reg->umax_value = meta->msize_umax_value;
>  	__reg_deduce_bounds(ret_reg);
>  	__reg_bound_offset(ret_reg);
> +	__update_reg_bounds(ret_reg);

Thanks a lot for the analysis and the fix.
I think there is still a small problem.
The variable is called msize_smax_value which is used to remember smax,
but the helpers actually use umax and the rest of
if (arg_type_is_mem_size(arg_type)) { ..}
branch is validating [0,umax] range of memory.
bpf_get_stack() and probe_read_str*() have 'u32 size' arguments too.
So doing
meta->msize_smax_value = reg->smax_value;
isn't quite correct.
Also the name is misleading, since the verifier needs to remember
the size 'signed max' doesn't have the right meaning here.
It's just a size. It cannot be 'signed' and cannot be negative.
How about renaming it to just msize_max_value and do
meta->msize_max_value = reg->umax_value;
while later do:
ret_reg->smax_value = meta->msize_max_value;
with a comment that return value from the helpers
is 'int' and not 'unsigned int' while input argument is 'u32 size'.
