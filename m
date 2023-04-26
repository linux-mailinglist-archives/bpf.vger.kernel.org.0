Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B661C6EFAB4
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjDZTL4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjDZTLz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:11:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A9C133
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:11:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so11635370a12.1
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682536313; x=1685128313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cu1raF5FMtwrQ8Bo340HbyzNx2UJfRz7FGX25CQGyj0=;
        b=lt/+MXO2ix5ygIxlx5z7Xy5x784mjKT2m3xYyzPDrn96KDGshiz6cl5UiexS9SfYTr
         xOtcf1HbWix5m1SAdaPdig8QnZ/X6LI+J08xvJDW8+ToH8p6S5xQ7xw5s8BgNv0mUAms
         KNC0WYtjHas8K4zLtqLqX410fu4aj1RgvfkTNVLqugUgabcGOkmDhQABkjaBzjNIuAbS
         6xgZr3CabzhdMI0E0jlwAt+CijRElLn3UDoqm+08VT9RTYqYynoh+O5XimiT/NgVQ6zy
         qjqY5tbTgjDy6TIIh9hUH6mOOsS3UNOPGQBIrBJbI6CTB8LRwOXPfFIrkAoH0TBBOyuD
         sWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682536313; x=1685128313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cu1raF5FMtwrQ8Bo340HbyzNx2UJfRz7FGX25CQGyj0=;
        b=Hfc1fz16l5VavfFl6VdfI0URukC6X9amyNsykZh5zcqkELpVGbHvp9SU7QnF+0no8I
         w9lsJ7Sql38Dlk7z4QOkD+0I9TaEQNizkMy4zn18KV/gNwQSMA+oB7n0fNcpVkutZ55/
         bs2sLnvM/KpfXm2KSOH4SHjvrHV6opyLHaeIoLLVvjhAtmbIPkMtAgvbHrV2U6K3PeAl
         tCIhmBYVgBDYC6zJfV1EYDF/uLMezqjQa7lcQZf5sR3sBmJUbxVZ1+RIgDjmJZFhUtU1
         GtKagGUTFvc7HAQhIP17326TYDTW7A/enh5VqV4W15gFqirTBWRDp5KNXi2eGJWt/Xzz
         Tf+w==
X-Gm-Message-State: AAQBX9fEYMFvlfP8ZQi5wsEEMfoEJfCbppTtF00G3VxSxQ0HHW6V1Xnv
        wQcsNaHW3UtPQ/aBnDf0HVjqbK/V0rFNJrvfh94=
X-Google-Smtp-Source: AKy350ZPs/cDxGzYgroR7J2ZcRxkI+aIq2qvfuStC54kUe4x3hWQKc0u5B3A6xOKSBJEeiLbX55Ace31AMkQnXVRR3w=
X-Received: by 2002:aa7:d796:0:b0:508:3bb7:d703 with SMTP id
 s22-20020aa7d796000000b005083bb7d703mr20330953edq.4.1682536312956; Wed, 26
 Apr 2023 12:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-4-jolsa@kernel.org>
In-Reply-To: <20230424160447.2005755-4-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 12:11:41 -0700
Message-ID: <CAEf4BzZvb5PsJAJO7A-UP3bb7vNiSc2x=QPUN=uFZT08mqw1Dw@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 03/20] bpf: Add bpf_get_func_ip helper
 support for uprobe link
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
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

On Mon, Apr 24, 2023 at 9:05=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support for bpf_get_func_ip helper being called from
> ebpf program attached by uprobe_multi link.
>
> It returns the ip of the uprobe.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

LGTM. I assume that IP will be user space address for uprobes, right?
Might be worth calling this out explicitly (it's kind of obvious and
expected, though, so maybe I'm overthinking this).

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/trace/bpf_trace.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>

[...]
