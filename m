Return-Path: <bpf+bounces-4810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3177074FBD5
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 01:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CD82817FD
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 23:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8471ED49;
	Tue, 11 Jul 2023 23:25:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018891ED32
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 23:25:28 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BA1E7A;
	Tue, 11 Jul 2023 16:25:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so100402b3a.0;
        Tue, 11 Jul 2023 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689117927; x=1691709927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdleDO2lGPE6ba8t/zdX0KO9d2+dLQJATvHIoa7Lxd4=;
        b=rwLJgd8R/3kKp0BUqh3W2oAr9amN+1A9VTuiPjK+xPcWQoYF2Jw1HMlkQxfPJEynd3
         sl2cl16QanqVVxWflxMxEFupw45KsuT9Ylk7w27qU9j8UUvnpqikwcy1xmmxGuJZ1jS0
         1FAaZQdAegU9ckvqHj8LNFjk2md37xhBC7I6Y4+8CZlSpad3PLuqolVeBHfQ+1+x5lNv
         J1M4jhIctGYb1rr0STCqvAg9hBbG3hZe+dDcOokV+TcnNHCjpbDoTl7AbhHo4ThtZ/Jw
         digQYlyILNcLfqTlaOlSe0lSoQIDidWvYWpCpJe96y11yt9G/QzK6VYUm+ER9JeEHl1p
         JFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689117927; x=1691709927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdleDO2lGPE6ba8t/zdX0KO9d2+dLQJATvHIoa7Lxd4=;
        b=A9H9jXmJbHOxMp9mCjo/slXz18pU9r8cKye6tdYeLuOQXNvPmgpFISq1zADs2ZwvR2
         9ddFPYrd2I67X91Cv9mwbQMMbPs9jRwD34llqZHhe96hTg3dTcA5AotByCshZeUftozD
         e6PenHsNJz8+Olc0ibHAv07YcFjHzs1S5hU9GkyL192q8Pdb4dzBEPawyR5DRXi+a6nJ
         xc/OxdZrZQVlfykc1aDdX4b7uxhBfOFqq5I1D3NMBLNuR8SVkuRhp3gC37SRX2mX7PhD
         +gua64zjGyDosbM9SXJBHjHUSyjzu4TrHc/RFcx3uC13wcSq2GcUw7lqtNXKpFaOOb0B
         Ur8g==
X-Gm-Message-State: ABy/qLYulJBwr8QTlVbjlP1arCMkZDoru7G6D98bC7sQvuNxdwGF87h9
	AQBg0IPjaNfWKa++brDSUX8=
X-Google-Smtp-Source: APBJJlGpQXjSLE0Jyq+lKWjQYjZqbz505VPDnZm5nDbz0n7hDJ3Jqg0y7OjpZYQiPGhUH38E5bk9Tg==
X-Received: by 2002:a17:902:f546:b0:1b9:c61c:4c01 with SMTP id h6-20020a170902f54600b001b9c61c4c01mr336209plf.9.1689117926782;
        Tue, 11 Jul 2023 16:25:26 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:400::5:f81])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709028c8700b001b51b3e84cesm2486527plo.166.2023.07.11.16.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 16:25:26 -0700 (PDT)
Date: Tue, 11 Jul 2023 16:25:22 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: menglong8.dong@gmail.com
Cc: yhs@meta.com, daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, dsahern@kernel.org, jolsa@kernel.org,
	x86@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH RESEND bpf-next v8 3/3] selftests/bpf: add testcase for
 TRACING with 6+ arguments
Message-ID: <20230711232522.54dbqdxkfbjvbvgi@macbook-pro-8.dhcp.thefacebook.com>
References: <20230710104834.947884-1-imagedong@tencent.com>
 <20230710104834.947884-4-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710104834.947884-4-imagedong@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 06:48:34PM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Add fentry_many_args.c and fexit_many_args.c to test the fentry/fexit
