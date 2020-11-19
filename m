Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF902B9D30
	for <lists+bpf@lfdr.de>; Thu, 19 Nov 2020 22:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKSVv0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 16:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgKSVvY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 16:51:24 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688FFC0613D4
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 13:51:24 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w142so10473195lff.8
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 13:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNkP1BfoND8tPkUFRfpyqdTZsuDNt6M1lpZgWEkn6Jc=;
        b=RAH4dACOk6p+Hl0CUknO6IqaObL74j1ij3JIrmV4Sxb2GuXcuW0/A7vF+XR9RhhFSp
         GPbynKn+i2ldVeFGmkbi3Ywr0Gu6zT9mlfPOchTMUS2kACmG/ekXrxinbmzEOFWcyYbz
         /5C73fBQ28oRR8OuM5kZQCthv6ve/myWVsRbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNkP1BfoND8tPkUFRfpyqdTZsuDNt6M1lpZgWEkn6Jc=;
        b=IMZVHgE7eKCP7AZJ4fYKeYtwmLSB1mmnA3JkJZRrbFG/LFAeXkzIT8xhRfZia6w5U8
         qIT7/BsbLbN7zhmuFqpbvmwjxRRtczn7FWAwsmmGJ66EF25bA2rUUXJ3xzsW+7W2Ugig
         g+H17FwaW7beifc1+pA24cfUtGvyqKPoNwhYw3etnBfzYQ2Ul6qG4GdtLPaAJSsbzrs3
         uoXTOxjTU+zKOLSmEJLwkYpex5St8+91I5R1Bu/mYaLLx8bNv7tkz2W1BnfQlrIKPPiN
         OWXmqTV3wKuVo5mHsJoBe2FFC4TnW3YurAZi6Zwx0gZSH+QBqXNDqSGcVF/U4VPfOBW0
         v0xw==
X-Gm-Message-State: AOAM531O4ToMLOmuRx8gI/pKwYJojuJIPLh48OJ2pl0HzpqBW8/4xE6d
        Hxzest3RNvGBVna2b6pUqXMoqMVOGeTYIay6M8nh+A==
X-Google-Smtp-Source: ABdhPJzAav3mWCYz/rq8AYwkC5wyEpFUWloem8MmqonR2PXl1rjJxoQVJCUYjeBQizBZlQtlvaImLgveQ0rxVWRKRgA=
X-Received: by 2002:ac2:43b4:: with SMTP id t20mr6247176lfl.146.1605822682841;
 Thu, 19 Nov 2020 13:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20201119162654.2410685-1-revest@chromium.org> <20201119162654.2410685-2-revest@chromium.org>
In-Reply-To: <20201119162654.2410685-2-revest@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 19 Nov 2020 22:51:12 +0100
Message-ID: <CACYkzJ79eOai+k1=YfwvP_DNdxX1G+yJ-1vyhgoCqxWyJZGAGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] bpf: Add a bpf_sock_from_file helper
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 19, 2020 at 5:27 PM Florent Revest <revest@chromium.org> wrote:
>
> From: Florent Revest <revest@google.com>
>
> While eBPF programs can check whether a file is a socket by file->f_op
> == &socket_file_ops, they cannot convert the void private_data pointer
> to a struct socket BTF pointer. In order to do this a new helper
> wrapping sock_from_file is added.
>
> This is useful to tracing programs but also other program types
> inheriting this set of helpers such as iterators or LSM programs.
>
> Signed-off-by: Florent Revest <revest@google.com>

Acked-by: KP Singh <kpsingh@google.com>

Some minor comments.

> ---
>  include/uapi/linux/bpf.h       |  7 +++++++
>  kernel/trace/bpf_trace.c       | 20 ++++++++++++++++++++
>  scripts/bpf_helpers_doc.py     |  4 ++++
>  tools/include/uapi/linux/bpf.h |  7 +++++++
>  4 files changed, 38 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 162999b12790..7d598f161dc0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3787,6 +3787,12 @@ union bpf_attr {
>   *             *ARG_PTR_TO_BTF_ID* of type *task_struct*.
>   *     Return
>   *             Pointer to the current task.
> + *
> + * struct socket *bpf_sock_from_file(struct file *file)
> + *     Description
> + *             If the given file contains a socket, returns the associated socket.

"If the given file is a socket" or "represents a socket" would fit better here.

> + *     Return
> + *             A pointer to a struct socket on success or NULL on failure.

NULL if the file is not a socket.
