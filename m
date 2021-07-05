Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C673BB823
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 09:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhGEHtP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 03:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhGEHtO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 03:49:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B2C061574;
        Mon,  5 Jul 2021 00:46:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t14-20020a05600c198eb029020c8aac53d4so1408957wmq.1;
        Mon, 05 Jul 2021 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BqiXpIg5V7sTEup/0xQEj/hiyc6Lh+cfI6OcJeOZV6k=;
        b=WR6kiKkgvYcUCbfT/u13+/pNOZq+b+XOF1PJ3iEFiJgW4etthuXnUfg9JqvWujWO0d
         2ijodrfHco8iKlGyiHQeuBH/SiSArHzI51AAyhrQEFll7UpyV9/uC/BdaUb2goRWIbuK
         rv6lgaOAGdhdCiX0rlhfHmpVSyartqAp/V+jQV3N1kArVPw1jtyO3UsTNeL6Ji5xtL1e
         7l0Nzif+59g3P+LYl2dndOPZg3pNqOB64pHLyBs+iAmUoTI9lzHpDIIRLBQtKfvvYduo
         VOclfqSk7u9sh9HQBLq7WNtdUIRuhTqdGll3JHmuuUQy0ECY16ONoquJJhEXuzXjNnnQ
         LMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BqiXpIg5V7sTEup/0xQEj/hiyc6Lh+cfI6OcJeOZV6k=;
        b=lAnZL70YbGZqpLYbcdpProiP0hBBGqjdxVHUpuHhn/ORlgcjQ9yokOseOL+Af8rMb6
         wtunHsOQqhQEkDwLf6+Md1Si8BSToViSSnKWk4+Y0miMzjRJrCbiz6oN/hhSDkbDv02K
         vhqXJb0U138GYYiK64v/5qz6HjF7b5g/0hcUKCkGu5PRdxJg5QP3XtIVqeFfh4+p9rpY
         tb6b3CVuOk33e1pEkFnFTW6RAkG9hzgK3STeWbUZoIzMqbb38ucB0zBfpeG04MmAIFTt
         VeIjYpvxAaaSb/kcJKvzXWaihaUTw/YSCzPus0acftfvv3rivImXVICsji55szAsyIxR
         +tEg==
X-Gm-Message-State: AOAM530SNZo+aCjOdnmT+kJQL8sfm8tuVxChyI48UwPr6Js187rR9Vu6
        zpOdhhfy5h5rZgcem0mD9uA=
X-Google-Smtp-Source: ABdhPJzPaW2ETGgvgF/SEu1sGob4DqTnra/paPyyaLujOFXbTpNTTyk0Wc0I9s09u0xFF5yRzBio/A==
X-Received: by 2002:a05:600c:3648:: with SMTP id y8mr13405428wmq.174.1625471195631;
        Mon, 05 Jul 2021 00:46:35 -0700 (PDT)
Received: from gmail.com (178-164-188-14.pool.digikabel.hu. [178.164.188.14])
        by smtp.gmail.com with ESMTPSA id v15sm21422491wmj.39.2021.07.05.00.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:46:34 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 5 Jul 2021 09:46:33 +0200
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
Subject: Re: [PATCH -tip v8 01/13] ia64: kprobes: Fix to pass correct
 trampoline address to the handler
Message-ID: <YOK42eM70kb9fd6r@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162399993125.506599.11062077324255866677.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162399993125.506599.11062077324255866677.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Commit e792ff804f49 ("ia64: kprobes: Use generic kretprobe trampoline handler")
> missed to pass the wrong trampoline address (it passes the descriptor address
> instead of function entry address).
> This fixes it to pass correct trampoline address to __kretprobe_trampoline_handler().
> This also changes to use correct symbol dereference function to get the
> function address from the kretprobe_trampoline.
> 
> Fixes: e792ff804f49 ("ia64: kprobes: Use generic kretprobe trampoline handler")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

A better changelog:

  The following commit:

     Commit e792ff804f49 ("ia64: kprobes: Use generic kretprobe trampoline handler")

  Passed the wrong trampoline address to __kretprobe_trampoline_handler(): it
  passes the descriptor address instead of function entry address.

  Pass the right parameter.

  Also use correct symbol dereference function to get the function address
  from 'kretprobe_trampoline' - an IA64 special.

(Although I realize that much of this goes away just a couple of patches 
later.)

Thanks,

	Ingo