> with 7/11 arguments. As this feature is not supported by arm64 yet, we
> disable these testcases for arm64 in DENYLIST.aarch64. We can combine
> them with fentry_test.c/fexit_test.c when arm64 is supported too.
> 
> Correspondingly, add bpf_testmod_fentry_test7() and
> bpf_testmod_fentry_test11() to bpf_testmod.c
> 
> Meanwhile, add bpf_modify_return_test2() to test_run.c to test the
> MODIFY_RETURN with 7 arguments.
> 
> Add bpf_testmod_test_struct_arg_7/bpf_testmod_test_struct_arg_7 in
> bpf_testmod.c to test the struct in the arguments.
> 
> And the testcases passed on x86_64:
> 
> ./test_progs -t fexit
> Summary: 5/14 PASSED, 0 SKIPPED, 0 FAILED
> 
> ./test_progs -t fentry
> Summary: 3/2 PASSED, 0 SKIPPED, 0 FAILED
> 
> ./test_progs -t modify_return
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> ./test_progs -t tracing_struct
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
> v8:
> - split the testcases, and add fentry_many_args/fexit_many_args to
>   DENYLIST.aarch64
> v6:
> - add testcases to tracing_struct.c instead of fentry_test.c and
>   fexit_test.c
> v5:
> - add testcases for MODIFY_RETURN
> v4:
> - use different type for args in bpf_testmod_fentry_test{7,12}
> - add testcase for grabage values in ctx
> v3:
> - move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
>   bpf_testmod_fentry_test{7,12} meanwhile
> - get return value by bpf_get_func_ret() in
>   "fexit/bpf_testmod_fentry_test12", as we don't change ___bpf_ctx_cast()
>   in this version
> ---
>  net/bpf/test_run.c                            | 23 ++++++--
>  tools/testing/selftests/bpf/DENYLIST.aarch64  |  2 +
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 49 ++++++++++++++++-
>  .../selftests/bpf/prog_tests/fentry_test.c    | 43 +++++++++++++--
>  .../selftests/bpf/prog_tests/fexit_test.c     | 43 +++++++++++++--
>  .../selftests/bpf/prog_tests/modify_return.c  | 20 ++++++-
>  .../selftests/bpf/prog_tests/tracing_struct.c | 19 +++++++
>  .../selftests/bpf/progs/fentry_many_args.c    | 39 ++++++++++++++
>  .../selftests/bpf/progs/fexit_many_args.c     | 40 ++++++++++++++
>  .../selftests/bpf/progs/modify_return.c       | 40 ++++++++++++++
>  .../selftests/bpf/progs/tracing_struct.c      | 54 +++++++++++++++++++
>  11 files changed, 358 insertions(+), 14 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_many_args.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fexit_many_args.c
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 63b11f7a5392..1c59fa60077b 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -565,6 +565,13 @@ __bpf_kfunc int bpf_modify_return_test(int a, int *b)
>  	return a + *b;
>  }
>  
> +__bpf_kfunc int bpf_modify_return_test2(int a, int *b, short c, int d,
> +					void *e, char f, int g)
> +{
> +	*b += 1;
> +	return a + *b + c + d + (long)e + f + g;
> +}
> +
>  int noinline bpf_fentry_shadow_test(int a)
>  {
>  	return a + 1;
> @@ -600,9 +607,13 @@ __diag_pop();
>  
>  BTF_SET8_START(bpf_test_modify_return_ids)
>  BTF_ID_FLAGS(func, bpf_modify_return_test)
> +BTF_ID_FLAGS(func, bpf_modify_return_test2)
>  BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
>  BTF_SET8_END(bpf_test_modify_return_ids)
>  
> +BTF_ID_LIST(bpf_modify_return_test_id)
> +BTF_ID(func, bpf_modify_return_test)
> +
>  static const struct btf_kfunc_id_set bpf_test_modify_return_set = {
>  	.owner = THIS_MODULE,
>  	.set   = &bpf_test_modify_return_ids,
> @@ -665,9 +676,15 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
>  			goto out;
>  		break;
>  	case BPF_MODIFY_RETURN:
> -		ret = bpf_modify_return_test(1, &b);
> -		if (b != 2)
> -			side_effect = 1;
> +		if (prog->aux->attach_btf_id == *bpf_modify_return_test_id) {
> +			ret = bpf_modify_return_test(1, &b);
> +			if (b != 2)
> +				side_effect = 1;
> +		} else {
> +			ret = bpf_modify_return_test2(1, &b, 3, 4, (void *)5, 6, 7);
> +			if (b != 2)
> +				side_effect = 1;

Patches 1 and 2 look good, but I don't like where this check will lead us:
attach_btf_id == *bpf_modify_return_test_id...

When Jiri did a conversion of all test func into bpf_testmod.ko I forgot
why we couldn't move fmod_ret tests as well.
Whatever it was the extra attach_btf_id check will make it worse.

For now please think of a way to test fmod_ret when bpf_prog_test_run_tracing()
does something unconditional like:
	ret = bpf_modify_return_test(1, &b);
	if (b != 2)
		side_effect++;
	ret = bpf_modify_return_test2(1, &b, 3, 4, (void *)5, 6, 7);
	if (b != 2)
		side_effect++;

