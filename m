Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B59E6EB51F
	for <lists+bpf@lfdr.de>; Sat, 22 Apr 2023 00:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjDUWoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 18:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjDUWoL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 18:44:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41351BD9
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 15:44:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-504e232fe47so3863218a12.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 15:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1682117048; x=1684709048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tvf5j/bINAOiQrCkYKeeaDxMIaoN8V+mcRrm9nEicRY=;
        b=Ov7f87q+/GNcxXrkOnaERdvsYozN6ITub+SEYzIvIhDWs4EDVBoknOMx+R5E1AudF8
         +hNH3cwIO85Ba53Hx2FGdcP4Ke3cVEfmjDIB8LAeJvesnVwsjMws0taaAC0Z3ScxxppB
         f9sXawapASYud7MGVUciJPDAF8I3L9G8ENjp4DM9u9bpNnlajdgg3qcx1MBdiZ3UB2Fa
         NeMLvIL9E+9M/rsaxsq7SOYCpkvY46G7xYRFTef5MFdtwOEXwRjkmSPi4eWGePakMnwZ
         pXbehglwI+R+IHSTPYmZvVuA5yinKq8YLUw6Tc0gYBDSpxIRk1T3lHX200NH/BlXRa//
         ja/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682117048; x=1684709048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tvf5j/bINAOiQrCkYKeeaDxMIaoN8V+mcRrm9nEicRY=;
        b=AlIycmvtQd3n553ysVmBYklEIRW5BQo2/ZPFEofs4gaRwu3+cC/lI14O/FV+q7s5p8
         CyXMNe5gQBx3kZ6LjFAJSonmI5w8J3N4zM68e0UdLANoZqa2AfHrgDFjHXDBVq9R6VYx
         M9NF2AmsQEJcxlbcJ5YnnDRVv2dxxElFHl1kTf2G35IgYNXlhiKPA2qT0DoQr5tG8cGb
         wlxHnaFFX9VMwYgdLcxQXIcI6xmZMu4ZYToHosZ0vUnoDr2VrwC6bwxWy8F1HGTTnDjM
         cEznStvrNmsphFMfdzJ+HtUbbpP1BUJ0XuFR+LNVOOwqbgrPg1V6TelRTX8Xv2uPIxpT
         GeYQ==
X-Gm-Message-State: AAQBX9daFO45COkEITmJ+VpnO5FER6D0PbGAz/asTJASuZ4ZzI4cucra
        e5m9SnijLOw6YvVFJe+O39vcaf7JKcNaW7zHBn5Mog==
X-Google-Smtp-Source: AKy350Z7tsZGMHuCKfKxhW0176voBwFeqIcIduoNvJQR7FvSkUZn/IfrPrvT/mGuDF7WXe/8PffnqO89+53UAmMv9+k=
X-Received: by 2002:a05:6402:1ad1:b0:504:7f60:9f6d with SMTP id
 ba17-20020a0564021ad100b005047f609f6dmr5201714edb.9.1682117048360; Fri, 21
 Apr 2023 15:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230421101154.23690-1-kuro@kuroa.me>
In-Reply-To: <20230421101154.23690-1-kuro@kuroa.me>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Fri, 21 Apr 2023 23:43:57 +0100
Message-ID: <CACdoK4Jez-Hpv2s6iSj_j2qxt6rrHLpXULbJbY72_w8LVECdbw@mail.gmail.com>
Subject: Re: [PATCH] Dump map id instead of value for map_of_maps types
To:     Xueming Feng <kuro@kuroa.me>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 21 Apr 2023 at 11:12, Xueming Feng <kuro@kuroa.me> wrote:
>
> When using `bpftool map dump` in plain format, it is usually
> more convenient to show the inner map id instead of raw value.
> Changing this behavior would help with quick debugging with
> `bpftool`, without disruption scripted behavior. Since user

s/disruption/disrupting/ ?

> could dump the inner map with id, but need to convert value.
>
> Signed-off-by: Xueming Feng <kuro@kuroa.me>

Thanks for this patch! It looks good, with some minor comments below.

> ---
>  tools/bpf/bpftool/main.c | 16 ++++++++++++++++
>  tools/bpf/bpftool/main.h |  1 +
>  tools/bpf/bpftool/map.c  |  9 +++++++--
>  3 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 08d0ac543c67..d297200c91f7 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -251,6 +251,22 @@ int detect_common_prefix(const char *arg, ...)
>         return 0;
>  }
>
> +void fprint_uint(FILE *f, void *arg, unsigned int n)

I suppose you based this function on fprint_hex(). But for your
function, let's remove the first argument? We always print to stdout.
We can always turn it to a "fprint" version again if we need to print
elsewhere in the future.

Also, "arg" should probably be a "const"?

Can you please rename "n" to "arg_size" or something similar?

> +{
> +       unsigned char *data = arg;
> +       unsigned int data_uint = 0;
> +
> +       for (unsigned int i = 0; i < n && i < 4; i++) {

Please move the declaration for "i" to the top of the function, for consistency.

Also, why stop at i == 4? Couldn't this function be used for 8-byte
long integers too? It should be up to the caller function to set "n"
correctly.

> +       #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +               data_uint |= data[i] << (i * 8);
> +       #else
> +               data_uint |= data[i] << ((n - i - 1) * 8);
> +       #endif
> +       }
> +
> +       fprintf(f, "%d", data_uint);
> +}
> +
>  void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep)
>  {
>         unsigned char *data = arg;
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 0ef373cef4c7..7488ef38e7a9 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -90,6 +90,7 @@ void __printf(1, 2) p_info(const char *fmt, ...);
>
>  bool is_prefix(const char *pfx, const char *str);
>  int detect_common_prefix(const char *arg, ...);
> +void fprint_uint(FILE *f, void *arg, unsigned int n);
>  void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep);
>  void usage(void) __noreturn;
>
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index aaeb8939e137..638bd8de8135 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -259,8 +259,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>                 }
>
>                 if (info->value_size) {
> -                       printf("value:%c", break_names ? '\n' : ' ');
> -                       fprint_hex(stdout, value, info->value_size, " ");
> +                       if (map_is_map_of_maps(info->type)) {
> +                               printf("id:%c", break_names ? '\n' : ' ');
> +                               fprint_uint(stdout, value, info->value_size);
> +                       } else {
> +                               printf("value:%c", break_names ? '\n' : ' ');
> +                               fprint_hex(stdout, value, info->value_size, " ");
> +                       }
>                 }
>
>                 printf("\n");
> --
> 2.37.1 (Apple Git-137.1)
>
