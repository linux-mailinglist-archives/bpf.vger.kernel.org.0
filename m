Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853C63ABB55
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 20:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhFQSYN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 14:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232421AbhFQSYN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 14:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623954124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dLf5lb9pqtiFUUorIDm+A5wNwoIqKNePrs/M2mIsUMY=;
        b=Azn4JmfrmfBSW11fi34Or7vnKSXNMtx7c1URNfXjD+Owp4B1dGFoYa6dWTJ/Yhv75Mmdtq
        0951/yyz/coZxrlQWOPOoJJgkhOGpLsR9R9CdSWe2P/vBmybJlla7sGzFztXIEObp9dUGk
        qJnTe2ymbeoSaCusVUDNhQdVYj4tShQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313--wt-MQD5PiSS5v-PR0FHig-1; Thu, 17 Jun 2021 14:22:02 -0400
X-MC-Unique: -wt-MQD5PiSS5v-PR0FHig-1
Received: by mail-qv1-f71.google.com with SMTP id q8-20020ad45ca80000b02902329fd23199so2969593qvh.7
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 11:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dLf5lb9pqtiFUUorIDm+A5wNwoIqKNePrs/M2mIsUMY=;
        b=h7E7QtU1f0CuDeEz69HlqOuGdzytD46r1DJUO7/qY33z080NEFH2K/JhqPCW5M1P0A
         VhVkijDcliSWsIIwETt+3KkxfDwJL6+5cMKvmiQZAI2B3uEK+JAN9sLRtVD72WPZXf/8
         ra57Q9BcVUsEDgbMF2zt3J/0Zk3LmCCza/iNzX4lApJNUT0Vz7OPOoRjJWxS9scx7Mt3
         75Q5Oq06o9UCLdGdJDRAhfjzYQAlHwD8Vnzvj00htbpfrvcxSFUKLYxTBeCuwegXFEA1
         qNNX14hM5mB47Y32vJ0l9NE1fgf04tS4VGPkvViTaB79wIvRtQ4QK3Ur+MXYtsid29Ew
         h39g==
X-Gm-Message-State: AOAM533ZfMXkND75ApKVhzzjTC/eIgBIngBmc1V/2ejkfpSg2N26zX++
        BhOn7LpquGkzD4nMcseV23Pmwd+uZqzNPUxMGcwwcogOqyccLkHaw/rEaTsiheJjOlqNBOtk8to
        GG3JI2qD2CtgH
X-Received: by 2002:ac8:4803:: with SMTP id g3mr6508849qtq.176.1623954122445;
        Thu, 17 Jun 2021 11:22:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvs7yF1XwMKN/+3URlziDuC/xxyy+TxwhIoORXzLoREhu5g8YsnZqVt7ydq/WqRqMUIs/Gjw==
X-Received: by 2002:ac8:4803:: with SMTP id g3mr6508806qtq.176.1623954122162;
        Thu, 17 Jun 2021 11:22:02 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id k19sm2229348qkj.89.2021.06.17.11.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 11:22:01 -0700 (PDT)
Date:   Thu, 17 Jun 2021 13:21:59 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v7 09/13] kprobes: Setup instruction pointer in
 __kretprobe_trampoline_handler
Message-ID: <20210617182159.ka227nkmhe4yu2de@treble>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
 <162209762943.436794.874947392889792501.stgit@devnote2>
 <20210617043909.fgu2lhnkxflmy5mk@treble>
 <20210617044032.txng4enhiduacvt6@treble>
 <20210617234001.54cd2ff60410ff82a39a2020@kernel.org>
 <20210618000239.f95de17418beae6d84ce783d@kernel.org>
 <CAEf4Bzbob_M0aS-GUY5XaqePZr_prxUag3RLHtp=HY8Uu__10g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbob_M0aS-GUY5XaqePZr_prxUag3RLHtp=HY8Uu__10g@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 10:45:41AM -0700, Andrii Nakryiko wrote:
> > > > > I know I suggested this patch, but I believe it would only be useful in
> > > > > combination with the use of UNWIND_HINT_REGS in SAVE_REGS_STRING.  But I
> > > > > think that would be tricky to pull off correctly.  Instead, we have
> > > > > UNWIND_HINT_FUNC, which is working fine.
> > > > >
> > > > > So I'd suggest dropping this patch, as the unwinder isn't actually
> > > > > reading regs->ip after all.
> > > >
> > > > ... and I guess this means patches 6-8 are no longer necessary.
> > >
> > > OK, I also confirmed that dropping those patche does not make any change
> > > on the stacktrace.
> > > Let me update the series without those.
> >
> > Oops, Andrii, can you also test the kernel without this patch?
> > (you don't need to drop patch 6-8)
> 
> Hi Masami,
> 
> Dropping this patch and leaving all the other in place breaks stack
> traces from kretprobes for BPF. I double checked with and without this
> patch. Without this patch we are back to having broken stack traces. I
> see either
> 
>   kretprobe_trampoline+0x0
> 
> or
> 
>   ftrace_trampoline+0xc8
>   kretprobe_trampoline+0x0
> 
> Is there any problem if you leave this patch as is?

Hm, I must be missing something then.  The patch is probably fine to
keep, we just may need to improve the commit log so that it makes sense
to me.

Which unwinder are you using (CONFIG_UNWINDER_*)?

-- 
Josh

