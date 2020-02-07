Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955C11560B1
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2020 22:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGVXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Feb 2020 16:23:09 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41036 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgBGVXJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Feb 2020 16:23:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so287436lfp.8
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 13:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9rJ6JCRkOCFo0V9s8CdNnaI3wWmefC28RszpTyGAWw=;
        b=VvtSmiQXMxNoLYA0REg7yn/IKYp9LpxAp2JMHVtTq9eKSbuHQofzu8thXdYfavxfgg
         KaszQKWyc5/sz+4ktvdx72FiDwHHSph2l5y+QLpormctWMbujlDSWpFTSUfUVVFukZZc
         +H5PgE78tWxv9Y4OwaU9H4Dg+/Ud6cjxcqz4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9rJ6JCRkOCFo0V9s8CdNnaI3wWmefC28RszpTyGAWw=;
        b=cJQAfi6VdZwjEEkCYqlSzyMbE7ne+5ypsUF3UzuoE0ZvEBytg+mRLts3ltwDlk3+zo
         Pt6aK31a4x8+RZCJDWxnEGysKM6QhUT9OPsFUav7JzHA/Koo39V1UPz/o2R5nrkdcACm
         632brHUgrXPHCgf0uhVs0kOJpi9e6XZiT9ip+O/+qMMCsK2qa0b95uOC9YkLZUCsT1Jz
         HbnInR9yboaIgGQWDHUIEfaA90t6YnUKM0dcBRvkzZZjTodywKTfhsmo+e64i9Dt7Sny
         VU0CTW40FCwd2T+CChWPPUPnFhwZ6juboEOfu5iRMOcmHIN9wsMUrROD7dF7byXJUx48
         LbuA==
X-Gm-Message-State: APjAAAVsc6d6qcQHvV7Kf5uiCtSDf/xI/VSnEWNc184ZztyFTkDx2uPI
        QBBLCrCtd2YB3jCd12JbY4u14S95I1fHBQ==
X-Google-Smtp-Source: APXvYqwrin+qXifHMNm4rdbY3ZkiAjWCiFW0j/BUMrmWJys7oz72lXy1ud2mOTgdl2/qaS0L3xR1jg==
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr403137lfp.162.1581110586658;
        Fri, 07 Feb 2020 13:23:06 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id n3sm1844738ljc.100.2020.02.07.13.23.05
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 13:23:05 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id b15so304078lfc.4
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 13:23:05 -0800 (PST)
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr409316lff.142.1581110584946;
 Fri, 07 Feb 2020 13:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20200207081810.3918919-1-kafai@fb.com> <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
 <CAHk-=wjbhawNieeiEig4LnPVRTRPgY8xag7NuAKuM9NKXCTLeQ@mail.gmail.com> <20200207204144.hh4n4o643oqpcwed@ltop.local>
In-Reply-To: <20200207204144.hh4n4o643oqpcwed@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Feb 2020 13:22:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvS9x5NKtOqcUgJeTY7dfdAHcEALJT53cy3P7Hzfgr1g@mail.gmail.com>
Message-ID: <CAHk-=whvS9x5NKtOqcUgJeTY7dfdAHcEALJT53cy3P7Hzfgr1g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, kernel-team@fb.com,
        Linux-Sparse <linux-sparse@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: multipart/mixed; boundary="000000000000c479ce059e02fe60"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--000000000000c479ce059e02fe60
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 7, 2020 at 12:41 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I never saw it so badly but it's not the first time I've bitten by
> the very early inlining. Independently of this, it would be handy to
> have an inliner at IR level, it shouldn't be very difficult but ...
> OTOH, it should really be straightforward would be to separate the
> current tree inliner from the type evaluation and instead run it just
> after expansion. The downsides would be:
>   * the tree would need to be walked once more;

Actually, if we were to do the inlining _during_ expansion, we
wouldn't add a new phase.

>   * this may make the expansion less useful but it could be run again
>     after the inlining.

Same comment: how about doing it as part of the expansion phase?

This is where we handle the built-ins too, it would kind of make sense
to do inlining in expand_symbol_call(), I feel. An inline function is
a "builtin" that the user has defined, after all.

And if we do it in that phase, we'd automatically avoid it for
conditional expressions with a static conditional value, because
expansion does the obvious trivial simplification as it goes along,
and never expands the side that is trivially not seen.

