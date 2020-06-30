Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F4020FE98
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 23:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgF3VTc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 17:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgF3VTc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 17:19:32 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225B8C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 14:19:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j80so20149162qke.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 14:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NtUx76WX8U/GQRPBok/W/UbIJ78YwqZY+73zgsy3zE=;
        b=fsJg1t4jHpERP/2w4hP7YNSyOwXiWTRS6Eh/FCsV6beU+rdzhAMnpmqs+PR+U8YVFW
         jC3zkLFas1jnG6Hf98HPQNhWvd6eEb3IwUST1b2N1IMG8lXVUrZqgGm0Y9bQAfvPVrkp
         e/o8QoHLhCjxT02c1NvNvR0V29Yb/fa73/Dvq4/Lgh5WA1qvCgduSwibcwcWoDXida/e
         Ukjn9zymF5kqI9NrYHC5V7yyZu6gKkU3ze07G0B2YkuF6F6ekKZ/qSZnpXgqS6rbd5ZB
         w2P8mMTBuKUTJn6qEaWgZQUUWda7HK7J4TBE7BS4zbgr7vhUUEpjBPEmgGib+Ba46pW+
         VmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NtUx76WX8U/GQRPBok/W/UbIJ78YwqZY+73zgsy3zE=;
        b=rUKA4WhY6WQyh7Uk74izeYkigwDGpn6WClcN80aOfl2vI83EtbO9nyk9hrkZFrm5zV
         GQTWDatEbScIxrQfhjqb6LtujspXG9Up5MrZVWASP9Tb46sHUIvML8N9yGPYhSfhofx/
         rj+hV0Q0vQPdV0BiKcbmDIzisLlHJuB83YUXxDVnHEyhHHmJKoHqnrWQQ81nSqaFLr9i
         H1Y8fRDN5ELsrVOc7vIhRZVWUHvulKIA9Kob5aqCmWddJPihvIbH4f7s+dIKxhvwZVzM
         QKVvSa8Z15FGbUOVDY3PpXhxHuujtSie0FHzI4le3avVUv3SmquB4WOy7LvadbKg8a43
         k8ig==
X-Gm-Message-State: AOAM530VItq68QXGtGhZb41B36mY7rRF9KrKDCkp4tzc1V1Glc5Rc7ON
        nKHNW5ljM7C2xr8YWuzi5xAhyA/fWvZRfZl78a0=
X-Google-Smtp-Source: ABdhPJzO8RiUVJCrOcLz+prSFC/R7kGU9YjLOIgg6Nx5KnS4YKmps2Xi21/8Ci0k77TfC9H4PtTQAarnPfDzVrJF+MI=
X-Received: by 2002:a37:7683:: with SMTP id r125mr19566259qkc.39.1593551970222;
 Tue, 30 Jun 2020 14:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <159353162763.912056.3435319848074491018.stgit@firesoul>
 <CAEf4BzZ-Ryq+i1ez3Q8G1js6tuD8niAejJzA5Gf7N-vS=6AE_g@mail.gmail.com> <20200630223224.16fb2377@carbon>
In-Reply-To: <20200630223224.16fb2377@carbon>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 30 Jun 2020 14:19:19 -0700
Message-ID: <CAEf4BzYqojkRHQGszn0jcQEx6jYMvx3fZV4BERn5zeO-AxBjSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: test_progs option for listing
 test names
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 1:32 PM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Tue, 30 Jun 2020 08:46:01 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > > @@ -688,9 +700,17 @@ int main(int argc, char **argv)
> > >                         cleanup_cgroup_environment();
> > >         }
> > >         stdio_restore();
> > > +
> > > +       if (env.list_test_names) {
> > > +               if (env.succ_cnt == 0)
> > > +                       env.fail_cnt = 1;
> > > +               goto out;
> > > +       }
> > > +
> >
> > Why failure if no test matched? Is that to catch bugs in whitelisting?
>
> I would not call it catch bugs, but sort of.  The purpose is to know if
> requested test is valid.  This can be used to e.g. run through all the
> tests numbers, and stopping when a test number (-n) is no-longer valid,
> by using this shell exit value as a test, like:
>
>  n=1;
>  while [ $(./test_progs --list -n $n) ] ; do \
>    echo "./test_progs -n $n" ; n=$(( n+1 )); \
>  done
>
> Notice that this features that be used for looking up a test number,
> and returning a testname, which was the original request from CI.  I
> choose this implementation as it more generic and generally useful.
>
>  $ ./test_progs --list -n 89
>  xdp_adjust_tail
>

Yeah, it has a nice querying effect. Makes sense.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>
