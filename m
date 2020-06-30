Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7197C20FBBC
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 20:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbgF3Sby (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbgF3Sbx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 14:31:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A341C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 11:31:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so23745803ljg.13
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=z2Md+0xqPbD4CwQCNuZFLs5vo0+1IUFp8nKqNUd1/ZM=;
        b=tLgNnNjUojhQ36ngXW/zy+TuXbslVuNNCyJAQmHiyctAvd4BmXLw8gtrcLTZ4uxGDj
         s3Jkids5q88qNubmHQ6INy4CWylJ3/agYPifYiGcHVyFvI9OMko29HvAdc8v39sComRx
         /+v1vssQ+kAGvm2avPUHbl2kZyaKk7loiqi9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=z2Md+0xqPbD4CwQCNuZFLs5vo0+1IUFp8nKqNUd1/ZM=;
        b=ATL3QEiay/J7PLmt9yGJHOPquLDhW25jbnxHZv+KoCyuWO3PoHpK6ShO0wfQ5DoWzs
         19AFfumtIvAjtCIWF9JQD4ujZJOfBv12IH08lvQkOZy3HiFvAcCW9IECyTFtOvgxqorq
         vopv9c5iC9VDWW6lPVXzGp3Hbo/zt3CrMucVp8hiWXnlSyBr4fXNMRrDTcDtGGwGu4Sk
         AfqDYsud4yW4Ada7QDfg6rumDZtx54PgdkeL70kQBa6qE0dIMi5mxunpMVyF2ThAdof/
         EkEJaMiGElhrHEaELdrz9S7qlcPONUzUyW0PkoKgjvNlDZElF6hm+vp8tG4mpkDoh0fQ
         RA/A==
X-Gm-Message-State: AOAM530OmBzcK+t+KYxHMQR5lcU/sLhT3b/yYbt76mbc1BaRkSGtCFAU
        tiQG/3KFlv8RxFr9fqnkl+GoUA==
X-Google-Smtp-Source: ABdhPJy091LTNISIh2ccAlxt9Fx+vib7HB35IixmMrlg+UX8Tjrpa1TMMEEI+tDYVMsdja4GG1nftQ==
X-Received: by 2002:a2e:9bc4:: with SMTP id w4mr9311482ljj.391.1593541911351;
        Tue, 30 Jun 2020 11:31:51 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id d2sm1082979lfq.79.2020.06.30.11.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:31:50 -0700 (PDT)
References: <20200629095630.7933-1-lmb@cloudflare.com> <CAADnVQ+VN6nUCQC51nByeKa+uHG=O-GyzeEpWQgJ8OP815RB2A@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2 0/6] Fix attach / detach uapi for sockmap and flow_dissector
In-reply-to: <CAADnVQ+VN6nUCQC51nByeKa+uHG=O-GyzeEpWQgJ8OP815RB2A@mail.gmail.com>
Date:   Tue, 30 Jun 2020 20:31:49 +0200
Message-ID: <878sg4mmlm.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 08:00 PM CEST, Alexei Starovoitov wrote:
> On Mon, Jun 29, 2020 at 2:59 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>>
>> Both sockmap and flow_dissector ingnore various arguments passed to
>> BPF_PROG_ATTACH and BPF_PROG_DETACH. We can fix the attach case by
>> checking that the unused arguments are zero. I considered requiring
>> target_fd to be -1 instead of 0, but this leads to a lot of churn
>> in selftests. There is also precedent in that bpf_iter already
>> expects 0 for a similar field. I think that we can come up with a
>> work around for fd 0 should we need to in the future.
>>
>> The detach case is more problematic: both cgroups and lirc2 verify
>> that attach_bpf_fd matches the currently attached program. This
>> way you need access to the program fd to be able to remove it.
>> Neither sockmap nor flow_dissector do this. flow_dissector even
>> has a check for CAP_NET_ADMIN because of this. The patch set
>> addresses this by implementing the desired behaviour.
>>
>> There is a possibility for user space breakage: any callers that
>> don't provide the correct fd will fail with ENOENT. For sockmap
>> the risk is low: even the selftests assume that sockmap works
>> the way I described. For flow_dissector the story is less
>> straightforward, and the selftests use a variety of arguments.
>>
>> I've includes fixes tags for the oldest commits that allow an easy
>> backport, however the behaviour dates back to when sockmap and
>> flow_dissector were introduced. What is the best way to handle these?
>>
>> This set is based on top of Jakub's work "bpf, netns: Prepare
>> for multi-prog attachment" available at
>> https://lore.kernel.org/bpf/87k0zwmhtb.fsf@cloudflare.com/T/
>
> Folks, you should have used 'bpf' in the subject of Jakub's patches.
> I've dropped Jakub's set from bpf-next and re-applied to bpf tree.
> And applied this set on top.
> Thanks!

The preparatory work for multi-prog for netns programs [0] that landed
recently in bpf-next wasn't fixing anything, so I thought it was -next
material.

I've messed up because I've asked Lorenz to base his patchset on top of
mine, but didn't consider the fact that Lorenz's fixes are targeted for
v5.8 and earlier :-/

So alternatively, we could respin Lorenz patchset on top of 'bpf', if
you want, to untangle this situation.

But if you decide to keep my patchset in 'bpf', then can you please also
apply the today's fixup [1]? Or I can resend with correct subject prefix
tomorrow.

Thanks,
-jkbs

[0] https://lore.kernel.org/bpf/20200625141357.910330-1-jakub@cloudflare.com/
[1] https://lore.kernel.org/bpf/20200630164541.1329993-1-jakub@cloudflare.com/
