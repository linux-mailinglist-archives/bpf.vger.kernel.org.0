Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80D35FFBA1
	for <lists+bpf@lfdr.de>; Sat, 15 Oct 2022 20:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJOSZw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Oct 2022 14:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJOSZv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Oct 2022 14:25:51 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298BB4C62D
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 11:25:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------w8MS8LTdWd6t8Iy0qkV3zT29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1665858348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UrOF6TkYKmnyMwDV5LJ69NB2DKHk16dk57GEH4DLoN8=;
        b=KxhaQUfP6cxRWrHMg1RLikWwS1YxbO/N+G5g4JPFxfXO6LoaQnhq03P5t9Vzi6cz9h4msd
        vRbW4BwdaPGoDQB/9aOM4mtMsDynITRzkOKKa0An38omDLRMylXEK8kQGuhZKqOliGfX5P
        rI3wJJqgRlsoJXMLReQK/j5an8M6NPSb5YR1lloQB0J1iRF3zWUzO9W+nwK0YhiBUVCzvO
        9m2xaI6AbZ6n/C+2yDNU5HtTdBythm8ELgiT1FgZAdMMl7RQDglZJj3NkC3TT8Q6FHjGN8
        CxGYhPloFWfMtuJ1Vcpm2YaLkLs3p3/wcU2TomXpZWHoALVXhHAgAyIFND5olQ==
Message-ID: <24e70b1d-fcee-23b4-d012-7ecb6ac906f2@manjaro.org>
Date:   Sat, 15 Oct 2022 20:25:47 +0200
MIME-Version: 1.0
Subject: Re: [kernel] 5.10.148 / 5.19.16 - pahole 1.24: BTFIDS vmlinux,FAILED:
 load BTF from vmlinux: Invalid argument
Content-Language: en-US
From:   =?UTF-8?Q?Philip_M=c3=bcller?= <philm@manjaro.org>
To:     bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Bernhard Landauer <bernhard@manjaro.org>
References: <3f82d342-1c0f-32c4-996e-cc063f872673@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <3f82d342-1c0f-32c4-996e-cc063f872673@manjaro.org>
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a multi-part message in MIME format.
--------------w8MS8LTdWd6t8Iy0qkV3zT29
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I came now up with this ...

-- 
Best, Philip

--------------w8MS8LTdWd6t8Iy0qkV3zT29
Content-Type: text/x-patch; charset=UTF-8;
 name="bpf-add-skip_encoding_btf_enum64-option-to-pahole.patch"
Content-Disposition: attachment;
 filename="bpf-add-skip_encoding_btf_enum64-option-to-pahole.patch"
Content-Transfer-Encoding: base64

