Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101992D15D9
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgLGQU7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgLGQU7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 11:20:59 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76F4C061749
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 08:20:18 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id e7so5338750ljg.10
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ExTEv2H667JOfE6pkQV7NpKY2crYPN7oZNIwIWD5hKo=;
        b=ZC998t6jEGt6giJOBoFjBpBaGYr4iFojObjBDAio7DogG8rHA8ZEuvdQKdgNMvDFb7
         psLUnSAA9/hONlSKw4JUygDnekoqxr5+a23UIlqPMe8/Q8J9c2G/Unr+qjHBfUN6Q3EL
         kW9PVi+U89oxcDBpJxkMl/d73wNOHu6wXnLFvAzUuFsyN78FEZWWOgOBMRJ+beMlQfV3
         DtFkMI4cQEIBD30SeMp9vOoW6Q8doRSu0j8MKELJye4t71PQugIzg1+1ywYSwRZYFS+P
         vx75WadR/NbAuqcmlXQzyP9LyIHmB2iJ2nVmBZ6+ZZQ/KsbvELbS376OAsVf5yzMSYGy
         Phvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ExTEv2H667JOfE6pkQV7NpKY2crYPN7oZNIwIWD5hKo=;
        b=CT0SIe39U3F6EG4KVNmoa0iw6vnb3RrLTdzu0FY3rwykEm6ql9zWCw/wXY9LYw3GVz
         Ii0AAjt1rvfA3TLzJsyhs5o/G7m2mnQS4U3aDjiqqSPN0fIS/rKmAHntWxJ6Am/OMYUD
         UEUqKbDiSGdauIsER3IEAieJwgKVWwcRB3lvj08fDShlsH6Io6WP2PTTh/csHSpgEgZT
         jESB+mxQn9gBwafCVToklKsLqtccoT0R169znPBsrwmz8RkpRPhzS8sqggEivadCkoUH
         TywWnL9DzPp4VcbPAcKOJn3u6vsOvAVJyH5FNDdVadQkMZlp0BHSN0SDYlRZYcGhtgOu
         6ENQ==
X-Gm-Message-State: AOAM53138SEXpLPm1WnILKMj+PSKUUSiL/58l5agIfZ039/CH7baUyzY
        QydlndMoX30hVxZV22TCtJ/ns2HoxZgxzjL28lk=
X-Google-Smtp-Source: ABdhPJybnuGxX5TefHygG9D1g+HpQSXoc3UD+QDPMPUDR8CcT4COdwq4SlXTrmw0XQF6vsaZBoN4fFufucWSSIA69/E=
X-Received: by 2002:a2e:8891:: with SMTP id k17mr8450705lji.290.1607358017286;
 Mon, 07 Dec 2020 08:20:17 -0800 (PST)
MIME-Version: 1.0
References: <87lfeebwpu.fsf@toke.dk> <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com>
 <87r1o59aoc.fsf@toke.dk> <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
 <875z5d7ufl.fsf@toke.dk> <CAADnVQ+qibC_8cDwaqOoAnL7CwXv85EjQ96Zcdtrm+86cgZq1g@mail.gmail.com>
 <878sa9619d.fsf@toke.dk>
In-Reply-To: <878sa9619d.fsf@toke.dk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Dec 2020 08:20:05 -0800
Message-ID: <CAADnVQKYaeF2KCC5SLBg3feUY_DBh-eq2_O=T10_+13z3wNm1Q@mail.gmail.com>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 7, 2020 at 8:15 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Mon, Dec 7, 2020 at 3:03 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >>
> >> Wait, what? This is a regression that *breaks people's programs* on
> >> compiler versions that are still very much in the wild! I mean, fine i=
f
> >> you don't want to support new features on such files, but then surely =
we
> >> can at least revert back to the old behaviour?
> >
> > Those folks that care about compiling with old llvm would have to stick
> > to whatever loader they have instead of using libbpf.
> > It's not a backward compatibility breakage.
>
> What? It's a change in libbpf that breaks loading of existing BPF object
> files that were working (with libbpf) before. If that's not a backward
> compatibility break then that term has lost all meaning.

The user space library is not a kernel.
The library will change its interface. It will remove functions, features, =
etc.
That's what .map is for.
