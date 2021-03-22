Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF35345035
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 20:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhCVTqm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhCVTqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 15:46:40 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107E5C061574
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 12:46:40 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g12so7839910ybh.9
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qyo9S2X1/2ZdWKCbVr/KY2C485/elPMNmIdbH+9Qfyc=;
        b=FpGIj2PMKEgq6AWjdskWktMVV026k+B9Cuv0GtgUXgNbs2+ot+lRcAwdsCq5WtYhu9
         eL1O1PDAw3pH266UdDe9Vv87gaop17r4MqWwS8ADcueu/yJm+cBzUso/QjEngCSxdsTt
         CgYc2rdrTgwRG3jsKIZXwCFUR5M0W9vGiNVrquFhe9JC46J5p95lqXSDIcAYyW4xvztS
         xYbP/hlgrn4PFA1ZkCk3ybav2ufTGhO50XbyZXHmPzcqiv+aRHqpcpjJFaLLfwA3Nfzc
         yWrbXxLF/6gp6BFWPB9oqr56CChew3JAa2E/6SsS8BIxlQfqrNfz5EKjc/JCm4VpDV5M
         k/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qyo9S2X1/2ZdWKCbVr/KY2C485/elPMNmIdbH+9Qfyc=;
        b=q2FBNjRKwIyHUGnh0rrEa7JVAnoC1B9xNwcnCpjCs8ZTuem10CVrYogg4ZUMW36L4b
         C5GACKykAaXzM0SiW29AXRzXP+NCGO0Wu/DwtPfedfLK9lAbxuJxBqAqtdwdi+AOkkFc
         aSqHIziz+nqMgmhoRKxh7HwFrDlHI337UCr+VYbh8viEiflXlYc2v3Kf1ZNfWvtYeBot
         Kev5FoTbNxnejfoZUkJo2FwzRc6qp0wKj9ecaYHlsunzOhD2U4z4cFEdvFfce+ebhSH4
         ANhkiauhMvdaxZ6YRWaUswgfBTEM+vibjQHOIYzw6KAMP6XOTRNXlJVRScT3l9TK8l5W
         kZtA==
X-Gm-Message-State: AOAM532CvoGo65kdHSjqOy7sIgew5W7HKuQlrLKzKdEjGCBTERzuiH2c
        elqj+T3nvDJcOKTyEZbRGutZ3GaFb9DKNsjFE6I=
X-Google-Smtp-Source: ABdhPJxwY576oEsCrG42qbmJwaWk6hU6qcNwSBy/fap/l/fsbHkd0PsA8HETeePZm26ee2pRKK5vWg5LiaM8b3YlcWo=
X-Received: by 2002:a25:874c:: with SMTP id e12mr214344ybn.403.1616442399207;
 Mon, 22 Mar 2021 12:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210320202821.3165030-1-rafaeldtinoco@ubuntu.com>
 <CAEf4BzbUaDbhd4zzfpzpHS007hT+uyQyifdzCdD8_Rwp6ydhfQ@mail.gmail.com> <4867B26C-E650-451B-9103-2FFB99DD03C4@ubuntu.com>
In-Reply-To: <4867B26C-E650-451B-9103-2FFB99DD03C4@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Mar 2021 12:46:28 -0700
Message-ID: <CAEf4BzasP1GGccfBT9UFdC+AU775T+_vLAB4dv2cvE3Yb3SEfA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: add bpf object kern_version attribute setter
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 22, 2021 at 12:36 PM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
>
> >> +LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, __u32
> >> kern_version);
> >
> > have you run libbpf's Makefile? It should have complained about
> > bpf_object__set_kversion symbol mismatches/etc. That means that this
> > API needs to be listed in libbpf.map file, please add it there (to
> > latest version, 0.4, and also preserve alphabetical order). Thanks.
>
> Alright, sending a v3 with changes. I had only static builds on
> my side and it didn=E2=80=99t run assigned linker version-script. Will
> include in my tests before further submissions.
>
>

Oh, I just noticed that you based your patch on top of Github
repository. libbpf sources actually live and are developed against
bpf-next kernel tree. Github repository is periodically synced from
kernel trees with a special script. Please do the development against
libbpf sources in the kernel tree (in tools/lib/bpf). You should also
try running selftests from tools/testing/selftests/bpf, especially
`sudo ./test_progs`. You'll need very recent Clang built from sources
to build and run everything. But at least you won't have to spend
efforts setting up your VM for testing, see vmtest.sh script in
selftests, added recently by KP Singh. It will build latest kernel and
will spin up qemu VM to run tests.

It's a bit of an upfront setup, but if you are intending to keep
contributing to libbpf and kernel, it's worth it :)

Also we have CI that would automatically test submitted patch sets
(see [0]). See also [1] for the build for your v2.

  [0] https://github.com/kernel-patches/bpf/pulls
  [1] https://travis-ci.com/github/kernel-patches/bpf/builds/220716720

>
