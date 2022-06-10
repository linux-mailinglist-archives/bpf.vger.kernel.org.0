Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6AE545948
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 02:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiFJAou (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 20:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiFJAot (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 20:44:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5363BF6F5;
        Thu,  9 Jun 2022 17:44:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fu3so49091344ejc.7;
        Thu, 09 Jun 2022 17:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9j4hMC8yZPUVWHlh5QqDt7MKf3QVHD/GceSSuONapU=;
        b=nru09NlCRUkTOI3AvrZn0DPpOJgNEWzujsqAea7RBHiH39Vg+1HC0KXmzC4T1Epa66
         U6L7f4/47EvjlJ0iQUhaOrKb879ZtamK4bY0FZfX3b1zA/hwMhXTqxREL98K3usZzEhE
         cswPsF0b3bafKubNawLZnPiaXZG0JdEe4nMJOjhahdCqRJcEObG+PUF6FkT9UQ0kKJCF
         /dmGIj9QcbWgFIONv0TXsaYdp8cWoKttv8BP1lQOMGYwVGVGisLyCA7b4V0cl2XZJ65p
         3XrXdFdTnuokFi5MuLUgtsSBvuWc7MAkw5tcoSkYD5dVhPLp4L1W6KZfElgETpoDLx+C
         5qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9j4hMC8yZPUVWHlh5QqDt7MKf3QVHD/GceSSuONapU=;
        b=J3KvzTZA9GLOKuSJ2G53ylZtAyFnZIEjmR+Izg9D/HM0Pn7Hd5wGqoXwPVXnSdJDST
         qyOiJUn1kH3kuOkakGgpFRuIUMdDqYZoK2sqZM6C78XRUqAeoKK2z6xNjo/xIFrGR5Qf
         b+9ra046h1oOrJzoczO0hV8I3611lHhQo33iD+naEI/uepaZogmucCco7mwVmirFtqEm
         xAPX4e7JTtmc9aOaBhqiqM8pM4LbsIskKdqwQlH3tHArOE7kIHTaEcuLjeFOTvBr+BYD
         hdRgkoyjgY3+xdpvW0XLy+p+FHcWP9wPcHJhnfbJf70F1xF/uEdEzuWs+/vwQUHyQXmc
         yU5A==
X-Gm-Message-State: AOAM533wcLDqab5rbEmFDHntkEmkJ1ULupcGd2WP48SROiSkPtQ2Cj2h
        TvSF91BchbzCsPj1SYwClO6X48SRuRFALvsvZMI=
X-Google-Smtp-Source: ABdhPJyLOCIxjIfbzNWU7I7gk3D/rmHCGERnsVC9S6afxRJafqMz38/6sjnWkks2UfDC6nyME+4z8+h1VVJX77xBJYY=
X-Received: by 2002:a17:906:586:b0:70d:9052:fdf0 with SMTP id
 6-20020a170906058600b0070d9052fdf0mr33113584ejn.633.1654821886569; Thu, 09
 Jun 2022 17:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220609234601.2026362-1-kpsingh@kernel.org>
In-Reply-To: <20220609234601.2026362-1-kpsingh@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 9 Jun 2022 17:44:34 -0700
Message-ID: <CAADnVQJSijXmDG0C+U101ahgOYTmHEuyBu_=CS87rJ9GchFQyA@mail.gmail.com>
Subject: Re: [PATCH linux-next] security: Fix side effects of default BPF LSM hooks
To:     KP Singh <kpsingh@kernel.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 9, 2022 at 4:46 PM KP Singh <kpsingh@kernel.org> wrote:
>
> BPF LSM currently has a default implementation for each LSM hooks which
> return a default value defined in include/linux/lsm_hook_defs.h. These
> hooks should have no functional effect when there is no BPF program
> loaded to implement the hook logic.
>
> Some LSM hooks treat any return value of the hook as policy decision
> which results in destructive side effects.
>
> This issue and the effects were reported to me by Jann Horn:
>
> For a system configured with CONFIG_BPF_LSM and the bpf lsm is enabled
> (via lsm= or CONFIG_LSM) an unprivileged user can vandalize the system
> by removing the security.capability xattrs from binaries, preventing
> them from working normally:
>
> $ getfattr -d -m- /bin/ping
> getfattr: Removing leading '/' from absolute path names
> security.capability=0sAQAAAgAgAAAAAAAAAAAAAAAAAAA=
>
> $ setfattr -x security.capability /bin/ping
> $ getfattr -d -m- /bin/ping
> $ ping 1.2.3.4
> $ ping google.com
> $ echo $?
> 2
>
> The above reproduces with:
>
> cat /sys/kernel/security/lsm
> capability,apparmor,bpf

Why is this bpf related?
apparmor doesn't have that hook,
while capability returns 0.
So bpf's default==0 doesn't change the situation.

Just
cat /sys/kernel/security/lsm
capability

would reproduce the issue?
what am I missing?
