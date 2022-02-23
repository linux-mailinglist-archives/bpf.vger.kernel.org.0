Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC08C4C1EBA
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 23:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbiBWWnK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 17:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239123AbiBWWnJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 17:43:09 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246EDAE64
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 14:42:41 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d7so326749ilf.8
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 14:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+JALDyJ8QLqIedfI6kOYZ20uc8AbxmmpJplT8TSCgU=;
        b=KOV7V21T8hnnqtYL/LFWJiAHGtbpK6/um7PON4CUhOsobPIFSj8vq8xae7VVPK41hD
         vt91HBrQl5IqEF2o04+3lsedVoWF5wC3y65PJrAmUOUX9AU8dE+Gzhq40xNBaWuYW+Ho
         BIJGIcYhGyXgrUeECckMR7oup+RrekPcQKqOhWiH1/OL6EH2q3UoCQSBQ7t3Lummousa
         blnGbCLNWwEJkFsakczk5jZU5jRsXX7yDyuQSYe7vxXa7ic/bsxns6oVSUIRUkiBcKl1
         2vL54U7bJpW3iqKywwo7SZV3sOw2bW4JxaKq7LkJNRj2LyC2MgIx9Rqvt6wrs5y79xAI
         yy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+JALDyJ8QLqIedfI6kOYZ20uc8AbxmmpJplT8TSCgU=;
        b=qYMnn9WlNEDasE5gpirjRFdg5J8lGmyfsuKla6Ll52q2RrdMovRfkCj8LJZ1+USVvW
         5iFZNovj42ytyqymkE4185TW/cVsAp9wCDu1oL6LScPqntjA9mVEodU6jW2sG2MyNA/9
         uEaIMWCnxJC6WsuD/iyT2zr9h7vMlp3HzS3obYvBb+WCzaTDTd6uWpUfCF346y0Os/jA
         p7KhBJHoAJ9hTKATRoz8g4QCAmZ2IqY0VvbfEuKb2ZwsAKqFturjD8d720hZ9kvZ77e5
         IqB/t8Ejysd988jJMGFSx+yoRI1cXG6QfchXoUfXu9NA4xDOLY/FRh/YZgvZJYuawssD
         7t/A==
X-Gm-Message-State: AOAM533g/kkZ+sMsc4Iy839baMRhALnqTUY1fWRH6jIJgZC+ZRlCiMKJ
        kf/TDYv1IvswuOj5Co6utXaaXavv+ny+jRUbGnA=
X-Google-Smtp-Source: ABdhPJxCq5tViR+76IGQIgOKBD5QUa/RFHpKIzZrlA4akGrSffkQBh79HNuMBQqwgylBX9Kid7MAYZhsl+Iq5zZSwnA=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr1513364ilb.305.1645656160582; Wed, 23
 Feb 2022 14:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20220222074524.1027060-1-xukuohai@huawei.com> <20220222074524.1027060-2-xukuohai@huawei.com>
In-Reply-To: <20220222074524.1027060-2-xukuohai@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Feb 2022 14:42:29 -0800
Message-ID: <CAEf4BzY_GT-0zSXP0Vp2ekoLa0FnouW0yNuY7KUBQCBeS=mo2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Skip BTF_KIND_FWD when counting
 duplicated type names
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 21, 2022 at 11:34 PM Xu Kuohai <xukuohai@huawei.com> wrote:
>
> If a FWD appears in the BTF before a STRUCT with the same name, the
> STRUCT is dumped with a conflicted name:
>
>     $ bpftool btf dump file vmlinux format raw | grep "'unix_sock'"
>     [81287] FWD 'unix_sock' fwd_kind=struct
>     [89336] STRUCT 'unix_sock' size=1024 vlen=14
>
>     $ bpftool btf dump file vmlinux format c | grep "struct unix_sock"
>     struct unix_sock;
>     struct unix_sock___2 {      <--- conflict, the "___2" is unexpected
>                     struct unix_sock___2 *unix_sk;
>
> Fixes: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  tools/lib/bpf/btf_dump.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 07ebe70d3a30..55079efbd8f1 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1505,13 +1505,15 @@ static const char *btf_dump_resolve_name(struct btf_dump *d, __u32 id,
>         if (s->name_resolved)
>                 return *cached_name ? *cached_name : orig_name;
>
> -       dup_cnt = btf_dump_name_dups(d, name_map, orig_name);
> -       if (dup_cnt > 1) {
> -               const size_t max_len = 256;
> -               char new_name[max_len];
> -
> -               snprintf(new_name, max_len, "%s___%zu", orig_name, dup_cnt);
> -               *cached_name = strdup(new_name);
> +       if (!btf_is_fwd(t)) {

let's handle FWD as a special case and not touch existing logic. Maybe
something like this?

if (btf_is_fwd(t) || (btf_is_enum(t) && btf_vlen(t) == 0)) {
    s->name_resolved = 1;
    return orig_name;

}


btf_is_enum() part should handle enum forward declarations (they are
represented as enums with no values defined)


> +               dup_cnt = btf_dump_name_dups(d, name_map, orig_name);
> +               if (dup_cnt > 1) {
> +                       const size_t max_len = 256;
> +                       char new_name[max_len];
> +
> +                       snprintf(new_name, max_len, "%s___%zu", orig_name, dup_cnt);
> +                       *cached_name = strdup(new_name);
> +               }
>         }
>
>         s->name_resolved = 1;
> --
> 2.30.2
>
