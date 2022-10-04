Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B0B5F3A6B
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 02:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJDAM6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 20:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJDAMw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 20:12:52 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890CD23173
        for <bpf@vger.kernel.org>; Mon,  3 Oct 2022 17:12:51 -0700 (PDT)
Message-ID: <49aa0aec-a009-c0c3-cf47-11a6734aae36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664842368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Sp0eCjUQyluj+OeoDtyk60E0S2YGz4u9w+4Rau3BsQ=;
        b=uo13vCWO562gZ1xvqDt2+oNBd6tGAz8saBxo6qDmoAC45kiUYLFVeEPhed8NDQGdhtTg3/
        Z6AftirWValkK1n4ZbPOwmgET2jcwBlk2J4g6uzV93t54QWoxLY1WiKVnECXuHte7u+T8c
        EV9o5zgT/eVSzsuqNtbgNsrg+9WUOW4=
Date:   Mon, 3 Oct 2022 17:12:44 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Add missing
 bpf_iter_vma_offset__destroy call
Content-Language: en-US
To:     Jiri Olsa <jolsa@kernel.org>, Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20221002151141.1074196-1-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221002151141.1074196-1-jolsa@kernel.org>
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

On 10/2/22 8:11 AM, Jiri Olsa wrote:
> Adding missing bpf_iter_vma_offset__destroy call to
> test_task_vma_offset_common function and related goto jumps.
> 
> Fixes: b3e1331eb925 ("selftests/bpf: Test parameterized task BPF iterators.")
> Cc: Kui-Feng Lee <kuifeng@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 3369c5ec3a17..462fe92e0736 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -1515,11 +1515,11 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
>   
>   	link = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);

Thanks for the fix.

A nit.  Instead of adding a new goto label.  How about doing

	skel->links.get_vma_offset = bpf_program_attach_iter(...)

and bpf_iter_vma_offset__destroy(skel) will take care of the link destroy.  The 
earlier test_task_vma_common() is doing that also.

Kui-Feng, please also take a look.

>   	if (!ASSERT_OK_PTR(link, "attach_iter"))
> -		return;
> +		goto exit_skel;
>   
>   	iter_fd = bpf_iter_create(bpf_link__fd(link));
>   	if (!ASSERT_GT(iter_fd, 0, "create_iter"))
> -		goto exit;
> +		goto exit_link;
>   
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> @@ -1534,8 +1534,10 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
>   
>   	close(iter_fd);
>   
> -exit:
> +exit_link:
>   	bpf_link__destroy(link);
> +exit_skel:
> +	bpf_iter_vma_offset__destroy(skel);
>   }
>   
>   static void test_task_vma_offset(void)

