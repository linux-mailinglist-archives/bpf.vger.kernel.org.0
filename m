Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8ADA32D631
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 16:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCDPMw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 10:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhCDPM1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 10:12:27 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0906C061574
        for <bpf@vger.kernel.org>; Thu,  4 Mar 2021 07:11:46 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h7so731527wmf.3
        for <bpf@vger.kernel.org>; Thu, 04 Mar 2021 07:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oh5XfKQn28uLW2iRHHkqsTQ1f3PUmV3O6dFSVkLpZsE=;
        b=lGWEvWjuEyKtxjTkuRmUZiXeaumlqnSgqDDqCHVF66ony2A2Twls3DRxNWK1+BLNU7
         VpWyzILF63Rt2epeTwvkKCBNa/W6vrO/NNj3k3ZVwAPiHbDKfBYKHQm8819QKzvO2HgX
         e9TMB7uEVIvqY/6SLlJ6aE/Gd3f7tZy1xLHwsc166Fip/T+V8+5fvyS/wDUOpRWle2nI
         8dB0ELijj5XqYcyvZ1jBRRGN6PNYgM4gO5TgzKdT1OEbFI8x0hyD32WGkD8H0c/i8IO0
         7tbPcq5IBlIaVRkFotYBES7VR4GBmaEMutApBvXCSREvO37EUrVY9Tl21MT35/4RBpGk
         ZvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oh5XfKQn28uLW2iRHHkqsTQ1f3PUmV3O6dFSVkLpZsE=;
        b=RE+th0pPfGeiUPVZlu86Lw1J1EV48Oj3ArY8MeBqMFhadWh6TpF5r2lki1r2D9Wzox
         S9ou1UB4p+1tNeT3wsObLrN5LIm7W/9wT2oooqRDF+y7oYGc4O9JrjMEnnP/Kj4nU9cZ
         WfIT9I+tqVnh2YgVRsBRtYJmPXUdQFvZPSHeYVJx5Gbyh+cviS5suJdwhDmZ/uLGGXnV
         hl39x17OyuqKrYyffnyIm6PGWc9c2wX4C41KMKp76LJH35WXuOU2qnwK8Gc/AgAOa0eg
         YSI7bXkWR3+8glCCsG2ccZv7CO3SYvnaIX904FdX4ofiDqNnUrYcZY0dbI3h4OfdodLp
         NUjA==
X-Gm-Message-State: AOAM532XC87PdR6yx5ddDwKf1WDnGa2m9Ehv0rFJVSR4/zfIlFFPTpjA
        3YTt578i+Ks0wcQi5AfTL7ha7WW+Brq4PHKDxy5FaroOPH5gMKY1QA==
X-Google-Smtp-Source: ABdhPJzdRbM43pvLN+pxltN7QeI2UDXeVGVw/RlqkndyTcyzL/ABiQLImIWlSSx9bYFHjAC0fVWbbccyhG5VLiRsQkE=
X-Received: by 2002:a1c:4986:: with SMTP id w128mr4393727wma.37.1614870705344;
 Thu, 04 Mar 2021 07:11:45 -0800 (PST)
MIME-Version: 1.0
From:   Tal Lossos <tallossos@gmail.com>
Date:   Thu, 4 Mar 2021 17:11:34 +0200
Message-ID: <CAO15rP=MCzHx74Wx1dp1b-DCpxAp3CAPK_cg5=642WkCCnX6ww@mail.gmail.com>
Subject: =?UTF-8?Q?bpf=3A_inode=5Fstorage_lookup_element_unexpected_behavio?=
        =?UTF-8?Q?ur=E2=80=8F=E2=80=8F?=
To:     bpf@vger.kernel.org
Cc:     kpsingh@kernel.org, gilad.reti@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
For some reason I've noticed that the current inode_storage's
lookup_elem func returns NULL for a bad fd, which causes ENOENT in
bpf_map_copy_value.
This behaviour is different from the other inode_storage's functions
like update_elem which returns EBADF for a bad fd.

We've checked in the other local storage maps (tasks and sock) and
they return EBADF for a bad fd in their lookup_elem func.
Should inode_storage's lookup_elem func be changed for this same behaviour?
I could submit a patch which changes that behaviour.

Thanks.
