Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534753D3BE
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2019 19:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405941AbfFKRQu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jun 2019 13:16:50 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:37721 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405855AbfFKRQu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jun 2019 13:16:50 -0400
Received: by mail-pg1-f171.google.com with SMTP id 20so7330153pgr.4
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2019 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=NP0gA1ABckvdSxnswrfwtyDrSN1dU2orYg+qwnAaWU0=;
        b=fCnawsruKXMsyZtdZkLLbAjxXjcWO7UUBt6Go6jNPSUFC0x6uMTddfjQjosUqRo3cO
         Jc0jXjHQrSrU42XNdeRKNRnGLYlRL4ojHXgGpbQbQ2qKmZdFzo/4AHYalAdrhYHi7C3U
         DIE8zAxwbLxyv3krKFvNGd5ECXkYPMKwYaTKLgpvNZ29I7kb9E+A7gnrB2sDf9UTInwx
         bGNgHFFd2sThfwGOP0ESd+1aNMgcut0JC8e11UOnxvAr+PmZX4AE8NB21aH/ZEZeYhZX
         oJWJJ0nyehTcFjqj1YeRUYHo64MDB75LhR3TZucrAmzzKZMykDbkrd4HHajGzSZKqdPB
         BAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NP0gA1ABckvdSxnswrfwtyDrSN1dU2orYg+qwnAaWU0=;
        b=S8+KsfRM4uBaQKo+Zbu39eoCn7tvwgXl6NSxDLOcA7KTDoBQgRhw+NG/uGN8mF1R5I
         1wwfEjSBXrsoXb25BEyPpimWe9KUs0AjjeNrRhH8mgHkgGUDv95RYFLUBuiNsXYl5tDG
         aE8Pw+wg3WrPuvTwsVs4IEw5hpmgULbSIdm/ZjVccg8uS8UY4puaoC6h4ftP8zCULP6M
         9+UrnAdubs5QZCb68wii+fyhKguV76j7PSexyvAi7oLyD7/4695Crp9f38JU/JnJqIAM
         pJEfK+h+oQZBKUw+hUE8iB98ZgrnDi7GjfhL/LK3zd2ryRowsYhTVjXJPin8uEW6/SAa
         m2pg==
X-Gm-Message-State: APjAAAXwkWeUymJuds+LDvWGvf4rBu78DZzvD+mGGvdINw2H0KjeARBE
        785djIoEipIKj2wy7UleSFtorA==
X-Google-Smtp-Source: APXvYqxtEattJ3/+CA3rv8tUikfccZabdw+tyfqO2UmRi4gT3U9+ViUAnX/16vxoTmntuqCAWtc2sg==
X-Received: by 2002:a63:4813:: with SMTP id v19mr14934308pga.124.1560273409434;
        Tue, 11 Jun 2019 10:16:49 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id j37sm13040375pgj.58.2019.06.11.10.16.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 10:16:49 -0700 (PDT)
Date:   Tue, 11 Jun 2019 10:16:44 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+06537213db7ba2745c4a@syzkaller.appspotmail.com>,
        aviadye@mellanox.com, borisp@mellanox.com,
        Daniel Borkmann <daniel@iogearbox.net>, davejwatson@fb.com,
        David Miller <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        bpf <bpf@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>
Subject: Re: memory leak in create_ctx
Message-ID: <20190611101644.267d8e9c@cakuba.netronome.com>
In-Reply-To: <CACT4Y+YX4biKo1nEKh32pJoS9ANNV06hQp5=+w+3GpWQB1worg@mail.gmail.com>
References: <20190609025641.11448-1-hdanton@sina.com>
        <CACT4Y+YX4biKo1nEKh32pJoS9ANNV06hQp5=+w+3GpWQB1worg@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 11 Jun 2019 13:45:11 +0200, Dmitry Vyukov wrote:
> Do you see the bug? Jakub said he can't repro.
> The repro has these suspicious bpf syscalls and there is currently
> some nasty bpf bug that plagues us and leads to random assorted
> splats.

Ah, must be the BPF interaction indeed :S The reproducer text uses
incorrect names:

bpf$MAP_CREATE(0x0, &(0x7f0000000280)={0xf, 0x4, 0x4, 0x400, 0x0, 0x1}, 0x3c)

# ^ this is a map create SOCKMAP

socket$rxrpc(0x21, 0x2, 0x800000000a)
r0 = socket$inet6_tcp(0xa, 0x1, 0x0)
setsockopt$inet6_tcp_int(r0, 0x6, 0x13, &(0x7f00000000c0)=0x100000001, 0x1d4)
connect$inet6(r0, &(0x7f0000000140), 0x1c)
bpf$MAP_CREATE(0x0, &(0x7f0000000000)={0x5, 0x0, 0x0, 0x0, 0x80}, 0x3c)

# ^ another map create (perf event array?)

bpf$MAP_CREATE(0x2, &(0x7f0000003000)={0x3, 0x0, 0x77fffb, 0x0, 0x10020000000, 0x0}, 0x2c)

# ^ but this is MAP_UPDATE, not MAP_CREATE, it probably inserts the r0
#   into the map

setsockopt$inet6_tcp_TCP_ULP(r0, 0x6, 0x1f, &(0x7f0000000040)='tls\x00', 0x4)


That threw me off.

> I've run the repro as "./syz-execprog -repeat=0 -procs=6 repro"  and
> in 10 mins I got the following splat, which indeed suggests a bpf bug.
> But we of course can have both bpf stack overflow and a memory leak in tls.
