Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED543C932
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhJ0MH6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 08:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241747AbhJ0MH5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 08:07:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05B7960F70;
        Wed, 27 Oct 2021 12:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635336331;
        bh=2Lbg+DYX1Z5W0MhjQK8z0VSDJIVb3tjppXqApAeaISc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svwhNfD9vhXraPhqoqWl/YuHmXQ4Tt784tt9waR5iQ5XPwSzTx8ow4xrkUKMYVJFB
         8Mbjz+PWOxKIY11+eSz7d5bxEpMdW7t0Z42xpdoCWbfZN4JYWPn1AdqYJ6zOTWsJL1
         dhwKbtdh8097642NiJ9izrX7tjbPLkvB/yWj0nuQMCVMC4eZ/oF0P+rOgf/v9Kdsjo
         RmqtN5o8z/anXoVji/3LdhIbvQvJs3HjOv0WJhcs+YwKFsiCFyiMMgbQUSWoZr3pOF
         bX3Lwl1rbf+Mo4M5BZcvRojEjiVxotfbYkFq45Kq/h1LJAOCvxrm5LlSBzvV9/yH3t
         W40Bg9tLSm7nw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F50D410A1; Wed, 27 Oct 2021 09:05:27 -0300 (-03)
Date:   Wed, 27 Oct 2021 09:05:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH dwarves] btf: rename btf_tag to btf_decl_tag
Message-ID: <YXlAh58JivlWyEqF@kernel.org>
References: <20211025230220.3250968-1-yhs@fb.com>
 <CAEf4BzZ9povWyXYnx0_ud8chXobB3_wga+cWoi0gX8EoLO=gLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ9povWyXYnx0_ud8chXobB3_wga+cWoi0gX8EoLO=gLA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Oct 25, 2021 at 05:20:49PM -0700, Andrii Nakryiko escreveu:
> On Mon, Oct 25, 2021 at 4:02 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > Kernel commit ([1]) renamed btf_tag to btf_decl_tag
> > for uapi btf.h and libbpf api's. The reason is a new
> > clang attribute, btf_type_tag, is introduced ([2]).
> > Renaming btf_tag to btf_decl_tag makes it easier to
> > distinghish from btf_type_tag.
> >
> > I also pulled in latest libbpf repo since it
> > contains renamed libbpf api function btf__add_decl_tag().
> >
> >   [1] https://lore.kernel.org/bpf/20211012164838.3345699-1-yhs@fb.com/
> >   [2] https://reviews.llvm.org/D111199
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> 
> LGTM.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks, applied. Made a few adjustments as there were changes touching
the pahole options in my local tree, very minor stuff.

- Arnaldo

 
> >  btf_encoder.c  | 16 ++++++++--------
> >  dwarf_loader.c |  6 +++---
> >  dwarves.h      |  2 +-
> >  lib/bpf        |  2 +-
> >  pahole.c       | 12 ++++++------
> >  5 files changed, 19 insertions(+), 19 deletions(-)
> >
> 
> [...]

-- 

- Arnaldo
