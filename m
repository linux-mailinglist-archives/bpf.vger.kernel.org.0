Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA326A143E
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 01:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBXASj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 19:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBXASi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 19:18:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9B438658
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 16:18:36 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id h16so48840698edz.10
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 16:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGq7XbcsUijde088nTu1tSH3UtXJCcjtlyWYEbrzouA=;
        b=lXSZbq+/x1S1AX+MzlATNiHtekiq0Nxaa38IwjQ9+ISaFJ47Ep/5XZFwAMVXtGr6pA
         z5edKcx3O0rGoGcpEXGEOLVIjiY3+beiu7LLkqVgSY0nmNZuvb2I2qWrtTviJFy9wHcE
         aQaWGCJAUhRnZ6RGchMVhgPQDiUGlOLzHNy+r22WvzOhIwFf8l4giYnUHQnrhkdwt3QM
         ZQTXZvyBrJt05JdWUH5H2Jco16pm0ZAdxnoh3tIOBxQ8xAXRgt7ymhtuzs789+Dzz3ud
         zTqgpKGOUtNRI4WgayZNb+WzMJlQQOowHHwueRp+/kDlsVItHwsKJmbxYB7+yEHzSuWT
         zmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGq7XbcsUijde088nTu1tSH3UtXJCcjtlyWYEbrzouA=;
        b=XAwwiqJ6z3bEqbpTZxp/ux73FbMAE0BPCdgxaQmmo5DLwA0TLZ76JQJwgsnO/1NQu2
         SbWSgWw2/rSgeSNNQjBchwkEHPowubnnNz3FuHINJDoyF278hyDfFSXpIxr4PVFfDRyS
         rj1xbqhhWBx6FnuQclbkGBGAP35smJ59yI/qQ9jAn2N64s5CefRgmQ2MO0L+OKXyGdiJ
         UNNt7f6FfYkDyrA3jYl28mch2NBjtfiZDJgbjh2Z/kkn0Dbt+y2mVemjMLQxRnTviL/V
         3gcczECz+K/XcfHHrAHK/ZrIwOFWpBEZTsSpvvbe0E95hYS7JbK06ejo+NZFe6yQz53Y
         YQtw==
X-Gm-Message-State: AO0yUKWg2lSWKIcFbc1mK0zAVNNQjle3IfE9e80nMsxmbODQ2izDmeQk
        w7nqr2I3n4UdV9DS4SFSYiF0K5qZTPGROO5KTYM=
X-Google-Smtp-Source: AK7set8vEQxQuK1UXCIpdFvGUuFqfbE7mSnIr+2aXTZpcUqJFTEaqS7xQ3HQ7CKgG/G5WNWqU83HF+V6xrK4dwyZPik=
X-Received: by 2002:a17:906:9499:b0:8b1:79ef:6923 with SMTP id
 t25-20020a170906949900b008b179ef6923mr10905111ejx.15.1677197915213; Thu, 23
 Feb 2023 16:18:35 -0800 (PST)
MIME-Version: 1.0
References: <20230217191908.1000004-1-deso@posteo.net> <de1878ef-1963-6f9d-3861-a3a6cb3ceb65@oracle.com>
 <20230221233448.afjni6u5jgoh2r4n@muellerd-fedora-PC2BDTX9>
In-Reply-To: <20230221233448.afjni6u5jgoh2r4n@muellerd-fedora-PC2BDTX9>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Feb 2023 16:18:23 -0800
Message-ID: <CAEf4BzanuYbWo7T1D1noh-+XdFC_P0iZ_SMmvG57PmngrV5C1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] libbpf: Make uprobe attachment APK aware
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kafai@meta.com, kernel-team@meta.com
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

On Tue, Feb 21, 2023 at 3:35 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> On Sat, Feb 18, 2023 at 08:29:32PM +0000, Alan Maguire wrote:
> > On 17/02/2023 19:19, Daniel M=C3=BCller wrote:
> > > On Android, APKs (android packages; zip packages with somewhat
> > > prescriptive contents) are first class citizens in the system: the
> > > shared objects contained in them don't exist in unpacked form on the
> > > file system. Rather, they are mmaped directly from within the archive
> > > and the archive is also what the kernel is aware of.
> > >
> > > For users that complicates the process of attaching a uprobe to a
> > > function contained in a shared object in one such APK: they'd have to
> > > find the byte offset of said function from the beginning of the archi=
ve.
> > > That is cumbersome to do manually and can be fragile, because various
> > > changes could invalidate said offset.
> > >
> > > That is why for uprobes inside ELF files (not inside an APK), commit
> > > d112c9ce249b ("libbpf: Support function name-based attach uprobes") a=
dded
> > > support for attaching to symbols by name. On Android, that mechanism
> > > currently does not work, because this logic is not APK aware.
> > >
> > > This patch set introduces first class support for attaching uprobes t=
o
> > > functions inside ELF objects contained in APKs via function names. We
> > > add support for recognizing the following syntax for a binary path:
> > >   <archive>!/<binary-in-archive>
> > >
> > >   (e.g., /system/app/test-app.apk!/lib/arm64-v8a/libc++.so)
> > >
> > > This syntax is common in the Android eco system and used by tools suc=
h
> > > as simpleperf. It is also what is being proposed for bcc [0].
> > >
> > > If the user provides such a binary path, we find <binary-in-archive>
> > > (lib/arm64-v8a/libc++.so in the example) inside of <archive>
> > > (/system/app/test-app.apk). We perform the regular ELF offset search
> > > inside the binary and add that to the offset within the archive itsel=
f,
> > > to retrieve the offset at which to attach the uprobe.
> > >
> >
> > I have to look in a bit more depth here, but my first thought is if
> > we need the APK specifics in libbpf itself? Would having additional
> > uprobe opts that specify elf memory and some sort of "don't attach,
> > just figure out offset" flag work? Then you could perhaps do the work
> > in patch 3 outside of libbpf, calling attach once to get the
> > offset within the elf (using the changes in patch 2 to support ELF
> > memory), then a second time to do the attach using the offset previousl=
y
> > computed.
> >
> > Then you could implement the APK handling in a custom SEC() handler
> > which runs based on seeing an APK path or apk_uprobe/ prefix. Is that
> > approach feasible? I'm guessing there's something I'm missing, but it
> > would be good to understand what that is. Thanks!
>
> Thanks for taking a look! From what I understand what you laid out could =
work as
> well (though the devil may be in the detail here; I am not particularly f=
amiliar
> with custom SEC handlers and so unless it's being prototyped I can't say =
for
> certain).
> That being said, I am not sure I see how it is superior: it strikes me as=
 more
> complicated just from a control flow and orchestration point of view. It =
also
> does not seem more user friendly to work with. As mentioned in the descri=
ption,
> the proposed syntax addition is common in the eco system. I would think t=
hat
> supporting it benefits users, which in turn helps with adoption of libbpf=
 usage
> on Android systems.
>

+1. Yes, a lot of stuff could be implemented with a custom SEC()
handler, but here the point is to have good out-of-the-box declarative
support for very typical APK-based attachments.

> Thanks,
> Daniel
>
> [...]
