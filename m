Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2903BB830
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 09:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhGEHut (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhGEHut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 03:50:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CABC061574;
        Mon,  5 Jul 2021 00:48:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso13353438wmh.4;
        Mon, 05 Jul 2021 00:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SXbBPp2iS8nwSVm3yeB0A4lnvn/jOz20r+A/6pXUHHY=;
        b=K8KS25r0RHUrbbXW3XiToZgcpnEoMxthTUzc1et0doSyqpGURw6rN9YwfipD9F6CuL
         Is8DqkdKuvQcJf7ZaelDbb+eut3Ec8uLegYdq5+d/eYmBO/Pl4fHeXAzR9ErOFlMVcF4
         FB2H2ELWS1sJf+S1nN+B3l9y3VEVkLeIHLDk10dcm4FLKlYqzGLpOgvB134B9/b2U/bi
         ojuo5MBMt3aKTwYes5IewmdskUhFMQc0gWJHHW1zDGTI1QZf7RJ2xaoSZGcCqhDrBraP
         ATo6vteW9N89mHO9GWkyluVbcXsO326VdWCz7J6gKq9sjKgz5juwI9Z7jzVt2T0l8x+T
         BqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SXbBPp2iS8nwSVm3yeB0A4lnvn/jOz20r+A/6pXUHHY=;
        b=YaryAMR2v3trHfK9UAvJFENQZu915K3W4A+57UAKnaQOHz9GovB1F+H+Q3fDlEHUIO
         O8XmScZwuLmnO2qBPQO/0yXN8qGVNwW530wavIdZ/As5eH8ruWymDZ+wpiYp8zbl0YXQ
         8XsIhs9nt7W6n2R95iLzE2O7NapfWCBvXhE35pxrCMpKEkXD3iAccZkhrDNeZaMWU1u8
         Flw2OHG+s5dh4sUGxcDgT9PAsT5GARrsO58SGcJamOVDQbIvN9BI5uhgJGD4aAT8Hq+n
         wCk1PGRqNSVgeT1hcplRhzBetr57VWVp0wpelFZ59wMEV18cqzpf3EsCqMmGUgBk5oKs
         ohMQ==
X-Gm-Message-State: AOAM5320V99dkVKOsUP6srYRRmLrGRLx1pmzqMS+26utaS6b/iIzpJIG
        D8PXma9lB0TET6hoz0ZRzMg=
X-Google-Smtp-Source: ABdhPJy6OJA4bmaOgopY9Tl8app1eKjIwf+NslUjIwcHRD1gJ9o0m+6u65c2eaKAsQ6yFou5vY0k6A==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr13561630wmi.87.1625471291570;
        Mon, 05 Jul 2021 00:48:11 -0700 (PDT)
Received: from gmail.com (178-164-188-14.pool.digikabel.hu. [178.164.188.14])
        by smtp.gmail.com with ESMTPSA id h14sm13181602wro.32.2021.07.05.00.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:48:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 5 Jul 2021 09:48:09 +0200
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
Subject: Re: [PATCH -tip v8 02/13] kprobes: treewide: Replace
 arch_deref_entry_point() with dereference_symbol_descriptor()
Message-ID: <YOK5OV0zdjvrsqju@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162399994018.506599.10332627573727646767.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162399994018.506599.10332627573727646767.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Replace arch_deref_entry_point() with dereference_symbol_descriptor()
> because those are doing same thing.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Andrii Nakryik <andrii@kernel.org>

A better changelog:

  ~15 years ago kprobes grew the 'arch_deref_entry_point()' __weak function:

    3d7e33825d87: ("jprobes: make jprobes a little safer for users")

  But this is just open-coded dereference_symbol_descriptor() in essence, and
  its obscure nature was causing bugs.

  Just use the real thing.

Thanks,

	Ingo
