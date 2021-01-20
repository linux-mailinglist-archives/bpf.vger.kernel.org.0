Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5FC2FD64F
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 18:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391740AbhATQ7d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 11:59:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391595AbhATQ72 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 11:59:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96887233E2
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 16:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611161927;
        bh=v7nlydOKYBAsJsCf/q26TX06Nkq+tas/clcVk+BeKwY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mr8z7KGmTnLpFR8cTd1a1UZppJn2Ed67+QxAPSkR7PixEteRf7VExI+pAuf3YrFo/
         FaZ6bPvsPIm2z8lEvHdBK4nStc3wd+EJoDub+NoN4lhxgFt/3Bfe1TTiyZrXXCH3j2
         jwItTQgJCaIfUaRViMeMv3t+eMYPK7eKFUVPV7JEhmqC0IXFgA8Gb+4Y4e4Nsp9tUG
         LA+TOkW250VqRwJkqoJxUkW40bDk8eUn9QvHtE9nObII2Sm/Me8gcmYUIZhrf6l4qs
         yHoxTL59SWg4MBMdmi2ql8rr3jlicKiU5xA10rN/ltxC94KZeBInWGST1p8q1NE+/9
         5NO3V+9cWT/fA==
Received: by mail-lj1-f174.google.com with SMTP id x23so26867085lji.7
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 08:58:47 -0800 (PST)
X-Gm-Message-State: AOAM5333YfPf3ghepCmeeYb8V2ITFax6PmUTBsTTOrw65oxdX+1V5E/W
        Na3EXNPAnAHRRRuouPUi0Y8ANQYln8PWF5Vb9iAK3w==
X-Google-Smtp-Source: ABdhPJwGYgwwaNer71VlQhfBHKFPJd3bzShpGLw4SF5PAAWUJpaYwqIxrKck8//dr5tKm62g8ORkN/W8oB9xBWKb724=
X-Received: by 2002:a2e:9b1a:: with SMTP id u26mr4888757lji.187.1611161925940;
 Wed, 20 Jan 2021 08:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20210119155953.803818-1-revest@chromium.org> <20210119155953.803818-3-revest@chromium.org>
In-Reply-To: <20210119155953.803818-3-revest@chromium.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 20 Jan 2021 17:58:35 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6WisUDuMrb0h8gid4_QGqpCjfURFbz7e=xRgB98LS4tA@mail.gmail.com>
Message-ID: <CACYkzJ6WisUDuMrb0h8gid4_QGqpCjfURFbz7e=xRgB98LS4tA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] selftests/bpf: Integrate the
 socket_cookie test to test_progs
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
> Currently, the selftest for the BPF socket_cookie helpers is built and
> run independently from test_progs. It's easy to forget and hard to
> maintain.
>
> This patch moves the socket cookies test into prog_tests/ and vastly
> simplifies its logic by:
> - rewriting the loading code with BPF skeletons
> - rewriting the server/client code with network helpers
> - rewriting the cgroup code with test__join_cgroup
> - rewriting the error handling code with CHECKs
>
> Signed-off-by: Florent Revest <revest@chromium.org>

Acked-by: KP Singh <kpsingh@kernel.org>
