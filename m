Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951573B7697
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 18:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhF2Qn5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 12:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232174AbhF2Qn4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 12:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624984888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6lsvhzrygbJh4AwNqvmWZ2sHvNWKnTHpejWGaVE6/Q=;
        b=c4Ez5l3PWruLbVPHqxCGlSaERbDzEsiOhsipzIsx6hDaOQdfnLY+iCtNP+BBolEHkB50KW
        pF97aICFSvrxN+dlnD+QyD0ODZMFhYJSi1S+wKpfQpCOBdngasY1mQHFk/+oJU4K3jKgpz
        DRKu03jXlcaaEUomQTsBGhOQNCO7O24=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-yz6DkTB8NWWp5YFJTo8Xyw-1; Tue, 29 Jun 2021 12:41:27 -0400
X-MC-Unique: yz6DkTB8NWWp5YFJTo8Xyw-1
Received: by mail-wm1-f70.google.com with SMTP id t82-20020a1cc3550000b02901ee1ed24f94so1501159wmf.9
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 09:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R6lsvhzrygbJh4AwNqvmWZ2sHvNWKnTHpejWGaVE6/Q=;
        b=foR6oNOwqypsZ9/GJNIZuQl2ZKqYxEWiwDOkRLq28fBECWOdU2vYHUhahZWEyHQON1
         d+zzN2xHUnL/HBXGPj2CyL24sNGeQMtOtyhvVbCJrB7T96qcD6Jx0zexN3L4jMJOfx6u
         g8vKO7j8TmOBauUu/U1IwJBaajy6bsNZUAygCKpi4GZucfpw4OIR5FwVVVfy2pAs81OJ
         qFRCe+0RNsBcDHLaSq1HSpe0UDIxakb/FqQ3lR/XtzjltpIi85ms9Ebw9D2T76g6cA2p
         oOfH1jSc03OBEiym2j2cx5Fl5hq5PrUSf37I2hwdW4b55gm2TRe0f8X2WhRpMYGKEPAg
         PR6A==
X-Gm-Message-State: AOAM532MXiasafVMHmXRDQw3ew3vLYzKmD1dOoHdluz5irrtBGROp55V
        MOO3fSZf1b1kCYNAbkgmFQ7OmyORI9R7k2oZOqdXwTHokNF7bWKn/9QX6t2hWghfnGyBSKpGC+0
        /yY17H2L/GVfo
X-Received: by 2002:a05:600c:33a6:: with SMTP id o38mr18188286wmp.126.1624984884921;
        Tue, 29 Jun 2021 09:41:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtkavlaXf3Z3/wVm1xSHl973s+nq+E8K48zkjSONEaCMRvgep32bNqxaRm0rT1LRFZcUt0CA==
X-Received: by 2002:a05:600c:33a6:: with SMTP id o38mr18188269wmp.126.1624984884791;
        Tue, 29 Jun 2021 09:41:24 -0700 (PDT)
Received: from krava ([109.53.3.246])
        by smtp.gmail.com with ESMTPSA id h10sm3339837wmb.40.2021.06.29.09.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 09:41:24 -0700 (PDT)
Date:   Tue, 29 Jun 2021 18:41:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
Message-ID: <YNtNMSSZh3LTp2we@krava>
References: <20210202135002.4024825-1-jackmanb@google.com>
 <YNiadhIbJBBPeOr6@krava>
 <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
 <YNspwB8ejUeRIVxt@krava>
 <YNtEcjYvSvk8uknO@krava>
 <CA+i-1C3RDT1Y=A7rAitfbrUUDXxCJeXJLw1oABBCpBubm5De6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i-1C3RDT1Y=A7rAitfbrUUDXxCJeXJLw1oABBCpBubm5De6A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 29, 2021 at 06:25:33PM +0200, Brendan Jackman wrote:
> On Tue, 29 Jun 2021 at 18:04, Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Jun 29, 2021 at 04:10:12PM +0200, Jiri Olsa wrote:
> > > On Mon, Jun 28, 2021 at 11:21:42AM +0200, Brendan Jackman wrote:
> > > > On Sun, 27 Jun 2021 at 17:34, Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >
> > > > > On Tue, Feb 02, 2021 at 01:50:02PM +0000, Brendan Jackman wrote:
> [snip]
> > > > Hmm, is the test prog from atomic_bounds.c getting JITed there (my
> > > > dumb guess at what '0xc0000000119efb30 (unreliable)' means)? That
> > > > shouldn't happen - should get 'eBPF filter atomic op code %02x (@%d)
> > > > unsupported\n' in dmesg instead. I wonder if I missed something in
> > > > commit 91c960b0056 (bpf: Rename BPF_XADD and prepare to encode other
> >
> > I see that for all the other atomics tests:
> >
> > [root@ibm-p9z-07-lp1 bpf]# ./test_verifier 21
> > #21/p BPF_ATOMIC_AND without fetch FAIL
> > Failed to load prog 'Unknown error 524'!
> > verification time 32 usec
> > stack depth 8
> > processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
> > Summary: 0 PASSED, 0 SKIPPED, 2 FAILED
> 
> Hm that's also not good - failure to JIT shouldn't mean failure to
> load. Are there other test_verifier failures or is it just the atomics
> ones?

I have CONFIG_BPF_JIT_ALWAYS_ON=y so I think that's fine

> 
> > console:
> >
> >         [   51.850952] eBPF filter atomic op code db (@2) unsupported
> >         [   51.851134] eBPF filter atomic op code db (@2) unsupported
> >
> >
> > [root@ibm-p9z-07-lp1 bpf]# ./test_verifier 22
> > #22/u BPF_ATOMIC_AND with fetch FAIL
> > Failed to load prog 'Unknown error 524'!
> > verification time 38 usec
> > stack depth 8
> > processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
> > #22/p BPF_ATOMIC_AND with fetch FAIL
> > Failed to load prog 'Unknown error 524'!
> > verification time 26 usec
> > stack depth 8
> > processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
> >
> > console:
> >         [  223.231420] eBPF filter atomic op code db (@3) unsupported
> >         [  223.231596] eBPF filter atomic op code db (@3) unsupported
> >
> > ...
> >
> >
> > but no such console output for:
> >
> > [root@ibm-p9z-07-lp1 bpf]# ./test_verifier 24
> > #24/u BPF_ATOMIC bounds propagation, mem->reg OK
> >
> >
> > > > atomics in .imm). Any idea if this test was ever passing on PowerPC?
> > > >
> > >
> > > hum, I guess not.. will check
> >
> > nope, it locks up the same:
> 
> Do you mean it locks up at commit 91c960b0056 too?
> 

I tried this one:
  37086bfdc737 bpf: Propagate stack bounds to registers in atomics w/ BPF_FETCH

I will check also 91c960b0056, but I think it's the new test issue

jirka

