Return-Path: <bpf+bounces-60262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8161AD478B
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 02:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6042E17BBCA
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 00:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D77018E20;
	Wed, 11 Jun 2025 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frYTcKa8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7475695
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749602723; cv=none; b=aZvFDwpwtyQgvKTRum0AGDt+es7zts+fttGmx7oWTU8Ly5l7/hvww6IC9Lr0gBTx1OHAGU+ze04u32eMnjvzgI+RePa56AXt5DR0n3eEl79XS4aXZQf3+POaiV4PdFz6pZtEG9jVxG77znyHBmX3ucDEd5Ykw2uSknUXmegtm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749602723; c=relaxed/simple;
	bh=GL7dXZ6TYN2daR8uY9dujj/NsJJD55NmhRegf2PWVSw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l5/a+gAZS3QMtpnkbNHLqPEoSf2i+pfRfqzYwmpVqKZVyqr/T/GIih5a6tpAlkDhWDREmKdzg3Q4rFNp/cLQw6VRpfYh3atbhA6JZ+YFSsIigkG13vr0LRPB+6cxB3cXyG9cIoFJD5ALUBpJ4ulNdc7awH2OVbcL33QPKb7yt2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frYTcKa8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so4751553b3a.0
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 17:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749602720; x=1750207520; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wisaM9cKhtKwrendSa4f005YgS+BgCeTiLO0WcTFBrY=;
        b=frYTcKa8q9GVWOpot4Uj+pSu5HgK6pFonIjbIvSbmmUsHe0F8iWT/+CR+oa+aaf+5H
         OU6xTpYswZ/5owpgIlDHj59Pd/LVOSxM1NpKtqO0DlauCeM7If7xY/mCtPKJvTMEL3l8
         yTRiNlXY3fh+j/pSR2rF9ZDSSo5a3G9RLfmErKs6BzfWYMlmq5O951Wtx98FuvaRzwcb
         lRiIdF79KdTj5a+F+TgzM4rldHtmsHS90h/emCdFwsGLx3+8SsXLG2pNsKCmEUPWRk/w
         LqafRivd6FOa+pe0TaeESl2HvwH3jXLVc4Cn88/3BFSmZHkYm3LqpWJIu1twjaCzY67T
         vwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749602720; x=1750207520;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wisaM9cKhtKwrendSa4f005YgS+BgCeTiLO0WcTFBrY=;
        b=arPueTqPoGCJ8r2Fhd7o914t/j0yjN30e0YUmIQLfjkON609sccpgiKy3iuYGNTpjc
         JaJ4GTo85ci5YR55EEAKrwCz43inmMgvaorTBFhIRHn417SnwK8dsh3FjXHuOY7RonwY
         iGp65zuyFjlNdJHgVIpdeIZLpykS4ftiyj5mukOPaWMMuCLlEMXiarDkf/i2FzOnls1F
         F3pJ++KuPL4/mPIfr9RVG/a+bDjlCqe6G8p4TXe5F1dKHs5V+w1wRH6trd3BYYtgk/c4
         mY3nos5i6pHfx9LdOwy86BM7jCzAV0ZkvVQwgyPsjeKNWxNHLW8hBgIsxR3gTVO8InuV
         qwaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx57tI7eETmGHwi5D3g2HPaEVFhqD92UihlLD7sFjoTsC9UQknEvFm/BpGkqV14RHv+mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE35fPEkSJNrYHv/ZSW9VplvhN4+a/57ig5I0c0+EBGgkzzFGM
	rn4PkORhyby2IaGnxeM8y74059Qp4Vc4s+EgrADbBntvXGyINu38e/cpYjCOJ67P
X-Gm-Gg: ASbGnct3VliNnbw22iRStjy4Kl3obrZlOhFsW1X2C1JzGJ7+j9lwlWQKLe7EifrhtKC
	S6lBtPAPxx9e3YRcLs/hLZjD77AEjLg+EuSNw0WTD/pGHlBScuQuLNhWL/W3p5PmVVs5G2RAghN
	TmsnQIktjC+k1iQZuLbm3baLN7shziFBu90JUFFcfMxYj4ffuT+mINqVPkXpQWHv+nINZ3Uisa3
	cWBTBPTCztXwyBkH0xWQbdZMFueOXsp2+RINyQusj/LhCB9iEJOIgprktc8HVBF4cW8yLFICazC
	Yhr8/aMQY1sfXxqhUyHDiN5BUW+L1xNDv7OkxPYxDeNt68DZCohpetsiKIFhjz1jb1QD
X-Google-Smtp-Source: AGHT+IH17wNsF+I+Vtfu2F+7vRaIe6glBJ4D2z4YIU8jV8CvyIdVl1OoMbIXCQAXmNpyFYOjE0fDwQ==
X-Received: by 2002:a05:6a21:998e:b0:21f:5409:32f4 with SMTP id adf61e73a8af0-21f865b9433mr2192461637.8.1749602720267;
        Tue, 10 Jun 2025 17:45:20 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:e4f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ef88914sm7448712a12.33.2025.06.10.17.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 17:45:19 -0700 (PDT)
