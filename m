Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5B19136C
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 15:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCXOmT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 10:42:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39243 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgCXOmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 10:42:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so9357177wrt.6
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7vTrTxx0I42zw2BaG0USTFej0dtrrNyaNSAnPWYt9Eo=;
        b=dkufhUJ9zQgyP8eGpXezEO6a9c0CgpImFYcOb7SPCPnxkVXnUCf9MubJp0Db51xEiq
         qINGVez4sAiuIZTWVRXxyECGEj+Tt0lNCg0T/cuaWJn6rLAyv22itIBOF196q7ArZrkG
         Np68R2299lTO/aD1jrc6693/loNDi3KzSYUtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7vTrTxx0I42zw2BaG0USTFej0dtrrNyaNSAnPWYt9Eo=;
        b=UEke6bSNiFMhujp9+vZQVLJOI5q3aGsKZ5Du2Mohp0pdnh2tGDNDHZv7zSxN0WeuzQ
         G7zkXOaSTsElcK9dFu2pXCz607/T0X/q4giGgjXbrLwPuOtNQfWFv3ohpH1tTYa1F4u1
         0ZO1a4PyZLeGNR7xhaiyeus2t65GFnLqn+u2aeUGZbydZeF7dXF8vAtESMy4jE3P+dwQ
         JnA2dreeTKOQPU9PhLMvPJfXO+cAmWXLuUX+04JCujIvziAohSjBWqXJ74hkjuzxkUzO
         +qkPI6Q++chdT8RiwvU9pypjuIJymlloAWSnf/kyyClfz4/l8cKT/ZD2kYIC44QGiT1X
         ARQw==
X-Gm-Message-State: ANhLgQ0bWpRZyG0ZaZbt9UPdSvQ2OmgqeQ92qmrGeyEXagU2S4H54XV0
        /EmPadzRBFGF2TurksYweNusDA==
X-Google-Smtp-Source: ADFU+vvCgG3AatQ3uIwpMlAUCRa8G1ExnmSdd3Fbwn543GAsmTl1Hh4EBhFaLe+iPrfpcTl6xafpCA==
X-Received: by 2002:a5d:6888:: with SMTP id h8mr27440636wru.159.1585060937530;
        Tue, 24 Mar 2020 07:42:17 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id s15sm30790432wrr.45.2020.03.24.07.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 07:42:16 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 15:42:14 +0100
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
Message-ID: <20200324144214.GA1040@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
 <6d45de0d-c59d-4ca7-fcc5-3965a48b5997@schaufler-ca.com>
 <20200324015217.GA28487@chromium.org>
 <CAEjxPJ7LCZYDXN1rYMBA2rko0zbTp0UU0THx0bhsAnv0Eg4Ptg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ7LCZYDXN1rYMBA2rko0zbTp0UU0THx0bhsAnv0Eg4Ptg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24-Mär 10:37, Stephen Smalley wrote:
> On Mon, Mar 23, 2020 at 9:52 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On 23-Mär 18:13, Casey Schaufler wrote:
> > > On 3/23/2020 9:44 AM, KP Singh wrote:
> > > > From: KP Singh <kpsingh@google.com>
> > > >
> > > > The bpf_lsm_ nops are initialized into the LSM framework like any other
> > > > LSM.  Some LSM hooks do not have 0 as their default return value. The
> > > > __weak symbol for these hooks is overridden by a corresponding
> > > > definition in security/bpf/hooks.c
> > > >
> > > > +   return 0;
> >
> > [...]
> >
> > > > +}
> > > > +
> > > > +DEFINE_LSM(bpf) = {
> > > > +   .name = "bpf",
> > > > +   .init = bpf_lsm_init,
> > >
> > > Have you given up on the "BPF must be last" requirement?
> >
> > Yes, we dropped it for as the BPF programs require CAP_SYS_ADMIN
> > anwyays so the position ~shouldn't~ matter. (based on some of the
> > discussions we had on the BPF_MODIFY_RETURN patches).
> >
> > However, This can be added later (in a separate patch) if really
> > deemed necessary.
> 
> It matters for SELinux, as I previously explained.  A process that has
> CAP_SYS_ADMIN is not assumed to be able to circumvent MAC policy.
> And executing prior to SELinux allows the bpf program to access and
> potentially leak to userspace information that wouldn't be visible to
> the
> process itself. However, I thought you were handling the order issue
> by putting it last in the list of lsms?

We can still do that if it does not work for SELinux.

Would it be okay to add bpf as LSM_ORDER_LAST?

LSMs like Landlock can then add LSM_ORDER_UNPRIVILEGED to even end up
after bpf?

- KP

