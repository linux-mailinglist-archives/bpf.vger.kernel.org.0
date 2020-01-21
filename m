Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9AA14489F
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 00:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgAUX6E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jan 2020 18:58:04 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:47063 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUX6E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jan 2020 18:58:04 -0500
Received: by mail-qv1-f48.google.com with SMTP id u1so2375363qvk.13
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2020 15:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8q1cpC8OvVYAAHN2yTqcM3sIr/3/d6R1L/2b874RO1I=;
        b=KDKFjycUIsLS0oCYRATtjq5mhrG7T2vegoZf1wHzeYCAoKvL/qiwgMZw9DG2VQWqz0
         /5IiYyTumdydggxRk0eyLEfXPrPVfHcSEBY00zPmmb90sv8gQtHyk0xISaxH17FI2fM8
         q3Xp5fBejKxF0noVjFuqsiXfrrXcLY8jIjaX+3/bNMTZ11b4AgF0HW+ZZ8rMBGBjl7X6
         Ne1fDEnsTzfLWEkik8NHwTdTBYEfnO5ys1SW4DrbTotBM7KyvnfDM74xKgOu8kmQrb1A
         IlW0iyJpR7OtB6s+F10oGMS9cxOA2Cxvmq/44fXLXvgaON6j404bdREcPkeJqyMkE71K
         zIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8q1cpC8OvVYAAHN2yTqcM3sIr/3/d6R1L/2b874RO1I=;
        b=fbvNgY/SCZdwk60U1zvAHny74zSwFrQhSseDjwDAV86wsFAC53S1wbsSkbfw2ClU+U
         zp7OiUu7uNSqPtI5sZiipbztjVnO4LZV2oHTW5Y1qJr6yqAHmrfiVFEl74Wul7EOhmAi
         YwhQdyGMJGXv9pl/mY2KXMskpykBnaPQTPD6jA6jU68OyrmdrIMHnoIyPJkISX/DM5gB
         tZjxnYL1/5ExPV9pBWOEV3XMLqtexD0YNLRmz1WrFJiorVu/x2KMv86D0qzsujE3nKSo
         3gZGOqJQFaN4SEAotL29yjSto4djaEcoEniy9KoiF+Iisj6EnsYt459DHlfGlAVf3b6l
         rgEg==
X-Gm-Message-State: APjAAAURRG1qj6NcNlO/pDifK3qxvVzfrovEAq9UYgAlkj4kfTSF4JNs
        EyweYrvZ4R38KIPmUy0VPZdEgl2uQ8QVQUTnYWVt58jQ
X-Google-Smtp-Source: APXvYqyA0Uq4wP6fchhoOHNnSCmr/b1X1iUiiGC0h8F/w3apUFQSD1upqOdWHTDt4UF7/KG/jEhU5tWULUnI0etEtPI=
X-Received: by 2002:ad4:4e34:: with SMTP id dm20mr7687712qvb.163.1579651083255;
 Tue, 21 Jan 2020 15:58:03 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzbWvCaAU5_t7k+fUiPyHgtxJnTfuC2QaAQCxf5YcZ8Bhw@mail.gmail.com>
In-Reply-To: <CAEf4BzbWvCaAU5_t7k+fUiPyHgtxJnTfuC2QaAQCxf5YcZ8Bhw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Jan 2020 15:57:52 -0800
Message-ID: <CAEf4BzbNqdfwPm2HhFjXBxCnQsw5E2JPR8vGL=SetXy4U_meyw@mail.gmail.com>
Subject: Re: Re-thinking BPF logging
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

forgot to add [LSF/MM/BPF TOPIC] prefix, sorry, will re-send.


On Tue, Jan 21, 2020 at 3:56 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Re-thinking BPF logging
> =======================
>
> BPF historically had a very restricted logging capabilities through
> bpf_printk macro. It's almost never used in production due to its
> limitations and because of how heavy-weight it is. BPF developers
> would just sprinkle few logging statements here and there while
> debugging issue, and will immediately remove them once they are done.
> But real-world production BPF applications need easy-to-use and
> flexible logging capabilities, both for debugging at scale in
> production, as well as for ad-hoc local development needs. Its hard to
> anticipate what needs to be logged in case of production issue, so
> logging has to be shipped with production version of BPF application,
> but enabled whenever issue arises. BPF needs to re-think its logging
> approach to satisfy real-world needs: zero-overhead when disabled,
> low-overhead and reliable while turned on. All this without
> sacrificing code clarity and developer productivity. We pose that with
> all the recent BPF advancements (BTF, global variables, BPF text
> poking, etc), it's now possible to have a qualitatively different
> logging capabilities in a modern BPF application.
>
> -- Andrii
