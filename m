Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B480B51FB6
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 02:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfFYAOX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 20:14:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41375 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbfFYAOX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 20:14:23 -0400
Received: by mail-qk1-f196.google.com with SMTP id c11so11214679qkk.8
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 17:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=idMODAcOv2Dt8ZWy2wPt4Z83ta1OwJTt0jsnz2NfzUI=;
        b=oO6ZS5eqyA9LygqsicelqXcxs1lPMoD+hODhPKrOyskzS0p0gL80ydnDZrFAymyJQk
         rzd7Tq31z91+DWytz5dz1NMQP7SexeLme2wMe62wSN8FxM2UxkVxnMx5u7cW2E8+o3fb
         FEdGrmR8gQO/igyF70T5H0z9p29Fs5JZjqwAlqR3dmuNL2cQqMD9RWgknn/MYFMDMIcW
         syZTrU8mWL3t0vlnX6LWJOIxY9ePxCFhVolT59fJfRSF+EcYaYfggmkqPT4ABF9IlQr4
         WVdJeA+WNx3xGQdLAxckPCN24+7hdY5rHhpc3RL4Y5gsjzstgINbBtL3Mu0xYMm+LzbV
         8JBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=idMODAcOv2Dt8ZWy2wPt4Z83ta1OwJTt0jsnz2NfzUI=;
        b=kdn3S+DfjFzdFTyYLVhiRD5CG3BkF4kQVZFqW3B2nk4iD2sTs/jmSvjMJZpU8i6FKf
         ta7rrAgLDwePzO4AHM08jj+7RpyoYIwDbZw0gjrD0bGk8LMj8sTWy4qwR/0FFVekV9/L
         kz1FYcOx+wEDfygIF7tjGhj3UdlyCXs/VlvARGaHOAgzKxBbfm6pkKju3Om1PZdZtraV
         757twgpSgdFcNGIEuh7AvRt96N8Z4bJRV64+8LKI7/HxoFu1EM4+fHV1xpJ68lKcbhdw
         ZjxTO8bVdSG/+wkRjRUjU0ZUZbct1/HjfSfPxhp8BWuC845uBgkxsQYf9qzG1Zz5peh7
         oD3Q==
X-Gm-Message-State: APjAAAXmzAnIjdpZEgy399exvG1Lox0LG4Vyv1HIdNXyC46OLIH7RXEn
        B8XHBMqZ/oz9pi69vCHSMJlz9w==
X-Google-Smtp-Source: APXvYqz2RsO+/la3fEScy9M3DKQDzUV6J9+FET3PoqvNpTPp5INSNcc/ZnodbI3nQ0jwog296hUckA==
X-Received: by 2002:a37:a2d8:: with SMTP id l207mr18964343qke.492.1561421661964;
        Mon, 24 Jun 2019 17:14:21 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s11sm7357466qte.49.2019.06.24.17.14.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 17:14:21 -0700 (PDT)
Date:   Mon, 24 Jun 2019 17:14:16 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>
Cc:     Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 2/6] bpf: add BPF_MAP_DUMP command to access more
 than one entry per call
Message-ID: <20190624171416.2a39f4c7@cakuba.netronome.com>
In-Reply-To: <CABCgpaUhHmLaWUg-x_X+yYD6pnoAcMLw9jr1BPnv5vrM-NYmqQ@mail.gmail.com>
References: <20190621231650.32073-1-brianvv@google.com>
        <20190621231650.32073-3-brianvv@google.com>
        <20190624154558.65c31561@cakuba.netronome.com>
        <CABCgpaUhHmLaWUg-x_X+yYD6pnoAcMLw9jr1BPnv5vrM-NYmqQ@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 24 Jun 2019 16:35:05 -0700, Brian Vazquez wrote:
> On Mon, Jun 24, 2019 at 3:46 PM Jakub Kicinski wrote:
> > On Fri, 21 Jun 2019 16:16:46 -0700, Brian Vazquez wrote:  
> > > @@ -385,6 +386,14 @@ union bpf_attr {
> > >               __u64           flags;
> > >       };
> > >
> > > +     struct { /* struct used by BPF_MAP_DUMP command */
> > > +             __u32           map_fd;  
> >
> > There is a hole here, perhaps flags don't have to be 64 bit?  
> The command implementation is wrapping BPF_MAP_*_ELEM commands, I
> would expect this one to handle the same flags which are 64 bit.
> Note that there's a hole in the anonymous structure used by the other
> commands too:
>         struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>                 __u32           map_fd;
>                 __aligned_u64   key;
>                 union {
>                         __aligned_u64 value;
>                         __aligned_u64 next_key;
>                 };
>                 __u64           flags;
>         };

Ah, okay.
