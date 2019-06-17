Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E75E490AA
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2019 22:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfFQT77 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jun 2019 15:59:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43616 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFQT77 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jun 2019 15:59:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so11321083wru.10
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2019 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rj6kyMEA/u1sspC6ifYkBt2kw6kdB+YUafgdUoEPFDc=;
        b=uEPe4SrM9Q3eOS4O3n3MUZDyl1fTLoNodLGl+bwHErQa9scNIOvmcXC1TorBl6V5GX
         IL+AjGmiIvHRGi7lLZ6nRvIy760dw66qXdmeRBC5s/S2pieZXHRaTKLV3RBBOgN1CZ60
         z2NkmFQWnUb9INEGhmbz1vQNFrLvR3pzgelwEdcvZrZvsVuBiy3M3GUSFwfjSEzydw77
         JMksFqwu1eHK7PVw4J8Qv3734IhkYReGJovZvS7KUKy0MHY62xyE+LRvur2DKrheZuZ1
         Kq6kOlswz9+FACwWtuNKiUX7mdTfOdJvnFgnC5883hkanN1v+e6AxZgvIAOcv6q/CpzU
         hbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rj6kyMEA/u1sspC6ifYkBt2kw6kdB+YUafgdUoEPFDc=;
        b=WG2ZV3Ki7rSULka9GckXWIgw7bZ6R5xO5KzgUdKwbeQq1vOloBYcQ0klVuxuSlnEl4
         BiUd4aCquGUqPlOhHvw1GKg+hOTMEyMarpwayuwsVKZl2eveDIUZo4iS32xBR305p8d4
         z2grTqG3rIclrHdHGoTlmdvFf0N8sh/7DuVd5jv+CZ2a7kQ3MNUxfgq5vudYweV+Izsj
         OIPMsFCfoTjPljWTDvshXHsq57kCSjd5gPX8RH+pr/yc4AMZqZpSGkC7hraYgFmfKzKJ
         k5VubcOZErH75OXBtiebBHZdiWCJF5wOxpt5HbweGtk1rRpsXrp3QyXdX6XjwuS/4JDC
         LHHA==
X-Gm-Message-State: APjAAAUVfhfy+FEdEmktFxnSYSYuHgkg5x+vHIfY9YH8KzizefUbd5dJ
        +OTKH9EHzC5PtRibtwFBTZIEg+jwI+I=
X-Google-Smtp-Source: APXvYqzrGK57In7OVq0IZgqsXEePdLhmkPDvUjcfmEk+VggYuKuinUuglqvBitX99avjBO9B7pyUmw==
X-Received: by 2002:adf:e841:: with SMTP id d1mr14401853wrn.204.1560801597355;
        Mon, 17 Jun 2019 12:59:57 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id s63sm166569wme.17.2019.06.17.12.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 12:59:56 -0700 (PDT)
References: <20190612113208.21865-1-naveen.n.rao@linux.vnet.ibm.com> <CAADnVQLp+N8pYTgmgEGfoubqKrWrnuTBJ9z2qc1rB6+04WfgHA@mail.gmail.com> <87sgse26av.fsf@netronome.com> <87r27y25c3.fsf@netronome.com> <CAADnVQJZkJu60jy8QoomVssC=z3NE4402bMnfobaWNE_ANC6sg@mail.gmail.com> <87ef3w5hew.fsf@netronome.com> <41dfe080-be03-3344-d279-e638a5a6168d@solarflare.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Edward Cree <ecree@solarflare.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH] bpf: optimize constant blinding
In-reply-to: <41dfe080-be03-3344-d279-e638a5a6168d@solarflare.com>
Date:   Mon, 17 Jun 2019 20:59:54 +0100
Message-ID: <878su0geyt.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Edward Cree writes:

> On 14/06/2019 16:13, Jiong Wang wrote:
>> Just an update and keep people posted.
>>
>> Working on linked list based approach, the implementation looks like the
>> following, mostly a combine of discussions happened and Naveen's patch,
>> please feel free to comment.
>>
>>   - Use the reserved opcode 0xf0 with BPF_ALU as new pseudo insn code
>>     BPF_LIST_INSN. (0xf0 is also used with BPF_JMP class for tail call).
>>
>>   - Introduce patch pool into bpf_prog->aux to keep all patched insns.
> It's not clear to me what the point of the patch pool is, rather than just
>  doing the patch straight away. 

I used pool because I was thinking insn to be patched could be high
percentage, so doing lots of alloc call is going to be less efficient? so
allocate a big pool, and each time when creating new patch node, allocate
it from the pool directly. Node is addressed using pool_base + offset, each
node only need to keep offset.

> Idea is that when prog is half-patched,
>  insn idxs / jump offsets / etc. all refer to the original locations, only
>  some of those might now be a list rather than a single insn.  Concretely:
>
> struct bpf_insn_list { bpf_insn insn; struct list_head list; }
> orig prog: array bpf_insn[3] = {cond jump +1, insn_foo, exit};
> start of day verifier converts this into array bpf_insn_list[3],
>  each with new.insn = orig.insn; INIT_LIST_HEAD(new.list)
>
> verifier decides to patch insn_foo into {insn_bar, insn_baz}.
> so we allocate bpf_insn_list *x;
> insn_foo.insn = insn_bar;
> x->insn = insn_baz;
> list_add_tail(&x->list, &insn_foo.list);
>
> the cond jump +1 is _not_ changed at this point, because it counts
>  bpf_insn_lists and not insns.
>
> Then at end of day to linearise we just have int new_idx[3];
>  populate it by iterating over the array of bpf_insn_list and adding on
>  the list length each time (so we get {0, 1, 3})
>  then allocate output prog of the total length (here 4, calculated by
>  that same pass as effectively off-the-end entry of new_idx)
>  then iterate again to write out the output prog, when we see that 'cond
>  jump +1' in old_idx 0 we see that (new_idx[2] - new_idx[0] - 1) = 2, so
>  it becomes 'cond jump +2'.
>
>
> This seems to me like it'd be easier to work with than making the whole
>  program one big linked list (where you have to separately keep track of
>  what each insn's idx was before patching).  But I haven't tried to code
>  it yet, so anything could happen ;-)  It does rely on the assumption
>  that only original insns (or the first insn of a list they get patched
>  with) will ever be jump targets or otherwise need their insn_idx taken.
>
> -Ed

