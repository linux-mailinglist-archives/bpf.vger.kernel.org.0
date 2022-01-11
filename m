Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F2548ADA3
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 13:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiAKMdY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 07:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbiAKMdY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 07:33:24 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD0C06173F
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 04:33:23 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u21so43968094edd.5
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 04:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Iyuyw1lveh7BTFp098e8inSytxlbldUsFUYZq5M97Uk=;
        b=aVLGEFN09CKi1L79iT5rILR6v9jOAVdekFvJF4VaYNrToUHG1Cyo8hnQZywkZpC01d
         57g6mUp9qQm9BNfeRkv26sDFFrRqdnsFSOJM2BFgStJB3fQN7IlVZfaXArd3bYPqk99j
         WCeK4c9QNxyAljPajfToCHA2REUso/F9PY66H3LJcRglH3njse+lke3iU+qD/W179q9r
         wp0XwZBPqQEVmcBvhveLiM9VKrmJqcaPDd6AkVgP8Lg3eSvmA+sRroGeupl5RsvmzCGm
         pDjAMsr4LzyPzSBunnqpD9v2on0VxCvjH/937yl4zQb4GTGtT1vXNYnwwQRB7VXt/0vE
         ZYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Iyuyw1lveh7BTFp098e8inSytxlbldUsFUYZq5M97Uk=;
        b=nXN/LC131dIlWsa6hANa1NlsB7+cqvXiFFgQ1DR8qlkNmhUcrgs53Xay8Yv94OkjyG
         4GA7wDnCza/Rc8f1OsLOuzkGFUGg+/Qz5giq0nUntQVw5aMsz2QKqafvP/DZd0pujC//
         HvnM4TxT+IzydFAlTaPPh5lDzm+VKq+3sD5k0leWA0TIiEzEdsZq3/c2WhcK3M8Ep8SF
         q0pwzR/z5LwcPAMssh4rwpKCIgA8CF/P1S6aMdIb3PdQ4FA7W2v/U4Ti1TXN+oaKCMU8
         KBL7yWiV5UVBM5fjppXQFBlzR4RBSkptO6fKNNKbbYwI9Yzj/rfWKM34clQwLiaH/wR4
         OCJA==
X-Gm-Message-State: AOAM532Jr/67wh0ZkNNk9rmQY8D+ImQ7syY3fhTHgkHlIGtHSgQpr8Xf
        rY2jpOgIDieEgjU1vWyFkqCu0c7cffpR2jS0wh2fbAjty5Y=
X-Google-Smtp-Source: ABdhPJyR0qnV472ATGcu34aK1/QmHVSx8gseak5XZ6Oad+pbyfGpU3QOXZiP2S6FXl7a4apAQjRDty2Wr9hsLCfqN/o=
X-Received: by 2002:a05:6402:124b:: with SMTP id l11mr4054749edw.9.1641904402221;
 Tue, 11 Jan 2022 04:33:22 -0800 (PST)
MIME-Version: 1.0
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Tue, 11 Jan 2022 14:33:11 +0200
Message-ID: <CAMy7=ZXqyoaw0mOk2Z8ADxUSs95B=SRgvTua3vRJ00nS5qTFgQ@mail.gmail.com>
Subject: libbpf API: dynamically load(/unload/attach/detach) bpf programs question
To:     bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     michael.tcherniack@aquasec.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello!

I noticed that the bpf_program__load() API was deprecated since libbpf
0.6 saying that bpf_object__load() should be used instead.
This, however, doesn't seem to fit our use case of loading multiple
bpf programs (that also share the same maps) from one bpf object (elf
file), then unloading and loading them dynamically according to some
given needs.
I'm not sure it is possible to load one specific program from the bpf
object using bpf_object__load() API - is it?

Another question with the same context -
If I understand correctly, the purpose of detach is to "prevent
execution of a previously attached program from any future events"
(https://facebookmicrosites.github.io/bpf/blog/2018/08/31/object-lifetime.html),
which seems like something that I would want to do if I just wanted to
temporarily stop an event from triggering the program. But then I ask
myself - what is the meaning of detaching a link (and not
bpf_link__destroy() it) if there is no way to attach it back (without
re-creating the link object)? I don't see any function named
bpf_link__attach() that would do such a thing, or any other function
in libbpf API that can do something similar, am I right?
Also, It seems that using bpf_link__detach() does not fit all link
types. For example, when attaching a (non legacy) kprobe, detaching it
should probably happen using PERF_EVENT_IOC_DISABLE and not through
sys_bpf(BPF_LINK_DETACH), shouldn't it?

And one last question:
When using bpf_program__unload() on a program that is already
attached, should we first call bpf_link__detach() or does the kernel
already take care of this?

Thanks,
Yaniv
