Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D3349EA44
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 19:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbiA0SV1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 13:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiA0SV0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 13:21:26 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85BFC061714
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 10:21:26 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id u130so3375741pfc.2
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 10:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cju3nifTKKUK6H86ANdteppMEv77ZEUpYOv9PC19Uu8=;
        b=fz38Ko3bcUBeNoGTUFiL2DH/g2JarLMtg3NnUDNkAor9fh7E5yPdKB0Hz8P3sxQ9rp
         56uad/aU4IKoQCoWVoszsWTRnLjHMXABtNrFlxbg+1QuSF1IrlHnwJAnkOjlZ0T+bb1y
         82v7mLSfZchQhKgsb5OVPEKzAHXCKcb2VM0y2hEukPJbLu71UWopw2TxUvIRCf7dQEzD
         7f5FR/Wt0dneKNAIDV9e0VF6effJPo1pZU5inC2q1UUavbWfQgqzgjiRb/O4iiDFYodF
         sdQr8XWFtmizyKTEW/CdirBmLWo9GEAc7Oo+HY32UoYP8cV4dgA3Ma8JMivpB2ymqNW0
         qlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cju3nifTKKUK6H86ANdteppMEv77ZEUpYOv9PC19Uu8=;
        b=8RD5HFV+4XxP0EduTZh/ncGnqjXLAVWBoDrnvCgiNvKNDtTq3v9yZYLxtUW3k4WYAE
         aAo7l7wnWub5kzlQ0mGjLobqH6flOgZPYPTkrR5eUuAbZjn4akTj3wXDv6ZFMT9MBESi
         ej9Zny/UZJzfVVWBJ0wkLxCdbB7rDSBqcni8+Bnvl8ekfm38ToSwc7CoDztq2TOWJR9f
         UKoF+4w6rQaP9X/9Cqywh7zqy1rxcf6dPVHyDCFcOx6YF/0qq4e86eohRJe6jBfw1HWY
         aXaKQ+XzDeTC1ZEuU3vMCJjJMIINGn3pbk1ojqeWeq53x15FUpkVDe2RMcIJpkNvGyWX
         wwSQ==
X-Gm-Message-State: AOAM532h6U5vsb6JSNhz0zkkrYgFTKbUc55XtwrFdtgxYhX+fuX6yGXU
        FKIvEJ5fQX4jroeIHMAN2WdCSgTYEWXsMj2r2ACPLE/c
X-Google-Smtp-Source: ABdhPJy9QOsQMBaxWemODEJwt6HBMdqAA5mKj2TYK6OA3n2z9UzwQHs+g90JaBOzFHQgZ6rmQC+RfIOrCXe6SIRX8WY=
X-Received: by 2002:a63:580d:: with SMTP id m13mr3497759pgb.497.1643307685808;
 Thu, 27 Jan 2022 10:21:25 -0800 (PST)
MIME-Version: 1.0
References: <d8c58857113185a764927a46f4b5a058d36d3ec3.1643292455.git.asml.silence@gmail.com>
 <20220127180854.i6snxqt4r3eq4huv@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220127180854.i6snxqt4r3eq4huv@kafai-mbp.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 27 Jan 2022 10:21:14 -0800
Message-ID: <CAADnVQ+LU+HZKVQ37ZeWQtj4xdk3wTSN_HGA7b54rXa9Ta4DpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6] cgroup/bpf: fast path skb BPF filtering
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 27, 2022 at 10:09 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Jan 27, 2022 at 02:09:13PM +0000, Pavel Begunkov wrote:
> > Even though there is a static key protecting from overhead from
> > cgroup-bpf skb filtering when there is nothing attached, in many cases
> > it's not enough as registering a filter for one type will ruin the fast
> > path for all others. It's observed in production servers I've looked
> > at but also in laptops, where registration is done during init by
> > systemd or something else.
> >
> > Add a per-socket fast path check guarding from such overhead. This
> > affects both receive and transmit paths of TCP, UDP and other
> > protocols. It showed ~1% tx/s improvement in small payload UDP
> > send benchmarks using a real NIC and in a server environment and the
> > number jumps to 2-3% for preemtible kernels.
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Applied. Thanks
