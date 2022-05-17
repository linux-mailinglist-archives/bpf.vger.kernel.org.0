Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68885295E9
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 02:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiEQAPY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 20:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbiEQAPX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 20:15:23 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FEB45051
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:15:22 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e15so17759963iob.3
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ca+sZU1CZ7cEQL0AlJqA5FjSuBCUP8ogPnxwmrzOswI=;
        b=W5JVG3f3d88mpM0M+cTgV32THMCwqMxLzMi1ms/5ntVTha66jY/LlEiDzY+sZGWK36
         aKPzIAp4dc1QBpG769qs3Bdq2sCpTy4gioYQR/KHTZwKdp2QI4MP8tWBCsnOBJF9k3nQ
         j0WA0RS40WuJ6JMyetlfuPAvBlBVmyFiOvhVxnXL4u+abO/nH6AEz5XocYLEgWG6S9pe
         YvRTgeV8Q+EXIt8z2TjcdMaPF4yBwelbu72VXFUgocsFO5TMO4nGhNkKzScfj/Pm5dtu
         1ZEE4bJMIVREvOO1DqU8LVYJUYAhnNivO54+BPE7nqQHug1Q2Ojyml6YMYkO2RWXf9AO
         7HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ca+sZU1CZ7cEQL0AlJqA5FjSuBCUP8ogPnxwmrzOswI=;
        b=CZ45BNvzm3AxudplWtC58WyPWYVRsxyML3ym414Bnj1YlHMHzloezIOX/CRBdClFE2
         XMlGHoaiQyKJVmkY8vbSqow5thbTd+lnbOkualO/+0ZfzpC2wCYvvG84vb/+a+2WdemG
         AOvPsWEB8Gi5hBzRKpVzQdzXtvLVPgntU+J2ehJ5eYBm/+7W0fya16yM+xsqHR/NNPkY
         6DGo/a9/w6C/sj77eea1spXeOsdHIF/7HK83Pj6tq48MsyKX2DHmkNgy0JsxafG88Dg4
         f5hPaauKHdCHfpTMC4K9kFz2hMWGnPCxfzmWohY2yC9B5TY8OdCA1VEmX/fn2uTsnR1+
         N8Ug==
X-Gm-Message-State: AOAM533D0XZX1OcZoCHoKQShdVev33lyTzMl9+8N0a78XsaLPiDiZ6iH
        lcwtMuArnMmezVyFrO7GLWRPf8/euQFmWVu/ABg=
X-Google-Smtp-Source: ABdhPJyeVak3FI/HHiB8+bglhnqHBlnUO3doUmbhC0VR1pw2UmSC7GdjqtrZ4QRhHn2l5xTvbG6AoChnuu5FbdnP6Ak=
X-Received: by 2002:a05:6638:33a1:b0:32b:8e2b:f9ba with SMTP id
 h33-20020a05663833a100b0032b8e2bf9bamr10516672jav.93.1652746522210; Mon, 16
 May 2022 17:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031247.3242311-1-yhs@fb.com>
In-Reply-To: <20220514031247.3242311-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 17:15:11 -0700
Message-ID: <CAEf4BzZ=sdD1WQdwU1VLMMwU6s=P6=o=LWBXSoeOJ5E+eAotLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/18] libbpf: Add enum64 parsing and new
 enum64 public API
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add enum64 parsing support and two new enum64 public APIs:
>   btf__add_enum64
>   btf__add_enum64_value
>
> Also add support of signedness for BTF_KIND_ENUM. The
> BTF_KIND_ENUM API signatures are not changed. The signedness
> will be changed from unsigned to signed if btf__add_enum_value()
> finds any negative values.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Looks good, but new APIs will have to go into 1.0 in libbpf.map

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/btf.c      | 103 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h      |  12 +++++
>  tools/lib/bpf/libbpf.map |   2 +
>  3 files changed, 117 insertions(+)
>

[...]
