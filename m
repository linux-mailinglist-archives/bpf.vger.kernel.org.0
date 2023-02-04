Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739EB68A92A
	for <lists+bpf@lfdr.de>; Sat,  4 Feb 2023 10:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjBDJV2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Feb 2023 04:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDJV1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Feb 2023 04:21:27 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D588F27D55
        for <bpf@vger.kernel.org>; Sat,  4 Feb 2023 01:21:25 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mf7so21498329ejc.6
        for <bpf@vger.kernel.org>; Sat, 04 Feb 2023 01:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rulwtckv80w0sIHvymUPwA0BEOwgFlDPC/VPj3zRpIs=;
        b=hyxT7/0Xxw5yWOsy1OIwON0nyP4DqevXgWpJ180XjtfC/D7W6E28YM6/De8BjLeYmZ
         FhbJ51Evb3gGzNAOC/EC17rzUGwXOGUXPRT4SIVpBK3NmP77n+Br3FHpJHyjgb5eLpqC
         ey7yD4B2UIjKHK3KhEq7hJbQ6QiVO7/PF9YfWZAvx1PV/DAPRBRSy26jgTIHu9BSpK0t
         uQilPCvSylfg/aoK4JnTuAfF4v6tyPtDoo1Spnc+B+i3NszaHeUp3x4q02m0/SLqHh1q
         KH35WaWwkNWXCMdCZWKKly1hfWV2nT5C9HsqDL0jnq0bgyqgyZrbUy7kV8TZ/QZHlLba
         RdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rulwtckv80w0sIHvymUPwA0BEOwgFlDPC/VPj3zRpIs=;
        b=tQ8EYMBROPpKi3iPJbnQutj6l/rqxrCdI0nr300iNmr2XU5THlcK3lg2BjfY6Zp0Nb
         b04PMHQa/h0JRQfLD7Saz3OGQNxgNy72NizgUH3SOqQHVdVYxOh7CpUXKmmZ+zchLJWR
         jYLmp71Kj7sI5SIgd7cBm2BMMIuXf9595t/6d4EDEcaKWj/Oach1l7QCCB3tm1W6CZl3
         rwhHjVpHpIz8YaJzA0dMKq1E9IlJx3746RAUyQp6L+BiexK8jvQeiH6jd7+iXZbqS+27
         oEfOIr25IVfXxjpe0J/0J+rK3O/1c2CslnDhwhj3LikCfhTDps89CIr3oBndiT9BCfFl
         WhEQ==
X-Gm-Message-State: AO0yUKV27BHIU5KOCsRQdtqkkVmrzB14f53F4MUEjv71ODl9bb2QiucJ
        EJzqAh83drvnuG15jlHgeID90bgT0qFInlt51/s=
X-Google-Smtp-Source: AK7set92Nrp72DSPtAEY2UtOetUPDJsqIYyjZKqc4QnJqDpfodL4F80zlPZmwxATBaF4TjrZIJJ09aV9FqwBggwL77c=
X-Received: by 2002:a17:906:6d13:b0:878:786e:8c39 with SMTP id
 m19-20020a1709066d1300b00878786e8c39mr3992879ejr.105.1675502484219; Sat, 04
 Feb 2023 01:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20230203162336.608323-1-jolsa@kernel.org>
In-Reply-To: <20230203162336.608323-1-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 4 Feb 2023 01:21:13 -0800
Message-ID: <CAADnVQKBYgN5nWG26s0s-U0=PMAWEc17aGWx76GLUc_PM22ZAw@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 0/9] bpf: Move kernel test kfuncs into bpf_testmod
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
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

On Fri, Feb 3, 2023 at 8:23 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> I noticed several times in discussions that we should move test kfuncs
> into kernel module, now perhaps even more pressing with all the kfunc
> effort. This patchset moves all the test kfuncs into bpf_testmod.
>
> I added bpf_testmod/bpf_testmod_kfunc.h header that is shared between
> bpf_testmod kernel module and BPF programs, which brings some difficulties
> with __ksym define. But I'm not sure having separate headers for BPF
> programs and for kernel module would be better.
>
> This patchset also needs:
>   74bc3a5acc82 bpf: Add missing btf_put to register_btf_id_dtor_kfuncs
> which is only in bpf/master now.

I thought you've added this patch to CI,
but cb_refs is still failing on s390...
