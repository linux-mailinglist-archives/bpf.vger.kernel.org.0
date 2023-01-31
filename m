Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07093682212
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 03:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjAaCdv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 21:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAaCdv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 21:33:51 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B598818B2E
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 18:33:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso17556459pjj.1
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 18:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=acHSeiBjjProRSWFVmZnnPKg14Jw2I9KkiXnL1t/STk=;
        b=HMdc26nRwvjdUsi9ujPfF0zPyb6vGmIG5JFoTFRMghN2XdsVglRU12xrZ5j2PuAxHN
         6iHm214FFskzgTLV6dUUaaUT/Vl0wRi3pGGkObi435trFn0x94O/D9QH5ThVjVRxj6U4
         ka0wMRff0QzeDGGp/i6sVbgE0KDTox2Yubs/NMynftJVHjL6gnxrRc51cQGZ507dKm5d
         XJXI3Ij/ZBze9xp6pnO4xq3GsOj8ZaaFhU/9h6+Ud/ecmNnMgI3v0dc/Ysp/K9EbjoVf
         tKVfPjg63K/7/pOw1xRyaC2BKtWIj90TcppP5fNH7y9z3yOb/xzPJAMZ4RlSnz6CBF66
         JYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acHSeiBjjProRSWFVmZnnPKg14Jw2I9KkiXnL1t/STk=;
        b=kf5DCwYzTQjqFlGsbvZwiD8Wl/CIKOcqPL9FOMrKY7dbIPWpC8C5b6yaJy4if+r1qZ
         0BDF6YpnJCD+a/cuwIanaRpiYkkotLwyzbOgHnm+VfnuT8+KtlSqxhw3W5B6cPYEFpne
         uqXAnEovOnJVrU/xc2Fm/2F+oQTjWBtJEICuRwk4KLsyafFuGAaQ/3PZUXqJGXbZk6PY
         yJpydz6Tiyeiz1YVsDSKsmCyE4fzLyWcE5ddqIkjM2N9FdVKKq0DjuM4y6DfDJFRMk0/
         qJNjMkWIMNtGaeww8Mhe7TKUBd1pC9kuDat/FA7NQNqS+i/8o+QEOwv6iZsUmEyXlJW1
         HSPA==
X-Gm-Message-State: AFqh2koeCK0M2Bx+7rTLkgtudhfplVlHiNrs/CsA3DVgL/xqy3niyLqQ
        IpK1rAETCLKykjCZVoeCpC8=
X-Google-Smtp-Source: AMrXdXt83CKqgcSgU6KigY/eWDEaOabTNWO6Ez4ndxsz/M5b8DrbvD/ir6WPeB0zlbEQl9ug9dZ3ww==
X-Received: by 2002:a17:90a:4401:b0:229:2427:532f with SMTP id s1-20020a17090a440100b002292427532fmr53745989pjg.40.1675132429060;
        Mon, 30 Jan 2023 18:33:49 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:a52d])
        by smtp.gmail.com with ESMTPSA id dw18-20020a17090b095200b00218daa55e5fsm7732649pjb.12.2023.01.30.18.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 18:33:48 -0800 (PST)
Date:   Mon, 30 Jan 2023 18:33:45 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Subject: Re: [PATCH bpf-next v2 1/1] docs/bpf: Add description of register
 liveness tracking algorithm
Message-ID: <20230131023345.jl7jait4mgnvdvnn@macbook-pro-6.dhcp.thefacebook.com>
References: <20230130182400.630997-1-eddyz87@gmail.com>
 <20230130182400.630997-2-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130182400.630997-2-eddyz87@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 08:24:00PM +0200, Eduard Zingerman wrote:
> +  
> +             +--------------------------+--------------------------+ 
> +             |         Frame #0         |         Frame #1         |
> +  Checkpoint +--------------------------+--------------------------+
> +  #0         | r0-r5 | r6-r9 | fp-8 ... |                           
> +             +--------------------------+                           
> +                ^       ^       ^
> +                |       |       |          
> +  Checkpoint +--------------------------+                           
> +  #1         | r0-r5 | r6-r9 | fp-8 ... |
> +             +--------------------------+
> +                        ^       ^         nil     nil     nil 
> +                        |       |          |       |       |          
> +  Checkpoint +--------------------------+--------------------------+
> +  #2         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
> +             +--------------------------+--------------------------+

Looks like you already realized that frame1 r1-r5 needs to be connected to frame0 r1-r5.
Otherwise when subprog (frame1) reads r1 the read mark won't be propagated
into checkpoint#1 r1 frame0 and r1 in frame0 will be trimmed incorrectly.

> +                        ^       ^          ^       ^       ^  
> +                        |       |          |       |       |
> +  Checkpoint +--------------------------+--------------------------+
> +  #3         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
> +             +--------------------------+--------------------------+
> +                        ^       ^
> +                        |       |          
> +  Current    +--------------------------+                           
> +  state      | r0-r5 | r6-r9 | fp-8 ... |                           
> +             +--------------------------+
> +                        \           
> +                          r6 read mark is propagated via
> +                          these links all the way up to
> +                          checkpoint #1.
> +
...
> +Read marks propagation for cache hits
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Another important point is handling of read marks when a previously verified
> +state is found in the states cache. All read marks present on registers and
> +stack slots of the cached state must be propagated over the parentage chain of
> +the current state. Function ``propagate_liveness()`` handles this case.
> +
> +For example, consider the following state parentage chain (S is a
> +starting state, A-E are derived states, -> arrows show which state is
> +derived from which)::
> +
> +                      r1 read
> +               <-------------                    A[r1] == 0
> +                    +---+                        C[r1] == 0
> +      S ---> A ---> | B | ---> exit              E[r1] == 1
> +      |             |   |
> +      ` ---> C ---> | D |
> +      |             +---+
> +      ` ---> E        

The box around B and D is confusing.
The description doesn't explain what the box is for.
If the box is removed the description stays as-is, no?

> +                      ^
> +             ^        |___   suppose all these
> +             |             states are at insn #Y
> +      suppose all these
> +    states are at insn #X
> +
> +* Chain of states ``S -> A -> B -> exit`` is verified first.
> +
> +* While ``B -> exit`` is verified, register ``r1`` is read and this read mark is
> +  propagated up to state ``A``.
> +
> +* When chain of states ``C -> D`` is verified the state ``D`` turns out to be
> +  equivalent to state ``B``.
> +
> +* The read mark for ``r1`` has to be propagated to state ``C``, otherwise state
> +  ``C`` might get mistakenly marked as equivalent to state ``E`` even though
> +  values for register ``r1`` differ between ``C`` and ``E``.

Overall it's awesome.
Please cc Edward Cree <ecree.xilinx@gmail.com> in the respin.
