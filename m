Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E796D3AF4
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 01:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDBXhr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 19:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBXhq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 19:37:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7AA59F9;
        Sun,  2 Apr 2023 16:37:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w4so26345169plg.9;
        Sun, 02 Apr 2023 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680478665; x=1683070665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ao3ul6XNYxlEloMUF9UKkjGjNYX4IkQEThyq71yxJ2A=;
        b=Q/jRySSY8fGAlaUWG/dY+2Dnha50fi9OCf9j2El+U6gSR2LuZ03KL1hv7MuPfon3D7
         546qgkoWpaulYChTI8l4S/EyZY2hqAG4wAkMmtuJAL6ePaTB6P+cf52LSTOsfpzAnHyG
         4ePVtgVxAbV9MTj3+wp9t0wGNNhlb/7jdhEbQnFurqoJqsP3Op2fCGni9uiT3cSVHwFG
         +npdz5fI4qIq2DIFz1vAHweMRswod/Wbsp4yQL+lUCWfWNr/WNfXzkUj62YzGcz+ZAFC
         BdeW7gXFC/33DG5LoyaGzYlXt1BL6huU2jcFLNWFEAHSTHiIQJ6YK0QqHSe/wBeftczS
         B43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680478665; x=1683070665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao3ul6XNYxlEloMUF9UKkjGjNYX4IkQEThyq71yxJ2A=;
        b=QFXB7936NuSfiSYIeunQm+txByuVXonQs3yqCWz1d6q76oWb+5tBAEJIt7RcZJfDmn
         6kF546BDB/ecXqYI8Gmb5i09vCDGuUpOvEB0WQdO1rt+mfFbP6M5R3+mL0DGRFBUyLIK
         C/fwaXXkj2PniDsljOvwEpmhG93HvUdkKfmRaRmJLt0f6OwnPSMiAFgDb/hb7SCgJmu+
         0/16SsTrzwQ978i9xyZk9JYQdi6pXWAMrIJrFWP6pBRWq3DpichFLaxAgpVgomUPUyAH
         61LIRwQjjLb/bZQAYWpim7O+VjN0n8HPoAD7S15NgSQIHSIrBNbbQYhG5n+7vdCKHFoM
         nxqg==
X-Gm-Message-State: AO0yUKXS3qkYqriyHGwPIXlGA3uokM6VDyt5/OY8q7bgUfhHJQZMFtcF
        jAeAOVPdh8L3W6KGs858KHagznvo/CU=
X-Google-Smtp-Source: AK7set9jxQYoQMogbP0M/KKqLkkBPUS4uGQyGeVdmMM7N0Kpd769vFGXVKEZSrBo8uWL0aNTS8xHYA==
X-Received: by 2002:a05:6a20:6589:b0:d9:3440:9a26 with SMTP id p9-20020a056a20658900b000d934409a26mr30214216pzh.20.1680478664732;
        Sun, 02 Apr 2023 16:37:44 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:3c8])
        by smtp.gmail.com with ESMTPSA id 18-20020aa79212000000b0062db34242aesm5484548pfo.167.2023.04.02.16.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 16:37:44 -0700 (PDT)
Date:   Sun, 2 Apr 2023 16:37:40 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
Message-ID: <20230402233740.haxb7lgfavcoe27f@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
 <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
 <CALOAHbCqCb3xmSpNe1Qvm75GBY4ZEGrAOHfVJvpZV5t=akTTgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCqCb3xmSpNe1Qvm75GBY4ZEGrAOHfVJvpZV5t=akTTgQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 11:47:31AM +0800, Yafang Shao wrote:
> On Tue, Mar 28, 2023 at 3:04 AM Song Liu <song@kernel.org> wrote:
> >
> > On Sun, Mar 26, 2023 at 2:22 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert IDs
> > > to FDs, that's intended for BPF's security model[1]. Not only does it
> > > prevent non-privilidged users from getting other users' bpf program, but
> > > also it prevents the user from iterating his own bpf objects.
> > >
> > > In container environment, some users want to run bpf programs in their
> > > containers. These users can run their bpf programs under CAP_BPF and
> > > some other specific CAPs, but they can't inspect their bpf programs in a
> > > generic way. For example, the bpftool can't be used as it requires
> > > CAP_SYS_ADMIN. That is very inconvenient.
> >
> > Agreed that it is important to enable tools like bpftool without
> > CAP_SYS_ADMIN. However, I am not sure whether we need a new
> > namespace for this. Can we reuse some existing namespace for this?
> >
> 
> It seems we can't.

Yafang,

It's a Nack.

The only thing you've been trying to "solve" with bpf namespace is to
allow 'bpftool prog show' iterate progs in the "namespace" without CAP_SYS_ADMIN.
The concept of bpf namespace is not even close to be thought through.
Others pointed out the gaps in the design. Like bpffs. There are plenty.
Please do not send patches like this in the future.
You need to start with describing the problem you want to solve,
then propose _several_ solutions, describe their pros and cons,
solicit feedback, present at the conferences (like LSFMMBPF or LPC),
and when the community agrees that 1. problem is worth solving,
2. the solution makes sense, only then work on patches.

"In container environment, some users want to run bpf programs in their containers."
is something Song brought up at LSFMMBPF a year ago.
At that meeting most of the folks agreed that there is a need to run bpf
in containers and make sure that the effect of bpf prog is limited to a container.
This new namespace that creates virtual IDs for progs and maps doesn't come
close in solving this task.
