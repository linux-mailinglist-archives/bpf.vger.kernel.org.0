Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61C31DC57E
	for <lists+bpf@lfdr.de>; Thu, 21 May 2020 05:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgEUDNA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 23:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgEUDNA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 23:13:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858BCC061A0E;
        Wed, 20 May 2020 20:12:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m12so4063094ljc.6;
        Wed, 20 May 2020 20:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4w0EkZBcNC3I1R8tbgMmRIZQyQCAyGziqLkw7YCEjc=;
        b=gWnBYZb3onOFrzELuM1INXXs0nCvU8m+5CTkmIoEEz9dzfUaZz22FVdxFCFRJlwF9S
         E7cLYf54O14YKC/OGnn8wcDpLT3KSunrgp7Uxn6j8FgU4N3vcLE3nQixkXDPx9yjC/OU
         ZHgug6gAKpBPj+Wg+i3Ffj1GlARsGF6Jl+WLkittPFW7+/mJOWCBv9xSEzLdH0lauqgG
         +pQ+2HE7r1vnJ6wYYJdO51yAWAZLS0IWNsW6NKouFCNkFNv2DD0nqFWAhI8zwg33JrqR
         4fH+nCwyiUZ2XHVf9/Z2OkgI1NlOMBZrYS+OHpdvgCaMFyX3zsL/MYs5eWAidEN1qgk7
         yYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4w0EkZBcNC3I1R8tbgMmRIZQyQCAyGziqLkw7YCEjc=;
        b=nMQHG1PxmZjCOz+pI61gwsw7l404H2ho+pWzIWnpM/oJT1ayYLQFo5zReXpllx2JS8
         hAhWHwCC8jUEWwJld2vdzJRd3tQL+iwmSER+7Z7BnsoR0OFTJ0NcjTIHRJahVJQdK0IK
         8mQdTjS1kSI7jMnz99eCIILIzQdfA5RQMOX04a6Jw/vuV+5qDQqOWQdI2ScmaFXtFjUS
         i+XhYghF7L9FkvMKulsiLjtyrcT5QtiBBEK2O8PQlQl3zj07nEXw8dIuijUL5wPVCiFV
         R7cIsXskEttIGrfxZ6r1Co+uu+V6CxN/MAoy7AbM5xav6gT1N/+mdvj8yIN1zvycKyJJ
         39nA==
X-Gm-Message-State: AOAM530G6Hhf7M6ahyHLLZlKS6rtVA9Q8iycoygEjyyWht2JsqLjpcjk
        ngFiAwK4sz1uZLpmHjw4UazI9MJau+Jouk6uBQo=
X-Google-Smtp-Source: ABdhPJxLA2patLywIkWv3BWBro2GnAYR+4B7stOdBJVWlU/h2QfV+fKcWnOXSTMdOMdE+WFjadzsXFAFHXzQy0Ankj0=
X-Received: by 2002:a05:651c:2de:: with SMTP id f30mr2024329ljo.450.1590030777589;
 Wed, 20 May 2020 20:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200520125616.193765-1-kpsingh@chromium.org> <5f540fb8-93ec-aa6b-eb30-b3907f5791ff@schaufler-ca.com>
 <CAADnVQL_j3vGMTiQTfKWOZKhhuZxAQBQpU6W-BBeO+biTXrzSQ@mail.gmail.com> <alpine.LRH.2.21.2005211201410.2368@namei.org>
In-Reply-To: <alpine.LRH.2.21.2005211201410.2368@namei.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 20 May 2020 20:12:46 -0700
Message-ID: <CAADnVQLFhSTVQ_ArMaQdABD6A4goiw6wx-d_KyJUFJRfcSMC9A@mail.gmail.com>
Subject: Re: [PATCH bpf] security: Fix hook iteration for secid_to_secctx
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 20, 2020 at 7:02 PM James Morris <jmorris@namei.org> wrote:
>
> On Wed, 20 May 2020, Alexei Starovoitov wrote:
>
> > On Wed, May 20, 2020 at 8:15 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >
> > >
> > > On 5/20/2020 5:56 AM, KP Singh wrote:
> > > > From: KP Singh <kpsingh@google.com>
> > > >
> > > > secid_to_secctx is not stackable, and since the BPF LSM registers this
> > > > hook by default, the call_int_hook logic is not suitable which
> > > > "bails-on-fail" and casues issues when other LSMs register this hook and
> > > > eventually breaks Audit.
> > > >
> > > > In order to fix this, directly iterate over the security hooks instead
> > > > of using call_int_hook as suggested in:
> > > >
> > > > https: //lore.kernel.org/bpf/9d0eb6c6-803a-ff3a-5603-9ad6d9edfc00@schaufler-ca.com/#t
> > > >
> > > > Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> > > > Fixes: 625236ba3832 ("security: Fix the default value of secid_to_secctx hook"
> > > > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > > > Signed-off-by: KP Singh <kpsingh@google.com>
> > >
> > > This looks fine.
> >
> > Tested. audit works now.
> > I fixed missing ')' in the commit log
> > and applied to bpf tree.
> > It will be on the way to Linus tree soon.
>
> Please add:
>
>
> Acked-by: James Morris <jamorris@linux.microsoft.com>

Thank you. Done.
