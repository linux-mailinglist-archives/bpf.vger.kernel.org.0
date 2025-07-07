Return-Path: <bpf+bounces-62550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451E1AFBB75
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 21:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85194169D37
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C78E265CA7;
	Mon,  7 Jul 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7w0Ba0+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5D26057A
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915230; cv=none; b=qz6aY4PFDjpgz93j4PUAKjRYiro+Jy2yzop5vLnGzvyqAw2BUZcJRNhBfyzoLIBi6zoQBVtI4RI9z326xFSrgqplIE/Q6wTg688LbRM5+HxpabIERz8Zpkz5IJ2npB3YUPB9u5kT32aZgcxN+GcW1lJmRCRj1lbxsu8uNgUqd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915230; c=relaxed/simple;
	bh=433eaG3DvsezFmYNbOITxaKOcqFJF/+HXhsec+3QXEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A06eIcUsk2TEK9fnH3cMfWwdMVptdsQM+VbzgkMirBedeJ13e84qnuTMt3AADXHSHqw/jRA/JmpjX2Gk/SiG5DMq3lM9p393OMUBxfSU+buDektOV0a0gUJNAGXdQS1aJs1J0tHQW6o7wybO9Olg0oWXOFbzdQCJTNbJC3P8hbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7w0Ba0+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748d982e97cso3215351b3a.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751915228; x=1752520028; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eCLEv1Ykf32zDbDVXxMYtwSkcFGJiUdUT39PRX97jXI=;
        b=D7w0Ba0+UPRp1apNMnTg1cwZVhhhve92Kmxd+FFp2pzqq5DuSMZ0++un24fJWpqEkf
         T/pSTytQpTT9TCpEf+n9iU0FQRl3S29BeKxqNM5PRSWJ7Vg1nBnB+tPoY5mCuSumnRLO
         TGCAWV9a34nrHJkdAqzzibgNyQmR6X8dQOrQPST82ApeoFmtUVfYYHT5gQNkXuZlJnJh
         P/BlMdWmVyxSg8Ti4Jx0Bxy/9KyZeBXm9Wxl39GiIvTRj36z6alXabnG/eSDgKa7zAV4
         hmcWRw3cXzRzdo7aXbi6yoHne4Rjs2e29+wlbdPhloHRphoFvDcG/pjg5l+RoMLE3+BQ
         JA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751915228; x=1752520028;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCLEv1Ykf32zDbDVXxMYtwSkcFGJiUdUT39PRX97jXI=;
        b=IObV0QdmkAaEuDEbzgOC2MaYkokWt4vGcmuR8avhCfO2amNHNpXVfL4UDurPDQZ2TJ
         wTXljwZ7ZlZy0EHI/fO27LaR39WoCZPDR49Yd3dcTDFi6pWOR1430Z4ZE4MyBu3iN3BT
         vFhSd4q+c5HLjB1otefMFWm+k1G+hhFbyLptXf4MY5Cn1zBhWLiDfqQhMAPoHjs51pSI
         UvJT2MZw8PdMBEV5gHVOpnvn6Maj4rdiWqH8XFHgXn44NMcWunMh3fvHI1JaD0oreWz8
         Hy1RJxZYEmRn4MWm5eVp7rkCpSwZI+EaDpAt3TRhSLPjQOJYVZ+EJRha5RaXHkwhKBcX
         O1og==
X-Gm-Message-State: AOJu0Yw3BxSHdKQ7cJsDM0v67SZ4trMmx67AFQhBE1jP+6IhS7xeCdUD
	5M88izrCNuB10D27YoLwPCiDb/4Pvt8fI2cVZcB/k6lllMQYZE2EVM0y
X-Gm-Gg: ASbGncsDkeRrpk1ABZmwZ+Zp5sl9QIhagYRboJ5oB6/zdoxfViJOuIYSvYeEcurMhxT
	YtSTho3wwWW0AR+lMJxw+HuhJQ52nPvqAWRkrB6nyy0AKI5p5le3PtO2ladX4CFz4lldeplCjLZ
	7DO2vNTwB6UaY+l043MEmFi6XF0Adxaqek//N670/Iw4ATkUs87bo5+FtyQT/52HSnNTa7DgUnB
	VBmq+jU5VDd/n0c6RMOSoHucyosXAjJJyeONPKWqeTQU97uBYWHawz+y3k3r1DSiW+lC+cF3mEE
	gPE4DLg6kiG7ycxyu3l/ZCj4FqHFQZPnnJsLcECmnMTyiYs4ME/8dvW1rjXa6/1Q7jw=
