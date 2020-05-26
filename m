Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E121E297C
	for <lists+bpf@lfdr.de>; Tue, 26 May 2020 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbgEZR7I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 13:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388499AbgEZR7I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 13:59:08 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D74FC03E96D
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 10:59:08 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id r16so1068993qvm.6
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftT8GVUXacGzP3kg8TVm5zJgCurWuWO6xVYrwW2lba8=;
        b=WSAYgSHWMtND11SlxJ9Miv7GxdC1VM8ojrwnP5+wT5WXU+3XhmMSqMyBXyAU9WuYyA
         G2KvSQ/4NWGjekn11kn7RI7kS3cCH/iv/t4czYr3xJzQu8/OAhzOXG+RunGqwyuJv5wN
         m9NmJhdn9EKksJ12VzT1d0NCfBoA30NMyQOyQk+2xd3qdGoKr27axy1qFDZCGwYLRUOu
         T2Z4kn6bFsck5srw2VWr4Sx8bF7KKl7vWgpSQ4pS+PWjawG2Ki6BSxcAUkqFkZS9ybcN
         Vs0996Jbx+8JAFrpak4vUioRmowDZSSMPNg1+0QLiB78f6N+HoPNH9CLeHpVla6wcMLm
         JP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftT8GVUXacGzP3kg8TVm5zJgCurWuWO6xVYrwW2lba8=;
        b=P+eWYE3zNbarjuJCbPUIfOS1iwMxkLqYOvB63ZnmsVjCYMyVfeqHDllyTs040SvEdC
         OiF1WMulpAACWvOD0wFVnyQpPCFoxZsJZxsX4A+NQEkYuDvnOFJePpA1xYa41aVXEGiL
         bEFFyAvdlI0gUGoQFmvRpbn3VbuUtpgGK9nxe92ng8I3wTbXtZBuw64pyHMj8D2Hk7FG
         EGLHPbndypIgff/wE7Is3KfEshw7EM632IVg2CGMmeOZjHShM3XDftmCSLgnBL/1EcrH
         7xXw+eS2v14LuliM1rhH8OHUCBTBaa3zFzkbJ6KiMNmyJ76AKnBQxq+IznB0MlP97lwe
         rITQ==
X-Gm-Message-State: AOAM5337BUzqvQgKh8TU6IhFVfl5ZHcVgcLEHHsWp0nZQd2sXs7UQVr1
        cf+cT6Yd0SlhAvCYIsUg0g9md8cfTTsRAeUF+H8=
X-Google-Smtp-Source: ABdhPJy4SusCzcjfcy9ePjo4ofVWHDJ+gharQKvxYe72EGp7OPNcIGQXQMTu0tsi+9ufiGKxDwMjdavoNcSqktaB1iE=
X-Received: by 2002:ad4:55ea:: with SMTP id bu10mr22163695qvb.163.1590515947632;
 Tue, 26 May 2020 10:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200526174612.5447-1-nborisov@suse.com>
In-Reply-To: <20200526174612.5447-1-nborisov@suse.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 10:58:56 -0700
Message-ID: <CAEf4BzaP=Pvf9D73rD0kf7LRe6AMnQ1Cfk7jdS+So6JHXBQFJg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Install headers as part of make install
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 26, 2020 at 10:49 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> Current 'make install' results in only pkg-config and library binaries
> being installed. For consistency also install headers as part of
> "make install"
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---

Github Makefile already does that, curiously :)

Acked-by: Andrii Nakryiko <andriin@fb.com>


>  tools/lib/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index aee7f1a83c77..d02c4d910aad 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -264,7 +264,7 @@ install_pkgconfig: $(PC_FILE)
>         $(call QUIET_INSTALL, $(PC_FILE)) \
>                 $(call do_install,$(PC_FILE),$(libdir_SQ)/pkgconfig,644)
>
> -install: install_lib install_pkgconfig
> +install: install_lib install_pkgconfig install_headers
>
>  ### Cleaning rules
>
> --
> 2.17.1
>
