Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB33C635D
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhGLTO6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 15:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbhGLTO6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Jul 2021 15:14:58 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5935C0613DD
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 12:12:08 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h3so20630850ilc.9
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=QcWKGSknHpowkFqrK80QYpf8DshSGQq4GxDpyyIc2sc=;
        b=jDs74HG4qgcjnNQUONu8KdFFgK1uIjLo/fftRmpRPRd+MoS/ALhoVKbSE2C5xFrDbn
         VwylXhz64VjQvk/y9FX5jqNlizfrV6HBBGwtSfmGBtZ9gNc9rs/BE3LNJX8WDpNPaSu+
         ebFB2nUtde/FRtN5b0uRtsh3S2BL6j5BfpGt3El7AK4qEA5UvF69CeO/sgCcRW82LnjU
         Cl/K03XvWEy+KvZhCOjQbsl/mVTfbGxH0irEk6rnnH0iflEXgh37iweFp5wPdunmqVOI
         lDoEFo6wBnHcZbJjZsRKEMqVP5XkxgGDHqg/EKPxFiK/FNvBuoXLZCXDnS11LXIR4gdx
         /iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=QcWKGSknHpowkFqrK80QYpf8DshSGQq4GxDpyyIc2sc=;
        b=QJMDm4mwppjUYfB7+nKy4sOAk0tCx0hWYTREj8Ho82nRstQztvVg1ussLarVnKtHbn
         wpzvJ8d740VaZtGEXtnhsRpRideYIGD5Uf7YKxIxNch3NWYlw8eM1Pps7mojgxi01nZj
         csGLiRNUmkV9IqHi1nNyT97OP0oZSZHIqszHtC7m9j/48eQvI3kSt1lRJpHgOFnBU2rL
         FeOydN8gnfKVhZ99bpUfzP369ePSf/MamKew6c8YL8S/2GRoOWCaQvDbVgvclyL8XtpK
         fFlzFe9hWKASWRQwt1QIMd01Pn1jcB5KSaLJUASX/v3TPaaRobb+jboaqMCb2tAV1MEt
         r9/Q==
X-Gm-Message-State: AOAM532YpMC5PXxcV5P9CRMO4fEZuu0/cFQCQFa83WpwhkuKI+4uZQjs
        Kbb18bLr3+bOtCGvsZdesvA=
X-Google-Smtp-Source: ABdhPJx2ttcA5P4CrPk1KiFxqxVipzzelkedCj5twWJ8JxGB35duOHS8PJwFxaYmv1Bkv68wMnQ7WA==
X-Received: by 2002:a92:2a10:: with SMTP id r16mr239359ile.223.1626117128140;
        Mon, 12 Jul 2021 12:12:08 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id k19sm7482204ilh.60.2021.07.12.12.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 12:12:07 -0700 (PDT)
Date:   Mon, 12 Jul 2021 12:12:01 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org
Cc:     yhs@fb.com, andriin@fb.com, jolsa@kernel.org, hengqi.chen@gmail.com
Message-ID: <60ec94013acd1_50e1d2081@john-XPS-13-9370.notmuch>
In-Reply-To: <20210712162424.2034006-1-hengqi.chen@gmail.com>
References: <20210712162424.2034006-1-hengqi.chen@gmail.com>
Subject: RE: [PATCH bpf-next] bpf: Expose bpf_d_path helper to
 vfs_read/vfs_write
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hengqi Chen wrote:
> Add vfs_read and vfs_write to bpf_d_path allowlist.
> This will help tools like IOVisor's filetop to get
> full file path.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---

As I understand it dpath helper is allowed as long as we
are not in NMI/interrupt context, so these should be fine
to add.

Acked-by: John Fastabend <john.fastabend@gmail.com>

>  kernel/trace/bpf_trace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 64bd2d84367f..6d3f951f38c5 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -861,6 +861,8 @@ BTF_ID(func, vfs_fallocate)
>  BTF_ID(func, dentry_open)
>  BTF_ID(func, vfs_getattr)
>  BTF_ID(func, filp_close)
> +BTF_ID(func, vfs_read)
> +BTF_ID(func, vfs_write)
>  BTF_SET_END(btf_allowlist_d_path)
>  
>  static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> -- 
> 2.25.1
> 


