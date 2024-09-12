Return-Path: <bpf+bounces-39779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B39775AC
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 01:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8CA282461
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 23:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044071C2DD4;
	Thu, 12 Sep 2024 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrQE23i1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE221C244B
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726184190; cv=none; b=Nlr1Ar/WyR/09pWP9h6MQE59bE2eFoDK9Iy4MfG45tLNw6yasf1ypl855iEvwJPjGrpKqD/yyqxAUeTSgbBbsXjNyWHYkr5tPNX6Y1REkCVbCyDq1Ilyavhgg1nZOr9B/QFFpkgl3kEF4ZOg0SH9jxLI9UJ2yEiwHOBxO/BaXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726184190; c=relaxed/simple;
	bh=5x8sOSqmEil6u6vXArLypaELUqp01t5GGi3Mqd/qIg0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HqiDvjitmzwYaXSRujMucW1TjEnEKyC9eLxHB5CRxjk3K8xQAGR4er1YW36hOSeg6BQCmHc2sPU539CR97grzu5KQQdEVV1h2g83SloqNl+pFNFGfG57/0RmeO5fXoaVfD1kVnsE4oMJdBUdE5tfNVrJKfhFrVUw+aMGT0zXrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrQE23i1; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-719232ade93so322087b3a.2
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726184188; x=1726788988; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9oI3YmCOseZtJb+PDL8wkTJoipcuxkhosVYnKTTxzxs=;
        b=GrQE23i1jVc4/uNVE4i0eQPoUI+sR/nWyKo2cvVT45VHxfzKXD1wyEVfkqxxUHeFG9
         o2go9eDlDasVsekPGGq3nxCvIoPTqErpwXyL+YqS6quyhCIbo+oGJosSdPfAYbKq3hl4
         xZTb3gYm5Vu+SFt0nbFpfYSUQwnuZcFG/4Z0WSaRRzz8m4rxcSVcxtQfB7+GUZZ70y3M
         8DHThGSV0ray6uyNnZx08vEEHvpA9BcOwKKQXlaMkYf2LGdC36N4laVrTRVa7NMl8XF1
         Qf1w6LQaPYNKtxD8RcMvjE8qV8OgOyxGmt7t1tzzDhJbykIu/lmW+U5gDQsucqS4Fmbg
         UAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726184188; x=1726788988;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oI3YmCOseZtJb+PDL8wkTJoipcuxkhosVYnKTTxzxs=;
        b=r7K9UJIEtDLQIJq5ialOnK1SbmqKjea5JySl81gnjIF/iiEAxcmCmRwqwz6vNZdSRM
         CaWuk76+vFiEJo3YXNVEGvxRaEsBFqWpcBH3gKOSSL5vTkgpQyXu26WOVeS+OHC4iXYq
         Var8r/r9i/4qyTC2T0+vPcdAEkSoHJOMKsMiseNpDwbME5pRJvCpo/JsSp55LqEvLKb7
         D5ngzAIKNKSVXAqm7FalFtJ504YT1kSSDswnNWzuA8VCZ+KkxeqiE69JeLlCtITzKxxR
         cnByrHUYvc+dpBpBRvSMJSzmVyvPGDyiEqaJtsvb2gCY+hpPOHQHW7UmltAZdKjEyzxj
         96HQ==
X-Gm-Message-State: AOJu0YxKLgdpYjlkXe4XewyjE4NISt6/kjZchSL1KJgD0M5EvEcVQy/z
	/orKp9CxjKAPpBMigwTGv3HkGO9R2to+DkQk+v6x3ecem9CbBnOxd8Z7eA==
X-Google-Smtp-Source: AGHT+IGYZdSsyq/MUKTRqGy0vFR45O74XanGCxkCq14OCQkvjqu6w1aQjyDRu3ZeLzQwjdfjnBbATg==
X-Received: by 2002:a05:6a00:14cd:b0:717:94d2:43c3 with SMTP id d2e1a72fcca58-71936af660dmr1638506b3a.18.1726184187972;
        Thu, 12 Sep 2024 16:36:27 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090ad428sm5256782b3a.142.2024.09.12.16.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:36:27 -0700 (PDT)
