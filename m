Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F564E0B9F
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbfJVSm2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 14:42:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39440 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbfJVSm2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 14:42:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id 4so17248732qki.6;
        Tue, 22 Oct 2019 11:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z5E1UgKK0swToOdaVE1vrj3rS3+MfFMI5KCYTwUDvjE=;
        b=ouZ+YfdYnsqEG5Mrfhnl/oCGv5/i4ar9VvOIlc4u5soJ6wiKu3idpcvTMQzeVKdYJj
         YKlbkjvMGpn2hsI8O7MDIylhFSi3KWkYOVyN4K/dWGUedAQh9kUXg7v6LvwZEIrtRHCw
         8ttqR5gF74VH2eD20Nkmclpcr/DlXhdynNrMkGDkAHiWXaivE0V4KSp7gtq75ZPzqW17
         0SQS0+7fTMR/oe9ubNe8NBEkNdavt/TH9NwMkKpkEhWzd9g/4mQQr8wKHqC9WgwZaW3S
         xa2cQAjhQ9BzPkXRSuMA0ys/rEybm8dKUHo+sFTQW7ezmeMbSUIjCMSnc0e+9+Gm/N5F
         QwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z5E1UgKK0swToOdaVE1vrj3rS3+MfFMI5KCYTwUDvjE=;
        b=pO1O1ASq5PQBZY6aDMWeUVnlqcbZICVpo2NcmUWSz5J93g9r1WoNUDQ11VULmrHnC8
         NuoS+cDLQJycn616/evaehottnmpap1YaqeO4DrEGCmPxcX61CvVtYnrGxBTNfBi8KIl
         TYayl++NDYYwahOT/hJ+SEGdKbVboFOM6MIASYqSi1J+Xz5bkzqvn85lBe2qYmbNKtQQ
         r4JZV9wxo3QXu3qVsq8lqkJj4jy/3ZzPZJWiiX34HW+KZsfphRIMSAOtvQgirIEC53KO
         92Na/1VgoAPw6ZD6BvwXrHLosjGKt5u602srQ5yLphDd3i8zP6rxAW+av8GBjr3CJnm3
         nCog==
X-Gm-Message-State: APjAAAW8t7FzrfZu94BbRTj/KIUBQ2BHwcZ2wam4vlOh41eWEQ4eQoBd
        U+bxNnpUgKqRQHwxlrpEfFiF4CIb7ZdhYRWStM0=
X-Google-Smtp-Source: APXvYqwpkAk0xmfVNKx19v7ZUhWLtfpcp58XLtRa4vpl3aPIwquhkdFer4zqDaPeSE6KVtnzx6aaV1JPQjXM3H3VgXk=
X-Received: by 2002:a37:9a8a:: with SMTP id c132mr4487196qke.92.1571769745663;
 Tue, 22 Oct 2019 11:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191022141833.5706-1-kpsingh@chromium.org>
In-Reply-To: <20191022141833.5706-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 22 Oct 2019 11:42:14 -0700
Message-ID: <CAEf4BzY5YYtiWOtHWfis2F28gmsCvJ=JuM7yHKrbBCdERwr2ew@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix strncat bounds error in libbpf_prog_type_by_name
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 22, 2019 at 7:19 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> On compiling samples with this change, one gets an error:
>
>  error: =E2=80=98strncat=E2=80=99 specified bound 118 equals destination =
size
>   [-Werror=3Dstringop-truncation]
>
>     strncat(dst, name + section_names[i].len,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      sizeof(raw_tp_btf_name) - (dst - raw_tp_btf_name));
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> strncat requires the destination to have enough space for the
> terminating null byte.
>
> Fixes: f75a697e09137 ("libbpf: Auto-detect btf_id of BTF-based raw_tracep=
oint")
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9364e66d755d..5fff3f15d705 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4666,7 +4666,7 @@ int libbpf_prog_type_by_name(const char *name, enum=
 bpf_prog_type *prog_type,
>                         }
>                         /* prepend "btf_trace_" prefix per kernel convent=
ion */
>                         strncat(dst, name + section_names[i].len,
> -                               sizeof(raw_tp_btf_name) - (dst - raw_tp_b=
tf_name));
> +                               sizeof(raw_tp_btf_name) - (dst - raw_tp_b=
tf_name + 1));

Just:

sizeof(raw_tp_btf_name) - sizeof("btf_trace_")

?

>                         ret =3D btf__find_by_name(btf, raw_tp_btf_name);
>                         btf__free(btf);
>                         if (ret <=3D 0) {
> --
> 2.20.1
>
