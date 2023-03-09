Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C26B17F1
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 01:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCIAfh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 19:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCIAfg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 19:35:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DCB8534A
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 16:35:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s11so637567edy.8
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 16:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678322133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hih5eWTNNM03/sjWG3mzqQrLSJ4gGwEQugVo3w9Ftk=;
        b=VDcavIxrcX+8htLbVC7l+W2HknwbAIxVpTpnUwTmH0/0CE9BpnOjgvzWJsWwSUy01k
         MypkAgKVDaFPiPdm0qcQKbpXmTlzIRXMXlibaSTvEjUJDU02M4a9/jLCdvydmAYZOJ6E
         Agx3uQqDQsCdi2Q7cLlJ7o5W+KbyTbz5lDBSSuSmE8EOrtVvbPsjP2xXiEDeYiXhNrNH
         FqRJMrmXCfoAEMTYu4DCxybzDNzjYvfT0PZy7CZ02RPlshen85gMQS1oqFWeLSEdQGML
         ArRWoiYEUUFZEyLw4HP1ofnZItcMR5HQ4H3hYRaKPeaIs71j1pbkiIv8P1Z3Jz4/Fjnq
         KxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678322133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hih5eWTNNM03/sjWG3mzqQrLSJ4gGwEQugVo3w9Ftk=;
        b=Szqn5XCK1jM26asXsVqEEfG5ZiQexpD9quBuakou3tvgGcqx1pEfNtTBhr+6DRrIPr
         Z/j41cpovMdBorc2cCd4aobkzx4x1gBZpipGTpVeKcESMsT6hSatqGI/LbbeWGJmv20G
         fAW/YCPM8mQcXdybu3FtVZiGpsQDz3fojPzjKmP5Ar/tLYf2UILnn/piHffUmAZbOw9j
         6Vy4hwImQSjFnyNrN0SVxLBK/jzRRPXsR+AB212T88FNlQAYCe70nNVyp8wdIs89OG9D
         5QGG44XSW6rGo6O8/iwImGG4SSEi7Xe01NNdLTfU3khpkYBHQ+PyulbiuDRekDCfHcDI
         uajA==
X-Gm-Message-State: AO0yUKXHgtma8TBUO0nK9+qoJf/DZLELL+wCfPfxcte5Y6MXT0FgFhbT
        8NMS9otil3Ad+Oi2/6WhqvJvds3c0q5UUcvRp3baWzYq
X-Google-Smtp-Source: AK7set96QJvkCZ89egYoEbp3IEEkoV7ZiLmMj0Pbn1vTf5l3HTjVHFYrEkELKl9X5mZxgOykL1V8esVFO28YszRBYXE=
X-Received: by 2002:a50:9f8b:0:b0:4ad:7265:82db with SMTP id
 c11-20020a509f8b000000b004ad726582dbmr11063655edf.1.1678322133369; Wed, 08
 Mar 2023 16:35:33 -0800 (PST)
MIME-Version: 1.0
References: <CAK4Nh0igK=-wapie340gnoo4xazC8GP7EG7wjy1EEJokCLQanA@mail.gmail.com>
 <CAK4Nh0iEP5CAAe+i6o5AT=V=EfX2fW2FmoGCfU3+OgR1f-GMAg@mail.gmail.com> <CAKH8qBshq-J2H+Bo1xA=FzAJ6x_mo5yfW6oYjQ_u1QwLJ5CDog@mail.gmail.com>
In-Reply-To: <CAKH8qBshq-J2H+Bo1xA=FzAJ6x_mo5yfW6oYjQ_u1QwLJ5CDog@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Mar 2023 16:35:21 -0800
Message-ID: <CAEf4BzYA9XAY6SDd1a8f5OUggPVC_N+nC50Rbr_oD7XuiRNuEQ@mail.gmail.com>
Subject: Re: Broken build on 6.3-rc1 with uClibc-ng based toolchains due to
 poisoned strlcpy
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Jesus Sanchez-Palencia <jesussanp@google.com>, rongtao@cestc.cn,
        daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org
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

On Wed, Mar 8, 2023 at 4:01=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On Wed, Mar 8, 2023 at 3:51=E2=80=AFPM Jesus Sanchez-Palencia
> <jesussanp@google.com> wrote:
> >
> > (+bpf folks, -perf folks)
> >
> > Please see below.
> >
> > On Wed, Mar 8, 2023 at 11:28=E2=80=AFAM Jesus Sanchez-Palencia
> > <jesussanp@google.com> wrote:
> > >
> > > Hi there,
> > >
> > > So commit 6d0c4b11e743("libbpf: Poison strlcpy()") added the pragma
> > > poison directive to libbpf_internal.h to protect against accidental
> > > usage of strlcpy. This has broken the build for some toolchains and
> > > the problem is that some libcs  (e.g. uClibc-ng) provide the strlcpy(=
)
> > > declaration from string.h, which leads to a problem with the followin=
g
> > > include order:
> > >
> > >                  string.h,
> > >                  from Iibbpf_common.h:12,
> > >                  from libbpf.h:20,
> > >                  from libbpf_internal.h:26,
> > >                  from strset.c:9:
> > >
>
> [..]
>
> > > If we patch libbpf_internal.h and move the #pragma GCC poison
> > > directive to after the include list, we fix the problem but at the
> > > expense of leaving libbpf.h unprotected (and libbpf_common.h as well,
> > > of course).
>
> Seems like a nice compromise? I'm assuming the original intent was to
> mostly protect the c files, not the headers. Andrii WDYT?

Let's drop the poisoning of strlcpy completely, if it's causing such
problems. It's unlikely to accidentally use this function. If someone
can please send a patch, I'd appreciate it. Thank you!


>
> > >We could duplicate the directive on all these other libbpf
> > > headers after the include list, but that's code duplication so I
> > > wanted to bring this up here before I send out a patch.
> > >
> > > Let me know what you think or if you have any other suggestions, plea=
se.
> > >
> > > Thanks,
> > > Jesus
