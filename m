Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08E532C177
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhCCWtc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:49:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380750AbhCCN3g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 08:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614778080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJFVk9Prwjkxdm586ACwDtBMKBVeZRi7IzKPe/DvaFI=;
        b=hErmplPYcuy9JYr5U0+O+j+nsfeI2pSwip1oPv/fxbbFtYEvVx5V34nCqc1FB4+ulF5XlT
        W7PWfZyohYcMDiU6Ee7TiJBtY7ZJABsj2vhWu5WQVjrCyusU2W0Us1V69ESKfkqzAioFbs
        5ylvXPmpTvsIx61ZkPx+q1Yike357Vk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-YJ8FY7OuMBiHiY1HqX1Adg-1; Wed, 03 Mar 2021 08:27:56 -0500
X-MC-Unique: YJ8FY7OuMBiHiY1HqX1Adg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 795176D4E0;
        Wed,  3 Mar 2021 13:27:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 614936F999;
        Wed,  3 Mar 2021 13:27:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  3 Mar 2021 14:27:54 +0100 (CET)
Date:   Wed, 3 Mar 2021 14:27:50 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Why do kprobes and uprobes singlestep?
Message-ID: <20210303132749.GA28955@redhat.com>
References: <CAADnVQJtpvB8wDFv46O0GEaHkwmT1Ea70BJfgS36kDX0u4uZ-g@mail.gmail.com>
 <968E85AE-75B8-42D7-844A-0D61B32063B3@amacapital.net>
 <CAADnVQJoTMqWK=kNFyTbjhoo22QD81KXnPxUjiCXhQaNhbK+8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJoTMqWK=kNFyTbjhoo22QD81KXnPxUjiCXhQaNhbK+8A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/02, Alexei Starovoitov wrote:
>
> Especially if such tightening will come with performance boost for
> uprobe on a nop and unprobe at the start (which is typically push or
> alu on %sp).
> That would be a great step forward.

Just in case, nop and push are emulated without additional overhead.

Oleg.

