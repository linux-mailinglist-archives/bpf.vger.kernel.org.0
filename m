Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1DCB4B7
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2019 09:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbfJDHBL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Oct 2019 03:01:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27860 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388483AbfJDHBK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Oct 2019 03:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570172469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+SV3gwAgG40O12ODD6m4hgfyWqz5XOp/AVtX54TzA0=;
        b=g7Wc+5LXaGsBrgknEX3JIncgBy6aXGuvSHVz9v9vL4eOjbz2kV9SkP5aiV2gRF+SkRCm8i
        pmL+99PUJPTp6fr0yXs18SKCLqcX/2CUoGpJqCVmZIAIrAA/pKwWJaXO/Uwy9kzDPMrA2o
        xQkovMZUVfLgQzC6OwQ/VvN9EmdlBfg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-9QOyyCyzOgaeaq_cVL_u-w-1; Fri, 04 Oct 2019 03:01:06 -0400
Received: by mail-lj1-f198.google.com with SMTP id w26so1488477ljh.9
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2019 00:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/+SV3gwAgG40O12ODD6m4hgfyWqz5XOp/AVtX54TzA0=;
        b=gXTw1y3NFK7l4juy1FUBRvaE2fL6oLleSkzS2XUZL0YAKD1GAPST0zuHO7ssx/AdR2
         hD2sZqCYC6K+uKeyrWXHEJzFI3dgaIHW5cMIN2zdY+kR7vCi+xF1EoZe1P6WDXrTOZ4N
         9TzQxsBQqdb6RmE7Ku10rdON5gew4hZktuaaZWO/kJo9saeGod3FxIMlykznMoQqPEQz
         qk6CpBihkkJGe1la1j6J+gsWgc8ntEZA5BPsrizmFW/XOBkLxLaSns8FRLVBO7EOArH9
         z2Th1cz/mc7lhNzOURf2pNU0FUbAW5wfXnc7/r6uIdo8MZUwC8cTHR4TXaGoA7mGOjGX
         tpog==
X-Gm-Message-State: APjAAAV9gZu1uryGuC+oSR6vXlyglXrU2cvVTLJvjS6TS4jsrb4zDTlk
        yfzwfklFoNKBkioo7Ycbt9B6SOOFRgkgnlReSx8km6AbbIIwJVdIh/dyCeUETR2aZ2PHpBIA76r
        onJbWpXJIyYgg
X-Received: by 2002:ac2:5dd0:: with SMTP id x16mr8229981lfq.38.1570172465027;
        Fri, 04 Oct 2019 00:01:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1QeWf7qCaEUQw/EZn5p2xaig4KIQMBOZvCAl1WITohaIjLZwXE214T++os9E/VExNP+M07w==
X-Received: by 2002:ac2:5dd0:: with SMTP id x16mr8229966lfq.38.1570172464735;
        Fri, 04 Oct 2019 00:01:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id e10sm1060746ljg.38.2019.10.04.00.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 00:01:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 810E018063D; Fri,  4 Oct 2019 09:01:03 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v3 bpf-next 4/7] selftests/bpf: split off tracing-only helpers into bpf_tracing.h
In-Reply-To: <20191003212856.1222735-5-andriin@fb.com>
References: <20191003212856.1222735-1-andriin@fb.com> <20191003212856.1222735-5-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 04 Oct 2019 09:01:03 +0200
Message-ID: <87zhihngeo.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 9QOyyCyzOgaeaq_cVL_u-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> Split-off PT_REGS-related helpers into bpf_tracing.h header. Adjust
> selftests and samples to include it where necessary.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

