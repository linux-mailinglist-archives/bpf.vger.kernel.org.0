Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C03231C028
	for <lists+bpf@lfdr.de>; Mon, 15 Feb 2021 18:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhBORKu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 12:10:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231804AbhBORIy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Feb 2021 12:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613408848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VtQLGfCRGP7Cl7zKoEWsA+OESxLic5t9ZlIxij1ea/w=;
        b=GjGLQbfXDL4xO9VJKjV+j0kmnmw1xLeFDtxFoK5AzAeVbBXi6il68IUkqIkXqSpOswIy83
        Ry5g68wJvoW3/fte0tw2INvjYG4CJhda3GosaBwXw5rQ8TriM6VLROayS+9q021paYdpl0
        o1YNl9OkrH5cNdAE87wsACkohnTtoVA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-N86Y4iqoMpSJgmgdWPJtPg-1; Mon, 15 Feb 2021 12:07:24 -0500
X-MC-Unique: N86Y4iqoMpSJgmgdWPJtPg-1
Received: by mail-ed1-f69.google.com with SMTP id m16so5566737edd.21
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 09:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VtQLGfCRGP7Cl7zKoEWsA+OESxLic5t9ZlIxij1ea/w=;
        b=fmYFOpfFeJ6RvaJSlg5V47pIDU1+Hp1ClcF7VC8QW1F1z7xEQWuR2ci/JwrT9dkByO
         F/ZzPwe2YAFlb3TT3rHmeaArosG7Cks6mSsrgdXSwCQR3yq7qWNpUZOI+opESuppegZC
         frSl8nZpDpg6dCHKDsUnrQ/ZaX2wATHMLryBAwCRMLrTmu6vmYS71NEkk4qfzcdvQKQD
         oUZQFbuGV0UKhQJHXNov/8Qk9luVVUVmVbL49xOVub5LPKsMk7VjHJkouvPHY1SVFigb
         lNMCvvyHI06eCIwVV8esTtqR5jl2VC0QvCG3oqC/JLI9kWtNHWhBEWP7J3FAMiSCXovY
         V7EQ==
X-Gm-Message-State: AOAM531Me9LE76GEkRqvEkDB6CAWfbDPhpwU1LjwjK4dsdAovb+Ab7gS
        n4P2AfuxMOwfNAnIZ0926pLh5fnb6HtY7gGEhGCR4eOwqDp2FiSuf22GxFEF9KwFLTbpfPRDDiW
        ssfQDUWUPCA9S
X-Received: by 2002:a17:906:380b:: with SMTP id v11mr4891585ejc.183.1613408843367;
        Mon, 15 Feb 2021 09:07:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsoqJX27QEBb6nYQEKeQD+kS5OZbm0WHQ2fMNqjw9uc4sKG6SQTeBOimlyS/YdsJs+vThfSw==
X-Received: by 2002:a17:906:380b:: with SMTP id v11mr4891555ejc.183.1613408843142;
        Mon, 15 Feb 2021 09:07:23 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id k27sm11100279eje.67.2021.02.15.09.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:07:22 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 407D51805FB; Mon, 15 Feb 2021 18:07:22 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     andrii@kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com, ciara.loftus@intel.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: xsk: use bpf_link
In-Reply-To: <20210215154638.4627-2-maciej.fijalkowski@intel.com>
References: <20210215154638.4627-1-maciej.fijalkowski@intel.com>
 <20210215154638.4627-2-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 15 Feb 2021 18:07:22 +0100
Message-ID: <87eehhcl9x.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Currently, if there are multiple xdpsock instances running on a single
> interface and in case one of the instances is terminated, the rest of
> them are left in an inoperable state due to the fact of unloaded XDP
> prog from interface.
>
> To address that, step away from setting bpf prog in favour of bpf_link.
> This means that refcounting of BPF resources will be done automatically
> by bpf_link itself.
>
> When setting up BPF resources during xsk socket creation, check whether
> bpf_link for a given ifindex already exists via set of calls to
> bpf_link_get_next_id -> bpf_link_get_fd_by_id -> bpf_obj_get_info_by_fd
> and comparing the ifindexes from bpf_link and xsk socket.

One consideration here is that bpf_link_get_fd_by_id() is a privileged
operation (privileged as in CAP_SYS_ADMIN), so this has the side effect
of making AF_XDP privileged as well. Is that the intention?

Another is that the AF_XDP code is in the process of moving to libxdp
(see in-progress PR [0]), and this approach won't carry over as-is to
that model, because libxdp has to pin the bpf_link fds.

However, in libxdp we can solve the original problem in a different way,
and in fact I already suggested to Magnus that we should do this (see
[1]); so one way forward could be to address it during the merge in
libxdp? It should be possible to address the original issue (two
instances of xdpsock breaking each other when they exit), but
applications will still need to do an explicit unload operation before
exiting (i.e., the automatic detach on bpf_link fd closure will take
more work, and likely require extending the bpf_link kernel support)...

-Toke

[0] https://github.com/xdp-project/xdp-tools/pull/92
[1] https://github.com/xdp-project/xdp-tools/pull/92#discussion_r576204719

