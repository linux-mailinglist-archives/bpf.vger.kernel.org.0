Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725F824E1E1
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 22:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgHUULP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 16:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUULN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Aug 2020 16:11:13 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE4EC061573
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 13:11:11 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b16so2948808ioj.4
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zZSOcpy1P/zNsT/51IFI9bOfmzwYPf0Ipi5VIDha23k=;
        b=VfvGA2xVELvGsMnxnrR+yZlJkasdKkvaVU9Vxpo1KioxZowknsB1wtnXwbtP/VtQu2
         ulIGcI9B/9B5Re488GuE3BANYTaw6vlLg++haO+SAwidZRg/fsMBcUBWsOC2AYZFTDL0
         olggIjbes8EbUCFlyVkGxd0C4c2nEcHIm80SDLVdNQ02LzvknoPZIkp9xtSc8ds4j4vw
         +KMxgQjIfSLhtiRWHbPOYCjM8aLXgsCBhsFvQ09uR+hqOYpNUSjGZBO+bJGxPwMt5EK7
         KtYnxmKkzw0VmUKWT+Xsn+L5s+c4wja00RPR8YMCp90YXKLGbVlZZajduXmUuuQXWYdp
         6iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zZSOcpy1P/zNsT/51IFI9bOfmzwYPf0Ipi5VIDha23k=;
        b=Qyx3rBuIRKLjfG27eetB/zeQ8BEK0jc6vZvcfozhsA8t3NMvoBWKA4462DPjoJOLHZ
         Dg1nfYX2Vf9hHQKFGRuYam43hoXZ3peGtjJNzZxZfW2s+iaSYLvYEu+4GkWRwJbQeMff
         7eVM5giNHBJNknQhl/bc1GnsG7ksxAJDIr0BHV0l+ra4HdiHmo3rU7oXvlm01fJ7EkoD
         Fl+VzA9n5m0mJMol11mIOQQp7zxRQP8/Mmz0WY5bztrq1QFxj8TBa8YL7O3H8rnUzTgj
         f+gcHodEfrnu+SpCpuejH1P0pKCJAeNSgOTV3sa9CCkmPSvBqsYss51utVWBM2er70Zi
         SqrA==
X-Gm-Message-State: AOAM533n+AOpD31mtRC2slp287mRF/pbHcStHLa0yQWn2/gYveRVj4QN
        pGOcz7BHPdNxmntSSmGiBAnxyvM3BDtJ411LvSp9OA==
X-Google-Smtp-Source: ABdhPJw+UQyQnO7DbS1+Q/HMuR8ZdrSv2ziQjw0R75FB5mcjWmLCcs3iDRQ0MsF1cq7Qs+V9siVea9WXIgyLhYy+0oA=
X-Received: by 2002:a05:6602:26c1:: with SMTP id g1mr3705695ioo.10.1598040671155;
 Fri, 21 Aug 2020 13:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597915265.git.zhuyifei@google.com> <9138c60f036c68f02c41dae0605ef587a8347f4c.1597915265.git.zhuyifei@google.com>
 <e02ae4a7-938f-222e-3139-5ba84e95df15@fb.com> <877dts5qah.fsf@toke.dk>
In-Reply-To: <877dts5qah.fsf@toke.dk>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Fri, 21 Aug 2020 15:10:59 -0500
Message-ID: <CAA-VZP=Jo0iQRpP+QEmB359C5TS=0BnDHTAzd6yC85aOkEJrsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpftool: support dumping metadata
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Yonghong Song <yhs@fb.com>, YiFei Zhu <zhuyifei1999@gmail.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 21, 2020 at 3:58 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
> Yonghong Song <yhs@fb.com> writes:
> > Not sure whether we need formal libbpf API to access metadata or not.
> > This may help other applications too. But we can delay until it is
> > necessary.
>
> Yeah, please put in a libbpf accessor as well; I would like to use this
> from libxdp - without a skeleton :)
>
> -Toke

I don't think I have an idea on a good API in libbpf that could be
used to get the metadata of an existing program in kernel, that could
be reused by bpftool without duplicating all the code. Maybe we can
discuss this in a follow up series?

YiFei Zhu
