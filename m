Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAB63A4978
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 21:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFKTgX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 15:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKTgX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 15:36:23 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7524C061574;
        Fri, 11 Jun 2021 12:34:24 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id c8so4127663ybq.1;
        Fri, 11 Jun 2021 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=thzKt8ybtEw0fXVAej6fjclluLhu089WJPqYEnS6mwk=;
        b=KGf6ClnlBOPMpThrbWfQQkxw4QDyzcXoAk6BwwAPq/Mj9Vwm9EySuF7kIeQYucC6ms
         sUu/bFZFFfa1zOQB5aAD9Gfj8e9JRQRdwIhD8rDbvu2SDcwTQV6XYAxTIj/fN9RwPAvQ
         464ADL5CDc5i9GVk9RJbTuXPJHzl9lnZd2CgKqDuL/hyxqrQm19b9hWMB6haZ4DxrMW6
         ZBVSv+yWyvkWLPy5tcDX0RcGjR4pPmgqLLoApr1MChe7hKYu+CUf0evDA4owiZrLQNLk
         AkgTx95BagzN+3Ok8KJi9TB8vTV28CTnu4WuOB+P5B8hpCXNNkOR8UtBMQNt5cJcW9bm
         CGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=thzKt8ybtEw0fXVAej6fjclluLhu089WJPqYEnS6mwk=;
        b=DVEub0c99NcYrEPq34bOTeEQo8oSZImbz8v7fRU4PvGjYzYCdtZFkCv2qhRuN7HmIl
         xWU5TDurRLWnttQqJcvLa8RNXgDkRMX93XEBi+LOrgMcpAb75z5WYjNPG9IkSM/sNxlS
         +8ouFEfXK1Za0atyd/X8C0f2OAQhePTWm5T2df+kvAlqIFs9ZcrFYdUwaUOFwbSrVF/0
         O40flCfHlX9vQOoHnf5KcokRcmGGTwLW36Vku2V9QXw1aAcN2+wF+RPTdwxXRH9iC+rN
         PJvkM76WxKaOX1931kGon5ei1k0NMOTtKKGZMmeFEgGuwlzs3YNlsrRhYmHu2vN83hGd
         HvRg==
X-Gm-Message-State: AOAM531Vz0CWGU9Dd+bc1bc5ZqDPN6zFMelxeW/7rJhmSQ1Gpc8uW6ft
        ee9a007me29H0LzQx4RvPyxMV22ScZas70ylXWmVCrI84sLHBA==
X-Google-Smtp-Source: ABdhPJzn06cXenQgLBibSaPvsdHH7nz/spTn65mUrI+M7zYlbAskslhaQWFI6pigz0EwfE1jtNaaoFd7nv5HfL3NTEA=
X-Received: by 2002:a25:6612:: with SMTP id a18mr8218158ybc.347.1623440064070;
 Fri, 11 Jun 2021 12:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
 <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
 <YMJMdQvCWHd5J0M1@kernel.org>
In-Reply-To: <YMJMdQvCWHd5J0M1@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Jun 2021 12:34:13 -0700
Message-ID: <CAEf4BzZEmLbKtUMkbV4+3rDFrSwP9Eu-tO_GvYRgRvdsQqrWTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] CMakeLists.txt: enable SHARED and STATIC lib creation
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Deepak Kumar Mishra <deepakkumar.mishra@arm.com>,
        dwarves@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, siudin@fb.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 10, 2021 at 10:31 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Jun 08, 2021 at 12:50:13AM +0530, Deepak Kumar Mishra escreveu:
> > CMakeLists.txt does not allow creation of static library and link appli=
cations
> > accordingly.
> >
> > Creation of SHARED and STATIC should be allowed using -DBUILD_SHARED_LI=
BS
> > If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt sets it t=
o ON.
> >
> > Ex:
> > cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DOFF ..
> > cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DON ..
>
> Had to do some fixups due to a previous patch touching CMakeLists.txt,
> please check below.
>
> I tested it and added some performance notes.

Hey Arnaldo, Deepak,

I think this commit actually breaks libbpf's CI (see [0]) and my local
setup as well (see output below). It seems like now we are using
system-wide libbpf headers, while still building local libbpf sources.
This is pretty bad because system-wide headers might be too old or
just missing.

Is it possible to make sure that we always use local libbpf headers
when building pahole with libbpf built from sources (the default case,
right?). It's also important to use UAPI headers distributed with
libbpf when building libbpf itself, I don't know if that's what is
done right now or not.

Note how libbpf CI case shows that system-wide bpf/btf.h is not
available at all because we don't have system-wide libbpf installed.
In my local case, you can see that my system-wide header is outdated
and doesn't have BTF_LITTLE_ENDIAN/BTF_BIG_ENDIAN constants defined in
libbpf.h.

BTW, I tried -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DOFF options and they
didn't help. Maybe I'm doing something wrong.

  [0] https://travis-ci.com/github/kernel-patches/bpf/builds/228673352


$ make -j60
-- Setting BUILD_SHARED_LIBS =3D ON
-- Checking availability of DWARF and ELF development libraries
-- Checking availability of DWARF and ELF development libraries - done
-- Configuring done
-- Generating done
-- Build files have been written to: /home/andriin/local/pahole/build

....

/home/andriin/local/pahole/btf_encoder.c:900:28: error:
=E2=80=98BTF_LITTLE_ENDIAN=E2=80=99 undeclared (first use in this function)
   btf__set_endianness(btf, BTF_LITTLE_ENDIAN);
                            ^
/home/andriin/local/pahole/btf_encoder.c:900:28: note: each undeclared
identifier is reported only once for each function it appears in
/home/andriin/local/pahole/btf_encoder.c:903:28: error:
=E2=80=98BTF_BIG_ENDIAN=E2=80=99 undeclared (first use in this function)
   btf__set_endianness(btf, BTF_BIG_ENDIAN);
                            ^
...


>
> Thanks!
>
> - Arnaldo
>
> commit aa2027708659f172780f85698f14303c7de6a1d2
> Author: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
> Date:   Tue Jun 8 00:50:13 2021 +0530
>
>     CMakeLists.txt: Enable SHARED and STATIC lib creation
>
>     CMakeLists.txt does not allow creation of static library and link app=
lications
>     accordingly.
>
>     Creation of SHARED and STATIC should be allowed using -DBUILD_SHARED_=
LIBS
>     If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt sets it=
 to ON.
>
>     Ex:
>
>       $ cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DOFF ..
>       $ cmake -D__LIB=3Dlib -DBUILD_SHARED_LIBS=3DON ..
>

[...]
