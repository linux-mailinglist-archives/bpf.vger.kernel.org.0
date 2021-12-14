Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5D473C5B
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 06:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhLNFPS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 00:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhLNFPS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 00:15:18 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1598C061574
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 21:15:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id o4so16838989pfp.13
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 21:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jszANN8IKBRswJaX8j5QsurEt5UP0ve2Ij7Mp4jHWfE=;
        b=Ibi0w5z+duHlxF5IPg7bqTUeDfnWzI2ymQIB9t/Qi1i/WMXToN7I+7A9GzaQdqtBeF
         VTdDGe9DPnYtWJF9g9wgqRuVFJAJOE93/RKgydyoOygN1GApUtyCKUcSTRFg30GTy00I
         /jEI1NmbkTqFu+3ZT7xBNeY/R4cPlj7Tu3lkzNkzxRtH+7a7olcu1fBkPnLVqQBQJ6Qa
         BEd2meeNSXbFskwxMlv0pVHkWqck6tbVdqK//U+Ew/wE+UFxYEnE0lOMqEirEvBwXzAY
         OyR1GJAtWJ3LymJ+QwFGKHTC+2LHzi36npkRQtq4Hda7lI84KrehqKE2YMDkW9NKoURh
         FTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jszANN8IKBRswJaX8j5QsurEt5UP0ve2Ij7Mp4jHWfE=;
        b=qLtYX3dWvAwixRuUOEF/soRUI5h3cZXEiEMCtvsl/xnLXOURKxUEXItvccQVSUK8vt
         BEADZTrZ9VdAX7AkWRG3qIRuKWBYQHJ8zzEqePqJyO5gQdUKw2M3CKmuHCU8CB6f8rSz
         JJkVQVJUl8GC7rELIwGRBjoawn6y5HJ5PNQuKgL9hp0t5cpjhNnpnAyFDA3incIa/IS4
         L39qndXogZOzg+azUuVGL7jxJfuZO0A7MVShL4KApfQ5P7LStk4i7ueNw3n6jItzIlu5
         jzlgm/82uT1KBuBLgEuuJxtzdzt0EZN0JJuH99pt8/qvtJe1l+nchGHXeQdVhGhV8tIN
         CJeA==
X-Gm-Message-State: AOAM533vIBEjUjpluVzrSriQ5Lr/RC9eWNc16yeMUq4YpCzfARj1Ezpq
        yxdTs5KWi/6ilWI5GaAKuMzoOnkT1TszalY2EnJQ/oGjqD8=
X-Google-Smtp-Source: ABdhPJyPaU9ND61WRslhF4meIV5wV1oigUYwAZr91En4+iK6idfCcaNLQndv/0PuV3Alb27f7RA7Z5Uw+5WJXXLXlhk=
X-Received: by 2002:a62:33c6:0:b0:4a0:3a81:3489 with SMTP id
 z189-20020a6233c6000000b004a03a813489mr2305062pfz.59.1639458917347; Mon, 13
 Dec 2021 21:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20211213234223.356977-1-kuba@kernel.org> <20211213234223.356977-4-kuba@kernel.org>
In-Reply-To: <20211213234223.356977-4-kuba@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Dec 2021 21:15:06 -0800
Message-ID: <CAADnVQ+6Qmm9b3Jf_BHCn_PFxs00NK71K235zQYc=_PufkOPAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: create a header for struct bpf_link
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 13, 2021 at 3:42 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> struct bpf_link needs to be embedded by cgroups.
> Put it in its own header.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/bpf-link.h | 23 +++++++++++++++++++++++
>  include/linux/bpf.h      | 10 +---------
>  2 files changed, 24 insertions(+), 9 deletions(-)
>  create mode 100644 include/linux/bpf-link.h
>
> diff --git a/include/linux/bpf-link.h b/include/linux/bpf-link.h
> new file mode 100644
> index 000000000000..d20f049af51a
> --- /dev/null
> +++ b/include/linux/bpf-link.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
> + */
> +#ifndef _LINUX_BPF_MIN_H
> +#define _LINUX_BPF_MIN_H 1

MIN_H ?

My understanding that patch 4 is the key.
I think the bpf-link.h bpf-cgroup-types.h and bpf-cgroup-storage.h
are too specific. We don't do a header file per type.
Maybe combine them all into one bpf-cgroup-types.h ?
That will still achieve the separation of cgroup from linux/bpf.h
