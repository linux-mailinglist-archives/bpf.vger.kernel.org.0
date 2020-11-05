Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD972A7C9A
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 12:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKELIb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 06:08:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgKELIb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 06:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604574510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dlLhYd+eKsE+923I1lGmVo2SHsoM0x8bbkuUO0N+HW8=;
        b=YscucEJMO7aN2pLj09HpTYqmKr3iIFRq+6E6T/Sh6NEcnsYlp7lkMZySLGaVIml/5aU3xA
        3e8B/+WIVELlKinxXSB3iWGp19pwxHrc8QraCTnPw2vHVVgimadEx/ZTwuh2fCJ9dslBa2
        2Pb7Wg6qBMCpZTC59DejUX/Ni3LMu8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-5S-D_sWmOmWx2deUeljOdA-1; Thu, 05 Nov 2020 06:08:26 -0500
X-MC-Unique: 5S-D_sWmOmWx2deUeljOdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 222BE1900082;
        Thu,  5 Nov 2020 11:08:25 +0000 (UTC)
Received: from localhost (unknown [10.40.193.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F84870C24;
        Thu,  5 Nov 2020 11:08:23 +0000 (UTC)
Date:   Thu, 5 Nov 2020 12:08:21 +0100
From:   Jiri Benc <jbenc@redhat.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/6] bpf: flow_dissector: check value of unused
 flags to BPF_PROG_ATTACH
Message-ID: <20201105120821.07d8ee8c@redhat.com>
In-Reply-To: <CACAyw98rvXpcdQBE_XzFR0Y0s=rgtum-D0dcyE3DSZXUL-im=Q@mail.gmail.com>
References: <20200629095630.7933-1-lmb@cloudflare.com>
        <20200629095630.7933-2-lmb@cloudflare.com>
        <20201104190808.417b9a4b@redhat.com>
        <CACAyw98rvXpcdQBE_XzFR0Y0s=rgtum-D0dcyE3DSZXUL-im=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 5 Nov 2020 11:00:45 +0000, Lorenz Bauer wrote:
> I had a cursory look at bpftool packaging in Debian, Ubuntu and
> Fedora, it seems they all package bpftool in a kernel version
> dependent package. So the most straightforward fix is probably to
> change bpftool to use *mapfd = 0 and then land that via the bpf tree.
> 
> What do you think?

Apparently nobody is using bpftool for this (otherwise someone would
notice), so I'd say go ahead.

Thanks!

 Jiri

