Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1FD33A38B
	for <lists+bpf@lfdr.de>; Sun, 14 Mar 2021 09:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhCNI3Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Mar 2021 04:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhCNI25 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Mar 2021 04:28:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FB6C061762
        for <bpf@vger.kernel.org>; Sun, 14 Mar 2021 00:28:56 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j3so13724168edp.11
        for <bpf@vger.kernel.org>; Sun, 14 Mar 2021 00:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ujBPd6PJmaTlt/8ZbmqrzeOBykDyLePR+osy7yCDN9E=;
        b=FEjeFBegFLjUheJglzMfzBqKiQEjMhvTGD1xBJIPUGCuqdR8sHC8rd5DfJK74MTrPG
         uTUMAnOIZm88Vx4CXq+4ZMiLnRzibxKIMAvV36/El9DThb8OJlzU1PTXq3diVDqIvl0I
         lSqQj3R41CYxo44f9lnmOcPOie+5xA2o/V+pBem9XPF76pM7nlF5pbjoDPf4B2spS+fD
         URdqm4Amz/NsAICIC/2LUaClyNCI091vuAzGQfWQASJB7zyUUo7Qmuu2UaUrqltP1TTF
         /FH4hCvESdaYhM2Psf+GNwRUaIDwf5rTHhrpCvwMQ6DwYWp0hZxwIrlUnnhWuU5VJuoY
         7kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ujBPd6PJmaTlt/8ZbmqrzeOBykDyLePR+osy7yCDN9E=;
        b=PZMi9mpcSuQu5KHxt2n3IPCuFbTJLM+Ex/cch4uqgY1hoXsEEU3fl0DoTxjHs9DQ6j
         FuWGNVodv0VLG4V9fbRN7zCeLreWyfPf3AIXyfjoGLaXn4AHbVSi4OYA/sgddiTVqMnD
         pRfqVqiMsDcmAP4hsZiJroLgpYFbDPV6TSzu+cC8Y5YMpwaqsj0/ktwMdv92p7YUC22r
         rGTYaT8GOsTR20sAko6HfITf28CWaJP9rjQezkd+t3DXSHs7wls3kbeAMCt9z4QePR6/
         TDYDndPRv7QgxUUeIcb4aYa1dp7L0/nJr698gZ3D3eAluLw5kfsbH2xP2+qOT+u00bKs
         E4cQ==
X-Gm-Message-State: AOAM531cJxrVPwOwllcZ9Zy0YcUzaFnZbJAK0sobyewOJ3cn1LQQDiHg
        OhZPMfQ7J3LD1C869Czcmpq4Rp1OFiElzLd8uRJ6
X-Google-Smtp-Source: ABdhPJwbESXO0QjAoSYh7IRnYouE/17lOLaH2/gjYCuB6Rlk5C7OclHvtlSNwr6tuqgoUjGa2q8P5BjiMjDoj4s2Bi8=
X-Received: by 2002:aa7:df14:: with SMTP id c20mr23665812edy.197.1615710535257;
 Sun, 14 Mar 2021 00:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20210212211607.2890660-1-morbo@google.com> <CAGG=3QWuxzwKGuYhVu+EfXPFZMNsO7-=NtHbdXAyvcVjvKF3hA@mail.gmail.com>
 <86bcb5c4-b3c8-e41f-96ec-800caf57f585@fb.com>
In-Reply-To: <86bcb5c4-b3c8-e41f-96ec-800caf57f585@fb.com>
From:   Bill Wendling <morbo@google.com>
Date:   Sun, 14 Mar 2021 00:28:44 -0800
Message-ID: <CAGG=3QUYzMNBwoOY9q739wKDVzuevZSjC=KPBdrQW9fXRCnvjQ@mail.gmail.com>
Subject: Re: [RFC 0/1] Combining CUs into a single hash table
To:     Yonghong Song <yhs@fb.com>
Cc:     dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000083f6da05bd7aec4f"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--00000000000083f6da05bd7aec4f
Content-Type: text/plain; charset="UTF-8"

