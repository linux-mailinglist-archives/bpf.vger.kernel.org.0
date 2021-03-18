Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44D2340FF0
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 22:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhCRVip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 17:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhCRVi0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 17:38:26 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B4BC06175F
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 14:38:24 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id l4so2366332vsc.7
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLPqaFCjOxJqP96ilPAU1cPfZQuKxpOHXRuDS0s7Vr4=;
        b=qKVpWtCjskEKfxSobzVob96NxKhzoHpA0zkVpey6v9nz5hqX4fwpWRs2r3Xv0LtQVY
         G16K6pLlLiiOgiA9WlvBYuNv+dkBxVQoBMTZmRC3drafHcUHKnQM/tG/M+cxNlkBKFlD
         6s0+yKEf1+/y0f7FoLfouj1leYGLXXX0BHvTCWQ+suw1xpi/HPjaWWJGI7rE5Zq4hjN+
         KeG6ltSdPXps4+kFCWvGrU0ia0VmTHM2GBqcg/2BbR/sCeCZJbCtvjlsmF4re7pImMHk
         IhFvMOnUBJEqxCQDOIJTiaQI5tXqy8l13Wdqav4qDmK3cuJjAHbGFKOiSQWrw4vDipzM
         ux1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLPqaFCjOxJqP96ilPAU1cPfZQuKxpOHXRuDS0s7Vr4=;
        b=ZG6qr7NiR9rzlZyl1aTPbhy9kft3vw5y2aVPtbmuGaBjnx+dQpXALqxufgdL8rs0d6
         O15C+1xL88R30GECGLr8upsEm6dYHcXt9zeAlChYtZNrLEvEkesBUzdUD73qS+4bntmL
         +kLL96ZuchsOUTtRFdX4/ppENpDJUqiXB/WnfbxP+GfAVvdFDQcqtiA9heix26+FgMJs
         wHGRLijbPTH6HEwjJS15EEC7qFu5Qru4SbE/2LHLsrBXOvtlgH+95BzEmSHnrAtQrmWg
         +oxMYKicxFj93QUJ8o7y9t4BSplU4Br3CE9I33C0kfCyFkKYaWFtyP2npYlggpcs4mHe
         sCgQ==
X-Gm-Message-State: AOAM533bPETMagacqxtiI2rtGZKfKZZMiw//Wb5uQXtv/iikK3UABvd/
        QmLaBRLSY+pRRzpRw489IPNo5KLCh80BQb8onjKfUA==
X-Google-Smtp-Source: ABdhPJyaMaWSU8mQS4gTjUoMCHt/hL7J7EWOKPoWt/RxfzbbDBNbfggOD5G6oZscrzSei7ViS8Oslpe0+7Gv7JZE5Pk=
X-Received: by 2002:a67:2803:: with SMTP id o3mr1141643vso.36.1616103503542;
 Thu, 18 Mar 2021 14:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
 <20210318171111.706303-6-samitolvanen@google.com> <CAKwvOd=fWs6g2Bf2a_bA58_-uoWtVmNQnvrPxNhio4R5qGjcMQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=fWs6g2Bf2a_bA58_-uoWtVmNQnvrPxNhio4R5qGjcMQ@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 18 Mar 2021 14:38:12 -0700
Message-ID: <CABCJKufa_-WSSYzHBSjZ+3i0DfvoGBox7Xa0PcE_Kuhf2rd07g@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] workqueue: use WARN_ON_FUNCTION_MISMATCH
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 18, 2021 at 11:50 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Mar 18, 2021 at 10:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > With CONFIG_CFI_CLANG, a callback function passed to
> > __queue_delayed_work from a module points to a jump table entry
> > defined in the module instead of the one used in the core kernel,
> > which breaks function address equality in this check:
> >
> >   WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
> >
> > Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
> > when CFI and modules are both enabled.
>
> Does __cficanonical help with such comparisons? Or would that be a
> very invasive change, if the concern was to try to keep these checks
> in place for CONFIG_CFI_CLANG?

The last time I checked, Clang ignored the __cficanonical attribute in
header files, which means it would still generate a local jump table
entry in each module for such functions, and the comparison here would
fail. We could avoid the issue by using __cficanonical for the
callback function *and* using __va_function() when we take the
function address in modules, but that feels way too invasive for this
particular use case.

Sami
