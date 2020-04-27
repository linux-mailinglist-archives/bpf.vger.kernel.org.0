Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791391BAF31
	for <lists+bpf@lfdr.de>; Mon, 27 Apr 2020 22:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgD0USt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Apr 2020 16:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0USt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Apr 2020 16:18:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8BFC0A3BF5
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2020 13:18:49 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b1so11816454qtt.1
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2020 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4cawZpukBw1+Q25BdOqsQHK1urediqAEbyuaY1Hefs=;
        b=EhVvTDlqn1lqTJhu6OX8igYAMA2XjCri6Ee1wZc1NbwzcIF908bfuL2zQNBqzFuxeW
         7+ykw2T21AQ5bC9FA8Tcmx5iJBuGFY8M9sNlKug+YqDPoQxaJGQpiOmD9aOvX98kuw1e
         IvtKJhb/9pIC4u+9VxUaUnKG7Kl6M2/Zz/M4duzJ4mzwSDGYqIJ/+ZOVL5lqOdgzOdhc
         fgfQJxB4L6WwhUc7kQU6DVyAuQhXQsP5M/JNZkvms+0wXuuGByGmCjnt/ADILgHvtIy5
         PF1PyseG+YNK/LOZheOVTFjq6RL82o7jv2xOxnOVfwekzslvvIz+2JxmtwSJFMte/aWk
         A7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4cawZpukBw1+Q25BdOqsQHK1urediqAEbyuaY1Hefs=;
        b=jBsMgvwtN5j2UXb8wQo7ISRw74l4GWj6AxmA9/fPOteNB4bk96MHabCwYu7QB08GNq
         gSP1OhJlOrhwD5SI2xeaN5BPcks+izeCgyITjl5fEvcP6JYoooCng5vI2D7El6CxmoqS
         pZPBm0RPU0FLJ6Rs9050E4OdjzKR0RsgulQHD+GtXfutY2NZzeuNbSjs8nhEBzhfyumY
         BZT9chtYAk1fnIws9UGvzHJHsebGTBvDc7wP+gjTxu7PplYqAM+U6Ps7+bhtEUMGzzXz
         1lrrJDYLOH9gDD1VcjcSyhmY28Ynv/D7vWhA+qHPg90brfChBM/Ekk3AjGE3N56DFZaM
         rEDQ==
X-Gm-Message-State: AGi0PuZZ4DErc75qcC6CcDr6WQpkh668oxC+UfsL6/6PyYk3qlmLdr6G
        BtCgRsE84dx1/x3emM/o7Pki4Xfva/vpoN1m0J+EyOtE
X-Google-Smtp-Source: APiQypLnEN1TkH/F3a3i1dQGZpV5Uje4BHr76hZ2KKwTthYpbrzFscpTJa6nx6jUbtOa2INXBYpGqVymZPC+tBgZi7Y=
X-Received: by 2002:ac8:468d:: with SMTP id g13mr24206957qto.59.1588018728270;
 Mon, 27 Apr 2020 13:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200427132940.2857289-1-vkabatov@redhat.com> <20200427160240.5e66a954@carbon>
In-Reply-To: <20200427160240.5e66a954@carbon>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Apr 2020 13:18:37 -0700
Message-ID: <CAEf4BzbZPHyR5cqqM73QbppHMDuaRXCf9z08VZFcohdsQE2DGw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Copy runqslower to OUTPUT directory
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 27, 2020 at 7:03 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Mon, 27 Apr 2020 15:29:40 +0200
> Veronika Kabatova <vkabatov@redhat.com> wrote:
>
> > $(OUTPUT)/runqslower makefile target doesn't actually create runqslower
> > binary in the $(OUTPUT) directory. As lib.mk expects all
> > TEST_GEN_PROGS_EXTENDED (which runqslower is a part of) to be present in
> > the OUTPUT directory, this results in an error when running e.g. `make
> > install`:
> >
> > rsync: link_stat "tools/testing/selftests/bpf/runqslower" failed: No
> >        such file or directory (2)
> >
> > Copy the binary into the OUTPUT directory after building it to fix the
> > error.
> >
> > Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> > ---
>

Did I miss original patch somewhere on bpf@vger mailing list?..

> Looks good to me
>
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
>
> >  tools/testing/selftests/bpf/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 7729892e0b04..cb8e7e5b2307 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -142,6 +142,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ)
> >       $(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower     \
> >                   OUTPUT=$(SCRATCH_DIR)/ VMLINUX_BTF=$(VMLINUX_BTF)   \
> >                   BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)
> > +     @cp $(SCRATCH_DIR)/runqslower $(OUTPUT)/runqslower

This should be AND'ed (&&) with $(MAKE) to not attempt copy on failed
make run. Also in general @cp should be $(Q)cp, but if you use $$ you
shouldn't need $(Q).

Also, just use $@ instead of $(OUTPUT)/runqslower:

cp $(SCRATCH_DIR)/runqslower $@

> >
> >  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/test_stub.o $(BPFOBJ)
>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>
