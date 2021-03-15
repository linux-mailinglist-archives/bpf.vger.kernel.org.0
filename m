Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C1233C277
	for <lists+bpf@lfdr.de>; Mon, 15 Mar 2021 17:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhCOQum (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Mar 2021 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCOQuP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Mar 2021 12:50:15 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FB0C06174A
        for <bpf@vger.kernel.org>; Mon, 15 Mar 2021 09:50:14 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id v11so4402104uao.0
        for <bpf@vger.kernel.org>; Mon, 15 Mar 2021 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1eXLTRT+GCWYDUqsHI0px35dMXxudCxB6Y29Igq2tfA=;
        b=Zt/e7C15pUXcbtGtlERHjdsaAbsQMdyvsMcS7Bjquvvmruz1Ktk1itTQLZ4o24+LoK
         sPBm1CbpRsE1ol3XeZnbHDqq5+maxWQZNTEz5Q0AOdBPxtF3T7yv3dobKgg3MilEKHTx
         PCc6bw+OjSOCSekYQSg35xeKnd9P//AX3Eit2wV3gz3+d5j9T4fG181goFUX4mLvfadF
         W+v7ZNkhCiF/9GgnuPEEl+8OdUHlgd/W/uKF+Mxs9lYlGtvtzM4t16VYEUldeZdsL0B7
         oDd87aG5LOCjDejeykPwHy6CYYFl2Shf2rdPVl7twypbcZ1bAlEys9cmcLNcJxSpxtrV
         Knsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1eXLTRT+GCWYDUqsHI0px35dMXxudCxB6Y29Igq2tfA=;
        b=HUku7KqYrbafRl30M7RxNmVf7Vk7nV7MjQpJgDejbx8yGVfWD7yHr++XVjFsSYM3B7
         t4ijn8rjjIHOLnaAGRD7Fc1d44ZCklNxTaoldRClv8miiO4hE7Un4YT/iO2VsKtl/nmV
         ngVSwuz4WROnQI1AU5NsxSPzYGEMGgLb4+09TCZdHoXrx/QwmltcYVDCdMBj44InWx5M
         2eZ2PMoTPlv0QvCUQ/ysOl4jR43p7eHehKc1YoU5elGsPYVXXOemRR7pe+C4InCiA3l0
         m+Ttax7cgaeEtUnN9UirZbQaV5jIZwX4b5/d9Av0R1yhexrLHcas7dIwFpacus8tP/C1
         hnhQ==
X-Gm-Message-State: AOAM531FPGFNb/ftlvu/RwUVOYQglkCuR2EJB+G0PnJYvyRGrzp8+pZY
        Jok/g3/KRK3qVLEqhwfw76hD2wxO7I/vkUfsG7GKE8QxEdw=
X-Google-Smtp-Source: ABdhPJziuVx7x1VhvyAucEKF96BJ0d/LqVTeLnwkPTysSr3Y6UnebOgQ+maen+SsM82Mn9PvsEO5MiHc8RA/SQm5fHg=
X-Received: by 2002:a9f:3104:: with SMTP id m4mr5753447uab.127.1615827013381;
 Mon, 15 Mar 2021 09:50:13 -0700 (PDT)
MIME-Version: 1.0
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Mon, 15 Mar 2021 12:50:02 -0400
Message-ID: <CAO658oXG4HEm0rGEW-==0kaTmqenDUC_GM-qi7CEjwSakbnJRw@mail.gmail.com>
Subject: Generating libbpf API documentation
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

I have been experimenting with ways to contribute documentation to
libbpf to make it easier for developers of bpf projects to use it.
With the goal of making a documentation site that is easy to
maintain/generate I found Doxygen (many of you may have experience
with it, I did not). I set up a CI/CD workflow using github actions
that runs doxygen on the libbpf mirror hosted there, and hosts the
produced HTML using netlify. You can find the currently hosted version
of it at https://libbpf-docs.netlify.app (I would gladly donate a real
domain name for this purpose). The docs generation workflow is in my
github repo here: https://github.com/grantseltzer/libbpf-docs

In order to make this work all we would need is to format comments
above functions we want to document. Doxygen requires that the comment
just be in a block that starts with `/**`. I don't think doxygen
specific directives should be committed to code but I think this is a
fine convention to follow. Other doxygen directives (i.e. having
`@file` in every file) can be faked using a step I have in the github
actions.

What does everyone think? Can we agree on this convention and start
contributing documentation in this way? Any pitfalls to doxygen I'm
not familiar with?

Thanks!
