Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E2E45FC58
	for <lists+bpf@lfdr.de>; Sat, 27 Nov 2021 04:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351627AbhK0D0C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 22:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhK0DYC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Nov 2021 22:24:02 -0500
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Nov 2021 18:11:42 PST
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DF8C08EB1E;
        Fri, 26 Nov 2021 18:11:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 26164CE21ED;
        Sat, 27 Nov 2021 02:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C1FC53FCD;
        Sat, 27 Nov 2021 02:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637978733;
        bh=4YiSAorf5qAH+UlLNY8UbMZaD2SA/pzWA0hjPnnjqvo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=liJKODFHBeeC/EN6c80lpFdDXtRy6zOgMqQhq+giq5uAwUi8Tr0GIUrlynyDb0DT0
         dTRPV2oRIoiniKGc7Fu4hKn5qKfso/bGiol2fqU6OCGgZNaWSS+gGiw8HstAbqGRwp
         W+j2Phk9idhksslpLfrwNuKNPiWsX7ydq7IQQaMwbwB6fGgGhsh/DyaVqEbbe+qrSN
         ssc8epoiVaZfAU3WUys2NXIJDPEoqhnh+l6s/g+rSHsTYetRootARLG1Esxfk+jdYH
         xbwrJVdA6CHHc1bcfcbLuGsn+XRDT6KBfYcGt3YUvEcHm/e908jRcgI5U2jKIXYRhp
         EuPWrEL4znweA==
Received: by mail-yb1-f181.google.com with SMTP id v138so24565941ybb.8;
        Fri, 26 Nov 2021 18:05:33 -0800 (PST)
X-Gm-Message-State: AOAM5329s+K1x8IyxXOIWoQeiRqzpHTbZJLdu2kIeIZ90omx5qDZxPk7
        T6L4vtWl/2LAeVM2B3UCEt9Q/d2rC/reTtb121Y=
X-Google-Smtp-Source: ABdhPJztzbw8hnomzFIS0CCsf3IrGX4M9KMZbZ3/960gU+gBiNhrdsLVMhangiRDNRgrWC5SfSxd4/e1pcB2fDH2G9E=
X-Received: by 2002:a25:af82:: with SMTP id g2mr20212763ybh.509.1637978732227;
 Fri, 26 Nov 2021 18:05:32 -0800 (PST)
MIME-Version: 1.0
References: <fb36291f5998c98faa1bd02ce282d940813c8efd.1637684071.git.dave@dtucker.co.uk>
 <9b20a6e558008b8d422db1008dd2b5c8ff18ce46.1637684071.git.dave@dtucker.co.uk>
In-Reply-To: <9b20a6e558008b8d422db1008dd2b5c8ff18ce46.1637684071.git.dave@dtucker.co.uk>
From:   Song Liu <song@kernel.org>
Date:   Fri, 26 Nov 2021 18:05:21 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7p4BaoYNRKxvCW7MumBbR7kiszu2auHHsAM1Bbct7RPQ@mail.gmail.com>
Message-ID: <CAPhsuW7p4BaoYNRKxvCW7MumBbR7kiszu2auHHsAM1Bbct7RPQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
To:     Dave Tucker <dave@dtucker.co.uk>
Cc:     bpf <bpf@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 8:24 AM Dave Tucker <dave@dtucker.co.uk> wrote:
>
> This commit adds documentation for the BPF_MAP_TYPE_ARRAY including
> kernel version introduced, usage and examples.
> It also documents BPF_MAP_TYPE_PERCPU_ARRAY since this is similar.
>
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>

It will be great to add an example with BPF_F_MMAPABLE, but I guess we can
do that in a follow up patch. So

Acked-by: Song Liu <songliubraving@fb.com>

With one nitpick.

[...]

> +
> +When calling ``bpf_map_update_elem()`` the flags ``BPF_NOEXIST`` can not be used for these maps.
> \ No newline at end of file

nit: Maybe add a newline at the end?

> --
> 2.33.1
>
