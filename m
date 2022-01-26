Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5009149C65B
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 10:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbiAZJc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 04:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbiAZJcm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 04:32:42 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45DBC061744
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 01:32:41 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z7so16226098ljj.4
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 01:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBMj6kNPnAsXT4KCcvojdleZo/R9epjnx+Luiy+QWUg=;
        b=hl41LzSXwl0/6IkzJZxlsZQdcl3YmA8fRtB0fi3frmniBg6ULOcv5q7+jnVyLmB4cx
         xSe7rKqHPq1+wTJuVLOWs8j6ACBsugSjdDkIQlfxcWULLnHqmNf6X5mGtk1CBuz4UZrT
         DaacmgNnwPdUh98kJeqQCEgkTQiFZrdV/jPxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBMj6kNPnAsXT4KCcvojdleZo/R9epjnx+Luiy+QWUg=;
        b=5dFW/6VMhqOSp95Jkf+VFLsg24U5xipit8agTka13Gc0i9mOw+fOiod2jjZF7Ub3IS
         E17cDhxus1o3cX/4bQL6CElpwUT8VXdr/DyOoWyH/WdMvnodWPDvNzjDeTL1YRtB3UAr
         5nfiwyXY5Px/ClLU/wGRsAkRgh6+OgUtc09Q5H1WsFnqbGzgJ8lxjGyvaf5dyxKVQMox
         khQU0diZMxerH6xWc1gpuDGMjFZ7wmPVDnwYKeBipdLwO2iQcgtmDdt6T8KZt6UD/C7+
         UKItTTezvEhuy13IbJ6mEcupZTVmrnmm73HcPzSYtIG+l3XHLZG09ff9GehOaxvaVORu
         aafA==
X-Gm-Message-State: AOAM532pvRb59Bek+Q+y55j9V8t2kkand3bsecAIbiepRUrh7+Ve5KQG
        1Uwn7tJu7p9DMkdvmao+Pee9/sD9GA0AJFWR6QZRGQ==
X-Google-Smtp-Source: ABdhPJwT1x9vtPAArlZ9FqxFhIhYLwmDIZYJexf81w0hGGUxSd6t+RWrwjsXux21tYDQt4gr+ISCjveJNro1QFhOzXU=
X-Received: by 2002:a05:651c:11d0:: with SMTP id z16mr1015741ljo.111.1643189560247;
 Wed, 26 Jan 2022 01:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20220125081717.1260849-1-liuhangbin@gmail.com> <20220125081717.1260849-6-liuhangbin@gmail.com>
In-Reply-To: <20220125081717.1260849-6-liuhangbin@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 26 Jan 2022 09:32:29 +0000
Message-ID: <CACAyw99e+TUxpXcxgrp6PN1G5b+SGxhUWXCKJW7B4QHoqLF+kw@mail.gmail.com>
Subject: Re: [PATCH bpf 5/7] selftests/bpf/test_tcp_check_syncookie: use temp
 netns for testing
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        William Tu <u9012063@gmail.com>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 25 Jan 2022 at 08:18, Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> Use temp netns instead of hard code name for testing in case the
> netns already exists.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Acked-by: Lorenz Bauer <lmb@cloudflare.com>

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
