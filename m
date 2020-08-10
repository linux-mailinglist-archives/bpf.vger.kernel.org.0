Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E78240D68
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 21:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgHJTEB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 15:04:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37827 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728259AbgHJTEA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 15:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597086238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jgjf2NshHAceA99G9hTTil7sUKhf3WdGM7KeEQ2smd8=;
        b=LRJcsy9HIjaWIIYki4Pa13XC5oEo9pXJA45M/DuGL9iaARtePkRvdLAK8xSLemN7QTkuHm
        P0RLKSYIvaVhBB2b/JxrrEJP52vE/8TjwtpZS/3zSQCLNMBznG4ZTUaVunWUzwTMZGYJMa
        c0KhURxkXdtx2nmEogYONS5UoevRnew=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-nNhwmUuDOBe5Oz7W8wqoqg-1; Mon, 10 Aug 2020 15:03:55 -0400
X-MC-Unique: nNhwmUuDOBe5Oz7W8wqoqg-1
Received: by mail-wr1-f72.google.com with SMTP id w7so4581207wrt.9
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 12:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Jgjf2NshHAceA99G9hTTil7sUKhf3WdGM7KeEQ2smd8=;
        b=CdCNM8Fqm6Cg+pY1LFOfN1H9aC6IydT6uGkCMwGyGBJfGUkY8j1/QE9NDgnbHcKp71
         r4TVi3sPBSk8al0iRSaJ2y+VuQGkLYzBmqiBfXUA+e4zw3lqDvxbKXGg/NwO/y3HV3XH
         n6KrnmNagOXnzEO4p1LZVWCMlfhfK0WlAJGheNSFMf+K5uIXFQ6g3Eh0PIdxUTVMIUA0
         KTMQXGsKMyUNqWsTvAHIo748GkP+bss+oHTSUp1/UbyvmA/kvtKoUXqSRhWZL7qyNZ8n
         K3aBAfZFvsXlbMnkILhCmZWu9/yeWYygv/SiawGJ7kUGyTHrUm3W6rmXXT2M0+dLqbr6
         3evQ==
X-Gm-Message-State: AOAM531OSPJbf0CEGyaHs7TKAYsLUbjyhVxIJUOEbOZpiqNRmtpuq6U2
        3IDIC/Z59ujvVYpVpIdn6xHrv3NV85hVPwtQguKzti3TfNhCQB9G3L0qcJIVN7HCz/Z4xvZip0T
        +5uQPIco4DLr3
X-Received: by 2002:a1c:e184:: with SMTP id y126mr555066wmg.141.1597086234034;
        Mon, 10 Aug 2020 12:03:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF5VEVaO8RQpZHKKvjl2zgFvHMR0mhQHML8IsXTpk7OixAn7Tw4J651/QIuYp1uNfh8Ka6UQ==
X-Received: by 2002:a1c:e184:: with SMTP id y126mr555054wmg.141.1597086233865;
        Mon, 10 Aug 2020 12:03:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d11sm22161320wrw.77.2020.08.10.12.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 12:03:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D607B18282F; Mon, 10 Aug 2020 21:03:52 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/5] BPF link force-detach support
In-Reply-To: <CAEf4BzZMC4LWpgOMBgKaLAGLPmt4rz0D7_sNC+i=yaVhEtDG9g@mail.gmail.com>
References: <20200729230520.693207-1-andriin@fb.com> <874kpa4kag.fsf@toke.dk> <CAEf4BzZMC4LWpgOMBgKaLAGLPmt4rz0D7_sNC+i=yaVhEtDG9g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 10 Aug 2020 21:03:52 +0200
Message-ID: <87mu322uhz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

>> BTW, I've noticed that you tend to drop Ccs on later versions of your
>> patch series (had to go and lookup v2 of this to check that it was in
>> fact merged). Is that intentional? :)
>
> Hm.. not sure about whether I tend to do that. But in this it was
> intentional and I dropped you from CC because I've seen enough
> reminders about your vacation, didn't need more ;)

Haha, that's fair ;)

> In general, though, I try to keep CC list short, otherwise vger blocks
> my patches. People directly CC'd get them, but they never appear on
> bpf@vger mailing list. So it probably happened a few times where I
> started off with longer CC and had to drop people from it just to get
> my patches into patchworks.

Ah, I have had that happen to me (patches not showing up on vger), but
had no idea that could be related to a long Cc list. Good to know! And
thanks for the explanation - it's not a huge issue for me (I do
generally keep up with netdev@ and bpf@ although as you can no doubt
imagine I'm a wee bit behind right now), was just wondering...

-Toke