X-Google-Smtp-Source: AGHT+IEM5cUJlF0NT/Ygty+r+sstZzaw1p1+keWJT1Xs+DWnlSmZDEAhlTfcHnIgxekYcU9vWxTI4Q==
X-Received: by 2002:a05:6a00:180f:b0:748:2ff7:5e22 with SMTP id d2e1a72fcca58-74ce65c1199mr16124511b3a.10.1751915228318;
        Mon, 07 Jul 2025 12:07:08 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:6ad])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm9590809b3a.136.2025.07.07.12.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 12:07:07 -0700 (PDT)
Message-ID: <e8a7a143ad1ebb087ff06032068201023aa893f4.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>
Date: Mon, 07 Jul 2025 12:07:06 -0700
In-Reply-To: <454128db01c0a01f3459783cd5a0ea37af01c34e.camel@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
		 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
		 <1c17cd755a3e8865ad06baad86d42e42e289439a.camel@gmail.com>
		 <f8bc4e5469e73b99943ff7783fbe4a7758bbbe32.camel@gmail.com>
		 <aF5v8Yw5LUgVDgjB@mail.gmail.com>
	 <454128db01c0a01f3459783cd5a0ea37af01c34e.camel@gmail.com>
Content-Type: multipart/mixed; boundary="=-23b8JRhv/SmifpmIRp2G"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-23b8JRhv/SmifpmIRp2G
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-07-03 at 11:21 -0700, Eduard Zingerman wrote:

[...]

> > > >   .jumptables
> > > >     <subprog-rel-off-0>
> > > >     <subprog-rel-off-1> | <--- jump table #1 symbol:
> > > >     <subprog-rel-off-2> |        .size =3D 2   // number of entries=
 in the jump table
> > > >     ...                          .value =3D 1  // offset within .ju=
mptables
> > > >     <subprog-rel-off-N>                          ^
> > > >                                                  |
> > > >   .text                                          |
> > > >     ...                                          |
> > > >     <insn-N>     <------ relocation referencing -'
> > > >     ...                  jump table #1 symbol

[...]

I think I got it working in:
https://github.com/eddyz87/llvm-project/tree/separate-jumptables-section

Changes on top of Yonghong's work.
An example is in the attachment the gist is:

-------------------------------

$ clang --target=3Dbpf -c -o jump-table-test.o jump-table-test.c
There are 8 section headers, starting at offset 0xaa0:

Section Headers:
  [Nr] Name              Type            Address          Off    Size   ES =
Flg Lk Inf Al
  ...
  [ 4] .jumptables       PROGBITS        0000000000000000 000220 000260 00 =
     0   0  1
  ...

Symbol table '.symtab' contains 8 entries:
   Num:    Value          Size Type    Bind   Vis       Ndx Name
     ...
     3: 0000000000000000   256 NOTYPE  LOCAL  DEFAULT     4 .BPF.JT.0.0
     4: 0000000000000100   352 NOTYPE  LOCAL  DEFAULT     4 .BPF.JT.0.1
     ...

$ llvm-objdump --no-show-raw-insn -Sdr jump-table-test.o
jump-table-test.o:      file format elf64-bpf

Disassembly of section .text:

0000000000000000 <foo>:
       ...
       6:       r2 <<=3D 0x3
       7:       r1 =3D 0x0 ll
                0000000000000038:  R_BPF_64_64  .jumptables
       9:       r1 +=3D r2
      10:       r1 =3D *(u64 *)(r1 + 0x0)
      11:       gotox r1
      ...
      34:       r2 <<=3D 0x3
      35:       r1 =3D 0x100 ll
                0000000000000118:  R_BPF_64_64  .jumptables
      37:       r1 +=3D r2
      38:       r1 =3D *(u64 *)(r1 + 0x0)
      39:       gotox r1
      ...

-------------------------------

The changes only touch BPF backend. Can be simplified a bit if I move
MachineFunction::getJTISymbol to TargetLowering in the shared LLVM
parts.

--=-23b8JRhv/SmifpmIRp2G
Content-Disposition: attachment; filename="session.log"
Content-Transfer-Encoding: base64
Content-Type: text/x-log; name="session.log"; charset="UTF-8"

