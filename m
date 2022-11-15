Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AEC629FD1
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 18:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKORBy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 12:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiKORBw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 12:01:52 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506992717D
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 09:01:52 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y4so13732616plb.2
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 09:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PxMKZOoPyVcRUMBilPywR4X0Hi/lwu1qQCl5H75DsRw=;
        b=d/LJDJFFYEu4VZD4eEbJF2Rx19yY3VTMz4s3QSWtkhjMQrnPUIr17RZFQVk2PElhvC
         bxyU4Ho3RjXIimiWE/2nMaYB4QLsY+Vv/RJiyYb37bAgz3qXAcVlDSBDwhlZevWSvdrs
         hJCwWhIBF03QEXuq2faBoR5HDxBoYrvwT/x0trmmel+ZPV1Lg7wDxklxZzuhmst1SUB1
         GiiOzLZTweNrYXEA4Ss96isIIFFvWx9aIkFcv8HXQ9CKvb36Btg0nFqbSZYiwP/vEJuY
         wQPB7Ski7dVduq20Zpn8NQr6Zh5IPCkefTZDVr6BRFkBRwTEbp31/JLJwL8CSMiblvSg
         3JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxMKZOoPyVcRUMBilPywR4X0Hi/lwu1qQCl5H75DsRw=;
        b=BMXPRgJV3OPXQ1YOQ7kajJCCaFhIsWtb4An/BZZzF9g+xsFWdqbylj9ZGXmptY0+1S
         8c7eK9xgDNHpzf7UUGs/eCS6H2avcp12C+GlVjCP3asMnyPDYl19D5XxM5JjRjTZJCYq
         rCfwN5tn/8LiMgX+FT5yNdsHXZ2zYVOp1X1vJqzES+GLylMMrKTkO3SsJe/GGxrdYHhz
         c2HwbKGLgbEFK7+lzOKfJevWE2vEYeLJY6VVByT41Svq1krf8VJbWhL2GjyjNpvJYEdN
         EVc7Lp1g25XvLhJm4MSnxbqc5HZrl66Mcl37iNCrsuYDGEwlHGZgo5srcgAOgh3YwCJO
         XATA==
X-Gm-Message-State: ANoB5pl7Gjqgnt376x1UsBxmts2E5FMtwNg0y7wB0r9fOQeS7vh3IhvW
        1hXhCW17iiwaZUH/CACHvCkPi7yOZc8=
X-Google-Smtp-Source: AA0mqf4iEh62umqV5KaEfKbWxrOyRTiUi66vRLhHSVGIPcf3UvfGLTcA5VKMgOmhEJRIi+XZFLv+jw==
X-Received: by 2002:a17:902:d54d:b0:174:b537:266d with SMTP id z13-20020a170902d54d00b00174b537266dmr4882195plf.144.1668531711763;
        Tue, 15 Nov 2022 09:01:51 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id u136-20020a62798e000000b00565c8634e55sm8995393pfc.135.2022.11.15.09.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:01:51 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:31:44 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v7 21/26] bpf: Add 'release on unlock' logic for
 bpf_list_push_{front,back}
Message-ID: <20221115170144.axgypthtx7yaseqp@apollo>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-22-memxor@gmail.com>
 <f0058919-d90a-bf0e-100d-fcd991093ee6@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0058919-d90a-bf0e-100d-fcd991093ee6@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 10:22:56PM IST, Dave Marchevsky wrote:
> On 11/14/22 2:15 PM, Kumar Kartikeya Dwivedi wrote:
> > This commit implements the delayed release logic for bpf_list_push_front
> > and bpf_list_push_back.
> >
> > Once a node has been added to the list, it's pointer changes to
> > PTR_UNTRUSTED. However, it is only released once the lock protecting the
> > list is unlocked. For such PTR_TO_BTF_ID | MEM_ALLOC with PTR_UNTRUSTED
> > set but an active ref_obj_id, it is still permitted to read them as long
> > as the lock is held. Writing to them is not allowed.
> >
> > This allows having read access to push items we no longer own until we
> > release the lock guarding the list, allowing a little more flexibility
> > when working with these APIs.
> >
> > Note that enabling write support has fairly tricky interactions with
> > what happens inside the critical section. Just as an example, currently,
> > bpf_obj_drop is not permitted, but if it were, being able to write to
> > the PTR_UNTRUSTED pointer while the object gets released back to the
> > memory allocator would violate safety properties we wish to guarantee
> > (i.e. not crashing the kernel). The memory could be reused for a
> > different type in the BPF program or even in the kernel as it gets
> > eventually kfree'd.
> >
> > Not enabling bpf_obj_drop inside the critical section would appear to
> > prevent all of the above, but that is more of an artifical limitation
> > right now. Since the write support is tangled with how we handle
> > potential aliasing of nodes inside the critical section that may or may
> > not be part of the list anymore, it has been deferred to a future patch.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Can the two WARN_ON_ONCE in this patch be converted to
> verifier-log-and-EFAULT? Looks like they're both in
> functions with access to 'env' and are checking for
> scenarios that should be considered bugs in the verifier.
>

Will do.

> Aside from that style nit, logic and patch summary updates
> here LGTM.
>
> Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
