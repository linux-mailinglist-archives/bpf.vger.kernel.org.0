Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B841F44DBAE
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 19:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhKKSqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 13:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhKKSqF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 13:46:05 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE633C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:43:15 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id u60so17357396ybi.9
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIVRDco06JuK7rMfO5iLkn8/+jeMgtIq/lzJhdZI2M8=;
        b=gI/JCRU1UDn+rbW5evue2jXcJNOvey43Wi1561zmcdq5s9rD2C3Gv+VvIAjGZRbqPz
         OhhljwIt9opZcqoPtgj+cknMNE/nuKoL7DF19oXEr3Z8naWm7uk+UAFbTnvHShWkxTTO
         IoEQQ0RRqQjryg3eRjl+xK59WGfm+pgESGrXlF8OGcdiVMPutWdRjLh823qw+DSjDxkJ
         pSD+JYRFN2kCOac+zQsm75VhorkUXhS+ciBPTFpmT3sFhy/TRrW/IMum4gpl1mnWq2rw
         0eyvKMuDn/Hi2KUp3NftmWxxwnmjmOjaf2LM+V836KPwq0iwOLsIQt2TZkU3/9OICo03
         xgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIVRDco06JuK7rMfO5iLkn8/+jeMgtIq/lzJhdZI2M8=;
        b=rPm7MDHfiJsf7nTOj6H7ov72E7saGZEwUlxxtBPzXAsDqhuE2spMO2g6r3icJLPYZD
         xPPuxzknfuuagbJjsM6cNMMdkakYFyE7drwB/20QT/GX+vZB7gVAC+uRfOng3Q++a9de
         rNfWbg8cqdE0p7hVIQhLhsOYOpxL0WzRZ4U42POZlDED/835nmr8LK9m8qydxTgJpOgE
         RPIbve9t8KogXKai3ftAhKoFlNntN894Xx4o4vIoeFXaI/l7sppSzyPelPsApw9297N4
         hD+VnoNnBBIvpw6UbblTxJslZOHz+L2A3+/JKUtsp3R1kK6lKiaGmiuvU7g5jMeaNvOK
         s5Sg==
X-Gm-Message-State: AOAM533cGdvmm8dBB25zW8RXmcSgt6qEZYfRZihFurPae8os+6sUkUS2
        YOAHQZ+KqUSSl4Yaguw9DtsusYg1Rip84deM/MI=
X-Google-Smtp-Source: ABdhPJwZ8K4byiUvFJaMy957OXHSnCdb2xWZWCTMKMXIgQwX2ZykspM8CKzRaEuZC6fRRkggQB30nqZuTVQUGbP14EU=
X-Received: by 2002:a25:d187:: with SMTP id i129mr9888023ybg.2.1636656194224;
 Thu, 11 Nov 2021 10:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20211110051940.367472-1-yhs@fb.com> <20211110051956.369869-1-yhs@fb.com>
In-Reply-To: <20211110051956.369869-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Nov 2021 10:43:03 -0800
Message-ID: <CAEf4BzZ2Dfsc3NviRjeZ8Jj=wuJ1sWPY=b74oiyqMg7ox-LF6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/10] bpftool: Support BTF_KIND_TYPE_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 9:20 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add bpftool support for BTF_KIND_TYPE_TAG.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/bpf/bpftool/btf.c | 2 ++
>  1 file changed, 2 insertions(+)
>

[...]
