Return-Path: <bpf+bounces-52846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEDAA49112
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 06:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CA216E6F8
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 05:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C3E1C1F05;
	Fri, 28 Feb 2025 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eivpzvKE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67E156861
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721454; cv=none; b=uwzh785fX5UxvVLcVdsuZQ2GHImUHBVywQeyWQDAG/Go6JoxkMpeXhrMIN2/g/fQKZeULpx/Dwj0nJL7YaZmGOZlgvdC6mPdwVJSMdsyVwhEwIeERh0Tuo0zVbeQhGrS/jzPJL8RIk5XyqI3y638jtQBsAubdeK4e1ZZM/Nitpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721454; c=relaxed/simple;
	bh=rRpxVlwugFLZbO6mF1iWY7x7cCslzYrhj9vEEQIjxx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s71YZy1szWUNUe1LCMlEgmnBTkOwXMeAcPPAuv2OeQsXNMieCX0I4K8t9wjx6P507n2mnSfq0y25RXCAnKSP/HYSICrBd3XZSsdbDDC+gY4X2TAJaSSanyAbiT1ZcIzfY6/0F+Y7oO1VjSy16B2RW7HYzxSr9bYjEbj7dl53wLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eivpzvKE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740721450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OiMplhGrnygs9HIg2mHnNWtqWeq5kklG40WZ9V0FRdQ=;
	b=eivpzvKEsQIrK9lAOYEpme8OWfruD8tRHwLHnylHVXH4el8SshghBT50WuBBkQpLF9J09R
	Q7NAvY1SAcHNMbjlELlV/7jaC0BS9MlV51/GM/IBAmSCegDTV894R5X3op3JphN39vIq/D
	teeQGnhz1OisZPFCUhsg/mfz+F93Gsc=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-jwFKJ6OgO9m1VgEdQW5xiQ-1; Fri, 28 Feb 2025 00:44:08 -0500
X-MC-Unique: jwFKJ6OgO9m1VgEdQW5xiQ-1
X-Mimecast-MFC-AGG-ID: jwFKJ6OgO9m1VgEdQW5xiQ_1740721448
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-51f249a5a4dso626542e0c.0
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 21:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740721448; x=1741326248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiMplhGrnygs9HIg2mHnNWtqWeq5kklG40WZ9V0FRdQ=;
        b=u8wzfXMviocAwSElNw7GSyha5QwDvNjXHnf8nmjnQO4iu5DzyOJSpo6AxDS/CFgqXQ
         ep1eZo9Utirl7edf5abkhVOEZugdimFBvfml8aIlD7lGibBWKrZiHFs6nKJYQgbz99gh
         hVRFMIETznUVW4AVT2OSSYc7O/n9LYtVocRWuLDrQRVoB1TT4iEJ6xhzT/H0zdE5fG4b
         z/qAJzCAyH/QyqJEUh5QfYS1N4iSX4RyuVry8ZU/ef3SACBEmbgNeroZ+wC5sLM8sEXl
         I64rIQtq3KtUxe4v2JAEycUYH1XiXHMiUmuxTD9wtAPHhGNUWoQJ1ccfWZeb875Dpsf8
         XIug==
X-Forwarded-Encrypted: i=1; AJvYcCV3U/ey3Z3w0FkFS7HaVuKcwDEQ4HBVZASMZAfsSQ2+o2Hk7LH3zvdbJZ7qnRIoZnPjTd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3S4LQBJ0X3WRHY7DrCRCRZHrpl0A+fQty1GvlWqDceMUsUYUq
	NivdaWL0bnTwyOLI+La6quZEE2hN8ZV5TAdFMS6NjRrolcP+r7VBw/phx8KSrND2zL7V0GiVgvG
	RDJa+xAoEdjJPeiW+1bRqaovuQYEdIlcCFSjtYvV+lb3YukveXzI3FR5ij8v5tobMb7XWpH63GM
	GqcRh3CWHPfBjKvrbQo12HJV1D
X-Gm-Gg: ASbGncvgLLG21fupUvPAgQUPS8TMYqG5LMfQxzmuQhENfUZrxFLz5b8Duu00M5QcAi6
	bgT0a3fZMupqr9k72XzRlT4A2MIRJmNDyr3ST5K+MvDpZBhK70EY+2A0b1ZYLlkdVCbxW6X3H6Q
	==
X-Received: by 2002:a05:6122:f8f:b0:520:60c2:3fb with SMTP id 71dfb90a1353d-5235a8e57efmr1249821e0c.0.1740721448000;
        Thu, 27 Feb 2025 21:44:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRWW6rCHYFgAWLZ+yOH4s3GqLIHZakIdmjkSiaHkC8nUR9JmkpJKZdqgXMKByl9MuOasbquPfzxDJd0W6GIts=
