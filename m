Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60339C2F0C
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2019 10:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfJAImT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Oct 2019 04:42:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48230 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727785AbfJAImT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Oct 2019 04:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569919337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8AWULPNBM5xtQu7TWGb1bj/ti/j5sBJfVkWEi3Rd3Y=;
        b=TOd7CMluje/Rr4peWbQnONmxOunXgw0dlRghWW22XziBIEgWTs2a+SVz5o25oprraI6n7K
        mFczpcuW/EC/2DvxE2f8ilSOCQ2AssGZQHjTSsITvCrDoksK6jmKGUAkDv6b0FnNEOT3B+
        9EaRtoGr4TKmrdV/cRZ35Z6OMwzJPsM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-PprQSJCNMLCz5wqITZ5gSg-1; Tue, 01 Oct 2019 04:42:15 -0400
Received: by mail-lj1-f199.google.com with SMTP id p18so3909288ljn.1
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2019 01:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TuBvw2mrfFOTeGw74SrYWhsZAQSjB9GnUTEtXc5MODI=;
        b=KR6EdapesL3noQCm5Cq/84qUJvGANlyuhiM2zp3bNr61kPvilBgnNI4YBqgWExucxJ
         1GKAWF8oxJql8VIWXYyOlOhELbVR3shGsneI+eC9SrzEczXPT0heD4pYFZEoXtlg040S
         htQ4lvLHFEYtcwch5ZkYXrPj+Mg7q94i8g7WP/aOQ9yi01zxDMF0MhscyKP8MDYi4rfE
         6J8iciKgkPrSernifB4dpuc/XTV87AGw9dzjEZUvhol6Taok4djAkFCwYt9cJljX/X8b
         KtzGo46haCP8935/gynHofeMZQmRaWGJMUF7er59Gy/8X80lg89G6UyhFQlYLvMEjIu7
         M8ZQ==
X-Gm-Message-State: APjAAAUWHUIXZHemM6s9fLlAIEuvi862UfD+yPY9BEiMnJgoc6vjMiT+
        wlwhPv5bFTwxl8KofLm0g4yt48wHJctthn7AchhS84nhQxBC/CUvnnvCiMrHCGdHwYr/yigwKYe
        vqiQ+t6341YM7
X-Received: by 2002:a19:98e:: with SMTP id 136mr14527939lfj.156.1569919334398;
        Tue, 01 Oct 2019 01:42:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyKrVuPVSgX4a/MGkl8g9g2PDDJ3Tdwznl48zEdEjQLVt8Zj37XSYapNlmxWf0vKrVuD6C9Dw==
X-Received: by 2002:a19:98e:: with SMTP id 136mr14527930lfj.156.1569919334230;
        Tue, 01 Oct 2019 01:42:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id b10sm3945539lji.48.2019.10.01.01.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 01:42:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 79D6618063D; Tue,  1 Oct 2019 10:42:12 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net,
        kpsingh@chromium.org
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [RFC][PATCH bpf-next] libbpf: add bpf_object__open_{file,mem} w/ sized opts
In-Reply-To: <20190930164239.3697916-1-andriin@fb.com>
References: <20190930164239.3697916-1-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Oct 2019 10:42:11 +0200
Message-ID: <871rvwx3fg.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: PprQSJCNMLCz5wqITZ5gSg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> Add new set of bpf_object__open APIs using new approach to optional
> parameters extensibility allowing simpler ABI compatibility approach.
>
> This patch demonstrates an approach to implementing libbpf APIs that
> makes it easy to extend existing APIs with extra optional parameters in
> such a way, that ABI compatibility is preserved without having to do
> symbol versioning and generating lots of boilerplate code to handle it.
> To facilitate succinct code for working with options, add OPTS_VALID,
> OPTS_HAS, and OPTS_GET macros that hide all the NULL and size checks.
>
> Additionally, newly added libbpf APIs are encouraged to follow similar
> pattern of having all mandatory parameters as formal function parameters
> and always have optional (NULL-able) xxx_opts struct, which should
> always have real struct size as a first field and the rest would be
> optional parameters added over time, which tune the behavior of existing
> API, if specified by user.

I think this is a reasonable idea. It does require some care when adding
new options, though. They have to be truly optional. I.e., I could
imagine that we will have cases where the behaviour might need to be
different if a program doesn't understand a particular option (I am
working on such a case in the kernel ATM). You could conceivably use the
OPTS_HAS() macro to test for this case in the code, but that breaks if a
program is recompiled with no functional change: then it would *appear*
to "understand" that option, but not react properly to it.

In other words, this should only be used for truly optional bits (like
flags) where the default corresponds to unchanged behaviour relative to
when the option was added.

A few comments on the syntax below...


> +static struct bpf_object *
> +__bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
> +=09=09       struct bpf_object_open_opts *opts, bool enforce_kver)

I realise this is an internal function, but why does it have a
non-optional parameter *after* the opts?

>  =09char tmp_name[64];
> +=09const char *name;
> =20
> -=09/* param validation */
> -=09if (!obj_buf || obj_buf_sz <=3D 0)
> -=09=09return NULL;
> +=09if (!OPTS_VALID(opts) || !obj_buf || obj_buf_sz =3D=3D 0)
> +=09=09return ERR_PTR(-EINVAL);
> =20
> +=09name =3D OPTS_GET(opts, object_name, NULL);
>  =09if (!name) {
>  =09=09snprintf(tmp_name, sizeof(tmp_name), "%lx-%lx",
>  =09=09=09 (unsigned long)obj_buf,
>  =09=09=09 (unsigned long)obj_buf_sz);
>  =09=09name =3D tmp_name;
>  =09}
> +
>  =09pr_debug("loading object '%s' from buffer\n", name);
> =20
> -=09return __bpf_object__open(name, obj_buf, obj_buf_sz, true, true);
> +=09return __bpf_object__open(name, obj_buf, obj_buf_sz, enforce_kver, 0)=
;
> +}
> +
> +struct bpf_object *
> +bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
> +=09=09     struct bpf_object_open_opts *opts)
> +{
> +=09return __bpf_object__open_mem(obj_buf, obj_buf_sz, opts, false);
> +}
> +
> +struct bpf_object *
> +bpf_object__open_buffer(const void *obj_buf, size_t obj_buf_sz, const ch=
ar *name)
> +{
> +=09struct bpf_object_open_opts opts =3D {
> +=09=09.sz =3D sizeof(struct bpf_object_open_opts),
> +=09=09.object_name =3D name,
> +=09};

I think this usage with the "size in struct" model is really awkward.
Could we define a macro to help hide it? E.g.,

#define BPF_OPTS_TYPE(type) struct bpf_ ## type ## _opts
#define DECLARE_BPF_OPTS(var, type) BPF_OPTS_TYPE(type) var =3D { .sz =3D s=
izeof(BPF_OPTS_TYPE(type)); }

Then the usage code could be:

DECLARE_BPF_OPTS(opts, object_open);
opts.object_name =3D name;

Still not ideal, but at least it's less boiler plate for the caller, and
people will be less likely to mess up by forgetting to add the size.

-Toke