Message-ID: <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: support array presets in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 10 Jun 2025 17:45:17 -0700
In-Reply-To: <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com>
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
	 <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com>
Content-Type: multipart/mixed; boundary="=-xG4L2sl2ldRrvmcrfkMc"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-xG4L2sl2ldRrvmcrfkMc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-06-10 at 20:08 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Implement support for presetting values for array elements in
> veristat.
> For example:
> ```
> sudo ./veristat set_global_vars.bpf.o -G "arr[3] =3D 1"
> ```
> Arrays of structures and structure of arrays work, but each
> individual
> scalar value has to be set separately: `foo[1].bar[2] =3D value`.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

A few nits regarding error reporting:

  ./veristat -q -G ptr_arr[10]=3D0 set_global_vars.bpf.o=20
  Unsupported array element type for variable ptr_arr. Only int, enum, stru=
ct, union are supported
                                                                           =
                      ^^^
											 missing dot

  ./veristat -G arr[[10]]=3D0 set_global_vars.bpf.o=20
  Could not parse 'arr[[10]]'Failed to parse global variable presets: arr[[=
10]]=3D0
  ^^^^^^^^^                ^^^                                             =
     ^^^
  Can't ?		   dot or comma                                 missing dot

  ./veristat -q -G "struct1[0] =3D 0" set_global_vars.bpf.o=20
  Setting value for type Struct is not supported
                                           ^^^^^^^^^
					   report full_name here?

I applied a diff as in the attachment, to see what offsets are being assign=
ed.
Looks like this shows a bug:

  ./veristat  -q -G "struct1[0].filler =3D 42" set_global_vars.bpf.o > /dev=
/null
  setting struct1[0].filler: offset 54, kind int, value 42

Shouldn't offset be 2 in this case?

(maybe print such info in debug (-d) mode?)

Unrelated to this patch, but still a bug:

  # Catches range error:
  ./veristat -q -G "struct1[0].filler2 =3D 100500" set_global_vars.bpf.o=
=20
  Variable unsigned short value 100500 is out of range [0; 65535]
  # Does not range error:
  ./veristat -q -G "struct1[0].filler2 =3D -1" set_global_vars.bpf.o
  ... success ...

[...]

--=-xG4L2sl2ldRrvmcrfkMc
Content-Disposition: attachment; filename="show-offset.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="show-offset.patch"; charset="UTF-8"

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi92ZXJpc3RhdC5jIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3ZlcmlzdGF0LmMKaW5kZXggYmM5ZWJmNWEyOTg1Li43
ZjNlOGJhNzVhY2MgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi92ZXJp
c3RhdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi92ZXJpc3RhdC5jCkBAIC0x
NzI1LDYgKzE3MjUsOCBAQCBzdGF0aWMgaW50IGFkanVzdF92YXJfc2VjaW5mbyhzdHJ1Y3QgYnRm
ICpidGYsIGNvbnN0IHN0cnVjdCBidGZfdHlwZSAqdCwKICAgICAgICByZXR1cm4gMDsKIH0KIAor
Y29uc3QgY2hhciAqYnRmX2tpbmRfc3RyKGNvbnN0IHN0cnVjdCBidGZfdHlwZSAqdCk7CisKIHN0
YXRpYyBpbnQgc2V0X2dsb2JhbF92YXIoc3RydWN0IGJwZl9vYmplY3QgKm9iaiwgc3RydWN0IGJ0
ZiAqYnRmLAogICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBicGZfbWFwICptYXAsIHN0
cnVjdCBidGZfdmFyX3NlY2luZm8gKnNpbmZvLAogICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCB2YXJfcHJlc2V0ICpwcmVzZXQpCkBAIC0xNzYxLDYgKzE3NjMsOSBAQCBzdGF0aWMgaW50
IHNldF9nbG9iYWxfdmFyKHN0cnVjdCBicGZfb2JqZWN0ICpvYmosIHN0cnVjdCBidGYgKmJ0ZiwK
ICAgICAgICAgICAgICAgIH0KICAgICAgICB9CiAKKyAgICAgICBmcHJpbnRmKHN0ZGVyciwgInNl
dHRpbmcgJXM6IG9mZnNldCAlZCwga2luZCAlcywgdmFsdWUgJWxsZFxuIiwKKyAgICAgICAgICAg
ICAgIHByZXNldC0+ZnVsbF9uYW1lLCBzaW5mby0+b2Zmc2V0LCBidGZfa2luZF9zdHIoYmFzZV90
eXBlKSwgdmFsdWUpOworCiAgICAgICAgLyogQ2hlY2sgaWYgdmFsdWUgZml0cyBpbnRvIHRoZSB0
YXJnZXQgdmFyaWFibGUgc2l6ZSAqLwogICAgICAgIGlmICAoc2luZm8tPnNpemUgPCBzaXplb2Yo
dmFsdWUpKSB7CiAgICAgICAgICAgICAgICBib29sIGlzX3NpZ25lZCA9IGlzX3NpZ25lZF90eXBl
KGJhc2VfdHlwZSk7Cg==


--=-xG4L2sl2ldRrvmcrfkMc--

