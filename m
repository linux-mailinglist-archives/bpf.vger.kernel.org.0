Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F99194F9D
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2019 23:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfHSVNF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Aug 2019 17:13:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36669 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfHSVNF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Aug 2019 17:13:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id d23so2720135qko.3
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2019 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=zcVnTkmaXZnvPzlslFpXTMQ+JyK8DgeCTABL7ZZHlNU=;
        b=VneBgzz0zlwlbD+l25IEANd6GZochFewROcYaBQgFYjKrQTYV7b9Enr3aOVpRzYlHD
         uCCmm6sRFPRnhKlctdECpZ/4OkRUTWuY7XvzXvfY4FBNOXxZP0urwnOgzmgszTbPPUqu
         I7offB5XiFLr76whtKbv/7zyhDKvitkCTGSMj0A4cJi44sl2i0U6qked42BxpM00dzdI
         kQgTrGUgQO5oCuBA1WQQvUYYa1hGWG5hoOPJ75v3LkR3r6a85fE0IBGm97o9IUpHHamk
         ztNpnA3Wax0FBRwaUJOoFmMfWLXhMTTvhx0Mcg3FzRYDekOWNAtbo03YZDNRf3CE+s8J
         5YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=zcVnTkmaXZnvPzlslFpXTMQ+JyK8DgeCTABL7ZZHlNU=;
        b=e7VS20rLOkyv4OHmRMrAGBtsBsyNUEHlFnA+JM9qHo93TVJlSKsTs5gLNPH9DDzxja
         m4fihWzpra9V8GgdvWaMbYPb7DGagW+0O2gISeciHw0TfmiJVr5iYrgzigJzDpkRpx3/
         rk9up5ZRqOGKKw2sp2r0P4/DseZlyop9Cfrkh18wIaEo8LsVbrCZXnDWoOuX/jCggHWO
         yIg/cdhXyRwj3cWrfKt3AoJSlb1Ki6GAFGWiEFF/juF92IjylwNjJgLm7i2ORJJhN9RT
         KenqKk6Z2lXIF90Ik1r0ID9lqvAQYIljP0VoKQpVNRgMROnAU9ft/gqsyDYbaf6CYl5e
         PeBQ==
X-Gm-Message-State: APjAAAWvdlRgxgC5laLpUSbknZItZHaMkALBhqwXzkrBg6dZCDaP+boX
        gqM8HhO/8xhKxpLqXtx7yLL59w==
X-Google-Smtp-Source: APXvYqwLaN0yohHtVfe4XZyjRKdXGEk5nnPYe9Tav4wl1k/s/Fsnb6Cem5zSCOnY6T+lv/oZaKquFA==
X-Received: by 2002:a05:620a:4c8:: with SMTP id 8mr21380405qks.366.1566249184021;
        Mon, 19 Aug 2019 14:13:04 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o29sm8527788qtf.19.2019.08.19.14.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 14:13:03 -0700 (PDT)
Date:   Mon, 19 Aug 2019 14:12:55 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        syzbot <syzbot+6a9ff159672dfbb41c95@syzkaller.appspotmail.com>,
        ast@kernel.org, aviadye@mellanox.com, borisp@mellanox.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, hdanton@sina.com, john.fastabend@gmail.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Subject: Re: INFO: task hung in tls_sw_release_resources_tx
Message-ID: <20190819141255.010a323a@cakuba.netronome.com>
In-Reply-To: <20190817054743.GE8209@sol.localdomain>
References: <000000000000523ea3059025b11d@google.com>
        <000000000000e75f1805902bb919@google.com>
        <20190816190234.2aaab5b6@cakuba.netronome.com>
        <20190817054743.GE8209@sol.localdomain>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 16 Aug 2019 22:47:43 -0700, Eric Biggers wrote:
> [+Steffen, who is the maintainer of pcrypt]
> 
> On Fri, Aug 16, 2019 at 07:02:34PM -0700, Jakub Kicinski wrote:
> > On Thu, 15 Aug 2019 11:06:00 -0700, syzbot wrote:  
> > > syzbot has bisected this bug to:
> > > 
> > > commit 130b392c6cd6b2aed1b7eb32253d4920babb4891
> > > Author: Dave Watson <davejwatson@fb.com>
> > > Date:   Wed Jan 30 21:58:31 2019 +0000
> > > 
> > >      net: tls: Add tls 1.3 support
> > > 
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118e8dee600000
> > > start commit:   6d5afe20 sctp: fix memleak in sctp_send_reset_streams
> > > git tree:       net
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=138e8dee600000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=158e8dee600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=6a9ff159672dfbb41c95
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cb0502600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d5dc22600000
> > > 
> > > Reported-by: syzbot+6a9ff159672dfbb41c95@syzkaller.appspotmail.com
> > > Fixes: 130b392c6cd6 ("net: tls: Add tls 1.3 support")
> > > 
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection  
> > 
> > CC Herbert, linux-crypto
> > 
> > This is got to be something in the crypto code :S 
> > 
> > The test case opens a ktls socket and back log writes to it.
> > Then it opens a AF_ALG socket, binds "pcrypt(gcm(aes))" and dies.
> > 
> > The ktls socket upon close waits for async crypto callbacks, but they
> > never come. If I unset CRYPTO_USER_API_AEAD or change the alg to bind
> > to "gcm(aes)" the bug does not trigger.
> > 
> > Any suggestions?  
> 
> Seeing as pcrypt is involved and this is a "task hung" bug, this is probably
> caused by the recursive pcrypt deadlock, which is yet to be fixed.
> 
> See the original thread for more info:
> 
> 	https://groups.google.com/forum/#!msg/syzkaller-bugs/1_CXUd3gBcg/BvsRLH0lAgAJ
> 
> And the syzbot dashboard link:
> 
> 	https://syzkaller.appspot.com/bug?id=178f2528d10720d563091fb51dceb4cb20f75525
> 
> Let's tell syzbot this is a duplicate:
> 
> #syz dup: INFO: task hung in aead_recvmsg

Thanks for the suggestion Eric!

Looks like the dup didn't tickle syzbot the right way. Let me retry
sending this directly to the original report.
