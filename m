Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E48746D0D
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2019 02:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFOABH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jun 2019 20:01:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40189 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfFOABG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jun 2019 20:01:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so2382007pgm.7
        for <bpf@vger.kernel.org>; Fri, 14 Jun 2019 17:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KT4IpT0YGFv9ghQa3t6IoKfeIcka4hGjEOUTWMdheO0=;
        b=G4IbYnFq6pwJFgRwo/04ruaGJs9xY/ZMoBzIlPkuUieQFa1/KJaS5naRz3hYc4GMDS
         o8DkRTVvxOI7OY65kf5DSxqsh6tlBJOfSJt4Af0PSU2dLX9zt20RlnjUFsQQkZvxbpwO
         B0cfACa0GqIGJLR3GyW6mHIPw/ndMJu02RkolBIglA7GUjNdqLFOvpTw215PrF8ATkP6
         GVBHJWJPHp/xdev5Oqy7hvAOm2xgXYPZuOD14eGqsPVboAWtuhA2a8Hoa6lIQGJF0prh
         9j4UFibuM9UZtv5GLqqw9a0d/3c0j4N9biF3KKbKvkNp9rFuj5p5stH3EjqTPdvFDCyS
         t/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KT4IpT0YGFv9ghQa3t6IoKfeIcka4hGjEOUTWMdheO0=;
        b=XInoDa4zfW0p2+RxfWvhnJ8hdR+R30wvVwPdx94rhDjCUIW7Tz/GM2Y9queNJK+HSw
         KQZ69saQcCYmgjj8JFims7PNSv8ctSbH/JRLbTAjMXeHpM/rIpb0iTe/bFrEwmAp4hwo
         HCR8AAEHToldUsXd8eicJquWNl73Jr5uGXGvJ7rQ19/ugPlg3IJTGPeQ1oPkKbBCI1VX
         xZLBtxIULaY40XW6/o8x7MqQ/R+BpDrGssS6RpuJ0cvkXLxLa0EeFocXaf1X70ht3CaE
         QzPCdvMRioKZKHfg20qHYzTU94pkjqkJcba4Ou4DekySgSYfdv9v++vSbcAMfCAqQeu2
         K7vw==
X-Gm-Message-State: APjAAAXP/1Zj3VpeoE2aa3pPg+riUWvaD0KwJdeA2u486OlqTfQDjNaD
        8pa9h5ln3OpRUSRoN3+eLZ3WjQ==
X-Google-Smtp-Source: APXvYqy0L2Z2bLrRj3KJePR5v/Ve/h0OoWDU0HMJoHgbMo7ZO13QMuQiJYYkYAdhKjapy8X88GaiaA==
X-Received: by 2002:aa7:808a:: with SMTP id v10mr10082536pff.170.1560556866116;
        Fri, 14 Jun 2019 17:01:06 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id a7sm3705828pgj.42.2019.06.14.17.01.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 17:01:05 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:01:04 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: switch tests to BTF-defined
 map definitions
Message-ID: <20190615000104.GG9636@mini-arch>
References: <20190611044747.44839-1-andriin@fb.com>
 <20190611044747.44839-9-andriin@fb.com>
 <20190614232329.GF9636@mini-arch>
 <CAEf4BzZ5itJ+toa-3Bm3yNxP=CyvNm=CZ5Dg+=nhU=p4CSu=+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ5itJ+toa-3Bm3yNxP=CyvNm=CZ5Dg+=nhU=p4CSu=+g@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/14, Andrii Nakryiko wrote:
> On Fri, Jun 14, 2019 at 4:23 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 06/10, Andrii Nakryiko wrote:
> > > Switch test map definition to new BTF-defined format.
> > Reiterating my concerns on non-RFC version:
> >
> > Pretty please, let's not convert everything at once. Let's start
> > with stuff that explicitly depends on BTF (spinlocks?).
> 
> How about this approach. I can split last commit into two. One
> converting all the stuff that needs BTF (spinlocks, etc). Another part
> - everything else. If it's so important for your use case, you'll be
> able to just back out my last commit. Or we just don't land last
> commit.
I can always rollback or do not backport internally; the issue is that
it would be much harder to backport any future fixes/extensions to
those tests. So splitting in two and not landing the last one is
preferable ;-)

> > One good argument (aside from the one that we'd like to be able to
> > run tests internally without BTF for a while): libbpf doesn't
> > have any tests as far as I'm aware. If we don't have 'legacy' maps in the
> > selftests, libbpf may bit rot.
> 
> I left few legacy maps exactly for that reason. See progs/test_btf_*.c.
Damn it, you've destroyed my only good argument.

> > (Andrii, feel free to ignore, since we've already discussed that)
> >
> > > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > > ---
> 
> 
> <snip>
