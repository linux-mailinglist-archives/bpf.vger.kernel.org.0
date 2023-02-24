Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE16A21D9
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 19:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBXSzg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 13:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXSzf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 13:55:35 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72D6C8D7
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 10:55:27 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ee7so1177691edb.2
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 10:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wWZOYTl/NhkiTbVX6lb4bqIBuKyGvJmEQvcp/SdXuQ=;
        b=btQ4TomS/9Xgn97h0oNBvnq940iiXzenELq+dzZfPi158VJrFL3J8UfeKQ/gzhCVMe
         HIhN3SvzJjJvL8SIsBJfdiJBNC3/8a8u1fopqCpmfO/tbCBWMWm8bKVhmCENvyFgmPet
         HgBnoOl8XObMBrhevIhQkMT4J6pfdenIpyRV2A8ve9fqVTe8II2JChroC55tDIm8ICMe
         gQ+Ep9mbaW+7bb1pgqG0nAz+Eg9XcC9ez4seLCy+UHif4XhNyj/fzIP/mJ2dyX8Uvooi
         DzWz4asdP0FPBJFJPtba9DXuLQzerZj7UM0bys2sMvu97J6cVzswbgvOXUH/4VSA80Mo
         4X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wWZOYTl/NhkiTbVX6lb4bqIBuKyGvJmEQvcp/SdXuQ=;
        b=6xBonxCYeSLOySM8420JqROp11SwrShsKsCkxvFyUWBhRaz63xleoKvf+T/CBP2sNH
         dNsJVKmpanGgGi7vqs6iaElL16Uq5HIYqh/vl0ihE4t7sjZnupVODif6SKKX0QEihAy2
         CR7gceYMB/T08LojFoVL8penT157n9BGPp7PFNx7FtvY7B9bjw0zTTItNoLQDFPVAvDd
         sDetOpxG6iswAEA8J4DIWdaRkw4iYDmhnW69Ddc4KDt8lbeqjBZLbpThIS9ez50EXRms
         Jh4hxVyD8Zlac5P8DMWmzoeYi+oQoSaYyzm+9KeZiSM08h1jrw7AamKSc/VraXtJKjjc
         ljrQ==
X-Gm-Message-State: AO0yUKWOiRYXTS2BKlZJI34SjfyDe+qhuaCojLEJc1nQLD6JkKsPPTyx
        rWe+Hk8IC7UkCBRZfnkhUiRGL2FpH8V9/1tufxU=
X-Google-Smtp-Source: AK7set+U3GsBnjSjw7CAEtnES1RLtCTu8qvp+M/u1QCp/dT9p3y25Tx1d+s2SaTLwjmBnG1xqR7fm3p/WOGV1kHgPkE=
X-Received: by 2002:a17:907:2071:b0:8e5:411d:4d09 with SMTP id
 qp17-20020a170907207100b008e5411d4d09mr5310425ejb.15.1677264925849; Fri, 24
 Feb 2023 10:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20230221234500.2653976-1-deso@posteo.net> <20230221234500.2653976-2-deso@posteo.net>
In-Reply-To: <20230221234500.2653976-2-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Feb 2023 10:55:13 -0800
Message-ID: <CAEf4BzZq3PUUaG_samYSAtFPnJKJP0QF9saUx4Wr+r84j4=O5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] libbpf: Implement basic zip archive
 parsing support
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
        =?UTF-8?Q?Micha=C5=82_Gregorczyk?= <michalgr@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 21, 2023 at 3:45 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> This change implements support for reading zip archives, including
> opening an archive, finding an entry based on its path and name in it,
> and closing it.
> The code was copied from https://github.com/iovisor/bcc/pull/4440, which
> implements similar functionality for bcc. The author confirmed that he
> is fine with this usage and the corresponding relicensing. I adjusted it
> to adhere to libbpf coding standards.
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> Acked-by: Micha=C5=82 Gregorczyk <michalgr@meta.com>
> ---
>  tools/lib/bpf/Build |   2 +-
>  tools/lib/bpf/zip.c | 326 ++++++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/zip.h |  47 +++++++
>  3 files changed, 374 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/bpf/zip.c
>  create mode 100644 tools/lib/bpf/zip.h
>

[...]

> +
> +static int find_cd(struct zip_archive *archive)
> +{
> +       __u32 offset;
> +       int64_t limit;
> +       int rc =3D -1;
> +
> +       if (archive->size <=3D sizeof(struct end_of_cd_record))
> +               return -EINVAL;
> +
> +       /* Because the end of central directory ends with a variable leng=
th array of
> +        * up to 0xFFFF bytes we can't know exactly where it starts and n=
eed to
> +        * search for it at the end of the file, scanning the (limit, off=
set] range.
> +        */
> +       offset =3D archive->size - sizeof(struct end_of_cd_record);
> +       limit =3D (int64_t)offset - (1 << 16);
> +
> +       for (; offset >=3D 0 && offset > limit && rc =3D=3D -1; offset--)

rc !=3D 0 here to handle -EINVAL? It will keep going for -ENOTSUP,
though, which is probably not right, so maybe (rc !=3D 0 && rc !=3D
-ENOTSUP)?

but with the latter it feels better to just have explicit if with
return inside the for loop

> +               rc =3D try_parse_end_of_cd(archive, offset);
> +
> +       return rc;
> +}
> +

[...]
