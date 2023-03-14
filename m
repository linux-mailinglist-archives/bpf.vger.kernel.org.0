Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6621A6BA0A7
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 21:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCNUZF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 16:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCNUZE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 16:25:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E6C2B608
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 13:24:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id fd5so33191867edb.7
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678825498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tU3ksFTzr2Yl8vc5ZBkTB/dabYgmT/tkNVKADrCCK0=;
        b=gx8CyFG/gHWV8XcpzHK0S9CV2DfZ/qnr1MeQ7FSg7BxYLZgWiqjGla2WlimyRONqZt
         q6buvEWtBlSras2jmcZUvzpVyK8sJD0pE+TgIw5KTKiZLCEa8G3XfR2bnFLTslhIGeWW
         plkcDWTvT+I/6WE6IqRCi34ljlBSa6B1dN2ubMn2dVaqfEeGpLVBvjnOQVhgfFP6oj+w
         mqANku8YY8uyc+FQjKoIHalBqjgQcCwjz4+jJ7OpcCA8yhCaJ0PKjbPnGh1X93WRzUZr
         0FgX0GV1JcrdsMCRnK81E7ILUCK3yeGcDlsZO3WsvrZIVynMxDcRLoXCSDJ8kGv6/mE+
         cUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678825498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tU3ksFTzr2Yl8vc5ZBkTB/dabYgmT/tkNVKADrCCK0=;
        b=F8XDpyjnTsU3B0cWXhbEnCYMDwgY+TghGkgFwxynhPDDGs/MU7uPvAFxNIQ3/T4BkU
         8YfnnxYUh9zjx3zo8IBm1h+AIOyaNOJP28A32jempenv1HHzZo6h3BploEWf/BKYEML6
         Ij535UPLpmtmVRTWtixOtXOFnBOqsmOzJCNMXccPU6So5Q8R+gV6Tg8LCtdLcaAysyvU
         Zq1QPwyy8QIFXvRYYeZO8sBgxS7GIjxXMqPRaBuEcYbyY01bvopbVhZD5g/LXm1zWPKe
         fIhRX165kTcWxYIiGC20nUhf5GZqYPIMwAMLWTyRhQ/nyXSMP+psJxBhRRLOM/FVMdaK
         G6mA==
X-Gm-Message-State: AO0yUKXgRQOJqPJ2eFLApCeuq/WSqYap/HMlhds8pM7QoBSoTm6iw8ne
        agUb8xy0D5QgITdTguE149Ko6Q/iQCsanIkaieIc2FrY
X-Google-Smtp-Source: AK7set+h701RADCPzGkhT9/6mVm1hpIHo3lwl9LqZ98E8z4NC8tDG8bcO5Ad4Q6mCfufvMpQ+9AnYbsW3km1Wz6jpp8=
X-Received: by 2002:a50:9314:0:b0:4fb:dc5e:6501 with SMTP id
 m20-20020a509314000000b004fbdc5e6501mr217503eda.1.1678825498195; Tue, 14 Mar
 2023 13:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230310150216.922-1-patteliu@gmail.com>
In-Reply-To: <20230310150216.922-1-patteliu@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Mar 2023 13:24:46 -0700
Message-ID: <CAEf4BzbH+W0oUAoe2My0xDUQQC2GyG-26S9YGaNWSPMpXb-T9Q@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Explicitly call write to append content to file
To:     liupan <patteliu@gmail.com>
Cc:     bpf@vger.kernel.org
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

On Fri, Mar 10, 2023 at 7:13=E2=80=AFAM liupan <patteliu@gmail.com> wrote:
>
> Write data to fd by calling "vdprintf", in most implementations
> of the standard library, the data is finally written by the writev syscal=
l.
> But "uprobe_events/kprobe_events" does not allow segmented writes,
> so switch the "append_to_file" function to explicit write() call.
>
> Signed-off-by: liupan <patteliu@gmail.com>

please specify your real full name in Signed-off-by tag

> ---
>  tools/lib/bpf/libbpf.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a557718401e4..7d865ca95c81 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9912,16 +9912,20 @@ static int append_to_file(const char *file, const=
 char *fmt, ...)
>  {
>         int fd, n, err =3D 0;
>         va_list ap;
> +       char buf[1024];
> +
> +       va_start(ap, fmt);
> +       n =3D vsnprintf(buf, sizeof(buf), fmt, ap);
> +       va_end(ap);
> +
> +       if (n < 0 || n >=3D sizeof(buf))
> +               return -EINVAL;

if n < 0 we should return -errno here

and if n >=3D sizeof(buf) let's return -E2BIG

>
>         fd =3D open(file, O_WRONLY | O_APPEND | O_CLOEXEC, 0);
>         if (fd < 0)
>                 return -errno;
>
> -       va_start(ap, fmt);
> -       n =3D vdprintf(fd, fmt, ap);
> -       va_end(ap);
> -
> -       if (n < 0)
> +       if (write(fd, buf, n) < 0)
>                 err =3D -errno;
>
>         close(fd);
> --
> 2.20.1
>
