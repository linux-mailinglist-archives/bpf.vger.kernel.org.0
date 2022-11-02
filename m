Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6515061651D
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 15:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiKBO25 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 10:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiKBO24 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 10:28:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A411A2A704;
        Wed,  2 Nov 2022 07:28:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y69so26719701ede.5;
        Wed, 02 Nov 2022 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JN9e6KnO28jwqscnNvWI6DFGM8wjQ/Z+ADfn8tI1rrU=;
        b=cXi1du0jLioRrdro2Mry3RZROvpWveZLs8DPOyXerdCZf6h6nZD0lf6u1zu/YVq31h
         j8Vss8GXlGDyZQqG0Na4QOK0eomYRW9p08zUDzOpLte/26uETzBysY37ACu2tovmqzPd
         X5jsSdBPrJqtA4eLd6m9+H/QRjweSmCKcKxJeDo/dtmeETXf+1Db9u6HdWus93fbZY3W
         2v6o65DYAb06bXGEb5X/3/T5mF/KKz0tU5eLW2nXPQeQQssOktOmB8KeSgN+5IaM2cif
         n+LTx5th6PvvsN75OJx7FAr6Or/h0+WK23Fn0XpOSy94EE8/9PNgCgbb5Q+FRlNJGGuk
         2TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JN9e6KnO28jwqscnNvWI6DFGM8wjQ/Z+ADfn8tI1rrU=;
        b=2A3FdV2Jg23CmyDJYHqzdw+cmZX1wkVwtn+ujYv++AI/DFbSMo1JpsOct6euewlbeg
         JBoMDAzOJUr4WtlrbM/xZuoMRVsm0Hts+XSXQmUmLmeFC8XvR3AuV5RwERvqA8s/j9CA
         yMvFOzrLu/SpU4NNoBWcOR2G8MpvIMrALBaFpHsihczUSZ4vKL5xUSQKu7ddMXXT5M1D
         Xadyo3dtDb0QnXVvyXziKDb+7O44AjYi/KLHVSoAs8oEZqos1I8snTDvI0N2SCt5Kf9G
         /yNlPOQbzP5Pa5v6uKJX9coXMBOLijhTDqabOayrEomN3M+OiwioUd5Vw+1nVXFpnZ0R
         11sA==
X-Gm-Message-State: ACrzQf1Z1G6xUqRJhsAF0us9h+qjWohX4LvMk5GhInQZBXDQNnPkULnk
        tLmn7zJJ61OFKoWcm8mSmRUyhvDmGUobvg==
X-Google-Smtp-Source: AMsMyM56KVIWrxndO7Iw7G/EJqZjqfE4f1bezoOgvKn27JAwbOIAkXkMrCk3OX5AqIagDmjBX/0O0g==
X-Received: by 2002:a05:6402:2a03:b0:463:11e7:cd5f with SMTP id ey3-20020a0564022a0300b0046311e7cd5fmr21575119edb.274.1667399331132;
        Wed, 02 Nov 2022 07:28:51 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b0079800b81709sm5470994ejh.219.2022.11.02.07.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:28:50 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 2 Nov 2022 15:28:47 +0100
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrii@kernel.org, ast@kernel.org, bpf <bpf@vger.kernel.org>,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, yhs@fb.com
Subject: Re: WARNING in bpf_bprintf_prepare
Message-ID: <Y2J+n7SqmtfyA7ZM@krava>
References: <CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com>
 <Y1pqWPRmP0M+hcXf@krava>
 <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 27, 2022 at 07:45:16PM +0800, Hao Sun wrote:
> Jiri Olsa <olsajiri@gmail.com> 于2022年10月27日周四 19:24写道：
> >
> > On Thu, Oct 27, 2022 at 10:27:28AM +0800, Hao Sun wrote:
> > > Hi,
> > >
> > > The following warning can be triggered with the C reproducer in the link.
> > > Syzbot also reported this several days ago, Jiri posted a patch that
> > > uses bpf prog `active` field to fix this by 05b24ff9b2cfab (bpf:
> > > Prevent bpf program recursion...) according to syzbot dashboard
> > > (https://syzkaller.appspot.com/bug?id=179313fb375161d50a98311a28b8e2fc5f7350f9).
> > > But this warning can still be triggered on 247f34f7b803
> > > (Linux-v6.1-rc2) that already merged the patch, so it seems that this
> > > still is an issue.
> > >
> > > HEAD commit: 247f34f7b803 Linux 6.1-rc2
> > > git tree: upstream
> > > console output: https://pastebin.com/raw/kNw8JCu5
> > > kernel config: https://pastebin.com/raw/sE5QK5HL
> > > C reproducer: https://pastebin.com/raw/X96ASi27
> >
> > hi,
> > right, that fix addressed that issue for single bpf program,
> > and it won't prevent if there are multiple programs hook on
> > contention_begin tracepoint and calling bpf_trace_printk,
> >
> > I'm not sure we can do something there.. will check
> >
> > do you run just the reproducer, or you load the server somehow?
> > I cannot hit the issue so far
> >
> 
> Hi,
> 
> Last email has format issues, resend it here.
> 
> I built the kernel with the config in the link, which contains
> “CONFIG_CMDLINE="earlyprintk=serial net.ifnames=0
> sysctl.kernel.hung_task_all_cpu_backtrace=1 panic_on_warn=1 …”, and
> boot the kernel with normal qemu setup and then the warning can be
> triggered by executing the reproducer.
> 
> Also, I’m willing to test the proposed patch if any.

fyi I reproduced that.. will check if we can do anything about that

thanks,
jirka