Something like the attached completely broken patch. It builds but
doesn't work, because "inline_function()" is currently designed to
work during evaluation, not during expansion.

So the patch is complete garbage, but maybe could be the starting
point for something that works.

             Linus

--000000000000c479ce059e02fe60
Content-Type: text/x-patch; charset="US-ASCII"; name="broken.diff"
Content-Disposition: attachment; filename="broken.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k6co9evz0>
X-Attachment-Id: f_k6co9evz0

ZGlmZiAtLWdpdCBhL2V2YWx1YXRlLmMgYi9ldmFsdWF0ZS5jCmluZGV4IGYxYTI2NmJlLi5iN2Ji
MWY1MiAxMDA2NDQKLS0tIGEvZXZhbHVhdGUuYworKysgYi9ldmFsdWF0ZS5jCkBAIC0zMTA3LDIy
ICszMTA3LDYgQEAgc3RhdGljIGludCBldmFsdWF0ZV9zeW1ib2xfY2FsbChzdHJ1Y3QgZXhwcmVz
c2lvbiAqZXhwcikKIAlpZiAoY3R5cGUtPm9wICYmIGN0eXBlLT5vcC0+ZXZhbHVhdGUpCiAJCXJl
dHVybiBjdHlwZS0+b3AtPmV2YWx1YXRlKGV4cHIpOwogCi0JaWYgKGN0eXBlLT5jdHlwZS5tb2Rp
ZmllcnMgJiBNT0RfSU5MSU5FKSB7Ci0JCWludCByZXQ7Ci0JCXN0cnVjdCBzeW1ib2wgKmN1cnIg
PSBjdXJyZW50X2ZuOwotCi0JCWlmIChjdHlwZS0+ZGVmaW5pdGlvbikKLQkJCWN0eXBlID0gY3R5
cGUtPmRlZmluaXRpb247Ci0KLQkJY3VycmVudF9mbiA9IGN0eXBlLT5jdHlwZS5iYXNlX3R5cGU7
Ci0KLQkJcmV0ID0gaW5saW5lX2Z1bmN0aW9uKGV4cHIsIGN0eXBlKTsKLQotCQkvKiByZXN0b3Jl
IHRoZSBvbGQgZnVuY3Rpb24gKi8KLQkJY3VycmVudF9mbiA9IGN1cnI7Ci0JCXJldHVybiByZXQ7
Ci0JfQotCiAJcmV0dXJuIDA7CiB9CiAKZGlmZiAtLWdpdCBhL2V4cGFuZC5jIGIvZXhwYW5kLmMK
aW5kZXggMzY2MTJjODYuLmE0ZjI2NDYxIDEwMDY0NAotLS0gYS9leHBhbmQuYworKysgYi9leHBh
bmQuYwpAQCAtOTEwLDYgKzkxMCwxNSBAQCBzdGF0aWMgaW50IGV4cGFuZF9zeW1ib2xfY2FsbChz
dHJ1Y3QgZXhwcmVzc2lvbiAqZXhwciwgaW50IGNvc3QpCiAJaWYgKGZuLT50eXBlICE9IEVYUFJf
UFJFT1ApCiAJCXJldHVybiBTSURFX0VGRkVDVFM7CiAKKwlpZiAoY3R5cGUtPmN0eXBlLm1vZGlm
aWVycyAmIE1PRF9JTkxJTkUpIHsKKwkJc3RydWN0IHN5bWJvbCAqZGVmOworCisJCWRlZiA9IGN0
eXBlLT5kZWZpbml0aW9uID8gY3R5cGUtPmRlZmluaXRpb24gOiBjdHlwZTsKKwkJaWYgKGlubGlu
ZV9mdW5jdGlvbihleHByLCBkZWYpKQorCQkJcmV0dXJuIGV4cGFuZF9leHByZXNzaW9uKGV4cHIp
OworCX0KKworCiAJaWYgKGN0eXBlLT5vcCAmJiBjdHlwZS0+b3AtPmV4cGFuZCkKIAkJcmV0dXJu
IGN0eXBlLT5vcC0+ZXhwYW5kKGV4cHIsIGNvc3QpOwogCg==
--000000000000c479ce059e02fe60--
