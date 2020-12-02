Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53142CC9D1
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 23:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgLBWpN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 17:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgLBWpN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 17:45:13 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21095C0617A6
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 14:44:33 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id o24so294345ljj.6
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 14:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lGRULi7YN+C3pfhYfujKANQS8jbzhBTJMPdbsEK2lA=;
        b=SQGrx/TDpeExbvZERvSS4hw0Qlg7meg1NPZUvH6xwJJQUba9A8JzXpy4pKQHYhFlN5
         0cnBuY6qJsODYcFybUN8kLVwLX7vMIDzxk4yrPIJpjy75KAQ7rlg36mCOMK/nJhbsW7p
         dpIB4jk59yzbPDqU8LToxrQWRffb6XQlZKWJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lGRULi7YN+C3pfhYfujKANQS8jbzhBTJMPdbsEK2lA=;
        b=Qq/w1omkv1+ArrFnKfWyUovtygVlCray2OvjyKCkljFTvPCO/ArsXlNTjsvPgB7r+J
         QtmyIZqyjKbC59wIEMijuZNb/M9qOSHb2wmya8EX4zvoX2BF00iT6N80Rd8M5CTve9aR
         A7UNJg4FyEiwntT4kYYXxmEjv3T7OT/HGRpJErU4Xv+a8JRE8kpFpdxrz+JOsw7hroR6
         pecAaxhqT5OKvsin66JYbxN4pdSI+gWYW6YGk5XC7FqMjRnDGDq+pUYWcgMr7Db1dBt6
         4ghdYkI+ko7WjTGWbB1dPcrvhqMKppRArFxGeh2jfByw1MdxuHUxM87EVGpS3Fc0ux5n
         QmQw==
X-Gm-Message-State: AOAM532P1WTjFLpkVoCzISwgEmvy8skmhJ5sXzoKKInaE/kVo11Woqfk
        C48leY87hfNeg7PmYnCHY+811T1c6gDh1bf8AcTV6GnVLT3dCnwX
X-Google-Smtp-Source: ABdhPJwz+c068pukEiEjDFWX59hBcbpzbXSi5K30Rk22SUc9BJ6hy9tbF2CFfDcZjwDjvDR48RmG80irxZ7pKk4rpX8=
X-Received: by 2002:a2e:984e:: with SMTP id e14mr53028ljj.110.1606949071511;
 Wed, 02 Dec 2020 14:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20201202223944.456903-1-kpsingh@chromium.org> <20201202223944.456903-2-kpsingh@chromium.org>
In-Reply-To: <20201202223944.456903-2-kpsingh@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 2 Dec 2020 23:44:20 +0100
Message-ID: <CACYkzJ5Ck7fe0m3qBMgLFmW66fu4BBO8Z0xp_kezRK69jVbrrg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Ensure securityfs mount
 before writing ima policy
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 2, 2020 at 11:39 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> SecurityFS may not be mounted even if it is enabled in the kernel
> config.
>
> Signed-off-by: KP Singh <kpsingh@google.com>

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
