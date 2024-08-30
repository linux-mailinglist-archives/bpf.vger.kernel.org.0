Return-Path: <bpf+bounces-38546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FCE966065
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 13:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71A21F29D85
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 11:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A31197512;
	Fri, 30 Aug 2024 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kpp8S95s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2C1D131D
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016555; cv=none; b=UeH63vMIk+YAIqt+6Pt8wqR/BrGOnsem6lPZ2Jw3thviw0t5+ytxevmcHTYGzavLrldhl+IX8yQZt8zxrxpsUPjs+L1Jf9sXY8FGgLCEqDIhbq1AD1T7eUgPMgcRmhR7zY5nIkPek94gqblXw1LuFFbQ7Qt6L4792jO6w2yDFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016555; c=relaxed/simple;
	bh=FrwymthPatG2A7kTNtc1T0kIZ1weLCHn4LL0OkdFYsw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F2d2vs5deJErCtQ+zl7+fCzL5Ns2IUaulMfA4ihJ8G1nHM8pU5k8sEj5KDX40rBNIH+pPONpIqD2ii4zPGR05gUw8ctPyyKSp84dcueAiiVinT03cyUlMC8ghjHiIBjEGNYPrqSReNyukQKWQYtlr3KnA5+rLrIT0zzoEpSwVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kpp8S95s; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7142448aaf9so1186744b3a.1
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 04:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725016553; x=1725621353; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa7rWxwOonS5Mu8xCqUzBmVbF4ExVZnbrsU+bW5FiOs=;
        b=Kpp8S95sKOG12m1LzH/+NFqUNPjxSH/isvvyPuqLjDF6S6GR6IOYZA/LqqbrT1awSQ
         FAavQkNoNtmmzUAL0qAE3JajLHOan0u6CF8UNrhuErksQBTGvqWWDD+MKT7VWYdkETQ7
         7EL3ZWXAbwYLA0KPPrwF7mx2AtjEbCA6HIe0IUoluj29x67mh7xFHoTOBMjVuYZu7uEA
         z0UluMZcktiJTPCbjRHNMwt3Qe6/vPYPpja4WZbpgye/Dc0tjVCm7g8QV1DOsl+AFrjo
         gfhPi7SSZWLH7mcXf1OVE5QY1Q3dGQrZgtIvUzeSckPUynB6jqgonKHXdNmV0w1QWRZe
         USRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725016553; x=1725621353;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa7rWxwOonS5Mu8xCqUzBmVbF4ExVZnbrsU+bW5FiOs=;
        b=kQGCUANfweT7AFwuXVpk4D4UK09yixFfAGYiC2aew8t+zU3nE0KaibVZYhaO1+nmQX
         4Dmhp6waIwRhUoEyGhf6One+tdalgNcSBwAZ/YBE00USWlNUayoTYDgCBs5R3OAFXGov
         VD1vSLkPTaTF/DoLRoXHvo2EN8DBmt/IKejfv5j2/A+KawFv6OqZelXnBFxVdovC03DZ
         qBV88NKgX2q2WCdl/3+fcKOkP9ZMmdWqTmm4qRvXQilxJ7xMQ+gVOnuVvS8bGjCgZ2XM
         cf9tP7CA+1UirH4BB9R9v/aGh/FLfv8ia4GklHvOeljZzGtHX9+r5n3YJrrVMTbq4Wvl
         02Yg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Qafp7o9u4MaxA4Eb8BWacm3IXzEXv1COOL/lb0NsCxz6/vN7NatDqTMDFnPIaDxXjQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzffXQ01i+cVDnL+/nPSF6G93MqiQDJnN46dH2vsXtOn1QyA6eP
	60AeGWbmWzPeFm0oQixQXL0IImlKiCgodidDxT7CIglSeMhq/1Kj
X-Google-Smtp-Source: AGHT+IH6CceILrws06iWqPEPvAdAwGaWqqffMC2K37tLEyOeD6EX9TtIHqtS5fblaLT3+0wqdFGUxg==
X-Received: by 2002:a05:6a00:2d1c:b0:70d:26cd:9741 with SMTP id d2e1a72fcca58-7170a85aaafmr2842361b3a.12.1725016552519;
        Fri, 30 Aug 2024 04:15:52 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a3a34sm2540510b3a.45.2024.08.30.04.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 04:15:51 -0700 (PDT)
