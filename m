Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FDE48474B
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 18:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiADR6A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 12:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbiADR56 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jan 2022 12:57:58 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC9DC061761
        for <bpf@vger.kernel.org>; Tue,  4 Jan 2022 09:57:58 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g132so23791239wmg.2
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 09:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=c/XYkjVYV/Wi4bFCDI0eNFnCXhDrw/CmHFSj04tSLFs=;
        b=WvY4+Hvgy35dpMFt1qFe1bgXkyTsq7bDat6DFhbpb7F0K83uVgHFu/iGzpxOIXNnjv
         3t36LA7ThITZG7iCdEDnqFtWiH70FKbyZIHZAf0kIys7egp0jrRzIsr6EXC23s3h2Qf6
         AfqFGNOW4WveQdIsnP/2b8S2C9dCVSyFDnzXEp+vuhujRlfIuudZzR+gFRcuWa0J9hod
         oJDh3fi3j6NCGz43ywl0DqrJfIw9dteNT0BCRZdvONqoWaL3xWyiGdIuSXpKOgcfE8c+
         h6nGavHmj3rCoQxnorVFPN1hPi4BSaX2AOa3qDc+9gxPSQ7rh7VnP4KLNWq92XDDc7AS
         +wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=c/XYkjVYV/Wi4bFCDI0eNFnCXhDrw/CmHFSj04tSLFs=;
        b=eqrnreLemkLl2X7gw3kdMnBXqg8RCae5x/eONv1zNkvwP3emy9Ap+9opu8FMWeB39B
         7jmoPZCVMYqP322H1MBbXKrH5wWZLDjUsW9h8CXEgL2ynA/4fTGzY1v11oP5T31TcgXl
         0y/tLvvbBKKKyyOkuiLQvkdmCoeka7vgMGtQlj3bubrW9pgqa03nKhVXUZJLg8235BtF
         9u83aJazg2PBLPY+sOOWOwQIwmHcmoeN29ibta3AilaJpwjVVBTQRNcdYBWBzFgqyYvU
         JUz1i4rzLTtN+wRlZ9hq0YZmtx3CW1gjXirG+lm1QJaspDAN9W/DdPsNl6l9tMCtwg0l
         brdw==
X-Gm-Message-State: AOAM530Scp33nDKwfi+jNPVECdYbtHMEv/kSQtKSflqedzmKB7ZABZ4L
        YCJ1BxSmCmxci0L3EjaV2YRdKB4tkJyr
X-Google-Smtp-Source: ABdhPJx5B6ecwytchCBqFKub5nXb/4cs3PBVujKlIagUnwhYFqeD5N3PYdsiVDSxQc+qOmSWp8454w==
X-Received: by 2002:a05:600c:22d2:: with SMTP id 18mr42302436wmg.158.1641319076631;
        Tue, 04 Jan 2022 09:57:56 -0800 (PST)
Received: from Mem (2a01cb088160fc006dcbec8694cd1f89.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:6dcb:ec86:94cd:1f89])
        by smtp.gmail.com with ESMTPSA id b2sm42574716wrd.35.2022.01.04.09.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:57:56 -0800 (PST)
Date:   Tue, 4 Jan 2022 18:57:54 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 0/3] bpftool: Probes for bounded loops and
 instruction set extensions
Message-ID: <cover.1641314075.git.paul@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds feature probes for bounded loops and instruction set
extensions. The first patch refactors the existing miscellaneous probe
to avoid code duplication in subsequent patches.

The four miscellaneous probes were tested on kernels 4.9, 4.19, and 5.4.

The feature probe for bounded loops was previously submitted as part of
patchset https://lore.kernel.org/bpf/20211217211135.GA42088@Mem/T/.

Paul Chaignon (3):
  bpftool: Refactor misc. feature probe
  bpftool: Probe for bounded loop support
  bpftool: Probe for instruction set extensions

 tools/bpf/bpftool/feature.c | 109 +++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 15 deletions(-)

-- 
2.25.1

