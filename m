Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0845350A89F
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 21:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391667AbiDUTCW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 15:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiDUTCV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 15:02:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7729F2194
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 11:59:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c15so6878476ljr.9
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ak9lVWwM+coDmUHY61U+ZihyKQCtIFN8nTMg/HLgunQ=;
        b=dUTQSAcJXhEgH56325FZO9cBwpb+y6gnzAUNugFkBCF6CGx9PFgIG3mnV3YjioVs3b
         TH2pvqbF8RHSX8PsvM64v1T/aseBE32JhDyWgSL5UjmKA/JIDWQwH9YFuRBx6QqXcBTo
         oZJFMw/LprgNr7LDtNxdhVWuHnyeBLs3xkMBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ak9lVWwM+coDmUHY61U+ZihyKQCtIFN8nTMg/HLgunQ=;
        b=yOHTmApCWTsbr9J5m4rUK5YASlfMPpJL8SC9/ayFcAKNtCLeoXXNjcl62cLVcwNppf
         XKd311QbLJ70B4hS8NW4hDGqiVUXdoLIujNFI9p+xJ6fygOUqRxBjqRWfrsBTEGCs5xy
         G45XlvTSBu3RJyY1e37Qp/EssLlcqOL2PXwdcj6qls/fzk01yRRhl+jQgdbal/wkyMey
         o0R+K5lP+kWK7VeWC80vOXXAFkmj8fzAg4jIzewwP9soQOUfcqP1xwJLuTePA632cJ6X
         Cv4N/txlstcMegNk0TYc35ALR6/XbNI5PdQU+vJHbtOxWnrJlP9pPOlO8SyMt3W7tyJa
         jFzA==
X-Gm-Message-State: AOAM5332IwlYbKnpZxcXjgesymWr0JeE9QpnRkQR3+WU2WgxHSV8FVAz
        RSuHD1WzfVEeStPhN6/x7BCFFPsOXPSer0TXgQ0=
X-Google-Smtp-Source: ABdhPJz47XyKTRq1X2XAPBosH/aIgTY36+Id5ak6M7nzSkFg8tjmpP5juDijduC/9UPnFE2gdv0RIw==
X-Received: by 2002:a05:651c:a0e:b0:24e:f06d:dae6 with SMTP id k14-20020a05651c0a0e00b0024ef06ddae6mr399076ljq.31.1650567568465;
        Thu, 21 Apr 2022 11:59:28 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id p15-20020a19604f000000b00471bc59aebasm642599lfk.219.2022.04.21.11.59.23
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 11:59:23 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id h27so10066993lfj.13
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 11:59:23 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr582580lfv.27.1650567562684; Thu, 21 Apr
 2022 11:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220421072212.608884-1-song@kernel.org> <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
 <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com>
In-Reply-To: <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 11:59:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com>
Message-ID: <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000004099a605dd2eb54d"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--0000000000004099a605dd2eb54d
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 21, 2022 at 11:24 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Let's not complicate the logic by dragging jit_fill_hole
> further into generic allocation.

I agree that just zeroing the page is probably perfectly fine in
practice on x86, but I'm also not really seeing the "complication" of
just doing things right.

> The existing bpf_prog_pack code still does memset(0xcc)
> a random range of bytes before and after jit-ed bpf code.

That is actually wishful thinking, and not based on reality.

From what I can tell, the end of the jit'ed bpf code is actually the
exception table entries, so we have that data being marked executable.

Honestly, what is wrong with this trivial patch?

I've not *tested* it, but it looks really really simple to me. Take it
as a "something like this" rather than anything else.

And yes, it would be better if bpf_jit_binary_pack_free did it too, so
that you don't have random old JIT'ed code lying around (and possibly
still in CPU branch history caches or whatever).

And it would be lovely if the exception table entries would be part of
another allocation and not marked executable.

But I certainly don't see the _downside_ (or complexity) of just doing
this, instead of zeroing things.

So this is by no means perfect, but it seems at least incrementally
_better_ than just zeroing. No?

                    Linus

--0000000000004099a605dd2eb54d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l29ck8xn0>
X-Attachment-Id: f_l29ck8xn0

