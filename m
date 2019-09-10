Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678D9AF062
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2019 19:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbfIJRXA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Sep 2019 13:23:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42218 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731510AbfIJRXA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Sep 2019 13:23:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id w22so11920360pfi.9
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WytUsbUCueuTaHp+R3kiieTTsIcIBaJbRPUzOY9zmMs=;
        b=g8eBFeJURPLmM7K80XMyv6QCx9j8YlqaXas7oh2yW8WK40QJIDwACb+8Fed1j4td8M
         rDgIx0hMCLUGE2ZLv0+DhqEU6GEAD9EgjaTcKC2f7slxN9qUxOR3H7UikEyiSWfyziwL
         lzkvnZGQUh93SlN+8AXzBgLvJqZ2UCH0Zeycm3EFae21/p/tcstsMHN7DgvmMYWoSa/E
         xEz6R5wNLvHQWPJ3Bb6JtYorQKBqOqedQneR/BXDcedQqQEDA50N8N9h36EL9837Y5G0
         WlDnCjhRt6OajXG+J5ay44IycrumkvdYDUnesB54fFvPe3v8pBv4tcVLn8H/X/zSOSne
         RDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WytUsbUCueuTaHp+R3kiieTTsIcIBaJbRPUzOY9zmMs=;
        b=ua9DQvpC9Pwu5jsbaDy9aiVR+OqMXacIBzKSlRfQ5O9dBVwWGA8m4G91Upn97kWB62
         EPt3x/VzKb2qwOL6DI27Y/S7j6mtNdvKcOY291omTWpOWDU+3Qe3+HXOEZymvC/ikm7T
         adxadiMXwilHjXm7vpscYNkQIECUs+85slr1N+w2EIBafmkC6lXegC1VDw3nRQ++rKui
         e9bdIQkqz4oHFzGiWjZGWi5uDr1NwSzDsZgwXTTNcVsvjLiNFvf7VNMyfKgIadb7gd8+
         TIOoWyp+BV087yvVcbWxhbVmHMcSFadS03GzuNf3rtWBzK/T1K0B/C/3XTwEPtIy40K0
         15Fw==
X-Gm-Message-State: APjAAAVHsavPr/LnhQyXqzSw3M2v+Wxx3vB18/Enk1FBUNTJqmJM+Df1
        3Kfea8J+JImaWg36mL1+4+cZXA==
X-Google-Smtp-Source: APXvYqxmkQCQc3l3UoT5KLzpgDQQV9we+Pmo9WXUarV5tvLUbmr6ZHi67Bb91kphtkBUZgPj7hoTOg==
X-Received: by 2002:a63:dd0c:: with SMTP id t12mr27742480pgg.82.1568136178740;
        Tue, 10 Sep 2019 10:22:58 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id j2sm19138413pfe.130.2019.09.10.10.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 10:22:58 -0700 (PDT)
Date:   Tue, 10 Sep 2019 10:22:53 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: validate bpf_func when BPF_JIT is enabled
Message-ID: <20190910172253.GA164966@google.com>
References: <20190909223236.157099-1-samitolvanen@google.com>
 <4f4136f5-db54-f541-2843-ccb35be25ab4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f4136f5-db54-f541-2843-ccb35be25ab4@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 10, 2019 at 08:37:19AM +0000, Yonghong Song wrote:
> You did not mention BPF_BINARY_HEADER_MAGIC and added member
> of `magic` in bpf_binary_header. Could you add some details
> on what is the purpose for this `magic` member?

Sure, I'll add a description to the next version.

The magic is a random number used to identify bpf_binary_header in
memory. The purpose of this patch is to limit the possible call
targets for the function pointer and checking for the magic helps
ensure we are jumping to a page that contains a jited function,
instead of allowing calls to arbitrary targets.

This is particularly useful when combined with the compiler-based
Control-Flow Integrity (CFI) mitigation, which Google started shipping
in Pixel kernels last year. The compiler injects checks to all
indirect calls, but cannot obviously validate jumps to dynamically
generated code.

> > +unsigned int bpf_call_func(const struct bpf_prog *prog, const void *ctx)
> > +{
> > +	const struct bpf_binary_header *hdr = bpf_jit_binary_hdr(prog);
> > +
> > +	if (!IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) && !prog->jited)
> > +		return prog->bpf_func(ctx, prog->insnsi);
> > +
> > +	if (unlikely(hdr->magic != BPF_BINARY_HEADER_MAGIC ||
> > +		     !arch_bpf_jit_check_func(prog))) {
> > +		WARN(1, "attempt to jump to an invalid address");
> > +		return 0;
> > +	}
> > +
> > +	return prog->bpf_func(ctx, prog->insnsi);
> > +}

> The above can be rewritten as
> 	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) || prog->jited ||
> 	    hdr->magic != BPF_BINARY_HEADER_MAGIC ||
> 	    !arch_bpf_jit_check_func(prog))) {
> 		WARN(1, "attempt to jump to an invalid address");
> 		return 0;
> 	}

That doesn't look quite equivalent, but yes, this can be rewritten as a
single if statement like this:

	if ((IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
	     prog->jited) &&
	    (hdr->magic != BPF_BINARY_HEADER_MAGIC ||
	     !arch_bpf_jit_check_func(prog)))

I think splitting the interpreter and JIT paths would be more readable,
but I can certainly change this if you prefer.

> BPF_PROG_RUN() will be called during xdp fast path.
> Have you measured how much slowdown the above change could
> cost for the performance?

I have not measured the overhead, but it shouldn't be significant. Is
there a particular benchmark you'd like me to run?

Sami
