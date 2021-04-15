Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2F836011A
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 06:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhDOE2g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 00:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhDOE2g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 00:28:36 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13437C061574
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 21:28:12 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id n12so24657574ybf.8
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 21:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tilogIfXr99bL0Wh7jt0Z2EUNC50zrzFhk0YzZ5FE/Q=;
        b=GRfbFVb5PUE6EMZ0POGAB38jrfpo0d3XTcUKCTX54zo6nhJ6e8iDNr7SGmy8FSP5Oh
         LUdqFkY6/+GJPgxZ+T7cT63lhkkUW5sxukOxIW+d+o4jN2Apxf9LKiiq7We7YMWMDTu8
         RQgTvtesFCpfawBucp8TEYOW1lgH6NNbQzlmDSmNy1H0+Phhd+dsJ6Wq6BK84p1Suoro
         M2SH/74QctkW2rKj2HgqoLLyt5rur85rcDHKSycmenK+P/JFVubiZsWgSSXAehHjVn1J
         3Vw6VHNPgNTTHHDPfP1mFjoahnpOyTJRxqtsLcn8biZ+pKLi4QNuh+1A3ykxvqr0Kjbr
         SkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tilogIfXr99bL0Wh7jt0Z2EUNC50zrzFhk0YzZ5FE/Q=;
        b=r0QQLaEpWckgdnWy3jbZTXih3SLflQ4giw5iXFFMTSLMQwJAbvnP0+OxraufQR1Tea
         +ReG/mnc0e+C37dzc6GFiItxNMteK5kAOoD5Up0r8HycGF2/qPjC4MvWpB7rfcpo4k0X
         kk7yKK/dURMRV0ETSRjAugkH+XaBlBRmH9R83GozkiXOM+Z7UDrxH09D+LpfvKHYi9OX
         3ODRlCXMawvO/o2x7iHevdPi1FWsZqSZOhF2PKCt9JDa8wiE66cQKIOuHz4pSGQqEdNR
         luJyk4OWlSH/fNjewl2LNMIeOhN3cwFqBmc7Q0GLc5bHUXtWEMsDgIVKGVKmVZyoH5Fp
         ooNw==
X-Gm-Message-State: AOAM532oZM4pq2LUnNxM0Lf9cJgiVKNeRW4hp5Ox3FXjUMVa0eQUTcbw
        fhzFfXbxsxrMFZkRhcidWZGU+GRY4vOCclsYvoLQ4vBPU28=
X-Google-Smtp-Source: ABdhPJxINy9CLmShBSuIzjGlm3yOG6GPHmME+M+ECZTwdIz3FnefW/i43+H0mu/Zmt+Y4YxHW68mkFGfYlaylu9qRFo=
X-Received: by 2002:a25:3357:: with SMTP id z84mr1886278ybz.260.1618460891273;
 Wed, 14 Apr 2021 21:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oVyB2b+Y6K3--sAhTcXfmPpmPjLhA0z7bbjyjhzDV8kcA@mail.gmail.com>
In-Reply-To: <CAO658oVyB2b+Y6K3--sAhTcXfmPpmPjLhA0z7bbjyjhzDV8kcA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Apr 2021 21:27:54 -0700
Message-ID: <CAEf4BzZ2Piu5kkpp6PmHUFryGOo7P=jjNk7DkUVg6kJUBaHs8g@mail.gmail.com>
Subject: Re: Access to rodata when using libbpf directly
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 7:26 PM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> As I understand it, accessing and setting read only global variables
> from a userspace control program through libbpf can only happen when
> importing a BPF skeleton. Things like `bpf_object__find_map_by_name()`
> are exposed but the name of this map is internal and
> `internal_map_name()` is as well. Traversing through the maps array
> via bpf_object directly doesn't seem possible either.

Not really.

See bpf_object__for_each_map() macro and bpf_map__is_internal() API,
both of which are public. As for the name, it's also sort of part of
API, though I want to fix them in libbpf 1.0 (they should be named
.rodata, .data, .bss). So you can definitely either find the map with
iteration or by knowing how the name is generated. Then do mmap() and
using BTF you'll know each variable's offset and size. No magic, just
some code to do this, which is what is done by bpftool for skeletons
(bpftool is a completely external user of libbpf in this case, no
private APIs are involved).

>
> Why is this feature only available through generating a skeleton?
> Should there be differences in supported functionality between using a
> skeleton and using libbpf directly?
