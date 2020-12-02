Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E288E2CC305
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 18:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbgLBRFc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 12:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387464AbgLBRFb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 12:05:31 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FD2C061A04
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 09:04:44 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id o16so1689499qvq.4
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 09:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fhMyhnnNKEJ49XIgzEQBRBGObFetYBnzrC8zuUBillQ=;
        b=mCFGoaqy0YtGQpgCyBFLhVshQDjMsEZyqbtMmywjZSDzevQhZaSBiE54QbOBPcUDE5
         tcnirweVwezwz1SrbeoMHQd63MJpmOBkTN2WZFU9rvxHM5C40XZi+tS/ThYzdm2Vx24A
         TQKh3X8wSg49sNhc/MGwpCu1B3EmotJcbBgTrjoLgfi5QwX1OMYD82Ua9pbbsNoL+Rbr
         36myGDRRugLmX2MU8PedLDKjTBMrawWGKEx2tGkemiNBOkhKA/lkRI1JNxthUS8AaATE
         4xA0CMymFQwldECukh4Lyh0bgebOoQg4GNVmiYip7tA1ugZfwu3KAfUANqPOOhRHWs2i
         cNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fhMyhnnNKEJ49XIgzEQBRBGObFetYBnzrC8zuUBillQ=;
        b=QL3+27Il7Qux6ARourfu9haauqsk18weUryVRKQvg7nYDsX7FL490u8NJClnWQ6fuD
         Ws0W3BWL71MnSXodxXplUr0rxs+gzwRLWgZZMYNJFTWAPJyCDvD/DhX3LPzDPpD/isWo
         OJfOIEN2WlBwa3R1Gnq3iQUZbI0JOImolGDXNIZ319gwTIDuzwOq9Pj0fXCV19r0IBIf
         Hh/35TCNQqRdCSoiZvI48YH7bMrsLrUxUdFhje9j/AQPkJi3NKOTqxbyoR3j60xVbTtx
         BwD6jA8kmUMm3TeHA7H+x0XgFZPvUqYLXPYYvyD3OXJWUILNLW2ll6o6evE5QpcXEMjm
         5SpQ==
X-Gm-Message-State: AOAM530rGNQuWu+qNERzeMMW1Uan7gkzRJ0gPKWu1XM3fgd5qAg3MemK
        hJsA99DPwB9zssaeS5TPl7k9uJw=
X-Google-Smtp-Source: ABdhPJzLSsJa6w2KaEmRmS7vrSTVfu0Jl+EREPxUfXxG22VNZzQJpjIAt0yioLN4UIhKTt5W8ipuh3U=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a05:6214:29:: with SMTP id b9mr3748555qvr.18.1606928683263;
 Wed, 02 Dec 2020 09:04:43 -0800 (PST)
Date:   Wed, 2 Dec 2020 09:04:41 -0800
In-Reply-To: <CAEf4BzaQGJCAdbh3CYPK=z1XPBpqbWkXJLgHaEJc+O7R5dt9vw@mail.gmail.com>
Message-Id: <20201202170441.GC553169@google.com>
Mime-Version: 1.0
References: <20201118001742.85005-1-sdf@google.com> <20201118001742.85005-2-sdf@google.com>
 <CAEf4BzaQGJCAdbh3CYPK=z1XPBpqbWkXJLgHaEJc+O7R5dt9vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: rewrite test_sock_addr bind
 bpf into C
From:   sdf@google.com
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/01, Andrii Nakryiko wrote:
> On Tue, Nov 17, 2020 at 4:20 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > I'm planning to extend it in the next patches. It's much easier to
> > work with C than BPF assembly.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---

> With nits below:

> Acked-by: Andrii Nakryiko <andrii@kernel.org>
Thank you for the review! Will respin shortly with the nits addressed.
