Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24888211081
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 18:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbgGAQXc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 12:23:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49680 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729019AbgGAQXc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Jul 2020 12:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593620611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mzifNkKB8Bsgoz5K61KO9neFPMQLOKn0g9YIuoJvNc=;
        b=biCxrXOvUq59cnDixSCF5O3Tt7ukJHlJGZ3Lrz+ySZpa8rbNI2ADZazK3QKV4HsMKgd/pK
        5Y9X02sBL48iDwDzxL/KiUN3sSIPhV3OLWLVwuppALjgf5OWK8gz41lsyqH8nSL3fxtYU0
        mnNNiTDN3IfUxRL9lgFyafqBKUWvss0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-tJO4lqLnMueeVs2mvEZlng-1; Wed, 01 Jul 2020 12:23:27 -0400
X-MC-Unique: tJO4lqLnMueeVs2mvEZlng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2533C188360D;
        Wed,  1 Jul 2020 16:23:26 +0000 (UTC)
Received: from carbon (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 493A55BAD5;
        Wed,  1 Jul 2020 16:23:21 +0000 (UTC)
Date:   Wed, 1 Jul 2020 18:23:19 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>, brouer@redhat.com
Subject: Re: [PATCH bpf-next] selftests/bpf: test_progs option for listing
 test names
Message-ID: <20200701182319.55a7c392@carbon>
In-Reply-To: <CAADnVQJmz461mcv4MBq40jtHBzeX0FgpFaQW3XLB0=U6Y3WgGw@mail.gmail.com>
References: <159353162763.912056.3435319848074491018.stgit@firesoul>
        <CAEf4BzZ-Ryq+i1ez3Q8G1js6tuD8niAejJzA5Gf7N-vS=6AE_g@mail.gmail.com>
        <20200630223224.16fb2377@carbon>
        <CAEf4BzYqojkRHQGszn0jcQEx6jYMvx3fZV4BERn5zeO-AxBjSQ@mail.gmail.com>
        <CAADnVQJmz461mcv4MBq40jtHBzeX0FgpFaQW3XLB0=U6Y3WgGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 1 Jul 2020 08:36:08 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Jun 30, 2020 at 2:19 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Jun 30, 2020 at 1:32 PM Jesper Dangaard Brouer
> > <brouer@redhat.com> wrote:  
> > >
> > > On Tue, 30 Jun 2020 08:46:01 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >  
> > > > > @@ -688,9 +700,17 @@ int main(int argc, char **argv)
> > > > >                         cleanup_cgroup_environment();
> > > > >         }
> > > > >         stdio_restore();
> > > > > +
> > > > > +       if (env.list_test_names) {
> > > > > +               if (env.succ_cnt == 0)
> > > > > +                       env.fail_cnt = 1;
> > > > > +               goto out;
> > > > > +       }
> > > > > +  
> > > >
> > > > Why failure if no test matched? Is that to catch bugs in whitelisting?  
> > >
> > > I would not call it catch bugs, but sort of.  The purpose is to know if
> > > requested test is valid.  This can be used to e.g. run through all the
> > > tests numbers, and stopping when a test number (-n) is no-longer valid,
> > > by using this shell exit value as a test, like:
> > >
> > >  n=1;
> > >  while [ $(./test_progs --list -n $n) ] ; do \
> > >    echo "./test_progs -n $n" ; n=$(( n+1 )); \
> > >  done
> > >
> > > Notice that this features that be used for looking up a test number,
> > > and returning a testname, which was the original request from CI.  I
> > > choose this implementation as it more generic and generally useful.
> > >
> > >  $ ./test_progs --list -n 89
> > >  xdp_adjust_tail
> > >  
> >
> > Yeah, it has a nice querying effect. Makes sense.
> >
> > Acked-by: Andrii Nakryiko <andriin@fb.com>  
> 
> hmm. it doesn't apply.
> Applying: selftests/bpf: Test_progs option for listing test names
> error: sha1 information is lacking or useless
> (tools/testing/selftests/bpf/test_progs.c).
> error: could not build fake ancestor
> Patch failed at 0001 selftests/bpf: Test_progs option for listing test names

It doesn't apply because it depend on my previous changes, that Daniel
said he applied:

 https://lore.kernel.org/bpf/6e7543fa-f496-a6d2-a6d5-70dff9f84090@iogearbox.net/

But I can see that it is not in the net-next git tree.
 
> Could you please respin.

I will respin together with the other unapplied patch.  Which is
actually fine, as I have an improvement for the previous patch, that I
can squash.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

