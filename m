Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55C21448A1
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 00:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgAUX7N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jan 2020 18:59:13 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:46988 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgAUX7N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jan 2020 18:59:13 -0500
Received: by mail-qk1-f177.google.com with SMTP id r14so4645537qke.13
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2020 15:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=C7ec4ISisBCmycKNgZR5SkMgE5nr16XsORF/ICf7iq8=;
        b=MQEwwqN3katN5JtYB/b9X19fZHft8SrFDAtf00ts3C5L83VdXklVseQ1WSZVMVCjbc
         28s3TALXbwkfMmR7cszEz8UDk+OvAhRO/wVtHa2Zci7G5Ew4Zq+kB31QG6l6q2B29gqP
         BwUFen3VfweqZka0r1dSewIgh7mj+Uj+oFRS42R7fMvOgbUP3loUyO2sF31pRAKUdRpX
         vDXDhB8rp9nPwzgCRESuH9XkR1khM0VwpuSVDdyGFBac/0hg3UG7HlJ5Q8MfRdJivPH6
         IkP1u287rair7qYQSUeqP4WLHYX1nd0qBColqR1kUuZv18/nYxGhCeoYaTWU6huVVPAV
         RVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=C7ec4ISisBCmycKNgZR5SkMgE5nr16XsORF/ICf7iq8=;
        b=fxaQXXut3kIRf9+fO7a6RaXLEKT8DRvePvusSQvIOxDw7udbqyLqvKwegR+1MpfXy6
         +9rzyqWjNcpMH7E4UspkJYP3/tehAGqz76MAYMitezdkEIqR/ec/+XNPjK/QCqDJ2moD
         6JzXsUSV3flKaOjwoeXOj5LVNfNI2d5k0o+w8KrFePxcSpD859CTPZedlqeH8bYdDHKE
         3cgrs6thGMTs5WdaHh50fcE/gdQ6tXb8B2gIqmoDKFl5znullt79pDFccJEXQj31guxd
         SpMgtk66i5p/yssV3sEm+MUohsAK7u1uNxrEb7VgOS1DW3zmzzzf8uEpCdXwpa7sFyJI
         Q2sw==
X-Gm-Message-State: APjAAAWZHWq5zHvsr5mmyOConPm9Q0Yhp1adL3Rzj2HZgSJENPXBe22a
        GPQjfFEpbPX73HQ004vfQ6O5n/ySMcNA4hll8IhGZzOy
X-Google-Smtp-Source: APXvYqz0T8BHwUqg3YfsReH0JugmVVrMZJERTxjcJU7FWa+fj7FSCaA0dHfAxA1bf2QgJxHQIRCrHkWA93BUiLoq5vM=
X-Received: by 2002:a05:620a:5ae:: with SMTP id q14mr7425545qkq.437.1579651152192;
 Tue, 21 Jan 2020 15:59:12 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Jan 2020 15:59:01 -0800
Message-ID: <CAEf4Bza2qEbe3TFGpJtP2_6Lmdpim0Ykz4EEB6it5QCmMQaY1w@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Re-thinking BPF logging
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Re-thinking BPF logging
=======================

BPF historically had a very restricted logging capabilities through
bpf_printk macro. It's almost never used in production due to its
limitations and because of how heavy-weight it is. BPF developers
would just sprinkle few logging statements here and there while
debugging issue, and will immediately remove them once they are done.
But real-world production BPF applications need easy-to-use and
flexible logging capabilities, both for debugging at scale in
production, as well as for ad-hoc local development needs. Its hard to
anticipate what needs to be logged in case of production issue, so
logging has to be shipped with production version of BPF application,
but enabled whenever issue arises. BPF needs to re-think its logging
approach to satisfy real-world needs: zero-overhead when disabled,
low-overhead and reliable while turned on. All this without
sacrificing code clarity and developer productivity. We pose that with
all the recent BPF advancements (BTF, global variables, BPF text
poking, etc), it's now possible to have a qualitatively different
logging capabilities in a modern BPF application.

-- Andrii
