Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29833BB835
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 09:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhGEHwP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 03:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhGEHwO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 03:52:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B712C061574;
        Mon,  5 Jul 2021 00:49:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a8so9185848wrp.5;
        Mon, 05 Jul 2021 00:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d0dQZRJ3T9P2oADq6Txm5lSu38y0NAynZvCdSK4/Cao=;
        b=HLcDlujDpRoNX7m9HZff0LdF8NBRLnSnmM0Uhbag1lNq/wa9op2N3WcnUEziL6gRF8
         ZVtqxftQOEBMunfMZy5jAJ2WWwgDZZU1w0ILeou5SeuN+ft032yhkiY1XpVwdhTkTG7i
         ZDtDvmQFiDdPeg/cW5wpx2aJ0YUV3UDrns/Ew8sIw5T2XoHwjzOFXIR22nekXkZ4qby0
         2kun0p5dGvh6B+RiM48fmtXjlMsaY18nqpLV2IQUqG9hC0U98VZy9A2G6tv8GwXXx2CA
         VnczIipniTEtJtHv15OObIpDhVb4ax8boHKHMCjr0qbIKQIc14apJ6nyoUuZ/sY3U6kF
         CS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=d0dQZRJ3T9P2oADq6Txm5lSu38y0NAynZvCdSK4/Cao=;
        b=B1ocmmUUe24zQuNfqpcAmcSzLv3BaJ4nral0DswV5E8KWIkERkUWbA5o4rzu60xLNr
         QjGhE6W5jlvh6ZFzC4G7YUvlpr4RcYwjtMZzoTjBjp34JlYSDLfU4NZOBuE1UJxmvC/m
         G0ep2Bz1Vvf1n2AvfMrSovq28e7t8eA3AowuINEMJ1SMOSd50j6xTcESPbVe3QWJ7/TN
         1A2sekPmngKMSIBBHNXaUpAOSatCHDyNJxiX545J/XGnEgTTTAf3DAFZR5d7Yi5lSzpM
         6Ijht+0lRPGhZxkLr4hEgAFH5f1pikZp1aB1Wkw1ckbS1+ehc2ocJCcQReAqCh6J7QIn
         6Kbw==
X-Gm-Message-State: AOAM5318TpqjR5Ku8dL0sN2ZuOBo+pPq//iy2inokrNgjHeUvMAy850z
        /IzNbHB42Fq8cY938aPhsL0=
X-Google-Smtp-Source: ABdhPJzpCdRjyhNQxEEbs/Y4eM6QQJ1T9DrtOXPxm8LQgJlto2y2uNrXsSiJYs9dRdo27Rlq99SaDw==
X-Received: by 2002:adf:a4d8:: with SMTP id h24mr14010038wrb.416.1625471376798;
        Mon, 05 Jul 2021 00:49:36 -0700 (PDT)
Received: from gmail.com (178-164-188-14.pool.digikabel.hu. [178.164.188.14])
        by smtp.gmail.com with ESMTPSA id y13sm12287630wrp.80.2021.07.05.00.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:49:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 5 Jul 2021 09:49:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 03/13] kprobes: treewide: Remove
 trampoline_address from kretprobe_trampoline_handler()
Message-ID: <YOK5jnkaqNCMQkJi@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162399994996.506599.17672270294950096639.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162399994996.506599.17672270294950096639.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Remove trampoline_address from kretprobe_trampoline_handler().
> Instead of passing the address, kretprobe_trampoline_handler()
> can use new kretprobe_trampoline_addr().
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Andrii Nakryik <andrii@kernel.org>

A better changelog:

   The __kretprobe_trampoline_handler() callback, called from low level 
   arch kprobes methods, has the 'trampoline_address' parameter, which is 
   entirely superfluous as it basically just replicates:

        dereference_kernel_function_descriptor(kretprobe_trampoline)

   In fact we had bugs in arch code where it wasn't replicated correctly.

   So remove this superfluous parameter and use kretprobe_trampoline_addr() 
   instead.

Thanks,

	Ingo
