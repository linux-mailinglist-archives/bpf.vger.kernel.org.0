Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F2167306D
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 05:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjASEiP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 23:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjASEha (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 23:37:30 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E075F39F
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 20:34:13 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id d10so553986pgm.13
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 20:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G0ilO45QkkX+/f6PtRJ+jeYES3LN3IOqIe/SPz0rViU=;
        b=UTvd3iQyKkljSq/BEInV+Bjgjsrs2X/F/1Mt1bgK8OgenuQj0jK7rIFvMCEuc7h348
         6PFwd9Ct73QguW8RIKfgT6+WH8V1Tx8eJeV3RMTsepqwEbsteDkrO6sWEUauchAZYK3c
         PntZIA51xXQzNrObzVjj8fl5OEWN9aEdfjwkoHqBFOfRAJg1E6OBjg2iGwMk3eoHjaYj
         9pcR0f4N6Ab9j2urTw/TJTsHqaiUasDXkIoi7kVxaLTg7eWwKHDGzjGEZeSL0x2sjnHb
         pwqNWiKd8h2DADuEfHS5hajSDGLLM+e/p22Ybpev/j804lTUGv5sKjTVurJAY3ckfkj3
         kUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0ilO45QkkX+/f6PtRJ+jeYES3LN3IOqIe/SPz0rViU=;
        b=dVaAzPUI0Wr9DB3D62zm0Ue161iPdgq4UmJtUWp/N2lw0A3/4qGEBIClqWz+rGKUjV
         WphEQslFzOQr0xyKstd84EZ2a9XM0c5U2fN/MrqhlfGUonZ1OXr9MFj6m0+IJiBWaNNP
         ZNtx9I4sx6Q9ILzzoDq4nfomkxWxcDhbkrlCJySACSeYvDzIe+AuNCnJmNRq/ysMGIy1
         T96FgvTdeN6/EjJCVNJ0lMbIMXXu9ZXybumYKosTHHQbuerr+rmzo7W81uIrFTm/bRH0
         rLRu1Rs0hw6/OPcB7qBIyXiwrVXIXZXS0m0NKnaZodZnZ8c9hXEWckxtz1Ce0hwZ+rUP
         jDUg==
X-Gm-Message-State: AFqh2kpRts4Y+09bNPVTyh/e6yE9ALwBuALMsQ63HiHInRz5e9+xX97h
        kdJPbZ0rxXrsB9/rzFwfmzM=
X-Google-Smtp-Source: AMrXdXuA/+R3UdeieH763BwIwZtKz5fBnBKw2+6FkHqe/YJKYl+3AtaeisbpvhcNC3tmr+j9tbr4bw==
X-Received: by 2002:aa7:9250:0:b0:58d:917e:59d8 with SMTP id 16-20020aa79250000000b0058d917e59d8mr7962511pfp.7.1674102771770;
        Wed, 18 Jan 2023 20:32:51 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:194d])
        by smtp.gmail.com with ESMTPSA id b131-20020a621b89000000b005815217e665sm22883058pfb.65.2023.01.18.20.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 20:32:51 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:32:47 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable
 kfuncs"
Message-ID: <20230119043247.tktxsztjcr3ckbby@MacBook-Pro-6.local>
References: <20230117212731.442859-1-toke@redhat.com>
 <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
 <87v8l4byyb.fsf@toke.dk>
 <CAKH8qBs=nEhhy2Qu7CpyAHx6gOaWR25tRF7aopti5-TSuw66HQ@mail.gmail.com>
 <CAADnVQKy1QzM+wg1BxfYA30QsTaM4M5RRCi+VHN6A7ah2BeZZw@mail.gmail.com>
 <CAKH8qBvZgoOe24MMY+Jn-6guJzGVuJS9zW4v6H+fhgcp7X_9jQ@mail.gmail.com>
 <3500bace-de87-0335-3fe3-6a5c0b4ce6ad@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3500bace-de87-0335-3fe3-6a5c0b4ce6ad@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 18, 2023 at 11:48:59AM +0100, Daniel Borkmann wrote:
> 
> My $0.02 is that I don't think we need to make a hard-cut ban as part of this.

The hard-cut is easier to enforce otherwise every developer will be arguing that
their new feature is special and it requires a new discussion.
This thread has been going for too long. We need to finish it now and
don't come back to it again every now and then.

imo this is the summary of the thread:

bpf folks fall into two categories: kernel maintainers and bpf developers/users.
- developers add new bpf features. They obviously want to use them and want bpf users
to know that the feature they added is not going to disappear in the next kernel.
They want stability.
- maintainers want to make sure that the kernel development doesn't suffer because
developers keep adding new apis. They want freedom to innovate and change apis.
Maintainers also know that developers make mistakes and might leave the community.
The kernel is huge and core infra changes all the time.
bpf apis must never be a reason not to change something in the kernel.

