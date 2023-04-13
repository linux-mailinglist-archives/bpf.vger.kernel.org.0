Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6FC6E187F
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 01:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDMXyg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 19:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMXyf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 19:54:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5AB120;
        Thu, 13 Apr 2023 16:54:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kt6so3344731ejb.0;
        Thu, 13 Apr 2023 16:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681430073; x=1684022073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWvjWk4I7oc6dibDy+yZ1HnfJOmElV8h8gzVVqmgQHg=;
        b=lA//TTbrxMuf+RtLbXQDgO4FDlYsguGdpLEAqEUy1fDjyiwB23DoaHo7S4YdVh1FNo
         wglzWEGejSBWMuiUIAYJ2cSsH+zzluQ0icAD8Kwb3iYLxpWIv8Ec1+J4KWpQTKI9Ve4C
         gK+u0G4J7lkRj4YI4zuQE9kCpFCbiL+CzEEZXjVczK50s41pQlRLo6E05iaFYWYE9rlr
         INkZ+rD7vq52Pz4c8qEa1JvrNCKmybJJxMzL90areN7eiJ6hBUnRs+uCKfYuNykkoeng
         4rr5FHHMldUCEv+MQ68NNLay2w9sDb0eDfUYarCSx/sVB5914hDeVg3wNicgPhqbUllo
         CYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681430073; x=1684022073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWvjWk4I7oc6dibDy+yZ1HnfJOmElV8h8gzVVqmgQHg=;
        b=Ni8Djt4SX/sLE9lBVb/uxvOXiExDkQyzqurXiq+xcDNxkBqXGnuIynKNrKZmCMCPe+
         NHiYlLz/EM3/cnORqN6PiIObCDe1O8Rw7I+ubXcsgEAhTuHzFvVkHFHqR7p11k4rIDbu
         qZziuJDflpV73qhdhfoDFVQiHwHKQ/Hj8K2dI5I0eNDmqOohlRJGs7bVIwA4gO4KtXDp
         dl4tMI8X1hJiAmf1ltl+qNkxx+lSBmdhMMte7qGSoyeD/a4TiJIi5p1iSsSKXqYQOA8X
         y43O/rJ4WWLt4EjsilWNrVxRzlz1qHOj9HE1hNjpC2CarK6OMdg5dO0MR6BVA0loGrzD
         2NrQ==
X-Gm-Message-State: AAQBX9dpD+wrW5EKPNkZ3FdNrjVSRZBNvDLOB9ZuIP5Ws6wYcFCxfBa4
        QhJrMhPOpmDX6QRRZHNA+ltfjGr+fZ9YLRnxUUQ=
X-Google-Smtp-Source: AKy350b4CoEwB7jArQnIrPMYgyL3cdsVhg3mhG7UHPDCFw43nx0iPj0YuocPDq5JuaNgM6B6LnTgreYIb8SV7JUlVJk=
X-Received: by 2002:a17:906:3c3:b0:931:3a19:d835 with SMTP id
 c3-20020a17090603c300b009313a19d835mr2130172eja.3.1681430072621; Thu, 13 Apr
 2023 16:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZDWAcN6wfeXzipHz@gofer.mess.org> <CAADnVQJ-zzzTxDj8_7WKW-o3BDsU=DNAnvSEZGNHswbhGA8xhA@mail.gmail.com>
 <ZDe9ND/M4I9ll1xV@gofer.mess.org>
In-Reply-To: <ZDe9ND/M4I9ll1xV@gofer.mess.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 13 Apr 2023 16:54:21 -0700
Message-ID: <CAADnVQLOmDEQsHX4XfgETXUte9mJ+-qphR_E7dcjXB2PMDaZnA@mail.gmail.com>
Subject: Re: [PATCH] bpf: lirc program type should not require SYS_CAP_ADMIN
To:     Sean Young <sean@mess.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 1:28=E2=80=AFAM Sean Young <sean@mess.org> wrote:
>
> On Wed, Apr 12, 2023 at 04:14:05PM -0700, Alexei Starovoitov wrote:
> > On Tue, Apr 11, 2023 at 8:45=E2=80=AFAM Sean Young <sean@mess.org> wrot=
e:
> > >
> > > Make it possible to load lirc program type with just CAP_BPF.
> >
> > Is it safe?
> > If the user can load with just CAP_BPF the FD to the prog and target_fd
> > will allow attach as well.
>
> Exactly, that's the $1m question of course.
>
> I think it's safe from a lirc perspective because you need to be able to
> open the /dev/lirc0 device in the first place; if you can open it, you
> alter all sorts of lirc receiving options already. Changing the IR protoc=
ol
> decoder is no different in that perspective.
>
> The other side of course, is it save to load a bpf lirc program as a norm=
al
> user. I don't see any issue with this; I guess this depends on whether th=
e
> subset of functions in lirc_mode2_func_proto() is safe. I am hoping that
> the expert opinion everyone here can help answer that question.

That part is fine under CAP_BPF.
I don't know how lirc devices are typically setup.
If they need root to open them
then why bother relaxing bpf loading part?
