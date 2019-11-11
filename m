Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70FFFF8068
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2019 20:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKKTrd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Nov 2019 14:47:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44554 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfKKTrc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Nov 2019 14:47:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so11353605pfn.11;
        Mon, 11 Nov 2019 11:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+9p0geAPYzACJGr4kM2hyRnJuBulukbnnM2rKBijSkE=;
        b=Lr9u6dKcMnxosBmDkOTOg/HV8B2blEwxnmgWJEQ2EzK/7M8d+TwKUi1LeMvLaCcIvH
         045v2cS+xss3k7mIyOINO21skpydLlCsLjZOMyFZt9lqc0j8Kw+G/U/H5OHwuoVOLsbY
         JH5OQc6ooy9GVhVlmvcMkmvYq6TRkF4nMwNv7Dclp8OPKYSgjnTYzV4KKhkkyMQhQnDw
         1MdhLmr033d7wLIn09fqyh66HhHqE6IS40S+twJZCqFQUK9UO+SRbc3lb/VAk3v28ihn
         9JyMgllUKc8iRUgf/wPPEilaHxllpAYuShMzivAI5MLAof85ZJaIvil4uAgMZnEuhxvR
         QaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+9p0geAPYzACJGr4kM2hyRnJuBulukbnnM2rKBijSkE=;
        b=GUxs/5ZrSBSkbcz91RGwObBlUpLFoolFZgLhkrkRcQ60yhGyvBsm5OLD0PdBDDoSoY
         /Su7muB4LgAiCxnS8fkNFD2QozmbjYOBOVl3bvNVWo1xGkawPMzMG3IpKsGot19pKOED
         3rm1jwVzfoKNU8xX/h1If8tSE6/aKk5FW2YznMB90Rhq9jRILog328KYNMRShtHp0Zhl
         r8AcmhTU9kh3ktEYXEkkKFoZnNc/MM7ttMzX+FhWlVCegjYEQTmSLOGYAiYHLVU8DHhO
         kOXqDgsAAsoi1ORxWSAHM9sAxsWix3zTGVvelruWkx6wnJ3X/dJX3v8tYCCRebrmIuI1
         4PxQ==
X-Gm-Message-State: APjAAAWuH9VNnzQ/iY4k7haoWxl04P4vhAJqWUd+Mu3S1G1Fh4KQbTHb
        Yti3GOFpVqB4ibRg/I2sejg=
X-Google-Smtp-Source: APXvYqwcKjEdlZMRYppAqHUMbv7gQ99eeSBVdLpKqj2EkFkNJV09fdgaGoK6Idh+rD+cOgW29Fu9yA==
X-Received: by 2002:aa7:9f86:: with SMTP id z6mr32086375pfr.102.1573501651618;
        Mon, 11 Nov 2019 11:47:31 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::a925])
        by smtp.gmail.com with ESMTPSA id s2sm4623877pgv.48.2019.11.11.11.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 11:47:30 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:47:28 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kernel-team@fb.com
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and more)
Message-ID: <20191111194726.udayafzpqxeqjyrj@ast-mbp.dhcp.thefacebook.com>
References: <20191111131252.921588318@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111131252.921588318@infradead.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 11, 2019 at 02:12:52PM +0100, Peter Zijlstra wrote:
> Ftrace is one of the last W^X violators (after this only KLP is left). These
> patches move it over to the generic text_poke() interface and thereby get rid
> of this oddity.
> 
> The first 14 patches are the same as in the -v4 posting. The last 3 patches are
> new.
> 
> Will, patch 13, arm/ftrace, is unchanged. This is because this way it preserves
> behaviour, but if you can provide me a tested-by for the simpler variant I can
> drop that in.
> 
> Patch 15 reworks ftrace's event_create_dir(), which ran module code before the
> module was finished loading (before we even applied jump_labels and all that).
> 
> Patch 16 and 17 address minor review feedback.
> 
> Ingo, Alexei wants patch #1 for some BPF stuff, can he get that in a topic branch?

Thanks Peter!
Much appreciate it.

I've re-tested the patch 1 alone (it seems to be exactly the same as you posted
it originally back on Aug 27 and then on Oct 7). And now I tested my stuff with
this whole set. No conflicts. Feel free to add to patch 1 alone or the whole set:
Acked-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Some of the patches I think are split too fine. I would have combined them, but
we try hard to limit our sets to less than fifteen in bpf/netdev land fwiw.

It was a poor judgment on my side to use text_poke() in my patch (to avoid
explicit dependency on your patch) and not mention the obvious race in the
commit log and intended fix when trees converge:
        case BPF_MOD_CALL_TO_CALL:
                if (memcmp(ip, old_insn, X86_CALL_SIZE))
                        goto out;
-               text_poke(ip, new_insn, X86_CALL_SIZE);
+               text_poke_bp(ip, new_insn, X86_CALL_SIZE, NULL);
                break;

To avoid the issue in the first place the best is to have your 1st patch in tip
and bpf-next/net-next trees. We had "the same patch in multiple trees"
situation in the past and git did the right thing during the merge window. So I
don't anticipate any issues this time around.

One more question.
What is the reason you stick to int3 style poking when 8 byte write is atomic?
Can text_poke() patch nop5 by combining the call/jmp5 insn with extra 3 bytes
after the nop and write 8 ?

