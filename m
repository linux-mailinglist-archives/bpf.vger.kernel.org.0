Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDDC5B0C5B
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiIGSQD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 14:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIGSQC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 14:16:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEF09C23C
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 11:16:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lz22so11395727ejb.3
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0AhUs+ZF6YL0YnaxavPuj29v6rZ71SuC1+lY5vlY+IE=;
        b=kTg51TWyjPKaD8ZlDy5nRgSbnELJGnns4YPJd6fHqoRTbtstF938IpvywpGskwMwEo
         4E6MO4QQve/otI1pG81uqE0xqeYnPkWOfzh9aOSnGjHnxSltb3WwkxtlGNVdKZybAX1e
         e1iBlI1NtRC8irvn2/vO/N32z6aqNcYN2d/yXK5TVK6sT0hGWaz7s6+DDi/vC6h87gQO
         wR/378JNOMSW0JVgHnDRP42LHD0SdGQGm307ZYp13gueWF02/on3umc1yQRC3iMb+Kya
         EgjWiiOEGVXzMZTI7Qr0Bqjk32XpH0UM4fWGH53by5rxuEitlveMhN8tIlzNIZuPtH5+
         K7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0AhUs+ZF6YL0YnaxavPuj29v6rZ71SuC1+lY5vlY+IE=;
        b=y3Bl/TQEobPguSIvOKI/6c9ZBzdpijp4tjziXGURTXsyteOTHetAY08AVnZ8elhmop
         YyHREvaXRU1YqcI0T22TMiry3KL3c/0iPPkraPKI3KDtZ1DMYlE4CL/4G/T+7ZSJ/xKM
         18VyPRkIl0Npi6UgKjWdaUz3Bss15UD1bvUfGCyedqQx9MvBXHTv8TYvy1vRleoTV2iD
         SaS17N7XOOKHpMbBpSjMhcfjbOh5h6ns90YDkYJjbX7e5CVa94l3STJhWaFM1kbiR3sC
         N28L2aTvnzdVJsxlM6+KOprH1OMS+ebk227YGSmWr9tWpBu1jBirrNQMJMTjiCjV2jeL
         LhBg==
X-Gm-Message-State: ACgBeo1A/93F66bmteKN6heiLvHCpaIkWv4gJoi+D5seSZJOYYq1ZN08
        7sYjaErKvSCO/JI2C8EOLV7CS0Ki3STqXveGyyM=
X-Google-Smtp-Source: AA6agR4rRQQ71afEyF1tGyYsS5zd1ZJ5Nh9XiV5f7PNT/uE5PN3/Gd28aspOxrAkGHthznXPel+u6r2yM1TaDI6Fzao=
X-Received: by 2002:a17:906:dc93:b0:742:133b:42c3 with SMTP id
 cs19-20020a170906dc9300b00742133b42c3mr3323770ejc.502.1662574560244; Wed, 07
 Sep 2022 11:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <Yxi3pJaK6UDjVJSy@playground> <CAP01T77wGxv5aTf=Wwwn79jHMrTuv+Wr9Y8b8x1244tQUBxCyQ@mail.gmail.com>
In-Reply-To: <CAP01T77wGxv5aTf=Wwwn79jHMrTuv+Wr9Y8b8x1244tQUBxCyQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 7 Sep 2022 11:15:48 -0700
Message-ID: <CAADnVQJE+D2jGEa0PSWVbtn50TvkyvdHECkHwxfuyNJk_KcN0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix resetting logic for unreferenced kptrs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, Elana.Copperman@mobileye.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 7, 2022 at 8:58 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, 7 Sept 2022 at 17:24, Jules Irenge <jbi.octave@gmail.com> wrote:
> >
> > Sparse reported a warning at bpf_map_free_kptrs()
> >
> > "warning: Using plain integer as NULL pointer"
> >
> > During the process of fixing this warning,
> > it was discovered that the current code
> > erroneously writes to the pointer variable
> > instead of deferencing and writing to the actual kptr.
> > Hence, Sparse tool accidentally helped to uncover this problem.
> >
> > Fix this by doing WRITE_ONCE(*p, 0) instead of WRITE_ONCE(p, 0).
> >
> > Note that the effect of this bug is that
> > unreferenced kptrs will not be cleared during check_and_free_fields.
> > It is not a problem if the clearing is not done during map_free stage,
> > as there is nothing to free for them.
> >
>
> You're still missing the fixes tag right before your Signed-off-By.
>
> Instead of
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
>
> It must be
>
> Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Added while applying.
