Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD39254D27
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgH0Sf2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 14:35:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41343 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726217AbgH0Sf2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 14:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598553327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRhgwKqIg4GgwNtz9HzPGfCZ1HJPKJB936I/3G0KNd0=;
        b=Z9DmLlw1BMd6m/G4q8EdtdjcWF6vomaMYNqlwNFz268OaH7x1KxJaphWlqEZD3v6dfJ/kv
        +Ph5KX81Wz6SmkMOMNjU/4fNWzyN4GkDvEsz1A6jl+ksTXvj/WO4VzxW0kxCMyttnEajnM
        eom0RxqAb13CKUF/N4C6heAC5os9cWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-1btYbe1DOqeANwsiukwfAQ-1; Thu, 27 Aug 2020 14:35:22 -0400
X-MC-Unique: 1btYbe1DOqeANwsiukwfAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0233189E615;
        Thu, 27 Aug 2020 18:35:19 +0000 (UTC)
Received: from krava (unknown [10.40.192.67])
        by smtp.corp.redhat.com (Postfix) with SMTP id E44355C1C2;
        Thu, 27 Aug 2020 18:35:08 +0000 (UTC)
Date:   Thu, 27 Aug 2020 20:35:01 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH bpf-next 1/6] tools: Factor HOSTCC, HOSTLD, HOSTAR
 definitions
Message-ID: <20200827183501.GA127372@krava>
References: <20200827153629.3820891-1-jean-philippe@linaro.org>
 <20200827153629.3820891-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827153629.3820891-2-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 27, 2020 at 05:36:25PM +0200, Jean-Philippe Brucker wrote:
> Several Makefiles in tools/ need to define the host toolchain variables.
> Move their definition to tools/scripts/Makefile.include
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

for perf and resolve_btfids

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

