Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F07A61A4E9
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 23:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiKDWyS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 18:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiKDWyE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 18:54:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B38FAEE;
        Fri,  4 Nov 2022 15:53:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b2so16889296eja.6;
        Fri, 04 Nov 2022 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aRgru+eX2sft8myxTL/E2yHwfYNkhODH4ZywnD+JOQ4=;
        b=Pd6w3rs8DJKl6GcTJM6vwBBWfSo5t9vvCc+wgHxkCmIzxjJSKEXZQVP3KT5inCVQ+5
         k9m2JKnOaz/3y7ycGqHx1FSFvtxnCyBcSCI8/QVOdq6TL6jZoe8xlIRJ0n3BBgM9/zva
         R+NeTinIizIce1kdzO3R2P71nvrUg238xOKbTn3KZTQa+Pc4fQSiLNtpfUN47Yf4ArfQ
         dRBgBwR/N538PjroIDrfGEecPe9LnUS6F2DnMRzveatrKED6Ueh7fP1q/MyZJYF9ZkhW
         9k/QxDkruzX6XnK3znGN0UtAlu9VQFyuV7P7U/zdHVjrFAf7ZF5A1/5lNMoTd5zxpBIX
         +Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRgru+eX2sft8myxTL/E2yHwfYNkhODH4ZywnD+JOQ4=;
        b=lqj3xFF1MNOJuFY051uy0mSqb333MW+O2ARlZx0p4+m42ljHIkjvITRr0XbF2yaQAS
         NlBU+slJlVwA09LYE7jdenfnarePDoBozAaoYCDZ9AdEVjo2HU4wmcJGsGQNkS177Xjs
         wQUJjvz65BdYK5iTccmFJpSDotzqndO2IgeMImRwEVB4IrWbxkhaVLY37ohftIOtaWbE
         O7h5iAvji9rk2EKOCpin3zlvUgrt/Ei3mizLs5s5+bxs+HpR4g6iIGeelW9Ga8ZLt26i
         /PheNjmnMJ2LdhYWl3n56ZNH8qi5OFxxnH4vEXXe6QWROphmKAVUjk1tnmF6LokVSDn1
         cYjg==
X-Gm-Message-State: ACrzQf0QIkVjoXvEccImpCZoUr6heeXYIwYto2iPR9P0PIxh/xpnkSyF
        K7CwHDAaQDs5auVDJjO2B6a+yr7PmWPTc+WWpeY+dPp6YeY=
X-Google-Smtp-Source: AMsMyM7EyxlUJrFmHrxat7v9ocOjrufkf5Y/U5oAOwsRFlS+vYX0/PHU3j6Koo+TVse6j8yZjUAu2Olg+3LAuZaBQZY=
X-Received: by 2002:a17:906:11d6:b0:7ad:fd3e:2a01 with SMTP id
 o22-20020a17090611d600b007adfd3e2a01mr17390468eja.545.1667602403045; Fri, 04
 Nov 2022 15:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzbvCABmSB3UqKyka=txTiCUdBpTtQg4X6XOa_qVVXW+hw@mail.gmail.com>
 <tencent_6AD8D17AC411037DA1AC2C8FCB0D15A3D707@qq.com>
In-Reply-To: <tencent_6AD8D17AC411037DA1AC2C8FCB0D15A3D707@qq.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 15:53:09 -0700
Message-ID: <CAEf4BzbZDmgnohyyXBwy+p_qfZ1r_kq6d3bfqig+zSOm65vFHg@mail.gmail.com>
Subject: Re: Re: [PATCH bpf-next] samples/bpf: Fix sockex3: missing BPF prog type
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, sdf@google.com,
        song@kernel.org, yhs@fb.com
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

On Thu, Nov 3, 2022 at 8:17 PM Rong Tao <rtoax@foxmail.com> wrote:
>
> We can not just remove the number of program like:
>
> -#define PROG(F) SEC("socket/"__stringify(F)) int bpf_func_##F
> +#define PROG(F) SEC("socket_filter") int bpf_func_##F
>
> because "sockex3" use the _NUMBER_ as index(see map "jmp_table"), if we
> apply the following patch, it's still not recognize "socket_filter/xxx"
> as "socket_filter", still have "missing BPF prog type" error:

Ok, let's keep unwinding this. This is an old and manual way to set up
tail call map. Libbpf supports declarative way to do, so
sockex3_user.c won't have to do anything at all.

See progs/test_prog_array_init.c for an example. Let's convert samples
to use this as well.

This programmatic setting of program type works, there is no doubt
about this. But it's a signal that something is not exactly how it
should be. So let's use this as an opportunity to modernize samples,
instead of adding workarounds.

I hope you sympathize with this goal.

>
> diff --git a/samples/bpf/sockex3_kern.c b/samples/bpf/sockex3_kern.c
> index b363503357e5..ab5a7bde66d0 100644
> --- a/samples/bpf/sockex3_kern.c
> +++ b/samples/bpf/sockex3_kern.c
> @@ -17,7 +17,7 @@
>  #define IP_MF          0x2000
>  #define IP_OFFSET      0x1FFF
>

[...]
