Return-Path: <bpf+bounces-9674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAD379AA77
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 19:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080501C208EC
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0E6156CA;
	Mon, 11 Sep 2023 17:11:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5D8F5F
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 17:11:06 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371431A5
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:11:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e7e70fa52so4335427276.0
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694452264; x=1695057064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ksoAdVf3diYWyebJH6G4pxq2k4gkSHQp29Mr0okOto=;
        b=mxIIhj+FpJoxNBEAlL64KadxRvdIH/dV3TGXKlq97w4nqbeaQG11xB2pTebldMy1qX
         51+lE27pOK7fZ6elR+uTH0vUcvhJBCozrtjhJKjdCeMWcg8nW6Er4jTcMsIj9djA8LiY
         aaHX9BITirvQbj2rPRT1FAv+PdapVNip22hA3LWf+8Ckl2dbwRCXvmAYSEEwxr5wXgNZ
         eHBuq5Edy22f1SCtxIKgb9U/UbsZdTiGaJD8P3miyntVnBsl+8vpEC2g0U6qztNizrmg
         XfAeuD81PVGTbXjyf7XNWGGxCpe41sSzmfYRzoRsgMvAWyMlMSFzDNv3UtxVqkKDNf3y
         4yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694452264; x=1695057064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ksoAdVf3diYWyebJH6G4pxq2k4gkSHQp29Mr0okOto=;
        b=byxGhTV8XBEOMSclpUgfvYk3bGjV1xJv9urZyOXZsOmpJLkSFdpor1RGPbm6W8tBAv
         4YemuPnIQ8qPCRFW0f1Z5e/evCbIfDT+5uNX7N4oBdUtSxYxyF6dDCcosXmDalWV/1Qg
         yYqSkSlVU3DkZjLDzYPBFa4f+rN0EzQxlX8E23GkhKgWo+YBgT2DsYttkP0qRAcN+2P1
         VMk2TL/2ZrIrBr9oVVU+8MDRBWxHG7PKCWAkLSNyDxoeW7g0U597OzAvYY2G9wWUiabz
         SKGLOCSpbpQ/g5Dxt2QCxnIi3Hr91+ZpBWq+yXme2UvcHoF2pDkk/umMGFfPZKMi7EI1
         PG+g==
X-Gm-Message-State: AOJu0Yyjs81wQFUizv9vS3wPqbZIm1TIT8xZBgwz7/7QnsmXceQkfKXf
	y7/sZq1+2c5ZAxANvRu3TMkgS7w=
X-Google-Smtp-Source: AGHT+IH/nhvRzSzgehnphFCBApP3sInfD5uFshB7CdO5gA4I2h4ZilOL8nNcXjhLjN2+R1xIpE90k9U=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:aa73:0:b0:d72:8661:ee25 with SMTP id
 s106-20020a25aa73000000b00d728661ee25mr214890ybi.2.1694452264473; Mon, 11 Sep
 2023 10:11:04 -0700 (PDT)
Date: Mon, 11 Sep 2023 10:11:02 -0700
In-Reply-To: <acdb12bc-518a-c3f6-ef09-2dfd714770b5@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230908210007.1469091-1-sdf@google.com> <acdb12bc-518a-c3f6-ef09-2dfd714770b5@linux.dev>
Message-ID: <ZP9KJpQIpoYqzaB3@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: return correct -ENOBUFS from bpf_clone_redirect
From: Stanislav Fomichev <sdf@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09/09, Martin KaFai Lau wrote:
> On 9/8/23 2:00 PM, Stanislav Fomichev wrote:
> > Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
> > packets") exposed the fact that bpf_clone_redirect is capable of
> > returning raw NET_XMIT_XXX return codes.
> > 
> > This is in the conflict with its UAPI doc which says the following:
> > "0 on success, or a negative error in case of failure."
> > 
> > Let's wrap dev_queue_xmit's return value (in __bpf_tx_skb) into
> > net_xmit_errno to make sure we correctly propagate NET_XMIT_DROP
> > as -ENOBUFS instead of 1.
> > 
> > Note, this is technically breaking existing UAPI where we used to
> > return 1 and now will do -ENOBUFS. The alternative is to
> > document that bpf_clone_redirect can return 1 for DROP and 2 for CN.
> > 
> > Reported-by: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   net/core/filter.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index a094694899c9..9e297931b02f 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2129,6 +2129,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
> >   	ret = dev_queue_xmit(skb);
> >   	dev_xmit_recursion_dec();
> > +	if (ret > 0)
> > +		ret = net_xmit_errno(ret);
> 
> I think it is better to have bpf_clone_redirect returning -ENOBUFS instead
> of leaking NET_XMIT_XXX to the uapi. The bpf_clone_redirect in the
> uapi/bpf.h also mentions
> 
>  *      Return
>  *              0 on success, or a negative error in case of failure.
> 
> If -ENOBUFS is returned in __bpf_tx_skb, should the same be done for
> __bpf_rx_skb? and should net_xmit_errno() only be done for
> bpf_clone_redirect()?  __bpf_{tx,rx}_skb is also used by skb_do_redirect()
> which also calls __bpf_redirect_neigh() that returns NET_XMIT_xxx but no
> caller seems to care the NET_XMIT_xxx value now.

__bpf_rx_skb seems to only add to backlog and doesn't seem to return any
of the NET_XMIT_xxx. But I might be wrong and haven't looked too deep
into that.

> Daniel should know more here. I would wait for Daniel to comment.

Ack, sure!

> ~~~~
> 
> For the selftest, may be another option is to use a 28 bytes data_in for the
> lwt program redirecting to veth? 14 bytes used by bpf_prog_test_run_skb and
> leave 14 bytes for veth_xmit. It seems the original intention of the "veth
> ETH_HLEN+1 packet ingress" test is expecting it to succeed also.

IIUC, you're suggesting to pass full ipv4 or ipv6 packet for veth tests
to make them actually succeed with the forwarding, right?

Sure, I can do that. But let's keep this entry with the -NOBUFS as well?
Just for the sake of ensuring that we don't export NET_XMIT_xxx from
uapi.

