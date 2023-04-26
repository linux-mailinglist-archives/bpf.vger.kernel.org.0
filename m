Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17E6EFAD1
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjDZTPX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239327AbjDZTPO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:15:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B530359C7
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:15:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5051abd03a7so11174064a12.2
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682536506; x=1685128506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHth1HSjcUblD6HuiQbwly/jJ3B37VHNRLoG+u/0ydk=;
        b=k6Q+rjup/8u/HUJi3yNE61GrFZrOv6sd5Yq/EFJnxQPvneOgfW6wvd4hxoDKXEs6bg
         3uPBMfI5QDiXUtVqYJJeXWn5uqSDVyOd3WpJZ6Z7y4T4ySOKhxY9K1o1De93u53jAPVs
         8l0+cDSePzZ8ryQ0E1V68NXaHkzwjB5UMF/GQOg33kLwlRttDvNppREno+8LZhnnnzwz
         HJxXB1I0OvAjhQCI6OsyGxD0TxTL3fg+bP426++i7bWpScWA4Tjzrf7VwPc/6DqcV/0b
         Ho9sb4/7c+iiQbLSu1R7YriYYHjuvkaHN3EbdVsjKPrq4vBW5Swjb0E6owcV7P2LXKzL
         By2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682536506; x=1685128506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHth1HSjcUblD6HuiQbwly/jJ3B37VHNRLoG+u/0ydk=;
        b=gt+W1lgAZIMYABLaJgvcc1Q+DVIz/N41MtUK9FAh8FIn/M9h3m47258ewT9IMHqjU4
         AHUcgFtu0OB6aGqEfhzHvXEskXhd5hmyQWgb5BmXmOfgSs0qQMvnlwa9qAglPxTpN6l5
         mAd7lJE/WNgc1JrmNARPJJFF4bQB60BUGnmFysV5bW2t0aijRk0DJRCj3FHoOihT1pi+
         fwCpSMp6ZgOedzjw1nJOYqfy27piJkkIPicSnnQ7LDt6O8PHFFOkWwQxcMymJCm92vPl
         Kd2BRfNfOwk0oIPlcc5Er4Yh48J3HUQrL42EJdggAatk6Nb9qHrFFedd3t30ORN8IhPi
         NzGg==
X-Gm-Message-State: AAQBX9cY9qXgERFub4gtgp43JG1ZX034o117Hf/1GdU2J9UhBI+hFWZh
        eTbv++A0wmFqpIqI+RAWjV7KqaJ7FWOKACobSy8=
X-Google-Smtp-Source: AKy350aMbs1KmLVhksLaLP7Y7L5uGV8jo06QPYbCQMEErTTBrayhVXYU56hlghQGKmsEkVL2ru5bROSgLRZ3XyFblw0=
X-Received: by 2002:aa7:d9c1:0:b0:509:bf63:a97e with SMTP id
 v1-20020aa7d9c1000000b00509bf63a97emr16062029eds.16.1682536505789; Wed, 26
 Apr 2023 12:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-6-jolsa@kernel.org>
In-Reply-To: <20230424160447.2005755-6-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 12:14:54 -0700
Message-ID: <CAEf4Bzbg1bvXcjqoK=CY3nHA7e5r34yedb82nir7-J37bJ9=xg@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 05/20] libbpf: Add uprobe_multi attach type
 and link names
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
> Adding new uprobe_multi attach type and link names,
> so the functions can resolve the new values.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/libbpf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1cbacf9e71f3..b5bde1f19831 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -117,6 +117,7 @@ static const char * const attach_type_name[] =3D {
>         [BPF_PERF_EVENT]                =3D "perf_event",
>         [BPF_TRACE_KPROBE_MULTI]        =3D "trace_kprobe_multi",
>         [BPF_STRUCT_OPS]                =3D "struct_ops",
> +       [BPF_TRACE_UPROBE_MULTI]        =3D "trace_uprobe_multi",
>  };
>
>  static const char * const link_type_name[] =3D {
> @@ -131,6 +132,7 @@ static const char * const link_type_name[] =3D {
>         [BPF_LINK_TYPE_KPROBE_MULTI]            =3D "kprobe_multi",
>         [BPF_LINK_TYPE_STRUCT_OPS]              =3D "struct_ops",
>         [BPF_LINK_TYPE_NETFILTER]               =3D "netfilter",
> +       [BPF_LINK_TYPE_UPROBE_MULTI]            =3D "uprobe_multi",
>  };
>
>  static const char * const map_type_name[] =3D {
> --
> 2.40.0
>
