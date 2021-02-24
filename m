Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E310C3244CF
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 20:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhBXT5g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 14:57:36 -0500
Received: from mail-vs1-f44.google.com ([209.85.217.44]:46187 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbhBXTz3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 14:55:29 -0500
Received: by mail-vs1-f44.google.com with SMTP id i13so1677749vsr.13
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 11:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mY7CoCJBGUAMCRKjAIU1VcPgGV8lc5bn5jKH0ISi5bE=;
        b=qjglyFVMsjA0qSvqbxfVuD1d90K3+uCezSLKBTArgazxH6f0UKNnhSaJ10opVaQPB0
         jmoX81rSNKVvxrTKK9ymu4FYHrydjtPZZZhfmzT0b19Bg48wskBNAQBc/0vJn8z0EK5I
         YfgrMAGBXeBx7ynLasiu0Jl8MiPXi9rPtFawS0ZIOnS+PHEHAgZsnTgcPpUPVV/XRj1J
         9RNYAI1He24Kj6KBUugveNMMmlHHb7xRMH0kOyYcyyg82jcyr9C/+4X3uE0BDl6rZAdb
         i40U4/F3OYo2AF64p3MyrkaY5DU34DJ+OHOqd+9LxuIpgJAnBCl2TTi0gUgvjjMSasn6
         3O4Q==
X-Gm-Message-State: AOAM533/CuE1UtWHgMx7kxAEpRQehd6QuA+zS5x/caSaTPLCj971PjgN
        VyTGwhDjpAMpqr7WPMTRZcvWshbPoNeUwmJz3hqwRoip4R8wYA==
X-Google-Smtp-Source: ABdhPJxL18qLbn6vXRug6lV28mAVQw/nRr+4TJ9vD0o6wYiO1XtBsTsujIscyHaGPRr6Z/OrFzEUwKOsQOb8JuazhGw=
X-Received: by 2002:a67:2283:: with SMTP id i125mr5677248vsi.21.1614196488460;
 Wed, 24 Feb 2021 11:54:48 -0800 (PST)
MIME-Version: 1.0
From:   Luigi Rizzo <rizzo@iet.unipi.it>
Date:   Wed, 24 Feb 2021 20:54:37 +0100
Message-ID: <CA+hQ2+hhDG2JprNLaUdX4xgcihvchEda1aJuQN3jtJ3hYucDcQ@mail.gmail.com>
Subject: arch_prepare_bpf_trampoline() for arm ?
To:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I prepared a BPF version of kstats[1]
https://github.com/luigirizzo/lr-cstats
that uses fentry/fexit hooks to monitor the execution time
of a kernel function.

I hoped to have it working on ARM64 too, but it looks like
arch_prepare_bpf_trampoline() only exists for x86.

Is there any outstanding patch for this function on ARM64,
or any similar function I could look at to implement it myself ?

thanks
luigi


[1] kstats is an in-kernel also in the above repo and previously
discussed at https://lwn.net/Articles/813303/

-- 
-----------------------------------------+-------------------------------
 Prof. Luigi RIZZO, rizzo@iet.unipi.it  . Dip. di Ing. dell'Informazione
 http://www.iet.unipi.it/~luigi/        . Universita` di Pisa
 TEL      +39-050-2217533               . via Diotisalvi 2
 Mobile   +39-338-6809875               . 56122 PISA (Italy)
-----------------------------------------+-------------------------------
