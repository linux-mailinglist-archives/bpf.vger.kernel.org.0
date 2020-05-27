Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9021E4C5A
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 19:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391704AbgE0RsK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 13:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391708AbgE0RsJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 13:48:09 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD7EC03E97D
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:48:08 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id y2so250968qkf.2
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hCh6x28F7RCb/iRwPUgrfvOqv0uQyjWT7o6ARE6uy94=;
        b=buh8K4Ebwqz0vYSel8dZkg1XwFAfHoXQdpKcLLhuErjdwEO3cTujJFqQlCwMgp06Hh
         L5PA/poWu0ooGUHqzv7ipkX2cuuq2XH+MNF2QGxnsB284zZdq+YHOB8lkVD6j9trL//Q
         NvNx+7FHseulPD3GfEsK2BXLoC6b/SlBsh+31twwqZqlQiEOS9Ro+WrgRSEcE9naro3t
         tBrJxWU1uWtIW1dyWQexaPzRDBXgq4ay2HOe9SD9otSbWv9qDdwOYY015p93xnXxczP8
         sMeVOl4PgeX4LKluhlOUYzY9v+Lj1cW6oEKqqR5gcwxqFEPs900VHvdhM3fWimeU7P93
         j97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hCh6x28F7RCb/iRwPUgrfvOqv0uQyjWT7o6ARE6uy94=;
        b=hvDAFyGjoTZifc8aaGjY0raqnJDaTKYP6tI4gLvr4+h7GAGI6jTvO3yQGceMFkjH2Z
         oih/3J5odJpuqQty5Ns4if7SlaX1yW/o84Mopw1d4HHbYqzZQcLKj1Cl4TkhFjnvdToY
         YMElnnSJusLXLE/cAyEiAEv7+4h7iEw32EcpxJ4uVVwc7I+dR68Fpwd8hMQ65laOWxSc
         InJTFamOghbmURdwNLYgpKh2o4ydYc7J/tDfvn9C7MKHo2EudNo6hogw1HbiamliFddU
         8qes9OK/RLHMIRo5NevBHo9WweomQvry8RFCwACyrrwZu4RjClx023rnix+ZB+2AUjKv
         Ya4g==
X-Gm-Message-State: AOAM5312JJ0jPP5a4bJOVUqqMjpR4S+Oy/F1dsNVDjepRhgTHRP3qCZq
        Llp1voiF8otXQcYhf828IL5Z4C4=
X-Google-Smtp-Source: ABdhPJwnVrg5lq5Zze8uh9HWudikqOpQQ1aOF9BZdxGZF1Ms86JDN765C3hY/aC807lhNfYtxACa3G0=
X-Received: by 2002:a05:6214:1371:: with SMTP id c17mr4053196qvw.186.1590601687264;
 Wed, 27 May 2020 10:48:07 -0700 (PDT)
Date:   Wed, 27 May 2020 10:48:05 -0700
In-Reply-To: <20200527170840.1768178-6-jakub@cloudflare.com>
Message-Id: <20200527174805.GG49942@google.com>
Mime-Version: 1.0
References: <20200527170840.1768178-1-jakub@cloudflare.com> <20200527170840.1768178-6-jakub@cloudflare.com>
Subject: Re: [PATCH bpf-next 5/8] bpf: Add link-based BPF program attachment
 to network namespace
From:   sdf@google.com
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/27, Jakub Sitnicki wrote:
> Add support for bpf() syscall subcommands that operate on
> bpf_link (LINK_CREATE, LINK_UPDATE, OBJ_GET_INFO) for attach points tied  
> to
> network namespaces (that is flow dissector at the moment).

> Link-based and prog-based attachment can be used interchangeably, but only
> one can be in use at a time. Attempts to attach a link when a prog is
> already attached directly, and the other way around, will be met with
> -EBUSY.

> Attachment of multiple links of same attach type to one netns is not
> supported, with the intention to lift it when a use-case presents
> itself. Because of that attempts to create a netns link, when one already
> exists result in -E2BIG error, signifying that there is no space left for
> another attachment.

> Link-based attachments to netns don't keep a netns alive by holding a ref
> to it. Instead links get auto-detached from netns when the latter is being
> destroyed by a pernet pre_exit callback.

> When auto-detached, link lives in defunct state as long there are open FDs
> for it. -ENOLINK is returned if a user tries to update a defunct link.

> Because bpf_link to netns doesn't hold a ref to struct net, special care  
> is
> taken when releasing the link. The netns might be getting torn down when
> the release function tries to access it to detach the link.

> To ensure the struct net object is alive when release function accesses it
> we rely on the fact that cleanup_net(), struct net destructor, calls
> synchronize_rcu() after invoking pre_exit callbacks. If auto-detach from
> pre_exit happens first, link release will not attempt to access struct  
> net.

> Same applies the other way around, network namespace doesn't keep an
> attached link alive because by not holding a ref to it. Instead bpf_links
> to netns are RCU-freed, so that pernet pre_exit callback can safely access
> and auto-detach the link when racing with link release/free.

[..]
> +	rcu_read_lock();
>   	for (type = 0; type < MAX_NETNS_BPF_ATTACH_TYPE; type++) {
> -		if (rcu_access_pointer(net->bpf.progs[type]))
> +		if (rcu_access_pointer(net->bpf.links[type]))
> +			bpf_netns_link_auto_detach(net, type);
> +		else if (rcu_access_pointer(net->bpf.progs[type]))
>   			__netns_bpf_prog_detach(net, type);
>   	}
> +	rcu_read_unlock();
Aren't you doing RCU_INIT_POINTER in __netns_bpf_prog_detach?
Is it allowed under rcu_read_load?
