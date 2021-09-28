Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E193B41B629
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 20:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbhI1S1c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 14:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241724AbhI1S1b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 14:27:31 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3EC06161C
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 11:25:51 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id m70so33767069ybm.5
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Je9t8ZzjyraEl9KD5dyMzHYrfFskRd8I/xvHN5vfHOM=;
        b=I8dKFALSowIqwr9yc3elaFZDCdK9ktnHOCRbXxiS+7KJP/+xbk2oBzxuvLQkR1dpaW
         iOUtgUDtPWL/euDWTkMinxb5uUs53d1qsW5GbYgR1er/ww68BwlqyliskQnrO6Wzs+tO
         SlTWbZCHeltLRZLrc5iDPv6F5n7n8sYooq/u9na0g1pa66t1QCSm7NiIHgJJN2v1IKZk
         BiGNq1AF00MOHXrIRQ+KPAWlPIJqrPOfLc3vzLDD6Ie6uStOdJPqUFJjmMWQsmkQb1LP
         rYmjBzxIyAhEF2+R3Lv0Zpg79Ds2fkrw/4xZ0kvdrSax878yKB+N88+4ks/jexFnaloa
         FoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Je9t8ZzjyraEl9KD5dyMzHYrfFskRd8I/xvHN5vfHOM=;
        b=BmcZt9LymOpXbL4bVaF1DlQTQVq2jRaZhis9IhlMSjJC9Vu3iwNEv6xeN8RJq0auW/
         +LoGS0U2nPTQ8UojI45pIITrSeFEMdO8F2ktyB+12SW9eG97l8GRHs2lcABYs6R7Cdfx
         r3rmGNGScRczLT8HUU9eVPGwhxGrGPDOsFFIJWOOa4GYrGiy0ZLl7pE/siVXaNqpZ2O9
         AIHLCZGVgJAoYnudocQuEc0JyDErWukLwOUtEatBLxp+GuoEozb41hDsHs8NaqBAP1kV
         6lQgmAAl4+xO0Xup7JhlRXymAW9sLrl6mjnmKrWBp8Gyb1RC61VH9+st5nX8lrYpQPC6
         VNbQ==
X-Gm-Message-State: AOAM5321BhMRj+K1C3Qx7YGK+nI3A1PTIDG/jwHaXqBbreKUjdqTcCoV
        AXhJZ5Up5oH/rVtzKEvDZzeM0FVjXZZ09uAv9MxJ+IL0
X-Google-Smtp-Source: ABdhPJzaQS9+PfWXM2XB1hx3sTX0YIpLswZt0PJ5vf7F1MnMYLa5SGtGkeArXcA+h41+sw4gh7PzkEENuGo3YAXZqmo=
X-Received: by 2002:a05:6902:724:: with SMTP id l4mr8167204ybt.433.1632853550965;
 Tue, 28 Sep 2021 11:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210928181127.1392891-1-fallentree@fb.com>
In-Reply-To: <20210928181127.1392891-1-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Sep 2021 11:25:39 -0700
Message-ID: <CAEf4BzZq5bqSYvxsW4ot7pN8kyrGNG6RHSOSzyYr6-qFUuh38Q@mail.gmail.com>
Subject: Re: [PATCH bpf] tools/bpftool: Avoid using "?:" in generated code
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 11:11 AM Yucong Sun <fallentree@fb.com> wrote:
>
> "?:" is a GNU C extension, some environment has warning flags for its
> use, or even prohibit it directly.  This patch avoid triggering these
> problems by simply expand it to its full form, no functionality change.
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---

Given there is no bug in the first place, it's not a fix, and thus
should target bpf-next tree.

>  tools/bpf/bpftool/gen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index d40d92bbf0e4..85071b6fa4ad 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -803,7 +803,7 @@ static int do_skeleton(int argc, char **argv)
>                         }                                                   \n\
>                                                                             \n\
>                         err = %1$s__create_skeleton(obj);                   \n\
> -                       err = err ?: bpf_object__open_skeleton(obj->skeleton, opts);\n\
> +                       err = err ? err : bpf_object__open_skeleton(obj->skeleton, opts);\n\

err+err+err in one row looks quite bad. If we can't use ?: for
shortness, maybe let's just do

if (!err)
    err = <some operation>

It's more verbose than the original version, but it's more obvious and
sort of canonical C?

>                         if (err)                                            \n\
>                                 goto err_out;                               \n\
>                                                                             \n\
> --
> 2.30.2
>
