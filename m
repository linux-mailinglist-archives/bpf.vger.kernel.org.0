Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1FC1B5AC5
	for <lists+bpf@lfdr.de>; Thu, 23 Apr 2020 13:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgDWLuP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Apr 2020 07:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727081AbgDWLuP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Apr 2020 07:50:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB81DC035494;
        Thu, 23 Apr 2020 04:50:14 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t11so4497254lfe.4;
        Thu, 23 Apr 2020 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0myt66h+KuJjxp6VJJBImdgi/+DrnmI1vWbnrvx6uF4=;
        b=dCQSm3f+PEwrnEUww5FJRA78dUepbt+uKSQgCnAfHxF+0xIsM4szquq+IjXS6UBZg5
         PlQpdIjw8h+9OBx1D3c1D9aWz8UGX/Muwp1Hoh7BRmW9BpKs80ZD8FsCDv2LI+tLy0cb
         cRYGtEvn/5/9X6uH1vU1G/PmcCGlQnJ0rq24qrdiHLgJF2d5YjK4lVR0EyBwK9u/T7An
         ZhXU9KsSYTGc5Bhdd6KJP6Nncux4r0o+hmUKdC96wTE43Mhan4hC5aLjSjqrsVJV9s0S
         coxAdaCARKmjLV83b9tw8hMzOLJfQSnsGCUGnaNQZ1U3J9CSoxDk0RnE2YhJU6Hi56VW
         SqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0myt66h+KuJjxp6VJJBImdgi/+DrnmI1vWbnrvx6uF4=;
        b=BWxTNrX2Ll/C3Am6OEx+FR6UqOhqmB3BxClUGb/SyWni0EMWAnByLTq1xHXqbpS616
         Uy+zE0GudWS73IKCACDdlk+NFsSdgdoV8FnQcRp8gN5x7AxybELGDU+dOxLFA3UMFlNq
         7tLluJM31d6C1admoeubBCzSjWwEIBUFJYhPtuZHFVjoWMzz1RlPwvihDvtiqokytYh/
         cYodhaQyhkWZ6E6DM7JzgAKV+xVDWUbU6l+kS/iRRQVxYBW7v40o1YsOKqsasHTZP0jP
         LkyMex2m34OMSfy+cr8TlnGYBJelr0wpLYdpmryNezhp0Hz8jJWYduDrxMweKfToFF+L
         FdXg==
X-Gm-Message-State: AGi0PuZjxgVAv/OqH4qspafPUr7WfIbFejjQGNeiRdMsPD/pZhkx+vB1
        0ucbRKaabV2yD21LGHbVlyEv3X2/Ge+l/VA0/tG6WA==
X-Google-Smtp-Source: APiQypKZRn0ziiHFKI4kHuz8qP+crx/uaqkj2hKD1Sp7uDRG9p/ViyTblhjFD3/iLMGplyddPzqJIvHP5UWaYZY7DtI=
X-Received: by 2002:a19:9109:: with SMTP id t9mr2271272lfd.10.1587642613050;
 Thu, 23 Apr 2020 04:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200423073929.127521-1-masahiroy@kernel.org> <20200423073929.127521-15-masahiroy@kernel.org>
In-Reply-To: <20200423073929.127521-15-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 23 Apr 2020 13:50:02 +0200
Message-ID: <CANiq72nUa8uoXtSThqq7t9oAmZnGSE9a1_d+ZoRAagpKDo4DRg@mail.gmail.com>
Subject: Re: [PATCH 14/16] samples: auxdisplay: use 'userprogs' syntax
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        bpf@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Masahiro,

On Thu, Apr 23, 2020 at 9:41 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Kbuild now supports the 'userprogs' syntax to describe the build rules
> of userspace programs for the target architecture (i.e. the same
> architecture as the kernel).
>
> Add the entry to samples/Makefile to put this into the build bot
> coverage.
>
> I also added the CONFIG option guarded by 'depends on CC_CAN_LINK'
> because $(CC) may not necessarily provide libc.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for this! Looks nice. I guess you take all patches for the
samples/ changes through your tree?

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
