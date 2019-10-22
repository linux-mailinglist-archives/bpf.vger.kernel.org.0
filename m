Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A7FE0AEF
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 19:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfJVRpM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 13:45:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31908 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727152AbfJVRpL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Oct 2019 13:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571766310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=84NOK6JlBnakomHmdK8lEf2i89cFK17pqxVXj9BUO1k=;
        b=Bwh8qDWBDVdylOUwwGYGRPJvJpKg2tfPUOUdTb1h9Q7RbsFwurXwyVFVyHSgRe2nbRDUM+
        OqHf7DIp+hBqZaHZTeG4ieDSiZByOkSCD3MCIdMW0ESCoKsP9ySFKGykR4UYGg+gHwZdKn
        XAk/nCu2tIKWGmn7DFwBu73h10WiKIo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-GXtWpp5RPjOptOVIsyuuxg-1; Tue, 22 Oct 2019 13:45:08 -0400
Received: by mail-lj1-f197.google.com with SMTP id v24so3103853ljh.23
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 10:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=84NOK6JlBnakomHmdK8lEf2i89cFK17pqxVXj9BUO1k=;
        b=FQc+N0m1N/ne3lggTbtuWYXaxcMW9ahzmqyb2zezNh0+IfHG/eu5XIKcjJrPf9qDdm
         5d4dWXLRbjIOTB9SjfXFzaK/IjIBBRTvQbGDZGI/KQERNM23NFx0ubXMgbHPZQB0v4po
         Wyh6oVHRbJwQM47MNKDbuGxSBYQZJaCxCcio4Z63DPYtQ0sJdnYk9hM3W1eWBsFqAW4x
         5S6HuN07eDlat2aOjh8YCbF/vrkCTdlV0z+gmG5+PjGDk7rbRF6TxfPYCn+Ur6dSxK75
         V6UVUhGi56WNx3uNfGzP0sg8+ujI8yBCaYfxPNRRHPjxUAZvUpLSd/abINxZaWK24H/y
         LPSA==
X-Gm-Message-State: APjAAAXnfMrgeVWuTAzWE9xu1f1GQYl1zDZVzrDv5v3qDYZSAifGdDzP
        AgJ71opJflkn4p3sIOVks3eDX84RnjcpXC2kFRFZxZzw0B09O/6ZYD0BziL8lUmNOfkDSci3wNX
        e17N6AySrL6cV
X-Received: by 2002:a19:6759:: with SMTP id e25mr18854011lfj.80.1571766307516;
        Tue, 22 Oct 2019 10:45:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyWaFofKCqI5Dh4lYpflNmAetMBkkoN5rdIx4shy+jTuAP5JoYEhNPwO1ylG1Uqw2N1zImLUw==
X-Received: by 2002:a19:6759:: with SMTP id e25mr18853990lfj.80.1571766307340;
        Tue, 22 Oct 2019 10:45:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id a18sm5692318lfi.15.2019.10.22.10.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 10:45:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BF9081804B1; Tue, 22 Oct 2019 19:45:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Pravin B Shelar <pshelar@ovn.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        William Tu <u9012063@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [RFC PATCH v2 bpf-next 00/15] xdp_flow: Flow offload to XDP
In-Reply-To: <5daf34614a4af_30ac2b1cb5d205bce4@john-XPS-13-9370.notmuch>
References: <20191018040748.30593-1-toshiaki.makita1@gmail.com> <5da9d8c125fd4_31cf2adc704105c456@john-XPS-13-9370.notmuch> <22e6652c-e635-4349-c863-255d6c1c548b@gmail.com> <5daf34614a4af_30ac2b1cb5d205bce4@john-XPS-13-9370.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Oct 2019 19:45:05 +0200
Message-ID: <87h840oese.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: GXtWpp5RPjOptOVIsyuuxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> I think for sysadmins in general (not OVS) use case I would work
> with Jesper and Toke. They seem to be working on this specific
> problem.

We're definitely thinking about how we can make "XDP magically speeds up
my network stack" a reality, if that's what you mean. Not that we have
arrived at anything specific yet...

And yeah, I'd also be happy to discuss what it would take to make a
native XDP implementation of the OVS datapath; including what (if
anything) is missing from the current XDP feature set to make this
feasible. I must admit that I'm not quite clear on why that wasn't the
approach picked for the first attempt to speed up OVS using XDP...

-Toke

