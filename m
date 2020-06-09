Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31C11F44DE
	for <lists+bpf@lfdr.de>; Tue,  9 Jun 2020 20:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388459AbgFISJN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jun 2020 14:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbgFISJH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 14:09:07 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC44DC05BD1E
        for <bpf@vger.kernel.org>; Tue,  9 Jun 2020 11:09:06 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z206so13055596lfc.6
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2020 11:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogBASi6iUFg7q2fB38qT1Thf4pCew1r3vqCaWc789jc=;
        b=E2Ejh8mYblCco8jvn54oVOfPF3EuLAReZh1lZi1cONOuTVYDZHLA9on62jEWgbQPbK
         9h5G3l6QSi8YqephB02Rg3UkHUvSc8EJbEB4XKmA+6NHlEa6YH2Qu5mk8f3671mZxWtY
         aEDLVtP+iPLH60fVu7cl/8XRsrL/zxYzmFujFyF1/r3BObmOlQGPGPybG4CF45ZtgtEi
         3nKguWrBWt5VSfC/ya26SEtThnwkK87BrVe9dEM2v0EbnFCPxkNeTA063Mkl+1gqaNCx
         hSrRWmuKHTkKnHDmh/juFxVXtmlMm0s6Ir78vkDAj7pfk9fYtwxTRmmIideYB12h9+D+
         MwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogBASi6iUFg7q2fB38qT1Thf4pCew1r3vqCaWc789jc=;
        b=AoavWRgOkOgGWsvOWKPB/8LbjMiwUl0oUShzdwup+RZnOQ1j84Trib1zoemSt9qHjo
         l4u3aikQUNRuibmZyvS899kFBZGC7lArh+dXuV8m5BKDfvu0U6VMD7fT9Qmt9cox8tkO
         /RavyBbRltCwIraRJrnUpHnJSfS6rmlw3/sVLozp+XTFxCmQ0YC8PkNT5SGsH93aGsDp
         hupd3WKiAzU1PRBJWbTJFbeSvfgd8d1ffPm/cfXvVK7emh8wI1pE3LYV9pGWcNtCjJS3
         t/qMPzsq8uwGTu0a5SJ/6zcJdKuSzhBTyEQSXu7QVkCnSoeFifeJ+58S7Rhz99y2XXTC
         FHzw==
X-Gm-Message-State: AOAM532jwG4Br96gdmLFgjlb+KbqDwa2QwDi3kxYenUTqRnzKX11Vdpl
        iySWZx0cqDeFcuR+fmm8F2OUM1sv/oJ8LsxaJV0=
X-Google-Smtp-Source: ABdhPJytOTFrDOf7MTo9mE6F9eX6j8PXNDIKUc38o4iGPhND0wzmemGSruXk2AQtvE32ACJqWRvYfW+WRmJenksFKAg=
X-Received: by 2002:ac2:5f82:: with SMTP id r2mr15802293lfe.119.1591726144918;
 Tue, 09 Jun 2020 11:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200608094257.47366-1-lmb@cloudflare.com> <3318a5fa-e4c0-67a7-0d69-9eb16d397f73@fb.com>
In-Reply-To: <3318a5fa-e4c0-67a7-0d69-9eb16d397f73@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Jun 2020 11:08:53 -0700
Message-ID: <CAADnVQ+BR5kZOZwMqcbF=yp2kZA_jpmN_F215AHYm8oWfG-4Lw@mail.gmail.com>
Subject: Re: [PATCH bpf] scripts: require pahole v1.16 when generating BTF
To:     Yonghong Song <yhs@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, daniel@iogearbox.com,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Ivan Babrou <ivan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 8, 2020 at 10:33 AM Yonghong Song <yhs@fb.com> wrote:
>
>
> On 6/8/20 2:42 AM, Lorenz Bauer wrote:
> > bpf_iter requires the kernel BTF to be generated with
> > pahole >= 1.16, since otherwise the function definitions
> > that the iterator attaches to are not included.
> > This failure mode is indistiguishable from trying to attach
> > to an iterator that really doesn't exist.
> >
> > Since it's really easy to miss this requirement, bump the
> > pahole version check used at build time to at least 1.16.
> >
> > Fixes: 15d83c4d7cef ("bpf: Allow loading of a bpf_iter program")
> > Suggested-by: Ivan Babrou <ivan@cloudflare.com>
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

Applied. Thanks
