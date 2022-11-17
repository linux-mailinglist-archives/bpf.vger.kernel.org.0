Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CF962E989
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 00:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiKQX0n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 18:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiKQX0m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 18:26:42 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8C82F5;
        Thu, 17 Nov 2022 15:26:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z18so4824420edb.9;
        Thu, 17 Nov 2022 15:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yJfiRY/THrfxp68on+xM5wu4YptIc+9/TjEbNBRuQSI=;
        b=BmgiDAN02XbAyzBOe34n5+NOE6w9YZ8LMptFPoYxXM6PNZKL3DLbi+vpeoHRTQxr6k
         rdeMU5nVWaqNtIRxmhwCCNeUBn++qOZXyCbcOUctlMW5BWUqc6zX/c8sql959SoWNiD2
         fIrmG0HCV37/1kZzyVOYlUTUZzby2UUd7xgdNCNqKlLcxLD57xLmtCMvv5gkeI3PXMvd
         zJKq3X8JUss1ZiAsRtnalKG4LptBFy5w2YX5RwdhwwXpcu3MBa8khNZTN5P2zFbSXnwz
         plx66DkH55omoPOMZHu1MTJ2UcuxfCBA9bSdobgTNXuvCM9F9VN9yZkoJl/oyAwtReR+
         i7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJfiRY/THrfxp68on+xM5wu4YptIc+9/TjEbNBRuQSI=;
        b=Zp+ySitHxRWV1HnSHVw/TAyMuwzLoEZxJhy0OKm1ojSJ+1HX11IBIdQiIX62fL7+82
         PvHUO6XkFuEWQHJdEhAGn78njWe4PXRCZBlvMPh7z6wFpQn4lYGC0izP7htasRugdpSg
         8RLe5Oy0chYMWp7xUCHvggaatza+J4967hZhWNsdnjDEZaV1qkhLjKC/IaP7qtw3ZJi7
         EQsCqMaXRfi4WLsXWCvkGx+M5kKU9iSnCMHf0N2aOwqFnt96U+zd7m77VJ7bgf14KeNZ
         Susm75JKlBceh7yNKn6hd8hxFlYsVrW0zeQeLK9cRDu6XEeVIhdxZ0UkLqrqbFlUIsU3
         YO4w==
X-Gm-Message-State: ANoB5pkUiEp4J2K9EBBcE3e3e2TT80jXwnxTi3yArkdl2Cbef6o0xbbS
        OuBVabmXwaXKG2ExBB4pC9D7+sktI8J+jCfbsIU=
X-Google-Smtp-Source: AA0mqf4m83QI2OEaPeLuS8Zq3i5RZegg3WidXusvKj5A+wNcIQnsMky18V2MxfIHfa7mi98zpBFsvtNalN/cLZz1naY=
X-Received: by 2002:a05:6402:2075:b0:457:1323:1b7e with SMTP id
 bd21-20020a056402207500b0045713231b7emr3922238edb.311.1668727600375; Thu, 17
 Nov 2022 15:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20221116064631.16224-1-tegongkang@gmail.com>
In-Reply-To: <20221116064631.16224-1-tegongkang@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Nov 2022 15:26:28 -0800
Message-ID: <CAEf4BzbqKRTzTdhD1Vt-j8NXaqnyqXCRjNgMe9_h56rbt4a9YA@mail.gmail.com>
Subject: Re: [PATCH] samples, bpf: Add duration option D for sampleip
To:     Kang Minchul <tegongkang@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 10:46 PM Kang Minchul <tegongkang@gmail.com> wrote:
>
> Although sampleip program can handle three options,
> (-F for frequency, duration, and -h for help)
> currently there is no independent option for duration.

Because it's positional argument, which is very clearly documented by
usage(). What's wrong with that and why do you want to change this?

>
> This patch adds option -D for duration like below:
>
> $ sudo ./samples/bpf/sampleip -h
> USAGE: sampleip [-F freq] [-D duration]
>        -F freq       # sample frequency (Hertz), default 99
>        -D duration   # sampling duration (seconds), default 5
>
> $ sudo ./samples/bpf/sampleip -F 120
> Sampling at 120 Hertz for 5 seconds. Ctrl-C also ends.
> ADDR                KSYM                          COUNT
> ...
>
> $ sudo ./samples/bpf/sampleip -D 7
> Sampling at 99 Hertz for 7 seconds. Ctrl-C also ends.
> ADDR                KSYM                          COUNT
> ...
>
> $ sudo ./samples/bpf/sampleip -F 120 -D 7
> Sampling at 120 Hertz for 7 seconds. Ctrl-C also ends.
> ADDR                KSYM                          COUNT
> ...
>
> Signed-off-by: Kang Minchul <tegongkang@gmail.com>
> ---
>  samples/bpf/sampleip_user.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/samples/bpf/sampleip_user.c b/samples/bpf/sampleip_user.c
> index 921c505bb567..ce6aadd496e1 100644
> --- a/samples/bpf/sampleip_user.c
> +++ b/samples/bpf/sampleip_user.c
> @@ -28,9 +28,9 @@ static int nr_cpus;
>
>  static void usage(void)
>  {
> -       printf("USAGE: sampleip [-F freq] [duration]\n");
> -       printf("       -F freq    # sample frequency (Hertz), default 99\n");
> -       printf("       duration   # sampling duration (seconds), default 5\n");
> +       printf("USAGE: sampleip [-F freq] [-D duration]\n");
> +       printf("       -F freq       # sample frequency (Hertz), default 99\n");
> +       printf("       -D duration   # sampling duration (seconds), default 5\n");
>  }
>
>  static int sampling_start(int freq, struct bpf_program *prog,
> @@ -145,19 +145,20 @@ int main(int argc, char **argv)
>         char filename[256];
>
>         /* process arguments */
> -       while ((opt = getopt(argc, argv, "F:h")) != -1) {
> +       while ((opt = getopt(argc, argv, "F:D:h")) != -1) {
>                 switch (opt) {
>                 case 'F':
>                         freq = atoi(optarg);
>                         break;
> +               case 'D':
> +                       secs = atoi(optarg);
> +                       break;
>                 case 'h':
>                 default:
>                         usage();
>                         return 0;
>                 }
>         }
> -       if (argc - optind == 1)
> -               secs = atoi(argv[optind]);
>         if (freq == 0 || secs == 0) {
>                 usage();
>                 return 1;
> --
> 2.34.1
>
