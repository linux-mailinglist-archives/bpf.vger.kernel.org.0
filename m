Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25A4211540
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 23:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGAVim (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 17:38:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53622 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbgGAVim (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Jul 2020 17:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593639521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MTKdvSy+TelK931YCuByBbSYqDmHNiiPh6m/HOqLb9A=;
        b=A5g3Yw0zbBiXi6VovgwREZ+IXrCgYQa89m7pzufe9aBXy6Ro6XM32vtlaGhiFqWIbukvvs
        9BgiifRTN6jBOC6h0gskhGIu1IjF8j08TQgL+D7SP8LoRwB8enh2HAN63yS3M8b82qcdlR
        bO73OZRnjj2DDKNlH2tHg0iCnRvrH+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-p67-zZ7uP0ik2fdHPeyeTg-1; Wed, 01 Jul 2020 17:38:38 -0400
X-MC-Unique: p67-zZ7uP0ik2fdHPeyeTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F12A80183C;
        Wed,  1 Jul 2020 21:38:37 +0000 (UTC)
Received: from carbon (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1079B1002388;
        Wed,  1 Jul 2020 21:38:31 +0000 (UTC)
Date:   Wed, 1 Jul 2020 23:38:30 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Jiri Benc <jbenc@redhat.com>, brouer@redhat.com
Subject: Re: [PATCH bpf-next V2 3/3] selftests/bpf: test_progs indicate to
 shell on non-actions
Message-ID: <20200701233830.19ee0ec8@carbon>
In-Reply-To: <CAEf4BzYXAHMC=7DTEzqH563zuMsuZuMbDaBPN9TmX4P8PG49jA@mail.gmail.com>
References: <159363468114.929474.3089726346933732131.stgit@firesoul>
        <159363474925.929474.15491499711324280696.stgit@firesoul>
        <CAEf4BzYXAHMC=7DTEzqH563zuMsuZuMbDaBPN9TmX4P8PG49jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 1 Jul 2020 13:54:41 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Jul 1, 2020 at 1:19 PM Jesper Dangaard Brouer <brouer@redhat.com> wrote:
> >
> > When a user selects a non-existing test the summary is printed with
> > indication 0 for all info types, and shell "success" (EXIT_SUCCESS) is
> > indicated. This can be understood by a human end-user, but for shell
> > scripting is it useful to indicate a shell failure (EXIT_FAILURE).
> >
> > Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > ---
> >  tools/testing/selftests/bpf/test_progs.c |    9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> > index 3345cd977c10..75cf5b13cbd6 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -706,11 +706,8 @@ int main(int argc, char **argv)
> >                 goto out;
> >         }
> >
> > -       if (env.list_test_names) {
> > -               if (env.succ_cnt == 0)
> > -                       env.fail_cnt = 1;
> > +       if (env.list_test_names)
> >                 goto out;
> > -       }
> >
> >         fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
> >                 env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
> > @@ -723,5 +720,9 @@ int main(int argc, char **argv)
> >         free_str_set(&env.subtest_selector.whitelist);
> >         free(env.subtest_selector.num_set);
> >
> > +       /* Return EXIT_FAILURE when options resulted in no actions */
> > +       if (!env.succ_cnt && !env.fail_cnt && !env.skip_cnt)
> > +               env.fail_cnt = 1;
> > +  
> 
> Heh, just suggested something like this in the previous patch. I think
> this change should go first in patch series and not churn on
> env.list_test_names above.
> 
> I'd also rewrite it as (no need to muck around with fail_cnt, less
> negation for integers):
> 
> if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
>     return EXIT_FAILURE;

All good suggestions, I'll respin.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

