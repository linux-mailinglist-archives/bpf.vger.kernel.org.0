Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B8C4AC7E5
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 18:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344125AbiBGRq1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 12:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348895AbiBGRmh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 12:42:37 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECC6C0401D9
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 09:42:37 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y84so17855197iof.0
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 09:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xqo+6t0ue3N1pVD/MIWaP/FoEK4UVSgFwkyNcyriXdM=;
        b=VP1Y6IsnOYnDC9eJ7jBanBJlNWb0xTHnKzEnAxUkzcuRT/4lc/9tO0sYlnUuVMLtdJ
         ACIQPCoak9b9ID9Y3Y1hwqDxmiupPvPVYERuwBQuDVuqFSh1q7P0o9Wbi+P7a0vnuIhs
         t76cHKyzCPfrfuIpz614m0S44SPabPaV1h3BuQV50HaQH0kf44W8NbDfr8DOTizLzM8Y
         WvcnOyGWwUpfw7Uk4NAgN7YUG2Vq63ZkZBK9HNXtT9tvzXHU0xxK7uZ3L0EfMflyPIDE
         CI9Cq1K0zs1B8qShZMc1lQq3IfHPs/hAnhtHn1ZYKEYYwTViIF8mw/ebNS4REeNI0N1P
         66nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xqo+6t0ue3N1pVD/MIWaP/FoEK4UVSgFwkyNcyriXdM=;
        b=ekcnbSgAsK/2gMSHyIdCmYJziHSNfeKPQISpUQivFVpdbTXf9BvS2gAKtbe6Xg91aY
         zv/PrGkl4V6zycw0qadyWgf1bE6NYDdBF9t2X2QkM0Ht6XVSXbo7n2jOPEXhzNYZ2+n9
         pBhNbiMhTL4nfuzaOuuT+3a1ocpOqCeXJBt9cOH0ktiEQoU/0V83VjY58XI5KHLCblCb
         PcCCuJ2KCTi8UtO6WIVXr6W+gYOaGx823Wx497BBd1ebQzyDvh8DmpYpUXK6Ip+XKNSY
         7hbxo+/+plujuCK4c69rlVbcQENVgSCSfbuYWScQDZqMKh6X5eOjcrAeo4PZGXCxP0s/
         U6TA==
X-Gm-Message-State: AOAM5337BOU33TAgw5Fd9US3hg+x8cG/DyX2S6EkSpKy0L9VmHxUXVQX
        FMdEUcP1RYRaH+QlHIYmpU43+hV5HYXVXD1VFpw=
X-Google-Smtp-Source: ABdhPJwqRODKltv5F8EATLxoKmS02oFDYYAm1OGahJbO6Rzl1VDdnX9JNvGTELnIz20PDXhttL0NxTD/iUzlrkv7eHQ=
X-Received: by 2002:a5d:88c1:: with SMTP id i1mr320169iol.154.1644255756762;
 Mon, 07 Feb 2022 09:42:36 -0800 (PST)
MIME-Version: 1.0
References: <1644249625-22479-1-git-send-email-yinjun.zhang@corigine.com>
In-Reply-To: <1644249625-22479-1-git-send-email-yinjun.zhang@corigine.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Feb 2022 09:42:25 -0800
Message-ID: <CAEf4BzbjVnkb8Oz67p3jDhL-Pv9RG-wq1A7KMV06zowRK9psew@mail.gmail.com>
Subject: Re: [PATCH bpf] bpftool: fix the error when lookup in no-btf maps
To:     Yinjun Zhang <yinjun.zhang@corigine.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, niklas.soderlund@corigine.com,
        Simon Horman <simon.horman@corigine.com>
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

On Mon, Feb 7, 2022 at 8:00 AM Yinjun Zhang <yinjun.zhang@corigine.com> wro=
te:
>
> When reworking btf__get_from_id() in commit a19f93cfafdf the error
> handling when calling bpf_btf_get_fd_by_id() changed. Before the rework
> if bpf_btf_get_fd_by_id() failed the error would not be propagated to
> callers of btf__get_from_id(), after the rework it is. This lead to a
> change in behavior in print_key_value() that now prints an error when
> trying to lookup keys in maps with no btf available.
>
> Fix this by following the way used in dumping maps to allow to look up
> keys in no-btf maps, by which it decides whether and where to get the
> btf info according to the btf value type.
>
> Fixes: a19f93cfafdf ("libbpf: Add internal helper to load BTF data by FD"=
)
> Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund@corigine.com>
> Signed-off-by: Simon Horman <simon.horman@corigine.com>
> ---
>  tools/bpf/bpftool/map.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index cc530a229812..4fc772d66e3a 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1054,11 +1054,9 @@ static void print_key_value(struct bpf_map_info *i=
nfo, void *key,
>         json_writer_t *btf_wtr;
>         struct btf *btf;
>
> -       btf =3D btf__load_from_kernel_by_id(info->btf_id);
> -       if (libbpf_get_error(btf)) {
> -               p_err("failed to get btf");
> +       btf =3D get_map_kv_btf(info);
> +       if (libbpf_get_error(btf))

See discussion in [0], it seems relevant.

  [0] https://lore.kernel.org/bpf/20220204225823.339548-3-jolsa@kernel.org/

>                 return;
> -       }
>
>         if (json_output) {
>                 print_entry_json(info, key, value, btf);
> --
> 1.8.3.1
>
