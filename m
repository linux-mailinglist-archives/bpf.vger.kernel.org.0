Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F533C97A8
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 06:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbhGOEsE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 00:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbhGOEsE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 00:48:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF6BC06175F
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 21:45:11 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f30so7566357lfj.1
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 21:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dbs+6nEmTEdrEA0NncGSU82hIr21Uag+EkHJQ1HaunI=;
        b=cfE13DaVbKB4UsEKoTkWehvYavXOM8qQ7qVWAHyA+dL+BuTMMDA5nFMtX1QZG7nsQW
         lRWnJycpM1MoVBvnZQMHkLYPCCy16OC9PNU1NyBjcFTAxnbELRNOM0KqaUzzcySr3lMx
         nI2ASrM+YrpsO5KC0uomqcH5KiiyLXW49waVRVpJx5x0Modee9p1FKjo8XNVC4dDRbiP
         n6ohaLgE37necMXM102Uyl3xqj5jHPiZU53FPPePxUX6tpVedmXfaWBXTPBQJ9miZTzV
         oW93N4Q/s/SSs7OLvd1DdSOmAm1Q7z1jiAEspAZlndo6bvFKPmiZUC/y3mCs2siEDPk9
         JPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dbs+6nEmTEdrEA0NncGSU82hIr21Uag+EkHJQ1HaunI=;
        b=IA3QuaO7m59hdJbm2uWkI4mehzzjRfkBt1mfdcy2XYmFfA09eJHwnaOQR5QoAxy3c0
         0gYlMXxh03zgxzv0T8Q19crsHWve1h8z559vybvNoETITDmSAc8MA+3hKxk0ZASHxCfu
         V12ajs+gNDnbg7moswnYGmvgryt/vVB3N2EJbY3mQPZkiV42OMEG41vESO9t2D03Lb6q
         VVSe6OGyPKes8EoFm9a4QabAAAJcodnszGCVHMh/snHrUemo0M/b2SIK35NMlGIm4A3L
         u0vnYEcU48xyApSIcIYDvULFW4n0wsTF1LFlDL3sRCDPOWYV8UHRG6VjvD4K7MTZdsAO
         5qyw==
X-Gm-Message-State: AOAM531ZcRDhND8H4lHbspvTqmw+fWsniwgIDGyTaBGxUiLje+/a/oJK
        VKmkL38pQTJQ85Gt9YsBl0T5TOJeTrOlG8nVS58=
X-Google-Smtp-Source: ABdhPJygscTUrXyI5jp40NYXz1KxzzeoMirN14k0Y0Uu9bHtoNhcVNHVBYnMp9AGHBvTGCxie5MBZGvIYSGHcLbLCzw=
X-Received: by 2002:a05:6512:3138:: with SMTP id p24mr1657422lfd.214.1626324310012;
 Wed, 14 Jul 2021 21:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <CH2PR21MB1430287CC594A28B1FC473EAFA1B9@CH2PR21MB1430.namprd21.prod.outlook.com>
In-Reply-To: <CH2PR21MB1430287CC594A28B1FC473EAFA1B9@CH2PR21MB1430.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 14 Jul 2021 21:44:58 -0700
Message-ID: <CAADnVQ+ETbQgF2j=RqgzKYjzNCp_XLCswSLwyE6BqttwF=GSOA@mail.gmail.com>
Subject: Re: Signing of BPF programs as root delegation
To:     Alan Jowett <Alan.Jowett@microsoft.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 6, 2021 at 10:30 AM Alan Jowett <Alan.Jowett@microsoft.com> wro=
te:
>
> BPF folks,
>
> Quick question: Has anyone considered using signing of BPF programs as co=
mpromise between completely denying non-root from loading eBPF programs and=
 permitting non-root to load any eBPF programs?
>
> Problem statement:
> A large set of security issues have arisen because of permitting non-root=
 to verify and load eBPF programs into the kernel. These range from Specter=
 style speculative load side channel attacks to verification failures. The =
desire exists to permit programs that use eBPF to run as non-root as an eff=
ort to run with least privilege, but this conflicts with the desire to limi=
t eBPF program loading to root only.
>
> Proposal:
> Enable signing enforcement of eBPF programs (https://lwn.net/Articles/853=
489/) and permit root to set a policy that permits non-root to only load eB=
PF programs signed by root. This would allow root to delegate permission to=
 load specific eBPF programs to a non-root entity while continuing to block=
 loading of arbitrary eBPF programs. Root could then verify the provenance =
of eBPF programs and then sign them only if they are from a safe source and=
 have been compiled with appropriate speculative load hardening. This appro=
ach would appear to give the benefits of least privilege while also control=
ling what is loaded into the kernel address space.
>
> Background:
> The eBPF for Windows (https://github.com/microsoft/ebpf-for-windows) team=
 is exploring security hardening options and one of the options on the tabl=
e is to use signing to restrict loading of eBPF programs to those designate=
d as trusted. The desire exists to maintain a similar security model on all=
 platforms on which eBPF is supported, hence reaching out to you folks.
>
> Thoughts or feedback?

In general it all makes sense to me.
The only confusing bit is "signed by root". I don't think such model
exists today.
At least for bpf programs the idea was to follow a signing process mostly
similar to kernel module signing. The user that signed it is not
recorded in the signature.
Whoever has the key can sign it.
The kernel would verify the signature from the key ring.
The questions would be whether bpf needs its own key ring or not.
Some folks proposed to delegate the final decision to another bpf prog.
Like the kernel would verify the signature, but things like key ring
and what to do
with validation outcome would be delegated to a special prog.
In such case an unpriv process loading progs that are signed with a certain=
 key
could be allowed to proceed even when progs are of tracing type.
The libbpf-tools and pre-compiled bpftrace scripts would benefit.
I think it would fit exactly to what you're proposing.
These details need to be worked out, of course.
