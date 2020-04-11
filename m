Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1420C1A53F5
	for <lists+bpf@lfdr.de>; Sun, 12 Apr 2020 00:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgDKWmT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Apr 2020 18:42:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44414 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDKWmT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Apr 2020 18:42:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id n13so2684352pgp.11
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2020 15:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ztl26xUGlKd6MFW++izFLO+4DwtPEbVAJx37Xe1HyAY=;
        b=Gq1Kb6Wem25hMC+uv1fmWlbkoF2Qw42bl9WyxJeuZePGRgR2bQ73XWr2j7hnMAcSRn
         mHSDvVFmfsro6ieoXLcnno+8vrLpmEpdlH7kOW9HGEyYHcEq2zkp3x95XhoIvEONh3DD
         Si1mNucyuV2DFqfEM3VewsKymtTF7kGFA6XGCbKr+gpW9wInQXAZteZjKVtUYbreKHC2
         URBEfOi81FEPtG/q2LTFKcRSXFZ/ISoKgVmpM2N0l/x2ejOxW5QdJLT+D/V1rxxpVrc3
         CYchGHM1GT0FCgTzbpQPFGuggmFkWGCF+hPZSblts4k01IGro3httLDIFn6IKcTd/R0u
         Fk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ztl26xUGlKd6MFW++izFLO+4DwtPEbVAJx37Xe1HyAY=;
        b=SNMgjRftgPjhFdErZ+G7U3e/kWLGzPWz8wh5yOu3Ctj/Ahqql3xQqiEV3PYLX9f1EI
         KUHiG/O0065mp/2lheXewRXiEzJE7d5q3JBUIHs8UlnpxHUPbPQ7tN8+e7/jXCg7VtUE
         qlD/PwYsGfrBEt1wCRzj+WTu7kLghDuR8U/ttwV3ZEqrwL/p/nB8Su8WhEky8danzL6d
         zpStdUJXE+LKoLOMHaeS2jl4h9QQyrUoQneHiQFdwYq7NJkR1ZNMVB68W9KojmqgqsQV
         7IJHq2HZnXie2VUZWApN4IoS68samlOGvfQdLVZjlcXUMLqQ5VVUO3fSmSqweYNWQTKu
         eXGQ==
X-Gm-Message-State: AGi0PubSxCnHJwwraHd1vXzyzRS9idkT3id0CWF5yNn1AV5w13EoImc0
        agwt+yqUM7M+S7M+wKaQ6bk=
X-Google-Smtp-Source: APiQypLsUDu9CZ4jiXXSfVwvHwJ61g1gxNI1ZpFx72OykPZ5MJGpm/gN7r5x70OpA05NKv0gVax0Vg==
X-Received: by 2002:a63:df01:: with SMTP id u1mr10768815pgg.166.1586644937261;
        Sat, 11 Apr 2020 15:42:17 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:507f])
        by smtp.gmail.com with ESMTPSA id p12sm5112259pfq.153.2020.04.11.15.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 15:42:16 -0700 (PDT)
Date:   Sat, 11 Apr 2020 15:42:14 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf 1/2] libbpf: Fix loading cgroup_skb/egress with ret
 in [2, 3]
Message-ID: <20200411224214.32hiebejlsl2rc2k@ast-mbp>
References: <cover.1586547735.git.rdna@fb.com>
 <daa546903aa74cf844452b7f80788d67c15b42ea.1586547735.git.rdna@fb.com>
 <CAEf4BzYvPawqgdP+cU94+US=hKGaD8qCBFtnu_JZae3eJ0+SUw@mail.gmail.com>
 <20200410225739.GA95636@rdna-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410225739.GA95636@rdna-mbp.dhcp.thefacebook.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 10, 2020 at 03:57:39PM -0700, Andrey Ignatov wrote:
> 
> > Seems like kernels accept expected_attach_type
> > for a while now, so it might be ok backwards compatibility-wise?
> 
> Sure, that commit is from 2018, but I guess backward compatibility
> should still be maintained in this case? That's a question to
> maintainers though. If simply changing BPF_APROG_SEC to BPF_EAPROG_SEC
> is an option that works for me.
> 
> 
> > Otherwise, we can teach libbpf to retry program load without expected
> > attach type for cgroup_skb/egress?
> 
> Looks like a lot of work compared to simply adding a new section name
> (or changing existing section if backward compatibility is not a concern
> here).

I still don't understand that backward compatiblity concern.
Fixing libbpf to do BPF_EAPROG_SEC("cgroup_skb/egress"
will make egress progs to fail at load time if they use > 1 return value on old
kernels and fail at load time for > 3 return value on new kernels. Without
libbpf fix such progs would rely on old and new kernels internal implementation
details. Since on the latest kernel with current libbpf behavior the egress
prog will get loaded as ingress type with return value 4 and then gets attached
at egress. Argh. One really need to deep dive into kernel sources to figure out
what kernel will do with such return value. Such behavior is undefined and broken.
Did I misunderstand the whole issue?
