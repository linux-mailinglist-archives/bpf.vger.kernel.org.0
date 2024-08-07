Return-Path: <bpf+bounces-36605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5185294AFA0
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829921C2180A
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 18:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D5114037F;
	Wed,  7 Aug 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dELi+Jtw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29138762DF
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055094; cv=none; b=FOkpUQf7nyyUrBnWqkYenNY9cvgJxGXdB+5Vv/IMGFHkF6Zbw81IfG0RSOO+DfVYaDF575XustLQVVdCAXCgJUaqyE37nQxHjgkHBA6khj2EyEPTKDNznl7fxNLZIiu0xC+9QNuye9C4o/Rf1B3rat/5OQRQd/cM/cpnInLlXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055094; c=relaxed/simple;
	bh=9D2wJx7b2TcE05VUmWhYDYryIterDH+F2PD6mBFHDzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1MnVOWUY5EiWztdiBz2Si00cZXhxhQwA6V6ASq5ACeqWgNQH7ocJkXnzbvq1It3q2fx0WytAdjBcxY91/T6VXNOzEJLQapIHdZX/Y3NnLTmouY4FecrdZ7Zn4WPKps2KUz9H3ryEI32UrhollzMjO9xzcw+QMsKKOu0llv8HCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dELi+Jtw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723055092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9D2wJx7b2TcE05VUmWhYDYryIterDH+F2PD6mBFHDzQ=;
	b=dELi+Jtwy+OqaH1oY2qABenM8LkoF7YrsSMR2JeybCxgj0uHiIbST5MinOPbHcxyxFhzMj
	LjW4hw4VlfUtaBn3dnlPwhshn2iWScEhMkRatGkDJeUSunXI25q8/4JGu03QGghUgpI9qK
	LNDk0bN/cbKKxPGTIvbeXkQSwoBDcpA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-8TT0jHODPPu6z4IrG3IxQQ-1; Wed,
 07 Aug 2024 14:24:48 -0400
X-MC-Unique: 8TT0jHODPPu6z4IrG3IxQQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93B07195608A;
	Wed,  7 Aug 2024 18:24:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.97])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4464319560A7;
	Wed,  7 Aug 2024 18:24:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  7 Aug 2024 20:24:44 +0200 (CEST)
Date: Wed, 7 Aug 2024 20:24:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Liao Chang <liaochang1@huawei.com>, Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 0/8] uprobes: RCU-protected hot path optimizations
Message-ID: <20240807182438.GE27715@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240807132922.GC27715@redhat.com>
 <CAEf4BzZSyuFexZfwZs1bA9S=O0FHejw_tE6PXm5h8ftMsuSROw@mail.gmail.com>
 <20240807171113.GD27715@redhat.com>
 <CAEf4BzZ8SaFK4iMtPPxYZQjHOvaPqpKApE8=Bz+h29xq+xMEsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ8SaFK4iMtPPxYZQjHOvaPqpKApE8=Bz+h29xq+xMEsA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/07, Andrii Nakryiko wrote:
>
> Are you going to send a patch with
> your bool flag proposal?

No, I will wait for the next version from Liao.

If he agrees with my comments. If not, we will continue the discussion in that thread.

Note also another patch from Liao which removes ->siglock from uprobe_deny_signal(),
https://lore.kernel.org/all/20240731095017.1560516-1-liaochang1@huawei.com/

Oleg.


