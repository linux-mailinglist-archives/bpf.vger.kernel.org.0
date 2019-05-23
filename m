Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83AE28B74
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 22:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfEWUUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 May 2019 16:20:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45386 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfEWUUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 May 2019 16:20:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so7604439wrq.12
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 13:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=9F0FoQ8PdR78lWVTG+S7ZbqZVtmtEg/8mKeg0Q5fd34=;
        b=BTfLCdPDlz+1fas+1ZiAKLw9cZSnFWtYUU5BFnH2r8aD3B2VRc8v8uMMbYY5fwtDfI
         MIDJ+z35vCrUV0IoDoYuBUx+bcKCJ2XhFa0BZV9F2kImou9WkLWOMO3+LiU4pZanU5qi
         vUlxQCSmH48a9naWMZMxcKaki3oYufNDVdP9qn7o4jSpv6SVPScgwDVlrAmzE1uQrJ04
         WKvr9lRyWuRKhgaR3hCX0ES01sDpV5442lBHzMYJvg4YMqNugEP97S2NssCEQmItQLp7
         UrnZe8rGPD/Qn57yALL0RrDScJjcJFG8FAk9087tbLoyGN16uga6ELcHiJ1BUlal9C+e
         syWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=9F0FoQ8PdR78lWVTG+S7ZbqZVtmtEg/8mKeg0Q5fd34=;
        b=G7hWz5z3rboXfzABhk7ST26S+LiJatfk3JlVRhbtsbiNJfIZyc2GGsTWM61YtHSitK
         TEB7THSZ/KgN0PY5VgUpxLxkUF6BRVQcw+7LQrjeSPgxiw5PjIid/5aXHnx+2Oz0QMAW
         fUldyB7rcjRoRHBseeQCJjeaNiOdwVvbQtKI92HdUAufK2kizAR0rsYjuopQ+kR5lSPP
         URDgC/GovZ87pWXluzX3h3tAYdaz4Jd3uniwET+C6g4S7618UmlF5wJ16/hdW0n7x6Hh
         /V/xP6H/IuC+AjFo/YjKOw6XUTqaatJdlmSG8Rr8jmiV9rw+Jp6t3+7RJwhqvBn2LKX2
         jGxw==
X-Gm-Message-State: APjAAAUCmrC3Ot2j+4scidh0KA1WenjWmjlcz5M2hjka4KTG7f8Cnae+
        SumBptPbaw2/Njk/HrUamgtP+w==
X-Google-Smtp-Source: APXvYqypmmuftnJtPF9XV1EJiIzFebtZBBxdAsyaAq270PwsWqAX4IlWypDfDDC2pHGQciSd3CKxVg==
X-Received: by 2002:adf:ec8c:: with SMTP id z12mr632721wrn.209.1558642819385;
        Thu, 23 May 2019 13:20:19 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id w3sm416822wrv.25.2019.05.23.13.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 13:20:18 -0700 (PDT)
References: <1558551312-17081-1-git-send-email-jiong.wang@netronome.com> <1558551312-17081-2-git-send-email-jiong.wang@netronome.com> <20190523020757.mwbux72pqjbvpqkh@ast-mbp.dhcp.thefacebook.com> <B9C052B7-DFB9-461A-B334-1607A94833D3@netronome.com> <20190523161601.mqvkzwjegon2cqku@ast-mbp.dhcp.thefacebook.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        davem@davemloft.net, paul.burton@mips.com, udknight@gmail.com,
        zlim.lnx@gmail.com, illusionist.neo@gmail.com,
        naveen.n.rao@linux.ibm.com, sandipan@linux.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        jakub.kicinski@netronome.com
Subject: Re: [PATCH v7 bpf-next 01/16] bpf: verifier: mark verified-insn with sub-register zext flag
In-reply-to: <20190523161601.mqvkzwjegon2cqku@ast-mbp.dhcp.thefacebook.com>
Date:   Thu, 23 May 2019 21:20:15 +0100
Message-ID: <87h89kkjnk.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Alexei Starovoitov writes:

<snip>

> well, it made me realize that we're probably doing it wrong,
> since after calling check_reg_arg() we need to re-parse insn encoding.
> How about we change check_reg_arg()'s enum reg_arg_type instead?

This is exactly what I had implemented in my initial internal version.

> The caller has much more context and no need to parse insn opcode again.

And I had exactly the same thoughts, is_reg64 is duplicating what has been
done.

The code evolved into the current shape mostly because I agreed if we
re-centre all checks inside check_reg_arg, then we don't need to touch
quite a few call sites of check_reg_arg, the change/patch looks simpler,
and I was thinking is_reg64 is a quick check, so the overhead is not big.

> Something like:
> enum reg_arg_type {
>         SRC_OP64,        
>         DST_OP64,       
>         DST_OP_NO_MARK, // probably no need to split this one ?
>         SRC_OP32,      
>         DST_OP32,      
> };
>

Yeah, no need to split DST_OP_NO_MARK, my split was

enum reg_arg_type {
   SRC_OP,
+  SRC32_OP,
   DST_OP,
+  DST32_OP,
   DST_OP_NO_MARK 
}

No renaming on existing SRC/DST_OP, they mean 64-bit, the changes are
smaller, looks better?

But, we also need to know whether one patch-insn define sub-register, if it
is, we then conservatively mark it as needing zero extension. patch-insn
doesn't go through check_reg_arg analysis, so still need separate insn
parsing.

And because we also introduced hi32 rand which should only happen if
insn_aux.zext_dst is false. But when zext_dst is false, there are two
situations, one is this insn define a sub-register whose hi32 is not used
later, the other is this insn define a full 64-bit register. hi32 rand
should only happen on the prior situation. So is_reg64 also called to rule
out the latter. The use of is_64 could be removed by changing aux.zext_dst
from bool to enum, so we rename it to aux.reg_def, its value could be:

  REG_DEF_NONE (some insn doesn't define value, this is default)
  REG_DEF64
  REG_DEF32
  REG_DEF32_ZEXT

When calling check_reg_arg, and DST/DST_32 will initialize aux.reg_def into
REG_DEF64 and REG_DEF32 accordingly. Then, a later 64-bit use on sub-register
could promote REG_DEF32 into REG_DEF32_ZEXT.

In all, my propose changes are:
  1. split enum reg_arg_type, adding new SRC32_OP and DST32_OP, during insn
     walking, let call sites of check_reg_arg passing correct type
     directly, remove insn re-parsing inside check_reg_arg.
  2. keep "is_reg64", it will be used by parsing patched-insn.
  3. change aux.zext_dst to aux.reg_def, and change the type from bool to
     the enum listed above. When promoting one reg to REG_DEF32_ZEXT, also
     do sanity check, the promotion should only happen on REG_DEF32.

Does this looks good?

Regards,
Jiong
