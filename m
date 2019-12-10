Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0094118103
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 08:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfLJHDX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 02:03:23 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39977 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfLJHDW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 02:03:22 -0500
Received: by mail-il1-f195.google.com with SMTP id b15so15175599ila.7
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2019 23:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XOLR366ue9UbdwpGi75PQA5BDSgsShKRMR6syBVaCSI=;
        b=NkuGcga7SVDZTUMMo51w4HRsBnbf0R/URj6PpPGlU3pLyxh/0ttxIog576y1yzdvLn
         eoJ8kf6kXgiGbSaaWDuUGmWTjtsTjZKVSCJ8Q1SnoKKiwiN/5ZXbedZXayDFlSyae+Yy
         nAhd9fD3buTsungj4t2ef9PnPd818UbU+6cdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOLR366ue9UbdwpGi75PQA5BDSgsShKRMR6syBVaCSI=;
        b=lLuvDZGalwKPjrx1CmDNX67JRzLKOMQ446E1YvgpP1/8XWez62pEEmmF9JwQ72sPOM
         BnJTQqXrcVo1iq6XfzJiWI7qkhGxoYUbKHK6Ij0fD455eGuCYpHf9k7qOvxxErWRhOL/
         hpGjB0RsR5E2b4/zL6UbUuTJ+E9lb9MiWBw738vtMZ7K7NsTBJOFu5I3iI5eQbv0MEiG
         FqB+UskOHROswJoLHxx97i45kw5Jdryx64iA7tRt8KgLIk01rD/sJVQXOGV1scRbP8iG
         pnTDCPzbwkSSJwYr0Pn/1YEqs3Oa9xEMgtnZ60tVgnuN5cehOJraV5BejyFmUxGD3Wol
         HLqA==
X-Gm-Message-State: APjAAAXJlQdRUNmF8meNXtJROZOAIIoKBOREhUOfXovuZMsbalhNFrrH
        X1/hCdlY3D6OM8oKyk+0H895q/xbFg370beKmNLCtQ==
X-Google-Smtp-Source: APXvYqzgHM+DLDGODvA/sjBCZyZhAfvnRErBW0IceCs2/IQqhRh8rJvuSRMhu9qEW/u/DVJiNXoqYx8gBP7F7uuyY6I=
X-Received: by 2002:a92:86c5:: with SMTP id l66mr31157017ilh.280.1575961401998;
 Mon, 09 Dec 2019 23:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20191209173136.29615-1-bjorn.topel@gmail.com> <20191209173136.29615-3-bjorn.topel@gmail.com>
 <CADasFoDOyJA0nDVCyA6EY78dHSSxxV+EXS=xUyLDW4_VhJvBkQ@mail.gmail.com> <2d5d1f2d-d4ab-2449-37c6-e5b319a778d6@iogearbox.net>
In-Reply-To: <2d5d1f2d-d4ab-2449-37c6-e5b319a778d6@iogearbox.net>
From:   Luke Nelson <lukenels@cs.washington.edu>
Date:   Mon, 9 Dec 2019 23:02:53 -0800
Message-ID: <CADasFoCZc7Lt=puc82x7PBSvuOG_dBwVgasYGJ4M3RFDG=qR3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/8] riscv, bpf: add support for far branching
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-riscv@lists.infradead.org,
        bpf <bpf@vger.kernel.org>, Xi Wang <xi.wang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 9, 2019 at 1:27 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> This is awesome work! Did you also check for other architectures aside
> from riscv and x86-32, e.g. x86-64 or arm64?

We haven't tried on x86-64 or arm64 yet, but we plan to in the
future and are looking at ways to minimize the effort required to
port verification to new architectures.

> It would be great if we could add such verification tool under tools/bpf/
> which would then take the in-tree JIT-code as-is for its analysis and
> potentially even trigger a run out of BPF selftests. Any thoughts whether
> such path would be feasible wrt serval?

Right now the verification requires manual translation of the JIT
implementation in C to Rosette for verification, which makes it
difficult to integrate into existing tests. Were currently working
on automating this process to be able to verify the C implementation
directly. If this works out, it'd be awesome to integrate into the
selftests in some way. Will keep you posted.

Thanks,

Luke
