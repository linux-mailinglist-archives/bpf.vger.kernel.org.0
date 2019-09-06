Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7797BABC11
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2019 17:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390706AbfIFPSK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Sep 2019 11:18:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34420 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfIFPSK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Sep 2019 11:18:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so3695356pgc.1
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2019 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VZMCXRM8TzTq1t7EOE0Ava5YGmAYMTxnG5vJ96XDLeo=;
        b=0o4CIO4Yw5Th9JIsK7kiZuHiHXKRpbf5CEfsLgRrKbPxpG0LVSt5pkTCKTF0cZPAmO
         HnFxXq0175zq0zcq8rotA3Amu7MlBgKbZbDl6LlbodEW0zedeww9kgd+YLrZy47nZFo4
         KHaawj1vUb68v/xGE3DiP8r3XUa4+4+LJ5proE4zU9dj4mRJiDPJQr3vM9e+Nn3PsjrP
         g8/OAShBtX8OutE+bc6OId/bz87ZdxwsuIpH5exuXxyw46sHVPvfHWvxIRdOhKPuP0ei
         6gvdjpz/bHMB0KhOL/IrrUotdqA3F8K2jN0qPCoVpWXEHtlJXQqxCktYiFkPjHguUPaP
         7jtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VZMCXRM8TzTq1t7EOE0Ava5YGmAYMTxnG5vJ96XDLeo=;
        b=t0AwX+kwsdebsxoTxIAK83gtIqAHfK89YGpiAssT/KzkhzsyJmJE6AuTop6PP6X0LM
         oDp4GwwEPjq+F3ags5bsXB0n4CPMrLxNDcVNAfsQlDStIEWRGf14l/ogwI2NjUAJDDG8
         u8ojTiI8Ilg3yU52r+O4l7o+9ptUltSaE6AdEAhIPO4cDZCoAm8sBpptp714P2pDlgv4
         u83Ozwdz6eELzHNWb45HKtIuyrwWzJ8lvMAoFR8htENQVgZehcPuaBWxdG8RiDK4BWZd
         /PCP5JuPOfMc9MnGac2VS86N7z106F/3dNGoLV3VoHeZjvSa/NckdUt2jto1Uv+t+pbE
         kokA==
X-Gm-Message-State: APjAAAXVWJJLN/QcE+lpm7et5sSGDJKclFP01WcVhoysgtUQ9z2pxAYt
        Fb0Em1moI9sRG661n8O7wXfxCQ==
X-Google-Smtp-Source: APXvYqwTzMDAqoqNVtjpAIyiyOhgw8YqlJVjor7lpAPtQdPUVvPxWvJPCoWcP1AAqbmsbvD1mbe5SQ==
X-Received: by 2002:a62:e216:: with SMTP id a22mr11335997pfi.249.1567783089565;
        Fri, 06 Sep 2019 08:18:09 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id q21sm7156080pfh.18.2019.09.06.08.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 08:18:08 -0700 (PDT)
Date:   Fri, 6 Sep 2019 08:18:08 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 0/6] selftests/bpf: move sockopt tests under
 test_progs
Message-ID: <20190906151808.GD2101@mini-arch>
References: <20190904162509.199561-1-sdf@google.com>
 <20190904230331.ld4zsn4jgldu7l6q@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzaoh0Ur6Ze0VLNYqhTJ21Vp6D2NBMkb7yAeseqom=TyKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzaoh0Ur6Ze0VLNYqhTJ21Vp6D2NBMkb7yAeseqom=TyKA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/06, Andrii Nakryiko wrote:
> On Wed, Sep 4, 2019 at 4:03 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Sep 04, 2019 at 09:25:03AM -0700, Stanislav Fomichev wrote:
> > > Now that test_progs is shaping into more generic test framework,
> > > let's convert sockopt tests to it. This requires adding
> > > a helper to create and join a cgroup first (test__join_cgroup).
> > > Since we already hijack stdout/stderr that shouldn't be
> > > a problem (cgroup helpers log to stderr).
> > >
> > > The rest of the patches just move sockopt tests files under prog_tests/
> > > and do the required small adjustments.
> >
> > Looks good. Thank you for working on it.
> > Could you de-verbose setsockopt test a bit?
> > #23/32 setsockopt: deny write ctx->retval:OK
> > #23/33 setsockopt: deny read ctx->retval:OK
> > #23/34 setsockopt: deny writing to ctx->optval:OK
> > #23/35 setsockopt: deny writing to ctx->optval_end:OK
> > #23/36 setsockopt: allow IP_TOS <= 128:OK
> > #23/37 setsockopt: deny IP_TOS > 128:OK
> > 37 subtests is a bit too much spam.
> 
> If we merged test_btf into test_progs, we'd have >150 subtests, which
> would be pretty verbose as well. But the benefit of subtest is that
> you can run just that sub-test and debug/verify just it, without all
> the rest stuff.
> 
> So I'm wondering, if too many lines of default output is the only
> problem, should we just not output per-subtest line by default?
Ack, we can output per-subtest line if it fails so it's easy to re-run;
otherwise, hiding by default sounds good. I'll prepare a v3 sometime
today; Alexei, let us know if you disagree.
