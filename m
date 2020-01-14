Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8D613AE51
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 17:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgANQEh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 11:04:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37375 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgANQEh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 11:04:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id o13so14960030ljg.4
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 08:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=+H+H6Ga+4JFtfT6TfTdJtyZwGfO1XdaI77oQLwOJulY=;
        b=deg2iFB69XUcAU6WSbn2FDLcD4JbNZC8FeTdY1N7SHc8F/It16Ab+J8641ymR9dFw8
         EIO+oDjPtirFwV+5vC7Qb2ywRg44+k0Rb08OBS6hQwYo0w/97u9nUeU2lSrH1qD69rU3
         wP5vAZ7XLShcQpOz5D51mSzfo474ecm9BTSKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=+H+H6Ga+4JFtfT6TfTdJtyZwGfO1XdaI77oQLwOJulY=;
        b=XW2f4pSVLvuoaHNoNznVYjfZr7pbJdkZzx3XY0Zu/gdVD8j2F4MBdGZnSl81vFGoZi
         Qo8R2adbUyy8JfupcJdilC42wwH2DtX13F0RufcrA6ljo+BvbymbWKmXEaoVhCtTaZcb
         nnX+xCuswMUhSRwOo1utTqQtIXg1wWpRm51d8V783NO+7SsGl05XmeE4r98NGsA8YyFx
         zeu9oF8gK+/Lq2FaepUA2W55GkThnK5uQb073FrKc7y1hOXfGSJe/HX70hX5X/PwUUrJ
         FqoeCyKOg+qRkil2rdb4o+hIKfJm1z3M1jyRFeWQFo99nn+pKZvRJAYJ+3RUOfdrU9jS
         oChw==
X-Gm-Message-State: APjAAAXbXJ9e21uWs74mvP+1gNFRgw8UwRoH09qmDv+2ONza0N78wNhK
        UUlC4+OFAxBst7SKyuoOCub7dA==
X-Google-Smtp-Source: APXvYqwD4F55xjnZNU6JSUcx2EG/xlvr4BzRiJ6a4V/9cTyEHEcnLJSGmOGvKH7l4QK52zzwWGd4Nw==
X-Received: by 2002:a2e:9510:: with SMTP id f16mr14642612ljh.249.1579017875217;
        Tue, 14 Jan 2020 08:04:35 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id t27sm7827251ljd.26.2020.01.14.08.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 08:04:34 -0800 (PST)
References: <20200110105027.257877-1-jakub@cloudflare.com> <20200110105027.257877-4-jakub@cloudflare.com> <20200113201456.t5apbcjdqdr6by5t@kafai-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin Lau <kafai@fb.com>
Cc:     "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-team\@cloudflare.com" <kernel-team@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        "John Fastabend" <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 03/11] net, sk_msg: Clear sk_user_data pointer on clone if tagged
In-reply-to: <20200113201456.t5apbcjdqdr6by5t@kafai-mbp.dhcp.thefacebook.com>
Date:   Tue, 14 Jan 2020 17:04:33 +0100
Message-ID: <87a76qrpm6.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 13, 2020 at 09:15 PM CET, Martin Lau wrote:
> On Fri, Jan 10, 2020 at 11:50:19AM +0100, Jakub Sitnicki wrote:
>> sk_user_data can hold a pointer to an object that is not intended to be
>> shared between the parent socket and the child that gets a pointer copy on
>> clone. This is the case when sk_user_data points at reference-counted
>> object, like struct sk_psock.
>> 
>> One way to resolve it is to tag the pointer with a no-copy flag by
>> repurposing its lowest bit. Based on the bit-flag value we clear the child
>> sk_user_data pointer after cloning the parent socket.
> LGTM.  One nit, WARN_ON_ONCE should be enough for all the cases if they
> would ever happen.  Having continuous splat on the same thing is not
> necessary useful while it could be quite distributing for people
> capture/log them.

Will switch to WARN_ON_ONCE in v3. Thanks for the review!

>
> Acked-by: Martin KaFai Lau <kafai@fb.com>

