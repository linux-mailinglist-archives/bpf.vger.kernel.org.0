Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4856A4415
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 15:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjB0ORk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 09:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjB0ORj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 09:17:39 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9426E15C9A
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 06:17:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so7271622wmb.3
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 06:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677507457;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BujO2i2Pqqby7/8pr3HhgIZOLeKrhps5GyORQP6iuOU=;
        b=lwuTNsNTNgapjpGQvt5tG2ws/Z2Yjqt2IvF5mM1gl7xNcf4ToCY2r7V6Y9L0IVJqn8
         bNYHmLi1GZXOLs7k4mHzItpqN6liwwWv/pMkPFKWyI/KHswQvpY2eBubP2PfSZ/o31RN
         eMJ0OxIcyPDmf+zBdUw31rLPg6Wf8ft+IOVWRZcu1cGtbQ5Uc5YT3E/9ESgNzThp/Xdv
         9K0/mso1ngh9x35qk0eGUHfyt516ubcSmPSIpXp2luhT/Z1f9ZuY2+cKu6O02ArQjGl7
         ci+vxV1i97qAI76mEhs9c8nQ6QWkFeW4ISJWEfGU3RtXEunpJ+k73nE39QLpWhWi0wO+
         WIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677507457;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BujO2i2Pqqby7/8pr3HhgIZOLeKrhps5GyORQP6iuOU=;
        b=lRliXm+0fy6RfqO6mFbVUpEO4b42FJYkIE2VTtFtZRppnW+4fDG0LNY2WjtGuidAzX
         uQFFoqU9e0HG3fTz64wAlkbXCcgevpXE77t6wPTFk/2zqRVqd7Tb9M8gwSufQTOswpV5
         tvlOc+uZokbgIwHYD8ekCU+yW1tL+5Rwq9WGSBpoSTdrn150T/65cRstxodM8qzn521v
         XDFnpNMvLl7xuO/Bzw3I1GYbgc3cP2js5T13UDQ8+HpKR32k8yIfx1ZvXz1uZqvZ1KyY
         6/12NwpIYhiPcIsK871e4ZggwxTQo9IiiqgLKDB+L5MEU7FXJVP5ViUxWdN+dbJYyXm2
         jFIA==
X-Gm-Message-State: AO0yUKVKYejxW124rpU4Sdjr/Wx59hG8yEnlze/HRb6pXF9Jabi80iEN
        qTqvboQpPe/28jMNk0Rz59eZYLsDsACPnw==
X-Google-Smtp-Source: AK7set/MJYIF7lrSkVSjq6ItzGuS2qbVgizQzakX5y50ErGZ9SRB2uxespBpWPghjf7Bo9s6CA6ApQ==
X-Received: by 2002:a05:600c:43d4:b0:3e2:1d1e:78d6 with SMTP id f20-20020a05600c43d400b003e21d1e78d6mr15336795wmn.7.1677507456855;
        Mon, 27 Feb 2023 06:17:36 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p13-20020a1c544d000000b003e208cec49bsm19305422wmi.3.2023.02.27.06.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 06:17:36 -0800 (PST)
Message-ID: <693dffd9571073a47820653fd2de863010491454.camel@gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Matt Bobrowski <mattbobrowski@google.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, acme@redhat.com
Date:   Mon, 27 Feb 2023 16:17:35 +0200
In-Reply-To: <c4cda35711804ec26ebaeedc07d10d5d51901495.camel@gmail.com>
References: <Y/P1yxAuV6Wj3A0K@google.com>
         <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
         <Y/czygarUnMnDF9m@google.com>
         <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
         <Y/hLsgSO3B+2g9iF@google.com>
         <8f8f9d43d2f3f6d19c477c28d05527250cc6213d.camel@gmail.com>
         <Y/p0ryf5PcKIs7uj@google.com>
         <c4cda35711804ec26ebaeedc07d10d5d51901495.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2023-02-26 at 03:03 +0200, Eduard Zingerman wrote:
> On Sat, 2023-02-25 at 20:50 +0000, Matt Bobrowski wrote:
> > Sorry Eduard, I replied late last night although the email bounced due
> > to exceeding the mail char limit. Let's try attaching a compressed
> > variant of the requested files, which includes the compiled kernel's
> > BTF and the kernel's config.
>=20
> Hi Matt,
>=20
> I tried using your config but still can't reproduce the issue.
> Will try to do it using debian 12 chroot tomorrow or on Monday.

Hi Matt,

Short update:
I've reproduced the issue with multiple STRUCT 'linux_binprm' BTF IDs
in Debian testing chroot, thank you for providing all details.
Attaching the instructions in the end of the email.
Need some time to analyze pahole behavior.

Thanks,
Eduard

--

host root:
  mkdir bookworm
  sudo debootstrap testing bookworm/ http://deb.debian.org/debian/
  sudo mount -t proc proc bookworm/proc/
  sudo mount -t sysfs sys bookworm/sys/
  sudo chroot bookworm/ /bin/bash

bookworm root:
  apt install python3 bc build-essential git \
    cmake libdwarf-dev libdw-dev flex bison \
    kmod cpio libncurses5-dev libelf-dev libssl-dev
  adduser eddy
  sudo eddy

bookworm user:
  cd ~
  git clone git://git.kernel.org/pub/scm/devel/pahole/pahole.git
  mkdir build && \
    cd build && \
    cmake -D__LIB=3Dlib .. && \
    make -j $(nproc)
  export PATH=3D/home/eddy/pahole/build/:$PATH
  cd ~
  git clone https://github.com/torvalds/linux.git && cd linux
  make defconfig && make kvm_guest.config
  scripts/config \
   -e BPF \
   -e BPF_SYSCALL \
   -e BPF_LSM \
   -e BPF_JIT \
   -e BPF_EVENTS \
   -e DEBUG_INFO \
   -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
   -e DEBUG_INFO_BTF \
   -e DEBUG_INFO_BTF_MODULES \
   -e PAHOLE_HAS_SPLIT_BTF \
   -e FTRACE \
   -e DYNAMIC_FTRACE \
   -e FUNCTION_TRACER
  make olddefconfig
  # Multiple warnings in the end:
  #   WARN: multiple IDs found for 'task_struct': 176, 23383 - using 176
  #   WARN: multiple IDs found for 'file': 638, 23422 - using 638
  #   ...
 =20
  make -C ./tools/bpf/bpftool
  ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux | \
    grep -c linux_binprm
  # The output is 19 for me

Repository versions:
  - kernel:
    f3a2439f20d9 ("Merge tag 'rproc-v6.3' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/remoteproc/linux")
  - pahole:
    431df45 ("btfdiff: Exclude Rust CUs since those are not yet being conve=
rted to BTF on the Linux kernel")