Message-ID: <7e2aa30a62d740db182c170fdd8f81c596df280d.camel@gmail.com>
Subject: Re: [PATCH] Fix a bug in ebpf verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: lonial con <kongln9170@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 12 Sep 2024 16:36:22 -0700
In-Reply-To: <CAH6SPwhUnn9-nNz9fpX3YGeA9WHT_BA5UzNgS5wYMqO=+8Ly_A@mail.gmail.com>
References: <1726037521-18232-1-git-send-email-kongln9170@gmail.com>
	 <67451140439fafa1bae3e3b010d2c6b9969696a1.camel@gmail.com>
	 <CAH6SPwj6=zu8fLNLwZ06fTso9634GV6ku21xpyzN+bwvrOevFg@mail.gmail.com>
	 <62b54401510477eebdb6e1272ba4308ee121c215.camel@gmail.com>
	 <CAH6SPwjoACNcNBWCjYauSMYCFOUAys10uH-xM6mF8_Q79D0Yow@mail.gmail.com>
	 <CAH6SPwhUnn9-nNz9fpX3YGeA9WHT_BA5UzNgS5wYMqO=+8Ly_A@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-tUPn5VgLFFz5sIAWZxF/"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-tUPn5VgLFFz5sIAWZxF/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-09-12 at 22:40 +0800, lonial con wrote:
> Hi,
>=20
> I tried to build this environment, but it seems that it needs kvm
> support. For me, it is very troublesome to prepare a kvm environment.
> So could you please write this selftest?

Please find the patch for test in the attachment.
Please submit a v2 as a patch-set of two parts:
- first patch: your fix
- second patch: my test

Also, please make sure to use up to date bpf-next kernel tree,
your patch changes function find_equal_scalars(), this function
was renamed to sync_linked_regs() some time ago.
So the updated fix should look like:

