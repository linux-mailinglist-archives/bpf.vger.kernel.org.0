Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8559EFB1
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 01:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiHWX2K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 19:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiHWX2J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 19:28:09 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB308035C
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 16:28:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u9so1381913ejy.5
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 16:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=x1Fp+IpyDwn/4d3aB5wFR8uoRKJQYECGEKILP2rZCVw=;
        b=higVv8uTGKmFPhm3BNJ4bT4PhUTvv8duLp2vhvQCYNSYUuxkdCSaesUS7kjxKZCcpU
         AOT62TYhaWzo6V5SFDxiqaaJYFHvYRqtzmOLRBQrLsEjA/d4ONy5Mtm++Sp3EaK19yvi
         1WhAk7muXJcFnTV+/qL59tOCev+tIWNyPzzCY2whKFf8SuN26f/iHopkS91rxgpbdw3L
         824NGbsC6Qb/2TRU2P4WOi+9RB/TK1RxwlHd5mcIGWg3vuMGl7kCyf2VyuZ8+z20mCMj
         0Z++FQESQ7U5tSYvkF1u0wPzUN2BR7TyfmYea1+4Oz+7TiexgPEM//Nr5b2lzv7UHoQY
         d63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=x1Fp+IpyDwn/4d3aB5wFR8uoRKJQYECGEKILP2rZCVw=;
        b=A7iUP/nLKtXov/Bnb0gIfOHOoArqFTM2oG//RCiFSRbdIE2NzyOcc8F5Wkv4B5Fc68
         gTM9lg4S7PbvnZE09Z3AxnF/6eJgzYT5TdZ9+AbI3r3X3EC2nG887AHx2vSGyLmOZGYX
         jP0UvtbQy8b7XYh+J81XYPTS44LI3ImosDxoRll7/I9/U7BtvG75BRoHAZTzkGWFWBy9
         SLo5guINr4VNt6VFuEFzqr9BxQk2nlPK9U65jP7pznsXh+SwpW9K2Dh/MN9GpBTYz6D3
         Vi/oZSSMzdRJmsYHAqyWfd4SRNIYXFkGjzKj64odwy6rsktW5GNsEfRgnzpz+ZWRe5U/
         yM3g==
X-Gm-Message-State: ACgBeo2MAB7rZwX9HYtlL89L8YL/NbWiCIqhEBOmTlld0Oao4O6ABluj
        vd2EX3wVo9PWAkBL3RCYq9WzfnkUoEH2yVmtIcfM5Qd1
X-Google-Smtp-Source: AA6agR4bf9qxByNADNsB24OFWcrRbzoIV3BhwURnkZtgdfm+1GQLj3RfQs+UUK10rjjtEnBQ2tz7Hwx3QGeOG2tIn0s=
X-Received: by 2002:a17:906:a089:b0:72f:826b:e084 with SMTP id
 q9-20020a170906a08900b0072f826be084mr1213219ejy.708.1661297287198; Tue, 23
 Aug 2022 16:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220822131923.21476-1-memxor@gmail.com> <20220822131923.21476-2-memxor@gmail.com>
 <630490024ded0_2ad4d7208e3@john.notmuch> <CAP01T75DOMXk0Z6FoOT7n7tcb8f+hMQ-W1HC_VfGqe+hBh+Gcg@mail.gmail.com>
In-Reply-To: <CAP01T75DOMXk0Z6FoOT7n7tcb8f+hMQ-W1HC_VfGqe+hBh+Gcg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 23 Aug 2022 16:27:55 -0700
Message-ID: <CAADnVQKjfvdqOegpmrGbt6wVkzhyUsUt8ysEEgbAKS8d_OVS9w@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/3] bpf: Move bpf_loop and bpf_for_each_map_elem
 under CAP_BPF
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 23, 2022 at 10:36 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 23 Aug 2022 at 10:29, John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > Kumar Kartikeya Dwivedi wrote:
> > > They would require func_info which needs prog BTF anyway. Loading BTF
> > > and setting the prog btf_fd while loading the prog indirectly requires
> > > CAP_BPF, so just to reduce confusion, move both these helpers taking
> > > callback under bpf_capable() protection as well, since they cannot be
> > > used without CAP_BPF.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> >
> > This should have a fixes tag IMO. You'll get unexpected results if we
> > don't have get it backported to the right places.
> >
>
> Hm, I was unsure if this requires a Fixes tag. It's technically not a
> fix, it's a minor reorg in my opinion (could have gone through
> bpf-next as well) which has no real resulting change for users loading
> programs, and makes things less confusing. The actual fix in patch 2
> is independent of this change.

Pushed to bpf-next.
Such corner case fixes are too risky to go directly into the bpf tree.
