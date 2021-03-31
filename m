Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF53E3501D9
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhCaOEq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 10:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbhCaOE0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 10:04:26 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94F5C06174A
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 07:04:25 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 184so23967853ljf.9
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WkKKW/QkEs9/kkL1SzWso2zmgtPiw9JFTK148I7Nb4=;
        b=niP6gSWqtgY8fqKdzU9VHeMUI4+Y+aJZqdJSpI7MrXBBXbr/yaOMsYQfYPtRMHvRbr
         HFVoWRpG01gTfsI1lXIUDCA6ip2c2A8W/taxgcGCoJ7VmKM/TJYvM9p4JFAmOjKjWed/
         qYpl40v1nu9CC9vOjChykYcdyjD5HQw6VVb3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WkKKW/QkEs9/kkL1SzWso2zmgtPiw9JFTK148I7Nb4=;
        b=bd9/c0tJ83t1mM3FMigXSgzvVAYY2C76L8v2XZRkgtZA9kS6HlBd/rZRXgGIUY+62P
         RCWJB+NKVR6UOGpl4C564vjF8x4ANtZyhVbYTuGwGNsbNgT8UAKYYllf9llMB8KJK+Kt
         cuZZhtR4yzRCUO70ydJ1AKycsTesN3r1y/yaeMAhoqrJMGBTrl/Hklxev7QYl2yY5upi
         ZjoGMEvqBbI9JznlniJqtEvqULV2fPGY+VjbSTGHA0Af/ZWiCEbggloeADYLxzSmGn8l
         PE3e8akcoVwtMjoZToEB++y823w5hyIrHNpVGv2BbY+dL5kC2mY8h/pPhENOrMls06/a
         gyMA==
X-Gm-Message-State: AOAM531VBgtgqaAF9R4o8DyraMu25lM19PGKRuu0qOBq64hux4v+mLEu
        e7m1MrQ3Patd3fEL6zzukXGBvsBKToWSZPVgkLba6Lv6J2o=
X-Google-Smtp-Source: ABdhPJwGGJC46aQqg9+k+oN5WbxooZfC2RyoJrBbGmk9xp43AiM5ChwTRs/po0Pv34t6pPvRXgiXVBdqaoqxaQxZxkQ=
X-Received: by 2002:a05:651c:118b:: with SMTP id w11mr2156382ljo.223.1617199463908;
 Wed, 31 Mar 2021 07:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210326160501.46234-1-lmb@cloudflare.com>
In-Reply-To: <20210326160501.46234-1-lmb@cloudflare.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 31 Mar 2021 15:04:13 +0100
Message-ID: <CACAyw9_FHepkTzdFkiGUFV6F8u7zaZYOeH+bUjWxcBNBNeBYBg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: link: refuse non-O_RDWR flags in BPF_OBJ_GET
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 26 Mar 2021 at 16:05, Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Invoking BPF_OBJ_GET on a pinned bpf_link checks the path access
> permissions based on file_flags, but the returned fd ignores flags.
> This means that any user can acquire a "read-write" fd for a pinned
> link with mode 0664 by invoking BPF_OBJ_GET with BPF_F_RDONLY in
> file_flags. The fd can be used to invoke BPF_LINK_DETACH, etc.
>
> Fix this by refusing non-O_RDWR flags in BPF_OBJ_GET. This works
> because OBJ_GET by default returns a read write mapping and libbpf
> doesn't expose a way to override this behaviour for programs
> and links.

Hi Alexei and Daniel,

I think these two patches might have fallen through the cracks, could
you take a look? I'm not sure what the etiquette is around bumping a
set, so please let me know if you'd prefer me to send the patches with
acks included or something like that.

Best

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