X-Received: by 2002:a05:6122:f8f:b0:520:60c2:3fb with SMTP id
 71dfb90a1353d-5235a8e57efmr1249811e0c.0.1740721447691; Thu, 27 Feb 2025
 21:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
In-Reply-To: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 28 Feb 2025 13:43:29 +0800
X-Gm-Features: AQ5f1JoObPo6-qhA8092fRMPocEO4grstqiE_F4aj34cMl6VxKYbAYrhG9DOQcg
Message-ID: <CAPpAL=wLk0Z3jfg9eY75c3ZFhH-3w7H--WqFuaGMcCJ+Bm5q+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/6] XDP metadata support for tun driver
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, 
	hawk@kernel.org
Content-Type: multipart/mixed; boundary="0000000000008bb20a062f2d4ba7"

--0000000000008bb20a062f2d4ba7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcus

Since your patches are about the virtual network, I'd like to test it,
but it conflicts (Please review the attachment to review more details)
when I apply it to the master branch.
My test based on this commit:
commit 1e15510b71c99c6e49134d756df91069f7d18141 (origin/master, origin/HEAD=
)
Merge: f09d694cf799 54e1b4becf5e
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Feb 27 09:32:42 2025 -0800

    Merge tag 'net-6.14-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

    Pull networking fixes from Jakub Kicinski:
     "Including fixes from bluetooth.

Thanks
Lei

On Thu, Feb 27, 2025 at 10:28=E2=80=AFPM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> Hi all,
>
> this series contains some improvements for the selftest patches. The othe=
r
> patches remain unchanged. Please check the changelist below.
>
> I have reverted the addition of the NOARP flag from the previous version,
> as it was not effective and the CI was still failing occasionally because
> of the race condition caused by foreign packets interfering with the veth
> tests. This series contains an alternative solution by filtering all but
> the test packets using the attached XDP program.
>
> Successful pipeline:
> https://github.com/kernel-patches/bpf/actions/runs/13552017584
>
> ---
>
> v4:
> - strip unrelated changes from the selftest patches
> - extend commit message for "selftests/bpf: refactor xdp_context_function=
al
>   test and bpf program"
> - the NOARP flag was not effective to prevent other packets from
>   interfering with the tests, add a filter to the XDP program instead
> - run xdp_context_tuntap in a separate namespace to avoid conflicts with
>   other tests
>
> v3: https://lore.kernel.org/bpf/20250224152909.3911544-1-marcus.wichelman=
n@hetzner-cloud.de/
> - change the condition to handle xdp_buffs without metadata support, as
>   suggested by Willem de Bruijn <willemb@google.com>
> - add clarifying comment why that condition is needed
> - set NOARP flag in selftests to ensure that the kernel does not send
>   packets on the test interfaces that may interfere with the tests
>
> v2: https://lore.kernel.org/bpf/20250217172308.3291739-1-marcus.wichelman=
n@hetzner-cloud.de/
> - submit against bpf-next subtree
> - split commits and improved commit messages
> - remove redundant metasize check and add clarifying comment instead
> - use max() instead of ternary operator
> - add selftest for metadata support in the tun driver
>
> v1: https://lore.kernel.org/all/20250130171614.1657224-1-marcus.wichelman=
n@hetzner-cloud.de/
>
> Marcus Wichelmann (6):
>   net: tun: enable XDP metadata support
>   net: tun: enable transfer of XDP metadata to skb
>   selftests/bpf: move open_tuntap to network helpers
>   selftests/bpf: refactor xdp_context_functional test and bpf program
>   selftests/bpf: add test for XDP metadata support in tun driver
>   selftests/bpf: fix file descriptor assertion in open_tuntap helper
>
>  drivers/net/tun.c                             |  28 +++-
>  tools/testing/selftests/bpf/network_helpers.c |  28 ++++
>  tools/testing/selftests/bpf/network_helpers.h |   3 +
>  .../selftests/bpf/prog_tests/lwt_helpers.h    |  29 ----
>  .../bpf/prog_tests/xdp_context_test_run.c     | 138 +++++++++++++++++-
>  .../selftests/bpf/progs/test_xdp_meta.c       |  53 +++++--
>  6 files changed, 223 insertions(+), 56 deletions(-)
>
> --
> 2.43.0
>
>

--0000000000008bb20a062f2d4ba7
Content-Type: application/octet-stream; name=conflict
Content-Disposition: attachment; filename=conflict
Content-Transfer-Encoding: base64
Content-ID: <f_m7ocjiew0>
X-Attachment-Id: f_m7ocjiew0

