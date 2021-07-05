Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5C43BB895
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 10:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhGEIHW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 04:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGEIHW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 04:07:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5214C061574;
        Mon,  5 Jul 2021 01:04:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i94so20941538wri.4;
        Mon, 05 Jul 2021 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=19rdSk5GG117pPMoVg+QpxWS28GpyWbwBKt8+Q5v5YQ=;
        b=h5VjnR4UJnLOgRFsUahLiCKW5XBhNPkkHEY1mzBCB9N3FTs31Z2i6o5XOL4LiUmQNu
         F9+UOU7eGGTkGao0avAyZeA2/MbpkjMA/lS6AwEjmLmap19g4oQQHdcUoMwu7XghlIby
         Q0xmIkh6/0lma8qvWmxVaAIWrscxvdpJlwhlHoYqgj6vZqTyH6HgRSSDTO31HjBaYLqZ
         2GXhqBEmMgO3QsmIEMU/V0gG6Y0Yi6UjlAfKjZdaqBB7tZBgKLd2hZrZD4WV8idEofTr
         Y73FjkHS7Ol9hByCPui4wIZgzpy/hsAGJjOqCMyhgWeuKAuPQvLcAIDAQ5B58jzkTkkl
         q/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=19rdSk5GG117pPMoVg+QpxWS28GpyWbwBKt8+Q5v5YQ=;
        b=rY+u0FiLGYgenNmU5sNP1PBLk/PgjMFphwQXdVS7EivurobKoNJ8eNfTic8VWROqxR
         cxuAJ4DuJq3+ZFyCQCFBqSim/vY1U9f1mj3FBapM+W3/AsS5LXQDxR+wBCKQzTwuW85F
         lxewRIV/rPkHY+pxCw8DlC7ZGj/af1kca8nxesooYMkNWW3bBDx+Fh2bSspKYgj7DPNG
         ZzXicxwtIcEQ8DwZKmj3Na+3TdNZ2gAb5qcIZYHC21ao8sbkpd/nPnfQZNdJ3wdG2P6C
         V+QUfr0Yot4kyM3oYlUIeGYQo07CukR6YIU1VPdTP5cJ0qEy4pnI3V0SpoauGpGdJTeh
         tROg==
X-Gm-Message-State: AOAM533V1HrynfHlFm/BQJagRi4O0EP2usVW0ktD8D2Jdr4R+r6ZCgdN
        3WTVmSMvihlYt9xaBN+jwB4=
X-Google-Smtp-Source: ABdhPJyZiOJ+iRi+SL5/RJBY1ChtVUqJrFjo3ZgYgp5/0VYHcJGj1BONkhJ1dM1lqCS1e7VhQUv30Q==
X-Received: by 2002:a05:6000:154c:: with SMTP id 12mr14431864wry.97.1625472283370;
        Mon, 05 Jul 2021 01:04:43 -0700 (PDT)
Received: from gmail.com (178-164-188-14.pool.digikabel.hu. [178.164.188.14])
        by smtp.gmail.com with ESMTPSA id h13sm1393698wrs.68.2021.07.05.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 01:04:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 5 Jul 2021 10:04:41 +0200
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
Subject: Re: [PATCH -tip v8 08/13] arm: kprobes: Make a space for
 regs->ARM_pc at kretprobe_trampoline
Message-ID: <YOK9Gbcd63QkU5LB@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162399999702.506599.16339931387573094059.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162399999702.506599.16339931387573094059.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Change kretprobe_trampoline to make a space for regs->ARM_pc so that
> kretprobe_trampoline_handler can call instruction_pointer_set()
> safely.

The idiom is "make space", but in any case, what does this mean?

Was the stack frame set up in kretprobe_trampoline() and calling 
trampoline_handler() buggy?

If yes, then explain the bad effects of the bug, and make all of this clear 
in the title & changelog.

Thanks,

	Ingo
