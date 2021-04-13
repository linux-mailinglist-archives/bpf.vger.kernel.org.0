Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7625835D607
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 05:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbhDMDij (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 23:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbhDMDii (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 23:38:38 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097C8C061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 20:38:20 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y2so14517443ybq.13
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 20:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5v/vNfiMJaw9l++fcsYKSE/QRXjzOn2qP4/rAYRdzm4=;
        b=QSgPBN4rG7WVPHXETxJkmzBipGiFNa5JXoD1qZsLWf2+hAvKZttHR2Cny7dBi1/vcb
         9rZ7pomFUJYsFrT/Zo+odnOM18Cq4GeLk4NJyX9NYU+zvq6SZcmCfKj4wHwxCHcTuqZ5
         andxQOarsdeFio2B9MEYQHI7dk3CDO4tUoxDZ4XrVwwwjGXTFcN9LdEZQnJkieBkjjm6
         C6Uom+w4KxOtMEUGu5ErWLCFDSmi78GWdXqe1//HLX6EvU7++4Q4wx9xzHWwLWPd6OET
         PlU5UN6pSddW4JnLFLTIa2NMYbbEVDpQi2+AKz1UE8kysO7OCC3NeD+nh7mVOavUGv83
         cf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5v/vNfiMJaw9l++fcsYKSE/QRXjzOn2qP4/rAYRdzm4=;
        b=OvbPFmmQQnrfhcx3kKvLIhliasFhL5F+4zEzli0LZ21popnKSo7QOAOmojNVjzn9Ac
         0tvYwBCzriHD9cipBmdCxzKpOqcMHsajDNwL/6RVc+6VvuqGVOqNBVlB2YoLbbfCuf3P
         /THfQUodgGE/HBLr8CCwJWXRvsG2BP9ZFoR6+3k9XooMd9vCQ4sQkwEjBdjFd/wfylk9
         4FPs1AmH5bI2IhZOVx9X4erqFLc62bdhbl26eFxck3p41uPJ700Aso4KU723/QbfE/t6
         CmcOnrZq7m+pAJ5jfgKk2fAg6J5tbMRzLHqUVzEXOoQYCXsaDdcOoZaPOHVLaJ5CTTi0
         8hxw==
X-Gm-Message-State: AOAM532aRMN9znNEck7jUNmWKi644WTpiASMwtRruzLno3o4A+Y95KbF
        nl1MTcICgFYpqGDjf7bN4X3418R5LTSm/Zg3Xes=
X-Google-Smtp-Source: ABdhPJzXyASP5jPD3U77S2h3W42rcxUWyG1VEdtew7zvJVwQ7NK7P8EyYIRjSIVnWD6jTion205w4WYE0ZPNdlVGx+w=
X-Received: by 2002:a25:5b55:: with SMTP id p82mr40531676ybb.510.1618285099319;
 Mon, 12 Apr 2021 20:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <87blaozi20.fsf@toke.dk>
In-Reply-To: <87blaozi20.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Apr 2021 20:38:08 -0700
Message-ID: <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
Subject: Re: Selftest failures related to kern_sync_rcu()
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 8, 2021 at 12:34 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Hi Andrii
>
> I'm getting some selftest failures that all seem to have something to do
> with kern_sync_rcu() not being enough to trigger the kernel events that
> the selftest expects:
>
> $ ./test_progs | grep FAIL
> test_lookup_update:FAIL:map1_leak inner_map1 leaked!
> #15/1 lookup_update:FAIL
> #15 btf_map_in_map:FAIL
> test_exit_creds:FAIL:null_ptr_count unexpected null_ptr_count: actual 0 =
=3D=3D expected 0
> #123/2 exit_creds:FAIL
> #123 task_local_storage:FAIL
> test_exit_creds:FAIL:null_ptr_count unexpected null_ptr_count: actual 0 =
=3D=3D expected 0
> #123/2 exit_creds:FAIL
> #123 task_local_storage:FAIL
>
> They are all fixed by adding a sleep(1) after the call(s) to
> kern_sync_rcu(), so I'm guessing it's some kind of
> timing/synchronisation problem. Is there a particular kernel config
> that's needed for the membarrier syscall trick to work? I've tried with
> various settings of PREEMPT and that doesn't really seem to make any
> difference...
>

If you check kern_sync_rcu(), it relies on membarrier() syscall
(passing cmd =3D MEMBARRIER_CMD_SHARED =3D=3D MEMBARRIER_CMD_GLOBAL).
Now, looking at kernel sources:
  - CONFIG_MEMBARRIER should be enabled for that syscall;
  - it has some extra conditions:

           case MEMBARRIER_CMD_GLOBAL:
                /* MEMBARRIER_CMD_GLOBAL is not compatible with nohz_full. =
*/
                if (tick_nohz_full_enabled())
                        return -EINVAL;
                if (num_online_cpus() > 1)
                        synchronize_rcu();
                return 0;

Could it be that one of those conditions is not satisfied?


> -Toke
>