IGtlcm5lbC9icGYvY29yZS5jIHwgMTAgKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2NvcmUu
YyBiL2tlcm5lbC9icGYvY29yZS5jCmluZGV4IDEzZTlkYmVlZWRmMy4uYTRjZmMzNTNhNTJkIDEw
MDY0NAotLS0gYS9rZXJuZWwvYnBmL2NvcmUuYworKysgYi9rZXJuZWwvYnBmL2NvcmUuYwpAQCAt
ODczLDcgKzg3Myw3IEBAIHN0YXRpYyBzaXplX3Qgc2VsZWN0X2JwZl9wcm9nX3BhY2tfc2l6ZSh2
b2lkKQogCXJldHVybiBzaXplOwogfQogCi1zdGF0aWMgc3RydWN0IGJwZl9wcm9nX3BhY2sgKmFs
bG9jX25ld19wYWNrKHZvaWQpCitzdGF0aWMgc3RydWN0IGJwZl9wcm9nX3BhY2sgKmFsbG9jX25l
d19wYWNrKGJwZl9qaXRfZmlsbF9ob2xlX3QgYnBmX2ZpbGxfaWxsX2luc25zKQogewogCXN0cnVj
dCBicGZfcHJvZ19wYWNrICpwYWNrOwogCkBAIC04ODksMTMgKzg4OSwxNCBAQCBzdGF0aWMgc3Ry
dWN0IGJwZl9wcm9nX3BhY2sgKmFsbG9jX25ld19wYWNrKHZvaWQpCiAJYml0bWFwX3plcm8ocGFj
ay0+Yml0bWFwLCBicGZfcHJvZ19wYWNrX3NpemUgLyBCUEZfUFJPR19DSFVOS19TSVpFKTsKIAls
aXN0X2FkZF90YWlsKCZwYWNrLT5saXN0LCAmcGFja19saXN0KTsKIAorCWJwZl9maWxsX2lsbF9p
bnNucyhwYWNrLT5wdHIsIGJwZl9wcm9nX3BhY2tfc2l6ZSk7CiAJc2V0X3ZtX2ZsdXNoX3Jlc2V0
X3Blcm1zKHBhY2stPnB0cik7CiAJc2V0X21lbW9yeV9ybygodW5zaWduZWQgbG9uZylwYWNrLT5w
dHIsIGJwZl9wcm9nX3BhY2tfc2l6ZSAvIFBBR0VfU0laRSk7CiAJc2V0X21lbW9yeV94KCh1bnNp
Z25lZCBsb25nKXBhY2stPnB0ciwgYnBmX3Byb2dfcGFja19zaXplIC8gUEFHRV9TSVpFKTsKIAly
ZXR1cm4gcGFjazsKIH0KIAotc3RhdGljIHZvaWQgKmJwZl9wcm9nX3BhY2tfYWxsb2ModTMyIHNp
emUpCitzdGF0aWMgdm9pZCAqYnBmX3Byb2dfcGFja19hbGxvYyh1MzIgc2l6ZSwgYnBmX2ppdF9m
aWxsX2hvbGVfdCBicGZfZmlsbF9pbGxfaW5zbnMpCiB7CiAJdW5zaWduZWQgaW50IG5iaXRzID0g
QlBGX1BST0dfU0laRV9UT19OQklUUyhzaXplKTsKIAlzdHJ1Y3QgYnBmX3Byb2dfcGFjayAqcGFj
azsKQEAgLTkxMCw2ICs5MTEsNyBAQCBzdGF0aWMgdm9pZCAqYnBmX3Byb2dfcGFja19hbGxvYyh1
MzIgc2l6ZSkKIAkJc2l6ZSA9IHJvdW5kX3VwKHNpemUsIFBBR0VfU0laRSk7CiAJCXB0ciA9IG1v
ZHVsZV9hbGxvYyhzaXplKTsKIAkJaWYgKHB0cikgeworCQkJYnBmX2ZpbGxfaWxsX2luc25zKHB0
ciwgc2l6ZSk7CiAJCQlzZXRfdm1fZmx1c2hfcmVzZXRfcGVybXMocHRyKTsKIAkJCXNldF9tZW1v
cnlfcm8oKHVuc2lnbmVkIGxvbmcpcHRyLCBzaXplIC8gUEFHRV9TSVpFKTsKIAkJCXNldF9tZW1v
cnlfeCgodW5zaWduZWQgbG9uZylwdHIsIHNpemUgLyBQQUdFX1NJWkUpOwpAQCAtOTIzLDcgKzky
NSw3IEBAIHN0YXRpYyB2b2lkICpicGZfcHJvZ19wYWNrX2FsbG9jKHUzMiBzaXplKQogCQkJZ290
byBmb3VuZF9mcmVlX2FyZWE7CiAJfQogCi0JcGFjayA9IGFsbG9jX25ld19wYWNrKCk7CisJcGFj
ayA9IGFsbG9jX25ld19wYWNrKGJwZl9maWxsX2lsbF9pbnNucyk7CiAJaWYgKCFwYWNrKQogCQln
b3RvIG91dDsKIApAQCAtMTEwMiw3ICsxMTA0LDcgQEAgYnBmX2ppdF9iaW5hcnlfcGFja19hbGxv
Yyh1bnNpZ25lZCBpbnQgcHJvZ2xlbiwgdTggKippbWFnZV9wdHIsCiAKIAlpZiAoYnBmX2ppdF9j
aGFyZ2VfbW9kbWVtKHNpemUpKQogCQlyZXR1cm4gTlVMTDsKLQlyb19oZWFkZXIgPSBicGZfcHJv
Z19wYWNrX2FsbG9jKHNpemUpOworCXJvX2hlYWRlciA9IGJwZl9wcm9nX3BhY2tfYWxsb2Moc2l6
ZSwgYnBmX2ZpbGxfaWxsX2luc25zKTsKIAlpZiAoIXJvX2hlYWRlcikgewogCQlicGZfaml0X3Vu
Y2hhcmdlX21vZG1lbShzaXplKTsKIAkJcmV0dXJuIE5VTEw7Cg==
--0000000000004099a605dd2eb54d--
