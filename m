Return-Path: <bpf+bounces-8149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D178259F
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 10:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF921C2092E
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CD32112;
	Mon, 21 Aug 2023 08:36:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293DB15BA
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 08:36:50 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8341AB5
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 01:36:43 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so3710668a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692607002; x=1693211802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=72HSNEt7Lc2k9yVA/FsLp62Ha6RR0IszhWUfriuwIrM=;
        b=ooR9/e9P3bOTC4CZXny+GomH9og73BuEIqp+IxKgIFjxP47K0Ky+sczHxHv8fl0RNq
         w/CaUegVgU0CDHhzyyUZ0zeu5AWCGuhg0iocoJvIBTu1hfFWdEtYNzrE0a55HBLfgomu
         QxVQD8YWCXbAi8/eQTlhbTd3vocnMeWzKFYeXcVCbwoIcUtfaWIZ+2myD3nwCcxKPFxK
         SD5p2LpV/C3mBZ76r9VIgKnFSajx2d41XjOEZ2knwawrQcUiaTL5HLVu+r+K0Ii8ZTlg
         iJHpSYq5jOl+e40kz3cky43JNgV+MIhKEQ/hg4bC6pmOke0YCBsXgVM99FhERLUwl1PU
         txcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692607002; x=1693211802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72HSNEt7Lc2k9yVA/FsLp62Ha6RR0IszhWUfriuwIrM=;
        b=QReEDG8s7Nzf94j2naZj/JOf1T2NYlTfoMbyhsadisumkStORNR+S+Giu8BiMTgeSz
         lWnnpP5Fdj84G4YEBUuD274IqnMpos5+kvorlQ582QOhnmN4BWmiatKM2qqGdf9Xo3y0
         eyS63tvWGZNTQBRNm3+C+QeMRChG9Jq5dcVq2DSXlyE8/z5J1nrLQsa4kQdY+NoYigaX
         9PKYQKlAZlnOglz6X7CMVj44ysiNxzqL6tk00ZZbCrDLjR5JAWhB1jYi9yD3wmZZZ1XE
         lkpLkRDQ7xo9tEsI4OzXJWNuDrt4zXoTEvRrMcXROpa/U1/SxjrOfYgvD0DBsNE/VlFK
         TRGw==
X-Gm-Message-State: AOJu0YzHW1PGn107qOiKMmnGMsuWmZXcHf/S8IDEaaJ1CO0UdofOgAN8
	bPcATG1zgqlpDgdUIozVt80dKq90QjvulmIZ6iY=
X-Google-Smtp-Source: AGHT+IFlLi1tHzowAPLphZKWaUh5S8WQLEJ9kZQeFQc6JSM7WmZSMGvsB+kFdlfjzbOo8n/lHEOmOHieNKhqfPEkFik=
X-Received: by 2002:aa7:c04c:0:b0:522:3a89:a79d with SMTP id
 k12-20020aa7c04c000000b005223a89a79dmr4230373edo.2.1692607001732; Mon, 21 Aug
 2023 01:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821000230.3108635-1-yonghong.song@linux.dev>
In-Reply-To: <20230821000230.3108635-1-yonghong.song@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 21 Aug 2023 14:06:05 +0530
Message-ID: <CAP01T76hm=FBU3f9EePUsV525g=RFw0KPvSRn5BjHo=QGD_qEQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a bpf_kptr_xchg() issue with local kptr
To: Yonghong Song <yonghong.song@linux.dev>, Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000155d4106036ac7e4"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000155d4106036ac7e4
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Aug 2023 at 05:33, Yonghong Song <yonghong.song@linux.dev> wrote:
>
> When reviewing local percpu kptr support, Alexei discovered a bug
> wherea bpf_kptr_xchg() may succeed even if the map value kptr type and
> locally allocated obj type do not match ([1]). Missed struct btf_id
> comparison is the reason for the bug. This patch added such struct btf_id
> comparison and will flag verification failure if types do not match.
>
>   [1] https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com/#t
>
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Fixes: 738c96d5e2e3 ("bpf: Allow local kptrs to be exchanged via bpf_kptr_xchg")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

But some comments below...

>  kernel/bpf/verifier.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 02a021c524ab..4e1ecd4b8497 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7745,7 +7745,18 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>                         verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
>                         return -EFAULT;
>                 }
> -               /* Handled by helper specific checks */
> +               if (meta->func_id == BPF_FUNC_kptr_xchg) {
> +                       struct btf_field *kptr_field = meta->kptr_field;
> +
> +                       if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> +                                                 kptr_field->kptr.btf, kptr_field->kptr.btf_id,
> +                                                 true)) {
> +                               verbose(env, "R%d is of type %s but %s is expected\n",
> +                                       regno, btf_type_name(reg->btf, reg->btf_id),
> +                                       btf_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id));
> +                               return -EACCES;
> +                       }
> +               }

