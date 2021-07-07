Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8EC3BE061
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 02:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhGGA41 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 20:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGGA40 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 20:56:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CE3C061574
        for <bpf@vger.kernel.org>; Tue,  6 Jul 2021 17:53:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p21so939274lfj.13
        for <bpf@vger.kernel.org>; Tue, 06 Jul 2021 17:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSH5KOGdQBuS8hnLpzEVpeWhRmgrKAYzq8zVt0z5QW0=;
        b=gp0685ccztlhrruyZHvZ89gv/drO7DasNsIbIIUc1WptVLtEOu0QVgBp3D6z7PwLpg
         EPcZdXpN+VaqgB8ryn+E5XiKCl5njyHBaBraBamTi7JVJD2j5a4jv7Hk13s4hYr0/X/w
         n4OyJwqH5sOifzf2+DXYMPdeWIjCdybW4poe4b7TBbkf//1PUlgMSg6qiozXGSneF1Ks
         FecmVH3GqA8+gBGu+7ozybJ7IQpoDi37uyww58dnmjY+6N0FCOJVy0/MpF5bHjLjgLN0
         XxQiQZdBfJjjqw9mjnv9A+/NUzjUp/6TNu7U5Py3HmFr4X3gV1la6IQNYWtfZM698V2A
         p3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSH5KOGdQBuS8hnLpzEVpeWhRmgrKAYzq8zVt0z5QW0=;
        b=Obgr1pA88bPsULqiCSGZsqPut6lEAw9OwnzTwkyymy1pX1s50fT8CG6eZbHywGf3Mm
         o5ebiJiktW1D1CKRN6AxmAfrx7zzH1Wkh/IpJ4rZh8sg64vJFRGqnK70qFv9krL0yTuI
         7spwkrLTmtJ+a7FruzRsW8X8m7aQ29zbzMT+FY0RWv7QElVybZxPVre6RQylqgzhk0qW
         kmY29Y/uwjBqV9mkikEOZtHUGpueUkm/U/PxCoWG1atnsbSczAJL0LM6ux4KpqBrTK1+
         jzWzCyN4G7g1LJEBRTt1RfX1gUVCiI6l3WWZ2Qr8UxKAfWqZ7Ah/vVmBPtWoK/RBI2As
         KOTQ==
X-Gm-Message-State: AOAM531RU/Uoy9om4IwPO9aID1VsDNQiRnt88soZ86G+8RelV6BB9IHV
        b78btn/pCNKnkJPledEcAn0Ob/5FvIossun87i4ORndX
X-Google-Smtp-Source: ABdhPJwUT0mqI3UrhqKWOsIGGJylAbtEwlk3uBg2Wvuz9Yos8QXFoQb88QjD1ClFnQmWU7w09xWBpQ61lLDL1HNku0s=
X-Received: by 2002:a05:6512:3f9a:: with SMTP id x26mr17736063lfa.75.1625619224596;
 Tue, 06 Jul 2021 17:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <dc71d2f8-acd8-c88a-1ec6-1b733fa03440@kot-begemot.co.uk>
In-Reply-To: <dc71d2f8-acd8-c88a-1ec6-1b733fa03440@kot-begemot.co.uk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 6 Jul 2021 17:53:33 -0700
Message-ID: <CAADnVQL177FHCroCZ_F5hwhgN6GRmoGFwbA4UZCPGVRMpqgEJg@mail.gmail.com>
Subject: Re: Access to a BPF map from a module
To:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 5, 2021 at 9:00 AM Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
>
> Hi List,
>
> I have the following problem.
>
> I want to perform some operations on a bpf map from a loadable module. The map is instantiated elsewhere and pinned.
>
> How do I go about to obtain the map inside the module?
>
> bpf_map_get* functions are not exported at present so they are not available. Is there another way besides them to fetch a bpf map "by fs name" in a kernel module?
>
> If the access limitation is intentional, may I ask what is the actual rationale behind this decision?

BPF objects (like maps) and BPF infra are not extensible or accessible
from modules.
That is intentional to make sure that BPF development stays on the public
mailing list and within the kernel.
If you could describe your use case we hopefully will be able to come
up with upstreamable
alternative to your proprietary module.
