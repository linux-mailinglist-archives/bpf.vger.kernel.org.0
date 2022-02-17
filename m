Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551704BA93D
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 20:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiBQTHr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 14:07:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244987AbiBQTHq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 14:07:46 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050368567B
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 11:07:32 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id s1so4852047iob.9
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 11:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TpKXjcc9BaA1pqX9YdThVlYucA/Xk9TNVNtnkyOAuI0=;
        b=GWL0PAbz24RBtIxUCOsAr302ucCGAMjTyOeVYOqri6aVuL/ZnHzW/CQj53j5QaySeA
         ABrgkEUgnmmrK25icyFHg0ih8/noHJIxGoaL/dciwDQMHBULOqtbq4ObyZSK5Z9mkP41
         jm8jRsdyMGHNdfKBUVkgHFBw+yADA/a1u992WulYps5uxWNvg5BqN9ZA5/eETnq0dsD+
         d2fQIqXuMdLhvggI330+mS8PA/Ut6UPJcVFcdSTZly1WcS7XxhwfEtoXDucQF1aXujyA
         xudj+icpImU8Se0fastlzKk6TQVt9h60Rkx9MVReewLgjhvAEAq3vt8Dj6tOWAVKw6sL
         FT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpKXjcc9BaA1pqX9YdThVlYucA/Xk9TNVNtnkyOAuI0=;
        b=1svyQf733h/0xgKe3V4DhUcb6PrEkUti37jg9hDNLXraO8kq8KykuQpIlL+8AIf0u5
         zytC2u8RBfZxzwIl23Vb68q+hsorUePL3k/eSSipX/+TYI9rRUbS+HFziWj9AURTzFEh
         kpeFShbgZCUT3O8gndKeBoZA2tp+fInzFLf445CmvSs19Nvnh7Unn266DazVi64sgubp
         aVFuz5n1RndcKGCpAVm5qqxv93LTA2HENh/z5g+lFNf61b424R56tHP6uz1dQ5l6ABRc
         yeszFONd5vD+Boh0bke97oWr/oluADh1xwAoDaDhx+SdxKCEjCqFu+hZxfQsjg90/B5p
         gmRg==
X-Gm-Message-State: AOAM5322xOTAeVOWMYnoLj55y7dAOoENKF34TCQnuj58Jg9krJQgqkk5
        Z81y0ONBscnmYJlT5jR3gS1iIeeUiVKeIlacvwk=
X-Google-Smtp-Source: ABdhPJwf86ugsOSaXDRKh4NVT28h+Pv82B8+caWV/T+yfXweSB6VE0Yv9qARwtbT1bmu7y1TJTWbuX7evx/M6hVlAIo=
X-Received: by 2002:a05:6638:1035:b0:306:e5bd:36da with SMTP id
 n21-20020a056638103500b00306e5bd36damr2988344jan.145.1645124851386; Thu, 17
 Feb 2022 11:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20220217180210.2981502-1-fallentree@fb.com> <20220217183253.ihfujgc63rgz7mcj@kafai-mbp.dhcp.thefacebook.com>
 <CAJygYd3m0_EkqD8DepPLX0rk48BO0TwHkqJ81KRfOvaygMg9_w@mail.gmail.com> <CAEf4BzZjCRt5OmrSem5MZCOJRo2Ghv2TR60w4kEphGWGDf7mxA@mail.gmail.com>
In-Reply-To: <CAEf4BzZjCRt5OmrSem5MZCOJRo2Ghv2TR60w4kEphGWGDf7mxA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Feb 2022 11:07:20 -0800
Message-ID: <CAEf4BzZHhjSrqqABuZgzVz8j+-qCbbU5GnzOuUpAQUqhLNazrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix crash in core_reloc when
 bpftool btfgen fails
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Yucong Sun <fallentree@fb.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 10:57 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Feb 17, 2022 at 10:55 AM sunyucong@gmail.com
> <sunyucong@gmail.com> wrote:
> >
> > > Should it be:
> > >                 bpf_object__close(obj);
> > >                 obj = NULL:
> >
> > No, the actual crash is caused by this line:
> > https://github.com/kernel-patches/bpf/blob/bpf-next/tools/testing/selftests/bpf/prog_tests/core_reloc.c#L896
> >
> > When run_btfgen fails, the obj contains uninitialized data and then
> > bpf_object__close(obj) crashes.
>
>
> Martin's point is that you have to NULL out obj so that on the next
> iteration this doesn't crash again. I'll fix it up while applying.

But I actually ended up replacing two goto cleanup with continue
(there is no clean up to do). And adjusted commit message to reflect
that. Applied to bpf-next, thanks for the fix!
