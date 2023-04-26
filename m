Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB16EFADA
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjDZTSB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDZTSA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:18:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13074FF
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:17:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50506111a6eso13830965a12.1
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682536677; x=1685128677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zihP0FVvNq/zb4OyvOHfwnz1MSnZAJw5hAefcFKWQP0=;
        b=hjlWBh3apcdHao3Y4VxsUzMDU8y0pIbCYnwcP9eyTVGavFDEhFJwyBeR2jqNBVI/0E
         /5TmXhMK7Y4hinr6CLfwJghHa3btP323zj7zT0AeMeoCViKY4ZQDbmSP/WAfMaWXWl3u
         280gftbcLyXiIU2t0nN34ztC2ile/FH9WEAn+yudzPIqNJgDwSi2F3Fs7Z0Rcv6YYCq2
         mCuKTjDuqnYIbvY7DHqOeVfdap0X4gtqo7u5OxP7FwQFsqJKXIAy3UkLjz42S+Ycie8k
         edFektFSMquJu49XIrdeGWaiYOfTftPvV7IYt3RIC4z6fWQIZ12L6rsa9MCEnOUiCyog
         oPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682536677; x=1685128677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zihP0FVvNq/zb4OyvOHfwnz1MSnZAJw5hAefcFKWQP0=;
        b=edmX0/2AXM9t5pYLHq8xUE5BHoAWqv4wjCPCEsKoWOtSquaDcl/SZPAXWsd3LzgMH4
         dQ7B59VtOTRFlj5kvqzX08/mc7QHfKj2hpY5GDo3/2M14z/lUdcdwmRaTyVh7pyk323K
         ZoBTBtt+IR6Qn7TR8XhTgt4OwKpTzrjbauGj+qPHIGG0Pu4Q7sVvVjoJiGl6jbxfXPnS
         3a7Q0yZZutvdkYNNYzXkDkEci7EETJJZ5t6OyW+nb6b3gxxZYMhHchy/14HAcVZi9NzN
         8LKVS0L49h8d2lqTehWOuAvxR1H4bEiX+lk4Q/HFProwe33b4k0w46lo9Q1v096w0/jM
         /J+w==
X-Gm-Message-State: AAQBX9daN+5pJl7wdI4AjL4aY3bIKlzChn13pgRKozQjZPX4D5w9UMwu
        ZkOURUTV0nTB9g5JZ2mopZJSaeqWHWCvC9eTsssiKC0a/pM=
X-Google-Smtp-Source: AKy350YpubPAgYJiN2vswVYUdsf1RMUIc4G9sFUa9uBuajD3dHolClyg79w8XIUKLFaqCv7TsUzDg3W/9anSgW5v2ss=
X-Received: by 2002:a05:6402:10c2:b0:504:9cec:8afb with SMTP id
 p2-20020a05640210c200b005049cec8afbmr18070563edu.2.1682536677317; Wed, 26 Apr
 2023 12:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-2-jolsa@kernel.org>
In-Reply-To: <20230424160447.2005755-2-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 12:17:45 -0700
Message-ID: <CAEf4Bzayo2gUTyBZGUsv5LbgRY+wLrwNsP_1=hc4HU5SOGVjrA@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 01/20] bpf: Add multi uprobe link
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
> Adding new multi uprobe link that allows to attach bpf program
> to multiple uprobes.
>
> Uprobes to attach are specified via new link_create uprobe_multi
> union:
>
>   struct {
>           __u32           flags;
>           __u32           cnt;
>           __aligned_u64   paths;
>           __aligned_u64   offsets;
>           __aligned_u64   ref_ctr_offsets;
>   } uprobe_multi;
>
> Uprobes are defined in paths/offsets/ref_ctr_offsets arrays with
> the same 'cnt' length. Each uprobe is defined with a single index
> in all three arrays:
>
>   paths[idx], offsets[idx] and/or ref_ctr_offsets[idx]
>
> The 'flags' supports single bit for now that marks the uprobe as
> return probe.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/trace_events.h |   6 +
>  include/uapi/linux/bpf.h     |  14 +++
>  kernel/bpf/syscall.c         |  16 ++-
>  kernel/trace/bpf_trace.c     | 231 +++++++++++++++++++++++++++++++++++
>  4 files changed, 265 insertions(+), 2 deletions(-)
>

[...]

> +static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
> +{
> +       struct bpf_uprobe_multi_link *umulti_link;
> +
> +       umulti_link =3D container_of(link, struct bpf_uprobe_multi_link, =
link);
> +       kvfree(umulti_link->uprobes);
> +       kfree(umulti_link);
> +}
> +
> +static const struct bpf_link_ops bpf_uprobe_multi_link_lops =3D {
> +       .release =3D bpf_uprobe_multi_link_release,
> +       .dealloc =3D bpf_uprobe_multi_link_dealloc,
> +};
> +

let's implement show_fdinfo and fill_link_info as well? At least we
can display how many instances of uprobe are attached for a given
link? And depending on what we decide with single or multi paths per
link, we could output path to the binary, right? And PID as well, if
we agree that it's possible to support it. Thanks!


[...]
