Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D78308AA8
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 17:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhA2QwT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 11:52:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231567AbhA2QvQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Jan 2021 11:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611938979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0LJVECpOlUE7iCohzUD34pw4c+hMPt6DfdyYZYLmTpM=;
        b=HPVbJHOPwqe0vsmfsmW5QmDJoXBZUlTk5+wcrhh/BmseNgZId4lofx/iVqZMDoTNW+181I
        zN89XkvpIeMQCVPhJ9yDASriwF+i8tdoBR9l8lnV931OHlyHGM87w9YxkoNfQagkndP5s7
        87+oQBTqXlVWcfzBm2xRn/pcLeRSD/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-6-5jlf43MqeSlS5NRiJL6g-1; Fri, 29 Jan 2021 11:49:37 -0500
X-MC-Unique: 6-5jlf43MqeSlS5NRiJL6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9606BBBEEC;
        Fri, 29 Jan 2021 16:49:35 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82A9419C66;
        Fri, 29 Jan 2021 16:49:34 +0000 (UTC)
Date:   Fri, 29 Jan 2021 10:49:32 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] x86: Disable CET instrumentation in the kernel
Message-ID: <20210129164932.qt7hhmb7x4ehomfr@treble>
References: <a35a6f15-9ab1-917c-d443-23d3e78f2d73@suse.com>
 <20210128103415.d90be51ec607bb6123b2843c@kernel.org>
 <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
 <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
 <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <20210128165014.xc77qtun6fl2qfun@treble>
 <20210128215219.6kct3h2eiustncws@treble>
 <20210129102105.GA27841@zn.tnic>
 <20210129151034.iba4eaa2fuxsipqa@treble>
 <20210129163048.GD27841@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210129163048.GD27841@zn.tnic>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 05:30:48PM +0100, Borislav Petkov wrote:
> On Fri, Jan 29, 2021 at 09:10:34AM -0600, Josh Poimboeuf wrote:
> > Maybe eventually.  But the enablement (actually enabling CET/CFI/etc)
> > happens in the arch code anyway, right?  So it could be a per-arch
> > decision.
> 
> Right.
> 
> Ok, for this one, what about
> 
> Cc: <stable@vger.kernel.org>
> 
> ?
> 
> What are "some configurations of GCC"? If it can be reproduced with
> what's released out there, maybe that should go in now, even for 5.11?
> 
> Hmm?

Agreed, stable is a good idea.   I think Nikolay saw it with GCC 9.

-- 
Josh

