Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82661489D66
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 17:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbiAJQVB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 11:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiAJQU7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jan 2022 11:20:59 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDC8C06173F
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 08:20:59 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t24so7857524edi.8
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 08:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5Y1n4atMmQKmkxovSc1HBRXepMJB8K2VXOHz1SrJQfo=;
        b=c/iZ9IVsXjkdHLCpw8mdod98tYCn7JxallSA/PgldV7FDcYk2seEWwPggEwMf5WxpA
         zb5+XAzBe7WmnzxMiKZof4rjoWMXBxMAAsLnqLvJhiAaKzKjmm2Bg8Cw/1dMsi70V2BP
         O5oGs97zrVj+6oq7hEdps1vYwgchS6k6XYDhsRaBT/+Ztmk2LcgQHKMMjbaBDg+X4xri
         RIdwQ1BpEMeb5/a1bib0dezITqGLh/ed4YNvwq8WnUFwA/+UYlxEljRemNKctrmRxe78
         +TVh+NY+N/yZTp02WDJSPoQcyLoPCB7EhrvtKiFqltxZ98yPoO0HVZHavpKRsCPlUDN6
         ctkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5Y1n4atMmQKmkxovSc1HBRXepMJB8K2VXOHz1SrJQfo=;
        b=fUZEPgTLnL30E3Z9xNOA5RAK/XmczjdX7Go/VhrISiPM0Xgl8ptS0d+C6aUOVFtU8G
         v88xv6AKVV5JADmp/hWDNpByQR+n3gESMiqgD7p7MIT6iDYOKOVfDxyNhRcNpyfJns16
         D125EIPvjgNM3UXVZGxQBcEknfR6nLYMK2PQ1Mj0AQ1H7RQiAsCZG896+YERhOHjxM9D
         OIhSddWk7l/fMxPBC4XhcUG+5fMvouMr0Q1Z54ZcilwvL1Dc9MER8OTIWOXqVf9qMVgt
         jY9zP4D9vClEzaNF00uaWLzqQ8mDuSVK9Z4tQJ9rnYi/PldCMR3+E6udwkVr7i01WHpp
         St4w==
X-Gm-Message-State: AOAM533PAlqIaoFKqKRKp6li5mZO95gplE1SzBN+DisSw/Lpxt2S/ZjQ
        VcqoVqC8LY6xZjRhslF5cQIkCGt9NOJkETvUxk/5TJH/6dc=
X-Google-Smtp-Source: ABdhPJzPiOkH3tAiRa0zhNHbBI5o08tmiu0g1RLlpjInydGx8T3AbEdca9G3B5qO9ne3lHg6tTGIIpIZ/Et0XTs4z80=
X-Received: by 2002:a17:906:bcd6:: with SMTP id lw22mr399530ejb.114.1641831657494;
 Mon, 10 Jan 2022 08:20:57 -0800 (PST)
MIME-Version: 1.0
References: <CAK7W0xe9VVbyVykzTK8X8ieg4UgRJEtrvEyKgLjBO+iVFV41+A@mail.gmail.com>
 <YdOYhsVwGu1p/SSu@pop-os.localdomain> <CAK7W0xezGaA1TZcsxkt_hf+b0LU+396CmetejFBEXjqtvbmDkA@mail.gmail.com>
 <CAK7W0xfX35NSKa_ExcpJkWoy1iX5mU7ogjHbr=T5sHJ9U+D0fQ@mail.gmail.com>
 <61d4b7a06ddea_460792081b@john.notmuch> <CAK7W0xe7QSW4F+tEneqMS26PdTgX83rURiSefnDbRu9WusPDaw@mail.gmail.com>
In-Reply-To: <CAK7W0xe7QSW4F+tEneqMS26PdTgX83rURiSefnDbRu9WusPDaw@mail.gmail.com>
From:   His Shadow <shadowpilot34@gmail.com>
Date:   Mon, 10 Jan 2022 19:20:46 +0300
Message-ID: <CAK7W0xc1+sYTP=CPxe6XmGefsjmHvvd-vD2CUL5Xd22h3ZFc2A@mail.gmail.com>
Subject: Re: Fwd: eBPF sockhash datastructure and stream_parser/stream_verdict programs
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Let's say I'm writing a simple SOCKS4/4a server(yes, obsolete, but
still does it's job), no authorization(although it wouldn't matter).
So I need to read some data from the client: ip and port and maybe
domain if it's 4A. Then I connect to the ip/domain:port and send a
success response. Meanwhile the IP/Domain:port I connected to, before
sending success to the client might send some data, like if the target
was an SSH server, it sends a version string right away if you connect
to it. So it could be missed if I then put client and target socket
into a sockmap/hash and tell them to redirect traffic to each other.
I've tried very hard to figure out a way to use eBPF stream_verdict or
sk_msg_verdict to redirect traffic right when I need it, but I think
it is impossible. Do I have to do SOCKS4/4A parsing inside
stream_parser and communicate with my userspace program via a ring
buffer about the results? But I'm not sure how that could help with
missing bytes. I guess I got interested after I read that article on
cloudflare blog about sockmap
https://blog.cloudflare.com/sockmap-tcp-splicing-of-the-future/ , but
their example of an echo server is plagued with the same problem, if
you put a delay, before socket addition to a sockmap.
