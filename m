Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46491196E9
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 22:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfLJV34 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 16:29:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60809 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727230AbfLJVKB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576012200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Dn0X1y8qWY4L6jupdvIYtGjXctpKGwYZyUlMuuX+gk=;
        b=QoR6Yr/J4bbjg/p1mvjp7aha9lOWnKDi9ZOSF9vhAgamPAx0hMo1FaX41vIJkJE+j2Lh2K
        ISZwzpZ2cts5uzgcrjzSZoPLxVlaazc7O+KU167PfBAEoT4Re2QMxxZODBx+13nljlG4+s
        XZwH0VLWZ0q7q7gg9ZpkjHENCtlY+f4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-3ZmF-bNKPJ6yMjV4_KvasA-1; Tue, 10 Dec 2019 16:09:59 -0500
Received: by mail-lf1-f71.google.com with SMTP id a11so4336779lff.12
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 13:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6Dn0X1y8qWY4L6jupdvIYtGjXctpKGwYZyUlMuuX+gk=;
        b=k54/Ww4n5Yw4sgC11FqsE/hPQwiGjvhdt9S+Pa+bqAN+ck2qM+Y5YRt3WxV1AbSRrX
         fZQny42et39EV2b1FIBsZXUAIhO2WSIFuf7aC9gpTiZU4f/JnlvaNXgCousr4sVy1it9
         xKOkRKqZKCZwSsZY6zt+NKEdNyfSHM/0W55jNZiPtGb/7JPA9xeLbn5HkusMuZPut4HH
         FkY9cKoVSPo8rpT6lc2E59y5d9hwQHuAQtUdsPFIgn9iXWKCeSzWC09pv13dLAj6YTBm
         QJVhJEc2o9Ow8vBrDzD416g2buvtuQY1V/+3PCbiA361bQOYGjvqsGsN0ZkrpSnILUEB
         KEKQ==
X-Gm-Message-State: APjAAAVKQ/+udGV8fqrf/+ytxUfJHWFRtpzxamlG2SBFLS2kUG2tOtZ4
        Wn4v8A+IxQk88k+CFZIooNewOvFywBsDf6DPpVO37UDJi8MwcWx///ph8D0vpAe/05K+GZJ9djN
        Up/iejki0Pezy
X-Received: by 2002:a2e:a408:: with SMTP id p8mr3996812ljn.145.1576012197596;
        Tue, 10 Dec 2019 13:09:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxvMCPn/czOu2GRrVuQOc/gN/GQSbTQE0kUF3zFgRZi0rgmbc3zka5Cy/ldLQX+t9WQBZ45iA==
X-Received: by 2002:a2e:a408:: with SMTP id p8mr3996800ljn.145.1576012197452;
        Tue, 10 Dec 2019 13:09:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f8sm2469467ljj.1.2019.12.10.13.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 13:09:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E6C981803C1; Tue, 10 Dec 2019 22:09:55 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin Lau <kafai@fb.com>
Subject: Re: [PATCH bpf v2] bpftool: Don't crash on missing jited insns or ksyms
In-Reply-To: <20191210125457.13f7821a@cakuba.netronome.com>
References: <20191210181412.151226-1-toke@redhat.com> <20191210125457.13f7821a@cakuba.netronome.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 10 Dec 2019 22:09:55 +0100
Message-ID: <87eexbhopo.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 3ZmF-bNKPJ6yMjV4_KvasA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <jakub.kicinski@netronome.com> writes:

> On Tue, 10 Dec 2019 19:14:12 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>> When the kptr_restrict sysctl is set, the kernel can fail to return
>> jited_ksyms or jited_prog_insns, but still have positive values in
>> nr_jited_ksyms and jited_prog_len. This causes bpftool to crash when try=
ing
>> to dump the program because it only checks the len fields not the actual
>> pointers to the instructions and ksyms.
>>=20
>> Fix this by adding the missing checks.
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
>
> and
>
> Fixes: f84192ee00b7 ("tools: bpftool: resolve calls without using imm fie=
ld")
>
> ?

Yeah, guess so? Although I must admit it's not quite clear to me whether
bpftool gets stable backports, or if it follows the "only moving
forward" credo of libbpf?

Anyhow, I don't suppose it'll hurt to have the Fixes: tag(s) in there;
does Patchwork pick these up (or can you guys do that when you apply
this?), or should I resend?

-Toke

