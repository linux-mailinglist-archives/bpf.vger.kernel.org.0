Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4151515C290
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2020 16:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgBMPeo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Feb 2020 10:34:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45980 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729857AbgBMPdQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Feb 2020 10:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581607995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RFvkSpm4IwLd01HTkzruRySmSPs5no9cLpZYqP7h4Y8=;
        b=dPEsvQDrUCR3Y58tUw7k7Umc+WXevrJGABPhZQd+CYlpG6n2UqvDdY+Pv6MSIBiAkW6Koq
        BROT4l2EghntLZOouN4QqLoLdHN0pzfbtgPueC5pEYFY2mzisQKKEHhArRNh1nuW0gRmYa
        DFO5MN5C1oFdJAZwnGVGhqALpYEM0MI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-szT_aBQNNPK3GHOyJC4t4A-1; Thu, 13 Feb 2020 10:32:04 -0500
X-MC-Unique: szT_aBQNNPK3GHOyJC4t4A-1
Received: by mail-lj1-f200.google.com with SMTP id k25so2241612lji.4
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2020 07:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RFvkSpm4IwLd01HTkzruRySmSPs5no9cLpZYqP7h4Y8=;
        b=AkHxb56XgOlBmCdcbBw5M3CTU+BGirVepFJtHk69SV3cjaJwj7HjyG/RgFeQf6+PyK
         A21IPYkviv7R0i9AxeDwOIRpsCAmBSTS3U3eRSIgyyMbM0X3pCm0JL397rongcrHQ2+A
         kjR6BiKcVnAmvtLtKNS72+LBX/uG/xHFhRxcFoLCwhXMogxMjzzLmZVTjJpBmMqo6Xlh
         3815JgH5rU1IYQVbV3zla3b6C5pA++FnWm5aw2nBcI4zfb0458iUOUjIlBlOFzYRuL6K
         hgX2VS5Sk72gWDeY1I3cZVEBQ3Vvycr07zyFrCdrJGD8ykX0zXY0lzYV9pF7bl195484
         Utzg==
X-Gm-Message-State: APjAAAXIh3qklY5rnHnry85O5EJPxrT4WIqj2xYd/BVXQ3DuUat6Qq+H
        1wnsTm9/a5ZhvkRv43y8sIq0zzQ48Y+sF3jSczEh9jGKmIbHhlf83GrYUSsXsANtkOOrIsLSm4g
        Pw4rlRu/FtwE+
X-Received: by 2002:a2e:7818:: with SMTP id t24mr11193078ljc.195.1581607923160;
        Thu, 13 Feb 2020 07:32:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqw0y9boF3lVrvrxVIhdVwRR6fhl5800oZPJ3Twbe8XRUDRYmViuzFOpaQTcoR3Z8ImnxC8Dfw==
X-Received: by 2002:a2e:7818:: with SMTP id t24mr11193064ljc.195.1581607922961;
        Thu, 13 Feb 2020 07:32:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a12sm1699198ljk.48.2020.02.13.07.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:32:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9103B180365; Thu, 13 Feb 2020 16:32:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Eelco Chaudron <echaudro@redhat.com>, bpf@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com
Subject: Re: [PATCH bpf-next v2] libbpf: Add support for dynamic program attach target
In-Reply-To: <158160616195.80320.5636088335810242866.stgit@xdp-tutorial>
References: <158160616195.80320.5636088335810242866.stgit@xdp-tutorial>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 13 Feb 2020 16:32:01 +0100
Message-ID: <87h7zuh5am.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Eelco Chaudron <echaudro@redhat.com> writes:

> Currently when you want to attach a trace program to a bpf program
> the section name needs to match the tracepoint/function semantics.
>
> However the addition of the bpf_program__set_attach_target() API
> allows you to specify the tracepoint/function dynamically.
>
> The call flow would look something like this:
>
>   xdp_fd = bpf_prog_get_fd_by_id(id);
>   trace_obj = bpf_object__open_file("func.o", NULL);
>   prog = bpf_object__find_program_by_title(trace_obj,
>                                            "fentry/myfunc");
>   bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
>   bpf_program__set_attach_target(prog, xdp_fd,
>                                  "xdpfilt_blk_all");
>   bpf_object__load(trace_obj)
>
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>

Hmm, one question about the attach_prog_fd usage:

> +int bpf_program__set_attach_target(struct bpf_program *prog,
> +				   int attach_prog_fd,
> +				   const char *attach_func_name)
> +{
> +	int btf_id;
> +
> +	if (!prog || attach_prog_fd < 0 || !attach_func_name)
> +		return -EINVAL;
> +
> +	if (attach_prog_fd)
> +		btf_id = libbpf_find_prog_btf_id(attach_func_name,
> +						 attach_prog_fd);
> +	else
> +		btf_id = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
> +					       attach_func_name,
> +					       prog->expected_attach_type);

This implies that no one would end up using fd 0 as a legitimate prog
fd. This already seems to be the case for the existing code, but is that
really a safe assumption? Couldn't a caller that closes fd 0 (for
instance while forking) end up having it reused? Seems like this could
result in weird hard-to-debug bugs?

-Toke

