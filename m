Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7269A4A54B5
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 02:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiBABeH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 20:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiBABeG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 20:34:06 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E592C061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 17:34:06 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id z4so13045600ilz.4
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 17:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c42Uw7eDS5rNXX3LOxgmnLpNlMnn7bS6qmU1XwgrLuo=;
        b=CsjbPvj4G1p6U2bxlCjrAIsXYTUPB/aK7a+y9+knaqeroy/PrrNp4crIQud9AdmkZJ
         yBulBR/KVHKhpIpjrFcwTzKlI1y9RblgefYUIWexw7KPQCKvcAUAbe2lISxyYc8Wz4XM
         +WoMdcqR+q8hWmA19pm5rldgimbuZ77Fl84OKLodQ7EcL0d7JcgKlJgiKKjbJxIsD7BI
         dCymwjuOasi9Vzo6zkvHOxt95QLgnXDWx0ZHUipOHoX+M91IIz8LfdS0v0L56zdTzwIO
         5A36cU27cpjhtiqIMBjDlt4MQxwnXwpnk/OmFP8CNl6/OuCS/dlfspmIpml4rvMhTVfr
         oSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c42Uw7eDS5rNXX3LOxgmnLpNlMnn7bS6qmU1XwgrLuo=;
        b=VrPnPq/ywG8oJMXbUh6Qcgb7U2AzeeQP1hWjXZ8MFVqO8hlGXMoTIT/SNPVt+xXwDj
         2SguFs3oGpgSDlINHTePMWS3QLTCqi4UK8ABl1uXoDlmirSL7yMzI3Krjq03bG8ajmal
         GyZW1QOuMVd0Yp6KOYUcsaz+dSH6PD4IAYricTvxvrgBAjxBpl0lNMFAjkdVo4XBIuIf
         VNb3NnNlWDxosEvsNH/X2UHRttwUa8jQ8VBdyTl06nnjwFjoA2Lgo2RgPnncjFEaGeKD
         eJBi8p52dPMnhJsWZ7q4yOv3NK8CqdswgxerFhs8xVwEbs//yVKDFsy/fSiEnDMxDAGi
         YQ3w==
X-Gm-Message-State: AOAM531bXGyP3vHISXBqhkegoKcFk4BMLZB/g7gMa9zTZ8cUzcLTYOd3
        oD/ExDK8G9LbNWHkrH5kZH3s6WK1+aeuQPu+qgk=
X-Google-Smtp-Source: ABdhPJzrNb9Vjrx1LcV83nk1Dndd1RnISJCxuZfdxh7yDg/m7309Jh6gWBqyVl5oxLYqZ9cIiwrvEt6OVMJRVJGyIIU=
X-Received: by 2002:a05:6e02:1a6c:: with SMTP id w12mr8331102ilv.305.1643679246013;
 Mon, 31 Jan 2022 17:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20220128012319.2494472-1-delyank@fb.com> <20220128012319.2494472-4-delyank@fb.com>
In-Reply-To: <20220128012319.2494472-4-delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 31 Jan 2022 17:33:55 -0800
Message-ID: <CAEf4BzZqYAy2Af=DVF4ekmzQyHcb3YhSYcY_p_=w3fSLb+eAjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpftool: migrate from bpf_prog_test_run_xattr
To:     Delyan Kratunov <delyank@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 27, 2022 at 5:23 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> bpf_prog_test_run_xattr is being deprecated in favor of bpf_prog_test_run_opts.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/bpf/bpftool/prog.c | 55 ++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 28 deletions(-)
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 87593f98d2d1..4f96c229ba77 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1272,12 +1272,12 @@ static int do_run(int argc, char **argv)
>  {
>         char *data_fname_in = NULL, *data_fname_out = NULL;
>         char *ctx_fname_in = NULL, *ctx_fname_out = NULL;
> -       struct bpf_prog_test_run_attr test_attr = {0};
>         const unsigned int default_size = SZ_32K;
>         void *data_in = NULL, *data_out = NULL;
>         void *ctx_in = NULL, *ctx_out = NULL;
>         unsigned int repeat = 1;
>         int fd, err;
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);

let's name it "test_attr" and avoid most of the code churn?

Otherwise it looks good, thanks!

>
>         if (!REQ_ARGS(4))
>                 return -1;

[...]
