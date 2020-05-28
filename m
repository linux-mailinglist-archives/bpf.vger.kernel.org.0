Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADA31E6992
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405898AbgE1Si4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 14:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405894AbgE1Siz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 14:38:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FD4C08C5C6
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 11:38:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z18so34645498lji.12
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hUnvlYB0pF+QMK1+vF+Btmnp5WWUAGUny9kz/UrsQo=;
        b=Bp2uVYiPA6mVXNK4rbio85j384P6Slz2GMBsVf3b1nt3fcGmxfbvJquo6zVj5DxtsZ
         44s5Q8sT/HXPVu3jlHnv2xLCJ/hIUEiSOP1ilVw9hs3h+8AuT8VMiJS0AeQikpVcEE7+
         MvZsol18Xh1VY6EawtoM/V3ATV6kua67NKAQmOyCCQ4P6u/mTN95yVlTCPPBinAJW4bp
         xG5Yu7El39SdufLeNR45EeGN/+5gXPxmCucLy3ylPdmWFNTvgR98mZO7pUIuuuUfJvEa
         icJey2ZYyeUvqyg4Pygl14iOKb8gjjQK012C443HAsnJBp9rIE/7Y49IeoK5d06lhA+Y
         +Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hUnvlYB0pF+QMK1+vF+Btmnp5WWUAGUny9kz/UrsQo=;
        b=gL9HDlQTTuG1001zt3NXKfLOw2BEEMkhK0MxKXwmZiVY7nNUpgdVwxzxuKkAzSlFIK
         kmhyWpPP/ov5ozq09yFeiddwvWgKACGze/EpiJDc/AzyCDRFxcnnrUwWYbbFVs8Tcu08
         d62sGMyQ7x+gD3uSyCP2qJN23LRWMp8Vg2LxBh1u/R688p9FkaLiS4GzMu+ZTYwI3fAN
         43PcMX2MCtHejT9Sw5YgSDuxkIcwsSBnD3fV8gHLtaYyjitjLum3hbL2EXCGRfSHSkHC
         MC2m3Bm53XTPFYjtfxtVDtKAyqxOgvrpV1vQwqV4UhTdPBeFoGrgI2MosrX1jlW6xEMQ
         FINA==
X-Gm-Message-State: AOAM530tm3pxRlu0jxUv9T9MppBPdsDUnnor1owHQOGxiPDFJUZLlUbA
        fcb6ozd2WnRh2+FxLh8f++5ycVRFxlzNLsLCgIg=
X-Google-Smtp-Source: ABdhPJzUSDWPyKjOHM1X4R6MEado0l70nGDOVf/HB3VhYYSVDnUNUeCxIVgpCvE4ZCINP0m7giUn/Snw8mDr/PQ+4mg=
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr2285156ljj.121.1590691133207;
 Thu, 28 May 2020 11:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <159057923399.191121.11186124752660899399.stgit@firesoul>
 <CAEf4Bzavr2hLv+Z0be0_uGRfPqNsBKAsQL7MpQUoXQX46rj4eA@mail.gmail.com>
 <20200528090842.6fb4e42d@carbon> <CAEf4BzZ0L=J9PbYndB4rFLvBEnZR6opUppDnD=b9BXsR2AR0cQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ0L=J9PbYndB4rFLvBEnZR6opUppDnD=b9BXsR2AR0cQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 28 May 2020 11:38:42 -0700
Message-ID: <CAADnVQJorSsnhGef5_Nfdwe=G2XP2LXdetNRqCKpjJmkKhSN7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2] bpf: Fix map_check_no_btf return code
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 28, 2020 at 11:21 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> My biggest grudge with changing error code is that old error code will
> still be used in older kernels, so if libbpf were to help users with
> more helpful message, it now needs to support both error codes,
> forever, potentially depending on kernel version. This constant
> splitting of logic is annoying, so I'd rather avoid it.

+1.

I think what this patch is trying to do is to fix strerror() lack of
understanding of error code on the kernel side by changing
the error code.
There are plenty of similar places in the kernel.
I think it's better to fix strerror via wrapper that understand kernel
error codes.
There probably will be more than one such ENOTSUPP error.