JCBjYXQganVtcC10YWJsZS10ZXN0LmMKc3RydWN0IHNpbXBsZV9jdHggeyBpbnQgeDsgfTsKCmlu
dCBiYXIoaW50IHYpOwoKaW50IGZvbyhzdHJ1Y3Qgc2ltcGxlX2N0eCAqY3R4KQp7CglpbnQgcmV0
X3VzZXI7CgogICAgICAgIHN3aXRjaCAoY3R4LT54KSB7CiAgICAgICAgY2FzZSAwOgogICAgICAg
ICAgICAgICAgcmV0X3VzZXIgPSAyOwogICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgY2Fz
ZSAxMToKICAgICAgICAgICAgICAgIHJldF91c2VyID0gMzsKICAgICAgICAgICAgICAgIGJyZWFr
OwogICAgICAgIGNhc2UgMjc6CiAgICAgICAgICAgICAgICByZXRfdXNlciA9IDQ7CiAgICAgICAg
ICAgICAgICBicmVhazsKICAgICAgICBjYXNlIDMxOgogICAgICAgICAgICAgICAgcmV0X3VzZXIg
PSA1OwogICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgZGVmYXVsdDoKICAgICAgICAgICAg
ICAgIHJldF91c2VyID0gMTk7CiAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICB9CgogICAg
ICAgIHN3aXRjaCAoYmFyKHJldF91c2VyKSkgewogICAgICAgIGNhc2UgMToKICAgICAgICAgICAg
ICAgIHJldF91c2VyID0gNTsKICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgIGNhc2UgMTI6
CiAgICAgICAgICAgICAgICByZXRfdXNlciA9IDc7CiAgICAgICAgICAgICAgICBicmVhazsKICAg
ICAgICBjYXNlIDI3OgogICAgICAgICAgICAgICAgcmV0X3VzZXIgPSAyMzsKICAgICAgICAgICAg
ICAgIGJyZWFrOwogICAgICAgIGNhc2UgMzI6CiAgICAgICAgICAgICAgICByZXRfdXNlciA9IDM3
OwogICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgY2FzZSA0NDoKICAgICAgICAgICAgICAg
IHJldF91c2VyID0gNzc7CiAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICBkZWZhdWx0Ogog
ICAgICAgICAgICAgICAgcmV0X3VzZXIgPSAxMTsKICAgICAgICAgICAgICAgIGJyZWFrOwogICAg
ICAgIH0KCiAgICAgICAgcmV0dXJuIHJldF91c2VyOwp9CgokIGNsYW5nIC0tdGFyZ2V0PWJwZiAt
YyAtbyBqdW1wLXRhYmxlLXRlc3QubyBqdW1wLXRhYmxlLXRlc3QuYwpUaGVyZSBhcmUgOCBzZWN0
aW9uIGhlYWRlcnMsIHN0YXJ0aW5nIGF0IG9mZnNldCAweGFhMDoKClNlY3Rpb24gSGVhZGVyczoK
ICBbTnJdIE5hbWUgICAgICAgICAgICAgIFR5cGUgICAgICAgICAgICBBZGRyZXNzICAgICAgICAg
IE9mZiAgICBTaXplICAgRVMgRmxnIExrIEluZiBBbAogIFsgMF0gICAgICAgICAgICAgICAgICAg
TlVMTCAgICAgICAgICAgIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwIDAwMDAwMCAwMCAgICAgIDAg
ICAwICAwCiAgWyAxXSAuc3RydGFiICAgICAgICAgICBTVFJUQUIgICAgICAgICAgMDAwMDAwMDAw
MDAwMDAwMCAwMDBhMzEgMDAwMDZiIDAwICAgICAgMCAgIDAgIDEKICBbIDJdIC50ZXh0ICAgICAg
ICAgICAgIFBST0dCSVRTICAgICAgICAwMDAwMDAwMDAwMDAwMDAwIDAwMDA0MCAwMDAxZTAgMDAg
IEFYICAwICAgMCAgOAogIFsgM10gLnJlbC50ZXh0ICAgICAgICAgUkVMICAgICAgICAgICAgIDAw
MDAwMDAwMDAwMDAwMDAgMDAwNTQwIDAwMDAzMCAxMCAgIEkgIDcgICAyICA4CiAgWyA0XSAuanVt
cHRhYmxlcyAgICAgICBQUk9HQklUUyAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAwMDAyMjAgMDAw
MjYwIDAwICAgICAgMCAgIDAgIDEKICBbIDVdIC5yZWwuanVtcHRhYmxlcyAgIFJFTCAgICAgICAg
ICAgICAwMDAwMDAwMDAwMDAwMDAwIDAwMDU3MCAwMDA0YzAgMTAgICBJICA3ICAgNCAgOAogIFsg
Nl0gLmxsdm1fYWRkcnNpZyAgICAgTExWTV9BRERSU0lHICAgIDAwMDAwMDAwMDAwMDAwMDAgMDAw
YTMwIDAwMDAwMSAwMCAgIEUgIDcgICAwICAxCiAgWyA3XSAuc3ltdGFiICAgICAgICAgICBTWU1U
QUIgICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAwMDA0ODAgMDAwMGMwIDE4ICAgICAgMSAgIDYg
IDgKS2V5IHRvIEZsYWdzOgogIFcgKHdyaXRlKSwgQSAoYWxsb2MpLCBYIChleGVjdXRlKSwgTSAo
bWVyZ2UpLCBTIChzdHJpbmdzKSwgSSAoaW5mbyksCiAgTCAobGluayBvcmRlciksIE8gKGV4dHJh
IE9TIHByb2Nlc3NpbmcgcmVxdWlyZWQpLCBHIChncm91cCksIFQgKFRMUyksCiAgQyAoY29tcHJl
c3NlZCksIHggKHVua25vd24pLCBvIChPUyBzcGVjaWZpYyksIEUgKGV4Y2x1ZGUpLAogIFIgKHJl
dGFpbiksIHAgKHByb2Nlc3NvciBzcGVjaWZpYykKClN5bWJvbCB0YWJsZSAnLnN5bXRhYicgY29u
dGFpbnMgOCBlbnRyaWVzOgogICBOdW06ICAgIFZhbHVlICAgICAgICAgIFNpemUgVHlwZSAgICBC
aW5kICAgVmlzICAgICAgIE5keCBOYW1lCiAgICAgMDogMDAwMDAwMDAwMDAwMDAwMCAgICAgMCBO
T1RZUEUgIExPQ0FMICBERUZBVUxUICAgVU5EIAogICAgIDE6IDAwMDAwMDAwMDAwMDAwMDAgICAg
IDAgRklMRSAgICBMT0NBTCAgREVGQVVMVCAgIEFCUyBqdW1wLXRhYmxlLXRlc3QuYwogICAgIDI6
IDAwMDAwMDAwMDAwMDAwMDAgICAgIDAgU0VDVElPTiBMT0NBTCAgREVGQVVMVCAgICAgMiAudGV4
dAogICAgIDM6IDAwMDAwMDAwMDAwMDAwMDAgICAyNTYgTk9UWVBFICBMT0NBTCAgREVGQVVMVCAg
ICAgNCAuQlBGLkpULjAuMAogICAgIDQ6IDAwMDAwMDAwMDAwMDAxMDAgICAzNTIgTk9UWVBFICBM
T0NBTCAgREVGQVVMVCAgICAgNCAuQlBGLkpULjAuMQogICAgIDU6IDAwMDAwMDAwMDAwMDAwMDAg
ICAgIDAgU0VDVElPTiBMT0NBTCAgREVGQVVMVCAgICAgNCAuanVtcHRhYmxlcwogICAgIDY6IDAw
MDAwMDAwMDAwMDAwMDAgICA0ODAgRlVOQyAgICBHTE9CQUwgREVGQVVMVCAgICAgMiBmb28KICAg
ICA3OiAwMDAwMDAwMDAwMDAwMDAwICAgICAwIE5PVFlQRSAgR0xPQkFMIERFRkFVTFQgICBVTkQg
YmFyCgokIGxsdm0tb2JqZHVtcCAtLW5vLXNob3ctcmF3LWluc24gLVNkciBqdW1wLXRhYmxlLXRl
c3QubwpqdW1wLXRhYmxlLXRlc3QubzoJZmlsZSBmb3JtYXQgZWxmNjQtYnBmCgpEaXNhc3NlbWJs
eSBvZiBzZWN0aW9uIC50ZXh0OgoKMDAwMDAwMDAwMDAwMDAwMCA8Zm9vPjoKICAgICAgIDA6CSoo
dTY0ICopKHIxMCAtIDB4OCkgPSByMQogICAgICAgMToJcjEgPSAqKHU2NCAqKShyMTAgLSAweDgp
CiAgICAgICAyOgl3MSA9ICoodTMyICopKHIxICsgMHgwKQogICAgICAgMzoJKih1NjQgKikocjEw
IC0gMHgxOCkgPSByMQogICAgICAgNDoJaWYgdzEgPiAweDFmIGdvdG8gKzB4MTMgPGZvbysweGMw
PgogICAgICAgNToJcjIgPSAqKHU2NCAqKShyMTAgLSAweDE4KQogICAgICAgNjoJcjIgPDw9IDB4
MwogICAgICAgNzoJcjEgPSAweDAgbGwKCQkwMDAwMDAwMDAwMDAwMDM4OiAgUl9CUEZfNjRfNjQJ
Lmp1bXB0YWJsZXMKICAgICAgIDk6CXIxICs9IHIyCiAgICAgIDEwOglyMSA9ICoodTY0ICopKHIx
ICsgMHgwKQogICAgICAxMToJZ290b3ggcjEKICAgICAgMTI6CXcxID0gMHgyCiAgICAgIDEzOgkq
KHUzMiAqKShyMTAgLSAweGMpID0gdzEKICAgICAgMTQ6CWdvdG8gKzB4YyA8Zm9vKzB4ZDg+CiAg
ICAgIDE1Ogl3MSA9IDB4MwogICAgICAxNjoJKih1MzIgKikocjEwIC0gMHhjKSA9IHcxCiAgICAg
IDE3Oglnb3RvICsweDkgPGZvbysweGQ4PgogICAgICAxODoJdzEgPSAweDQKICAgICAgMTk6CSoo
dTMyICopKHIxMCAtIDB4YykgPSB3MQogICAgICAyMDoJZ290byArMHg2IDxmb28rMHhkOD4KICAg
ICAgMjE6CXcxID0gMHg1CiAgICAgIDIyOgkqKHUzMiAqKShyMTAgLSAweGMpID0gdzEKICAgICAg
MjM6CWdvdG8gKzB4MyA8Zm9vKzB4ZDg+CiAgICAgIDI0Ogl3MSA9IDB4MTMKICAgICAgMjU6CSoo
dTMyICopKHIxMCAtIDB4YykgPSB3MQogICAgICAyNjoJZ290byArMHgwIDxmb28rMHhkOD4KICAg
ICAgMjc6CXcxID0gKih1MzIgKikocjEwIC0gMHhjKQogICAgICAyODoJY2FsbCAtMHgxCgkJMDAw
MDAwMDAwMDAwMDBlMDogIFJfQlBGXzY0XzMyCWJhcgogICAgICAyOToJdzAgKz0gLTB4MQogICAg
ICAzMDoJdzEgPSB3MAogICAgICAzMToJKih1NjQgKikocjEwIC0gMHgyMCkgPSByMQogICAgICAz
MjoJaWYgdzAgPiAweDJiIGdvdG8gKzB4MTYgPGZvbysweDFiOD4KICAgICAgMzM6CXIyID0gKih1
NjQgKikocjEwIC0gMHgyMCkKICAgICAgMzQ6CXIyIDw8PSAweDMKICAgICAgMzU6CXIxID0gMHgx
MDAgbGwKCQkwMDAwMDAwMDAwMDAwMTE4OiAgUl9CUEZfNjRfNjQJLmp1bXB0YWJsZXMKICAgICAg
Mzc6CXIxICs9IHIyCiAgICAgIDM4OglyMSA9ICoodTY0ICopKHIxICsgMHgwKQogICAgICAzOToJ
Z290b3ggcjEKICAgICAgNDA6CXcxID0gMHg1CiAgICAgIDQxOgkqKHUzMiAqKShyMTAgLSAweGMp
ID0gdzEKICAgICAgNDI6CWdvdG8gKzB4ZiA8Zm9vKzB4MWQwPgogICAgICA0MzoJdzEgPSAweDcK
ICAgICAgNDQ6CSoodTMyICopKHIxMCAtIDB4YykgPSB3MQogICAgICA0NToJZ290byArMHhjIDxm
b28rMHgxZDA+CiAgICAgIDQ2Ogl3MSA9IDB4MTcKICAgICAgNDc6CSoodTMyICopKHIxMCAtIDB4
YykgPSB3MQogICAgICA0ODoJZ290byArMHg5IDxmb28rMHgxZDA+CiAgICAgIDQ5Ogl3MSA9IDB4
MjUKICAgICAgNTA6CSoodTMyICopKHIxMCAtIDB4YykgPSB3MQogICAgICA1MToJZ290byArMHg2
IDxmb28rMHgxZDA+CiAgICAgIDUyOgl3MSA9IDB4NGQKICAgICAgNTM6CSoodTMyICopKHIxMCAt
IDB4YykgPSB3MQogICAgICA1NDoJZ290byArMHgzIDxmb28rMHgxZDA+CiAgICAgIDU1Ogl3MSA9
IDB4YgogICAgICA1NjoJKih1MzIgKikocjEwIC0gMHhjKSA9IHcxCiAgICAgIDU3Oglnb3RvICsw
eDAgPGZvbysweDFkMD4KICAgICAgNTg6CXcwID0gKih1MzIgKikocjEwIC0gMHhjKQogICAgICA1
OToJZXhpdAoK


--=-23b8JRhv/SmifpmIRp2G--

