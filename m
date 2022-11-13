Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DEE6271E2
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 20:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiKMTCA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 14:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKMTB6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 14:01:58 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE70A185;
        Sun, 13 Nov 2022 11:01:56 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id y25so3026678ual.2;
        Sun, 13 Nov 2022 11:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnkeEBCw6ranPelwuigeNqc3fGeQZ3YRHXxc4wGG+X4=;
        b=Rru0D6PXV839nvUNfTP0a836a2YT+tPCvKFXzz+ACQrBbHtHhkCx6eFhHb5uGs8byn
         a9V8fjYQm5klTi0LAU76Ny63Rxk8W3rfRWMqQ+JYlcUEahhdJml7x7TIlt/D8ABLCjq6
         FuYx73USDMZ24EmYVmtYyXdTFZ1LbOeKuglyEEEAYz2+Bf6nFK5457x1DoaPKbrrLs/w
         IwFx2r08A83mIFg+Ru/jIWzss7rxoKCqRze9kOpQw4l7mJ9+umlIt2nkm/ECBqAkzauT
         /eAoR7o3FAyHI5yWIrGX++oSIh8eEvawq2taTpOPoZH/AmhLQVxHL0ml0/caoApneJOi
         6uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnkeEBCw6ranPelwuigeNqc3fGeQZ3YRHXxc4wGG+X4=;
        b=Ysqoc97iKTH0PG8UYK093chw19zYYtdjkQUWJN8jr+OBldMbhjqmOsKVMw9QytpknR
         ut35GS7KY8ockSSJMpxl0hObRbL/pgTa5fgsLEzL1CSyazkwo4Zo5ipz5gmtJSlCH979
         idYj5LhOGDzMYNjcqhGgFI095pilhf0/DHdYUHyZ7IQz0gfRwL5gAStLhPke3xGtdWfq
         9uRAlkoaIn1Mv++bn99qTI5ClqDV0XwL3Xf5agFP1jqC0pr8ATrDYm9RwQLv2LHN7mad
         RDYiESJhF1dV22yWR5L1ghsPiT+vL9JC07H7TGk/A7x0GJM1n9kryvq4r8/ZGs2mofWq
         p9Rg==
X-Gm-Message-State: ANoB5plNmuOSX1h+mWF98kQHCHLZvRfMCl+91VTNM6Fx6pGVU6VK8z9i
        jT4hlUwleRoHcHWy8OJPGfBSTqj1F35Jd23xQu1vcLjSrbIB/g==
X-Google-Smtp-Source: AA0mqf7nF2zaDMban7naC3xrNthlYxfspble4XuVZQyAN2/Gi3TWORIxeQtTqptCD59qAR7LSFOAO/C6crIsLS8isTw=
X-Received: by 2002:ab0:7513:0:b0:3ed:654e:c6ba with SMTP id
 m19-20020ab07513000000b003ed654ec6bamr4730074uap.56.1668366115558; Sun, 13
 Nov 2022 11:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20221113154258.36560-1-tegongkang@gmail.com>
In-Reply-To: <20221113154258.36560-1-tegongkang@gmail.com>
From:   Kang Minchul <tegongkang@gmail.com>
Date:   Mon, 14 Nov 2022 04:01:44 +0900
Message-ID: <CA+uqrQD9QacA3ypk5fPbjh6NoZSepPPFxH=y_-PU5xUgWYp=eQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] libbpf: Fixed various checkpatch issues
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022=EB=85=84 11=EC=9B=94 14=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 12:43,=
 Kang Minchul <tegongkang@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> This patch series fixes contains various checkpatch fixes
I just found out that the cover letter message is weird.
I will send new patch series with a modified cover letter message.
Sorry for the inconvenience. I'm still learning.

regards,

Kang Minchul