Message-ID: <7425efdc2c8f52a780e2b4817e15911f8dd491f2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1] libbpf: ensure new BTF objects inherit
 input endianness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Date: Fri, 30 Aug 2024 04:15:47 -0700
In-Reply-To: <20240830095150.278881-1-tony.ambardar@gmail.com>
References: <5be4f797c3d5092b34d243361ebd0609f3301452.camel@gmail.com>
	 <20240830095150.278881-1-tony.ambardar@gmail.com>
Content-Type: multipart/mixed; boundary="=-uZ65FpwVMNACKtDut19W"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-uZ65FpwVMNACKtDut19W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-08-30 at 02:51 -0700, Tony Ambardar wrote:
> The pahole master branch recently added support for "distilled BTF" based
> on libbpf v1.5, but may add .BTF and .BTF.base sections with the wrong by=
te
> order (e.g. on s390x BPF CI), which then lead to kernel Oops when loaded.
>=20
> Fix by updating libbpf's btf__distill_base() and btf_new_empty() to retai=
n
> the byte order of any source BTF objects when creating new ones.
>=20
> Reported-by: Song Liu <song@kernel.org>
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Link: https://lore.kernel.org/bpf/6358db36c5f68b07873a0a5be2d062b1af5ea5f=
8.camel@gmail.com/
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

But we also need a test for this. Like the one attached.
Or Alan can share his test, which is much shorter but skips round trip to b=
ytes and back.

[...]

--=-uZ65FpwVMNACKtDut19W
Content-Disposition: attachment;
	filename*0=0001-selftests-bpf-checl-if-distilled-base-inherits-sourc.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-selftests-bpf-checl-if-distilled-base-inherits-sourc.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAzMGZkNDZlNGM4NGJhOTA2MjdiMDM5YjFlNzIxNDQ5Y2E4YjY1NmFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFZHVhcmQgWmluZ2VybWFuIDxlZGR5ejg3QGdtYWlsLmNvbT4K
