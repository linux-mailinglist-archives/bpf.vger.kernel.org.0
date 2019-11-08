Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70DDF5851
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 21:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKHURV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 15:17:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46600 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726641AbfKHURV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 15:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573244240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8XmqdlToSU6NJqH8qmccEKFAVpRMleSguA8vXGilu6s=;
        b=UrsyhpY1MOvn1fM7Vze5QZe009Na0WmD9YWPguQ4jWosHJt96ZMjupoDVw/BUMwcyl0zvc
        A274OhuJTiPifbB6jZQpk36H/T2qwmDmt2M3txfxw4dBaLIBuQMl9zYpOkvHw0XxYvvd0m
        5b5Pj5w2pD7wJ296fgCRsSIJV/1S/Ic=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-tRBmHF0SMi2AlOh_plJ2tg-1; Fri, 08 Nov 2019 15:17:16 -0500
Received: by mail-lf1-f70.google.com with SMTP id h3so1504881lfp.17
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 12:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tZXwWUvRbK2iGv7/sjZbpOCmTR15Xdh/z/tXR5i51YU=;
        b=iRLtzRH2z/P+Vmo8bUQ3nph7py6iTh7nCwRZ3n73LrSm9jo5GKcxJn07KPBKjtCQ6V
         G6+RE2V20NVlgHZk8HpolnT9+u70RNE5XmTGLP/5iJD0CSXBP022grFeUn/Tv8LrcP8P
         aC61qrZ8ADLvjOk2HruBzVuKIZyfUvBsCYCFkPvTSKLa1PnVVjwcDU25KbpNdx4jU1ug
         hDteUkYILbgWo4J3dAuj18FgqzzOHLe2PqGCfqZsEpIDTFwNDBfoi+qfY1qr4vYKrmDD
         6kDbdS1pKbsX3/VcSed00lQsEr4f/Hi+lUXVyEoX/ZOEkKeJxZr34qxxjLZHW0UJ5ejb
         WnKQ==
X-Gm-Message-State: APjAAAVaim/IJ9O/iltM5TU8ofOTW2wm/qHocmaHFk2gGeTyWPcaRrlh
        UY4pbH1kdcqMXqkxAxum8FfGO+Us0PzyByGEdfrlb45RLqYFVZsvZrhoRhpdwizSXhDq4v1w9IS
        9ipop1ZSjswI2
X-Received: by 2002:a2e:9dd5:: with SMTP id x21mr8021228ljj.232.1573244234676;
        Fri, 08 Nov 2019 12:17:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZF5NmC9uJloejljsBclAtv2y/On5iFys1P+hJ7HdJ/rjgq4ubrTwjSKlBB8keESGx34oNzA==
X-Received: by 2002:a2e:9dd5:: with SMTP id x21mr8021218ljj.232.1573244234478;
        Fri, 08 Nov 2019 12:17:14 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id b67sm6984800ljf.5.2019.11.08.12.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:17:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F121C1818B6; Fri,  8 Nov 2019 21:17:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     daniel@iogearbox.net, x86@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 15/18] bpf: Support attaching tracing BPF program to other BPF programs
In-Reply-To: <20191108064039.2041889-16-ast@kernel.org>
References: <20191108064039.2041889-1-ast@kernel.org> <20191108064039.2041889-16-ast@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 08 Nov 2019 21:17:12 +0100
Message-ID: <87pni2ced3.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: tRBmHF0SMi2AlOh_plJ2tg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <ast@kernel.org> writes:

> Allow FENTRY/FEXIT BPF programs to attach to other BPF programs of any ty=
pe
> including their subprograms. This feature allows snooping on input and ou=
tput
> packets in XDP, TC programs including their return values. In order to do=
 that
> the verifier needs to track types not only of vmlinux, but types of other=
 BPF
> programs as well. The verifier also needs to translate uapi/linux/bpf.h t=
ypes
> used by networking programs into kernel internal BTF types used by FENTRY=
/FEXIT
> BPF programs. In some cases LLVM optimizations can remove arguments from =
BPF
> subprograms without adjusting BTF info that LLVM backend knows. When BTF =
info
> disagrees with actual types that the verifiers sees the BPF trampoline ha=
s to
> fallback to conservative and treat all arguments as u64. The FENTRY/FEXIT
> program can still attach to such subprograms, but won't be able to recogn=
ize
> pointer types like 'struct sk_buff *' into won't be able to pass them to
> bpf_skb_output() for dumping to user space.
>
> The BPF_PROG_LOAD command is extended with attach_prog_fd field. When it'=
s set
> to zero the attach_btf_id is one vmlinux BTF type ids. When attach_prog_f=
d
> points to previously loaded BPF program the attach_btf_id is BTF type id =
of
> main function or one of its subprograms.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

This is cool! Certainly solves the xdpdump use case; thanks!

I do have a few questions (thinking about whether it can also be used
for running multiple XDP programs):

- Can a FEXIT function loaded this way only *observe* the return code of
  the BPF program it attaches to, or can it also change it?

- Is it possible to attach multiple FENTRY/FEXIT programs to the same
  XDP program and/or to recursively attach FENTRY/FEXIT programs to each
  other?

- Could it be possible for an FENTRY/FEXIT program to call into another
  XDP program (i.e., one that has the regular XDP program type)?

-Toke

