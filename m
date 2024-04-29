Return-Path: <bpf+bounces-28056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4DB8B4F38
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 03:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B588228206F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 01:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4663E;
	Mon, 29 Apr 2024 01:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L7lHfAiv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A395E7F
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714354443; cv=none; b=XdNP38BOMURakdHEgvUJAz8hwHwkF0NYflTftfPA77I7dBk5oFeZcFfs95yBUbP3XIyGy5Kf2tq/0UcBCmS2upxZ93Uc41J4vkEGVxgEmkJ0TuLKhDsLslK4JWh720o1ijPyIU7Rv5EXaZZMRCzJD9CGCu62UvI/9+8GIUcWxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714354443; c=relaxed/simple;
	bh=fd0kJpD6vbyUOilYff0vqjgmGQdeo18DxumCk5VRECc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNuumfx6Qv8R1yZQPezJPJZW0F9RJWkNzyJ6gG+90EFfIAKT+oVNy9v+RK55XOnE9z/QnmukOSu8wjoVEnmVJk6nt39ZNr7DdIdhJTUOBmvweDuj6ENUu0CZKv9EEsqZ5zZ7B2JOQzXSz1qzDn267jDRMbBL/B20WOrfRUwrW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L7lHfAiv; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a56d7d457a1so457490966b.1
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 18:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714354440; x=1714959240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V9FR6pOGINW5hWqGcUs2Y0pMovcHvidMbvjger7RIYI=;
        b=L7lHfAiv+3nrxhqVyu5uatYy7ieFHJ3+mVKPZgSkE3PPZQxWQ2Xjo9Gn5N0qo5gEmH
         vhoGBPmCOmYfSMnXubGE2GSeUuGPPKBoFXGRWd7VW5PGi6No1QJsV397Fuo0SZ4ZjeKm
         oOFhSYAUtx8h9p/LBfPVN4EyKfKgBa9n7t/KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714354440; x=1714959240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9FR6pOGINW5hWqGcUs2Y0pMovcHvidMbvjger7RIYI=;
        b=gDFYIFke1NklwjKeDuJpD3c5ThAWadSUSH0M3y9IZ8RmgpDzZO8hnGM2ebkc/B462G
         xPrtSlf+ZvFLZaIKv3gNt7jsObKj5uWL5dpO3yLrwQ3mpCf3rz1stSjoYLFLXE0oioVL
         4bgTJrKDAN9VZy+UQiA69uOSo4tAPlRK1TZJULYf6SmORHDqs/b7WlQZrR4wh/PuQ+9Z
         sel87WARdO5fHDzLYRrpAJ+6USt1M7Ae6xCx3HURc8dttBlE3e9FDbO2VGc6ZCR2p/yf
         zByLYtFDgzsYlxYtgNWtaDNNS/+E43AqvM+4XU2FewYMASXs+bFmI20wj7rxViOxpH7Z
         bGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHDfr5IIJd6q4ZYOgfaPaN2B1iTDG09HIJSm6Qf0kJjWHeY5BNqNRwMJFmSZIveKg1tcMB8CzF/ffEn4vf4uWKn6M7
X-Gm-Message-State: AOJu0YyJR5amrtNwYWACDcyyIu1EY2Nd1XPy7Bw2l6L8w83HNCwHGQY9
	F21g1Oa7ygCfJ1kGQhi8QQEsp4r8tJar90iGnmgUtiaKsmi+quuWGzfsBJgH9P9jeVp2kyd8brR
	FROyyTg==
