Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7EF3B144B
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 08:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFWHAL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 03:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhFWHAI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Jun 2021 03:00:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11205C061756
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 23:57:50 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p7so2350122lfg.4
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Li+V/nl0cjsmLCz3l8a0QSOYRkjhsF2wxz4QKN56JeA=;
        b=i5fK+QNObEpMsmez8iNU9Z7+pSSG5iVFOyr20YhUpBF/j/ptXb6Jl9lDNI9g4LPKf/
         j7vHCw4red5E2ujeVTez80m3wnMzA1xhbKuANkDeF6ePQasvLZBZpB2YUWCaN54JfwbY
         amBVPmqmKWeF+r2b6lMgrtY7CGPffoV8Ddds+dIZjtGiTZSYZbNRIbC42fZNAJU8rBTm
         +8TW9yfSd1M9Yx6f+TpPLvdsjDvDe2eqT8SYw5YSQgmXxNPtLG6CsigqhTFoSKc30gMR
         1fi4NSA24FGOfsPs/9CjSXdcSFkykXfGAj9S8w+0dQUwVGkNtPYN/mXdJDACkZHYG7b0
         9jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Li+V/nl0cjsmLCz3l8a0QSOYRkjhsF2wxz4QKN56JeA=;
        b=iuDRpGREl8CTT6tqCIUcfxjFlRrpDRWwq3+XjpTeVQAAtBQcgy3Z7qNksrwS23y03I
         /NnfrBviF4KHFhv9XTjknEHy0nYzfyo3IVP13djLtRVSImEQKe8JcJ4KPZArrjFpEJ91
         SK32w337crR+GcHJx9XxLeDLUqVOBgeIKKWKxi8lmSROO4KFQxQ2zSfR/5tYckLPQKPQ
         mADFxz8AlhZP1nu+x/TenPejXtVVUQHiYZeHSB6njm1B89eGY+aQMYpLAwu4qTJWrxWB
         x0lCi1GOvqSRhgv+JHl1uvAmx3lwrfx/tv+CejKv9CD4VddSKd1MLza285nB3qHpmFNb
         XK/g==
X-Gm-Message-State: AOAM5302cKKa+EWbnpzoirnQzjHvQIKCTQL1kuL20DkzJg0HxAM3JvsF
        yWa0RmVyXsY+MLL0u0SUYeKdIA==
X-Google-Smtp-Source: ABdhPJwh+g+jkKtyGUasqYD3sa5fnzHls6A7Kp/p8RCTaAEbbEXm6SoOV1s1BrRUZQUekxjrJrq0sQ==
X-Received: by 2002:a05:6512:320f:: with SMTP id d15mr6148126lfe.266.1624431468426;
        Tue, 22 Jun 2021 23:57:48 -0700 (PDT)
Received: from localhost ([45.137.113.63])
        by smtp.gmail.com with ESMTPSA id i26sm2311248lfv.164.2021.06.22.23.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 23:57:47 -0700 (PDT)
Date:   Wed, 23 Jun 2021 10:57:44 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Gary Lin <glin@suse.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Martin Loviska <mloviska@suse.com>
Subject: Re: [PATCH bpf] net/bpfilter: specify the log level for the kmsg
 message
Message-ID: <20210623065744.igawwy424y2zy26t@amnesia>
References: <20210623040918.8683-1-glin@suse.com>
 <CAADnVQLpN993VpnPkTUxXpBMZtS6+h4CVruH33zbw-BLWj41-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLpN993VpnPkTUxXpBMZtS6+h4CVruH33zbw-BLWj41-A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 22, 2021 at 09:38:38PM -0700, Alexei Starovoitov wrote:
> On Tue, Jun 22, 2021 at 9:09 PM Gary Lin <glin@suse.com> wrote:
> >
> > Per the kmsg document(*), if we don't specify the log level with a
> > prefix "<N>" in the message string, the default log level will be
> > applied to the message. Since the default level could be warning(4),
> > this would make the log utility such as journalctl treat the message,
> > "Started bpfilter", as a warning. To avoid confusion, this commit adds
> > the prefix "<5>" to make the message always a notice.
> >
> > (*) https://www.kernel.org/doc/Documentation/ABI/testing/dev-kmsg
> >
> > Fixes: 36c4357c63f3 ("net: bpfilter: print umh messages to /dev/kmsg")
> > Reported-by: Martin Loviska <mloviska@suse.com>
> > Signed-off-by: Gary Lin <glin@suse.com>
> > ---
> >  net/bpfilter/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
> > index 05e1cfc1e5cd..291a92546246 100644
> > --- a/net/bpfilter/main.c
> > +++ b/net/bpfilter/main.c
> > @@ -57,7 +57,7 @@ int main(void)
> >  {
> >         debug_f = fopen("/dev/kmsg", "w");
> >         setvbuf(debug_f, 0, _IOLBF, 0);
> > -       fprintf(debug_f, "Started bpfilter\n");
> > +       fprintf(debug_f, "<5>Started bpfilter\n");
> >         loop();
> >         fclose(debug_f);
> >         return 0;
> 
> Adding Dmitrii who is redesigning the whole bpfilter.

Thanks. The same logic already exists in the bpfilter v1 patchset
- [1].

1. https://lore.kernel.org/bpf/c72bac57-84a0-ac4c-8bd8-08758715118e@fb.com/T/#mb36e20c4e5e4a70746bd50a109b1630687990214



-- 

Dmitrii Banshchikov
