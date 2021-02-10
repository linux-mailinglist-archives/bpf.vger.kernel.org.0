Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3881C31719A
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 21:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhBJUpQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 15:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhBJUpD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 15:45:03 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A86EC061793
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 12:44:22 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t26so2026634pgv.3
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 12:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMVGhI9++wS+Kt4DIl8uy7OJgJhgaTXof7QAYp/rX/s=;
        b=D/NgsJvYNnPktQ2xK8HvwiC30gvulg+54GQeol4ZNq0srigvxnCfhpME6D/XguddvK
         6KSpxrMLrciruY9sNXrk3YvPOH/20RopXdwEFOSeO7Fq1ko5lfwwLxdAIgdW1jpQ6QLk
         mFXkvV/nLQkjG4mfYp/U1d8n1KCG6jv93aviI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMVGhI9++wS+Kt4DIl8uy7OJgJhgaTXof7QAYp/rX/s=;
        b=TWviLCFN/Ae7QhME9HB9qqoZHYDiqMt/J9o5WP3V4Nvk4JArOMW8B3zKh3EC1/L8fE
         FJ4N+PQ43A3lTohSzEU4Qt1jBlqG9i2mmnUb1V5f/ptXTosFvvoazEH4VHnEiMBttCuS
         JApWz9oxV8GSEF0RR3b5beYmPldYbBYTArOXuey9XgrGns/4FEmlzOnrNM4wTdFW2P/m
         wC1wV1/q1r9y1Llf3rlig0y00qjhUMeGKe9hR64EoJOzpwpm6150IsoooYByt3DBYe1R
         5fNhtn5PyWGLP8RrdbJA+xUB997edecbfmmN12vWfpYfqqmb2gRXlZjm4cs7PMtHJH4k
         LeVw==
X-Gm-Message-State: AOAM531qOeavkxY2zdatTAkE1BstLFyw4knBTbIN+0MfQM4YTXZGKIUG
        Vr/Xuy+INGUOjRdMYN66oP/BNA==
X-Google-Smtp-Source: ABdhPJyYhZykAX8Eic//chi7N7csGZxtVY9QVjUmn4AhnOhq/8mIzgSuJoHTyraUUVDxsigJ98HMBw==
X-Received: by 2002:a65:5b47:: with SMTP id y7mr4708626pgr.221.1612989861966;
        Wed, 10 Feb 2021 12:44:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b6sm2763247pgt.69.2021.02.10.12.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:44:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     wanghongzhe <wanghongzhe@huawei.com>, luto@amacapital.net
Cc:     Kees Cook <keescook@chromium.org>, bpf@vger.kernel.org, yhs@fb.com,
        netdev@vger.kernel.org, ast@kernel.org,
        linux-kernel@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com, kafai@fb.com,
        kpsingh@kernel.org, john.fastabend@gmail.com, wad@chromium.org
Subject: Re: [PATCH v2] seccomp: Improve performace by optimizing rmb()
Date:   Wed, 10 Feb 2021 12:44:07 -0800
Message-Id: <161298984230.3996968.4640881413498941015.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1612496049-32507-1-git-send-email-wanghongzhe@huawei.com>
References: <1612496049-32507-1-git-send-email-wanghongzhe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 5 Feb 2021 11:34:09 +0800, wanghongzhe wrote:
> According to kees's suggest, we started with the patch that just replaces
> rmb() with smp_rmb() and did a performace test with UnixBench. The results
> showed the overhead about 2.53% in rmb() test compared to the smp_rmb()
> one, in a x86-64 kernel with CONFIG_SMP enabled running inside a qemu-kvm
> vm. The test is a "syscall" testcase in UnixBench, which executes 5
> syscalls in a loop during a certain timeout (100 second in our test) and
> counts the total number of executions of this 5-syscall sequence. We set a
> seccomp filter with all allow rule for all used syscalls in this test
> (which will go bitmap path) to make sure the rmb() will be executed. The
> details for the test:
> 
> [...]

Applied to for-next/seccomp, thanks!

[1/1] seccomp: Improve performace by optimizing rmb()
      https://git.kernel.org/kees/c/a381b70a1cf8

-- 
Kees Cook

