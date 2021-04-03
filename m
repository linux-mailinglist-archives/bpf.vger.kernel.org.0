Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A766D353591
	for <lists+bpf@lfdr.de>; Sat,  3 Apr 2021 23:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbhDCVS4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Apr 2021 17:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbhDCVS4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Apr 2021 17:18:56 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00077C0613E6
        for <bpf@vger.kernel.org>; Sat,  3 Apr 2021 14:18:52 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4FCVCY5XnSzQjwQ;
        Sat,  3 Apr 2021 23:18:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=felix-maurer.de;
        s=MBO0001; t=1617484727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R2xg7ye+WKXFRfRrF1Pro82q8/GInpKE9nmb12xpCbs=;
        b=N2zKQPiesOLCgrvlGBFLu6SSihJGamsguLwCdbkU4CKeYLrXFimEg2aZxp8xbAahNJ1PBQ
        REb8WMkHNlFDWGDJRv05Yzk/WcpI0EWTyZQ7v9MLAqq/VuxBjrEVWtIqar3XGcqfD/IOi9
        PfFsqR6nSHCyP2VvvO1y9E9K8o4OAYqS5d4BznPpFbhd2nCjJVTBJzM9MIVg+2cePQpfMe
        bLa8O5XdBk098rsFAv9rspZu9++a1ZSSCpF3ziie78pm9r4w3t7zedXbsiW1e3wFTo1NXA
        qezfnC3L1mr/1Hu0u8P9AlGHI+Ewsstat8ISvyqHijwNwar6RkVegD9I4TFQcA==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id aVRKI6QLWFjk; Sat,  3 Apr 2021 23:18:43 +0200 (CEST)
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <45cb2bbc-202b-00d6-7422-738a025be068@felix-maurer.de>
 <CAEf4Bza-w+nOMOJU4+rL+ZiF++vbDpXBvPWz2kgei3fcNzRSdA@mail.gmail.com>
From:   Felix Maurer <felix@felix-maurer.de>
Subject: Re: libbpf: failed to find BTF ID for ksym
Message-ID: <5030c92e-14dc-0870-ee95-14b14cda7f54@felix-maurer.de>
Date:   Sat, 3 Apr 2021 23:18:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAEf4Bza-w+nOMOJU4+rL+ZiF++vbDpXBvPWz2kgei3fcNzRSdA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4d8ez5bCHYdQ6QUaDJFaSbfs18vzpLj7A"
X-MBO-SPAM-Probability: *
X-Rspamd-Score: 0.83 / 15.00 / 15.00
X-Rspamd-Queue-Id: C8B5B17E2
X-Rspamd-UID: 96d8bf
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4d8ez5bCHYdQ6QUaDJFaSbfs18vzpLj7A
Content-Type: multipart/mixed; boundary="Hn5FnTudx0TqrldbKiOSpTPvVchZX6o1I";
 protected-headers="v1"
From: Felix Maurer <felix@felix-maurer.de>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Message-ID: <5030c92e-14dc-0870-ee95-14b14cda7f54@felix-maurer.de>
Subject: Re: libbpf: failed to find BTF ID for ksym
References: <45cb2bbc-202b-00d6-7422-738a025be068@felix-maurer.de>
 <CAEf4Bza-w+nOMOJU4+rL+ZiF++vbDpXBvPWz2kgei3fcNzRSdA@mail.gmail.com>
In-Reply-To: <CAEf4Bza-w+nOMOJU4+rL+ZiF++vbDpXBvPWz2kgei3fcNzRSdA@mail.gmail.com>

--Hn5FnTudx0TqrldbKiOSpTPvVchZX6o1I
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.04.21 17:50, Andrii Nakryiko wrote:
> On Fri, Apr 2, 2021 at 3:47 PM Felix Maurer <felix@felix-maurer.de> wro=
te:
>>
>> Hello,
>>
>> I am working on a tracing tool for which I need know the address of so=
me
>> kernel data structures. The tool should be CO-RE and I am using libbpf=

>> (through the libbpf-rs Rust bindings, but this is not the issue I
>> assume). However, I am having trouble to use ksyms with libbpf.
>>
>> To get the address of the data structure (in my case
>> skbuff_fclone_cache), I use an extern ksym declaration in my BPF code
>> like this:
>>
>> extern struct kmem_cache *skbuff_fclone_cache __ksym;
>>
>=20
> Due to skbuff_fclone_cache being a static variable, typed __ksym
> (where you specify expected type and thus BPF verifier will expect BTF
> ID and will allow reading it directly from your BPF program) won't
> work. If you need to just have an address of the symbol, you can use
> untyped __ksym, which will use /proc/kallsyms:
>=20
> extern const void skbuff_fclone_cache __ksym;
>=20
> If you need to further read any data (e.g., follow the pointer and
> read struct kmem_cache's fields), you can use BPF_CORE_READ() macro.

Thank you very much for the explanation. The declaration like this works =

fine and solved my issues.

This also means that the whole chain works as expected, no bugs here :)

>>
>> Now, I am not really sure where the root cause of the issue can be
>> found. Should the ksym be present in the BTF information (i.e., the
>> issue comes from building the kernel) or is the BPF object file broken=

>> (i.e., an issue with clang) or is the identification of the ksym wrong=

>> (i.e., the issue is in the libbpf loading code). Or something complete=
ly
>> different? Does anyone have a hint on what goes wrong here?
>>
>=20
> As Yonghong already replied, pahole doesn't generate BTF type
> information for static variables right now, so it's expected.
>=20
> [...]
>=20


--Hn5FnTudx0TqrldbKiOSpTPvVchZX6o1I--

--4d8ez5bCHYdQ6QUaDJFaSbfs18vzpLj7A
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEOvn7WnUe77k0LECvRGZ/5ZBuc3UFAmBo268FAwAAAAAACgkQRGZ/5ZBuc3VK
kw//b1zZ3ZAKBG+C5h4gmkcIvhwvcrS9J+eFaaU9G0LQIJab/SvWJEwwRAIYN66Qh3GiaV+8fbGE
k0OhhN4YD7+lma7EXZQlywWWt2YBv123XA8/ijtasMo/bIEY2eDqqpus29R9lWLcH6zwPL5ti0sl
Pri7JUTxv+R7+QG0UD8BMT2jCdN84AJ6dpe4GrPMADdr7sLccgf0USrCazg93v9lVA8g+CzBod3U
IC2ZqJO2dlEctfR+f0yjmCqsnjt44rd3WzDya2HJ7GZMYYlgwDGC5nL3XRgc1myuBs//2A0iyVlP
B+Ln7i+wIenaghPPnRpgTPMVE8AvTgnMd16/gj//2gykgQXmO4lBXXRUqunFB+i23fZFcYPn/vUW
vCb/bimbxjeIle4jfcDYOYwRFzbvepROWHE6nhrla31zfEgIiuYgtl5bMDwGs297uA+RQyk56EGy
bkK2Eq0+PHjDgtEhe52dVg86RJ7wb9/X4gS4tcjrLjX1alFj2gPbZADqzfo+Bb9JlCa7YemcHpNr
lgZ4+mbu+ASgX8BwQQdJm51RGNQ6gzEp7cjnFQExxXdW2OujCdCSBOTbKrvgHWeVFkrWQgREONaP
iaE6rmJTIelWRTPLP9QCO0xuai2xcgNwZImR39RMrNOZq3fbEXAnhyu+YVM72qX1vi/ahC8L5+Ad
jpo=
=gGj9
-----END PGP SIGNATURE-----

--4d8ez5bCHYdQ6QUaDJFaSbfs18vzpLj7A--
