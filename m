Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD101E8940
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 22:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgE2UxQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 16:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgE2UxQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 16:53:16 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52DDC03E969
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 13:53:15 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 202so501358lfe.5
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6onLvbDDTQi9P1ixKKc/sXtCs/6RamfMd3X4Ca5X+7Y=;
        b=gETzNx0lYbK2z2kNr6LgmzKzIoUSbQH6sU+qj36RsHP2N59KwqE3S2MjskLoyEZeR+
         FySdMUm7p/xYY5qLKBTS0QnzYIunvw07rDpX3RmdIOss+x1Ww06ga3R+oqcjSR9H6v27
         N8jjQjoGfSlDINYa6bpLiZTW02k4ZmSUh53dhtABCaX94aYvn60EnBHhoAJa7rLsbkgI
         xGgKaATqe2RBuMElO5naY7/FJkLr4iUhUwktVpgHmgTIDXDVgcr0zAh4Sz8svw6wVuVo
         5wUlew1aJQcp6CqpU4l4FzRDucfxaXZpN689YEdueZVy/ogs4M1eD6+2MB/wUFhtjF5V
         Ac9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6onLvbDDTQi9P1ixKKc/sXtCs/6RamfMd3X4Ca5X+7Y=;
        b=dyI00VFsSDXQoOnSA1EMRlJR5anrRBT4yhRyXpP6rENsvvuiocIL/1ttTLRB/X/68P
         wLSAMih5HxmtQidCcckvdSFQvXbzrN/xPI3rHTANOJEwqcUWWB8NOBXnaYus4JlBOTuT
         MH8S7kWJmI8krsTd1qHJ14StCaX1XwABgm4sNtx6aTKWuyegPzzahXQ+JM6Z8DF+7bQf
         N2luPRGyNcoJeVgbsraGEUI50+PAnfNEhSR9zNCKFrTxI/Xh2a40MW6sOI+FJwzjZHiR
         U/klUjFXifEyTseaIoQalsKAMSfnn0Gn7Yr6IsOBql5MyZkaJz4MaIMHg4vSJ1JqCfj5
         IQyA==
X-Gm-Message-State: AOAM533abD3peiF7+/4Fjl6RGo1gVGnSQ3AOt7Fs5SDvY/yinwtJn/X+
        7qSdFFlj7dpuKsGXcs8MzuodWA5q1jdT86lorAI=
X-Google-Smtp-Source: ABdhPJx0UG0RedJvw09YxtTqsXyhEBehrqZo6Uv5kxRP2sQzYOVBMwSa9fuOh+MaM2BEyQtTKA1mhgKhKs2gNaK/ZiE=
X-Received: by 2002:a19:987:: with SMTP id 129mr5371308lfj.8.1590785593971;
 Fri, 29 May 2020 13:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <159077324869.6014.6516130782021506562.stgit@john-Precision-5820-Tower>
In-Reply-To: <159077324869.6014.6516130782021506562.stgit@john-Precision-5820-Tower>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 29 May 2020 13:53:02 -0700
Message-ID: <CAADnVQ+o5ncV9-__0c62RLJ98BKVvjYD2cTd6z_AB3WXSm_UrA@mail.gmail.com>
Subject: Re: [bpf PATCH 0/3] verifier fix for assigning 32bit reg to 64bit reg
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 29, 2020 at 10:28 AM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> These add a fix for 32 bit to 64 bit assignment introduced with
> latest alu32 bounds tracking. The initial fix was proposed by
> Yonghong and then I updated it slightly and added a test fix.

Applied. Thanks
