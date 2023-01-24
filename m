Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE4C678FEC
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 06:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjAXFcS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 00:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjAXFcR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 00:32:17 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC521113FF;
        Mon, 23 Jan 2023 21:32:16 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mg12so36105742ejc.5;
        Mon, 23 Jan 2023 21:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NNreOgpbDDYLXB0lHydwWOLk/CCoPwMbZLNxKsq1ywA=;
        b=RXailLhO9HLEmDnh9MeambYI7cOBo27tc0/hQ2Y+LULzVK6aowd+as2L3azTtqIOSP
         HhmvSJOkmeiIRzxNi8swixvKhT0Gt2QIZl5Fjc3OmRvaEQW6O34RXNFRiBu7PaH9kB5S
         fJx5OUuyB3x4cnQc/uoe2ZAQNc7WVB4mfTx/XDo5lhmVSP9+hgiz1egJ+1/c/3mO/LjI
         yT80G2t6x6NKkcQkfmnhemSM3E20H6amEfZRk+gVaeeEttqu0vTsS6k+PAUC31hRDylT
         8JepnK424tOSulMkgoBoxXbJuW46zmsD3WmpJUtN7diJWFhUTOmD+lm8YTsQfeNWGQXY
         qtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNreOgpbDDYLXB0lHydwWOLk/CCoPwMbZLNxKsq1ywA=;
        b=1X7cyKC1OE1jBBF83y4IeEa4vGskj1v3ebcI2Tgpf7A7CcE+55eUsXoIjxJey5aZC6
         z+2K98DQYAo9ByNKI0F4OHhCcQnSB+p3Wn1akTL+Kkdb5Das3+1k7dzDQU8rmfCD47xY
         Xj3MEHO8M4Q/nAipnnDk4JEotkhoREeAHBMwn5LhjQ+ndOL0AEsnsTOr9BkMoZ9nMlXJ
         xa+mrG3ArqxSsZiUeymYcvyp2vf+8EjbN97/HSjVyOdB580YmMXCHF0iny1ruxHMmFBW
         OAA4YW+ICscCols9dG0JXweLO27rH/j/YzZIyHT4Om9ySxrbeTl1SLfnKKrXDXa7HLXQ
         ZZ5w==
X-Gm-Message-State: AFqh2kr6Y5cVUUM/t0TmqLVrqltBrpl+Ueqq0FpWsXz+mVobK86qUcpc
        7gdV/EGPpIlI5rUg6NvfHERloaSwGtMvTGS0mUA=
X-Google-Smtp-Source: AMrXdXvPcnv0tVhvVis9Zhru1bIw1wECYpQAcIXB/dvhFQBLK42qxBuzVuaBhekCMMzeyUUzmaMNy0i05i32sLc2vok=
X-Received: by 2002:a17:906:e0d3:b0:7b2:7af0:c231 with SMTP id
 gl19-20020a170906e0d300b007b27af0c231mr2509367ejb.240.1674538335104; Mon, 23
 Jan 2023 21:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20230123232228.646563-1-void@manifault.com> <20230123232228.646563-4-void@manifault.com>
In-Reply-To: <20230123232228.646563-4-void@manifault.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 23 Jan 2023 21:32:03 -0800
Message-ID: <CAADnVQKnyz4gqDXfo0OTDuGGbn3i-+roB4M4Q-uxiMLrSP=S=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf/selftests: Verify struct_ops prog
 sleepable behavior
To:     David Vernet <void@manifault.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>, Tejun Heo <tj@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Mon, Jan 23, 2023 at 3:22 PM David Vernet <void@manifault.com> wrote:
>
> +static struct dummy_st_ops *open_load_skel(void)
> +{
> +       int err;
> +       struct dummy_st_ops *skel;
> +
> +       skel = dummy_st_ops__open();
> +       if (!ASSERT_OK_PTR(skel, "dummy_st_ops_open"))
> +               return NULL;
> +
> +       err = bpf_program__set_flags(skel->progs.test_3, BPF_F_SLEEPABLE);

Feels that this is incomplete without libbpf support.
Instead of:
+SEC("struct_ops/test_3")
the users should be able to:
+SEC("struct_ops.s/test_3")

and the above manual set_flags won't be needed.
