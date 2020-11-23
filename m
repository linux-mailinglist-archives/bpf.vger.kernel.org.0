Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19C12C1220
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 18:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbgKWRgu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 12:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388448AbgKWRgu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 12:36:50 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55A2C0613CF
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:36:49 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id d17so18974402ion.4
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ff4vhiOtoTFqg67U0xy16Cf9hTZctC7vbQn+QBcOK9c=;
        b=t3oB71JLTk25rt5N3Mv40X9vKuJtML3jwwsStJl64i/e8RCQeZ9BnySPaqlfu44R9O
         FO0lm8YWGd63DuXQKVZp6AvYIMfH1WFFPuXe0eFDcW+fe2MV1+yEB/NCVOpwTN8ZDE4E
         zZFhC2f/rjWrP0WUGGjHiH9nm9Su7xGDSsa7I+hNXhB9rVtVXCcupG5e/WTFXf8p7P0G
         2HKpvEg+CjIT7gH+qQGMjepYgrVomyDArVqo1BP4qBKT9xVqJPODSyERt8U0IZn6CnpW
         0r1rjFjzeSmLeTkFxsfvHter3sc+dkNUSStGwsgQ+crmve/X5hBx0d8WzoA/aj2Leiws
         cvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ff4vhiOtoTFqg67U0xy16Cf9hTZctC7vbQn+QBcOK9c=;
        b=R3FxFFNv8kRLQDP3bzvnz4QFauKDt+IPSbbYF6RMf6gSAOmodMbrK9l7u/IkDlBXWA
         l44IjuDPEekuhgbvuHfz0ZjjsmuSZy7ePBiRwxF3ehJcNVCCZEc0SJOC54IuzAFh9D6o
         pSY0Ylqs2Yf68rAlmo4OznjUPFveZzFPlk4IrIhKgkwOWGL4iUnVP3WWmlT1DFB5bN0v
         vvovVF904p7YEF8ikUb0lzm4V7G1EyfnKPw5GgtOfV3nsP40oLBvbi1fnPA0SaO5i1v8
         AIxSarDTL2hYmGEmHktvqgiXYmB4zubF2AW5OUoqO8aCxyyaKlHRemmOlhvnLliBavMS
         QmMQ==
X-Gm-Message-State: AOAM532Apc3AvikIxq1g2+gs3H+stjpJ/TMpDa1A+pSsZfsnWFou+zQ1
        BGmsXhESFzxOImfv8NDznZQ1Ff78eIJGJscFk8BjJ4uvqeK6xg==
X-Google-Smtp-Source: ABdhPJxiA2IR2KVMYyUAmsjTdayRphsGj0qgJmQZ+mKrjD6i1axI99P6PxErhV/cTPKPnm+Baem3imJrapQVW0MKIIc=
X-Received: by 2002:a02:6a5b:: with SMTP id m27mr615640jaf.58.1606153008962;
 Mon, 23 Nov 2020 09:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20201123173202.1335708-1-jackmanb@google.com>
In-Reply-To: <20201123173202.1335708-1-jackmanb@google.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 23 Nov 2020 18:36:37 +0100
Message-ID: <CA+i-1C2Mbr6p9RoReUKAcdJ29s+vFhYe4v5sHWFoed6kj_q+tg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Atomics for eBPF
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Agh, sorry - should be [PATCH bpf-next].

These patches apply to commit 91b2db27d3ff
