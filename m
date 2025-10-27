Return-Path: <bpf+bounces-72334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF44C0E74A
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 15:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7537188D17F
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D528330BF59;
	Mon, 27 Oct 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGlR3RpS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B0E30ACF7
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575505; cv=none; b=aIg6Mq6wWmB9vfzrbicWXVZIfS5/5SpYipztlGR1f/GAhenX3F6bLImni4+Nxbh3J6c5c3ENJkVjKoJAjfPntVlqBOQLKJU5VNjPkWIQg9ZEjw7pZgnsEqWgwIvmGxUx0faZmrrJXawYbtMYLdYE3pC+Z7OPglU28UH9QG3rbaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575505; c=relaxed/simple;
	bh=QZcXiRDkn2CEe1SMwdiavm/3yNEraVw6q51WtyZeWZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DckgBnqAsdfLvaUlNw+WXaB3Q8+bYtsYGPEZPZF+uX25gdaAqVnoyi5BJX/P56HZnMizqiY6vnLB+c57wC1v/Ju5xoZ/vtEmhsU6T6/1JyMsE5je4eF2QQiz9EulpBlE8IsT7LE2l96zOfqRAPAR3PWVLdlWHiGmJ5sClbjXTHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGlR3RpS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761575502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZcXiRDkn2CEe1SMwdiavm/3yNEraVw6q51WtyZeWZQ=;
	b=AGlR3RpSHrbnA5W66iTC4ABWoTIomVBhxopCJMzIFao124nkiGWIa1farjPdMHwU9Mc5yI
	fiDE0I/np2SQjL+YUTKSpFwQfzW2JsjxkDl9Ff0WkI03sQuNzpf4N65iV/Z24wPaLCwE3m
	9pQpLnASlIccr8P3B0Vu00Oy6f46P7U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-PWSKCkbxPpyBfQs2TVLn-A-1; Mon, 27 Oct 2025 10:31:41 -0400
X-MC-Unique: PWSKCkbxPpyBfQs2TVLn-A-1
X-Mimecast-MFC-AGG-ID: PWSKCkbxPpyBfQs2TVLn-A_1761575500
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-63c2b8d344cso6114373a12.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 07:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575500; x=1762180300;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZcXiRDkn2CEe1SMwdiavm/3yNEraVw6q51WtyZeWZQ=;
        b=DQf6kdJ307JPSHNyVclP5d/D+QTWwxDEIfdpA0qwKP6TKfxCwnoSiC2MRg3PfL+2od
         Leplck5AHEsAUkjaMZieSE3eEHTXyjzBmBIAanDeZW9PbnNwi9DyVpokxFW73r9U4nec
         sDdPkgepctY0i8RjbVfCFP/TT/1Gza5naB1nJq7HpBdXFqwkgBMVorLdQ8CiWN3FSE02
         H5j286WlKmzVEv2P1m/WXOdY3rJwvMBBpiH7GBYUE3UdWugeeJHIgTKIp5wDaMzed4TE
         XSeKcc//JUJgivLRs6c1+ipKGDdKKsoLihcjxH81L7W1VL0EbRvEs3cbf/Ytd2skBY4C
         x2SA==
X-Forwarded-Encrypted: i=1; AJvYcCXR/Z4KG96ofNgsyEIW8C/rOLuujafRcJIRN8Ov4jG+q3KJt/Oe9Rzcvg2AHnBuuZWIoaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx61j0Rg4lBU1lUe6SAfT57tYDjsenrqUHBe2FmQ0CtDOycdR0
	P2yUH1IhnT2B1oWrPCSHMS45r8M199HGgTGKtGpUVv5l58YGhT6W1qPHhHAU3rbzkYvKsh89pLJ
	4rw3NJi7hVY+bjiDVAJA2Z+gNXKjfqTfD8Yj+WkTHjgmQ2R+GwuuR+g==
X-Gm-Gg: ASbGnctR+Ij5Lh6jTzswugsGbty8vVh29c3BwW06vY6IZV5lHxHDECanGJGngRWBnVb
	Tdr8CrUeLimnIzlmRTNuyVXHLZ+Az5L/k7CYBhnear/WNN0cm5EKznM7W6ITy8wzXmqqVOUIJgQ
	D80ZgzVvmM9+ZezaNtnS4c2r2JVWFEnf1ocgC9C34kUpR5ZVfISULJi78vb8wYiBlHgitC/ghPu
	8LeN6H+FtJ2Sya0K/QPcfehJ1qwvux2zRKKLBrdjaJuWl40fUCWBgsDBZHH9oyG+aEPB0yOhQUF
	tQaGldJRvj1yxOry31V98nSoOlWww7I2NxYQTSZT28Yp42FoYhZsOJG0Sh5u93zaexObUSeMZIm
	gSQDOi4sG3xrzZ3W1pl76OEyppw==
X-Received: by 2002:a17:907:d1b:b0:b04:1249:2b24 with SMTP id a640c23a62f3a-b6dba56f908mr12496666b.37.1761575499803;
        Mon, 27 Oct 2025 07:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGeKsYcRiyTwP3GVGgGDXvdfH25i6VHJvBBM4RcMH9DWuG1+VcBzYhWvawsrB9fT9lMDQtdQ==
X-Received: by 2002:a17:907:d1b:b0:b04:1249:2b24 with SMTP id a640c23a62f3a-b6dba56f908mr12493766b.37.1761575499306;
        Mon, 27 Oct 2025 07:31:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d854430dbsm775630866b.63.2025.10.27.07.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:31:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A52272EAA5E; Mon, 27 Oct 2025 15:31:37 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org,
 lorenzo@kernel.org, kuba@kernel.org, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>,
 syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v4 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
In-Reply-To: <20251027121318.2679226-2-maciej.fijalkowski@intel.com>
References: <20251027121318.2679226-1-maciej.fijalkowski@intel.com>
 <20251027121318.2679226-2-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 27 Oct 2025 15:31:37 +0100
Message-ID: <87pla8e7qu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
> which do not have its XDP memory model registered. There is a case when
> XDP program calls bpf_xdp_adjust_tail() BPF helper, which in turn
> releases underlying memory. This happens when it consumes enough amount
> of bytes and when XDP buffer has fragments. For this action the memory
> model knowledge passed to XDP program is crucial so that core can call
> suitable function for freeing/recycling the page.
>
> For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
> of mem model registration. The problem we're fixing here is when kernel
> copied the skb to new buffer backed by system's page_pool and XDP buffer
> is built around it. Then when bpf_xdp_adjust_tail() calls
> __xdp_return(), it acts incorrectly due to mem type not being set to
> MEM_TYPE_PAGE_POOL and causes a page leak.
>
> Pull out the existing code from bpf_prog_run_generic_xdp() that
> init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
> embed there rxq's mem_type initialization that is assigned to xdp_buff.
> Make it agnostic to current skb->data position.
>
> This problem was triggered by syzbot as well as AF_XDP test suite which
> is about to be integrated to BPF CI.
>
> Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@g=
oogle.com/
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in gene=
ric mode")
> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Co-developed-by: Octavian Purdila <tavip@google.com>
> Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, test=
ing, initiating a fix
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit=
 msg and proposed more robust fix


Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


