Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C25712CCA9
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2019 06:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfL3FVp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Dec 2019 00:21:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36296 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfL3FVp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Dec 2019 00:21:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id q20so29004839qtp.3;
        Sun, 29 Dec 2019 21:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lNKxPvHxROHqhZ4QdqK3+zrQW02SHIbFmnsEL2JrlU=;
        b=RQ4JfQxTot2k1DcBlQGLXvz3lkTQEP8nGiYdHpB4vbntl1utw5VeRDP8riMvM6u2zo
         yr6JTTCyU3kvzBuEl2wh2J3vM6qdpLVbXs5vvho8cps/CgeCKlHXzVqzIeBXbxAFLWiM
         L45uwGKtPZ+G5E7/Qu/X0pDbuzSIxD34SsDDztObllsVZSDaIFH5e8ZtvkEnQCMnSdlL
         DPPTExnt2hOtdj0QeBI4O3YNSFfPMppcJ3GHPBNE6DOsv4tzRfy29dJQxPbgmhkMwN7y
         K1gaKQoepQ5o3ncb/gPxrIcQSnaJ7zQzIh+rces5FwG7WjmJ2t7u3z17+l++f6KefIF5
         ghrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lNKxPvHxROHqhZ4QdqK3+zrQW02SHIbFmnsEL2JrlU=;
        b=hiivRhRAclQMW3tklDyL6a+TTrcj6BiyBAM36Pmzg3Ia5hTAros2tPoJ/OOsIX0gvC
         JWBsDp5kO3v5fFkF9n3Dpb0XiVB8/lpPI1PDKce5hlwVF0luoL5Y8/+1dgx6SYNl4hnc
         /mitepjmoleprazvRxmOiYnmgK0FoeMP9AQWkcPEPvKXCwA4JOYCKThSSYhIT6SCGglT
         kAjc8IXPHp5zCoeaze40foU83GCrevIYEjgG3mTZ5VGaVsYJAfHQwHntmQLBL5X3e/+S
         Yq6lNjCE6CYMSSbJUdsP6MiLvVpYG7ooE876ENcAjSZrPQN9VMEkxxj3fuheduq/sPBC
         vdyA==
X-Gm-Message-State: APjAAAXTw2seR4mOBVhFlZ/s58M2VMMVNeHAiuDOm6/+wCbXu22mSps8
        wnPaR67hFjt1jZnTfktHbkq6inxCyOc57oIqDDU=
X-Google-Smtp-Source: APXvYqxDeNI60I9aNBcmjRlevGT/gLeQhWXzYEQUT+Su8gr56d6E8avrSOCWGMb+w2Xu/NgvvRBlqNHZe9SoV0Zqyr0=
X-Received: by 2002:ac8:140c:: with SMTP id k12mr47339337qtj.117.1577683304111;
 Sun, 29 Dec 2019 21:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20191227024156.150419-1-shile.zhang@linux.alibaba.com>
In-Reply-To: <20191227024156.150419-1-shile.zhang@linux.alibaba.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 29 Dec 2019 21:21:32 -0800
Message-ID: <CAEf4BzaKz9CiJh5FVn8+Mg2K+nVJ5RBfZmz6X0C0LH_dcdt0bQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Use $(SRCARCH) for include path
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 26, 2019 at 6:42 PM Shile Zhang
<shile.zhang@linux.alibaba.com> wrote:
>
> To include right x86 centric include path for ARCH=x86_64.
>
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> ---
>  tools/lib/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index defae23a0169..197d96886303 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -59,7 +59,7 @@ FEATURE_USER = .libbpf
>  FEATURE_TESTS = libelf libelf-mmap bpf reallocarray
>  FEATURE_DISPLAY = libelf bpf
>
> -INCLUDES = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(ARCH)/include/uapi -I$(srctree)/tools/include/uapi
> +INCLUDES = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi

Is this breaking anything at all right now? I just tried removing
arch-specific include and everything still compiled successfully. So
maybe instead let's just drop arch-specific include path?

>  FEATURE_CHECK_CFLAGS-bpf = $(INCLUDES)
>
>  check_feat := 1
> --
> 2.24.0.rc2
>
