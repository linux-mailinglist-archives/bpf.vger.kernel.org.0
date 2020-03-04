Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377CE178CBD
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 09:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbgCDIpN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 03:45:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39341 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgCDIpL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 03:45:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id x97so1235971ota.6
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 00:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ma8ZuzcCeVEH6377/YAf0HxDb+sbrr8YMMlgCfFH6Lk=;
        b=FrMlwWsM6VLOsyh8IR/l2AzoOl3oFGBHNGhVWnWt1/tr3WhRWPJ0BMj3yX6YGBMea/
         TQXGkaFBa4jar3k26oX5MaEcapBB2a9JrNsHVM3OA9DUIQ5UDooYIFTp46eOZKBkaMDc
         08Zcri9aN5WHeb0oDzOIOw4JngUyWipsbPvd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ma8ZuzcCeVEH6377/YAf0HxDb+sbrr8YMMlgCfFH6Lk=;
        b=uJCOQqwiPIvcB6Y5emA0c2/UDzeBWMJw0bdRRFkJwAYhp6ggeB1PgtH+/+GXlbgu1X
         oyFn9Tb2FjqOrf0J/qwlcwsrd4v8s26h67svMpviIjOomPK+VYySf+YP9LKnDXQIGse7
         R2eGc62+yn8D1okSp9wLsFVBxryq6XJBKupVAlh7FjDybJ5KhEm+oMunDDYml0wiQ8N6
         TRcXAKtZvCLSN0kxsy+B9127F7PQjDCzohDjAgGZnAemP8oChmzVtWUvzIkEZUAXWQD3
         mFtbXRWv/bXLC/SuO65P5aPGQTy7J8+NXR5Z1zYbE6YIc7hbafW2OTQSPoaRdIdRxSRV
         9UXQ==
X-Gm-Message-State: ANhLgQ0FChccW0SR92+zpDXWnBzhTcxGq9gb0z6MqSgLyreUNl1Kib9w
        /ZLXm/3rWxMvw/e5b1BzvPOAkZupHSFgML6WFzFx9Q==
X-Google-Smtp-Source: ADFU+vszsCH0gAioTE/0Oo9bJUmXm+Eq3B6gwTKHp5hf/N0BfkJM6SCshdG+Ifs/jv7uE2DSKKOkCsuTMscyII1dFjw=
X-Received: by 2002:a9d:10d:: with SMTP id 13mr1579216otu.334.1583311509322;
 Wed, 04 Mar 2020 00:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20200228115344.17742-1-lmb@cloudflare.com> <20200228115344.17742-4-lmb@cloudflare.com>
 <20200303175051.zcxmo3c257pfpj7f@kafai-mbp>
In-Reply-To: <20200303175051.zcxmo3c257pfpj7f@kafai-mbp>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 4 Mar 2020 09:44:57 +0100
Message-ID: <CACAyw9_Ewe86YYgdffhz3dVaPPMnXeckMYhoPn+umvhAShtnBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/9] bpf: sockmap: move generic sockmap hooks
 from BPF TCP
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 3 Mar 2020 at 18:51, Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Feb 28, 2020 at 11:53:38AM +0000, Lorenz Bauer wrote:
> > The close, unhash and clone handlers from TCP sockmap are actually generic,
> > and can be reused by UDP sockmap. Move the helpers into the sockmap code
> Is clone reused in UDP?

No, my bad. I'll update the commit message.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
