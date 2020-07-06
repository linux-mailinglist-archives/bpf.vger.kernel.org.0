Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B59D215703
	for <lists+bpf@lfdr.de>; Mon,  6 Jul 2020 14:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGFMG5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 08:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgGFMG4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 08:06:56 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDD6C08C5DF
        for <bpf@vger.kernel.org>; Mon,  6 Jul 2020 05:06:56 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k15so22383124lfc.4
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2020 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=GmvaF2RhCemtp0SHPoK89d62E4QZdQfiONp/RHC5qZc=;
        b=E1c75pkQoEn004cTSot2YDXhKmoFqLOQDbwnXZiX2cZF8aP4+EKCce3jctnK0Mod/G
         ynz2szL3SSHM50REGaPHDmk5Gi1/SS5W5pLCr1jTF3l9rJNtPy/WGmSvV2PDUlmJtbdw
         d6j40k0gOYELli+go0P4NUzXq1OiCXD1WS+8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=GmvaF2RhCemtp0SHPoK89d62E4QZdQfiONp/RHC5qZc=;
        b=fO0zOopi4VrY4OF9C/+f39nofEr4pTj4yqOGALbIWA8gH/2ZR69MoXGRFbpblsWiil
         e9t7d/LEdod3dsSh1xhhD8am+KS0l3pkpj+/ie/T67s8TsXfnxjeIFMyHzzh20EHj+5X
         swOOFNXxnFcvONnXu+xHFZQU8TOO62t0dArF0dQkjKmSvMGQ71kCVUZMheJPbGx+Hwp4
         LnIRzHB4M51TrH7nqA5dCqbGbCT1z73kBWrj5iv/GHX1hJOdf+D4JPe9MWegVgDeLyjZ
         VfUuZIgR6eKTg7mT80fjS56lj0Cr1WBQIdaNcm44t2AqgBut9X1w0kZA8GNiZiS6hBhS
         hTmQ==
X-Gm-Message-State: AOAM531pCYST2ogQH/cGxsj4YoSfgPFZkxbIkFGW8O8oBAra8xg/e2Pk
        eMesGvVdjPR22GZuZQz1Pu4Gz/qoTo4/Dg==
X-Google-Smtp-Source: ABdhPJzZehYzGL5uLmeLhfBhO1sQ/k2rbgw4NkjjArUmysCCUhT6cukvfoGbQwSoVrNmvziGGKHmJg==
X-Received: by 2002:ac2:5c49:: with SMTP id s9mr30349121lfp.90.1594037214255;
        Mon, 06 Jul 2020 05:06:54 -0700 (PDT)
Received: from cloudflare.com (apn-31-0-46-84.dynamic.gprs.plus.pl. [31.0.46.84])
        by smtp.gmail.com with ESMTPSA id y22sm2921804ljn.2.2020.07.06.05.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 05:06:53 -0700 (PDT)
References: <20200702092416.11961-1-jakub@cloudflare.com> <20200702092416.11961-5-jakub@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marek Majkowski <marek@cloudflare.com>
Subject: Re: [PATCH bpf-next v3 04/16] inet: Run SK_LOOKUP BPF program on socket lookup
In-reply-to: <20200702092416.11961-5-jakub@cloudflare.com>
Date:   Mon, 06 Jul 2020 14:06:52 +0200
Message-ID: <87h7ukj19f.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 02, 2020 at 11:24 AM CEST, Jakub Sitnicki wrote:
> Run a BPF program before looking up a listening socket on the receive path.
> Program selects a listening socket to yield as result of socket lookup by
> calling bpf_sk_assign() helper and returning BPF_REDIRECT (7) code.
>
> Alternatively, program can also fail the lookup by returning with
> BPF_DROP (1), or let the lookup continue as usual with BPF_OK (0) on
> return. Other return values are treated the same as BPF_OK.
>
> This lets the user match packets with listening sockets freely at the last
> possible point on the receive path, where we know that packets are destined
> for local delivery after undergoing policing, filtering, and routing.
>
> With BPF code selecting the socket, directing packets destined to an IP
> range or to a port range to a single socket becomes possible.
>
> In case multiple programs are attached, they are run in series in the order
> in which they were attached. The end result gets determined from return
> code from each program according to following rules.
>
>  1. If any program returned BPF_REDIRECT and selected a valid socket, this
>     socket will be used as result of the lookup.
>  2. If more than one program returned BPF_REDIRECT and selected a socket,
>     last selection takes effect.
>  3. If any program returned BPF_DROP and none returned BPF_REDIRECT, the
>     socket lookup will fail with -ECONNREFUSED.
>  4. If no program returned neither BPF_DROP nor BPF_REDIRECT, socket lookup
>     continues to htable-based lookup.

Lorenz suggested that we cut down the allowed return values to just
BPF_OK (pass) or BPF_DROP, and get rid of BPF_REDIRECT.

Instead of returning BPF_REDIRECT, BPF program will select a socket with
bpf_sk_assign() and return BPF_OK.

Also, program will be able to discard the socket is has selected by
passing NULL to bpf_sk_assign(). This requires a slight change to
verifier in order to support an argument type that is a pointer to full
socket or NULL.

These simplified semantics seem very attractive. They make the the new
type of behave like a filter that can simply pass / drop connection
requests in its basic form. And with a key ability to select an
alternative socket to handle the connection request when bpf_sk_assign()
gets called.

It is also closer to how redirection in TC BPF, SK_SKB and SK_REUSEPORT
programs work. There is no REDIRECT return code expectation there.

We can even go a step further and adopt SK_PASS / SK_DROP as return
values, instead of BPF_OK / BPF_DROP, as they are already in use by
SK_SKB and SK_REUSEPORT programs.

[...]
