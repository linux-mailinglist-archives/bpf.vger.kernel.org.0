Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC624495473
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 19:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377368AbiATSwO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 13:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377354AbiATSwO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 13:52:14 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F94FC061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 10:52:13 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x22so25111170lfd.10
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 10:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=9Fk/SIGHdNTnb/4ALIp+d7fHRN+OGq5AmFDA567rUGg=;
        b=sk1T3U6UsxTjgt3bkR1zIKGLUHDjc4k+QP+8lt3xxv69gnYqPM2XKmN22ynapflfT1
         2OM3GklSrY3eMK/+zI8bdt5T4Y4LR1K3zZ6jqMjXFs3x4zw/RPpK7xT2fH/er47PnooF
         KCRfQUwSQMCD/uDT57n4JFJdF4TssNBMj+2TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=9Fk/SIGHdNTnb/4ALIp+d7fHRN+OGq5AmFDA567rUGg=;
        b=JxPY0fATRygZL3hFb9yPXJm5Jm5sKIfV+5umQ1mqvUJtPO+HadzZQ5OXRD5Dt6Bo+l
         azUklYFi0HoHggPOLXmHSao1VmpaHaUNrHrqD2lA7/kCS/MPqe5NGtP7YT/3jtKhOC7B
         mHuDth+GnbLI4vsCk3/wxqPa48vnMxbyDOpFeLZnpRhnfq2Kdk0JhW4hGthjL8g4Bnq1
         AfmeFr9PVBsLND768ujEAHzTNjDN94lqN6wxL/i+Hxk6dhk1bC0bamoHALKWcRaeVb9F
         I/TPevRKl5XFyF3h/8hQ1AUIsJSo210O9C0D9LSOXt1TiplzCL01WWS3uL+GosFmVC0l
         pn7A==
X-Gm-Message-State: AOAM5303jyHC5rD4VPBao+cFtnyz7KF/vefou7p8IYncJu9ZkVggYcee
        Vtu/nXb3N/iL6GhH7IM/oJ48uAsUmSZy9Q==
X-Google-Smtp-Source: ABdhPJxXzWLIS3v70w+pK+nx6x8gjZNtZijexZR+g1GXPSGfOskfPZHLptra3CbDDY2b8nVHvkvSvg==
X-Received: by 2002:a05:6512:c29:: with SMTP id z41mr423705lfu.160.1642704731967;
        Thu, 20 Jan 2022 10:52:11 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id s7sm3210lfs.23.2022.01.20.10.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:52:11 -0800 (PST)
References: <551ee65533bb987a43f93d88eaf2368b416ccd32.1642518457.git.fmaurer@redhat.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Felix Maurer <fmaurer@redhat.com>
Cc:     bpf@vger.kernel.org, sdf@google.com, kafai@fb.com, ast@kernel.org
Subject: Re: [PATCH bpf v2] selftests: bpf: Fix bind on used port
In-reply-to: <551ee65533bb987a43f93d88eaf2368b416ccd32.1642518457.git.fmaurer@redhat.com>
Date:   Thu, 20 Jan 2022 19:52:11 +0100
Message-ID: <87tudynstg.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 18, 2022 at 04:11 PM CET, Felix Maurer wrote:
> The bind_perm BPF selftest failed when port 111/tcp was already in use
> during the test. To fix this, the test now runs in its own network name
> space.
>
> To use unshare, it is necessary to reorder the includes. The style of
> the includes is adapted to be consistent with the other prog_tests.
>
> v2: Replace deprecated CHECK macro with ASSERT_OK
>
> Fixes: 8259fdeb30326 ("selftests/bpf: Verify that rebinding to port < 1024 from BPF works")
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
