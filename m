Return-Path: <bpf+bounces-70711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A47BCB466
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 02:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80F51A61A12
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 00:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6111DE3AC;
	Fri, 10 Oct 2025 00:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6ATgbT1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD4176ADE
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760055996; cv=none; b=P7WJg4uOfVHrFCdHfQWDxKnwVPBLLxBRxfzmF1HyWgvEsp5R0BHa6phZmhfmit7UeQpPJIRvGOOWfK9fqrmmBJ2BMNSQbJzxztHzuyieemKK0+PvQGOarPHr70In4zzUHazXe6FEzrhTPLBIEth5XddqbOKDXe6He8nHoN/TtoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760055996; c=relaxed/simple;
	bh=JVQGXEnKlYV2bfnTgHup24mHvFAa+322b8XCRQx448g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i581fMBY5dCLMNZCUPGrxkMwVZq5Va7qa1EyUZjxHRPKjNSK/Wewq/x78tVdQiNxuwvWDcH+t1OS5RrXeTECg+9IPI9i2LAgTQjrPQJ4CDYD5sTi67qJSjtPclYthzDfMLK2vu9xG3b0+7qDy8WGrxPH8M7soCcXkItX9j6U1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6ATgbT1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso8244935e9.2
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 17:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760055993; x=1760660793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zUW4z5PB2uYt+UHHfwXSoWrNlo9PxYnuvCzympehrHU=;
        b=B6ATgbT1ukD0lFOwuh5p+sifo49XW21YM9nUDCIhQ/9gqYi1rQ88PlVe3WHjl7bZX6
         ugpGD+MGVbQw7tE+ZAOzqZCyFex6wRp8GfHDNAfD8FPyekJM5YKjh1KCEkfQChlXyTuv
         7AhyDVLK61+ZT1Qtsf47kNOtpeR9pOugjUUra/YTRg69dUGOCCRBgezILfW7rejpVwGb
         KemawWyzPk203OTs0ib78Ukk8LPUD3FYE/An7wlMY0SSmcYXygvyO/SgcFOp4E+idVmC
         VL3Zt/frFjNv/aBGs+aK8WM0EB9PNSBKGD52/qOP0jigKyUpOb3L4d1T5xdnI75Zr7wS
         lOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760055993; x=1760660793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUW4z5PB2uYt+UHHfwXSoWrNlo9PxYnuvCzympehrHU=;
        b=nSvZtw+5+yDPwHHogHcMhvdQ3nsyyMJba0S6+4m6OPiMHobpDijEGDhJpovyUgPrXQ
         oCcQ1KT8wOmoV/LygErzWHQfzrfOVYeF3ZH+50glizWO4/5efWZ745y+78pgegqGcbyM
         El/e1O5wJ808wWCUVWa+NdbvxOjg2ISFoiIseTlWZrG/y4hdDt6EwPvukYzrswRBU5fC
         nXtMU8pcSSAzmVF2HlT7AhDD9mNts4j9/XFLI4vZFKbeqwW4Wu2npvmLqjWzx7my3Mc1
         aFLk2jvUlZ69OUxsYxutPm5/3KtEyvEeQ+BPyOoEy++ac8XU9yNlPLGAek4BP5Te9+rF
         eUCA==
X-Forwarded-Encrypted: i=1; AJvYcCUZV5LY8XubmSuCQGCA574xbRR+GSPGhHy6ZBqeMk1Zo+8gP+TLEwiglzxzXe7eJQFPmGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3oTpwYXgxkWObVZa7g4c6rm2bNU+VEUFLeXU0gZ5oVnqhiZW
	Kym29l8OTVAzJvX3YDxTsRPIjqZ/QiJH9KwJvBfUtCqmcpKe1yUPpQLyq6xsDE9IBTKmV9qmk1o
	WVltTlhlVi7gCxqbGdUJn4kk8pxJlXDY=
