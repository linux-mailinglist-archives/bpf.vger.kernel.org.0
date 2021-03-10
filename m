Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26FB3335A3
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 07:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhCJGCg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 01:02:36 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57053 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbhCJGBF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Mar 2021 01:01:05 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AF4C215E1;
        Wed, 10 Mar 2021 01:00:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Mar 2021 01:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:references:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Gmoc5jKVzAgBqiZ4f
        WtHTwEusY8E0LLv6lYmG50fdZ8=; b=Jb2WWhfOpN1/p1749aTI+ZA88HTcahMmh
        WAyy6kPOyo/IwVeb7jX9LQOblDpiEw8iK4+YeQ2HuHX8XL5+z0E545rktL6tkM0X
        iUz71ertRuK9rx+VeVi7gh/Na3LHIt/1wR/gDbuaqcD9xDY0KeDf+lPVoXVwpLQl
        IhmBwXskr3ZtPBVULHOfUSXDZMKq9/6NI7UElku31W/DIG7eKJFwpCBbLyFgaQ5a
        oel0LPXqMrD1RBs0DV3MKwim6fI1f2s7R+ZqIrIa/NKtJuSp13JX+MRMqQeYpAcq
        uUCrX2L8WmAuIcyZptngGxoEk2LEXA0BATiXXPG6z/x0EShEaS11A==
X-ME-Sender: <xms:m2BIYElHL_6r8jGDowv-lJaecmnY5jmO0DaM35KenJZ8GVZYHlPw-Q>
    <xme:m2BIYD0MbwH-NTuJzeO_AamGJqUmQLmQiA2DJv3obKr3P0jI9GfGrdmVX3Vl2Bexd
    rKFPWxKkUyetRmGEFc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddujedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfgtggfuffhfvffkofesghdtmherhhdtjeenucfhrhhomheptfgrfhgrvghl
    ucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehusghunhhtuh
    drtghomheqnecuggftrfgrthhtvghrnhepkeektdeukedvieehvdefieekkeejhfeuhfef
    vdethffgheekiefhhfefteejtdffnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpuh
    gsuhhnthhurdgtohhmnecukfhppedujeejrddvvddtrddujedvrddvgeegnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrfhgrvghlughtih
    hnohgtohesuhgsuhhnthhurdgtohhm
X-ME-Proxy: <xmx:m2BIYCpc44YSKjCInR_eZLAo9PGsV8vq5uNiPPSRoAqdqBNLn8n9ng>
    <xmx:m2BIYAlmN1tNBKu9g72ZaCEb5gr4KF7Dl9787Sl03slREpNkz39SUQ>
    <xmx:m2BIYC1M0rbgYF8lp6XTnxQfoop3zQyNEDIXyUo6gL1TB20kH5f1Kw>
    <xmx:m2BIYH8U7CnOgY9iJE2hi1Ce-atMZ5hpx9PY7da99f-dQVOCNDy1ig>
Received: from [192.168.100.154] (unknown [177.220.172.244])
        by mail.messagingengine.com (Postfix) with ESMTPA id 08B3A240057;
        Wed, 10 Mar 2021 01:00:57 -0500 (EST)
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D7EE16AE-FCD9-4A99-870E-70162760A937";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Fwd: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
Date:   Wed, 10 Mar 2021 03:00:55 -0300
References: <67E3C788-2835-4793-8A9C-51C5D807C294@ubuntu.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vamsi Kodavanty <vamsi@araalinetworks.com>,
        bpf <bpf@vger.kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Message-Id: <A6A2EA65-A0EC-4E26-A1CA-E37A3E737F9F@ubuntu.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--Apple-Mail=_D7EE16AE-FCD9-4A99-870E-70162760A937
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 5 Mar 2021, at 03:32, Rafael David Tinoco =
<rafaeldtinoco@ubuntu.com> wrote:
>=20
>=20
>>> Specially the attach_kprobe_legacy() function:
>>>=20
>>> https://github.com/rafaeldtinoco/portablebpf/blob/master/mine.c#L31
>>>=20
>>> I wanted to reply here in case others also face this.
>>=20
>> Great, glad it worked out. It would be great if you could contribute
>> legacy kprobe support for libbpf as a proper patch, since it probably
>> would be useful for a bunch of other people stuck with old kernels.
>=20

