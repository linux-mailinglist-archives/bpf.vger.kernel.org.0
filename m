Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33632A0E69
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 20:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgJ3TQt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Oct 2020 15:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgJ3TQj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Oct 2020 15:16:39 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650EFC0613CF
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2020 12:16:39 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i18so1820445ots.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2020 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ETmLqyudWdwsXw7h+1qB3Egpb5agg4/veOj74MbPzAA=;
        b=bLZMTp89K92g3jDGpV4wE/NzKncR1zk5Lpxv3s2LZ3qRvCNXZSs3duuYCfdEHfLrCF
         To3xmw3TdtC63CbdyNHYYqsyOBcr0tXNeSnR8xgJFjuGmWglqrr4wSsnl61KYwLBAFaD
         iLC+40Grovjv7ZBWOC37qkxBXflrRKdoyQercXHoVoItM3Nu1nIOtjBi76o0DdpP1xR2
         VpknLT3fkWweECDSGt0Jrx4U4EelQaqkoJdlaN0WWKWBtd1OAHgDknBfXzc/DBTRkNZx
         9PpvqgrFwEsuDZw5awIfrlic/xBbMLwZ9E9xK/D9JYZ0X7+GOXogt35U20YGkyxS4OTm
         w86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ETmLqyudWdwsXw7h+1qB3Egpb5agg4/veOj74MbPzAA=;
        b=VVV43r26FkkDGgv+i258wOtuGPBLCbqCFr7iPVJDinYtSHeHHo4cfeRS5/o7xTPNl8
         lZIRANwaaCAdtLoRZNZJC5DIQxxgJO4NzWbNHBNr3AB2QDEG0cpU/Spb9GmHymFtJcQ5
         i5dznPWU/IP/Z40zkn6kIfkAtyZTFXmt+BHfQn4geprBmzJWHMhGQoKn5HQLLpoUN/q8
         PWf4UiYlBKOQlXZWBR1ieCA/+6SfH8KoJFnmQIDy8MroqggiSx+NmY6FpsRH7CiRdo2M
         oJPjEeG9dvwbPYYX12Vi+Inn3IzUzqN6uTzB29faTxVr1q6WGATGvl4i17oA+7/A40Sr
         xyjQ==
X-Gm-Message-State: AOAM530shHrFGAJxj0zSJQdqvPSjkKiM01kGOhRVYvxs6SHPALpZplMw
        NnkwJolJFTg3icTEGwJic/k=
X-Google-Smtp-Source: ABdhPJzloQyHiSuNiVouJPVgly645hTwmVFa1eBRnUURPIk1jH8iyd8lcAJ4566CVZ3Kthrec2GCag==
X-Received: by 2002:a9d:eca:: with SMTP id 68mr2666323otj.141.1604085398877;
        Fri, 30 Oct 2020 12:16:38 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id h7sm1543300oop.40.2020.10.30.12.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 12:16:38 -0700 (PDT)
Date:   Fri, 30 Oct 2020 12:16:29 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        KP Singh <kpsingh@google.com>
Message-ID: <5f9c668d9a55a_16d420895@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4Bza-KX7C5ghXSVs30R_xkKtqjDwM8snH2B2A_VCAxSim2g@mail.gmail.com>
References: <VI1PR8303MB008003C9E3B937033A593C47FB150@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
 <CAEf4Bza-KX7C5ghXSVs30R_xkKtqjDwM8snH2B2A_VCAxSim2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: update verifier to stop perf ring buffer
 corruption
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Fri, Oct 30, 2020 at 5:08 AM Kevin Sheldrake
> <Kevin.Sheldrake@microsoft.com> wrote:
> >
> > As discussed, bpf_perf_event_output() takes a u64 for the sample size parameter but the perf ring buffer uses a u16 internally.  This results in overlapping samples where the total sample size (including header/padding) exceeds 64K, and prevents samples from being submitted when the total sample size ==  64K.

[...]

> >Also I don't know what the size reduction of -24 relates to (it doesn't match any header struct I've found) but it was found through experimentation.
> 
> So -24 should have been a clue that something fishy is going on. Look
> at perf_prepare_sample() in kernel/events/core.c. header->size (which
> is u16) contains the entire size of the data in the perf event. This
> includes raw data that you send with bpf_perf_event_output(), but it
> can also have tons of other stuff (e.g., call stacks, LBR data, etc).
> What gets added to the perf sample depends on how the perf event was
> configured in the first place. And it happens automatically on each
> perf event output.
> 
> So, all that means that there could be no reliable static check in the
> verifier which would prevent the corruption. It has to be checked by
> perf_prepare_sample() in runtime based on the actual size of the
> sample. We can do an extra check in verifier, but I wouldn't bother
> because it's never going to be 100% correct.

Please don't add the check in the verifier if its not 100% correct. I
think that will confuse readers and make it appear "safe" when it is
not. Even if you add a big warning comment there it will make the error
case harder to hit. So lets just solve it as Andrii notes. My $.02

Thanks.
