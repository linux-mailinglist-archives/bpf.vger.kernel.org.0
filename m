Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3935317C
	for <lists+bpf@lfdr.de>; Sat,  3 Apr 2021 01:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhDBX0C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 19:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBX0B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 19:26:01 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D9C0613E6
        for <bpf@vger.kernel.org>; Fri,  2 Apr 2021 16:25:59 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4FBx4h3fWbzQjmr;
        Sat,  3 Apr 2021 01:25:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=felix-maurer.de;
        s=MBO0001; t=1617405954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7hIzgOeG2w/35yTyTV7qCADPbEi2r0ryzGdlCSPcEDs=;
        b=zgbraTjfFOFntlpLoOW2fW5quV82OOKrY5bioL1mV7U7eLSrwzNJ3crWBHf645FjbCPwgi
        PRJpRKPBhTFwJyjtzPJoZ581L/q2EXLPDcymXl6PAzrFVSqmX9qpREZmmdvSR8C7q28kVx
        2hlTmT5rmkvFUDmzuSV1Z7x1qqxqBkuholjIBqDkw8sIt4C9CdzUJmrI6SDDw8azDWv4nT
        W+xPeRrSp5sarIw0Ezg34FvQnmhaDq7abJowZ9F4MTHbwQxdSwhUpfj0EehVHcNB/1OeuD
        gpaz1fpKMo+8YnbC3mo+PgggVFsHBSF0xoWzd/bMM4VB4s3LxrSKxzYlmeB9kg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id gJedLIdW_LOj; Sat,  3 Apr 2021 01:25:52 +0200 (CEST)
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
References: <45cb2bbc-202b-00d6-7422-738a025be068@felix-maurer.de>
 <fac7938c-a591-1ecd-9943-8b4726b69e01@fb.com>
From:   Felix Maurer <felix@felix-maurer.de>
Subject: Re: libbpf: failed to find BTF ID for ksym
Message-ID: <6db72b92-c724-68f7-7445-1ef7110a7acd@felix-maurer.de>
Date:   Sat, 3 Apr 2021 01:25:45 +0200
MIME-Version: 1.0
In-Reply-To: <fac7938c-a591-1ecd-9943-8b4726b69e01@fb.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QbdReqAfYGyx7M9hjaDLBtiF33Tt6shMB"
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.90 / 15.00 / 15.00
X-Rspamd-Queue-Id: 7C64C243
X-Rspamd-UID: 116142
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QbdReqAfYGyx7M9hjaDLBtiF33Tt6shMB
Content-Type: multipart/mixed; boundary="LQQJTO4XSEbTAeDegHQZu01V5w0PhdBXn";
 protected-headers="v1"
From: Felix Maurer <felix@felix-maurer.de>
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Message-ID: <6db72b92-c724-68f7-7445-1ef7110a7acd@felix-maurer.de>
Subject: Re: libbpf: failed to find BTF ID for ksym
References: <45cb2bbc-202b-00d6-7422-738a025be068@felix-maurer.de>
 <fac7938c-a591-1ecd-9943-8b4726b69e01@fb.com>
In-Reply-To: <fac7938c-a591-1ecd-9943-8b4726b69e01@fb.com>

--LQQJTO4XSEbTAeDegHQZu01V5w0PhdBXn
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.04.21 00:59, Yonghong Song wrote:
>=20
>=20
> On 4/2/21 3:44 PM, Felix Maurer wrote:
>> Hello,
>>
>> I am working on a tracing tool for which I need know the address of=20
>> some kernel data structures. The tool should be CO-RE and I am using=20
>> libbpf (through the libbpf-rs Rust bindings, but this is not the issue=
=20
>> I assume). However, I am having trouble to use ksyms with libbpf.
>>
>> To get the address of the data structure (in my case=20
>> skbuff_fclone_cache), I use an extern ksym declaration in my BPF code =

>> like this:
>>
>> extern struct kmem_cache *skbuff_fclone_cache __ksym;
>>
>> This compiles just fine, opening the compiled bytecode with libbpf=20
>> also works. From the debug log[1], it can be seen that the extern is=20
>> identified. However, loading the object fails with the following error=
:
>>
>> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
>> libbpf: extern (ksym) 'skbuff_fclone_cache': failed to find BTF ID in =

