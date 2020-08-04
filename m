Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF423B1E5
	for <lists+bpf@lfdr.de>; Tue,  4 Aug 2020 02:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgHDAvJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Aug 2020 20:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgHDAvI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Aug 2020 20:51:08 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF439C06174A
        for <bpf@vger.kernel.org>; Mon,  3 Aug 2020 17:51:08 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id f68so10874809ilh.12
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2020 17:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVYHTG9/w1sACeSgc1h5/Ki3DkFWvo5hFp+R1gPI7EI=;
        b=QnFoBuZw2lctRlF7jBapcgeWW7MifnN91E0aFgNXsQ5UHbglhQJK5VOiZgmR0F3oe5
         2fdrb0H5ZbZajP8EiVZCJaLpxfncSN38rayPHmXIYU71TMZkegHkvsmuPrgc7hIDGzQb
         6CMsURWtoUyZXeQTL93LxnvqHO6lWvC2qcXlEkE0u8Z92k8SxSjMPOl34KpDVxdn6vjp
         rJoDtBe8yIElIYvCVq70N7YcDc5pakmnamMuoO73jMLujBE8LZEorkcyWer7sQE+/SO4
         /rhcn7zk+FFBL5lSD1S/wqCXo+42vL4X4xrj0iNT8bQirU4Z3Qrvyx444kddrOfEcnGu
         c6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVYHTG9/w1sACeSgc1h5/Ki3DkFWvo5hFp+R1gPI7EI=;
        b=FNYwzkRF8mR+9gbHsjQNOsSvbl67FlTpRrTzDGmE/zURLyE3Iqo9P68vOwRZXQKpuL
         ipcD12itMJLiYJOq/Hr3PkvRHQtkg+sQb2AFKR+9QCurnh/xPLOBN5n8UTHbJihj4BFD
         MtjXuDA2El24bqJjWhrzY7jOok/JIEVjSNQOyNEJ3NlPalNpjTwp0mQQs+hk5Cu8Ozih
         BnpfcIoTNtCR3CNOGWY+tiqvRc0PGMX1rBAIIDENB/7GPH30zD5vnpCDEG91ubucp4UR
         FWueGTLC+SAOhKi/XfYj9jM+Ac4rT5msoZNABF5+8vymsOVWbAKQyhWqjRyqE4QS2Bt/
         raMg==
X-Gm-Message-State: AOAM530SyBWhIEFm4lQ0flMSZ0wh6bbiZ8G+VV/phrPUlksNOrYTvy+U
        aJAmIOcdeTS9TPiPCYRXGYDFx/BYhect6AdVrCqpPQ==
X-Google-Smtp-Source: ABdhPJx8SqMNWIYmmj4SoVpcYDpD2gLZQlRPvWatIGPGFyczj08/U8IRBcG93CmFDsQ9mkzMdz1Z9lQYBJW5uKUTomg=
X-Received: by 2002:a92:d781:: with SMTP id d1mr1991499iln.68.1596502267851;
 Mon, 03 Aug 2020 17:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200803231013.2681560-1-kafai@fb.com> <20200803231051.2683561-1-kafai@fb.com>
In-Reply-To: <20200803231051.2683561-1-kafai@fb.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 3 Aug 2020 17:50:56 -0700
Message-ID: <CANn89iLipQWyGB9WVyK1ub48q31oEe9Pn=9RB_D21vTCs6r_vA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 bpf-next 06/12] bpf: tcp: Add bpf_skops_parse_hdr()
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 3, 2020 at 4:10 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> The patch adds a function bpf_skops_parse_hdr().
> It will call the bpf prog to parse the TCP header received at
> a tcp_sock that has at least reached the ESTABLISHED state.
>
> For the packets received during the 3WHS (SYN, SYNACK and ACK),
> the received skb will be available to the bpf prog during the callback
> in bpf_skops_established() introduced in the previous patch and
> in the bpf_skops_write_hdr_opt() that will be added in the
> next patch.
>
> Calling bpf prog to parse header is controlled by two new flags in
> tp->bpf_sock_ops_cb_flags:
> BPF_SOCK_OPS_PARSE_UNKNOWN_HDR_OPT_CB_FLAG and
> BPF_SOCK_OPS_PARSE_ALL_HDR_OPT_CB_FLAG.
>
> When BPF_SOCK_OPS_PARSE_UNKNOWN_HDR_OPT_CB_FLAG is set,
> the bpf prog will only be called when there is unknown
> option in the TCP header.
>
> When BPF_SOCK_OPS_PARSE_ALL_HDR_OPT_CB_FLAG is set,
> the bpf prog will be called on all received TCP header.
>
> This function is half implemented to highlight the changes in
> TCP stack.  The actual codes preparing the bpf running context and
> invoking the bpf prog will be added in the later patch with other
> necessary bpf pieces.
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
