Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAB33AAA44
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 06:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFQEnM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 00:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229671AbhFQEnM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 00:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623904865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NRH1mIv3BE8eD5JB0vSdN7Y05iQZJajr4cyJmYooT0M=;
        b=EtrtZYlf85o/BTTTK0H5T54Mgz44XMId3wXMYhAkAam8jfDSTYj7NLKYdlAcId0vx0fDlO
        gXqYeq/rmln7gZszeMzf/ob3OvOHa0zNGB4c+8PxqV4gVAIthYzj8Dbmts0OybHx868oEz
        MT03WzxfsgDpeO7Ud5QEQcw2UOOkgfQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-_9HBP45NPHKY-1I9YfMJEA-1; Thu, 17 Jun 2021 00:41:03 -0400
X-MC-Unique: _9HBP45NPHKY-1I9YfMJEA-1
Received: by mail-qv1-f69.google.com with SMTP id n3-20020a0cee630000b029020e62abfcbdso1213829qvs.16
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 21:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NRH1mIv3BE8eD5JB0vSdN7Y05iQZJajr4cyJmYooT0M=;
        b=rt5ARn3Y0s/ZzPr+Wo3jahMg2uBbWpRT4zraZbBOHmGakomBZ/AVq7U26w2JtkDm/k
         ZSc2CyCnGCLmRS8aZafKEtfuN05ueNp9oJnYS1ePA12Few7SL1AoWDPeiOm8+GXnkZfU
         e7SzRVxJOwmQDXSeAkqt5iFVQcPsY8sqCWcPfkt45WHxiEZjVX6xbG4eBdJ5tR/Pnwm6
         QcxCwqaXDtHW8FVK/4N5xUrRW4DPIpxQVBbs/GdzazGaIqXV9Rld/7doL/RbhtE7Ecxv
         c4SfObFh/uStrthKjAFai7oY8GwkvNTyXvboRhsAOV6YdPUurIZICys/Jdi6UM4or+ZM
         FmXA==
X-Gm-Message-State: AOAM531G/JG4TRKm+fti/zYgKDz9+fum9fHdbuPGsLG/QnKP1V1eFXd6
        jjlRNY+X1kiBS4PiIFmDII4gCBa5V5RU3ppFfvp7KyL4gsWD/jj3utmsAA6b9lmCD0fvdczZ0bH
        b0RqqqIwZb0SN
X-Received: by 2002:a37:a389:: with SMTP id m131mr1852467qke.134.1623904862697;
        Wed, 16 Jun 2021 21:41:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy/rnTImZkYqGlwtbUgW/jE8SgnPZVG2s9z6nNoS60Q0zHIRP2wQA0sGlLTIxkcaBzfQbNYA==
X-Received: by 2002:a37:a389:: with SMTP id m131mr1852440qke.134.1623904862501;
        Wed, 16 Jun 2021 21:41:02 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id w8sm967908qkp.136.2021.06.16.21.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 21:41:02 -0700 (PDT)
Date:   Wed, 16 Jun 2021 23:41:00 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v7 10/13] x86/kprobes: Push a fake return address at
 kretprobe_trampoline
Message-ID: <20210617044100.swsgkyio5wwdl2ic@treble>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
 <162209763886.436794.6585363781863933939.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162209763886.436794.6585363781863933939.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 03:40:39PM +0900, Masami Hiramatsu wrote:
> This changes x86/kretprobe stack frame on kretprobe_trampoline
> a bit, which now push the kretprobe_trampoline as a fake return
> address at the bottom of the stack frame. With this fix, the ORC
> unwinder will see the kretprobe_trampoline as a return address.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Tested-by: Andrii Nakryik <andrii@kernel.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

