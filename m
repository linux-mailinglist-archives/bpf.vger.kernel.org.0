Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D096732315F
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 20:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhBWTXY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 14:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbhBWTVz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 14:21:55 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E498DC06174A
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 11:21:14 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id u3so17641797ybk.6
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 11:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTmXA66KAzs1/DFCo1UHG53JqVDirhjPx9owwUzw6rY=;
        b=ttMeFCxo4jfJm6Oml8Ptd+y/iewpWvFI4A0YhiQM1+bsHeMjeO92HB2mKi41/fybiN
         4nvFP4VDUCWnk85ZHAFtfNaDqrHgAsz5q/D5BmRwsQS0xY91CH5MFYq6Gewfx9WnCnhY
         IIWePvXBJFDglTvoiYyhEXrQ21fpCY+48Nr0xbmx8jH4oo8LGPnh/U/crvnHt2RPsKYC
         hlNPYNbMT7JgcIotBhnUKQj6CWvsPWQk/jdzW6/GM1h7sO+qe0VRopvgYiykzd+MlFSp
         6MAZRppfmMnm9vLFfi0ZQBqOCFZch/TKzJVHC+Hh4SdxRzFuRkMDnHrlsUz/Fcn8PQjH
         GD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTmXA66KAzs1/DFCo1UHG53JqVDirhjPx9owwUzw6rY=;
        b=uFEhRc01+XuzLkZfK8W06+ssE/UG+UMI3MM6q+kH0V5w0TVS10VhPWvZ0hGFfoNn1t
         ZMJN96gqI/QCUsQ4A16RLNHdUwcSQuAhLWGu7utRunW+QPGksVkYiIVeULudcu00/cwz
         dm6TC/XZ94H7xacTabPw66e98TuTgxExNjsv9i+bkQ1LEcwORWTgW8252ebuft3yLJdJ
         oKxg6pnWxIwQMoNhjirMVDSNxlZQ034s36mnj9wq+SLpTcehqe01y2HX3eR71POkPHNh
         Fn6I4uyGmj602JLRym2lnBdf0HpwEHG5oH1UMUQWQ+Hmf6VYCX7kVBsqJH8VKDXSIkEm
         4Enw==
X-Gm-Message-State: AOAM532Qk75qYkoQ7riupm9I99bTvwgMAZl80HSfLmzFSBts7Ws7xQN8
        2cvUmn1Ww8TuQXBlL67WApwJYh7lc2EP0BD3nsI=
X-Google-Smtp-Source: ABdhPJzpcUiYqWg1tzisq6Bsnk9H/SX9aMeTtEEc+p8S+qrM175V2mnohJuJzDA4wxniPsSySUi9XY/Hrhgjl2a61rc=
X-Received: by 2002:a25:abb2:: with SMTP id v47mr41671649ybi.425.1614108074219;
 Tue, 23 Feb 2021 11:21:14 -0800 (PST)
MIME-Version: 1.0
References: <20210217181803.3189437-1-yhs@fb.com> <20210217181812.3191397-1-yhs@fb.com>
 <CAEf4BzZwEDQwMiXthy2Q32F3Qt1X4sTg92w8HZL7PbMB_FtYtg@mail.gmail.com>
 <b20cf48f-fa7c-1397-fc47-361a9e8edecf@fb.com> <a97068b4-2428-bc0b-0978-95d5c1f50752@fb.com>
In-Reply-To: <a97068b4-2428-bc0b-0978-95d5c1f50752@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Feb 2021 11:21:03 -0800
Message-ID: <CAEf4BzZOTAVgRSF+DKWidCEYvtw=5UNid-WUpOab2LKoy3D7SA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/11] libbpf: support local function pointer relocation
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 23, 2021 at 11:08 AM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 2/23/21 10:55 AM, Yonghong Song wrote:
> >> BTW, doesn't Clang emit instruction with BPF_PSEUDO_FUNC set properly
> >> already? If not, why not?
> >
> > This is really a contract between libbpf and kernel, similar to
> > BPF_PSEUDO_MAP_FD/BPF_PSEUDO_MAP_VALUE/BPF_PSEUDO_BTF_ID.
> > Adding encoding in clang is not needed as this is simply a load
> > of function address as far as clang concerned.
>
> Andrii, I had the same thought when I first looked at it.
> The llvm can be taught to do this, but it would be a change in behavior.
> Older llvms will generate relo while new one will not.
> To ease adoption libbpf would probably need to support both.
> Hence no real need to tweak llvm.
> If we go with llvm only approach my ongoing work on naked functions
> would require to tweak llvm and libbpf again.
> While the llvm does the same relo for naked funcs already.
> So I will reuse this libbpf support as-is.
> Only for &&label and jmptables the extra llvm work will be needed.

Yeah, that's fine. I wasn't complaining :) It would be safer if LLVM
emitted the intent, but it's fine, libbpf seems to be doing fine
inferring it. I was also under the impression we do get BPF_PSEUDO_xxx
for other types of relos (for whatever reason), which is not really
the case.