X-Gm-Gg: ASbGncsJ5t9B9nk0F2pBhfJYs4rGsUuhrm314JI5hQc4UTbrccURs8Lev5kSPRuH/PU
	qrqiPSh+Y3TpRzavce0nF89rmgAQ/rjF4KVJ/MxbqJMwqoGA5P5LQlVSKt10fo2RGT6HuQ4LXQQ
	3j/uieGm+S3BTi/pmBEf/R7bUgZwmyhEgKsOWifZLW3bZDLRnjlBeyA9s5+nkngc41bEkVCPV/g
	MA4RcAs2xE46g1utkgmTfQQ1IJqMZkjNw6/3CUKzSKnd9nCWYXgsX2Qqj+iln4u
X-Google-Smtp-Source: AGHT+IEKhtlRs7io6HG8uJV/pO+2akEGSzzZFCHHiFDcUno2eR4NPpeVNsPtm6HRWIbw/xBK09T31f2XH3b4EnhpJ1g=
X-Received: by 2002:a05:600c:4506:b0:45b:8a0e:cda9 with SMTP id
 5b1f17b1804b1-46fa9a8638dmr69082915e9.2.1760055993199; Thu, 09 Oct 2025
 17:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68e7e6ad.a70a0220.126b66.0043.GAE@google.com> <20251009165241.4d78dc5d9fa5525d988806b5@linux-foundation.org>
In-Reply-To: <20251009165241.4d78dc5d9fa5525d988806b5@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 17:26:21 -0700
X-Gm-Features: AS18NWBxXjf9R6H60KDIOONvstVA7iwAST5osQQuEMTaL13eeM1e3CKmUs6Ja48
Message-ID: <CAADnVQK_8bNYEA7TJYgwTYR57=TTFagsvRxp62pFzS_z129eTg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: locking bug in __set_page_owner (2)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+8259e1d0e3ae8ed0c490@syzkaller.appspotmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brendan Jackman <jackmanb@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Michal Hocko <mhocko@suse.com>, Network Development <netdev@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, 
	Vlastimil Babka <vbabka@suse.cz>, ziy@nvidia.com, bpf <bpf@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000428a840640c2f8e6"

--000000000000428a840640c2f8e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 4:52=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu, 09 Oct 2025 09:45:33 -0700 syzbot <syzbot+8259e1d0e3ae8ed0c490@sy=
zkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    2c95a756e0cf net: pse-pd: tps23881: Fix current measure=
men..
> > git tree:       net
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16e1852f980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5bcbbf19237=
350b5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D8259e1d0e3ae8=
ed0c490
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7=
976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/8272657e4298/d=
isk-2c95a756.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/4e53ba690f28/vmli=
nux-2c95a756.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/6112d620d6fc=
/bzImage-2c95a756.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+8259e1d0e3ae8ed0c490@syzkaller.appspotmail.com
>
> At 2c95a756e0cf, page_owner.c hasn't been modified in a couple of years.
>
> How can add_stack_record_to_list()'s spin_lock_irqsave() be "invalid
> wait context"?  In NMI, yes, but the trace doesn't indicate that we're
> in an NMI.
>
> Confused.  I'm suspecting BPF involvement.  Cc'ed for help, please.

The attached patch should fix it.
There are different options, but this one is the simplest.

--000000000000428a840640c2f8e6
Content-Type: application/octet-stream; 
	name="0001-mm-Don-t-spin-in-add_stack_record-when-gfp-flags-don.patch"
Content-Disposition: attachment; 
	filename="0001-mm-Don-t-spin-in-add_stack_record-when-gfp-flags-don.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mgk3vgkn0>
X-Attachment-Id: f_mgk3vgkn0

