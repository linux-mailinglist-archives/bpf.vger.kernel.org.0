Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783E124CFFC
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgHUHw1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 03:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgHUHw0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Aug 2020 03:52:26 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86EAC061385
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 00:52:25 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g14so898684iom.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 00:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Je9QBZ4HgxobPUcmnwUOyZ+DLSuSOkQOi9CyPbhagdE=;
        b=q1TjEAuffiFGMySAK+bC3pad4/UgDrUI8XIB4d2bmmBeGkbgd0pwoCfqYr5w1XE42k
         BZ0IQx5IwKXEz4wn9L/GujxZgei5fPLrySR5tcH+3LDVgqHDjJaZIbuvOj1nnmzrePWi
         mnIpqc4fb+1Z2kB2tXL+FICEC+VeN43bNhrgi2ynPMDBCGGS35eBeDEO0WQnMVnY9Fk5
         Zzomfil3tEN0hKOEEKnCgTikF1qdnQE3OWE6OFnHXCXNV8QFdT0063+4V3o+B76edmLU
         ykaz5sqYXUiNxur7HU0NhoEbWMQEVvMs+nxPLo6OvzIht+jVSa14yciEVBmkAvg5QRGJ
         PSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Je9QBZ4HgxobPUcmnwUOyZ+DLSuSOkQOi9CyPbhagdE=;
        b=Bx0z84f+JE2szmLsbxc3DuuPDQr6zxhLc6hlMcm21nJTAhWVM+5PEP6kD0JgZljulx
         VXTuEhC4X9Y2IS59mkbiAWzh4x8PisrYVSdUjkC2apOH5bCE7x3x8gXjR8JY3LTI44Bw
         0XOvEujc1pKiEFWazoB93EW3VRjcztxMX/wZdw6BagMUg8aCA6kd3CjsxyyyBjcO+tdO
         aEmeZAKA2JiObfpAF2HUR6ykGSIzm9VMETIyWmUJkT+iznok+OwtmYYBd6MTBTdT1CcO
         ErgQtyhsvbnKnoHE+iqGbnSIBsDccR3x2wp3sYXCwEPKFR8/QFHsKWuYcwB6z8x8yKYV
         FDrA==
X-Gm-Message-State: AOAM532v+2nf8KUURpguSXNYX17e5L5G9OwnDHXoqWyzeqBUqMi4YWLk
        wZ5j+gDe64rVWzbzWqCNOCWscDi/qLmtlzc9ivHN3A==
X-Google-Smtp-Source: ABdhPJz6WvSl1IWyUN2im6wMNb35IGIZhatrBB6ab4DdG+b2pUFr90WmcWgN9iF2R2YKonUNqiA1ppzOb9hME7BZRRc=
X-Received: by 2002:a05:6638:d4f:: with SMTP id d15mr1455779jak.119.1597996344296;
 Fri, 21 Aug 2020 00:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597915265.git.zhuyifei@google.com> <b65c850c8e9f9ae8309c8a328a3d53ab76289c5b.1597915265.git.zhuyifei@google.com>
 <e4d7e9a8-19ac-b107-0f5d-8f9322ff9d21@fb.com>
In-Reply-To: <e4d7e9a8-19ac-b107-0f5d-8f9322ff9d21@fb.com>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Fri, 21 Aug 2020 02:52:12 -0500
Message-ID: <CAA-VZPm_4q=nkx2PaawtdpesqJSMQdziNwV5=t3zgW8WM6Q9kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] libbpf: Add BPF_PROG_BIND_MAP syscall and
 use it on .metadata section
To:     Yonghong Song <yhs@fb.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 20, 2020 at 3:38 PM Yonghong Song <yhs@fb.com> wrote:
>
> > +                             int fd = ret;
> > +
> > +                             ret = -errno;
>
> libbpf_strerror_r understands positive and negative errno, so no need
> "ret = -errno".

I don't understand this one. The use of ret = -errno here is that when
we goto out later we return a -errno. If this line is removed then fd
is returned after fd is closed, in the case of a bind map failure,
without writing to *pfd. Am I misunderstanding something?

YiFei Zhu
