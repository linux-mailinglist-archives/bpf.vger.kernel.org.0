Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1385D24A1E9
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 16:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgHSOj6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 10:39:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54994 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727087AbgHSOjz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 10:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597847993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FbsnLY9rKkobFTZIKxecpfsJvpNNawkeoUCvEimCuCc=;
        b=gvjGtq55BsYgTmR8X24PDB+Ve1GPb7PjpqkYH1RON0fJZGuOaT0J11O89BX+c7vKPEYBxQ
        GqxscEmNSdPionuP6QzJx5TKAPfk84FbkzRA1/TjXS3K/5GHX0ETxvt/t7sYuHbb49L3Uo
        Yf6v7lzZnKvHsys1nnMGTlGt6yc9aCY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-WES00mciPbK8L64I85JlRg-1; Wed, 19 Aug 2020 10:39:49 -0400
X-MC-Unique: WES00mciPbK8L64I85JlRg-1
Received: by mail-wm1-f72.google.com with SMTP id g72so1109700wme.4
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 07:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FbsnLY9rKkobFTZIKxecpfsJvpNNawkeoUCvEimCuCc=;
        b=Pium1qHLVpF3stAheJdtGX/Evv8sxmxD8yzpyryMJw6CUbSuMRPKGLq/RFZyT+LYFF
         3ccwYPSbpXMEye3CR+NP7EFslxTLH4v4VK0KC71nfKh4lzeLw3fR/0R7hj52Am76YqFN
         uRe7eVTVoMrh/q7+4NA/nNZZgCljCMekqE8G4RyiY/i/Z+3LiPzRwCcnGNcoKXwxqn2+
         HUNGOqOFqf/FpAiciIJxFb+Qrhrt5lzSENpUi/khyWcSueK5lONntHxxKERNzr1m9ah+
         aoz75g5SnBSzPTFrghfFXjLC0KJkuntupjsEykj3lTjEqn70OgyCVYXSXtE2QUbKwkS/
         Cn3w==
X-Gm-Message-State: AOAM533kS1cWW+VK2cu3E3ZeZqqaGmImj+zJKhNPKoHdTN5OJdCwarxP
        P03J/2FGVT2wN4PqzCmbW2Ly82xuVGcfOqACN7plOio/gAaqsarxtRWu6rt1EccWesvQA+ru/U6
        fQJPkr2OSTFRE
X-Received: by 2002:a1c:b443:: with SMTP id d64mr5702112wmf.68.1597847988800;
        Wed, 19 Aug 2020 07:39:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyESO9tY3SC/TsbFL+82UpS0RG6FkakxcRfLLk+J/ZHSgrHlQcsjl4YHHeQCicvNi05JwEY1A==
X-Received: by 2002:a1c:b443:: with SMTP id d64mr5702098wmf.68.1597847988612;
        Wed, 19 Aug 2020 07:39:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w1sm5599495wmc.18.2020.08.19.07.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 07:39:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2D3A6182B54; Wed, 19 Aug 2020 16:39:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, andriin@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, ast@kernel.org
Subject: Re: xdp generic default option
In-Reply-To: <20200819092811.GA2420@lore-desk>
References: <20200819092811.GA2420@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 19 Aug 2020 16:39:47 +0200
Message-ID: <87eeo2pumk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Hi Andrii,
>
> working on xdp multi-buff I figured out now xdp generic is the default choice
> if not specified by userspace. In particular after commit 7f0a838254bd
> ("bpf, xdp: Maintain info on attached XDP BPF programs in net_device"), running
> the command below, XDP will run in generic mode even if the underlay driver
> support XDP in native mode:
>
> $ip link set dev eth0 xdp obj prog.o
> $ip link show dev eth0
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 xdpgeneric qdisc mq state UP mode DEFAULT
>    group default qlen 1024
>    link/ether f0:ad:4e:09:6b:57 brd ff:ff:ff:ff:ff:ff
>    prog/xdp id 1 tag 3b185187f1855c4c jited

Yeah, defaulting to xdpgeneric is not a good idea (and a change in
behaviour; I get native mode on the same command on a 5.8 kernel)...

-Toke

