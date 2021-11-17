Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356F1453F54
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 05:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhKQESL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 23:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhKQESK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 23:18:10 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2A6C061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 20:15:13 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id v138so3351263ybb.8
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 20:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u62sDeopQ2/5kScIxmSyrjMhQth6vWE3Gpyf79b50Kk=;
        b=AM2riEM6KDyO9OqPJy22YDukfA9cn7FgcmlINQnezmZFOvd+yVIHox2VidQzpJ4DeZ
         4TNffJTHIGRwKiPgjhOixi/Sz8shfkqG5v/5lKdy5aWUocuVre7G4yT3y6QP6rdsHl94
         m1jzB6Wau+fesJaWTqCjRr8fEqd4ONcuCXeKGxwNwu2tCCg0DBEYXpT4I7b8gpbm01Ry
         UkcW9jy+dOc0DQFhTMxEvbZbKeJ6dieAiwxKu+KW7ThPyywx6fx2Jd1kRoPR/B6Ai7pA
         6GM3LC7P5NKJkSqIjepDqf1fi35qK3NuP4FIaxirC5qGBNCnNJWtvIrcBJOkcLGrnWY1
         iwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u62sDeopQ2/5kScIxmSyrjMhQth6vWE3Gpyf79b50Kk=;
        b=rKGpkrq0sCAf4dV/hquS9/OmCYzaRyMphV/gEk9hyxsd5w6dyDOZvVD1oT3C7moa2G
         W/eMx2nghvg7KNqXWy3+9E82WhKGlpsVDOjoeyQhVOL9KENgUx/MKeTFbylFAfthPg1p
         Lx1TbesnK2DIZ6CKqwv22JB7jWF3U9efBpXApNhNkxqpR9vs14sHZfd7xzlvPske/gp/
         IHMAp1ASejWrO+JVFX0gUbJTVkGsqqoN1R+DoVnK/arlys6Wl81700rGamOgwLMSAazq
         8xZ9Vci6CRrp/t61Pnr7AVdqmRQp+mZCj0Wccd6VSzDCzKE5yvE90qd6sjxQCDJ+sBN8
         PdeQ==
X-Gm-Message-State: AOAM532sJ8qpGwJe9RgDgk8Qbq7/QVFXS4YF30dQdGM1h77GEuut3/UA
        c0Zgsfr6MBdUtP3tdmuQq95VF9d51XdSOZCY+8U=
X-Google-Smtp-Source: ABdhPJxlCDBxDjRx+zS9GH3tlzMco+94vJxxqVqLbxDSzjzeBn6Er0KBcrI2GlBo2B+gdx6r/jYiiKVNwzQXk8lQ7gY=
X-Received: by 2002:a25:d16:: with SMTP id 22mr14379552ybn.51.1637122512402;
 Tue, 16 Nov 2021 20:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com> <20211112050230.85640-11-alexei.starovoitov@gmail.com>
In-Reply-To: <20211112050230.85640-11-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 20:15:01 -0800
Message-ID: <CAEf4BzYLTWWywZ=_Rv2UQehY_eoYyB+ggJw4_um7P6rDZ1N8sA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/12] selftests/bpf: Improve inner_map test coverage.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 11, 2021 at 9:03 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Check that hash and array inner maps are properly initialized.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/progs/map_ptr_kern.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>

[...]
