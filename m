Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9D25EAA07
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 17:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbiIZPPi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 11:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiIZPOn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 11:14:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE18FD82
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 06:58:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u24so9130255edb.9
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=weB3+iVwFEuLzsBZw3pcRq4P7JM3zeoy1ZIpyYF0Epg=;
        b=D1yV5vuOzlY40tpBjZ7CI61QYzSGhCNoqFcAJBx3fDMSXPbzpFDm5Zylb1zOre3Qz7
         YNElykdH6uuljo00Mzj5Ur01bci49usa1RUqcsHHb1ZZvkHCJyqiDuBPYDJWfSFRCtFl
         pZ78ctBKCNrUlPwHj4YBYs6e6WJ3QvCoynEo8AuPkcMeQaQLivB4iQVABbsI8WwQftqC
         4gGm68hX2WBNvq9cOb7C47xVMg9819Z48c+SRRO30She4vSkVhq+kO0Jsn5Gqlm4EWYO
         G2FaEEyyryWFO1RgbsEuQS7JgytBS4OFdgdjQ/ZvpTrR85Q8uWd52riGrKKzD3yAB72W
         ZLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=weB3+iVwFEuLzsBZw3pcRq4P7JM3zeoy1ZIpyYF0Epg=;
        b=2xVnrA1pQQk94QKj61D8SWlSFcyFx5VYoBObTvHlE18CLHLN9U6xgUzwHfFUMmjSIo
         ZIJxn6im13JMUIzc8APotiKg/2TXH804zGj9vzn6p6URtW9m8bNHaYSSD+Qhp/E97jUF
         aVbpBOYOlMPbxcMq9F9Sh4wEPVo8TH+7LDpVuLV30cC8vS0HyQkSVomL1IFB/LwGMWDu
         Lx5j1qOe7Y5ddUpA0V43e91QgDIy9GRL43WZ7WGA+tk9XelD2GW+yHlrzOMexssPZX0L
         6+G6IAY8E8HDyF34Xrq3/qWtXuL/xRv+dmluslxhjv+lkGFn47W4JOR0OlTaiu7I9lNN
         urlQ==
X-Gm-Message-State: ACrzQf0vDtjnsx10dbFfUs5xnbdozvgsBIF2F5YCfQUVy3H2yn/EXWR4
        UsGROuqLZR3I6sTR5nZdgDk=
X-Google-Smtp-Source: AMsMyM5918GgB8FRALmRXQ55dXpwgr+MV+shQdJa9rYsw8lNjHAshWrRXymYEhPqapXh/MW00SIf4w==
X-Received: by 2002:a05:6402:2804:b0:439:83c2:8be2 with SMTP id h4-20020a056402280400b0043983c28be2mr22845294ede.292.1664200723241;
        Mon, 26 Sep 2022 06:58:43 -0700 (PDT)
Received: from krava ([83.240.61.46])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906260600b0077ce503bd77sm8186031ejc.129.2022.09.26.06.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:58:42 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 26 Sep 2022 15:58:41 +0200
To:     Martynas Pumputis <m@lambda.lt>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCHv4 bpf-next 5/6] bpf: Return value in kprobe get_func_ip
 only for entry address
Message-ID: <YzGwEfj3ZAdU7K/V@krava>
References: <20220922210320.1076658-1-jolsa@kernel.org>
 <20220922210320.1076658-6-jolsa@kernel.org>
 <0e1742f8-06ea-1c69-d245-e3202a751f42@lambda.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1742f8-06ea-1c69-d245-e3202a751f42@lambda.lt>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 25, 2022 at 07:42:48AM +0200, Martynas Pumputis wrote:
> On 9/22/22 23:03, Jiri Olsa wrote:
> > Changing return value of kprobe's version of bpf_get_func_ip
> > to return zero if the attach address is not on the function's
> > entry point.
> > 
> > For kprobes attached in the middle of the function we can't easily
> > get to the function address especially now with the CONFIG_X86_KERNEL_IBT
> > support.
> > 
> > If user cares about current IP for kprobes attached within the
> > function body, they can get it with PT_REGS_IP(ctx).
> > 
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Tested the patches with "pwru --filter-func='.*skb.*'
> --filter-dst-ip=1.1.1.1" from [1] - the symbol name resolution works,
> thanks!
> 
> Without your patches:
> 
>                SKB    CPU          PROCESS                     FUNC
> 0xffff8989c159b4e8      0           [curl]       0xffffffffbbb06164
> 0xffff8989c223f000      0           [curl]       0xffffffffbbb07534
> 0xffff8989c223f000      0           [curl]       0xffffffffbbb04934
> 0xffff8989c223f000      0           [curl]         skb_release_data
> 0xffff8989c223f000      0           [curl]             kfree_skbmem
> 0xffff8989c159b4e8      0           [curl]       0xffffffffbbb00db4
> [..]
> 
> With patches:
> 
>                SKB    CPU          PROCESS                     FUNC
> 0xffffa4564159b4e8      0           [curl]   validate_xmit_skb_list
> 0xffffa4564159b4e8      0           [curl]       netif_skb_features
> 0xffffa4564159b4e8      0           [curl]     skb_network_protocol
> 0xffffa4564159b4e8      0           [curl]  skb_csum_hwoffload_help
> 0xffffa4564159b4e8      0           [curl]        skb_checksum_help
> 0xffffa4564159b4e8      0           [curl]      skb_ensure_writable
> 0xffffa4564159b4e8      0           [curl]             skb_to_sgvec
> [..]
> 
> [1]: https://github.com/cilium/pwru/tree/test-ibt-kernel-fix
> 
> Acked-by: Martynas Pumputis <m@lambda.lt>

awesome, thanks

jirka

> 
> > ---
> >   kernel/trace/bpf_trace.c                             | 5 ++++-
> >   tools/testing/selftests/bpf/progs/get_func_ip_test.c | 4 ++--
> >   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> [..]
