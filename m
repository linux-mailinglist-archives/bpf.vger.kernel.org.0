Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7D344F062
	for <lists+bpf@lfdr.de>; Sat, 13 Nov 2021 02:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhKMBIg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 20:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhKMBIf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 20:08:35 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCEDC061766
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 17:05:44 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id z6so9860198pfe.7
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 17:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=radOxXXni+ujVr62vdigYgGNyE1EqLyrpdmlMQkf1y8=;
        b=gLtQX6F6v1I2X5+RhlWWsau1TDANC1r7KUfd554/n7DukL5yJAH9QOWp+SuZ0/yBkJ
         jtLwzFmboTmLfdEU9KRinRfBPdywzgfcA5L6e2ubrMZOttQ8za4G2RwamZTdo5zOr1m+
         mSPuENq4jm5K0VONyrmDC5+XriXf6pXr3K6xPQ/EqYy42QLuQdh6u9fasXN71jlRWI98
         dieh14MRuo0PPiGV4adaMxzbF+WH4dnUpERnBtoWXbhVpZLZMZ5/BwgyIB8bWJyNPqE2
         2fImP3rW4dL8VTraYrtPPwkkGFzpxbIiRZBPHDnxbZKKMRHonpg1muJB9nQo7nVrKsky
         IRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=radOxXXni+ujVr62vdigYgGNyE1EqLyrpdmlMQkf1y8=;
        b=MhlLMF+k/HyoSECS4G8moWG2NqWwYx9sihWbG1SfaeTsBUsyEg5UFmfccOBPP9jBtF
         7thk+9HrafanrYhBZUz749bhkTnYO3EyeO3U694wJuGJpD/fW9D4rrHLpEVRtFvNkXkl
         PO4aAYdoDhBTpLuQY0xjVqV57h2DEPVJQ4OgIqfFkbqG9o+YcN4xhVuE8GLmEIlZEGuH
         NTf6JPgx/l8hQtQj4sW0qtdPexRO5JwmgCLe5/sb4GNEuCDqePSbkxTM/RDB5GAtKMJs
         c2Cfw/BQDfDWlcgWB0Bk92D06rH/azE0OzCjWwo1DNgFxIpCQHzGoG5zUXMMpxn9Pn+N
         QAhA==
X-Gm-Message-State: AOAM5333i+IncE59MpRm3mohc1ktePc1cyp25ov72i7kN15tzO5gucsl
        FuZe/xonSC5pgYyJaBN0nbs=
X-Google-Smtp-Source: ABdhPJwXysY4vYJS3HXCgXE+p2I563AbzClJsPi/Dlmpppbfbd6Tjz9+3JcfwGLzSWtD++ZivpeHHw==
X-Received: by 2002:a63:f702:: with SMTP id x2mr12599706pgh.162.1636765544229;
        Fri, 12 Nov 2021 17:05:44 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id p20sm7746302pfw.96.2021.11.12.17.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 17:05:43 -0800 (PST)
Date:   Sat, 13 Nov 2021 06:35:41 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf v2] libbpf: Perform map fd cleanup for gen_loader in
 case of error
Message-ID: <20211113010541.7xhqokpchexe3px6@apollo.localdomain>
References: <20211112232022.899074-1-memxor@gmail.com>
 <20211113005707.7kcqlvywfzk5jfdx@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113005707.7kcqlvywfzk5jfdx@ast-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 13, 2021 at 06:27:07AM IST, Alexei Starovoitov wrote:
> On Sat, Nov 13, 2021 at 04:50:22AM +0530, Kumar Kartikeya Dwivedi wrote:
> >
> > +	/* amount of stack actually used, only used to calculate iterations, not stack offset */
> > +	nr_progs_sz = offsetof(struct loader_stack, prog_fd[nr_progs + 1]);
>
> I think '+ 1' would be one too many.
> When nr_progs == 1 the offsetof(struct loader_stack, prog_fd[1])
> would cover btf_fd, inner_map_fd, and prog_fd[0].
>

Ooh, right, my bad, thanks for fixing it :).

> >  	/* jump over cleanup code */
> >  	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
> > -			      /* size of cleanup code below */
> > -			      (stack_sz / 4) * 3 + 2));
> > +			      /* size of cleanup code below (including map fd cleanup) */
> > +			      (nr_progs_sz / 4) * 3 + 2 +
> > +			      /* 6 insns for emit_sys_close_blob,
> > +			       * 6 insns for debug_regs in emit_sys_close_blob
> > +			       */
> > +			      (nr_maps * (6 + (gen->log_level ? 6 : 0)))));
>
> I've removed the extra () in the above.
>
> And pushed to bpf tree.
> Please confirm that +1 removal was correct.
>
> Thanks for the quick debugging and fix. Much appreciate it.

--
Kartikeya
