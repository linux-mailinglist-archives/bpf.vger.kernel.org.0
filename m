Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749A3109BE
	for <lists+bpf@lfdr.de>; Wed,  1 May 2019 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEAO7i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 May 2019 10:59:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33060 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfEAO7i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 May 2019 10:59:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id b188so1496469wmb.0
        for <bpf@vger.kernel.org>; Wed, 01 May 2019 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwZ6MdL5R5AOerbVDItJqenvqXbPYw3Q89hSGLypnfM=;
        b=A7Any30y+Ixmf+Ti12t1rhXwX2O0gO0UWQdiQn6QI93upvjR4Kwm7YLr6FD7pAJrvF
         NVVpOPacWFu1v/qyeSm8nIGBnOOBfkZAKd52940lplB3Ql5ZZMILEppZUbvPZ1ulY98T
         yHskaCo+N9hjxNRUues88jFU7yQUTGwA9pLeC157ONj5agcljACRHDv28kkvAJvBhV/w
         8yTf+v5Fwv7BHcyDwyCHYETEoQ0tphjlzZAglWWFgeCILVH/qziO7wCW0IkyZLOfDOdB
         SLZ2qyNSxnOm2ZNci/BpJRaheHCc3ePdyEZ4ceD/KDoHXCcqkMXHsuMC9vq3HAOQ3rzB
         Oj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwZ6MdL5R5AOerbVDItJqenvqXbPYw3Q89hSGLypnfM=;
        b=aAzsvpMhVv0DAItHJHqlCw3npE6DndGm3f0sjeREYFUsEOgXbArKaWyWGJHOcf6+zh
         j8TH+5xIylBjxkdkjQGwgfy7mSS2/mpW0vAS2SIIcjgRoySZh3lft2QAaRkcc58VH3UZ
         vWqTWYSUgcwiicK6mtUX6I1MjbmvkKDp2bXmCtf6Zx7BAVZVOhz0taHMS83WfiWH+Qem
         /YCtBUElyhw1SO0sY4C5+enLeWoVyx4zRgdjMKHUZwDAp+N13FmPiMLehkpUaExHFzK5
         G+4O/Km4+wIo8NUcE5KG3xIlbMxQp7Ya/Ztp+naQZZJOS419mFgvKuSDP4B5n3CdyJT7
         9Z3A==
X-Gm-Message-State: APjAAAXymX3M6F2bhAmBgR4YGQgv2a3vaDYg44r03W1bq2S2rIHa8PZZ
        rNNnjaFLETZbIQl1El8dhlTjFmFMGtgfT+l5AK+OJg==
X-Google-Smtp-Source: APXvYqxupOpdlAgq4mdMFssyDUB6fHCFkMjNBzRsPQDZ+ywudw0oP++fFWfCkpUGDgb51g73ZVV83nqftjInNrc4Er8=
X-Received: by 2002:a1c:35c3:: with SMTP id c186mr7433197wma.135.1556722775680;
 Wed, 01 May 2019 07:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190412214132.2726285-1-ast@kernel.org> <lyimv3hujp.fsf@netronome.com>
 <20190425043347.pxrz5ln4m7khebt6@ast-mbp.dhcp.thefacebook.com>
 <lylfzyeebr.fsf@netronome.com> <20190425221021.ov2jj4piann7wmid@ast-mbp.dhcp.thefacebook.com>
 <lyk1fgrk4m.fsf@netronome.com> <20190427030512.zs3tfdudjbfpyawh@ast-mbp> <760D400C-2548-41B6-AE34-F89A66397A75@netronome.com>
In-Reply-To: <760D400C-2548-41B6-AE34-F89A66397A75@netronome.com>
From:   Jiong Wang <jiong.wang@netronome.com>
Date:   Wed, 1 May 2019 15:59:22 +0100
Message-ID: <CAMsOgNDumbU7EWmOpwUoXdM5QWZ8h=W5nG3_JTFU5Tju-ofg_A@mail.gmail.com>
Subject: Re: 32-bit zext time complexity (Was Re: [PATCH bpf-next]
 selftests/bpf: two scale tests)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > if you can craft a test that shows patch_insn issue before your set,
> > then it's ok to hack bpf_fill_scale1 to use alu64.
>
> As described above, does the test_verifier 732 + jit blinding looks convincing?
>
> > I would also prefer to go with option 2 (new zext insn) for JITs.
>
> Got it.

I followed option 2 and have sent out v5 with latests changes/fixes:

The major changes are:
  - introduced BPF_ZEXT, even though it doesn't resolve insn patch in-efficient,
    but could let JIT back-ends do optimal code-gen, and the change is small,
    so perhap just better to support it in this set.
  - while look insn patch code, I feel patched-insn need to be conservatiely
    marked if any insn inside patch buffer define sub-register.
  - Also fixed helper function return value handling bug. I am thinking helper
    function should have accurate return value type description, otherwise
    there could be bug. For example arm32 back-end just executes the native
    helper functions and doesn't do anything special on the return value. So
    a function returns u32 would only set native reg r0, not r1 in the pair.
    Then if the outside eBPF insn is casting it into u64, there needs to be
    zext.
  - adjusted test_verifier to make sure it could pass on hosts w and w/o hw
    zext.

For more info, please see the cover letter and patch description at v5.

Thanks.
Regards,
Jiong
