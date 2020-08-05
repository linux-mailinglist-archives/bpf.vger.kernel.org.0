Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A623D41D
	for <lists+bpf@lfdr.de>; Thu,  6 Aug 2020 01:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHEXKx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Aug 2020 19:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHEXKw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Aug 2020 19:10:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47817C061574
        for <bpf@vger.kernel.org>; Wed,  5 Aug 2020 16:10:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 83so17897050ybf.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2020 16:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GZ1p3B4zJ4xx6pY44JI6Q7OnvQ2G+QUjUwLs4Aa2HV8=;
        b=DJJRLof2R5IF1rZ9RSqTLiQ32L86nWzfrX1bKv/BU3wbhfS9JWt3F3kOZamF4oy5Ir
         lC9u+ZkAaSFz3UyhEWO6qonUn26GP8XFwnoYd9SiNK8Xia5mn8wMQewU89qJ+p6OtQIG
         CWWGq1mqg9PQE9fILG09X7C9q+aPdETiFs6FFzqIR3onMr9gHrDcj0FPMu2dIX0yVZag
         NB5FTaPdPNcADcj3lIS8FaQUcgSScVilJqU+/mGQeFELX5ee1MZEDuBn1hSQHYx6Scso
         +Fh/cKyRGgKRi8qnsONl2FKgo10Mvfs9CT3ly1hWyVyc6STTA0SxJ/i58lHg634rQCRR
         2nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GZ1p3B4zJ4xx6pY44JI6Q7OnvQ2G+QUjUwLs4Aa2HV8=;
        b=TLXi5NGxCMklRyHF3agsBDkqsBDGZ6/bEcUIGLg7R4eppPVxbWppoa+rQGic5f7YB1
         UC34BUK7x1tKSya+gnU/WwKM4tPoMxEiIsJisfq8o63U6hOsOwUSRQbLDQlmplnFmEY9
         RqHjchg5+SYKMaTEUpH4a5PJE8bGft91nhxXBd6LZUB/DNBG5dDFrR4LVxeRor/MKjr+
         GXd0uRvrPbMgrpyWv1tBsO1PCKmmC1IwGYpJAKq7NdOQ/1YsjIfQ7kstxy9zfoZTgd+t
         Qfuvmssol+XQAVUmZVXRljdM6AvKRvDwyouCFi+Nc02zmPPWuxjobnJnL/xZlE67KHgg
         yFaQ==
X-Gm-Message-State: AOAM532mPgchwiseRlf7OglOIW7kMpE8syztFbpCJSrbT8Sl5N54FG5E
        XddrBxCAKHk4lYKoOq8ynlf7O54=
X-Google-Smtp-Source: ABdhPJxLN/Sdq9bqGyRgr6wPwHjR3NWIxX9FsQJQzSPos9jkZAgDDZ4lMLCHXNRMIv5EyLmAA+t/rMw=
X-Received: by 2002:a25:d709:: with SMTP id o9mr8093120ybg.392.1596669051284;
 Wed, 05 Aug 2020 16:10:51 -0700 (PDT)
Date:   Wed, 5 Aug 2020 16:10:49 -0700
In-Reply-To: <CAADnVQJ-usRjX20KBuCot3NNmrsVZ5oN3c+cZ86Hbr5a9F7n3g@mail.gmail.com>
Message-Id: <20200805231049.GF184844@google.com>
Mime-Version: 1.0
References: <20200729162751.GC184844@google.com> <20200804194251.GE184844@google.com>
 <CAADnVQJ-usRjX20KBuCot3NNmrsVZ5oN3c+cZ86Hbr5a9F7n3g@mail.gmail.com>
Subject: Re: BPF program metadata
From:   sdf@google.com
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        YiFei Zhu <zhuyifei@google.com>,
        Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/05, Alexei Starovoitov wrote:
> On Tue, Aug 4, 2020 at 12:42 PM <sdf@google.com> wrote:
> >
> > On 07/29, sdf@google.com wrote:
> > > As discussed in
> > >  
> https://docs.google.com/presentation/d/1A9Anx8JPHl_pK1aXy8hlxs3V5pkrKwHHtkPf_-HeYTc
> > > during BPF office hours, we'd like to attach arbitrary auxiliary
> > > metadata to the program, for example, the build timestamp or the  
> commit
> > > hash.
> >
> > > IIRC, the suggestion was to explore BTF and .BTF.ext section in
> > > particular.
> > > We've spent some time looking at the BTF encoding and BTF.ext section
> > > and we don't see how we can put this data into .BTF.ext or even .BTF
> > > without any kernel changes.
> >
> > > The reasoning (at least how we see it):
> > > * .BTF.ext is just a container with  
> func_info/line_info/relocation_info
> > >    and libbpf extracts the data form this section and passes it to
> > >    sys_bpf(BPF_PROG_LOAD); the important note is that it doesn't pass  
> the
> > >    whole container to the kernel, but passes the data that's been
> > >    extracted from the appropriate sections
> > > * .BTF can be used for metadata, but it looks like we'd have to add
> > >    another BTF_INFO_KIND() to make it a less messy (YiFei, feel free  
> to
> > >    correct me)
> >
> > > So the question is: are we missing something? Is there some way to add
> > > key=value metadata to BTF that doesn't involve a lot of kernel  
> changes?
> >
> > > If the restrictions above are correct, should we go back to trying to
> > > put this metadata into .data section (or maybe even the new .metadata
> > > section)? The only missing piece of the puzzle in that case is the
> > > ability to extend BPF_PROG_LOAD with a way to say 'hold this map
> > > unconditionally'.
> > Should we have a short discussion about that this Thu during the office
> > hours?

> Of course. That's what office hours are for.
> Since google folks have trouble with zoom I've added google meets link
> to the spreadsheet. Let's try it tomorrow.
Ooooh, thank you for the Google Meets link :-)
