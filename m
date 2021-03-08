Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815C3330A57
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 10:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCHJdv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 04:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhCHJdV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 04:33:21 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC01EC06174A
        for <bpf@vger.kernel.org>; Mon,  8 Mar 2021 01:33:20 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a17so15233441ljq.2
        for <bpf@vger.kernel.org>; Mon, 08 Mar 2021 01:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpqQYtNxI2EYftvKZqg0C0+CNDsRpVCG9S8FtJReEZ8=;
        b=gpQo8KrxJ9chq2psqVfMBIu1zEiwm6C6jECWc1zW0oCnyUzaPU1x2UNEViPKJSOHtD
         hum5iiUsFZFjBFYZ+FCnaAHAkEXx/gHcC4PP2+DPrNlDpYTcm6pv2XGgzJaB0L3dTUVq
         X6t4NeqtZICV0Chi/Zig1y2aXJvUZDhTBzZ3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpqQYtNxI2EYftvKZqg0C0+CNDsRpVCG9S8FtJReEZ8=;
        b=lekbr6iHYFOj6fbGyK41VRKcK4iYmtviaj28J9+8ipvtmgEmH3/HBHxgtUUhHPp3YK
         iHAxgNeTpqCSonnBfLiBCiw6KupLhlxLyd5oT1JaOrJrNedTC5V8fRqC6ehyAUeQMLOc
         yRIJMXhe3Mk3Orbo+xrF6pHGsIkaMA8aBr8IP0REIW2908tPY/XXL3VwZ2wDvBUNJa6D
         0txLSVx+jfWEUnVuVHuUo5GQ3gOXzh0WTHHJ5jepMPnMk3NIzWnk/r+Loyx3+WmxBreT
         QwUa6cY5W/2GHlJBr2hhCFbDTmWg+a50zYeciTwitADMk/NpGY66g8GhfjdjdUPbxgVl
         FOWw==
X-Gm-Message-State: AOAM531Tc3cqAlJBSsBYDb4yy73TMnnbqmJ4aiteKbSGAeiFdE8mv22j
        x8jVg3ujUe8pdbkeGNbP8X7doLMRPXEEDSATDJV+zA==
X-Google-Smtp-Source: ABdhPJx6WZuhqE5cGxqSRVRzdPW65PMeqDYs5Pwxqp0Z5jung+LiP/+SMjlbhRsPpVPu2kcl2pmqfnIENUVx4ZrzF/c=
X-Received: by 2002:a2e:9244:: with SMTP id v4mr13822091ljg.196.1615195999403;
 Mon, 08 Mar 2021 01:33:19 -0800 (PST)
MIME-Version: 1.0
References: <CACAyw9_P-Zk+hrOwgenLz4hCc7Cae9=qV86Td2CkGVUPAzWQ8A@mail.gmail.com>
 <a3782f71-3f6b-1e75-17a9-1827822c2030@fb.com> <6c02f403-666f-2025-4a57-416feab147a5@fb.com>
In-Reply-To: <6c02f403-666f-2025-4a57-416feab147a5@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 8 Mar 2021 09:33:08 +0000
Message-ID: <CACAyw9-Ow9=u8EGz5Fx2WYy_hThAGXRu=iWweWzKEps0qpDzmw@mail.gmail.com>
Subject: Re: bpf_core_type_id_kernel with qualifier aborts clang compilation
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 5 Mar 2021 at 21:36, Yonghong Song <yhs@fb.com> wrote:
>
> Lorenz, the issue has been fixed by llvm patch
> https://reviews.llvm.org/D97986. It is in llvm13 trunk now.
> I have also requested the fix to backport to 12.0.1 release.
> Thanks!
>

Thanks again for the quick fix :)

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