@@ -15349,8 +15349,12 @@ static void sync_linked_regs(struct bpf_verifier_s=
tate *vstate, struct bpf_reg_s
 			continue;
 		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
 		    reg->off =3D=3D known_reg->off) {
+			s32 saved_subreg_def =3D reg->subreg_def;
+
 			copy_register_state(reg, known_reg);
+			reg->subreg_def =3D saved_subreg_def;
 		} else {
+			s32 saved_subreg_def =3D reg->subreg_def;
 			s32 saved_off =3D reg->off;
=20
 			fake_reg.type =3D SCALAR_VALUE;
@@ -15363,6 +15367,8 @@ static void sync_linked_regs(struct bpf_verifier_st=
ate *vstate, struct bpf_reg_s
 			 * otherwise another sync_linked_regs() will be incorrect.
 			 */
 			reg->off =3D saved_off;
+			/* TODO: describe why */
+			reg->subreg_def =3D saved_subreg_def;
=20
 			scalar32_min_max_add(reg, &fake_reg);
 			scalar_min_max_add(reg, &fake_reg);


For illustrative purposes, you might refer to the test case in the
commit message for the fix. (You can actually run it w/o KVM, it would
be slower but otherwise should work). W/o your fix the test case is
miscompiled as follows:

   call %[bpf_ktime_get_ns];                    call unknown        =20
   r0 &=3D 0x7fffffff;          after verifier    r0 &=3D 2147483647    =
=20
   w1 =3D w0;                   rewrites          w1 =3D w0             =
=20
   if w0 < 10 goto +0;        -------------->   r11 =3D 794195110     =20
   r1 >>=3D 32;                                   r11 <<=3D 32          =
=20
   r0 =3D r1;                                     r1 |=3D r11           =
=20
   exit;                                        if w0 < 0xa goto pc+0
                                                r1 >>=3D 32           =20
                                                r0 =3D r1             =20
                                                exit

Leaving return value undefined.

[...]



--=-tUPn5VgLFFz5sIAWZxF/
Content-Disposition: attachment;
	filename*0=0002-selftests-bpf-verify-that-sync_linked_regs-preserves.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0002-selftests-bpf-verify-that-sync_linked_regs-preserves.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBhNzZhOWRlYmZhY2JjYTBmNWViYTJlMjcxNzI4YWMxNmM2Yjg0NTM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFZHVhcmQgWmluZ2VybWFuIDxlZGR5ejg3QGdtYWlsLmNvbT4K
RGF0ZTogVGh1LCAxMiBTZXAgMjAyNCAxNTo1NzoyMCAtMDcwMApTdWJqZWN0OiBbUEFUQ0ggYnBm
LW5leHQgdjEgMi8yXSBzZWxmdGVzdHMvYnBmOiB2ZXJpZnkgdGhhdCBzeW5jX2xpbmtlZF9yZWdz
CiBwcmVzZXJ2ZXMgc3VicmVnX2RlZgoKVGhpcyB0ZXN0IHdhcyBhZGRlZCBiZWNhdXNlIG9mIGEg
YnVnIGluIHZlcmlmaWVyLmM6c3luY19saW5rZWRfcmVncygpLAp1cG9uIHJhbmdlIHByb3BhZ2F0
aW9uIGl0IGRlc3Ryb3llZCBzdWJyZWdfZGVmIG1hcmtzIGZvciByZWdpc3RlcnMuClRoZSB0ZXN0
IGlzIHdyaXR0ZW4gaW4gYSB3YXkgdG8gcmV0dXJuIGFuIHVwcGVyIGhhbGYgb2YgYSByZWdpc3Rl
cgp0aGF0IGlzIGFmZmVjdGVkIGJ5IHJhbmdlIHByb3BhZ2F0aW9uIGFuZCBtdXN0IGhhdmUgaXQn
cyBzdWJyZWdfZGVmCnByZXNlcnZlZC4gVGhpcyBnaXZlcyBhIHJldHVybiB2YWx1ZSBvZiAwIGFu
ZCBsZWFkcyB0byB1bmRlZmluZWQKcmV0dXJuIHZhbHVlIGlmIHN1YnJlZ19kZWYgbWFyayBpcyBu
b3QgcHJlc2VydmVkLgoKU2lnbmVkLW9mZi1ieTogRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0Bn
bWFpbC5jb20+Ci0tLQogLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJfc2NhbGFyX2lk
cy5jIHwgNjcgKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDY3IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVy
aWZpZXJfc2NhbGFyX2lkcy5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Zl
cmlmaWVyX3NjYWxhcl9pZHMuYwppbmRleCAyZWNmNzdiNjIzZTAuLjA5ZTQxMGJjNzIyNSAxMDA2
NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3ZlcmlmaWVyX3NjYWxh
cl9pZHMuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJf
c2NhbGFyX2lkcy5jCkBAIC03NjAsNCArNzYwLDcxIEBAIF9fbmFrZWQgdm9pZCB0d29fb2xkX2lk
c19vbmVfY3VyX2lkKHZvaWQpCiAJOiBfX2Nsb2JiZXJfYWxsKTsKIH0KIAorU0VDKCJzb2NrZXQi
KQorLyogTm90ZSB0aGUgZmxhZywgc2VlIHZlcmlmaWVyLmM6b3B0X3N1YnJlZ196ZXh0X2xvMzJf
cm5kX2hpMzIoKSAqLworX19mbGFnKEJQRl9GX1RFU1RfUk5EX0hJMzIpCitfX3N1Y2Nlc3MKKy8q
IFRoaXMgdGVzdCB3YXMgYWRkZWQgYmVjYXVzZSBvZiBhIGJ1ZyBpbiB2ZXJpZmllci5jOnN5bmNf
bGlua2VkX3JlZ3MoKSwKKyAqIHVwb24gcmFuZ2UgcHJvcGFnYXRpb24gaXQgZGVzdHJveWVkIHN1
YnJlZ19kZWYgbWFya3MgZm9yIHJlZ2lzdGVycy4KKyAqIFRoZSBzdWJyZWdfZGVmIG1hcmsgaXMg
dXNlZCB0byBkZWNpZGUgd2hldGhlciB6ZXJvIGV4dGVuc2lvbiBpbnN0cnVjdGlvbnMKKyAqIGFy
ZSBuZWVkZWQgd2hlbiByZWdpc3RlciBpcyByZWFkLiBXaGVuIEJQRl9GX1RFU1RfUk5EX0hJMzIg
aXMgc2V0IGl0CisgKiBhbHNvIGNhdXNlcyBnZW5lcmF0aW9uIG9mIHN0YXRlbWVudHMgdG8gcmFu
ZG9taXplIHVwcGVyIGhhbGZzIG9mCisgKiByZWFkIHJlZ2lzdGVycy4KKyAqCisgKiBUaGUgdGVz
dCBpcyB3cml0dGVuIGluIGEgd2F5IHRvIHJldHVybiBhbiB1cHBlciBoYWxmIG9mIGEgcmVnaXN0
ZXIKKyAqIHRoYXQgaXMgYWZmZWN0ZWQgYnkgcmFuZ2UgcHJvcGFnYXRpb24gYW5kIG11c3QgaGF2
ZSBpdCdzIHN1YnJlZ19kZWYKKyAqIHByZXNlcnZlZC4gVGhpcyBnaXZlcyBhIHJldHVybiB2YWx1
ZSBvZiAwIGFuZCBsZWFkcyB0byB1bmRlZmluZWQKKyAqIHJldHVybiB2YWx1ZSBpZiBzdWJyZWdf
ZGVmIG1hcmsgaXMgbm90IHByZXNlcnZlZC4KKyAqLworX19yZXR2YWwoMCkKKy8qIENoZWNrIHRo
YXQgdmVyaWZpZXIgYmVsaWV2ZXMgcjEvcjAgYXJlIHplcm8gYXQgZXhpdCAqLworX19sb2dfbGV2
ZWwoMikKK19fbXNnKCI0OiAoNzcpIHIxID4+PSAzMiAgICAgICAgICAgICAgICAgICAgIDsgUjFf
dz0wIikKK19fbXNnKCI1OiAoYmYpIHIwID0gcjEgICAgICAgICAgICAgICAgICAgICAgIDsgUjBf
dz0wIFIxX3c9MCIpCitfX21zZygiNjogKDk1KSBleGl0IikKK19fbXNnKCJmcm9tIDMgdG8gNCIp
CitfX21zZygiNDogKDc3KSByMSA+Pj0gMzIgICAgICAgICAgICAgICAgICAgICA7IFIxX3c9MCIp
CitfX21zZygiNTogKGJmKSByMCA9IHIxICAgICAgICAgICAgICAgICAgICAgICA7IFIwX3c9MCBS
MV93PTAiKQorX19tc2coIjY6ICg5NSkgZXhpdCIpCisvKiBWZXJpZnkgdGhhdCBzdGF0ZW1lbnRz
IHRvIHJhbmRvbWl6ZSB1cHBlciBoYWxmIG9mIHIxIGhhZCBub3QgYmVlbgorICogZ2VuZXJhdGVk
LgorICovCitfX3hsYXRlZCgiY2FsbCB1bmtub3duIikKK19feGxhdGVkKCJyMCAmPSAyMTQ3NDgz
NjQ3IikKK19feGxhdGVkKCJ3MSA9IHcwIikKKy8qIFRoaXMgaXMgaG93IGRpc2FzbS5jIHByaW50
cyBCUEZfWkVYVF9SRUcgYXQgdGhlIG1vbWVudCwgeDg2IGFuZCBhcm0KKyAqIGFyZSB0aGUgb25s
eSBDSSBhcmNocyB0aGF0IGRvIG5vdCBuZWVkIHplcm8gZXh0ZW5zaW9uIGZvciBzdWJyZWdzLgor
ICovCisjaWYgIWRlZmluZWQoX19UQVJHRVRfQVJDSF94ODYpICYmICFkZWZpbmVkKF9fVEFSR0VU
X0FSQ0hfYXJtNjQpCitfX3hsYXRlZCgidzEgPSB3MSIpCisjZW5kaWYKK19feGxhdGVkKCJpZiB3
MCA8IDB4YSBnb3RvIHBjKzAiKQorX194bGF0ZWQoInIxID4+PSAzMiIpCitfX3hsYXRlZCgicjAg
PSByMSIpCitfX3hsYXRlZCgiZXhpdCIpCitfX25ha2VkIHZvaWQgbGlua2VkX3JlZ3NfYW5kX3N1
YnJlZ19kZWYodm9pZCkKK3sKKwlhc20gdm9sYXRpbGUgKAorCSJjYWxsICVbYnBmX2t0aW1lX2dl
dF9uc107IgorCS8qIG1ha2Ugc3VyZSByMCBpcyBpbiAzMi1iaXQgcmFuZ2UsIG90aGVyd2lzZSB3
MSA9IHcwIHdvbid0CisgICAgICAgICAqIGFzc2lnbiBzYW1lIElEcyB0byByZWdpc3RlcnMuCisJ
ICovCisJInIwICY9IDB4N2ZmZmZmZmY7IgorCS8qIGxpbmsgdzEgYW5kIHcwIHZpYSBJRCAqLwor
CSJ3MSA9IHcwOyIKKwkvKiAnaWYnIHN0YXRlbWVudCBwcm9wYWdhdGVzIHJhbmdlIGluZm8gZnJv
bSB3MCB0byB3MSwKKwkgKiBidXQgc2hvdWxkIG5vdCBhZmZlY3QgdzEtPnN1YnJlZ19kZWYgcHJv
cGVydHkuCisJICovCisJImlmIHcwIDwgMTAgZ290byArMDsiCisJLyogcjEgaXMgcmVhZCBoZXJl
LCBvbiBhcmNocyB0aGF0IHJlcXVpcmUgc3VicmVnIHplcm8KKyAgICAgICAgICogZXh0ZW5zaW9u
IHRoaXMgd291bGQgY2F1c2UgemV4dCBwYXRjaCBnZW5lcmF0aW9uLgorCSAqLworCSJyMSA+Pj0g
MzI7IgorCSJyMCA9IHIxOyIKKwkiZXhpdDsiCisJOgorCTogX19pbW0oYnBmX2t0aW1lX2dldF9u
cykKKwk6IF9fY2xvYmJlcl9hbGwpOworfQorCiBjaGFyIF9saWNlbnNlW10gU0VDKCJsaWNlbnNl
IikgPSAiR1BMIjsKLS0gCjIuNDYuMAoK


--=-tUPn5VgLFFz5sIAWZxF/--

