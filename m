Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C3767EF68
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 21:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjA0UQw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 15:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjA0UQv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 15:16:51 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259DC2D50
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 12:16:50 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z3so4065414pfb.2
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 12:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C1DZbq5Scy3myblZme4Od3syRaep87TAKxbsaCO1y10=;
        b=ZkOa6ib4S9RBZHXTtmxuJVeMMD3KnTR/NQw2GVEspbp5xuZu8otx8DZRUsCNa2yVH5
         yTLcvx/CWsJglLSuzu2+2oWzSbp6qQWiIpoRfpGrWOnKUxAEcP4F7OO9dCXtiQYfNxWL
         IfLUfiImE2CFwRRSwi7g15myB/eeGAWhUNHhqw3uLbU1VMe20vBl5cfsRJOS67vOU4e+
         c1lYrY09/E/0JIzxbnEnQNveMB425CaCz5ttRXQuqIAGcQ/UXGTIXX1PqMv9NqXKaXRn
         s6GzVUwBb9rsym+9eWDUIkGJngJqlw2DLonMJo8xff3kx9cX7Nath7UsMGGITmHG225N
         dsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1DZbq5Scy3myblZme4Od3syRaep87TAKxbsaCO1y10=;
        b=Wv78GCKEhkADWZwAYyEaILKOMXeZBMepj8nJGfXWSBmS+u8i6H5lqzNNReFkS+J0VX
         CqcohQ19OBmGnTwkF/+M0Pe2NSIVvJlGo4JsjdRjFcbSr6B8XVKYp9X6xaBgqvxcf6iZ
         98bW97DAeYbXrLxhHelp6tbSCTlddw+2GSOqe0klnDn7naxSadP1jha2Ht8h8B102Q6C
         pbFizAhJb1+jVpNKfW7pkz2yZCtoYYvdNnoALwMj+i7hVCTd9KLjK6cmsi1zsU3uOO3/
         aJt22NL0VMBZ+louRMp3Qdvv2qADZ+zUqdZC8nzCYBBFfgP+RDnk+P3mqe6KmxvE+TrW
         zXeQ==
X-Gm-Message-State: AO0yUKUBOq97q5PXGgZteelpFZCK+TZUzV1CHlXP6pGODW8cJHbBHFml
        SD91imIO8o87bUU5/r38cQLEhKZiv8VOdG3Y70mQ
X-Google-Smtp-Source: AK7set9rn7fqzqighdS/6BdpeEFo2c0cEytXTnzFapZu/SdC4RNhf6JdQBKuerY1Fw3hAWJfw7rRx/XUE+FZjftsRso=
X-Received: by 2002:a62:8e0a:0:b0:592:a8af:4ffc with SMTP id
 k10-20020a628e0a000000b00592a8af4ffcmr495205pfe.52.1674850609581; Fri, 27 Jan
 2023 12:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20230119231033.1307221-1-kpsingh@kernel.org>
In-Reply-To: <20230119231033.1307221-1-kpsingh@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 Jan 2023 15:16:38 -0500
Message-ID: <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, casey@schaufler-ca.com, song@kernel.org,
        revest@chromium.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 6:10 PM KP Singh <kpsingh@kernel.org> wrote:
>
> # Background
>
> LSM hooks (callbacks) are currently invoked as indirect function calls. These
> callbacks are registered into a linked list at boot time as the order of the
> LSMs can be configured on the kernel command line with the "lsm=" command line
> parameter.

Thanks for sending this KP.  I had hoped to make a proper pass through
this patchset this week but I ended up getting stuck trying to wrap my
head around some network segmentation offload issues and didn't quite
make it here.  Rest assured it is still in my review queue.

However, I did manage to take a quick look at the patches and one of
the first things that jumped out at me is it *looks* like this
patchset is attempting two things: fix a problem where one LSM could
trample another (especially problematic with the BPF LSM due to its
nature), and reduce the overhead of making LSM calls.  I realize that
in this patchset the fix and the optimization are heavily
intermingled, but I wonder what it would take to develop a standalone
fix using the existing indirect call approach?  I'm guessing that is
going to potentially be a pretty significant patch, but if we could
add a little standardization to the LSM hooks without adding too much
in the way of code complexity or execution overhead I think that might
be a win independent of any changes to how we call the hooks.

Of course this could be crazy too, but I'm the guy who has to ask
these questions :)

-- 
paul-moore.com
