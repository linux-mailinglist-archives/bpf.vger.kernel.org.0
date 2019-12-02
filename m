Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92FB610F2BB
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2019 23:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLBWPd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Dec 2019 17:15:33 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:46451 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLBWPd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Dec 2019 17:15:33 -0500
Received: by mail-pj1-f68.google.com with SMTP id z21so421510pjq.13
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2019 14:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NhXX3I1UlqvZdQq8+fgCGGfKkFSrcYd+r8H30a1bOCs=;
        b=xBPpkjXI8u1WpYOXZw96OJLU8A84/4scxd+32jXsqBw9SDCMGgQUUSIrCWQw8RYpxC
         Af/PwEc92MVgwEJb4lIMh7iOKKStr0rjLqGbuC3JTkSzf+7A9I6oL13CKnO6EXv3gVIS
         UtVHAnch3GCA8LNGzkp76ZF94ubybtdzBCoT2frtTMOdjDW5chgrS5kfibeaOx0IKmQX
         OUdcLgWaZgxStH3JFYJivnLFwRt3q3RPnKY06n2zme218YFFy+PeLqm8YCV9ednPk419
         0np5fxiZIA32H37nSHwsAeuZfnAP+xSF0WBFFtyjgkZ1apppncSdwFbSdHUCLztEI/73
         jPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NhXX3I1UlqvZdQq8+fgCGGfKkFSrcYd+r8H30a1bOCs=;
        b=ELxmdSXOo3gkJoAtOJaiiEcrtIb/HQgTHnTtxTbyUsccaGKW7O93RNclOm6/0opk0c
         fXElHMfc8gDwg7S0B78hFLIGqODdPju+dr1raljlYL6pYoHixg5uQ4j+fKzn7CNegFoE
         Y1rPk0qFXsJtdq38D9wCPLPaldUgJ7c3V9i8FbSWr8PeOpoVrMdmjW842eIIydGc55wY
         lOf1aS05BM1JkMF96l/PQy4Iykz8N7vJIGebpUAULeP+PI9m6mEdh30iNXe1nV7Fhb2R
         s1nPee0juj/a6UBctdvBTefyNHgHaxl8iVBXA/GyEdChWSdwRRPAWLSpXOuDurFn04Bu
         VmdA==
X-Gm-Message-State: APjAAAVfv28qY/DJFjG1lKNUxQr/Ajw4Prkn6rLpoV3AMpMmGBQtANDj
        smc+YiblVm7t7Qo6VuACxC66OQ==
X-Google-Smtp-Source: APXvYqx6oI6+VcmQyEBQIV5AE1EznqUclyUDPFU8yQ8VOnEH2bFjVbO/806HRDztwEu7NN1vTPE4Fw==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7mr1389404plt.341.1575324932557;
        Mon, 02 Dec 2019 14:15:32 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id f81sm493477pfa.118.2019.12.02.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 14:15:31 -0800 (PST)
Date:   Mon, 2 Dec 2019 14:15:31 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf] selftests/bpf: bring back c++ include/link test
Message-ID: <20191202221531.GB202854@mini-arch>
References: <20191202202112.167120-1-sdf@google.com>
 <CAEf4BzZGOSAFU-75hymmv2pThs_WJd+o25zFO0q4XQ=mWpYgZA@mail.gmail.com>
 <20191202214935.GA202854@mini-arch>
 <CAEf4BzYzY2WsiDoGokeo9AjmYfnrAhEn0YhTeQV6Gt-53WhR4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYzY2WsiDoGokeo9AjmYfnrAhEn0YhTeQV6Gt-53WhR4A@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/02, Andrii Nakryiko wrote:
> On Mon, Dec 2, 2019 at 1:49 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 12/02, Andrii Nakryiko wrote:
> > > On Mon, Dec 2, 2019 at 12:28 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > > +# Make sure we are able to include and link libbpf against c++.
> > > > +$(OUTPUT)/test_cpp: test_cpp.cpp $(BPFOBJ)
> > > > +       $(CXX) $(CFLAGS) $^ -lelf -o $@
> > >
> > > let's use $(LDLIBS) instead here
> > Sure, I'll send a v2 with $(LDLIBS); it might be worth doing for
> > consistency.
> >
> > Just curious: any particular reason you want to do it?
> > (looking it tools/build/features, I don't see any possible -lelf
> > cross-dependency)
> 
> The main reason is that I'd like to only have one (at least one per
> Makefile) place where we specify expected library dependencies. In my
> extern libbpf change I was adding explicit dependency on zlib, for
> instance, and having to grep for -lxxx to see where I should add -lz
> is error-prone and annoying. Nothing beyond that.
Makes sense, agreed.
