Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7177943FAD6
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhJ2Kiv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 06:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231719AbhJ2Kit (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 06:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635503780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zTf+kP+TTNJjwaC8Adr///Yv4cYdq6F0Z4nTu/ogXo=;
        b=UBT1VhUv2hHzpbzRWrKQjXKpMr5j1Spq7kSBBZ94Il9/TpB6nkAnMM+EeMlj8WwvOYigiY
        lznhYedekIEgTTQWM8tY0GYH+orxpGo84h69n6zCMyvpEJ5ZYrMhwHHw8SGkxygQeBmkjO
        L5IGRAFFQTzdUcJY2dYxShktI1BgCmw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-Sgvw0Yq5NpCDqWT2W2eZEg-1; Fri, 29 Oct 2021 06:36:18 -0400
X-MC-Unique: Sgvw0Yq5NpCDqWT2W2eZEg-1
Received: by mail-ed1-f71.google.com with SMTP id x13-20020a05640226cd00b003dd4720703bso8799334edd.8
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 03:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6zTf+kP+TTNJjwaC8Adr///Yv4cYdq6F0Z4nTu/ogXo=;
        b=opHgOnDjNx3eln2mHKGNi986HVuk3qTIsH0k4K05SKqFRTi4i5zck53ZX1u++JdetO
         Sw01zuCoY8ys821YfZqNGOnQyCO9Ff3kWj6rLwl46sshCPQl6CZxiH94F3wxcWrco7ye
         5Mjyydauhv51qNSQ3GTEMxJxFfg+uy5/JYzuvVMiQovrPylu+DiUQYMCdamuF9ebWaZv
         FYxxCG54sUmDwDnlN6hmRwM2UIulpY70ysGjrAs5VM8Eol3B+gEERlXnRAUN/H1DIhw+
         x6X/VIo+7A/gM1ZjXd6HLgSvu8gvmuJUOPhZMXn3sSzGH2xCLca3prt4pacCyeDSsMmm
         iNVw==
X-Gm-Message-State: AOAM533piQCnvJGAOS+u94JpAnvJycn9khtNQSDhK3walCYC0CY7sGaf
        VMajfHlnbBIE0xByU/KdsUANTlJjvCWv0kn6HpakmV/vQ6JQm/w430Lb5nKU8brTgoIVYo/uG+8
        PaZgKnOCiPKeH
X-Received: by 2002:a17:907:868c:: with SMTP id qa12mr12174756ejc.346.1635503776888;
        Fri, 29 Oct 2021 03:36:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0vSAUG187MJcKLC8ZiB6qmj2025d/UW8QZOcijvFGVGylan+cJPkDv+Ymiqz0I7USKh4+xg==
X-Received: by 2002:a17:907:868c:: with SMTP id qa12mr12174639ejc.346.1635503775911;
        Fri, 29 Oct 2021 03:36:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a9sm3281830edm.31.2021.10.29.03.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 03:36:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B1970180262; Fri, 29 Oct 2021 12:36:14 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        maciej.fijalkowski@intel.com, yhs@fb.com, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org
Cc:     jonathan.lemon@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] libbpf: deprecate AF_XDP support
In-Reply-To: <20211029090111.4733-1-magnus.karlsson@gmail.com>
References: <20211029090111.4733-1-magnus.karlsson@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 29 Oct 2021 12:36:14 +0200
Message-ID: <87mtms86e9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> From: Magnus Karlsson <magnus.karlsson@intel.com>
>
> Deprecate AF_XDP support in libbpf ([0]). This has been moved to
> libxdp as it is a better fit for that library. The AF_XDP support only
> uses the public libbpf functions and can therefore just use libbpf as
> a library from libxdp. The libxdp APIs are exactly the same so it
> should just be linking with libxdp instead of libbpf for the AF_XDP
> functionality. If not, please submit a bug report. Linking with both
> libraries is supported but make sure you link in the correct order so
> that the new functions in libxdp are used instead of the deprecated
> ones in libbpf.
>
> Libxdp can be found at https://github.com/xdp-project/xdp-tools.
>
> [0] https://github.com/libbpf/libbpf/issues/270
>
> v1 -> v2: Corrected spelling error
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

