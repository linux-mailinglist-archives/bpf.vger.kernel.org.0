Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F8F19888F
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 01:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgC3Xx3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 19:53:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44109 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgC3Xx3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 19:53:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id j4so21156152qkc.11
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2020 16:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEeD2ynREbqBHB9cLaqJx6nSGcBjmQzXGIRvg9dyv3I=;
        b=U4D8boWjIGxt05DbPDn0/Kda5cRytPh41gY5PPi99LtvkJ2w5zuUmqHdY3iy+c/ouV
         EVwt1EaxHbxgQqL6k8J+YDYYc/KCkg5HT1OoU3oAHnnnF2TNww8dKcq98ANmIpTi1HJv
         T+nvUleaEZNXdr8MDkLfacvdvNsmZFKEi6fvaEaaZgE1W0BgHy/IZZUkNjc10eFyiYvb
         sxhARkFNmeUpmQfvdyBYq+fFwDzVoFbLINKZ1G6wr8Tehwgm2hV+tjHI88YMw6e4c03x
         NC1alUXxpD1Oy09BPfPtu0ggrGBX2AR1jg7nOXrq6qXJFFyDd+jkBUBx0R5VyctJGJga
         vItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEeD2ynREbqBHB9cLaqJx6nSGcBjmQzXGIRvg9dyv3I=;
        b=KeieY0PqQw6LXkyXUay9pJHNuGVyhHNtrv4SvCv2BMYTS9JKXF58N0HmPid5VU77KF
         BmEpn+0yvh5MmXzSJK7yg6U08GN5mdOs666S84s5Z8AQeYPskxHIMwb40NGgWf4j8zIb
         quaAjh+9ShDdTLh1X0UG1so0BnK2gewxTsKxBCkzpTmaJsNAoNdF+6kVgQVYmzPqE5y6
         VgUa3KZKSdKXUN+Onc3QFz0ZrKbXKoUSCggoUSUAnFrcig//MHXGfrOV4aBERFJ8cs0o
         mPxkJQmAwu9GcgR8AUAQgQrjlOpDqf7+6SVncsx7pXVnKCVJ5+g/XceXLkavLesgac8T
         fsqw==
X-Gm-Message-State: ANhLgQ3qXJD3wCJAzamcYPzkQNtKs8ZYex+LKAdl7FjJK+YTlwJ0o6DR
        +PEmF1Jl/eyQqUi3HPLmnCdsdRqh/S4XTct3ZEQ=
X-Google-Smtp-Source: ADFU+vseRGWJu7mMCOTaa8dOS8JXA3cierfSwCBO2YqlRns5wY4rJ5mcLii0955O7e8izYWyeFKuvmac2dCuAqzbMl4=
X-Received: by 2002:a37:992:: with SMTP id 140mr1874898qkj.36.1585612407853;
 Mon, 30 Mar 2020 16:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <0e9a74933b3f21f4c5b5a3bc7f8e900b39805639.1585556231.git.daniel@iogearbox.net>
In-Reply-To: <0e9a74933b3f21f4c5b5a3bc7f8e900b39805639.1585556231.git.daniel@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Mar 2020 16:53:16 -0700
Message-ID: <CAEf4BzYcpzeH+wDhk-MAU9NFbZ7NXYb5neh3hZVWrn2pHhduNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, doc: Add John as official reviewer to BPF subsystem
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 30, 2020 at 1:39 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> We've added John Fastabend to our weekly BPF patch review rotation over
> last months now where he provided excellent and timely feedback on BPF
> patches. Therefore, add him to the BPF core reviewer team to the MAINTAINERS
> file to reflect that.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> ---

In case you need more acks :)

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3197fe9256b2..983e449c0b5b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3147,6 +3147,7 @@ R:        Martin KaFai Lau <kafai@fb.com>
>  R:     Song Liu <songliubraving@fb.com>
>  R:     Yonghong Song <yhs@fb.com>
>  R:     Andrii Nakryiko <andriin@fb.com>
> +R:     John Fastabend <john.fastabend@gmail.com>
>  R:     KP Singh <kpsingh@chromium.org>
>  L:     netdev@vger.kernel.org
>  L:     bpf@vger.kernel.org
> --
> 2.21.0
>
