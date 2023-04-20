Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50F66EA018
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 01:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjDTXlZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 19:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDTXlZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 19:41:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0756A2D65
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:41:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-504dfc87927so1635223a12.0
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682034081; x=1684626081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFg2Cw/GimRTtwnRELQsGuUWa/0tOu2lwvgWMwbFW18=;
        b=KogUTH+GuIaEvdKOjQ+EMI7r6iFljw2m4iIyN24scvlIq5DE6bck360DCQnjGvwUqo
         HvqR2cXCOKzHGSc37+JLjpWJopHpWS2dsyd6srSwdZdz4vHkDDl4LR9wnigE6nhuks1k
         XsIA2B0ViewykIzKO2N+pbOf/6n/iqL3gZwqM7YYSwCOXSUh0OUBOEKxmTs2iUM2ronR
         lTmbTChtl6RL6u38lB7vv4vGBatbNGD8XPfzS1FIUrYVLpwwmOKEOMlCEJ+2SJZJYYjx
         756XtBA/3ZKV0KlBvuCdpQD/eUBsYtsXVsS+GGhBrXfb0bSsZ9flMlGGMOQFNRowvrTF
         miVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682034081; x=1684626081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFg2Cw/GimRTtwnRELQsGuUWa/0tOu2lwvgWMwbFW18=;
        b=Rmnr3WU/vnYDVb3bhnBpGGMqJ4nyJIWSxAceccle/Az1vLcoYv3cEqhzir0SpOTbYy
         5HkvAEAtrMINYDrFnGFq5VS05MrM+w6bsw7K+U8A3wryykzHOvpCM9WooOcUrnLjxbgv
         UC9rtQjJYO6Vx0AQYfj5XKbHGtvbuGlLyCQ5Mo3LMcLL0fRfCePimKCkaPjqvDOHVPQI
         3+8EjBt/83+uPFBq1uUf7Hs+pVlM0iy/N2CLpMOuYjZ6AsrOds8nd633eKvIlHIZ1nUG
         CRrOkY7Y/M6lP7rNFG8cIXChVvrV77buxuzxQzk+IzJl5MJj14MXq09qOZK7+tOztX5w
         q7tg==
X-Gm-Message-State: AAQBX9fy+jZkK1NzqP/GHmZD9h60bCXYnJSPEi2/hmhUTemv+exINC8G
        NBYZnPM2vTtjGdu3bOyY0dq3GH68UCZEjLpjJOz4xzUh
X-Google-Smtp-Source: AKy350YNZwpzAaVX6vg0PcnyLpst/0AVQt44v8SWWN+gnJVTgG+FKU9Na3kYAYOF3xpvvVhcNHjvQfOLayJywG62eIM=
X-Received: by 2002:aa7:db42:0:b0:506:b228:7aff with SMTP id
 n2-20020aa7db42000000b00506b2287affmr3220538edt.23.1682034081320; Thu, 20 Apr
 2023 16:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230419003651.988865-1-kuifeng@meta.com>
In-Reply-To: <20230419003651.988865-1-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Apr 2023 16:41:09 -0700
Message-ID: <CAEf4BzY3DOYZOQBfvvOEGdKaUF+M8DS8Q33devTWzjcEHkOuQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Show map IDs along with struct_ops links.
To:     Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        yhs@meta.com, song@kernel.org, kernel-team@meta.com,
        andrii@kernel.org, Kui-Feng Lee <kuifeng@meta.com>,
        Quentin Monnet <quentin@isovalent.com>
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

On Tue, Apr 18, 2023 at 5:37=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> A new link type, BPF_LINK_TYPE_STRUCT_OPS, was added to attach
> struct_ops to links. (226bc6ae6405) It would be helpful for users to
> know which map is associated with the link.
>
> The assumption was that every link is associated with a BPF program, but
> this does not hold true for struct_ops. It would be better to display
> map_id instead of prog_id for struct_ops links. However, some tools may
> rely on the old assumption and need a prog_id.  The discussion on the
> mailing list suggests that tools should parse JSON format. We will mainta=
in
> the existing JSON format by adding a map_id without removing prog_id. As
> for plain text format, we will remove prog_id from the header line and ad=
d
> a map_id for struct_ops links.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> ---
>  tools/bpf/bpftool/link.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index f985b79cca27..8eb8520bd7b4 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -195,6 +195,10 @@ static int show_link_close_json(int fd, struct bpf_l=
ink_info *info)
>                                  info->netns.netns_ino);
>                 show_link_attach_type_json(info->netns.attach_type, json_=
wtr);
>                 break;
> +       case BPF_LINK_TYPE_STRUCT_OPS:
> +               jsonw_uint_field(json_wtr, "map_id",
> +                                info->struct_ops.map_id);
> +               break;
>         default:
>                 break;
>         }
> @@ -227,7 +231,10 @@ static void show_link_header_plain(struct bpf_link_i=
nfo *info)
>         else
>                 printf("type %u  ", info->type);
>
> -       printf("prog %u  ", info->prog_id);
> +       if (info->type =3D=3D BPF_LINK_TYPE_STRUCT_OPS)
> +               printf("map_id %u  ", info->struct_ops.map_id);
> +       else
> +               printf("prog %u  ", info->prog_id);

if we output "prog %u" for prog_id, shouldn't we just output "map %u"
for map_id?

>  }
>
>  static void show_link_attach_type_plain(__u32 attach_type)
> --
> 2.34.1
>