RnJvbSAzODNhOTllYTlhMjM4MWQ4Y2VlMzk3Y2RjM2M4YTA5NmE5ZTVkN2NkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgpE
YXRlOiBUaHUsIDkgT2N0IDIwMjUgMTc6MTU6MTMgLTA3MDAKU3ViamVjdDogW1BBVENIIG1tXSBt
bTogRG9uJ3Qgc3BpbiBpbiBhZGRfc3RhY2tfcmVjb3JkIHdoZW4gZ2ZwIGZsYWdzIGRvbid0CiBh
bGxvdwoKc3l6Ym90IHdhcyBhYmxlIHRvIGZpbmQgdGhlIGZvbGxvd2luZyBwYXRoOgogIGFkZF9z
dGFja19yZWNvcmRfdG9fbGlzdCBtbS9wYWdlX293bmVyLmM6MTgyIFtpbmxpbmVdCiAgaW5jX3N0
YWNrX3JlY29yZF9jb3VudCBtbS9wYWdlX293bmVyLmM6MjE0IFtpbmxpbmVdCiAgX19zZXRfcGFn
ZV9vd25lcisweDJjMy8weDRhMCBtbS9wYWdlX293bmVyLmM6MzMzCiAgc2V0X3BhZ2Vfb3duZXIg
aW5jbHVkZS9saW51eC9wYWdlX293bmVyLmg6MzIgW2lubGluZV0KICBwb3N0X2FsbG9jX2hvb2sr
MHgyNDAvMHgyYTAgbW0vcGFnZV9hbGxvYy5jOjE4NTEKICBwcmVwX25ld19wYWdlIG1tL3BhZ2Vf
YWxsb2MuYzoxODU5IFtpbmxpbmVdCiAgZ2V0X3BhZ2VfZnJvbV9mcmVlbGlzdCsweDIxZTQvMHgy
MmMwIG1tL3BhZ2VfYWxsb2MuYzozODU4CiAgYWxsb2NfcGFnZXNfbm9sb2NrX25vcHJvZisweDk0
LzB4MTIwIG1tL3BhZ2VfYWxsb2MuYzo3NTU0CgpEb24ndCBzcGluIGluIGFkZF9zdGFja19yZWNv
cmRfdG9fbGlzdCgpIHdoZW4gaXQgaXMgY2FsbGVkCmZyb20gKl9ub2xvY2soKSBjb250ZXh0LgoK
UmVwb3J0ZWQtYnk6IHN5emJvdCs4MjU5ZTFkMGUzYWU4ZWQwYzQ5MEBzeXprYWxsZXIuYXBwc3Bv
dG1haWwuY29tClJlcG9ydGVkLWJ5OiBzeXpib3QrNjY1NzM5ZjQ1NmIyOGYzMmIyM2RAc3l6a2Fs
bGVyLmFwcHNwb3RtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFz
dEBrZXJuZWwub3JnPgotLS0KIG1tL3BhZ2Vfb3duZXIuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbW0vcGFnZV9vd25lci5jIGIvbW0vcGFn
ZV9vd25lci5jCmluZGV4IGMzY2EyMTEzMmMyYy4uNTg5ZWMzN2M5NGFhIDEwMDY0NAotLS0gYS9t
bS9wYWdlX293bmVyLmMKKysrIGIvbW0vcGFnZV9vd25lci5jCkBAIC0xNjgsNiArMTY4LDkgQEAg
c3RhdGljIHZvaWQgYWRkX3N0YWNrX3JlY29yZF90b19saXN0KHN0cnVjdCBzdGFja19yZWNvcmQg
KnN0YWNrX3JlY29yZCwKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCXN0cnVjdCBzdGFjayAqc3Rh
Y2s7CiAKKwlpZiAoIWdmcGZsYWdzX2FsbG93X3NwaW5uaW5nKGdmcF9tYXNrKSkKKwkJcmV0dXJu
OworCiAJc2V0X2N1cnJlbnRfaW5fcGFnZV9vd25lcigpOwogCXN0YWNrID0ga21hbGxvYyhzaXpl
b2YoKnN0YWNrKSwgZ2ZwX25lc3RlZF9tYXNrKGdmcF9tYXNrKSk7CiAJaWYgKCFzdGFjaykgewot
LSAKMi40Ny4zCgo=
--000000000000428a840640c2f8e6--