On Sat, Mar 13, 2021 at 11:05 PM Yonghong Song <yhs@fb.com> wrote:
> On 2/23/21 12:44 PM, Bill Wendling wrote:
> > Bump for exposure.
> >
> > On Fri, Feb 12, 2021 at 1:16 PM Bill Wendling <morbo@google.com> wrote:
> >>
> >> Hey gang,
> >>
> >> I would like your feedback on this patch.
> >>
> >> This patch creates one hash table that all CUs share. The impetus for this
> >> patch is to support clang's LTO (Link-Time Optimizations). Currently, pahole
> >> can't handle the DWARF data that clang produces, because the CUs may refer to
> >> tags in other CUs (all of the code having been squozen together).
>
> Hi, Bill,
>
> LTO build support is now in linus tree 5.12 rc2 and also merged in
> latest bpf-next. I tried thin-LTO build and it is fine with latest
> trunk llvm (llvm13) until it hits pahole and it stuck there (pahole
> 1.20) probably some kind of infinite loop in pahole as pahole is
> not ready to handle lto dwarf yet.
>
> I then applied this patch on top of master pahole (1.20) and pahole
> seg faulted. I did not debug. Have you hit the same issue?
> How did you make pahole work with LTO built kernel?
>
Hi Yonghong,

I haven't tried this very much with top-of-tree Linux, but it's quite
possible that there's a segfaulting issue I haven't come across yet.
Make sure that you're using pahole v1.20, because it supports clang's
penchant for assigning some objects "null" names.