X-Google-Smtp-Source: AGHT+IEtMeo6izgmBYAmn8EGeh5SMXRMUVITteG7kCMdaDg9KhbI8+QKDOAdlo9V14gOsC5meC7/aw==
X-Received: by 2002:a17:906:33c7:b0:a56:8e7c:9eb8 with SMTP id w7-20020a17090633c700b00a568e7c9eb8mr5623364eja.9.1714354439607;
        Sun, 28 Apr 2024 18:33:59 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906490c00b00a58ea7cfeedsm2160644ejq.62.2024.04.28.18.33.58
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 18:33:58 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a55b3d57277so461918566b.2
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 18:33:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXvoAOFANPekS0pvJDe0m0LqEh8tZWMyAXfQk6GrM4/4z1ilUGmL8NUWGnSZ4HTvdu41nX2DbDk7wA4a6TRLoZp/PD
X-Received: by 2002:a17:906:698e:b0:a52:58a7:11d1 with SMTP id
 i14-20020a170906698e00b00a5258a711d1mr5612258ejr.38.1714354438473; Sun, 28
 Apr 2024 18:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com> <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 18:33:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
Message-ID: <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
To: Hillf Danton <hdanton@sina.com>, Andy Lutomirski <luto@amacapital.net>, Peter Anvin <hpa@zytor.com>, 
	Ingo Molnar <mingo@kernel.org>, Adrian Bunk <bunk@kernel.org>
Cc: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000005346490617323fd6"

--0000000000005346490617323fd6
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Apr 2024 at 17:50, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>    But the immediate problem is
> not the user space access, it's that something goes horribly wrong
> *around* it.

Side note: that stack trace from hell actually has three nested page
faults, and I think that's actually the important thing here:

 - the first page fault is from user space, and triggers the vsyscall emulation.

 - the second page fault is from __do_sys_gettimeofday, and that
should just have caused the exception that then sets the return value
to -EFAULT

 - the third nested page fault is due to _raw_spin_unlock_irqrestore
-> preempt_schedule -> trace_sched_switch, which then causes that bpf
trace program to run, which does that bpf_probe_read_compat, which
causes that page fault under pagefault_disable().

It's quite the nasty backtrace, and there's a lot going on.

And I think I finally see what may be going on. The problem is
literally the vsyscall emulation, which sets

        current->thread.sig_on_uaccess_err = 1;

and that causes the fixup_exception() code to send the signal
*despite* the exception being caught.

And I think that is in fact completely bogus.  It's completely bogus
exactly because it sends that signal even when it *shouldn't* be sent
- like for the bpf user mode trace gathering.

In other words, I think the whole "sig_on_uaccess_err" thing is
entirely broken, because it makes any nested page-faults do all the
wrong things.

Now, arguably, I don't think anybody should enable vsyscall emulation
any more, but this test case clearly does.

I think we should just make the "send SIGSEGV" be something that the
vsyscall emulation does on its own, not this broken per-thread state
for something that isn't actually per thread.

The x86 page fault code actually tried to deal with the "incorrect
nesting" by having that

                if (in_interrupt())
                        return;

which ignores the sig_on_uaccess_err case when it happens in
interrupts, but as shown by this example, these nested page faults do
not need to be about interrupts at all.

IOW, I think the only right thing is to remove that horrendously broken code.

The attached patch is ENTIRELY UNTESTED, but looks like the
ObviouslyCorrect(tm) thing to do.

