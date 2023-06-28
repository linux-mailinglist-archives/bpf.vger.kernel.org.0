Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E915374164C
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 18:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjF1Q1E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 12:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231812AbjF1Q07 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Jun 2023 12:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687969572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JxQVW/FoUG8cV2pg+DBQ/jXA1gdc+fv/lKw5d723uto=;
        b=iD113lyRFJUgDGCW989Ju4wjRS45TkFifrFUpyezJToT81rnEWmXEVdoxRkUV7AsWnAcjp
        ekgni1WLT71+f4KhyeTZ+FTQPf6HIaEwUENXnRbPEcd2Ub7ZWl0WxI9zaOgp6Y+Uq1dZRy
        kbDBZpa/aExSfOWssNJd4ZwdvywApDY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-2wBGDvh4NtqAtf3C7YezTw-1; Wed, 28 Jun 2023 12:26:08 -0400
X-MC-Unique: 2wBGDvh4NtqAtf3C7YezTw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb76659d54so3676231e87.1
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 09:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969566; x=1690561566;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxQVW/FoUG8cV2pg+DBQ/jXA1gdc+fv/lKw5d723uto=;
        b=UNKZmcuuYOL2RIvklhgrMWzXA+hZz0Exkpuu+YOqyQLU2TTQP5qHG4T+tfdRkfGKqY
         AgQHrb7SOtvExUpB0f6L4ciq5uA4IJ7VjpCPbntPQR6Pqf5wjs4MhuX/41z1RCJivsCB
         kDHDdBUYyid7Szn73AYyueCrnd67oFo2Dp9pqUgojINf51lKl9IY7L5b1iSta7viY2GM
         CQFlJUTOYvMjlXV666vXDQXjWLbYY1LVIssas0gRhvSwhTj+6yHPSjJU2DxyNqZXb9Dl
         h/GbfwRfRYD99JJmHUgF+0f3qe6l4WHz7NdxizPiUuLPuDwPTcpL/UbLzVjDZY896/5m
         vH0Q==
X-Gm-Message-State: AC+VfDyr4aVql35k34Ge/TzBXkxDEFHIBb3wKxkdVA01Y3Gttfj7vPTL
        6e23aybU0rHR4YK9naILiepVQjnkTdbIbk7KMl3Xrd5Grpw7fv17EITCI+K7lEYOTiq6LtL5psy
        9IPUP5HdLMXLn
X-Received: by 2002:ac2:4bcf:0:b0:4fb:835a:8486 with SMTP id o15-20020ac24bcf000000b004fb835a8486mr5045171lfq.32.1687969566124;
        Wed, 28 Jun 2023 09:26:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7d5F0AlkCciYm2xN9/QExzqXorusFYENew2yNtKSbpdcq9cL+QxghzwEDPtUJuYznJ/dn4QQ==
X-Received: by 2002:ac2:4bcf:0:b0:4fb:835a:8486 with SMTP id o15-20020ac24bcf000000b004fb835a8486mr5045159lfq.32.1687969565728;
        Wed, 28 Jun 2023 09:26:05 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003f9b2c602c0sm17224542wmh.37.2023.06.28.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:26:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1C7F1BC01DD; Wed, 28 Jun 2023 18:26:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org,
        Florian Westphal <fw@strlen.de>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] tools: libbpf: add netfilter link
 attach helper
In-Reply-To: <20230628152738.22765-2-fw@strlen.de>
References: <20230628152738.22765-1-fw@strlen.de>
 <20230628152738.22765-2-fw@strlen.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 28 Jun 2023 18:26:04 +0200
Message-ID: <87jzvnh7tv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> Add new api function: bpf_program__attach_netfilter.
>
> It takes a bpf program (netfilter type), and a pointer to a option struct
> that contains the desired attachment (protocol family, priority, hook
> location, ...).
>
> It returns a pointer to a 'bpf_link' structure or NULL on error.
>
> Next patch adds new netfilter_basic test that uses this function to
> attach a program to a few pf/hook/priority combinations.
>
> v2: change name and use bpf_link_create.
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Link: https://lore.kernel.org/bpf/CAEf4BzZrmUv27AJp0dDxBDMY_B8e55-wLs8DUK=
K69vCWsCG_pQ@mail.gmail.com/
> Link: https://lore.kernel.org/bpf/CAEf4BzZ69YgrQW7DHCJUT_X+GqMq_ZQQPBwopa=
JJVGFD5=3Dd5Vg@mail.gmail.com/
> Signed-off-by: Florian Westphal <fw@strlen.de>


Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

