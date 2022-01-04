Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFCE483FD6
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 11:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiADKYX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 05:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiADKYV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jan 2022 05:24:21 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FCCC061785
        for <bpf@vger.kernel.org>; Tue,  4 Jan 2022 02:24:21 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q14so138750852edi.3
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 02:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lS2G53CUISbjpkqCjm2OaetcGsivZVkspnAYsGlEa00=;
        b=L6Yv8nqYLar/A3mUr0OfY1upF8XUDRYHUiBhFwiesxtM8Wo55kNFJau869s0RO8RmJ
         w4sFqQLwewU1rA96MFYVhJSZ88T/gkon2QoJTB+h1RfDrEomOLZrFRzDw0dSG6DuWLEq
         5IRP/HXM9kq1IproeXaKI6C3hYAYQ+2qekpaUjrGw0UGS5DPBjQyQ/b0YlOT0rFgxeHc
         sGowHEKqSROFpcEF2dQVo8LtWXe76tA8kfYztr0GXuduKZDnSMXD/3SrXFImrPZyQpqn
         wOq9bx+IC36O9xdsSI4nQFJYLvJvNSZvKQVFFYolCxlD03ZdQce3zUXqlF2J7VlVdyoA
         Z2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lS2G53CUISbjpkqCjm2OaetcGsivZVkspnAYsGlEa00=;
        b=H1Q5VDX22r0X1uHs1AyPSTE6T48Oxq3IoqkGYu3RssqhvBoY2tLezeBvKXwDor6QCZ
         A+Bcwb/eVHrRk7dnkJl6akDuGNURbB7qGsu+ZBs0ameS+QzhGi1tdQ7kcEfxgWbi5NfE
         kTofMLUYA6bpa/len6bpKO+Uj3qyde1fezhJGaE3mKf2+DmcO8aclOLFbx9PL50CT+nP
         K6s7ErLujn9HG/rTOPx7DOc4ASlggSNI1BlSyWSv9kkTrPWgC3LHyNw+9LTcGSIXnRFU
         gpkYtotXqkBU+D+quCDi2Tzfg8UbqFI04egQfeIG6UF6b6AmBMdUwKXg2fIc4jfqli8O
         pDnw==
X-Gm-Message-State: AOAM532wAyedKVc+BpZO5YK8gpPhzwcho3H43KKvNu8aA/FWyPKuhO+g
        nkJqmOhuK6Hh9RXd0G/QlKli9J0OmwCPoU4pkEAHfMN8
X-Google-Smtp-Source: ABdhPJw8Q/Etvc/rvstudi7zF0u8pW2QlZogdT8VH9Nsm4wJ3oSFlxHnSGJHT3469yOr2a9ZNVy6wTindAZazmThQWA=
X-Received: by 2002:aa7:c7d1:: with SMTP id o17mr44632979eds.412.1641291859545;
 Tue, 04 Jan 2022 02:24:19 -0800 (PST)
MIME-Version: 1.0
References: <CAK7W0xe9VVbyVykzTK8X8ieg4UgRJEtrvEyKgLjBO+iVFV41+A@mail.gmail.com>
 <YdOYhsVwGu1p/SSu@pop-os.localdomain> <CAK7W0xezGaA1TZcsxkt_hf+b0LU+396CmetejFBEXjqtvbmDkA@mail.gmail.com>
In-Reply-To: <CAK7W0xezGaA1TZcsxkt_hf+b0LU+396CmetejFBEXjqtvbmDkA@mail.gmail.com>
From:   His Shadow <shadowpilot34@gmail.com>
Date:   Tue, 4 Jan 2022 13:24:08 +0300
Message-ID: <CAK7W0xfX35NSKa_ExcpJkWoy1iX5mU7ogjHbr=T5sHJ9U+D0fQ@mail.gmail.com>
Subject: Fwd: eBPF sockhash datastructure and stream_parser/stream_verdict programs
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Resending to the list, since gmail only picks first responder :(

>Are you saying the packets arrived before you put the socket into the sockmap?
Yes, exactly!

Could you elaborate on how BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB would
be helpful? I assume I need to set up a sockops program and record
passive ends pointers to bpf_sock somewhere, then redirect from
passive to passive or passive->active?


-- 
HisShadow
