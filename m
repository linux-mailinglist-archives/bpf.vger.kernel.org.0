Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D5F18FBE4
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 18:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgCWRu4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 13:50:56 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40978 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgCWRu4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 13:50:56 -0400
Received: by mail-qv1-f67.google.com with SMTP id o7so5180617qvq.8;
        Mon, 23 Mar 2020 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zfv1TUEAfS2XlKM6dZdDXyRH3HlubwchhWDB9NapG4k=;
        b=lVUXki8OmhFP0I0phFRcmLgSJRgmsAamD5VIe4londSRhr2G10LMj/Dxod0GCoDueY
         gsv7vk/NQgRYaI3mQMBbkCevubomLViTDNMNYJyIUMNGVATqPhNVv++wJmhrxLMZiT2W
         acOnqbadl53eO95o3HK4GokxU8NS6oot/V/Y+Cknjpr1/3kw01nTD5SPlbwMuZeBLMWI
         hsi4MeEbGMGFUCYbbQ86i8AoiEms63IePTIjzpeULJLEQlK6HvYC5NRcrAxMy1CD0gTK
         eeBkch84mWltMT96bBsC0sMkk2ZTHn0OPhguiIi+LdD8cTn1BMcKTybJtpInW37MC55B
         o9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zfv1TUEAfS2XlKM6dZdDXyRH3HlubwchhWDB9NapG4k=;
        b=raw79qJZDl+5LMe3iupGykEWjkJeyVND5iX7i8iDD32nbBqG/LrCuwprmkJIYqrBA/
         zNeXEPStoLKviuQzuXTBbdOT3T0+QtvGsB0RLbXSlPcPBo70XpZKduLSJLm+TSfxPs+M
         O42N+IJKKBCWSQMK96w6MVoa2qaXLgp4nZUb4ROtebo9VHSXj/uZRcCRovZ1gKLOdfWZ
         /maEET5HTLVTAo5pUhi23adrFzqtJOqo5WKhaBIX5/tD5TQqDK2l6a5Gexl+2jHFXVGQ
         WZpYqu77dDkY9ZX+k8clUMOemBqdXW2fQ8y7BXraeKHBZ1MlRdHAqVHVYgtGeVgI1Jje
         zeZQ==
X-Gm-Message-State: ANhLgQ39DbSBcCYb1qo/3JPXWRXNEeQwXsDpuyxpQGI3FrCanioiB+PW
        r+AaX5rTz9g9fHH/lY1XnAPH0eX4Gpf2pIXzu9w=
X-Google-Smtp-Source: ADFU+vvyaWRr5jf4VAHvSFtD018nPcsXUr1VAxnixMzmIlE44LfKtc2Ajs6Zb8xqwd2FpN0sV4KfCS5BTESOK9RbK2Q=
X-Received: by 2002:ad4:4182:: with SMTP id e2mr1642935qvp.247.1584985853810;
 Mon, 23 Mar 2020 10:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9ptzBzzn+jOo=azZagB=TTFbc2vzdcYurfsE0_1nvKF+g@mail.gmail.com>
 <50c6bd77-fb16-852a-adcc-3976550f6f81@fb.com> <CAHmME9r+anBCRihmhi-Jsy6o8bcZkbwiRRW2ZYytUd5uTrha-w@mail.gmail.com>
In-Reply-To: <CAHmME9r+anBCRihmhi-Jsy6o8bcZkbwiRRW2ZYytUd5uTrha-w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Mar 2020 10:50:42 -0700
Message-ID: <CAEf4BzYXN=xNu6qeYZR_fDu3NRw9hMB7-Ehs=diB+N_aYkOWmw@mail.gmail.com>
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

On Sun, Mar 22, 2020 at 11:00 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Thanks! That's much nicer to use:
>
> https://git.zx2c4.com/netifexec/commit/?id=8a39f70c981264500d27e90bbd5e3baf8f2d10d3


You probably don't want to compile libbpf with your custom rules. See
BCC libbpf-tools [0] on how to do this when you use libbpf as a
submodule. The idea is to do a sub-make call and let libbpf's Makefile
deal with everything.

Having said that, though, libbpf is packaged properly for Fedora (and
I think maybe for OpenSUSE and Debian, but not sure), so if you can
rely on libbpf package, that would probably be easiest and best. If
Linux distribution(s) you are targeting doesn't have libbpf package
yet, we'd really appreciate you reaching out to packager and asking
them to follow Fedora and do it :) Would make everyone's job easier in
long term. Thanks!
