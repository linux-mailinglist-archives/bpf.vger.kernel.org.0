Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80E468B1AC
	for <lists+bpf@lfdr.de>; Sun,  5 Feb 2023 21:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBEUmH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Feb 2023 15:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEUmG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Feb 2023 15:42:06 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B5118B35;
        Sun,  5 Feb 2023 12:42:05 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id f10so10936475qtv.1;
        Sun, 05 Feb 2023 12:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=baJmWUdmXVxM+m9C4fBDKrI1jWXWeqNSvEzKDmMn6/M=;
        b=SSMkxH8xCWttzweeETBFl/UCMnZpy5mKzOFrOqGq8bC0gR0ny3UpATXov8Y5mTan4Q
         9p+Yafup31xdVV6I7G52LPaIj7ByN8WiHl79X8ZymX9R8MtIl9euWb0rtmM7gGXegFJw
         KLsfeJusNmHPIunW5AKlIPpUwpeVMBjDqV0D+A9EGKazJ7F9ERSdr3+dZFnUCirZ4Lge
         PhZZjAtlyNZu+ErqbODBMlpqu69NuOPuyBV4V+PtXZXIaDBWd4bkpM3VNMZKat0PuaH9
         Ajp/pwWPwLrLwHstHT7H7b3bvGbidkcwksQRvI2xvLoqYSVq0HAhGphgt6pcnehRVyJ3
         6Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baJmWUdmXVxM+m9C4fBDKrI1jWXWeqNSvEzKDmMn6/M=;
        b=2RTZlsi9/XVEzdWKtVC0NJ8HPJwvgLk4UJ3s7PWqZcvy3LWLLpYk4I649djXXIaY7I
         WSOegboHxwTg10JDo7ZJRvyyaNmlHSnzX2NopkAI+ZG+g1SqpB2DHmT7ptcBpjNEl13J
         x+gXD+bi78rXxyXVLZEkxOqEmB1kUL0GyujqX5Qk+6pdCdiKW0JkQJjsATpQlMST2H2n
         cBqZPxFc6gNkHIf4LNYg/MFNlr8GzSLUdEXIy9AgF2j3VqmNUQp6WkE2/VWhB5vPytXM
         Ey838Lx1DVEy1v0rOV20RfENZAgtQbAhzZRGJ3nN9WZmPJMb+nT7ebepWT9AMpx2dE4+
         wABA==
X-Gm-Message-State: AO0yUKVbfD+Mq/DAKbdvC4LuuXMTGjk0rxNNVIl7oLtQmqeKmzis7vXW
        cEzGH9lehdoc28DpYzWio80=
X-Google-Smtp-Source: AK7set/UDuxsSLYZ5O17sdxwiyzq0qjEQT1oXqV2fBG7niXHLPSfrcFUIkUFMq13ygxznuWHKSrqUQ==
X-Received: by 2002:ac8:7f8e:0:b0:3a9:81f0:d8e9 with SMTP id z14-20020ac87f8e000000b003a981f0d8e9mr31582595qtj.68.1675629724567;
        Sun, 05 Feb 2023 12:42:04 -0800 (PST)
Received: from localhost ([2600:1700:65a0:ab60:a80b:31f2:24c8:7c9a])
        by smtp.gmail.com with ESMTPSA id i9-20020ac813c9000000b003b86d3ca969sm5815755qtj.51.2023.02.05.12.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 12:42:04 -0800 (PST)
Date:   Sun, 5 Feb 2023 12:42:03 -0800
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        toke@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        brouer@redhat.com, bagasdotme@gmail.com, linux-api@vger.kernel.org
Subject: Re: [PATCH bpf-next v3] bpf/docs: Document kfunc lifecycle /
 stability expectations
Message-ID: <Y+AUm8cikB6m978j@pop-os.localdomain>
References: <20230203155727.793518-1-void@manifault.com>
 <20230203155727.793518-2-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203155727.793518-2-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 09:57:27AM -0600, David Vernet wrote:
> BPF kernel <-> kernel API stability has been discussed at length over
> the last several weeks and months. Now that we've largely aligned over
> kfuncs being the way forward, and BPF helpers being considered
> functionally frozen, it's time to document the expectations for kfunc
> lifecycles and stability so that everyone (BPF users, kfunc developers,
> and maintainers) are all aligned, and have a crystal-clear understanding
> of the expectations surrounding kfuncs.
> 
> To do that, this patch adds that documentation to the main kfuncs
> documentation page via a new 'kfunc lifecycle expectations' section. The
> patch describes how decisions are made in the kernel regarding whether
> to include, keep, deprecate, or change / remove a kfunc. As described
> very overtly in the patch itself, but likely worth highlighting here:
> 
> "kfunc stability" does not mean, nor ever will mean, "BPF APIs may block
> development elsewhere in the kernel".
> 
> Rather, the intention and expectation is for kfuncs to be treated like
> EXPORT_SYMBOL_GPL symbols in the kernel. The goal is for kfuncs to be a
> safe and valuable option for maintainers and kfunc developers to extend
> the kernel, without tying anyone's hands, or imposing any kind of
> restrictions on maintainers in the same way that UAPI changes do.

I think they are still different, kernel modules are still considered as
a part of kernel development, while eBPF code is not that supposed to be
kernel development, at least much further. Treating them alike is
misleading, IMHO.

> 
> In addition to the 'kfunc lifecycle expectations' section, this patch
> also adds documentation for a new KF_DEPRECATED kfunc flag which kfunc
> authors or maintainers can choose to add to kfuncs if and when they
> decide to deprecate them. Note that as described in the patch itself, a
> kfunc need not be deprecated before being changed or removed -- this
> flag is simply provided as an available deprecation mechanism for those
> that want to provide a deprecation story / timeline to their users.
> When necessary, kfuncs may be changed or removed to accommodate changes
> elsewhere in the kernel without any deprecation at all.

This fundamentally contradicts with Compile-Once-Run-Everywhere
https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portability-and-co-re.html
Could you add some clarification for this too? Especically how we could
respect CO-RE meanwhile deprecating kfuncs?

BTW, not related to compatibility, but still kfuncs related confusion,
it also contradicts with Documentation/bpf/bpf_design_QA.rst:

"
Q: Can BPF functionality such as new program or map types, new
helpers, etc be added out of kernel module code?

A: NO.
"

The conntrack kfuncs like bpf_skb_ct_alloc() reside in a kernel module.

Thanks!
