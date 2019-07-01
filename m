Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F04B5B416
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 07:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGAFcO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 01:32:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45617 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfGAFcN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 01:32:13 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so25854168ioc.12;
        Sun, 30 Jun 2019 22:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=bHwLGMVGeA5RZAQhouQu9TuLFrBTaeIaDSifyZUdLOo=;
        b=HLYYdNKTnons4Refd7zSAfvhRwZxW4KdSMltv4C7TWzAJS8Oio5M6GtT9F3GUOyXa/
         CKj/R64RZCm6rNX49Lu08qanJBXFIvNCgyoFgS68PKVicQNpADxFgCeSRPsADvP5JOKP
         ocHh8kGB4uKpAJsQpxNqdoZyY+baCFmd02LtWibSvzlSCAl5fHBdUZ3vvqxPxtm4Cdyw
         kdB5KRChd9lYgT2/pqu10m/8e7+v2wOl4vf19/AFPObKh3hAOCdz4YkMN8njvynYtBlb
         rvhAGzCr9kB9ZugjHqCZJ+48MkW4iY1bQyRKHLYyOtFuxHZR2HMuXY0eeps1lVevJKT9
         HjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=bHwLGMVGeA5RZAQhouQu9TuLFrBTaeIaDSifyZUdLOo=;
        b=KIJQwd7cmdXIse9k7k7wM0yJ18/roU6hH9CLsLOTZBPjThs0bpzCHEiWDco8TNKsFN
         xqnqUH3OEmD2HgDsp9e8PSGDJT93i87K5eXo7fHOg7mgAtPV5FnTqUkqBiQXVJqJ9A9G
         WXm1P7fKH68HVFXeVFx+FIymuxfrCGkCW6aREH7PLgUdDaEtVXLKblSrWQNtJxPXL4Wb
         2zxo8RjY9UJSlTZsoxgk124IT3ZgOGpuVuKQkFJAfqv5aFfJCM+bDzfyrAPUTl9mE5bG
         pg0slE0OS0YforLk2z03s4sfum2rw1HrPuAmXRYtXSTzos+P0bbLwNTAaITaVpVBfsWj
         QhQw==
X-Gm-Message-State: APjAAAVy2f4QRq6yC3+y2S/H7cfYlI7Om/rXUxEsNMha61F1IfIe5WyT
        0HMbnjsJvc2RKc0PSMuV1GKPqVi9Pr8=
X-Google-Smtp-Source: APXvYqxjWRXI9LiYpyoUC93AFib9/B4amldRGx79u7c95Y8aWn4AueOnBg49wfZPHXPzRhHvU/UHIw==
X-Received: by 2002:a02:c50a:: with SMTP id s10mr26966556jam.106.1561959133032;
        Sun, 30 Jun 2019 22:32:13 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id c14sm9693438ioa.22.2019.06.30.22.32.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 22:32:12 -0700 (PDT)
Date:   Sun, 30 Jun 2019 22:32:04 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Eric Biggers <ebiggers@kernel.org>, bpf@vger.kernel.org
Cc:     syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <5d199ad457036_1dd62b219ced25b86e@john-XPS-13-9370.notmuch>
In-Reply-To: <20190625072942.GB30940@sol.localdomain>
References: <0000000000005aedf1058c1bf7e8@google.com>
 <alpine.DEB.2.21.1906250820060.32342@nanos.tec.linutronix.de>
 <20190625072942.GB30940@sol.localdomain>
Subject: RE: [net/bpf] Re: WARNING in mark_lock
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Eric Biggers wrote:
> [+bpf list]
> 
> On Tue, Jun 25, 2019 at 08:20:56AM +0200, Thomas Gleixner wrote:
> > On Mon, 24 Jun 2019, syzbot wrote:
> > 
> > > Hello,
> > 
> > CC++ Peterz 
> > 
> > > 
> > > syzbot found the following crash on:
> > > 
> > > HEAD commit:    dc636f5d Add linux-next specific files for 20190620
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=162b68b1a00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=99c104b0092a557b
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=a861f52659ae2596492b
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110b24f6a00000
> > > 
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com
> 
> The syz repro looks bpf related, and essentially the same repro is in lots of
> other open syzbot reports which I've assigned to the bpf subsystem...
> https://lore.kernel.org/lkml/20190624050114.GA30702@sol.localdomain/
> 
> {"threaded":true,"repeat":true,"procs":6,"sandbox":"none","fault_call":-1,"tun":true,"netdev":true,"resetnet":true,"cgroups":true,"binfmt_misc":true,"close_fds":true,"tmpdir":true,"segv":true}
> bpf$MAP_CREATE(0x0, &(0x7f0000000280)={0xf, 0x4, 0x4, 0x400, 0x0, 0x1}, 0x3c)
> socket$rxrpc(0x21, 0x2, 0x800000000a)
> r0 = socket$inet6_tcp(0xa, 0x1, 0x0)
> setsockopt$inet6_tcp_int(r0, 0x6, 0x13, &(0x7f00000000c0)=0x100000001, 0x1d4)
> connect$inet6(r0, &(0x7f0000000140), 0x1c)
> bpf$MAP_CREATE(0x0, &(0x7f0000000000)={0x5}, 0xfffffffffffffdcb)
> bpf$MAP_CREATE(0x2, &(0x7f0000003000)={0x3, 0x0, 0x77fffb, 0x0, 0x10020000000, 0x0}, 0x2c)
> setsockopt$inet6_tcp_TCP_ULP(r0, 0x6, 0x1f, &(0x7f0000000040)='tls\x00', 0x4)

#syz test: git://github.com/cilium/linux ktls-unhash
