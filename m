Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F882F6E17
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 23:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbhANWWS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 17:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730208AbhANWWQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 17:22:16 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBB4C061575
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 14:21:36 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q1so14415836ion.8
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 14:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=bdfuv3uxXwvDJxJbU9ckCj7K5u9W9WbAQASu0As3A2M=;
        b=mXCeAv9QKL/0YGSCPu3CEdSoWVdWiq2l9vHCW97o9uKuzP/M3Zpvv2NU+SCS7DLUCv
         EbiVxV/aixDph3SptVej685xLRiw/k78ZfysRAoci63VLsGPy/JO2sRdTWvoGEWiRXxy
         1asJJo+3V/pN04NCau01f9HHClIQShMsvtm96LHZgQT5M45bDmuG01DB9S8A89ViCfSd
         uf5XSlmmlW/I+IiX94Cjp2XPYG1S2SBz0U1Ws/YG3q4P1lh3uZkY5bzeBBBLl+rfgyTI
         H3/c5FQRQgVB4VBpaQjz6LS1uhQyGetF18ZDfYtG6UVgv/HV/5JtuFubTZzFgIG0uo76
         CXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=bdfuv3uxXwvDJxJbU9ckCj7K5u9W9WbAQASu0As3A2M=;
        b=D3XY+pvXMmK+VYD94zQXECEW2uBx0PLEyPyZaI7f4swl6L+s+K6CwU/DWe61rLu55J
         pvtK+qZz71M0BVCZo0KLAO1Bf73nR4rDa2Ma9bqpjEr8I0x5JwoRm4c59VjCHEKazx9k
         Yqn+t6bcYArBfPVIDv5WNicZIDcBJVOvskn3VqlGLQQs7otiMTtAKoVAKaDFmU7i7enw
         l5lW3qfUb0oVTsmfVAOVdZUzyrEPhKTmlj5WAJZ7KHw7B1JBUkoZkyYQBE6crEskS97k
         8qg616xC+HwLrRxk95u7lce6LItaWo7ZEi4Yy64p9bnTTQe+Wx09LwrA4I8xSpAu5m/4
         e6gg==
X-Gm-Message-State: AOAM531KPd076/NUPpkReOD3F7EmP39pGX7sIhfvwg7oYDjuMm1dKIqp
        2r8mcqm98twzQDyzCk+N2esfEoN3fCPv3wB79NQ=
X-Google-Smtp-Source: ABdhPJy3tEvjRaSv0psGlD0AeT6FpgHorwa4YcZQvEFjv7OWx8oJanmuLY8VJAIddDRMqW83WVlvOe1QBKEuDoj3t7o=
X-Received: by 2002:a5e:9b06:: with SMTP id j6mr6703570iok.171.1610662895325;
 Thu, 14 Jan 2021 14:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-3-ndesaulniers@google.com> <CA+icZUVa5rNpXxS7pRsmj-Ys4YpwCxiPKfjc0Cqtg=1GDYR8-w@mail.gmail.com>
 <CA+icZUW6h4EkOYtEtYy=kUGnyA4RxKKMuX-20p96r9RsFV4LdQ@mail.gmail.com>
 <CABtf2+RdH0dh3NyARWSOzig8euHK33h+0jL1zsey9V1HjjzB9w@mail.gmail.com>
 <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
 <CAKwvOd=+g88AEDO9JRrV-gwggsqx5p-Ckiqon3=XLcx8L-XaKg@mail.gmail.com>
 <CAKwvOdnSx+8snm+q=eNMT4A-VFFnwPYxM=uunRkXdzX-AG4s0A@mail.gmail.com>
 <5707cd3c-03f2-a806-c087-075d4f207bee@fb.com> <CA+icZUXuzJ4SL=AwTaVq_-tCPnSSrF+w_P8gEKYnT56Ln0Zoew@mail.gmail.com>
 <CA+icZUXQ5bNX0eX7jEhgTMawdctZ4vkmYoRKDgxEMV5ZKp8YaQ@mail.gmail.com> <CAKwvOdn98zvjGaEy0O7uCb9AUZdZANCeSYpdti3U3uj4+V4dyQ@mail.gmail.com>
In-Reply-To: <CAKwvOdn98zvjGaEy0O7uCb9AUZdZANCeSYpdti3U3uj4+V4dyQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 23:21:23 +0100
Message-ID: <CA+icZUUMPwUF7wHir1rqNTGdQEgR1Fo5j646BunhEB6D3aFXsA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Kbuild: DWARF v5 support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yonghong Song <yhs@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Caroline Tice <cmtice@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nick Clifton <nickc@redhat.com>, bpf <bpf@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000bafb9905b8e3ad30"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--000000000000bafb9905b8e3ad30
Content-Type: text/plain; charset="UTF-8"

On Thu, Jan 14, 2021 at 11:05 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jan 14, 2021 at 1:52 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > Today, I have observed and reported (see [1]) bpf/btf/pahole issues
> > with Clang v12 (from apt.llvm.org) and DWARF-4 ("four").
> > Cannot speak for other compilers and its version.
>
> If these are not specific to DWARF5, then it sounds like
> CONFIG_DEBUG_INFO_DWARF4 should also be marked as `depends on
> !DEBUG_INFO_BTF`? (or !BTF && CC=clang)
>

