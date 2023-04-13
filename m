Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5DA6E165D
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 23:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDMVOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 17:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjDMVOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 17:14:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA71D93C2
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 14:14:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50506ac462bso1419043a12.3
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 14:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681420454; x=1684012454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iw9rlpg8ozshQQ9GL1xtg2Yqf9pvDF0Kqb2ww8Y5MjU=;
        b=LSdIrSmUvrxApHW7CEhBgi/WqK60CVNyh/D3Ay9cG51sVnKkbeOxvrJr55iF8aqmWX
         WFVB7g9UU0Osim/aWPNBhegknN0BeFRhs0BRhnSk9Pt02Lx6i+KmLsi3lAttzws1LNhB
         DXQqiY/n2KqcN15qqxGYtddnD5M94VO68CNGt3EdJ8cFt7wm9JmySTXLx5pAnN4w2NHc
         hDSkzHkVuf1EC3gFMv0iFG8tqNCmcwLUH7QTwCcYtjxcn7kstrPO+wdFkxo2OTKfjcrC
         LMBf/zznusZES28EaQj0gNcopi5bjwg7Xj7AxULrbpbBZ4nS9oVOU/lsZRkJn3Mqc1Dr
         5//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681420454; x=1684012454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iw9rlpg8ozshQQ9GL1xtg2Yqf9pvDF0Kqb2ww8Y5MjU=;
        b=YVJTLqcOVWRcztcNoU6O9RiFCB1oF/vSRlUxpzcqblBmXrJDxBgD1bzyLW1ywoPIKF
         ncUndUzqBJjEZLoxiHSYbz+0pO2cVQqpo8OiSyUVsTJpvmMPV8Oull1iHkSqvqeBER4y
         98kjohHjkyL+rpjT4IBko8kvVbK3ie4QrcR16PJ22Xk6cjMQGm2yI1u9KSchdYbW/n7x
         c6Vov9pVx3pa1h1aJglKM4mMLvzqdyg8TpnRgHfxyZlxI7JWEdeJnSXnqiUVMT0rh9SJ
         CL1CsLQWXjhdAYOPfG7jwBAr/OJUX6cqWaNyMd3knAbyvdfWF+YNEQJ74Jp52Z70ITrY
         oYHA==
X-Gm-Message-State: AAQBX9ccTh0qF63ouSiKgWOJ+LjBsQhUiqZQoDJSSRyJHf/ymGmN7mrz
        K9x36BmpKFoaVcfcM2JrlMYr56jbAHK2QzUggqHoYA==
X-Google-Smtp-Source: AKy350b8WcrGf580mAFJ58BQiyNxUgjDL0y9ljpqarouqS6LOdRNth0G4IdY3nFrcWw6LS/UlDmayM6ZpL1sAifoCHU=
X-Received: by 2002:a50:9ee9:0:b0:504:ed04:5d3d with SMTP id
 a96-20020a509ee9000000b00504ed045d3dmr1957703edf.7.1681420454183; Thu, 13 Apr
 2023 14:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230413133228.20790-1-fw@strlen.de> <20230413133228.20790-6-fw@strlen.de>
In-Reply-To: <20230413133228.20790-6-fw@strlen.de>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Thu, 13 Apr 2023 22:14:03 +0100
Message-ID: <CACdoK4LRjNsDY6m2fvUGY_C9gMvUdX9QpEetr9RtGuR8xb8pmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] tools: bpftool: print netfilter link info
To:     Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        bpf@vger.kernel.org, dxu@dxuuu.xyz, qde@naccy.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Florian,

On Thu, 13 Apr 2023 at 14:36, Florian Westphal <fw@strlen.de> wrote:
>
> Dump protocol family, hook and priority value:
> $ bpftool link
> 2: type 10  prog 20

Could you please update link_type_name in libbpf (libbpf.c) so that we
display "netfilter" here instead of "type 10"?

>         pf: 2, hook 1, prio -128
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  tools/bpf/bpftool/link.c       | 24 ++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 15 +++++++++++++++
>  tools/lib/bpf/libbpf.c         |  1 +
>  3 files changed, 40 insertions(+)
>
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index f985b79cca27..a2ea85d1ebbf 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -135,6 +135,18 @@ static void show_iter_json(struct bpf_link_info *info, json_writer_t *wtr)
>         }
>  }
>
> +static void show_netfilter_json(const struct bpf_link_info *info, json_writer_t *wtr)
> +{
> +       jsonw_uint_field(json_wtr, "pf",
> +                        info->netfilter.pf);
> +       jsonw_uint_field(json_wtr, "hook",
> +                        info->netfilter.hooknum);
> +       jsonw_int_field(json_wtr, "prio",
> +                        info->netfilter.priority);
> +       jsonw_uint_field(json_wtr, "flags",
> +                        info->netfilter.flags);
> +}
> +
>  static int get_prog_info(int prog_id, struct bpf_prog_info *info)
>  {
>         __u32 len = sizeof(*info);
> @@ -195,6 +207,10 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>                                  info->netns.netns_ino);
>                 show_link_attach_type_json(info->netns.attach_type, json_wtr);
>                 break;
> +       case BPF_LINK_TYPE_NETFILTER:
> +               show_netfilter_json(info, json_wtr);
> +               break;
> +
>         default:
>                 break;
>         }
> @@ -301,6 +317,14 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>                 printf("\n\tnetns_ino %u  ", info->netns.netns_ino);
>                 show_link_attach_type_plain(info->netns.attach_type);
>                 break;
> +       case BPF_LINK_TYPE_NETFILTER:
> +               printf("\n\tpf: %d, hook %u, prio %d",
> +                      info->netfilter.pf,
> +                      info->netfilter.hooknum,
> +                      info->netfilter.priority);
> +               if (info->netfilter.flags)
> +                       printf(" flags 0x%x", info->netfilter.flags);
> +               break;
>         default:
>                 break;
>         }
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 3823100b7934..c93febc4c75f 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -986,6 +986,7 @@ enum bpf_prog_type {
>         BPF_PROG_TYPE_LSM,
>         BPF_PROG_TYPE_SK_LOOKUP,
>         BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
> +       BPF_PROG_TYPE_NETFILTER,

If netfilter programs could be loaded with bpftool, we'd need to
update bpftool's docs. But I don't think this is the case, right? We
don't currently have a way to pass the pf, hooknum, priority and flags
necessary to load the program with "bpftool prog load" so it would
fail?

Have you considered listing netfilter programs in the output of
"bpftool net" as well? Given that they're related to networking, it
would maybe make sense to have them listed alongside XDP, TC, and flow
dissector programs?

The patch looks good to me otherwise.

Thanks,
Quentin
