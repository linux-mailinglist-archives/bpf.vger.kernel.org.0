Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671312D454F
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 16:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgLIPY4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 10:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729894AbgLIPYw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 10:24:52 -0500
X-Gm-Message-State: AOAM530A0prqfr/7oVe/wKqQFN0LosLiVBBgzGYSen4NcP4KfQzBRqla
        VI0zC6oy5I2tI56AJ0AuwaI9iPkOK1GfF/FC7cZjwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607527452;
        bh=+dXI+bpx4dnaTYf5igVjStgYvCfJ0BEDZGFbpTVmtxE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eL3C/FLF45GyK9oe47qbVFU4xEUNTzBuEf8biAee4dVkAAQcasA7yOP8rFNyZyE/n
         sv9eHOn4s29Njzd1V6Knxfosb3MCAEyU+5qTUgQZgCj4EX3TkkQsRnLzhlu+26/4pH
         76c2IWFC8ek+1rPK/i5yIWKwbUP5vQl0REQvoL1rNRj3NK+hv+Wbm1zaWMyvu2No3R
         kh4dU/CNJaCLs/zQuwndHNL1JiSX+U+dO+9289EFxCv/QyOU+XEi+T4e/WwoZWU4W8
         H0XsT8z67p8dQ9jkjR2RIcOUujrhPzbtukFbabYkptZGLuPtrG2/fbk+aHhEBfviFc
         V4mKqErlYSaHQ==
X-Google-Smtp-Source: ABdhPJzO1xxGSE3TeUyPtZqx87VH61OUOrOKxLclNwlNTe1YN6+iqHWrVur5Iq75ZqI8mPoMOcm3CWtxazp2WuPxwSg=
X-Received: by 2002:a19:8343:: with SMTP id f64mr1192727lfd.542.1607527450100;
 Wed, 09 Dec 2020 07:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20201209132636.1545761-1-revest@chromium.org> <20201209132636.1545761-2-revest@chromium.org>
In-Reply-To: <20201209132636.1545761-2-revest@chromium.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 9 Dec 2020 16:23:59 +0100
X-Gmail-Original-Message-ID: <CANA3-0d_VqjXUc0LBwc1f7Js9NfV_ZRp8e=tQ-q5-EWjRsqFYg@mail.gmail.com>
Message-ID: <CANA3-0d_VqjXUc0LBwc1f7Js9NfV_ZRp8e=tQ-q5-EWjRsqFYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org,
        Martin KaFai Lau <kafai@fb.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 9, 2020 at 2:29 PM Florent Revest <revest@chromium.org> wrote:
>
> This needs two new helpers, one that works in a sleepable context (using
> sock_gen_cookie which disables/enables preemption) and one that does not
> (for performance reasons). Both take a struct sock pointer and need to
> check it for NULLness.
>
> This helper could also be useful to other BPF program types such as LSM.
>
> Signed-off-by: Florent Revest <revest@chromium.org>

Acked-by: KP Singh <kpsingh@kernel.org>
