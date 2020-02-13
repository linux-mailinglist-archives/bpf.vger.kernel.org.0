Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8E7D15C940
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2020 18:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgBMROB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Feb 2020 12:14:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46896 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728489AbgBMROB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Feb 2020 12:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581614039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4meJ+9cGtIXsHFSQL1G0hT63jAf2xSIQo/UpbNAdilE=;
        b=Vco5YffiqH7mp533eIlfetJH7ZJYAgMtlUXTlspaTI3cDYhkTh2EjO3xSRbkujc1xNseP2
        fc08TLmADgQLKIrBzzhSdoEDLt1aEpf/SXHfmqPD4onh3H7aOwec4ZNzDIizytP+bW5GA/
        gA8YRhFke8czf0VIU0/OZcv46caEmLg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-Q2K9M6PhM4yKk8QDFf77Ww-1; Thu, 13 Feb 2020 12:13:49 -0500
X-MC-Unique: Q2K9M6PhM4yKk8QDFf77Ww-1
Received: by mail-lj1-f199.google.com with SMTP id l14so2354382ljb.10
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2020 09:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4meJ+9cGtIXsHFSQL1G0hT63jAf2xSIQo/UpbNAdilE=;
        b=Y3lZj6T1v39ZkSGD+txVaMn1WzlYpL51J4jJc+la0liTWsWny3sneYVh4Rc7vQnsqT
         bTGU3VlXY8DXBP0E/Fp+90JvkXzUUxQtbNQj/FCVe2IsJRSN6Kqr9jbD+nmC4PPFX58R
         G5RH0GC31utXVcUErhd08Kf6j4ZWANoEjUzPTo9guhRfjResp6VozygnTLGHbCwBqSNQ
         WmuKEW1Jx7l8ukR8AJK4rUW/SkgLkoZR5t1ZQclI/7mYAOQs4+5oe5b26RP4IPa/5VOi
         f+zeol6sbatapIsR+PtYQWuM+r5g86LclzbCK+YXGahFhzXu47REj9Wc0IdbPegQloEl
         /zxg==
X-Gm-Message-State: APjAAAVw5Zro9ywedv8aVQGWfEwWDq+zG9P0p8sv2sQgdk/bjgsYA6hR
        GRlfYj/98XW0fLQlaj9BNDaiEa+PYeKwtH1/vLfJftuZ+PApVRHToNN3/f5ayMEaAjyc4U5Q8Hc
        xnarTBNzIcPV0
X-Received: by 2002:a05:6512:3f6:: with SMTP id n22mr10110517lfq.59.1581614027950;
        Thu, 13 Feb 2020 09:13:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqy69WpTIKdAdOq6vjd9P/Up6B7Z4JvuIAqSNVob3Necf0Rf7t52pVnPkRyEITMrFK8InvJU0A==
X-Received: by 2002:a05:6512:3f6:: with SMTP id n22mr10110503lfq.59.1581614027754;
        Thu, 13 Feb 2020 09:13:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a28sm1607172lfg.86.2020.02.13.09.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:13:47 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 96807180364; Thu, 13 Feb 2020 18:13:46 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Eelco Chaudron <echaudro@redhat.com>, bpf@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com
Subject: Re: [PATCH bpf-next v2] libbpf: Add support for dynamic program attach target
In-Reply-To: <158160616195.80320.5636088335810242866.stgit@xdp-tutorial>
References: <158160616195.80320.5636088335810242866.stgit@xdp-tutorial>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 13 Feb 2020 18:13:46 +0100
Message-ID: <87blq2h0l1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
>   xdp_fd =3D bpf_prog_get_fd_by_id(id);
>   trace_obj =3D bpf_object__open_file("func.o", NULL);
>   prog =3D bpf_object__find_program_by_title(trace_obj,
>                                            "fentry/myfunc");
>   bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
>   bpf_program__set_attach_target(prog, xdp_fd,
>                                  "xdpfilt_blk_all");
>   bpf_object__load(trace_obj)
>
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

