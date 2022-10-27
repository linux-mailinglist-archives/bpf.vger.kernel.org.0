Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D71610279
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 22:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbiJ0UPy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 16:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiJ0UPx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 16:15:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BB06049D;
        Thu, 27 Oct 2022 13:15:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v27so4799961eda.1;
        Thu, 27 Oct 2022 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9v+GCYX9b0Yz3saIQquk7xcyeLFFBorcA4ECRIR0puY=;
        b=WrKQ/H+3tZd1pFrUuT1adYe+ZhSQbXtq52lHeiw5G9wfoHv6HQxQAejHqaITGqGRct
         8oaDkawsI5Qypf7EleDZN3g/8WlI+QuclVy9Ixy472YJe9K7MOAWftTh/Qdks1BbAKhv
         QS1Ja1T+XIB2+7K51Hg5Cipv9mKZ3Wir9JLh0H+j2Il8pO9uZtFVdK951B4iwckKaGDd
         9dlCJBcqonyt1zGFaGzLn0W2Dl5MDYJXhx7XJixfOvmwq0YGy6E13w+6osnp6MsVVzwl
         gWgtLSKiFcLXxUVVH4MmDjkOiMhIf9YldYCOlpuzH7fuaEpX5A3sGjLLvIJR3kKi2NXV
         GZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9v+GCYX9b0Yz3saIQquk7xcyeLFFBorcA4ECRIR0puY=;
        b=eltcyDd9RRp4X7LYTXcUpJZD/BfxC5vXeKr/K6KzPMEIE0Bg1i5/HkZQY2Vk6YM5lG
         dGel9vhNe9dqaQDQJow2cAuYWFq+sn4g8UJ8VSZuHwhxsncArWCSr101SKNweeA1NOct
         PA1yr2HjAtVH5u3q8HsZjdxPdvy2Pgl0KpzR/Hv7nt7/iqCl5AX7kqpI/nL4JLKtOT8Z
         iTPi252rLjImABT2dJnV+gNjDtXX+6DtYO/6ec6ac1nLTQ2xLa1251RSsEpvW8NqfcDT
         Q48sRbeUUUr9gOrID9bMEPWf2MF6WRZzLy0QU/rGQTvhrltABLEWZF9GQA+pINT6bRAS
         +ntw==
X-Gm-Message-State: ACrzQf2cq2F/6ruq9WU/GLFCO19Z9oagMsc42eISlMmDDURbEjtnNKzz
        hLNwDv1Eufe+Vs3ZToj2xn8yudpzdV5I+Pv6C9M=
X-Google-Smtp-Source: AMsMyM5x8wZAbsIi4LW77ELtol2GmRtTMuogRS4GsjXrqHvwR/M//T3KiIXnnjdDSddPRRTjzT+6ZIZc4V+1Bg9uMNE=
X-Received: by 2002:a05:6402:3641:b0:45c:4231:ddcc with SMTP id
 em1-20020a056402364100b0045c4231ddccmr46926006edb.224.1666901749660; Thu, 27
 Oct 2022 13:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_9E1B74096164395DDAAB4CBFE68CE6216E0A@qq.com> <tencent_C0A1D82C934B5895D65788D11A4456835607@qq.com>
In-Reply-To: <tencent_C0A1D82C934B5895D65788D11A4456835607@qq.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Oct 2022 13:15:37 -0700
Message-ID: <CAEf4BzZAOm8Q4U2vcDjQ7T2_PdoMb5NTWUcL-vzzbXH5tntdOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] samples/bpf: Fix sockex3: missing BPF prog type
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 27, 2022 at 6:38 AM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> since commit 450b167fb9be("libbpf: clean up SEC() handling"),
> sec_def_matches() does not recognize "socket/xxx" as "socket", therefore,
> the BPF program type is not recognized, we should add a custom program
> type handler for "socket/xxx".

I don't think we should, we should just switch to SEC("socket") or
whatever the right annotation has to be. Let's fix the BPF-side code.

>
>  $ cd samples/bpf
>  $ sudo ./sockex3
>  libbpf: prog 'bpf_func_PARSE_IP': missing BPF prog type, check ELF section name 'socket/3'
>  libbpf: prog 'bpf_func_PARSE_IP': failed to load: -22
>  libbpf: failed to load object './sockex3_kern.o'
>  ERROR: loading BPF object file failed
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  samples/bpf/sockex3_user.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/samples/bpf/sockex3_user.c b/samples/bpf/sockex3_user.c
> index cd6fa79df900..d18d7a3600b0 100644
> --- a/samples/bpf/sockex3_user.c
> +++ b/samples/bpf/sockex3_user.c
> @@ -22,6 +22,14 @@ struct pair {
>         __u64 bytes;
>  };
>
> +static int socket_prog_type_id;
> +
> +__attribute__((destructor))
> +static void unregister_socket_sec_handlers(void)
> +{
> +       libbpf_unregister_prog_handler(socket_prog_type_id);
> +}
> +
>  int main(int argc, char **argv)
>  {
>         int i, sock, key, fd, main_prog_fd, jmp_table_fd, hash_map_fd;
> @@ -31,6 +39,13 @@ int main(int argc, char **argv)
>         char filename[256];
>         FILE *f;
>
> +       LIBBPF_OPTS(libbpf_prog_handler_opts, socket_opts,
> +               .cookie = 1,
> +       );
> +
> +       socket_prog_type_id = libbpf_register_prog_handler("socket/",
> +                       BPF_PROG_TYPE_SOCKET_FILTER, 0, &socket_opts);
> +
>         snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
>
>         obj = bpf_object__open_file(filename, NULL);
> --
> 2.31.1
>
