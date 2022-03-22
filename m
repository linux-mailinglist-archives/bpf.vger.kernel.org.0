Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09214E35E3
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 02:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiCVBRZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 21:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiCVBRY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 21:17:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC622629
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 18:15:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q5so4964715plg.3
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 18:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZkQN05mOw7GHNVlObcMTjdx+Y8aT3di0n76j6jctfw=;
        b=qt8wNxoZlriN6eioiaXuHrXPp74Y0cyI3exfX7a0M4/AOMjv+uEGwy0bzctLoPQ0pQ
         wo+9hohNWm+J2vzsOIAxBh7nZSD0SeZV85YxZFaGk0oUO8Tw2GHUTMT8AFynHyIfMh39
         9O0gTTK0rbHN5TZIsup1MWjWSDp3jYZ00FsrYDIMhlYhEmx42Apbs9oPcyWbtuoClr/q
         et05Zh+/OGeqmoye9fR5QJoGQKPcl8HcCu1XimfnEP+HmTL0dso5SkUIblqhtOIe0QSJ
         LVmb2p7l9e7QUTTO8VpXN62PHGfaykCTtYCd1DR2JFpUnHyL7UuQak8/nfqgHDyS4ZE2
         mOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZkQN05mOw7GHNVlObcMTjdx+Y8aT3di0n76j6jctfw=;
        b=sTSSmHYvmuLN3FF1emS3CzbteD1rTRRsUcLFtlkcoYubQM8oJtEA3jFMsneuizQNse
         0Tg+yvpViD++T3irqiBZxx5vA/ToyRudj6Xj6ou9w44iCrafD3ydbU33TRgn1jUFiUdJ
         yWP2pSe+kSthLfOZgaoLW5SoAXpu92Ft9q5s0lJV/FlwAB9ZgkSYfMbnSjSldLpMoB0k
         l7tnKXqSsvJNpFZw1hlOUIBfC/Yrtb3xZOIVxBMcUNlAwnKmeXiaWbJYudO77bdvwogP
         Oz8sRBJT0oBodvhP6Krk6ARtmMAM08b3F2Snun+TtzC8HPLb2dKhVEdENNMaYc3BRGB6
         cS1g==
X-Gm-Message-State: AOAM532GMenpFlsfot55uS3Du5zT2dhZaijn8U2MC81ylTKx8mX0njLV
        6J02Nc+dARZOI+iAb7dMyt+E6pXgGw2/Z4IdeHmol9tRMSA=
X-Google-Smtp-Source: ABdhPJwexIjbBaauntRGnW46RIAraWARGbKOvvQ/08jVTSaU8mW7dFnn9x7Yv0E/4crm38TLnbimFWV+uUcUA4v+8eM=
X-Received: by 2002:a17:90b:4f43:b0:1c7:552b:7553 with SMTP id
 pj3-20020a17090b4f4300b001c7552b7553mr1886747pjb.117.1647911757978; Mon, 21
 Mar 2022 18:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-4-kuifeng@fb.com>
 <20220318191332.7qsztafrjyu7bjtc@ast-mbp> <CAEf4BzZF02Jn3PP8LJ7oF55ogPOePt0Wt8+Dtmj5fN0r7PfU0w@mail.gmail.com>
In-Reply-To: <CAEf4BzZF02Jn3PP8LJ7oF55ogPOePt0Wt8+Dtmj5fN0r7PfU0w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Mar 2022 18:15:47 -0700
Message-ID: <CAADnVQKo2xiOYrUG_Mb9OTAO_Sa7uahkYL-UEbu02GD=Sr8BJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for fentry/fexit/fmod_ret.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Mon, Mar 21, 2022 at 4:24 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> I remember I brought this up earlier, but I forgot the outcome. What
> if don't touch BPF_RAW_TRACEPOINT_OPEN and instead allow to create all
> the same links through more universal BPF_LINK_CREATE command. And
> only there we add bpf_cookie? There are few advantages:
>
> 1. We can separate raw_tracepoint and trampoline-based programs more
> cleanly in UAPI (it will be two separate structs: link_create.raw_tp
> with raw tracepoint name vs link_create.trampoline, or whatever the
> name, with cookie and stuff). Remember that raw_tp won't support
> bpf_cookie for now, so it would be another advantage not to promise
> cookie in UAPI.

What would it look like?
Technically link_create has prog_fd and perf_event.bpf_cookie
already.

        case BPF_PROG_TYPE_TRACING:
                ret = tracing_bpf_link_attach(attr, uattr, prog);
would just gain a few more checks for prog->expected_attach_type ?

Then link_create cmd will be equivalent to raw_tp_open.
With and without bpf_cookie.
?
