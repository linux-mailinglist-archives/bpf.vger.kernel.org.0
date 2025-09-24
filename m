Return-Path: <bpf+bounces-69628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B68B9C440
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538593A035B
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 21:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0CF296BAB;
	Wed, 24 Sep 2025 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FiQOgnCO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00741290D81
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749082; cv=none; b=m4Zhli0uLSWNYilASDbPKI3mDQU9Rk6TBk9RUJmFkXGIIyQTaXnmf495jCcsItnjczR6X/pveBeLOzmCO0KWEGxBBAgLLQMMVM46bPkpcM4L7lUewLL7ZcfVfQJWBJ4J9/GQJJa0p4cW256HYKmxweD7nUCbcQOm57ZvBwJfwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749082; c=relaxed/simple;
	bh=yYlJMEiOn4ahL9VGQHqHfLn8g81HGorNFwQNV25DIPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNne0CAkbnUGng92ZgGW3hhVFmuxI+ptHdrAzij2vwd1uDwmNOHwI/YhO/2QTVT6W2lGjmQdDsAsqiL4+Qf3TD5ZDqWyhVg8FDFwBi/aW0IWN6PJ6SP2h0vigH9SGBv/nG79QXvOxPFQzazYSapNv38NWcIPeyibokpubwdDToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FiQOgnCO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-330631e534eso331270a91.0
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758749080; x=1759353880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dhLUMSWCJCb7Nc7Lx/+68xlS8KMxySblqVYlmSCjYI=;
        b=FiQOgnCOJibaeCTr921wkYnyw1rd4ab+Kj4p5eWP8pJXsnyR2P5rAUZ3rVKdL+OZsR
         BS1JsnZ50k55mxRbXrojHcJFe0oDbJP8ZDzfwKO5EaNNEmkHpb6JejFvoxrDlZlEkJgA
         9mnprG/0fVZSAYljqsb3lIURw7zgGJ7Q84gLtTD1EQ2i6pHyJyz8ZSPLtydu1N4TWfnr
         Vi9HYUzcWopX16GuyRPTGynyQd2iEFtBHRj+wHmCaYfmfR0GfqAeGRUbAYQC8rRlN5e2
         flpZ5eJzlrtyf/U9342uZqBmtxzAmVjVGzaW+zBFlwzlgtES4a2K8OCgn9sCKfTHLuJO
         I9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749080; x=1759353880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dhLUMSWCJCb7Nc7Lx/+68xlS8KMxySblqVYlmSCjYI=;
        b=by2v98T2AfxY4G9fQQcGwthxo643JxL7CCrBHIWn3RIGW2TH1tOwNrmRJ+AMx7eUbq
         sqnLgV69Hz5lEkBCVbyU9/Oz2r9htC+KMUBgAblP8w/BSECw+BrumghT2IWJgMQ/7bDo
         SoYk9UuSjHlbNG1W9YJPnjafjbEyPT3oXstz2as62fj2Usj7iHryfgCBDEuK9rKn0JHc
         stu5kUuG41ZcW7I8074XtEnTGaSJdUjV0z2ZeS7+Yb0RjDEn8Hrjxu4HqLCSYx9l4GzU
         Gd9M42Zt8Qk7RkiAMW4VQATYLuFURP76/WHPp/UXur1Y0Vm1Mm1ob7koqo/S93q+tL3/
         iuLw==
X-Forwarded-Encrypted: i=1; AJvYcCWuCTE0yZ9vcQAnTo0sR8i39/EE4BSx2r4DD1qZ2aSMLF79HpLIEB3HqPCrwIIOfSJTd8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5L0v9msOcPBLnWw4CfVXam9KJAPsWqnYOcT44qkmmvl9+z9pK
	V12udbIgpzgC2Bu9jVsFGMTuXxZriIul7BIXMQ9FZU6espP6UgvI3Omf8WSQWLliwx9SNpZK9VT
	rVFW3ZAvjRD+R4xNFdk4z6A87KAMC00JQ1mtZAlt0
