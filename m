Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9B61D4339
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 03:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgEOBtH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 21:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgEOBtH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 May 2020 21:49:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0EDC061A0C
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 18:49:06 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f18so454737lja.13
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 18:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjDYpro2I7pma2os69a1xVeLdgazW/Kr6SEEVn3uTSg=;
        b=Sx6G1kz/W/We64yvAHmLeZdNVRLNiuwN3XEIdJENj2wbtdARCVS2LI+a/GpHe0G+j+
         P21uJrK+4yi5MnsEciBJgykpBpx68vvvDi1Z2913rEjYMPyF3FRVF91eC+k2ePLFLg/A
         eRXzXl+zX4TnZ474G7XPikRULMNKR6FYmvBqWPvLxANsLtm5JRullAsUZAGmWQgFaCb+
         KozAQK3ihPHQWpbgg4PhjwQm5I8q98ny0CC9n6gtGr8x5I+hNpJFV2Z9oKXC4Z55ciFU
         AEFCQwJIA2aDpumKmSXWzpUcms+Rlka/dev8D1ObUjVIr9v4XtCcQaf1M/ClJJ9SRHfH
         +g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjDYpro2I7pma2os69a1xVeLdgazW/Kr6SEEVn3uTSg=;
        b=dcE7xVcsl5NKJk06Q9R4mRCHygC0E3CKMpl+gA3t60wQ9p07ZvOcyZ75vS/iGYauX2
         LqgmZEayVm6nTL8HROxx4XjDCwHHxkq9dakSPxq7ygdDSLybju7m9EL/xcBArtFmMIIE
         Pj2xf3m+i9RBg4CS3X1aYIsFzRve3BQ1Wbnn2+dGUa/23Q1PJqblRYNJxguzFxjEr23G
         tw+UAEnfmoBpJeXyqqvacBg2StqIx9enRj+/VCNgDDJtK3fgOozdsANzY9HjgUF+CkRr
         IxOZpQKHgsOjLX21JkmOvVPKQ8ZyJ0Ycl2J5Cai8n001IUNbaK47hk7iryKo3syjAuZV
         bhqQ==
X-Gm-Message-State: AOAM532p22fHQeyWNxrpYnHg+MdrXIsqfdZzHQH+z0OnBNiNlowqebh2
        UZqm5aaYUhIsbwHwVNTLbsiF8enhca095vZfhOYD1A==
X-Google-Smtp-Source: ABdhPJx8o+mFQxgNsr6BxVqaCg9yZGVtFdq3oC/LEQ+af2eO4v1SFzqJYJSMEfIIm9j4n22PDej2v2IZswqZOCmJAnE=
X-Received: by 2002:a2e:b4c2:: with SMTP id r2mr654371ljm.143.1589507345064;
 Thu, 14 May 2020 18:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589486450.git.rdna@fb.com>
In-Reply-To: <cover.1589486450.git.rdna@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 May 2020 18:48:53 -0700
Message-ID: <CAADnVQKz_2DH4xLUSgtGcHoH9O+5QamvotWtyROPw3OwGi0PPw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/5] bpf: sk lookup, cgroup id helpers in
 cgroup skb
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 14, 2020 at 1:04 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> v2->v3:
> - better documentation for bpf_sk_cgroup_id in uapi (Yonghong Song)
> - save/restore errno in network helpers (Yonghong Song)
> - cleanup leftover after switching selftest to skeleton (Yonghong Song)
> - switch from map to skel->bss in selftest (Yonghong Song)
>
> v1->v2:
> - switch selftests to skeleton.
>
> This patch set allows a bunch of existing sk lookup and skb cgroup id
> helpers, and adds two new bpf_sk_{,ancestor_}cgroup_id helpers to be used
> in cgroup skb programs.
>
> It fills the gap to cover a use-case to apply intra-host cgroup-bpf network
> policy based on a source cgroup a packet comes from.
>
> For example, there can be multiple containers A, B, C running on a host.
> Every such container runs in its own cgroup that can have multiple
> sub-cgroups. But all these containers can share some IP addresses.
>
> At the same time container A wants to have a policy for a server S running
> in it so that only clients from this same container can connect to S, but
> not from other containers (such as B, C). Source IP address can't be used
> to decide whether to allow or deny a packet, but it looks reasonable to
> filter by cgroup id.
>
> The patch set allows to implement the following policy:
> * when an ingress packet comes to container's cgroup, lookup peer (client)
>   socket this packet comes from;
> * having peer socket, get its cgroup id;
> * compare peer cgroup id with self cgroup id and allow packet only if they
>   match, i.e. it comes from same cgroup;
> * the "sub-cgroup" part of the story can be addressed by getting not direct
>   cgroup id of the peer socket, but ancestor cgroup id on specified level,
>   similar to existing "ancestor" flavors of cgroup id helpers.
>
> A newly introduced selftest implements such a policy in its basic form to
> provide a better idea on the use-case.
>
> Patch 1 allows existing sk lookup helpers in cgroup skb.
> Patch 2 allows skb_ancestor_cgroup_id in cgrou skb.
> Patch 3 introduces two new helpers to get cgroup id of socket.
> Patch 4 extends network helpers to use them in the next patch.
> Patch 5 adds selftest / example of use-case.

Applied. Thanks