This patch is the first step in my attempt to get pahole working with
LTO. There's a follow-up patch that I'll attach to this email that
gets me through the compilation. It's not been heavily tested or
reviewed (it's in my local tree), so caveat emptor. I would love to
have people test it to see if it helps or just makes things worse.

Cheers!
-bw

> Thanks!
>
> Yonghong
>
> >>
> >> One solution I found is to process the CUs in two steps:
> >>
> >>    1. add the CUs into a single hash table, and
> >>    2. perform the recoding and finalization steps in a a separate step.
> >>
> >> The issue I'm facing with this patch is that it balloons the runtime from
> >> ~11.11s to ~14.27s. It looks like the underlying cause is that some (but not
> >> all) hash buckets have thousands of entries each. I've bumped up the
> >> HASHTAGS__BITS from 15 to 16, which helped a little. Bumping it up to 17 or
> >> above causes a failure.
> >>
> >> A couple of things I thought of may help. We could increase the number of
> >> buckets, which would help with distribution. As I mentioned though, that seemed
> >> to cause a failure. Another option is to store the bucket entries in a
> >> non-list, e.g. binary search tree.
> >>
> >> I wanted to get your opinions before I trod down one of these roads.
> >>
> >> Share and enjoy!
> >> -bw
> >>
> >> Bill Wendling (1):
> >>    dwarf_loader: have all CUs use a single hash table
> >>
> >>   dwarf_loader.c | 45 +++++++++++++++++++++++++++++++++------------
> >>   1 file changed, 33 insertions(+), 12 deletions(-)
> >>
> >> --
> >> 2.30.0.478.g8a0d178c01-goog
> >>

--00000000000083f6da05bd7aec4f
Content-Type: application/octet-stream; name="pahole.patch"
Content-Disposition: attachment; filename="pahole.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_km8w87va0>
X-Attachment-Id: f_km8w87va0

Y29tbWl0IDg2NmZhYzU4Zjg4ZDUwMWNhMjMxMzE4MzA2NzlkMWY5NjYyNWRkYTgKQXV0aG9yOiBC
aWxsIFdlbmRsaW5nIDxtb3Jib0Bnb29nbGUuY29tPgpEYXRlOiAgIEZyaSBGZWIgMTIgMTQ6MDU6
MTkgMjAyMSAtMDgwMAoKICAgIGR3YXJmX2xvYWRlcjogcGVyZm9ybSB0aGUgcmVjb2RpbmcgYW5k
IGZpbmFsaXphdGlvbiBzZXBhcmF0ZWx5CiAgICAKICAgIENsYW5nJ3MgTFRPIHByb2R1Y2VzIERX
QVJGIGRhdGEgd2hlcmUgYSBDVSBtYXkgcmVmZXIgdG8gdGFncyBpbiBvdGhlcgogICAgQ1UuIFRo
aXMgbWVhbnMgdGhhdCB3ZSBuZWVkIGFsbCB0YWdzIGZyb20gZXZlcnkgQ1UgYXZhaWxhYmxlIGR1
cmluZwogICAgcmVjb2RpbmcgYW5kIGZpbmFsaXphdGlvbi4gU28gd2UgZ2F0aGVyIHRoZSB0YWcg
ZGF0YSBpbiBvbmUgcGhhc2UgYW5kCiAgICB1c2UgaXQgaW4gdGhlIGZvbGxvd2luZyBwaGFzZS4K
ICAgIAogICAgU2lnbmVkLW9mZi1ieTogQmlsbCBXZW5kbGluZyA8bW9yYm9AZ29vZ2xlLmNvbT4K
CmRpZmYgLS1naXQgYS9kd2FyZl9sb2FkZXIuYyBiL2R3YXJmX2xvYWRlci5jCmluZGV4IDJiMGQ2
MTkuLmU4M2IyNDcgMTAwNjQ0Ci0tLSBhL2R3YXJmX2xvYWRlci5jCisrKyBiL2R3YXJmX2xvYWRl
ci5jCkBAIC0yMjYxLDE0ICsyMjYxLDYgQEAgc3RhdGljIGludCBkaWVfX3Byb2Nlc3MoRHdhcmZf
RGllICpkaWUsIHN0cnVjdCBjdSAqY3UpCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbnQgZGll
X19wcm9jZXNzX2FuZF9yZWNvZGUoRHdhcmZfRGllICpkaWUsIHN0cnVjdCBjdSAqY3UpCi17Ci0J
aW50IHJldCA9IGRpZV9fcHJvY2VzcyhkaWUsIGN1KTsKLQlpZiAocmV0ICE9IDApCi0JCXJldHVy
biByZXQ7Ci0JcmV0dXJuIGN1X19yZWNvZGVfZHdhcmZfdHlwZXMoY3UpOwotfQotCiBzdGF0aWMg
aW50IGNsYXNzX21lbWJlcl9fY2FjaGVfYnl0ZV9zaXplKHN0cnVjdCB0YWcgKnRhZywgc3RydWN0
IGN1ICpjdSwKIAkJCQkJIHZvaWQgKmNvb2tpZSkKIHsKQEAgLTI0OTgsNiArMjQ5MCwyMCBAQCBz
dGF0aWMgaW50IGN1c19fbG9hZF9tb2R1bGUoc3RydWN0IGN1cyAqY3VzLCBzdHJ1Y3QgY29uZl9s
b2FkICpjb25mLAogCQl9CiAJfQogCisJLyoKKwkgKiBDVXMgbWF5IHJlZmVyIHRvIHRhZ3MgYW5k
IHR5cGVzIGxvY2F0ZWQgaW4gb3RoZXIgQ1VzLiBUbyBzdXBwb3J0CisJICogdGhpcywgd2UgcHJv
Y2VzcyB0aGUgQ1VzIGluIHR3byBzdGVwcy4KKwkgKgorCSAqICAgLSBDb2xsZWN0IHRoZSBDVXMg
YW5kIGFkZHMgdGhlaXIgdHlwZXMgYW5kIHRhZ3MgZW50cmllcyBpbnRvCisJICogICAgIGhhc2hl
cyBzaGFyZWQgYmV0d2VlbiBhbGwgQ1VzLgorCSAqICAgLSBUaGVuIHJlY29kZSBhbmQgZmluYWxp
emUgdGhlIENVcy4KKwkgKi8KKworCS8qIEEgdGVtcG9yYXJ5IGxpc3Qgb2YgYWxsIENVIG9iamVj
dHMuICovCisJc3RydWN0IGN1cyAqZGN1cyA9IGN1c19fbmV3KCk7CisJaWYgKGRjdXMgPT0gTlVM
TCkKKwkJcmV0dXJuIERXQVJGX0NCX0FCT1JUOworCiAJd2hpbGUgKGR3YXJmX25leHRjdShkdywg
b2ZmLCAmbm9mZiwgJmN1aGwsIE5VTEwsICZwb2ludGVyX3NpemUsCiAJCQkgICAgJm9mZnNldF9z
aXplKSA9PSAwKSB7CiAJCUR3YXJmX0RpZSBkaWVfbWVtOwpAQCAtMjUyOCwyNCArMjUzNCw0MSBA
QCBzdGF0aWMgaW50IGN1c19fbG9hZF9tb2R1bGUoc3RydWN0IGN1cyAqY3VzLCBzdHJ1Y3QgY29u
Zl9sb2FkICpjb25mLAogCQl9CiAJCWN1LT5saXR0bGVfZW5kaWFuID0gZWhkci5lX2lkZW50W0VJ
X0RBVEFdID09IEVMRkRBVEEyTFNCOwogCi0JCXN0cnVjdCBkd2FyZl9jdSBkY3U7Ci0KLQkJZHdh
cmZfY3VfX2luaXQoJmRjdSk7Ci0JCWRjdS5jdSA9IGN1OwotCQlkY3UudHlwZV91bml0ID0gdHlw
ZV9jdSA/ICZ0eXBlX2RjdSA6IE5VTEw7Ci0JCWN1LT5wcml2ID0gJmRjdTsKLQkJY3UtPmRmb3Bz
ID0gJmR3YXJmX19vcHM7Ci0KLQkJaWYgKGRpZV9fcHJvY2Vzc19hbmRfcmVjb2RlKGN1X2RpZSwg
Y3UpICE9IDApCisJCXN0cnVjdCBkd2FyZl9jdSAqZGN1ID0gbWFsbG9jKHNpemVvZihzdHJ1Y3Qg
ZHdhcmZfY3UpKTsKKwkJaWYgKGRjdSA9PSBOVUxMKQogCQkJcmV0dXJuIERXQVJGX0NCX0FCT1JU
OwogCi0JCWlmIChmaW5hbGl6ZV9jdV9pbW1lZGlhdGVseShjdXMsIGN1LCAmZGN1LCBjb25mKQot
CQkgICAgPT0gTFNLX19TVE9QX0xPQURJTkcpCisJCWR3YXJmX2N1X19pbml0KGRjdSk7CisJCWRj
dS0+Y3UgPSBjdTsKKwkJZGN1LT50eXBlX3VuaXQgPSB0eXBlX2N1ID8gJnR5cGVfZGN1IDogTlVM
TDsKKwkJY3UtPnByaXYgPSBkY3U7CisJCWN1LT5kZm9wcyA9ICZkd2FyZl9fb3BzOworCisJCWN1
c19fYWRkKGRjdXMsIGN1KTsKKworCQlpZiAoZGllX19wcm9jZXNzKGN1X2RpZSwgY3UpICE9IExT
S19fS0VFUElUKQogCQkJcmV0dXJuIERXQVJGX0NCX0FCT1JUOwogCiAJCW9mZiA9IG5vZmY7CiAJ
fQogCisJLyogUmVjb2RlIGFuZCBmaW5hbGl6ZSB0aGUgQ1VzLiAqLworCXN0cnVjdCBjdSAqcG9z
LCAqbjsKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocG9zLCBuLCAmZGN1cy0+Y3VzLCBub2Rl
KSB7CisJCXN0cnVjdCBjdSAqY3UgPSBwb3M7CisJCXN0cnVjdCBkd2FyZl9jdSAqZGN1ID0gKHN0
cnVjdCBkd2FyZl9jdSAqKWN1LT5wcml2OworCisJCWlmIChjdV9fcmVjb2RlX2R3YXJmX3R5cGVz
KGN1KSAhPSBMU0tfX0tFRVBJVCkKKwkJCXJldHVybiBEV0FSRl9DQl9BQk9SVDsKKworCQlpZiAo
ZmluYWxpemVfY3VfaW1tZWRpYXRlbHkoY3VzLCBjdSwgZGN1LCBjb25mKQorCQkgICAgPT0gTFNL
X19TVE9QX0xPQURJTkcpCisJCQlyZXR1cm4gRFdBUkZfQ0JfQUJPUlQ7CisJfQorCisJLyogV2Ug
bm8gbG9uZ2VyIG5lZWQgdGhpcyBsaXN0IG9mIENVIG9iamVjdHMuICovCisJZnJlZShkY3VzKTsK
KwogCWlmICh0eXBlX2xzayA9PSBMU0tfX0RFTEVURSkKIAkJY3VfX2RlbGV0ZSh0eXBlX2N1KTsK
IAo=
--00000000000083f6da05bd7aec4f--
