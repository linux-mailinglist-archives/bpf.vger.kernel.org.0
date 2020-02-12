Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB8C15A9A7
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2020 14:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgBLNFX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Feb 2020 08:05:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41111 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725887AbgBLNFX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 Feb 2020 08:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581512722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/XD0MHQK5ZuJMwMqcwKOLpQ1jPM8Al3qW0s4LcNAgmg=;
        b=jCCxIZB+LvKuYZ3/m+vP6CszVn/ISVGOEvWCgCKhWV3uwWBw8a8ayZUwWPAFDxpPBKlnNr
        I3G8+I4WV6N5MZsUzFaS238h8z/MvxzJUvtYJZYh1jLIQe7oaWgTiUsF9TWM/HnMc64qgx
        2/p5f/pmmU5thQHiIAZx5hoezTTc8+o=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-AKprAc35P02G6yEOoxfudA-1; Wed, 12 Feb 2020 08:05:20 -0500
X-MC-Unique: AKprAc35P02G6yEOoxfudA-1
Received: by mail-lj1-f199.google.com with SMTP id l14so748819ljb.10
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2020 05:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/XD0MHQK5ZuJMwMqcwKOLpQ1jPM8Al3qW0s4LcNAgmg=;
        b=fG2ElPti+TU7NjQNYA9FENHIDJHcDRdVLqJ1y0drKVaIt4knaz+bz7jieTgtsRXgWI
         MyQBa55xCy0uhmtz3d9W2W8d5DhJD1Fj+pCIVvjL4SjfDKgqrPIzkEt2kBrCqni5nB+4
         YszYjk4z9iKVQBjf8XcjP+24VddZaRbCUmqAPHlEeIMbSjrtozl1Mcy24b4dhFpfrAdG
         596duanPCNMs2wa6Kdv8viZsJtCou4PzoZm5G7xVWjm8o1up+KFCw6qv4wj+F3G6rzKL
         s4ebpgXMMx95h9EMruL6zEdvUqUNWv7rw04a+ZVIWBoWyZL9QPnThtRvkD7gL3ldDoam
         PQmw==
X-Gm-Message-State: APjAAAU/OUn3/W7Z6k5YlECoD2EnRBinzCbWOC/XU31R+YtmN8832Y6j
        6DRmAwn5bBDWohjk8O0Xc2GgDZD77wmqMXlqCheePXj85G2Skw3QNbFK6f89jOL3LjiwzvyfyoW
        FFtEy1fqyXfcJ
X-Received: by 2002:a19:4f46:: with SMTP id a6mr6617544lfk.143.1581512719254;
        Wed, 12 Feb 2020 05:05:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEmYbs1kpH4LtWXeOOm0UGQZP4l0SeP5rAJoLcOaLK6Rn3gHLo/Dl6HD3JuR8fFbbymXRJDw==
X-Received: by 2002:a19:4f46:: with SMTP id a6mr6617529lfk.143.1581512719049;
        Wed, 12 Feb 2020 05:05:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s15sm235031ljs.58.2020.02.12.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 05:05:15 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id ADE9A180365; Wed, 12 Feb 2020 14:05:13 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Eelco Chaudron <echaudro@redhat.com>, bpf@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com
Subject: Re: [PATCH bpf-next] libbpf: Add support for dynamic program attach target
In-Reply-To: <158151067149.71757.2222114135650741733.stgit@xdp-tutorial>
References: <158151067149.71757.2222114135650741733.stgit@xdp-tutorial>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 12 Feb 2020 14:05:13 +0100
Message-ID: <874kvwhs6u.fsf@toke.dk>
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
>   bpf_program__set_attach_target(prog, xdp_fd,
>                                  "fentry/xdpfilt_blk_all");

I think it would be better to have the attach type as a separate arg
instead of encoding it in the function name. I.e., rather:

   bpf_program__set_attach_target(prog, xdp_fd,
                                  "xdpfilt_blk_all", BPF_TRACE_FENTRY);

-Toke

