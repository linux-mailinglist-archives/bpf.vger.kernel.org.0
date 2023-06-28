Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBA741654
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjF1Q1l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 12:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231449AbjF1Q1g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Jun 2023 12:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687969608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EcGVCtGLLiVH4d4G2TnsoMdFkZEx9BvdbEaOJarqpKk=;
        b=SDBXc5CJdhGb1nGCBFsVeFfUXsu8ji0P+dVBK50QRZKocahW4SETP51MkObkKIpjuYepdR
        GR/z1pLaV1afTZz00ym/gOdP+jmWdn8+rU4e4BBv6kXw0lLSwKkh0wNF45CEvIXP8DSWcp
        Bz/mOYbYXgk3wL5Q5fOM6pYceFUC1js=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-Dw0-DSjbNoOUdbNXAshfCQ-1; Wed, 28 Jun 2023 12:26:46 -0400
X-MC-Unique: Dw0-DSjbNoOUdbNXAshfCQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa979d0c32so346695e9.2
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 09:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969601; x=1690561601;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcGVCtGLLiVH4d4G2TnsoMdFkZEx9BvdbEaOJarqpKk=;
        b=VDYokZwNXLkBJzXG/pG8E2vWQ7LsYWCDRDFY8rrLXqn9oreJZLfqVBNXngzzcuol7y
         KckZvpiLXFYh1IB4V2FzJ3amaw3vhWcYn0OUiv+8v90GtieLQVZYfY9EuraYQmERSwJt
         K/0TRsekgKxCLu+mG9JUCtcDf3Dk712SHxKRzjnzlJ2j+t9SaN8XFvpcaasDqDXNVSIq
         B7wR9onZGav/rO5p+0LyB3s6hrwMSIIU6UOpP0JVN2FceGf+KZ3/0FWTF7rnkYEGMxo/
         dxuajACTTEtajK6mAEtMjivh/zGklwmlPX4w6+Cw+dDJAV3/q+NbmWh2FEosc+GjnsHX
         wOFQ==
X-Gm-Message-State: AC+VfDzP40Vgw6cZQvJoLG8ouG4d7fDJlr+0Iv+ceb0YjK6U4ZVCGT03
        cDcMhpikJe3zZHZSG30CoPQlf/3veOpAu412OwV4U9MwbxuQqRecGt7SkQ6Bk15PUyOZNtN/VA/
        8OUbz/4wdUwQbT+pp44XW
X-Received: by 2002:a05:600c:cf:b0:3fa:d167:5348 with SMTP id u15-20020a05600c00cf00b003fad1675348mr6503414wmm.1.1687969601451;
        Wed, 28 Jun 2023 09:26:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Vzo+uBzc/JyYSGFXDPARP96IlylziRcnJBcodWbyqa26TFS+86d3xF7w087Ia6ljj9palEA==
X-Received: by 2002:a05:600c:cf:b0:3fa:d167:5348 with SMTP id u15-20020a05600c00cf00b003fad1675348mr6503399wmm.1.1687969601059;
        Wed, 28 Jun 2023 09:26:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y23-20020a7bcd97000000b003fbb2c0fce5sm1737784wmj.25.2023.06.28.09.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:26:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3E8BEBC01DF; Wed, 28 Jun 2023 18:26:40 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add
 bpf_program__attach_netfilter helper test
In-Reply-To: <20230628152738.22765-3-fw@strlen.de>
References: <20230628152738.22765-1-fw@strlen.de>
 <20230628152738.22765-3-fw@strlen.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 28 Jun 2023 18:26:40 +0200
Message-ID: <87h6qrh7sv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> Call bpf_program__attach_netfilter() with different
> protocol/hook/priority combinations.
>
> Test fails if supposedly-illegal attachments work
> (e.g., bogus protocol family, illegal priority and so on) or if a
> should-work attachment fails.  Expected output:
>
>  ./test_progs -t netfilter_link_attach
>  #145/1   netfilter_link_attach/allzero:OK
>  #145/2   netfilter_link_attach/invalid-pf:OK
>  #145/3   netfilter_link_attach/invalid-hooknum:OK
>  #145/4   netfilter_link_attach/invalid-priority-min:OK
>  #145/5   netfilter_link_attach/invalid-priority-max:OK
>  #145/6   netfilter_link_attach/invalid-flags:OK
>  #145/7   netfilter_link_attach/invalid-inet-not-supported:OK
>  #145/8   netfilter_link_attach/attach ipv4:OK
>  #145/9   netfilter_link_attach/attach ipv6:OK
>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

