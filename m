Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040DC2139A9
	for <lists+bpf@lfdr.de>; Fri,  3 Jul 2020 13:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGCL7o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jul 2020 07:59:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47602 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726108AbgGCL7n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jul 2020 07:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593777582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XO6IufJ40eraFe6AvOGxOPD2j1WspKYF/86TMPkF1XU=;
        b=AtZvfT47n/8jwbleC46BO00Lq99FwQDsvSjT6zjSgW6eVPdhTrMofPMpmkj3K3YnnroqY1
        EGTk4uAlN9xa2IhIsUqWoEDf2ERH/6r0d+MPvFIB+46HbKMPa0FXPrGCIxMUaeKetVfnMQ
        ArMQufb0+kc96raXr2XXDM8OgFDVznc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-akaL7x2hOxiwi8c2wcuTng-1; Fri, 03 Jul 2020 07:59:39 -0400
X-MC-Unique: akaL7x2hOxiwi8c2wcuTng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FD78100A61D;
        Fri,  3 Jul 2020 11:59:33 +0000 (UTC)
Received: from carbon (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B8142DE70;
        Fri,  3 Jul 2020 11:59:27 +0000 (UTC)
Date:   Fri, 3 Jul 2020 13:59:23 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <vkabatov@redhat.com>, <jbenc@redhat.com>, brouer@redhat.com
Subject: Re: [PATCH bpf-next] selftests/bpf: test_progs use another shell
 exit on non-actions
Message-ID: <20200703135923.5bf3e521@carbon>
In-Reply-To: <7b3f6c32-78e9-69fe-1f49-7065149e943e@fb.com>
References: <20200702154728.6700e790@carbon>
        <159371277981.942611.89883359210042038.stgit@firesoul>
        <7b3f6c32-78e9-69fe-1f49-7065149e943e@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2 Jul 2020 14:24:14 -0700
Yonghong Song <yhs@fb.com> wrote:

> On 7/2/20 10:59 AM, Jesper Dangaard Brouer wrote:
> > This is a follow up adjustment to commit 6c92bd5cd465 ("selftests/bpf:
> > Test_progs indicate to shell on non-actions"), that returns shell exit
> > indication EXIT_FAILURE (value 1) when user selects a non-existing test.
> > 
> > The problem with using EXIT_FAILURE is that a shell script cannot tell
> > the difference between a non-existing test and the test failing.
> > 
> > This patch uses value 2 as shell exit indication.
> > (Aside note unrecognized option parameters use value 64).
> > 
> > Fixes: 6c92bd5cd465 ("selftests/bpf: Test_progs indicate to shell on non-actions")
> > Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > ---
> >   tools/testing/selftests/bpf/test_progs.c |    4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> > index 104e833d0087..e8f7cd5dbae4 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -12,6 +12,8 @@
> >   #include <string.h>
> >   #include <execinfo.h> /* backtrace */
> >   
> > +#define EXIT_NO_TEST 2  
>
> How do you ensure this won't collide with other exit code
> from other library functions (e.g., error code 64 is used
> for unrecognized option which I have no idea what 64 means)?

I expect 64 comes from: /usr/include/sysexits.h
 #define EX_USAGE        64      /* command line usage error */


> Maybe -2 for the exit code?

No. The process's exit status must be a number between 0 and 255, as
defined in man exit(3). (run: 'man 3 exit' as there are many manpages
named exit).

But don't use above 127, because that is usually used for indicating
signals.  E.g. 139 means 11=SIGSEGV $((139 & 127))=11.  POSIX defines
in man wait(3p) check WIFSIGNALED(STATUS) and WTERMSIG(139)=11.
(Hint: cmd 'kill -l' list signals and their numbers).

I bring up Segmentation fault explicitly, as we are seeing these happen
with different tests (that are part of test_progs).  CI people writing
these shell-scripts could pickup these hints and report them, if that
makes sense.


> test_progs already uses -1.

Well that is a bug then.  This will be seen by the shell (parent
process) as 255.

 
> > +
> >   /* defined in test_progs.h */
> >   struct test_env env = {};
> >   
> > @@ -740,7 +742,7 @@ int main(int argc, char **argv)
> >   	close(env.saved_netns_fd);
> >   
> >   	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
> > -		return EXIT_FAILURE;
> > +		return EXIT_NO_TEST;
> >   
> >   	return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
> >   }
> > 

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

