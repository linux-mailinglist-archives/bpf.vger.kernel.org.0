Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E195C28C3EB
	for <lists+bpf@lfdr.de>; Mon, 12 Oct 2020 23:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgJLVVK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 17:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgJLVVK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 17:21:10 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759C5C0613D0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 14:21:08 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p15so25217424ejm.7
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gPQruZ4c4WTHJGOuIBKUut5i/edZs5tI8zZd/BS3PSY=;
        b=DJ9eZFICggoCI8tUlEBV/Unl85SYRUVWd1+gv2lDszymNofH76rjRQjm6YI7Os0XgE
         I0Np307Y47vf8s7M4nkUnWx1fwd+Xb2d3eNJTpUQGay+iVkU80uWs19RIAMcv+AuQX8j
         ZQc6HjTIxe1MGIifLz+R2uFoXjHH8jKyzWMRsof+4O1ykb2FcWqp0MW3WDNHlCL0OzYk
         aGHP+rz3PeWuH+iwqU5i4SN6MH9xtyglomAt4mlyHKVGTbAI0Ek63QgOfLqhLJcTB7+E
         ZKLMkG9dngxJL1AFMowsEsl17aBTwDy8qRRJ3hv988wRxuifaUkxXqGUpiZ4JNXegy4C
         KOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gPQruZ4c4WTHJGOuIBKUut5i/edZs5tI8zZd/BS3PSY=;
        b=N9sb1v3Itxs03JBZyNUvOVDxiXS1E1mubbvofc3j9qLSHlmqh+jfEUhGwsiDdnIAnJ
         CYi9fpmzR76OCtPA/lx/PjfxBIODMqwavjA6AZNyqeSfjbK8a+koLcg20oUU7xlHUmVm
         5TgHM/6OBCbi7Dr2PGrMNtjIH+xpmtARK9Q7NJWAUDLJDBiPl9vSt3oaQW+yceSx8+Yb
         CaL2cRSs0rxxFJTW1JqkZbFo4sugEOYkARdp1nuNpo4MRNcNxDOBw5Yd7JISZWf3rYV/
         ysyWRDWugeABZANRAI7Fntv6evh/eBa3ExRy1Mq3fgYtKYSvIcs0LsUw/WHoYeOe2JRB
         UiMg==
X-Gm-Message-State: AOAM533sPmvL8bJWYvv8zCfT9Gz2GbITnzVMhBMIZuL1zOCtOinXoLH+
        p5BdKKiZXFPLHMqG3MPA4TjhzA8sGbd3BYUO46Xb+AXHudtletna
X-Google-Smtp-Source: ABdhPJz8ecmXC3+nIsJlNNXubFcpfoXGGmu1Onz6ZHxbd8f4RNQ519K3dgcseobsGUvw93jQvJO7StiXzLWNb0oxkpQ=
X-Received: by 2002:a17:906:4d10:: with SMTP id r16mr31666597eju.68.1602537667010;
 Mon, 12 Oct 2020 14:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZWoL7w97aR5_02OEjKEkJT8R7OEzpL5Zp8Cycm=yZSLJQ@mail.gmail.com>
 <CAEf4BzYnELT0tE8Y4goPWxuBGN+G-37A8A1yjspFL=LK842geQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYnELT0tE8Y4goPWxuBGN+G-37A8A1yjspFL=LK842geQ@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Tue, 13 Oct 2020 00:20:55 +0300
Message-ID: <CAMy7=ZUcdu7_nxnUyGZkGyue5rG_0YRMXqhrnvfKW64dio1LpQ@mail.gmail.com>
Subject: Re: libbpf: Loading kprobes fail on some distros
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 12 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:02 =D7=9E=D7=90=D7=AA=
 =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Sun, Oct 11, 2020 at 7:10 PM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > Trying to load kprobes on ubuntu 4.15.0, I get the following error:
> > libbpf: load bpf program failed: Invalid argument
> >
> > The same kprobes load successfully using bcc
> >
> > After some digging, I found that the issue was with the kernel version
> > given to the bpf syscall. While libbpf calculated the value 265984 for
> > the kern_version argument, bcc used 266002.
> > It turns out that some distros (e.g. ubuntu, debian) change the patch
> > number of the kernel version, as detailed in:
> > https://github.com/ajor/bpftrace/issues/8
> >
> > I didn't find a proper API in libbpf to load kprobes in such cases -
> > is there any?
>
> Yes, you can override kernel version that libbpf determines from
> utsname with a special variable in your BPF code:
>
> int KERNEL_VERSION SEC("version") =3D 123;

Thanks! This is trivial, I should have thought about it myself.
For some reason, I thought that the loader should handle that, but if I inc=
lude
int KERNEL_VERSION SEC("version") =3D LINUX_VERSION_CODE;
It should just work

Thanks again!