My experiments yesterday on Wednesday were with GCC v10.2.1 plus LLVM=1.
There were no issues with DWARF v2 and v4 but v5.

Unfortunately, build-time is long here on my systems.

For now, I did CONFIG_DEBUG_INFO_BTF=n.

I have applied attached patch.

Is it possible to re-arrange CC depends?

[ /lib/Kconfig.debug ]

config DEBUG_INFO_DWARF5
       bool "Generate DWARF Version 5 debuginfo"
-       depends on GCC_VERSION >= 50000 || CC_IS_CLANG
-       depends on CC_IS_GCC ||
$(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC)
$(CLANG_FLAGS))
+      depends on CC_IS_GCC && GCC_VERSION >= 50000 || CC_IS_CLANG
+      depends on $(success,$(srctree)/scripts/test_dwarf5_support.sh
$(CC) $(CLANG_FLAGS))
+       depends on !DEBUG_INFO_BTF
       help
         Generate DWARF v5 debug info. Requires binutils 2.35, gcc 5.0+ (gcc
         5.0+ accepts the -gdwarf-5 flag but only had partial support for some

And adding text to help concerning DEBUG_INFO_BTF is no good these days.

BTW, if you do not mind:

Label your patches with "*k*build:" not "*K*build:".

Use "DWARF *v*ersion" not "DWARF *V*ersion" - everywhere.

One patch missed the label "kbuild:" (guess the subject has too many
characters).

From what I remember - but these are small nits.

Thanks for DWARF v5 support in Linux.

- Sedat -

> >
> > - Sedat -
> >
> > [1] https://lore.kernel.org/bpf/CA+icZUWb3OyaSQAso8LhsRifZnpxAfDtuRwgB786qEJ3GQ+kRw@mail.gmail.com/T/#m6d05cc6c634e9cee89060b2522abc78c3705ea4c
> --
> Thanks,
> ~Nick Desaulniers

--000000000000bafb9905b8e3ad30
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-kbuild-dwarf-5-Do-not-depend-on-CONFIG_DEBUG_INFO_BT.patch"
Content-Disposition: attachment; 
	filename="0001-kbuild-dwarf-5-Do-not-depend-on-CONFIG_DEBUG_INFO_BT.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kjxeqgmr0>
X-Attachment-Id: f_kjxeqgmr0

RnJvbSA3ZjcxYjQ4YThhMzAwNzdlMzg1ZjAwNjE0YWY1MTU4NzMyMDkyYjkwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDE0IEphbiAyMDIxIDIxOjU0OjM2ICswMTAwClN1YmplY3Q6IFtQQVRDSF0ga2J1
aWxkOiBkd2FyZi01OiBEbyBub3QgZGVwZW5kIG9uIENPTkZJR19ERUJVR19JTkZPX0JURgoKLS0t
CiBsaWIvS2NvbmZpZy5kZWJ1ZyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
CgpkaWZmIC0tZ2l0IGEvbGliL0tjb25maWcuZGVidWcgYi9saWIvS2NvbmZpZy5kZWJ1ZwppbmRl
eCBlZGE3NmFmNDMyOGUuLjFkNmE1MjZiNjM0NCAxMDA2NDQKLS0tIGEvbGliL0tjb25maWcuZGVi
dWcKKysrIGIvbGliL0tjb25maWcuZGVidWcKQEAgLTI3Nyw2ICsyNzcsNyBAQCBjb25maWcgREVC
VUdfSU5GT19EV0FSRjUKIAlib29sICJHZW5lcmF0ZSBEV0FSRiBWZXJzaW9uIDUgZGVidWdpbmZv
IgogCWRlcGVuZHMgb24gR0NDX1ZFUlNJT04gPj0gNTAwMDAgfHwgQ0NfSVNfQ0xBTkcKIAlkZXBl
bmRzIG9uIENDX0lTX0dDQyB8fCAkKHN1Y2Nlc3MsJChzcmN0cmVlKS9zY3JpcHRzL3Rlc3RfZHdh
cmY1X3N1cHBvcnQuc2ggJChDQykgJChDTEFOR19GTEFHUykpCisJZGVwZW5kcyBvbiAhREVCVUdf
SU5GT19CVEYKIAloZWxwCiAJICBHZW5lcmF0ZSBEV0FSRiB2NSBkZWJ1ZyBpbmZvLiBSZXF1aXJl
cyBiaW51dGlscyAyLjM1LCBnY2MgNS4wKyAoZ2NjCiAJICA1LjArIGFjY2VwdHMgdGhlIC1nZHdh
cmYtNSBmbGFnIGJ1dCBvbmx5IGhhZCBwYXJ0aWFsIHN1cHBvcnQgZm9yIHNvbWUKLS0gCjIuMzAu
MAoK
--000000000000bafb9905b8e3ad30--
