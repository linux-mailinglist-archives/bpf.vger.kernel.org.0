Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A018E3E9BF5
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 03:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhHLBgm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Aug 2021 21:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhHLBgl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Aug 2021 21:36:41 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61E0C061765
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 18:36:16 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id a201so846996vsd.3
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 18:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pzBzfCGH1lUAP5Nww0rTC/VlqE/I0ccF7XCQPd8J30w=;
        b=E9LsvKT+4GhpVxRJbZBIZt/pyNMGk6OdYszv47tbOmxx60hcuIXv53iOM+TtX8KFv9
         /KbPpsur6GsB0q4JHP1YynoAb1haM33EtgkZW3pQoWEKAgql6qdQIpRTmEAiccs2i6Fb
         CMPAEIZh750djanNkq+AoDwg4tijj7JeBInyQhnVv42Bv87bISVBpnDSfLe73koVXqL2
         pMC/ZfmDr7Nw2hkF1gU/pEh4Yzn3N8L3G7GBl+C5Y59MwKGbbizJuozb0eV8IyMOsuMH
         yvmgtEFmh5XqqpedS2ao48Xn6DKeGF0vC/I/mULSr9aXZ+lCL6QGieN4WKPTdf5CTnEB
         I3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pzBzfCGH1lUAP5Nww0rTC/VlqE/I0ccF7XCQPd8J30w=;
        b=QHv0QrrylICfPMT2W2ffs77AZkVF8mguw7++GkPIf3KdwkPpHC67F64bin0THMAYHe
         gX3dm+160kleJfhGJ1vQfu0WrfSs91B9ERqvL5IDQgdFtXCYua057nFJ5ebx/7s8q1n3
         hA4FpVyB+aaXMiUEeNRP01EAN3Gh63LanpzKcM9T9YSRG0qK9j9FTDDW0BeJcJqBEubX
         1i1I+6eOdznGbXaWUJBkijSKB2KLMmbjPnh6JryXuK2zOcNLPTBb1AXMT+Nc1py34tpd
         M3nD6hq76CIxxzKrkviQByFeImu2rWCanv/MjzE+LhsrZMlOJFU2MhiNzwtW8Wvo0frQ
         lH1A==
X-Gm-Message-State: AOAM533hTsK53I5sL84kbGWRcfLYQu1Q0I17UYLynIuwLBt9Tqekxfjw
        lMpAMTlTQzluYvflq6RKpPUx5etSol5FFZXJNZaL0gvQHUI=
X-Google-Smtp-Source: ABdhPJyEdpO8l/b41gKvNQ4fjWD0gNzjeZP/+VSgiBWpKMH+SV75BpadM+1AUH4h0iCimU4Bvlk2vuuhB30nOz2JtEo=
X-Received: by 2002:a67:b304:: with SMTP id a4mr1460134vsm.43.1628732175914;
 Wed, 11 Aug 2021 18:36:15 -0700 (PDT)
MIME-Version: 1.0
From:   Mohan Parthasarathy <mposdev21@gmail.com>
Date:   Wed, 11 Aug 2021 18:36:05 -0700
Message-ID: <CAL2pN5_4tPwhOxKu1g4YT3fEnzvhkQ0dLkP7-4RyUoEmPJiyVw@mail.gmail.com>
Subject: libbpf attaching a raw socket
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I looked in the samples and header files, but could not find an
example for this. How does one convert this from bcc to libbpf. This
is the userspace code.

bpf = BPF(src_file = "socket_filter.c", debug=0)
socket_filter = bpf.load_func("socket_filter", BPF.SOCKET_FILTER)
BPF.attach_raw_socket(socket_filter, "eth2")
socket_fd = socket_filter.sock

I can do the following to set the type:

err = bpf_program__set_socket_filter(obj);

Is there any sample I can follow or any header files where I can look
for attaching a socket to the bpf code.

Thanks
Mohan
