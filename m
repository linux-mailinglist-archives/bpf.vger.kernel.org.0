Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2056101236
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 04:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfKSDbS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 22:31:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41982 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfKSDbS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 22:31:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id d29so10957747plj.8
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 19:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s0S/hKRe1szTk6MwXth+tHpDQqJLPjD39CGSL0II42w=;
        b=mZ5jabhHLDv1WnS4SL9eKijp2yGhrUQBjMD+o9ckAO7WLXwZl9yoq+8QxR29Royeb8
         A9bn9fK81swnR7jzPbMQCwr6iTH2sc+kmLtblCokuzwVjYnK3DgfSbiUHGvEfvjkJy7w
         sHcUVMr2PtE+SIl9ynI+ALzJgJ8ElRV1zcOzsGVxLelq4UEUo06JVXmNam7RUE62/YHg
         E37eQiP6PhFY47X5SUqTsnC+6nAkIK5NSlgaplBH/x6lvYu5UbBOVnl+KUlpvN/f5Gi6
         TwPwP0I4S6zfr4Zosi7E93wTq9dDRTFta0wICkWmP6dnKhYGyd6N+VL5KTCKWm3sAALL
         +RDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s0S/hKRe1szTk6MwXth+tHpDQqJLPjD39CGSL0II42w=;
        b=mtXl7sMV3ymD4/cyDxJRij8kQW54HLUs6jbrwPtXAFgPgeYZY5pIHcuE0vfB6f32dG
         W3Qini3w6hGa0/ubRLBTjRmLHMjSS5EQjFVHZ1dToSkvs113ARuw1v8dtdEidkAf7xvC
         L5eiPvwEgf6/zKGJRyc4kBmhNc2TGkEZ0JZY8tmQYwy/yIXAuCTw5LqLcEjH/kkfRQIg
         DiW0CZvQ5hW5AtsjdED2iXIP5BYilclGbsantc0PhAgq25NuWyJ36+XPquBRZDQjY32e
         NE2VTn5gFbu3YGDg9YYzZ5uah/OQIgMJJLue1bxto3EMKDL+G9SmbJiHNFYoo2F7i2k1
         WHwA==
X-Gm-Message-State: APjAAAU278Q15+HiqvDP2i/K3lTJJill8PNK/RE1VQS08J9InM0EtYS9
        J1sGmWH/l6QJdjiA8Bn6ezg=
X-Google-Smtp-Source: APXvYqxPGqggTAZzTr+2nm3l8+vGH0o3Gp7A/7pQQewb3jRkBll0MYOIF9eVabkljC+6HWS210AqvA==
X-Received: by 2002:a17:902:6b8a:: with SMTP id p10mr3119899plk.10.1574134276667;
        Mon, 18 Nov 2019 19:31:16 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::db2d])
        by smtp.gmail.com with ESMTPSA id i22sm1006247pjx.1.2019.11.18.19.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 19:31:15 -0800 (PST)
Date:   Mon, 18 Nov 2019 19:31:14 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/2] [bpf] allow s32/u32 return types in
 verifier for bpf helpers
Message-ID: <20191119033111.fs7fnmncwi5rnhdk@ast-mbp.dhcp.thefacebook.com>
References: <20191117182704.656602-1-yhs@fb.com>
 <20191117182704.656659-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117182704.656659-1-yhs@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 17, 2019 at 10:27:04AM -0800, Yonghong Song wrote:
