Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB6427FD78
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 12:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbgJAKdt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 06:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732180AbgJAKdY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Oct 2020 06:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601548403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MpAORZQCxCD8t7TrF9bscNxbDDoc2oX5Y6uxVY/gI60=;
        b=WhBc25rLqjeHvE1JVvucU2VzR4FFyM9UwLUgJ6phv30rlOR1D2OMXHe012mr9eaAunwZz1
        vLVL83Cl59izah4HhJN3+Zz6hLStVch7Gwf6KXr+AHOpWlyZiys7AkzyLyx0dIe4YmuIq+
        xUMwCD1XNO+QX+wK9+g7RrmoNIctvZI=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-kpYXBO2EPtebejfuzRyKAw-1; Thu, 01 Oct 2020 06:33:22 -0400
X-MC-Unique: kpYXBO2EPtebejfuzRyKAw-1
Received: by mail-oo1-f69.google.com with SMTP id n16so2461956oov.17
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 03:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MpAORZQCxCD8t7TrF9bscNxbDDoc2oX5Y6uxVY/gI60=;
        b=MwYjiNSSxAlPWEMOipzNfXoWekUupIlmmc2uqkLwMUUa7psgk9T9NPj84l66ZYknDa
         CKXnQSwo4nIuVa+ycd3jmuhqf9ToxoYlSfCDvrEV5AaVD/HFuvwGEU92XzduD54K5AAc
         Ud2YKNJDTLlgKRhiWnkku+/u1dywzey8PYwScapugm4xIawatcaExzE3YKlsl2+GR+eK
         M4Jic+B8gSlp6t0LRr+UaB1miylAGMPksD7rYrXWdG1enMXQG1Fj0CErbL+QB2R9AHsE
         hcRwhN2E+r3/dR4OuCoi+d4QKtBQaw3eqfJKoYQuIKhOpvxv5NIrj4wHvJJP3Un6F7RT
         M7jw==
X-Gm-Message-State: AOAM533jvot42COxNcjQNKp2VSENG8CI8T9Euj0N2YFXzIKjMOMC42IW
        Q5yswPwnjetNg15YbJW8oYBJawBUgVjNCzfFYBgKHhHOivt1jnO0FK6VkmfCzffxX/dDtgM88TV
        Y56RwA6Ey6I2o
X-Received: by 2002:a4a:b3c9:: with SMTP id q9mr5151442ooo.84.1601548401483;
        Thu, 01 Oct 2020 03:33:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMU1PKLlDb30zHOQVzciYQBRAWuivzwVPnCjljvsHvkMXeFEPFfnt+gvpsVv7543XZy0C5gg==
X-Received: by 2002:a4a:b3c9:: with SMTP id q9mr5151432ooo.84.1601548401278;
        Thu, 01 Oct 2020 03:33:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m12sm1098772otq.8.2020.10.01.03.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 03:33:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 74D93183A1F; Thu,  1 Oct 2020 12:33:18 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: BTF without CONFIG_DEBUG_INFO_BTF=y
In-Reply-To: <VI1PR83MB02542417DBEF45BBA9C90FF7FB300@VI1PR83MB0254.EURPRD83.prod.outlook.com>
References: <VI1PR83MB02542417DBEF45BBA9C90FF7FB300@VI1PR83MB0254.EURPRD83.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 01 Oct 2020 12:33:18 +0200
Message-ID: <87h7rejkwh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kevin Sheldrake <Kevin.Sheldrake@microsoft.com> writes:

> Hello
>
> I've seen mention a few times that BTF information can be made
> available from a kernel that wasn't configured with
> CONFIG_DEBUG_INFO_BTF. Please can someone tell me if this is true and,
> if so, how I could go about accessing and using it in kernels 4.15 to
> 5.8?
>
> I have built the dwarves package from the github latest and run pahole
> with '-J' against my kernel image to no avail - it actually seg
> faults:
>
> ~/dwarves/build $ sudo ./pahole /boot/vmlinuz-5.3.0-1022-azure
> btf_elf__new: cannot get elf header.
> ctf__new: cannot get elf header.
> ~/dwarves/build $ sudo ./pahole -J /boot/vmlinuz-5.3.0-1022-azure
> btf_elf__new: cannot get elf header.
> ctf__new: cannot get elf header.
> Segmentation fault
> ~/dwarves/build $ sudo ./pahole --version
> v1.17
>
> Judging by the output, I'm guessing that my kernel image isn't the
> right kind of file. Can someone point me in the right direction?

vmlinuz is a compressed image. There's a script in the kernel source
tree (scripts/extract-vmlinux), however the kernel image in /boot/
probably also has debug information stripped from it, so that likely
won't help you. You'll need to get hold of a kernel image with debug
information still intact somehow...

(Either way, pahole shouldn't be segfaulting, so hopefully someone can
take a look at that).

-Toke

