Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548121413BB
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 22:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAQVzU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 16:55:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40483 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVzU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 16:55:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id c17so24212907qkg.7;
        Fri, 17 Jan 2020 13:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4pHI0w4puOIIpTavEP0FpVLcc6fVlC+yRi0odac6wM=;
        b=OnLlNnFlbPtWmvDFs2w6DvsFAcLmX4osdXWnpFfZPRowiiSOFidqtvn4k2u4rLIuuS
         rF/yPQfyuO92gl/xCkfCpXQhreRs4Z16jFdJ7gqXHNElDQfyrsc0HL/3IN9Sr1Lxd2rX
         fYlgrCce6exsuKFtj8a+589HaBKHJJBES4oYJeBXK39cS/mTgBIGqc/6HnVVhhQOGG2M
         HztzIEHmga7AThmS6Ia+1dP6XpGDYE2eFxhcoJFNqKSQ26pxCcqpD2uadxIqt3a657Pf
         3sFGOm7uBMbhq2LO3no2fegZ8oGQVlRKGqMaaYubMhkmUURagXEijme1TQNf0eO3NTpa
         wepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4pHI0w4puOIIpTavEP0FpVLcc6fVlC+yRi0odac6wM=;
        b=Py4YmjPsVFDEtKAGNWYasJdfmvj9i2GnyWzeop5ulNKi5HdeAmfyopACUx8zQzjgmR
         9HOXbIbJS/Xvgy/dpEU8uxv/xgemJAodbd+YjboiF/nIxC30wqTAKFrWyzTbKLPen0ji
         wZXBTHrd91hDSoShuZLD7ObiAU17WAmHRsQjs7QLDgKDndwhiUneCoMz0sjU9zoGDGb3
         4OY9Tc7lvZFDviAW4pbcALYTR1D75Yeii95i50g6yRBpAahL4c6IIb2Hc9mVhPGouSv+
         7evSLDmY66VeXTBo1UoiwUFzdHPaiOqPZjN4d+xhh2AOn0C28TDER1hrg32Jgcf0dBNg
         da+A==
X-Gm-Message-State: APjAAAVF8urQGzYwt+gqvvGC5OQPfSlQ21dtMiKoG8IbQ1XKYrFOtPrR
        DjBPZKCR/VbwJkhJBh3v0mh82VHAGH3W+dDaNaI=
X-Google-Smtp-Source: APXvYqyhURizCoo+zp6Z1+sd0yPDWV0kjzEW58vFdJBxM9dW4GSAxbE/uMh786GoN1L2/Dv2d+926KUAQfh9adUwYTE=
X-Received: by 2002:a05:620a:5ae:: with SMTP id q14mr36688643qkq.437.1579298119693;
 Fri, 17 Jan 2020 13:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20200117212825.11755-1-kpsingh@chromium.org>
In-Reply-To: <20200117212825.11755-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Jan 2020 13:55:08 -0800
Message-ID: <CAEf4BzZ1STEe-RvsLYBccXXLSip2N49cgjE1kE+PvnQaKipM5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Load btf_vmlinux only once per object.
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 17, 2020 at 1:28 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> As more programs (TRACING, STRUCT_OPS, and upcoming LSM) use vmlinux
> BTF information, loading the BTF vmlinux information for every program
> in an object is sub-optimal. The fix was originally proposed in:
>
>    https://lore.kernel.org/bpf/CAEf4BzZodr3LKJuM7QwD38BiEH02Cc1UbtnGpVkCJ00Mf+V_Qg@mail.gmail.com/
>
> The btf_vmlinux is populated in the object if any of the programs in
> the object requires it just before the programs are loaded and freed
> after the programs finish loading.
>
> Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Reviewed-by: Brendan Jackman <jackmanb@chromium.org>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

Looks great!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/libbpf.c | 153 +++++++++++++++++++++++++++--------------
>  1 file changed, 101 insertions(+), 52 deletions(-)
>

[...]
