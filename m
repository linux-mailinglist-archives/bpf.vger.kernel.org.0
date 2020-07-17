Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5959122463A
	for <lists+bpf@lfdr.de>; Sat, 18 Jul 2020 00:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGQWXk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 18:23:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48098 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgGQWXj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 18:23:39 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jwYlV-0002g7-8m
        for bpf@vger.kernel.org; Fri, 17 Jul 2020 22:23:37 +0000
Received: by mail-io1-f70.google.com with SMTP id k12so7426239iom.19
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 15:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VTRHb0I4lJ0TXv3fEEeiTuxPtQBoGCZFEk4QSYILvTw=;
        b=hmr0IUzwjoN4CedZ8UowCp4zr3jvU1BI6ECzI9hRWKc7BhCstporjkvJ+rvJyLIQwL
         HTVfLaBSV8YZcFmMd0qqFmFqmfrGG+nYz7NSFOdFqofzz1fu9tU0/+hYXP6nbVmPc+Nx
         OfRpu0F6JknEIpEncKxeT4ljqPvNdtYgirePk6xkKay3DQAV8LGnqIszKN+ZKaFsEye/
         D9SYLDY9CgFGLieVqxJ+58Ad5gM2g3WJytb8NBFsDm8bC/FssbXSf9zTA08UK3UGMXT/
         kkGoAKsZsjoHfC151YaVOMQy7qLShqHcIQgLr/abw40RPkA4nrnFwaSs76eSkkTN9Co3
         Fotg==
X-Gm-Message-State: AOAM530Mip6MREnYxFwVAKF/W9yBgyBnvAIzYl73/d0d/qPSC+wQ5Beo
        djMDMiypU/cVxezGC/f56mJ1yezhe5lEDM2QiB1EjPEg90XMPs8zRgiXG9bP4pU/NEGf0jodskG
        mWJbaUKRD+qL47m4T8EIWYB/xG+cvfw==
X-Received: by 2002:a6b:6d07:: with SMTP id a7mr11594196iod.166.1595024616173;
        Fri, 17 Jul 2020 15:23:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoR/QDdzMUXwI93+BnrKlP7K1ZLswHry1d5yDI6K6imiBAtUDwMMtToaUkOa3OeVEW1RKLUg==
X-Received: by 2002:a6b:6d07:: with SMTP id a7mr11594177iod.166.1595024615901;
        Fri, 17 Jul 2020 15:23:35 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:90fa:132a:bf3e:99a1])
        by smtp.gmail.com with ESMTPSA id s12sm5015422ilk.58.2020.07.17.15.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 15:23:35 -0700 (PDT)
Date:   Fri, 17 Jul 2020 17:23:34 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 2/5] s390/bpf: fix sign extension in branch_ku
Message-ID: <20200717222334.GQ3644@ubuntu-x1>
References: <20200717165326.6786-1-iii@linux.ibm.com>
 <20200717165326.6786-3-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717165326.6786-3-iii@linux.ibm.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 17, 2020 at 06:53:23PM +0200, Ilya Leoshkevich wrote:
> Both signed and unsigned variants of BPF_JMP | BPF_K require
> sign-extending the immediate. JIT emits cgfi for the signed case,
> which is correct, and clgfi for the unsigned case, which is not
> correct: clgfi zero-extends the immediate.
> 
> s390 does not provide an instruction that does sign-extension and
> unsigned comparison at the same time. Therefore, fix by first loading
> the sign-extended immediate into work register REG_1 and proceeding
> as if it's BPF_X.
> 
> Fixes: 4e9b4a6883dd ("s390/bpf: Use relative long branches")
> Reported-by: Seth Forshee <seth.forshee@canonical.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

This fixes the failing tests I was seeing. Thanks!

Tested-by: Seth Forshee <seth.forshee@canonical.com>
