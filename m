Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E194610A7B1
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2019 01:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfK0A7P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Nov 2019 19:59:15 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42299 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfK0A7O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Nov 2019 19:59:14 -0500
Received: by mail-io1-f68.google.com with SMTP id k13so22839786ioa.9
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2019 16:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VbU/38+yNJ+zfC9u+frCXiwxMQpfNcWxp5XLS8niF1A=;
        b=A10E0Zkk+zRrcOORDMMGCsKvy9BHFgf9FxT8Q5Z+F9T0wHGy8ix5R/AeW+qpfr2BLY
         AuSpKXkAJKbWFrfzzgtr9gXIip0OYbus86/WG9/IaIKfRq2eNqfUL4oW0gSl7kAGiLKC
         hpLn9uWQyeaELHETva1e3D83DjU/edfu7aUWAOAV7ru9LRkEs1dfRabuSYfIFDcLaDFu
         IReRx9b2JQ1INbGgMuTdZECfpMi3o8NeOqWOkz82VQhy4PIh54PN+jRYK96gnq2z7w4q
         ywrDF0yv5vR+B5AzLX9VjE216xTiY7ZcEEGWPiRNZbxy8JRTu5eTmdXKEHIE7XLW7Xbq
         V6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VbU/38+yNJ+zfC9u+frCXiwxMQpfNcWxp5XLS8niF1A=;
        b=bVaKZlJ/6NxaR+63TqIaeXaIev7qRX+veeOU4QAx2nQZcshPao748Z/h2kHAxaxyTx
         tElC7wvsEKL1o8DFKlRSYCLeCAPIkDmLF5By7oQj8GBww3/PXWvs0tYjsSKmAIRj9+y9
         S/ZiaMJNgPpYjCl/G3XRIu7HJtkJAOJEQAs3ElFbcmuYZOBDMlEnF8xBp4ueYjuFnFOG
         hlsHkdeHkEy/j24CmHbO4+f/6m7/7BqQosDuTRHyEwvvDyH6tPPxeZ9KiMGfMb3MI5vH
         YLEJA6Feex70RHCq1/o1utPnA98JN8YsD4RD2ckpE24Phlb0VTOC8SjZPapFMPNhNrub
         mqhg==
X-Gm-Message-State: APjAAAUp9NArTdjOWgUdCz6I20kdCAJe8P4I6fO7Mp9X7EchM2Xesc5h
        IG6348Ub0Rx9fQZRVOhnmoKWjQ==
X-Google-Smtp-Source: APXvYqxCcCkr//QkJqo4RilDXTt5UmXBfkRr7b/U5pz2/bN55Ik8XDB5pe77KNzYh8fyijKcertCWA==
X-Received: by 2002:a5d:9b08:: with SMTP id y8mr36537219ion.108.1574816354041;
        Tue, 26 Nov 2019 16:59:14 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id k20sm3215043iol.3.2019.11.26.16.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 16:59:12 -0800 (PST)
Date:   Tue, 26 Nov 2019 16:59:11 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Kees Cook <keescook@chromium.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, bpf@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel test robot <rong.a.chen@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Tyler Hicks <tyhicks@canonical.com>,
        Will Drewry <wad@chromium.org>, x86@kernel.org,
        Yonghong Song <yhs@fb.com>
Subject: Re: [GIT PULL] seccomp updates for v5.5-rc1
In-Reply-To: <201911260818.9C5DC1E@keescook>
Message-ID: <alpine.DEB.2.21.9999.1911261656110.23039@viisi.sifive.com>
References: <201911260818.9C5DC1E@keescook>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 26 Nov 2019, Kees Cook wrote:

> Most notably, the secure_computing() prototype has changed (to remove an 
> unused argument), but this has happened at the same time as riscv adding 
> seccomp support, so the cleanest merge order would be to merge riscv 
> first, then seccomp with the following patch for riscv to handle the 
> change from "seccomp: simplify secure_computing()":

The RISC-V pull request that contains the seccomp change has been sent.  
It's here:

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1911261311520.23039@viisi.sifive.com/T/#u


- Paul
