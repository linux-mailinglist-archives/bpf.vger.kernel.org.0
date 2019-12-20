Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F51C1281F0
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 19:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfLTSJj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 13:09:39 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42647 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfLTSJj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 13:09:39 -0500
Received: by mail-qv1-f68.google.com with SMTP id dc14so3948360qvb.9
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 10:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ft61T+I9PjwSYi2Ca52U2YfJJkIcXtBrYvaXk0xOaoA=;
        b=AWlbFLiwSPnJQTB7VNNlWN/DSNv2UoPeT6YDKYjbW7NLYv+QIVlz5oP6VZDGM0vXam
         k0fHu6NIa1unsEiHE9uJCoD3jVxuj6z9fcoUI0JCa02hu1L0RkyyFwj9Yh8y69hYFDbA
         yYdXP4rwnzBAeg+I3us7InEpXqop/2tR0sQ3/IdG6OFian3rFR27FEffu6RM/PEPOuaX
         qinvBbqmQvXATkggU0TideOUVKjhlRccPlzbt4KHbF7JSZtbMv0lPWVPIxOOEbXKufVE
         1xdeaneI9c+EU7YJpONn0DBm+bdtRdfHmPmxC2NauNebfcX+v3ot42mEXXAxq47+++X+
         zygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ft61T+I9PjwSYi2Ca52U2YfJJkIcXtBrYvaXk0xOaoA=;
        b=b/zORgyZ1FXDO3qHfoxyk4hMpwYE/eg8nCeN2Q/Ovzsmq+JfzZrlcttzi/ywKvJXZO
         Y0N9hRoN65IrRDqjJfTc/VMDoW8y24Byx5Hrfy1wkxDvnF4j9L/ZNYow6MR4x0lKiyu/
         nj9ayN8jzBjzNnoa0bYFxIUMn47i9eGGqSfPbcoLHwtYVX3K1fkzJ5vMvxIf37fSBXcY
         EKXLVqw+05t+eBq0pmhgvI04WdiZg3ZSWwewyP4117s7qyprgMreBC7QYTUteol10qr5
         79KhHTI8YFEN51TnXbsxsTAlCvmmBEm/l8LNOM9GxyvEZqGZB/ZYw2aM7U003DTvyk+J
         Otdg==
X-Gm-Message-State: APjAAAUwf1or092jE3ssVEVEHjk2g0+vX+HjCLozQzsP0/8Ujejf6oSj
        xTOrF8LPUbqo1ATOdC6B0UG+TpqgWfcT5saNa/z3P+4r
X-Google-Smtp-Source: APXvYqwCwTtlEQzRugqihDgF06mtdijQnNqcxy5YCgAW3ZQzyKLfo2R4y3Kvmup5h5JgLqx8gTzCVky9ARdYkmvXdlc=
X-Received: by 2002:ad4:4e34:: with SMTP id dm20mr13702084qvb.163.1576865378719;
 Fri, 20 Dec 2019 10:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20191220000511.1684853-1-rdna@fb.com>
In-Reply-To: <20191220000511.1684853-1-rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 Dec 2019 10:09:27 -0800
Message-ID: <CAEf4Bzb3Z2j2jXic20WTzZ66Y_doYHsc99R0G50LQSriNP2tFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Preserve errno in test_progs
 CHECK macros
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 19, 2019 at 4:06 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> It's follow-up for discussion [1]
>
> CHECK and CHECK_FAIL macros in test_progs.h can affect errno in some
> circumstances, e.g. if some code accidentally closes stdout. It makes
> checking errno in patterns like this unreliable:
>
>         if (CHECK(!bpf_prog_attach_xattr(...), "tag", "msg"))
>                 goto err;
>         CHECK_FAIL(errno != ENOENT);
>
> , since by CHECK_FAIL time errno could be affected not only by
> bpf_prog_attach_xattr but by CHECK as well.
>
> Fix it by saving and restoring errno in the macros. There is no "Fixes"
> tag since no problems were discovered yet and it's rather precaution.
>
> test_progs was run with this change and no difference was identified.
>
> [1] https://lore.kernel.org/bpf/20191219210907.GD16266@rdna-mbp.dhcp.thefacebook.com/
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---

LGTM. Doesn't hurt for sure.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/test_progs.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
