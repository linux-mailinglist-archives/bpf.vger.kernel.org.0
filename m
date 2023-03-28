Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ACA6CB501
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 05:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjC1Dms (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 23:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjC1Dmr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 23:42:47 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D607171E;
        Mon, 27 Mar 2023 20:42:46 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o82so3149671qka.11;
        Mon, 27 Mar 2023 20:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679974965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v53+mhuHaVyRCA9ANp2YWn8fT8oGsc0ngrPG41Abz6w=;
        b=Y41L4pVTOWSp2kmEl6c2veo6Izsu4wPeBEjE/u/WWnM6GqkzfLVioMLiw/VYdUSk+x
         ruhBvMA78bRn7tJJ6+dC4E2Nzl7LSQf+gE1TsqsScRA0SenJc4cA1ko4OiBrXWOINMby
         J75qhcGSsGGHdUHzizIOVC8jL75mwhGcImayvEjGQBry07F/38FRDYQf/7fa/Q3xSGbO
         IyaFrM0rtJtkjzfoVBSBSB73rDgENq/FVdtNOZD/ZYNDeR9wPVaQm1wZn2tL9VgM5lZg
         mtDdUQVzeG2TKjE/WGv9P7IaTSWFl97lwXjf/tYDrVTlQhKJk/cs2OmaKC5wIe9J5DTO
         UYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679974965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v53+mhuHaVyRCA9ANp2YWn8fT8oGsc0ngrPG41Abz6w=;
        b=tzmEZd6dWzSMhg1rQNzx05MpWZ77AO2YRQypJz8dIuzTDwAvvqwtzIS+lfpC/YybGt
         SNrROSkgpe/Mxdg4M2FuWhowqeAKkSYtnlunlmhvmnAHrSTNWv/1q2oemjN3F1nl8fBa
         yULedZYriXVEtyyKDNJgmzJFFIDcJkch9BTTWQ9qUX4NS/t7RyQHLLplEfnzC6LWNM4N
         KymzJcno0zZLhO2GFpuL7m8gHdDMcDyXeoPi8Jsiot0WFVFyGhnSO5/DOOqK25+CE+Ze
         ++wPjnl47qjCOp4RhuFBdcUHMKoyqZwIBfKPR/jZzDgDFCTwcXUXmSCVn5TxIDxZAleg
         ep0g==
X-Gm-Message-State: AO0yUKWEcvxSQCDxp/Qbwqi6Fai2aiWR0dn71kmWSjpUgE1UioDkld8w
        JJ7DUFYAnnvMscNoqKrgAw40Tvl5Y0+mBlpFYYY=
X-Google-Smtp-Source: AK7set8B/zPWcoITUIpNoYgY5xGATb2bsU+4eea3277XnaA9+Fhtk4i+PnbwB28qbL53lfsaD2IpHlw7VswLssX7zjg=
X-Received: by 2002:a05:620a:a88:b0:743:6092:91b4 with SMTP id
 v8-20020a05620a0a8800b00743609291b4mr3186427qkg.14.1679974964928; Mon, 27 Mar
 2023 20:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <ZCHSOxto9DlEzVy9@google.com>
In-Reply-To: <ZCHSOxto9DlEzVy9@google.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 28 Mar 2023 11:42:08 +0800
Message-ID: <CALOAHbBJEXdR4Myk1zrgFDf9UJYu2-3tbjz0ETNvK3WamD5sFg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 1:28=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 03/26, Yafang Shao wrote:
> > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert IDs
> > to FDs, that's intended for BPF's security model[1]. Not only does it
> > prevent non-privilidged users from getting other users' bpf program, bu=
t
> > also it prevents the user from iterating his own bpf objects.
>
> > In container environment, some users want to run bpf programs in their
> > containers. These users can run their bpf programs under CAP_BPF and
> > some other specific CAPs, but they can't inspect their bpf programs in =
a
> > generic way. For example, the bpftool can't be used as it requires
> > CAP_SYS_ADMIN. That is very inconvenient.
>
> > Without CAP_SYS_ADMIN, the only way to get the information of a bpf obj=
ect
> > which is not created by the process itself is with SCM_RIGHTS, that
> > requires each processes which created bpf object has to implement a uni=
x
> > domain socket to share the fd of a bpf object between different
> > processes, that is really trivial and troublesome.
>
> > Hence we need a better mechanism to get bpf object info without
> > CAP_SYS_ADMIN.
>
> [..]
>
> > BPF namespace is introduced in this patchset with an attempt to remove
> > the CAP_SYS_ADMIN requirement. The user can create bpf map, prog and
> > link in a specific bpf namespace, then these bpf objects will not be
> > visible to the users in a different bpf namespace. But these bpf
> > objects are visible to its parent bpf namespace, so the sys admin can
> > still iterate and inspect them.
>
> Does it essentially mean unpriv bpf?

Right. With CAP_BPF and some other CAPs enabled.

> Can I, as a non-root, create
> a new bpf namespace and start loading/attaching progs?

No, you can't create a new bpf namespace as a non-root, see also
copy_namespaces().
In the container environment, new namespaces are always created by
containered, which is started by root.

> Maybe add a paragraph about now vs whatever you're proposing.

What I'm proposing in this patchset is to put bpf objects (map, prog,
link, and btf) into the bpf namespace. Next step I will put bpffs into
the bpf namespace as well.
That said, I'm trying to put  all the objects created in bpf into the
bpf namespace. Below is a simple paragraph to illustrate it.

Regarding the unpriv user with CAP_BPF enabled,
                                                             Now | Future
------------------------------------------------------------------------
Iterate his BPF IDs                                | N   |  Y  |
Iterate others' BPF IDs                          | N   |  N  |
Convert his BPF IDs to FDs                  | N   |  Y  |
Convert others' BPF IDs to FDs            | N   |  N  |
Get others' object info from pinned file  | Y(*) | N  |
------------------------------------------------------------------------

(*) It can be improved by,
     1). Different containers has different bpffs
     2). Setting file permission
     That's not perfect, for example, if one single user has two bpf
instances, but we don't want them to inspect each other.

> Otherwise it's not very clear what's the security story.
> (haven't looked at the whole series, so maybe it's answered somewhere els=
e?)
>


--=20
Regards
Yafang
