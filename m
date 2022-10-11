Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3915FAD68
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 09:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJKHZN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJKHZN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 03:25:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E6422C3
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73C93B811FE
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375FFC43470
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665473108;
        bh=Et+zx25hklA4YAakpfYSSJclXoU9BN7VanXSv1e/khM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z7tVHoMfLQdmmgySayAqMLBCkyVzadHcxbmZvUaCVBGuFiEjBryersKG2e2x7mR+n
         V+aTDFzP5TJmHXIrexeZ99RmRmSk149Rcdk1GMRN5RFBfLbV5X/X7Qpfczz5ocvpsg
         6QTsXm6bNX+8SF2B/AbHlRll8bXFifm3p8QT5PxIwOEbj/aJktYnzui6FyhYo3nWu8
         PkCr+hgUO7zwKMl9OEktwns6xj6Q+p3YD+ybH0JNhwaIpkkXHQaRNKfD9y7L6T+4Qt
         if/XNq9EV1sDU8tW5f49N2pM/itwPoZcJ2nN9go9Ku/EsaCgjnV4HDHf2XfpKwqnj2
         A6LbX2lrxzaiw==
Received: by mail-ed1-f50.google.com with SMTP id v12so573204edc.6
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:25:08 -0700 (PDT)
X-Gm-Message-State: ACrzQf3WVaNvllliO4UHNwtPnzhPvFIA2zZwabwVh/sA14rtJy6KLuP5
        we4sx83U24YlUZT50GZXH0D6D5C8cjqvuf1nhdI=
X-Google-Smtp-Source: AMsMyM50ZJLycF34EVr5bcbWOT0sxEpQx8572wM4lhV4LaMqqH3wZwSl5DB2Vu2MtxYmGCyKJsHP3T+B3QDPCyM4sQA=
X-Received: by 2002:a05:6402:4491:b0:45b:d55b:1207 with SMTP id
 er17-20020a056402449100b0045bd55b1207mr14332212edb.53.1665473106389; Tue, 11
 Oct 2022 00:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221009215926.970164-1-jolsa@kernel.org> <20221009215926.970164-7-jolsa@kernel.org>
In-Reply-To: <20221009215926.970164-7-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 11 Oct 2022 00:24:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4EJ9HxD9gAeAGaBBS8FVvCQ++XGyCjVPqByBBr5Pt-HA@mail.gmail.com>
Message-ID: <CAPhsuW4EJ9HxD9gAeAGaBBS8FVvCQ++XGyCjVPqByBBr5Pt-HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/8] selftests/bpf: Add bpf_testmod_fentry_* functions
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 9, 2022 at 3:00 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding 3 bpf_testmod_fentry_* functions to have a way to test
> kprobe multi link on kernel module. They follow bpf_fentry_test*
> functions prototypes/code.
>
> Adding equivalent functions to all bpf_fentry_test* does not
> seems necessary at the moment, could be added later.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index a6021d6117b5..5085fea3cac5 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -128,6 +128,23 @@ __weak noinline struct file *bpf_testmod_return_ptr(int arg)
>         }
>  }
>
> +noinline int bpf_testmod_fentry_test1(int a)
> +{
> +       return a + 1;
> +}
> +
> +noinline int bpf_testmod_fentry_test2(int a, u64 b)
> +{
> +       return a + b;
> +}
> +
> +noinline int bpf_testmod_fentry_test3(char a, int b, u64 c)
> +{
> +       return a + b + c;
> +}
> +
> +int bpf_testmod_fentry_ok;
> +
>  noinline ssize_t
>  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>                       struct bin_attribute *bin_attr,
> @@ -167,6 +184,13 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>                         return snprintf(buf, len, "%d\n", writable.val);
>         }
>
> +       if (bpf_testmod_fentry_test1(1) != 2 ||
> +           bpf_testmod_fentry_test2(2, 3) != 5 ||
> +           bpf_testmod_fentry_test3(4, 5, 6) != 15)
> +               goto out;
> +
> +       bpf_testmod_fentry_ok = 1;
> +out:
>         return -EIO; /* always fail */
>  }
>  EXPORT_SYMBOL(bpf_testmod_test_read);
> --
> 2.37.3
>