>> kernel BTF(s).
>> libbpf: failed to load object 'skbuffTime_bpf'
>> libbpf: failed to load BPF skeleton 'skbuffTime_bpf': -22
>=20
> net/core/skbuff.c:static struct kmem_cache *skbuff_fclone_cache=20
> __ro_after_init;
>=20
> skbuff_fclone_cache is a static variable. I think pahole does not
> emit static variables into btf, only global variables.

Is that the expected behavior that static variables do not show up in=20
BTF? If so, I guess the way to fix it would be that libbpf looks up=20
static vars in kallsyms instead of BTF.

>>
>> I found, that libbpf has a check if it needs to load the BTF=20
>> information or /proc/kallsyms. In my case, it loads the BTF=20
>> information and cannot find the ksym in there. Searching in the BTF=20
>> from the running kernel (bpftool btf dump file /sys/kernel/btf/vmlinux=
=20
>> format raw | grep "skbuff_fclone_cache") indeed gives no results.=20
>> However, it can be found in kallsyms (cat /proc/kallsyms | grep=20
>> "skbuff_fclone_cache" gives one result). Therefore, a resolution of=20
>> the ksym with kallsyms will probably work but is not even attempted.
>>
>> Now, I am not really sure where the root cause of the issue can be=20
>> found. Should the ksym be present in the BTF information (i.e., the=20
>> issue comes from building the kernel) or is the BPF object file broken=
=20
>> (i.e., an issue with clang) or is the identification of the ksym wrong=
=20
>> (i.e., the issue is in the libbpf loading code). Or something=20
>> completely different? Does anyone have a hint on what goes wrong here?=

>>
>> Some version information:
>> I am running Ubuntu 20.04, the kernel version is 5.8.0-45-generic=20
>> (from HWE). The kernel has been build on the system to enable BTF;=20
>> otherwise, the configuration is identical to the Ubuntu upstream. It=20
>> has been compiled with gcc 9.3.0 and pahole v1.17. I am compiling the =

>> BPF code with clang 10.0.0 and tested with different libbpf versions=20
>> from the GitHub mirror (0.2, 0.3, and 99bc17633).
>>
>> Thank you already for taking a look at my issue!
>>
>> Best regards,
>> Felix Maurer
>>
>>
>>
>> [1]: Full libbpf opening debug log:
>> libbpf: loading object 'skbuffTime_bpf' from buffer
>> libbpf: elf: section(3) fexit/kmem_cache_alloc, size 176, link 0,=20
>> flags 6, type=3D1
>> libbpf: sec 'fexit/kmem_cache_alloc': found program 'kmem_cache_alloc'=
=20
>> at insn offset 0 (0 bytes), code size 22 insns (176 bytes)
>> libbpf: elf: section(4) .relfexit/kmem_cache_alloc, size 32, link 26, =

>> flags 0, type=3D9
>> libbpf: elf: section(5) fexit/kmem_cache_alloc_node, size 176, link 0,=
=20
>> flags 6, type=3D1
>> libbpf: sec 'fexit/kmem_cache_alloc_node': found program=20
>> 'kmem_cache_alloc_node' at insn offset 0 (0 bytes), code size 22 insns=
=20
>> (176 bytes)
>> libbpf: elf: section(6) .relfexit/kmem_cache_alloc_node, size 32, link=
=20
>> 26, flags 0, type=3D9
>> libbpf: elf: section(7) license, size 4, link 0, flags 3, type=3D1
>> libbpf: license of skbuffTime_bpf is GPL
>> libbpf: elf: section(8) .maps, size 24, link 0, flags 3, type=3D1
>> libbpf: elf: section(17) .BTF, size 4419, link 0, flags 0, type=3D1
>> libbpf: elf: section(19) .BTF.ext, size 440, link 0, flags 0, type=3D1=

