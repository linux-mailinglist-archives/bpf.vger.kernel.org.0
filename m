Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539572C6AB7
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbgK0Rir (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbgK0Riq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 12:38:46 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1090C0613D1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:38:46 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 62so4820768pgg.12
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=b0PD3VXFRIXXsyv+AGcr0zgIWVDd+gNQbTfr0RKXdRA=;
        b=TGfsZgI1jTAQpbJ4NcYkrwmzBLpPGpUpUdKr/le3u3oAmZdsBtV0xIVVdVA+hUwwTv
         hhj4ySP+tWXCUk2BwinXSQmZPzybI9zp0Ka8BBXOY1ePbD6+KBaSuAGCt4WsRdqZ8c5G
         iPlvL3FiKjDYdG14kx9oWEqCZJOO0ZjpESuueuLyw3Xvs3/I7ELIcZMZCyJDTSO/1FGf
         CLnpq7WLtEWmhRdZWSDRNFhQDY46ohQFShZJBrpddfFJHcThxdaOi0l1gEn0xYRztocH
         6ZMPc0u/wBJGqMJySpSUbVX2UtVzahNzyRqZlSmOhLhUhx9+dWMu8yJJ/uiEyy5JX1kd
         drvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=b0PD3VXFRIXXsyv+AGcr0zgIWVDd+gNQbTfr0RKXdRA=;
        b=bIKybO6j7XuTFgHG/0PLitN669F3XUbnAWvnnYfUDOusIu4MXIqDvhYLgtM8o92LeQ
         cO0nGK4WuvQQlLQGTvMpUsdC6u8LpPZmtEerMx6uxaDNBjNyVMlEpc0CeBfppCwx/gE2
         T2wmoLBFb1ouBM5mh+Na/DhSzB8mY/HfVLtEiytn/qXGngFHktVKzueWisIUQ8pWbuKy
         5pNV9JL7xIek/oD00B1cuEUhsXUnWfaBwRDfWb8qEr3zhhKPHGSwsUMlamDfHQInUR8N
         VzLraRdC5tx+SnupyWYIsvRNZxpN8BKppuj9R0D4cpmVp9f5tVyx7DQHzPtL0rN8D4xm
         mIEg==
X-Gm-Message-State: AOAM533z3cb49APUhfZ29VUluwMDlzAjbkLR9O+GKMUALG8fZpThdXLJ
        oV+AMEplYnKKX3ewMw3Go9L7WhXZcpVb4I1Kkp/bXohixgt3xaT1
X-Google-Smtp-Source: ABdhPJzRbLDNDQ3lOgVS528D8PKb8ZDESYFPLO88SZMv3JC9l0eDL9NBuO/CT5raD/kgDlPdtXFBbaL/bbQfhvQBfVA=
X-Received: by 2002:a17:90a:de81:: with SMTP id n1mr11378552pjv.52.1606498725586;
 Fri, 27 Nov 2020 09:38:45 -0800 (PST)
MIME-Version: 1.0
References: <CANzUK58dwpX9HjfCZTyZa4oJX2iAczYEfQe5ojW1N_0NrYW7mw@mail.gmail.com>
In-Reply-To: <CANzUK58dwpX9HjfCZTyZa4oJX2iAczYEfQe5ojW1N_0NrYW7mw@mail.gmail.com>
From:   Srivats P <pstavirs@gmail.com>
Date:   Fri, 27 Nov 2020 23:08:34 +0530
Message-ID: <CANzUK5-g9wLiwUF88em4uVzMja_aR4xj9yzMS_ZObNKjvX6C6g@mail.gmail.com>
Subject: Re: How to read from pkt_end?
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

> How do I read from the end of the packet in a XDP program? I tried the
> below ebpf program to read the last 4 bytes of the packet, but the
> verifier rejects it.

Got it working with some trial and error - the trick was to AND the
calculated offset with 0x3fff - largest value for a packet size that
allows 9K jumbo.

Here's the working code -

__section("prog")
int xdp_prog(struct xdp_md *ctx)
{
    void *data = (void *)(long)ctx->data;
    void *data_end = (void *)(long)ctx->data_end;

    __u16 len = data_end - data;
    if ((data + len) > data_end)
        return XDP_ABORTED;

    __u16 ofs = (len - 4) & 0x3fff;
    __u32 *mgc = (__u32*)(data+ofs);
    if ((mgc + 1) > (__u32*)data_end)
        return XDP_ABORTED;

    if (*mgc == 0x1d10c0da)
        return XDP_DROP;

    return XDP_PASS;
}

What clued me onto the AND thing was the following lines in
Documentation/networking/filter.txt about overflow -

    Operation 'r3 += rX' may overflow and become less than original skb->data,
    therefore the verifier has to prevent that.  So when it sees 'r3 += rX'
    instruction and rX is more than 16-bit value, any subsequent
bounds-check of r3
    against skb->data_end will not give us 'range' information, so
attempts to read
    through the pointer will give "invalid access to packet" error.

Without the (superfluous) data + len > data_end check, LLVM was
optimizing the code in a way that led to scalar arithmetic which the
verifier wouldn't allow.

Of course, the ideal way to work backwards from the end of  the packet
is to allow arithmetic on pkt_end (so you could do `ofs = data_end -
4`), but there may be valid reasons not to allow that, that I'm not
aware of.

Srivats