IyBnaXQgYW0gLS1zaG93LWN1cnJlbnQtcGF0Y2g9ZGlmZgotLS0KIHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9uZXR3b3JrX2hlbHBlcnMuYyB8IDI4ICsrKysrKysrKysrKysrKysrKwogdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL25ldHdvcmtfaGVscGVycy5oIHwgIDMgKysKIC4uLi9z
ZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvbHd0X2hlbHBlcnMuaCAgICB8IDI5IC0tLS0tLS0tLS0t
LS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL25ldHdvcmtfaGVs
cGVycy5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL25ldHdvcmtfaGVscGVycy5jCmlu
ZGV4IDczN2E5NTJkY2Y4MC4uZTFjZmExYjM3NzU0IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYvbmV0d29ya19oZWxwZXJzLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvYnBmL25ldHdvcmtfaGVscGVycy5jCkBAIC01NjUsNiArNTY1LDM0IEBAIHZvaWQgY2xv
c2VfbmV0bnMoc3RydWN0IG5zdG9rZW4gKnRva2VuKQogICAgICAgIGZyZWUodG9rZW4pOwogfQog
CitpbnQgb3Blbl90dW50YXAoY29uc3QgY2hhciAqZGV2X25hbWUsIGJvb2wgbmVlZF9tYWMpCit7
CisgICAgICAgaW50IGVyciA9IDA7CisgICAgICAgc3RydWN0IGlmcmVxIGlmcjsKKyAgICAgICBp
bnQgZmQgPSBvcGVuKCIvZGV2L25ldC90dW4iLCBPX1JEV1IpOworCisgICAgICAgaWYgKCFBU1NF
UlRfR1QoZmQsIDAsICJvcGVuKC9kZXYvbmV0L3R1bikiKSkKKyAgICAgICAgICAgICAgIHJldHVy
biAtMTsKKworICAgICAgIGlmci5pZnJfZmxhZ3MgPSBJRkZfTk9fUEkgfCAobmVlZF9tYWMgPyBJ
RkZfVEFQIDogSUZGX1RVTik7CisgICAgICAgc3RybmNweShpZnIuaWZyX25hbWUsIGRldl9uYW1l
LCBJRk5BTVNJWiAtIDEpOworICAgICAgIGlmci5pZnJfbmFtZVtJRk5BTVNJWiAtIDFdID0gJ1ww
JzsKKworICAgICAgIGVyciA9IGlvY3RsKGZkLCBUVU5TRVRJRkYsICZpZnIpOworICAgICAgIGlm
ICghQVNTRVJUX09LKGVyciwgImlvY3RsKFRVTlNFVElGRikiKSkgeworICAgICAgICAgICAgICAg
Y2xvc2UoZmQpOworICAgICAgICAgICAgICAgcmV0dXJuIC0xOworICAgICAgIH0KKworICAgICAg
IGVyciA9IGZjbnRsKGZkLCBGX1NFVEZMLCBPX05PTkJMT0NLKTsKKyAgICAgICBpZiAoIUFTU0VS
VF9PSyhlcnIsICJmY250bChPX05PTkJMT0NLKSIpKSB7CisgICAgICAgICAgICAgICBjbG9zZShm
ZCk7CisgICAgICAgICAgICAgICByZXR1cm4gLTE7CisgICAgICAgfQorCisgICAgICAgcmV0dXJu
IGZkOworfQorCiBpbnQgZ2V0X3NvY2tldF9sb2NhbF9wb3J0KGludCBzb2NrX2ZkKQogewogICAg
ICAgIHN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlIGFkZHI7CmRpZmYgLS1naXQgYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvbmV0d29ya19oZWxwZXJzLmggYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9icGYvbmV0d29ya19oZWxwZXJzLmgKaW5kZXggOWY2ZTA1ZDg4NmM1Li45OWQxNDE3YzFk
OGIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9uZXR3b3JrX2hlbHBl
cnMuaAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvbmV0d29ya19oZWxwZXJzLmgK
QEAgLTgsNiArOCw3IEBACiB0eXBlZGVmIF9fdTE2IF9fc3VtMTY7CiAjaW5jbHVkZSA8bGludXgv
aWZfZXRoZXIuaD4KICNpbmNsdWRlIDxsaW51eC9pZl9wYWNrZXQuaD4KKyNpbmNsdWRlIDxsaW51
eC9pZl90dW4uaD4KICNpbmNsdWRlIDxsaW51eC9pcC5oPgogI2luY2x1ZGUgPGxpbnV4L2lwdjYu
aD4KICNpbmNsdWRlIDxsaW51eC9ldGh0b29sLmg+CkBAIC05OCw2ICs5OSw4IEBAIGludCBzZW5k
X3JlY3ZfZGF0YShpbnQgbGZkLCBpbnQgZmQsIHVpbnQzMl90IHRvdGFsX2J5dGVzKTsKIGludCBt
YWtlX25ldG5zKGNvbnN0IGNoYXIgKm5hbWUpOwogaW50IHJlbW92ZV9uZXRucyhjb25zdCBjaGFy
ICpuYW1lKTsKIAoraW50IG9wZW5fdHVudGFwKGNvbnN0IGNoYXIgKmRldl9uYW1lLCBib29sIG5l
ZWRfbWFjKTsKKwogLyoqCiAgKiBhcHBlbmRfdGlkKCkgLSBBcHBlbmQgdGhyZWFkIElEIHRvIHRo
ZSBnaXZlbiBzdHJpbmcuCiAgKgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
YnBmL3Byb2dfdGVzdHMvbHd0X2hlbHBlcnMuaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9wcm9nX3Rlc3RzL2x3dF9oZWxwZXJzLmgKaW5kZXggZmIxZWI4YzY3MzYxLi5jY2VjMGZjZGFi
YzEgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2x3
dF9oZWxwZXJzLmgKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMv
bHd0X2hlbHBlcnMuaApAQCAtNSw3ICs1LDYgQEAKIAogI2luY2x1ZGUgPHRpbWUuaD4KICNpbmNs
dWRlIDxuZXQvaWYuaD4KLSNpbmNsdWRlIDxsaW51eC9pZl90dW4uaD4KICNpbmNsdWRlIDxsaW51
eC9pY21wLmg+CiAKICNpbmNsdWRlICJ0ZXN0X3Byb2dzLmgiCkBAIC0zNywzNCArMzYsNiBAQCBz
dGF0aWMgaW5saW5lIGludCBuZXRuc19kZWxldGUodm9pZCkKICAgICAgICByZXR1cm4gc3lzdGVt
KCJpcCBuZXRucyBkZWwgIiBORVROUyAiPi9kZXYvbnVsbCAyPiYxIik7CiB9CiAKLXN0YXRpYyBp
bnQgb3Blbl90dW50YXAoY29uc3QgY2hhciAqZGV2X25hbWUsIGJvb2wgbmVlZF9tYWMpCi17Ci0g
ICAgICAgaW50IGVyciA9IDA7Ci0gICAgICAgc3RydWN0IGlmcmVxIGlmcjsKLSAgICAgICBpbnQg
ZmQgPSBvcGVuKCIvZGV2L25ldC90dW4iLCBPX1JEV1IpOwotCi0gICAgICAgaWYgKCFBU1NFUlRf
R1QoZmQsIDAsICJvcGVuKC9kZXYvbmV0L3R1bikiKSkKLSAgICAgICAgICAgICAgIHJldHVybiAt
MTsKLQotICAgICAgIGlmci5pZnJfZmxhZ3MgPSBJRkZfTk9fUEkgfCAobmVlZF9tYWMgPyBJRkZf
VEFQIDogSUZGX1RVTik7Ci0gICAgICAgc3RybmNweShpZnIuaWZyX25hbWUsIGRldl9uYW1lLCBJ
Rk5BTVNJWiAtIDEpOwotICAgICAgIGlmci5pZnJfbmFtZVtJRk5BTVNJWiAtIDFdID0gJ1wwJzsK
LQotICAgICAgIGVyciA9IGlvY3RsKGZkLCBUVU5TRVRJRkYsICZpZnIpOwotICAgICAgIGlmICgh
QVNTRVJUX09LKGVyciwgImlvY3RsKFRVTlNFVElGRikiKSkgewotICAgICAgICAgICAgICAgY2xv
c2UoZmQpOwotICAgICAgICAgICAgICAgcmV0dXJuIC0xOwotICAgICAgIH0KLQotICAgICAgIGVy
ciA9IGZjbnRsKGZkLCBGX1NFVEZMLCBPX05PTkJMT0NLKTsKLSAgICAgICBpZiAoIUFTU0VSVF9P
SyhlcnIsICJmY250bChPX05PTkJMT0NLKSIpKSB7Ci0gICAgICAgICAgICAgICBjbG9zZShmZCk7
Ci0gICAgICAgICAgICAgICByZXR1cm4gLTE7Ci0gICAgICAgfQotCi0gICAgICAgcmV0dXJuIGZk
OwotfQotCiAjZGVmaW5lIElDTVBfUEFZTE9BRF9TSVpFICAgICAxMDAKIAogLyogTWF0Y2ggYW4g
SUNNUCBwYWNrZXQgd2l0aCBwYXlsb2FkIGxlbiBJQ01QX1BBWUxPQURfU0laRSAqLwotLSAKMi40
My4wCg==
--0000000000008bb20a062f2d4ba7--


