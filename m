Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECF82B54F6
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 00:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgKPX3S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 18:29:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729188AbgKPX3S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 18:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605569357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=29i5jFbCpMBjOMLduGjN9Ff1FImT1jBsomcSSYB+Xa0=;
        b=UzxYHWKsuyjDQAEZkXhc/Iy6tgwKXuNz24sG21OXT+WJMETXCv0T9nFOBXpE6BD06J3ykC
        CNVqr5j5Yf4FxKa753r5OLpISGt61RFSjVa2dxlGDIC1i4xXRnIc/XJWjoPnem+H465Nkl
        4fOkphZkB7UYVDmaHp8P0LC+RQ5arcY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-vdpoBbgdOg2E0CPIkAYQ1w-1; Mon, 16 Nov 2020 18:29:14 -0500
X-MC-Unique: vdpoBbgdOg2E0CPIkAYQ1w-1
Received: by mail-wr1-f70.google.com with SMTP id c8so11821291wrh.16
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 15:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=29i5jFbCpMBjOMLduGjN9Ff1FImT1jBsomcSSYB+Xa0=;
        b=lW783AnBD7sXCdAEjQPPTqB6Ls04nBgSQQdFtY7En1g/iXPadWirvkOvat6Tn8KIxZ
         p7uASmR21j5AgIq/uzlN2Q7LJtKNogesQpz14RqCqkknJouPEahakvCjzdj+mOPRew1e
         9g8omq9elLcdSB5F8ZlGV746FFRjJR4ffZpPU2Hdt7hownPMcwS2DyAYNJ/HpCvHBISW
         4Ho/mXGLqsiOQsRft/tkQ4ujYjA8QAx+SkVDI47pFCeyPpTAQ3w7osSoly5EMzfbzV6z
         GxXx3Yj3RujMhqMMqBMJdaw24aLlP0v2TYO1dTsDsIRQk9SOYZ4nYmGh3ZXm/mElWMoM
         Qgqw==
X-Gm-Message-State: AOAM530lruMVSKArZAcvm6Qa6IV8tNJaL4BnDrvSqyW9Xvx5zd2euPy2
        uD00cm1H7fq+kajN4dsUDL6FBFfv9HQ/5rdAEN5aCx57yr0dM4B7LrYQ/V/LaJ/JPQqdYgBZIB7
        OHWlaD+7WXLmT
X-Received: by 2002:a1c:9a12:: with SMTP id c18mr1237666wme.22.1605569353687;
        Mon, 16 Nov 2020 15:29:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWxGtBfVK/PtwsEclUDT2ZDsuscK/pAbuvbQtVTslUxVNOxAbVUElLBYTRnCOnIIhk1a8TsQ==
X-Received: by 2002:a1c:9a12:: with SMTP id c18mr1237648wme.22.1605569353538;
        Mon, 16 Nov 2020 15:29:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f11sm24314892wrs.70.2020.11.16.15.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 15:29:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6DD6E1833E0; Tue, 17 Nov 2020 00:29:11 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hangbin Liu <haliu@redhat.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        brouer@redhat.com
Subject: Re: [PATCHv5 iproute2-next 0/5] iproute2: add libbpf support
In-Reply-To: <20201116155446.16fe46cf@carbon>
References: <20201109070802.3638167-1-haliu@redhat.com>
 <20201116065305.1010651-1-haliu@redhat.com>
 <CAADnVQ+LNBYq5fdTSRUPy2ZexTdCcB6ErNH_T=r9bJ807UT=pQ@mail.gmail.com>
 <20201116155446.16fe46cf@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Nov 2020 00:29:11 +0100
Message-ID: <87tuto3mpk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> When compiled against dynamic libbpf, then I would use 'ldd' command to
> see what libbpf lib version is used.  When compiled/linked statically
> against a custom libbpf version (already supported via LIBBPF_DIR) then
> *I* think is difficult to figure out that version of libbpf I'm using.
> Could we add the libbpf version info in 'tc -V', as then it would
> remove one of my concerns with static linking.

Agreed, I think we should definitely add the libbpf version to the tool
version output.

-Toke

