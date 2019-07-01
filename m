Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5203E5B816
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfGAJeh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 05:34:37 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38590 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfGAJeh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 05:34:37 -0400
Received: by mail-oi1-f194.google.com with SMTP id v186so9416576oie.5
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yBOQL4AlA49bjQlqErsbDODVihHA5ZvWVTU0xteZNjM=;
        b=sqgTYLC0jS+FvL1gHtpbAGC/SFNLb8Khi0zbul2zM9QIHbNFwew/u471bowmYEHrJl
         h9EbSGIU/HYDlTleHv41zX4llIzx9RUen1vqGxeiNDKti/EDzikPP22JI2xXk05nNpqv
         tdPXvDg2eEbYU9oP7lzvuB6AxCWLwVOrkGvHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yBOQL4AlA49bjQlqErsbDODVihHA5ZvWVTU0xteZNjM=;
        b=hGDyq/8LAxU4Td5XdmC3SqvoQcFysuAIsDYrRvguL57ovBczcCgpn+LAz6Ay0NKwHd
         mF123LnsKKlHpadEhP2ZO8AsI0qvcAES8Blp7ibw3i5kWqSOVC06i8Okhe95apHcasGG
         0gV69hvfpOoa0PYeRQl4a5il+VosF56ET1+7rR3VlNyprIC059P6fzG9+kTUYBq4w3Im
         PvGdXEZ2KBF5oZqVB7AhlX7v529PcazQooPlUc/HHXRYJnvHPgwmvplv+lxPFPATG27+
         mFnNavGQFAo9jmlcDPnBj0Zq/rQZb2X0kFsjQ+5yVMlKQvMPU3FSfZ5L100gupnPPJVV
         /HDw==
X-Gm-Message-State: APjAAAXAf1MWTLtTrhfVFwOn3xzhbepHnPZWIJblkn8Et/zkZDVNmXwz
        2WpdrZql7cYtwEMCfoF1ubqywxwTNeQMKomUigbqhw==
X-Google-Smtp-Source: APXvYqwskeJabbHvnBxy9OrHFkf4zReo8vmmZTHqVVBtlsOL5J/ywx6cEEt9fZgNZ8oR/IU09XbV7Jctvx2AUgd5TkQ=
X-Received: by 2002:aca:ea0b:: with SMTP id i11mr5961615oih.102.1561973676792;
 Mon, 01 Jul 2019 02:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190627201923.2589391-1-songliubraving@fb.com>
 <20190627201923.2589391-2-songliubraving@fb.com> <CACAyw98RvDc+i3gpgnAtnM0ojAfQ-mHvzRXFRUcgkEPr3K4G-g@mail.gmail.com>
 <91C99EC0-C441-410E-A96F-D990045E4987@fb.com>
In-Reply-To: <91C99EC0-C441-410E-A96F-D990045E4987@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 1 Jul 2019 10:34:25 +0100
Message-ID: <CACAyw98VyM8a-h_8jtsNdF0KfK69-AxzRR4K28HVsyUecb0a5Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
To:     Song Liu <songliubraving@fb.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Jann Horn <jannh@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 28 Jun 2019 at 20:10, Song Liu <songliubraving@fb.com> wrote:
> There should be a master thread, no? Can we do that from the master threa=
d at
> the beginning of the execution?

Unfortunately, no. The Go runtime has no such concept. This is all
that is defined about program start up:

  https://golang.org/ref/spec#Program_initialization_and_execution

Salient section:

  Package initialization=E2=80=94variable initialization and the invocation=
 of init
  functions=E2=80=94happens in a single goroutine, sequentially, one packag=
e at
  a time. An init function may launch other goroutines, which can run
  concurrently with the initialization code. However, initialization always
  sequences the init functions: it will not invoke the next one until the
  previous one has returned.

This means that at the earliest possible moment for Go code to run,
the scheduler is already active with at least GOMAXPROCS threads.

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
