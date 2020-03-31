Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3C8199F61
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 21:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgCaTp6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 15:45:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46768 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgCaTp6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 15:45:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id g7so19452812qtj.13;
        Tue, 31 Mar 2020 12:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REjYZlG94i8PyvxEbrGw6FROa/0MlwWAThXqw6aFXhA=;
        b=VSzLexTs4R0b655EBqdGCoSiFIqAQHoDH/UYop0iyse8dwS75rGIg5+JF73dCSmK1g
         zEphrL0t82cI/7mDQyyl246sSAEeSaZYqwIjLSG8E6an5fc7yedc0djdKKfBh1e/+sX6
         8hHIphF8tk+LMZqKjxxZasi5b4mRCYJm7kt/urRRmWEJnZRitnDeMeNIozr37N4Wsuxv
         PY5vrL5L1OYrgDjprWPaodKVqzE4OZXFXydKFQ0owREtK2KnYbdNY9BDVIySeE6mK0L/
         f1KkeATFooGwCvPN8f86OH2P3zwP7dJWlab2UyZR3iMe+EZDreIPJ6FARa+xmZ8DiT1Y
         VvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REjYZlG94i8PyvxEbrGw6FROa/0MlwWAThXqw6aFXhA=;
        b=Bhaw6xWlaauB+MTUSw6SCgoP5rPPL458ZDHpYRdfo7Xk8fG+jR6oY5SdNOaLsDP6KQ
         YEmFDshh+3tB3UAIgdxLU6uwFUzt3N2ueX14qImjT+n1LIitNpEW7AyKKZYDsKZI66WI
         L2t/gadhJYxjYIq665h+lzDCajtu6pgQ4wgxuI4ZYcsRISThKE2ONm8wkTpFK8Bbl7N/
         2sbjCFvWRhOp3nYpvf9q/S2wpRh3HzitG0/YQKhB/hLuBGo8YZkdafUC0nZ7cFhuGuGK
         YtkdKuWqa2K046usOXSAGQ48z8Rt1DvnIBwP8U1MAyFAB6ka6SmYEaCszND6u2PCQe7a
         6BFw==
X-Gm-Message-State: ANhLgQ2RFlllpx+2aPwI0IJR3W75L7mLqAzww4oaJgPBbtMPg+8RqjJQ
        kM59p5aLNYKrpjAUEIilj713rpsJH2v2hoEKuDU=
X-Google-Smtp-Source: ADFU+vvi0ecOPffFZmRFp24NNImgY9stnVZBzdZ7eyIL1hi/wzu6S8WAYD8vWyl+NrWOBTAx/Emq3hZqKr5dYgtkrY8=
X-Received: by 2002:ac8:6f1b:: with SMTP id g27mr6856118qtv.117.1585683956976;
 Tue, 31 Mar 2020 12:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200331164719.15930-1-slava@bacher09.org>
In-Reply-To: <20200331164719.15930-1-slava@bacher09.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 Mar 2020 12:45:46 -0700
Message-ID: <CAEf4BzadnfAwfa1D0jZb=01Ou783GpK_U7PAYeEJca-L9kdnVA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: disable DEBUG_INFO_SPLIT when BTF is on
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 31, 2020 at 9:57 AM Slava Bacherikov <slava@bacher09.org> wrote:
>
> Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
> enabled will produce invalid btf file, since gen_btf function in
> link-vmlinux.sh script doesn't handle *.dwo files.
>
> Signed-off-by: Slava Bacherikov <slava@bacher09.org>
> ---
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f61d834e02fe..a9429ef5eec8 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -223,6 +223,7 @@ config DEBUG_INFO_DWARF4
>  config DEBUG_INFO_BTF
>         bool "Generate BTF typeinfo"
>         depends on DEBUG_INFO
> +       depends on !DEBUG_INFO_SPLIT

Thanks for following up! This looks good, but I think there are more
DWARF-related configs that should be banned. See [0] and [1]. If you
don't mind, let's use your patch to disable all of them in one go. So
can you please update and disable DEBUG_INFO_REDUCED and
GCC_PLUGIN_RANDSTRUCT? Thanks!

  [0] https://lore.kernel.org/bpf/202003311110.2B08091E@keescook
  [1] https://lore.kernel.org/bpf/a2b1a025-6a70-c3a5-fc19-155f0266946a@fb.com


>         help
>           Generate deduplicated BTF type information from DWARF debug info.
>           Turning this on expects presence of pahole tool, which will convert
> --
> 2.24.1
>
