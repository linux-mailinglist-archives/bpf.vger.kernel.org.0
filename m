Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F377E8E69
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 18:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfJ2RkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 13:40:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36070 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ2Rj7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Oct 2019 13:39:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id x14so11110186qtq.3
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbqmVKGKwC3WwF9LnMswqHfUpZkWivjXavqOsIAHHoo=;
        b=dzWy1t16bqwR7rVRekoeaH4Yll7O5Mht21rR4mxBmUeJEQ5OgJs4CY2TFU6XDhcbwr
         QFW3oUTlXvzbnz1jTjIvbCnnCQ7Hv4MVw86uZjGMvQbkpLZ8tJYPS82Vg0R8HPmACj8b
         CgyykFYUnVRTAC8SAq9CwbfdtawOlHe5A9zJ5X+/EbZgU/az/B4Z+yQh7PBxjI1iZWdK
         GQSqFqaDgav8m+IQ5SuoLJPZF6sldVYMUc+ErTyMd2SzK08Js+1Efq5cshDH5fVqy6by
         A4jHFZojVKytnao/Rsh3TY/Nvq/Eay8je/a4nDcCuUkunS4jAzX7B+ikTfjkcOs6iDyo
         sVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbqmVKGKwC3WwF9LnMswqHfUpZkWivjXavqOsIAHHoo=;
        b=kPJ+uRb0AASl/saZd2aZSnOSNvcX9lxul9T5gxiseJ6yJqHzhKbggaJR6y5V7n9Vdc
         BHUlpx8H/F45eXJFtgGte+sTG1BwOF5L24pHRzktFAq6J8P5ps597zZmHWElo50jC4px
         /I9L9I2tR3I35Bo2PjE+G7lq1r0tGIqsaviCCaAOtVmx5f4kOsUwx3HpGnT7SIllAdi2
         9mONgBbiZePWeHeOSCG08hhQQ1yajq3gQ/9rd6vzFoIdGV8n+HGJ5NXgr1tzJGAl5/j1
         rQ2IDAlKAYp1rH2SS5LCoGIecQabcJI/tPkdhY+GcU1iTAMcbXi61R57IXl04ymD4SfD
         cfLQ==
X-Gm-Message-State: APjAAAXdni5gazyCn3XRpeVYjElj0GHef0aArqN1PkUHjhMk5I7kigfe
        8G++D/JJubNeoGEPnA0CQ4ek6auzF6Qz5rOExGw=
X-Google-Smtp-Source: APXvYqxXcUKYZRdtEMrS5ibgjKxLP+S9Q2KOBeAJyZsLisSjmX79QhFyhBm2dnbDzhCOVcxPD3WkQ8rBqM3sel1lXWU=
X-Received: by 2002:ac8:4890:: with SMTP id i16mr141423qtq.141.1572370798805;
 Tue, 29 Oct 2019 10:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191028122902.9763-1-iii@linux.ibm.com> <CAEf4BzajQL463pCogVAnX1H5Tg-+kj9p_-mAJs=n1r6OfZ2mXg@mail.gmail.com>
 <9B04A778-42CE-4451-A276-5A41D6290055@linux.ibm.com> <20191029151615.GA83844@rdna-mbp>
In-Reply-To: <20191029151615.GA83844@rdna-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 29 Oct 2019 10:39:47 -0700
Message-ID: <CAEf4BzahGwFmFP6wZkLda1p68JUDJRv36XM-8uKtHLovKLNLOQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: allow narrow loads of bpf_sysctl fields with
 offset > 0
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 29, 2019 at 8:16 AM Andrey Ignatov <rdna@fb.com> wrote:
>
> Ilya Leoshkevich <iii@linux.ibm.com> [Tue, 2019-10-29 07:20 -0700]:
> > > Am 29.10.2019 um 05:36 schrieb Andrii Nakryiko <andrii.nakryiko@gmail.com>:
> > >
> > > On Mon, Oct 28, 2019 at 1:09 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> > >>
> > >> --- a/kernel/bpf/cgroup.c
> > >> +++ b/kernel/bpf/cgroup.c
> > >> @@ -1311,12 +1311,12 @@ static bool sysctl_is_valid_access(int off, int size, enum bpf_access_type type,
> > >>                return false;
> > >>
> > >>        switch (off) {
> > >> -       case offsetof(struct bpf_sysctl, write):
> > >> +       case bpf_ctx_range(struct bpf_sysctl, write):
> > >
> > > this will actually allow reads pas t write field (e.g., offset = 2, size = 4).
> >
> > Wouldn't
> >
> >       if (off < 0 || off + size > sizeof(struct bpf_sysctl) || off % size)
> >               return false;
> >
> > prevent all OOB read-write attempts? Especially the off % size part - I
> > think it has the effect of preventing OOB accesses for fields. In
> > particular, it would filter offset = 2, size = 4 case.
>
> Yes, it would. This code makes sure that narrow accesses are aligned so
> that offset = 2 would allow only size = 2 or size = 1.

Yes, you both are right, I missed the "off % size" check above.
Thanks. Looks good to me as well.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>
> > I have also checked the other usages of bpf_ctx_range, for example,
> > bpf_skb_is_valid_access, and they don't seem to be doing anything
> > special.
>
> Yes, sysctl hook follows logic similar to that of other program types.
>
> > >>                if (type != BPF_READ)
> > >>                        return false;
> > >>                bpf_ctx_record_field_size(info, size_default);
> > >>                return bpf_ctx_narrow_access_ok(off, size, size_default);
> > >> -       case offsetof(struct bpf_sysctl, file_pos):
> > >> +       case bpf_ctx_range(struct bpf_sysctl, file_pos)
> > >
> > > this will allow read past context struct altogether. When we allow
> > > ranges, we will have to adjust allowed read size.
> >
> > Same here.
>
> --
> Andrey Ignatov
