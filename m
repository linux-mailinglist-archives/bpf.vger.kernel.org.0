Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218ED24F684
	for <lists+bpf@lfdr.de>; Mon, 24 Aug 2020 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgHXJAy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 05:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730475AbgHXJAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 05:00:17 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69ABC061574
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 02:00:15 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id m12so1809307vko.5
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 02:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KfhSuOovLnLRVmlJFLbo80kBFl4FB5sqA5U4FgRWdXE=;
        b=sF0cp1JrdrQ5w+tMqws5LD4vUPY/tS2GNl0kwpIxrT7Z2tvlIvQl3kp/UupnnkFEhw
         P97cQIaiKcoqDiXPPChDUtgG3floGftRcROmppacO3HxwKH80TUEl6Vr2WM8I8s6S9u4
         sghLN2nBSTyQpm7VBixjZNrvVUOMM/VwZ9MTfhS9bA+x3LYj8x587UWnrhiWQ5rK/S8c
         sMrf0vOlbgVyn3Kyh06cI3dtcOykPduzolO2XbUM1mCa0bnxK2/e3X+I5MI/OAbvIQer
         RrVqK3fqYbCfcU1Er/UikCOKQm8VTa1SsBPUTpUo+OGY8a8L4QX9n2TrQR1KnduIIb2p
         xhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KfhSuOovLnLRVmlJFLbo80kBFl4FB5sqA5U4FgRWdXE=;
        b=V3MTCxHuGIB39Za0dNhj5NlpMkyB2cjLehyiDIRMoquVTcl2EJ9yH07oo/bg7OsIRB
         6QOVQOhZU6GFYK/1TqrdET33GrBQhpvrY0UluxYtuDu6f3UUgth/LLejUC1BEs0RgaXF
         KP2KWAFaZ5PeOf7Vk2vPh1555I/ND9plJ7DjXcuYkw3+qBcmJ6SfV6KbiVNkU/2oPk1q
         MSnarmGDQXkaEQHhHGyWNRjH/QR4S9pTGY6JiXfZfHybNYrrJLOGmMOKsp9MmMPtdJtA
         EWQ0q9OsH8/HyGNpLydGPhAuamveN08VaTeKgH1RYaUSIccTDJV28BuuX8E0f5WrPUX0
         6nWQ==
X-Gm-Message-State: AOAM533LEfGSYLR2GBVTxCu9fTlo89BS2ZY/cdh+LWUTYUqK8IG+6lLp
        hwy99q1o0BvzQhPkBahv+hiKHtpyKmW18OLaaIv4ceHoFJ/yffHA
X-Google-Smtp-Source: ABdhPJz/KtMppW2wUDSI5hh9kF22nqOYQnim3Qj7+E4taS5Wd7au/tHa/tVWNgJla6ZbMnBGXUm+Vz9lK3r+rPtUyo4=
X-Received: by 2002:a1f:eecb:: with SMTP id m194mr1767325vkh.40.1598259613475;
 Mon, 24 Aug 2020 02:00:13 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 24 Aug 2020 14:30:01 +0530
Message-ID: <CA+G9fYvWkGp9p95DQ5T87GDBmUMecEYBZC0TYHmfwHysanQ7zA@mail.gmail.com>
Subject: expects argument of type 'size_t', but argument 5 has type 'Elf64_Xword
To:     bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        ast@fb.com, Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, lkft-triage@lists.linaro.org,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

while building perf with gcc 7.3.0 on linux next this warning/error is found.

In file included from libbpf.c:55:0:
libbpf.c: In function 'bpf_object__elf_collect':
libbpf_internal.h:74:22: error: format '%zu' expects argument of type
'size_t', but argument 5 has type 'Elf64_Xword {aka long long unsigned
int}' [-Werror=format=]
  libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);
cc1: all warnings being treated as errors

OE perf build long link,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/846/consoleText

- Naresh
