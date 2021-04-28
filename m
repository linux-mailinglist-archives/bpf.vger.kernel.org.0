Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7133A36DF62
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 21:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbhD1TOF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Apr 2021 15:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbhD1TOF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Apr 2021 15:14:05 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A1AC061573
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 12:13:18 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id i5so3463091uap.5
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=j/G6quImpfxIJ/vYkgsyAwQtm80uxa+W0hEvP/Tc0Qs=;
        b=dNmolaNHVPW11woW8JrZWQyKs3nFmlooK4fvqrYcQCiOXSN0MxlHIMoav/cdMQVM0c
         zL93mxdBR8Dvmw8EbVIRq3+FXKCrNBcTw8ZGoeq/eGog4o9Amh+6SV5NCgVvoB/1a8kj
         Ure2I+3qhtaIgCk1GMu1GolGq1knTIQswFxFWsMvwQKBc6TlzzVQtsdBQKFajrK/b4JH
         qBfnDrdJF3cfpTfBYhptoxIcsCkv0lAgFs1d1KCImsSIJKQ6o5JnzqjpxBYar7BeEfpe
         UK76EIXzDldJQETbnjxjPqu4THdZg4FZiXFVXu5bIvWkIjJ/1WFHtu+LkEfOeUjgcZxL
         14PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j/G6quImpfxIJ/vYkgsyAwQtm80uxa+W0hEvP/Tc0Qs=;
        b=X3hxGGuFx+2g+UwqZ7UlXuZGE9GHBWR5gYjoIjAZWXiR1GJQVR/1QdLk3HhbN3VOsx
         xs83wbY/xIJi5eb9ow3HQhgqVWjOR523EC+skl1zkrdvn3a6l29LjRSKasDBNH6TMdjI
         Gn7Vmgu/7eORZAaA6aGjfyYID1ew2k3yAxUnFjyCp6ctGta7zjzSiKOvEsLRD0uL7Rhd
         KWnU4TaXHsNlLhJjhy9QVlD685bFjLF2AnCRIzyQaoZfbMba8c090wxdNxSjTG1D3rIT
         PijFZLal13hRz6OFDMPxCIm9EM2RYqTIrHgNcDuTOJVPKwVKV/nXUnMGJKniSR+mHyvl
         b+7A==
X-Gm-Message-State: AOAM530pJLSvh7m5z+mgq8cIrK+h8PHPWOjGCxOJ219raYrWikqrMkfR
        g6Ik8KV7BBKaNygobfMgIuTYbuj1bEiSc/FHXjunAu4fyXnoOv8z
X-Google-Smtp-Source: ABdhPJx9WSwp8N3q0Xvy/yj8w6di9HjGsgugCRrV3J8g9gG9IDw77Uz1eom9p2LtIYH9cd6sleX+5714CgRZo6tv0ac=
X-Received: by 2002:ab0:4d66:: with SMTP id k38mr15930458uag.70.1619637197334;
 Wed, 28 Apr 2021 12:13:17 -0700 (PDT)
MIME-Version: 1.0
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Wed, 28 Apr 2021 15:13:06 -0400
Message-ID: <CAO658oV9AAcMMbVhjkoq5PtpvbVf41Cd_TBLCORTcf3trtwHfw@mail.gmail.com>
Subject: Typical way to handle missing macros in vmlinux.h
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

I'm working on enabling CO:RE in a project I work on, tracee, and am
running into the dilemma of missing macros that we previously were
able to import from their various header files. I understand that
macros don't make their way into BTF and therefore the generated
vmlinux.h won't have them. However I can't import the various header
files because of multiple-definition issues.

Do people typically redefine each of these macros for their project?
If so is there anything I should be careful of, such as architectural
differences. Does anyone have creative ideas, even if not developed
fully yet that I can possibly contribute to libbpf?

Thanks so much,
Grant Seltzer
