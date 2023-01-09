Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35F8662DD9
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 19:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbjAISAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 13:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbjAIR75 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 12:59:57 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA7634D58
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 09:58:31 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s14-20020a17090302ce00b00192d831a155so6737096plk.11
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wHAzTYynvmx1uoMaFbPm/qLc1nLrur1XarUzaqZ8OI=;
        b=AZcc6qtZfhosNWa2fs0VYHMAqp/wftxvvck0of6zT4ezHOh7Bdyt52im0bmda23X2Q
         Bq431WageMIPw2Q4zuTj2jWayVK5N/NXP03xGI/gmPZHHmaI8ZDbdrNLyB5FxIaOmMJO
         /oQTfSUY09QuG+bw9PKWSGlfs/N94KBt/CU+kzLxlB78iAm42kQcHASgGAN9zOypOgxk
         EFvBbXudFxFyhzoDC701b3jORxkTMGCH/NTaRPCEnEEPa8U78dwTwyTwLt4KKG1od1yZ
         r2PKXQ3vqjcbKkEKSA4PA4JjH4/U4Nys9Yj4UrtF0BY/+RkrTyz3L6QaWYEqx64gVkrb
         us2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wHAzTYynvmx1uoMaFbPm/qLc1nLrur1XarUzaqZ8OI=;
        b=4PHwERzK6CNQSCrovTnPcYzpRGjbssaZ905nFikEyMycmVyIsbOBFZJGr3D1fR8BNc
         eQRVJJMsjk/FsF7YdvS/tg/Y8UdlAvzyjA9X3y4z8gDDe4ek/M0t+y0FqinWt8Pnkt1q
         nCrU2fdHS+e5mI9Xka2nTbijAAS5xLjD8foVP68NDD+zuv8Fy2HDQO6MkOYot8uDaQt5
         lex/NEo5JvUYAt8tvWEYUeMgje3nQBeng5xqeHsBBf0pRbL4qEJHfnK4NmEbABhDsM84
         H5x7ejXZwW4OT5eotG2sVjqiOBZs4jo8hP3OYHXTXnTkKGQ6wn0+fR4Pyoq5deEVxzwF
         pS6w==
X-Gm-Message-State: AFqh2kpvJbMIQU4eTZg8Oz5mSRjCkMCRNvLMN/JuKLy+NyOzISykS+XL
        T4Dt8l0nw3Nsx3iF+qs83Yxr55I=
X-Google-Smtp-Source: AMrXdXvZi9JfVG8MSXeVESoWTLTnIykaIiW7J1vs+3N4ldT4afJwDmAkX/FakGaMsK1BJtH4o3js65E=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:84c1:0:b0:583:63ea:f5e8 with SMTP id
 k184-20020a6284c1000000b0058363eaf5e8mr1068377pfd.60.1673287110577; Mon, 09
 Jan 2023 09:58:30 -0800 (PST)
Date:   Mon, 9 Jan 2023 09:58:29 -0800
In-Reply-To: <CAHC9VhRLSAbSHE1nTGwjuUdMtfwTsRVjhV+eznWRw5Ju_qgDAA@mail.gmail.com>
Mime-Version: 1.0
References: <20230106154400.74211-1-paul@paul-moore.com> <20230106154400.74211-2-paul@paul-moore.com>
 <CAKH8qBtr3A+EH2J6DCaVbgoGMetKbLUOQ8ZF=cJSFd8ym-0vxw@mail.gmail.com> <CAHC9VhRLSAbSHE1nTGwjuUdMtfwTsRVjhV+eznWRw5Ju_qgDAA@mail.gmail.com>
Message-ID: <Y7xVxT7gWIhRitza@google.com>
Subject: Re: [PATCH v3 2/2] bpf: remove the do_idr_lock parameter from bpf_prog_free_id()
From:   sdf@google.com
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Burn Alting <burn.alting@iinet.net.au>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/09, Paul Moore wrote:
> On Fri, Jan 6, 2023 at 2:45 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Fri, Jan 6, 2023 at 7:44 AM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > It was determined that the do_idr_lock parameter to
> > > bpf_prog_free_id() was not necessary as it should always be true.
> > >
> > > Suggested-by: Stanislav Fomichev <sdf@google.com>
> >
> > nit: I believe it's been suggested several times by different people

> As much as I would like to follow all of the kernel relevant mailing
> lists, I'm short about 30hrs in a day to do that, and you were the
> first one I saw suggesting that change :)

Sure, sure, I'm just stating it for the other people on the CC. So maybe
we can drop this line when applying.

> > Acked-by: Stanislav Fomichev <sdf@google.com>

> --
> paul-moore.com
