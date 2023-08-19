Return-Path: <bpf+bounces-8106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF81D781604
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 02:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8527E281E02
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 00:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F8962D;
	Sat, 19 Aug 2023 00:29:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7194362
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 00:29:12 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D373C38
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 17:29:11 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a7781225b4so995173b6e.3
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 17:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692404951; x=1693009751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SeehBOJWSfhk8lD9RilqQ6Zrqd29tFDLWC4+cn1q5RY=;
        b=oVq3CcjhscaHA0NDstwBHH8jiT0JYXTeLjQZglqGheZaRn/JJKbX+WgJ7YfVBKI2fX
         IC99w5zexJp8js8DMTNc4wX6TzcHiuoG9BWC3gDMkQoDPaqfTMreLYuKce0+FsqufYqB
         z8M2nR6wL5b1FFD97YNZpVYYbrYJ9DaUzCoM/2wpKZCqtJ8JS93uaMcfiHNxQ3ZP1nc8
         MmtZyE1VxCRl45sgg7vOpO8OVNb7gElcFKDl9xWucCGoACS2mgZcgZmBrqpjHtzDRVZC
         67HtS6djmXBc8vsC6H3HgnxjABwtMIgbK5ppL4i+EsaBw6TtkmwNxh29T93thStHkg3j
         mZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692404951; x=1693009751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeehBOJWSfhk8lD9RilqQ6Zrqd29tFDLWC4+cn1q5RY=;
        b=DnCKUKvR/T2jxS/JhqceOe3i5ScFZfmyUVDzWoRIeIrxFz2TAMP9RGIhjZRnKcfDbi
         aXqvYjtJP4eLw60qzJdw4zSRMpCpAvP03l6zlN5GUVo0hPpR5VsxPoYisAssHvjlIo+a
         7MNas5aYJ3DYE2uQNogU4MwHgkHNHVU/MuigE1hpwOiD/9aNzpjLWrlrkTw76J0eGqUV
         7ZQhVdpctSYrga7I+r2zK6jMSho6P7dArZb4a2TPQHUWvLTf/IGn3WyQUIJpJXA1Q7Ob
         wuzt/Lm3coBXknbGCxx4/YMBORP4AdwO/8z1L4ReyS8ZZfQgiWtBjJm7fUcO4XoAPTwP
         PHGw==
X-Gm-Message-State: AOJu0YzOwXIaCyb3/fxrmX92k5pGl2ruWMkoVsfw2kjf3+nQcPK/YIb3
	5yvT/Gz3cM/BtjhZoiNtgjJfVmcuf7E=
X-Google-Smtp-Source: AGHT+IH0C8GYJrtUUdMqpIlYo1BAjeZ6KgWVAPmKLVSSeMI7P7FgYCz6o9xSOad+tTSlGj4tZEP49A==
X-Received: by 2002:a05:6808:10c2:b0:3a7:a58:e818 with SMTP id s2-20020a05680810c200b003a70a58e818mr1023399ois.33.1692404950876;
        Fri, 18 Aug 2023 17:29:10 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::5:1ebf])
        by smtp.gmail.com with ESMTPSA id g21-20020a633755000000b00569368ead4bsm2156619pgn.42.2023.08.18.17.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 17:29:10 -0700 (PDT)
Date: Fri, 18 Aug 2023 17:29:07 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 03/15] bpf: Add alloc/xchg/direct_access support
 for local percpu kptr
Message-ID: <20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
 <20230814172825.1363378-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814172825.1363378-1-yonghong.song@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 10:28:25AM -0700, Yonghong Song wrote:
> @@ -4997,13 +4997,20 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
>  	if (kptr_field->type == BPF_KPTR_UNREF)
>  		perm_flags |= PTR_UNTRUSTED;
>  
> +	if (kptr_field->type == BPF_KPTR_PERCPU_REF)
> +		perm_flags |= MEM_PERCPU | MEM_ALLOC;

this bit doesn't look right and ...

> +
>  	if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
>  		goto bad_type;
>  
> -	if (!btf_is_kernel(reg->btf)) {
> +	if (kptr_field->type != BPF_KPTR_PERCPU_REF && !btf_is_kernel(reg->btf)) {
>  		verbose(env, "R%d must point to kernel BTF\n", regno);
>  		return -EINVAL;
>  	}
> +	if (kptr_field->type == BPF_KPTR_PERCPU_REF && btf_is_kernel(reg->btf)) {
> +		verbose(env, "R%d must point to prog BTF\n", regno);
> +		return -EINVAL;
> +	}

.. here it really doesn't look right.
The map_kptr_match_type() should have been used for kptrs pointing to kernel objects only.
But you're calling it for MEM_ALLOC object with prog's BTF...

> +	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
> +		if (meta->func_id != BPF_FUNC_kptr_xchg) {
> +			verbose(env, "verifier internal error: unimplemented handling of MEM_PERCPU | MEM_ALLOC\n");
> +			return -EFAULT;
> +		}

this part should be handling it, but ...

> +		if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
> +			return -EACCES;

why call this here?

Existing:
        case PTR_TO_BTF_ID | MEM_ALLOC:
                if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
                    meta->func_id != BPF_FUNC_kptr_xchg) {
                        verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
                        return -EFAULT;
                }
doesn't call map_kptr_match_type().
Where do we check that btf of arg1 and arg2 matches for kptr_xchg of MEM_ALLOC objs? Do we have a bug?

Yep. We do :(

diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
index 06838083079c..a6f546f4da9a 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -14,10 +14,12 @@ struct node_data {
        struct bpf_rb_node node;
 };

+struct node_data2 { long foo[4];};
+
 struct map_value {
        struct prog_test_ref_kfunc *not_kptr;
        struct prog_test_ref_kfunc __kptr *val;
-       struct node_data __kptr *node;
+       struct node_data2 __kptr *node;
 };

 /* This is necessary so that LLVM generates BTF for node_data struct
@@ -32,6 +34,7 @@ struct map_value {
  * Had to do the same w/ bpf_kfunc_call_test_release below
  */
 struct node_data *just_here_because_btf_bug;
+struct node_data2 *just_here_because_btf_bug2;

passes the verifier and runs into kernel WARN_ONCE.

Let's fix this issue first before proceeding with this series.

