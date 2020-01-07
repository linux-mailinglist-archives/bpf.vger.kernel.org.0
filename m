Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E2131D46
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2020 02:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgAGBgz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jan 2020 20:36:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45022 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgAGBgw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jan 2020 20:36:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id 195so26909724pfw.11
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2020 17:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=HWVPU6NTGp9nzRxw5BWJeatmP8pnvZxGmvGTyfzAkRc=;
        b=H/bxSDl9ArODmhysOekCr4511LlfvhHtaBDU8GIImpRdmsvDx40o7nMg/xP6prsIR3
         W3wfDDHw7bYbaNMyMAt/CZBXvSY1qUoH2OGKUMGcoGkZjTvK/Ss3sTUWmjPTx+xUnPcB
         /Ri5nVSIBJ4fQ8uFTyem8NfwiSa8/uBW6+OJbrR+gDUtYqvj2yLwQek6ho40oG80i7c3
         utvI49OLakatRGxFuN91PBHLPNGJO+b3PNIg2CMjCDaW5r58PLezOGoGIxRgPFxmOhIr
         jmlP+7U7gJwDrjgCWKNqBW3MxgSLx2NQth3QScpuYOm1wjI7LyouHYobvzIozvvpD+8X
         AyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HWVPU6NTGp9nzRxw5BWJeatmP8pnvZxGmvGTyfzAkRc=;
        b=uKy9vHVbNUxw+hVMLG1x3US3gd1Xk+wNuq4oLi1n4MESMloTx3l1jWUoBunis0P36N
         pb+36RLTRlK5DBU85JbhPJ1ZwzMcgidtOgky2Fva/2PpvWRAdWzATskFCu1CVGkB9ugw
         x8C7T0W+I1yfuw2CgLShf5zHkkujOJXeXBNq6eV9fNeP+7M4KW1ALVxUx5t00pzL2bJj
         EMBpIOqwnVyqtT+xuPi34mk/RgjZkabvCdIdCXfsx8gbjX7tezj6bR65CwxVN2F4tM0L
         FRTjy6j+D1D+UjyMdKdVyqp68fDmHgTEgr0xpzz7VGCeV26ufGZ2fgVxi5FyTgSucUMK
         s9Mg==
X-Gm-Message-State: APjAAAW+e9wb0mXIJ+xfYapLAAWO2baAWAREDIN+uS4vs6SB8UXfbwe2
        sQUyGp9RK1wX6mOubfI7yGEL1w==
X-Google-Smtp-Source: APXvYqwABUMpjwkXRj3CIQncBFYa4iBNoJvcnED7WOpDnd8SZzBtyrCvkbT8+x2IU2YDKmbRxbrMDw==
X-Received: by 2002:aa7:9218:: with SMTP id 24mr110748206pfo.145.1578361011553;
        Mon, 06 Jan 2020 17:36:51 -0800 (PST)
Received: from ?IPv6:2600:1013:b01b:fb95:11fc:e81d:31f1:7b96? ([2600:1013:b01b:fb95:11fc:e81d:31f1:7b96])
        by smtp.gmail.com with ESMTPSA id q12sm78770893pfh.158.2020.01.06.17.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 17:36:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH bpf-next] bpf: Make trampolines W^X
Date:   Mon, 6 Jan 2020 15:36:49 -1000
Message-Id: <DB882EE8-20B2-4631-A808-E5C968B24CEB@amacapital.net>
References: <21bf6bb46544eab79e792980f82520f8fbdae9b5.camel@intel.com>
Cc:     "kpsingh@chromium.org" <kpsingh@chromium.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "jannh@google.com" <jannh@google.com>,
        "mjg59@google.com" <mjg59@google.com>,
        "thgarnie@chromium.org" <thgarnie@chromium.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "revest@chromium.org" <revest@chromium.org>,
        "jackmanb@chromium.org" <jackmanb@chromium.org>,
        "kafai@fb.com" <kafai@fb.com>, "yhs@fb.com" <yhs@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "mhalcrow@google.com" <mhalcrow@google.com>,
        "andriin@fb.com" <andriin@fb.com>
In-Reply-To: <21bf6bb46544eab79e792980f82520f8fbdae9b5.camel@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Jan 6, 2020, at 12:25 PM, Edgecombe, Rick P <rick.p.edgecombe@intel.com=
> wrote:
>=20
> =EF=BB=BFOn Sat, 2020-01-04 at 09:49 +0900, Andy Lutomirski wrote:
>>>> On Jan 4, 2020, at 8:47 AM, KP Singh <kpsingh@chromium.org> wrote:
>>>=20
>>> =EF=BB=BFFrom: KP Singh <kpsingh@google.com>
>>>=20
>>> The image for the BPF trampolines is allocated with
>>> bpf_jit_alloc_exe_page which marks this allocated page executable. This
>>> means that the allocated memory is W and X at the same time making it
>>> susceptible to WX based attacks.
>>>=20
>>> Since the allocated memory is shared between two trampolines (the
>>> current and the next), 2 pages must be allocated to adhere to W^X and
>>> the following sequence is obeyed where trampolines are modified:
>>=20
>> Can we please do better rather than piling garbage on top of garbage?
>>=20
>>>=20
>>> - Mark memory as non executable (set_memory_nx). While module_alloc for
>>> x86 allocates the memory as PAGE_KERNEL and not PAGE_KERNEL_EXEC, not
>>> all implementations of module_alloc do so
>>=20
>> How about fixing this instead?
>>=20
>>> - Mark the memory as read/write (set_memory_rw)
>>=20
>> Probably harmless, but see above about fixing it.
>>=20
>>> - Modify the trampoline
>>=20
>> Seems reasonable. It=E2=80=99s worth noting that this whole approach is s=
uboptimal:
>> the =E2=80=9Cmodule=E2=80=9D allocator should really be returning a list o=
f pages to be
>> written (not at the final address!) with the actual executable mapping to=
 be
>> materialized later, but that=E2=80=99s a bigger project that you=E2=80=99=
re welcome to ignore
>> for now.  (Concretely, it should produce a vmap address with backing page=
s but
>> with the vmap alias either entirely unmapped or read-only. A subsequent h=
ealer
>> would, all at once, make the direct map pages RO or not-present and make t=
he
>> vmap alias RX.)
>>> - Mark the memory as read-only (set_memory_ro)
>>> - Mark the memory as executable (set_memory_x)
>>=20
>> No, thanks. There=E2=80=99s very little excuse for doing two IPI flushes w=
hen one
>> would suffice.
>>=20
>> As far as I know, all architectures can do this with a single flush witho=
ut
>> races  x86 certainly can. The module freeing code gets this sequence righ=
t.
>> Please reuse its mechanism or, if needed, export the relevant interfaces.=

>=20
> So if I understand this right, some trampolines have been added that are
> currently set as RWX at modification time AND left that way during runtime=
? The
> discussion on the order of set_memory_() calls in the commit message made m=
e
> think that this was just a modification time thing at first.

I=E2=80=99m not sure what the status quo is.

We really ought to have a genuinely good API for allocation and initializati=
on of text.  We can do so much better than set_memory_blahblah.

FWIW, I have some ideas about making kernel flushes cheaper. It=E2=80=99s cu=
rrently blocked on finding some time and on tglx=E2=80=99s irqtrace work.

>=20
> Also, is there a reason you couldn't use text_poke() to modify the trampol=
ine
> with a single flush?
>=20

Does text_poke to an IPI these days?=
