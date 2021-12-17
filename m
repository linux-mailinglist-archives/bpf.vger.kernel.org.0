Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC3B4791E0
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 17:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhLQQvN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 11:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhLQQvN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 11:51:13 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD7C061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 08:51:12 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v138so8162332ybb.8
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 08:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wy1hD1NtN3aIYhaK0EXbIDD96mHBKbesLioQtcUcYdU=;
        b=c3tRzLrkC/yuIe7i6fv4q/KHFz8PyxMh1GZi/anKopd70WAG/nqs2CIWbflCGER80M
         6GYHElaQJ9kFA2LXel5kefhyvwJzZgljsMS+o5r8qvmCojv8Fk+5yg3xfAypBr1RiVdK
         c5th1vrbx0ZXTsT9yK3y7t2cyfBFBNIGloqZqWfp1FY6Yi88mtBsDzhhurr/drH+eSgo
         ZmiV9Q5ZRKh3nfNgs1c7QL15/CcS+tppxyghcT4O9yTkjE9ElVdkvflD84fXMn17ehY5
         mMhMRDkfqrNVAW5X24FKiR/Yc+8WNQx9Dt8MoBQG+U4de+YH3hjFUAlcXwkFm4kO2afE
         yqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wy1hD1NtN3aIYhaK0EXbIDD96mHBKbesLioQtcUcYdU=;
        b=FY+Ab9FmOP1QQX/uR3tN2D33Bf2Uyw8aNU7uwK6khcbBsVTa8zzmhWhaQvTLqgLSa8
         mRcLVNFirASH3bpj1z3Ar/S8PuyYF7VfYFacyqUq7zfO44SMMLQzccs55MWRL/3GgMuW
         WPuZhPKZZdX4Q2PDLXqHmQuxdrs9fhbYWg8ZcxvvEImqhjfUisxX4AMlinqm9LNNbiEo
         3x85JpV1p2WKaVu5Fyv6eBChOe0TgO8zYTPiZ4yBKHbqQkt0KwuJfSLSK9gy++4W/dJE
         OaWvEMxYsZkXQb56avDDSogkcK1PElfP7ty3/CwZreAAKFTEdnLbrHdGU0PnwnsqvKXq
         tKIA==
X-Gm-Message-State: AOAM5332Q7cljaa2ZPF8ngwqMQIv76o/oyLXIWGqPM9g9bW6qGByyDYa
        stIZcYOuHtrqeNJIuzB93eU3l2WngenFs4Lj9Sk=
X-Google-Smtp-Source: ABdhPJx87cO9rtCYzg5Cgsro4PHrx2Hj3LUWIeE9OFt03xMDzbrwAh+CpB2Q5idtAkl7pQIa2KTZ3rW1tNQRvsNQrDQ=
X-Received: by 2002:a25:ac12:: with SMTP id w18mr2597976ybi.362.1639759872163;
 Fri, 17 Dec 2021 08:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20211217141140.GA26351@Mem>
In-Reply-To: <20211217141140.GA26351@Mem>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Dec 2021 08:51:01 -0800
Message-ID: <CAEf4BzYxLcZRq685reGkNRBWNpxLWnEt3u_J1pBCb1ptrU0z1A@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpftool: Flush tracelog output
To:     Paul Chaignon <paul@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 17, 2021 at 6:11 AM Paul Chaignon <paul@isovalent.com> wrote:
>
> The output of bpftool prog tracelog is currently buffered, which is
> inconvenient when piping the output into other commands. A simple
> tracelog | grep will typically not display anything. This patch fixes it
> by flushing the tracelog output after each line from the trace_pipe file.
>
> Fixes: 30da46b5dc3a ("tools: bpftool: add a command to dump the trace pipe")
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Paul Chaignon <paul@isovalent.com>
> ---
> Changes in v2:
>   - Resending to fix a format error.
>
>  tools/bpf/bpftool/tracelog.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/bpf/bpftool/tracelog.c b/tools/bpf/bpftool/tracelog.c
> index e80a5c79b38f..b310229abb07 100644
> --- a/tools/bpf/bpftool/tracelog.c
> +++ b/tools/bpf/bpftool/tracelog.c
> @@ -158,6 +158,7 @@ int do_tracelog(int argc, char **argv)
>                         jsonw_string(json_wtr, buff);
>                 else
>                         printf("%s", buff);
> +               fflush(stdout);

maybe it's better to

setlinebuf(stdout);

for the entire bpftool instead?


>         }
>
>         fclose(trace_pipe_fd);
> --
> 2.25.1
>
