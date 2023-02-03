Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1E6688EA1
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 05:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBCEmH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 23:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBCEmG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 23:42:06 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9954F34E
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 20:42:05 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id k4so12213276eje.1
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 20:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNGbv56CPpVjdl1Lz+Iq5i6bIlxoDAJdAuM9/NxhDIo=;
        b=PWS5tDbl+wI8uDBuXpkrGyBMkwI4jSvyEsatH2IKwxeX2xt2fV2dIhdmi10r6ehDCk
         HQLP+dPcOaS9D/TM9ZZjMHmh3aljeag+lIAdHpvNjXlnRNfIB2ZWFFGCl0GRkgPhnHCD
         j9i52v7zwZvbdnmWrlPemC/hByGfkrW549qUxPMhLJ/w5cfDU8aoggj0nCFx5studoTw
         77lAqUY+1XsSSBP8aZ3pUKBAvURedfKAYL5jCIrDhJEdafjRyX5u7P87/UuVlzAn8/4l
         2TfRMb9ovHGJdr9SnpF2UQH/1+tFpPkE6zTp5E1RXkD13Y1hjHTTVBDNmJS4167awZHr
         PIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNGbv56CPpVjdl1Lz+Iq5i6bIlxoDAJdAuM9/NxhDIo=;
        b=u/l6gufM5EfXRavCj11iT9yQBfWXeZnHDbVSYkFUynApHJTcrpRqpRNc0HBgNhnHjL
         sTUcEWjhWiWXl4zHh+vrXosbRt7XjSJfAgpRZOXkdoC5IrcnG4rCU/2PAtcJWidnN97W
         subVCuf8MDHWVMCBI8qaqBMCRjDIj74SOQa4+gwv+MZJ3mNEHBBTvcQsYsJ9j5PQJ8GL
         mtO9rS85RnyZHhd2SJFC6E5yAFV8uss8kBTMkM2fwZOMNBpoZvnvan4Ujo/l61/hvkPF
         MrTF1bALocvvs82+kwI4fEL5DRvEvg3HAjtOcGt1OFhClE1N5leDVzwSUVc74cJfdvsZ
         rRDA==
X-Gm-Message-State: AO0yUKUgdQ1+za9LhNglpkkvFXhPaItX73qTLogst0cJYuui0SmHW48T
        bAr1y1LdyyRpwrttRpP014zlfZ7pQzF8ao1yxLQ=
X-Google-Smtp-Source: AK7set/bA30W/I7R07U5dke+wNJYL8816EoT0IIiPAX/qby+NC3XVNSZeouKOVasZ08VgAihj1Hoq2s68MnBsuqkQiI=
X-Received: by 2002:a17:906:6d13:b0:878:786e:8c39 with SMTP id
 m19-20020a1709066d1300b00878786e8c39mr2735618ejr.105.1675399323496; Thu, 02
 Feb 2023 20:42:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHF350LaCGPZL_e__5s04PO466eGnA9uM61rc1eQAu-0N8jhJA@mail.gmail.com>
In-Reply-To: <CAHF350LaCGPZL_e__5s04PO466eGnA9uM61rc1eQAu-0N8jhJA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Feb 2023 20:41:52 -0800
Message-ID: <CAADnVQ+XNEEj78m-xDgmcsk5hy30nz+gDECht7Ft07DEy_j-gQ@mail.gmail.com>
Subject: Re: Adding map read write API to bpftool gen skeleton sub command.
To:     Dushyant Behl <myselfdushyantbehl@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Quentin Monnet <quentin@isovalent.com>,
        palani.kodeswaran@in.ibm.com, sayandes@in.ibm.com
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

On Tue, Jan 31, 2023 at 10:41 PM Dushyant Behl
<myselfdushyantbehl@gmail.com> wrote:
>
> Hi folks,
>
> I have been testing the use of BTF to generate read/write API on maps
> with specific key value types which can be extracted from the BTF
> info.
> I have already developed a small tool to test this which uses the BTF
> information in the ebpf binary to automatically generate map
> type-specific CRUD APIs. This can be built on top of the libbpf api in
> the sense that it can provide key and value type info and type
> checking on top of the existing api.

What is 'CRUD APIs' ?
Could you give an example of what kind of code will be generated?

> Our goal is to ease the development of ebpf user space applications
> and was wondering if this feature could be integrated to "bpftool gen
> skeleton" sub command.=E2=80=A8I was wondering if you think that such a
> feature will be inline with the intent of bpftool and will be of value
> to its users.
> I am happy to have more discussion or a meeting on how this could be
> approached and implemented and if it would be a good addition to
> bpftool.
>
> Please let me know.
>
> Thanks,
> Dushyant