Freedom to change and stability just don't overlap. 
These two camps can never agree on what is more important.
But we can make them co-exist.

The bpf developers adding new kfunc should assume that it's stable and proceed
to use it in bpf progs and production applications.
The bpf maintainers will keep this stability promise. They obviously will not
reap it out of the kernel on the whim, but they will nuke it if this kfunc
will be in the way of the kernel innovation.
The longer the kfunc is present the harder it will be for maintainers to justify
removing it. The developers have to stick around and demonstrate that their
kfunc is actually being used. The better developers do it the bigger the effort
maintainers will put into keeping the kfunc perfectly intact.

Some kfunc might be perfect on the first try and it will be stable from the
first kernel release it appeared in.
Other kfuncs might be questionable. Like what happened with conntrack kfunc.
It looked good first, but then the same developers who added it came back to change it.
The approach of 'assume stable, but fix it if you like' worked in this case.

Take bpf_obj_new kfunc. I think it's great and I hope the interface will stick.
But we have an option to change it.

Take Andrii's upcoming 'open coded iterators'. The concept and api look great.
I hope we will do it right the first time and
bpf progs will start to use it immediately.
In such case why would anyone think of changing it?
If api works well and progs are using we will keep it this way.

But imagine we decide to replace the verifier with something better.
It will give us much better flexibility, but sadly bounded loops and
iterators will be in the way.
What we most likely going to do in such case we'll keep two verifiers for
several years and deprecate the old one along with kfuncs that we couldn't keep.
That would be a scheme for deprecation of kfunc.
Maybe we will use KF_DEPRECATE mechansim in such case or something else.
I think we need to cross that bridge when we get there.

Introducing KF_STABLE and KF_DEPRECATED right now looks premature.
We can discuss it, but adding it to a doc and committing to it is too early.
We don't have any kfuncs to mark as KF_STABLE or as KF_DEPRECATED.
No one presented any data on usage of existing kfuncs.
So we're not going to change or remove any one of them.
bpf developers and users should assume that all kfuncs are stable and use them.
When somebody comes to argue that a particular kfunc needs to change
the developer who added that kfunc better to be around to argue that the kfunc is
perfect the way it is. If developer is gone the maintainers will make a call.
It's a self regulating system.
kfuncs will be stable if developers/users are around.
Yet the maintainers will have a freedom to change if absolutely necessary.

Back to deprecation...
I think KF_DEPRECATED is a good idea.
When kfunc will be auto emitted into vmlinux.h (or whatever other file)
or shipped in libbpf header we can emit
__attribute__((deprecated("reason", "replacement")));
to that header file (so it's seen during bpf prog build) and
start dmesg warn on them in the verifier.
Kernel splats do get noticed. The users would have to act quickly.

As far as KF_STABLE... I think it hurts the system in the long run.
The developer can argue at one point in time that kfunc has to be KF_STABLE.
The patch will be applied, but the developer is off the hook and can disappear.
The maintainers would have to argue on behalf of the developer
and keep maintaining it? The maintainers won't have a signal whether
kfunc is still useful after initial KF_STABLE patch.

I think it's more important to decide how we document kfuncs and
how equivalent of bpf_helper_defs.h can be done.

> The 'All new BPF kernel helper-like functionality must initially start out as
> kfuncs.' is pretty clear where things would need to start out with, and we could
> leave the option on the table if really needed to go BPF helper route when
> promoting kfunc to stable at the same time. I had that in the text suggestion
> earlier, it's more corner case and maybe we'll never need it but we also don't
> drive ourselves into a corner where we close the door on it. Lets let the infra
> around kfuncs evolve further first.

Going kfunc->helper for stability was discussed already. It probably got lost
in the noise. The summary was that it's not an option for the following reason:
kfuncs and helpers are done through different mechanisms on prog and kernel side.
The prog either sees = (void *)1 hack or normal call to extern func.
The generated code is different.
Say, we convert a kfunc to helper. Immediately the existing bpf prog that uses 
that kfunc will fail to load. That's the opposite of stability.
We're going to require the developer to demonstrate the real world use of kfunc
before promoting to stable, but with such 'promotion' we will break bpf progs.
Say, we keep kfunc and introduce a new helper that does exactly the same.
But it won't help bpf prog. The prog was using kfunc in production,
why would it do some kind of CO-RE thing to compile 'call foo' differently
depending whether 'foo' is kfunc or helper in the given kernel. And so on.
