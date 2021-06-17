Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A243AAAA7
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 07:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhFQFPE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 01:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhFQFPD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 01:15:03 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE822C061574
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 22:12:55 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id p15so6378886ybe.6
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 22:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ClM324FNrdH3q99k5UcsI+S9yLK9S2TWREmKYzBSs6Y=;
        b=PTAR05taIoMZ5qd/7IqUELaD8IHXjfEAFbSNSJj+x0IuVzVHk2xmFTv6k/fE+upLq6
         hNYHNzCSVIqiqMejHanFeZ4CAr5CKFFzJ+qaRnMnf2eR6/dfTgfjpSfnmIncR8jS6bDo
         +boegZNgFTKGOlAHoJykSoj8AWBJaIBQwftAmxwd6m3gtVYkdvmH3K2XpE+RC+OfZWsS
         bSKapQ39yZ9UPoqxTVvgzAAQnxcSeSo+MJwM4Vcs0odgySEDVl27evd5ilTWS7I5sciF
         +X/oYnw9MpRC4HA22ZnC2ZC+a0Zk7nQ+g2Zgn6mJlNYzU23fLVfWEpICHGQU5+7h/LLV
         sf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ClM324FNrdH3q99k5UcsI+S9yLK9S2TWREmKYzBSs6Y=;
        b=LS/zwba8OEK7w54aPToTwLLEmnei8C+ya/eIu2ekKkUigvfI9HyOr1brmkAYjLyHxi
         d2tdJ+c/2upta7miWbD4yqu5Omfqxn2sl0AtrStK16dnnLlM5y1JJ2eYWUSGw7X6Nxmx
         dIUroK4byuFomPauyH82CxoifhYpVck61PE8Fce+wfa14yDmhTqbu1s4CUwjoFWY1zVc
         AWNRd7Skgn/zn/ja+C7CtfRc4IDRYdEpmBRF32Axgf76Sr30X58jBjTyVnJC4qYXNo2C
         FcIiCuIKxedI80AU+6J3XN0Tv2R+h3FIdpvhHH7EvCxMpXkwifsT7eneARMy95CnohN4
         ur7g==
X-Gm-Message-State: AOAM530Q8TjkryP8E7eo/7ieBYW1fMsvwRv5LFA8656dbxQ0W6ZA36Em
        HcTSldZh2G91/dloZCDpPkhAwFAmTiZzX3vW9Bg=
X-Google-Smtp-Source: ABdhPJzejfGoN5ZkefoaKfN1e0hEsDoHzzht0kIS1DuumMVJeKzkW050yHDwdPg7IiHXihyBkz0+lI97gzU5ivJMXRU=
X-Received: by 2002:a25:aa66:: with SMTP id s93mr4132372ybi.260.1623906775115;
 Wed, 16 Jun 2021 22:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <YQXPR0101MB075902232E6458F07FBB78E39D0F9@YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQXPR0101MB075902232E6458F07FBB78E39D0F9@YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 16 Jun 2021 22:12:44 -0700
Message-ID: <CAEf4BzYtuJKaOSk6nqkMbb4vwmTAXjSWOZUJ8FnRUf_7LKkO1w@mail.gmail.com>
Subject: Re: [PATCH] add multiple program checks to bpf_object__probe_loading
To:     Jonathan Edwards <jonathan.edwards@165gc.onmicrosoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 16, 2021 at 7:19 PM Jonathan Edwards
<jonathan.edwards@165gc.onmicrosoft.com> wrote:
>
> eBPF has been backported for RHEL 7 w/ kernel 3.10-940+ (https://www.redh=
at.com/en/blog/introduction-ebpf-red-hat-enterprise-linux-7).
>
> However only the following program types are supported (https://access.re=
dhat.com/articles/3550581)
>
> BPF_PROG_TYPE_KPROBE
> BPF_PROG_TYPE_TRACEPOINT
> BPF_PROG_TYPE_PERF_EVENT
>
> Source is here: https://access.redhat.com/labs/rhcb/RHEL-7.9/kernel-3.10.=
0-1160.25.1.el7/sources/raw/kernel/bpf/syscall.c#_code.1177
>
> For libbpf 0.4.0 (db9614b6bd69746809d506c2786f914b0f812c37) this causes a=
n EINVAL return during the bpf_object__probe_loading call which only checks=
 to see if programs of type BPF_PROG_TYPE_SOCKET_FILTER can load as a test.
>
> Quick discussion with anakryiko (https://github.com/libbpf/libbpf/issues/=
320) indicated a preference for trying to load multiple program types befor=
e failing (e.g SOCKET_FILTER, then KPROBE). On older kernels KPROBE require=
s attr.kern_version =3D=3D LINUX_VERSION_CODE, which may not always be avai=
lable (out of tree builds). TRACEPOINT will work without needing to know th=
e version. We can use multiple tests.
>
> The following suggestion will try multiple program types and return succe=
ssfully if one passes. TRACEPOINT works for the ebpf backport for RHEL 7, K=
PROBE on newer kernels (e.g 5+)
>

So few high-level points about formatting the patch itself:
 - please use [PATCH bpf-next] subject prefix when submitting patches
against bpf-next tree;
 - please wrap all the lines at 80 and please look through general
kernel patch submission guidelines ([0])
 - note how I didn't include URL directly and used [0] (and [1], [2],
etc, if necessary). Please do the same, that keeps text more readable
and shorter.

  [0] https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l

> ---
>  src/libbpf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/src/libbpf.c b/src/libbpf.c
> index 5e13c9d..c33acf1 100644
> --- a/src/libbpf.c
> +++ b/src/libbpf.c
> @@ -4002,6 +4002,12 @@ bpf_object__probe_loading(struct bpf_object *obj)
>         attr.license =3D "GPL";
>
>         ret =3D bpf_load_program_xattr(&attr, NULL, 0);
> +
> +       attr.prog_type =3D BPF_PROG_TYPE_KPROBE;
> +       ret =3D (ret < 0) ? bpf_load_program_xattr(&attr, NULL, 0) : ret;
> +       attr.prog_type =3D BPF_PROG_TYPE_TRACEPOINT;
> +       ret =3D (ret < 0) ? bpf_load_program_xattr(&attr, NULL, 0) : ret;

As for this logic, I think let's drop KPROBE altogether. Ubuntu has
problems with LINUX_VERSION_CODE. Let's try SOCKET_FILTER and fallback
to TRACEPOINT before giving up. Very old upstream kernels allow
SOCKET_FILTER, so that is covered. And then backported RHEL will know
about TRACEPOINT. That should be good enough.

Also, explicit if in this case is more appropriate:

if (ret < 0) {
    attr.prog_type =3D BPF_PROG_TYPE_TRACEPOINT;
    ret =3D bpf_load_program_xattr(...);
}

if (ret < 0) { /* warn and error out */ }

> +
>         if (ret < 0) {
>                 ret =3D errno;
>                 cp =3D libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
> --
> 2.17.1
