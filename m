Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3C5E725C
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2019 14:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfJ1NGl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Oct 2019 09:06:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37971 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730837AbfJ1NGl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Oct 2019 09:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572268000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oGrbVCBkV20SbSjbFrHblua1QCyKVnk3uyHwY5NqyHU=;
        b=OVNwJjTGUkPvQ8hugCmG3D6w/Yo7+aBEWklf6qKD6Hxx801hao3pk4fU9Az3QwqmmJiQBE
        Hi0TP1/NxzlgQhknFylRfWmSlFrmm+L0CjIZsJDGw2KYHWiAJBhsOcznI6nGKkNt2FGyyV
        8v71KeYBa6oLfcK5QynDViNwMybB8IA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-PfJS1Z2XPKe_I-NAOzpRgw-1; Mon, 28 Oct 2019 09:06:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A61A1005509;
        Mon, 28 Oct 2019 13:06:34 +0000 (UTC)
Received: from carbon (ovpn-200-19.brq.redhat.com [10.40.200.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C905B1C95A;
        Mon, 28 Oct 2019 13:06:26 +0000 (UTC)
Date:   Mon, 28 Oct 2019 14:06:24 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, brouer@redhat.com
Subject: Re: [PATCH bpf-next v3 4/4] selftests: Add tests for automatic map
 pinning
Message-ID: <20191028140624.584bcc1e@carbon>
In-Reply-To: <157220959980.48922.12100884213362040360.stgit@toke.dk>
References: <157220959547.48922.6623938299823744715.stgit@toke.dk>
        <157220959980.48922.12100884213362040360.stgit@toke.dk>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: PfJS1Z2XPKe_I-NAOzpRgw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 27 Oct 2019 21:53:19 +0100
Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:

> diff --git a/tools/testing/selftests/bpf/progs/test_pinning.c b/tools/tes=
ting/selftests/bpf/progs/test_pinning.c
> new file mode 100644
> index 000000000000..ff2d7447777e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_pinning.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include "bpf_helpers.h"
> +
> +int _version SEC("version") =3D 1;
> +
> +struct {
> +=09__uint(type, BPF_MAP_TYPE_ARRAY);
> +=09__uint(max_entries, 1);
> +=09__type(key, __u32);
> +=09__type(value, __u64);
> +=09__uint(pinning, LIBBPF_PIN_BY_NAME);
> +} pinmap SEC(".maps");

So, this is the new BTF-defined maps syntax.

Please remind me, what version of LLVM do we need to compile this?

Or was there a dependency on pahole?


> +struct {
> +=09__uint(type, BPF_MAP_TYPE_ARRAY);
> +=09__uint(max_entries, 1);
> +=09__type(key, __u32);
> +=09__type(value, __u64);
> +} nopinmap SEC(".maps");
> +
> +SEC("xdp_prog")
> +int _xdp_prog(struct xdp_md *xdp)
> +{
> +=09return XDP_PASS;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
>=20



--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

