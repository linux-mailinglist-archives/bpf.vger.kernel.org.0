Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F446C93CC
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCZKuA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 06:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCZKuA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 06:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156518A74;
        Sun, 26 Mar 2023 03:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 968ED60BA0;
        Sun, 26 Mar 2023 10:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D76C433D2;
        Sun, 26 Mar 2023 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679827796;
        bh=/zPzerCJyWN32gkIc4jdRhEwAiqgyzx8PWwuY7bpEV0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tqHrPHv64m8uWPu1rKbDXQwubJsZxY+ecesEmgIfY761zhK7K1Q/gl/PsCN6ovSka
         vVJL6fJl6GkRFok8o76h7d+oj5PdPjkpko+QCix9PuwYZWdw90vIb4ji8lo99oudhB
         9pmh9swYZay5fN+es3Hn2FKj4ArQktwgc5tG25wpgTU40591QhRirIqeo16F1DWudD
         j0JGm1HfiLrj4yLmE2LDEEMt1FEabGUN/8Hmf6uorSJqYJEJDbiZUvmf7jHh7MDJq+
         AHsC/Lt1v/7jobOxRfqRBYoBLm9YXTAzIk39YIvzQKQTpbZ+gOA2SMxFBG8EGqNfGK
         j9R2B2QeAFyzQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CE337A22551; Sun, 26 Mar 2023 12:49:52 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 26 Mar 2023 12:49:52 +0200
Message-ID: <87pm8v7pnz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yafang Shao <laoar.shao@gmail.com> writes:

> Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert IDs
> to FDs, that's intended for BPF's security model[1]. Not only does it
> prevent non-privilidged users from getting other users' bpf program, but
> also it prevents the user from iterating his own bpf objects.
>
> In container environment, some users want to run bpf programs in their
> containers. These users can run their bpf programs under CAP_BPF and
> some other specific CAPs, but they can't inspect their bpf programs in a
> generic way. For example, the bpftool can't be used as it requires
> CAP_SYS_ADMIN. That is very inconvenient.
>
> Without CAP_SYS_ADMIN, the only way to get the information of a bpf object
> which is not created by the process itself is with SCM_RIGHTS, that
> requires each processes which created bpf object has to implement a unix
> domain socket to share the fd of a bpf object between different
> processes, that is really trivial and troublesome.
>
> Hence we need a better mechanism to get bpf object info without
> CAP_SYS_ADMIN. 
>
> BPF namespace is introduced in this patchset with an attempt to remove 
> the CAP_SYS_ADMIN requirement. The user can create bpf map, prog and
> link in a specific bpf namespace, then these bpf objects will not be
> visible to the users in a different bpf namespace. But these bpf
> objects are visible to its parent bpf namespace, so the sys admin can 
> still iterate and inspect them.
>
> BPF namespace is similar to PID namespace, and the bpf objects are
> similar to tasks, so BPF namespace is very easy to understand. These
> patchset only implements BPF namespace for bpf map, prog and link. In the
> future we may extend it to other bpf objects like btf, bpffs and etc.

May? I think we should cover all of the existing BPF objects from the
beginning here, or we may miss important interactions that will
invalidate the whole idea. In particular, I'm a little worried about the
interaction between namespaces and bpffs; what happens if you're in a
bpf namespace and you try to read a BPF object from a bpffs that belongs
to a different namespace? Does the operation fail? Is the object hidden
entirely? Something else?

-Toke
