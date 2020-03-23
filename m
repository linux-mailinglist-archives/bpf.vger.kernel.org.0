Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF518FC83
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 19:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgCWSRy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 14:17:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43514 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgCWSRy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 14:17:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id o10so10589302qki.10;
        Mon, 23 Mar 2020 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/iINQakXzdSaxtc+oBuB0CcXHSHh3PaVKS7Xnoq5BJg=;
        b=hW6ry3XELpTQ9FArONRTT+1ABF3rH0TIBfP/dW57M5BkZn4/6VNvOVLGVX/r84j2yS
         /8/qeIrFwuUR6QdA7xneRBwHFkZkKbJ+SsV2Wfz4Bj5jFyg8J6962AYCAAZYwLhJVJrm
         6NcBIkbrogDU8Ll5Jk2tLHIZrsmJVSASOIK3AyDY9y656FGpvQ/wniPsPsP44KIGrGhp
         GgOjmy/rnEkCTXldpXf30Tck8/MLODydaSalm88IVbKkcGKEPXFkiU6bDKptqsj8dcrw
         W4EXJNoQARdPPWpClizMmvWYCl823IwNRmbVcmZe985WeIMURVHjo0fAuM7+x+kT9g3C
         IVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iINQakXzdSaxtc+oBuB0CcXHSHh3PaVKS7Xnoq5BJg=;
        b=VOBKGXOCXcOH22Vas/m/DEtormY+XmmHLF9MEjc4Qle99qVz45KM/QxXjrhhINtxYl
         TW/PoCbDo76SlfdGp+CkzXUXoPuCt3EWjR0qmh/tW60m+4z4WrOUlv7P6T00Jhq50ozv
         1wkSnnZ6ofRfMcSnnDSmld/ASraHAQGeH/NagKGRk6OX7SJOB7cBnaMBwxhZIkIXCMEi
         jc2Tx10u5ITmqaO/jd8va1VSmOY1xjM2qGan0Ts+S5klDaYjR9DzU3KmJSrV3yoMuTZg
         G7fBAQebXvrWvhFNFOfPeQo3ZDxlaqbXBWMHRjnsY1XGYaMuEDylo26gAKD34n958uvg
         l+ug==
X-Gm-Message-State: ANhLgQ3CG6ekHiocSDDSfpRlDZicYTBVcJuAYJsL8wbrMVxJdp4suofL
        DvznDjapYINLK5qwRz+/oqh5BA0fbzk29dggKe5l81Z3
X-Google-Smtp-Source: ADFU+vu54K/MLKIRzODRv1lzYlUn5Y0owG4WQEJmzgRAlHFITjSo/8KHMJeS/8AAOa/zl1xGbqn9cNtMLZ+rzea/jI0=
X-Received: by 2002:a37:992:: with SMTP id 140mr22664483qkj.36.1584987473076;
 Mon, 23 Mar 2020 11:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9ptzBzzn+jOo=azZagB=TTFbc2vzdcYurfsE0_1nvKF+g@mail.gmail.com>
 <50c6bd77-fb16-852a-adcc-3976550f6f81@fb.com> <CAHmME9r+anBCRihmhi-Jsy6o8bcZkbwiRRW2ZYytUd5uTrha-w@mail.gmail.com>
 <CAEf4BzYXN=xNu6qeYZR_fDu3NRw9hMB7-Ehs=diB+N_aYkOWmw@mail.gmail.com>
In-Reply-To: <CAEf4BzYXN=xNu6qeYZR_fDu3NRw9hMB7-Ehs=diB+N_aYkOWmw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Mar 2020 11:17:42 -0700
Message-ID: <CAEf4BzaGBNmtiGwn6uT29ipG+M9YL9J6miGEA0nn2utDsmpaNw@mail.gmail.com>
Subject: Re: using libbpf in external projects
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        nicolas@serveur.io,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 23, 2020 at 10:50 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Mar 22, 2020 at 11:00 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Thanks! That's much nicer to use:
> >
> > https://git.zx2c4.com/netifexec/commit/?id=8a39f70c981264500d27e90bbd5e3baf8f2d10d3
>
>
> You probably don't want to compile libbpf with your custom rules. See
> BCC libbpf-tools [0] on how to do this when you use libbpf as a
> submodule. The idea is to do a sub-make call and let libbpf's Makefile
> deal with everything.
>
> Having said that, though, libbpf is packaged properly for Fedora (and
> I think maybe for OpenSUSE and Debian, but not sure), so if you can
> rely on libbpf package, that would probably be easiest and best. If
> Linux distribution(s) you are targeting doesn't have libbpf package
> yet, we'd really appreciate you reaching out to packager and asking
> them to follow Fedora and do it :) Would make everyone's job easier in
> long term. Thanks!

Just realized I didn't paste the link:

  [0] https://github.com/iovisor/bcc/tree/master/libbpf-tools
