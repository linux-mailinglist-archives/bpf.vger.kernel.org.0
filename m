Return-Path: <bpf+bounces-5428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7818175A7FE
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 09:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD36C1C211E5
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 07:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E776171D5;
	Thu, 20 Jul 2023 07:42:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A4CA5E
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 07:42:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F2C2118
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689838931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJtpCG9zhhGX7NtLxzTudWbkt/DuRh61nie9AceVl2I=;
	b=g12sMbNC9EmjBQe7cUbwWqv391x8cEp1re1RCWVN/yI1sa8/c+pfCAdweBwe7UWYBhRku6
	Ez3MONLo0HfPEGYJuOBfymvMWobEywfceVMKDU26gvP0udLCc3YCOGattDb0chk2LrGJ//
	+oNTqi2ExWwpCuiw9MQhv2XWpkSFn3I=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-XCjAIhihMWaWnIXUKpfgZw-1; Thu, 20 Jul 2023 03:42:09 -0400
X-MC-Unique: XCjAIhihMWaWnIXUKpfgZw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b703a076ceso4633331fa.1
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689838928; x=1692430928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJtpCG9zhhGX7NtLxzTudWbkt/DuRh61nie9AceVl2I=;
        b=ctjF+R0Y2aZvhVigrofPZUt6AmqZUowioj/H/zwd8padvjwIdC4mHKEVik+QJaCbLD
         WoYPa2/nIDKsDtR/EHoBD3WsmrOTW0HjuZZ1T5rjNt8c5Qc6xDbg6+m9gY4u6g3P7oG3
         YY0bTM9jKvwelMsjDl7XpHwDM31e4y0cp5BuNYVOel4zvCJnXNcQtwtrg9j7wfxtCcW5
         CTh4zhCR25vdWumknAzBt4pSc7+80kCobMnhcO3n+bKQt4YpGiuvIrJXPmvqMZLGck2R
         F6ijpJxtBcS/Iq6g0VFT/enkgr9fzLm3Wb12+cIdA1E7iNjSnepmXoVwwFvEYnFNi7Q9
         VRTw==
X-Gm-Message-State: ABy/qLbEIXuY/hfN/gAOVLA/fF5KUfocYs9lqFDyiZH7XRUvg+AXnchy
	qlRIwODO8ywBjeIV+Tt7Kk3+WiX3QPxvhqXbyofGr4lIWx7DPZ/aoHHWZm3mKsuq8c/OMYcR7s7
	XsiAMO0+58DZ/ulua55SBuvLhW0cG
X-Received: by 2002:a2e:b705:0:b0:2b9:5fd2:763a with SMTP id j5-20020a2eb705000000b002b95fd2763amr1615012ljo.35.1689838928242;
        Thu, 20 Jul 2023 00:42:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFu+k5ZrMkQd2anF8aWE9EZzH1m96rLrkmjQzi71csOsVj3MZfM8zyG9H1kdd7cZfq4E2nEHoiz7btC/Za/LcQ=
X-Received: by 2002:a2e:b705:0:b0:2b9:5fd2:763a with SMTP id
 j5-20020a2eb705000000b002b95fd2763amr1614992ljo.35.1689838927964; Thu, 20 Jul
 2023 00:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-11-xuanzhuo@linux.alibaba.com> <CACGkMEtoiHXese1sNJELeidmFc6nFR8rE1aA8MooaEKKUSw_eg@mail.gmail.com>
 <1689231087.0744615-2-xuanzhuo@linux.alibaba.com> <CACGkMEsf4+56veqem1HMWiqYhiW5LVw-1CbWX-cQSN6Z0zYMRQ@mail.gmail.com>
 <ZLjS4D7urgIK1MxV@infradead.org>
In-Reply-To: <ZLjS4D7urgIK1MxV@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jul 2023 15:41:56 +0800
Message-ID: <CACGkMEsbzWU3+pA1kLNwGEmwYjP9riRANpUtsmE-YXJmnFAuhw@mail.gmail.com>
Subject: Re: [PATCH vhost v11 10/10] virtio_net: merge dma operation for one page
To: Christoph Hellwig <hch@infradead.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 2:23=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> Hi Jason,
>
> can you please resend your reply with proper quoting?  I had to give
> up after multiple pages of scrolling without finding anything that
> you added to the full quote.

I guess it's this part?

> > > You should also test without iommu but with swiotlb=3Dforce
> >
> >
> > For swiotlb, merge DMA has no benefit, because we still need to copy da=
ta from
> > swiotlb buffer to the origin buffer.
> > The benefit of the merge DMA is to reduce the operate to the iommu devi=
ce.
> >
> > I did some test for this. The result is same.
> >
> > Thanks.
> >
>
> Did you actually check that it works though?
> Looks like with swiotlb you need to synch to trigger a copy
> before unmap, and I don't see where it's done in the current
> patch.

And this is needed for XDP_REDIRECT as well.

Thanks


