Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F162B0F0F
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 21:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgKLU3g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 15:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgKLU3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 15:29:36 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2011C0613D4
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:29:19 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id p12so7775924ljc.9
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5vf4lP9wnfH0LUzbBBcbdWfEQQ9TSKop8FfDOsd61Q0=;
        b=P+h9KuxPhuu1NTJNRN9kJ6Wmc8UU3NznYihiPyXBupeX4raR8Fpk52/3I3VuYiUVNr
         4BKWt4ZedxIhgt4FWtzH2/qsoPnmefgo/OjGrOVs9pFbApLdGjvSdHI0JwKcKsMKy06p
         6/edl4EnbSVclpkxbUbNX2EHoAJfWn/55CO1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5vf4lP9wnfH0LUzbBBcbdWfEQQ9TSKop8FfDOsd61Q0=;
        b=g6RjZbradMCoya5Beax7Y876gHfcrjm8faaDdOx2At/fdZh+hinFp3x9vBQWhC9MQQ
         jz9of7bFhnBgGXmVIKc2RMQb3k28c+Xm0LP4l696Vo4y85AbiPb1reAzipiDQPoV0+TS
         Dlzztqg5Ya1GqPo1/5FTy23h0ERgEtabtCg/oLbt8n9pNPZXzB+fx8Kax+xrN0W53sV4
         sUrHlG/NVvGOhKX/3O/ntrYiUkefU4v7BgAoSPpZB6u1UZ3/HsYi+ufdwjtI6zAit+5C
         c+2PuIBAZ3jiIvLRFlrRklFvG04sDQEz0Ioe7TzwkMS0yXfrzFd+a1n/nH8j0Mpq4yJ2
         Eiig==
X-Gm-Message-State: AOAM530rBm6pAkSMtdvtNJioXLhErkEfD8BlsYZLB5Po2VD2QbUh3rSA
        vg5j7j8agl4eyRIlBEF3cX7GSCAI7T8aUeaIaJImwhcpiHmZv75P
X-Google-Smtp-Source: ABdhPJx8vL6q4t437J/9H9nOcxD7k2iRyQ9ak4YEvh90L/tX/8ejTifHw6ttdjBsvo893UePV1C7nxP46h1hpkhI6Ew=
X-Received: by 2002:a2e:8e3b:: with SMTP id r27mr533438ljk.466.1605212958196;
 Thu, 12 Nov 2020 12:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20201112200346.404864-1-kpsingh@chromium.org>
In-Reply-To: <20201112200346.404864-1-kpsingh@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 12 Nov 2020 21:29:07 +0100
Message-ID: <CACYkzJ5ctN0wJfy5gWsR=+-DnmqaNZBF=QO8+FEB_qH4Sfm3=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] Sleepable LSM Hooks
To:     open list <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 9:03 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> # v1 -> v2
>
>   * Fixed typos and formatting errors.
>   * Added Andrii's ack.

Oops, I sent an older patch file which does not have Andrii's ack.
