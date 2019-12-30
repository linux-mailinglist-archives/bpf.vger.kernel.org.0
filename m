Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F90C12D3D1
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2019 20:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfL3TUn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Dec 2019 14:20:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33568 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfL3TUm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Dec 2019 14:20:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so25575185otp.0
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2019 11:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R2HUGNP1cgOAxLXKvlAf83qqvmp0LxZQcufLQgEdsSk=;
        b=PY5Y+hA+W0jSa/dQ/V6VYLCqV4AT5UTQYa/uE4RAwjVpydp7EBzIhqRGAY878mMDoN
         FHEaoDv3IAjYCnvd9HjkLIn3r6sFuOEkicnZT8ougvvck33aYYn/XTuQVKWU8PlFODAj
         3x4ttGGQfDQLwU/9UX1Ht2WkvfJSLQPfQYkRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R2HUGNP1cgOAxLXKvlAf83qqvmp0LxZQcufLQgEdsSk=;
        b=Qbos3mvKeOU6m/sw9M4QoBxCBZFteRHmldsAvHvl2DmLbHh6ywrcgPcpvVcAa5qw+l
         OMMz++P8ZKaEPlHnHynEMuMhlDnlKkvH1UcjQVFEQtK/TNUgBbV9d/l89pi9ivYBwSRL
         1XfOd+UtBgCAEViizF2EUdNpF7u5ESyn6S3jSeuXvQkTEyMl2jDECoQwP+ja8DGdU7vV
         jyvdvDou12CCEuZ0I+GH7NLIjaFRUf35VRqB80lO/UDpBD3UgdH8yQFJfOgdqp3wvMxu
         pjqMedp+MrhMLuDx4MK1pGAmMxEEhUuzOr5tOfIMpx41R4B9zo+h9imxPeB3hdlSL2F6
         Kqig==
X-Gm-Message-State: APjAAAV1GvbBFaS3HHMf0EhNwrRhOJTEc1wBKGLK/en3/uNQczZY7ItW
        WXFCwikbDSD/Y7Qasu1MFgtyUQ==
X-Google-Smtp-Source: APXvYqxU4Rafz9V1wbvaC2DEXCwxWLwK/+lXqX/YBMc6nhISNgTL6bIGnejZYe7KiLdWaMYtrkPCNw==
X-Received: by 2002:a05:6830:2116:: with SMTP id i22mr79234563otc.0.1577733642201;
        Mon, 30 Dec 2019 11:20:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u75sm9985380oie.15.2019.12.30.11.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:20:41 -0800 (PST)
Date:   Mon, 30 Dec 2019 11:20:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v1 06/13] bpf: lsm: Init Hooks and create files
 in securityfs
Message-ID: <201912301119.B475C474@keescook>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <20191220154208.15895-7-kpsingh@chromium.org>
 <CAEf4BzZ+wMTjghpr4=e5AY9xeFjvm-Rc+JooJzJstBW1r73z4A@mail.gmail.com>
 <20191230153711.GD70684@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230153711.GD70684@google.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 30, 2019 at 04:37:11PM +0100, KP Singh wrote:
> On 23-Dec 22:28, Andrii Nakryiko wrote:
> > On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
> > [...]
> 
> Good catch! You're right. These macros will not be there in v2 as
> we move to using trampolines based callbacks.

Speaking of which -- is the BPF trampoline code correctly designed to be
W^X?

-- 
Kees Cook
