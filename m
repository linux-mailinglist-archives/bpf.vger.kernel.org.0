Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ED26C99AA
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 04:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjC0Cow (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 22:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjC0Cov (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 22:44:51 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83AF46BD;
        Sun, 26 Mar 2023 19:44:48 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id n14so7237388qta.10;
        Sun, 26 Mar 2023 19:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679885088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjPRw7a8pMHELQ53oymZFeBvbCGiVm/Rg9umw+16D4A=;
        b=R2EoaN+p6+koB5S3sZg0C8WmMZ1DNFr+GTnOprbfL1XkZnwG/V69NyBkMuUaNPx1V3
         TW6G0ueC6Vu4cQLsZfY2cCYdT88jioE9o8SWhGgNH5Rp7LCiNOnzNdMyPvs5WmmLWw2/
         iXPN+WoIk+rDF04qQTRmhUnS+FLZ1vH7XGhsMjyxrAykIBuQKkQvhPDJ5Qd/mAeCA4Ck
         ztzQA3qiPyAKfICjPw1MxfKYpQcUX13DCEl3jePOtycKyaVL8f4G9YhovyXd2Y3B5cpr
         /giI9cOvp1xDNx9Q25YcAStpxEHpmSCJMjvVgj9xaIsU54NzXjYRBCdns9Mn78kqIeY7
         54UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679885088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjPRw7a8pMHELQ53oymZFeBvbCGiVm/Rg9umw+16D4A=;
        b=79skYBIDCmDb98R+rEBOsfFczwWyLl5BRP20q4IDeUB4XFf8c8L/DgKJHOexJqiuAi
         e1x9LbEvLKakNOnvkYbV1bB5WPjNg6HufxWOqcaipsQhGrtJus0NJAwxLCZFPWh3nP1a
         2BnEyzFN0sUt/mnw46w2lX8UMX0r11h2AyqSv5YYjZq5BGJ5Maoegx9DRIrPS/xx8gbv
         NBH4ti01Mr7QZJQyepCTDItOcLOdF2Yo5H9fjcgl54LMIbf/YaPYQrL0b/QCmNeOi6vX
         5IsY+DBYzlfbzvpYRLCDRQ+Rbg3WmeUqW4xaqJ2hUE99eOZdbL6ku5pBy7Nbn1Eaeb5a
         dHxw==
X-Gm-Message-State: AO0yUKVg/PL5WjI8IRbKSMDx7LY199t3tFuPuRjPmTcae45KOcx+AHRD
        VxLpeK9cvYBNOQggtNtpo9Mox3+pCCCy8DzJs10=
X-Google-Smtp-Source: AKy350aOzVpb4lrDmXf1MemVwOUyXJP4Tz2Fl8Psq7HOSU1iRGITSzt6y4unqzOZD/SuOyKBAVXq/fhksYoE9v/9Vt0=
X-Received: by 2002:a05:622a:199f:b0:3c0:2b0b:84c with SMTP id
 u31-20020a05622a199f00b003c02b0b084cmr3971968qtc.6.1679885088035; Sun, 26 Mar
 2023 19:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <20230326092208.13613-9-laoar.shao@gmail.com>
 <87mt3z7pm5.fsf@toke.dk>
In-Reply-To: <87mt3z7pm5.fsf@toke.dk>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 27 Mar 2023 10:44:12 +0800
Message-ID: <CALOAHbBd5Bx0Tnzv1MW_NV9mOJrqdk5oySYWQr-XXURAM5xndw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 08/13] bpf: Alloc and free bpf_map id in bpf namespace
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 26, 2023 at 6:51=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> Yafang Shao <laoar.shao@gmail.com> writes:
>
> > We only expose the bpf map id under current bpf namespace to user. The
> > map->id is still the id in the init bpf namespace.
> >
> > The result as follows,
> >
> > Run bpftool in a new bpf namespace
> > $ bpftool map show
> > 4: array  name kprobe_b.rodata  flags 0x80
> >         key 4B  value 37B  max_entries 1  memlock 360B
> >         btf_id 159  frozen
>
> The btf_id is identical for all the different objects in this example
> output; surely that can't be right? Copy-paste error? Same thing in the
> other patches...
>

The bpf progs {"kretprobe_run","kprobe_run"} and the bpf maps
{"kprobe_b.rodata","kprobe_b.data"} belong to the same bpf program. So
the btf_id of them are always the same. For example, below is the
result when I rerun it on my test server,
$ bpftool btf show
...
943: name <anon>  size 1086B  prog_ids 48824,48822  map_ids 43712,43711
        pids kprobe(3599801)
...

$ bpftool map show
43711: array  name kprobe_b.rodata  flags 0x80
        key 4B  value 37B  max_entries 1  memlock 360B
        btf_id 943  frozen
        pids kprobe(3599801)
43712: array  name kprobe_b.data  flags 0x400
        key 4B  value 4B  max_entries 1  memlock 8192B
        btf_id 943
        pids kprobe(3599801)

$ bpftool prog show
48822: kprobe  name kretprobe_run  tag 0de47cc241a2b1b3  gpl
        loaded_at 2023-03-27T10:35:01+0800  uid 0
        xlated 112B  jited 78B  memlock 4096B  map_ids 43711
        btf_id 943
        pids kprobe(3599801)
48824: kprobe  name kprobe_run  tag bf163b23cd3b174d  gpl
        loaded_at 2023-03-27T10:35:01+0800  uid 0
        xlated 104B  jited 75B  memlock 4096B  map_ids 43711
        btf_id 943
        pids kprobe(3599801)

The btf_id hasn't been added into the bpf namespace, so the btf id in
init bpf namespace and child bpf namespace are the same value.

--=20
Regards
Yafang