X-Gm-Gg: ASbGncvONb5WxmoL/uFafgU7cKnecRChixqJIcDSeEOs8p9iwXO8QZMVZeFtRdto2Y3
	jrcibNjstaCo51yTMbMSWY64jKZzbzjoot0qK9BCt3VG/IqrjexR90DEI373AARM9birJuNVSC0
	93jAbatpFs8FwOY/MsPkVrpHbWNirSSj9uqnLEQ4XHe1P2XHufhUF/vZfoUiqIPwHxSMMjJ1UU8
	WIT3+6v+nYy2n9FBg==
X-Google-Smtp-Source: AGHT+IHR9pP1MvU0qJbfCGQoZkW8eEMjmqKvK5A67Eqc2Nnt+qxlyEAnQFYtUTxdfOJEIc9WV2+K5Q4lRtal6pKd1BM=
X-Received: by 2002:a17:90b:5343:b0:32d:17ce:49d5 with SMTP id
 98e67ed59e1d1-3342a2b08bcmr1001670a91.23.1758749080200; Wed, 24 Sep 2025
 14:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e5d594d0aee93da67a22a42d0e2b4e6e463ab894.camel@gmail.com>
In-Reply-To: <e5d594d0aee93da67a22a42d0e2b4e6e463ab894.camel@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 24 Sep 2025 17:24:28 -0400
X-Gm-Features: AS18NWCNQQSQBWtRenUjLlMUKvi01cd9ZXZW5J6vPc0TKqgJOAr2w5N1LESqTqk
Message-ID: <CAHC9VhRu=-J5xdKgYOJ1eqQ6EiMoEJ3M+cjDU8AHrts-=DoTvg@mail.gmail.com>
Subject: Re: [bug report] [regression?] bpf lsm breaks /proc/*/attr/current
 with security= on commandline
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 1:01=E2=80=AFPM Filip Hejsek <filip.hejsek@gmail.co=
m> wrote:
>
> Hello,
>
> TLDR: because of bpf lsm, putting security=3Dselinux on commandline
>       results in /proc/*/attr/current returning errors.
>
> When the legacy security=3D commandline option is used, the specified lsm
> is added to the end of the lsm list. For example, security=3Dapparmor
> results in the following order of security modules:
>
>    capability,landlock,lockdown,yama,bpf,apparmor
>
> In particular, the bpf lsm will be ordered before the chosen major lsm.
>
> This causes reads and writes of /proc/*/attr/current to fail, because
> the bpf hook overrides the apparmor/selinux hook.

What kernel are you using?  Things appear to work correctly on my
kernel that is tracking upstream (Fedora Rawhide + some unrelated
bits):

% uname -a
Linux dev-rawhide-1.lan 6.17.0-0.rc7.250923gd1ab3.57.1.secnext.fc44.x86_64 =
#1 SM
P PREEMPT_DYNAMIC Tue Sep 23 10:07:14 EDT 2025 x86_64 GNU/Linux
% cat /proc/cmdline
BOOT_IMAGE=3D(hd0,gpt4)/boot/vmlinuz-6.17.0-0.rc7.250923gd1ab3.57.1.secnext=
.fc44.x
86_64 root=3DUUID=3D285029fa-4431-45e9-af1b-298ab0caf16a ro console=3DttyS0=
 mitigation
s=3Doff security=3Dselinux
% cat /sys/kernel/security/lsm; echo ""
lockdown,capability,yama,selinux,bpf,landlock,ipe,ima,evm
% id -Z
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
% cat /proc/self/attr/current; echo ""
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023

I even ran it against the LSM initialization rework that has been
proposed, but has not yet been accepted/merged, and that worked the
same as above.

Is this a distro kernel with a lot of "special" patches which aren't
present upstream?

--=20
paul-moore.com

