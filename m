Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99F45F776
	for <lists+bpf@lfdr.de>; Sat, 27 Nov 2021 01:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhK0AeD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 19:34:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36708 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343558AbhK0AcC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Nov 2021 19:32:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54B97623B6
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 00:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA7AC53FAD
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 00:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637972928;
        bh=y8h+mE84bh4/wabUgLFAAtFBHulippexAdIdyJ5i57o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gMOldYzZL5FY6SpZ1GN0229OPn138sEWsiAz9gd+M+pc0I8NC848kpmiBvfjvdRzC
         PmF2ZL3Zyfw5yO2f90UnaRsawgHIKL2FcS6aQbYBzp7yixI0EDFU9vuEUbAeeC+r9f
         pVDlp7FJIo10Iqr+fxz/+4lDcJAexUsDDpGhrwiE7XjB7yfbLOJX8mgWCpn+MqzjRB
         6cJlKLp0BvZKF9/s/oifmh/8uZ5CpDqot94Aa663NOgv4MBypec19kgZldhaoBcq9B
         2LtnKEmbLS0TmVgPjfQAkY5sj8SD6t1kKF4mF37FfeyfmyExgyGhFwyWh9pUMtYMoH
         jV5nVFlsjxbRw==
Received: by mail-yb1-f178.google.com with SMTP id v7so24301940ybq.0
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 16:28:48 -0800 (PST)
X-Gm-Message-State: AOAM531tldoGqsOJTezKwGqluKvLOycSAm0VIjOWhsXcXUMp5VletBAi
        h572KQuojpHoVVyuQRcBGX6N6DhzvCwusyeiu+k=
X-Google-Smtp-Source: ABdhPJw0tWL1PB2v/LQIyScYBpKu/9UD9v/b8FAdYWNPF2xKPVouY/jVMvVhUV3KwpZI3RShO77d+p1PmhXweC3Yg8M=
X-Received: by 2002:a25:344d:: with SMTP id b74mr19486660yba.317.1637972927908;
 Fri, 26 Nov 2021 16:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20211122235733.634914-1-memxor@gmail.com> <20211122235733.634914-4-memxor@gmail.com>
In-Reply-To: <20211122235733.634914-4-memxor@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 26 Nov 2021 16:28:36 -0800
X-Gmail-Original-Message-ID: <CAPhsuW65miR-nETWseUWfO0yfuFWsjJThpXk0YU-un=ovzLXzA@mail.gmail.com>
Message-ID: <CAPhsuW65miR-nETWseUWfO0yfuFWsjJThpXk0YU-un=ovzLXzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] libbpf: Avoid reload of imm for weak,
 unresolved, repeating ksym
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 3:57 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Alexei pointed out that we can use BPF_REG_0 which already contains imm
> from move_blob2blob computation. Note that we now compare the second
> insn's imm, but this should not matter, since both will be zeroed out
> for the error case for the insn populated earlier.
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>
