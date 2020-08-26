Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE34252690
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 07:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgHZFg6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 01:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgHZFg5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 01:36:57 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DBC061574
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 22:36:57 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id x2so282641ybf.12
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 22:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fekKqqwCiKjKoAwYRnXxqFqH02hThuNZuJBxCpw3/6I=;
        b=R9SPLU9J1nuL2QYoE9ZdX9zV9BEee/RQCX5APt3sEIAAJhw2h2bBdgc6s1cP4Z5i9Q
         5tJ82Py2iMj4d+NR62MUDyzdn95V628Yvzvqw7k/VYzllcIKsQaNHgjhAz+wjfY1vjkj
         xO48FUlQknh9pe+HqOLOquSBJKebn5CoeyT0ot2I/9JEctsQFZddPT1ytA8DP4doPOnZ
         xqb8ZFxq1MhQ/x36Jk/q7T9TvEohuySf14QWqB4G7DaNNNhtI328z2BOztV1f8ECKL1F
         w3s1+78AHcNCxwOl8Ph2J552Hu+I2lbJFq2dXr35zwoGUAH4o4S9tBAmKixyDV16r1SF
         KFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fekKqqwCiKjKoAwYRnXxqFqH02hThuNZuJBxCpw3/6I=;
        b=DnEGSH7rWJv3tUUlCJSxNLUAE4Ymu6ovHcnXbUMRVzJI8yI6r0OuieT9AvMaKYBRsW
         imhts8wAhXwuH85aKiiu+Z2IZfCNk12JsZC+SMnR20nsF7O5pbsPUQ0TJvY2Uqf1DSPa
         ZqoMUPVRCYUdAuLxDnjr2IWlCQWGudo7ikBJD/DWFTHyNyvQWnOWspgu6BIrAoC7aFuI
         LjVnWVZ5knIRfDQ4PD3JrGUQH2OdGedhSl29TsRP9vjshZCRZq/bU3J5kmWhzOh1wWW9
         S7I2Zbven5Mr+qE/zqThT8uWd+nFwcZlSqdSvI5+uFR40SBu0a3vrsNxLUwcogSk/+yF
         rWyA==
X-Gm-Message-State: AOAM532NOZRPjzDAr8h4Pr/sxsN8GmVZbd7vYQqqRR/U3vqpjI4BJPuT
        dROtzWQhwbAgHYf8dpF0StHZu56bPVtJci/xhL0=
X-Google-Smtp-Source: ABdhPJy5tkoc0Co3Mv7NyLD+Pt+yphte78/h1wKw8OEbILl1kctx6Pg+4hWV0d/i7qO2fiKJvAvqRywNldsiAmoxSvQ=
X-Received: by 2002:a5b:44d:: with SMTP id s13mr19621549ybp.403.1598420216296;
 Tue, 25 Aug 2020 22:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597915265.git.zhuyifei@google.com> <9138c60f036c68f02c41dae0605ef587a8347f4c.1597915265.git.zhuyifei@google.com>
In-Reply-To: <9138c60f036c68f02c41dae0605ef587a8347f4c.1597915265.git.zhuyifei@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 25 Aug 2020 22:36:45 -0700
Message-ID: <CAEf4BzaGFP=Ob5MOcQgBjFOdY8aP1gvNV68wTAzA-V3kR5BKYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpftool: support dumping metadata
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 20, 2020 at 2:44 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> From: YiFei Zhu <zhuyifei@google.com>
>
> Added a flag "--metadata" to `bpftool prog list` to dump the metadata
> contents. For some formatting some BTF code is put directly in the
> metadata dumping. Sanity checks on the map and the kind of the btf_type
> to make sure we are actually dumping what we are expecting.
>
> A helper jsonw_reset is added to json writer so we can reuse the same
> json writer without having extraneous commas.
>
> Sample output:
>
>   $ bpftool prog --metadata
>   6: cgroup_skb  name prog  tag bcf7977d3b93787c  gpl
>   [...]
>         btf_id 4
>         metadata:
>                 metadata_a = "foo"
>                 metadata_b = 1
>
>   $ bpftool prog --metadata --json --pretty
>   [{
>           "id": 6,
>   [...]
>           "btf_id": 4,
>           "metadata": {
>               "metadata_a": "foo",
>               "metadata_b": 1
>           }
>       }
>   ]
>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>  tools/bpf/bpftool/json_writer.c |   6 ++
>  tools/bpf/bpftool/json_writer.h |   3 +
>  tools/bpf/bpftool/main.c        |  10 +++
>  tools/bpf/bpftool/main.h        |   1 +
>  tools/bpf/bpftool/prog.c        | 135 ++++++++++++++++++++++++++++++++
>  5 files changed, 155 insertions(+)
>

[...]

> +       for (i = 0; i < prog_info.nr_map_ids; i++) {
> +               map_fd = bpf_map_get_fd_by_id(map_ids[i]);
> +               if (map_fd < 0)
> +                       return;
> +
> +               err = bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len);
> +               if (err)
> +                       goto out_close;
> +
> +               if (map_info.type != BPF_MAP_TYPE_ARRAY)
> +                       goto next_map;
> +               if (map_info.key_size != sizeof(int))
> +                       goto next_map;
> +               if (map_info.max_entries != 1)
> +                       goto next_map;
> +               if (!map_info.btf_value_type_id)
> +                       goto next_map;
> +               if (!strstr(map_info.name, ".metadata"))

This substring check sucks. Let's make libbpf call this map strictly
".metadata". Current convention of "some part of object name" + "." +
{rodata,data,bss} is extremely confusing. In practice it's something
incomprehensible and "unguessable" like "test_pr.rodata". I think it
makes sense to call them just ".data", ".rodata", ".bss", and
".metadata". But that might break existing apps that do lookups based
on map name (and might break skeleton as it is today, not sure). But
let's at least start with ".metadata", as it's a new map and we can
get it right from the start.

> +                       goto next_map;
> +
> +               goto found;
> +
> +next_map:
> +               close(map_fd);
> +       }
> +
> +       return;
> +
> +found:

[...]