RGF0ZTogRnJpLCAzMCBBdWcgMjAyNCAwNDowODo0NCAtMDcwMApTdWJqZWN0OiBbUEFUQ0ggYnBm
LW5leHRdIHNlbGZ0ZXN0cy9icGY6IGNoZWNsIGlmIGRpc3RpbGxlZCBiYXNlIGluaGVyaXRzCiBz
b3VyY2UgZW5kaWFubmVzcwoKQ3JlYXRlIGEgQlRGIHdpdGggZW5kaWFubmVzcyBkaWZmZXJlbnQg
ZnJvbSBob3N0LCBtYWtlIGEgZGlzdGlsbGVkCmJhc2Uvc3BsaXQgQlRGIHBhaXIgZnJvbSBpdCwg
ZHVtcCBhcyByYXcgYnl0ZXMsIGltcG9ydCBhZ2FpbiBhbmQKdmVyaWZ5IHRoYXQgZW5kaWFubmVz
cyBpcyBwcmVzZXJ2ZWQuCgpTaWduZWQtb2ZmLWJ5OiBFZHVhcmQgWmluZ2VybWFuIDxlZGR5ejg3
QGdtYWlsLmNvbT4KLS0tCiAuLi4vc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2J0Zl9kaXN0aWxs
LmMgICAgfCA3MyArKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNzMgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rl
c3RzL2J0Zl9kaXN0aWxsLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0
cy9idGZfZGlzdGlsbC5jCmluZGV4IGJmYmU3OTU4MjNhMi4uODEwYjJlNDM0NTYyIDEwMDY0NAot
LS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9idGZfZGlzdGlsbC5j
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2J0Zl9kaXN0aWxs
LmMKQEAgLTUzNSw2ICs1MzUsNzcgQEAgc3RhdGljIHZvaWQgdGVzdF9kaXN0aWxsZWRfYmFzZV92
bWxpbnV4KHZvaWQpCiAJYnRmX19mcmVlKHZtbGludXhfYnRmKTsKIH0KIAorc3RhdGljIGJvb2wg
aXNfaG9zdF9iaWdfZW5kaWFuKHZvaWQpCit7CisJcmV0dXJuIGh0b25zKDB4MTIzNCkgPT0gMHgx
MjM0OworfQorCisvKiBTcGxpdCBhbmQgbmV3IGJhc2UgQlRGcyBzaG91bGQgaW5oZXJpdCBlbmRp
YW5uZXNzIGZyb20gc291cmNlIEJURi4gKi8KK3N0YXRpYyB2b2lkIHRlc3RfZGlzdGlsbGVkX2Vu
ZGlhbm5lc3Modm9pZCkKK3sKKwlzdHJ1Y3QgYnRmICpiYXNlID0gTlVMTCwgKnNwbGl0ID0gTlVM
TCwgKm5ld19iYXNlID0gTlVMTCwgKm5ld19zcGxpdCA9IE5VTEw7CisJc3RydWN0IGJ0ZiAqbmV3
X2Jhc2UxID0gTlVMTCwgKm5ld19zcGxpdDEgPSBOVUxMOworCWVudW0gYnRmX2VuZGlhbm5lc3Mg
aW52ZXJzZV9lbmRpYW5uZXNzOworCWNvbnN0IHZvaWQgKnJhd19kYXRhOworCV9fdTMyIHNpemU7
CisKKwlwcmludGYoImlzX2hvc3RfYmlnX2VuZGlhbj8gJWRcbiIsIGlzX2hvc3RfYmlnX2VuZGlh
bigpKTsKKwlpbnZlcnNlX2VuZGlhbm5lc3MgPSBpc19ob3N0X2JpZ19lbmRpYW4oKSA/IEJURl9M
SVRUTEVfRU5ESUFOIDogQlRGX0JJR19FTkRJQU47CisJYmFzZSA9IGJ0Zl9fbmV3X2VtcHR5KCk7
CisJYnRmX19zZXRfZW5kaWFubmVzcyhiYXNlLCBpbnZlcnNlX2VuZGlhbm5lc3MpOworCWlmICgh
QVNTRVJUX09LX1BUUihiYXNlLCAiZW1wdHlfbWFpbl9idGYiKSkKKwkJcmV0dXJuOworCWJ0Zl9f
YWRkX2ludChiYXNlLCAiaW50IiwgNCwgQlRGX0lOVF9TSUdORUQpOyAgIC8qIFsxXSBpbnQgKi8K
KwlWQUxJREFURV9SQVdfQlRGKAorCQliYXNlLAorCQkiWzFdIElOVCAnaW50JyBzaXplPTQgYml0
c19vZmZzZXQ9MCBucl9iaXRzPTMyIGVuY29kaW5nPVNJR05FRCIpOworCXNwbGl0ID0gYnRmX19u
ZXdfZW1wdHlfc3BsaXQoYmFzZSk7CisJaWYgKCFBU1NFUlRfT0tfUFRSKHNwbGl0LCAiZW1wdHlf
c3BsaXRfYnRmIikpCisJCWdvdG8gY2xlYW51cDsKKwlidGZfX2FkZF9wdHIoc3BsaXQsIDEpOwor
CVZBTElEQVRFX1JBV19CVEYoCisJCXNwbGl0LAorCQkiWzFdIElOVCAnaW50JyBzaXplPTQgYml0
c19vZmZzZXQ9MCBucl9iaXRzPTMyIGVuY29kaW5nPVNJR05FRCIsCisJCSJbMl0gUFRSICcoYW5v
biknIHR5cGVfaWQ9MSIpOworCWlmICghQVNTRVJUX0VRKDAsIGJ0Zl9fZGlzdGlsbF9iYXNlKHNw
bGl0LCAmbmV3X2Jhc2UsICZuZXdfc3BsaXQpLAorCQkgICAgICAgImRpc3RpbGxlZF9iYXNlIikg
fHwKKwkgICAgIUFTU0VSVF9PS19QVFIobmV3X2Jhc2UsICJkaXN0aWxsZWRfYmFzZSIpIHx8CisJ
ICAgICFBU1NFUlRfT0tfUFRSKG5ld19zcGxpdCwgImRpc3RpbGxlZF9zcGxpdCIpIHx8CisJICAg
ICFBU1NFUlRfRVEoMiwgYnRmX190eXBlX2NudChuZXdfYmFzZSksICJkaXN0aWxsZWRfYmFzZV90
eXBlX2NudCIpKQorCQlnb3RvIGNsZWFudXA7CisJVkFMSURBVEVfUkFXX0JURigKKwkJbmV3X3Nw
bGl0LAorCQkiWzFdIElOVCAnaW50JyBzaXplPTQgYml0c19vZmZzZXQ9MCBucl9iaXRzPTMyIGVu
Y29kaW5nPVNJR05FRCIsCisJCSJbMl0gUFRSICcoYW5vbiknIHR5cGVfaWQ9MSIpOworCisJcmF3
X2RhdGEgPSBidGZfX3Jhd19kYXRhKG5ld19iYXNlLCAmc2l6ZSk7CisJaWYgKCFBU1NFUlRfT0tf
UFRSKHJhd19kYXRhLCAiYnRmX19yYXdfZGF0YSAjMSIpKQorCQlnb3RvIGNsZWFudXA7CisJbmV3
X2Jhc2UxID0gYnRmX19uZXcocmF3X2RhdGEsIHNpemUpOworCWlmICghQVNTRVJUX09LX1BUUihu
ZXdfYmFzZTEsICJuZXdfYmFzZTEgPSBidGZfX25ldygpIikpCisJCWdvdG8gY2xlYW51cDsKKwly
YXdfZGF0YSA9IGJ0Zl9fcmF3X2RhdGEobmV3X3NwbGl0LCAmc2l6ZSk7CisJaWYgKCFBU1NFUlRf
T0tfUFRSKHJhd19kYXRhLCAiYnRmX19yYXdfZGF0YSAjMiIpKQorCQlnb3RvIGNsZWFudXA7CisJ
bmV3X3NwbGl0MSA9IGJ0Zl9fbmV3X3NwbGl0KHJhd19kYXRhLCBzaXplLCBuZXdfYmFzZTEpOwor
CWlmICghQVNTRVJUX09LX1BUUihuZXdfc3BsaXQxLCAibmV3X3NwbGl0MSA9IGJ0Zl9fbmV3KCki
KSkKKwkJZ290byBjbGVhbnVwOworCisJQVNTRVJUX0VRKGJ0Zl9fZW5kaWFubmVzcyhuZXdfYmFz
ZTEpLCBpbnZlcnNlX2VuZGlhbm5lc3MsICJuZXdfYmFzZTEgZW5kaWFubmVzcyIpOworCUFTU0VS
VF9FUShidGZfX2VuZGlhbm5lc3MobmV3X3NwbGl0MSksIGludmVyc2VfZW5kaWFubmVzcywgIm5l
d19zcGxpdDEgZW5kaWFubmVzcyIpOworCVZBTElEQVRFX1JBV19CVEYoCisJCW5ld19zcGxpdDEs
CisJCSJbMV0gSU5UICdpbnQnIHNpemU9NCBiaXRzX29mZnNldD0wIG5yX2JpdHM9MzIgZW5jb2Rp
bmc9U0lHTkVEIiwKKwkJIlsyXSBQVFIgJyhhbm9uKScgdHlwZV9pZD0xIik7CitjbGVhbnVwOgor
CWJ0Zl9fZnJlZShuZXdfc3BsaXQxKTsKKwlidGZfX2ZyZWUobmV3X2Jhc2UxKTsKKwlidGZfX2Zy
ZWUobmV3X3NwbGl0KTsKKwlidGZfX2ZyZWUobmV3X2Jhc2UpOworCWJ0Zl9fZnJlZShzcGxpdCk7
CisJYnRmX19mcmVlKGJhc2UpOworfQorCiB2b2lkIHRlc3RfYnRmX2Rpc3RpbGwodm9pZCkKIHsK
IAlpZiAodGVzdF9fc3RhcnRfc3VidGVzdCgiZGlzdGlsbGVkX2Jhc2UiKSkKQEAgLTU0OSw0ICs2
MjAsNiBAQCB2b2lkIHRlc3RfYnRmX2Rpc3RpbGwodm9pZCkKIAkJdGVzdF9kaXN0aWxsZWRfYmFz
ZV9tdWx0aV9lcnIyKCk7CiAJaWYgKHRlc3RfX3N0YXJ0X3N1YnRlc3QoImRpc3RpbGxlZF9iYXNl
X3ZtbGludXgiKSkKIAkJdGVzdF9kaXN0aWxsZWRfYmFzZV92bWxpbnV4KCk7CisJaWYgKHRlc3Rf
X3N0YXJ0X3N1YnRlc3QoImRpc3RpbGxlZF9lbmRpYW5uZXNzIikpCisJCXRlc3RfZGlzdGlsbGVk
X2VuZGlhbm5lc3MoKTsKIH0KLS0gCjIuNDYuMAoK


--=-uZ65FpwVMNACKtDut19W--

