Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A7D4D7152
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 23:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiCLXAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Mar 2022 18:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiCLXAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Mar 2022 18:00:21 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCC33668E
        for <bpf@vger.kernel.org>; Sat, 12 Mar 2022 14:59:14 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id m2so10687412pll.0
        for <bpf@vger.kernel.org>; Sat, 12 Mar 2022 14:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1psd4Vkpz9OA+otnRMCaa+t8sMhK2xQBTgO7p8yr7lQ=;
        b=NFSWBkIApqc03xIkUbnfzGM13Varjl0e1Qw8lZi2uQ6LzFrEfknYZP+9C0iFqdg2JS
         8A0CQm0MrGDzZm1R0It7/UX9PSeX6wGBRJbjBO065OZ4Yg+qBEfPu0VHQ6y9Oel8S8W3
         3wiOOcj3PzlMMJrgWWLCmriLxrrtPPJDlDBsZcHV19feqBzw9dIntYwvnr7pbk5U/cGH
         l8xR/lTaH5EmU0JGFEqTMy8uq3xbNb3w21z0zffu/v1fgPIRQ6Mq4Rah8YBV40cWitk/
         KXTvBsycu+8vuuLnkp1Md9SPBB5UQRu+zRq4DHPmzsx4mSGKVYRKVHnXA4InTZyO4vQb
         SIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1psd4Vkpz9OA+otnRMCaa+t8sMhK2xQBTgO7p8yr7lQ=;
        b=tLWTa31dOwZI5K5rVK91jKG91KsciQeXLa81gz/ZYkG0DlUAVsUFE4tXMB0DeUCR3D
         OSXBrK3Zle62BAKJemFxtfz7B/Ka3tqvqw+YAh4mgRCqKaHkZbTtE/IW5dfj9Pzak2Jg
         46SFvkgtrvZVAJj1kMsQdb4cPvOyZiEeoNU5gKMQ5J9GFlFHA6vGv/qql1EDums/QSW1
         CWQmHMZhVVo6C1LslfpAivFMs4l28TwOhA0wuMPmVOUlVr8EDi+Hx65UW0+COXSRufvA
         63cMtIDRcTkGYY1wqiMLmPoAlKCHfqB5QygM3vn7ew9nQTAArIkfd/U+9ly93fgqDGff
         ysdw==
X-Gm-Message-State: AOAM530Uj+ndIpminVxTOlrdghpw8aTafibKo3eU6nC62u0raGOMWuhl
        f3pZP923tJVqgT9pKY1K0yvBbjelxE+O4Fm/jWp30Q==
X-Google-Smtp-Source: ABdhPJzIygGy2PDIX8lbUKue+5Pn6mKRWGULwllNAv0jJpVrh+eu44mBuD7C3SeSuX/KMkkbVbimGjRpPJn34DdEj+c=
X-Received: by 2002:a17:902:d482:b0:151:ef7f:f5aa with SMTP id
 c2-20020a170902d48200b00151ef7ff5aamr17080512plg.58.1647125954051; Sat, 12
 Mar 2022 14:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20220309163112.24141-1-9erthalion6@gmail.com> <CAEf4BzZJ1DBuhHi400ObWoEQA7nLMT8TD4cVmhea_g4tdRFzoA@mail.gmail.com>
In-Reply-To: <CAEf4BzZJ1DBuhHi400ObWoEQA7nLMT8TD4cVmhea_g4tdRFzoA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Sat, 12 Mar 2022 22:59:02 +0000
Message-ID: <CACdoK4Kviw5UiBCgP=3PFGRippmP1U3yXp-9vM8WwAB_-aRmeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6] bpftool: Add bpf_cookie to link output
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 11 Mar 2022 at 22:25, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 9, 2022 at 8:33 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> > BPF perf links") introduced the concept of user specified bpf_cookie,
> > which could be accessed by BPF programs using bpf_get_attach_cookie().
> > For troubleshooting purposes it is convenient to expose bpf_cookie via
> > bpftool as well, so there is no need to meddle with the target BPF
> > program itself.
> >
> > Implemented using the pid iterator BPF program to actually fetch
> > bpf_cookies, which allows constraining code changes only to bpftool.
> >
> > $ bpftool link
> > 1: type 7  prog 5
> >         bpf_cookie 123
> >         pids bootstrap(81)
> >
> > Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
>
> Quentin, any opinion on this feature? The implementation seems
> straightforward enough. We'll need to not forget to expand the support
> to other types that support bpf_cookies (and multi-attach kprobes and
> fentries will be problematic, potentially), but this might be useful
> for debugging purposes.

No strong opinion. I'm generally in favour of adding more useful info
to bpftool's output; I've not found myself in need for the bpf_cookie
so far, but if it's helpful for debugging, then it makes sense to me
that bpftool be the tool to provide the info. The change looks clean
indeed. Agreed also that this will require us to think of updating
bpftool when new types gain support for the cookies. What would be the
problem with multi-attach, the kprobes/fentries would have several
cookies?

Quentin
