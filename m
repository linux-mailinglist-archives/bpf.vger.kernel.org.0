Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078FE68F495
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 18:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjBHRbj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 12:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjBHRbc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 12:31:32 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BEB4F84E
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 09:31:31 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l12so12572209edb.0
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 09:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Miev00N3jyviXEWVulW1zpx2DqSLhsF+0vVHn1UCcE=;
        b=S2F0gGJvVNpnEMLu8YX+fH9iX4P4FqdND4l42c19tbffpMkgeo7qDbnirWHVkAZ6MA
         3rJ6kwy7Y405x0Gk1VU7iyI8LCqtYCGlbBjZR/0GrhSf8EYBACJ+X/KMmiR6ENUJ5hEl
         eu03SN9l+NT+hb9KfaIIBeapuFm+WO4IyY1vB1WY1zLgVUEY/e3sHbPTXpFnbNht9iL7
         5kD74mFGXTFY9eiJ3dpnIw+e3sd0cKETy7O8qtmB6LMkfTSx1FV/rGt3AFYPwCtEBd4H
         ioDO4ytfEHMq7f1hXxsWJUHV3dPgza515+U316HLsJiIKbRk6AYnF0a3n23eljfAB65L
         h7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Miev00N3jyviXEWVulW1zpx2DqSLhsF+0vVHn1UCcE=;
        b=ROT25iD4E2+GeUuzIYteM8RE96aghEZB9gbk2eAsoTyMiaWMb5bPJI3ocpjL6io0/k
         hPM1nKKWHxhD0jXjzhXJoHG2+9W7XzJ8Lyl+bVHKzzNkBsajrXMPfM5cuE6Tj8vkNAF+
         p7yJaK7dkEV+l3jryrhzj82wO+qhUvpHGj6fa2GDWpQA9yh+lf8f1IihSgJpkWMpBJ1k
         6sStNSF0AZQd4PlZjOv1qShX8FbCNA6ZMmLezL40hNpum5iLzjtSMdbaup4sRG3yAOQJ
         6laewXDH4aJq61FfNirs8d6Rk5t1JxtJKZPeAsKHbLZsJQbA0eVEy/rXfrkU6/4ysmn9
         SDMg==
X-Gm-Message-State: AO0yUKXjGrZKLVUaTmXhB7UGTqn9qNZcmBkJesi59tzT+N+G29z/Ahbm
        J/kpegXlgWGNVKlZ5WDg4h+8RIc3sAU6oL8dArrhnmgy
X-Google-Smtp-Source: AK7set/HZCfWHHRiolvaX2R08Lyi7vW4qxN20bcLvPUd/ONxPyyZVeCs3mYgcXNBUhTcWVgATQxrL6NvcwY87BWRibo=
X-Received: by 2002:a50:9e07:0:b0:4ab:15d8:7282 with SMTP id
 z7-20020a509e07000000b004ab15d87282mr484108ede.3.1675877489669; Wed, 08 Feb
 2023 09:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20230206191647.2075-1-dthaler1968@googlemail.com>
 <Y+O7b5iKBUpskWLg@maniforge.lan> <PH7PR21MB387847C84B7D6DA43607692DA3D89@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB387847C84B7D6DA43607692DA3D89@PH7PR21MB3878.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 8 Feb 2023 09:31:18 -0800
Message-ID: <CAADnVQ+hgqw4fL8Vvq7GkP8VkO3wvFbhVD-LFU+h9-8vQC+0RQ@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Explain helper functions
To:     Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc:     David Vernet <void@manifault.com>,
        Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>
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

On Wed, Feb 8, 2023 at 9:26 AM Dave Thaler
<dthaler=40microsoft.com@dmarc.ietf.org> wrote:
>
> David Vernet wrote:
> > > +Reserved instructions
> > > +====================
> >
> > small nit: Missing a =
>
> Ack.
>
> > > +Clang will generate the reserved ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d)
> > instruction if ``-O0`` is used.
> >
> > Are we calling this out here to say that BPF_CALL in clang -O0 builds is not
> > supported? That would seem to be the case given that we say that BPF_CALL
> > | BPF_X | BPF_JMP in reserved and not permitted in instruction-set.rst.
>
> Yes, exactly.  I could update the language to add something like
> "... so BPF_CALL in clang -O0 builds is not supported".

That will not be a correct statement.
BPF_CALL is a valid insn regardless of optimization flags.
BPF_CALLX will be a valid insn when the verifier support is added.
Compilers need to make a choice which insn to use on a case by case basis.
When compilers have no choice, but to use call by register they will
use callx. That what happens with = (void *)1 hack that we use for
helpers.
It can happen with -O2 just as well.
