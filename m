Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C092C7BAC
	for <lists+bpf@lfdr.de>; Sun, 29 Nov 2020 23:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgK2WW6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Nov 2020 17:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgK2WW5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Nov 2020 17:22:57 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79F8C0613CF
        for <bpf@vger.kernel.org>; Sun, 29 Nov 2020 14:22:17 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id l36so9615207ota.4
        for <bpf@vger.kernel.org>; Sun, 29 Nov 2020 14:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iIyisqiXWadn6cs+V8CD5moLJZvksL222yjVKbKWQQ=;
        b=FIBjXgyvGx0hVpuHRmBhBnxC9VvGAJo2TfvDVyrmHeSlLDpBE79xdft4tjpIvEp+uy
         bp1s+Btd1TmXdMm67/+kY3ym9iE8IeBClyOzd5y75tmpOrB9WlUQ+fQ3dobSlCkDRdh0
         PyK67z24kBtdWloXpCrj8mNlTvPliIHWYlxPe1zzgQQmIoXUbBX/Gg2BlRxJgtJuDXik
         U3idHLPhnAVQnPl+olevqqhfx1DS8Hfig1CtqsSmiQCWRvf3WcxaXgK4A7RT4/7RK6aQ
         BVk+MGstPqyHgjU2FHJPcflrKQwWZv/0altUQaB6be9H8h3ykZo4HYCymeBKBJLeyLXz
         hBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iIyisqiXWadn6cs+V8CD5moLJZvksL222yjVKbKWQQ=;
        b=aisFhougH/Pcq8G8H+rUC7E1afmsyUH2DXguosHjRqyJWlk36cQhXdvixRyGwHnraL
         3f3a7jwCEu556gXnE00V8245QeOuJ93LMV6WmuVH9tPoHzckKepyZOVMtMZ2mHmAGKoe
         Kt+9olnjHPvQxuXHFlS3q5YVRO8V/jdSxMUrmDiAIWGqVGQtf7+LEk+nLndVIKVAaUwy
         gIEw2eKfLlWE+9Edm9O8Cns9JXEXzTrqcBvzZdti4AC7XpMRP+FW+SQPHou+XJyH0tpL
         Nu/zMfDGl8mPSb6nMsuxoMEzNfLtV7zoClDsJTjnU0IM47rEX3ByiQ/42s9xUV4tcTsa
         vdQw==
X-Gm-Message-State: AOAM530g4mFkY/YOz15vpg4dJswT82SpLiiDtNsh4f3DJKWq3BeAuCl3
        LtUWiP7FulFMKFpSstl9g8hPI21pf6QOV8MAuGIcJqHcdgo=
X-Google-Smtp-Source: ABdhPJwv13VxP5j8cXXFHKApC384D8IgBSFXNn/Vyi+AOiqDJJwgOuXw1INt8oKrDtCFAR11vea3bcLTTJdm6+y7Ubs=
X-Received: by 2002:a9d:172c:: with SMTP id i44mr14835642ota.307.1606688536959;
 Sun, 29 Nov 2020 14:22:16 -0800 (PST)
MIME-Version: 1.0
References: <eea9673f-5ee4-4adc-bc64-fcc88f715cc8@www.fastmail.com>
In-Reply-To: <eea9673f-5ee4-4adc-bc64-fcc88f715cc8@www.fastmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 29 Nov 2020 14:22:06 -0800
Message-ID: <CAADnVQ+2DiSH42cSjQ2fNEEc217c6C+SPEqSEzBJb22aZdm3kA@mail.gmail.com>
Subject: Re: HELP: bpf_probe_user_write for registers
To:     Markus Ongyerth <bpf@ongy.net>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 29, 2020 at 10:38 AM Markus Ongyerth <bpf@ongy.net> wrote:
>
> Hi,
>
> I've been looking into introspecting and possibly convincing an application to behave slightly different with bpf measures.
>
> I found `bpf_probe_user_write` but as far as I can tell, that only works for memory areas.
> Is there an alternative that can be used on registers as well?

fyi bpf_probe_write_user() warns in dmesg.
That was done on purpose to avoid usage of this helper in production code.
A new helper can be added to adjust user regs, but it will have similar warning.
It's better to discuss the use case first.
Do you envision user regs to be changed after uprobe in an arbitrary location
or in some fixed place and only particular regs?
