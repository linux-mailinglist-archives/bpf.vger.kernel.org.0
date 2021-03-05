Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0732DFC7
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 03:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCECvt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 21:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCECvt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 21:51:49 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD03C061574;
        Thu,  4 Mar 2021 18:51:49 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 18so1099147lff.6;
        Thu, 04 Mar 2021 18:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjnEJEa+vxW530VM5nSoy3SNP0gFstYX+DggD9FqR3o=;
        b=kDfjOvunn4rJQXXIqSvt66SJ6pJpenxqRA9js78/6lY1te5GR6SPpZqdZeKMLLpcOc
         oqv5Fgx94nU89+iQa8tUZx+kxiDqUze1cdHmzk10A1fkpTYMEzzo/o0FKh7YPgKtlbjJ
         a/EB0KR3iY6mx5s2mZReTZTKQYw2164tbmisH3uIRhayUvHWQfbqdf7IQ8CDypEVainy
         Xjdkc6WdpWsbxVkXgLWdwowPi29U0Ie2kUBcoeNJd/X5cnvIM4OMOIDDEJUFNsopDSlD
         OvTNDpEv4KfxRqrYgsFNykNsFuRn1FgH1G9f5VVKlj04KWr1fihj0yPc9dnoSUOB9ibp
         YfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjnEJEa+vxW530VM5nSoy3SNP0gFstYX+DggD9FqR3o=;
        b=B0TQfQlJQDX3dLLJcfkSfE0uuIe51JmJs/WrpUP5+9WSmiVC4Kglfr6NbeqBhOSbga
         5s+j0r2o9PgyGobDUdJkyW70/I+CtIpk19XHIyJxJtEjCxgFuao0R9d7aIaSIOu/e0HM
         19t3TCwaVf/Oasyx5BxKs2NhP5t/1RXbcaihHe0+whc79H8UROK7yiRjnu2cjkZL3/IR
         RXyajqoRHi2wc4WgsfLTcRsBsxjUZVDDCZGyT4jZ31s5yjCTb/0IloUfLAlJ4K5Z/J0B
         wMWEHOsr4vyLmy6vZ6Olq28fp9kfFPDgahUWibpkntyiYNIhAVAmxWoOEdPtLWn7BkqF
         4VJA==
X-Gm-Message-State: AOAM530acif8bVscC/Pp9p/VXhpHVQKeZ3iuz0iQiPTzZPYOtSu3paPW
        L+j4M0G83ZBtovoyRZkVQbbTVw8kY1axvqxiXNc=
X-Google-Smtp-Source: ABdhPJwN59ho3oOMO8l+pTawq54uy53wr2ypcPMOYjnAS0mF5vqsgRHCxVx+KY4dxOK+qHDWrlOR7g2wRv6VskGhD0I=
X-Received: by 2002:a19:48d2:: with SMTP id v201mr3951154lfa.504.1614912707769;
 Thu, 04 Mar 2021 18:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20210302171947.2268128-1-joe@cilium.io>
In-Reply-To: <20210302171947.2268128-1-joe@cilium.io>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 4 Mar 2021 18:51:36 -0800
Message-ID: <CAADnVQJzmymY6NDSwEp9NE6PNfoa8TGytoWqScSRQ3s5X+oDbw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 00/15] Improve BPF syscall command documentation
To:     Joe Stringer <joe@cilium.io>
Cc:     bpf <bpf@vger.kernel.org>, linux-man <linux-man@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Brian Vazquez <brianvv@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Mack <daniel@zonque.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Petar Penkov <ppenkov@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Sean Young <sean@mess.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 2, 2021 at 9:20 AM Joe Stringer <joe@cilium.io> wrote:
>
> Rather than tackle everything at once, I have focused in this series on
> the syscall commands, "enum bpf_cmd".
...
> The eventual goal of this effort would be to extend the kernel UAPI
> headers such that each of the categories I had listed above (commands,
> maps, progs, hooks) have dedicated documentation in the kernel tree, and
> that developers must update the comments in the headers to document the
> APIs prior to patch acceptance, and that we could auto-generate the
> latest version of the bpf(2) manual pages based on a few static
> description sections combined with the dynamically-generated output from
> the header.
> v2:
> * Remove build infrastructure in favor of kernel-doc directives
> * Shift userspace-api docs under Documentation/userspace-api/ebpf
> * Fix scripts/bpf_doc.py syscall --header (throw unsupported error)
> * Improve .gitignore handling of newly autogenerated files

Looks great. Applied. Thanks!
