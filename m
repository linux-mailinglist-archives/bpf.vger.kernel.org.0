Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAFA215B31B
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2020 22:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgBLVwd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Feb 2020 16:52:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20065 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727692AbgBLVwc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 Feb 2020 16:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581544352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ut8JNPHbV/vle2Nzp00xNm23ljflYGh+71pleXomCZU=;
        b=ZqFdRBXlCHiWi0DyafUC+prUyJ/Op51np8ickjWbBHl2JIpML2v5VluWAZGePDtP4MSGLf
        Gkn6JD4AphELrwLr6+6wnn+I8eOoVvXyAtU519va3Uocvw85rplgSZpOwFliMYR3uqUF1j
        Vz/uZGesNFl98spsAmwLTIhYqUFMx5E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-2Gzp6khqPpO-Y_GPy1_FAg-1; Wed, 12 Feb 2020 16:52:29 -0500
X-MC-Unique: 2Gzp6khqPpO-Y_GPy1_FAg-1
Received: by mail-lj1-f200.google.com with SMTP id t23so1280850ljk.14
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2020 13:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ut8JNPHbV/vle2Nzp00xNm23ljflYGh+71pleXomCZU=;
        b=gBKVsshsqwUDDq0Cx+7RRb9XZjSCv9ydVEAUFmuOPuf5ZCyKvtUmAK9ohMbiD5Av43
         Zky169/m3pxdrrhJEABR7ESB+JRK3pDcdYANtneGPvwyDjh4BTz6HhX7Cog5VsDlQZrZ
         jHLsD8VZ8FRU2Cy5lEOA8RfZ6LhciZ4pjsKDFdl7ezzIUSVzuFQnSEFay322CB4w3tgV
         jvnBbEbVk4jO9mEK7evsq5M3nevjKFUqRrxVpbC4bwccNX5+fphT2MSp9u8h0VYXGncd
         Y3Z/SisCK3J+QTQ8fXI6iXD9fqY1vvhKvjs6hbUAAT0yBi5Qbz+g1IHPCgPYv4ySbwZc
         LLOw==
X-Gm-Message-State: APjAAAWO2GY1xxjBo/4uCxsiWkIwU9gb6kMJFREw2mLbeCfgQCCKdZQH
        6E5mCMwvhimU1bVlaClfWwrvYznytVSKpdfM1khwCrQtKwh6VsqBmnIMYuum/2uVVfI7BIcUA3c
        sftlrkKtj/3Yc
X-Received: by 2002:a2e:7009:: with SMTP id l9mr8969124ljc.96.1581544348339;
        Wed, 12 Feb 2020 13:52:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzcymufI4ntD4MBsujZ3eOdrYHFB8Xec/vw1aTAActF+XRlvmm52LjGj5ypd+aafURKhkvgWQ==
X-Received: by 2002:a2e:7009:: with SMTP id l9mr8969113ljc.96.1581544348116;
        Wed, 12 Feb 2020 13:52:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j19sm193887lfb.90.2020.02.12.13.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:52:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 792F7180365; Wed, 12 Feb 2020 22:52:25 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Eelco Chaudron <echaudro@redhat.com>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next] libbpf: Add support for dynamic program attach target
In-Reply-To: <CAEf4BzYn3pVhqzj8PwRWxjWSJ16CS9d60zFtsS=OuA5ydPyp2Q@mail.gmail.com>
References: <158151067149.71757.2222114135650741733.stgit@xdp-tutorial> <874kvwhs6u.fsf@toke.dk> <CAEf4BzYn3pVhqzj8PwRWxjWSJ16CS9d60zFtsS=OuA5ydPyp2Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 12 Feb 2020 22:52:25 +0100
Message-ID: <871rqziicm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Feb 12, 2020 at 5:05 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Eelco Chaudron <echaudro@redhat.com> writes:
>>
>> > Currently when you want to attach a trace program to a bpf program
>> > the section name needs to match the tracepoint/function semantics.
>> >
>> > However the addition of the bpf_program__set_attach_target() API
>> > allows you to specify the tracepoint/function dynamically.
>> >
>> > The call flow would look something like this:
>> >
>> >   xdp_fd =3D bpf_prog_get_fd_by_id(id);
>> >   trace_obj =3D bpf_object__open_file("func.o", NULL);
>> >   prog =3D bpf_object__find_program_by_title(trace_obj,
>> >                                            "fentry/myfunc");
>> >   bpf_program__set_attach_target(prog, xdp_fd,
>> >                                  "fentry/xdpfilt_blk_all");
>>
>> I think it would be better to have the attach type as a separate arg
>> instead of encoding it in the function name. I.e., rather:
>>
>>    bpf_program__set_attach_target(prog, xdp_fd,
>>                                   "xdpfilt_blk_all", BPF_TRACE_FENTRY);
>
> I agree about not specifying section name prefix (e.g., fentry/). But
> disagree that expected attach type (BPF_TRACE_FENTRY) should be part
> of this API. We already have bpf_program__set_expected_attach_type()
> API, no need to duplicate it here.

Ah yes, forgot about that; just keeping that and making this function
name only is fine with me :)

-Toke

