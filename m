Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035046922A7
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 16:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjBJPw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 10:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjBJPwZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 10:52:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA8C4B749
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 07:52:24 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id rp23so16977819ejb.7
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 07:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ROduZYJpSejdajCsBZSHrHuAACG1d4aq3VU3Cfv3Yt4=;
        b=qAM8LzdtIzHzZx9Kf1mmuf82NNGWVm/JOZKSidHNH/flRfQFR6mcHEVPmS+xWBBlng
         xasUroz0oZpe/l3/em7/BN9N6XRzOxO2hnrVQu6cxuSaA9K8aD3TrmDOekcOuYxYbZBP
         3dYQPagXm7Qp8CpTytNoRFPG9+YbB5EwO42RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ROduZYJpSejdajCsBZSHrHuAACG1d4aq3VU3Cfv3Yt4=;
        b=OnXvDwzXdpC0J8pG6t5EXcslUvym+FkVDq1jSFSMNoDXtOEp9sguiFmpzRPRZ6Wuuw
         qiTE1ACIQemxTOsHTdHS7a/Xstoi+J07TDm7RJHBenCvrW3VS5fFnPS0twQQ/h/iiPGf
         1EDMKzdQ+KJPMb0wTVkPHr1Ml5gGJQIZIdIJJia2rbFgs1HJwiLuUJ5xHvotMhg+FZKu
         QbC0nL3H8RWHd+5nGNDKdydRA3f2STwfKiBSjQguaEZJ7nSosaiwU6en7UPX/oeSVWDi
         5yjqJCMdSkcYYL284dL4s8zm5NjeBU/1IJoISmwWijDNGZch4B0PDfc/NKsJmUvSbMxZ
         aniA==
X-Gm-Message-State: AO0yUKXFu55r6Qh9oNXNgmRnIsPdxQ5SNYVTPWOSPqKgE/O4U5tUFcVH
        FmewRTGTI2insiLw74Ex0AM5C9whl7FEl14gOIV1zQ==
X-Google-Smtp-Source: AK7set9DRrfJ8emvNMJ4bkS2cGPib1PAntVERZKX/H6AbXR1QQgyUoIWPbU2nZm7VGO/zeuCODpjgQVksVs8Lq6XoUc=
X-Received: by 2002:a17:906:718d:b0:8ab:4931:ca26 with SMTP id
 h13-20020a170906718d00b008ab4931ca26mr1302015ejk.5.1676044342787; Fri, 10 Feb
 2023 07:52:22 -0800 (PST)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 10 Feb 2023 16:52:12 +0100
Message-ID: <CAJfpegu6xqH3U1icRcY1SeyVh0h-CirXJ-oaCXUsLCZGQgExUQ@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] fuse passthrough solutions and status
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alessio Balsini <balsini@android.com>,
        Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Several fuse based filesystems pass file data from an underlying
filesystem without modification.  The added value can come from
changed directory structure, changed metadata or the ability to
intercept I/O only in special cases.  This pattern is very common, so
optimizing it could be very worthwhile.

I'd like to discuss proposed solutions to enabling data passthrough.
There are several prototypes:

 - fuse2[1] (myself, very old)
 - fuse-passthrough[2] (Alessio Balsini, more recent)
 - fuse-bpf[3] (Daniel Rosenberg, new)

The scope of fuse-bpf is much wider, but it does offer conditional
passthrough behavior as well.

One of the questions is how to reference underlying files.  Passing
open file descriptors directly in the fuse messages could be
dangerous[4].  Setting up the mapping from an open file descriptor to
the kernel using an ioctl() instead should be safe.

Other open issues:

 - what shall be the lifetime of the mapping?

 - does the mapped open file need to be visible to userspace?
Remember, this is a kernel module, so there's no process involved
where you could look at /proc/PID/fd.  Adding a kernel thread for each
fuse instance that installs these mapped fds as actual file descriptor
might be the solution.

Thanks,
Miklos


[1] https://lore.kernel.org/all/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2oQiOZXVB1+7g@mail.gmail.com/

[2] https://lore.kernel.org/all/20210125153057.3623715-1-balsini@android.com/

[3] https://lore.kernel.org/all/20221122021536.1629178-1-drosen@google.com/

[4] https://lore.kernel.org/all/CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com/
