Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAACA32A46E
	for <lists+bpf@lfdr.de>; Tue,  2 Mar 2021 16:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578100AbhCBKfi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 05:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379120AbhCBJvl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 04:51:41 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622C9C061793
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 01:47:23 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id h4so22938780ljl.0
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 01:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kcgL94+L1tIXT1R8vfU9UzdbVrMKYIDLcHvPGal+1A=;
        b=SurN3sWHWBPKkLlGNZc6rYyjJtp8AA/I2oXOTORAolb7hFvo7bfaUhEMmYnvL9t/eV
         lX70eBcFbTYDzPxYJFrDwpr1iGSt7PkyTCRxzAkSHJR8OMWI5IkYUuKCCG2ZTlt0f2kO
         IRqX8Vh8c1GRXIZ4HZUGAXxuD7wo4pek3aQ6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kcgL94+L1tIXT1R8vfU9UzdbVrMKYIDLcHvPGal+1A=;
        b=TlEDFOueq6VJ3H6YW7Z3bWUlhsD0ahfyJDBaXB6zxwQ2W+azAjot/Mt9fg54O9fqWA
         7Z/h3Zu4l/kVjbWPHhmye4SfOf1d9grzVrXP0E1CPMvnU2IBVGFJQs9SmdMoygE9LyNN
         NmHmq8lXfs9dNc+37VzgDXZGWlrG3vD2LRDwiHcS2vopgyQQu4pOFpPHj5AvzV00MCeT
         dMFNJWFPPLg3vuEwDAY2OrajQueBunOmpdlIvGf4DigdotK4BCXyYLmxACx6ybl5c42p
         wmRp5Jrh0vV2IVREhS0iqZhjxBLd8fjPXONJQQ6Lwwi2JI5pQCAoG/on8sPrV7tGOYEo
         CD3A==
X-Gm-Message-State: AOAM532M1hS5pJLRyqsdBL7+dtsRpVIEgWvQYI+gjRQQxMGPFM7EnRFk
        wQ0Pu16XxSnx/7tz0flXqJuLevFwUw6LU8f3M7A+og==
X-Google-Smtp-Source: ABdhPJwg1ssQ28iX2I+mijjOyb6szTErEc2v03CrScKzyn9CA47P04+7k072VSz5R/vYT31LV7LexBEMXka7Q6QXIJg=
X-Received: by 2002:a05:651c:1318:: with SMTP id u24mr11838773lja.426.1614678441745;
 Tue, 02 Mar 2021 01:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20210210120425.53438-1-lmb@cloudflare.com> <20210210120425.53438-3-lmb@cloudflare.com>
 <20210301100420.slnjvzql6el4jlfj@wittgenstein>
In-Reply-To: <20210301100420.slnjvzql6el4jlfj@wittgenstein>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 2 Mar 2021 09:47:10 +0000
Message-ID: <CACAyw9_P0o36edN9RiimJBQqBupMWwvq746+Mp1_a=YO3ctfgw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] nsfs: add an ioctl to discover the network
 namespace cookie
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 1 Mar 2021 at 10:04, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Hey Lorenz,
>
> Just to make sure: is it intentional that any user can retrieve the
> cookie associated with any network namespace, i.e. you don't require any
> form of permission checking in the owning user namespace of the network
> namespace?
>
> Christian

Hi Christian,

I've decided to drop the patch set for now, but that was my intention, yes. Is
there a downside I'm not aware of?

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
