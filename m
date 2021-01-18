Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1692FA2F5
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 15:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405033AbhAROZ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 09:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404946AbhAROZO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 09:25:14 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708E4C061573
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 06:24:34 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so9400915wrz.0
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 06:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RwHCiPZ3k6rKU9HgYXsJpMTWS3X7HJ6axuJ87Yi9CqQ=;
        b=N99Yh/Jvy30ktSLQs+FtwuHzvD86WJliq6aK2lYhUSoswxmXzWD5EsBQPvxOPYYFk9
         ewKURV3TIt2AoF9a4pvYCRBwP6gdsghJy13LR4daGTSR+nV4E85uZMCMN1JWRDA5zQ+S
         DHbnf+7ptX0RcjeUipYWve3+qhRrdqM6B50QyBDNW6FA5iLc6zk9/N7pEdqaC60skKQ0
         JyPp3bGr78V8VwWIowllgrktmzPl+LWwahC6/UugNnQJGwRQu2vC2VqJXRGOtz7288ND
         wMkBEFt243hFHtQ8isJCHQmJK8XATBbM4C7yetIpi+QbrK0reHDCIcLKqsNU69FqfgvT
         gqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RwHCiPZ3k6rKU9HgYXsJpMTWS3X7HJ6axuJ87Yi9CqQ=;
        b=uGmp5otlAFKS59Itqc7YBP+/vKBlXKvCAf/PmEwp6i4Vo5mieNedfXmK9a8N7o3Dkc
         BO3BHMjk0fiOvueToZ1yyBFC/scx2kjHVyMk+wLli66vQhvnjBtDcxwZ5tjJ5LOC+S5W
         sPi2Xiikvum5TWHRd9v17//SPUWy6inPiXg6l0Xw4R97O9cx6WSQfyShfOJkfuu+ieZd
         Rnoc4nv+mQIaH7bSjnx+42s+qU3fUVxUkDCHJQhJQBd9m/Kuks8/3akD7kYTd9nb6oTx
         G0RJe2zh1rKCLn6hyzAGqbK87aoueAaFMRab1+IWSfJU05VUFnbxTN/gmZafM9eG13IT
         C4ZA==
X-Gm-Message-State: AOAM5314XQmg+qJmbthIqfaM7pqFyn2DW31ZhFLOG7Us9Q0QdMwmC8w/
        h+rHMQOLSdOLa9vC9I3UNKF9u6jJ3WBdBB+yVec=
X-Google-Smtp-Source: ABdhPJzQnq4PzH5jturPL+yofvENlkcQ2jc990GymOjlluWTmuTihpVjDHdVhlt8oVRaYr8Tg+DKE9d1Eyfz9MUnDyc=
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr25738276wrx.176.1610979873110;
 Mon, 18 Jan 2021 06:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20210118144101.01a5d410@carbon> <CA+i-1C1Te+c876s3JYSE6o7fw+TaTbC7TnMmyw8kx5Tg1jUxNw@mail.gmail.com>
In-Reply-To: <CA+i-1C1Te+c876s3JYSE6o7fw+TaTbC7TnMmyw8kx5Tg1jUxNw@mail.gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Mon, 18 Jan 2021 15:24:21 +0100
Message-ID: <CAJ+HfNiZY9VSNiJKaqD5LSz7ghEd9xrFzYJUZ3cUk9XJFrtCQw@mail.gmail.com>
Subject: Re: Issues compiling selftests XADD - "Invalid usage of the XADD
 return value"
To:     Brendan Jackman <jackmanb@google.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 18 Jan 2021 at 14:47, Brendan Jackman <jackmanb@google.com> wrote:
>
[...]
>
> Yes, since bpf-next commit 98d666d05a1d970 ("bpf: Add tests for new
> BPF atomic operations") you need llvm-project commit 286daafd6512 (was
> https://reviews.llvm.org/D72184) for the selftests, which will be in
> Clang 12. You'll need to build LLVM from master.
>

I ran into this as well, so a (shameless) plug: for folks running
Debian derivatives, there's https://apt.llvm.org/ where you can get
daily Clang snapshot builds.


Bj=C3=B6rn
