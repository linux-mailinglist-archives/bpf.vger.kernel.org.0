Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B325F6CB7
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 19:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJFRVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 13:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJFRVd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 13:21:33 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F6ACA26
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 10:21:30 -0700 (PDT)
Message-ID: <a9e767e6-b8ce-ec1e-47dc-74abfe828713@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665076888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHTXlpPz0SRLPnl4199FQCenZLPnwWcu12lMT+2QCG4=;
        b=Lm31v2dzKX4xnoIDHbxcZ7XVhcpfUqHiQHFc4Hykfp60kNmSc8IcZ3j70O0JYiSplzSavW
        Mr+Ru71K7AKNDm4cGA2ilWEG/jkT9U2WRumSrMolw3fFsMi646/l1nncj+RFtphvy4EPL7
        iO8Z7pxDCDzXfw5A90eJ6SBZiSWvC34=
Date:   Thu, 6 Oct 2022 10:21:24 -0700
MIME-Version: 1.0
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Add missing
 bpf_iter_vma_offset__destroy call
Content-Language: en-US
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20221006083106.117987-1-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221006083106.117987-1-jolsa@kernel.org>
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

On 10/6/22 1:31 AM, Jiri Olsa wrote:
> Adding missing bpf_iter_vma_offset__destroy call and using in-skeletin
> link pointer so we don't need extra bpf_link__destroy call.
> 
> Fixes: b3e1331eb925 ("selftests/bpf: Test parameterized task BPF iterators.")
> Cc: Kui-Feng Lee <kuifeng@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   v2 changes:
>   - use in-skeletin link pointer and destroy call [Martin]
> 
>   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 3369c5ec3a17..d4437a2bba28 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -1498,7 +1498,6 @@ static noinline int trigger_func(int arg)
>   static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool one_proc)
>   {
>   	struct bpf_iter_vma_offset *skel;
> -	struct bpf_link *link;
>   	char buf[16] = {};
>   	int iter_fd, len;
>   	int pgsz, shift;
> @@ -1513,11 +1512,13 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
>   		;
>   	skel->bss->page_shift = shift;
>   
> -	link = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
> -	if (!ASSERT_OK_PTR(link, "attach_iter"))
> -		return;
> +	skel->links.get_vma_offset = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
> +	if (!ASSERT_OK_PTR(skel->links.get_vma_offset, "attach_iter")) {
> +		skel->links.get_vma_offset = NULL;

Applied with this NULL assignment removed.  bpf_link__destroy() can handle err 
ptr.  Thanks.


> +		goto exit;
> +	}
>   
> -	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.get_vma_offset));
>   	if (!ASSERT_GT(iter_fd, 0, "create_iter"))
>   		goto exit;
>   
> @@ -1535,7 +1536,7 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
>   	close(iter_fd);
>   
>   exit:
> -	bpf_link__destroy(link);
> +	bpf_iter_vma_offset__destroy(skel);
>   }
>   
>   static void test_task_vma_offset(void)

