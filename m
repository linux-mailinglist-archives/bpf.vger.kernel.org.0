Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246342FD63E
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 17:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391507AbhATQ6I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 11:58:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391708AbhATQ6C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 11:58:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1821233EF
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611161831;
        bh=sgxg0KRaG8bJzZjpq2ut3g06MpeRf3aA7NcuVdFZ148=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jI7DkmFAMvHXTd7F7JUwVHvA0PxFY7hKHd/ppPeOf1xGCQhifgO6j9my6ilPdYMcg
         bneOjo1Qb5JYgpPcU6OFs9oIOIBJ/9//q2ic/7eZvUwycMr8z7rMfREe2nCrQDJ4h5
         CVIdW/g2E7GN2llyyhZWjMAUnmUbt8v9r7QRveqJZXXKf63yWIaxTkSN+atIy1iv66
         Z9W16CsicEFqaOrMQ9DjtHat8ICojK7tF/IqNt0xa7ZA48GM9C9BPl3L1/4Fw5Iym+
         XfWHX5Tbm+dRROfvQUMOZvARgfPHo/lMtLM+q2BBsbX7TzhTL8CqkuQnihtk6DDarS
         zh4YVizn+fxow==
Received: by mail-lj1-f181.google.com with SMTP id b10so26890032ljp.6
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 08:57:10 -0800 (PST)
X-Gm-Message-State: AOAM532ojMxauUMv7hTFjM5SCiH/hPCtgxncH/HPZwjBXhwYpHVcceXQ
        Y0Iw3yLk5Pb3U+erXjiQG68KXVzO291W/tOD63NdwQ==
X-Google-Smtp-Source: ABdhPJzXDYBw9PcIkOEX6HhjsVsXy86y4A+K/8CU3oGNWcGtFsOHSubaZwXiOHF0TSOd1v3dILiKjmLzJl3bNj1q+gw=
X-Received: by 2002:a2e:870d:: with SMTP id m13mr4726784lji.136.1611161829317;
 Wed, 20 Jan 2021 08:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20210119155953.803818-1-revest@chromium.org> <20210119155953.803818-2-revest@chromium.org>
In-Reply-To: <20210119155953.803818-2-revest@chromium.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 20 Jan 2021 17:56:58 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7ZC1T7kBnjaU0-4=0-dsQ8_3pS_6r7Mb4mjPPhYKZjLw@mail.gmail.com>
Message-ID: <CACYkzJ7ZC1T7kBnjaU0-4=0-dsQ8_3pS_6r7Mb4mjPPhYKZjLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/4] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 19, 2021 at 5:00 PM Florent Revest <revest@chromium.org> wrote:
>
> This needs a new helper that:
> - can work in a sleepable context (using sock_gen_cookie)
> - takes a struct sock pointer and checks that it's not NULL
>
> Signed-off-by: Florent Revest <revest@chromium.org>

Acked-by: KP Singh <kpsingh@kernel.org>
