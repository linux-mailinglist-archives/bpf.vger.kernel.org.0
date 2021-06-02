Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A6F39865D
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 12:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhFBKXg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 06:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232576AbhFBKXP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Jun 2021 06:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622629291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLaimFrDsr1MW/JWI+oUnkOYYT66LzhiZ8Fd+WLe7hE=;
        b=B4/biQ3SulXE0znvijde5O2fOE8KqKGuqxj7GYyeze9DWvXK8zy8YyJw6DtpsAfIzguGbT
        hKVko4wn4JNtis/DX+wATNA+JU4z1X9xrqnwScDc5gbO1EAGyx3SVmYjxWJ7UdB49wYQ6M
        2yCEuD1XwNOBfRG9IbWADv5uce/1weM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-G4g_0ZqZMU-ilNb71DNT2Q-1; Wed, 02 Jun 2021 06:21:29 -0400
X-MC-Unique: G4g_0ZqZMU-ilNb71DNT2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 544C0180FD6F;
        Wed,  2 Jun 2021 10:21:28 +0000 (UTC)
Received: from Diego (unknown [10.36.110.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CD6550F89;
        Wed,  2 Jun 2021 10:21:22 +0000 (UTC)
Date:   Wed, 2 Jun 2021 12:21:19 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        =?ISO-8859-15?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFT] Testing 1.22
In-Reply-To: <YK+41f972j25Z1QQ@kernel.org>
Message-ID: <alpine.LRH.2.20.2106021220240.10640@Diego>
References: <YK+41f972j25Z1QQ@kernel.org>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 27 May 2021, Arnaldo Carvalho de Melo wrote:
> Hi guys,
> 
> 	Its important to have 1.22 out of the door ASAP, so please clone
> what is in tmp.master and report your results.
> 
[...]
> 
> Then make sure build/pahole is in your path and try your workloads.
> 
> Jiri, Michael, if you could run your tests with this, that would be awesome,

Hi Arnaldo!

I am sorry, but I don't think I have any tests covering this.

Michael
> 
> Thanks in advance!
> 
> - Arnaldo
> 
> 

