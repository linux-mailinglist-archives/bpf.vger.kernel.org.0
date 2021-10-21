Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7674A4367F9
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 18:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhJUQia (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 12:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUQi3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 12:38:29 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3F1C0613B9
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 09:36:13 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bl14so2066557qkb.4
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uAdhU5r7tXAtNjQa6C1r1u96sGJNqWiKbr4CmuRPEvY=;
        b=Ng48X2XbbMWmK7BQGBWn7gVwT1vu4vUi2AKylHU6tkD/L8UFmHktGghy19IfNvVfyj
         nhSz6kb3XeAZ9TWGzAfyG5gGnq7Y3+egiQ0jOdiwq1yu0An9dfMns5dZdNvj+zXMSE51
         uO+PV31C3HHSIry9ELz+dGZl6MM6JZKwq9Ojd9YeZYI7vY9B0r7ZbI+edBIPG00SNEwm
         uDfltrL12KHpIMzvLQIDsRdHrT/GFzx42d0UikA7Af2x86PmiOwTBxB1DMIqtqhNU6bI
         KOZzaRLfHkdtNvYi/2WAQLnCByE5zn6JA8At0tfdvcIsZE8Jwcz4zU/J1vozyZZm4rRO
         S3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAdhU5r7tXAtNjQa6C1r1u96sGJNqWiKbr4CmuRPEvY=;
        b=aXhTDs/1cCNGBj3kaIe0fFbVRrNYMgur5jJFDtGngtNBZIpJBSSCCopRgUp6cue0uB
         n2inXZ/HRLY0WqbeX9kgUGaBQd0dTk/emNVgV77Pi1ibT4xLSSZ8T35O8l3edRG6yf7d
         P+OKB1TqciJJKWOVSKDCOzOg7l1+e0DINHyPEsOPCLH9OPQF8rUjcqqXNDsoHV2RzSmF
         HqWMnjw4ykmeOm90J6Jf5uiDRATALbNpY35LVykfQv5nrOphW9uc+N4SMlGuPcjylQDt
         hIhtKdDubDM+gqAQ0YH0inUx1CgwfftMuHPfSzRX0IGtpmxkM1mjyAjibu2EDwtO+mfk
         aDXw==
X-Gm-Message-State: AOAM532XEDzJhOm6Hva5b6SJp+z9nMcoKdHT/UL6767kf4zcfTtwKTzP
        M0mJiR/q4HjK2P8BrQDLewAfTMuLnpHb3V8NXJy93g==
X-Google-Smtp-Source: ABdhPJw2TIl2NmbB9vQS9kJmK8Oh1FXnsvZiur26o6tpe3O96/y9vNxP+QXuYD9z/oZ5krNAorCe4aO3KVxyO4LkYsU=
X-Received: by 2002:a37:d53:: with SMTP id 80mr5313306qkn.490.1634834171953;
 Thu, 21 Oct 2021 09:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211020225005.2986729-1-sdf@google.com> <20211020225005.2986729-3-sdf@google.com>
 <39d1135f-1792-147a-558f-1e2314e34afe@isovalent.com>
In-Reply-To: <39d1135f-1792-147a-558f-1e2314e34afe@isovalent.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 21 Oct 2021 09:36:01 -0700
Message-ID: <CAKH8qBsKJ0VU=FbVmeznBduwUFnYK0of_ybpxR0Su=+U_Escyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpftool: don't append / to the progtype
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 3:21 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> 2021-10-20 15:50 UTC-0700 ~ Stanislav Fomichev <sdf@google.com>
> > Otherwise, attaching with bpftool doesn't work with strict section names.
> >
> > Also, switch to libbpf strict mode to use the latest conventions
> > (note, I don't think we have any cli api guarantees?).
>
> We've been trying to avoid breaking the command line arguments so far.
> With your patch, there are several types that would need a '/' appended
> to the command line argument. As far as I can tell, these are:
>
>     kprobe
>     kretprobe
>     uprobe
>     uretprobe
>     tracepoint
>     raw_tracepoint
>     tp
>     raw_tp
>     xdp_devmap
>     xdp_cpumap
>
> (Libbpf requires a '/' for a few other types, but bpftool does not
> support loading programs of such types at this time.)
>
> And I find it a bit strange to pass the trailing slash on the command line:
>
>     # bpftool prog load ret1.o /sys/fs/bpf/ret1 type kprobe/
>
> Would it be possible to maintain the current syntax? Maybe by keeping a
> list of types that need the trailing '/', or by making a second attempt
> with the '/' when libbpf complains that it failed to guess the program type?

Sounds good! I can leave existing code and add a retry without '/' to
enable strict mode.