>> libbpf: elf: section(26) .symtab, size 263040, link 1, flags 0, type=3D=
2
>> libbpf: looking for externs among 10960 symbols...
>> libbpf: collected 1 externs total
>> libbpf: extern (ksym) #0: symbol 10959, name skbuff_fclone_cache
>> libbpf: map 'events': at sec_idx 8, offset 0.
>> libbpf: map 'events': found type =3D 4.
>> libbpf: map 'events': found key_size =3D 4.
>> libbpf: map 'events': found value_size =3D 4.
>> libbpf: sec '.relfexit/kmem_cache_alloc': collecting relocation for=20
>> section(3) 'fexit/kmem_cache_alloc'
>> libbpf: sec '.relfexit/kmem_cache_alloc': relo #0: insn #2 against=20
>> 'skbuff_fclone_cache'
>> libbpf: prog 'kmem_cache_alloc': found extern #0 'skbuff_fclone_cache'=
=20
>> (sym 10959) for insn #2
>> libbpf: sec '.relfexit/kmem_cache_alloc': relo #1: insn #14 against=20
>> 'events'
>> libbpf: prog 'kmem_cache_alloc': found map 0 (events, sec 8, off 0)=20
>> for insn #14
>> libbpf: sec '.relfexit/kmem_cache_alloc_node': collecting relocation=20
>> for section(5) 'fexit/kmem_cache_alloc_node'
>> libbpf: sec '.relfexit/kmem_cache_alloc_node': relo #0: insn #2=20
>> against 'skbuff_fclone_cache'
>> libbpf: prog 'kmem_cache_alloc_node': found extern #0=20
>> 'skbuff_fclone_cache' (sym 10959) for insn #2
>> libbpf: sec '.relfexit/kmem_cache_alloc_node': relo #1: insn #14=20
>> against 'events'
>> libbpf: prog 'kmem_cache_alloc_node': found map 0 (events, sec 8, off =

>> 0) for insn #14


--LQQJTO4XSEbTAeDegHQZu01V5w0PhdBXn--

--QbdReqAfYGyx7M9hjaDLBtiF33Tt6shMB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEOvn7WnUe77k0LECvRGZ/5ZBuc3UFAmBnp/oFAwAAAAAACgkQRGZ/5ZBuc3Xy
WA/+M1ga8ASKi3tuHvVK25C+/7hxsYCzrCVycG40f+Acy+QA0Rbr3YxPWsp3Kg8/Rrzu+O2fo8NY
cRg80WLNq+BVTVV3mH84le0WYNIjhfDHU/P/14Dd+Ip4744gO5F+H/9+L8WKJQZBpbpVPjYXX9rU
8wfGwMGslYrYHrWp3R3pNVvbh1JY2UbfiTQTx/rM5HrulGtFcuKyQfnLe2q6OgqpzY71VKaFCglJ
wZMjngD6eqoKFoXyA727QjPV/LB53CwEfjy5m5lSRgFUN/ekEJvSurxNXRyPDRgGCLLdS7JwAfXk
W1JNGhjyPqbxG8PCx6uOHHQ+tAXlgAIS8BS4Fb9ugvmSb5XyRmGUK4OjEGnUxhz0/OGHLfypEYBW
JoWCcIdvjqUsZNKAXf2kjm4ayqfzWMITXqTa/qenA0qTAL6xzRkPgQTTIQM0IlQTG4agJ8z5FtGI
m6C3DJ1z5bz6RtRCY23qL7tVay8H3Y8wZQFmM2Z5/Qmcdkq2qj6VMxk6gbeS33yt+8qgobRloa31
vmOgAOamEW78eq/t2n9kX3vBaL141HBZ5GukFpYJxBcutYCYxvJ75rabS5pTlNxDb1ef/2nm7PUs
OF0xybSVKgWiNBi+XvsalnPu8XuHvwE7UvW9Aqc4IPp+yfjA8Mv9oX0AjlYFUAeRUN8aXf9MjluE
ckM=
=TW5y
-----END PGP SIGNATURE-----

--QbdReqAfYGyx7M9hjaDLBtiF33Tt6shMB--
