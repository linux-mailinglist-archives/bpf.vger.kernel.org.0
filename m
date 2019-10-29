Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37FE837D
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 09:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfJ2Iwv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 04:52:51 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:43777 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ2Iwu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Oct 2019 04:52:50 -0400
Received: by mail-lj1-f172.google.com with SMTP id s4so13437120ljj.10
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 01:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=z9sSAeXwIIyWFJluy+PNLaUWnTRoMLyFJ5At2Xlt+m0=;
        b=ti8plfew2iEyvf78VTb4TBvOXiLwp9GFFIz/Ric9blzrB72focf5MU750fBBYpPWf6
         l8qNSfa0mP0dQNHC1TejY+vd9FrfMtcxGFlE1O2v+XGfcvxhqvrkWlS34i4Sl11ezHHU
         8M81Ah8g6V3LWAOFA79Z1Ja6q6Am3dqJxVvsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=z9sSAeXwIIyWFJluy+PNLaUWnTRoMLyFJ5At2Xlt+m0=;
        b=HUQAp4vyF59Autb7rY+Jrdmk+6kaN0hatb8zmR3cPPVyl+5JYnZRU1pzj80DelX3OJ
         6M7R8fVriYGfmEgPwbpuLph+sxGJXmwLfhPVnIzjjs3uVOx9W0V+fF2sXVsX8BINUYEW
         w9Ztrq6RCBytDKA4yeQ6JHg94VLhqZ2gohvmeAVU8m5KmifxilnfREB95UDW3G3YmKpH
         BAJfQW8zDeid0i5DgieqasnkWssq4ISLnZn8UfNs5e8w/M6uCQYl4DKOqIH3jW3lhNf3
         G8ID/cJERCkpTRkqy1XbEOUNVw8p7gB5C6oyvN9WLNOEz+SjSGfd9t/FuJU9Sh83zQzN
         nHLg==
X-Gm-Message-State: APjAAAW3j+4H2prOXXK07esQrxB20nw+NTO/DK901nOIQPIHwQXVWJtw
        kjnoR/kuENRjVH9JjCsLO3VKdw==
X-Google-Smtp-Source: APXvYqyIaIKMz1788bTKcYpjSxvaDrqkAnJWpKQP74P5I3mBXH7xTw4B072YGtWxMNlzw3hadatdZw==
X-Received: by 2002:a2e:9112:: with SMTP id m18mr1728661ljg.75.1572339167284;
        Tue, 29 Oct 2019 01:52:47 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id c76sm7893903lfg.11.2019.10.29.01.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 01:52:46 -0700 (PDT)
References: <20191022113730.29303-1-jakub@cloudflare.com> <20191028055247.bh5bctgxfvmr3zjh@kafai-mbp.dhcp.thefacebook.com> <875zk9oxo1.fsf@cloudflare.com> <20191028204255.jmkraj3xlp346xz4@kafai-mbp.dhcp.thefacebook.com> <5db758142fac5_6642abc699aa5c4fd@john-XPS-13-9370.notmuch> <20191028213804.yv3xfjjlayfghkcr@kafai-mbp>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin Lau <kafai@fb.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-team\@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [RFC bpf-next 0/5] Extend SOCKMAP to store listening sockets
In-reply-to: <20191028213804.yv3xfjjlayfghkcr@kafai-mbp>
Date:   Tue, 29 Oct 2019 09:52:45 +0100
Message-ID: <874kzsorvm.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 28, 2019 at 10:38 PM CET, Martin Lau wrote:
> It is always better to get full UDP support ;)
> It seems to be confident also, then there is little reason not to do
> so in UDP sockmap support v1.

Let me give it a shot :-)
