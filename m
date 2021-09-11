Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25B84075AE
	for <lists+bpf@lfdr.de>; Sat, 11 Sep 2021 11:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhIKJDs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Sep 2021 05:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhIKJDs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Sep 2021 05:03:48 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C023DC061574
        for <bpf@vger.kernel.org>; Sat, 11 Sep 2021 02:02:35 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id z18so9127455ybg.8
        for <bpf@vger.kernel.org>; Sat, 11 Sep 2021 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=FcRdIGOFN0R7rAVLW0Y9V58DPM3AUAdahnBODHiGuPw=;
        b=dTD2sg0vMMehIju4c5Sx7Mp1pEMCai6LPUzE57wLQjLx/f+KyAHK3zxGpQwDgUfgnB
         O9+WkSRK+QXwaiHBfVK1U4eLTYpzM3I3dgw65MFBJtRYdTNRHWYOU24YuH6iRc/BtiYV
         1zBqoKl4tWZqiI2+5Wi/z74s6IyHR7o6LkM08aybJKbDK4EqxDPEAdd9wAM28amVJt8B
         8cO0O4O48u+DpdNcGsBsAm0weFiMhJipxUiMvl43E3hLJLkWD2sUBxVUWA1n4lPp6jrB
         hYGTe9+YY7+cBJoitqy+alrOlRFa9wCh/HeZ3q0fGGXKX9AAZOBEJVrNXSR/pexGD5Pw
         9tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FcRdIGOFN0R7rAVLW0Y9V58DPM3AUAdahnBODHiGuPw=;
        b=CGJ2WpgWHXk5n2MkgolNRoUOg6Qb8/Mcgs2MfZ/zPDBbKtYAV4FHJOgAfe5+7SapuP
         PA1AgIJd6gA6xN1Q5CcUNP2HZZcPZdF5QvYQ41TdukCoT3s+4cRHuWbiJsh6h5Yvyhj+
         K7mDSuaRMG0JM7mpJQMZpJcoUz3OiDCGZSRDoTA2qP+vFGl95fMMMEKG+F3mpds5GchJ
         /7qKkWT+Bx+cP9E9JL2KcggdrJXiwH6gQSOhuTRfCg65GFrWY3oY3ThnMV3nx5/31I0m
         tFvjuLWIMsG+DbktQKr4ntAvlHiuMSO+dH342iRfpDxuAUoX4K/rmv5NkRXrX6k91zLt
         fBzQ==
X-Gm-Message-State: AOAM533BzGcBC3viv4FmImUXzsLGbRZ12BcMnsYNvai47wzZacl1H+O1
        ZitX+yPPdAauMuErOfrKIKbNMU33D0SaiR5rv6cW7+n58L8=
X-Google-Smtp-Source: ABdhPJxOMMbNytwCBtNGQgGS6gIegWSPHLvfa1YpwkVgGYnltMNOz1SDW8QbOnDUsPnCD+TDPOth4LgV6YpgNdd6cLo=
X-Received: by 2002:a25:d497:: with SMTP id m145mr2606826ybf.389.1631350954896;
 Sat, 11 Sep 2021 02:02:34 -0700 (PDT)
MIME-Version: 1.0
From:   Gabriele <phoenix1987@gmail.com>
Date:   Sat, 11 Sep 2021 10:02:24 +0100
Message-ID: <CAGnuNNuenDT4Y_UHsny6BK_b1+g2joePAdapdn7aLCi99Rh3bg@mail.gmail.com>
Subject: Read process VM from kernel
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi there

I recently started playing around with libbpf and I was wondering if
it is possible to read a process' VM from the kernel side. In
user-space one could use process_vm_read, but I haven't been able to
find an equivalent BPF API for that.

Cheers,
Gab