RnJvbTogUGhpbGlwIE3DvGxsZXIgPHBoaWxtQG1hbmphcm8ub3JnPgpEYXRlOiBTYXQsIDE1
IE9jdCAyMDIxIDIwOjA5OjEzICswMjAwClN1YmplY3Q6IFtQQVRDSF0gYnBmOiBBZGQgc2tp
cF9lbmNvZGluZ19idGZfZW51bTY0IG9wdGlvbiB0byBwYWhvbGUKCk5ldyBwYWhvbGUgKHZl
cnNpb24gMS4yNCkgZ2VuZXJhdGVzIGJ5IGRlZmF1bHQgbmV3IEJURl9LSU5EX0VOVU02NCBC
VEYgdGFnLAp3aGljaCBpcyBub3Qgc3VwcG9ydGVkIGJ5IHN0YWJsZSBrZXJuZWwuCgpBcyBh
IHJlc3VsdCB0aGUga2VybmVsIHdpdGggQ09ORklHX0RFQlVHX0lORk9fQlRGIG9wdGlvbiB3
aWxsIGZhaWwgdG8KY29tcGlsZSB3aXRoIGZvbGxvd2luZyBlcnJvcjoKCiAgQlRGSURTICB2
bWxpbnV4CkZBSUxFRDogbG9hZCBCVEYgZnJvbSB2bWxpbnV4OiBJbnZhbGlkIGFyZ3VtZW50
CgpOZXcgcGFob2xlIHByb3ZpZGVzIC0tc2tpcF9lbmNvZGluZ19idGZfZW51bTY0IG9wdGlv
biB0byBza2lwIEJURl9LSU5EX0VOVU02NApnZW5lcmF0aW9uIGFuZCBwcm9kdWNlIEJURiBz
dXBwb3J0ZWQgYnkgc3RhYmxlIGtlcm5lbC4KCkFkZGluZyB0aGlzIG9wdGlvbiB0byBzY3Jp
cHRzL2xpbmstdm1saW51eC5zaC4KClRoaXMgY2hhbmdlIGRvZXMgbm90IGhhdmUgZXF1aXZh
bGVudCBjb21taXQgaW4gbGludXMgdHJlZSwgYmVjYXVzZSBsaW51cyB0cmVlCmhhcyBzdXBw
b3J0IGZvciBCVEZfS0lORF9FTlVNNjQgdGFnLCBzbyBpdCBkb2VzIG5vdCBuZWVkIHRvIGJl
IGRpc2FibGVkLgoKU2lnbmVkLW9mZi1ieTogUGhpbGlwIE3DvGxsZXIgPHBoaWxtQG1hbmph
cm8ub3JnPgotLS0KIHNjcmlwdHMvbGluay12bWxpbnV4LnNoIHwgNyArKysrKystCiAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvc2NyaXB0cy9saW5rLXZtbGludXguc2ggYi9zY3JpcHRzL2xpbmstdm1saW51eC5zaApp
bmRleCAzYjI2MWIwZjc0ZjBhNy4uNjY3YWFjYjkyNjFjZjIgMTAwNzU1Ci0tLSBhL3Njcmlw
dHMvbGluay12bWxpbnV4LnNoCisrKyBiL3NjcmlwdHMvbGluay12bWxpbnV4LnNoCkBAIC0y
MTMsNiArMjEzLDcgQEAgdm1saW51eF9saW5rKCkKIGdlbl9idGYoKQogewogCWxvY2FsIHBh
aG9sZV92ZXIKKwlsb2NhbCBleHRyYV9wYWhvbGVvcHQ9CiAKIAlpZiAhIFsgLXggIiQoY29t
bWFuZCAtdiAke1BBSE9MRX0pIiBdOyB0aGVuCiAJCWVjaG8gPiYyICJCVEY6ICR7MX06IHBh
aG9sZSAoJHtQQUhPTEV9KSBpcyBub3QgYXZhaWxhYmxlIgpAQCAtMjI3LDggKzIyOCwxMiBA
QCBnZW5fYnRmKCkKIAogCXZtbGludXhfbGluayAkezF9CiAKKwlpZiBbICIke3BhaG9sZV92
ZXJ9IiAtZ2UgIjEyNCIgXTsgdGhlbgorCQlleHRyYV9wYWhvbGVvcHQ9IiR7ZXh0cmFfcGFo
b2xlb3B0fSAtLXNraXBfZW5jb2RpbmdfYnRmX2VudW02NCIKKwlmaQorCiAJaW5mbyAiQlRG
IiAkezJ9Ci0JTExWTV9PQkpDT1BZPSR7T0JKQ09QWX0gJHtQQUhPTEV9IC1KICR7MX0KKwlM
TFZNX09CSkNPUFk9JHtPQkpDT1BZfSAke1BBSE9MRX0gLUogJHtleHRyYV9wYWhvbGVvcHR9
ICR7MX0KIAogCSMgQ3JlYXRlICR7Mn0gd2hpY2ggY29udGFpbnMganVzdCAuQlRGIHNlY3Rp
b24gYnV0IG5vIHN5bWJvbHMuIEFkZAogCSMgU0hGX0FMTE9DIGJlY2F1c2UgLkJURiB3aWxs
IGJlIHBhcnQgb2YgdGhlIHZtbGludXggaW1hZ2UuIC0tc3RyaXAtYWxsCg==

--------------w8MS8LTdWd6t8Iy0qkV3zT29--
