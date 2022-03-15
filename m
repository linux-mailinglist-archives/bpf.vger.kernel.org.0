Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6484DA4AE
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 22:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244790AbiCOVjb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 17:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiCOVja (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 17:39:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3189A37A99;
        Tue, 15 Mar 2022 14:38:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bx5so574997pjb.3;
        Tue, 15 Mar 2022 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNoJUVu33RBtyBtnAprQNI1p3NZHgGbzhtFN4UzdDR0=;
        b=GKGgw4osFatxLpSNtMw3h1IMZDSU6ZhMBqZ1QoQpwsP8pwL34zLiwl3Gq2Q+8HRtl4
         YxJeE0tIb55qgIcnK2McbfJ8YYy4Ba9TWsOJpd1kagk8zQhMRzQSXdgq2zFMmKWNdB4D
         aZL5+vgSnLZ6/qTdkAy/LWkG7SaqEDCHnKk4Bw+3tVilhG9WssFLFRhhlqfpG+WP9ltl
         8mDaXWx5G31AU6ZG6NYbh7M2agkMwkkkqLze1ioGAtX7yETu5q6eIGH1q8c2yrEBvluN
         tMizX4l3LMcvw94obsI/3ufcocWRla8tzOY9B1raNy+KA3vjNqpjSYfZEeuTImfX16FX
         rTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNoJUVu33RBtyBtnAprQNI1p3NZHgGbzhtFN4UzdDR0=;
        b=GVdZ/+DsUWnx67hgDCzU0+dNTO18OZx/II3oOVbboaEMMnykq2cWsDb+Rbl0iAreJl
         3+kXzEFmxkdjEh2PhDWv+lp9cVMhe+8M3pza1h3xBRFXmUjDds8P18RWQpYMD3hVBQ/I
         V9va6RHVHoYBFBpicI7hwgx6UAXSWCJT/XUmxoa9vG61S7PEE1rrlOS7+LvOl7Zcl/pU
         MsJSnJ16ELXvyYyHC5FETDGyLWg2J2Co2AofkXZt9/zGaPH5pO7mDndkp6h9jfTfWrTR
         Fat546A5IQ1dLcnhnPo4wf50a2nxlJ5sf+V4YzFKzbGdoaLO6t8MstPZn1U1d/Q4sFUK
         jlaQ==
X-Gm-Message-State: AOAM533jxnGFepgIoWfl7Gy2pgqsiKrEhh8J8a4Skt/6ZTbo1zwrcNF3
        W+lfb+9zM0k8PhIjMOWczA5T29vJyU2vLVvv84FIHuii
X-Google-Smtp-Source: ABdhPJwrW/i8S7xstQ2f1urd8K4yAG87xhQ6wR7zWxfvZGmrwrT2T+p2h5GGfJs4z46+bpI0ZujbjKhR5+VKDY6b7U4=
X-Received: by 2002:a17:903:32d2:b0:153:9c6a:5750 with SMTP id
 i18-20020a17090332d200b001539c6a5750mr4681706plr.34.1647380297577; Tue, 15
 Mar 2022 14:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <1d2931e80c03f4d3f7263beaf8f19a4867e9fe32.1647212431.git.dxu@dxuuu.xyz>
In-Reply-To: <1d2931e80c03f4d3f7263beaf8f19a4867e9fe32.1647212431.git.dxu@dxuuu.xyz>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Mar 2022 14:38:06 -0700
Message-ID: <CAADnVQJUvfKmN6=j5hzhgE25XSa2uqR3MJyq+c=AGCKkTKD05g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Add SPDX identifier to btf-dump-file output
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 13, 2022 at 4:01 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> A concern about potential GPL violations came up at the new $DAYJOB when
> I tried to vendor the vmlinux.h output. The central point was that the
> generated vmlinux.h does not embed a license string -- making the
> licensing of the file non-obvious.
>
> This commit adds a LGPL-2.1 OR BSD-2-Clause SPDX license identifier to
> the generated vmlinux.h output. This is line with what bpftool generates
> in object file skeletons.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/bpf/bpftool/btf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index a2c665beda87..fca810a27768 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -425,6 +425,7 @@ static int dump_btf_c(const struct btf *btf,
>         if (err)
>                 return err;
>
> +       printf("/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */\n\n");

I don't think we can add any kind of license identifier
to the auto generated output.
vmlinux.h is a pretty printed dwarfdump.
