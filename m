Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7BB25424
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfEUPg6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 21 May 2019 11:36:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46856 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbfEUPg4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 11:36:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id m15so6965236ljg.13
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 08:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xHcmjVDAiLTnPECUNX89YGAM+as77xb3JfSt8ueMttg=;
        b=qQJU/K9lXOrTyPKKcEleajjwsVup2194XF6oEEP8ZLSNHQSTXrCEZmW+uWnwL3fbmo
         cqWZyfEPo60GryWffV5G4CP42WMxvy6pzHdi37fIb5Pf7emH1mCGvnc8zhrRItOTo7/e
         Tu94Tmgd9tbxtSg9qQqYVU7sy8i1xWOs0aXB9T3ymdWMpiJyv6gOIERkrz7/tOBngXOD
         qylhFuKq2CAUhKCMUuMj3qlmCJzX2K7Eo0GsLt6FEA1s5nBVLYc25Eu17LF+dYS60nmf
         0skzUsA8UxOiT7w1Du7gJmOdJCaQQ8tDHut2WxowuVkP8z3uIGmLNcch5l4G9vB4VcGb
         hW4A==
X-Gm-Message-State: APjAAAV3ENx2paYBEm0n0SnSWc3THK0g32Vpk+QPwLKHy4Q1sqXFFNOX
        GJx2xQ7zcWBRoIABV1fFwjT32BEvlw6my/jJHjMNvQ==
X-Google-Smtp-Source: APXvYqxId1+Y+bq1lPj/Yok6ty2jTLWDK5G0XffsUKbymfGbxMl73FDP+m7u8QVhacYIjtFI63q52PwI7BY03+/Ek5A=
X-Received: by 2002:a2e:8741:: with SMTP id q1mr19418098ljj.97.1558453013827;
 Tue, 21 May 2019 08:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190518004639.20648-1-mcroce@redhat.com> <CAGnkfhxt=nq-JV+D5Rrquvn8BVOjHswEJmuVVZE78p9HvAg9qQ@mail.gmail.com>
 <20190520133830.1ac11fc8@cakuba.netronome.com> <dfb6cf40-81f4-237e-9a43-646077e020f7@iogearbox.net>
In-Reply-To: <dfb6cf40-81f4-237e-9a43-646077e020f7@iogearbox.net>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 21 May 2019 17:36:17 +0200
Message-ID: <CAGnkfhxZPXUvBemRxAFfoq+y-UmtdQH=dvnyeLBJQo43U2=sTg@mail.gmail.com>
Subject: Re: [PATCH 1/5] samples/bpf: fix test_lru_dist build
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 21, 2019 at 5:21 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 05/20/2019 10:38 PM, Jakub Kicinski wrote:
> > On Mon, 20 May 2019 19:46:27 +0200, Matteo Croce wrote:
> >> On Sat, May 18, 2019 at 2:46 AM Matteo Croce <mcroce@redhat.com> wrote:
> >>>
> >>> Fix the following error by removing a duplicate struct definition:
> >>
> >> Hi all,
> >>
> >> I forget to send a cover letter for this series, but basically what I
> >> wanted to say is that while patches 1-3 are very straightforward,
> >> patches 4-5 are a bit rough and I accept suggstions to make a cleaner
> >> work.
> >
> > samples depend on headers being locally installed:
> >
> > make headers_install
> >
> > Are you intending to change that?
>
> +1, Matteo, could you elaborate?
>
> On latest bpf tree, everything compiles just fine:
>
> [root@linux bpf]# make headers_install
> [root@linux bpf]# make -C samples/bpf/
> make: Entering directory '/home/darkstar/trees/bpf/samples/bpf'
> make -C ../../ /home/darkstar/trees/bpf/samples/bpf/ BPF_SAMPLES_PATH=/home/darkstar/trees/bpf/samples/bpf
> make[1]: Entering directory '/home/darkstar/trees/bpf'
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
> make -C /home/darkstar/trees/bpf/samples/bpf/../../tools/lib/bpf/ RM='rm -rf' LDFLAGS= srctree=/home/darkstar/trees/bpf/samples/bpf/../../ O=
>   HOSTCC  /home/darkstar/trees/bpf/samples/bpf/test_lru_dist
>   HOSTCC  /home/darkstar/trees/bpf/samples/bpf/sock_example
>

Hi all,

I have kernel-headers installed from master, but yet the samples fail to build:

matteo@turbo:~/src/linux/samples/bpf$ rpm -q kernel-headers
kernel-headers-5.2.0_rc1-38.x86_64

matteo@turbo:~/src/linux/samples/bpf$ git describe HEAD
v5.2-rc1-97-g5bdd9ad875b6

matteo@turbo:~/src/linux/samples/bpf$ make
make -C ../../ /home/matteo/src/linux/samples/bpf/
BPF_SAMPLES_PATH=/home/matteo/src/linux/samples/bpf
make[1]: Entering directory '/home/matteo/src/linux'
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
make -C /home/matteo/src/linux/samples/bpf/../../tools/lib/bpf/ RM='rm
-rf' LDFLAGS= srctree=/home/matteo/src/linux/samples/bpf/../../ O=
  HOSTCC  /home/matteo/src/linux/samples/bpf/test_lru_dist
/home/matteo/src/linux/samples/bpf/test_lru_dist.c:39:8: error:
redefinition of ‘struct list_head’
   39 | struct list_head {
      |        ^~~~~~~~~
In file included from /home/matteo/src/linux/samples/bpf/test_lru_dist.c:9:
./tools/include/linux/types.h:69:8: note: originally defined here
   69 | struct list_head {
      |        ^~~~~~~~~
make[2]: *** [scripts/Makefile.host:90:
/home/matteo/src/linux/samples/bpf/test_lru_dist] Error 1
make[1]: *** [Makefile:1762: /home/matteo/src/linux/samples/bpf/] Error 2
make[1]: Leaving directory '/home/matteo/src/linux'
make: *** [Makefile:231: all] Error 2

Am I missing something obvious?


Regards,


--
Matteo Croce
per aspera ad upstream
