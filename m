Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2206D702E
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 00:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbjDDWc5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 18:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDDWc5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 18:32:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E764209
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 15:32:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-4fb22f1f91eso24435a12.1
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680647574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPeeJZLR+A+7aPRJqsRvtyrtol69yWcoEEwycnFnIxE=;
        b=FnGJzNHWyUdoDps49Doy5ZXFzy8FhMAIrGWqhdYoEvagy8fYz5exURitTimTUBuKgV
         eaysCll1+Eeb3yQASWHsGV0d9C7y6jol3JkUTD4tiBF5v6YBoWPjD5VBIHQt+9JIrU/d
         lSZKuU97vOuulF5bkL6EmmPaFeeO1HHhBDBVHYG5bSE/gEcr3awUa973CKq6OI3R1JYG
         bXwgAaRgUKHwu0qU28MSYq2DhF024nh6ILD8jEacjuoU0SR/u1waL9OTo6XLF+3Sbxf8
         108AJHKl74aaJVdkhp9igoBL8/a6txYDvnf4IKhHH8q6KtjMRlbnhN1/ddF/8kV3Hek0
         azfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680647574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPeeJZLR+A+7aPRJqsRvtyrtol69yWcoEEwycnFnIxE=;
        b=Hk3T462JIaIjSI8BPLJuK/2TMfQrmiIKpKREnnH1dXYFoDI7+1oCQnrCCiIRC59OyS
         1k1Hw7CU9x248SXnmmwplXCCQbldsJ+R12gk58fILWnmW5fKZE5avVLDmMvDWP465iM+
         GnHI8WlIiCyLRyLW/CTDZ852R0QDIYuKAzcZ31mljzhYze5RcNXIPO1gF0vu/0Jq+Yit
         JlL25gAoVaIOSseSO59Sll+RaPfDneBLMh3XzzyU983rYe/89p9Cdeh09CXtwetcyBmg
         ahlYB33c5AiUfvtVus0V9fUFlzGnvWqYZAWu2uIU2QQmmf8RvoGm8tr0kRMVGfkzVw8m
         GxYg==
X-Gm-Message-State: AAQBX9eFlEQJ3SI6wb9CoLt0Ygvp7aOlwXmRI0x6y2/CST7odw8/fO2S
        qClXnC380kmoER1ZAKgBm9ADmAlX3Cw64ghyiZ+7aukJo3A=
X-Google-Smtp-Source: AKy350Ye3kP7zzGFcDeRcE08DI3PdAdVYoCTqDPW8GP30MJR1Y9IKT8ohqSo3CCRF7Y+d4Wrx/88Ob7hMB7yMhbcLAs=
X-Received: by 2002:a50:9556:0:b0:4fc:1608:68c8 with SMTP id
 v22-20020a509556000000b004fc160868c8mr91317eda.1.1680647574233; Tue, 04 Apr
 2023 15:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAGQdkDvyUu2ZDDdRmb4YhDzB96hS1NPW=ju=_Y_C+6nyA6xVGw@mail.gmail.com>
In-Reply-To: <CAGQdkDvyUu2ZDDdRmb4YhDzB96hS1NPW=ju=_Y_C+6nyA6xVGw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 4 Apr 2023 15:32:42 -0700
Message-ID: <CAEf4BzbauKucsr-e4GigvrdYy2S9XNQQ6YW0xZ3ocJVcGpR7Ow@mail.gmail.com>
Subject: Re: [QUESTION] usage of libbpf_probe_bpf_prog_type API
To:     andrea terzolo <andreaterzolo3@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 30, 2023 at 10:21=E2=80=AFAM andrea terzolo
<andreaterzolo3@gmail.com> wrote:
>
> Hi all!
>
> If I can I would like to ask one question about the
> `libbpf_probe_bpf_prog_type` API. The idea is to use `fentry/fexit`
> bpf progs only if they are available and fall back to simple `kprobes`
> when they are not. Is there a way to probe `BPF_TRACE_FENTRY` support
> with `libbpf` APIs? I was looking at `libbpf_probe_bpf_prog_type` API
> but it seems to check the `prog_type` rather than the `attach_type`,
> when I call it `libbpf_probe_bpf_prog_type(BPF_PROG_TYPE_TRACING,
> NULL);` it returns `1` even if `fentry/fexit` progs are not supported
> on my machine. Is there a way to probe this feature with other
> `libbpf` APIs?
>

looking at libbpf probing code, for BPF_PROG_TYPE_TRACING we choose
BPF_TRACE_FENTRY attach type automatically (because it doesn't really
matter whether its BPF_TRACE_FEXIT or BPF_MODIFY_RETURN, they all are
either supported or none is). We then expect that verifier will
complain with "attach_btf_id 1 is not a function" error. If we do see
that error, we know that verifier supports fentry/fexit programs *in
principle*, which is what we are checking with
libbpf_probe_bpf_prog_type().

If kernel doesn't support fentry/fexit attachment for some specific
function you'd like to attach to, that's a different matter. This
would be equivalent to BPF_PROG_TYPE_KPROBE check -- we check if
kprobes in general are supported, but not whether kprobing specific
kernel function works.

I assume by "not supported on my machine" you mean that you can't
attach fentry/fexit to some function? If not, let me know, and we'd
have to debug this further.

If you want to know if some function can be traced with fentry/fexit,
check below helper function from libbpf-tools ([0])

bool fentry_can_attach(const char *name, const char *mod)


  [0] https://github.com/iovisor/bcc/blob/master/libbpf-tools/trace_helpers=
.c#LL1043-L1043C58



> Thank you in advance for your time,
> Andrea
