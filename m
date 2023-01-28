Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D12267FA7F
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 20:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjA1Tip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 14:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjA1Tio (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 14:38:44 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7535C23C70;
        Sat, 28 Jan 2023 11:38:42 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mg12so21907283ejc.5;
        Sat, 28 Jan 2023 11:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WyA4c37awf6FUfhGcOco5QeZhWEaTt+jLXuHAzBLLqI=;
        b=bM+z29DpFQQ4ihX2O9Y0Lqm0kdgUonTGz3jD9ujj1ZvLHhr04tjq4bmd5uA1eFbSN4
         xFrzAzoZzx3X6HNCOHJg4DoPC7FF3REorfDIVLmg1+db0XZPJm6zwaO0gAMHazWn42M3
         c0hSUtkTs9Pkq5NktLUHYff7orO/ghSGE178GT62jAquf7rZ5VtHkjpWblyWP4SqMraS
         ckkOPtDPEmALHlNBN1FfOjSOHGhRi71gaYw3XoQ4VqBUc9bbo+wGdwHqksLPX/mzLAe0
         cRbqM0paHGEEgEaI3TG4mO/kVaV1rANFKsHYGW+bX4hk1shpOSBpd/jBQZOLlzT1XCJd
         /JwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyA4c37awf6FUfhGcOco5QeZhWEaTt+jLXuHAzBLLqI=;
        b=nFA3TXKT12VJufATUHNdgXnVlO0QZXiM3xxcU17EFKVrEXV3iYWbLyZ3bA0HjYL5z/
         zDdNuEP0btoRGuaK4/FSjvLBpm//srDHcYmi815EM2ircsi4hJNopgilm61qjW0gEXFG
         gU9e6tsI+jz8qq/zhGzaAl1LQ4lh+6PTHEECWfZRmJ/yYKej+ysAZar7uGbxv/w4yncR
         RcHsEM0XfDaqbe3c+JRbDQlEWbNq0C97zVJK7L0mMDNmRxwdg/DsvoBeNfTlyLGrERoR
         DjlAtN6sY9e9OkHzPNtyo8Kxyhh90E6H/jnKsy82T4+CBJN8u0Xw3u0yz3qBGZ2grgdq
         pwrg==
X-Gm-Message-State: AFqh2koL4bxpV5EMU8QRsEWQ56C/nT9r7ihlMLAJ2l0xtqyj7YNRgWGK
        koYXdKyF9es23L0IhguDe0/HLOF29UIq/XyFEjE=
X-Google-Smtp-Source: AMrXdXsYLotcrhMN0rZxq9THR4dxNGnQoJZwpVUcMUxlIBXqMhcP9wXoZWTOEhCdjKrUBWT3zv6eIQ2RdFpqT8aRmAE=
X-Received: by 2002:a17:906:3b4a:b0:86d:30f9:2e3d with SMTP id
 h10-20020a1709063b4a00b0086d30f92e3dmr6002375ejf.299.1674934720953; Sat, 28
 Jan 2023 11:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20230127064005.1558-1-rdunlap@infradead.org> <20230127064005.1558-5-rdunlap@infradead.org>
In-Reply-To: <20230127064005.1558-5-rdunlap@infradead.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 28 Jan 2023 11:38:29 -0800
Message-ID: <CAADnVQK58PHXuVOXgu1r306RZKRvEGgQwm3cLW0ak4fFNB4W5w@mail.gmail.com>
Subject: Re: [PATCH 04/35] Documentation: bpf: correct spelling
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
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

On Thu, Jan 26, 2023 at 10:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Correct spelling problems for Documentation/bpf/ as reported
> by codespell.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: bpf@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/bpf/libbpf/libbpf_naming_convention.rst |    6 +++---
>  Documentation/bpf/map_xskmap.rst                      |    2 +-
>  Documentation/bpf/ringbuf.rst                         |    4 ++--
>  Documentation/bpf/verifier.rst                        |    2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff -- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> --- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> +++ b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> @@ -83,8 +83,8 @@ This prevents from accidentally exportin
>  to be a part of ABI what, in turn, improves both libbpf developer- and
>  user-experiences.
>
> -ABI versionning
> ----------------
> +ABI versioning
> +--------------

The patch looks fine, but please submit it independently
targeting bpf-next with [PATCH bpf-next] subj.
We want to avoid conflicts.