The fix on its own looks ok to me, but any reason you'd not like to
delegate to map_kptr_match_type?
Just to collect kptr related type matching logic in its own place.  It
doesn't matter too much though.

While looking at the code, I noticed one more problem.

I don't think the current code is enforcing that 'reg->off is zero'
assumption when releasing MEM_ALLOC types. We are only saved because
you passed strict=true which makes passing non-zero reg->off a noop
and returns false.
The hunk was added to check_func_arg_reg_off in
6a3cd3318ff6 ("bpf: Migrate release_on_unlock logic to non-owning ref
semantics")
which bypasses in case type is MEM_ALLOC and offset points to some
graph root or node.

I am not sure why this check exists, IIUC rbtree release helpers are
not tagged KF_RELEASE, and no release helper can type match on them
either. Dave, can you confirm? I think it might be an accidental
leftover of some refactoring.

In fact, it seems bpf_obj_drop is already broken because reg->off
assumption is violated.
For node_data type:

bpf_obj_drop(&res->data);
returns
R1 must have zero offset when passed to release func
No graph node or root found at R1 type:node_data off:8

but bpf_obj_drop(&res->node);
passes verifier.

15: (bf) r1 = r0                      ;
R0_w=ptr_node_data(ref_obj_id=3,off=16,imm=0)
R1_w=ptr_node_data(ref_obj_id=3,off=16,imm=0) refs=3
16: (b7) r2 = 0                       ; R2_w=0 refs=3
17: (85) call bpf_obj_drop_impl#74867      ;
safe

I have attached a tentative fix and selftest to this patch, let me
know what you think.

--000000000000155d4106036ac7e4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-bpf-Fix-check_func_arg_reg_off-bug-for-graph-root-no.patch"
Content-Disposition: attachment; 
	filename="0001-bpf-Fix-check_func_arg_reg_off-bug-for-graph-root-no.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_llkmdkkn1>
X-Attachment-Id: f_llkmdkkn1

RnJvbSBhMDQxOTA0N2MxNDhkMmUxYjM2NzY0YTVhN2NhMmQ5MDkyMzA0NGYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSA8bWVteG9yQGdtYWls
LmNvbT4KRGF0ZTogTW9uLCAyMSBBdWcgMjAyMyAxMzowMzo0MyArMDUzMApTdWJqZWN0OiBbUEFU
Q0ggMS8yXSBicGY6IEZpeCBjaGVja19mdW5jX2FyZ19yZWdfb2ZmIGJ1ZyBmb3IgZ3JhcGggcm9v
dC9ub2RlCgpUaGUgY29tbWl0IGJlaW5nIGZpeGVkIGludHJvZHVjZWQgYSBodW5rIGludG8gY2hl
Y2tfZnVuY19hcmdfcmVnX29mZgp0aGF0IGJ5cGFzc2VzIHJlZy0+b2ZmID09IDAgZW5mb3JjZW1l
bnQgd2hlbiBvZmZzZXQgcG9pbnRzIHRvIGEgZ3JhcGgKbm9kZSBvciByb290LiBUaGlzIG1pZ2h0
IHBvc3NpYmx5IGJlIGRvbmUgZm9yIHRyZWF0aW5nIGJwZl9yYnRyZWVfcmVtb3ZlCmFuZCBvdGhl
cnMgYXMgS0ZfUkVMRUFTRSBhbmQgdGhlbiBsYXRlciBjaGVjayBjb3JyZWN0IHJlZy0+b2ZmIGlu
IGhlbHBlcgphcmd1bWVudCBjaGVja3MuCgpCdXQgdGhpcyBpcyBub3QgdGhlIGNhc2UsIHRob3Nl
IGhlbHBlcnMgYXJlIGFscmVhZHkgbm90IEtGX1JFTEVBU0UgYW5kCnBlcm1pdCBub24temVybyBy
ZWctPm9mZiBhbmQgdmVyaWZ5IGl0IGxhdGVyIHRvIG1hdGNoIHRoZSBzdWJvYmplY3QgaW4KQlRG
IHR5cGUuCgpIb3dldmVyLCB0aGlzIGxvZ2ljIGxlYWRzIHRvIGJwZl9vYmpfZHJvcCBwZXJtaXR0
aW5nIGZyZWUgb2YgcmVnaXN0ZXIKYXJndW1lbnRzIHdpdGggbm9uLXplcm8gb2Zmc2V0IHdoZW4g
dGhleSBwb2ludCB0byBhIGdyYXBoIHJvb3Qgb3Igbm9kZQp3aXRoaW4gdGhlbSwgd2hpY2ggaXMg
bm90IG9rLgoKRm9yIGluc3RhbmNlOgoKc3RydWN0IGZvbyB7CglpbnQgaTsKCWludCBqOwoJc3Ry
dWN0IGJwZl9yYl9ub2RlIG5vZGU7Cn07CgpzdHJ1Y3QgZm9vICpmID0gYnBmX29ial9uZXcodHlw
ZW9mKCpmKSk7CmlmICghZikgLi4uCmJwZl9vYmpfZHJvcChmKTsgLy8gT0sKYnBmX29ial9kcm9w
KCZmLT5pKTsgLy8gc3RpbGwgb2sgZnJvbSB2ZXJpZmllciBQb1YKYnBmX29ial9kcm9wKCZmLT5u
b2RlKTsgLy8gTm90IE9LLCBidXQgcGVybWl0dGVkIHJpZ2h0IG5vdwoKRml4IHRoaXMgYnkgZHJv
cHBpbmcgdGhlIHdob2xlIHBhcnQgb2YgY29kZSBhbHRvZ2V0aGVyLgoKRml4ZXM6IDZhM2NkMzMx
OGZmNiAoImJwZjogTWlncmF0ZSByZWxlYXNlX29uX3VubG9jayBsb2dpYyB0byBub24tb3duaW5n
IHJlZiBzZW1hbnRpY3MiKQpTaWduZWQtb2ZmLWJ5OiBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSA8
bWVteG9yQGdtYWlsLmNvbT4KLS0tCiBrZXJuZWwvYnBmL3ZlcmlmaWVyLmMgfCAxMSAtLS0tLS0t
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5l
bC9icGYvdmVyaWZpZXIuYyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwppbmRleCA3ZmE0NmU5MmZl
MDEuLmMwNjE2YzhiNjc2ZCAxMDA2NDQKLS0tIGEva2VybmVsL2JwZi92ZXJpZmllci5jCisrKyBi
L2tlcm5lbC9icGYvdmVyaWZpZXIuYwpAQCAtNzk3OSwxNyArNzk3OSw2IEBAIGludCBjaGVja19m
dW5jX2FyZ19yZWdfb2ZmKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsCiAJCWlmIChhcmdf
dHlwZV9pc19keW5wdHIoYXJnX3R5cGUpICYmIHR5cGUgPT0gUFRSX1RPX1NUQUNLKQogCQkJcmV0
dXJuIDA7CiAKLQkJaWYgKCh0eXBlX2lzX3B0cl9hbGxvY19vYmoodHlwZSkgfHwgdHlwZV9pc19u
b25fb3duaW5nX3JlZih0eXBlKSkgJiYgcmVnLT5vZmYpIHsKLQkJCWlmIChyZWdfZmluZF9maWVs
ZF9vZmZzZXQocmVnLCByZWctPm9mZiwgQlBGX0dSQVBIX05PREVfT1JfUk9PVCkpCi0JCQkJcmV0
dXJuIF9fY2hlY2tfcHRyX29mZl9yZWcoZW52LCByZWcsIHJlZ25vLCB0cnVlKTsKLQotCQkJdmVy
Ym9zZShlbnYsICJSJWQgbXVzdCBoYXZlIHplcm8gb2Zmc2V0IHdoZW4gcGFzc2VkIHRvIHJlbGVh
c2UgZnVuY1xuIiwKLQkJCQlyZWdubyk7Ci0JCQl2ZXJib3NlKGVudiwgIk5vIGdyYXBoIG5vZGUg
b3Igcm9vdCBmb3VuZCBhdCBSJWQgdHlwZTolcyBvZmY6JWRcbiIsIHJlZ25vLAotCQkJCWJ0Zl90
eXBlX25hbWUocmVnLT5idGYsIHJlZy0+YnRmX2lkKSwgcmVnLT5vZmYpOwotCQkJcmV0dXJuIC1F
SU5WQUw7Ci0JCX0KLQogCQkvKiBEb2luZyBjaGVja19wdHJfb2ZmX3JlZyBjaGVjayBmb3IgdGhl
IG9mZnNldCB3aWxsIGNhdGNoIHRoaXMKIAkJICogYmVjYXVzZSBmaXhlZF9vZmZfb2sgaXMgZmFs
c2UsIGJ1dCBjaGVja2luZyBoZXJlIGFsbG93cyB1cwogCQkgKiB0byBnaXZlIHRoZSB1c2VyIGEg
YmV0dGVyIGVycm9yIG1lc3NhZ2UuCi0tIAoyLjQxLjAKCg==
--000000000000155d4106036ac7e4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-selftests-bpf-Add-test-for-bpf_obj_drop-with-bad-reg.patch"
Content-Disposition: attachment; 
	filename="0002-selftests-bpf-Add-test-for-bpf_obj_drop-with-bad-reg.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_llkmdvou1>
X-Attachment-Id: f_llkmdvou1

RnJvbSAxNzgzODQyNWMyODRjYWJiYWE5NWRmMzMwNWFmNzZkZDJiOTM4NzUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSA8bWVteG9yQGdtYWls
LmNvbT4KRGF0ZTogTW9uLCAyMSBBdWcgMjAyMyAxMzoxMDo0MiArMDUzMApTdWJqZWN0OiBbUEFU
Q0ggMi8yXSBzZWxmdGVzdHMvYnBmOiBBZGQgdGVzdCBmb3IgYnBmX29ial9kcm9wIHdpdGggYmFk
CiByZWctPm9mZgoKQWRkIGEgc2VsZnRlc3QgZm9yIHRoZSBmaXggcHJvdmlkZWQgaW4gdGhlIHBy
ZXZpb3VzIGNvbW1pdC4gV2l0aG91dCB0aGUKZml4LCB0aGUgc2VsZnRlc3QgcGFzc2VzIHRoZSB2
ZXJpZmllciB3aGlsZSBpdCBzaG91bGQgZmFpbC4gVGhlIHNwZWNpYWwKbG9naWMgZm9yIGRldGVj
dGluZyBncmFwaCByb290IG9yIG5vZGUgZm9yIHJlZy0+b2ZmIGFuZCBieXBhc3NpbmcKcmVnLT5v
ZmYgPT0gMCBndWFyYW50ZWUgZm9yIHJlbGVhc2UgaGVscGVycy9rZnVuY3MgaGFzIGJlZW4gZHJv
cHBlZC4KClNpZ25lZC1vZmYtYnk6IEt1bWFyIEthcnRpa2V5YSBEd2l2ZWRpIDxtZW14b3JAZ21h
aWwuY29tPgotLS0KIC4uLi9icGYvcHJvZ3MvbG9jYWxfa3B0cl9zdGFzaF9mYWlsLmMgICAgICAg
ICB8IDIwICsrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL2xvY2Fs
X2twdHJfc3Rhc2hfZmFpbC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL2xv
Y2FsX2twdHJfc3Rhc2hfZmFpbC5jCmluZGV4IGViYjVmMDIwOGI0MS4uM2U3YzRhMDNlZDk4IDEw
MDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvbG9jYWxfa3B0cl9z
dGFzaF9mYWlsLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL2xvY2Fs
X2twdHJfc3Rhc2hfZmFpbC5jCkBAIC02Miw0ICs2MiwyNCBAQCBsb25nIHN0YXNoX3JiX25vZGVz
KHZvaWQgKmN0eCkKIAlyZXR1cm4gMDsKIH0KIAorU0VDKCJ0YyIpCitfX2ZhaWx1cmUgX19tc2co
IlIxIG11c3QgaGF2ZSB6ZXJvIG9mZnNldCB3aGVuIHBhc3NlZCB0byByZWxlYXNlIGZ1bmMiKQor
bG9uZyBkcm9wX3JiX25vZGVfb2ZmKHZvaWQgKmN0eCkKK3sKKwlzdHJ1Y3QgbWFwX3ZhbHVlICpt
YXB2YWw7CisJc3RydWN0IG5vZGVfZGF0YSAqcmVzOworCWludCBpZHggPSAwOworCisJbWFwdmFs
ID0gYnBmX21hcF9sb29rdXBfZWxlbSgmc29tZV9ub2RlcywgJmlkeCk7CisJaWYgKCFtYXB2YWwp
CisJCXJldHVybiAxOworCisJcmVzID0gYnBmX29ial9uZXcodHlwZW9mKCpyZXMpKTsKKwlpZiAo
IXJlcykKKwkJcmV0dXJuIDE7CisJLyogVHJ5IHJlbGVhc2luZyB3aXRoIGdyYXBoIG5vZGUgb2Zm
c2V0ICovCisJYnBmX29ial9kcm9wKCZyZXMtPm5vZGUpOworCXJldHVybiAwOworfQorCiBjaGFy
IF9saWNlbnNlW10gU0VDKCJsaWNlbnNlIikgPSAiR1BMIjsKLS0gCjIuNDEuMAoK
--000000000000155d4106036ac7e4--