(sending this again in proper format for the list)

I=E2=80=99m sorry to come back to this but I=E2=80=99d like to clarify =
something, if you allow me.

If I recompile old kernels (4.x.y) with the =E2=80=9Cscripts/link-vmlinux.=
sh" patch (setting $btf_vmlinux_bin_o and gen_btf()) I=E2=80=99m able to =
use "pahole -J" to generate the .BTF ELF section from a vmlinux file =
(out of the debugging package, for example) using its DWARF data.

Using objcopy, I=E2=80=99m also able to extract only the .BTF ELF =
section from it and use the generated file (smaller) as a base BTF file =
for libbpf (since old kernels don=E2=80=99t have /sys/kernel/btf/vmlinux =
interface).

So, in my case, with this, I can get an ~30MB ELF file (from a an almost =
600MB vmlinux) with BTF data that can feed libbpf to do needed =
relocations for my BPF object. Execution works perfectly and I can have =
the same libbpf based code to run in a 4.15 and a 5.8 kernel, smooth.

What is not entirely clear to me yet is =E2=80=A6 why can=E2=80=99t I =
use a =E2=80=9Cvmlinux=E2=80=9D file from a previous compiled kernel =
(that has not been compiled with a changed link-vmlinux.sh file) and do =
the same: generate the BTF section from its DWARF data with pahole and =
use generated file (or the BTF section extract only) as input to libbpf.

I mean, I can do, but it does not work=E2=80=A6 Assumption: it only =
works for the ones I build with patched link-vmlinux.sh (not the ones =
already built and provided as packages). The code execution output =
(debug=3D1 on libbpf) is at : https://pastebin.ubuntu.com/p/bx6tygY8p2/

The difference for a new 4.x.y kernel and the existing ones (older =
packaged kernels) is the vmlinux_link() function linking the BTF object =
file in each of the 3 tmp_kallsyms steps.

Is there a way I can get the already existing kernels to work with only =
pahole DWARF to BTF conversion data ?

Thank you!

-rafaeldtinoco
>=20


--Apple-Mail=_D7EE16AE-FCD9-4A99-870E-70162760A937
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE9/EO4QjRa7yS94ISqT4OCtg8DQ8FAmBIYJcACgkQqT4OCtg8
DQ9T8RAAwhSK4cIxbhJDXwNMJUslVMYXxPOe/jjS65fWT8P+Ag6l1VyC8ScbckwA
7SaQpgIpUxmes6KvgcRJCIJPa9dt2VY84cr4b6JWGg0wmfPa04Y0aixFEEH1CQp7
XwgssPXTIMGUxuudq4XmBqjzVPpA+3L/do2NEFxh9FduQMGoCsJw8uo/THekNfYQ
QhhsyyejWl9ygu/6zxczVcRcOVIbg1ueTiWFq0nQaCrnmcaIBgJD90RX53RmZkSi
MG/PgOjCGEdtQS8v5/lOvJO0SP4klpG/cUzuPvZEZ7uljJhecC1wZCkzshc1fX1s
rfxmzBrHA6tWXhq45MP4x/gjvoVPSYDrTb2mqzJtaIrQJxknMUzMgebYOXpVY8jx
Cyj3HeZKIbebJE6MjupEVZiV6ycG8xYjO304MAPhlFfTaUWDbq+o6xlR03dMgv2B
TbS67NYF6YHr8KfbO6uWTax5H9ihpQ7ULEFq45lMSr5IjMDvSGr6ozNiC9VCgv51
yjECuPOXri0G4r/w7o0zxBfWnXFgPe+sApnCgx/rX1DKewZaAgylNhp8JTTsPOGF
n3csM82f06NFn6MUR/Y69GHg4bbwVK8cvPuoRPZQs5SVNfj5kVVtSfAtZ/l2NzEX
gTjjJsD8WTzuhv5AthS1Tce6nMAW8p9zKjKpP/zgfmPl0KuQOTk=
=M8Fz
-----END PGP SIGNATURE-----

--Apple-Mail=_D7EE16AE-FCD9-4A99-870E-70162760A937--
