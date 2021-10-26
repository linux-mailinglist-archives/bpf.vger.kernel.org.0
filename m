Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD2243A9CD
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 03:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhJZBox (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 21:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhJZBox (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 21:44:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BE6C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 18:42:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w23so11829636lje.7
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 18:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NND/8wSd4gWI4RJgRatahkBOW7Lrks344Qf525awD84=;
        b=LM0xo/o70Boqodl+YAdk2Krh5zd96qz1lWuBsb6cVTc54lJvt/wUZjO3HLnrSv3zjg
         K50QShZLH95xVo/1hYITSCoOsyvLeVi9yWhNjMMrTx60/KN7I7aHDQgXQef5WMbM15K/
         wUfDi2CsetTmuccLTgBCnLCxK2B4/X3DHk7uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NND/8wSd4gWI4RJgRatahkBOW7Lrks344Qf525awD84=;
        b=pXKtXLO60aaZDUEzqZ+txERKuW2URbjE6bsrCGGRr1rKUGv1BOl80WqRGeumzRXXCn
         nmXYIYFXrH3o/Qup2KQbTOtZLWfX5zJF4BNbh/H9sLKSYgDRdJ5J0rPQwCerCjVQf5Rz
         xsSoyZBqV+Gf6zWC7HGNqn+8vZIJFo0OqZ3PRpz/mhyLM3e5tsSIn0qylYURrQy9xP4Y
         TfWYv22cXOITpfo/b31/T85MBhuiK/9iAtpYrqQNPjmrqwS76UYWmeMy/g0AQgJa3lTS
         cOOqVwYT5Wavm4dxbIHGNhAg728DFzsdeTSTvmq4FXDgtxRldcAGA+zLIQ+oAIKK676n
         5htA==
X-Gm-Message-State: AOAM532PVAXNt7sDfOHpdgIkq96DSMDctaaroNDAz/yrLIBBBb5CfhAp
        UulQWUEQl60wrXqTDt9tOaqO2S1sGxPZ/kAvCa37Y5qDjPllxQ==
X-Google-Smtp-Source: ABdhPJzYHx2E1XqirtXUqyk+FKel6Mv9VZXjAjNg1CmlF90Q3FteHScwU07SaodpmZAwUhmOCqrVu0iDOeRffU+4fCc=
X-Received: by 2002:a05:651c:10b7:: with SMTP id k23mr22865254ljn.310.1635212547876;
 Mon, 25 Oct 2021 18:42:27 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Mon, 25 Oct 2021 20:42:17 -0500
Message-ID: <CAHap4ztxPO485-5u5bkncyf9n-EQBTfF-3tN28jdNa4w1E-vkQ@mail.gmail.com>
Subject: Question about duplicated types in BTF and btf__dedup()
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi. I found out that some of the BTF files provided by BTFHub contain
a lot of duplicated types definitions:

$ mkdir -p /tmp/foo
$ cd /tmp/foo/
$ wget https://github.com/aquasecurity/btfhub/raw/main/ubuntu/20.04/x86_64/5.4.0-88-generic.btf.tar.xz
$ tar -xf 5.4.0-88-generic.btf.tar.xz

$ bpftool btf dump file 5.4.0-88-generic.btf | grep "STRUCT 'dentry'"
[954] STRUCT 'dentry' size=192 vlen=16
[28359] STRUCT 'dentry' size=192 vlen=16

$ bpftool btf dump file 5.4.0-88-generic.btf | grep "STRUCT 'task_struct'"
[146] STRUCT 'task_struct' size=9216 vlen=213
[28317] STRUCT 'task_struct' size=9216 vlen=213

$ bpftool btf dump file 5.4.0-88-generic.btf | grep "STRUCT 'file'"
[640] STRUCT 'file' size=256 vlen=21
[28416] STRUCT 'file' size=256 vlen=21

I tried to use btf__dedup() but the result is just the same file. Is
this expected to have duplicated types in the BTF files? Why aren't
those types getting deduplicated by the algorithm?

btw, I also noted that the /sys/kernel/btf/vmlinux file contains
duplicated types in some kernels, so I don't think it's an issue
related to BTFHub.

Thanks
Mauricio.
