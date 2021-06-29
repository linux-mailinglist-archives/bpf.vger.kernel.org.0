Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072413B7770
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhF2Rxu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 13:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232307AbhF2Rxs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 13:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624989080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sbch0FPTkhw9Zxp1G0Mtw4Jcb2D1KY3NaBDLJ9+m2Eo=;
        b=fUZlvPzcoCwjs93LqOUYo4YySuP+biBHEGLCBCuVn+ymDp3oNbPF3KXBiYVvMs8cZvUTTZ
        koD7v9fTe//EpvPjJV7l+0fjGu8XvXlwzsP3ib/4H6Zpa2cui/1dORKZjc5QbwUUlqxKEy
        WsY6iXdUKQ1R8/9Z6x10ntw0TLWHjVg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-lBstIApyPmCIBGizCsBthA-1; Tue, 29 Jun 2021 13:51:16 -0400
X-MC-Unique: lBstIApyPmCIBGizCsBthA-1
Received: by mail-wm1-f72.google.com with SMTP id z127-20020a1c7e850000b02901e46e4d52c0so1588624wmc.6
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 10:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Sbch0FPTkhw9Zxp1G0Mtw4Jcb2D1KY3NaBDLJ9+m2Eo=;
        b=Ppn/bB8WlGFSt1HCpCDbgOeRkRSVXErwDxL8FmnRqKqRzWd9nEglWmo/SinYBoP31w
         b5wzmqkryFWp3fBXGl6MsXfBAb1APlfnoPuEA1zmKhCxDAd+sf49Nu4BbTPMYu+55JQL
         k0vDHbMdqK+/e28GSsjyj+tq8ARSaTrImezD3DXTdbnwbb4cBJ9UTBi5Ki5mjCZZGKOf
         ZWHhpIf3QG3R1JweO/lb2XhT2ybP7v0c8EY8s5jJNtoDS7F6U3oSY3G4aMfPfTtxO6m6
         s9/0ykLR3ImZ83/MEXNDeg7rSuDTWgJb/vpeuPXcLnlWKEmzyUxcDDNTz4P/EGn7wap7
         LCTw==
X-Gm-Message-State: AOAM530jd+7APEZaTATtoH4GE2tJgYPm6zZufiYh7lpKwY18sObJF5Yn
        0BB+eyfXz1V+OFz/uUWM/WLaNo2UXbsYYQA/7+ZSNcG2WYAZbjJKYTq6h1HU948jvo0QdLndPQ7
        jcEwDbHpT46fR
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr33927367wmq.138.1624989075383;
        Tue, 29 Jun 2021 10:51:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkQIEK9ahXR3RumsilZjHEuXd2/Fgc88oxrJ3F64TQa7g8J02cTpI43T5qWoRo5v/X3+dDww==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr33927353wmq.138.1624989075195;
        Tue, 29 Jun 2021 10:51:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b9sm22313120wrh.81.2021.06.29.10.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 10:51:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F16E118016E; Tue, 29 Jun 2021 19:51:13 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
        bpf@vger.kernel.org
Cc:     David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH 1/3] bpf: Add support for mark with bpf_fib_lookup
In-Reply-To: <CA+FoirAaqbnYan2NEQVaxZ2s_brPNZ02hRFhW9miyfqn+KVGbA@mail.gmail.com>
References: <CA+FoirAaqbnYan2NEQVaxZ2s_brPNZ02hRFhW9miyfqn+KVGbA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 29 Jun 2021 19:51:13 +0200
Message-ID: <87wnqc1rvy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rumen Telbizov <rumen.telbizov@menlosecurity.com> writes:

> Add support for policy routing via marks to the bpf_fib_lookup
> helper. The bpf_fib_lookup struct is constrained to 64B for
> performance. Since the smac and dmac entries are used only for
> output, put them in an anonymous struct and then add a union
> around a second struct that contains the mark to use in the FIB
> lookup.
>
> Signed-off-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Rumen Telbizov <telbizov@gmail.com>
> ---
>  include/uapi/linux/bpf.h | 16 ++++++++++++++--
>  net/core/filter.c        |  4 ++--
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ec6d85a81744..6c78cc9c3c75 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5925,8 +5925,20 @@ struct bpf_fib_lookup {
>   /* output */
>   __be16 h_vlan_proto;
>   __be16 h_vlan_TCI;
> - __u8 smac[6];     /* ETH_ALEN */
> - __u8 dmac[6];     /* ETH_ALEN */
> +
> + union {
> + /* input */
> + struct {
> + __u32 mark;   /* fwmark for policy routing */
> + /* 2 4-byte holes for input */
> + };
> +
> + /* output: source and dest mac */
> + struct {
> + __u8 smac[6]; /* ETH_ALEN */
> + __u8 dmac[6]; /* ETH_ALEN */
> + };
> + };
>  };

Looks like your mailer mangled the indentation of the whole thing.
Threading is broken too...

-Toke

