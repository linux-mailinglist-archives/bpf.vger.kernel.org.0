Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3067F120232
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2019 11:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfLPKUF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Dec 2019 05:20:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47352 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727202AbfLPKUF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Dec 2019 05:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576491603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pl5GAP1jRdC0CwpXN80CHmPpQecKuMfnUQwsIaRGCLg=;
        b=a3G2pgRV9VOEGzJTpKcZNTmEqOaKD54sscxsuXprpThH5wzGSiq6Ui78XNILz4Cs/1ny7F
        gOf0WTfjntSe3BONYA+3tUBVPIXcR+W/IUGW15Y0fFpZbK7by5RVeOQjkK9ZnPZgpybe5X
        NA2DOQaazdtbjvGdDeUcWV53sILYWXI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-SiaEg76iMrOfU9VTK3eqoA-1; Mon, 16 Dec 2019 05:20:02 -0500
X-MC-Unique: SiaEg76iMrOfU9VTK3eqoA-1
Received: by mail-lj1-f200.google.com with SMTP id d14so1971374ljg.17
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2019 02:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Pl5GAP1jRdC0CwpXN80CHmPpQecKuMfnUQwsIaRGCLg=;
        b=aU/+V+6AcKZw0yKk8RPZjCwgcAtLBDdX2v6m3AxL4fUhnh77hmDJFIvaEEx59mheWN
         cc8P7yM+HotD5tRnaIRIuOd3l4sTAApoV1jb39BnrsU+in7lO1s+fGfGyXhymdHWfbPd
         ZVW4BRS3Rkx95O3O6ihR3xRyUiMpdCrc5G45PNsiWJqupwu0GOL/Kqg3LhUw9o/wt+JE
         vOP/AqvZvFVmp9ROPDM6dTeMZ4KJ6V5zePdC70Y8MvFBEbNzPZ5dwIW/zeIB1pZxoSa+
         yqapZf9MgfjWwdP6xYeCmpTS/8STN8cUzBhuoaBQV1biOjNHdOke4+frH9E7o6B3HPrZ
         CZoQ==
X-Gm-Message-State: APjAAAXMSOwXnLmquJH7ecQX+LgEjlm7uStAXD5AtANkTjIP6MbN2+1C
        fXRn61YTnUJCC/IItU8xsB8WEwv68uwnRqz38JMR9oVqIf8asGhSzNwK3pwhDmB9T6shZBmWEmY
        ZhwaFJ35ZqV9T
X-Received: by 2002:a2e:9b55:: with SMTP id o21mr19034867ljj.147.1576491601188;
        Mon, 16 Dec 2019 02:20:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJx0qXq+MZ+uifWsTqgT8cEn7YRedwq70nttDtYJ0IrjCI91lWWU020Lk/7Q1NnPxsz7LkBg==
X-Received: by 2002:a2e:9b55:: with SMTP id o21mr19034857ljj.147.1576491601054;
        Mon, 16 Dec 2019 02:20:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 192sm8640914lfh.28.2019.12.16.02.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 02:20:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8681B1819EB; Mon, 16 Dec 2019 11:19:59 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Prashant Bhole <prashantbhole.linux@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Prashant Bhole <prashantbhole.linux@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: fix build by renaming variables
In-Reply-To: <20191216082738.28421-1-prashantbhole.linux@gmail.com>
References: <20191216082738.28421-1-prashantbhole.linux@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 16 Dec 2019 11:19:59 +0100
Message-ID: <875zigbmi8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prashant Bhole <prashantbhole.linux@gmail.com> writes:

> In btf__align_of() variable name 't' is shadowed by inner block
> declaration of another variable with same name. Patch renames
> variables in order to fix it.
>
>   CC       sharedobjs/btf.o
> btf.c: In function =E2=80=98btf__align_of=E2=80=99:
> btf.c:303:21: error: declaration of =E2=80=98t=E2=80=99 shadows a previou=
s local [-Werror=3Dshadow]
>   303 |   int i, align =3D 1, t;
>       |                     ^
> btf.c:283:25: note: shadowed declaration is here
>   283 |  const struct btf_type *t =3D btf__type_by_id(btf, id);
>       |
>
> Fixes: 3d208f4ca111 ("libbpf: Expose btf__align_of() API")
> Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>

Seems there are quite a few build errors in bpf today; this at least
fixes libbpf. Thank you!

Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

