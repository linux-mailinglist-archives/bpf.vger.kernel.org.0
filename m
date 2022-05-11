Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1C5523D03
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 21:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbiEKTGK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 15:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbiEKTGD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 15:06:03 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DF435A96
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:06:01 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id a22so3013684qkl.5
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ivx0mcs/RPO5DAJXCudm6/jZaadeUToZiI2IlLY+xMc=;
        b=meJt1VvEsQ1zAESQ7W05hLgVyFjwVPpO1EIODiiZYJmVlAuuBYMcVQriI3GjIiWP/p
         14h+9lYNLuAHglCKOvwToTks4scxVLeO2Akxyax7i9XwdDdRGdFGNYqejVDsCpiljB6u
         AG08huEG7CDGjcyaNUO6J20PxxdIPYgjYtEzyayyGZtktvKawg+n2rUzoggRj6Mlki9z
         A0pXYkq5CtLPKZRU1DU5JCmZF1kuhne9lFixnhVQpqwGY6fwgQNhtLm8iqvb1NO0t9RY
         n4aSwNxiAfPWetWscGq8309XZBKZgAzJNGDlT4nv4JO6hDg6SggENAnF9zKnlvsxfXyV
         +isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ivx0mcs/RPO5DAJXCudm6/jZaadeUToZiI2IlLY+xMc=;
        b=SQD2QoA8A8W468iW3Pb2lDSkzTyOQpW2acGM/SPttDGiA/yAtqxvspxEaMMsjzrJPb
         s3SDOv6bWx8JrAvctNPw8QeyN3aVycWjp1hxiOC7GAFBOiSJxEHd/xXsqB7jRWqhxArQ
         qsQQJunj21u5/QvxwbuzhzT8C//lyI8Vc+LTVZqW/koUDefD9n2UPRxQK9XFvOdVjCvS
         Dqv3azTdQyhYcWZf9rb1yxipRy8CEwuIZkiP36T2KPxoXW39Nb3mpAtjfjVDrWq06NO7
         9752w/aL+sXfIZcg0rcONPTGzEoBshdK6VnbBPd8+/EZqJVZXpRZ5UjUm8+il88/g9+B
         iYXA==
X-Gm-Message-State: AOAM533t6fTFTT9zIrA2YcRAq5e7taTx2CIuXiqPVNTcVkhQbCRpjfyJ
        bc2WmbuSED288+Qom0wB+UBk1ILG3/O3pShJBc32/glZ
X-Google-Smtp-Source: ABdhPJxOoC/YHBLN7AJGhiB/FZC4fUSPf0d9XJfZVFHl51H+Rq3vUp+ZDI2Ms7Fy726eyt3nRIBrAPxmN0vsh0FW6pg=
X-Received: by 2002:a05:620a:258e:b0:680:f33c:dbcd with SMTP id
 x14-20020a05620a258e00b00680f33cdbcdmr21286552qko.542.1652295960933; Wed, 11
 May 2022 12:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220511172249.4082510-1-deso@posteo.net>
In-Reply-To: <20220511172249.4082510-1-deso@posteo.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 11 May 2022 12:05:49 -0700
Message-ID: <CAADnVQ+JVHMr9w0n6moWkb1FgbZ-g-ab6O5YmbA4H7n7+BDgjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Enable CONFIG_FPROBE for self tests
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 11, 2022 at 10:23 AM Daniel M=C3=BCller <deso@posteo.net> wrote=
:
>
> Some of the BPF selftests are failing when running with a rather bare
> bones configuration based on tools/testing/selftests/bpf/config.
> Specifically, we see a bunch of failures due to errno 95:
>
>   > test_attach_api:PASS:fentry_raw_skel_load 0 nsec
>   > libbpf: prog 'test_kprobe_manual': failed to attach: Operation not su=
pported
>   > test_attach_api:FAIL:bpf_program__attach_kprobe_multi_opts unexpected=
 error: -95
>   > 79 /6     kprobe_multi_test/attach_api_syms:FAIL
>
> The cause of these is that CONFIG_FPROBE is missing. With this change we
> add this configuration value to the BPF selftests config.
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>

Please use 'selftests/bpf: ' prefix in the patch subj
in the future.
I've fixed it up while applying this time.
