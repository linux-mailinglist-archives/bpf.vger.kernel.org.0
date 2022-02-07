Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CC14AC82E
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 19:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbiBGSDd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 13:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344917AbiBGR52 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 12:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C79B9C0401DA
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 09:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644256646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nSrsLxKO5uzyOgVc1p4ANil8NgYxSlUbB/IGZjdK54=;
        b=i0A+yv7SUBCkA6Jvbn59lU+adTrdEOlPVHt0QmkQw+G41Qp5oxSccGJx46cylHt9KMwuT8
        Qhxy+hXIxAOXxETu0jBcRw2txT0FvWhrYVZBJ4/9GMRLUFi1OktmSyiVnB6RS0ykQmFz7J
        WiX47W3FDLIGlOvPKavgOfJchBEdr6M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-vsbmz64ON6-K1Sny252Arw-1; Mon, 07 Feb 2022 12:57:25 -0500
X-MC-Unique: vsbmz64ON6-K1Sny252Arw-1
Received: by mail-wr1-f71.google.com with SMTP id l27-20020adfa39b000000b001e315c20064so1114653wrb.10
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 09:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6nSrsLxKO5uzyOgVc1p4ANil8NgYxSlUbB/IGZjdK54=;
        b=x0s5oLUqR12FMnBJSgopWkKVj3/A7kl+9u/oYVkX4q0PNLTXRwmRjt5z9t0LB9s+r7
         hNj7xWnnN1v1y5ijv5iXTz44ieXNJvYdiQD0vFX91NL1dtsJwb/373+JNBYqr3oJXbR+
         lNAgh3x+0UV1UwkPEITnR2YVrbGUg48dPIfCdBCYlz1e00H24M7Q1IKAKEC04p0sJsTt
         /0Sm6wpkYFaCZehqesRplceX6CknwIwm0HeF2LzdRcRf7jo8rxzLahqNRmFvQaArV6x4
         +/4BY0yfWaD28m2SzdfE5uq2V6N57CF0CjLoBP0YJ+siuhHKuE8WjPZThgnPOTiMgmn7
         v8oA==
X-Gm-Message-State: AOAM532RlSEuOHgAN7ICSZbswwwm9qyIXHwLQLLuoJBNoCNVXeDVxA/0
        Yr+4YxsBzTeTW4vO9g61mtvjf33morchKWcEVip32SErHgfzD0ICg+Dgc4egn8rMNq97roUXwgO
        2VsnaO+LkqLkI
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr451477wrw.673.1644256643373;
        Mon, 07 Feb 2022 09:57:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQgEs8mKMebfCPlVO2orIk3HGeddGG7PAsLFaQwiVuH4PXW2fVM1ru4fUOVlXYizg6VNg/kg==
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr451462wrw.673.1644256643183;
        Mon, 07 Feb 2022 09:57:23 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l24sm27332wms.24.2022.02.07.09.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 09:57:22 -0800 (PST)
Date:   Mon, 7 Feb 2022 18:57:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yinjun Zhang <yinjun.zhang@corigine.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, niklas.soderlund@corigine.com,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH bpf] bpftool: fix the error when lookup in no-btf maps
Message-ID: <YgFdgOVdEWUx63Ik@krava>
References: <1644249625-22479-1-git-send-email-yinjun.zhang@corigine.com>
 <CAEf4BzbjVnkb8Oz67p3jDhL-Pv9RG-wq1A7KMV06zowRK9psew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbjVnkb8Oz67p3jDhL-Pv9RG-wq1A7KMV06zowRK9psew@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 07, 2022 at 09:42:25AM -0800, Andrii Nakryiko wrote:
> On Mon, Feb 7, 2022 at 8:00 AM Yinjun Zhang <yinjun.zhang@corigine.com> wrote:
> >
> > When reworking btf__get_from_id() in commit a19f93cfafdf the error
> > handling when calling bpf_btf_get_fd_by_id() changed. Before the rework
> > if bpf_btf_get_fd_by_id() failed the error would not be propagated to
> > callers of btf__get_from_id(), after the rework it is. This lead to a
> > change in behavior in print_key_value() that now prints an error when
> > trying to lookup keys in maps with no btf available.
> >
> > Fix this by following the way used in dumping maps to allow to look up
> > keys in no-btf maps, by which it decides whether and where to get the
> > btf info according to the btf value type.
> >
> > Fixes: a19f93cfafdf ("libbpf: Add internal helper to load BTF data by FD")
> > Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
> > Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
> > Signed-off-by: Simon Horman <simon.horman@corigine.com>
> > ---
> >  tools/bpf/bpftool/map.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> > index cc530a229812..4fc772d66e3a 100644
> > --- a/tools/bpf/bpftool/map.c
> > +++ b/tools/bpf/bpftool/map.c
> > @@ -1054,11 +1054,9 @@ static void print_key_value(struct bpf_map_info *info, void *key,
> >         json_writer_t *btf_wtr;
> >         struct btf *btf;
> >
> > -       btf = btf__load_from_kernel_by_id(info->btf_id);
> > -       if (libbpf_get_error(btf)) {
> > -               p_err("failed to get btf");
> > +       btf = get_map_kv_btf(info);
> > +       if (libbpf_get_error(btf))
> 
> See discussion in [0], it seems relevant.
> 
>   [0] https://lore.kernel.org/bpf/20220204225823.339548-3-jolsa@kernel.org/

I checked and this patch does not fix the problem for me,
but looks like similar issue, do you have test case for this?

mine is to dump any no-btf map with -p option

thanks,
jirka

