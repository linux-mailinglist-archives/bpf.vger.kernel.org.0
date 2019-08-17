Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3492190C00
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2019 04:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfHQCCy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Aug 2019 22:02:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33437 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfHQCCy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Aug 2019 22:02:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id w18so5603472qki.0
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2019 19:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=x7XMRdgCt2pdutYjeOA8x9Ig7Wjm5vmCkdNaXQUT6Gk=;
        b=mcrBVju/QdoZkaoB86phY6BSIh7IESknpTqtDe3XtRMD7Xy5pTRaU/N/J6F9daxjdq
         NniNEg5UUDIRIyZRt6UbPX+niko9VyYxxbJkBKgKe2XjuQ2qa0MhDcp6DhrTnqIT1hfz
         0EnzaX0R/41+BqO0OORepLUzJRBtkQIMPMwDmQ2XcvBARvt65s0fPrzSa75czg8a2q0q
         FVfM/RNjC5wMHXa1y7p5xTYzjBwIFKm1bDVMqZKQfaxq1KHdcjmJ4DdSH1Pug46UhQNm
         MF0BUzCsTKr9cxRJhrBFIxt0IHsAdQvJy3FLykz5j4PUGQrH8Ekm4lzrHGmlnQ7n9JGB
         FrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=x7XMRdgCt2pdutYjeOA8x9Ig7Wjm5vmCkdNaXQUT6Gk=;
        b=FhO9oPtH9NCiVBbxiCHc3w0HsUDJpiAS4SdWiZRcFmwVCIEngvXfUFYuh5O/OK7NLR
         f6Jahm/T5K+EFowtPiTwJqSk2all6vPdR6SBCv/x8vk247GPZm3MyYSnvrNzMqZQVykK
         SIEgYcr1q0ISPFbSkbyxV+DYFeC7z7SQR7atjRvCw8Rj7PZcoj/Ty2v1wAdaeYjz+i1O
         TnvBIm1Eb4J600cNz+t0wFenySVUbNO4SOuX/ZAr+B9wRuiaMgQL01mw3kH5vAVd2DK7
         LWtp/sAkWRFDHPBbe5f1SuXqf3Uqf7U7m5/SW6vr15lbFe39/5pr5M6EGaAlJ+j+ztvt
         mYpg==
X-Gm-Message-State: APjAAAWgDo3c77aZe4Quzmqc8TB2uObAS18Y0q8Pe3bd1XjJHDHoph4f
        n0o+lic/WJVEofQ4V3BRRiMnNA==
X-Google-Smtp-Source: APXvYqzyDoDO9llEcgmuHCL2c+5J0/6rXwZo5GnScn31o/Yxbn/n4i5y6q8FE01IE8WdHDZ1LkS6qw==
X-Received: by 2002:a05:620a:1355:: with SMTP id c21mr10818956qkl.97.1566007373239;
        Fri, 16 Aug 2019 19:02:53 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id x145sm1678748qka.106.2019.08.16.19.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 19:02:53 -0700 (PDT)
Date:   Fri, 16 Aug 2019 19:02:34 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+6a9ff159672dfbb41c95@syzkaller.appspotmail.com>
Cc:     ast@kernel.org, aviadye@mellanox.com, borisp@mellanox.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, hdanton@sina.com, john.fastabend@gmail.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Subject: Re: INFO: task hung in tls_sw_release_resources_tx
Message-ID: <20190816190234.2aaab5b6@cakuba.netronome.com>
In-Reply-To: <000000000000e75f1805902bb919@google.com>
References: <000000000000523ea3059025b11d@google.com>
        <000000000000e75f1805902bb919@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 15 Aug 2019 11:06:00 -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 130b392c6cd6b2aed1b7eb32253d4920babb4891
> Author: Dave Watson <davejwatson@fb.com>
> Date:   Wed Jan 30 21:58:31 2019 +0000
> 
>      net: tls: Add tls 1.3 support
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118e8dee600000
> start commit:   6d5afe20 sctp: fix memleak in sctp_send_reset_streams
> git tree:       net
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=138e8dee600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=158e8dee600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
> dashboard link: https://syzkaller.appspot.com/bug?extid=6a9ff159672dfbb41c95
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cb0502600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d5dc22600000
> 
> Reported-by: syzbot+6a9ff159672dfbb41c95@syzkaller.appspotmail.com
> Fixes: 130b392c6cd6 ("net: tls: Add tls 1.3 support")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

CC Herbert, linux-crypto

This is got to be something in the crypto code :S 

The test case opens a ktls socket and back log writes to it.
Then it opens a AF_ALG socket, binds "pcrypt(gcm(aes))" and dies.

The ktls socket upon close waits for async crypto callbacks, but they
never come. If I unset CRYPTO_USER_API_AEAD or change the alg to bind
to "gcm(aes)" the bug does not trigger.

Any suggestions?
