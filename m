Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A064615C93D
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2020 18:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgBMRNq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Feb 2020 12:13:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46266 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgBMRNq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Feb 2020 12:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581614025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUYm4oxa0lX51akAxHQTtAdlCfDMW1QF1UNDbLFoX9Q=;
        b=XpI0Cvo5PGbogEvNeHi7HAdh9o1KLwPYU6GJaogxYt++zdLmkcu+xPI81QN+TViJTcDtge
        XnKFKBdSCdZusqu1dtOCNGF5IU1BxBFNoC1lqdEEiyNlS9ubad/nHHRqQpDjINPxv2QqBs
        0sNc+Dowuf7lON9o5xz2v7NyIAb01AI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-j5AoKCcuOLqVOZxXywHT6A-1; Thu, 13 Feb 2020 12:13:43 -0500
X-MC-Unique: j5AoKCcuOLqVOZxXywHT6A-1
Received: by mail-lj1-f200.google.com with SMTP id b3so2343928ljo.23
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2020 09:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DUYm4oxa0lX51akAxHQTtAdlCfDMW1QF1UNDbLFoX9Q=;
        b=F1V3d/69cJRQeeo7hU+H5LW+uBk61As1dIoCnV1h1hVaLfBhPbiM0rXzjausu+REd7
         j6kzhxUJ7SM3P6PuLQdboOMbYcUBRiSHLRDVxKJXsYV4+kkW7ThoAfcU14B+IZoY1LLM
         7RlioYR/AuUaGKQCKTchcDY8zWM2jAQBaJP/KK+qdBjbmUztnpI8MvJPATVxioH1GIgw
         ys3OhijxIjhu/wCisBqpJxe7yjvzGsZ9QQ87cMKm9mPKeSZ3YHl1u1OmH3Meg0xvwbzE
         E81ztavkIDCWrbLV8y2mI7RpE9i72to1cdiANcUQ7rdSD++bVYkDhfkzSE2qmCokKbN6
         Dnaw==
X-Gm-Message-State: APjAAAVaYwEHu3wmTwU2UPZHeU5HyDgKL1jR47T8T0HnHy05YY+EnMsQ
        Q1Wv1luhwv52gVNDhG68sUmowdGpvW8P3DOf8obdDAvlFq+Ox5oE3ngMc/c3Wlwk38XAlA8kvcm
        EQKhOy3LsURIL
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr11992877lji.214.1581614021935;
        Thu, 13 Feb 2020 09:13:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyz5FqI+lBgkJEI1LL8nhuqKOVGUpzumfLFBQjlOfE2HvYbwBBXTr8H0gmi+5XNSDxY4077vw==
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr11992842lji.214.1581614021247;
        Thu, 13 Feb 2020 09:13:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b17sm1921372ljd.5.2020.02.13.09.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:13:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 925BA180364; Thu, 13 Feb 2020 18:13:36 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Eelco Chaudron <echaudro@redhat.com>
Cc:     bpf@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Subject: Re: [PATCH bpf-next v2] libbpf: Add support for dynamic program attach target
In-Reply-To: <47AD4CC2-4D14-419C-87FC-A86F5B7E0974@redhat.com>
References: <158160616195.80320.5636088335810242866.stgit@xdp-tutorial> <87h7zuh5am.fsf@toke.dk> <47AD4CC2-4D14-419C-87FC-A86F5B7E0974@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 13 Feb 2020 18:13:36 +0100
Message-ID: <87eeuyh0lb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Eelco Chaudron" <echaudro@redhat.com> writes:

> On 13 Feb 2020, at 16:32, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>> Eelco Chaudron <echaudro@redhat.com> writes:
>>
>>> Currently when you want to attach a trace program to a bpf program
>>> the section name needs to match the tracepoint/function semantics.
>>>
>>> However the addition of the bpf_program__set_attach_target() API
>>> allows you to specify the tracepoint/function dynamically.
>>>
>>> The call flow would look something like this:
>>>
>>>   xdp_fd =3D bpf_prog_get_fd_by_id(id);
>>>   trace_obj =3D bpf_object__open_file("func.o", NULL);
>>>   prog =3D bpf_object__find_program_by_title(trace_obj,
>>>                                            "fentry/myfunc");
>>>   bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
>>>   bpf_program__set_attach_target(prog, xdp_fd,
>>>                                  "xdpfilt_blk_all");
>>>   bpf_object__load(trace_obj)
>>>
>>> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
>>
>> Hmm, one question about the attach_prog_fd usage:
>>
>>> +int bpf_program__set_attach_target(struct bpf_program *prog,
>>> +				   int attach_prog_fd,
>>> +				   const char *attach_func_name)
>>> +{
>>> +	int btf_id;
>>> +
>>> +	if (!prog || attach_prog_fd < 0 || !attach_func_name)
>>> +		return -EINVAL;
>>> +
>>> +	if (attach_prog_fd)
>>> +		btf_id =3D libbpf_find_prog_btf_id(attach_func_name,
>>> +						 attach_prog_fd);
>>> +	else
>>> +		btf_id =3D __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
>>> +					       attach_func_name,
>>> +					       prog->expected_attach_type);
>>
>> This implies that no one would end up using fd 0 as a legitimate prog
>> fd. This already seems to be the case for the existing code, but is=20
>> that
>> really a safe assumption? Couldn't a caller that closes fd 0 (for
>> instance while forking) end up having it reused? Seems like this could
>> result in weird hard-to-debug bugs?
>
>
> Yes, in theory, this can happen but it has nothing to do with this=20
> specific patch. The existing code already assumes that attach_prog_fd =3D=
=3D=20
> 0 means attach to a kernel function :(

Yup, I do realise you're just sticking to the existing behaviour. Seems
even the kernel does that check for fd !=3D 0, so I guess that's ABI now.
Still not sure I believe this will not trip anyone up, though... :/

-Toke

