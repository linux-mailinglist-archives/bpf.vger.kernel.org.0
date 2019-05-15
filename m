Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5771E6F9
	for <lists+bpf@lfdr.de>; Wed, 15 May 2019 04:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfEOC4j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 May 2019 22:56:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35587 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEOC4i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 May 2019 22:56:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so571704pgs.2
        for <bpf@vger.kernel.org>; Tue, 14 May 2019 19:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9kqRrsb++I0tVWKRUhKyYkTTZ79beQ5XiFr2tm4fXGg=;
        b=U/GuCKuLv0GYA0b2ZYYNgEW1VQTtESo1ytzGpUW6kAGFzfRs7tUMuw90tLk4Zy7Q8Z
         IKyx4Rg/OULhyxTKzIdYiQggiIthiElOtVoJ23r5srnHOh1j6r/xBkIGj0pD5RTwpNF5
         7TdbqnVk0+EX8pliMdOY7LkFdBrEGskbtb0qYhBHcutC9fNnjzAw2DcX/y24M5ALj5rP
         givk9LY3gLiwfYSioy9DkJma+BLcmK1NNOAXlP3lDT8U3OKAufpEHj29D6e+or+qubA0
         WpQHdmo16hY4jev+OkLdezQkqDpWYiOJU4nfpik9cmgn2ml4QTVtpEdcnonhoaybUD5h
         +T9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9kqRrsb++I0tVWKRUhKyYkTTZ79beQ5XiFr2tm4fXGg=;
        b=ltuujkW+jCkmgumnc+cy7k5wZjI+i7JH8D/JMURFgEvbCeFj82Kx9w5A89aYaFvDw7
         +P6i9R4/9lGgjuWNJtioTDtJkyUGmMs/ReZMGdBh86xSgeRn4e908/u46IecBQbjAXyt
         hXW5+cgcx7/eEk+BAWwqOjotXuRxtzIJq+979fQZrHRfYo0rn4DId7PVqZqUimorLyQ9
         +dYAfdTyJBsy8kmA2DayFvSuD9SYgVwH700/A1O1BbM3PffgcBl6s12mnJe35EYiyS0H
         843RBeppwVQIEksOx8x3rFJTCDznBlADSceWGMOTq5dPylPJ3P9LVHY0G92MEZwEnCvC
         PNaA==
X-Gm-Message-State: APjAAAVfPi1jcwv7/mOtk52pS6YEWNDkHb2tIuOdUC8qhNHpDVMV18XI
        ubNxwl6CDIaB9Kxkvs1C33Zotw==
X-Google-Smtp-Source: APXvYqzdPymztt59JMUNleYEqUbzDYVsx7mCTKC9cg/A90es9XlqLNTr11m2a8yQ1JhssNNINOnrXg==
X-Received: by 2002:a65:554d:: with SMTP id t13mr41127593pgr.171.1557888998050;
        Tue, 14 May 2019 19:56:38 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id s18sm550594pgg.64.2019.05.14.19.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 19:56:37 -0700 (PDT)
Date:   Tue, 14 May 2019 19:56:36 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf 0/4] bpf: remove __rcu annotations from bpf_prog_array
Message-ID: <20190515025636.GE10244@mini-arch>
References: <20190508181223.GH1247@mini-arch>
 <20190513185724.GB24057@mini-arch>
 <CAADnVQLX3EcbW=iVxjsjO38M3Lqw5TfCcZtmbnt1DJwDvp64dA@mail.gmail.com>
 <20190514173002.GB10244@mini-arch>
 <20190514174523.myybhjzfhmxdycgf@ast-mbp>
 <20190514175332.GC10244@mini-arch>
 <CAADnVQLAJ77XS8vfdnszHsw_KcmzrMDvPH0UxVXORN-wjc=rWQ@mail.gmail.com>
 <20190515021144.GD10244@mini-arch>
 <CAADnVQ+LPLfdfkv2otb6HRPeQiiDyr4ZO04B--vrXT_Tu=-9xQ@mail.gmail.com>
 <5ed25b81-fdd0-d707-f012-736fe6269a72@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed25b81-fdd0-d707-f012-736fe6269a72@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/14, Eric Dumazet wrote:
> 
> 
> On 5/14/19 7:27 PM, Alexei Starovoitov wrote:
> 
> > what about activate_effective_progs() ?
> > I wouldn't want to lose the annotation there.
> > but then array_free will lose it?
It would not have have it because the input is the result of
bpf_prog_array_alloc() which returns kmalloc'd pointer (and
is not bound to an rcu section).

> > in some cases it's called without mutex in a destruction path.
Hm, can you point me to this place? I think I checked every path,
maybe I missed something subtle. I'll double check.

> > also how do you propose to solve different 'mtx' in
> > lockdep_is_held(&mtx)); ?
> > passing it through the call chain is imo not clean.
Every caller would know which mutex protects it. As Eric said below,
I'm adding a bunch of xxx_dereference macros that hardcode mutex, like
the existing rtnl_dereference.

> Usage of RCU api in BPF is indeed a bit strange and lacks lockdep support.
> 
> Looking at bpf_prog_array_copy_core() for example, it looks like the __rcu
> in the first argument is not needed, since the caller must have done the proper dereference already,
> and the caller knows which mutex is protecting its rcu_dereference_protected() for the writer sides.
> 
> bpf_prog_array_copy_core() should manipulate standard pointers, with no __rcu stuff.
> 
> The analogy in net/ are probably the rtnl_dereference() users.