NOTE! This broken code goes back to commit 4fc3490114bb ("x86-64: Set
siginfo and context on vsyscall emulation faults") in 2011, and back
then the reason was to get all the siginfo details right. Honestly, I
do not for a moment believe that it's worth getting the siginfo
details right here, but part of the commit says

    This fixes issues with UML when vsyscall=emulate.

and so my patch to remove this garbage will probably break UML in this
situation.

I cannot find it in myself to care, since I do not believe that
anybody should be running with vsyscall=emulate in 2024 in the first
place, much less if you are doing things like UML. But let's see if
somebody screams.

Also, somebody should obviously test my COMPLETELY UNTESTED patch.

Did I make it clear enough that this is UNTESTED and just does
crapectgomy on something that is clearly broken?

           Linus "UNTESTED" Torvalds

--0000000000005346490617323fd6
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lvkac5u00>
X-Attachment-Id: f_lvkac5u00

IGFyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsXzY0LmMgfCAyNSArKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaCAgICAgIHwgIDEg
LQogYXJjaC94ODYvbW0vZmF1bHQuYyAgICAgICAgICAgICAgICAgICB8IDMzICstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDU2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3Zz
eXNjYWxsXzY0LmMgYi9hcmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92c3lzY2FsbF82NC5jCmluZGV4
IGEzYzBkZjExZDBlNi4uM2IwZjYxYjJlYTZkIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9lbnRyeS92
c3lzY2FsbC92c3lzY2FsbF82NC5jCisrKyBiL2FyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNj
YWxsXzY0LmMKQEAgLTk4LDExICs5OCw2IEBAIHN0YXRpYyBpbnQgYWRkcl90b192c3lzY2FsbF9u
cih1bnNpZ25lZCBsb25nIGFkZHIpCiAKIHN0YXRpYyBib29sIHdyaXRlX29rX29yX3NlZ3YodW5z
aWduZWQgbG9uZyBwdHIsIHNpemVfdCBzaXplKQogewotCS8qCi0JICogWFhYOiBpZiBhY2Nlc3Nf
b2ssIGdldF91c2VyLCBhbmQgcHV0X3VzZXIgaGFuZGxlZAotCSAqIHNpZ19vbl91YWNjZXNzX2Vy
ciwgdGhpcyBjb3VsZCBnbyBhd2F5LgotCSAqLwotCiAJaWYgKCFhY2Nlc3Nfb2soKHZvaWQgX191
c2VyICopcHRyLCBzaXplKSkgewogCQlzdHJ1Y3QgdGhyZWFkX3N0cnVjdCAqdGhyZWFkID0gJmN1
cnJlbnQtPnRocmVhZDsKIApAQCAtMTIzLDcgKzExOCw2IEBAIGJvb2wgZW11bGF0ZV92c3lzY2Fs
bCh1bnNpZ25lZCBsb25nIGVycm9yX2NvZGUsCiAJc3RydWN0IHRhc2tfc3RydWN0ICp0c2s7CiAJ
dW5zaWduZWQgbG9uZyBjYWxsZXI7CiAJaW50IHZzeXNjYWxsX25yLCBzeXNjYWxsX25yLCB0bXA7
Ci0JaW50IHByZXZfc2lnX29uX3VhY2Nlc3NfZXJyOwogCWxvbmcgcmV0OwogCXVuc2lnbmVkIGxv
bmcgb3JpZ19keDsKIApAQCAtMjM0LDEyICsyMjgsOCBAQCBib29sIGVtdWxhdGVfdnN5c2NhbGwo
dW5zaWduZWQgbG9uZyBlcnJvcl9jb2RlLAogCQlnb3RvIGRvX3JldDsgIC8qIHNraXAgcmVxdWVz
dGVkICovCiAKIAkvKgotCSAqIFdpdGggYSByZWFsIHZzeXNjYWxsLCBwYWdlIGZhdWx0cyBjYXVz
ZSBTSUdTRUdWLiAgV2Ugd2FudCB0bwotCSAqIHByZXNlcnZlIHRoYXQgYmVoYXZpb3IgdG8gbWFr
ZSB3cml0aW5nIGV4cGxvaXRzIGhhcmRlci4KKwkgKiBXaXRoIGEgcmVhbCB2c3lzY2FsbCwgcGFn
ZSBmYXVsdHMgY2F1c2UgU0lHU0VHVi4KIAkgKi8KLQlwcmV2X3NpZ19vbl91YWNjZXNzX2VyciA9
IGN1cnJlbnQtPnRocmVhZC5zaWdfb25fdWFjY2Vzc19lcnI7Ci0JY3VycmVudC0+dGhyZWFkLnNp
Z19vbl91YWNjZXNzX2VyciA9IDE7Ci0KIAlyZXQgPSAtRUZBVUxUOwogCXN3aXRjaCAodnN5c2Nh
bGxfbnIpIHsKIAljYXNlIDA6CkBAIC0yNjIsMjMgKzI1MiwxMiBAQCBib29sIGVtdWxhdGVfdnN5
c2NhbGwodW5zaWduZWQgbG9uZyBlcnJvcl9jb2RlLAogCQlicmVhazsKIAl9CiAKLQljdXJyZW50
LT50aHJlYWQuc2lnX29uX3VhY2Nlc3NfZXJyID0gcHJldl9zaWdfb25fdWFjY2Vzc19lcnI7Ci0K
IGNoZWNrX2ZhdWx0OgogCWlmIChyZXQgPT0gLUVGQVVMVCkgewogCQkvKiBCYWQgbmV3cyAtLSB1
c2Vyc3BhY2UgZmVkIGEgYmFkIHBvaW50ZXIgdG8gYSB2c3lzY2FsbC4gKi8KIAkJd2Fybl9iYWRf
dnN5c2NhbGwoS0VSTl9JTkZPLCByZWdzLAogCQkJCSAgInZzeXNjYWxsIGZhdWx0IChleHBsb2l0
IGF0dGVtcHQ/KSIpOwotCi0JCS8qCi0JCSAqIElmIHdlIGZhaWxlZCB0byBnZW5lcmF0ZSBhIHNp
Z25hbCBmb3IgYW55IHJlYXNvbiwKLQkJICogZ2VuZXJhdGUgb25lIGhlcmUuICAoVGhpcyBzaG91
bGQgYmUgaW1wb3NzaWJsZS4pCi0JCSAqLwotCQlpZiAoV0FSTl9PTl9PTkNFKCFzaWdpc21lbWJl
cigmdHNrLT5wZW5kaW5nLnNpZ25hbCwgU0lHQlVTKSAmJgotCQkJCSAhc2lnaXNtZW1iZXIoJnRz
ay0+cGVuZGluZy5zaWduYWwsIFNJR1NFR1YpKSkKLQkJCWdvdG8gc2lnc2VndjsKLQotCQlyZXR1
cm4gdHJ1ZTsgIC8qIERvbid0IGVtdWxhdGUgdGhlIHJldC4gKi8KKwkJZ290byBzaWdzZWd2Owog
CX0KIAogCXJlZ3MtPmF4ID0gcmV0OwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
cHJvY2Vzc29yLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaAppbmRleCA4MTE1
NDhmMTMxZjQuLjc4ZTUxYjBkNjQzMyAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
cHJvY2Vzc29yLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcHJvY2Vzc29yLmgKQEAgLTQ3
Miw3ICs0NzIsNiBAQCBzdHJ1Y3QgdGhyZWFkX3N0cnVjdCB7CiAJdW5zaWduZWQgbG9uZwkJaW9w
bF9lbXVsOwogCiAJdW5zaWduZWQgaW50CQlpb3BsX3dhcm46MTsKLQl1bnNpZ25lZCBpbnQJCXNp
Z19vbl91YWNjZXNzX2VycjoxOwogCiAJLyoKIAkgKiBQcm90ZWN0aW9uIEtleXMgUmVnaXN0ZXIg
Zm9yIFVzZXJzcGFjZS4gIExvYWRlZCBpbW1lZGlhdGVseSBvbgpkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvbW0vZmF1bHQuYyBiL2FyY2gveDg2L21tL2ZhdWx0LmMKaW5kZXggNjIyZDEyZWM3ZjA4Li5i
YmE0ZTAyMGRkNjQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L21tL2ZhdWx0LmMKKysrIGIvYXJjaC94
ODYvbW0vZmF1bHQuYwpAQCAtNzIzLDM5ICs3MjMsOCBAQCBrZXJuZWxtb2RlX2ZpeHVwX29yX29v
cHMoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHVuc2lnbmVkIGxvbmcgZXJyb3JfY29kZSwKIAlXQVJO
X09OX09OQ0UodXNlcl9tb2RlKHJlZ3MpKTsKIAogCS8qIEFyZSB3ZSBwcmVwYXJlZCB0byBoYW5k
bGUgdGhpcyBrZXJuZWwgZmF1bHQ/ICovCi0JaWYgKGZpeHVwX2V4Y2VwdGlvbihyZWdzLCBYODZf
VFJBUF9QRiwgZXJyb3JfY29kZSwgYWRkcmVzcykpIHsKLQkJLyoKLQkJICogQW55IGludGVycnVw
dCB0aGF0IHRha2VzIGEgZmF1bHQgZ2V0cyB0aGUgZml4dXAuIFRoaXMgbWFrZXMKLQkJICogdGhl
IGJlbG93IHJlY3Vyc2l2ZSBmYXVsdCBsb2dpYyBvbmx5IGFwcGx5IHRvIGEgZmF1bHRzIGZyb20K
LQkJICogdGFzayBjb250ZXh0LgotCQkgKi8KLQkJaWYgKGluX2ludGVycnVwdCgpKQotCQkJcmV0
dXJuOwotCi0JCS8qCi0JCSAqIFBlciB0aGUgYWJvdmUgd2UncmUgIWluX2ludGVycnVwdCgpLCBh
a2EuIHRhc2sgY29udGV4dC4KLQkJICoKLQkJICogSW4gdGhpcyBjYXNlIHdlIG5lZWQgdG8gbWFr
ZSBzdXJlIHdlJ3JlIG5vdCByZWN1cnNpdmVseQotCQkgKiBmYXVsdGluZyB0aHJvdWdoIHRoZSBl
bXVsYXRlX3ZzeXNjYWxsKCkgbG9naWMuCi0JCSAqLwotCQlpZiAoY3VycmVudC0+dGhyZWFkLnNp
Z19vbl91YWNjZXNzX2VyciAmJiBzaWduYWwpIHsKLQkJCXNhbml0aXplX2Vycm9yX2NvZGUoYWRk
cmVzcywgJmVycm9yX2NvZGUpOwotCi0JCQlzZXRfc2lnbmFsX2FyY2hpbmZvKGFkZHJlc3MsIGVy
cm9yX2NvZGUpOwotCi0JCQlpZiAoc2lfY29kZSA9PSBTRUdWX1BLVUVSUikgewotCQkJCWZvcmNl
X3NpZ19wa3VlcnIoKHZvaWQgX191c2VyICopYWRkcmVzcywgcGtleSk7Ci0JCQl9IGVsc2Ugewot
CQkJCS8qIFhYWDogaHdwb2lzb24gZmF1bHRzIHdpbGwgc2V0IHRoZSB3cm9uZyBjb2RlLiAqLwot
CQkJCWZvcmNlX3NpZ19mYXVsdChzaWduYWwsIHNpX2NvZGUsICh2b2lkIF9fdXNlciAqKWFkZHJl
c3MpOwotCQkJfQotCQl9Ci0KLQkJLyoKLQkJICogQmFycmluZyB0aGF0LCB3ZSBjYW4gZG8gdGhl
IGZpeHVwIGFuZCBiZSBoYXBweS4KLQkJICovCisJaWYgKGZpeHVwX2V4Y2VwdGlvbihyZWdzLCBY
ODZfVFJBUF9QRiwgZXJyb3JfY29kZSwgYWRkcmVzcykpCiAJCXJldHVybjsKLQl9CiAKIAkvKgog
CSAqIEFNRCBlcnJhdHVtICM5MSBtYW5pZmVzdHMgYXMgYSBzcHVyaW91cyBwYWdlIGZhdWx0IG9u
IGEgUFJFRkVUQ0gK
--0000000000005346490617323fd6--

