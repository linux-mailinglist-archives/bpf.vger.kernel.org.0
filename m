Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F4B413FBB
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 04:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhIVCo4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 22:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhIVCoz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 22:44:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB098C061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 19:43:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j14so783932plx.4
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 19:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Nbg3mrXvbsgV9SSnmtsSXXVqeGLNg+xe75XSv9J40g=;
        b=flsqT85ArHGgTQMZKW6a5gWGRWqARLDG/+X+yBhUReRWDfYaqTgG0HEGTXGluHcGhr
         SqG/BBF3yTPJvUOCMU28z4NaDWDF814LPI1dsfNX+uOetkJtPuGqbMe+CWrrfY740Skm
         IEaTIyaW2kN28g85mdsIfj+H4YLk+VhVKTMjcDK6lXVd9X5enP+yJmUBRBmoCA46qhZp
         y3eclK6rT1YGXDwhAyEHvnJzZgq3HQs5DooUelxxCBwM8Vgz1RDqv18iKxyyd0fXOYvC
         sOAvUpFyMtOT8wfGo4grV3hoGHsJaghBrlF78bYH6dJX+4GMDSLg0Zc+6jmY2u02owEt
         /t6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Nbg3mrXvbsgV9SSnmtsSXXVqeGLNg+xe75XSv9J40g=;
        b=B+l2ir3HC33T1g+adAlC70rE6ri2HtkuMDPRDwSO4hy1RKK/od8vuZ6jQMbgw7n1Wr
         iR1fmMza8wjp5zcCn2vp+36+7V9ItJT36HkrGMSJTNvf61NQPS9uoXH7wihGnHzsXDxT
         yNA45Qg0vPA7MrRfcjgfyFLkeC8ZLufDFeW+Ezp5XYagmznLOTpnxlOo3o1PycYNMcj+
         0jonzc9LS+eb1KuyO8H5aLb1/0z+YyXGGUdvrNB8Iyyrm/ztWFxPJvTk67ec0dALP1KE
         qr4QPizM1q54Ym2rfyzRUavskN9MbiPU9tsSphRbSiC7wPsUppNjoMlCKMP/KDfnuRgy
         NC2Q==
X-Gm-Message-State: AOAM5317UOrCJk2YEM6bvDc+Y8MVZUumEcM35AAvGg6wqss4sL/JlRuW
        B5FSPPOlXFbtEUN5lGxx5PhaYGcTBaCRewIgVyideaua
X-Google-Smtp-Source: ABdhPJwqPp3XVRpTnPesLtr0OnUeiin+aSKhOEI6Pk7sPZQg4ALnAi4qJcXEnMtkozajLrJfpen+1BiBdo5dbIffGrQ=
X-Received: by 2002:a17:90b:1c08:: with SMTP id oc8mr8768881pjb.138.1632278606267;
 Tue, 21 Sep 2021 19:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210921210036.1545557-1-andrii@kernel.org>
In-Reply-To: <20210921210036.1545557-1-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Sep 2021 19:43:15 -0700
Message-ID: <CAADnVQJqCSWAg1O_XwuFi2zb+1iSvkxvZdDg9Zs-ddRa1KrHyA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] libbpf: add legacy uprobe support
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 2:04 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Implement libbpf support for attaching uprobes/uretprobes using legacy
> tracefs interfaces. This is a logical complement to recently landed legacy
> kprobe support ([0]). This patch refactors existing legacy kprobe code to be more
> uniform with uprobe code as well, making the logic easier to compare and
> follow.
>
> This patch set also fixes two bugs recently found by Coverity in legacy kprobe
> handling code, and thus subsumes previously submitted two patches ([1]):
> original patch #1 is kept as is, while original patch #2 was dropped because
> patch #3 of the current series refactors and fixes affected code.
>
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20210912064844.3181742-1-rafaeldtinoco@gmail.com/
>   [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=549977&state=*
>
> v1->v2:
>   - drop 'legacy = true' debug left-over and explain legacy check (Alexei).

Applied. Thanks
