Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC866A5DC
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 23:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjAMWWq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 17:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjAMWWf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 17:22:35 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461C76EDB
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 14:22:34 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id l22so25807452eja.12
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NNYb5NkfBOA+DfBc9Yo7dVoTzKpHrIkvxnKcRHV9ytk=;
        b=GPJG8vQSmFjOd7BWfyy0kSl6E0jFggcCsDvfVpSmwQVXw1zcsRb3InmcOGH8Ty2PIn
         91iXXh6AaZdadwXchikHQra1MDWcIamqgC94HE1vpY8nf5LKKTe60MxPs4kCNbOqSNA+
         +u1No4IaCSTa39xaP3p3kBfXIt1Y1HMsYbrPDBRm1HgYZJDZg4jJoLriqDWzXYhBTwlO
         wVSYpL52s04riospd9Ec42JqiLbE7YtPw2HukprcFRLFE1iL5Bqz0ZkcS0dh2S6NtRav
         +A+yEf3s7D4e6LTWw/xpQu07TqSx05C9XCAd1kXdagZuD0F+JBOi95q+y0Rz6s51I6Q8
         uq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNYb5NkfBOA+DfBc9Yo7dVoTzKpHrIkvxnKcRHV9ytk=;
        b=ySS7jFQeze9b6ZryqLT8p3aLTzEwhcvYOtnw3nrXYLzYYiP61v02D8y1f5rNGvZE54
         0ohJqAu/jL/+wnt2ThhKzh9qTzieh7SpJAn8rAwY/JJJnPnsGcMnLFvpGY8t7V2Ljb+A
         q7uu2TQqo3b/kwBePDa2W0JCtpfDQLW+CPCBQauuTXwgxPDZlOKHWPx7IK5MJeYCNFgQ
         JWeHmf33rY10SONJjwFWeFAQhgRAbw+ZuhY5fqdYdmjrSvjNRbYE7X/fl+75lSFWL52F
         kfne3wHaHzTns3KCqGkFddkmUG4kXgu9upQzZOirfVKw/SgDKG637i4tTKV/jG9uWKrk
         Iv5A==
X-Gm-Message-State: AFqh2koAKdw8ZsMnJkMm1qSNuolmGB3roio3Ha3LQ0CEAiXAzVHtS2ex
        lzdpZ+PmIiMTk0Nvzo+N2OND0Nys1CrP/row/do=
X-Google-Smtp-Source: AMrXdXu0EeJ6f4Uho/ZD11ENoL4w586wFqjLEHd8+saP8s9kcHaTRVYyeWHJ7xugHeSuXW9zXi1Rc4aOZ7qUsLonSYk=
X-Received: by 2002:a17:907:9d0d:b0:84d:4d2d:1c5f with SMTP id
 kt13-20020a1709079d0d00b0084d4d2d1c5fmr1450015ejc.114.1673648553044; Fri, 13
 Jan 2023 14:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20230106142214.1040390-1-eddyz87@gmail.com> <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
 <e64e8dbea359c1e02b7c38724be72f354257c2f6.camel@gmail.com>
In-Reply-To: <e64e8dbea359c1e02b7c38724be72f354257c2f6.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Jan 2023 14:22:20 -0800
Message-ID: <CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 13, 2023 at 12:02 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2023-01-11 at 16:24 -0800, Andrii Nakryiko wrote:
> [...]
> >
> > I'm wondering if we should consider allowing uninitialized
> > (STACK_INVALID) reads from stack, in general. It feels like it's
> > causing more issues than is actually helpful in practice. Common code
> > pattern is to __builtin_memset() some struct first, and only then
> > initialize it, basically doing unnecessary work of zeroing out. All
> > just to avoid verifier to complain about some irrelevant padding not
> > being initialized. I haven't thought about this much, but it feels
> > that STACK_MISC (initialized, but unknown scalar value) is basically
> > equivalent to STACK_INVALID for all intents and purposes. Thoughts?
>
> Do you have an example of the __builtin_memset() usage?
> I tried passing partially initialized stack allocated structure to
> bpf_map_update_elem() and bpf_probe_write_user() and verifier did not
> complain.
>
> Regarding STACK_MISC vs STACK_INVALID, I think it's ok to replace
> STACK_INVALID with STACK_MISC if we are talking about STX/LDX/ALU
> instructions because after LDX you would get a full range register and
> you can't do much with a full range value. However, if a structure
> containing un-initialized fields (e.g. not just padding) is passed to
> a helper or kfunc is it an error?

if we are passing stack as a memory to helper/kfunc (which should be
the only valid use case with STACK_MISC, right?), then I think we
expect helper/kfunc to treat it as memory with unknowable contents.
Not sure if I'm missing something, but MISC says it's some unknown
value, and the only difference between INVALID and MISC is that MISC's
value was written by program explicitly, while for INVALID that
garbage value was there on the stack already (but still unknowable
scalar), which effectively is the same thing.

>
> > Obviously, this is a completely separate change and issue from what
> > you are addressing in this patch set.
> >
> > Awesome job on tracking this down and fixing it! For the patch set:
>
> Thank you for reviewing this issue with me.
>
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> >
> [...]
