Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1620386EC2
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2019 02:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404428AbfHIAUv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Aug 2019 20:20:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38096 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404850AbfHIAUp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Aug 2019 20:20:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id n11so94160002qtl.5
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2019 17:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=SrXlbID68lhPKrJjkmbTtajZDQHFU0j/ynkOO+lAohM=;
        b=Yr5u2Vmo96zfWo39ki7h7j7HCO1EXUDceAcYfoQtM5RXkFFvJypKjsEjKiv8bUFEWd
         ndb3UqgQdVG5d7QyqSo97A3i3BPmPoiVELQKMA1Y2j3qmge4ZhPji+1S0lPqrtEUxiaC
         MbJEyrANZe7MemMD0mDcPUlws7G4xTK/eXmUhFky1OS2l8RttkA2unobufRTaXikM86m
         JjgluiH74qu/c0dBiWmCgueiRclbh5xeau3N0NtY+U7uiSmXweWXVGnCuN+OF9hJPCKc
         eD4NnaKttNVkM6x4t06CaMZP0P0/iCI3pMHsvmGwzS1YFDZ6jZEsfV2a11ncE5Ojd1jU
         fVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=SrXlbID68lhPKrJjkmbTtajZDQHFU0j/ynkOO+lAohM=;
        b=nKihUUSiS15s+MU7RuVw+/FgaDWDyUZGeFnP3yxfFfETTv9Q7m44mBCekcR4veCLJs
         0plELUgUqPyjz6I5BVq9AiNe4B2FY4sGpsOWZd12QC0+/0hh6EMuKrOrpen6MRbFaHd6
         YyPfm7B91ndRm2fC/Ox77S9T/yhph/KzffXFRbeJrLL0+E3S2oTVyAZloG+IA5h8zxbk
         fNgdqzfgWawMOHobzDYi4+bIlBJ9A2RZDNcflh8oENq1QqCWCjSr1sZ3vAGeaXppxr2i
         569KSFMqlvJ8J6VQTx/cfC7XMC142Ow/ENBZk5uDcDc61WyaJcjnZY7jDTB8wpD0VMF6
         eezA==
X-Gm-Message-State: APjAAAWa96ewmIjC0U4SU6XTl3ahfDjTbVeALr0o1B1SpUPe+U1SJOKN
        1eak6q6/cvUMz5K5xTy3yVyCCw==
X-Google-Smtp-Source: APXvYqxXRpoNHsJzyfCUQYdj2V8c2KZTPv3rU9ocRemD+2B0qsEHSJiuOKcias/L0ujb0D4xLA65Pw==
X-Received: by 2002:a0c:8602:: with SMTP id p2mr15734769qva.111.1565310044622;
        Thu, 08 Aug 2019 17:20:44 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q17sm37509666qtl.13.2019.08.08.17.20.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 17:20:44 -0700 (PDT)
Date:   Thu, 8 Aug 2019 17:20:41 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+30c791a76814a3c6c9f9@syzkaller.appspotmail.com>
Cc:     ast@kernel.org, aviadye@mellanox.com, borisp@mellanox.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, john.fastabend@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Subject: Re: KASAN: use-after-free Read in tls_wait_data
Message-ID: <20190808172041.282a755d@cakuba.netronome.com>
In-Reply-To: <000000000000262820058f9dc474@google.com>
References: <000000000000262820058f9dc474@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 08 Aug 2019 09:44:07 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7b4980e0 Add linux-next specific files for 20190802
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a749b4600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7e1348afd44b5e02
> dashboard link: https://syzkaller.appspot.com/bug?extid=30c791a76814a3c6c9f9
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+30c791a76814a3c6c9f9@syzkaller.appspotmail.com

Also old tree, pretty confidently I can say:

#syz fix: net/tls: partially revert fix transition through disconnect with close
