Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F9A20496A
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 07:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgFWF62 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 01:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbgFWF61 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 01:58:27 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D5FC061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 22:58:27 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l17so17777456qki.9
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RgxG+qk6INCm32IfyNPa8oTVGm+U12PQv4jEF33YDY=;
        b=JaG5xEkD3cM3ISI5PwRgYZ1vYdqqN3rJK05vYA+yJMJGctpeU6OM/eCx6ek7nOeA0+
         0FTucaLgFLYKCqa7kQUZ3/Cee0cWtcg9eAooGvzZMe3LWD3Izg6ea1LcbWdxNQrj7Eq6
         OuIPUk+djdTBcpPoJP0qkifa/4ucpqicLqsZ7i89KHJoV1wGlFDZpfOn6NcZYoXz3u4g
         uTzUZFqhVFaPRmPHpUsI7YmmWJBYmu69GVjGXSyrVp9OK4IufopBHYcSLhcWsTtFyGqa
         9+uznyWUF8CqhjAe9tEDlgyCWn4FlXKptOaaWZItSk5Hs5zbtHMxfUAA9shbdANfJDXv
         WSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RgxG+qk6INCm32IfyNPa8oTVGm+U12PQv4jEF33YDY=;
        b=dh53jIHQtrR9mXF3Y62yquXmmIBjvH8WCNxTn7I33g75XY8NM+kDWf2UuADT2WaNpF
         6W2aeiR2LRhlUejmZCnTCt9D1hBnPb8d3dRhLq6jd9KO9jVs8aymiwjqnqLF20f3Ch4n
         ZcKJCal7Yft9/K7RVJ72wt5cAhoNCYeV+rcUAvAuJnZ2LW4QdlqhbV7rWUKeVvo5zgRk
         J+yPG/oGPdvY+qvV5cEdeR8HJw4Z2hdYlLMqxqzqjkB6dcZZ5hqQ1IXuqQz6267iuogG
         ShbPaMmsuna/pSNird15xSC4SqC5hIPrYXSMP2Fa4o4M0SG0LzjGQIKiO4UDRQ67GSpQ
         ErGQ==
X-Gm-Message-State: AOAM531ts82NON6epX0R7/ZB7Z2Z5ZfBet1WZk76YPC0TmWrPlwZfisW
        2EaDYtQ0zmcp4FS8NLdYbvZ76mIXWeCRYsOMF+4=
X-Google-Smtp-Source: ABdhPJx7xLLN/eT50mZ9vKrrSuEwaSxNEi8/FvQGRlDw0Ku7TKMhdZ4PdOBHrLpcAFPTJdSk17wQ5dRsDFpZGBbuTIY=
X-Received: by 2002:a37:d0b:: with SMTP id 11mr20141284qkn.449.1592891906166;
 Mon, 22 Jun 2020 22:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200622140007.4922-1-tklauser@distanz.ch> <20200622140007.4922-3-tklauser@distanz.ch>
In-Reply-To: <20200622140007.4922-3-tklauser@distanz.ch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Jun 2020 22:58:15 -0700
Message-ID: <CAEf4Bzau9o_0bAUmnjxCLODAMuReR+Vg3ZzV1=zg8k_-wvWi3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] tools, bpftool: Define attach_type_name
 array only once
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin@isovalent.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 22, 2020 at 7:00 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> Follow the same approach as for map_type_name and prog_type_name. This
> leads to a slight decrease in the binary size of bpftool.
>
> Before:
>
>    text    data     bss     dec     hex filename
>  399024   11168 1573160 1983352  1e4378 bpftool
>
> After:
>
>    text    data     bss     dec     hex filename
>  398256   10880 1573160 1982296  1e3f58 bpftool
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  tools/bpf/bpftool/cgroup.c | 36 ++++++++++++++++++++++++++++++++++++
>  tools/bpf/bpftool/main.h   | 36 +-----------------------------------
>  2 files changed, 37 insertions(+), 35 deletions(-)
>
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index d901cc1b904a..542050a4f071 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -30,6 +30,42 @@
>         "                        sendmsg6 | recvmsg4 | recvmsg6 |\n"           \
>         "                        sysctl | getsockopt | setsockopt }"
>
> +const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {

Let's move it into common.c instead. It's not really cgroup-specific.

[...]
