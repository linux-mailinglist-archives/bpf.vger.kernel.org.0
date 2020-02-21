Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB2166C91
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 02:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgBUB6C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 20:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbgBUB6C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 20:58:02 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 976BE206E2
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2020 01:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582250281;
        bh=+a+P7zG2dI/H8lFNRwbsLewaAhEAsLbby1F+UEiCvsY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fk4AlIFGqdb8FyhvehuDkFi4QIp58QAMgeWJ3DoI5aRIsIZvw0M++05a6gyyf339Y
         toEEPteqaV+O2Rp9WkLt10d1a+zH0Gy8YRai5uQFprLvuJV0MUpEfuzN7RsB+fY1/0
         7rKm3gk7+hWZMEKPiSK7p5+/TOyYiQGVPvnTcLMc=
Received: by mail-lj1-f182.google.com with SMTP id d10so499622ljl.9
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2020 17:58:01 -0800 (PST)
X-Gm-Message-State: APjAAAXQ9WQniKzH8dErjwuM6qfDE5Q+aJGHT+XXwXP27UPsgzcHnp/G
        9YqEiEGmSkOrS2JZ9w1oBzLH4+ipztXLhv7hvmg=
X-Google-Smtp-Source: APXvYqwd+PT9BzSALP4kYb1K8pR8RFNSiJ79TdTEDriSsZECX/2/xLgBv6Uy3K/VIGL5Z+JCpKL5022sK8W3kcXqgZM=
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr19942745ljk.228.1582250279778;
 Thu, 20 Feb 2020 17:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20200221004354.930952-1-yhs@fb.com>
In-Reply-To: <20200221004354.930952-1-yhs@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 20 Feb 2020 17:57:48 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4dfdzRP90je854K4BXaTRs0--zF+38U+vBwv6fNKNWcw@mail.gmail.com>
Message-ID: <CAPhsuW4dfdzRP90je854K4BXaTRs0--zF+38U+vBwv6fNKNWcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: update bpf development Q/A file
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 20, 2020 at 4:44 PM Yonghong Song <yhs@fb.com> wrote:
>
> bpf now has its own mailing list bpf@vger.kernel.org.
> Update the bpf_devel_QA.rst file to reflect this.
>
> Also llvm has switch to github with llvm and clang
> in the same repo https://github.com/llvm/llvm-project.git.
> Update the QA file with newer build instructions.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
