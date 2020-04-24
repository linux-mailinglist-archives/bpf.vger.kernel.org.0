Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2E51B7D88
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgDXSHx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgDXSHw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Apr 2020 14:07:52 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E8C09B048;
        Fri, 24 Apr 2020 11:07:52 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n143so11105306qkn.8;
        Fri, 24 Apr 2020 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihmRwl/qrS41lvTlnNKxmyiIPWALoPPs8H/T7cn45Oo=;
        b=GD74kfkAj+hnKAjI7UvXOmaFkH21MYMSBTiIEFv5H8StKlGvXVofbMDioO1bOfFIux
         5oQ/nBluOyfz6hHgf7P+buBGl/D/ihmQOfpSb2JHGVzSC/CRLRfIR9YtLF7khBfKJReh
         cX8C+HeSQ19t7NnKo7EiE5kvOZHsWix1znk5EI2whUDdNH3eatVDaymxM3cv+trernCa
         Ax+Qk7vh/+6DQV2IbkKjSx0KMehfA1khkBWLYEmRUPmRvchmrTKKsOh/ey5DlJc4thTB
         VGrIc+Ur1Fw+fDq5pUCY4++zBy3gp4K6FxJ3n97a1EHzLmbfrKpR7TRK00c7lAgJpJAI
         A7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihmRwl/qrS41lvTlnNKxmyiIPWALoPPs8H/T7cn45Oo=;
        b=AkFwKwQ9H5naaLlxSgipKpus3eiLZv5plGfjEuuXC+KZy8Rr6b5nPWjECXtKRYwzb8
         EdwBRUSV6Q/bkFq1B/1Am2bIuTRqEPswO+dztI2N0f8zf51KS2O/2MbO8u/PrmIM2K1i
         ZgBuKuriqqhviJ1bqH7RWfqZqG5S7wvUyQUsiW2KB4gevarZKdvXMy8C8kP6ZzOnRz6A
         CHy0Tfk7x0SRGpjxGQh4XmRIo/PIe0fsLxyu0tP2IEXqQYxRtxYH+ReYPe3BIE5vgg9B
         N7WNli33QmPssUcsLJf5GQe+ACxF5YrOJc31+E1wZTOBMXD+Ur8kADxQkDuobUCeinG+
         M92w==
X-Gm-Message-State: AGi0PuZ+jUE6KxnLEhnh6Li3yCGPtwYBR0PMOQBNvDp+ckSAf5PGX6qQ
        CBswuJ1XdmTouNVLzAnq248qedKlbcLxlP5aDlI=
X-Google-Smtp-Source: APiQypLnkwcJr9Jm0u16a6X8JqgYqTsJKqMuB508Zc9M4x6bHiVtF1kIsxCSeNfj56o+86Hja/tnzrqgWed9Uy+GgBI=
X-Received: by 2002:ae9:e10b:: with SMTP id g11mr10875912qkm.449.1587751671716;
 Fri, 24 Apr 2020 11:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200424174805.28b8d463@canb.auug.org.au> <f11ce3ab-9ede-6241-d648-1a2b34e1ea4b@infradead.org>
In-Reply-To: <f11ce3ab-9ede-6241-d648-1a2b34e1ea4b@infradead.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Apr 2020 11:07:40 -0700
Message-ID: <CAEf4BzaEjNKU0rV-im2aU1j0xrdYZhC61OLnu31iWy8G4S+yew@mail.gmail.com>
Subject: Re: linux-next: Tree for Apr 24 (kernel/bpf/cgroup.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 24, 2020 at 8:30 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 4/24/20 12:48 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20200423:
> >
>
> on i386:
>
> ld: kernel/bpf/cgroup.o: in function `cgroup_base_func_proto.isra.11':
> cgroup.c:(.text+0x14a1): undefined reference to `bpf_event_output_data_proto'
> ld: cgroup.c:(.text+0x14c1): undefined reference to `bpf_base_func_proto'
>

Stanislav, could you please take a look?

> Full randconfig file is attached.
>
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
