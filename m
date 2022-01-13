Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DED48D0CE
	for <lists+bpf@lfdr.de>; Thu, 13 Jan 2022 04:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiAMDT7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 22:19:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232023AbiAMDT6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 Jan 2022 22:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642043997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jm5clb8xIHCpD5vaQkgGsXDJRBF8humGdGQtxPy4P88=;
        b=cY+L9SY4uwrprXpkK6XVUeY1j4c5thss7dMDbLker9W1oOXKhvdTr9qHRuwPkvo/Vw4Ndd
        iSmjFbVWLwz61zsqWijW3aue9OwaC1babYGV2+sJWXa0gVa8TQ9Twc+vmQArCbMaLFnAPt
        SGFX30nmBi59r/DfwmPIN3LIqXumpeM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-jNCi_46sPMmYRJ2SaV461w-1; Wed, 12 Jan 2022 22:19:56 -0500
X-MC-Unique: jNCi_46sPMmYRJ2SaV461w-1
Received: by mail-lf1-f71.google.com with SMTP id d34-20020a0565123d2200b0042ed74cbf6aso2510588lfv.11
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 19:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jm5clb8xIHCpD5vaQkgGsXDJRBF8humGdGQtxPy4P88=;
        b=gDyaXHzOAiqGBhUjeBj7u/6k5VSMWwIAkuFBI1DHphQKTWSN9bnOSNjlo9pt1Jt//l
         T9osQgXQHCtlZ3LOJvsWxp6LiUzOKLDISC644NqH+71VdHwOp2K4RqNXF6UFeRVAZlZa
         5K1BTZv4IvxW6tIlUl+qqWCUSeC/aIBT8OTbwhqulkC6Vyatr1a+W1C76Ihy8pCamXLS
         1qRGPikAYx1QYeWiSPQAsrtmgTH/lWj7Lo/kKbxC2xyQlDsdVVQKpzlSV7b1CVh58IWZ
         x94FcqwIeg8aiZm7NRktytcFvcWrVcYltSVO3qHYG97kOPwVmjIYoVbnBb1ow/wxInnd
         JqTA==
X-Gm-Message-State: AOAM532BcWBi4zVCftYj+Juq76b/2HZ0J7qwq1/g4BQ58MUslo8pEAfy
        L08UNRqP6oDO9abrlMU73wFtp3RfXJ8AZom0O/9oI2xymc/y1sGgPqUOdPEU68xoDkM8vQHlPCP
        whCylFnb694EwrBK160ovLv/F06uL
X-Received: by 2002:a2e:947:: with SMTP id 68mr1793915ljj.300.1642043995133;
        Wed, 12 Jan 2022 19:19:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5cHa/DU7QyIA+QmQtXpznmnfrd2+vdQCDxWpWS7tHq+wUGhwbB0Mc8Mc7keQjtAIC037LniGxAkqy5XbXWaM=
X-Received: by 2002:a2e:947:: with SMTP id 68mr1793905ljj.300.1642043994973;
 Wed, 12 Jan 2022 19:19:54 -0800 (PST)
MIME-Version: 1.0
References: <00000000000081b56205d54c6667@google.com>
In-Reply-To: <00000000000081b56205d54c6667@google.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 13 Jan 2022 11:19:44 +0800
Message-ID: <CAFj5m9LujfHUMv+DuCLUfrevPHuF1NxtMiu_-N-C0VTiY-KNbw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in srcu_invoke_callbacks
To:     syzbot <syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, Jens Axboe <axboe@kernel.dk>,
        bpf@vger.kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 11, 2022 at 7:03 PM syzbot
<syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3770333b3f8c Add linux-next specific files for 20220106
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=171aa4e3b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9eb40d9f910b474
> dashboard link: https://syzkaller.appspot.com/bug?extid=4f789823c1abc5accf13
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b08f53b00000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com

BTW, the report should be addressed by the patch:

https://lore.kernel.org/linux-block/20220111123401.520192-1-ming.lei@redhat.com/T/#u

Thanks,
Ming

