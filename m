Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E77E2D4327
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 14:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgLINYk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 08:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgLINYk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 08:24:40 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFE6C0613D6
        for <bpf@vger.kernel.org>; Wed,  9 Dec 2020 05:24:00 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 3so1660470wmg.4
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 05:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SL6msqiYJNjRfO6GSKcCWS1H/vFhMdg8DRvJwX7TWvI=;
        b=bair6t1gQ0gVLR1zC0rKXgnoFeQOROlLEGFUf230op7Eo8hgh17TG5/9aBfCAI1qcD
         0bf25IS4q1Ux2U7LHFB/ZPgmrvEbnIszhsm+gSd4/iX/uq9dtl9TYE7kwxoxTOaGUJi/
         lFAHPLK4O4DL3ki+FDMxke9VxA9sMvkZVWLi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SL6msqiYJNjRfO6GSKcCWS1H/vFhMdg8DRvJwX7TWvI=;
        b=afON2CEzq9o1Ps/RL8CsyIS+BGrLjuZ0z83TuyIT6G4yTe9siWAJSljnFCszpq7/nG
         VmdC/AQf/6jA1gCurau7yVjZbqaOu6jFKzbpYyeHrgiUaTX3eLToe1I8PAYo/+43hyDg
         r13Nz2wSRwdnv2S7vAGsAKAamr2PPe7bUN2j+xjgd/W486hbcQVu54NWbY7e+y35YePg
         QT+r33I1DMKDmjyS8rByZJCZw0EkioqD5KbQlDWuNOIBLWAASctyb51HLfb6zTSryBFP
         SjjhR5DYQXbcyROvaobhlXUJgCQpXI/hIhGRbqSYZuqNycLEdrkDSXfnQMSvv/jRFHAZ
         HSng==
X-Gm-Message-State: AOAM5315wBy6Qem6c5VuPN5dfN+7scIHxDNYe+J72Mgdkaw9glSEGnDH
        xRjIdY4ea3PLObP7maZArXIPTg==
X-Google-Smtp-Source: ABdhPJxUVYjsNq97or/ZsOXlsUivBgB/hGt9elBF4gRMMx4dzqrjNIBi0qpfudtlShJCov0cs6MUyA==
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr2795827wmc.117.1607520238887;
        Wed, 09 Dec 2020 05:23:58 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id 65sm3405049wri.95.2020.12.09.05.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:23:58 -0800 (PST)
Message-ID: <38abab69fb724ebb25715bd362b4d187ae37cdf2.camel@chromium.org>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Expose bpf_get_socket_cookie to
 tracing programs
From:   Florent Revest <revest@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org,
        Martin KaFai Lau <kafai@fb.com>, linux-kernel@vger.kernel.org
Date:   Wed, 09 Dec 2020 14:23:57 +0100
In-Reply-To: <CANA3-0c5NtYVGa_TQqY36ZWhmFztrgmKgA9Karo-HpW0MBTkPw@mail.gmail.com>
References: <20201208201533.1312057-1-revest@chromium.org>
         <20201208201533.1312057-2-revest@chromium.org>
         <CANA3-0c5NtYVGa_TQqY36ZWhmFztrgmKgA9Karo-HpW0MBTkPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2020-12-08 at 23:08 +0100, KP Singh wrote:
> My understanding is you can simply always call sock_gen_cookie and
> not have two protos.
> 
> This will disable preemption in sleepable programs and not have any
> effect in non-sleepable programs since preemption will already be
> disabled.

Sure, that works. I thought that providing two helper implems would
slightly improve performances on non-sleepable programs but I can send
a v4 with only one helper that calls sock_gen_cookie.

