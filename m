Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B718E43AF1
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2019 17:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfFMPY5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jun 2019 11:24:57 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:38436 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731647AbfFMMME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 08:12:04 -0400
Received: by mail-io1-f51.google.com with SMTP id k13so16286445iop.5
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2019 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TnqYw+JH0yXL0cYBb0DT/5cCjybbJ0FkJFzKrPy/Ks=;
        b=V1kObx8WFKLXYMLDacaZYfPCx7cuX/IA1LFq0ZQgLWAhg1D+voGEfUagJ645qIod/k
         zGsXPiqk/Lqd34ObQupyesy1ZWwYRn4JJgZYrUNAhinntdvRuvv/WKGNUQ1CzGo77vZI
         HP27MV24tXmnPjITSM4yW0sUzQZ0bjDFAppf0fVDVLoyoOZEhMRz+m/JrdY2DmbhjqaB
         /fj1ntsBGZHDRJj9F2KyBisjtbnbm1G19+nfPG0p3m1qvVVNLMemEyuCeVdMA0IngggG
         vBjhGKmCmQKU4bEJ3/jtx+XCZqrxXvoxyG9f3sF4nQUxGgJ+AV93Oh/GUr/cB65beXrU
         IHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TnqYw+JH0yXL0cYBb0DT/5cCjybbJ0FkJFzKrPy/Ks=;
        b=UQEzzckl0zEN5ctkeVz9KHq6vTWGLUGwsrNu1dFsiW4zdkAlct1TdS2n03r/VXJdpO
         Ltfq6QcXuKyf1voIu+osG8IlXKPKSJPrdFq0kD6a+vNKFS4/hzyGPqeDJf+YD0gk668D
         VMrctooBK/SBh4v0Oqdxk0oo893YqkbMOdpTB7FgiL7KHlfejCh8Ym76+aQ9utZLwPFi
         JD80H6Z/o1kLAX32zyUoL7WvxSyoizwG83lkuQD2nHJfKdEdRdsugJskJKRO9zbZMX4B
         HGpg48Dvpmt+NjZhNlTG6HdrxXinyjHG3gVqzWczBexbw8111iJJ5AqHYr9+e7euMdJI
         urhg==
X-Gm-Message-State: APjAAAXJPQj7LYYZYZKos/DAvZ3pP4wx+8zDpu2hYUFyRMUrOCfI9x7s
        ClUJ52o59KfCG2QbPvxSh6kilJ1tak7HiEOdjUE/mw==
X-Google-Smtp-Source: APXvYqyCTIGH2L4bZDuCnup/5Krt+juZXVarS330yujDiKA6yKNS0mtgMz1H4aP3TlXSLRHvxmG6k/hJzd4683l6yRQ=
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr3118490iog.266.1560427923857;
 Thu, 13 Jun 2019 05:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190613120659.10680-1-hdanton@sina.com>
In-Reply-To: <20190613120659.10680-1-hdanton@sina.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Jun 2019 14:11:52 +0200
Message-ID: <CACT4Y+ZaoM4c739MM5KXH7K0_oeRsQ8F4Erptv8bjbx0JFuS-w@mail.gmail.com>
Subject: Re: memory leak in vhost_net_ioctl
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        syzbot <syzbot+0789f0c7e45efd7bb643@syzkaller.appspotmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 13, 2019 at 2:07 PM Hillf Danton <hdanton@sina.com> wrote:
>
>
> Hello Jason
>
> On Thu, 13 Jun 2019 17:10:39 +0800 Jason Wang wrote:
> >
> > This is basically a kfree(ubuf) after the second vhost_net_flush() in
> > vhost_net_release().
> >
> Fairly good catch.
>
> > Could you please post a formal patch?
> >
> I'd like very much to do that; but I wont, I am afraid, until I collect a
> Tested-by because of reproducer without a cutting edge.

You can easily collect Tested-by from syzbot for any bug with a reproducer ;)
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