> Currently, for all helpers with integer return type,
> the verifier permits a single return type, RET_INTEGER,
> which represents 64-bit return value from the helper,
> and the verifier will assign 64-bit value ranges for these
> return values. Such an assumption is different
> from what compiler sees and the generated code with
> llvm alu32 mode, and may lead verification failure.
> 
> For example, with latest llvm, selftest test_progs
> failed for program raw_tracepoint/kfree_skb.
> The source code looks like below:
> 
>   static __always_inline uint64_t read_str_var(...)
>   {
>     len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN, value->ptr);
>     if (len > STROBE_MAX_STR_LEN)
>       return 0;
>     ...
>     return len;
>   }
>   for (int i = 0; i < STROBE_MAX_STRS; ++i) {
>     payload += read_str_var(cfg, i, tls_base, &value, data, payload);
>   }
> 
> In the above, "cfg" refers to map "strobemeta_cfgs" and the signature
> for bpf_probe_read_user_str() is:
>  static int (*bpf_probe_read_user_str)(void *dst, __u32 size, const void *unsafe_ptr) = (void *) 114;
> in tools/lib/bpf/bpf_helper_defs.h.
> 
> The code path causing verification failure looks like below:
>   193: call bpf_probe_read_user_str
>   194: if (w0 > 0x1) goto pc + 2
>   195: *(u16 *)(r7 +80) = r0
>   196: r6 = r0
>   ...
>   199: r8 = *(u64 *)(r10 -416)
>   200: r8 += r6
>   R1 unbounded memory access, make sure to bounds check any array access into a map
> 
> After insn 193, the current verifier assumes r0 can be any 64-bit value.
>   R0=inv(id=0)
> At insn 194, the compiler assumes bpf_probe_read_user_str() will return
>   an __s32 value hences uses subregister w0 at insn 194 and at
>   branch false target, the w0 range can be refined to unsigned values <= 1.
>   But since insn 193 marks r0 with non-empty upper 32bit value, the new
>   umax_value becomes 0xffffffff00000001.
>   R0_w=inv(id=0,umax_value=18446744069414584321)
> At insn 196, the register r0 is assigned to r6.
> At insn 199, map pointer to strobemeta_cfgs map is restored and further refined
>   at insn 200 and 201.
> At insn 200, the verifier complains r8 + r6 unbounded memory access since r6 has
>   R6_rw=invP(id=0,umax_value=18446744069414584321)
> 
> The pattern can be roughly described by the following steps:
>   . helper return 32bit value, but return value marked conservatively.
>   . sub-registeer w0 is refined.
>   . r0 is used and the refined w0 range is lost.
>   . later use of r0 may trigger some kind of unbound failure.
> 
> To remove such failure, r0 range at insn 193 should be more aligned with
> what user expect based on function prototype in bpf_helper_defs.h, i.e.,
> its value range should be with 32-bit value. This patches distinguished
> 32-bit from 64-bit return values in verifier with proper return value
> ranges in r0. In the above case,
> after insn 193, the verifier will give r0 range as
>   R0_w=inv(id=0,smin_value=-2147483648,smax_value=2147483647,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> after insn 194, the new r0 range will be
>   R0_w=inv(id=0,umax_value=1,var_off=(0x0; 0x1))
> This better register range avoids above verification failure.

conceptually looks good. please refactor the code though.

> +static void mark_ret_reg_unknown(struct bpf_verifier_env *env,
> +				 struct bpf_reg_state *regs,
> +				 enum bpf_return_type ret_type)
> +{
> +	struct bpf_reg_state *reg = regs + BPF_REG_0;
> +
> +	memset(reg, 0, offsetof(struct bpf_reg_state, var_off));

only __mark_reg_known and __mark_reg_unknown should be allowed to do this.

> +	reg->type = SCALAR_VALUE;

> +
> +	if (ret_type == RET_INT64) {
> +		reg->var_off.mask = -1;

This is internal details of tnum_unknown. The code should not assign var_off directly.

> +		__mark_reg_unbounded(reg);
> +	} else {
> +		reg->var_off.mask = 0xffffffffULL;

same thing. Please introduce tnum_unknown32 instead

> +		reg->smin_value = S32_MIN;
> +		reg->smax_value = S32_MAX;
> +		reg->umin_value = 0;
> +		reg->umax_value = U32_MAX;

and this can be derived from tnum_unknown32.

> +	}
> +
> +	regs->precise = env->subprog_cnt > 1 || !env->allow_ptr_leaks ?
> +			true : false;

Doesn't belong here. Should really be one helper that does this.

