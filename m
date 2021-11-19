Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAFD457641
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 19:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhKSSVe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 13:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhKSSVd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 13:21:33 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5627C061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 10:18:31 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i12so11025181ila.12
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 10:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=tdLTFdg3pJJF3nSm4KjNclgDVRbzhV6EnwREp6ueFTY=;
        b=lhfZJcd7yqAJ+yvZZWTnfrALDDiM0L3n1JHTxW5mRc5xfPrQtbgupYx57yed4UVluu
         bK9hn8b7f8WpP3QdHhJGBD402ylpiueZ1e1GPcdWU+eRgDhtpcWmpr/uCCfuW7HAt3F/
         Ztsh543LigI1IwGZn9Fk4g/H4DuaAM8RfjEL8o9GjZIT4tBjy2w7osN4jtz4PxpfGo4U
         oC+dGvu/ZyOXIlhKDKPC0byuLhhgC0koZsXNEsIIK/XT5iwlljaBq0fSZpoNfep5hxOZ
         nXuR6eHOSfrmMwwVIVc3zk/eS77rV4ZTcUzEqofJ/d9FzSKxAGELBoiokrOGvz4h8mGN
         LV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=tdLTFdg3pJJF3nSm4KjNclgDVRbzhV6EnwREp6ueFTY=;
        b=GuuWxDlSnMvUwuF24JAOtOqGtr5xHpwSuGWPLHj8w7GkAAFN9FMMJos3vGMefx4OlY
         +tZqvW8+Q3LKXt3EQIDZ/Vfw3ZXkr/tDTxp3wS5clGeXXzsjJX48McHgmQABREydaajy
         S2TdEmCQBj+cZ72f8IEdCSm0S99XbKpVZQnror3+a7R3QRvzAGKDsreDYz/MgmDgpazV
         rVv3OkQt/FFDja7vsTYj3NyBN7vUJzAyhj/U/ZO++kWx4U1h9Uh3RDBP4fI5iv0Y+tWS
         MkDRuOS70jje8STBb6a62tBjD0ltgXdum5tPdsep6oS0NLh16nAcO44w6ItoxN2k+iMv
         MbNw==
X-Gm-Message-State: AOAM532TU6Z0uzQpxHsyXCu/zeukZqBWk+NR0jmY5rMj05ZMYStL+JzA
        zOTxZthWHZ5ZxV6KfNRBT88=
X-Google-Smtp-Source: ABdhPJyoDPwwyxz2KjkHc2jeLw5v5ar2gCSKRHzlUh5gEjazqPEX8hcmme8+B7InRT9CWFwsXYzifw==
X-Received: by 2002:a05:6e02:1bcc:: with SMTP id x12mr6442953ilv.106.1637345911323;
        Fri, 19 Nov 2021 10:18:31 -0800 (PST)
Received: from localhost ([172.243.151.11])
        by smtp.gmail.com with ESMTPSA id y6sm324276iln.74.2021.11.19.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 10:18:30 -0800 (PST)
Date:   Fri, 19 Nov 2021 10:18:23 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jussi Maki <joamaki@gmail.com>
Message-ID: <6197ea6f350b7_56706208c2@john.notmuch>
In-Reply-To: <6195e2ae7a82f_2b4cc20884@john.notmuch>
References: <CAADnVQKEPYYrr6MUSKL4Fd7FYp0y5MQFoDteU5T++E6fySDADw@mail.gmail.com>
 <6191ee3e8a1e1_86942087@john.notmuch>
 <CAEf4Bza3OC1pAvVvwoPhyuixf8_VpA1w0F7HAsX09x2DSYbYbA@mail.gmail.com>
 <6195432baf114_1f40a208aa@john.notmuch>
 <CAEf4Bza6HHeVTFxrmPJRUgsLYU7g06MctMoAGy3ayKq8ES9FTQ@mail.gmail.com>
 <6195e2ae7a82f_2b4cc20884@john.notmuch>
Subject: Re: sockmap test is broken
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend wrote:
> Andrii Nakryiko wrote:
> > On Wed, Nov 17, 2021 at 10:00 AM John Fastabend
> > <john.fastabend@gmail.com> wrote:
> > >
> > > Andrii Nakryiko wrote:
> > > > On Sun, Nov 14, 2021 at 9:21 PM John Fastabend <john.fastabend@gmail.com> wrote:
> > > > >
> > > > > Alexei Starovoitov wrote:
> > > > > > test_maps is failing in bpf tree:
> > > > > >
> > > > > > $ ./test_maps
> > > > > > Failed sockmap recv
> > > > > >
> > > > > > and causing BPF CI to stay red.
> > > > > >
> > > > > > Since bpf-next is fine, I suspect it is one of John's or Jussi's patches.
> > > > > >
> > > > > > Please take a look.
> > > > >
> > > > > I'll look into it thanks.
> > > >
> > > > Any updates, John? Should we just disable test_maps in CI to make it
> > > > useful again?
> > >
> > > I'm debugging this now. Hopefully I'll have a fix shortly (today I hope).
> > > Maybe, it makes sense to wait for EOD and if I still don't have the fix
> > > disable it then. Anyways fixing it is top of list now.
> > 
> > Sounds good, let's hope you find it and fix it today.
> 
> OK got the fix, but its fairly subtle. Whats happening is when socks are
> removed from a map their programs are not actually being removed. They
> continue to live with the sock for the lifetime of the socket or until
> the last reference held from BPF side is lost. At which point all progs
> are dropped and socket returns to normal/preBPF state. We never noticed
> it on our real use cases because once we move sockets into BPF we never
> release them until the socket is free. The fix is to null the set progs
> and then do the update_sk_prot call which will decide based on the
> configured programs what proto ops need to be set to.

Fix posted here,

https://lore.kernel.org/bpf/20211119181418.353932-1-john.fastabend@gmail.com/

Thanks,
John
