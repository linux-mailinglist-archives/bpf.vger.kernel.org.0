Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADB741B10F
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 15:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbhI1Nqg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 09:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233878AbhI1Nqf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 09:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632836695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1uDIYeK6IvFBGTTFBUuK5l1aEpXuys5Md5LPuKhoKjg=;
        b=KnNFdEVATzNzJJuOCUcACpwz9ntNZJ8XJB5P5al0H/xLXAF0ZSGZZDtKtZp8xIgCthMt1a
        JIjgTL5/ilsXjWTYreZr7K6SL+1NLrcVIwGpzVL8eW+dPZpWTQaWFZb3E4xu7rXeWtcUZO
        ZrbJJB4eCsemTxrRVV5EFerDY7ScaVg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-Okq4-cxXN9Gk9Hofk75Exw-1; Tue, 28 Sep 2021 09:44:54 -0400
X-MC-Unique: Okq4-cxXN9Gk9Hofk75Exw-1
Received: by mail-ed1-f72.google.com with SMTP id s18-20020a508d12000000b003da7a7161d5so6394932eds.8
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 06:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1uDIYeK6IvFBGTTFBUuK5l1aEpXuys5Md5LPuKhoKjg=;
        b=FBoPpZGmE1SnPZVDw2JtOsmX4c64C6bVKKO4U/YwGGCTpz6TqrwgWulmm4WOA0pVyX
         FjYDgdSsSQ/QikMYi0Sic/Qv9oBnzWIbsm8OfCiMw1Dzs2XaYw2vYW088jw6Vl6zysl9
         uVIZOPtyeOeHm4RFXXVuKmFVXDYa0guAeaokazNT2Erigv3d49vpUvDev9SFi0b7nhnW
         G3B0JF58JR9uTZdDCKo5ZbdMhPC03sGcDe+CZnWqtj/y0oiUkp5YspGjg8efDOUjblbO
         wYvFTF5dkEBcikiAHMiP+UvC7zKLmQR7hd2ezaxGLjf1xcF4B/EU9wcuDbfCzwZTLTBL
         2oNQ==
X-Gm-Message-State: AOAM532dc8slCAuhlACfh7UL6rtiugzGzydpjjbNt9qS8yYFYEMPz4v1
        nVu4y2G2GBGZfcjncwk8761RGVezoh9sYYa04Tl7LIy0UuT3VtXzvhDyeRYQNzQfW1UrkOQCpEC
        vXuCBWtaZ5PXn
X-Received: by 2002:a17:906:abcc:: with SMTP id kq12mr6760154ejb.107.1632836692403;
        Tue, 28 Sep 2021 06:44:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXqkRRZFHw+n6HoKSsUGXYApsiz4sOLe0LoHczA3PcnDKS1nIrFkKZ9PXo4zAyrhJVcBv9Hw==
X-Received: by 2002:a17:906:abcc:: with SMTP id kq12mr6760130ejb.107.1632836692163;
        Tue, 28 Sep 2021 06:44:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o15sm10531925ejj.10.2021.09.28.06.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:44:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E56FD18034A; Tue, 28 Sep 2021 15:44:49 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2] samples: bpf: Fix vmlinux.h generation for XDP
 samples
In-Reply-To: <20210928054608.1799021-1-memxor@gmail.com>
References: <20210928054608.1799021-1-memxor@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 28 Sep 2021 15:44:49 +0200
Message-ID: <874ka4ke5q.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Generate vmlinux.h only from the in-tree vmlinux, and remove enum
> declarations that would cause a build failure in case of version
> mismatches.
>
> There are now two options when building the samples:
> 1. Compile the kernel to use in-tree vmlinux for vmlinux.h
> 2. Override VMLINUX_BTF for samples using something like this:
>    make VMLINUX_BTF=3D/sys/kernel/btf/vmlinux -C samples/bpf
>
> This change was tested with relative builds, e.g. cases like:
>  * make O=3Dbuild -C samples/bpf
>  * make KBUILD_OUTPUT=3Dbuild -C samples/bpf
>  * make -C samples/bpf
>  * cd samples/bpf && make
>
> When a suitable VMLINUX_BTF is not found, the following message is
> printed:
> /home/kkd/src/linux/samples/bpf/Makefile:333: *** Cannot find a vmlinux
> for VMLINUX_BTF at any of "  ./vmlinux", build the kernel or set
> VMLINUX_BTF variable.  Stop.
>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Fixes: 384b6b3bbf0d (samples: bpf: Add vmlinux.h generation support)
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

