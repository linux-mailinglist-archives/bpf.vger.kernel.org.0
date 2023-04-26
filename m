Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C616EFB20
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbjDZTdT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbjDZTdR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:33:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C072684
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:33:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so13085756a12.3
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682537586; x=1685129586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7sZaAqrtEX9/N0wYEoEgig7d/0mKMBJk8C9Vn4bxnI=;
        b=piSvqZXBI7BXoXfbATGwXDp3SLwa/y5hOJc+uLq/52Qam9L8Oa13AVIjSnmRzij+dW
         XnPAwM67wEuqGKVaBz+vSVaopAKiowXpHgzYdyodOxU/RB8Nr7ZwvEyD5NczswV82z81
         V8ESLfIA9yJFzlX//GrZioGlmTPiopd0KIFO6+PvhGZURCeaYGcp1Q6o0MgPA6GuLlpV
         rmP+Z4ddM6FXAgpgu4ozmXGJ98H5IqUY2g8mSnufX1emvIkvs+B2yQ4zhIZUegbOp+fS
         9rF86q/XjChA3kbwqNMQr7TGWgq7I5PJCknTZmFlm3sgplb5zk3vFuZ38DTR8uo1ZoWn
         XitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682537586; x=1685129586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7sZaAqrtEX9/N0wYEoEgig7d/0mKMBJk8C9Vn4bxnI=;
        b=UFaPUaAB2u1SKikoTmYgIOMkMxjYWzD5CDDkrzXm2FgCGRy52tf93mZ/sUPms50B0S
         oslkUrYrj0RGE8QmN0SX1BhhkWVZAu7svxcIzqHbg+q0shYgVMMdfmVk3werz8bOZBOm
         NrAvA40toKgGSmObqxG27yfsOlj18xu2y9QMqRgjFwnAXvT/HpsWKcA19t0sv82NsINg
         ZJ8Ln+x4vtz/gH0WmMbEt7X8fJ9cRm5AmLwF4vzoQWkO7mG6cSkBXks57lfYhnr1jTer
         Ie2nlpZ4kjtJerzFhZcuqErTxsxwLGoILzsAPceNYcHecxu6G1m4In2gA9Nq24fWpMV1
         mTVQ==
X-Gm-Message-State: AAQBX9eCUiJXupG/u2VkuAJBnG5tP6BiKUEKqSARayjcP3S2pOyG9XqQ
        3aGQUPZwqbacOOGJRl/hmP4AVQ99xFkJdiKGu/0=
X-Google-Smtp-Source: AKy350Zs5IirITAeWBzaw4ylCuJmxT4yQ5PDpr6U7uC1AEcArrGsl+CCRVXY61eBDtw0josd1O6SAiVfAGmWST31coE=
X-Received: by 2002:a50:ee07:0:b0:506:9984:9236 with SMTP id
 g7-20020a50ee07000000b0050699849236mr17978879eds.15.1682537586385; Wed, 26
 Apr 2023 12:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-13-jolsa@kernel.org>
In-Reply-To: <20230424160447.2005755-13-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 12:32:54 -0700
Message-ID: <CAEf4Bzbku8kkAe1ptDqDYrwPqRFqCZO0VisNX9Vt1tf0H7kkBA@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 12/20] libbpf: Add uprobe multi link support
 to bpf_program__attach_usdt
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

On Mon, Apr 24, 2023 at 9:06=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uprobe_multi bool to struct bpf_usdt_opts. If it's true
> the usdt_manager_attach_usdt will use uprobe_multi link to attach
> to usdt probes.
>
> The bpf program for usdt probe needs to have BPF_TRACE_UPROBE_MULTI
> set as expected_attach_type.
>
> Because current uprobe is implemented through perf event interface,
> it allows the pid filter for uprobes. This is not the case for
> uprobe_multi link, so the pid filter is not allowed for that.

Ok, yep, let's fix that at kernel UAPI level and use multi-uprobe
transparently, if kernel supports it. This seems like a big UX problem
currently with uprobe.multi (and consequently with USDT programs)

>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c          |   9 ++-
>  tools/lib/bpf/libbpf.h          |   2 +
>  tools/lib/bpf/libbpf_internal.h |   2 +-
>  tools/lib/bpf/usdt.c            | 127 ++++++++++++++++++++++++--------
>  4 files changed, 105 insertions(+), 35 deletions(-)
>

[...]
